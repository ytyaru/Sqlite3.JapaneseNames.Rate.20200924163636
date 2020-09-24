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
	NUM_DEFAULT=5
	NUM=${1:-$NUM_DEFAULT}
	IsInt() { test 0 -eq $1 > /dev/null 2>&1 || expr $1 + 0 > /dev/null 2>&1; }
	IsInt "$NUM" || NUM=$NUM_DEFAULT
	[ $NUM -lt 1 ] && NUM=$NUM_DEFAULT
#	RandomLastNames() { echo 'select Id from LastNames order by random() limit @NUM / 2'; }
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
#		echo 'select Id from FirstNames'"$WHERE"'order by random() limit @NUM / 2'
	}
	RowNumLastNames() { echo 'select ROW_NUMBER() over (order by random(), Id) as R,Yomi,Kaki from LastNames where Id in ('"$(RandomLastNames "$@")"')'; }
	RowNumFirstNames() { echo 'select ROW_NUMBER() over (order by random(), Id) as R,Yomi,Kaki,Sex from FirstNames where Id in ('"$(RandomFirstNames "$@")"')'; }
	JoinNames() { echo 'select L.Yomi,F.Yomi,L.Kaki,F.Kaki,"'"$1"'" from ('"$(RowNumLastNames "$2")"') as L inner join ('"$(RowNumFirstNames "$@")"') as F on L.R=F.R order by L.Yomi,F.Yomi;'; }
#	Execute() { sqlite3 -batch -interactive "$DB_PATH" '.trace stdout' '.mode tabs' "$@"; }
	Execute() { sqlite3 -batch -interactive "$DB_PATH" '.mode tabs' "$@"; }
#	JoinName 'm' '@NUM / 2'
#	JoinName 'f' '@NUM / 2'
#	JoinName 'c' '1'

	[ 0 -eq $((NUM % 2)) ] && {
#		Execute <(JoinNames 'm' $((NUM / 2))) <(JoinNames 'f' $((NUM / 2)))
		Execute "$(JoinNames 'm' $((NUM / 2)))" "$(JoinNames 'f' $((NUM / 2)))"
	} || {
#		Execute <(JoinNames 'm' $((NUM / 2))) <(JoinNames 'f' $((NUM / 2))) <(JoinNames '*' 1)
		Execute "$(JoinNames 'm' $((NUM / 2)))" "$(JoinNames 'f' $((NUM / 2)))" "$(JoinNames '*' 1)"
	}
	
#	JoinName 'm' $((NUM / 2))
#	JoinName 'f' $((NUM / 2))
#	[ 1 -eq $((NUM % 2)) ] && JoinName '*' 1
#	sqlite3 -batch -interactive "$DB_PATH" '.mode tabs' \
#		'.parameter init' \
#		'.parameter set @NUM '"$NUM" \
#		"$SQL"
}
Run "$@"
