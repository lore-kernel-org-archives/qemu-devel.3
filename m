Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75FDC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtII-0003Sn-ND; Mon, 17 Aug 2026 05:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtI4-0003JK-VL; Mon, 17 Aug 2026 05:05:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtI3-0001fW-9S; Mon, 17 Aug 2026 05:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=2MfVjECRTUh/WlOoJNXxdVH1zBCPmiyq2nGwwVTVlhI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wgaRZq188XtbfSIlp4cDsjOD/vpb1APLpLaVzRs1ilVpeee0DyNLDWJGHCAzaHYXA
 jWLLNuN5of4wKYwwBUMo1vXlmJqEZpF7KNGyoVJQl4Yczjhnbj/aE6jxQ0be29IlUU
 mYXxFbIxo3Okmavz/Ha40RT/hWZUeNcYJxyErgPUGAUQbPgb0x54wf4tYmTPQ3ulK9
 t+V6+dbLFCue0j86IuNv+aWzO7PARuai6Jo/lDOl1lZwAbIPiXunshCM3w/AGXdJpI
 kA0fcW5kLxbY7hcLZZTqxNRPgXGkf90U+Rc4RHNefO75kJXMHDKFhLEWGdBHpUDwdl
 GeZJj3N1tbu9w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 24F731CBA3D;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 04D2A40D01F;
 Mon, 17 Aug 2026 12:05:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B8B3630CF2; Mon, 17 Aug 2026 12:05:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 09/42] hw/arm/aspeed: Add missing PCI_EXPRESS ->
 PCIE_PORT Kconfig dependency
Date: Mon, 17 Aug 2026 12:04:14 +0300
Message-ID: <20260817090453.2034156-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Add the missing Kconfig dependency on PCIE_PORT to avoid the
following runtime error:

  Type 'aspeed.pcie-root-port' is missing its parent 'pcie-root-port-base'

No need to have ASPEED_SOC select PCI_EXPRESS since it is
already selected by PCI_EXPRESS_ASPEED.

Cc: qemu-stable@nongnu.org
Fixes: 2af56518fa9 ("hw/pci-host/aspeed: Add AST2600 PCIe Root Port and make address configurable")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260709164103.37614-2-philmd@oss.qualcomm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 2fad751ed6b14ef02b8c728b1b88c6c809f767d3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 82e0bc2e700..00e2d938033 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -557,7 +557,6 @@ config ASPEED_SOC
     select MAX31785
     select FSI_APB2OPB_ASPEED
     select AT24C
-    select PCI_EXPRESS
     select PCI_EXPRESS_ASPEED
 
 config MPS2
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 8cbb8304a3f..bda6e161f1c 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -49,6 +49,7 @@ config PCI_I440FX
 config PCI_EXPRESS_ASPEED
     bool
     select PCI_EXPRESS
+    select PCIE_PORT
 
 config PCI_EXPRESS_Q35
     bool
-- 
2.47.3


