Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8ECC83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFJA-0006ve-2U; Tue, 08 Jul 2025 16:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZEBb-0005hH-0P; Tue, 08 Jul 2025 15:41:03 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZEBY-0005n8-Qe; Tue, 08 Jul 2025 15:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752003661; x=1783539661;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=d/0J7iUOqqeC6gDwuQ/GYQa5PstSaIDSlqPTS3QKdgU=;
 b=Bw3B8wF/pjjLPJ/gKxVSM7YWCwS92oEzDjTRBpE2v6d72QThecnoVreJ
 agmR9IQuQaWlbTjR3LdUZupc9YGzhxNuBWGuSBYYJiqDitCaNnZagJcdt
 ARSbhRUEVEJBolWs+IqIvnBHqoX6n4amTkN2Tie8wriPc0+kqdXZbo/Ly
 9HaMofYtEAyY3j5/a4OBflQxZs0+60cElfYLOhI4qI9OUfdjB51yGZ8hY
 bFmhGgQyYkHUSSK8B/zTG59EQeRW1R1AF2UZY9WsbfLWkQ5xxKDDm59Gx
 T3e2QYTkkvT+iRmGnT/eI+BZXTNvFMtJLOm3Yoe+Tj37njLsI47Lek2bB A==;
X-CSE-ConnectionGUID: 92zHIeQZQV+1gbWqyjj2iA==
X-CSE-MsgGUID: Qcpx+4hlQgGdtlZG+eBr/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53313338"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="53313338"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 01:41:29 -0700
X-CSE-ConnectionGUID: zcxjx1bBQWORE8KEJr9veA==
X-CSE-MsgGUID: cwwFz/aKRNGphQYarULxVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="186396768"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 08 Jul 2025 01:41:24 -0700
Date: Tue, 8 Jul 2025 17:02:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, armbru@redhat.com,
 berrange@redhat.com, dapeng1.mi@linux.intel.com,
 eric.auger@redhat.com, farman@linux.ibm.com,
 gustavo.romero@linaro.org, imammedo@redhat.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mst@redhat.com,
 mtosatti@redhat.com, peter.maydell@linaro.org, philmd@linaro.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, shannon.zhaosl@gmail.com,
 yangyicong@hisilicon.com
Subject: Re: [PATCH v14 2/7] hw/core/machine: topology functions capabilities
 added
Message-ID: <aGzevGnyfOM4WyKJ@intel.com>
References: <20250707121908.155-1-alireza.sanaee@huawei.com>
 <20250707121908.155-3-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707121908.155-3-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 07, 2025 at 01:19:03PM +0100, Alireza Sanaee via wrote:
> Date: Mon, 7 Jul 2025 13:19:03 +0100
> From: Alireza Sanaee via <qemu-devel@nongnu.org>
> Subject: [PATCH v14 2/7] hw/core/machine: topology functions capabilities
>  added
> X-Mailer: git-send-email 2.34.1
> 
> Add two functions one of which finds the lowest level cache defined in
> the cache description input, and the other checks if caches are defined
> at a particular level.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/core/machine-smp.c | 59 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/boards.h   |  7 +++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 0be0ac044c..4baf4a878e 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -406,3 +406,62 @@ bool machine_check_smp_cache(const MachineState *ms, Error **errp)
>  
>      return true;
>  }
> +
> +/*
> + * This function assumes l3 and l2 have unified cache and l1 is split l1d
> + * and l1i, and further prepares the lowest cache level for a topology
> + * level.  The info will be fed to build_caches to create caches at the
> + * right level.
> + */
> +bool machine_find_lowest_level_cache_at_topo_level(const MachineState *ms,
> +                                                   int *level_found,
> +                                                   CpuTopologyLevel topo_level)
> +{
> +
> +    CpuTopologyLevel level;
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I);
> +    if (level == topo_level) {
> +        *level_found = 1;

Unfortunately, there is no proper mapping between the cache enumeration
and the cache level...

> +        return true;
> +    }
> +

...at least for now, this is fine for me. We can think of how to
organize everything better afterwards. So,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



