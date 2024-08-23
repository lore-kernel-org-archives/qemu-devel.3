Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D87C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 12:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shTpp-0001nc-Lc; Fri, 23 Aug 2024 08:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1shTpk-0001BX-Iv; Fri, 23 Aug 2024 08:56:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1shTph-0005DW-L8; Fri, 23 Aug 2024 08:56:04 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr0Mb60P6z6GC4S;
 Fri, 23 Aug 2024 20:52:11 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id E4EB1140594;
 Fri, 23 Aug 2024 20:55:56 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.79.211) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 13:55:56 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <zhao1.liu@intel.com>, <zhenyu.z.wang@intel.com>,
 <dapeng1.mi@linux.intel.com>, <yongwei.ma@intel.com>, <armbru@redhat.com>,
 <farman@linux.ibm.com>, <peter.maydell@linaro.org>, <mst@redhat.com>,
 <anisinha@redhat.com>, <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>,
 <mtosatti@redhat.com>, <berrange@redhat.com>, <richard.henderson@linaro.org>, 
 <linuxarm@huwei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <Jonathan.Cameron@Huawei.com>, <jiangkunkun@huawei.com>
Subject: [PATCH 2/2] hw/acpi: add cache hierarchy node to pptt table
Date: Fri, 23 Aug 2024 13:54:46 +0100
Message-ID: <20240823125446.721-3-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823125446.721-1-alireza.sanaee@huawei.com>
References: <20240823125446.721-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.79.211]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Specify which layer (core/cluster/socket) caches found at in the CPU
topology.

Example:

Here, 2 sockets (packages), and 2 clusters, 4 cores and 2 threads
created, in aggregate 2*2*4*2 logical cores. In the smp-cache object,
cores will have l1d and l1i (threads will share these caches by default.
However, extending this is not difficult).  The clusters will share a
unified l2 level cache, and finally sockets will share l3. In this
patch, threads will share l1 caches by default, but this can be adjusted
if case required.

Currently only three levels of caches are supported. Also, PPTT table
revision has been increased to 3 even in scenarios where there are no
caches. The patch does not allow partial declaration of caches. In
another word, all caches must be defined or caches must be skipped.

./qemu-system-aarch64 \
-machine virt,smp-cache=cache0 \
-cpu max \
-m 2048 \
-smp sockets=2,clusters=2,cores=4,threads=2 \
-kernel ./Image.gz \
-append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
-initrd rootfs.cpio.gz \
-bios ./edk2-aarch64-code.fd \
-object '{"qom-type":"smp-cache","id":"cache0","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"},{"name":"l2","topo":"cluster"},{"name":"l3","topo":"socket"}]}' \
-nographic

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/acpi/aml-build.c         | 307 +++++++++++++++++++++++++++++++++++-
 hw/arm/virt-acpi-build.c    | 137 +++++++++++++++-
 hw/arm/virt.c               |   5 +
 hw/core/machine-smp.c       |   6 +-
 hw/loongarch/acpi-build.c   |   3 +-
 include/hw/acpi/aml-build.h |  20 ++-
 6 files changed, 468 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 6d4517cfbe..3b3ee6f01d 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1964,6 +1964,200 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
     acpi_table_end(linker, &table);
 }
 
