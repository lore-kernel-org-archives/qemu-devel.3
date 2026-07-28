Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF33C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofGd-00089C-8v; Tue, 28 Jul 2026 06:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGb-00087X-MZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:33 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGZ-0008Hq-Uk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:33 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so151890466b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785235350; x=1785840150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aVkbd/prjb9WYwlM7SXvDF45HVgnD6g6uz+iwnib8ps=;
 b=auBDwRsPvKZneFcBlveMY7ZsDnDSCGOQAhzT7CbJ787+v2njkni/seu2pPxfTU4E2Q
 YdX2rCsBRMcHLJTZTlhHX7Qt7KUmhbyDl0HyfMvSyZvi3Xa7tEw8jEhDjj9SEUAitD12
 QeeDdoZIC1okFjKkSw+4kmPGIgXz92TdScSHmiMpBPdxAVV8olLUJ3uYVSbp1e63eqHU
 1FUReB7/ynC9mIhIOFiiRit0+8mDh1CMUzCTvL9bNYHfcz7iESoAEB71HKaL5m390GY4
 MJc7muT2Q3UUpfUDf/jn30RCJnyejBr8h88S6GtIxSGe0jpRLmuvq2Xr4SwU9wZFuMtm
 cwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785235350; x=1785840150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aVkbd/prjb9WYwlM7SXvDF45HVgnD6g6uz+iwnib8ps=;
 b=T5G0YpeXIjcd6+7kGIwjImtPKrxMInkegwEa1YAgrIZXFoY2Ss+dmBPFaZ6fLUoRxe
 ordyRgzzL1RV1q5mOjbqN64W8wG0msUnvrQy5Qac3tNAc21X92YSp7KJ4DFjwE6SaTkI
 XhOrJNHY+nSl0LyDKZZFDuJ4kVZgvOtSBEeI8j1Ht4N2ESdZrbh1x3FbsqLs+pCexMJ0
 9NWvJzZUuwry0fD73TCD2RFt4Kt4gsaAvyoxn0DA3YmYf8kEBF7EWOKOTTSvepgJucEI
 CFUmIbvdK8QOA5nA5rzCwduhYg6nV/szh9WXsT+tRgk/QYmVwPsKK+MkbqHUBBcw5PWD
 DL0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwDEdeujNEzUBjrns7VT8GIHHRo+fIRRz1yXu4ixjwxjFBZcp3SfcUh1rX6kpjlymaa55t+Nvxnst2@nongnu.org
X-Gm-Message-State: AOJu0Ywm8O0hZEF0poT6wP31BRNxWcflYhoWZlRR23Zdc2kCDCOkXVuM
 QvBLGZZLGvvYoB9SjjrRjxPutPbLtN1aoTbJJYmIxGxss2y/wJR724gCJXicnT+fsFs=
X-Gm-Gg: AR+sD11SQdu8GPvo9GinNEXdw1Nj8aQe7kLPeifFhyjNe16WBv1kk+on20oN5uW23P9
 RAbgjE+OBKq7f+47IBse3Od7g5f9Qrew2opauE7nEthZ4PO4QFqaMYke749ijtacj8MnpdBSs6O
 z+G1ZDv46syqIxxSoIT//3mpY9auo5hKWZFhrCCPqYOznia1FZ0pswzYN9A0MIB9Mr11sqOzsQ7
 WTaXM0xPrXPKOR1vZZE2rmE/EUz0NBb/leP2Zc2xgBm3jbKZYAfxJZjW0xyi1xpofV/BuIs+JpK
 dH6TJcuoZAfj6DKXAPVkmQYE6h5pbA6AinCDcfaIT3J8a9zIYzqE0HN3vtZRQkZ1g518cfP+BHc
 GPdISOvjhUlYHUEH9f6iCI67tsX0OybmA/oP9EXH0Ew1pgr4oyurT0FLoEbB5R0AYqA==
