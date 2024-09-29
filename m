Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871CBCF6498
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 08:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1supOg-0006vK-RM; Sun, 29 Sep 2024 04:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1supOc-0006kO-MC
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 04:35:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1supOZ-0006Rp-Dk
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 04:35:14 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxrrM6Eflm370DAA--.4627S3;
 Sun, 29 Sep 2024 16:35:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn+QtEflmFt0UAA--.54891S3;
 Sun, 29 Sep 2024 16:35:05 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Bibo Mao <maobibo@loongson.cn>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 1/7] acpi: ged: Add macro for acpi sleep control register
Date: Sun, 29 Sep 2024 16:17:18 +0800
Message-Id: <20240929081724.2139556-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240929081724.2139556-1-gaosong@loongson.cn>
References: <20240929081724.2139556-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+QtEflmFt0UAA--.54891S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

Macro definition is added for acpi sleep control register, ged emulation
driver can use the macro , also it can be used in FDT table if ged is
exposed with FDT table.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240918014206.2165821-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/acpi/generic_event_device.c         | 6 +++---
 include/hw/acpi/generic_event_device.h | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 15b4c3ebbf..d00f5a6c1c 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -201,9 +201,9 @@ static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
 
     switch (addr) {
     case ACPI_GED_REG_SLEEP_CTL:
-        slp_typ = (data >> 2) & 0x07;
-        slp_en  = (data >> 5) & 0x01;
-        if (slp_en && slp_typ == 5) {
+        slp_typ = (data >> ACPI_GED_SLP_TYP_POS) & ACPI_GED_SLP_TYP_MASK;
+        slp_en  = !!(data & ACPI_GED_SLP_EN);
+        if (slp_en && slp_typ == ACPI_GED_SLP_TYP_S5) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         }
         return;
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index 40af3550b5..d2dac87b4a 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -81,8 +81,11 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 /* ACPI_GED_REG_RESET value for reset*/
 #define ACPI_GED_RESET_VALUE       0x42
 
-/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
-#define ACPI_GED_SLP_TYP_S5        0x05
+/* [ACPI 5.0 Chapter 4.8.3.7] Sleep Control and Status Register */
+#define ACPI_GED_SLP_TYP_POS       0x2   /* SLP_TYPx Bit Offset */
+#define ACPI_GED_SLP_TYP_MASK      0x07  /* SLP_TYPx 3-bit mask */
+#define ACPI_GED_SLP_TYP_S5        0x05  /* System _S5 State (Soft Off) */
+#define ACPI_GED_SLP_EN            0x20  /* SLP_EN write-only bit */
 
 #define GED_DEVICE      "GED"
 #define AML_GED_EVT_REG "EREG"
-- 
2.34.1


