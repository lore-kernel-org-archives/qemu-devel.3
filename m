Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D169C55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrsrI-00054L-Pw; Thu, 06 Aug 2026 03:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yang.yanjun1@sanechips.com.cn>)
 id 1wrsrF-00053X-43; Thu, 06 Aug 2026 03:49:41 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yang.yanjun1@sanechips.com.cn>)
 id 1wrsrB-0002v8-Iu; Thu, 06 Aug 2026 03:49:40 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4hFzv809Rfz57KTq;
 Thu, 06 Aug 2026 15:49:24 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 6767nOjv097972;
 Thu, 6 Aug 2026 15:49:24 +0800 (+08)
 (envelope-from yang.yanjun1@sanechips.com.cn)
Message-Id: <202608060749.6767nOjv097972@mse-fl2.zte.com.cn>
Received: from njy2app04.zte.com.cn ([10.40.12.64])
 by mse-fl1.zte.com.cn with SMTP id 6767laWw060418;
 Thu, 6 Aug 2026 15:47:36 +0800 (+08)
 (envelope-from yang.yanjun1@sanechips.com.cn)
Received: from mapi (njb2app06[null]) by mapi (Zmail) with MAPI id mid202;
 Thu, 6 Aug 2026 15:47:38 +0800 (CST)
X-Zmail-TransId: 2afe6a743c1ac91-75b1d
X-Mailer: Zmail v1.0
Date: Thu, 6 Aug 2026 15:47:38 +0800 (CST)
Mime-Version: 1.0
From: <yang.yanjun1@sanechips.com.cn>
To: <qemu-devel@nongnu.org>
Cc: <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <qemu-arm@nongnu.org>
Subject: =?UTF-8?B?wqBbUEFUQ0hdIHRhcmdldC9hcm06IEZpeCBTVkUyIFdISUxFV1IvV0hJTEVSVyB6ZXJvIGRpZmYgYm91bmRhcnkgY2FzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6767nOjv097972
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: yang.yanjun1@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 06 Aug 2026 15:49:24 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A743C84.000/4hFzv809Rfz57KTq
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=yang.yanjun1@sanechips.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: YanjunYang <yang.yanjun1@sanechips.com.cn>

The trans_WHILE_ptr function incorrectly handles the case where the
address difference divided by ESIZE results in zero. This happens when
the address difference is less than ESIZE but greater than zero.

In this boundary case, the address difference is less than ESIZE, which
means all elements are safe from conflicts. The previous code would set
the predicate to all zeros, but the correct behavior is to set all
elements to one.

Fix by checking if diff == 0 after the shift and setting diff to tmax
(all elements true) in this case.

Fixes the following test cases:
  whilewr p0.s, x9, x10  ; x9=8, x10=11 => p0=0xffffffff (all ones)
  whilerw p0.s, x9, x10  ; x9=8, x10=11 => p0=0xffffffff (all ones)

Signed-off-by: YanjunYang <yang.yanjun1@sanechips.com.cn>
---
 target/arm/tcg/translate-sve.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index fc4cc8c479..33613ebf58 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3736,6 +3736,10 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
         tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
     }

+    /* If diff == 0, the address difference is less than ESIZE,
+       so all elements are safe from conflicts. */
+    tcg_gen_movcond_i64(TCG_COND_EQ, diff, diff, tcg_constant_i64(0), tmax, diff);
+
     /* Bound to the maximum.  */
     tcg_gen_umin_i64(diff, diff, tmax);

-- 
2.43.0

