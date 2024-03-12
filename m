Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D89C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAdI-0005V9-Ge; Tue, 12 Mar 2024 18:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbx-0002oT-Dh
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbs-0004aC-Eb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5mdyjCEbyffW9T7OKjJbIrqSM8blOZkF1pxw/tMTzk=;
 b=EuKZsuIxB8hzA8rWqvIyMbr1v1FezI9d+C+wQ1o/OT16G/Oz729oK8eqWzZsupVnuBK370
 JZqbyx43TF6HaDx50jEI6B+50mPHuOGXxxMzA5HOwSftkW1Xg4bG6hdxslsTWl0DL3oqja
 ZOKJ2g4Q0oTs4hiQseKPnIRyPxmgdto=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-dzFvI5WaNimTuQBZrZgY7Q-1; Tue, 12 Mar 2024 18:28:34 -0400
X-MC-Unique: dzFvI5WaNimTuQBZrZgY7Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d44551e1ccso2831621fa.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282513; x=1710887313;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f5mdyjCEbyffW9T7OKjJbIrqSM8blOZkF1pxw/tMTzk=;
 b=KnE9MJ9TwDW3mmPdpc8oiOOUWcR7uFBaL0cvs80+B2oraUyoD+Y0taqzdT1QT8X2bw
 soD5DFnStLHMrwazPKFWF5CSd5GMD3eur/+VIcL5XGOWcbJy4Op219e+S7lMWzSKS303
 mmx2Ulm7rKMiY8YYbMj8gF3pZxS7OMY8h8bMiZdbT4tvRipF8j4JgBouR013VG5jtVBU
 PWb870jRJNmviiELAViBa4A/y+FD+9Mak1E9EL5kHTBXGGuC3sLf63HUyyttsohtBVmr
 1gR+s6P885VhbHzQJYVHKWsQ5elABUef9ZzB4adzw3UWcNeZxlmIV6AtBwiroXLBPhmA
 HJkQ==
X-Gm-Message-State: AOJu0YyeIt7HUthS6zu2qQEbSEezFZ2HMssgMlGu5qB+OkIOiH6ZaX7d
 Ly3wyYHvaxw9KTvVeBajNz2DppUQJgP/jjE5na2VW8rvc/cV22Ca31v7F8kzCyO75U6n1m3zxJ6
 EygiGLcuyqdISkt30LAd3gcRxsonH2JcG8VOcjtlUNPTc/ZnoCu8IDsGlar7p4gk5bP71OTvNLz
 TVJxW2vNatIKzpcGCB//NzL113ZdR+uGqZ
X-Received: by 2002:a2e:bc1f:0:b0:2d4:1d45:d5e2 with SMTP id
 b31-20020a2ebc1f000000b002d41d45d5e2mr4317076ljf.10.1710282512546; 
 Tue, 12 Mar 2024 15:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUnmOqgm4Tgu6e+odGAVI2IUdSFoEFX6iS0Efekr73qNPWVUuTYS4wNi0FN6UafvMtCjoPhA==
X-Received: by 2002:a2e:bc1f:0:b0:2d4:1d45:d5e2 with SMTP id
 b31-20020a2ebc1f000000b002d41d45d5e2mr4317051ljf.10.1710282511986; 
 Tue, 12 Mar 2024 15:28:31 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 jw22-20020a170906e95600b00a4623030893sm2658289ejb.126.2024.03.12.15.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:31 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-arm@nongnu.org
Subject: [PULL 55/68] hw/acpi: Implement the SRAT GI affinity structure
Message-ID: <0a5b5acdf2d8c7302ca48d42e6ef3423e1b956d5.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ankit Agrawal <ankita@nvidia.com>

ACPI spec provides a scheme to associate "Generic Initiators" [1]
(e.g. heterogeneous processors and accelerators, GPUs, and I/O devices with
integrated compute or DMA engines GPUs) with Proximity Domains. This is
achieved using Generic Initiator Affinity Structure in SRAT. During bootup,
Linux kernel parse the ACPI SRAT to determine the PXM ids and create a NUMA
node for each unique PXM ID encountered. Qemu currently do not implement
these structures while building SRAT.

Add GI structures while building VM ACPI SRAT. The association between
device and node are stored using acpi-generic-initiator object. Lookup
presence of all such objects and use them to build these structures.

The structure needs a PCI device handle [2] that consists of the device BDF.
The vfio-pci device corresponding to the acpi-generic-initiator object is
located to determine the BDF.

[1] ACPI Spec 6.3, Section 5.2.16.6
[2] ACPI Spec 6.3, Table 5.80

Cc: Jonathan Cameron <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cedric Le Goater <clg@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Message-Id: <20240308145525.10886-3-ankita@nvidia.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi_generic_initiator.h | 25 ++++++++
 include/sysemu/numa.h                    |  1 +
 hw/acpi/acpi_generic_initiator.c         | 77 ++++++++++++++++++++++++
 hw/acpi/hmat.c                           |  2 +-
 hw/arm/virt-acpi-build.c                 |  3 +
 hw/core/numa.c                           |  3 +-
 6 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index 16de1d3d80..a304bad73e 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -19,4 +19,29 @@ typedef struct AcpiGenericInitiator {
     uint16_t node;
 } AcpiGenericInitiator;
 
