Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6940D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Gu-0003Uv-E6; Mon, 04 Nov 2024 16:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Gq-0003O2-NR
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Go-0005H5-Lu
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkIaQdD7KqQ1sn0ggnRpjbZ4514ooYNFoj1fek6Hj2E=;
 b=cvV+tHowbmiTvsawdFcufeX92ArmeYQRAHgAznbkKAf0JeNqLUb5kD6VZceVCoB6w/lSNb
 oqUKkze3wFPBkh6e2Y1mCwtKqWf+i963PVlBvbBQW9kjSZjy0XIG+nyH/ae0BoJn19XDyz
 DaUA05Zr4em1p8j544kjgAkoIvcvqcw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-BXn_JaTVN0iwhSnCvow5_Q-1; Mon, 04 Nov 2024 16:05:50 -0500
X-MC-Unique: BXn_JaTVN0iwhSnCvow5_Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a9a0d8baa2cso541621566b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754348; x=1731359148;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lkIaQdD7KqQ1sn0ggnRpjbZ4514ooYNFoj1fek6Hj2E=;
 b=ey0rFns5gDJSLMjiav6bqVFSe+4jah6Osbi+HSR1/sfNwMWp1O3w5ePJ+2Qp+1u/6b
 5qwdOOk0HvzuYXyx5ezzUo6YoqkDGQ7I9+XR/IVrjBD5Z04H2gfW4ycOqE83hGx/KiBK
 5KLfhRZ2FtzLLnaRl8vw4u953Nt5q0lf9zh6uHsZPs+ZZUgFtc93k7ZeKe2P6OdRcLXF
 lFSWi2qw9bAqEBydmhHqaizz1+MzIW+YiB3djRNpa93we5ZKJ5WzTy4+BbDGMEl4jgi5
 uuHnzsMNEz2S5cbr6sK45Y1IilIEvw+OlJoC/0pL0ONer8sianGX0G1f8FLJVRxUSdF3
 8V+A==
X-Gm-Message-State: AOJu0YxcOKNWunJ00Td+uLha+90npzFrFn0DTUtzqlslKHR09zpXijvG
 yN49bT3fy9nGS+kFeQDTCMfCJlJnXiQoG7/x9xgfBIuxogj8McEVtTUsHFDcl0HohhB+vOFNCJa
 lWsGqIiWw25UAeONce8QtXaaGC+kv93i/v0+ivBZgL6VdL8NatxXkO2AhqeOD/HmdRqX50K+CWr
 E12cL6qqyeTHhmt/N1aw4mgPgHm7+OrA==
X-Received: by 2002:a05:6402:26cb:b0:5c9:66c:660e with SMTP id
 4fb4d7f45d1cf-5ceb8de9894mr12336202a12.13.1730754348327; 
 Mon, 04 Nov 2024 13:05:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgas6UZcIYl/4VLPtRWdCiaexz7SnEURRqYZZAfda62Cx05BIXUEdytGBfWARXe+GE/DsGig==
X-Received: by 2002:a05:6402:26cb:b0:5c9:66c:660e with SMTP id
 4fb4d7f45d1cf-5ceb8de9894mr12336170a12.13.1730754347934; 
 Mon, 04 Nov 2024 13:05:47 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6ac399bsm299458a12.52.2024.11.04.13.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:05:46 -0800 (PST)
Date: Mon, 4 Nov 2024 16:05:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 05/65] hw/acpi: Move AML building code for Generic Initiators
 to aml_build.c
Message-ID: <d8a4b4c3b4dd258c5f5f6237473349d377ea7fc9.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Rather than attempting to create a generic function with mess of the two
different device handle types, use a PCI handle specific variant.  If the
ACPI handle form is needed then that can be introduced alongside this
with little duplicated code.

Drop the PCIDeviceHandle in favor of just passing the bus, devfn
and segment directly.  devfn kept as a single byte because ARI means
that in this case it is just an 8 bit function number.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20240618142333.102be976@imammedo.users.ipa.redhat.com/
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916171017.1841767-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi_generic_initiator.h | 23 -------------
 include/hw/acpi/aml-build.h              |  4 +++
 hw/acpi/acpi_generic_initiator.c         | 39 ++-------------------
 hw/acpi/aml-build.c                      | 44 ++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 59 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index a304bad73e..7b98676713 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -19,29 +19,6 @@ typedef struct AcpiGenericInitiator {
     uint16_t node;
 } AcpiGenericInitiator;
 
