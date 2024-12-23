Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DEEE7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 18:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPms5-0004iH-MW; Mon, 23 Dec 2024 13:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tPms2-0004hb-SL; Mon, 23 Dec 2024 13:09:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tPmrz-0008Rf-GF; Mon, 23 Dec 2024 13:09:34 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH5bv74Djz6LDV2;
 Tue, 24 Dec 2024 02:08:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 2BB5014039E;
 Tue, 24 Dec 2024 02:09:24 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 19:09:23 +0100
Date: Mon, 23 Dec 2024 18:09:20 +0000
To: Alireza Sanaee <alireza.sanaee@huawei.com>, <linuxarm@huawei.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <zhao1.liu@intel.com>,
 <zhenyu.z.wang@intel.com>, <dapeng1.mi@linux.intel.com>,
 <yongwei.ma@intel.com>, <armbru@redhat.com>, <farman@linux.ibm.com>,
 <peter.maydell@linaro.org>, <mst@redhat.com>, <anisinha@redhat.com>,
 <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>, <mtosatti@redhat.com>,
 <berrange@redhat.com>, <richard.henderson@linaro.org>,
 <shameerali.kolothum.thodi@huawei.com>, <Jonathan.Cameron@Huawei.com>,
 <jiangkunkun@huawei.com>, <yangyicong@hisilicon.com>, <sarsanaee@gmail.com>
Subject: Re: [PATCH v4 3/7] arm/virt.c: add cache hierarchy to device tree
Message-ID: <20241223180920.000049d4@huawei.com>
In-Reply-To: <20241216175414.1953-4-alireza.sanaee@huawei.com>
References: <20241216175414.1953-1-alireza.sanaee@huawei.com>
 <20241216175414.1953-4-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.118]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Dec 2024 17:54:10 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Specify which layer (core/cluster/socket) caches found at in the CPU
> topology. Updating cache topology to device tree (spec v0.4).
> Example:
> 
> Here, 2 sockets (packages), and 2 clusters, 4 cores and 2 threads
> created, in aggregate 2*2*4*2 logical cores. In the smp-cache object,
> cores will have l1d and l1i.  However, extending this is not difficult).
> The clusters will share a unified l2 level cache, and finally sockets
> will share l3. In this patch, threads will share l1 caches by default,
> but this can be adjusted if case required.
> 
> Currently only three levels of caches are supported.  The patch does not
> allow partial declaration of caches. In another word, all caches must be
> defined or caches must be skipped.
> 
> ./qemu-system-aarch64 \
>     -machine virt,\
>          smp-cache.0.cache=l1i,smp-cache.0.topology=core,\
>          smp-cache.1.cache=l1d,smp-cache.1.topology=core,\
>          smp-cache.2.cache=l2,smp-cache.2.topology=cluster,\
>          smp-cache.3.cache=l3,smp-cache.3.topology=socket\
>     -cpu max \
>     -m 2048 \
>     -smp sockets=2,clusters=2,cores=4,threads=1 \
>     -kernel ./Image.gz \
>     -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
>     -initrd rootfs.cpio.gz \
>     -bios ./edk2-aarch64-code.fd \
>     -nographic
> 
> For instance, following device tree will be generated for a scenario
> where we have 2 sockets, 2 clusters, 2 cores and 2 threads, in total 16
> PEs. L1i and L1d are private to each thread, and l2 and l3 are shared at
> socket level as an example.
> 
> Limitation: SMT cores cannot share L1 cache for now. This
> problem does not exist in PPTT tables.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Hi Ali,


Hmm. So the bit where the Co-dev makes sense is the utility functions pulled
forwards from the ACPI code. That is quite a bit of the code so fair enough.

A few comments and questions follow that I missed during internal reviews.
Sorry they are late!


What happens if we see registers that indicate an L4 or higher?  Does it
just ignore it for now?  I've no problem with it doing so as those are
rare systems at best and describing the lower caches is still better
than nothing. I'm not sure what Linux does though if the CPU registers
say there are more caches than in DT / ACPI?

> ---
>  hw/arm/virt.c         | 390 ++++++++++++++++++++++++++++++++++++++++++
>  hw/cpu/core.c         |  97 +++++++++++
>  include/hw/arm/virt.h |   5 +
>  include/hw/cpu/core.h |  26 +++
>  4 files changed, 518 insertions(+)


