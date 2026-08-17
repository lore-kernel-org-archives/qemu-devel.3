Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C356FC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2aX-0007TA-8U; Mon, 17 Aug 2026 15:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yx-00062X-Gv
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yu-0006OS-SJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so40342215e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993195; x=1787597995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sLKHeTr+qaxkryYy6sSzyAc/KU6ezMFM//A19UpNHH4=;
 b=LoZCh5mDHCZVTVjZusHMLbn0l2vYv25K+iXkBVjc+PAFDZTBZi8on52nEfNbo/YJkO
 MDV3gNabhI2tsE4XkX9dzQDN72rDBNDm/RGtBIw3QzR47eAn5T1n5x1mPCuFTIiWRMDW
 TOsafd4R6/fvVmNk8X2O5uWCCFo3NMZcHwqtOEEicH7gU5d475BQzhFXCVIZqTshG9K5
 Qe+0wqiSHOHKOi5OWp98TFoisukTIzPIEz4onf4yNMQN40yBWvMpUAm7nrhBvJNkpmCi
 5lbF1FFADqmmWC51w2La3OFovn1yVkuWsOZAGyAkwHnshlkoHUy15G2Zk9UpMEuIaAyN
 kwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993195; x=1787597995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sLKHeTr+qaxkryYy6sSzyAc/KU6ezMFM//A19UpNHH4=;
 b=oFvyb6LV5p+XMyArcc7kYwoLIuoIRg8ekpB/CFniLl5jDHWigDkroSaw/aZY9VGa9A
 KYujgLroTyrN5cb7JvA0qNKSfwASFjfU1uISrgJhnJWO1XjvTfZoZc7PBhPNY8I5dob0
 hoe9Bhc9dPErb3lNS/0BVs6309l2dgtgGXf5I7LAg5PZo8IYC7ztbOGtEktMW1UehNA8
 zVO3HUksFmJFgwn+oTKIxDU3DID0/rgH4RCfWEtyNsVxVoolctR0RcULYXXpXOxP48VD
 WLOiS8RLWywok6o4Ku1fiLP3vXo38IRi/PdO0s12wel2sGJxmCrkC509tZ7c8zRwc37O
 VIYQ==
X-Gm-Message-State: AOJu0Yw+P0aEVQaajzpTKaf3saH308f3W3VbUf/18Bj+SXm9pzpjrPm9
 3kRu7E5C7whXs7jUK0H8tAI09UpC9nZ3Gx9Hke0I4kgOYbxQJq8bV5qDKsJsTgZ7zKVWXXhsLZk
 +0zck
X-Gm-Gg: AR+sD10Tk2pXSR5nEWTQNl8jGPtMkryd95qHisl4tNWuYUSVWGQtCgCVbmTT8Tc4CpC
 wPWxmpeg9paMHhkUjPvcsehFnV1PLDr6HSUE7RWnXo7OZicSxauo3c+irvT6MjyzQ/eqtcRPUEh
 ci9NDzrJVkzG+BaHAJywO6Zh/U/7bu6fJadiP25f8dFjrJHY+si6sZMryhnlxDiNBVTe+DtmGAA
 1IjIfq4lxd4bJiFAODj8lalm9S5MsTG3jXsr6yFWsdvg56zs+Rwh762V+Mjna1TQ+r53YZqT5Bf
 6oGXrbeFAFEikJBnrRdF9nh/PTgwJMQj2lD/4cTuyjydjZ3YR7qr32Uscy/0oH6Ts26iKpDHzUW
 Z7SuHUPmI9OJ9YBUByIMHm3jZmRBGi5HEMZBbjIexjF4UcuUD2g/62Iie0nVu2DFqPlx4HcytRO
 bclcaFQWveyxkxnYBvNBGQ5lSBNb2b4AL9Re/mLTXtNAXrjxRFGQ==
X-Received: by 2002:a05:600c:3b8f:b0:495:4491:b8c2 with SMTP id
 5b1f17b1804b1-499906ce446mr325234215e9.3.1786993195281; 
 Mon, 17 Aug 2026 11:59:55 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:54 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 09/25] parallels: Drop unused clusters at the end of the
 image
