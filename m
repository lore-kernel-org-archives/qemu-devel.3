Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30B4C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2Zw-0006Xc-QO; Mon, 17 Aug 2026 15:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yr-0005zq-8y
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yo-0006Mg-TJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so30517855e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993189; x=1787597989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gOCgb/8qYTx3Tvjv6qT01WmwOcfq9B2Xk9PXWdyz6VY=;
 b=lHrvxy8LZ91O4vcNmpKz90523yi6XNnNRobF8qlQ6K+uGdXMNRgEyn7wfFFC1ea/Ir
 iJZx6scoxIz8qdhRszSfmDRssekP55TOsITiDITf5I7EsobZNARUnvKx9P9Xa1g/qYMc
 l19kG490bA0h+58Z1YyZ7OpvomenIwBjkNjJ12VcpeLS0DtWBP5UcRqOXoEIDwU+xTC9
 qFiqZzW8fRqgfbqzQHOFE+lTonUt5crslodynV1Eyd12xvQQfUgDHl0Y9KZA2RLew+Ti
 +1QTUj4iNasXaB0yZyJ4Q803vI+dJX1QGyuIwdLW5yUokoSoYbUKKjVBKuW0FDCOmXt/
 kAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993189; x=1787597989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gOCgb/8qYTx3Tvjv6qT01WmwOcfq9B2Xk9PXWdyz6VY=;
 b=kQlw5egcLWf6/HAZMtdwa5WUDO9kcn/ZkIdp2OG/zbGXgZZj89OBWcegrxQw4VnkFm
 fkxxz/Qx083cvP9NONIpDXUgXXtMHb24TbF7hvCJ+feoj+07BuoYjcY3of7ygCEIJXxm
 +w7GBULLz6s1i/NgcQYSHUazv9V4jIUuHWVpxcnssuNooaTRmD2BBdcgCHUyMPIEQeX6
 KG8orsMUoo+AGbPlZm9TDG0bK4TEhmaqOHI+OquSxXN4o4Yt4pJ5cBaX8sOHboYY6Kd0
 efB19Xu+5nTToa+vhrTJocm0DCN16tU+Xxv0+kg0ZIAatXJA0siTHHF+xl2Q7lD2aGEL
 Ga3g==
X-Gm-Message-State: AOJu0YzIaq9lWP/6AeJEvIReKr37TpojPbRkxKGT2AgvHAO28SWhehcn
 10SuQGngK6DPOnMrZFTJyaRZ7cIkTzmPAHI6oO3Na1VSiBJ1ScAkckWfQJvZ63sP09qA6MkURLl
 cXs3c
X-Gm-Gg: AR+sD12E+ER2dVIsPmmEcSzZqUmYbp0GuwKCsc8/3pNOvsnIXfeEjlEDPVjLWCGf0uF
 bSZmRYjxSufwoBEh9m+uNn/6jloVNZ4yooopvb1d7Gsv0ju+/YS4etwpHg60JPBRAw01ml+iPXh
 XEJ6iWXSNKjgVzz8mGAQNcxe4hLlcxiqI1XlRxScxFhubitVw38yISaRTW+ZBGkolemZcR0fYVH
 67PbyCOrQi0nLpKrOv6oEP8qKM1IIqcbvqgEgcF2E4A7nnMv+B8UR18mb5tA4LW3+QJOMcgDFe+
 ZAuTVi6YoTci1BBAVUcZt6JCEUnwQiNEqOc771r8nxlE7UnbmFe9g/uE4PyV0C16gSBgpCBALlX
 x5EAGXvLTaYfw0f/mVe4DepqqjlaUKS8M4bI43r+wBSCw4CDTcMLz5vTeGw+hIBrED2mLMn/bjR
 yNkFCfbijvpI0EjLTyIpN8Sdp5oBZNfg4JvzytnPgCLBDkZ4OiLA==
X-Received: by 2002:a05:600c:870c:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-4999fb3be85mr42906515e9.9.1786993189325; 
 Mon, 17 Aug 2026 11:59:49 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:48 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v6 04/25] parallels: Make mark_used() a global function
Date: Mon, 17 Aug 2026 20:59:21 +0200
Message-ID: <20260817185942.1065143-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=den@openvz.org; helo=mail-wm1-x336.google.com
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

We will need this function and a function for marking unused clusters (will
be added in the next patch) in parallels-ext.c too. Let it be a global
function parallels_mark_used().

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 14 ++++++++------
 block/parallels.h |  3 +++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index f02ad7a0be..6f7a9911d7 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -187,8 +187,8 @@ static void parallels_set_bat_entry(BDRVParallelsState *s,
     bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_block, 1);
 }
 
-static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
-                     uint32_t bitmap_size, int64_t off, uint32_t count)
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count)
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t cluster_index = host_cluster_index(s, off);
@@ -241,7 +241,8 @@ static int GRAPH_RDLOCK parallels_fill_used_bitmap(BlockDriverState *bs)
             continue;
         }
 
-        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, 1);
+        err2 = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                                   host_off, 1);
         if (err2 < 0 && err == 0) {
             err = err2;
         }
@@ -375,7 +376,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         }
     }
 
-    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, to_allocate);
+    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                              host_off, to_allocate);
     if (ret < 0) {
         /* Image consistency is broken. Alarm! */
         return ret;
@@ -840,7 +842,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
 
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         assert(ret != -E2BIG);
         if (ret == 0) {
             continue;
@@ -900,7 +902,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
          * considered, and the bitmap size doesn't change. This specifically
          * means that -E2BIG is OK.
          */
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         if (ret == -EBUSY) {
             res->check_errors++;
             goto out_repair_bat;
diff --git a/block/parallels.h b/block/parallels.h
index 423b2ad727..68077416b1 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -90,6 +90,9 @@ typedef struct BDRVParallelsState {
     Error *migration_blocker;
 } BDRVParallelsState;
 
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count);
+
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
                                 Error **errp);
-- 
2.53.0


