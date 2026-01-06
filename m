Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39272CE9D63
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 16:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9Ty-0007qI-Ni; Tue, 06 Jan 2026 11:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vd9Tq-0007hL-P5; Tue, 06 Jan 2026 11:00:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vd9Tm-00077l-Cl; Tue, 06 Jan 2026 11:00:22 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlwqF18VFzHnHMH;
 Wed,  7 Jan 2026 00:00:09 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 95ED24056A;
 Wed,  7 Jan 2026 00:00:13 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.31.135) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 Jan 2026 16:00:11 +0000
To: <qemu-devel@nongnu.org>, <gustavo.romero@linaro.org>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <imammedo@redhat.com>, <jiangkunkun@huawei.com>,
 <maobibo@loongson.cn>, <mst@redhat.com>, <mtosatti@redhat.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shannon.zhaosl@gmail.com>,
 <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <zhao1.liu@intel.com>
Subject: [PATCH v17 3/8] hw/arm/virt: add cache hierarchy to device tree
Date: Tue, 6 Jan 2026 15:58:22 +0000
Message-ID: <20260106155828.643-4-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260106155828.643-1-alireza.sanaee@huawei.com>
References: <20260106155828.643-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.31.135]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Specify which level (core/cluster/socket) caches found at in the CPU
topology. Updating cache topology to device tree (spec v0.4).
Example:

For example, 2 sockets (packages), and 2 clusters, 4 cores and 2 threads
created, in aggregate 2*2*4*2 logical cores. In the smp-cache object,
cores will have L1d and L1i.  However, extending this is not difficult.
The clusters will share a unified L2 level cache, and finally sockets
will share L3. In this patch, threads will share L1 caches by default,
but this can be adjusted if case required.

Only three levels of caches are supported.  The patch does not
allow partial declaration of caches. In other words, the topology level
of every cache must be specified if that of any level is.

./qemu-system-aarch64 \
    -machine virt,\
         smp-cache.0.cache=l1i,smp-cache.0.topology=core,\
         smp-cache.1.cache=l1d,smp-cache.1.topology=core,\
         smp-cache.2.cache=l2,smp-cache.2.topology=cluster,\
         smp-cache.3.cache=l3,smp-cache.3.topology=socket\
    -cpu max \
    -m 2048 \
    -smp sockets=2,clusters=2,cores=4,threads=1 \
    -kernel ./Image.gz \
    -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
    -initrd rootfs.cpio.gz \
    -bios ./edk2-aarch64-code.fd \
    -nographic

For instance, following device tree will be generated for a scenario
where we have 2 sockets, 2 clusters, 2 cores and 2 threads, in total 16
PEs. L1i and L1d are private to each thread, and L2 and L3 are shared at
socket level as an example.

Limitation: SMT cores cannot share L1 cache for now. This
problem does not exist in PPTT tables.

Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/arm/virt.c         | 364 +++++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/virt.h |  17 +-
 include/hw/core/cpu.h |  12 ++
 3 files changed, 391 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fd0e28f030..c8a459bf01 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -90,6 +90,7 @@
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "hw/core/cpu.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
@@ -279,6 +280,86 @@ static bool ns_el2_virt_timer_present(void)
         arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu);
 }
 
