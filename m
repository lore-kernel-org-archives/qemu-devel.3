Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3494C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28f6-0002j8-Sk; Thu, 03 Sep 2026 10:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28ev-0002dX-1L
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28es-0003zR-8l
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-484374f54d0so1542499f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446597; x=1789051397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gOCgb/8qYTx3Tvjv6qT01WmwOcfq9B2Xk9PXWdyz6VY=;
 b=YznJL2N3wiIuDJOb7eankpuwZQOoUuMilTenlIoHM1/vWXE1estpNTc3DvDlfrYSbV
 qDAAtg35UcvSv5ljDIoFsaqzUR6dyPu5UmjijHG39tm2RSw3Im2Z6zf/mNDWo4FtU7tX
 5LAZOtRy7b5LatbDn+7NfcM4hFoqZEH0/H+gLtaWqWsDSL75x9TQr2UAdwjvYxR+KvLq
 dHoiKHtZeh8aCsbFfoKbRF2g/MnC/UyThI9tnFolMdHUi0BkB7kWd8My8ch51bTlpanR
 i2VyglMjahz3xRjsmmb9kMBMZfO1i+RhZZQe1cTOnZsQKPzNY2kE8lk1p27alp/HhaAM
 oqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446597; x=1789051397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gOCgb/8qYTx3Tvjv6qT01WmwOcfq9B2Xk9PXWdyz6VY=;
 b=TqBNM2OvWtObQRiOwHzWv5zDwwpjzmmUbRpMzA97ESxyiBUKbPlkalmhHapoD38bhs
 X9c+SCK0xj5KD7Cp+gCjLxSl3KhwBIxONTO7iGRvNsdF7DwO0tcytchcpa8H43hK3NDY
 mwlm9Qtb+QDw0KzrfEUCzK8fUzJZ7V9KC6uQMp3Igg2ybxAzDRNYEFFjHNR8SzOkOSSB
 0CTgjtjsdicV/x34bhZ1lRAH4oNEzvzSh13Q0sln54vAIEs/gM3+aoDNfhDaKO33c1tT
 ZIJlsiB8ju+DsshVrA8Et/Ik0BOn+Y8H/eZOe6eoxuxOZu/egmGJl+X5I2QWIfWv9de2
 0JjA==
X-Gm-Message-State: AFuF++nbLiHdPjGI+38qjeaPfazeeY4/gAz+wQqYfFrrgPyG7KrGsz9f
 8lwjvLzjIENKtAmGdUYS6D1OAENv0oAUHyuYIC4YTqa/l9mDDFq7kbFtoVN5z8jUdBxvgSnFag8
 iDXFU
X-Gm-Gg: AYBFou1Xjjt6n8VBrJ02tkMx33suFx7TuHV/TrIVxlFEEjr1TLcxle3ZomipdtMeopQ
 lW8xkHFkW1QnDCeHFWl4PPB2v9zs/4+uPrN5iCeAV+Smxy2Hdz08yN1IHFunLMV7FFhZv95dBKk
 AMSeO5JX3x2D0tD+plZrqJniohkDjxEewkvXl8casgRSj0+LSkgu/0/f3uYRsdBy3Ppni/1ps8x
 nyf4hixwlqzABv5eJiP6MTyGDEH+BzCWaIbXBpdMj0ZuFp35oOMoI8WuxbuPZUvspv0eTcpVFEm
 Hit/bQ2tShh8gG3isHBEd0RTLTrI97mWSHGmET80X56Cp0XwZP+iLLFN708huQT4qKipUHGrflg
 49VfTFNvSG/0qLbbIL6q2AYnIODaBYB33McVd8kdMuQME33kNGXzDV/L2iuclPKxi3AlHj2AaoU
 mCy5Dl38Ie/yAeoLluRi/a5qVTj6i9DJurQcXjWVNwoST1I8XnsUdsjOjI9A2D9k0JrMdM
X-Received: by 2002:a05:6000:1a8c:b0:485:8330:64a with SMTP id
 ffacd0b85a97d-485833009demr7000064f8f.6.1788446596798; 
 Thu, 03 Sep 2026 07:43:16 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:16 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v7 04/25] parallels: Make mark_used() a global function
Date: Thu,  3 Sep 2026 16:41:22 +0200
Message-ID: <20260903144143.2328870-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
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


