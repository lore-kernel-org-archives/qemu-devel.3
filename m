Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BD8C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFL2-0005CH-MK; Tue, 08 Jul 2025 16:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uZEVR-0002yU-C6
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:01:38 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uZEVJ-0003Zr-0C
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:01:28 -0400
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-4a442a3a2bfso78702751cf.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752004881; x=1752609681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MoncLiotR2i8htK3M42jgU29xEXPnqSxiRLcPBGmgMo=;
 b=QKuvyRgTB1BhEPLJSVqCNGL35LecdiJVYSyXMNSxqqlbuTFWFPlNXpcP+soIRwHGIt
 W9EfmpjvDS3OeREMyntriGKm1MbMyG9/OJ9ZcsKDwHTEdkjjD0waCc+2+BsLzyjb0Mm9
 1ZIvg+E0bbN43ooUmpJZuSj5+LfXBcjJTXUJE37r2yJHBRxN5oWN+cZo6B+U1dwTAA5u
 3V4OThx4jzvcNKJMWKQl6q9c/R2mlP3Zb94JEU7Z7xcBuht7l4UG4XU1zleXgkS0TaKT
 4NYNMHf6UELTSzM0uurpkkH1RHpet1Pf+mdXxR4ptgEFzweLiWzMQ/7jWeEeSUd4YUM/
 TjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752004881; x=1752609681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MoncLiotR2i8htK3M42jgU29xEXPnqSxiRLcPBGmgMo=;
 b=bkPhNmAAIvotDbmwX+W1wyk2yYDrl6X26MhSJYEgeTFTWktU5+Agnlt0eOhqWOKr3K
 /cyuTUk8duJIK5d96g3bdxGWhoN2ENAkmIqSA8IMxdqN07FcLygNobm/0jS/77Si5rdO
 K1PLJ1hMzZQ1J+NkM8ESgUA/U7cjjuahChkJLXs74Nf8iCsT3FPeWumL0hgfmboIfg/H
 ou05vdE5kb24uHaPWxPc1UjXvgbkTTW1EAAS2mbTOEJfmpI3TupxBq0VwtEdWbYrbrq7
 U6reetsy0pKoEyiHt+aUxKVQspcSZNgb7GFI8mrslmBqDs7VlZGirZz2/yaD0ZOEdPo9
 UBAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcKL5/i//xvW7HY/+BrsTFbDJtjtr9HJCAQok5QGOkFhXi4LLUiS8rKxmFhmD9dKLB2/P1iI9MkHqy@nongnu.org
X-Gm-Message-State: AOJu0YxiCvN9i4SsNRAkwO6WB/J0SHIFMaLNyab8w5FaTjghGb1XYGg2
 L4HFNK17mfZ96J4urtOHJBsBmlubJ00zSYpR5PgEz73eplpI6aouG6fCzHKac+P47A==
X-Gm-Gg: ASbGncv6mkaSpSEh4CxEzYW3XO+J1RRKBKkxBOfyVgaSpL82k8rjnwXzQiy88x2bdv+
 CDIiH11jEi4kbKYQx8nRsiVwlRG/1+xHXaNKVEfaePhmdW9Fpq5rUMqhaEuJnLBIIm2fcUZ3fEU
 FZLkkZN83WOBOzEx2jtLIp27unqDW4q0od1oIQGMockWtg8RIbM1JtRn/Wm6mEnG+GEiHWMDUSp
 pN+cggdraP+v3Iet84zzsk5nWddRULcFA43KDfHCb9VU5nlbsm+CShKwEuCgyuRWjRya6TuymIv
 Ti/pVim9vKztiNUcWYkjr06mUbeE2fcLWFnWBmkFKNAuxRxJZSjWUZvksiGDCFW2xyV/DHLmdyd
 UY/6a9nxuDA==
X-Google-Smtp-Source: AGHT+IEA7Q47Km+FlWpn9hwjYSo+hMCLX9DwGMPGw4uzbflOtPa4sKLF8MUnJvJq86mqwFIbwouAGg==
X-Received: by 2002:a05:6a21:2d8f:b0:21f:4459:c032 with SMTP id
 adf61e73a8af0-225b85f42edmr26203574637.18.1751986345510; 
 Tue, 08 Jul 2025 07:52:25 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.93])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce43d69d7sm12635484b3a.177.2025.07.08.07.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 07:52:25 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Tomita Moeko <tomitamoeko@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3] vfio/pci: Introduce x-pci-class-code option