+void set_cpu_cache(CPUCoreCaches *cpu_cache, enum CacheType cache_type,
+                   int cache_level, bool is_i_cache0)
+{
+    int bank_index = ((cache_level - 1) * 2) | is_i_cache0;
+    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
+    bool ccidx = cpu_isar_feature(any_ccidx, armcpu);
+
+    if (ccidx) {
+        *cpu_cache = (CPUCoreCaches){
+            .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                         CCIDX_LINESIZE) + 4),
+            .associativity = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                        CCIDX_ASSOCIATIVITY) + 1,
+            .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                               CCIDX_NUMSETS) + 1,
+        };
+    } else {
+        *cpu_cache = (CPUCoreCaches){
+            .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                         LINESIZE) + 4),
+            .associativity = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                        ASSOCIATIVITY) + 1,
+            .sets =
+                FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1, NUMSETS) + 1,
+        };
+    }
+    cpu_cache->type = cache_type;
+    cpu_cache->level = cache_level;
+    cpu_cache->size = cpu_cache->associativity *
+                             cpu_cache->sets *
+                             cpu_cache->linesize;
+
+    return;
+}
+
+unsigned int virt_get_caches(const VirtMachineState *vms, CPUCoreCaches *caches)
+{
+    int num_cache = 0;
+    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0)); /* assume homogeneous CPUs */
+    ARMISARegisters *isar = &armcpu->isar;
+    uint32_t clidr = GET_IDREG(isar, CLIDR);
+
+    for (int cache_level = 1; cache_level <= CLIDR_CTYPE_MAX_CACHE_LEVEL;
+         cache_level++) {
+        uint8_t ctype =
+            (clidr >> (3 * (cache_level - 1))) & CLIDR_CTYPE_MAX_CACHE_LEVEL;
+
+        if (ctype == CLIDR_CTYPE_NO_CACHE) {
+            /*
+             * If a "No cache" cache type is found it means no manageable caches
+             * exist at further-out levels of hierarchy, so ignore them.
+             */
+            break;
+        } else if (ctype == CLIDR_CTYPE_SEPARATE_I_D_CACHES) {
+            /*
+             * Create separate D and I caches. D-cache is stored first.
+             */
+            enum CacheType cache_type;
+            for (cache_type = DATA_CACHE; cache_type <= INSTRUCTION_CACHE;
+                 cache_type++) {
+                set_cpu_cache(&caches[num_cache++], cache_type, cache_level,
+                              cache_type == INSTRUCTION_CACHE ? true : false);
+            }
+        } else if (ctype == CLIDR_CTYPE_UNIFIED_CACHE) {
+            set_cpu_cache(&caches[num_cache++], UNIFIED_CACHE, cache_level,
+                          false);
+        } else if (ctype == CLIDR_CTYPE_D_CACHE) {
+            set_cpu_cache(&caches[num_cache++], DATA_CACHE, cache_level, false);
+        } else if (ctype == CLIDR_CTYPE_I_CACHE) {
+            set_cpu_cache(&caches[num_cache++], INSTRUCTION_CACHE, cache_level,
+                          true);
+        } else {
+            error_setg(&error_abort, "Unrecognized cache type");
+            return 0;
+        }
+    }
+
+    return num_cache;
+}
+
 static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -429,13 +510,150 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
     }
 }
 
