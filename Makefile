all: fedate feedate festamp feestamp

feedate: feedate.nim
	nim c -d:release feedate.nim

fedate: fedate.nim
	nim c -d:release fedate.nim

festamp: festamp.nim
	nim c -d:release festamp.nim

feestamp: feestamp.nim
	nim c -d:release feestamp.nim