Date: Tue,  8 Jul 2025 22:52:11 +0800
Message-ID: <20250708145211.6179-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=tomitamoeko@gmail.com; helo=mail-qt1-x843.google.com
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

Introduce x-pci-class-code option to allow users to override PCI class
code of a device, similar to the existing x-pci-vendor-id option. Only
the lower 24 bits of this option are used, though a uint32 is used here
for determining whether the value is valid and set by user.

Additionally, to ensure VGA ranges are only exposed on VGA devices,
pci_register_vga() is now called in vfio_pci_config_setup(), after
the class code override is completed.

This is mainly intended for IGD devices that expose themselves either
as VGA controller (primary display) or Display controller (non-primary
display). The UEFI GOP driver depends on the device reporting a VGA
controller class code (0x030000).

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
v3:
* Save the vdev class code when it is unspecified.
* Call pci_register_vga() in vfio_pci_config_setup() to ensure VGA
  regions are only get exposed when vdev is VGA.
* Check vdev class code in vfio_is_vga().
Link: https://lore.kernel.org/qemu-devel/20250528155548.29344-1-tomitamoeko@gmail.com/

v2:
* Add vdev class code check in vfio_populate_vga().
* Fix type in trace-events.
Link: https://lore.kernel.org/all/20250524153102.19747-1-tomitamoeko@gmail.com/

 hw/vfio/pci.c        | 29 +++++++++++++++++++++++++----
 hw/vfio/pci.h        |  6 ++----
 hw/vfio/trace-events |  1 +
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1093b28df7..910042c6c2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2893,10 +2893,6 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
                           "vfio-vga-io@0x3c0",
                           QEMU_PCI_VGA_IO_HI_SIZE);
 
-    pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
-                     &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
-                     &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
-
     return true;
 }
 
@@ -3228,6 +3224,23 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
                                               vdev->sub_device_id);
     }
 
+    /*
+     * Class code is a 24-bit value at config space 0x09. Allow overriding it
+     * with any 24-bit value.
+     */
+    if (vdev->class_code != PCI_ANY_ID) {
+        if (vdev->class_code > 0xffffff) {
+            error_setg(errp, "invalid PCI class code provided");
+            return false;
+        }
+        /* Higher 24 bits of PCI_CLASS_REVISION are class code */
+        vfio_add_emulated_long(vdev, PCI_CLASS_REVISION,
+                               vdev->class_code << 8, ~0xff);
+        trace_vfio_pci_emulated_class_code(vbasedev->name, vdev->class_code);
+    } else {
+        vdev->class_code = pci_get_long(pdev->config + PCI_CLASS_REVISION) >> 8;
+    }
+
     /* QEMU can change multi-function devices to single function, or reverse */
     vdev->emulated_config_bits[PCI_HEADER_TYPE] =
                                               PCI_HEADER_TYPE_MULTI_FUNCTION;
@@ -3257,6 +3270,12 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 
     vfio_bars_register(vdev);
 
+    if (vdev->vga && vfio_is_vga(vdev)) {
+        pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
+                         &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
+                         &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
+    }
+
     return true;
 }
 
@@ -3643,6 +3662,8 @@ static const Property vfio_pci_dev_properties[] = {
                        sub_vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-class-code", VFIOPCIDevice,
+                       class_code, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
     DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
                                    nv_gpudirect_clique,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 495fae737d..4aa6461117 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -157,6 +157,7 @@ struct VFIOPCIDevice {
     uint32_t device_id;
     uint32_t sub_vendor_id;
     uint32_t sub_device_id;
+    uint32_t class_code;
     uint32_t features;
 #define VFIO_FEATURE_ENABLE_VGA_BIT 0
 #define VFIO_FEATURE_ENABLE_VGA (1 << VFIO_FEATURE_ENABLE_VGA_BIT)
@@ -205,10 +206,7 @@ static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t de
 
 static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
 {
-    PCIDevice *pdev = &vdev->pdev;
-    uint16_t class = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
-
-    return class == PCI_CLASS_DISPLAY_VGA;
+    return (vdev->class_code >> 8) == PCI_CLASS_DISPLAY_VGA;
 }
 
 /* MSI/MSI-X/INTx */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 8ec0ad0cde..fc6ed230d0 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -48,6 +48,7 @@ vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s 0x%04x"
+vfio_pci_emulated_class_code(const char *name, uint32_t val) "%s 0x%06x"
 
 # pci-quirks.c
 vfio_quirk_rom_in_denylist(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"
-- 
2.47.2


