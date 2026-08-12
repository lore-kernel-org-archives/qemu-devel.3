Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21008C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAJq-0006BF-TA; Wed, 12 Aug 2026 10:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIS-0004VD-AU; Wed, 12 Aug 2026 10:51:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIQ-0006kr-NC; Wed, 12 Aug 2026 10:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546230; bh=bY9IVMqDDTDcjh9m1WOUBSt+BW1Vu6vLDoWlKaRCays=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ke6PgPuJ5HnVVD1gCY/hnTDwylNqrP7hRh7xXuiUm4KJ637xl0vlGC+uKupAbnUD0
 zk8Iek16Zmx95hcSvMqedarZzrZJJgmq2iHUSnifwA/UfEPIu2Mp/lLO1lYhaPzD6c
 4e8UvVoUeK4qoDOZWdaInpe3Ce2DX8kjTHBKjvoDGYCAG520NltSmb+czJVHGCpBaU
 T8MG9zGZ4MwFrMSwjvUMI+l0kWJod5QrDSouNLdgYJFQRzDkUGATMcr+6KoNxaxQWl
 6uKT8SdSy8aSqVExo3B3PvetJuztjMtCy1TxwPPYxo7H575BVAegshfgVtdHkn9wjv
 syKO7ojCKu1lA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E47321CA60E;
 Wed, 12 Aug 2026 17:50:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4B2F6409D4A;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AA8FC2F977; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 010/120] vfio/region: Clarify dma-buf failure messages
Date: Wed, 12 Aug 2026 17:47:53 +0300
Message-ID: <20260812144955.649205-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Cédric Le Goater <clg@redhat.com>

The dma-buf failure messages in vfio_region_create_dma_buf() say "PCI
BAR IOMMU mappings may fail", which suggests the BAR is broken. In
practice, only P2P DMA is affected -- normal passthrough uses the mmap
fallback.

Reword both messages to mention P2P DMA explicitly and clarify that
the mmap fallback is in use. Use warn_report_err_once() at the call
site so per-BAR repetition on mdev devices is suppressed.

Fixes: dcf1b77e834d ("hw/vfio/region: Create dmabuf for PCI BAR per region")
Cc: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 4b2e6505d59b7b16c6e15a2494942d00648e8510)
Actually
Fixes: 8cfaf22668c7 ("hw/vfio/region: Create dmabuf for PCI BAR per region")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 47fdc2df349..ad439c5ca6a 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -316,13 +316,12 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
     ret = vfio_device_get_feature(vbasedev, feature);
     if (ret < 0) {
         if (ret == -ENOTTY) {
-            warn_report_once("VFIO dma-buf not supported in kernel: "
-                             "PCI BAR IOMMU mappings may fail");
+            warn_report_once("VFIO dma-buf not supported in kernel, "
+                             "using mmap fallback, P2P DMA will not work");
             return true;
         }
-        /* P2P DMA or exposing device memory use cases are not supported. */
-        error_setg_errno(errp, -ret, "%s: failed to create dma-buf: "
-                         "PCI BAR IOMMU mappings may fail",
+        error_setg_errno(errp, -ret, "%s: dma-buf unavailable, "
+                         "using mmap fallback, P2P DMA will not work",
                          memory_region_name(region->mem));
         return false;
     }
@@ -443,7 +442,7 @@ int vfio_region_mmap(VFIORegion *region)
     }
 
     if (!vfio_region_create_dma_buf(region, &local_err)) {
-        error_report_err(local_err);
+        warn_report_err_once(local_err);
     }
 
     return 0;
-- 
2.47.3


