Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09705E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGS-0002rL-Sp; Thu, 19 Dec 2024 11:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1tOFr5-00028j-MB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:42:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1tOFr1-0006LE-M4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:42:14 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxSOGXFGRnCY5YAA--.41982S3;
 Thu, 19 Dec 2024 20:41:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxReSWFGRn2WUCAA--.15005S2;
 Thu, 19 Dec 2024 20:41:58 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: ghy <2247883756@qq.com>, Guo Hongyu <guohongyu24@mails.ucas.ac.cn>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH] target/loongarch: Fix vldi inst
Date: Thu, 19 Dec 2024 20:23:11 +0800
Message-Id: <20241219122311.3254940-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxReSWFGRn2WUCAA--.15005S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=no autolearn_force=no
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

From: ghy <2247883756@qq.com>

Refer to the link below for a description of the vldi instructions:
https://jia.je/unofficial-loongarch-intrinsics-guide/lsx/misc/#synopsis_88
Fixed errors in vldi instruction implementation.

Signed-off-by: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Hongyu Guo <guohongyu24@mails.ucas.ac.cn>
Cc: Song Gao <gaosong@loongson.cn>
Cc: Xianglai Li <lixianglai@loongson.cn>

 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index 92b1d22e28..d317dfcc1c 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -3480,7 +3480,7 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
         break;
     case 1:
         /* data: {2{16'0, imm[7:0], 8'0}} */
-        data = (t << 24) | (t << 8);
+        data = (t << 40) | (t << 8);
         break;
     case 2:
         /* data: {2{8'0, imm[7:0], 16'0}} */
-- 
2.39.1


