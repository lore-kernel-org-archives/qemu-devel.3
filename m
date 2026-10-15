Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF63CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKTR-0005Oj-6c; Thu, 15 Oct 2026 08:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTO-00058m-71
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTM-0005ZZ-6Y
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARFFXC2/ymVhZH3WtCkVYfkqKj6V6tiDGlg5gQ88kqU=;
 b=QpSL/51+YK2not95kvnvk9v3f6tdqRToGfr45iygZRiNodIFOwm8p/73fEJpSX5VtJJf0F
 F9PePzlRj4wT4TY4xkBe0sfkyou2NFHfVxsW22FI8g5UHpKqDBSfpAUCw4uZP3yIITsx+B
 sX03l2UFKHTvWrceC5Gxj3gKCXX9hm4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-6kj69M9XPBueJhI7ItblLA-1; Thu,
 15 Oct 2026 12:22:08 +0000
X-MC-Unique: 6kj69M9XPBueJhI7ItblLA-1
X-Mimecast-MFC-AGG-ID: 6kj69M9XPBueJhI7ItblLA_1792066927
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12E221801352; Thu, 15 Oct 2026 12:22:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A374A7D8; Thu, 15 Oct 2026 12:22:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/21] hw/arm/aspeed: Sort device IDs alphabetically
Date: Thu, 15 Oct 2026 14:21:36 +0200
Message-ID: <20261015122151.889017-7-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The ASPEED device ID enum has grown over time without a consistent
ordering rule. This makes it difficult to determine where new device
IDs should be added and reduces readability and maintainability as
more devices are introduced.

