Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DFDC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzF7-0005tj-Rf; Mon, 05 May 2025 13:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzEM-0005Ph-O4
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:52 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzEK-0003bh-GT
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:50 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso42378975ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464627; x=1747069427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztFqvqX00VgKPGvoZSHAuJaxjB/GvoAF6HbH18tiePY=;
 b=PvjIbywumG7ZufL3py8+yYthTTqlfVtYJugtRuKgZqlT6N7WXadqDLe95IQAW6SKLy
 nqx9T+wEUTESZOIGjac4mWFX6ZZeVkQTQeSExAZ/BFRxe89WTY9+J68zbNCyqkp6zNw8
 Y3Cz0UgFvPPSPji89xQuVLfXO1BUvkn2uw0HiVTd5EqRCVCXyDtF12qFlFUYwxwOQjLq
 DOmiNYSRLXkbqv1dJux/THX21ILEZYXU2luoXpZrRdEgfN571p7W3Jt93/jRxPXhTL5y
 9S78K2fwh/l1fR31z4VkccyG6HQCLFvWVe9+4fuq7PV0bNxJ6V14dIn0a7jO9N5KIoxk
 nwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464627; x=1747069427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ztFqvqX00VgKPGvoZSHAuJaxjB/GvoAF6HbH18tiePY=;
 b=q3Q6goclGRXDMOi5JzavRRVItV8zwZZtPPVuC9+qjiK1ht8CfMvxVbVEQoW4w0XyQE
 iVnIMoHZa+MG/j5ST3CAU+7xEhajjRTPFUhWr3GnoU5hAAWT1wuwMOJLTzHhbTIcBooR
 9XyX6QT/DK6qQQRm7svI2yRILLokp5F6PWjDD2kc4pwnQRxSkJFE3GzG1VE4BRtgIqc+
 gWulv8ZFXHfLX/GcEDQ0GyKEIS63qy8ZdLweSU1KfeAsw7gnOcvk87rRRhLfwe54z9xM
 tBqd3rUmPxm/9fvjOAHxnEcO5d1rmfZ5/gpsZU1IM1tY4D0OECJ3cKd6CIVrEto025F9
 k04A==
X-Gm-Message-State: AOJu0YwbDcEVgemJNT3WRDw4bJ0Ah9IqkT6cQlwQ5WhouFxLG2eCKcch
 VoGKPbyIUJpwwPjgJdacfjSjyV1nL3aehGlDw6jZ11NRmo5GVOQ=
X-Gm-Gg: ASbGncvV/hBhQ6jgjFdogKJetYYLdXPh16sQdRTZDaR6GEiCgeGqS78cONa9BXnXTCc
 d2QL8ihm2GAHTaE1Wan5egTRpJnzUYVK0B6vOpCAUollVzHZFTZioGP+Vl3+xRDTeC0Cd95nSQR
 FzEOGenA1wgn546Ub5CSm1LRmovD3WwEvZHjcYgH3M7w4so/3zCxsdBpawHliLgGMgwobC4h5On
 qJo6rCiA6nV/HwBY83r5Ay+zrYnp6NiHTjoiUCItD1SrN/kyPicNo20FwIRLKfqPA2xRtEQThc5
 O4slRPmTzZJ7rnZ0OhJixeIqsPC5XGrefPQP58McZMIM/aJE+hkfltiI
X-Google-Smtp-Source: AGHT+IEYrJgsMqjhE5EVKiJ9XAS7zX8r1iKQxxIWJkMRipWjGAx4enAW+O45Ybpxq6LEgXtRMIK60Q==
X-Received: by 2002:a17:902:d591:b0:215:a2f4:d4ab with SMTP id
 d9443c01a7336-22e327567a0mr3230255ad.7.1746464626878; 
 Mon, 05 May 2025 10:03:46 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9e9dsm57335135ad.83.2025.05.05.10.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 10:03:46 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH v3 9/9] vfio/igd: Remove generation limitation for IGD
 passthrough
Date: Tue,  6 May 2025 01:03:05 +0800
Message-ID: <20250505170305.23622-10-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505170305.23622-1-tomitamoeko@gmail.com>
References: <20250505170305.23622-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
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

Starting from Intel Core Ultra Series (Meteor Lake), Data Stolen Memory
has became a part of LMEMBAR (MMIO BAR2) [1][2], meaning that BDSM and
GGC register quirks are no longer needed on these platforms.

To support Meteor/Arrow/Lunar Lake and future IGD devices, remove the
generation limitation in IGD passthrough, and apply BDSM and GGC quirks
only to known Gen6-12 devices.

