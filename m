Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016C5109316E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 04:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3RiJ-0007p7-T6; Fri, 20 Mar 2026 00:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <long.yunjian@zte.com.cn>)
 id 1w3OVC-0000qq-HP; Thu, 19 Mar 2026 21:18:14 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <long.yunjian@zte.com.cn>)
 id 1w3OV9-0002dF-7n; Thu, 19 Mar 2026 21:18:14 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4fcPnd61Kjz501bF;
 Fri, 20 Mar 2026 09:17:57 +0800 (CST)
Received: from njy2app08.zte.com.cn ([10.40.13.206])
 by mse-fl2.zte.com.cn with SMTP id 62K1HjGH036236;
 Fri, 20 Mar 2026 09:17:45 +0800 (+08)
 (envelope-from long.yunjian@zte.com.cn)
Received: from mapi (njb2app07[null]) by mapi (Zmail) with MAPI id mid201;
 Fri, 20 Mar 2026 09:17:45 +0800 (CST)
X-Zmail-TransId: 2aff69bca039d48-c48a6
X-Mailer: Zmail v1.0
Message-ID: <20260320091745976o3u3XYI9SyVZ0siV2roHH@zte.com.cn>
Date: Fri, 20 Mar 2026 09:17:45 +0800 (CST)
Mime-Version: 1.0
From: <long.yunjian@zte.com.cn>
To: <kwolf@redhat.com>, <hreitz@redhat.com>
Cc: <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <mou.yi@zte.com.cn>,
 <liang.xianlong@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBibG9jazogZml4IGFubm90YXRpb24=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 62K1HjGH036236
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: long.yunjian@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 20 Mar 2026 09:17:57 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69BCA045.000/4fcPnd61Kjz501bF
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=long.yunjian@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:43:57 -0400
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

The bdrv_bsc_is_data function is defined in block_int-io.h,
so the correct annotation is block_int-io.h rather than block_int.h

Signed-off-by: Yunjian Long <long.yunjian@zte.com.cn>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 48a17f393c..3166114890 100644
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
-- 
2.27.0

