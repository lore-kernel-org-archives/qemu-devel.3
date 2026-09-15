Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FDBC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RZy-0000kE-Ns; Tue, 15 Sep 2026 07:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6RZL-0000f8-O7
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:43:24 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6RZ5-0005PS-HZ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:43:12 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843f22dc83so2212380f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789472583; x=1790077383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lDVXntjhSghPxLA6Cp0G7NQ6A+eniameEy7FZm2Hlnk=;
 b=mstC/ABLK2I0HYN1hNGJ0d+hG4/l5E4EThMNYfgSLbKQoly4vAzAtRM5jKBktLOIfR
 Ijj6gE3rYlEBVjcuFVE3WnoldZWMmxdSW8vV84AyuQ63KN0O9g9YwXe8nfEj1FNh5iHw
 u2+Ba9eFuHXCztNzHyqgPrH7uF7W2F8hDRRHmR0fuE5M8J1XM1Vm1aTbDtt4f8j7S8QL
 MwcxWUt0txXvK48sL1vVHMyuf8/o2o4zTyuYRltdpwA0G8PElM6nwRKbI38qAadlyLGM
 +fS2sig0jUtCjaXIQVny/DLw38y1NbmkcKvyuV8I+52SPuHoFVjEq15UvNvhe90O6ofA
 5SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789472583; x=1790077383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lDVXntjhSghPxLA6Cp0G7NQ6A+eniameEy7FZm2Hlnk=;
 b=UUIvC5OVI9jmMKbBzheiMY7xtLddLtrHtVl4hadCInHVN39n7C1ezjsomXrH7LIVsN
 PTGyxPxZpCxWDMtpEA6mUIes7uCVssm4cCUKmpzyaRchu1Iym69WNlRY3adTkqAvZYMp
 MGosuez6Bb0NonLMKEBxODRNVmOTIxEBAgfcb8OZsQvOsvtDmu966prF/39qwc3kI55d
 uNPyrtxkk4/EmRVgUqX4zQrDdMRpFPfi931ZAMGR5LXWL+c35qSJfxVBDVseSsoyOL6C
 SpUmner1OM+ntK08zEq2+UGmpNs++RW0FO1w83K6rgEuxIcbqSb7H19VUhSypM9+T3PY
 S3vQ==
X-Gm-Message-State: AFuF++mupb/jH5rJTbS9ZecCOtoVyVlgjhyOy5jTg1s/xJaTa9gQxzZR
 QgdEwvIsARD5bqya82M6Z9QzH7EvS+ano5mKyqWMzMQ/TM0gqO0+8wPp6P1b3SWdNImTwBzbYho
 OAwGq
X-Gm-Gg: AYBFou3ErV3QQtPJwQdGDg8m9APAdLd74oc2sxvSe6jK/SBVYvc8krE/AhViO+P9Y11
 LGZPvVdSLPqJlxOqMcK+WoIMQ/Zgy48iAHjoEbNC6sXfQ6csOrv+iBfRSt0XQ7yIJnhEqnBI8NQ
 /bXhaBQ0J9HOvzAmLS0AYNVmVQHTi2O4xgnTZ/vcvrm7PqFygLCrRv1ljrOALxu900eHOxgezkM
 H3xQF0JPdrIXtCYkMMSDIaOxqZSZYgGjodYwgIA+Ma3Gv+kLk1iCQv2ERregS17otECLORActwz
 nz0uNUmW7hHOkF8g29y+ynZOqttMWrXvgkOgUYhKckB92orId+AL/66t7le4eC8e1YdVsojSY2H
 BjRqijzzUDXT3+BySCdWt/yqtoVKbdWuHC2nO+J4v9Yh6jWdgjQfK0XZkF8LeB4AdGFiBxW+Aed
 /kMA95LPb6kl6ICg9c0+cmZVecGUR6BRxjUr2kvj657w7sK6keSkoXoX9Y/W8fQX7QaPj6
X-Received: by 2002:a05:6000:2312:b0:485:8edf:8353 with SMTP id
 ffacd0b85a97d-48702b184b7mr8514877f8f.43.1789472582822; 
 Tue, 15 Sep 2026 04:43:02 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:33e6:6107:4678:322f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e4b5sm33648081f8f.22.2026.09.15.04.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 04:43:02 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 1/3] parallels: report the stored dirty bitmaps in qemu-img info
Date: Tue, 15 Sep 2026 13:42:56 +0200
Message-ID: <20260915114258.3862446-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915114258.3862446-1-den@openvz.org>
References: <20260915114258.3862446-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