+static bool cache_described_at(MachineState *ms, CpuTopologyLevel level)
+{
+    if (machine_get_cache_topo_level(ms, SMP_CACHE_L3) == level ||
+        machine_get_cache_topo_level(ms, SMP_CACHE_L2) == level ||
+        machine_get_cache_topo_level(ms, SMP_CACHE_L1I) == level ||
+        machine_get_cache_topo_level(ms, SMP_CACHE_L1D) == level) {
+        return true;
+    }
+
+    return false;
+}
+
+static int partial_cache_description(MachineState *ms, ACPIPPTTCache* caches,
+                                 int num_caches)
+{
+    int level, c;
+
+    for (level = 1; level < num_caches; level++) {
+        for (c = 0; c < num_caches; c++) {
+            if (caches[c].level != level) {
+                continue;
+            }
+
+            switch (level) {
+            case 1:
+                /*
+                 * L1 cache is assumed to have both L1I and L1D available.
+                 * Technically both need to be checked.
+                 */
+                if (machine_get_cache_topo_level(ms, SMP_CACHE_L1I) ==
+                        CPU_TOPO_LEVEL_DEFAULT) {
+                    assert(machine_get_cache_topo_level(ms, SMP_CACHE_L1D) !=
+                           CPU_TOPO_LEVEL_DEFAULT);
+                    return level;
+                }
+                break;
+            case 2:
+                if (machine_get_cache_topo_level(ms, SMP_CACHE_L2) ==
+                        CPU_TOPO_LEVEL_DEFAULT) {
+                    return level;
+                }
+                break;
+            case 3:
+                if (machine_get_cache_topo_level(ms, SMP_CACHE_L3) ==
+                        CPU_TOPO_LEVEL_DEFAULT) {
+                    return level;
+                }
+                break;
+            }
+        }
+    }
+
+    return 0;
+}
+
+/*
+ * This function assumes l3 and l2 have unified cache and l1 is split l1d
+ * and l1i, and further prepares the lowest cache level for a topology
+ * level.  The info will be fed to build_caches to create caches at the
+ * right level.
+ */
+static int find_the_lowest_level_cache_defined_at_level(MachineState *ms,
+                int *level_found,
+                CpuTopologyLevel topo_level) {
+
+    CpuTopologyLevel level;
+
+    level = machine_get_cache_topo_level(ms, SMP_CACHE_L1I);
+    if (level == topo_level) {
+        *level_found = 1;
+        return 1;
+    }
+
+    level = machine_get_cache_topo_level(ms, SMP_CACHE_L1D);
+    if (level == topo_level) {
+        *level_found = 1;
+        return 1;
+    }
+
+    level = machine_get_cache_topo_level(ms, SMP_CACHE_L2);
+    if (level == topo_level) {
+        *level_found = 2;
+        return 2;
+    }
+
+    level = machine_get_cache_topo_level(ms, SMP_CACHE_L3);
+    if (level == topo_level) {
+        *level_found = 3;
+        return 3;
+    }
+
+    return 0;
+}
+
+static void build_cache_nodes(GArray *tbl, ACPIPPTTCache *cache,
+                              uint32_t next_offset, unsigned int id)
+{
+    int val;
+
+    /* Type 1 - cache */
+    build_append_byte(tbl, 1);
+    /* Length */
+    build_append_byte(tbl, 28);
+    /* Reserved */
+    build_append_int_noprefix(tbl, 0, 2);
+    /* Flags - everything except possibly the ID */
+    build_append_int_noprefix(tbl, 0xff, 4);
+    /* Offset of next cache up */
+    build_append_int_noprefix(tbl, next_offset, 4);
+    build_append_int_noprefix(tbl, cache->size, 4);
+    build_append_int_noprefix(tbl, cache->sets, 4);
+    build_append_byte(tbl, cache->associativity);
+    val = 0x3;
+    switch (cache->type) {
+    case INSTRUCTION:
+        val |= (1 << 2);
+        break;
+    case DATA:
+        val |= (0 << 2); /* Data */
+        break;
+    case UNIFIED:
+        val |= (3 << 2); /* Unified */
+        break;
+    }
+    build_append_byte(tbl, val);
+    build_append_int_noprefix(tbl, cache->linesize, 2);
+    build_append_int_noprefix(tbl,
+                             (cache->type << 24) | (cache->level << 16) | id,
+                             4);
+}
+
+/*
+ * builds caches from the top level (`level_high` parameter) to the bottom
+ * level (`level_low` parameter).  It searches for caches found in
+ * systems' registers, and fills up the table. Then it updates the
+ * `data_offset` and `instr_offset` parameters with the offset of the data
+ * and instruction caches of the lowest level, respectively.
+ */
+static bool build_caches(GArray *table_data, uint32_t pptt_start,
+                                int num_caches, ACPIPPTTCache *caches,
+                                int base_id,
+                                uint8_t level_high, /* Inclusive */
+                                uint8_t level_low, /* Inclusive */
+                                uint32_t *data_offset,
+                                uint32_t *instr_offset)
+{
+    uint32_t next_level_offset_data = 0, next_level_offset_instruction = 0;
+    uint32_t this_offset, next_offset = 0;
+    int c, level;
+    bool found_cache = false;
+
+    /* Walk caches from top to bottom */
+    for (level = level_high; level >= level_low; level--) {
+        for (c = 0; c < num_caches; c++) {
+            if (caches[c].level != level) {
+                continue;
+            }
+
+            /* Assume only unified above l1 for now */
+            this_offset = table_data->len - pptt_start;
+            switch (caches[c].type) {
+            case INSTRUCTION:
+                next_offset = next_level_offset_instruction;
+                break;
+            case DATA:
+                next_offset = next_level_offset_data;
+                break;
+            case UNIFIED:
+                /* Either is fine here - hopefully */
+                next_offset = next_level_offset_instruction;
+                break;
+            }
+            build_cache_nodes(table_data, &caches[c], next_offset, base_id);
+            switch (caches[c].type) {
+            case INSTRUCTION:
+                next_level_offset_instruction = this_offset;
+                break;
+            case DATA:
+                next_level_offset_data = this_offset;
+                break;
+            case UNIFIED:
+                next_level_offset_instruction = this_offset;
+                next_level_offset_data = this_offset;
+                break;
+            }
+            *data_offset = next_level_offset_data;
+            *instr_offset = next_level_offset_instruction;
+
+            found_cache = true;
+        }
+    }
+
+    return found_cache;
+}
 /*
  * ACPI spec, Revision 6.3
  * 5.2.29.1 Processor hierarchy node structure (Type 0)
@@ -2047,24 +2241,40 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
 
     acpi_table_end(linker, &table);
 }
+
 /*
  * ACPI spec, Revision 6.3
  * 5.2.29 Processor Properties Topology Table (PPTT)
  */
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id)
+                 const char *oem_id, const char *oem_table_id,
+                 int num_caches, ACPIPPTTCache *caches)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CPUArchIdList *cpus = ms->possible_cpus;
+    uint32_t l1_data_offset = 0, l1_instr_offset = 0, cluster_data_offset = 0;
+    uint32_t cluster_instr_offset = 0, node_data_offset = 0;
+    uint32_t node_instr_offset = 0;
+    int top_node = 3, top_cluster = 3, top_core = 3;
+    int bottom_node = 3, bottom_cluster = 3, bottom_core = 3;
     int64_t socket_id = -1, cluster_id = -1, core_id = -1;
     uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
     uint32_t pptt_start = table_data->len;
     int n;
