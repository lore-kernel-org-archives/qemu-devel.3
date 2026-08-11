Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E42C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpMg-0007YD-92; Tue, 11 Aug 2026 12:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMQ-0007J3-QH
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMN-00008t-Ks
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pIqQSYB58oc33PnOv0dUVSft6f4EnubNjjoTzIOyGWA=;
 b=XZ9+8J3Lmrq80OdCJPttTFZ6zYva1/IXAgaQRuCVL5DZdqEyeGmAtmAIUjGLLTwtJgNId3
 bbQcFlv8V6Vf95YZWKlzHm0bL4hSo9YP40YCdhtT6eYvfeu/9kFfonn3TtYBpdnt4+Wp7o
 fUmL6mNOeSQgtFX8GYXAF0tPppUxvCY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-EkYf9WrMNr-6m30nCJ2BYA-1; Tue,
 11 Aug 2026 12:29:48 -0400
X-MC-Unique: EkYf9WrMNr-6m30nCJ2BYA-1
X-Mimecast-MFC-AGG-ID: EkYf9WrMNr-6m30nCJ2BYA_1786465787
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 815FB1956048; Tue, 11 Aug 2026 16:29:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3E36195DF96; Tue, 11 Aug 2026 16:29:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/83] hw/arm/aspeed: Add missing Kconfig dependencies on
 required components
Date: Tue, 11 Aug 2026 18:28:17 +0200
Message-ID: <20260811162938.1403216-3-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/arm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 00e2d9380332..6f5b2add66ed 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -551,6 +551,7 @@ config ASPEED_SOC
     select TMP105
     select TMP421
     select EMC141X
+    select OR_IRQ
     select UNIMP
     select LED
     select PMBUS
@@ -558,6 +559,8 @@ config ASPEED_SOC
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS_ASPEED
+    select USB_EHCI_SYSBUS
+    select SDHCI
 
 config MPS2
     bool
-- 
2.55.0


