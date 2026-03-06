Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A83F513ED
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyLSh-0003FP-Iv; Thu, 05 Mar 2026 22:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyLSc-0003En-LS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:02:43 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyLSa-0000SC-31
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772766160; x=1804302160;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DhvNDxxeIWLb9YuNZGM3wTYZ+ckehia3cilXA5xumY0=;
 b=We5KHgbp9q+wWKx47VvA/FVlNqACiPkpXTtWEHGUKrWxnfQTS5Og8vpH
 QLnPwqbFD8OEW+5x9AIN4rb5pm2xxTrqqe99ZGqxb4WO585qWIR4jAPAq
 zYnCpU2hrkTQd7b2LyCMWNvgZ//wVTdBP434urZCPr+/V4NgAR5ji4b2y
 eLmT9fQefzDR6egiNSRSI+kwqaAOHsaEo9gVzMDXgvHAFEVf2bxzFsNcS
 dL7xvTrucNxtS9ymYuIKUQWnjUCb8l7jtOW0yiwhbTtAiSQ6TR34OWSr2
 Kg6RQPjqYq2FT+EWJDlgoQfCxOSX3F996BfMhYUNmLVsKggITepa9wy2H w==;
X-CSE-ConnectionGUID: rysiL6gmT4mPbhD7BX847w==
X-CSE-MsgGUID: SnyX4YboSKqfxgvzn59uwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84954575"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84954575"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:02:33 -0800
X-CSE-ConnectionGUID: hV1FhsldRRyy4/47AI7qSA==
X-CSE-MsgGUID: 753ji1UKSjqS6iqFsXsGgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="219015950"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147])
 ([10.124.241.147])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:02:29 -0800
Message-ID: <0fe9efc7-c3b3-4e11-b99e-17c80fe72892@linux.intel.com>
Date: Fri, 6 Mar 2026 11:02:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 04/13] target/i386: Adjust maximum number of PMU
 counters
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-5-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260304180713.360471-5-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/5/2026 2:07 AM, Zide Chen wrote:
> Changing either MAX_GP_COUNTERS or MAX_FIXED_COUNTERS affects the
> VMState layout and therefore requires bumping the migration version
> IDs.  Adjust both limits together to avoid repeated VMState version
> bumps in follow-up patches.
>
> To support full-width writes, QEMU needs to handle the alias MSRs
> starting at 0x4c1.  With the current limits, the alias range can
> extend into MSR_MCG_EXT_CTL (0x4d0).  Reducing MAX_GP_COUNTERS from 18
> to 15 avoids the overlap while still leaving room for future expansion
> beyond current hardware (which supports at most 10 GP counters).
>
> Increase MAX_FIXED_COUNTERS to 7 to support additional fixed counters
> (e.g. Topdown metric events).
>
> With these changes, bump version_id to prevent migration to older
> QEMU, and bump minimum_version_id to prevent migration from older
> QEMU, which could otherwise result in VMState overflows.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  target/i386/cpu.h     | 8 ++------
>  target/i386/machine.c | 4 ++--
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 6d3e70395dbd..23d4ee13abfa 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1749,12 +1749,8 @@ typedef struct {
>  #define CPU_NB_REGS CPU_NB_REGS32
>  #endif
>  
> -#define MAX_FIXED_COUNTERS 3
> -/*
> - * This formula is based on Intel's MSR. The current size also meets AMD's
> - * needs.
> - */
> -#define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)
> +#define MAX_FIXED_COUNTERS 7
> +#define MAX_GP_COUNTERS    15

I suppose it's good enough to reduce MAX_GP_COUNTERS to 10. I don't think
there would be 10+ GP counters for Intel platforms in near future. But need
AMD guys to confirm if it's enough for AMD platforms.

Of course, shrinking MAX_GP_COUNTERS to 15 is fine for me as well.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>  
>  #define NB_OPMASK_REGS 8
>  
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 1125c8a64ec5..7d08a05835fc 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -685,8 +685,8 @@ static bool pmu_enable_needed(void *opaque)
>  
>  static const VMStateDescription vmstate_msr_architectural_pmu = {
>      .name = "cpu/msr_architectural_pmu",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .needed = pmu_enable_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(env.msr_fixed_ctr_ctrl, X86CPU),

