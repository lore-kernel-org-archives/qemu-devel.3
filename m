Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C375FC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6uS-0004su-H3; Thu, 05 Jun 2025 05:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uN6uI-0004lV-FY
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:29:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uN6uC-0003PU-1V
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:29:05 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axx2lRY0FoV60MAQ--.2772S3;
 Thu, 05 Jun 2025 17:28:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPsdQY0Fo2CsLAQ--.39205S2;
 Thu, 05 Jun 2025 17:28:48 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/intc/loongarch_extioi: Fix typo issue about register
 EXTIOI_COREISR_END
Date: Thu,  5 Jun 2025 17:28:48 +0800
Message-Id: <20250605092848.1550985-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPsdQY0Fo2CsLAQ--.39205S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Interrupt controller extioi supports 256 vectors, register EXTIOI_COREISR
records pending interrupt status with bitmap method. Size of EXTIOI_COREISR
is 256 / 8 = 0x20 bytes, EXTIOI_COREISR_END should be EXTIOI_COREISR_START
+ 0x20 rather than 0xB20.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 include/hw/intc/loongarch_extioi_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
index 735bfee80a..dca25ff893 100644
--- a/include/hw/intc/loongarch_extioi_common.h
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -35,7 +35,7 @@
 #define EXTIOI_ISR_START             (0x700 - APIC_OFFSET)
 #define EXTIOI_ISR_END               (0x720 - APIC_OFFSET)
 #define EXTIOI_COREISR_START         (0x800 - APIC_OFFSET)
-#define EXTIOI_COREISR_END           (0xB20 - APIC_OFFSET)
+#define EXTIOI_COREISR_END           (0x820 - APIC_OFFSET)
 #define EXTIOI_COREMAP_START         (0xC00 - APIC_OFFSET)
 #define EXTIOI_COREMAP_END           (0xD00 - APIC_OFFSET)
 #define EXTIOI_SIZE                  0x800

base-commit: 09be8a511a2e278b45729d7b065d30c68dd699d0
-- 
2.39.3


