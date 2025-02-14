Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28494C021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwlz-0002tr-SM; Fri, 14 Feb 2025 09:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiwlx-0002tD-NH
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:34:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiwlu-0007eF-Vq
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739543665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LkPS0FGDxU+t+9lUB5LeY1ecp32+uH20EfBO9h0BOpk=;
 b=NyQg5hbfVZpqx/ZSG4UQOcEy6UBbWo6YVPXRXGQHntW+oDmp/LsJ8/Q6IatjeffNfRh8Vv
 lNi1gTzXoXD1fb0WlqKdFtWga5t8T43C6aQz8MvP3XosWcbK/fLifQHWIhTdaBbMXCzMy+
 p+lGinc9zdoBGAXgAnE/hDNodu0sHXo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-lf3SCU5YP3GBK2jhNM2jTA-1; Fri,
 14 Feb 2025 09:34:24 -0500
X-MC-Unique: lf3SCU5YP3GBK2jhNM2jTA-1
X-Mimecast-MFC-AGG-ID: lf3SCU5YP3GBK2jhNM2jTA_1739543662
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F17D7180098B; Fri, 14 Feb 2025 14:34:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A1851800359; Fri, 14 Feb 2025 14:34:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, tomitamoeko@gmail.com,
 corvin.koehne@gmail.com, Kirti Wankhede <kwankhede@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v3] vfio: Add property documentation
Date: Fri, 14 Feb 2025 15:34:15 +0100
Message-ID: <20250214143415.1686526-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Should we introduce documentation for properties like the kernel has
 in Documentation/ABI/*/sysfs-* ?

 Changes in v3:

 - Re-organized the vfio-pci properties based on the QEMU version in
   which they were introduced
 - Added property labels
 - Improved description as suggested by Alex, Tomita and Corvin

 Changes in v2:

 - Fixed version numbers
 - Fixed #ifdef in vfio/ccw.c
 - Addressed vfio-pci-nohotplug
 - Organize the vfio-pci properties in topics
 
 hw/vfio/ap.c       |   9 ++++
 hw/vfio/ccw.c      |  15 ++++++
 hw/vfio/pci.c      | 122 +++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/platform.c |  25 ++++++++++
 4 files changed, 171 insertions(+)

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
index 9a55e7b77324babf7295132b08e3ba23b482a291..cdf4cdcf88c143ff145427cae3fd64239a2d1e74 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3433,6 +3433,119 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
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
+                                          "Override PCI Sub Vendor ID with provided value (DEBUG)");
+    object_class_property_set_description(klass, /* 2.5 */
+                                          "x-pci-sub-device-id",
+                                          "Override PCI Sub Device ID with provided value (DEBUG)");
+    object_class_property_set_description(klass, /* 2.6 */
+                                          "sysfsdev",
+                                          "Host sysfs path of assigned device");
+    object_class_property_set_description(klass, /* 2.7 */
+                                          "x-igd-opregion",
+                                          "Expose host IGD OpRegion to guest");
+    object_class_property_set_description(klass, /* 2.7 (See c4c45e943e51) */
+                                          "x-igd-gms",
+                                          "Override IGD data stolen memory size (32MiB units). "
+                                          "Assign 00:02.0 from the host to 00:02.0 in the VM");
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
+                                          "due to adjacent device registers (sPAPR)");
+    object_class_property_set_description(klass, /* 3.0 */
+                                          "x-no-kvm-ioeventfd",
+                                          "Disable registration of ioeventfds with KVM (DEBUG)");
+    object_class_property_set_description(klass, /* 3.0 */
+                                          "x-no-vfio-ioeventfd",
+                                          "Disable linking of KVM ioeventfds to VFIO ioeventfds"
+                                          " (NVIDIA, DEBUG)");
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
+                                          "Disable dirty pages tracking during iterative phase");
+    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
+                                          "enable-migration",
+                                          "Enale device migration. Also requires a host VFIO PCI "
+                                          "variant driver with migration support enabled");
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
+                                          "container-based dirty page tracking");
+    object_class_property_set_description(klass, /* 9.1 */
+                                          "migration-events",
+                                          "Emit VFIO migration QAPI event when a VFIO device "
+                                          "changes its migration state. For management applications");
+    object_class_property_set_description(klass, /* 9.1 */
+                                          "skip-vsc-check",
+                                          "Skip config space check for Vendor Specific Capability "
+                                          "(NVIDIA, DEBUG)");
 }
 
 static const TypeInfo vfio_pci_dev_info = {
@@ -3461,6 +3574,15 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
 
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
index 1070a2113a17edb9ebafb5066e51ee2bc52a767d..61b8b856fac26e26a4805dc2d5e65266b907ef58 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -674,6 +674,31 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     /* Supported by TYPE_VIRT_MACHINE */
     dc->user_creatable = true;
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
+                                          "after INTx (DEBUG)");
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
+
 }
 
 static const TypeInfo vfio_platform_dev_info = {
-- 
2.48.1


