Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725DFD4A5F6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagd-0005NX-I9; Thu, 15 Jan 2026 22:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagc-0005Mp-90
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:46 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaga-00007Y-LZ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:46 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0fe77d141so11771165ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534783; x=1769139583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0b6Gm0w9KlLs51qj052MnIFfJ9dUHou4Uw1pKozVZqU=;
 b=NC2WntN65OQnLkzi34BqurICNgIjyFMo/UB/dGww/Ig6Le+Jn3/J3q841CXuB3tqUY
 mqgq2d4lo3ukHNWYZXchBA6IHzZc+A6J0Bnh/dNfa8/5rv3tDUMdYAkzSHmUC9SVW8bY
 wAKAkATWm7j4d226Yz0p14PXdxvXikNTP1IloTVGJyXtQqEyPAjIjjIYGti3wpWh1LOV
 zrjiKQnlYOeS3GD9MQRjdLdnUu0NgFNQUu3HHJjGQftp8lf2YjU8m4eRBTs8x8YNjKJH
 VlZVAnZpaOr+fRXDZWhdyMuUtW+NQNfVhUjLJbWOJG2+UJ6FmOXSXv3TZIEsGGfzDYdv
 bNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534783; x=1769139583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0b6Gm0w9KlLs51qj052MnIFfJ9dUHou4Uw1pKozVZqU=;
 b=NQNWJQ403ORk+YWOhBixx54ruGSAFUVxYk6H9DJ87sJ6ePNUW6Qg8KWbMdm7SO7uH4
 om/AWIvjB6sA8B4+OgAYmEWl3pUNGvNmgbah3Uimsbf0PcfqEi64hwB+HmKKgiltqtkH
 7DO0qsx7Df0pkra4ANqzTu3eBOuk8gwow/e2eu7fFVBqy4eW7jFq4vlfnNyuORFZdJpL
 hLZcXqC3i5yzX6PKIr71E/Y09supVNx7y5lac0lizMEomDjP3M3j9lrV7PtntiOJOker
 a9Kj4W1hs/C9NSWe2rLLUEA4aCAYm2OIjTccUyhgVsV7GLlSOct4zarN4c2SvjojcW2l
 m/RQ==
X-Gm-Message-State: AOJu0YzM7gmYcgsuk4UprFEvDA2FM8z4DotmXmiTgfxxl0Io+Ar0T4ms
 PUFpoLac+dLw+PwdFTkk5gfyMe1lXz/bvHZytnK0NpPjY9noMAXmyiyMMXh1uymNh+2Xt9Yqqp5
 T99mFbXWHzg==
X-Gm-Gg: AY/fxX4kuk6VfwMjGkwaPhbJPflxGbZlpCtiqcthKGf9xUHl97efK3vcvbgAUKRCl2d
 umqIb2wU+POMPhIFEkgL/s0T7jCuusyhvAC5sTPT+fkmp3pVQJAuoLceXaWqqQnZjofW4yo5XDH
 9X+ZiYXe/oOZ3La3JlbEXxsLlnR2For8C2tAt031U4gpq+X+0k8HRV0TPZskXZRUdGDde48ltWz
 swWNf6ela1K8IxC4pvxsQ0QgktJa7k1YAUXJiHvKAKOkOU5ahVsa+8wz2b7yJvh7x+YcMdn5kis
 d9N7LtEsWu8tmVY9ZB74/+hrqM4p+3SjBD1icSvOY9LUrZDsGE0yYTx5ANNKz6emeZJnUFWD6c0
 5zjp618+pCCs3h44uiqBEgiwhbHwYhqZsipeL07mcelZclIIKxQ5WNGRSCAn6QNGrwRDptEsge8
 b5/IT1iFItCmb1r4xI8A==
X-Received: by 2002:a17:903:40cb:b0:2a0:bb3b:4193 with SMTP id
 d9443c01a7336-2a7176cc6c7mr15699485ad.40.1768534782829; 
 Thu, 15 Jan 2026 19:39:42 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 54/58] block: Drop use of Stat64
Date: Fri, 16 Jan 2026 14:33:00 +1100
Message-ID: <20260116033305.51162-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