X-Received: by 2002:a17:907:d408:b0:c16:6dac:a008 with SMTP id
 a640c23a62f3a-c1f71c85ca3mr106424566b.8.1785235350267; 
 Tue, 28 Jul 2026 03:42:30 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b4dsm745682266b.35.2026.07.28.03.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:42:29 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 5/9] parallels: validate bitmap L1 table size before allocating
 it
Date: Tue, 28 Jul 2026 12:42:17 +0200
Message-ID: <20260728104221.3981592-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728104221.3981592-1-den@openvz.org>
References: <20260728104221.3981592-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=den@openvz.org; helo=mail-ej1-x62c.google.com
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

parallels_load_bitmap() allocated the L1 table sized directly from
the untrusted l1_size field, only cross-checking it against the
bitmap's actual size after the allocation and the L1 table copy had
already happened.

Compute the expected size and reject a mismatch before touching the
allocator, instead of after.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels-ext.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 3410daa620..97744c9696 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -70,20 +70,11 @@ parallels_load_bitmap_data(BlockDriverState *bs, const uint64_t *l1_table,
     uint64_t offset, limit;
     uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
     uint8_t *buf = NULL;
-    uint64_t i, tab_size =
-        DIV_ROUND_UP(bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size),
-                     s->cluster_size);
-
-    if (tab_size != l1_size) {
-        error_setg(errp, "Bitmap table size %" PRIu32 " does not correspond "
-                   "to bitmap size and cluster size. Expected %" PRIu64,
-                   l1_size, tab_size);
-        return -EINVAL;
-    }
+    uint64_t i;
 
     buf = qemu_blockalign(bs, s->cluster_size);
     limit = bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, bitmap);
-    for (i = 0, offset = 0; i < tab_size; ++i, offset += limit) {
+    for (i = 0, offset = 0; i < l1_size; ++i, offset += limit) {
         uint64_t count = MIN(bm_size - offset, limit);
         uint64_t entry = l1_table[i];
 
@@ -124,12 +115,14 @@ static BdrvDirtyBitmap * GRAPH_RDLOCK
 parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
                       Error **errp)
 {
+    BDRVParallelsState *s = bs->opaque;
     int ret;
     ParallelsDirtyBitmapFeature bf;
     g_autofree uint64_t *l1_table = NULL;
     BdrvDirtyBitmap *bitmap;
     QemuUUID uuid;
     char uuidstr[UUID_STR_LEN];
+    uint64_t bm_size, tab_size;
     int i;
 
     if (data_size < sizeof(bf)) {
@@ -164,6 +157,17 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
         return NULL;
     }
 
+    bm_size = bdrv_dirty_bitmap_size(bitmap);
+    tab_size = DIV_ROUND_UP(
+        bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size),
+        s->cluster_size);
+    if (tab_size != bf.l1_size) {
+        error_setg(errp, "Bitmap table size %" PRIu32 " does not correspond "
+                   "to bitmap size and cluster size. Expected %" PRIu64,
+                   bf.l1_size, tab_size);
+        goto fail;
+    }
+
     l1_table = g_new(uint64_t, bf.l1_size);
     for (i = 0; i < bf.l1_size; i++, data += sizeof(uint64_t)) {
         l1_table[i] = ldq_le_p(data);
@@ -171,8 +175,7 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
 
     ret = parallels_load_bitmap_data(bs, l1_table, bf.l1_size, bitmap, errp);
     if (ret < 0) {
-        bdrv_release_dirty_bitmap(bitmap);
-        return NULL;
+        goto fail;
     }
 
     /* We support format extension only for RO parallels images. */
@@ -180,6 +183,10 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
     bdrv_dirty_bitmap_set_readonly(bitmap, true);
 
     return bitmap;
+
+fail:
+    bdrv_release_dirty_bitmap(bitmap);
+    return NULL;
 }
 
 static int GRAPH_RDLOCK
-- 
2.53.0


