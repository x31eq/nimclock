all: fedate feedate festamp feestamp decode

feedate: feedate.nim feetime.nim
	nim c -d:release --opt:size feedate.nim

fedate: fedate.nim feetime.nim
	nim c -d:release --opt:size fedate.nim

festamp: festamp.nim feetime.nim
	nim c -d:release --opt:size festamp.nim

feestamp: feestamp.nim feetime.nim
	nim c -d:release --opt:size feestamp.nim

decode: decode.nim feetime.nim
	nim c -d:release --opt:size decode.nim
