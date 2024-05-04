Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF2AC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 08:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3B0s-00088k-S7; Sat, 04 May 2024 04:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B0r-00088A-Tx; Sat, 04 May 2024 04:44:57 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1s3B0p-0001XZ-KL; Sat, 04 May 2024 04:44:57 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-23eb1851c34so56378fac.0; 
 Sat, 04 May 2024 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714812294; x=1715417094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gTE/AfpQPUSDgNS6a4+2A3kt7wg96uujAYNI02kwlk=;
 b=TAY09B5M3rjMdLSEVmlxRKQs03z7vEcOTSApSqJv/GY5+5Prp+qbbx8sJJgA4iU3n1
 R6aEzaZddM/4munF6zmf2zzvY+1udAjrkiWclAIx+BnidWZn8dua+WMs2t0NZ9jvHayz
 hjP8CfILo1r1eSfS8NjNVbYnq3RJ5OjF20XTI1YCmGic0A2LNvl0MaNvWWjEsmlHb5Gu
 7SL9iUY7LcIfsp3TtLNDxR5BH3fUjHbxnpgTB1t6bxnk2K2MNGDf7txdCOLaVFoKgZop
 tRFIwn7GKman9FmDKczbPbpsAvmp6WdEuGHod26QDSk3LhyS6c0Nio7yozCEO7vlLtcn
 Ju1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714812294; x=1715417094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9gTE/AfpQPUSDgNS6a4+2A3kt7wg96uujAYNI02kwlk=;
 b=tWrrGEO71BRWshcu707eKi1XiywpwCed21f8iWkPWCOu6MB/Ah5JNI5IHKZUjB1tMJ
 NfEQkaixOWa+ZND+b+xh2fUQvnH3IpQvZmLut5z50DnsRxdiQSBdAPVUgyU6/37TQoEk
 b2O+6JmTN3JD3BYAasmi0CKQ520XjtnNbJayzUn1VoCIxZbkllDwTsVLPYkbiWBhjx86
 2Stq6KQ2ufapk7sfJvziFicMEp9fBro/+N96zSKjdcyW913FVtLi8Q1uKtNn4I0vEBFk
 qowlvVssPtAFW9HtD+XBXuArXCnQlDHuTsoFHS0Wm4oGKi+d7u0mS04qumyvY/iXl2Hr
 0lYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpBJF/BjHnfrz1cmFVnkd9Z1aegqgK6yX3Z29v+62dd8MrKDR3DBU+wYbdgKN+l4JiFwzQbucWbVgN2E2P8ev0ugAKb5A=
X-Gm-Message-State: AOJu0Yz2IQ20k4FKb8QHFtkk5mG0mR7gUSxvTGoxdeD6DZdk7MAi0dcQ
 FekmDrH0VJlSqvWqWz7VkvyKp0g2cHZz5os7lwdPmMPIEKGgf50v4WOjI9sp
X-Google-Smtp-Source: AGHT+IGnNRNYvM+8UNLkK0FjYRjOuGJUt1cOE5VT6xVg74RQuhBKTk0KoAUrYzFQ7q9i+AVio40mkg==
X-Received: by 2002:a05:6870:e414:b0:23e:5175:8de2 with SMTP id
 n20-20020a056870e41400b0023e51758de2mr5238476oag.44.1714812293584; 
 Sat, 04 May 2024 01:44:53 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 ei32-20020a056a0080e000b006f44e64dfe3sm2310393pfb.177.2024.05.04.01.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 01:44:53 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v2 5/5] iotests: Filter out `vvfat` fmt from failing tests
Date: Sat,  4 May 2024 16:44:23 +0800
Message-ID: <aa5d9b408bfd47ae7a073331514a890ec7f0e8f0.1714811679.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714811679.git.amjadsharafi10@gmail.com>
References: <cover.1714811679.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

`vvfat` is a special format and not all tests (even generic) can run without crashing.
So, added `unsupported_fmt: vvfat` to all failling tests.

