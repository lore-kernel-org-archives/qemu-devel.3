Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0C4C5DF7E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2ah-0008Ew-RT; Mon, 17 Aug 2026 15:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z0-00063U-E5
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:07 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yx-0006PI-JN
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47fecbb7000so2019198f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993198; x=1787597998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cf1yI1aREIxDxkefBceSwViRa1AdWX44R35eLRi8QFs=;
 b=SBE1ocr3nRYZvKHWpfJIcbHrM0QUbdqfQFlLG/+KbGgFtXgrh4nY9Oj/+ZXUHcdizm
 W0OxbKfwAkWD5kJQYqHChXGGuirqOBi2h8kds4Mku5z0xhUwc6U5HEzIyNEZVwZpcocm
 OcpO9fjLkVB7vqkMJQBSeYv4oWW+N2Z3WBuMweY5GW4y8UNgsOaXAn2S5wmChGQ5X6G3
 ypl1neO7VkBP3kJMu/2YkCU2ONLHy1+/ltVxcwHMYaKHRR2FJSjk+e85jFk6Ds8882H6
 nuT6BsAo4k/lzeslZV58V/8G2ECoFK9EvT5CMI+7VxUrZf16JD6IZFEt5Z/9Mtmk8ac9
 PKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993198; x=1787597998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Cf1yI1aREIxDxkefBceSwViRa1AdWX44R35eLRi8QFs=;
 b=dfaP9NZx9bqfbGVAHdTDvL8X2R8oScIzI36x7o9cnDHEdQEA+1t7D9hpdleAtRaEVk
 iM8dJnOJGnntKsbM5rSouaLDLO9v6XaYSjpJ+h/AKTs9qNUgH0/0lg5xeZo91HU+5gMh
 Q6FMXye53AAjeFINEeyGc1MBCWFv8V+/n5IG19eZlmARGczrc0DEvMHn3gtor/DjXff6
 /+2KOwfY4vqPOok+9avoBshfMRJja6wh5nivVTrk1zAfGLPGdiHBPg7s4S88TZp38QBM
 iuVh7p5ATNRiM0i92tIiryaql2VwiPtAvgEXMHQh2qCHoAKT/0CEXCpq1aSREfyGOqGy
 hB4Q==
X-Gm-Message-State: AOJu0YwhTGWuFDRAWuTTk8t58k09xNQkKRtK04lrzZT6rDqTDILpH8oE
 zksfJKsuGL5w22ptfqBPp91Eu/fzrCp6WKmAcf5oKFcPUMAzmWetuUEAn+XijJG4L4gXVQqhzOG
 Tx8up
X-Gm-Gg: AR+sD106oXNTq9xNfwNcL2li8P8fd6I475UQkdDM8ZwGcOxWG7CVGSOegGtlqNqMcX5
 +OExMJycFWNEo2E5cnrlNRhRUqmbjqAO71ai4ePOFOp5OXkeA+G/Dc7hCP8ENb01JLfF97tAeTc
 7lVnkC2HWBI6tiByWScOQiHJAE5CwkG0gW9+zh7xAE3hW7wMD2OjVDmuoA0+ihMkha77X5qcUPO
 1b1qNeD8Zali9Uex6gdqnVxw9zqFs940KCGCCLCpvi8XP7IFKiYXtOk6asTbGVEs3HWakapDYZS
 6bIHVojw24Qe6qlvdmRgsK88eTc8sZ0LZauFFQvsvguVJpM+EYuzobncOQUPjElJ3xJBe/MC0LV
 jeTzuW9SdX9FFk458Gz1ONvzSymQm6Nwzy698WpNvbwxUXTb0+n9zcOfDxgOjJbvnB0Ud5Itl9f
 k/zLrr7uvcqw0IuwoSDP9TxkB2UgeDQYcjt2g2W8iClAAtN68s3Q==
X-Received: by 2002:a05:600c:9a2:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-49987937932mr277138835e9.2.1786993198066; 
 Mon, 17 Aug 2026 11:59:58 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:57 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 11/25] parallels: Add dirty bitmaps saving
