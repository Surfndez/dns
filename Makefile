preview: preview_bytemark preview_cloudflare

preview_bytemark: data/openstreetmap.org data/openstreetmap.com data/openstreetmap.net \
		  data/openstreetmap.ca data/openstreetmap.eu data/openstreetmap.pro \
		  data/openstreetmaps.org data/osm.org data/openmaps.org \
		  data/openstreetmap.io data/osm.io \
		  data/openworldmap.org data/freeosm.org data/open-maps.org data/open-maps.com data/osmbugs.org \
		  data/openstreetmap.uk data/openstreetmap.org.uk data/openstreetmap.co.uk \
		  data/openstreetmap.org.za data/osm.org.za \
		  data/osmfoundation.org \
		  data/stateofthemap.org data/stateofthemap.com data/sotm.org \
		  data/stateofthemap.eu \
		  data/opengeodata.org \
		  data/switch2osm.org data/switch2osm.com \
		  data/tile.openstreetmap.org \
		  data/tile.openstreetmap.org \
		  data/render.openstreetmap.org

preview_cloudflare: include/sshfp.js include/tile.js include/render.js
	dnscontrol preview

update: update_bytemark update_cloudflare update_geodns

update_bytemark: preview_bytemark
	bin/update

update_cloudflare: include/sshfp.js include/tile.js include/render.js
	dnscontrol push --providers cloudflare

update_geodns: gdns/tile.map gdns/tile.resource gdns/tile.weighted
	parallel --will-cite rsync --quiet --recursive --checksum gdns/ {}::geodns ::: ${GEODNS_SERVERS}

clean:
	rm -f data/* json/* origins/* gdns/*

lib/countries.xml:
	curl -s -o $@ http://api.geonames.org/countryInfo?username=demo

data/openstreetmap.org: src/openstreetmap
data/openstreetmap.com: src/openstreetmap
data/openstreetmap.net: src/openstreetmap
data/openstreetmap.ca: src/openstreetmap
data/openstreetmap.eu: src/openstreetmap
data/openstreetmap.pro: src/openstreetmap
data/openstreetmaps.org: src/openstreetmap
data/osm.org: src/openstreetmap
data/openmaps.org: src/openstreetmap
data/openstreetmap.io: src/openstreetmap
data/osm.io: src/openstreetmap
data/openworldmap.org: src/openstreetmap
data/freeosm.org: src/openstreetmap
data/open-maps.org: src/openstreetmap
data/open-maps.com: src/openstreetmap
data/osmbugs.org: src/openstreetmap
data/openstreetmap.uk: src/openstreetmap-uk
data/openstreetmap.org.uk: src/openstreetmap-uk
data/openstreetmap.co.uk: src/openstreetmap-uk
data/openstreetmap.org.za: src/openstreetmap-za
data/osm.org.za: src/openstreetmap-za
data/osmfoundation.org: src/osmfoundation
data/stateofthemap.org: src/stateofthemap
data/stateofthemap.com: src/stateofthemap
data/sotm.org: src/stateofthemap
data/opengeodata.org: src/opengeodata
data/switch2osm.org: src/switch2osm
data/switch2osm.com: src/switch2osm
data/stateofthemap.eu: src/stateofthemap-eu

include/sshfp.js: $(wildcard /etc/ssh/ssh_known_hosts)
	bin/mksshfp

origins/tile.openstreetmap.yml: bin/mkcountries lib/countries.xml bandwidth/tile.openstreetmap.yml
	bin/mkcountries bandwidth/tile.openstreetmap.yml origins/tile.openstreetmap.yml

data/tile.openstreetmap.org include/tilse.js json/tile.openstreetmap.org.json origins/render.openstreetmap.yml gdns/tile.map gdns/tile.resource gdns/tile.weighted: bin/mkgeo origins/tile.openstreetmap.yml src/tile.openstreetmap
	bin/mkgeo origins/tile.openstreetmap.yml src/tile.openstreetmap tile.openstreetmap.org tile origins/render.openstreetmap.yml tile

data/render.openstreetmap.org include/render.js json/render.openstreetmap.org.json: bin/mkgeo origins/render.openstreetmap.yml src/render.openstreetmap
	bin/mkgeo origins/render.openstreetmap.yml src/render.openstreetmap render.openstreetmap.org render origins/total.openstreetmap.yml

data/%:
	sed -r -e 's/$(notdir $<)(:|$$)/$(notdir $@)\1/g' < $< > $@
