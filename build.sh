#!/usr/bin/env bash
CDIR=`dirname $(readlink -f $0)`

GPPATH="${CDIR}/_GENERATOR_PRJ"
GPDPATH="${GPPATH}_DIST"
OUT="${CDIR}/_BUNDLE/"
PKGPATH="${GPDPATH}/bundle/programs/web.browser/packages"

rm -rf ${GPPATH} ${GPDPATH} ${OUT}
mkdir -p ${OUT}

./meteor create --bare ${GPPATH}

cd $GPPATH

cat <<EOT > .meteor/packages
meteor
underscore
ddp
mongo
tracker
accounts-base
accounts-password
EOT

../meteor build --debug --directory ${GPDPATH}
# meteor build requires a different import to be successful than the one needed from nativescript to run
sed -i -r "s/Npm\.require\('faye-websocket'\).Client/__meteor_runtime_config__.wsImpl/" ${PKGPATH}/ddp-client.js

cp "${PKGPATH}/underscore.js" ${OUT}
cp "${PKGPATH}/meteor.js" ${OUT}
cp "${PKGPATH}/modules-runtime.js" ${OUT}
cp "${PKGPATH}/modules.js" ${OUT}
cp "${PKGPATH}/base64.js" ${OUT}
cp "${PKGPATH}/ejson.js" ${OUT}
cp "${PKGPATH}/check.js" ${OUT}
cp "${PKGPATH}/promise.js" ${OUT}
cp "${PKGPATH}/ecmascript-runtime.js" ${OUT}
cp "${PKGPATH}/babel-compiler.js" ${OUT}
cp "${PKGPATH}/ecmascript.js" ${OUT}
cp "${PKGPATH}/babel-runtime.js" ${OUT}
cp "${PKGPATH}/random.js" ${OUT}
cp "${PKGPATH}/tracker.js" ${OUT}
cp "${PKGPATH}/retry.js" ${OUT}
cp "${PKGPATH}/id-map.js" ${OUT}
cp "${PKGPATH}/ddp-common.js" ${OUT}
cp "${PKGPATH}/diff-sequence.js" ${OUT}
cp "${PKGPATH}/mongo-id.js" ${OUT}
cp "${PKGPATH}/ddp-client.js" ${OUT}
cp "${PKGPATH}/ddp.js" ${OUT}
cp "${PKGPATH}/ordered-dict.js" ${OUT}
cp "${PKGPATH}/geojson-utils.js" ${OUT}
cp "${PKGPATH}/minimongo.js" ${OUT}
cp "${PKGPATH}/allow-deny.js" ${OUT}
cp "${PKGPATH}/mongo.js" ${OUT}
cp "${PKGPATH}/localstorage.js" ${OUT}
cp "${PKGPATH}/callback-hook.js" ${OUT}
cp "${PKGPATH}/reactive-var.js" ${OUT}
cp "${PKGPATH}/accounts-base.js" ${OUT}
cp "${PKGPATH}/sha.js" ${OUT}
cp "${PKGPATH}/srp.js" ${OUT}
cp "${PKGPATH}/accounts-password.js" ${OUT}
cp "${PKGPATH}/global-imports.js" ${OUT}
cp "${PKGPATH}/service-configuration.js" ${OUT}
