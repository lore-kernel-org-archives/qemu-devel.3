Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE93DC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 19:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbP7C-0006kV-Fj; Fri, 24 Jan 2025 14:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbP7B-0006kC-0s
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:13:13 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbP78-0007qG-UD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:13:12 -0500
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so4583445a91.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 11:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737745989; x=1738350789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDJQfkF7TGyKUeThCnNUPt37lNu38uEocV8mTihMwvM=;
 b=SvWoCeL06d1SlIDv1a0KC+gKil2BA5/xV87zCZynMqUMCqcLI29B3MRQbsHaZza2S8
 r5ssU1DdWEXqJhsm9TvIDw7jYIl/Uawvlgv82smTrvRAq0kUrVVCnKt359JfdHO3ZAYZ
 ZuGPeSQUvVpmSYCLJx1snPqdWBEC0lGW3HrpftP7s29ms5sxJRQjOc7wH9cmw7+BcDMO
 vAWb9unAhYNnatP7kTlYyhtVXKXLe5vN+w+OH1gINl04LP5HEEs6EmXIOLxf6IKIDofL
 qIiEK8DptUGH37JWiCiXACTM9GWLRL6QKpvj7CXJ9gLMHtm8awuVwPFKl/VlFqThC8F7
 mvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737745989; x=1738350789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SDJQfkF7TGyKUeThCnNUPt37lNu38uEocV8mTihMwvM=;
 b=OyWT4J3h2f/3ipcz0wQzhbrpLIp+rbjxiPOglcabVzAF1lyumLIctI2FpNSkjPeWMG
 Ro1CDp6Php8FBqQmZ/bvNYnvzggzKWSXfUWd7xgN/SVIdkR31xQ3+wxCGjQupmOJzAEp
 uiJxtYtcvwsn1phCGIqZrxt3K1If69FswyheSA0iWL/Rj3R4K5Zn4eJJ5XBSMhKLF6Ll
 MYyIiKGARDSvTPPqBqUapLRdCvKZGkavKp9TZqaCAyd0KZqfBnC6gP/5af3CmeKkpNAI
 V5KMF5uuhoE/A5fLzty6n4liY9Vbslf3TfA29Is1N4IGvQHpO4uO+VOCI9b4fEDNoVp1
 +zxg==
X-Gm-Message-State: AOJu0Yxzg4vnTnM5paBGsd/mmN4bni2jqREaBx5nHpdRvGS/qFaQU6ht
 fz7IInpaHsebOhNyEGnOBdDZdPY+a6+IppXP7iJlIvgRyGpp45E=
X-Gm-Gg: ASbGncsjEKAOFqMw9hhB7+eQR1kF0vIw+LhBdPQoM+pGFpnzjo+i79yrboa95YA35ru
 xQ21R3+hVX/uiUGXCx1tpdnmSh1iTwReAE55Xe5TUQN7E6rSuZtH5XpVSCw6TdgehJ24kSv1jIq
 J1UgquJ+WE5CLsYNDuhOVuWTPvfzi0qLiVnQ/mwZRHPF26a9f5cjQjOBXBDrQCpcNjd7/6rz9vf
 /o4MJ0S3L9hbuLu+OEzpF+eY1yW5makJnNw5XziV7C52JfMcOi3xx7J21YWRZKDnrFeeJH3FC0U
 2QYBWCY5Q+kbNz9pYQ==
X-Google-Smtp-Source: AGHT+IFGuQi8+35i/rdlovFxz/fClmwbTUlny/0LqGXdE83kVUnBvq5mdSUWxHsDqq/vLXZ5s5owdg==
X-Received: by 2002:a05:6a00:811:b0:72a:a7a4:b641 with SMTP id
 d2e1a72fcca58-72dafb71a28mr50515742b3a.18.1737745989352; 
 Fri, 24 Jan 2025 11:13:09 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69eb75sm2318406b3a.12.2025.01.24.11.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 11:13:09 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 5/5] vfio/igd: handle x-igd-opregion in
 vfio_probe_igd_config_quirk()
Date: Sat, 25 Jan 2025 03:12:45 +0800
Message-ID: <20250124191245.12464-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250124191245.12464-1-tomitamoeko@gmail.com>
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1042.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Both enable opregion option (x-igd-opregion) and legacy mode require
setting up OpRegion copy for IGD devices. Move x-igd-opregion handler
in vfio_realize() to vfio_probe_igd_config_quirk() to elimate duplicate
code. Finally we moved all the IGD-related code into igd.c.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c        | 143 +++++++++++++++++++++++++++++++++----------
 hw/vfio/pci-quirks.c |  50 ---------------
 hw/vfio/pci.c        |  25 --------
 hw/vfio/pci.h        |   4 --
 4 files changed, 110 insertions(+), 112 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 6e06dd774a..015beacf5f 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -106,6 +106,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
     return -1;
 }
 
