Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC8FC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpMi-0007aq-3F; Tue, 11 Aug 2026 12:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMO-0007Iq-SQ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpML-00008W-HN
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNJGSNkdEJpgxsyLOLzM+JuqpupmlqCZ0lP1YU/TPHY=;
 b=ZtybrkPwzTkIydQN1H58ZG3FoKKhI3tvn/J4DvPrDapVwHsUh3ZYwDUgFVa8eTjDTMN/G6
 Vb/5Y0PS6/JjllTOCsYlmEtectDNNggTvd4N5FmrFOOBrqrFqU7vcXFKNz1reWaNHdktwO
 LjtjatlR+R/Xgz8ssBM2+RpRJ5QD+yU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-Lr8fNE_xMfap0i_DO-zcxg-1; Tue,
 11 Aug 2026 12:29:46 -0400
X-MC-Unique: Lr8fNE_xMfap0i_DO-zcxg-1
X-Mimecast-MFC-AGG-ID: Lr8fNE_xMfap0i_DO-zcxg_1786465785
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 443A918002E8; Tue, 11 Aug 2026 16:29:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D504195DF91; Tue, 11 Aug 2026 16:29:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/83] hw/arm/aspeed: Add missing PCI_EXPRESS -> PCIE_PORT
 Kconfig dependency
Date: Tue, 11 Aug 2026 18:28:16 +0200
Message-ID: <20260811162938.1403216-2-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
---
 hw/arm/Kconfig      | 1 -
 hw/pci-host/Kconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 82e0bc2e7004..00e2d9380332 100644
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
index 8cbb8304a3ff..bda6e161f1c8 100644
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
2.55.0