-    AcpiTable table = { .sig = "PPTT", .rev = 2,
+    uint32_t priv_rsrc[2];
+    uint32_t num_priv = 0;
+    bool cache_created;
+
+    AcpiTable table = { .sig = "PPTT", .rev = 3,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
     acpi_table_begin(&table, table_data);
 
+    n = partial_cache_description(ms, caches, num_caches);
+    if (n) {
+        error_setg(&error_fatal, "Missing cache description at #L%d", n);
+    }
+
     /*
      * This works with the assumption that cpus[n].props.*_id has been
      * sorted from top to down levels in mc->possible_cpu_arch_ids().
@@ -2077,10 +2287,37 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             socket_id = cpus->cpus[n].props.socket_id;
             cluster_id = -1;
             core_id = -1;
+            bottom_node = top_node;
+            num_priv = 0;
+
+            if (cache_described_at(ms, CPU_TOPO_LEVEL_SOCKET) &&
+                    find_the_lowest_level_cache_defined_at_level(ms,
+                        &bottom_node,
+                        CPU_TOPO_LEVEL_SOCKET)) {
+                cache_created = build_caches(table_data, pptt_start,
+                                    num_caches, caches,
+                                    n, top_node, bottom_node,
+                                    &node_data_offset, &node_instr_offset);
+
+                if (!cache_created) {
+                    error_setg(&error_fatal, "No caches at levels %d-%d",
+                               top_node, bottom_node);
+                }
+
+                priv_rsrc[0] = node_instr_offset;
+                priv_rsrc[1] = node_data_offset;
+
+                if (node_instr_offset || node_data_offset) {
+                    num_priv = node_instr_offset == node_data_offset ? 1 : 2;
+                }
+
+                top_cluster = bottom_node - 1;
+            }
+
             socket_offset = table_data->len - pptt_start;
             build_processor_hierarchy_node(table_data,
                 (1 << 0), /* Physical package */
-                0, socket_id, NULL, 0);
+                0, socket_id, priv_rsrc, num_priv);
         }
 
         if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