Sort the device IDs alphabetically to provide a consistent ordering
rule. Keep related numbered devices together, such as SPI0, SPI1 and
SPI2.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261005020428.3496039-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h | 176 ++++++++++++++++++------------------
 1 file changed, 88 insertions(+), 88 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 38226d9b8049..a11038574338 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -195,64 +195,56 @@ struct AspeedSoCClass {
 };
 
 enum {
-    ASPEED_DEV_VBOOTROM,
-    ASPEED_DEV_SPI_BOOT,
-    ASPEED_DEV_IOMEM,
-    ASPEED_DEV_IOMEM0,
-    ASPEED_DEV_IOMEM1,
-    ASPEED_DEV_UART0,
-    ASPEED_DEV_UART1,
-    ASPEED_DEV_UART2,
-    ASPEED_DEV_UART3,
-    ASPEED_DEV_UART4,
-    ASPEED_DEV_UART5,
-    ASPEED_DEV_UART6,
-    ASPEED_DEV_UART7,
-    ASPEED_DEV_UART8,
-    ASPEED_DEV_UART9,
-    ASPEED_DEV_UART10,
-    ASPEED_DEV_UART11,
-    ASPEED_DEV_UART12,
-    ASPEED_DEV_UART13,
-    ASPEED_DEV_VUART,
-    ASPEED_DEV_FMC,
-    ASPEED_DEV_SPI0,
-    ASPEED_DEV_SPI1,
-    ASPEED_DEV_SPI2,
+    ASPEED_DEV_ACRY,
+    ASPEED_DEV_ADC,
+    ASPEED_DEV_DP,
+    ASPEED_DEV_DPMCU,
     ASPEED_DEV_EHCI1,
     ASPEED_DEV_EHCI2,
     ASPEED_DEV_EHCI3,
     ASPEED_DEV_EHCI4,
-    ASPEED_DEV_VIC,
-    ASPEED_DEV_INTC,
-    ASPEED_DEV_INTCIO,
-    ASPEED_DEV_SDMC,
-    ASPEED_DEV_SCU,
-    ASPEED_DEV_ADC,
-    ASPEED_DEV_SBC,
+    ASPEED_DEV_EMMC,
     ASPEED_DEV_EMMC_BC,
-    ASPEED_DEV_VIDEO,
-    ASPEED_DEV_SRAM0,
-    ASPEED_DEV_SRAM1,
-    ASPEED_DEV_SDHCI,
+    ASPEED_DEV_ESPI,
+    ASPEED_DEV_ETH1,
+    ASPEED_DEV_ETH2,
+    ASPEED_DEV_ETH3,
+    ASPEED_DEV_ETH4,
+    ASPEED_DEV_FMC,
+    ASPEED_DEV_FSI1,
+    ASPEED_DEV_FSI2,
     ASPEED_DEV_GPIO,
     ASPEED_DEV_GPIO_1_8V,
-    ASPEED_DEV_SGPIOM0,
-    ASPEED_DEV_SGPIOM1,
-    ASPEED_DEV_RTC,
-    ASPEED_DEV_TIMER1,
-    ASPEED_DEV_TIMER2,
-    ASPEED_DEV_TIMER3,
-    ASPEED_DEV_TIMER4,
-    ASPEED_DEV_TIMER5,
-    ASPEED_DEV_TIMER6,
-    ASPEED_DEV_TIMER7,
-    ASPEED_DEV_TIMER8,
-    ASPEED_DEV_WDT,
-    ASPEED_DEV_PWM,
-    ASPEED_DEV_LPC,
-    ASPEED_DEV_IBT,
+    ASPEED_DEV_HACE,
     ASPEED_DEV_I2C,
+    ASPEED_DEV_I3C,
+    ASPEED_DEV_IBT,
+    ASPEED_DEV_INTC,
+    ASPEED_DEV_INTCIO,
+    ASPEED_DEV_IOMEM,
+    ASPEED_DEV_IOMEM0,
+    ASPEED_DEV_IOMEM1,
+    ASPEED_DEV_IOEXP0_I2C,
+    ASPEED_DEV_IOEXP1_I2C,
+    ASPEED_DEV_IOEXP0_I3C,
+    ASPEED_DEV_IOEXP1_I3C,
+    ASPEED_DEV_IOEXP0_INTCIO,
+    ASPEED_DEV_IOEXP1_INTCIO,
+    ASPEED_DEV_IPC0,
+    ASPEED_DEV_IPC1,
+    ASPEED_DEV_JTAG0,
+    ASPEED_DEV_JTAG1,
+    ASPEED_DEV_KCS,
+    ASPEED_DEV_LPC,
+    ASPEED_DEV_LTPI_CTRL1,
+    ASPEED_DEV_LTPI_CTRL2,
+    ASPEED_DEV_LTPI_IO0,
+    ASPEED_DEV_LTPI_IO1,
+    ASPEED_DEV_MII1,
+    ASPEED_DEV_MII2,
+    ASPEED_DEV_MII3,
+    ASPEED_DEV_MII4,
+    ASPEED_DEV_OTP,
     ASPEED_DEV_PCIE0,
     ASPEED_DEV_PCIE1,
     ASPEED_DEV_PCIE2,
@@ -263,49 +255,57 @@ enum {
     ASPEED_DEV_PCIE_MMIO1,
     ASPEED_DEV_PCIE_MMIO2,
     ASPEED_DEV_PECI,
-    ASPEED_DEV_ETH1,
-    ASPEED_DEV_ETH2,
-    ASPEED_DEV_ETH3,
-    ASPEED_DEV_ETH4,
-    ASPEED_DEV_MII1,
-    ASPEED_DEV_MII2,
-    ASPEED_DEV_MII3,
-    ASPEED_DEV_MII4,
-    ASPEED_DEV_SDRAM,
-    ASPEED_DEV_XDMA,
-    ASPEED_DEV_EMMC,
-    ASPEED_DEV_KCS,
-    ASPEED_DEV_HACE,
-    ASPEED_DEV_ACRY,
-    ASPEED_DEV_DPMCU,
-    ASPEED_DEV_DP,
-    ASPEED_DEV_I3C,
-    ASPEED_DEV_ESPI,
-    ASPEED_DEV_UDC,
-    ASPEED_DEV_JTAG0,
-    ASPEED_DEV_JTAG1,
-    ASPEED_DEV_FSI1,
-    ASPEED_DEV_FSI2,
+    ASPEED_DEV_PRIC0,
+    ASPEED_DEV_PRIC1,
+    ASPEED_DEV_PWM,
+    ASPEED_DEV_RTC,
+    ASPEED_DEV_SBC,
+    ASPEED_DEV_SCU,
     ASPEED_DEV_SCUIO,
+    ASPEED_DEV_SDHCI,
+    ASPEED_DEV_SDMC,
+    ASPEED_DEV_SDRAM,
+    ASPEED_DEV_SGPIOM0,
+    ASPEED_DEV_SGPIOM1,
     ASPEED_DEV_SLI,
     ASPEED_DEV_SLIIO,
+    ASPEED_DEV_SPI_BOOT,
+    ASPEED_DEV_SPI0,
+    ASPEED_DEV_SPI1,
+    ASPEED_DEV_SPI2,
+    ASPEED_DEV_SRAM0,
+    ASPEED_DEV_SRAM1,
+    ASPEED_DEV_TIMER1,
+    ASPEED_DEV_TIMER2,
+    ASPEED_DEV_TIMER3,
+    ASPEED_DEV_TIMER4,
+    ASPEED_DEV_TIMER5,
+    ASPEED_DEV_TIMER6,
+    ASPEED_DEV_TIMER7,
+    ASPEED_DEV_TIMER8,
+    ASPEED_DEV_UART0,
+    ASPEED_DEV_UART1,
+    ASPEED_DEV_UART2,
+    ASPEED_DEV_UART3,
+    ASPEED_DEV_UART4,
+    ASPEED_DEV_UART5,
+    ASPEED_DEV_UART6,
+    ASPEED_DEV_UART7,
+    ASPEED_DEV_UART8,
+    ASPEED_DEV_UART9,
+    ASPEED_DEV_UART10,
+    ASPEED_DEV_UART11,
+    ASPEED_DEV_UART12,
+    ASPEED_DEV_UART13,
+    ASPEED_DEV_UDC,
+    ASPEED_DEV_VBOOTROM,
+    ASPEED_DEV_VIC,
+    ASPEED_DEV_VIDEO,
+    ASPEED_DEV_VUART,
+    ASPEED_DEV_WDT,
+    ASPEED_DEV_XDMA,
     ASPEED_GIC_DIST,
     ASPEED_GIC_REDIST,
-    ASPEED_DEV_IPC0,
-    ASPEED_DEV_IPC1,
-    ASPEED_DEV_LTPI_CTRL1,
-    ASPEED_DEV_LTPI_CTRL2,
-    ASPEED_DEV_LTPI_IO0,
-    ASPEED_DEV_LTPI_IO1,
-    ASPEED_DEV_IOEXP0_I2C,
-    ASPEED_DEV_IOEXP1_I2C,
-    ASPEED_DEV_IOEXP0_INTCIO,
-    ASPEED_DEV_IOEXP1_INTCIO,
-    ASPEED_DEV_IOEXP0_I3C,
-    ASPEED_DEV_IOEXP1_I3C,
-    ASPEED_DEV_PRIC0,
-    ASPEED_DEV_PRIC1,
-    ASPEED_DEV_OTP,
 };
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
-- 
2.56.0