+#define IGD_ASLS 0xfc /* ASL Storage Register */
 #define IGD_GMCH 0x50 /* Graphics Control Register */
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
 #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
@@ -138,6 +139,55 @@ static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
     return 0;
 }
 
+/*
+ * The OpRegion includes the Video BIOS Table, which seems important for
+ * telling the driver what sort of outputs it has.  Without this, the device
+ * may work in the guest, but we may not get output.  This also requires BIOS
+ * support to reserve and populate a section of guest memory sufficient for
+ * the table and to write the base address of that memory to the ASLS register
+ * of the IGD device.
+ */
+static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
+                                       struct vfio_region_info *info,
+                                       Error **errp)
+{
+    int ret;
+
+    vdev->igd_opregion = g_malloc0(info->size);
+    ret = pread(vdev->vbasedev.fd, vdev->igd_opregion,
+                info->size, info->offset);
+    if (ret != info->size) {
+        error_setg(errp, "failed to read IGD OpRegion");
+        g_free(vdev->igd_opregion);
+        vdev->igd_opregion = NULL;
+        return false;
+    }
+
+    /*
+     * Provide fw_cfg with a copy of the OpRegion which the VM firmware is to
+     * allocate 32bit reserved memory for, copy these contents into, and write
+     * the reserved memory base address to the device ASLS register at 0xFC.
+     * Alignment of this reserved region seems flexible, but using a 4k page
+     * alignment seems to work well.  This interface assumes a single IGD
+     * device, which may be at VM address 00:02.0 in legacy mode or another
+     * address in UPT mode.
+     *
+     * NB, there may be future use cases discovered where the VM should have
+     * direct interaction with the host OpRegion, in which case the write to
+     * the ASLS register would trigger MemoryRegion setup to enable that.
+     */
+    fw_cfg_add_file(fw_cfg_find(), "etc/igd-opregion",
+                    vdev->igd_opregion, info->size);
+
+    trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
+
+    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
+    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
+    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
+
+    return true;
+}
+
 /*
  * The rather short list of registers that we copy from the host devices.
  * The LPC/ISA bridge values are definitely needed to support the vBIOS, the
@@ -339,29 +389,83 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
+static bool vfio_igd_try_enable_opregion(VFIOPCIDevice *vdev, Error **errp)
+{
+    g_autofree struct vfio_region_info *opregion = NULL;
+    int ret;
+
+    /*
+     * Hotplugging is not supprted for both opregion access and legacy mode.
+     * For legacy mode, we also need to mark the ROM failed.
+     */
+    if (vdev->pdev.qdev.hotplugged) {
+        vdev->rom_read_failed = true;
+        error_setg(errp,
+                   "IGD OpRegion is not supported on hotplugged device");
+        return false;
+    }
+
+    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
+                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
+    if (ret) {
+        error_setg_errno(errp, -ret,
+                         "device does not supports IGD OpRegion feature");
+        return false;
+    }
+
+    if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
 bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
-                                 Error **errp G_GNUC_UNUSED)
+                                 Error **errp)
 {
     g_autofree struct vfio_region_info *rom = NULL;
-    g_autofree struct vfio_region_info *opregion = NULL;
     g_autofree struct vfio_region_info *host = NULL;
     g_autofree struct vfio_region_info *lpc = NULL;
+    PCIBus *bus;
     PCIDevice *lpc_bridge;
     int ret, gen;
+    bool legacy_mode, enable_opregion;
     uint64_t gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
     Error *err = NULL;
 
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
+        !vfio_is_vga(vdev)) {
+        return true;
+    }
+
     /*
      * This must be an Intel VGA device at address 00:02.0 for us to even
      * consider enabling legacy mode.  The vBIOS has dependencies on the
      * PCI bus address.
      */
-    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) ||
-        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
-                                       0, PCI_DEVFN(0x2, 0))) {
+    bus = pci_device_root_bus(&vdev->pdev);
+    legacy_mode = (&vdev->pdev == pci_find_device(bus, 0, PCI_DEVFN(0x2, 0)));
+    enable_opregion = (vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION);
+
+    if (!enable_opregion && !legacy_mode) {
+        return true;
+    }
+
+    if (!vfio_igd_try_enable_opregion(vdev, &err)) {
+        if (enable_opregion) {
+            error_propagate(errp, err);
+            return false;
+        } else if (legacy_mode) {
+            error_append_hint(&err, "IGD legacy mode disabled\n");
+            error_report_err(err);
+            return true;
+        }
+    }
+
+    if (!legacy_mode) {
         return true;
     }
 
@@ -404,30 +508,10 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
         return true;
     }
 
