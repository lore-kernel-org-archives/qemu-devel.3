Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A299C5DF7E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2av-0001Xt-2R; Mon, 17 Aug 2026 15:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z0-00063S-9d
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yw-0006Ou-M2
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-495437bb891so1863435e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993196; x=1787597996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kJQhdOKNjR/0ShebFeeadPAu9Q3JSbfvQxQRJTWAOqo=;
 b=czSdcy7VawBAY+8QUhr+suVHlzUok+Q2kgOtliCqWfQcUCW9k/rROhbvLgd7Hg91BV
 iWuHp7p9PxsHjJaFZ8dbwX+RRTyVuJzFUUONj2t9Fk2dLmTIg3F4ODvUoFS0HF6aSrLe
 510vzOrTaJme6NrX102cfBfXrYI3D4Zviy0BTj1Zspx1qzJkd7QkKJwglkFovm+6rnvm
 1sniqM0NgJNXnvN9E97eRizDyzXC0l1CoMmyJTA5i+zJGiAe8+jljItfZXiY5m8fQTjl
 XIUIyG+EVSfzjfrBj2Z2kDQ79Y5/UJ7XSfheMZlTgjJvEGqqm9SJHsDlWkn0NjbOa76R
 f2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993196; x=1787597996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kJQhdOKNjR/0ShebFeeadPAu9Q3JSbfvQxQRJTWAOqo=;
 b=js7jy3kAVGAeyvi9Z8h3qXunvoWzX7c8S2AN38ph6Bw43y7jsnJwJ96sPn3+OeutON
 DTPD5S9g+7P8E9Yv4fgwrSJ74YDmG6UsUjmsSq/oHR3/OcN1ERUVygSAu5tkkNbp1foa
 WmJQ61iX7kYmneNxXZ6xzjWNf90HaskE0SlM71bYUig3Ib8gwwRps2sn227B2/iKsOSv
 FUXGDsVhY0EL7VILFnGoEuJxEkKXx/IaB4copxn48WtOLsXi5R0SW1KU5sFLFDtoWfxa
 RAbAs7hFe++MTUzqtOmQgNXt53Mc7hjk4S4Bkck8wPR87YbQGsh5bdbScRPc50BqLiR/
 ICXA==
X-Gm-Message-State: AOJu0YwqDRum1efbGdqm/uxmrXrIhUKwsYIm+VfFrHOv5xkdxPMUpnoR
 4KB7RiBI+F0uDHB6kiiYMq35Y/YOWnZubhyXw1+1I3apyyLJ56R6K8uubpFjmOEduy7CFMin7PQ
 HtLPO
X-Gm-Gg: AR+sD129kplY1tizAz+FelI5S+cCSYmHo3yHKtczi14tfZqlK2l559TsZOZeT1j20VU
 fXUk2L1dKcolBmc7LO3U1+sqOEukveZpUudZGBnuoKgPyRaaSFhvYYucjrEJYDUkFdOiLRz0VrA
 Vl2ov2pJJZ8AB0gXyjH0qsR9ax3Dx4A11M2qQbk3/QGNEXnU0XG6AgojsfKSa+0xYkRE5LDUOOY
 pncNLl5XdCefoW0jYRMJzGPV43+ck/h2nJnD0f8zO68T1IpEJtBPvKGj6vvmcdwNQSxjVGrtqII
 fjhBvFvGIV0buJ+8AFJx1MbQ4QyamagAYrEpMOCrKuA5I7t2Xv2ND1R9wLVJlEHUrVgO26MIyJK
 n69W1tB2NshJgZe13h8V9bYljXMmkfaNgOsmUDqdEtRB9e2TGT9q/mGe5P6BKQchg6AhVP2T+V/
 hwunpguMcc5aFzSWaQScYMfBWVVyY2tv0Ey2yi71iO0Ue46VTWCMI=
X-Received: by 2002:a05:600c:348b:b0:499:77ba:4b6 with SMTP id
 5b1f17b1804b1-499a1f65e40mr515655e9.9.1786993196390; 
 Mon, 17 Aug 2026 11:59:56 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:55 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 10/25] parallels: Remove unnecessary data_end field
Date: Mon, 17 Aug 2026 20:59:27 +0200
Message-ID: <20260817185942.1065143-11-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
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

Since we have used bitmap, field data_end in BDRVParallelsState is
redundant and can be removed.

Add parallels_data_end() helper and remove data_end handling.

The two are not equivalent, which is why this comes before the Format
Extension is stored. data_end is the highest extent seen in the BAT,
while the helper derives the end of the payload from the image file. A
cluster which belongs to the image without being referenced by the BAT,
as the Format Extension and its bitmap data clusters are, stays
invisible to the field: parallels_allocate_host_clusters() appends at
data_end, so it would hand out an offset which is already occupied and
parallels_mark_used() would refuse it with -EBUSY, failing the guest
write.

seek_to_sector() validates a BAT entry against data_end, so it becomes
a user of the new helper, which suits that check better as well: a
cluster has to live inside the image file, while the field could grow
to whatever extent a corrupted BAT entry claimed.

