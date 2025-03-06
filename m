Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CBFC28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBzz-0006mE-B8; Thu, 06 Mar 2025 09:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqBzx-0006ka-Aq
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:14:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqBzv-0001Z4-3z
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jsDCMU6OOVfdTbqxRxkrrzYD3sdMuJak9AFaBj57dak=;
 b=eJKOVuESYQ1TNoQcBxWC5mYivwg4qfg8FEclUU1s39DT8D82w9qBo7wPhTB4TvnxMubHFq
 QupQy6UoBJD0E4V9y6FCeHwY3IuAtEUNmL9oZhwfPTFIHAMaK0nVpE+BZAhHRX0tWYh2R8
 89pkFW7VZoELlM0TBP/6IQ4GcEhr9Zs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-Nf3AbrjyNMWt5vJ7pNoglA-1; Thu,
 06 Mar 2025 09:14:32 -0500
X-MC-Unique: Nf3AbrjyNMWt5vJ7pNoglA-1
X-Mimecast-MFC-AGG-ID: Nf3AbrjyNMWt5vJ7pNoglA_1741270470
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A618A1954B1E; Thu,  6 Mar 2025 14:14:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6398E18001D3; Thu,  6 Mar 2025 14:14:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Subject: [PULL 01/42] vfio: Add property documentation
Date: Thu,  6 Mar 2025 15:13:37 +0100
Message-ID: <20250306141419.2015340-2-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Investigate the git history to uncover when and why the VFIO
properties were introduced and update the models. This is mostly
targeting vfio-pci device, since vfio-platform, vfio-ap and vfio-ccw
devices are simpler.

Sort the properties based on the QEMU version in which they were
introduced.

Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com> # vfio-ccw
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250217173455.449983-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ap.c       |   9 ++++
 hw/vfio/ccw.c      |  15 ++++++
 hw/vfio/pci.c      | 125 +++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/platform.c |  24 +++++++++
 4 files changed, 173 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 30b08ad375d5ecae886c5000fbaa364799fe76d0..c7ab4ff57ada0ed0e5a76f52b5a05c86ca4fe0b4 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -257,6 +257,15 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
     dc->hotpluggable = true;
     device_class_set_legacy_reset(dc, vfio_ap_reset);
     dc->bus_type = TYPE_AP_BUS;
