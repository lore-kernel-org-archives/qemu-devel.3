Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2C8C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxg-0001A0-Dv; Sun, 18 Jan 2026 17:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxY-0000WR-3j
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:24 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxW-0001e6-Ef
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:23 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a12ebe4b74so35821345ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774161; x=1769378961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0b6Gm0w9KlLs51qj052MnIFfJ9dUHou4Uw1pKozVZqU=;
 b=ESncKiU7vDhjYLKqMzk0XEZfDFXJhOMLpAyBBGCZGcf/BXt/851LkhlCXeAggAO+Bq
 VUT0ezxqjmgFvOgLduwczzSSA2xACtM0kMQv0UAA8lO72bO0aiaCRZzgH1d0BCycoE4j
 3/2voonX0Gw/qcvhzupmTrq8ZNL0INwm1v4fjwasUpH6YnLYaVWlj9sGQh8QtnYQdHmO
 Wiwry5CGFETHFpHUrmbX2Y1PnQh2t4svQAYSsrzh98ILMWj+wlrQGNBvE/DDqo2h387e
 IE94yYallrW+RHgDTjhq5hYEwtbwJC/tGPZvXbFnX2RJpW3xeFsd9L2GiiuTvKm07bl7
 TTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774161; x=1769378961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0b6Gm0w9KlLs51qj052MnIFfJ9dUHou4Uw1pKozVZqU=;
 b=b/Ium4P9BamSrJGFI1nFyjj1/sXkzVKx78Mxww382GGRplcOpHMHmn9xqGHxTNTFLc
 Vx9vr5v+ZqeHxACuZwnBvCKtTgSWBZxPW6S9zvBVeyWk0Gkzbq4ROyhr49ABp8LpURbL
 UHBgYGA3PdP6kCS7VPlvg7bk1uBg0ZSvyLIDnXQRmSggox84MNUm8G06o35eq8flQGLf
 0nqKX/F2MsE5/aivHkcZz41c/Z3S8ltC3VGuW2/iKsch9QN6efMH/7vrEOdlsD7mkNkg
 7M00YaEVxJ1Mr27VdZlvpFpbPlrZg3v3qWYFKnzo8UBIs2aitQ4a6+3KU+y2/9XZCYP/
 3gBQ==
X-Gm-Message-State: AOJu0YzNHsAs2yFq6nASV/RB0zz2AoNIg4Ft2eiNxtqBj7aALa5jPrlC
 4jPJlZ6gy1zL0udOvKBFDObMWEeY7U/UZVVZOrF2i/YSfx0g8nUAlK3BI8byJmoESP0g3Apj6Wg
 30E9+179OJQ==
X-Gm-Gg: AY/fxX5UXuld6qedUpP5ZEJ2BIddKMhaQZrz2FcBf53N79Lx9TI/31tTFLTngq20sSW
 5NmALRel6lZ7CLpwxG7LcIXVP3xqzlGB3fbtCIJjVjry/wAoC1+FolTsH48i6wV2EsIrFI5snER
 WSGqj12/F2y5q5W+tatIUqI/Jfqbd7MvLQWnfsRecMQQUgsQhfy4Yce2xs4Xg2HQAjV9q1B5D0n
 DA9BP+L25VJr0q+K5Dfv2JLXf/qqDgQru2SBAehJNcj/Vf4kI/xIlSsevCMmF6N7/VyGvKGBCKD
 AnbZnGamxUBtsIewxPrRR7DcxAc/5YSCdo1PnqtMu7/FvQ6dRYgzSAGrwH7itg5DuLvPrWwVVwg
 Vy6CebBEjJaXLKen7/5mNxgItVe3Caz4763LZ7CMnK8ZPw+vH8qfPFx+KBhaqrYLdt47lDieMvX
 EVN9DjOln6v8wN3eR5sQ==
X-Received: by 2002:a17:902:ce92:b0:295:592f:94a3 with SMTP id
 d9443c01a7336-2a7177da2c4mr91066505ad.48.1768774160999; 
 Sun, 18 Jan 2026 14:09:20 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 50/54] block: Drop use of Stat64
Date: Mon, 19 Jan 2026 09:04:10 +1100
Message-ID: <20260118220414.8177-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The Stat64 structure is an aid for 32-bit hosts, and
is no longer required.  Use plain 64-bit types.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/block/block_int-common.h |  3 +--
 block/io.c                       | 10 +++++++++-
 block/qapi.c                     |  2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 6d0898e53d..9324af903d 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -30,7 +30,6 @@
 #include "qemu/aiocb.h"
 #include "qemu/iov.h"
 #include "qemu/rcu.h"
-#include "qemu/stats64.h"
 
 #define BLOCK_FLAG_LAZY_REFCOUNTS   8
 
@@ -1246,7 +1245,7 @@ struct BlockDriverState {
     QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
 
     /* Offset after the highest byte written to */
-    Stat64 wr_highest_offset;
+    uint64_t wr_highest_offset;
 
     /*
      * If true, copy read backing sectors into image.  Can be >1 if more
diff --git a/block/io.c b/block/io.c
index cace297f22..e8fb4ede4d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -39,6 +39,7 @@
 #include "qemu/main-loop.h"
 #include "system/replay.h"
 #include "qemu/units.h"
+#include "qemu/atomic.h"
 
 /* Maximum bounce buffer for copy-on-read and write zeroes, in bytes */
 #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
@@ -2044,7 +2045,14 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
     if (req->bytes) {
         switch (req->type) {
         case BDRV_TRACKED_WRITE:
-            stat64_max(&bs->wr_highest_offset, offset + bytes);
+            {
+                uint64_t new = offset + bytes;
+                uint64_t old = qatomic_read(&bs->wr_highest_offset);
+
+                while (old < new) {
+                    old = qatomic_cmpxchg(&bs->wr_highest_offset, old, new);
+                }
+            }
             /* fall through, to set dirty bits */
         case BDRV_TRACKED_DISCARD:
             bdrv_set_dirty(bs, offset, bytes);
diff --git a/block/qapi.c b/block/qapi.c
index 9f5771e019..27e0ac6a32 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -651,7 +651,7 @@ bdrv_query_bds_stats(BlockDriverState *bs, bool blk_level)
         s->node_name = g_strdup(bdrv_get_node_name(bs));
     }
 
-    s->stats->wr_highest_offset = stat64_get(&bs->wr_highest_offset);
+    s->stats->wr_highest_offset = qatomic_read(&bs->wr_highest_offset);
 
     s->driver_specific = bdrv_get_specific_stats(bs);
 
-- 
2.43.0