Date: Mon, 17 Aug 2026 20:59:28 +0200
Message-ID: <20260817185942.1065143-12-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=den@openvz.org; helo=mail-wr1-x435.google.com
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

Dirty bitmaps can be loaded now, but there is no way to save them. Add
code for dirty bitmap storage.

A bitmap which can not be stored is refused when it is created, by
parallels_co_can_store_new_dirty_bitmap(), as at store time there is
nowhere left to report it to: it would be dropped while the command
which asked to persist it still succeeded. The format identifies a
bitmap by a UUID, so a name which does not parse as one is refused, and
so is one whose L1 table does not fit the Format Extension cluster next
to the feature headers of the bitmaps already stored and the end of
features marker. The hook and the store path share the size arithmetic.

Losing a bitmap on an I/O error is still possible, and it used to be
silent. Report it through errp and answer -EINVAL from
parallels_inactivate(), the way qcow2_inactivate() does, giving up
before the in use flag is cleared: the inactivation failed, the node
stays writable, and the next open must not be told that the image was
closed correctly.

The extension is rebuilt as a whole and written to freshly allocated
clusters on every store, and its clusters are deliberately absent from
used_bmap, which is what lets the space of the copy read at open time
be reused. parallels_check_unused_clusters() derives the end of the
payload from used_bmap alone, though, so it would report the extension
as a leak and 'qemu-img check -r leaks' would truncate it away while
the header still points at it. Remember where the extension ends in
s->ext_end and use it as a lower bound for the end of the payload.

Based on the original work from Alexander Ivanov.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 295 +++++++++++++++++++++++++++++++++++++++++-
 block/parallels.c     |  12 ++
 block/parallels.h     |   7 +
 3 files changed, 312 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 21f54e4e3e..a0e2be395f 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
