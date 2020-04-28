all: fedate feedate

feedate: feedate.nim
	nim c -d:release feedate.nim

fedate: fedate.nim
	nim c -d:release fedate.nim
