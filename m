Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291BECD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnAy-0003tQ-JG; Wed, 17 Jun 2026 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAr-0003qh-VL
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:10 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAq-0008QD-II
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:09 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-30bc871ecdfso1164995eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781690827; x=1782295627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTa0ZmGP95JPl4WlasVWnwFDJEUD2jnUmweoPYvW62I=;
 b=okajfrxlBXtzjb0TSn5TpR4+ko4GrnSWAJoWy8TKcTEM3sTWMA/2ceA9pmj7YT4+sK
 /UB17Te67KXTRGj7hr/nvkZfLZKL3E5SB7N2x+0YtMiZuXuhVlLMwDjWlsIgLCsKnM3X
 syx4Kbs8ej1IInlrqePChKyLP0TXmsWGjZgAIn676B5aQglhsmsi8vU3pexUwyW3kR13
 zCXirVdpNdMhlnJv0Nwu6FC/O5Vk2BUQCtUminCFw1QbFN9fvI52Qk6jGNxYB8yCUrEq
 i166rRK6eXP2N++iFog2RJBp9pdYVZCagiM+0J2wZOjH2cGL4VRy8ASLkKYuZ7vGJaAV
 Uahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690827; x=1782295627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iTa0ZmGP95JPl4WlasVWnwFDJEUD2jnUmweoPYvW62I=;
 b=K/s+UzcCz771gOMmHpVaLSEG79R1v4ivuXIPoMyvFfXkLDLbGrIIqfqDjEqK8G5cnP
 1bFkeBzSu0FDAdFXCeYUb4Tmkjt5HmPU0fM1mktdxBPHG27VwUPMB8fwhZ85mlA3ZQET
 xi7Nu2WZhvR9UKM+Gb26k3doUYt7JTBz2N/+ykHWe2Btz4HGp3SYeX9plJHjr8daNRUn
 HXVhsElVVmnlcmCXfiEbmoYq12c3DcX5swrqkQHpFV4U/U45tVSRNizkKXXZ2twGARhS
 SjcRBoi9A2oVCm4rBd6W4hCDXWTedEeLysK1U7t2W33XLOEOvexzhB6hxyGb1CcN6TVt
 /HZg==
X-Gm-Message-State: AOJu0YyyYzaotfr3VXhGW75PGrq0ovjPqysf2JU0Ui359L9zOscBm+dm
 qBcBUBL5Q2vMTkM5XdiMcNH5H1uLRajBBXb7VYwvH6AzbuNYBcxTDYByIvUTzGQ9Xw==
X-Gm-Gg: AfdE7ckks3htEX5TUc/jFhLnXj8j4siQDpM8V6jO9goLDx6i+U9iOlECjY4xLRrU68P
 V0Tbc0b1IzZYqiH/o3GT9EWkHvBMkTHTzwYD4kUlQJClONUISnMsjPFra7d3UzO94ckRFa9qy+P
 aasM8fVeB8zSiQN/ss1aovG6wh5vAyFjeQZUS98akzKYimcm7He6ThcmcsJG1TY01yuvc/jvQB9
 QEkb6CPsoJfJBHja7faF1kI2G3cG10p75sgSDB4Gt7kJ1Z9aH2cyZRArk+ogamucLI9N0uc0N2s
 lVel7AaRQqlNVpeIUg+zm9WWEzjIcMTB1OAw9KzC49GEG3SeHCqLQ/Rb56HrE/pE/mnnGpctZgY
 ptzoxZfJGWeU5dgXMNUCujP2DewK7MlzsqlFnV9gShcEkijtkI19GlQivrqGB9t8eWSHKgF62eN
 RRzlUv82xxiu1QquI1bsjy
X-Received: by 2002:a05:7300:7643:b0:304:5b65:5971 with SMTP id
 5a478bee46e88-30bc9f5886cmr1828902eec.20.1781690827105; 
 Wed, 17 Jun 2026 03:07:07 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d3f20sm21858490eec.9.2026.06.17.03.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:07:06 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v3 4/7] hw/pci: Promote pci_patch_ids() to public
 pci_rom_patch_ids()
Date: Wed, 17 Jun 2026 18:06:41 +0800
Message-ID: <20260617100646.28326-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617100646.28326-1-tomitamoeko@gmail.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1341.google.com
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

Remove the static qualifier from pci_patch_ids() and rename it to
pci_rom_patch_ids(), adding a declaration in include/hw/pci/pci.h so
external callers can reuse it.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/pci/pci.c         | 4 ++--
 include/hw/pci/pci.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b4235834a0..92d4e71c04 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2492,7 +2492,7 @@ uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size)
 
 /* Patch the PCI vendor and device ids in a PCI rom image if necessary.
    This is needed for an option rom which is used for more than one device. */
-static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
+void pci_rom_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
 {
     uint16_t vendor_id;
     uint16_t device_id;
@@ -2654,7 +2654,7 @@ static void pci_add_option_rom(PCIDevice *pdev, Error **errp)
 
         if (pdev->rom_need_patch_id) {
             /* Only the default rom images will be patched (if needed). */
-            pci_patch_ids(pdev, ptr, size);
+            pci_rom_patch_ids(pdev, ptr, size);
         }
     }
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 2d8a4ad0eb..298e0e6c31 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1104,5 +1104,6 @@ void pci_set_power(PCIDevice *pci_dev, bool state);
 int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
 
 uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size);
+void pci_rom_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size);
 
 #endif
-- 
2.53.0