+static void add_cache_node(void *fdt, char *nodepath, CPUCoreCaches cache,
+                           uint32_t *next_level)
+{
+    /* Assume L2/3 are unified caches. */
+
+    uint32_t phandle;
+
+    qemu_fdt_add_path(fdt, nodepath);
+    phandle = qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_setprop_cell(fdt, nodepath, "phandle", phandle);
+    qemu_fdt_setprop_cell(fdt, nodepath, "cache-level", cache.level);
+    qemu_fdt_setprop_cell(fdt, nodepath, "cache-size", cache.size);
+    qemu_fdt_setprop_cell(fdt, nodepath, "cache-block-size", cache.linesize);
+    qemu_fdt_setprop_cell(fdt, nodepath, "cache-sets", cache.sets);
+    qemu_fdt_setprop(fdt, nodepath, "cache-unified", NULL, 0);
+    qemu_fdt_setprop_string(fdt, nodepath, "compatible", "cache");
+    if (cache.level != 3) {
+        /* top level cache doesn't have next-level-cache property */
+        qemu_fdt_setprop_cell(fdt, nodepath, "next-level-cache", *next_level);
+    }
+
+    *next_level = phandle;
+}
+
+static bool add_cpu_cache_hierarchy(void *fdt, CPUCoreCaches* cache,
+                                    uint32_t cache_cnt,
+                                    uint32_t top_level,
+                                    uint32_t bottom_level,
+                                    uint32_t cpu_id,
+                                    uint32_t *next_level) {
+    bool found_cache = false;
+
+    for (int level = top_level; level >= bottom_level; level--) {
+        for (int i = 0; i < cache_cnt; i++) {
+            char *nodepath;
+
+            if (i != level) {
+                continue;
+            }
+
+            nodepath = g_strdup_printf("/cpus/cpu@%d/l%d-cache",
+                                       cpu_id, level);
+            add_cache_node(fdt, nodepath, cache[i], next_level);
+            found_cache = true;
+            g_free(nodepath);
+
+        }
+    }
+
+    return found_cache;
+}
+
+static void set_cache_properties(void *fdt, const char *nodename,
+                                 const char *prefix, CPUCoreCaches cache)
+{
+    char prop_name[64];
+
+    snprintf(prop_name, sizeof(prop_name), "%s-block-size", prefix);
+    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.linesize);
+
+    snprintf(prop_name, sizeof(prop_name), "%s-size", prefix);
+    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.size);
+
+    snprintf(prop_name, sizeof(prop_name), "%s-sets", prefix);
+    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.sets);
+}
+
+static int partial_cache_description(const MachineState *ms,
+                                     CPUCoreCaches *caches, int num_caches)
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
+                if (machine_get_cache_topo_level(ms,
+                                                 CACHE_LEVEL_AND_TYPE_L1I) ==
+                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
+                    return level;
+                }
+                break;
+            case 2:
+                if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2) ==
+                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
+                    return level;
+                }
+                break;
+            case 3:
+                if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3) ==
+                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
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
 static void fdt_add_cpu_nodes(const VirtMachineState *vms)
 {
     int cpu;
     int addr_cells = 1;
     const MachineState *ms = MACHINE(vms);
+    const MachineClass *mc = MACHINE_GET_CLASS(ms);
     const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int smp_cpus = ms->smp.cpus;
+    int socket_id, cluster_id, core_id;
+    uint32_t next_level = 0;
+    uint32_t socket_offset = 0;
+    uint32_t cluster_offset = 0;
+    uint32_t core_offset = 0;
+    int last_socket = -1;
+    int last_cluster = -1;
+    int last_core = -1;
+    int top_node = 3;
+    int top_cluster = 3;
+    int top_core = 3;
+    int bottom_node = 3;
+    int bottom_cluster = 3;
+    int bottom_core = 3;
+    unsigned int num_cache;
+    CPUCoreCaches caches[16];
+    bool cache_created = false;
+    bool cache_available;
+    bool llevel;
+
+    num_cache = virt_get_caches(vms, caches);
+
+    if (mc->smp_props.has_caches &&
+        partial_cache_description(ms, caches, num_cache)) {
+        error_setg(&error_fatal, "Missing cache description");
+        return;
+    }
 
     /*
      * See Linux Documentation/devicetree/bindings/arm/cpus.yaml
@@ -464,9 +682,14 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
 
     for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
+        socket_id = cpu / (ms->smp.clusters * ms->smp.cores * ms->smp.threads);
+        cluster_id = cpu / (ms->smp.cores * ms->smp.threads) % ms->smp.clusters;
+        core_id = cpu / ms->smp.threads % ms->smp.cores;
+
         char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
         CPUState *cs = CPU(armcpu);
+        const char *prefix = NULL;
 
         qemu_fdt_add_subnode(ms->fdt, nodename);
         qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
@@ -496,6 +719,139 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
                                   qemu_fdt_alloc_phandle(ms->fdt));
         }
 
+        if (!vmc->no_cpu_topology && num_cache) {
+            for (uint8_t i = 0; i < num_cache; i++) {
+                /* only level 1 in the CPU entry */
+                if (caches[i].level > 1) {
+                    continue;
+                }
+
+                if (caches[i].type == INSTRUCTION_CACHE) {
+                    prefix = "i-cache";
+                } else if (caches[i].type == DATA_CACHE) {
+                    prefix = "d-cache";
+                } else if (caches[i].type == UNIFIED_CACHE) {
+                    error_setg(&error_fatal,
+                               "Unified type is not implemented at level %d",
+                               caches[i].level);
+                    return;
+                } else {
+                    error_setg(&error_fatal, "Undefined cache type");
+                    return;
+                }
+
+                set_cache_properties(ms->fdt, nodename, prefix, caches[i]);
+            }
+        }
+
+        if (socket_id != last_socket) {
+            bottom_node = top_node;
+            /* this assumes socket as the highest topological level */
+            socket_offset = 0;
+            cluster_offset = 0;
+            cache_available = machine_defines_cache_at_topo_level(ms,
+                                  CPU_TOPOLOGY_LEVEL_SOCKET);
+            llevel = machine_find_lowest_level_cache_at_topo_level(ms,
+                        &bottom_node,
+                        CPU_TOPOLOGY_LEVEL_SOCKET);
+            if (cache_available && llevel) {
+                if (bottom_node == 1 && !virt_is_acpi_enabled(vms))
+                    error_setg(
+                        &error_fatal,
+                        "Cannot share L1 at socket_id %d."
+                        "DT limiation on sharing at cache level = 1",
+                        socket_id);
+
+                cache_created = add_cpu_cache_hierarchy(ms->fdt, caches,
+                                                        num_cache,
+                                                        top_node,
+                                                        bottom_node, cpu,
+                                                        &socket_offset);
+
+                if (!cache_created) {
+                    error_setg(&error_fatal,
+                               "Socket: No caches at levels %d-%d",
+                               top_node, bottom_node);
+                    return;
+                }
+
+                top_cluster = bottom_node - 1;
+            }
+
+            last_socket = socket_id;
+        }
+
+        if (cluster_id != last_cluster) {
+            bottom_cluster = top_cluster;
+            cluster_offset = socket_offset;
+            core_offset = 0;
+            cache_available = machine_defines_cache_at_topo_level(ms,
+                                 CPU_TOPOLOGY_LEVEL_CLUSTER);
+            llevel = machine_find_lowest_level_cache_at_topo_level(ms,
+                        &bottom_cluster,
+                        CPU_TOPOLOGY_LEVEL_CLUSTER);
+            if (cache_available && llevel) {
+                cache_created = add_cpu_cache_hierarchy(ms->fdt, caches,
+                                                        num_cache,
+                                                        top_cluster,
+                                                        bottom_cluster, cpu,
+                                                        &cluster_offset);
+                if (bottom_cluster == 1 && !virt_is_acpi_enabled(vms)) {
+                    error_setg(&error_fatal,
+                        "Cannot share L1 at socket_id %d, cluster_id %d. "
+                        "DT limitation on sharing at cache level = 1.",
+                        socket_id, cluster_id);
+                }
+
+                if (!cache_created) {
+                    error_setg(&error_fatal,
+                               "Cluster: No caches at levels %d-%d.",
+                               top_cluster, bottom_cluster);
+                    return;
+                }
+
+                top_core = bottom_cluster - 1;
+            } else if (top_cluster == bottom_node - 1) {
+                top_core = bottom_node - 1;
+            }
+
+            last_cluster = cluster_id;
+        }
+
+        if (core_id != last_core) {
+            bottom_core = top_core;
+            core_offset = cluster_offset;
+            cache_available = machine_defines_cache_at_topo_level(ms,
+                                 CPU_TOPOLOGY_LEVEL_CORE);
+            llevel = machine_find_lowest_level_cache_at_topo_level(ms,
+                        &bottom_core,
+                        CPU_TOPOLOGY_LEVEL_CORE);
+            if (cache_available && llevel) {
+                if (bottom_core == 1 && top_core > 1) {
+                    bottom_core++;
+                    cache_created = add_cpu_cache_hierarchy(ms->fdt,
+                                                            caches,
+                                                            num_cache,
+                                                            top_core,
+                                                            bottom_core, cpu,
+                                                            &core_offset);
+
+                    if (!cache_created) {
+                        error_setg(&error_fatal,
+                                   "Core: No caches at levels %d-%d",
+                                   top_core, bottom_core);
+                        return;
+                    }
+                }
+            }
+
+            last_core = core_id;
+        }
+
+        next_level = core_offset;
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "next-level-cache",
+                              next_level);
+
         g_free(nodename);
     }
 