+/*
+ * ACPI 6.3:
+ * Table 5-81 Flags – Generic Initiator Affinity Structure
+ */
+typedef enum {
+    /*
+     * If clear, the OSPM ignores the contents of the Generic
+     * Initiator/Port Affinity Structure. This allows system firmware
+     * to populate the SRAT with a static number of structures, but only
+     * enable them as necessary.
+     */
+    GEN_AFFINITY_ENABLED = (1 << 0),
+} GenericAffinityFlags;
+
+/*
+ * ACPI 6.3:
+ * Table 5-80 Device Handle - PCI
+ */
+typedef struct PCIDeviceHandle {
+    uint16_t segment;
+    uint16_t bdf;
+} PCIDeviceHandle;
+
+void build_srat_generic_pci_initiator(GArray *table_data);
+
 #endif
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 4173ef2afa..825cfe86bc 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -41,6 +41,7 @@ struct NodeInfo {
     struct HostMemoryBackend *node_memdev;
     bool present;
     bool has_cpu;
+    bool has_gi;
     uint8_t lb_info_provided;
     uint16_t initiator;
     uint8_t distance[MAX_NODES];
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 130d6ae8c1..17b9a052f5 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -5,7 +5,9 @@
 
 #include "qemu/osdep.h"
 #include "hw/acpi/acpi_generic_initiator.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/boards.h"
+#include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
 
 typedef struct AcpiGenericInitiatorClass {
@@ -47,6 +49,7 @@ static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
                                             Error **errp)
 {
     AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    MachineState *ms = MACHINE(qdev_get_machine());
     uint32_t value;
 
     if (!visit_type_uint32(v, name, &value, errp)) {
@@ -60,6 +63,7 @@ static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
     }
 
     gi->node = value;
+    ms->numa_state->nodes[gi->node].has_gi = true;
 }
 
 static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
@@ -69,3 +73,76 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
     object_class_property_add(oc, "node", "int", NULL,
         acpi_generic_initiator_set_node, NULL, NULL);
 }
+
+/*
+ * ACPI 6.3:
+ * Table 5-78 Generic Initiator Affinity Structure
+ */
+static void
+build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
+                                          PCIDeviceHandle *handle)
+{
+    uint8_t index;
+
+    build_append_int_noprefix(table_data, 5, 1);  /* Type */
+    build_append_int_noprefix(table_data, 32, 1); /* Length */
+    build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
+    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type: PCI */
+    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
+
+    /* Device Handle - PCI */
+    build_append_int_noprefix(table_data, handle->segment, 2);
+    build_append_int_noprefix(table_data, handle->bdf, 2);
+    for (index = 0; index < 12; index++) {
+        build_append_int_noprefix(table_data, 0, 1);
+    }
+
+    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* Flags */
+    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
+}
+
+static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    AcpiGenericInitiator *gi;
+    GArray *table_data = opaque;
+    PCIDeviceHandle dev_handle;
+    PCIDevice *pci_dev;
+    Object *o;
+
+    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+        return 0;
+    }
+
+    gi = ACPI_GENERIC_INITIATOR(obj);
+    if (gi->node >= ms->numa_state->num_nodes) {
+        error_printf("%s: Specified node %d is invalid.\n",
+                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
+        exit(1);
+    }
+
+    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
+    if (!o) {
+        error_printf("%s: Specified device must be a PCI device.\n",
+                     TYPE_ACPI_GENERIC_INITIATOR);
+        exit(1);
+    }
+
+    pci_dev = PCI_DEVICE(o);
+
+    dev_handle.segment = 0;
+    dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
+                                               pci_dev->devfn);
+
+    build_srat_generic_pci_initiator_affinity(table_data,
+                                              gi->node, &dev_handle);
+
+    return 0;
+}
+
+void build_srat_generic_pci_initiator(GArray *table_data)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   build_all_acpi_generic_initiators,
+                                   table_data);
+}
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 3042d223c8..2242981e18 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -214,7 +214,7 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
     }
 
     for (i = 0; i < numa_state->num_nodes; i++) {
-        if (numa_state->nodes[i].has_cpu) {
+        if (numa_state->nodes[i].has_cpu || numa_state->nodes[i].has_gi) {
             initiator_list[num_initiator++] = i;
         }
     }
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6a1bde61ce..c3ccfef026 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -57,6 +57,7 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
+#include "hw/acpi/acpi_generic_initiator.h"
 #include "hw/virtio/virtio-acpi.h"
 #include "target/arm/multiprocessing.h"
 
@@ -504,6 +505,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
+    build_srat_generic_pci_initiator(table_data);
+
     if (ms->nvdimms_state->is_enabled) {
         nvdimm_build_srat(table_data);
     }
diff --git a/hw/core/numa.c b/hw/core/numa.c
index f08956ddb0..58a32f1564 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -229,7 +229,8 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
                    node->target, numa_state->num_nodes);
         return;
     }
-    if (!numa_info[node->initiator].has_cpu) {
+    if (!numa_info[node->initiator].has_cpu &&
+        !numa_info[node->initiator].has_gi) {
         error_setg(errp, "Invalid initiator=%d, it isn't an "
                    "initiator proximity domain", node->initiator);
         return;
-- 
MST