@@ -2088,20 +2325,78 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 assert(cpus->cpus[n].props.cluster_id > cluster_id);
                 cluster_id = cpus->cpus[n].props.cluster_id;
                 core_id = -1;
+                bottom_cluster = top_cluster;
+                num_priv = 0;
+
+                if (cache_described_at(ms, CPU_TOPO_LEVEL_CLUSTER) &&
+                       find_the_lowest_level_cache_defined_at_level(ms,
+                           &bottom_cluster,
+                           CPU_TOPO_LEVEL_CLUSTER)) {
+
+                    cache_created = build_caches(table_data, pptt_start,
+                        num_caches, caches, n, top_cluster, bottom_cluster,
+                        &cluster_data_offset, &cluster_instr_offset);
+
+                    if (!cache_created) {
+                        error_setg(&error_fatal, "No caches at levels %d-%d",
+                                   top_cluster, bottom_cluster);
+                    }
+
+                    priv_rsrc[0] = cluster_instr_offset;
+                    priv_rsrc[1] = cluster_data_offset;
+
+                    if (cluster_instr_offset || cluster_data_offset) {
+                        num_priv = cluster_instr_offset == cluster_data_offset ?
+                            1 : 2;
+                    }
+
+                    top_core = bottom_cluster - 1;
+                }
+
                 cluster_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
                     (0 << 0), /* Not a physical package */
-                    socket_offset, cluster_id, NULL, 0);
+                    socket_offset, cluster_id, priv_rsrc, num_priv);
             }
         } else {
+            if (cache_described_at(ms, CPU_TOPO_LEVEL_CLUSTER)) {
+                error_setg(&error_fatal, "Not clusters but defined caches for");
+            }
+
             cluster_offset = socket_offset;
+            top_core = bottom_node - 1; /* there is no cluster */
+        }
+
+        if (cpus->cpus[n].props.core_id != core_id) {
+            bottom_core = top_core;
+            num_priv = 0;
+
+            if (cache_described_at(ms, CPU_TOPO_LEVEL_CORE) &&
+                    find_the_lowest_level_cache_defined_at_level(ms,
+                        &bottom_core,
+                        CPU_TOPO_LEVEL_CORE)) {
+                cache_created = build_caches(table_data, pptt_start,
+                                    num_caches, caches,
+                                    n, top_core , bottom_core,
+                                    &l1_data_offset, &l1_instr_offset);
+
+                if (!cache_created) {
+                    error_setg(&error_fatal, "No cache defined at levels %d-%d",
+                        top_core, bottom_core);
+                }
+
+                priv_rsrc[0] = l1_instr_offset;
+                priv_rsrc[1] = l1_data_offset;
+
+                num_priv = l1_instr_offset == l1_data_offset ? 1 : 2;
+            }
         }
 
         if (ms->smp.threads == 1) {
             build_processor_hierarchy_node(table_data,
                 (1 << 1) | /* ACPI Processor ID valid */
                 (1 << 3),  /* Node is a Leaf */
-                cluster_offset, n, NULL, 0);
+                cluster_offset, n, priv_rsrc, num_priv);
         } else {
             if (cpus->cpus[n].props.core_id != core_id) {
                 assert(cpus->cpus[n].props.core_id > core_id);
@@ -2109,7 +2404,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 core_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
                     (0 << 0), /* Not a physical package */
-                    cluster_offset, core_id, NULL, 0);
+                    cluster_offset, core_id, priv_rsrc, num_priv);
             }
 
             build_processor_hierarchy_node(table_data,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e10cad86dd..397ff939eb 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -60,11 +60,14 @@
 #include "hw/acpi/acpi_generic_initiator.h"
 #include "hw/virtio/virtio-acpi.h"
 #include "target/arm/multiprocessing.h"
+#include "cpu-features.h"
 
 #define ARM_SPI_BASE 32
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 
+#define ACPI_PPTT_MAX_CACHES 16
+
 static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -890,6 +893,132 @@ static void acpi_align_size(GArray *blob, unsigned align)
     g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
 }
 
