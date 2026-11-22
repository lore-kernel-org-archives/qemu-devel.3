Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19995606A33C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wCn/hNAl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVAl8-0001n0-Ek; Sun, 22 Nov 2026 11:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl3-0001mI-EL
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:41 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl1-0001Vf-6g
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:40 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c4cac7a7d3cso353113066b.3
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 08:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795366178; x=1795970978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ILpF0sTy0cu/V1CAQBURyqxfUnvV1l87JurI6ftYrGo=;
 b=wCn/hNAlkIEsXa6rcKhwIMtwmYb5C9+BmbCYuLc7do4EfmzKactEOACLsnFwS00hSj
 T2AZkxjybeenRUrqUEr8OXZl9B+zwiE/2ic+YUJVXJDHE8sTpxlh1yAHw2zfwkOOU1cn
 0OLE3EI9VWF96cGbW3/ML2+vaeS4pSSLLG5MYyWOIRUEp0SKTxIQJLEaX1mmY4c7qa/Z
 2P7cNM85h4mequXzluXuQC8wcs+RSbfdD4NfAFlGwY785YV/3SKP16H9FHNh+qaVzRDH
 0BPKHXxWxqL2E+N0oZ7udHPcQTS84twnhH3VppK2ysBg9hG01ux9ItYk0J7iDl8l3PZO
 h3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795366178; x=1795970978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ILpF0sTy0cu/V1CAQBURyqxfUnvV1l87JurI6ftYrGo=;
 b=tBxdv6oLbSCysAHIyQzYpnbMXg4Y3P+f1jmFBXcQ1Y/UWvPaFgDCQwjmjOc2SIGT8o
 bD6bDeAYnkyj2louw2FIbqD2NVMBfFFngocDiljn56M5I1DacUr8o+yZxoo9DC0G4UBj
 kHzy9GpaCRMEtbL1ZFjBLakOxmrwFFxyLhpAaj8+FqamJIPP7RgkGoK3TZ6oILCXwjhH
 TjIyxAga6Jsat8w1UMeXN8WV+RXdt8mnYWTeIMRtcIxZ/jrTvkcXVzZtc+OeZYbyIFTv
 YfipWeisYbziQoxze7Pkr4DFB8RS7S02rPSue03nTvnzsr4Eetz6JuPdcMUchFCLRdij
 YFEw==
X-Gm-Message-State: APuU4Z/mQrZ88MtXiF9ZlGt5EnHNdEcjlptYhPuqzYNK3f/GZuTH2WE6
 1rM6s+SJaS+31nPL8Jh0wXDqcplM5j7sOp/Hq1R9AJQgTUbCvmpjtmLshcoNjiyuv64=
X-Gm-Gg: AZFdTZeg0rtiWdVgyvjRpFxjrRiucx/ZfPosOUvLddn1lehNqvbGUGbxhalSvRfmZO8
 V1cnfyCQ4RtEJxHQhMD7ltYSBjLGYokLwrrm3Wp6GdY63aPwl20SRulIQzqGxK8tfUEqviMEI+b
 teDZ+aGhYIoeYqAPK5JA4zpPU5qb5dbJ8AO9ncGO9JWva+OQdwptxtn08Wx0pnIT+EN0L6oepuF
 l3oo0d+dmSl1u/nHB4/HErIvKw2SPvpf1//U73HTAXNOMjT2fq8ukiSCalHMF8xP/ZHCPpjgALS
 U3HccIecfEYTMgrE1c4FofZtkaSd5WqxzHtPbGpAom8//WEW+xLLAT+kbue8bZjo0HTA1cNkmJv
 KiroVqnLNmO3O69wbdblWEIt7/jr+dgNrNHv0OzIyjtiYBTYW3c+54+BkegIVPTHuNyqyj4YbBa
 HmMrTaPAqQrQmDsHC+TSBIEXbgZP1K/X5lUfBw15I6N4EfUyg7AuvxhX1E/GJ3v2oWhaJYOJRZF
 JpojbB7eDcmCMqxYQ+fejPGCqFc/8Jb14shxsjZADg6NHRmUWcFKf+Wj8gR/j36ysAx5Fg3tJ9g
 BN1tJi3ZZY0h8QB+4wnvZwOt6XJcWfjd9FYFhfajocGp+VyNwjdxVCqLbzNEfr4Qg6x5sezD/gV
 sVwT4BiXd7GHI4gt2xvmH8QjQpm8CtIvRhvofLPU=
X-Received: by 2002:a17:906:3e1a:b0:c41:285a:46a9 with SMTP id
 a640c23a62f3a-c513ac9c0cemr594172566b.46.1795366177360; 
 Sun, 22 Nov 2026 08:49:37 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc2455sm325303166b.57.2026.11.22.08.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:49:37 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 01/10] iotests: use gsed instead of sed
Date: Sun, 22 Nov 2026 17:48:56 +0100
Message-ID: <20261122164905.59680-2-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122164905.59680-1-bogorodskiy@gmail.com>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some iotests fail on FreeBSD because the tests call sed
directly, and BSD sed is not always compatible with GNU sed.
As common.rc already provides the gsed() wrapper, use it
instead.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qemu-iotests/115           |  2 +-
 tests/qemu-iotests/common.filter | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 5c8a12f85a..e3ff91de7a 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -78,7 +78,7 @@ _make_test_img -o "refcount_bits=64,cluster_size=512,preallocation=metadata" 256
 # qemu-img check for that purpose, too.
 
 $QEMU_IMG check "$TEST_IMG" | \
