Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F372C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 09:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttNbx-0002sW-K9; Sat, 15 Mar 2025 05:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttNbs-0002n3-AF; Sat, 15 Mar 2025 05:15:13 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttNbo-0007xk-GI; Sat, 15 Mar 2025 05:15:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C67A9FFBBB;
 Sat, 15 Mar 2025 12:13:45 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CEE9D1CAD54;
 Sat, 15 Mar 2025 12:14:39 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AAA3255A3E; Sat, 15 Mar 2025 12:14:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.17 10/27] Kconfig: Extract CONFIG_USB_CHIPIDEA from
 CONFIG_IMX
Date: Sat, 15 Mar 2025 12:14:21 +0300
Message-Id: <20250315091439.657371-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.17-20250315101625@cover.tls.msk.ru>
References: <qemu-stable-7.2.17-20250315101625@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Bernhard Beschow <shentey@gmail.com>

TYPE_CHIPIDEA models an IP block which is also used in TYPE_ZYNQ_MACHINE which
itself is not an IMX device. CONFIG_ZYNQ selects CONFIG_USB_EHCI_SYSBUS while
TYPE_CHIPIDEA is a separate compilation unit, so only works by accident if
CONFIG_IMX is given. Fix that by extracting CONFIG_USB_CHIPIDEA from CONFIG_IMX.

cc: qemu-stable@nongnu.org
Fixes: 616ec12d0fcc "hw/arm/xilinx_zynq: Fix USB port instantiation"
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250209103604.29545-1-shentey@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 464ce71a963b3dfc290cd59c3d1bfedf11c004df)
(Mjt: context fixup due to missing
 v8.0.0-1939-gde6cd7599b51 "meson: Replace softmmu_ss -> system_ss",
 v9.1.0-609-ge02491903d50 "hw/usb: Remove tusb6010 USB controller",
 v9.2.0-1303-g1b326f278d05 "hw/pci-host/designware: Expose MSI IRQ")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 17fcde8e1c..837d0c5d41 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -300,7 +300,7 @@ config ZYNQ
     select PL330
     select SDHCI
     select SSI_M25P80
-    select USB_EHCI_SYSBUS
+    select USB_CHIPIDEA
     select XILINX # UART
     select XILINX_AXI
     select XILINX_SPI
@@ -416,6 +416,7 @@ config FSL_IMX25
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
 
@@ -438,6 +439,7 @@ config FSL_IMX6
     select IMX_USBPHY
     select WDT_IMX2
     select SDHCI
+    select USB_CHIPIDEA
 
 config ASPEED_SOC
     bool
@@ -488,6 +490,7 @@ config FSL_IMX7
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
     select UNIMP
+    select USB_CHIPIDEA
 
 config ARM_SMMUV3
     bool
@@ -501,6 +504,7 @@ config FSL_IMX6UL
     select IMX_I2C
     select WDT_IMX2
     select SDHCI
+    select USB_CHIPIDEA
     select UNIMP
 
 config MICROBIT
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index ce4f433976..db17750a64 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -138,3 +138,7 @@ config XLNX_USB_SUBSYS
     bool
     default y if XLNX_VERSAL
     select USB_DWC3
+
+config USB_CHIPIDEA
+    bool
+    select USB_EHCI_SYSBUS
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 793df42e21..ed5d0ad7e5 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -25,9 +25,9 @@ softmmu_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
 softmmu_ss.add(when: 'CONFIG_USB_MUSB', if_true: files('hcd-musb.c'))
 softmmu_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
 softmmu_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))
+softmmu_ss.add(when: 'CONFIG_USB_CHIPIDEA', if_true: files('chipidea.c'))
 
 softmmu_ss.add(when: 'CONFIG_TUSB6010', if_true: files('tusb6010.c'))
-softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('chipidea.c'))
 softmmu_ss.add(when: 'CONFIG_IMX_USBPHY', if_true: files('imx-usb-phy.c'))
 softmmu_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686-uhci-pci.c'))
 specific_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-usb2-ctrl-regs.c'))
-- 
2.39.5