Also added `vvfat` format into `meson.build`, vvfaat tests can be run on the `block-thorough` suite.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
---
 .gitlab-ci.d/buildtest.yml                         | 1 +
 tests/qemu-iotests/001                             | 1 +
 tests/qemu-iotests/002                             | 1 +
 tests/qemu-iotests/003                             | 1 +
 tests/qemu-iotests/005                             | 1 +
 tests/qemu-iotests/008                             | 1 +
 tests/qemu-iotests/009                             | 1 +
 tests/qemu-iotests/010                             | 1 +
 tests/qemu-iotests/011                             | 1 +
 tests/qemu-iotests/012                             | 1 +
 tests/qemu-iotests/021                             | 1 +
 tests/qemu-iotests/032                             | 1 +
 tests/qemu-iotests/033                             | 1 +
 tests/qemu-iotests/052                             | 1 +
 tests/qemu-iotests/094                             | 1 +
 tests/qemu-iotests/120                             | 2 +-
 tests/qemu-iotests/140                             | 1 +
 tests/qemu-iotests/145                             | 1 +
 tests/qemu-iotests/157                             | 1 +
 tests/qemu-iotests/159                             | 2 +-
 tests/qemu-iotests/170                             | 2 +-
 tests/qemu-iotests/192                             | 1 +
 tests/qemu-iotests/197                             | 2 +-
 tests/qemu-iotests/208                             | 2 +-
 tests/qemu-iotests/215                             | 2 +-
 tests/qemu-iotests/236                             | 2 +-
 tests/qemu-iotests/251                             | 1 +
 tests/qemu-iotests/307                             | 2 +-
 tests/qemu-iotests/308                             | 2 +-
 tests/qemu-iotests/meson.build                     | 3 ++-
 tests/qemu-iotests/tests/export-incoming-iothread  | 2 +-
 tests/qemu-iotests/tests/fuse-allow-other          | 1 +
 tests/qemu-iotests/tests/mirror-ready-cancel-error | 2 +-
 tests/qemu-iotests/tests/regression-vhdx-log       | 1 +
 34 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index cfdff175c3..a46c179a6b 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -347,6 +347,7 @@ build-tcg-disabled:
             124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
             208 209 216 218 227 234 246 247 248 250 254 255 257 258
             260 261 262 263 264 270 272 273 277 279 image-fleecing
+    - ./check -vvfat vvfat
 
 build-user:
   extends: .native_build_job_template
diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index 6f980fd34d..cf905b5d00 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 
 
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index 5ce1647531..1e557fad8c 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 _unsupported_imgopts "subformat=streamOptimized"
 
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index 03f902a83c..6e74f1faeb 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 _unsupported_imgopts "subformat=streamOptimized"
 
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index ba377543b0..28ae66bfcd 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 _supported_os Linux
 _unsupported_imgopts "subformat=twoGbMaxExtentFlat" \
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index fa4990b513..80850ecf12 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 
 
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index efa852bad3..408617b0bc 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 _unsupported_imgopts "subformat=streamOptimized"
 
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 4ae9027b47..c9f6279255 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 _unsupported_imgopts "subformat=streamOptimized"
 
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index 5c99ac987f..92039fa949 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 _unsupported_imgopts "subformat=streamOptimized"
 
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 3a24d2ca8d..5b0f1338e6 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto file
 
 # Remove once all tests are fixed to use TEST_IMG_FILE
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index 0fc89df2fe..475f9b2116 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 
 
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index ebbe7cb0ba..b58141f132 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # This works for any image format (though unlikely to segfault for raw)
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 _unsupported_imgopts "subformat=streamOptimized"
 
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 4bc7a071bd..6410c8717e 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 _unsupported_imgopts "subformat=streamOptimized"
 
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 2f23ac9b65..5b3545c8b9 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto file
 
 # Don't do O_DIRECT on tmpfs
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 4766e9a458..d8da955c1b 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto nbd
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
 
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index ac7bd8c4e3..d8e5f4241a 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file fuse
-_unsupported_fmt luks
+_unsupported_fmt luks vvfat
 _require_drivers raw
 
 _make_test_img 64M
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index d923b777e2..42a96d9097 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -45,6 +45,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto file fuse
 _supported_os Linux
 
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index a2ce92516d..ff9c6ff54f 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 
 _make_test_img 1M
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index aa2ebbfb4b..419d3b8b7a 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto file
 
 _require_devices virtio-blk
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 4eb476d3a8..70a1079ae5 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
-_unsupported_fmt luks
+_unsupported_fmt luks vvfat
 
 TEST_SIZES="5 512 1024 1999 1K 64K 1M"
 
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index 41387e4d66..f08fb0e8bd 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
-_unsupported_fmt luks
+_unsupported_fmt luks vvfat
 
 echo
 echo "== Creating image =="
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index e66e1a4f06..ca72b0b7c8 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto file
 
 if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 69849c800e..76b30672d9 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -53,7 +53,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto generic
 # LUKS support may be possible, but it complicates things.
-_unsupported_fmt luks
+_unsupported_fmt luks vvfat
 _unsupported_imgopts "subformat=streamOptimized"
 
 echo
diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 6117f165fa..f08c83c0c1 100755
--- a/tests/qemu-iotests/208
+++ b/tests/qemu-iotests/208
@@ -23,7 +23,7 @@
 
 import iotests
 