-    /*
-     * Ignore the hotplug corner case, mark the ROM failed, we can't
-     * create the devices we need for legacy mode in the hotplug scenario.
-     */
-    if (vdev->pdev.qdev.hotplugged) {
-        error_report("IGD device %s hotplugged, ROM disabled, "
-                     "legacy mode disabled", vdev->vbasedev.name);
-        vdev->rom_read_failed = true;
-        return true;
-    }
-
     /*
      * Check whether we have all the vfio device specific regions to
      * support legacy mode (added in Linux v4.6).  If not, bail.
      */
-    ret = vfio_get_dev_region_info(&vdev->vbasedev,
-                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                        VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
-    if (ret) {
-        error_report("IGD device %s does not support OpRegion access,"
-                     "legacy mode disabled", vdev->vbasedev.name);
-        return true;
-    }
-
     ret = vfio_get_dev_region_info(&vdev->vbasedev,
                         VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
                         VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG, &host);
@@ -476,13 +560,6 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
         return true;
     }
 
-    /* Setup OpRegion access */
-    if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
-        error_append_hint(&err, "IGD legacy mode disabled\n");
-        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-        return true;
-    }
-
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
      * 32MiB. This option should only be used when the desired size cannot be
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index b8379cb512..f2b37910f0 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1114,56 +1114,6 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
     trace_vfio_quirk_rtl8168_probe(vdev->vbasedev.name);
 }
 
-#define IGD_ASLS 0xfc /* ASL Storage Register */
-
-/*
- * The OpRegion includes the Video BIOS Table, which seems important for
- * telling the driver what sort of outputs it has.  Without this, the device
- * may work in the guest, but we may not get output.  This also requires BIOS
- * support to reserve and populate a section of guest memory sufficient for
- * the table and to write the base address of that memory to the ASLS register
- * of the IGD device.
- */
-bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
-                                struct vfio_region_info *info, Error **errp)
-{
-    int ret;
-
-    vdev->igd_opregion = g_malloc0(info->size);
-    ret = pread(vdev->vbasedev.fd, vdev->igd_opregion,
-                info->size, info->offset);
-    if (ret != info->size) {
-        error_setg(errp, "failed to read IGD OpRegion");
-        g_free(vdev->igd_opregion);
-        vdev->igd_opregion = NULL;
-        return false;
-    }
-
-    /*
-     * Provide fw_cfg with a copy of the OpRegion which the VM firmware is to
-     * allocate 32bit reserved memory for, copy these contents into, and write
-     * the reserved memory base address to the device ASLS register at 0xFC.
-     * Alignment of this reserved region seems flexible, but using a 4k page
-     * alignment seems to work well.  This interface assumes a single IGD
-     * device, which may be at VM address 00:02.0 in legacy mode or another
-     * address in UPT mode.
-     *
-     * NB, there may be future use cases discovered where the VM should have
-     * direct interaction with the host OpRegion, in which case the write to
-     * the ASLS register would trigger MemoryRegion setup to enable that.
-     */
-    fw_cfg_add_file(fw_cfg_find(), "etc/igd-opregion",
-                    vdev->igd_opregion, info->size);
-
-    trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
-
-    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
-    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
-    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
-
-    return true;
-}
-
 /*
  * Common quirk probe entry points.
  */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e624ae56c4..1b90c78c5a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3136,31 +3136,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         vfio_bar_quirk_setup(vdev, i);
     }
 
-    if (!vdev->igd_opregion &&
-        vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
-        g_autofree struct vfio_region_info *opregion = NULL;
-
-        if (vdev->pdev.qdev.hotplugged) {
-            error_setg(errp,
-                       "cannot support IGD OpRegion feature on hotplugged "
-                       "device");
-            goto out_unset_idev;
-        }
-
-        ret = vfio_get_dev_region_info(vbasedev,
-                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                        VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
-        if (ret) {
-            error_setg_errno(errp, -ret,
-                             "does not support requested IGD OpRegion feature");
-            goto out_unset_idev;
-        }
-
-        if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
-            goto out_unset_idev;
-        }
-    }
-
     /* QEMU emulates all of MSI & MSIX */
     if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
         memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5c64de0270..b9e920a6b4 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -229,10 +229,6 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
 
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
-bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
-                                struct vfio_region_info *info,
-                                Error **errp);
-
 void vfio_display_reset(VFIOPCIDevice *vdev);
 bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
-- 
2.45.2


