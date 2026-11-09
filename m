Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495D606A337
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RbkQMmeR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLL7-0002md-Uc; Mon, 09 Nov 2026 04:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLKy-0002fP-H2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLKt-0002sr-Gy
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794215202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLaOapSmndLuPGBkv7Vi5jvN5v8bBVecK9YYJuZXkk4=;
 b=RbkQMmeRf9DTflJgPiCgoKT2CFIczquf8azepOY/SVAfsUmxFzZB5j7f95V5kc45Z20t0b
 92niwEZSi4adSgVfvUgaUxbtZl0uWp36v+OgrCEWzu8aoZ42H6diuYYg2bAwA3ComJDwgQ
 mLkH5d9JplOHx5Bu5Sjz5HnOkk0VoRA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-OEpRVT7iPx6rh0B0Zq5aQw-1; Mon,
 09 Nov 2026 04:06:41 -0500
X-MC-Unique: OEpRVT7iPx6rh0B0Zq5aQw-1
X-Mimecast-MFC-AGG-ID: OEpRVT7iPx6rh0B0Zq5aQw_1794215200
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E86E1800555; Mon,  9 Nov 2026 09:06:40 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5059230000E5; Mon,  9 Nov 2026 09:06:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-12.0 6/9] vfio/pci: Rename capability functions
Date: Mon,  9 Nov 2026 10:06:22 +0100
Message-ID: <20261109090625.908592-7-clg@redhat.com>
In-Reply-To: <20261109090625.908592-1-clg@redhat.com>
References: <20261109090625.908592-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

  vfio_add_emulated_word      -> vfio_pci_cap_add_emulated_word
  vfio_add_emulated_long      -> vfio_pci_cap_add_emulated_long
  vfio_pci_disable_rp_atomics -> vfio_pci_cap_disable_rp_atomics

No functional change.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h      | 10 +++++-----
 hw/vfio/pci-caps.c | 32 ++++++++++++++++----------------
 hw/vfio/pci.c      | 12 ++++++------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 6fb2575053fa..2d0237b9afce 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -263,11 +263,11 @@ void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
 void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
 
 /* Capabilities */
-void vfio_add_emulated_word(VFIOPCIDevice *vdev, int pos,
-                            uint16_t val, uint16_t mask);
-void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
-                            uint32_t val, uint32_t mask);
-void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev);
+void vfio_pci_cap_add_emulated_word(VFIOPCIDevice *vdev, int pos,
+                                    uint16_t val, uint16_t mask);
+void vfio_pci_cap_add_emulated_long(VFIOPCIDevice *vdev, int pos,
+                                    uint32_t val, uint32_t mask);
+void vfio_pci_cap_disable_rp_atomics(VFIOPCIDevice *vdev);
 bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
 
 /* Quirks */
diff --git a/hw/vfio/pci-caps.c b/hw/vfio/pci-caps.c
index 6c4fb8db4209..df0759d38b22 100644
--- a/hw/vfio/pci-caps.c
+++ b/hw/vfio/pci-caps.c
@@ -59,7 +59,7 @@ static void vfio_set_word_bits(uint8_t *buf, uint16_t val, uint16_t mask)
     pci_set_word(buf, (pci_get_word(buf) & ~mask) | val);
 }
 
-void vfio_add_emulated_word(VFIOPCIDevice *vdev, int pos,
+void vfio_pci_cap_add_emulated_word(VFIOPCIDevice *vdev, int pos,
                             uint16_t val, uint16_t mask)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
@@ -74,7 +74,7 @@ static void vfio_set_long_bits(uint8_t *buf, uint32_t val, uint32_t mask)
     pci_set_long(buf, (pci_get_long(buf) & ~mask) | val);
 }
 
-void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
+void vfio_pci_cap_add_emulated_long(VFIOPCIDevice *vdev, int pos,
                             uint32_t val, uint32_t mask)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
@@ -148,7 +148,7 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
     vdev->clear_parent_atomics_on_exit = true;
 }
 
-void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
+void vfio_pci_cap_disable_rp_atomics(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
 
@@ -220,15 +220,15 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
          * Endpoints, which changes the type and clears the LNK & LNK2 fields.
          */
         if (type == PCI_EXP_TYPE_ENDPOINT) {
-            vfio_add_emulated_word(vdev, pos + PCI_CAP_FLAGS,
+            vfio_pci_cap_add_emulated_word(vdev, pos + PCI_CAP_FLAGS,
                                    PCI_EXP_TYPE_RC_END << 4,
                                    PCI_EXP_FLAGS_TYPE);
 
             /* Link Capabilities, Status, and Control goes away */
             if (size > PCI_EXP_LNKCTL) {
-                vfio_add_emulated_long(vdev, pos + PCI_EXP_LNKCAP, 0, ~0);
-                vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
-                vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKSTA, 0, ~0);
+                vfio_pci_cap_add_emulated_long(vdev, pos + PCI_EXP_LNKCAP, 0, ~0);
+                vfio_pci_cap_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
+                vfio_pci_cap_add_emulated_word(vdev, pos + PCI_EXP_LNKSTA, 0, ~0);
 
 #ifndef PCI_EXP_LNKCAP2
 #define PCI_EXP_LNKCAP2 44
@@ -238,9 +238,9 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
 #endif
                 /* Link 2 Capabilities, Status, and Control goes away */
                 if (size > PCI_EXP_LNKCAP2) {
-                    vfio_add_emulated_long(vdev, pos + PCI_EXP_LNKCAP2, 0, ~0);
-                    vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL2, 0, ~0);
-                    vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKSTA2, 0, ~0);
+                    vfio_pci_cap_add_emulated_long(vdev, pos + PCI_EXP_LNKCAP2, 0, ~0);
+                    vfio_pci_cap_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL2, 0, ~0);
+                    vfio_pci_cap_add_emulated_word(vdev, pos + PCI_EXP_LNKSTA2, 0, ~0);
                 }
             }
 