@@ -96,8 +97,9 @@ parallels_load_bitmap_data(BlockDriverState *bs, const uint64_t *l1_table,
         if (entry == 1) {
             bdrv_dirty_bitmap_deserialize_ones(bitmap, offset, count, false);
         } else {
-            ret = bdrv_pread(bs->file, entry << BDRV_SECTOR_BITS,
-                             s->cluster_size, buf, 0);
+            int64_t host_off = entry << BDRV_SECTOR_BITS;
+
+            ret = bdrv_pread(bs->file, host_off, s->cluster_size, buf, 0);
             if (ret < 0) {
                 error_setg_errno(errp, -ret,
                                  "Failed to read bitmap data cluster");
@@ -105,6 +107,7 @@ parallels_load_bitmap_data(BlockDriverState *bs, const uint64_t *l1_table,
             }
             bdrv_dirty_bitmap_deserialize_part(bitmap, buf, offset, count,
                                                false);
+            s->ext_end = MAX(s->ext_end, host_off + s->cluster_size);
         }
     }
     ret = 0;
@@ -328,6 +331,8 @@ int parallels_read_format_extension(BlockDriverState *bs,
 
     assert(ext_off > 0);
 
+    s->ext_end = ext_off + s->cluster_size;
+
     ext_cluster = qemu_try_blockalign(bs->file->bs, s->cluster_size);
     if (!ext_cluster) {
         error_setg(errp, "Failed to allocate the Format Extension cluster");
@@ -347,3 +352,289 @@ out:
 
     return ret;
 }
+
+static uint64_t parallels_bitmap_l1_size(uint32_t cluster_size, uint64_t bytes,
+                                         uint32_t granularity)
+{
+    uint64_t granules = DIV_ROUND_UP(bytes, granularity);
+
+    return DIV_ROUND_UP(granules, (uint64_t)cluster_size * 8);
+}
+
+static uint64_t parallels_bitmap_feature_size(uint64_t l1_size)
+{
+    return l1_size * sizeof(uint64_t) + sizeof(ParallelsFeatureHeader) +
+           sizeof(ParallelsDirtyBitmapFeature);
+}
+
+static int GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
+                                              BdrvDirtyBitmap *bitmap,
+                                              uint8_t **buf, int *buf_size,
+                                              GArray *clusters, Error **errp)
+{
+    BDRVParallelsState *s = bs->opaque;
+    ParallelsFeatureHeader *fh;
+    ParallelsDirtyBitmapFeature *bh;
+    uint64_t *l1_table, l1_size, granularity, limit, idx;
+    int64_t bm_size, ser_size, offset, buf_used;
+    int64_t alloc_size = 1;
+    const char *name;
+    uint8_t *bm_buf;
+    QemuUUID uuid;
+    int ret = 0;
+
+    if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
+        bdrv_dirty_bitmap_inconsistent(bitmap)) {
+        return 0;
+    }
+
+    name = bdrv_dirty_bitmap_name(bitmap);
+    ret = qemu_uuid_parse(name, &uuid);
+    if (ret < 0) {
+        error_setg(errp, "Can't save dirty bitmap: ID parsing error: '%s'",
+                   name);
+        return ret;
+    }
+
+    bm_size = bdrv_dirty_bitmap_size(bitmap);
+    granularity = bdrv_dirty_bitmap_granularity(bitmap);
+    limit = bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, bitmap);
+    ser_size = bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size);
+    l1_size = DIV_ROUND_UP(ser_size, s->cluster_size);
+
+    /* The end of features marker has to fit behind the feature as well */
+    buf_used = parallels_bitmap_feature_size(l1_size);
+    if (buf_used + (int64_t)sizeof(*fh) > *buf_size) {
+        error_setg(errp, "Can't save dirty bitmap %s: it needs %" PRId64
+                   " bytes of the Format Extension cluster, %d bytes are left",
+                   name, buf_used, *buf_size);
+        return -ENOSPC;
+    }
+
+    fh = (ParallelsFeatureHeader *)*buf;
+    bh = (ParallelsDirtyBitmapFeature *)(*buf + sizeof(*fh));
+    l1_table = (uint64_t *)((uint8_t *)bh + sizeof(*bh));
+
+    fh->magic = cpu_to_le64(PARALLELS_DIRTY_BITMAP_FEATURE_MAGIC);
+    fh->data_size = cpu_to_le32(l1_size * 8 + sizeof(*bh));
+
+    bh->l1_size = cpu_to_le32(l1_size);
+    bh->size = cpu_to_le64(bm_size >> BDRV_SECTOR_BITS);
+    bh->granularity = cpu_to_le32(granularity >> BDRV_SECTOR_BITS);
+    memcpy(bh->id, &uuid, sizeof(uuid));
+
+    bm_buf = qemu_try_blockalign(bs->file->bs, s->cluster_size);
+    if (!bm_buf) {
+        error_setg(errp, "Can't save dirty bitmap %s: allocation error", name);
+        ret = -ENOMEM;
+        goto fail;
+    }
+
+    offset = 0;
+    while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset,
+                                                  bm_size)) >= 0) {
+        int64_t cluster_off, end, write_size;
+
+        idx = offset / limit;
+
+        offset = QEMU_ALIGN_DOWN(offset, limit);
+        end = MIN(bm_size, offset + limit);
+        write_size = bdrv_dirty_bitmap_serialization_size(bitmap, offset,
+                                                          end - offset);
+        assert(write_size <= s->cluster_size);
+
+        bdrv_dirty_bitmap_serialize_part(bitmap, bm_buf, offset, end - offset);
+        if (write_size < s->cluster_size) {
+            memset(bm_buf + write_size, 0, s->cluster_size - write_size);
+        }
+
+        cluster_off = parallels_allocate_host_clusters(bs, &alloc_size);
+        if (cluster_off <= 0) {
+            ret = cluster_off < 0 ? cluster_off : -ENOSPC;
+            error_setg_errno(errp, -ret, "Can't save dirty bitmap %s: cluster "
+                             "allocation error", name);
+            goto fail;
+        }
+
+        ret = bdrv_pwrite(bs->file, cluster_off, s->cluster_size, bm_buf, 0);
+        if (ret < 0) {
+            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                                  cluster_off, 1);
+            error_setg_errno(errp, -ret, "Can't save dirty bitmap %s: IO error",
+                             name);
+            goto fail;
+        }
+
+        l1_table[idx] = cpu_to_le64(cluster_off >> BDRV_SECTOR_BITS);
+        s->ext_end = MAX(s->ext_end, cluster_off + s->cluster_size);
+        g_array_append_val(clusters, cluster_off);
+        offset = end;
+    }
+
+    *buf_size -= buf_used;
+    *buf += buf_used;
+    qemu_vfree(bm_buf);
+    return 0;
+
+fail:
+    /* Hand the clusters of the half written bitmap back to the allocator */
+    for (idx = 0; idx < l1_size; idx++) {
+        uint64_t entry = le64_to_cpu(l1_table[idx]);
+
+        if (entry > 1) {
+            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                                  entry << BDRV_SECTOR_BITS, 1);
+        }
+    }
+
+    /* Leave nothing behind a reader could take for a complete feature */
+    memset(fh, 0, buf_used);
+    qemu_vfree(bm_buf);
+    return ret;
+}
+
+void GRAPH_RDLOCK
+parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+{
+    BDRVParallelsState *s = bs->opaque;
+    BdrvDirtyBitmap *bitmap;
+    ParallelsFormatExtensionHeader *eh;
+    int remaining = s->cluster_size - sizeof(*eh);
+    uint8_t *buf, *pos;
+    int64_t header_off, alloc_size = 1;
+    g_autoptr(GArray) clusters = g_array_new(false, false, sizeof(int64_t));
+    g_autofree uint8_t *hash = NULL;
+    Error *bitmap_err = NULL;
+    size_t hash_len = 0;
+    int ret;
+    guint i;
+
+    s->header->ext_off = 0;
+    s->ext_end = 0;
+
+    if (!bdrv_has_named_bitmaps(bs)) {
+        return;
+    }
+
+    buf = qemu_try_blockalign0(bs->file->bs, s->cluster_size);
+    if (!buf) {
+        error_setg(errp, "Can't save dirty bitmaps: allocation error");
+        return;
+    }
+
+    eh = (ParallelsFormatExtensionHeader *)buf;
+    pos = buf + sizeof(*eh);
+
+    eh->magic = cpu_to_le64(PARALLELS_FORMAT_EXTENSION_MAGIC);
+
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        Error *local_err = NULL;
+
+        /*
+         * The extension is written as a whole, so a bitmap which does not
+         * make it must not take with it the ones which did.
+         */
+        if (parallels_save_bitmap(bs, bitmap, &pos, &remaining, clusters,
+                                  &local_err) < 0) {
+            error_propagate(&bitmap_err, local_err);
+        }
+    }
+
+    if (pos == buf + sizeof(*eh)) {
+        /* Not a single bitmap made it, so there is nothing to point at */
+        goto end;
+    }
+
+    header_off = parallels_allocate_host_clusters(bs, &alloc_size);
+    if (header_off <= 0) {
+        ret = header_off < 0 ? header_off : -ENOSPC;
+        error_setg_errno(errp, -ret,
+                         "Can't save dirty bitmaps: cluster allocation error");
+        goto end;
+    }
+    g_array_append_val(clusters, header_off);
+
+    ret = qcrypto_hash_bytes(QCRYPTO_HASH_ALGO_MD5,
+                             (const char *)(buf + sizeof(*eh)),
+                             s->cluster_size - sizeof(*eh),
+                             &hash, &hash_len, NULL);
+    if (ret < 0 || hash_len != sizeof(eh->check_sum)) {
+        error_setg(errp, "Can't save dirty bitmaps: hash error");
+        goto end;
+    }
+    memcpy(eh->check_sum, hash, hash_len);
+
+    ret = bdrv_pwrite(bs->file, header_off, s->cluster_size, buf, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Can't save dirty bitmaps: IO error");
+        goto end;
+    }
+
+    s->header->ext_off = cpu_to_le64(header_off / BDRV_SECTOR_SIZE);
+    s->ext_end = MAX(s->ext_end, header_off + s->cluster_size);
+end:
+    for (i = 0; i < clusters->len; i++) {
+        parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                              g_array_index(clusters, int64_t, i), 1);
+    }
+
+    /* A bitmap which was dropped only matters if the rest went through */
+    error_propagate(errp, bitmap_err);
+    qemu_vfree(buf);
+}
+
+bool coroutine_fn parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                                          const char *name,
+                                                          uint32_t granularity,
+                                                          Error **errp)
+{
+    BDRVParallelsState *s = bs->opaque;
+    BdrvDirtyBitmap *bitmap;
+    uint64_t needed, available;
+    QemuUUID uuid;
+
+    if (bdrv_find_dirty_bitmap(bs, name)) {
+        error_setg(errp, "Bitmap already exists: %s", name);
+        return false;
+    }
+
+    if (qemu_uuid_parse(name, &uuid) < 0) {
+        error_setg(errp, "Bitmap name must be a UUID to be stored in a "
+                   "parallels image: %s", name);
+        return false;
+    }
+
+    /*
+     * One L1 entry covers a cluster worth of serialized bits, and every
+     * bitmap of the image shares the Format Extension cluster with the
+     * feature headers and the end of features marker.
+     */
+    needed = parallels_bitmap_feature_size(
+        parallels_bitmap_l1_size(s->cluster_size,
+                                 bs->total_sectors << BDRV_SECTOR_BITS,
+                                 granularity));
+
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        if (!bdrv_dirty_bitmap_get_persistence(bitmap)) {
+            continue;
+        }
+
+        needed += parallels_bitmap_feature_size(
+            parallels_bitmap_l1_size(s->cluster_size,
+                                     bdrv_dirty_bitmap_size(bitmap),
+                                     bdrv_dirty_bitmap_granularity(bitmap)));
+    }
+
+    needed += sizeof(ParallelsFeatureHeader);
+
+    available = s->cluster_size - sizeof(ParallelsFormatExtensionHeader);
+    if (needed > available) {
+        error_setg(errp, "Bitmap %s with granularity %" PRIu32 " does not fit "
+                   "into the Format Extension cluster: every bitmap of the "
+                   "image would need %" PRIu64 " bytes of it, %" PRIu64 " are "
+                   "available", name, granularity, needed, available);
+        return false;
+    }
+
+    return true;
+}
diff --git a/block/parallels.c b/block/parallels.c
index ace79ad968..a9464d5352 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -802,6 +802,7 @@ parallels_check_unused_clusters(BlockDriverState *bs, bool truncate)
     }
 
     end_off += s->data_start * BDRV_SECTOR_SIZE;