Date: Mon, 17 Aug 2026 20:59:26 +0200
Message-ID: <20260817185942.1065143-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=den@openvz.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On an image closing there can be unused clusters in the end of the
image. Since we have used bitmap, they can be found without a leak
check, so parallels_check_unused_clusters() answers both questions:
inactivation asks it to truncate them away, and the leak check asks it
how much there is.

A repairing leak check truncates the file, so the used bitmap is
recreated afterwards, as it would no longer comply to it.

The helper answers with the size of the leak, which is a byte count and
does not belong in an int. parallels_inactivate() keeps it in an int64_t
and reports only a failure, as a leak of 2 GiB or more would otherwise
look like one and fail the inactivation of an image which was truncated
just fine.

A BAT entry pointing at a cluster which does not fit the file makes the
used bitmap reach further than the file does, and that difference is
not a leak of negative size. parallels_check_outside_image() reports it
as corruption on its own, so answer with no leak at all rather than
-EINVAL, which would fail the whole check before the duplicate check
and the statistics ever run.

Repairing such an entry clears it from the BAT, and the used bitmap has
to follow the way parallels_check_data_off() already makes it follow a
repaired data_off. Otherwise it keeps a bit for a cluster the image no
longer has, and 'qemu-img check -r all' leaves the space behind it
untouched instead of truncating it away.

Rebuilding the used bitmap after the truncation fails with -EBUSY or
-E2BIG on a BAT which points a cluster twice or out of the image.
parallels_open() calls those correctable and repairs them, so they must
not abort the check that is meant to do the repairing.

Based on the original work from Alexander Ivanov.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c                             | 131 +++++++++++++-----
 tests/qemu-iotests/tests/parallels-checks     |  11 ++
 tests/qemu-iotests/tests/parallels-checks.out |  22 ++-
 3 files changed, 126 insertions(+), 38 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 307e90ec71..2be7c20338 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -750,6 +750,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     BDRVParallelsState *s = bs->opaque;
     uint32_t i;
     int64_t off, high_off, size, data_start_off;
+    bool fixed = false;
 
     size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
@@ -771,6 +772,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
             if (fix & BDRV_FIX_ERRORS) {
                 parallels_set_bat_entry(s, i, 0);
                 res->corruptions_fixed++;
+                fixed = true;
             }
             continue;
         }
@@ -779,6 +781,17 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
         }
     }
 
+    if (fixed) {
+        int err;
+
+        parallels_free_used_bitmap(bs);
+        err = parallels_fill_used_bitmap(bs);
+        if (err == -ENOMEM) {
+            res->check_errors++;
+            return err;
+        }
+    }
+
     if (high_off == 0) {
         res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
     } else {
@@ -786,51 +799,96 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
         s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
     }
 
+
     return 0;
 }
 
+static int64_t GRAPH_RDLOCK
+parallels_check_unused_clusters(BlockDriverState *bs, bool truncate)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t leak, file_size, end_off = 0;
+    int ret;
+
+    file_size = bdrv_getlength(bs->file->bs);
+    if (file_size < 0) {
+        return file_size;
+    }
+
+    if (s->used_bmap_size > 0) {
+        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
+        if (end_off == s->used_bmap_size) {
+            end_off = 0;
+        } else {
+            end_off = (end_off + 1) * s->cluster_size;
+        }
+    }
+
+    end_off += s->data_start * BDRV_SECTOR_SIZE;
+
+    /*
+     * A cluster in use behind the end of the file is corruption which
+     * parallels_check_outside_image() reports on its own. There is no
+     * leaked space to reclaim behind it, and nothing to truncate.
+     */
+    if (end_off >= file_size) {
+        return 0;
+    }
+
+    leak = file_size - end_off;
+    if (!truncate) {
+        return leak;
+    }
+
+    ret = bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
+    if (ret) {
+        return ret;
+    }
+
+    parallels_free_used_bitmap(bs);
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret == -ENOMEM) {
+        return ret;
+    }
+
+    return leak;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size;
-    int ret;
+    int64_t leak, count, size;
+
+    leak = parallels_check_unused_clusters(bs, fix & BDRV_FIX_LEAKS);
+    if (leak < 0) {
+        res->check_errors++;
+        return leak;
+    }
+    if (leak == 0) {
+        return 0;
+    }
 
     size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
     }