[1] https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-registers/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/gem/i915_gem_stolen.c?h=v6.14#n142

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 docs/igd-assign.txt |  6 +++++
 hw/vfio/igd.c       | 58 ++++++++++++++++-----------------------------
 2 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index fc444503ff..af4e8391fc 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -157,6 +157,12 @@ fw_cfg requirements on the VM firmware:
    it's expected that this fw_cfg file is only relevant to a single PCI
    class VGA device with Intel vendor ID, appearing at PCI bus address 00:02.0.
 
+   Starting from Meteor Lake, IGD devices access stolen memory via its MMIO
+   BAR2 (LMEMBAR) and removed the BDSM register in config space. There is
+   no need for guest firmware to allocate data stolen memory in guest address
+   space and write it to BDSM register. Value of this fw_cfg file is 0 in
+   such case.
+
 Upstream Seabios has OpRegion and BDSM (pre-Gen11 device only) support.
 However, the support is not accepted by upstream EDK2/OVMF. A recommended
 solution is to create a virtual OpRom with following DXE drivers:
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 886d44f017..3ee1a73b57 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -103,6 +103,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
     /*
      * Unfortunately, Intel changes it's specification quite often. This makes
      * it impossible to use a suitable default value for unknown devices.
+     * Return -1 for not applying any generation-specific quirks.
      */
     return -1;
 }
@@ -459,20 +460,12 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
     int gen;
 
-    /*
-     * This must be an Intel VGA device at address 00:02.0 for us to even
-     * consider enabling legacy mode. Some driver have dependencies on the PCI
-     * bus address.
-     */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
         !vfio_is_vga(vdev) || nr != 0) {
         return;
     }
 
-    /*
-     * Only on IGD devices of gen 11 and above, the BDSM register is mirrored
-     * into MMIO space and read from MMIO space by the Windows driver.
-     */
+    /* Only on IGD Gen6-12 device needs quirks in BAR 0 */
     gen = igd_gen(vdev);
     if (gen < 6) {
         return;
@@ -519,7 +512,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     g_autofree struct vfio_region_info *opregion = NULL;
     int ret, gen;
-    uint64_t gms_size;
+    uint64_t gms_size = 0;
     uint64_t *bdsm_size;
     uint32_t gmch;
     bool legacy_mode_enabled = false;
@@ -536,18 +529,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     }
     info_report("OpRegion detected on Intel display %x.", vdev->device_id);
 
-    /*
-     * IGD is not a standard, they like to change their specs often.  We
-     * only attempt to support back to SandBridge and we hope that newer
-     * devices maintain compatibility with generation 8.
-     */
     gen = igd_gen(vdev);
-    if (gen == -1) {
-        error_report("IGD device %s is unsupported in legacy mode, "
-                     "try SandyBridge or newer", vdev->vbasedev.name);
-        return true;
-    }
-
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
 
     /*
@@ -645,32 +627,34 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
     }
 
-    gms_size = igd_stolen_memory_size(gen, gmch);
+    if (gen > 0) {
+        gms_size = igd_stolen_memory_size(gen, gmch);
+
+        /* BDSM is read-write, emulated. BIOS needs to be able to write it */
+        if (gen < 11) {
+            pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
+            pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
+            pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
+        } else {
+            pci_set_quad(vdev->pdev.config + IGD_BDSM_GEN11, 0);
+            pci_set_quad(vdev->pdev.wmask + IGD_BDSM_GEN11, ~0);
+            pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
+        }
+    }
 
     /*
      * Request reserved memory for stolen memory via fw_cfg.  VM firmware
      * must allocate a 1MB aligned reserved memory region below 4GB with
-     * the requested size (in bytes) for use by the Intel PCI class VGA
-     * device at VM address 00:02.0.  The base address of this reserved
-     * memory region must be written to the device BDSM register at PCI
-     * config offset 0x5C.
+     * the requested size (in bytes) for use by the IGD device. The base
+     * address of this reserved memory region must be written to the
+     * device BDSM register.
+     * For newer device without BDSM register, this fw_cfg item is 0.
      */
     bdsm_size = g_malloc(sizeof(*bdsm_size));
     *bdsm_size = cpu_to_le64(gms_size);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
-    /* BDSM is read-write, emulated.  The BIOS needs to be able to write it */
-    if (gen < 11) {
-        pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
-        pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
-        pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
-    } else {
-        pci_set_quad(vdev->pdev.config + IGD_BDSM_GEN11, 0);
-        pci_set_quad(vdev->pdev.wmask + IGD_BDSM_GEN11, ~0);
-        pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
-    }
-
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
 
     return true;
-- 
2.47.2


