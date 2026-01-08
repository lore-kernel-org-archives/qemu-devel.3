Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FDCD1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdifu-0004nu-Ot; Thu, 08 Jan 2026 00:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifi-0004c9-L4
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:35:00 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifg-0005yi-VA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:58 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso31473655ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850496; x=1768455296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JH+Dy4yoeNETpN5WiSsY0opPeGAFrG8nwZJ4mKF1IoY=;
 b=ly8GGS5ULuOUsaMVNElS+c5SHkKiHa9r9NINqaXUNl1s5msqmnfrrsBKgktMkfN1Sv
 pysZvCJaBUv3kaLNqE7XS2oygUUDJbmVG1RF5f1UffPuaYXdv2eyIkZDb1DuInpJprAq
 9w7Dijk2cF3UjM64Le9sMbC5oR+EB8lJTBvRThBTuxdy3DpNf7wmuihe1meuNu8VNT9I
 i2igf/e+GvWWeKE9BG7Zk/hBdrDuHfDGdt4KDiN3h+tQSa6ZOGWp38BXsoLc+urtM25N
 LvKhhJu5PxXG7jTyLxUONa7iieQMOuq5KuDKdt4VOt+iC10pjCUxBmouco3kif0d9uVu
 Fhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850496; x=1768455296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JH+Dy4yoeNETpN5WiSsY0opPeGAFrG8nwZJ4mKF1IoY=;
 b=DOJQrLZ+a3aVme51lMa41csh093Nh/3mfzCQdlvgbLVsjr/vqv6OxJaHJ+J3YzxVRu
 UrBQEEMijCDrGGUaDgXqwTquls97OtopJRQDD0IHdtCa/w4pjnrXqcvrGkWhvFVy0NR+
 ODxY50VW19LV4sZHKyc2p91tUGaguj0YZEYe04Y6F9Lm4rtK886IOoKkRxDwZ848UcnJ
 0sxsWWqCm1Nkf2c1GHeYIkcBOqUW0jrovzvg2yVBOu5GApvvNeMvK5/bHEbzAgkUDBuE
 2WHggWgpaC/PXByYrphWFH5DY1iEhnWF+xSOmAIiFQzWYLA30bB4u9mkQLAiIStMEnNq
 QtbQ==
X-Gm-Message-State: AOJu0Ywl3V4DdeLYH1YtrAoHbBc63F+Kb1Xbre8zWXkRmuaTA9E3eL5r
 lkXWJTgj/eGh9ghuPkMTJWyPIKIBoTcB6DNPFVm6ACW9SZgucvS+MZQ8UPQWf30ZL4Qe2G+cosX
 V5ekjSHs=
X-Gm-Gg: AY/fxX6Z6rCP5OYKzSZlgqkj2TGdaruXlgUTs1ztRzOLUpGedTMRgUNmcj+5bPjuOjB
 ugzqilZQKTE+XldbWfsNWB80ELXRjefRTyDIC4HYHIiDu1w8T9SLmHn06MjAni8Yd3YKC0fCuPf
 Iw7ztdiCuOyPPvG9md1RfIN0zzWi9jruJ/BCrKfjPB2n2e9zC06rZEGyUS2gAk/uoPnWmtWp2jF
 clnTVjYeKZH65UkWuxwwPDuReX4uLRZTJkcSoZnyGZJ5hpDHMeXuUGgc9NerlOjoaBlZk/nfYoj
 piWPfv3izGYJf5KNhhZSe4ej1+OItRpFlx/zhV2Kec3Aahu1qIXTNv5YVD9rRUwhs1ylvrY8sEb
 pP+7WZDNLDixqcD1Medf1nK+Lma6WhQBVFnbDs9QfzbT6J2xwGgvE2zdyiLycctd9VUhDW7Bv+i
 a8qB878691EB4di891ZQ==
X-Google-Smtp-Source: AGHT+IFdw/8bwv6pjDs9LnC6r/TdWiGAsnyRp6X2M39e/jmgtW1ygRMUtEGV92GaBpmNkcRULJ4Piw==
X-Received: by 2002:a17:902:ce87:b0:2a0:c1f6:6bc2 with SMTP id
 d9443c01a7336-2a3ee4c1b37mr50973485ad.59.1767850495493; 
 Wed, 07 Jan 2026 21:34:55 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2d93sm66341465ad.63.2026.01.07.21.34.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:34:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 46/50] block: Drop use of Stat64
Date: Thu,  8 Jan 2026 16:30:14 +1100
Message-ID: <20260108053018.626690-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

The Stat64 structure is an aid for 32-bit hosts, and
is no longer required.  Use plain 64-bit types.

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