Nothing tells which persistent bitmaps an image carries. qemu-img info
says nothing about them, and the only other way to see one is to export
the image over NBD and ask for a bitmap by name, which needs the name
beforehand.

Add ImageInfoSpecificParallels with the bitmaps and their granularity,
in the same way as qcow2 reports the contents of its bitmap directory:

    Format specific information:
        bitmaps:
            [0]:
                name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
                granularity: 65536

For running VM process the list is built on the fly from in-memory
list. This is the best we can do. FormatExtension could be dead in
the image while VMs are running as all bitmaps are cleared on
non-clean VM stop.

A bitmap of an image which was not closed correctly is inconsistent
and can not be used. Report that as well, the way qcow2 reports its
in-use flag, so such a bitmap is not listed as a valid one.

The section is left empty for an image with no persistent dirty
bitmaps, and an empty section is not printed, so the human readable
output of "qemu-img info" and "info block" is unchanged.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 block/parallels-ext.c                         | 26 +++++++++++
 block/parallels.c                             | 20 +++++++++
 block/parallels.h                             |  3 ++
 qapi/block-core.json                          | 45 ++++++++++++++++++-
 tests/qemu-iotests/tests/parallels-checks     |  6 +++
 tests/qemu-iotests/tests/parallels-checks.out | 19 ++++++++
 6 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index f687f2da7c..8b8035af91 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -736,3 +736,29 @@ parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 
     return ret;
 }
+
+void parallels_get_bitmap_info_list(BlockDriverState *bs,
+                                    ParallelsBitmapInfoList **info_list)
+{
+    BdrvDirtyBitmap *bitmap;
+    ParallelsBitmapInfoList **tail = info_list;
+
+    *info_list = NULL;
+
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        ParallelsBitmapInfo *info;
+
+        if (!bdrv_dirty_bitmap_get_persistence(bitmap)) {
+            continue;
+        }
+
+        info = g_new0(ParallelsBitmapInfo, 1);
+        info->name = g_strdup(bdrv_dirty_bitmap_name(bitmap));
+        info->granularity = bdrv_dirty_bitmap_granularity(bitmap);
+        if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
+            info->has_inconsistent = true;
+            info->inconsistent = true;
+        }
+        QAPI_LIST_APPEND(tail, info);
+    }
+}
diff --git a/block/parallels.c b/block/parallels.c
index 2a5ceb8978..e7d65d0458 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1624,6 +1624,25 @@ static bool parallels_is_support_dirty_bitmaps(BlockDriverState *bs)
     return 1;
 }
 
+static ImageInfoSpecific * GRAPH_RDLOCK
+parallels_get_specific_info(BlockDriverState *bs, Error **errp)
+{
+    ImageInfoSpecificParallels *parallels_info;
+    ImageInfoSpecific *spec_info;
+
+    parallels_info = g_new0(ImageInfoSpecificParallels, 1);
+    parallels_get_bitmap_info_list(bs, &parallels_info->bitmaps);
+    parallels_info->has_bitmaps = !!parallels_info->bitmaps;
+
+    spec_info = g_new(ImageInfoSpecific, 1);
+    *spec_info = (ImageInfoSpecific){
+        .type = IMAGE_INFO_SPECIFIC_KIND_PARALLELS,
+        .u.parallels.data = parallels_info,
+    };
+
+    return spec_info;
+}
+
 static BlockDriver bdrv_parallels = {
     .format_name                = "parallels",
     .instance_size              = sizeof(BDRVParallelsState),
@@ -1653,6 +1672,7 @@ static BlockDriver bdrv_parallels = {
                                   parallels_co_can_store_new_dirty_bitmap,
     .bdrv_co_remove_persistent_dirty_bitmap =
                                   parallels_co_remove_persistent_dirty_bitmap,
+    .bdrv_get_specific_info     = parallels_get_specific_info,
 };
 
 static void bdrv_parallels_init(void)
diff --git a/block/parallels.h b/block/parallels.h
index 27d8c3ac83..012f47320b 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -32,6 +32,7 @@
 #ifndef BLOCK_PARALLELS_H
 #define BLOCK_PARALLELS_H
 #include "qemu/coroutine.h"
+#include "qapi/qapi-types-block-core.h"
 
 #define HEADS_NUMBER 16
 #define SEC_IN_CYL 32
@@ -111,5 +112,7 @@ parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
 int coroutine_fn GRAPH_RDLOCK
 parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                             const char *name, Error **errp);