+static unsigned int virt_get_caches(VirtMachineState *vms,
+                                    ACPIPPTTCache *caches)
+{
+    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0)); /* assume homogeneous CPUs */
+    bool ccidx = cpu_isar_feature(any_ccidx, armcpu);
+    unsigned int num_cache, i;
+    int level_instr = 1, level_data = 1;
+
+    for (i = 0, num_cache = 0; i < ACPI_PPTT_MAX_CACHES; i++, num_cache++) {
+        int type = (armcpu->clidr >> (3 * i)) & 7;
+        int bank_index;
+        int level;
+        ACPIPPTTCacheType cache_type;
+
+        if (type == 0) {
+            break;
+        }
+
+        switch (type) {
+        case 1:
+            cache_type = INSTRUCTION;
+            level = level_instr;
+            break;
+        case 2:
+            cache_type = DATA;
+            level = level_data;
+            break;
+        case 4:
+            cache_type = UNIFIED;
+            level = level_instr > level_data ? level_instr : level_data;
+            break;
+        case 3: /* Split - Do data first */
+            cache_type = DATA;
+            level = level_data;
+            break;
+        default:
+            error_setg(&error_abort, "Unrecognized cache type");
+            return 0;
+        }
+        /*
+         * ccsidr is indexed using both the level and whether it is
+         * an instruction cache. Unified caches use the same storage
+         * as data caches.
+         */
+        bank_index = (i * 2) | ((type == 1) ? 1 : 0);
+        if (ccidx) {
+            caches[num_cache] = (ACPIPPTTCache) {
+                .type =  cache_type,
+                .level = level,
+                .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
+                                             CCSIDR_EL1,
+                                             CCIDX_LINESIZE) + 4),
+                .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
+                                            CCSIDR_EL1,
+                                            CCIDX_ASSOCIATIVITY) + 1,
+                .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                   CCIDX_NUMSETS) + 1,
+            };
+        } else {
+            caches[num_cache] = (ACPIPPTTCache) {
+                .type =  cache_type,
+                .level = level,
+                .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
+                                             CCSIDR_EL1, LINESIZE) + 4),
+                .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
+                                            CCSIDR_EL1,
+                                            ASSOCIATIVITY) + 1,
+                .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                   NUMSETS) + 1,
+            };
+        }
+        caches[num_cache].size = caches[num_cache].associativity *
+            caches[num_cache].sets * caches[num_cache].linesize;
+
+        /* Break one 'split' entry up into two records */
+        if (type == 3) {
+            num_cache++;
+            bank_index = (i * 2) | 1;
+            if (ccidx) {
+                /* Instruction cache: bottom bit set when reading banked reg */
+                caches[num_cache] = (ACPIPPTTCache) {
+                    .type = INSTRUCTION,
+                    .level = level_instr,
+                    .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
+                                                 CCSIDR_EL1,
+                                                 CCIDX_LINESIZE) + 4),
+                    .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
+                                                CCSIDR_EL1,
+                                                CCIDX_ASSOCIATIVITY) + 1,
+                    .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                       CCIDX_NUMSETS) + 1,
+                };
+            } else {
+                caches[num_cache] = (ACPIPPTTCache) {
+                    .type = INSTRUCTION,
+                    .level = level_instr,
+                    .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
+                                                 CCSIDR_EL1, LINESIZE) + 4),
+                    .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
+                                                CCSIDR_EL1,
+                                                ASSOCIATIVITY) + 1,
+                    .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                       NUMSETS) + 1,
+                };
+            }
+            caches[num_cache].size = caches[num_cache].associativity *
+                caches[num_cache].sets * caches[num_cache].linesize;
+        }
+        switch (type) {
+        case 1:
+            level_instr++;
+            break;
+        case 2:
+            level_data++;
+            break;
+        case 3:
+        case 4:
+            level_instr++;
+            level_data++;
+            break;
+        }
+    }
+
+    return num_cache;
+}
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -899,6 +1028,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(vms);
 