-iotests.script_initialize(supported_fmts=['generic'])
+iotests.script_initialize(supported_fmts=['generic'], unsupported_fmts=['vvfat'])
 
 with iotests.FilePath('disk.img') as disk_img_path, \
      iotests.FilePath('disk-snapshot.img') as disk_snapshot_img_path, \
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index 6babbcdc1f..3bd03c741e 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -50,7 +50,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto generic
 # LUKS support may be possible, but it complicates things.
-_unsupported_fmt luks
+_unsupported_fmt luks vvfat
 _unsupported_imgopts "subformat=streamOptimized"
 
 echo
diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
index 20419bbb9e..4bcca355ab 100755
--- a/tests/qemu-iotests/236
+++ b/tests/qemu-iotests/236
@@ -23,7 +23,7 @@
 import iotests
 from iotests import log
 
-iotests.script_initialize(supported_fmts=['generic'])
+iotests.script_initialize(supported_fmts=['generic'], unsupported_fmts=['vvfat'])
 size = 64 * 1024 * 1024
 granularity = 64 * 1024
 
diff --git a/tests/qemu-iotests/251 b/tests/qemu-iotests/251
index 794cad58b2..ac83f69d9a 100755
--- a/tests/qemu-iotests/251
+++ b/tests/qemu-iotests/251
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto file
 _supported_os Linux
 _unsupported_imgopts "subformat=streamOptimized"
diff --git a/tests/qemu-iotests/307 b/tests/qemu-iotests/307
index b429b5aa50..548d2f040d 100755
--- a/tests/qemu-iotests/307
+++ b/tests/qemu-iotests/307
@@ -27,7 +27,7 @@ import os
 # luks which requires special command lines)
 iotests.script_initialize(
     supported_fmts=['generic'],
-    unsupported_fmts=['luks', 'vpc'],
+    unsupported_fmts=['luks', 'vpc', 'vvfat'],
     supported_platforms=['linux'],
 )
 
diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index ea81dc496a..993dd2a5f9 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -47,7 +47,7 @@ if [ "$IMGOPTSSYNTAX" = "true" ]; then
 fi
 # We need the image to have exactly the specified size, and VPC does
 # not allow that by default
-_unsupported_fmt vpc
+_unsupported_fmt vpc vvfat
 
 _supported_proto file # We create the FUSE export manually
 _supported_os Linux # We need /dev/urandom
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index fad340ad59..e87cf71fc4 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -23,7 +23,8 @@ qemu_iotests_formats = {
   'raw': 'slow',
   'qed': 'thorough',
   'vmdk': 'thorough',
-  'vpc': 'thorough'
+  'vpc': 'thorough',
+  'vvfat': 'thorough',
 }
 
 foreach k, v : emulators
diff --git a/tests/qemu-iotests/tests/export-incoming-iothread b/tests/qemu-iotests/tests/export-incoming-iothread
index d36d6194e0..9535046dfd 100755
--- a/tests/qemu-iotests/tests/export-incoming-iothread
+++ b/tests/qemu-iotests/tests/export-incoming-iothread
@@ -75,5 +75,5 @@ class TestExportIncomingIothread(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['generic'],
-                 unsupported_fmts=['luks'], # Would need a secret
+                 unsupported_fmts=['luks', 'vvfat'], # Would need a secret
                  supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/fuse-allow-other b/tests/qemu-iotests/tests/fuse-allow-other
index 19f494aefb..6cfbe9ef1f 100755
--- a/tests/qemu-iotests/tests/fuse-allow-other
+++ b/tests/qemu-iotests/tests/fuse-allow-other
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ../common.qemu
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 
 _supported_proto file # We create the FUSE export manually
 
diff --git a/tests/qemu-iotests/tests/mirror-ready-cancel-error b/tests/qemu-iotests/tests/mirror-ready-cancel-error
index ed2e46447e..3b36764ecb 100755
--- a/tests/qemu-iotests/tests/mirror-ready-cancel-error
+++ b/tests/qemu-iotests/tests/mirror-ready-cancel-error
@@ -138,5 +138,5 @@ class TestMirrorReadyCancelError(iotests.QMPTestCase):
 if __name__ == '__main__':
     # LUKS would require special key-secret handling in add_blockdevs()
     iotests.main(supported_fmts=['generic'],
-                 unsupported_fmts=['luks'],
+                 unsupported_fmts=['luks', 'vvfat'],
                  supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/regression-vhdx-log b/tests/qemu-iotests/tests/regression-vhdx-log
index ca264e93d6..eb216c27dd 100755
--- a/tests/qemu-iotests/tests/regression-vhdx-log
+++ b/tests/qemu-iotests/tests/regression-vhdx-log
@@ -40,6 +40,7 @@ cd ..
 . ./common.filter
 
 _supported_fmt generic
+_unsupported_fmt vvfat
 _supported_proto generic
 _unsupported_imgopts "subformat=streamOptimized"
 
-- 
2.44.0