+    end_off = MAX(end_off, s->ext_end);
 
     /*
      * A cluster in use behind the end of the file is corruption which
@@ -1555,12 +1556,21 @@ fail:
 static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
+    Error *err = NULL;
     int64_t leak;
 
     if (!(bs->open_flags & BDRV_O_RDWR) || (bs->open_flags & BDRV_O_INACTIVE)) {
         return 0;
     }
 
+    parallels_store_persistent_dirty_bitmaps(bs, &err);
+    if (err != NULL) {
+        error_reportf_err(err, "Lost persistent bitmaps during "
+                          "inactivation of node '%s': ",
+                          bdrv_get_device_or_node_name(bs));
+        return -EINVAL;
+    }
+
     leak = parallels_check_unused_clusters(bs, true);
     if (leak < 0) {
         error_report("Failed to truncate image: %s", strerror(-leak));
@@ -1634,6 +1644,8 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
     .bdrv_co_invalidate_cache   = parallels_co_invalidate_cache,
     .bdrv_inactivate            = parallels_inactivate,
+    .bdrv_co_can_store_new_dirty_bitmap =
+                                  parallels_co_can_store_new_dirty_bitmap,
 };
 
 static void bdrv_parallels_init(void)
diff --git a/block/parallels.h b/block/parallels.h
index eb90aeea81..4684ba2890 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -79,6 +79,8 @@ typedef struct BDRVParallelsState {
     unsigned int bat_size;
 
     int64_t  data_start;
+    /* Exclusive end of the Format Extension, which is absent from used_bmap */
+    int64_t  ext_end;
     uint64_t prealloc_size;
     ParallelsPreallocMode prealloc_mode;
 
@@ -100,5 +102,10 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
                                 Error **errp);
+void GRAPH_RDLOCK
+parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+bool coroutine_fn GRAPH_RDLOCK
+parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                        uint32_t granularity, Error **errp);
 
 #endif
-- 
2.53.0