-/*
- * ACPI 6.3:
- * Table 5-81 Flags – Generic Initiator Affinity Structure
- */
-typedef enum {
-    /*
-     * If clear, the OSPM ignores the contents of the Generic
-     * Initiator/Port Affinity Structure. This allows system firmware
-     * to populate the SRAT with a static number of structures, but only
-     * enable them as necessary.
-     */
-    GEN_AFFINITY_ENABLED = (1 << 0),
-} GenericAffinityFlags;
-
-/*
- * ACPI 6.3:
- * Table 5-80 Device Handle - PCI
- */
-typedef struct PCIDeviceHandle {
-    uint16_t segment;
-    uint16_t bdf;
-} PCIDeviceHandle;
-
 void build_srat_generic_pci_initiator(GArray *table_data);
 
 #endif
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index a3784155cb..33eef85791 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -486,6 +486,10 @@ Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set, uint32_t io_offset,
 void build_srat_memory(GArray *table_data, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
+void build_srat_pci_generic_initiator(GArray *table_data, int node,
+                                      uint16_t segment, uint8_t bus,
+                                      uint8_t devfn);
+
 void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 4a02c19468..7665b16107 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -74,40 +74,11 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
         acpi_generic_initiator_set_node, NULL, NULL);
 }
 
-/*
- * ACPI 6.3:
- * Table 5-78 Generic Initiator Affinity Structure
- */
-static void
-build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
-                                          PCIDeviceHandle *handle)
-{
-    uint8_t index;
-
-    build_append_int_noprefix(table_data, 5, 1);  /* Type */
-    build_append_int_noprefix(table_data, 32, 1); /* Length */
-    build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
-    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type: PCI */
-    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
-
-    /* Device Handle - PCI */
-    build_append_int_noprefix(table_data, handle->segment, 2);
-    build_append_int_noprefix(table_data, PCI_BUS_NUM(handle->bdf), 1);
-    build_append_int_noprefix(table_data, PCI_BDF_TO_DEVFN(handle->bdf), 1);
-    for (index = 0; index < 12; index++) {
-        build_append_int_noprefix(table_data, 0, 1);
-    }
-
-    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* Flags */
-    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
-}
-
 static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     AcpiGenericInitiator *gi;
     GArray *table_data = opaque;
-    PCIDeviceHandle dev_handle;
     PCIDevice *pci_dev;
     Object *o;
 
@@ -130,13 +101,9 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
     }
 
     pci_dev = PCI_DEVICE(o);
-
-    dev_handle.segment = 0;
-    dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
-                                   pci_dev->devfn);
-
-    build_srat_generic_pci_initiator_affinity(table_data,
-                                              gi->node, &dev_handle);
+    build_srat_pci_generic_initiator(table_data, gi->node, 0,
+                                     pci_bus_num(pci_get_bus(pci_dev)),
+                                     pci_dev->devfn);
 
     return 0;
 }
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 34e0ddbde8..aeb4cb94e8 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1937,6 +1937,50 @@ void build_srat_memory(GArray *table_data, uint64_t base,
     build_append_int_noprefix(table_data, 0, 8); /* Reserved */
 }
 
+/*
+ * ACPI Spec Revision 6.3
+ * Table 5-80 Device Handle - PCI
+ */
+static void build_append_srat_pci_device_handle(GArray *table_data,
+                                                uint16_t segment,
+                                                uint8_t bus, uint8_t devfn)
+{
+    /* PCI segment number */
+    build_append_int_noprefix(table_data, segment, 2);
+    /* PCI Bus Device Function */
+    build_append_int_noprefix(table_data, bus, 1);
+    build_append_int_noprefix(table_data, devfn, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 12);
+}
+
+/*
+ * ACPI spec, Revision 6.3
+ * 5.2.16.6 Generic Initiator Affinity Structure
+ *    With PCI Device Handle.
+ */
+void build_srat_pci_generic_initiator(GArray *table_data, int node,
+                                      uint16_t segment, uint8_t bus,
+                                      uint8_t devfn)
+{
+    /* Type */
+    build_append_int_noprefix(table_data, 5, 1);
+    /* Length */
+    build_append_int_noprefix(table_data, 32, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
+    /* Device Handle Type: PCI */
+    build_append_int_noprefix(table_data, 1, 1);
+    /* Proximity Domain */
+    build_append_int_noprefix(table_data, node, 4);
+    /* Device Handle */
+    build_append_srat_pci_device_handle(table_data, segment, bus, devfn);
+    /* Flags - GI Enabled */
+    build_append_int_noprefix(table_data, 1, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+}
+
 /*
  * ACPI spec 5.2.17 System Locality Distance Information Table
  * (Revision 2.0 or later)
-- 
MST


