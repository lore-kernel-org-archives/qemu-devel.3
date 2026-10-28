Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B42606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QD/3xw8d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1K2-0004js-4A; Wed, 28 Oct 2026 06:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xM1K0-0004jW-3h
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xM1Jx-00089N-Pl
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793184952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GncdD7XcsCRIIPALGMHxfVH3670zLhGkPF4eiu7u/0Y=;
 b=QD/3xw8dgit6KEBVhSDl76mreF9SLIPzUgC7ssPNbjfUyICWl3QDcF7rYmX8nsfyu661VK
 9Hg4SCbY9n0gZ1aaAbvc5JD23WENIAgyQh4Vqo4C787kK0pa/UbxcK1IFr8rwGpz9lr4Bu
 iUDWaV9KOO86n11vNnGNToXlGH9K8xA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-cmQ7NxXYORST3RbmKvHJwQ-1; Wed,
 28 Oct 2026 06:55:51 -0400
X-MC-Unique: cmQ7NxXYORST3RbmKvHJwQ-1
X-Mimecast-MFC-AGG-ID: cmQ7NxXYORST3RbmKvHJwQ_1793184950
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E364A18004BB; Wed, 28 Oct 2026 10:55:49 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 583CE1955F21; Wed, 28 Oct 2026 10:55:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/pci: Reorganize pci.h declarations into sections
Date: Wed, 28 Oct 2026 11:55:43 +0100
Message-ID: <20261028105543.1287795-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Group function declarations in pci.h by topic for better readability.

No functional change.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h | 62 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c9ab9498708ec0343e206c7f343085b0be8a7a1e..7ff52e9a526561301dd4fd0c2fa3c9f7ac09f74b 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -221,28 +221,33 @@ bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
 void vfio_pci_intx_set_handler(VFIOPCIDevice *vdev, bool enable);
 void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
 void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr, bool enable);
+bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_intx_eoi(VFIODevice *vbasedev);
+void vfio_pci_teardown_msi(VFIOPCIDevice *vdev);
 
+/* Config space */
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len);
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_config_register_vga(VFIOPCIDevice *vdev);
+
+/* ROM */
+bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
 
+/* VGA */
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
+bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
-/**
- * vfio_pci_from_vfio_device: Transform from VFIODevice to
- * VFIOPCIDevice
- *
- * This function checks if the given @vbasedev is a VFIO PCI device.
- * If it is, it returns the containing VFIOPCIDevice.
- *
- * @vbasedev: The VFIODevice to transform
- *
- * Return: The VFIOPCIDevice on success, NULL on failure.
- */
-VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev);
+/* BARs */
+void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
 void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
-bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
+
+/* Capabilities */
+bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
+
+/* Quirks */
 bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_vga_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_vga_quirk_exit(VFIOPCIDevice *vdev);
@@ -256,12 +261,14 @@ void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
 
+/* IGD */
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
 bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
 void vfio_igd_legacy_rom_quirk(VFIOPCIDevice *vdev);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
+/* Reset */
 struct vfio_pci_hot_reset_info;
 
 void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
@@ -270,25 +277,30 @@ bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
 int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
                                     struct vfio_pci_hot_reset_info **info_p);
 
-bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
-
+/* Display */
 void vfio_display_reset(VFIOPCIDevice *vdev);
 bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_exit(VFIOPCIDevice *vdev);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
-
 extern const VMStateDescription vfio_display_vmstate;
 
-void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
-bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
-void vfio_pci_config_register_vga(VFIOPCIDevice *vdev);
-bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
-bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
-void vfio_pci_intx_eoi(VFIODevice *vbasedev);
-void vfio_pci_put_device(VFIOPCIDevice *vdev);
-bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp);
+/* Notifiers */
 void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev);
 void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev);
-void vfio_pci_teardown_msi(VFIOPCIDevice *vdev);
+
+/**
+ * vfio_pci_from_vfio_device: Transform from VFIODevice to
+ * VFIOPCIDevice
+ *
+ * This function checks if the given @vbasedev is a VFIO PCI device.
+ * If it is, it returns the containing VFIOPCIDevice.
+ *
+ * @vbasedev: The VFIODevice to transform
+ *
+ * Return: The VFIOPCIDevice on success, NULL on failure.
+ */
+VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev);
+void vfio_pci_put_device(VFIOPCIDevice *vdev);
+bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp);
 
 #endif /* HW_VFIO_VFIO_PCI_H */
-- 
2.56.0