+    res->image_end_offset = size;
 
-    if (size > res->image_end_offset) {
-        int64_t count;
-        count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-        if (explicit) {
-            fprintf(stderr,
-                    "%s space leaked at the end of the image %" PRId64 "\n",
-                    fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                    size - res->image_end_offset);
-            res->leaks += count;
-        }
-        if (fix & BDRV_FIX_LEAKS) {
-            Error *local_err = NULL;
+    if (!explicit) {
+        return 0;
+    }
 
-            /*
-             * In order to really repair the image, we must shrink it.
-             * That means we have to pass exact=true.
-             */
-            ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
-                                   PREALLOC_MODE_OFF, 0, &local_err);
-            if (ret < 0) {
-                error_report_err(local_err);
-                res->check_errors++;
-                return ret;
-            }
-            if (explicit) {
-                res->leaks_fixed += count;
-            }
-        }
+    count = DIV_ROUND_UP(leak, s->cluster_size);
+    fprintf(stderr,
+            "%s space leaked at the end of the image %" PRId64 "\n",
+            fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak);
+    res->leaks += count;
+
+    if (fix & BDRV_FIX_LEAKS) {
+        res->leaks_fixed += count;
     }
 
     return 0;
@@ -849,7 +907,10 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
     bool fixed = false;
 
     /*
-     * Create a bitmap of used clusters.
+     * Create a bitmap of used clusters. Please note that this bitmap is not
+     * related to used_bmap field in BDRVParallelsState and is created only for
+     * local usage.
+     *
      * If a bit is set, there is a BAT entry pointing to this cluster.
      * Loop through the BAT entries, check bits relevant to an entry offset.
      * If bit is set, this entry is duplicated. Otherwise set the bit.
@@ -1521,16 +1582,16 @@ fail:
 static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
-    int ret;
+    int64_t leak;
 
     if (!(bs->open_flags & BDRV_O_RDWR) || (bs->open_flags & BDRV_O_INACTIVE)) {
         return 0;
     }
 
-    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                        PREALLOC_MODE_OFF, 0, NULL);
-    if (ret < 0) {
-        return ret;
+    leak = parallels_check_unused_clusters(bs, true);
+    if (leak < 0) {
+        error_report("Failed to truncate image: %s", strerror(-leak));
+        return leak;
     }
 
     s->header->inuse = 0;
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index cf90eaf152..c9dcd715ac 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -352,6 +352,17 @@ truncate -s $((file_size - CLUSTER_SIZE / 2)) "$TEST_IMG"
 echo "== the check completes and reports the cluster =="
 _check_test_img
 
+echo "== nothing can be reclaimed behind it =="
+_check_test_img -r leaks
+echo "file size: `stat --printf="%s" "$TEST_IMG"`"
+
+echo "== a full repair drops the entry and truncates the image =="
+_check_test_img -r all
+echo "file size: `stat --printf="%s" "$TEST_IMG"`"
+
+echo "== the first cluster survived =="
+{ $QEMU_IO -c "read -P 0x11 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 # Clear image
 _make_test_img $SIZE
 
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 645c4b3679..6699848996 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -209,13 +209,29 @@ wrote 1048576/1048576 bytes at offset 1048576
 == cut the second one in half ==
 == the check completes and reports the cluster ==
 ERROR cluster 1 is outside image
-ERROR space leaked at the end of the image 524288
 
 1 errors were found on the image.
 Data may be corrupted, or further writes to the image may corrupt it.
+== nothing can be reclaimed behind it ==
+ERROR cluster 1 is outside image
 
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+1 errors were found on the image.
+Data may be corrupted, or further writes to the image may corrupt it.
+file size: 2621440
+== a full repair drops the entry and truncates the image ==
+Repairing cluster 1 is outside image
+Repairing space leaked at the end of the image 524288
+The following inconsistencies were found and repaired:
+
+    1 leaked clusters
+    1 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+file size: 2097152
+== the first cluster survived ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 == TEST A DUPLICATE IN THE LAST ALLOCATED BAT ENTRY ==
 == write two clusters ==
-- 
2.53.0


