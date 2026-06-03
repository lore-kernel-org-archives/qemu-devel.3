Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354D6CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpU1-0003qC-RH; Wed, 03 Jun 2026 13:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTx-0003ok-6C
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:22 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTv-0003J6-7H
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:20 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-137bd9ed2b1so4130859c88.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 10:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780508058; x=1781112858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qy1UUF3hxI4Wh5XfXs+GeaEbG1d+3h7FaO5OzNWRyiE=;
 b=CZkk4xAzTpwr/cJR1G0dQg3CJ7PlivI2r2x1fNgqLyZtuZpuethI7Sp69Qwu3ZFNDk
 tNmC7ViQxYn18cfIwnp614F12KvuXmf2bbb33MRGsClb6dZn+duQOAk4c1nkiy60JnEy
 oB4NSyFngpDNILgd8EoIJUkWRE85c9+Ew3YT1DANwNw3EPekLdG0OjHegSOkB7aTZkoa
 vOPBVunFFRuI5C4wwFpBIvpbFqGySeQxdDMy+yy5LS9+3ylFTz22sGBzagkfO/Rh341Q
 f5kd//JIwKBeSglrw165sXpm6Cl8qgKSo5NzBrPd+1NFu91TpINDfsX1zqn/VPlJZZHW
 MqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508058; x=1781112858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qy1UUF3hxI4Wh5XfXs+GeaEbG1d+3h7FaO5OzNWRyiE=;
 b=tBSCO5pStdMLv8iTgqUKK29HaEJskVR9Ey4RAR9HTdfYbR1N4LwNeC5G3JWsAboaUb
 LdrVkd/RXhLIRM6FkfHf2SeOAXbKgyimiSBeZUB75Czr//1dFF/+VCPUGFoXQ4O6dvq1
 quNBsd5UD0PpzIOB+z/P7MJoZo9d/7PPM5jFtuFLG0ATO4EcehcSW1Rrdmu1a/RwYolh
 uSNKMtBRQSG5DGoSnwd4P1cCvjAIi2jdtZg/E1o3V/vs76TKUT28jvSeIBLz4dEtjlxk
 szZWcONUMkVF2vMWf+sluwS9zrXZNChjy7hz2udRYGLLFyJ3kyoDjDp83jcs5AGhWL5R
 Vqzw==
X-Gm-Message-State: AOJu0YxELAk3C/k3ucuFEi3AlhnC2PLhp4bCG7XYdVfbvk2vr+EX8bqW
 SBcwAbc5sDdqd/5p5FDd/ZQc7j9azlGu7LuZtsBvDh/D2Z3G4YBw9rY3S0fvqYJA3w==
X-Gm-Gg: Acq92OEUPK4nNzSK/B95Gy/lMt40aPdMm6sop44+CYupr8/HTZ4VsYrZ/oh+ZAmaYqh
 1Hkzfz2pz1HihhKvIxd2xOmxS00SSlWX1raJ1fI6TbNc3Zt/rjyU4tUR+JXQf/RFwb2bxJrVz1p
 e8GvxSDQ97/Vo1NZH0HbT6DRVwXQJyVneWXNofapT0X5Xusz1AqV+MyFzolUsDoQCuj4/DN7FUQ
 7cBCgZscSoqXpBRDc3pWkRlLaC4s4K7AX5Fzwt+m0nyLBHgZwwM03NMGGR1cd6eLix2wqWPZZkq
 wnvBImq9ZdnZyJBF8LKf/+BMUiibi7TnpsYgCWUKp7AB2cxU6bFw4roiNmf7afghzvuXFuM3xYx
 rXl5Psra9JmzXkdKuQYFFl9Lu1X5vRQlDdZB7xMOSR0CFLfK+SCZm/3J4JPihle0qrmD5bdb3/X
 ZbdqaBcq1cCImnz5ps0nJwXa8rNAw7bGv0HwhUsXh7pg==
X-Received: by 2002:a05:7300:dc8c:b0:2df:7fe3:96a with SMTP id
 5a478bee46e88-3074f843547mr2218341eec.0.1780508057557; 
 Wed, 03 Jun 2026 10:34:17 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffa:7da0:c45e:b5c8:d6e8:bd7e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074d9fde90sm4354810eec.0.2026.06.03.10.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:34:17 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH 5/6] vfio/igd: Toggle rom_need_patch_id flag on IGD devices
Date: Thu,  4 Jun 2026 01:33:53 +0800
Message-ID: <20260603173355.36121-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603173355.36121-1-tomitamoeko@gmail.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dl1-x1243.google.com
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

IGD ROMs are known to have wrong device IDs and bogus checksums.
Toggle the rom_need_patch_id flag when the IGD has ROM BAR or custom
romfile so that pci_rom_patch_ids() will correct the vendor/device IDs
and checksum.

The ROM BAR availability check is extracted into
vfio_pci_igd_has_rom_bar() to avoid duplicating the region info lookup.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Tested-by: K S Maan <kirandeepmaan45@gmail.com>
---
 hw/vfio/igd.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e091f21b6a..17437ae18d 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -509,11 +509,22 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
+static bool vfio_pci_igd_has_rom_bar(VFIOPCIDevice *vdev)
+{
+    struct vfio_region_info *rom = NULL;
+    int ret;
+
+    ret = vfio_device_get_region_info(&vdev->vbasedev,
+                                      VFIO_PCI_ROM_REGION_INDEX, &rom);
+
+    return !ret && rom->size;
+}
+
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     struct vfio_region_info *opregion = NULL;
     PCIDevice *pdev = PCI_DEVICE(vdev);
-    int ret, gen;
+    int gen;
     uint64_t gms_size = 0;
     uint64_t *bdsm_size;
     uint32_t gmch;
@@ -556,8 +567,6 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          * - OpRegion
          * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
          */
-        struct vfio_region_info *rom = NULL;
-
         legacy_mode_enabled = true;
         info_report("IGD legacy mode enabled, "
                     "use x-igd-legacy-mode=off to disable it if unwanted.");
@@ -567,9 +576,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          * there's no ROM, there's no point in setting up this quirk.
          * NB. We only seem to get BIOS ROMs, so UEFI VM would need CSM support.
          */
-        ret = vfio_device_get_region_info(&vdev->vbasedev,
-                                          VFIO_PCI_ROM_REGION_INDEX, &rom);
-        if ((ret || !rom->size) && !pdev->romfile) {
+        if (!vfio_pci_igd_has_rom_bar(vdev) && !pdev->romfile) {
             error_setg(&err, "Device has no ROM");
             goto error;
         }
@@ -610,6 +617,14 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         goto error;
     }
 
+    /*
+     * IGD are known to have bad checksums and wrong device ID in its rom,
+     * request to patch it.
+     */
+    if (pdev->romfile || vfio_pci_igd_has_rom_bar(vdev)) {
+        pdev->rom_need_patch_id = true;
+    }
+
     /*
      * ASLS (OpRegion address) is read-only, emulated
      * It contains HPA, guest firmware need to reprogram it with GPA.
-- 
2.53.0


