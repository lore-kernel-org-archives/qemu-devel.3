Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241B3C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0rD-0003i0-Kw; Wed, 02 Jul 2025 13:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0rA-0003hi-Us
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0r9-0003bo-34
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751475766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvVRTJZEvErlhar5PkD4f+2MBTmfmoT9N45UB/olhLk=;
 b=AuafQi+sOOA/6HiDTLLLUG3N4Ds8zIh8pq/KmNqVYx/pe3lmOTbexiNL0ln7KPIqpedEnY
 3ae5lrtiy/otC/fVJ4ul6R2can6HvD9GVp1vEght5/+E7gt9UvWoPYLf3tgB0UY1da9jon
 73DjE9qCblkmX2F1p9G3H8gNCR2LUQU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-m-H7B2WWOKOXa-wlkOZWlQ-1; Wed,
 02 Jul 2025 13:02:44 -0400
X-MC-Unique: m-H7B2WWOKOXa-wlkOZWlQ-1
X-Mimecast-MFC-AGG-ID: m-H7B2WWOKOXa-wlkOZWlQ_1751475764
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F180F185FEFD; Wed,  2 Jul 2025 17:02:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18858195608F; Wed,  2 Jul 2025 17:02:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Sean Wei <me@sean.taipei>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 4/9] treewide: update docs file extensions (.txt -> .rst) in
 comments
Date: Wed,  2 Jul 2025 19:01:59 +0200
Message-ID: <20250702170206.212303-5-thuth@redhat.com>
In-Reply-To: <20250702170206.212303-1-thuth@redhat.com>
References: <20250702170206.212303-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Sean Wei <me@sean.taipei>

Several source comments still refer to docs with the old .txt
extension that were previously converted to reStructuredText.

Update these references to use the correct .rst extensions to
maintain accurate in-tree documentation pointers.

No functional changes.

Related commits:
  50f8174c5c1 (Jul 2021): docs/specs/acpi_nvdimm: Convert to rST
  f054eb1c920 (Jul 2021): docs/specs/acpi_pci_hotplug: Convert to rST
  912fb3678b8 (Sep 2023): docs/specs/vmgenid: Convert to rST
  bb1cff6ee04 (Sep 2023): docs/specs/ivshmem-spec: Convert to rST
  55ff468f781 (Jan 2022): docs: Rename ppc-spapr-hotplug.txt to .rst

Signed-off-by: Sean Wei <me@sean.taipei>
Message-ID: <20250616.qemu.relocated.05@sean.taipei>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/acpi/pcihp.h        | 2 +-
 include/hw/misc/ivshmem-flat.h | 2 +-
 hw/acpi/nvdimm.c               | 2 +-
 hw/acpi/pcihp.c                | 2 +-
 hw/acpi/vmgenid.c              | 6 +++---
 hw/misc/ivshmem-flat.c         | 2 +-
 hw/ppc/spapr.c                 | 2 +-
 tests/qtest/vmgenid-test.c     | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index a97904badaa..cdc0cb8e436 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -3,7 +3,7 @@
  *
  * QEMU supports PCI hotplug via ACPI. This module
  * implements the interface between QEMU and the ACPI BIOS.
- * Interface specification - see docs/specs/acpi_pci_hotplug.txt
+ * Interface specification - see docs/specs/acpi_pci_hotplug.rst
  *
  * Copyright (c) 2013, Red Hat Inc, Michael S. Tsirkin (mst@redhat.com)
  * Copyright (c) 2006 Fabrice Bellard
diff --git a/include/hw/misc/ivshmem-flat.h b/include/hw/misc/ivshmem-flat.h
index 09bc3abcad3..3eca99004ef 100644
--- a/include/hw/misc/ivshmem-flat.h
+++ b/include/hw/misc/ivshmem-flat.h
@@ -36,7 +36,7 @@ typedef struct IvshmemFTState IvshmemFTState;
 
 DECLARE_INSTANCE_CHECKER(IvshmemFTState, IVSHMEM_FLAT, TYPE_IVSHMEM_FLAT)
 