@@ -258,13 +258,13 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
          * These devices don't support LNK/LNK2 capabilities, so make them up.
          */
         if (type == PCI_EXP_TYPE_RC_END) {
-            vfio_add_emulated_word(vdev, pos + PCI_CAP_FLAGS,
+            vfio_pci_cap_add_emulated_word(vdev, pos + PCI_CAP_FLAGS,
                                    PCI_EXP_TYPE_ENDPOINT << 4,
                                    PCI_EXP_FLAGS_TYPE);
-            vfio_add_emulated_long(vdev, pos + PCI_EXP_LNKCAP,
+            vfio_pci_cap_add_emulated_long(vdev, pos + PCI_EXP_LNKCAP,
                            QEMU_PCI_EXP_LNKCAP_MLW(QEMU_PCI_EXP_LNK_X1) |
                            QEMU_PCI_EXP_LNKCAP_MLS(QEMU_PCI_EXP_LNK_2_5GT), ~0);
-            vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
+            vfio_pci_cap_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
         }
 
         vfio_pci_enable_rp_atomics(vdev);
@@ -278,7 +278,7 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
      * config space.
      */
     if ((flags & PCI_EXP_FLAGS_VERS) == 0) {
-        vfio_add_emulated_word(vdev, pos + PCI_CAP_FLAGS,
+        vfio_pci_cap_add_emulated_word(vdev, pos + PCI_CAP_FLAGS,
                                1, PCI_EXP_FLAGS_VERS);
     }
 
@@ -476,8 +476,8 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
          * BAR size.  A write of an unsupported value is undefined, therefore
          * the register field is essentially RO.
          */
-        vfio_add_emulated_long(vdev, pos + PCI_REBAR_CAP + (i * 8), cap, ~0);
-        vfio_add_emulated_long(vdev, pos + PCI_REBAR_CTRL + (i * 8), ctrl, ~0);
+        vfio_pci_cap_add_emulated_long(vdev, pos + PCI_REBAR_CAP + (i * 8), cap, ~0);
+        vfio_pci_cap_add_emulated_long(vdev, pos + PCI_REBAR_CTRL + (i * 8), ctrl, ~0);
     }
 
     return 0;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a8a6b7b030fa..a52bdfaf1f83 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1158,7 +1158,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
             error_setg(errp, "invalid PCI vendor ID provided");
             return false;
         }
-        vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
+        vfio_pci_cap_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
         trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
     } else {
         vdev->vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
@@ -1169,7 +1169,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
             error_setg(errp, "invalid PCI device ID provided");
             return false;
         }
-        vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
+        vfio_pci_cap_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
         trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
     } else {
         vdev->device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
@@ -1180,7 +1180,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
             error_setg(errp, "invalid PCI subsystem vendor ID provided");
             return false;
         }
-        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
+        vfio_pci_cap_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
                                vdev->sub_vendor_id, ~0);
         trace_vfio_pci_emulated_sub_vendor_id(vbasedev->name,
                                               vdev->sub_vendor_id);
@@ -1191,7 +1191,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
             error_setg(errp, "invalid PCI subsystem device ID provided");
             return false;
         }
-        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
+        vfio_pci_cap_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
         trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
                                               vdev->sub_device_id);
     }
@@ -1206,7 +1206,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
             return false;
         }
         /* Higher 24 bits of PCI_CLASS_REVISION are class code */
-        vfio_add_emulated_long(vdev, PCI_CLASS_REVISION,
+        vfio_pci_cap_add_emulated_long(vdev, PCI_CLASS_REVISION,
                                vdev->class_code << 8, ~0xff);
         trace_vfio_pci_emulated_class_code(vbasedev->name, vdev->class_code);
     } else {
@@ -1433,7 +1433,7 @@ static void vfio_exitfn(PCIDevice *pdev)
         timer_free(vdev->intx.mmap_timer);
     }
     vfio_pci_msi_teardown(vdev);
-    vfio_pci_disable_rp_atomics(vdev);
+    vfio_pci_cap_disable_rp_atomics(vdev);
     vfio_pci_bars_exit(vdev);
     vfio_migration_exit(vbasedev);
     if (!vbasedev->mdev) {
-- 
2.56.0