+    ACPIPPTTCache caches[ACPI_PPTT_MAX_CACHES]; /* Can select up to 16 */
+    unsigned int num_cache;
+
+    num_cache = virt_get_caches(vms, caches);
+
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
 
@@ -920,7 +1054,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
         build_pptt(tables_blob, tables->linker, ms,
-                   vms->oem_id, vms->oem_table_id);
+                   vms->oem_id, vms->oem_table_id,
+                   num_cache, caches);
     }
 
     acpi_add_table(table_offsets, tables_blob);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b0c68d66a3..b723248ecf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3093,6 +3093,11 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug = virt_machine_device_unplug_cb;
     mc->nvdimm_supported = true;
     mc->smp_props.clusters_supported = true;
+    /* Supported cached */
+    mc->smp_props.cache_supported[SMP_CACHE_L1D] = true;
+    mc->smp_props.cache_supported[SMP_CACHE_L1I] = true;
+    mc->smp_props.cache_supported[SMP_CACHE_L2] = true;
+    mc->smp_props.cache_supported[SMP_CACHE_L3] = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
     /* platform instead of architectural choice */
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index bf6f2f9107..de95ec9c0f 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -274,7 +274,11 @@ unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
 CpuTopologyLevel machine_get_cache_topo_level(const MachineState *ms,
                                               SMPCacheName cache)
 {
-    return ms->smp_cache->props[cache].topo;
+    if (ms->smp_cache) {
+        return ms->smp_cache->props[cache].topo;
+    }
+
+    return CPU_TOPO_LEVEL_DEFAULT;
 }
 
 static bool machine_check_topo_support(MachineState *ms,
diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index af45ce526d..154f2c9ddd 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -473,7 +473,8 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 
     acpi_add_table(table_offsets, tables_blob);
     build_pptt(tables_blob, tables->linker, machine,
-               lvms->oem_id, lvms->oem_table_id);
+               lvms->oem_id, lvms->oem_table_id,
+               0, NULL);
 
     acpi_add_table(table_offsets, tables_blob);
     build_srat(tables_blob, tables->linker, machine);
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index a3784155cb..9077b81ba2 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -31,6 +31,23 @@ struct Aml {
     AmlBlockFlags block_flags;
 };
 
+typedef enum ACPIPPTTCacheType {
+    DATA,
+    INSTRUCTION,
+    UNIFIED,
+} ACPIPPTTCacheType;
+
+typedef struct ACPIPPTTCache {
+    ACPIPPTTCacheType type;
+    uint32_t pptt_id;
+    uint32_t sets;
+    uint32_t size;
+    uint32_t level;
+    uint16_t linesize;
+    uint8_t attributes; /* write policy: 0x0 write back, 0x1 write through */
+    uint8_t associativity;
+} ACPIPPTTCache;
+
 typedef enum {
     AML_COMPATIBILITY = 0,
     AML_TYPEA = 1,
@@ -490,7 +507,8 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id);
+                const char *oem_id, const char *oem_table_id,
+                int num_caches, ACPIPPTTCache *caches);
 
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id);
-- 
2.34.1


