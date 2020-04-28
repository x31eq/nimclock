all: fedate feedate festamp

feedate: feedate.nim
	nim c -d:release feedate.nim

fedate: fedate.nim
	nim c -d:release fedate.nim

festamp: festamp.nim
	nim c -d:release festamp.nim