The BAT scan in parallels_open() no longer tracks the maximum extent,
but it keeps rejecting entries below data_start or beyond the end of the
file, so need_check is still set when an entry is out of bounds. Nothing
is accumulated any more, so the scan stops at the first such entry.
high_off in parallels_check_outside_image() only fed the
image_end_offset which the helper now provides, so it goes away with
the field.

The bdrv_pwrite_zeroes() of the branch which reuses a hole goes as well.
It was guarded by data_end, and it is redundant: the space was already
fallocated when the image grew over it. The 'bytes' variable goes with
it, as the used bitmap grows by the preallocated size rather than the
requested one.

Based on the original work from Alexander Ivanov.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 57 +++++++++++++----------------------------------
 block/parallels.h |  1 -
 2 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 2be7c20338..ace79ad968 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -116,6 +116,13 @@ static uint32_t bat_entry_off(uint32_t idx)
     return sizeof(ParallelsHeader) + sizeof(uint32_t) * idx;
 }
 
+static int64_t parallels_data_end(BDRVParallelsState *s)
+{
+    int64_t data_end = s->data_start * BDRV_SECTOR_SIZE;
+    data_end += s->used_bmap_size * s->cluster_size;
+    return data_end;
+}
+
 static int64_t seek_to_sector(BDRVParallelsState *s, int64_t sector_num)
 {
     uint32_t index, offset;
@@ -130,7 +137,8 @@ static int64_t seek_to_sector(BDRVParallelsState *s, int64_t sector_num)
     }
 
     cluster_off = bat2sect(s, index);
-    if (cluster_off < s->data_start || cluster_off + s->tracks > s->data_end) {
+    if (cluster_off < s->data_start ||
+        cluster_off + s->tracks > parallels_data_end(s) >> BDRV_SECTOR_BITS) {
         /* Cluster is outside of the image file or overlaps the header. */
         return -1;
     }
@@ -284,15 +292,14 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
 {
     BDRVParallelsState *s = bs->opaque;
     int64_t first_free, next_used, host_off, prealloc_clusters;
-    int64_t bytes, prealloc_bytes;
+    int64_t prealloc_bytes;
     uint32_t new_usedsize;
     int ret = 0;
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        host_off = s->data_end * BDRV_SECTOR_SIZE;
+        host_off = parallels_data_end(s);
         prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
-        bytes = *clusters * s->cluster_size;
         prealloc_bytes = prealloc_clusters * s->cluster_size;
 
         /*
@@ -323,27 +330,9 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
 
         /* Not enough continuous clusters in the middle, adjust the size */
         *clusters = MIN(*clusters, next_used - first_free);
-        bytes = *clusters * s->cluster_size;
 
         host_off = s->data_start * BDRV_SECTOR_SIZE;
         host_off += first_free * s->cluster_size;
-
-        /*
-         * No need to preallocate if we are using tail area from the above
-         * branch. In the other case we are likely re-using hole. Preallocate
-         * the space if required by the prealloc_mode.
-         */
-        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
-                host_off < s->data_end * BDRV_SECTOR_SIZE) {
-            ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
-            if (ret < 0) {
-                return ret;
-            }
-        }
-    }
-
-    if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
-        s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
     }
 
     ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
@@ -749,7 +738,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t i;
-    int64_t off, high_off, size, data_start_off;
+    int64_t off, size, data_start_off;
     bool fixed = false;
 
     size = bdrv_co_getlength(bs->file->bs);
@@ -759,7 +748,6 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     }
     data_start_off = s->data_start << BDRV_SECTOR_BITS;
 
-    high_off = 0;
     for (i = 0; i < s->bat_size; i++) {
         off = bat2sect(s, i) << BDRV_SECTOR_BITS;
         if (off == 0) {
@@ -774,10 +762,6 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
                 res->corruptions_fixed++;
                 fixed = true;
             }
-            continue;
-        }
-        if (high_off < off) {
-            high_off = off;
         }
     }
 
@@ -792,14 +776,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
         }
     }
 
-    if (high_off == 0) {
-        res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
-    } else {
-        res->image_end_offset = high_off + s->cluster_size;
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-    }
-
-
+    res->image_end_offset = parallels_data_end(s);
     return 0;
 }
 
@@ -1466,8 +1443,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->data_start = data_start;
-    s->data_end = s->data_start;
-    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
+    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
         /*
          * There is not enough unused space to fit to block align between BAT
          * and actual data. We can't avoid read-modify-write...
@@ -1530,10 +1506,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         if (sector < data_start || sector + s->tracks > file_nb_sectors) {
             /* Cluster is outside of the image file or overlaps the header. */
             need_check = true;
-            continue;
-        }
-        if (sector + s->tracks > s->data_end) {
-            s->data_end = sector + s->tracks;
+            break;
         }
     }
 
diff --git a/block/parallels.h b/block/parallels.h
index 493c89e976..eb90aeea81 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
     unsigned int bat_size;
 
     int64_t  data_start;
-    int64_t  data_end;
     uint64_t prealloc_size;
     ParallelsPreallocMode prealloc_mode;
 
-- 
2.53.0