>  static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>  {
>      int cpu;
> @@ -418,6 +608,24 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>      const MachineState *ms = MACHINE(vms);
>      const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      int smp_cpus = ms->smp.cpus;
> +    int socket_id, cluster_id, core_id, thread_id;
> +    uint32_t next_level = 0;
> +    uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
> +    uint32_t thread_offset = 0;
> +    int last_socket = -1, last_cluster = -1, last_core = -1, last_thread = -1;
> +    int top_node = 3, top_cluster = 3, top_core = 3, top_thread = 3;

I wonder if a few comments here make sense, or something that makes it clear 3
is about the levels of cache currently describable.  

> +    int bottom_node = 3, bottom_cluster = 3, bottom_core = 3, bottom_thread = 3;
> +    unsigned int num_cache;
> +    CPUCaches caches[16];
> +    bool cache_created = false;
> +
> +    num_cache = virt_get_caches(vms, caches);
> +
> +    if (ms->smp_cache.IsDefined &&
> +        partial_cache_description(ms, caches, num_cache)) {
> +            error_setg(&error_fatal, "Missing cache description");
> +            return;
> +    }
>  
>      /*
>       * See Linux Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -446,9 +654,15 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
>  
>      for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
> +        socket_id = cpu / (ms->smp.clusters * ms->smp.cores * ms->smp.threads);
> +        cluster_id = cpu / (ms->smp.cores * ms->smp.threads) % ms->smp.clusters;
> +        core_id = cpu / (ms->smp.threads) % ms->smp.cores;
> +        thread_id = cpu % ms->smp.cores;
> +
>          char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
>          ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
>          CPUState *cs = CPU(armcpu);
> +        const char *prefix = NULL;
>  
>          qemu_fdt_add_subnode(ms->fdt, nodename);
>          qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
> @@ -478,6 +692,177 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
>                                    qemu_fdt_alloc_phandle(ms->fdt));
>          }
>  
> +        if (!vmc->no_cpu_topology && num_cache) {
> +            for (uint8_t i = 0; i < num_cache; i++) {
> +                /* only level 1 in the CPU entry */
> +                if (caches[i].level > 1) {
> +                    continue;
> +                }
> +

One blank line only.

> +
> +                if (caches[i].type == INSTRUCTION) {
> +                    prefix = "i-cache";
> +                } else if (caches[i].type == DATA) {
> +                    prefix = "d-cache";
> +                } else if (caches[i].type == UNIFIED) {
> +                    error_setg(&error_fatal,
> +                               "Unified type is not implemented at level %d",
> +                               caches[i].level);
> +                    return;
> +                } else {
> +                    error_setg(&error_fatal, "Undefined cache type");
> +                    return;
> +                }
> +
> +                set_cache_properties(ms->fdt, nodename, prefix, caches[i]);
> +            }
> +        }
> +
> +        if (socket_id != last_socket) {
> +            bottom_node = top_node;
> +            /* this assumes socket as the highest topological level */

Is there any way we can check that remains true?  Maybe a question for other
reviewers.

> +            socket_offset = 0;
> +            cluster_offset = 0;
> +            if (cache_described_at(ms, CPU_TOPOLOGY_LEVEL_SOCKET) &&
> +                find_the_lowest_level_cache_defined_at_level(ms,
> +                    &bottom_node,
> +                    CPU_TOPOLOGY_LEVEL_SOCKET)) {
> +
> +                if (bottom_node == 1) {
> +                    error_report("Cannot share L1 at socket_id %d.", socket_id);

Maybe add a comment on why.  (DT limitation rather than a theoretical one).

> +                }
> +
> +                cache_created = add_cpu_cache_hierarchy(ms->fdt, caches,
> +                                                        num_cache,
> +                                                        top_node,
> +                                                        bottom_node, cpu,
> +                                                        &socket_offset);
> +
> +                if (!cache_created) {
> +                    error_setg(&error_fatal,
> +                               "Socket: No caches at levels %d-%d",
> +                               top_node, bottom_node);
> +                    return;
> +                }
> +
> +                top_cluster = bottom_node - 1;
> +            }
> +
> +            last_socket = socket_id;
> +        }
> +
...
> diff --git a/hw/cpu/core.c b/hw/cpu/core.c
> index 495a5c30ff..186bb367e7 100644
> --- a/hw/cpu/core.c
> +++ b/hw/cpu/core.c
> @@ -102,4 +102,101 @@ static void cpu_core_register_types(void)
>      type_register_static(&cpu_core_type_info);
>  }
>  
> +bool cache_described_at(const MachineState *ms, CpuTopologyLevel level)
> +{
> +    if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3) == level ||
> +        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2) == level ||
> +        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I) == level ||
> +        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D) == level) {
> +        return true;
> +    }
> +    return false;
> +}
> +
> +int partial_cache_description(const MachineState *ms,
> +                              CPUCaches *caches,
> +                              int num_caches)