@@ -2766,7 +3122,7 @@ static void virt_set_oem_table_id(Object *obj, const char *value,
 }
 
 
-bool virt_is_acpi_enabled(VirtMachineState *vms)
+bool virt_is_acpi_enabled(const VirtMachineState *vms)
 {
     if (vms->acpi == ON_OFF_AUTO_OFF) {
         return false;
@@ -3325,6 +3681,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     hc->unplug = virt_machine_device_unplug_cb;
     mc->nvdimm_supported = true;
     mc->smp_props.clusters_supported = true;
+
+    /* Supported caches */
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1D] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1I] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L2] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L3] = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
     /* platform instead of architectural choice */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 8694aaa4e2..43af837b4e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -41,6 +41,7 @@
 #include "system/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
+#include "hw/core/cpu.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -52,6 +53,8 @@
 /* GPIO pins */
 #define GPIO_PIN_POWER_BUTTON  3
 
+#define CPU_MAX_CACHES 16
+
 enum {
     VIRT_FLASH,
     VIRT_MEM,
@@ -188,7 +191,19 @@ struct VirtMachineState {
 OBJECT_DECLARE_TYPE(VirtMachineState, VirtMachineClass, VIRT_MACHINE)
 
 void virt_acpi_setup(VirtMachineState *vms);
-bool virt_is_acpi_enabled(VirtMachineState *vms);
+bool virt_is_acpi_enabled(const VirtMachineState *vms);
+
+#define CLIDR_CTYPE_NO_CACHE 0x00
+#define CLIDR_CTYPE_I_CACHE 0x01
+#define CLIDR_CTYPE_D_CACHE 0x02
+#define CLIDR_CTYPE_SEPARATE_I_D_CACHES 0x03
+#define CLIDR_CTYPE_UNIFIED_CACHE 0x04
+#define CLIDR_CTYPE_MAX_CACHE_LEVEL 7
+
+unsigned int virt_get_caches(const VirtMachineState *vms,
+                             CPUCoreCaches *caches);
+void set_cpu_cache(CPUCoreCaches *cpu_cache, enum CacheType cache_type,
+                   int cache_level, bool is_i_cache);
 
 /* Return number of redistributors that fit in the specified region */
 static uint32_t virt_redist_capacity(VirtMachineState *vms, int region)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f6f17df9e6..00b17f5139 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1211,4 +1211,16 @@ enum CacheType {
     UNIFIED_CACHE
 };
 
+struct CPUCoreCaches {
+    enum CacheType type;
+    uint32_t sets;
+    uint32_t size;
+    uint32_t level;
+    uint16_t linesize;
+    uint8_t attributes; /* write policy: 0x0 write back, 0x1 write through */
+    uint8_t associativity;
+};
+
+typedef struct CPUCoreCaches CPUCoreCaches;
+
 #endif
-- 
2.43.0