+
+    object_class_property_set_description(klass, /* 3.1 */
+                                          "sysfsdev",
+                                          "Host sysfs path of assigned device");
+#ifdef CONFIG_IOMMUFD
+    object_class_property_set_description(klass, /* 9.0 */
+                                          "iommufd",
+                                          "Set host IOMMUFD backend device");
+#endif
 }
 
 static const TypeInfo vfio_ap_info = {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 67bc137f9be6d43c5970c6271f3cdbfffd8a32de..ea766ae26c744c05515e1cc80a486a3462d82834 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -717,6 +717,21 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
     cdc->handle_halt = vfio_ccw_handle_halt;
     cdc->handle_clear = vfio_ccw_handle_clear;
     cdc->handle_store = vfio_ccw_handle_store;
+
+    object_class_property_set_description(klass, /* 2.10 */
+                                          "sysfsdev",
+                                          "Host sysfs path of assigned device");
+    object_class_property_set_description(klass, /* 3.0 */
+                                          "force-orb-pfch",
+                                          "Force unlimited prefetch");
+#ifdef CONFIG_IOMMUFD
+    object_class_property_set_description(klass, /* 9.0 */
+                                          "iommufd",
+                                          "Set host IOMMUFD backend device");
+#endif
+    object_class_property_set_description(klass, /* 9.2 */
+                                          "loadparm",
+                                          "Define which devices that can be used for booting");
 }
 
 static const TypeInfo vfio_ccw_info = {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 89d900e9cf0ce364f7c813d81b0317bb3b3e80ca..4f92b50b133060c9199079a0ab620793ecdac0ee 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3433,6 +3433,122 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
     pdc->exit = vfio_exitfn;
     pdc->config_read = vfio_pci_read_config;
     pdc->config_write = vfio_pci_write_config;
+
+    object_class_property_set_description(klass, /* 1.3 */
+                                          "host",
+                                          "Host PCI address [domain:]<bus:slot.function> of assigned device");
+    object_class_property_set_description(klass, /* 1.3 */
+                                          "x-intx-mmap-timeout-ms",
+                                          "When EOI is not provided by KVM/QEMU, wait time "
+                                          "(milliseconds) to re-enable device direct access "
+                                          "after INTx (DEBUG)");
+    object_class_property_set_description(klass, /* 1.5 */
+                                          "x-vga",
+                                          "Expose VGA address spaces for device");
+    object_class_property_set_description(klass, /* 2.3 */
+                                          "x-req",
+                                          "Disable device request notification support (DEBUG)");
+    object_class_property_set_description(klass, /* 2.4 and 2.5 */
+                                          "x-no-mmap",
+                                          "Disable MMAP for device. Allows to trace MMIO "
+                                          "accesses (DEBUG)");
+    object_class_property_set_description(klass, /* 2.5 */
+                                          "x-no-kvm-intx",
+                                          "Disable direct VFIO->KVM INTx injection. Allows to "
+                                          "trace INTx interrupts (DEBUG)");
+    object_class_property_set_description(klass, /* 2.5 */
+                                          "x-no-kvm-msi",
+                                          "Disable direct VFIO->KVM MSI injection. Allows to "
+                                          "trace MSI interrupts (DEBUG)");
+    object_class_property_set_description(klass, /* 2.5 */
+                                          "x-no-kvm-msix",
+                                          "Disable direct VFIO->KVM MSIx injection. Allows to "
+                                          "trace MSIx interrupts (DEBUG)");
+    object_class_property_set_description(klass, /* 2.5 */
+                                          "x-pci-vendor-id",
+                                          "Override PCI Vendor ID with provided value (DEBUG)");
+    object_class_property_set_description(klass, /* 2.5 */
+                                          "x-pci-device-id",
+                                          "Override PCI device ID with provided value (DEBUG)");
+    object_class_property_set_description(klass, /* 2.5 */
+                                          "x-pci-sub-vendor-id",
+                                          "Override PCI Subsystem Vendor ID with provided value "
+                                          "(DEBUG)");
+    object_class_property_set_description(klass, /* 2.5 */
+                                          "x-pci-sub-device-id",
+                                          "Override PCI Subsystem Device ID with provided value "
+                                          "(DEBUG)");
+    object_class_property_set_description(klass, /* 2.6 */
+                                          "sysfsdev",
+                                          "Host sysfs path of assigned device");
+    object_class_property_set_description(klass, /* 2.7 */
+                                          "x-igd-opregion",
+                                          "Expose host IGD OpRegion to guest");
+    object_class_property_set_description(klass, /* 2.7 (See c4c45e943e51) */
+                                          "x-igd-gms",
+                                          "Override IGD data stolen memory size (32MiB units)");
+    object_class_property_set_description(klass, /* 2.11 */
+                                          "x-nv-gpudirect-clique",
+                                          "Add NVIDIA GPUDirect capability indicating P2P DMA "
+                                          "clique for device [0-15]");
+    object_class_property_set_description(klass, /* 2.12 */
+                                          "x-no-geforce-quirks",
+                                          "Disable GeForce quirks (for NVIDIA Quadro/GRID/Tesla). "
+                                          "Improves performance");
+    object_class_property_set_description(klass, /* 2.12 */
+                                          "display",
+                                          "Enable display support for device, ex. vGPU");
+    object_class_property_set_description(klass, /* 2.12 */
+                                          "x-msix-relocation",
+                                          "Specify MSI-X MMIO relocation to the end of specified "
+                                          "existing BAR or new BAR to avoid virtualization overhead "
+                                          "due to adjacent device registers");
+    object_class_property_set_description(klass, /* 3.0 */
+                                          "x-no-kvm-ioeventfd",
+                                          "Disable registration of ioeventfds with KVM (DEBUG)");
+    object_class_property_set_description(klass, /* 3.0 */
+                                          "x-no-vfio-ioeventfd",
+                                          "Disable linking of KVM ioeventfds to VFIO ioeventfds "
+                                          "(DEBUG)");
+    object_class_property_set_description(klass, /* 3.1 */
+                                          "x-balloon-allowed",
+                                          "Override allowing ballooning with device (DEBUG, DANGER)");
+    object_class_property_set_description(klass, /* 3.2 */
+                                          "xres",
+                                          "Set X display resolution the vGPU should use");
+    object_class_property_set_description(klass, /* 3.2 */
+                                          "yres",
+                                          "Set Y display resolution the vGPU should use");
+    object_class_property_set_description(klass, /* 5.2 */
+                                          "x-pre-copy-dirty-page-tracking",
+                                          "Disable dirty pages tracking during iterative phase "
+                                          "(DEBUG)");
+    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
+                                          "enable-migration",
+                                          "Enale device migration. Also requires a host VFIO PCI "
+                                          "variant or mdev driver with migration support enabled");
+    object_class_property_set_description(klass, /* 8.1 */
+                                          "vf-token",
+                                          "Specify UUID VF token. Required for VF when PF is owned "
+                                          "by another VFIO driver");
+#ifdef CONFIG_IOMMUFD
+    object_class_property_set_description(klass, /* 9.0 */
+                                          "iommufd",
+                                          "Set host IOMMUFD backend device");
+#endif
+    object_class_property_set_description(klass, /* 9.1 */
+                                          "x-device-dirty-page-tracking",
+                                          "Disable device dirty page tracking and use "
+                                          "container-based dirty page tracking (DEBUG)");
+    object_class_property_set_description(klass, /* 9.1 */
+                                          "migration-events",
+                                          "Emit VFIO migration QAPI event when a VFIO device "
+                                          "changes its migration state. For management applications");
+    object_class_property_set_description(klass, /* 9.1 */
+                                          "skip-vsc-check",
+                                          "Skip config space check for Vendor Specific Capability. "
+                                          "Setting to false will enforce strict checking of VSC content "
+                                          "(DEBUG)");
 }
 
 static const TypeInfo vfio_pci_dev_info = {
@@ -3461,6 +3577,15 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
     dc->hotpluggable = false;
+
+    object_class_property_set_description(klass, /* 3.1 */
+                                          "ramfb",
+                                          "Enable ramfb to provide pre-boot graphics for devices "
+                                          "enabling display option");
+    object_class_property_set_description(klass, /* 8.2 */
+                                          "x-ramfb-migrate",
+                                          "Override default migration support for ramfb support "
+                                          "(DEBUG)");
 }
 
 static const TypeInfo vfio_pci_nohotplug_dev_info = {
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index f491f4dc9543c2ea3a7af4e51ee82fbc7ee6e4bb..d9faaa73959ad36aa3a835b87964ab940928bd9f 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -672,6 +672,30 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
     dc->desc = "VFIO-based platform device assignment";
     sbc->connect_irq_notifier = vfio_start_irqfd_injection;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+
+    object_class_property_set_description(klass, /* 2.4 */
+                                          "host",
+                                          "Host device name of assigned device");
+    object_class_property_set_description(klass, /* 2.4 and 2.5 */
+                                          "x-no-mmap",
+                                          "Disable MMAP for device. Allows to trace MMIO "
+                                          "accesses (DEBUG)");
+    object_class_property_set_description(klass, /* 2.4 */
+                                          "mmap-timeout-ms",
+                                          "When EOI is not provided by KVM/QEMU, wait time "
+                                          "(milliseconds) to re-enable device direct access "
+                                          "after level interrupt (DEBUG)");
+    object_class_property_set_description(klass, /* 2.4 */
+                                          "x-irqfd",
+                                          "Allow disabling irqfd support (DEBUG)");
+    object_class_property_set_description(klass, /* 2.6 */
+                                          "sysfsdev",
+                                          "Host sysfs path of assigned device");
+#ifdef CONFIG_IOMMUFD
+    object_class_property_set_description(klass, /* 9.0 */
+                                          "iommufd",
+                                          "Set host IOMMUFD backend device");
+#endif
 }
 
 static const TypeInfo vfio_platform_dev_info = {
-- 
2.48.1


