Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BB6C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuqK-0001DJ-Qw; Mon, 17 Aug 2026 06:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuq9-00014t-S1; Mon, 17 Aug 2026 06:45:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuq8-0003x4-3i; Mon, 17 Aug 2026 06:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=+6eKVzWfpYp6DQEI60ZuROXxrpWceMO0k7TzOkGPscY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RnBZPEB4yuDYdRpGOjEOpnyLYuD3VyOk4R8F4UZeaNkVoxjrfJRRQOY8P+5Slii+z
 7GDjneE81vhdKu/3NKNUJ+PiCdZUIC50NHn9ETWfkKz64EB2bonSwGABVHPnsn+0Tg
 J9NgeDowRqPT0fYV66cYShpI7+CN+TL3DoUCifvxesYsaNt5XDV7Q0+XpwFRvIlKLm
 cC5Dy1FDIN9JE7llE5KBwvbyHhvhvDO7ataVnswLajybmtW6rCx1ZxO8HEXo1wq1lT
 A1b5fmYVp1bXmChTDu69W11Xop2zrt7A1EnIEefLuZVQZxuGGgj5gulby7EnHwt4MW
 4dyf6rG4O7ldg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 52F251CBB68;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 549CA40D1F6;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E86FD30E48; Mon, 17 Aug 2026 13:44:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 123/161] hw/arm/aspeed: Add missing Kconfig
 dependencies on required components
Date: Mon, 17 Aug 2026 13:42:37 +0300
Message-ID: <20260817104344.2047346-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
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

Add various missing Kconfig dependencies of the Aspeed SoCs:

- USB EHCI (commit bfdd34f1caa "hw/arm: ast2400/ast2500: Wire up
  EHCI controllers")
- OR-IRQ (commit d831c5fd868 "aspeed/intc: Add AST2700 support")
- SDHCI (commit 2bea128c3d0 "hw/sd/aspeed_sdhci: New device"
  and f25c0ae1079 "aspeed/soc: Add AST2600 support")

This fixes the following runtime issues:

  qemu-system-aarch64: unknown type 'platform-ehci-usb'
  qemu-system-aarch64: unknown type 'or-irq'
  qemu-system-aarch64: unknown type 'generic-sdhci'

Cc: qemu-stable@nongnu.org
Fixes: 2bea128c3d0 ("hw/sd/aspeed_sdhci: New device")
Fixes: f25c0ae1079 ("aspeed/soc: Add AST2600 support")
Fixes: d831c5fd868 ("aspeed/intc: Add AST2700 support")
Fixes: bfdd34f1caa ("hw/arm: ast2400/ast2500: Wire up EHCI controllers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260709164103.37614-3-philmd@oss.qualcomm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 6440880ed371f74b3019462acfb2cd7709372db7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e3331563f19..a4ecc77c74a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -548,6 +548,7 @@ config ASPEED_SOC
     select TMP105
     select TMP421
     select EMC141X
+    select OR_IRQ
     select UNIMP
     select LED
     select PMBUS
@@ -555,6 +556,8 @@ config ASPEED_SOC
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS_ASPEED
+    select USB_EHCI_SYSBUS
+    select SDHCI
 
 config MPS2
     bool
-- 
2.47.3


