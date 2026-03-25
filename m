Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B261093168
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 01:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5DGP-0005K4-77; Tue, 24 Mar 2026 21:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <long.yunjian@zte.com.cn>)
 id 1w5DGL-0005Jd-7o; Tue, 24 Mar 2026 21:42:25 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <long.yunjian@zte.com.cn>)
 id 1w5DGH-0000K2-Em; Tue, 24 Mar 2026 21:42:23 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fgV5G3N4dz7QYRQ;
 Wed, 25 Mar 2026 09:42:10 +0800 (CST)
Received: from njy2app03.zte.com.cn ([10.40.13.14])
 by mse-fl2.zte.com.cn with SMTP id 62P1g3U8023579;
 Wed, 25 Mar 2026 09:42:03 +0800 (+08)
 (envelope-from long.yunjian@zte.com.cn)
Received: from mapi (njy2app01[null]) by mapi (Zmail) with MAPI id mid201;
 Wed, 25 Mar 2026 09:42:04 +0800 (CST)
X-Zmail-TransId: 2af969c33d6c400-ed151
X-Mailer: Zmail v1.0
Message-ID: <20260325094204300GFCZYBzAE00cSWaldbDcT@zte.com.cn>
Date: Wed, 25 Mar 2026 09:42:04 +0800 (CST)
Mime-Version: 1.0
From: <long.yunjian@zte.com.cn>
To: <kwolf@redhat.com>, <hreitz@redhat.com>
Cc: <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <mou.yi@zte.com.cn>,
 <liang.xianlong@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBibG9jazogZml4IGFubm90YXRpb24=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 62P1g3U8023579
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: long.yunjian@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 25 Mar 2026 09:42:10 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69C33D72.002/4fgV5G3N4dz7QYRQ
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=long.yunjian@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Yunjian Long <long.yunjian@zte.com.cn>

Some functions are defined in block_int-io.h, so the correct
annotation is block_int-io.h rather than block_int.h

Signed-off-by: Yunjian Long <long.yunjian@zte.com.cn>
---
v1 -> v2
fix all the same annotation problem.

 block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 48a17f393c..f0a6042e61 100644
--- a/block.c
+++ b/block.c
@@ -8477,7 +8477,7 @@ static bool bdrv_bsc_range_overlaps_locked(BlockDriverState *bs,
 }

 /**
- * See block_int.h for this function's documentation.
+ * See block_int-io.h for this function's documentation.
  */
 bool bdrv_bsc_is_data(BlockDriverState *bs, int64_t offset, int64_t *pnum)
 {
@@ -8487,7 +8487,7 @@ bool bdrv_bsc_is_data(BlockDriverState *bs, int64_t offset, int64_t *pnum)
 }

 /**
- * See block_int.h for this function's documentation.
+ * See block_int-io.h for this function's documentation.
  */
 void bdrv_bsc_invalidate_range(BlockDriverState *bs,
                                int64_t offset, int64_t bytes)
@@ -8501,7 +8501,7 @@ void bdrv_bsc_invalidate_range(BlockDriverState *bs,
 }

 /**
- * See block_int.h for this function's documentation.
+ * See block_int-io.h for this function's documentation.
  */
 void bdrv_bsc_fill(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
-- 
2.27.0

