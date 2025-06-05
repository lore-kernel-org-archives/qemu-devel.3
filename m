Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396C9C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6pK-0000vo-Db; Thu, 05 Jun 2025 05:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uN6pD-0000tn-H2; Thu, 05 Jun 2025 05:23:51 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uN6pA-0002rc-1b; Thu, 05 Jun 2025 05:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749115428; x=1780651428;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fs8GZxcpGH1OvN0sSfD/neWbbxp/8uG4eQd0WdAblHw=;
 b=Mk/cHu/d9NL6HsrB+4/v/Il+3mDwZr6KcGzO4rfElSg+0k4/fFYQJaIE
 QEWBLpaH2XzIS9b9mlUrpooWWluwXZu55CldW2N62AOeT44fJIezsiFYV
 WhDzbPIKdj4gbiUi/Zfq32tRKk8muNSeEwFE2OQk+4+3kS09snwwWl4cH
 9TtTZVeQc7VcApiQvtilXBhe7SDY8O/LEJGJvbv+ungJEgaQbdAiqYGPv
 dyFR/GLW6D2BDQDmVEzYgtsTCYGIrtYa+TvBQPz29j0lIHmyYv1v1Sip4
 /CO0YWO63FkRMYDsSKH3di9CprvQVc+LvGLrTkX3E9tkOiU52zQpCb5x2 Q==;
X-CSE-ConnectionGUID: 0RHgX4YbT3qS2TxPzioV0A==
X-CSE-MsgGUID: EiFhj0zRSbKtoH27CN0mKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51141681"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="51141681"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 02:23:44 -0700
X-CSE-ConnectionGUID: F49XkvY8ROi4JvrcHwCIGg==
X-CSE-MsgGUID: 3iyVGxBtRqCO/RVYVy1ilw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="176318547"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 05 Jun 2025 02:23:40 -0700
Date: Thu, 5 Jun 2025 17:44:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: mst@redhat.com, anisinha@redhat.com, armbru@redhat.com,
 berrange@redhat.com, dapeng1.mi@linux.intel.com,
 eric.auger@redhat.com, farman@linux.ibm.com,
 gustavo.romero@linaro.org, imammedo@redhat.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, mtosatti@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com,
 shannon.zhaosl@gmail.com, yangyicong@hisilicon.com, maobibo@loongson.cn
Subject: Re: [PATCH v12 2/6] arm/virt.c: add cache hierarchy to device tree
Message-ID: <aEFnFI+wglkmLD5G@intel.com>
References: <20250604133439.1592-1-alireza.sanaee@huawei.com>
 <20250604133439.1592-3-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604133439.1592-3-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Ali,

I'm very sorry to bother you with some comments after so many versions.

> diff --git a/hw/cpu/core.c b/hw/cpu/core.c
> index 5cb2e9a7f5..7339782663 100644
> --- a/hw/cpu/core.c
> +++ b/hw/cpu/core.c

core.c is not the right place. It just contains the "cpu-core"
abstraction. So we need to move the following functions to other files.

> @@ -102,4 +102,96 @@ static void cpu_core_register_types(void)
>      type_register_static(&cpu_core_type_info);
>  }
>  
> +bool cache_described_at(const MachineState *ms, CpuTopologyLevel level)

It's better to add the comment about what this function did. (its name
doesn't reflect it wants to check the coresponding CPU topology level.)

I also feel it's not a good name, what about "machine_check_cache_at_topo_level"?

Furthermore, we can move this one to hw/core/machine-smp.c, as it is
about with machine's smp_cache.

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
> +int partial_cache_description(const MachineState *ms, CPUCorePPTTCaches *caches,
> +                              int num_caches)

Because I'll suggest to move CPUCorePPTTCaches to include/hw/acpi/cpu.h
later, and this function accepts CPUCorePPTTCaches as the argument, so
I think we could move this function to hw/acpi/cpu.c (if Michael and
Igor don't object).

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
> +                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
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
> +bool find_the_lowest_level_cache_defined_at_level(const MachineState *ms,
> +                                                  int *level_found,
> +                                                  CpuTopologyLevel topo_level) {

This is a very long name :-).

Maybe we can rename it like:

machine_find_lowest_level_cache_at_topo_level,

(sorry this name doesn't shorten the length but align the naming style
in machine-smp.c)

and explain the arguments in the comment.

Furthermore, we can move this one to hw/core/machine-smp.c, too.

> +    CpuTopologyLevel level;
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I);
> +    if (level == topo_level) {
> +        *level_found = 1;
> +        return true;
> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D);
> +    if (level == topo_level) {
> +        *level_found = 1;
> +        return true;
> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
> +    if (level == topo_level) {
> +        *level_found = 2;
> +        return true;
> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3);
> +    if (level == topo_level) {
> +        *level_found = 3;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  type_init(cpu_core_register_types)

...

> diff --git a/include/hw/cpu/core.h b/include/hw/cpu/core.h
> index 98ab91647e..0f7bf8bc28 100644
> --- a/include/hw/cpu/core.h
> +++ b/include/hw/cpu/core.h
> @@ -11,6 +11,7 @@
>  
>  #include "hw/qdev-core.h"
>  #include "qom/object.h"
> +#include "qapi/qapi-types-machine-common.h"
>  
>  #define TYPE_CPU_CORE "cpu-core"
>  
> @@ -25,6 +26,32 @@ struct CPUCore {
>      int nr_threads;
>  };
>  
> +typedef enum CPUCacheType {
> +    CPU_CORE_DATA,
> +    CPU_CORE_INSTRUCTION,
> +    CPU_CORE_UNIFIED,
> +} CPUCoreCacheType;

This is a complete duplicate of the x86's CPUCaches (target/i386/cpu.h).

I think we can move x86's CPUCaches to include/hw/core/cpu.h.

> +typedef struct CPUPPTTCaches {
> +    CPUCoreCacheType type;
> +    uint32_t pptt_id;
> +    uint32_t sets;
> +    uint32_t size;
> +    uint32_t level;
> +    uint16_t linesize;
> +    uint8_t attributes; /* write policy: 0x0 write back, 0x1 write through */
> +    uint8_t associativity;
> +} CPUCorePPTTCaches;

x86 doesn't use PPTT to describe cache so it's not necessary to reuse
CPUCacheInfo (target/i386/cpu.h) for PPTT.

But I understand it's better to place this sturct in include/hw/acpi/cpu.h,
since it is part of the ACPI PPTT table.

> +int partial_cache_description(const MachineState *ms, CPUCorePPTTCaches *caches,
> +                              int num_caches);

Could move to include/hw/acpi/cpu.h, too.

> +bool cache_described_at(const MachineState *ms, CpuTopologyLevel level);
> +
> +bool find_the_lowest_level_cache_defined_at_level(const MachineState *ms,
> +                                                  int *level_found,
> +                                                  CpuTopologyLevel topo_level);
> +

Because these 2 functions' definitions would be moved to
hw/core/machine-smp.c, then we need to move their declarations to
include/hw/boards.h.


Except the above nits, the general part is fine for me.

Thanks,
Zhao