Can be wrapped onto fewer sub 80 char lines.

> +{
> +    int level, c;
> +
> +    for (level = 1; level < num_caches; level++) {
> +        for (c = 0; c < num_caches; c++) {
> +            if (caches[c].level != level) {
> +                continue;
> +            }
> +
> +            switch (level) {
> +            case 1:
> +                /*
> +                 * L1 cache is assumed to have both L1I and L1D available.
> +                 * Technically both need to be checked.
> +                 */
> +                if (machine_get_cache_topo_level(ms, 
> +                                                 CACHE_LEVEL_AND_TYPE_L1I) ==
> +                    CPU_TOPOLOGY_LEVEL_DEFAULT)
> +                {
> +                    assert(machine_get_cache_topo_level(ms,
> +                                CACHE_LEVEL_AND_TYPE_L1D) ==
> +                           CPU_TOPOLOGY_LEVEL_DEFAULT);

assert not really appropriate way to trigger an exit.
error_setg() or similar or just trigger an error_fatal.
Not sure what is common in related code.

> +                    return level;
> +                }
> +                break;
> +            case 2:
> +                if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2) ==
> +                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
> +                    return level;
> +                }
> +                break;
> +            case 3:
> +                if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3) ==
> +                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
> +                    return level;
> +                }
> +                break;
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * This function assumes l3 and l2 have unified cache and l1 is split l1d
> + * and l1i, and further prepares the lowest cache level for a topology
> + * level.  The info will be fed to build_caches to create caches at the
> + * right level.
> + */
> +int find_the_lowest_level_cache_defined_at_level(const MachineState *ms,
> +                                                 int *level_found,
> +                                                 CpuTopologyLevel topo_level) {
> +
> +    CpuTopologyLevel level;
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I);
> +    if (level == topo_level) {
> +        *level_found = 1;
> +        return 1;

This code evolved, but now it makes little sense to return the level found
and the put it in level_found.  Perhaps just return a bool?

> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D);
> +    if (level == topo_level) {
> +        *level_found = 1;
> +        return 1;
> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
> +    if (level == topo_level) {
> +        *level_found = 2;
> +        return 2;
> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3);
> +    if (level == topo_level) {
> +        *level_found = 3;
> +        return 3;
> +    }
> +
> +    return 0;
> +}
> +
>  type_init(cpu_core_register_types)
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index a4d937ed45..7b0311ce6e 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -39,6 +39,7 @@
>  #include "sysemu/kvm.h"
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "qom/object.h"
> +#include "hw/cpu/core.h"
>  
>  #define NUM_GICV2M_SPIS       64
>  #define NUM_VIRTIO_TRANSPORTS 32
> @@ -50,6 +51,8 @@
>  /* GPIO pins */
>  #define GPIO_PIN_POWER_BUTTON  3
>  
> +#define CPU_MAX_CACHES 16
> +
>  enum {
>      VIRT_FLASH,
>      VIRT_MEM,
> @@ -188,6 +191,8 @@ OBJECT_DECLARE_TYPE(VirtMachineState, VirtMachineClass, VIRT_MACHINE)
>  
>  void virt_acpi_setup(VirtMachineState *vms);
>  bool virt_is_acpi_enabled(VirtMachineState *vms);

> +unsigned int virt_get_caches(const VirtMachineState *vms,
> +                             CPUCaches *caches);
>  
Fits on one line under 80 chars, so undo that wrap.

Thanks,

Jonathan