-    sed -e 's/^.* = \([0-9]\+\.[0-9]\+% allocated\).*\(clusters\)$/\1 \2/' \
+    gsed -e 's/^.* = \([0-9]\+\.[0-9]\+% allocated\).*\(clusters\)$/\1 \2/' \
         -e '/^Image end offset/d'
 
 # (Note that we cannot use _check_test_img because that function filters out the
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index ce4213cb97..ed31249515 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -21,18 +21,18 @@
 
 _filter_date()
 {
-    sed -Ee 's/[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/yyyy-mm-dd hh:mm:ss/'
+    gsed -Ee 's/[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/yyyy-mm-dd hh:mm:ss/'
 }
 
 _filter_vmstate_size()
 {
-    sed -E -e 's/[0-9. ]{5} [KMGT]iB/     SIZE/' \
+    gsed -E -e 's/[0-9. ]{5} [KMGT]iB/     SIZE/' \
            -e 's/[0-9. ]{5} B/   SIZE/'
 }
 
 _filter_generated_node_ids()
 {
-    sed -Ee 's/\#block[0-9]{3,}/NODE_NAME/'
+    gsed -Ee 's/\#block[0-9]{3,}/NODE_NAME/'
 }
 
 _filter_qom_path()
@@ -43,7 +43,7 @@ _filter_qom_path()
 # replace occurrences of the actual TEST_DIR value with TEST_DIR
 _filter_testdir()
 {
-    sed -e "s#$TEST_DIR/#TEST_DIR/#g" \
+    gsed -e "s#$TEST_DIR/#TEST_DIR/#g" \
         -e "s#$SOCK_DIR/#SOCK_DIR/#g" \
         -e "s#SOCK_DIR/fuse-#TEST_DIR/#g"
 }
@@ -51,7 +51,7 @@ _filter_testdir()
 # replace occurrences of the actual IMGFMT value with IMGFMT
 _filter_imgfmt()
 {
-    sed -e "s#$IMGFMT#IMGFMT#g"
+    gsed -e "s#$IMGFMT#IMGFMT#g"
 }
 
 # Replace error message when the format is not supported and delete
@@ -89,7 +89,7 @@ _filter_qemu()
 # replace occurrences of QEMU_IMG_PROG with "qemu-img"
 _filter_qemu_img()
 {
-    sed -e "s#$QEMU_IMG_PROG#qemu-img#g"
+    gsed -e "s#$QEMU_IMG_PROG#qemu-img#g"
 }
 
 # replace problematic QMP output like timestamps
@@ -130,7 +130,7 @@ _filter_actual_image_size()
 # Filename filters for qemu-img create
 _filter_img_create_filenames()
 {
-    sed \
+    gsed \
         -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
@@ -178,7 +178,7 @@ _do_filter_img_create()
         | grep -a -e '^fmt' -e '^size' -e '^backing' -e '^preallocation' \
                   -e '^encryption' "${grep_data_file[@]}" \
         | _filter_img_create_filenames \
-        | sed \
+        | gsed \
             -e 's/^\(fmt\)/0-\1/' \
             -e 's/^\(size\)/1-\1/' \
             -e 's/^\(backing\)/2-\1/' \
@@ -186,9 +186,9 @@ _do_filter_img_create()
             -e 's/^\(encryption\)/4-\1/' \
             -e 's/^\(preallocation\)/8-\1/' \
         | LC_ALL=C sort \
-        | sed -e 's/^[0-9]-//' \
+        | gsed -e 's/^[0-9]-//' \
         | tr '\n\0' ' \n' \
-        | sed -e 's/^ *$//' -e 's/ *$//'
+        | gsed -e 's/^ *$//' -e 's/ *$//'
     )
 
     if [ -n "$options" ]; then
@@ -296,7 +296,7 @@ _filter_qemu_img_map()
         data_file_filter=(-e "s#$data_file_pattern#\\1#")
     fi
 
-    sed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
+    gsed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
         -e 's/"offset": [0-9]\+/"offset": OFFSET/g' \
         -e 's/Mapped to *//' \
         "${data_file_filter[@]}" \
@@ -310,7 +310,7 @@ _filter_nbd()
     # receive callbacks sometimes, making them unreliable.
     #
     # Filter out the TCP port number since this changes between runs.
-    sed -e '/nbd\/.*\.c:/d' \
+    gsed -e '/nbd\/.*\.c:/d' \
         -e 's#127\.0\.0\.1:[0-9]*#127.0.0.1:PORT#g' \
         -e 's#localhost:[0-9]*#localhost:PORT#g' \
         -e 's#host=127\.0\.0\.1,port=[0-9]*#host=127.0.0.1,port=PORT#g' \
@@ -356,7 +356,7 @@ sys.stdout.write(result)'
 
 _filter_authz_check_tls()
 {
-    sed -e 's/TLS x509 authz check for .* is denied/TLS x509 authz check for DISTINGUISHED-NAME is denied/'
+    gsed -e 's/TLS x509 authz check for .* is denied/TLS x509 authz check for DISTINGUISHED-NAME is denied/'
 }
 
 _filter_qcow2_compression_type_bit()
-- 
2.56.0