-/* Ivshmem registers. See ./docs/specs/ivshmem-spec.txt for details. */
+/* Ivshmem registers. See docs/specs/ivshmem-spec.rst for details. */
 enum ivshmem_registers {
     INTMASK = 0,
     INTSTATUS = 4,
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9ba90806f26..732d613ac09 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -535,7 +535,7 @@ nvdimm_dsm_no_payload(uint32_t func_ret_status, hwaddr dsm_mem_addr)
 
 #define NVDIMM_QEMU_RSVD_HANDLE_ROOT         0x10000
 
-/* Read FIT data, defined in docs/specs/acpi_nvdimm.txt. */
+/* Read FIT data, defined in docs/specs/acpi_nvdimm.rst. */
 static void nvdimm_dsm_func_read_fit(NVDIMMState *state, NvdimmDsmIn *in,
                                      hwaddr dsm_mem_addr)
 {
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index aac90013d4a..497281ae200 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -3,7 +3,7 @@
  *
  * QEMU supports PCI hotplug via ACPI. This module
  * implements the interface between QEMU and the ACPI BIOS.
- * Interface specification - see docs/specs/acpi_pci_hotplug.txt
+ * Interface specification - see docs/specs/acpi_pci_hotplug.rst
  *
  * Copyright (c) 2013, Red Hat Inc, Michael S. Tsirkin (mst@redhat.com)
  * Copyright (c) 2006 Fabrice Bellard
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index fac3d6d97e7..33c35c85dd4 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -38,7 +38,7 @@ void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
     guid_le = qemu_uuid_bswap(vms->guid);
     /* The GUID is written at a fixed offset into the fw_cfg file
      * in order to implement the "OVMF SDT Header probe suppressor"
-     * see docs/specs/vmgenid.txt for more details
+     * see docs/specs/vmgenid.rst for more details
      */
     g_array_insert_vals(guid, VMGENID_GUID_OFFSET, guid_le.data,
                         ARRAY_SIZE(guid_le.data));
@@ -101,7 +101,7 @@ void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
      * < 4GB, but write 64 bits anyway.
      * The address that is patched in is offset in order to implement
      * the "OVMF SDT Header probe suppressor"
-     * see docs/specs/vmgenid.txt for more details.
+     * see docs/specs/vmgenid.rst for more details.
      */
     bios_linker_loader_write_pointer(linker,
         VMGENID_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
@@ -153,7 +153,7 @@ static void vmgenid_update_guest(VmGenIdState *vms)
             guid_le = qemu_uuid_bswap(vms->guid);
             /* The GUID is written at a fixed offset into the fw_cfg file
              * in order to implement the "OVMF SDT Header probe suppressor"
-             * see docs/specs/vmgenid.txt for more details.
+             * see docs/specs/vmgenid.rst for more details.
              */
             cpu_physical_memory_write(vmgenid_addr, guid_le.data,
                                       sizeof(guid_le.data));
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index be28c24d73e..fe4be6be178 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -362,7 +362,7 @@ static bool ivshmem_flat_connect_server(DeviceState *dev, Error **errp)
      *
      *  ivshmem_flat_recv_msg() calls return 'msg' and 'fd'.
      *
-     *  See ./docs/specs/ivshmem-spec.txt for details on the protocol.
+     *  See docs/specs/ivshmem-spec.rst for details on the protocol.
      */
 
     /* Step 0 */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 702f774cda9..08615f6c905 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -577,7 +577,7 @@ static int spapr_dt_dynamic_memory(SpaprMachineState *spapr, void *fdt,
 
 /*
  * Adds ibm,dynamic-reconfiguration-memory node.
- * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
+ * Refer to docs/specs/ppc-spapr-hotplug.rst for the documentation
  * of this device tree node.
  */
 static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
diff --git a/tests/qtest/vmgenid-test.c b/tests/qtest/vmgenid-test.c
index e613374665e..33e96b7c559 100644
--- a/tests/qtest/vmgenid-test.c
+++ b/tests/qtest/vmgenid-test.c
@@ -61,7 +61,7 @@ static uint32_t acpi_find_vgia(QTestState *qts)
 
             /* The GUID is written at a fixed offset into the fw_cfg file
              * in order to implement the "OVMF SDT Header probe suppressor"
-             * see docs/specs/vmgenid.txt for more details
+             * see docs/specs/vmgenid.rst for more details
              */
             guid_offset = le32_to_cpu(vgia_val) + VMGENID_GUID_OFFSET;
             g_free(table_aml);
-- 
2.50.0


