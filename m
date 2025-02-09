Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C532DC02199
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 10:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1th4fj-0008DL-AU; Sun, 09 Feb 2025 05:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1th4fh-0008D3-WC; Sun, 09 Feb 2025 05:36:18 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1th4ff-0006uA-Tk; Sun, 09 Feb 2025 05:36:17 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38dd93a6f0aso385460f8f.0; 
 Sun, 09 Feb 2025 02:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739097373; x=1739702173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MYsdbMV3jgmw6Y96Lc6iJvpdy36kIPdKE3AGeizboVc=;
 b=bvI9I7YfCBTx98DecI/XNVhqmMvJxFe7ilVdMBNJgHoaelThtZ0Z9ovc/IEmTptfXu
 JeZHFxddGfAbd0+5qT6Pw2qnvQSvTjTHj7jNWmgWtU9kH+kzXwCPNTDr556nCOT/aMIG
 m7EynRdcAYKjypVoegQ821b3X40AZZpyBeE12R1iSU1L9TAOX+HNchPJcViaKBJLD55q
 Cv3kWUsm3qPBzJiFxqLlRiZWRNmtzkAn9DhsAJ+DbqsR0PLQ0j0gko96/jTtqeaQ5xZu
 CG0ekuW7yHgUMXY/pWXq08y1ZFa9BHKxyKtv6SKLVPxVyWyCcbQHLkmFSCV9cZReoUuk
 RuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739097373; x=1739702173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MYsdbMV3jgmw6Y96Lc6iJvpdy36kIPdKE3AGeizboVc=;
 b=DW3cpRWnuRpDB74OFPPll7aXqOABy/YMemOsEcMRn8/yqJ6Y3losFJ+5sHb+LM137N
 HkoYXmzZQIM9i0zCKFWoV/bBf/SA+cvJkPRLaMfYBwnJGCYiNZpS6UjzJqp0onaFW6sE
 gTe1Y2wvdFe+0mDn0vbSz8qRKUcm8vgC33U6v6U8ZB2utr3SQR7EBW8zPu1elA/D1Nrj
 BCx/TYizwvZgdTOEONVlu4UJg1oTypv3XA/dvnPJjoK395mslGvKoN7w++8Yq/Pagkp4
 W5NbuYkALbag3oTDmxOhzn8OzN8lKktr+J2KILf8ytfsBvNYKGYg8zYU7GGmHNHY8LWD
 mBug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxbIRCvpCCOyEfopt6GCEaK874liph8c5b4/bPZyLDjPHnByTHtQKZL1mgT70R4IO0oDp41F0f0g==@nongnu.org
X-Gm-Message-State: AOJu0Yx7TwJyMgtmLNWJf/7IJgIOFKQ7SRrefEyutPeJLX8Lna4Bj0zn
 2/c5mmye9jopsvRp+u9Oi6pOhFqnwTYv/f2MriiF9iS9DOES62NgSZfiTQ==
X-Gm-Gg: ASbGncu59WWC+FIShU+H2thI8a+KpWbfb78nDFTWImzj03qJ+HoIEFrHPxYq/Fnx5No
 57GlIEw34cSibHPg5PY/oJD4asw4mlEoouVCmBCdn84kHmgeyaZ6V/MZkJu/5Sef5l1nkRcmO+/
 z+oWWB3D2806IVliLw04Gd+GUM/zcrFl5uBwnfdnRwbRx5qCzXa83wBxOCT22QKC4mRg6ZviCR6
 LJ8kbVmXkklHMGP4Dfi3I3BP0z2R1syhGEBPMN9V4mvzNA9EbeaZ/UUfXQik476luuUCXIGGlzz
 JSW9Nxmhdq/GpSqGaftEPJnN5uF0brchwUMPJNHqlIrZEcO661WH0m6mZGEnJz6m16p6kHY2aLK
 h1McCVFxIVg==
X-Google-Smtp-Source: AGHT+IH2Jc2Nv3qyLJbkvxelK5ZhZCDwZdaj4HxuKPEN/3eyLT2HG7tSF4u7IKMBF3oeOFicW8sX1A==
X-Received: by 2002:a5d:5889:0:b0:38a:888c:a727 with SMTP id
 ffacd0b85a97d-38dc90ee376mr7409938f8f.25.1739097372567; 
 Sun, 09 Feb 2025 02:36:12 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcd34a39esm6152744f8f.30.2025.02.09.02.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 02:36:11 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX
Date: Sun,  9 Feb 2025 11:36:04 +0100
Message-ID: <20250209103604.29545-1-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

TYPE_CHIPIDEA models an IP block which is also used in TYPE_ZYNQ_MACHINE which
itself is not an IMX device. CONFIG_ZYNQ selects CONFIG_USB_EHCI_SYSBUS while
TYPE_CHIPIDEA is a separate compilation unit, so only works by accident if
CONFIG_IMX is given. Fix that by extracting CONFIG_USB_CHIPIDEA from CONFIG_IMX.

Fixes: 616ec12d0fcc "hw/arm/xilinx_zynq: Fix USB port instantiation"
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
cc: qemu-stable
---
 hw/arm/Kconfig     | 6 +++++-
 hw/usb/Kconfig     | 4 ++++
 hw/usb/meson.build | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 256013ca80..7eab3914d4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -303,7 +303,7 @@ config ZYNQ
     select PL330
     select SDHCI
     select SSI_M25P80
-    select USB_EHCI_SYSBUS
+    select USB_CHIPIDEA
     select XILINX # UART
     select XILINX_AXI
     select XILINX_SPI
@@ -489,6 +489,7 @@ config FSL_IMX25
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
 
@@ -516,6 +517,7 @@ config FSL_IMX6
     select PL310  # cache controller
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
+    select USB_CHIPIDEA
     select OR_IRQ
 
 config ASPEED_SOC
@@ -576,6 +578,7 @@ config FSL_IMX7
     select SDHCI
     select OR_IRQ
     select UNIMP
+    select USB_CHIPIDEA
 
 config ARM_SMMUV3
     bool
@@ -591,6 +594,7 @@ config FSL_IMX6UL
     select IMX_I2C
     select WDT_IMX2
     select SDHCI
+    select USB_CHIPIDEA
     select UNIMP
 
 config MICROBIT
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 5fbecd2f43..69c663be52 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -143,3 +143,7 @@ config USB_DWC3
 config XLNX_USB_SUBSYS
     bool
     select USB_DWC3
+
+config USB_CHIPIDEA
+    bool
+    select USB_EHCI_SYSBUS
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 1b4d1507e4..17360a5b5a 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -25,8 +25,8 @@ system_ss.add(when: 'CONFIG_USB_XHCI_SYSBUS', if_true: files('hcd-xhci-sysbus.c'
 system_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
 system_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
 system_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))
+system_ss.add(when: 'CONFIG_USB_CHIPIDEA', if_true: files('chipidea.c'))
 
-system_ss.add(when: 'CONFIG_IMX', if_true: files('chipidea.c'))
 system_ss.add(when: 'CONFIG_IMX_USBPHY', if_true: files('imx-usb-phy.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686-uhci-pci.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-usb2-ctrl-regs.c'))
-- 
2.48.1


