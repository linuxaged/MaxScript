/*
获取 foo object 的纹理并把它保存到 foodif.bmp
rm = renderMap $foo.material.diffuseMap size:[640,480] \
fileName:"foodif.bmp"
save rm
close rm
*/

/*
texturas_perdidas = for t in (getClassInstances BitmapTexture) where not (doesFileExist t.filename) collect t
if queryBox ("Clean " +texturas_perdidas.count as string + " textures missing?" ) beep:false then texturas_perdidas.filename = ""
*/

/**

**/

function getAllTextureFiles inputMaterials =
(
	local allTextureFiles = #();
	for eachMat in inputMaterials do
	(
		format "-- Material: %\n" eachMat.name;
		for i = 1 to (getNumSubTexmaps eachMat) do
		(
			try 
			( 
				if (getNumSubTexmaps (getSubTexmap eachMat i)) != 0 
				then
			  	(
			  		join allTextureFiles (getAllTextureFiles #((getSubTexmap eachMat i)));
			  	)
			) catch ();
			
			if (isProperty (getSubTexmap eachMat i) #filename) then
			(
				append allTextureFiles (getSubTexmap eachMat i);
				format "---- TextureFile: \"%\"\n" (getSubTexmap eachMat i).filename;
			);
		);
	);
	return allTextureFiles;
);

allTextureFiles = (getAllTextureFiles sceneMaterials);

/*
maps = getClassInstances bitmaptexture 
for m in maps do
(
	if not doesFileExist m.filename then
	(
		m.filename= ... --replace filename here
	)
)
*/
