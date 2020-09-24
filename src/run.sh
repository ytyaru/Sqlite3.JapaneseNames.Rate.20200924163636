#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# SQLite3でランダムに日本人名をフルネームで取得する（男女比1:1）
# CreatedAt: 2020-09-24
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	DB_PATH='Names.db'
	NUM_DEFAULT=40
	NUM=${1:-$NUM_DEFAULT}
	IsInt() { test 0 -eq $1 > /dev/null 2>&1 || expr $1 + 0 > /dev/null 2>&1; }
	IsInt "$NUM" || NUM=$NUM_DEFAULT
	[ $NUM -lt 1 ] && NUM=$NUM_DEFAULT
	RandomLastNames() { echo 'select Id from LastNames order by random() limit '"$1"; }
	RandomFirstNames() {
		case "$1" in
			'm'|'f'|'c'|'mc'|'fc'|'cm'|'mc') WHERE=' where sex="'"$1"'" ';;
			'M') WHERE=' where sex in ("m","mc","cm","c") ';;
			'F') WHERE=' where sex in ("f","fc","cf","c") ';;
			'C') WHERE=' where sex in ("c","mc","cm","fc","cf") ';;
			*) WHERE=' ';;
		esac
		echo 'select Id from FirstNames'"$WHERE"'order by random() limit '"$2"
	}
	RowNumLastNames() { echo 'select ROW_NUMBER() over (order by random(), Id) as R,Yomi,Kaki from LastNames where Id in ('"$(RandomLastNames "$@")"')'; }
	RowNumFirstNames() { echo 'select ROW_NUMBER() over (order by random(), Id) as R,Yomi,Kaki,Sex from FirstNames where Id in ('"$(RandomFirstNames "$@")"')'; }
	RandomSex() {
		case "$1" in
			'm'|'mc'|'cm'|'M') echo 'm'; return;;
			'f'|'fc'|'cf'|'F') echo 'f'; return;;
			'c'|'C'|*) [ 0 -eq $(($RANDOM % 2)) ] && echo 'm' || echo 'f'; return;;
		esac
	}
	JoinNames() { echo 'select L.Yomi,F.Yomi,L.Kaki,F.Kaki,"'"$(RandomSex "$1")"'" from ('"$(RowNumLastNames "$2")"') as L inner join ('"$(RowNumFirstNames "$@")"') as F on L.R=F.R order by L.Yomi,F.Yomi;'; }
	Execute() { sqlite3 -batch -interactive "$DB_PATH" '.mode tabs' "$@"; }
	NUM_M=$((NUM / 2))
	NUM_F=$((NUM / 2))
	[ 1 -eq $((NUM % 2)) ] && { [ 0 -eq $((RANDOM % 2)) ] && NUM_M=$((NUM_M + 1)) || NUM_F=$((NUM_F + 1)); }
	RESULT="$(Execute "$(JoinNames 'm' $NUM_M)" "$(JoinNames 'f' $NUM_F)")"
	paste <(eval echo {1..$(echo -e "$RESULT" | wc -l)} | tr ' ' '\n') <(echo -e "$RESULT" | sort)
}
Run "$@"