+void parallels_get_bitmap_info_list(BlockDriverState *bs,
+                                    ParallelsBitmapInfoList **info_list);
 
 #endif
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 199efc1e00..aed2888147 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -188,6 +188,16 @@
       '*extent-size-hint': 'size'
   } }
 
+##
+# @ImageInfoSpecificParallels:
+#
+# @bitmaps: A list of parallels bitmap details
+#
+# Since: 11.2
+##
+{ 'struct': 'ImageInfoSpecificParallels',
+  'data': { '*bitmaps': ['ParallelsBitmapInfo'] } }
+
 ##
 # @ImageInfoSpecificKind:
 #
@@ -197,10 +207,12 @@
 #
 # @file: Since 8.0
 #
+# @parallels: Since 11.2
+#
 # Since: 1.7
 ##
 { 'enum': 'ImageInfoSpecificKind',
-  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file' ] }
+  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file', 'parallels' ] }
 
 ##
 # @ImageInfoSpecificQCow2Wrapper:
@@ -255,6 +267,16 @@
 { 'struct': 'ImageInfoSpecificFileWrapper',
   'data': { 'data': 'ImageInfoSpecificFile' } }
 
+##
+# @ImageInfoSpecificParallelsWrapper:
+#
+# @data: image information specific to Parallels
+#
+# Since: 11.2
+##
+{ 'struct': 'ImageInfoSpecificParallelsWrapper',
+  'data': { 'data': 'ImageInfoSpecificParallels' } }
+
 ##
 # @ImageInfoSpecific:
 #
@@ -273,7 +295,8 @@
       'vmdk': 'ImageInfoSpecificVmdkWrapper',
       'luks': 'ImageInfoSpecificLUKSWrapper',
       'rbd': 'ImageInfoSpecificRbdWrapper',
-      'file': 'ImageInfoSpecificFileWrapper'
+      'file': 'ImageInfoSpecificFileWrapper',
+      'parallels': 'ImageInfoSpecificParallelsWrapper'
   } }
 
 ##
@@ -751,6 +774,24 @@
   'data': {'name': 'str', 'granularity': 'uint32',
            'flags': ['Qcow2BitmapInfoFlags'] } }
 
+##
+# @ParallelsBitmapInfo:
+#
+# Parallels bitmap information.
+#
+# @name: the name of the bitmap
+#
+# @granularity: granularity of the bitmap in bytes
+#
+# @inconsistent: true if the bitmap is in an inconsistent state and
+#     cannot be used
+#
+# Since: 11.2
+##
+{ 'struct': 'ParallelsBitmapInfo',
+  'data': { 'name': 'str', 'granularity': 'uint32',
+            '*inconsistent': 'bool' } }
+
 ##
 # @BlockLatencyHistogramInfo:
 #
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 3e9928c9c3..ca89ed5d62 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -382,6 +382,9 @@ echo "== dirty a single granule of the bitmap =="
 file_size=`stat --printf="%s" "$TEST_IMG"`
 echo "file size: $file_size"
 
+echo "== the bitmap is reported by qemu-img info =="
+_img_info --format-specific
+
 echo "== the extension and its bitmap data are not a leak =="
 _check_test_img
 
@@ -425,6 +428,9 @@ $QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
 echo "== pretend the image was not closed correctly =="
 poke_file "$TEST_IMG" "$INUSE_OFFSET" "\x59\x6e\x6f\x74"
 
+echo "== a read-only open still reports it, marked inconsistent =="
+_img_info --format-specific
+
 echo "== the bitmap is stale, so it can not be used and is dropped =="
 $QEMU_IMG bitmap --clear -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
 
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 871a88d924..f6806f82fa 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -241,6 +241,15 @@ qemu-img: Operation add on bitmap bitmap0 failed: Bitmap name must be a UUID to
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 file size: 4194304
+== the bitmap is reported by qemu-img info ==
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 4 MiB (4194304 bytes)
+Format specific information:
+    bitmaps:
+        [0]:
+            name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
+            granularity: 65536
 == the extension and its bitmap data are not a leak ==
 No errors were found on the image.
 == extend image by 1 cluster ==
@@ -273,6 +282,16 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == pretend the image was not closed correctly ==
+== a read-only open still reports it, marked inconsistent ==
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 4 MiB (4194304 bytes)
+Format specific information:
+    bitmaps:
+        [0]:
+            name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
+            granularity: 65536
+            inconsistent: true
 == the bitmap is stale, so it can not be used and is dropped ==
 Repairing image was not closed correctly
 qemu-img: Operation clear on bitmap b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45 failed: Bitmap 'b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45' is inconsistent and cannot be used
-- 
2.53.0


