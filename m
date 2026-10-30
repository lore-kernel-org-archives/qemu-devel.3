Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=fV2nIHl5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb53-0002Mo-6A; Thu, 29 Oct 2026 21:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4x-0002It-JS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:47 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4n-0006G3-6X
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso724265e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793322394; x=1793927194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QkHRhSns5Bho057K1prrFbTgtQFEeAH3lNc5pa8hbfg=;
 b=fV2nIHl5q/eVU/cRlNwow8cLepUdsGPBiaRKQmF2U5m2o600LxnsuZxc+wx75GTFYW
 7ti/q9WSmbsUj6iGJW/xTYIJfZ9PQQP18k8+D8IHZM7/ZdXPr8oRzG7274ZuNFgzm9Tg
 pTUv/5iidwDaw5+W29yo3+NfyXHlyOqc6Mdfpyammz481uclW7JVZf5RnTFf2FnEin5B
 XWvDSWKd0Ps0Skehisni8u1PTXFq0poQ1HmKDpUYA5buCNOP4KoIj4gVIeuX9WbhWM2a
 cqHRAAvR5jNgBG6D6jU/hQmJeBg91LekzUXoh21JrrG3DD0gn0IIIIAp4b+qy5pIHbYL
 6Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322394; x=1793927194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QkHRhSns5Bho057K1prrFbTgtQFEeAH3lNc5pa8hbfg=;
 b=gAgmH2N467sludJA4xVfhXkHrpjONvtPGTH4SqJ7MAKgP/6ZO2xI1YH5xnJAso19Td
 j/BNdyhUt0l1X+qhW5Q7pyC7D2ur2aimPP98xaeFgMxs624uG+h4yNVv5ojjBSCfNCfw
 J8wd3wooO1kfONqrRDIJigPhopLj1RXecfjkjm9SIhkkP1gqYDlI2vA3nQwn5YV19TgZ
 fitWOxQgEA0u9Foh3D2nGRlNedul9kvxMgVI9TVjvbRVcMcAc1YCPbAs6qKvzUlOurnL
 dfmIbzsyUsGT5SsqUg52M+uRNQw4TFk8LGMvmKjKosxpulhXAozMISXSEr5DtRsmIWqd
 YbGw==
X-Gm-Message-State: AFq9FYJIR9zAP4ECueDzBeg1xzY/J9Rl+QXZTflNRAZukMfvRQ+cBmB/
 T1OVOLKNon+nbDAsfSR11ztIi8xU9O6ECq45tm4uQ9Y/GJEglZXEaaYeM2uXPHCs5hk+qq/7UeH
 56V+Y
X-Gm-Gg: AYBFou09Ohh6LIqk6vyB3yuJ6t/hkpzbgPRCnhPs55Fh0eVDGaFcWNq9R+NLiqXyiJx
 HwLwHuSfD097nR/x3yV+sLNvx97ooKuHXj0yiUV/PJawTs8UzP5/pMLlhiIEHGaOVY0NsDw8ncB
 ps++flkM7Xf4g+WIF+AM8efPVaC7niBXQTH2vkq9po/HHMWQQ6LAMMYkXAxzFlnRu+imY3QCABf
 XvUPUvbhrSb6AKKe9R6iSEbiNbgngbi6vGGQxAuQagWOIcD2Gja8n2tX/91c7BNcG/I2iXkR0yq
 i9a26KIHyrDNQofdZ7/GkJ9E7+nm0VGVhzK0PIWLYCxIndq6JP/gM3hhNJekDc4vvW7r6GcOux4
 QQsY1R/GLhBhtdAWe3jsbENHHigJcLwnkqiFYZYZVZ6wumJWQxGdldNo12KAh3v8F3G07AE92Ux
 Mr+NDDwFn/Pw47aUVyMeXbvMNCEkRNaA6Nd6JJM7VkPdovK1fUfuYPT69T6Gn5ihz5dQS1+Wkzb
 8eajEtsCRYYjcGt4R36/eaWMFMqSgjGg56RldEGAYvoWr4FII0H/aUhQvSL29OKDTmTD+pQkzmq
 VB6GAzcpYx5285MemA==
X-Received: by 2002:a05:600c:3554:b0:4a1:f7f4:7cf2 with SMTP id
 5b1f17b1804b1-4ac1737c474mr13341435e9.17.1793322393914; 
 Thu, 29 Oct 2026 18:06:33 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm210023f8f.32.2026.10.29.18.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:06:33 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v4 08/12] block/block-copy: rename
 block_copy_is_cluster_allocated()
Date: Fri, 30 Oct 2026 02:06:08 +0100
Message-ID: <20261030010613.1612771-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030010613.1612771-1-den@openvz.org>
References: <20261030010613.1612771-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

Since it started filling zero_bitmap, the function does more than its
name says: it is the scan's block-status query, reporting allocation and
recording zeroes. Rename it to block_copy_scan_status() and say so in
its comment. No behavior change.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/block-copy.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 4f128a0ebd..ad358f4d2f 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -708,13 +708,13 @@ static void block_copy_mark_zero_prefix(BlockCopyState *s, int64_t offset,
 }
 
 /*
- * Check if the cluster starting at offset is allocated or not.
- * return via pnum the number of contiguous clusters sharing this allocation.
- * Also marks the zero prefix of the range in zero_bitmap.
+ * One block-status query of the scan at @offset: return 1 if the cluster
+ * there is allocated, 0 if not, -errno on failure, and via @pnum the number
+ * of contiguous clusters sharing that allocation. Their zero prefix goes
+ * into zero_bitmap.
  */
 static int coroutine_fn GRAPH_RDLOCK
-block_copy_is_cluster_allocated(BlockCopyState *s, int64_t offset,
-                                int64_t *pnum)
+block_copy_scan_status(BlockCopyState *s, int64_t offset, int64_t *pnum)
 {
     BlockDriverState *bs = s->source->bs;
     BlockDriverState *base = block_copy_status_base(s);
@@ -793,7 +793,7 @@ int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
     int ret;
     int64_t clusters, bytes;
 
-    ret = block_copy_is_cluster_allocated(s, offset, &clusters);
+    ret = block_copy_scan_status(s, offset, &clusters);
     if (ret < 0) {
         return ret;
     }
@@ -837,7 +837,7 @@ block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
     if (*cached_end < dirty_end) {
         int64_t clusters;
         int64_t query_offset = MAX(dirty_offset, *cached_end);
-        int ret = block_copy_is_cluster_allocated(s, query_offset, &clusters);
+        int ret = block_copy_scan_status(s, query_offset, &clusters);
 
         if (ret >= 0) {
             *cached_end = query_offset + clusters * s->cluster_size;
-- 
2.53.0


