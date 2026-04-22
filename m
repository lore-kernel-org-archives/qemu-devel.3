Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DAAF94CD8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSPK-0003T5-0Y; Wed, 22 Apr 2026 03:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wFSPC-0003Sc-Gp
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 03:53:55 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wFSP8-0006Z2-DZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 03:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776844431; x=1808380431;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=r2pZ45WaoLdd62U4o1lqu1UiwYsdm9zBkrbUIa1Vv80=;
 b=jA71ygZrM3YcsyX9LEmiAiRFhRhc+nBnZ3z+5deI5d0lPvXWTzEKUTxb
 P6JEXNW9VTgFt5PxmFKwRO/D+2h3A9E7A5p3r1Tn+SGJe0omI4brJfiJg
 4ACuX4lKPVm5qEqaY2eIifu32m67l4evRWbQWohtXqdillpP6dwzgPN8G
 Esj7w7EyDnD2LMmzswcvBh8X0pBfSe4CflkqudK/78fS60fXJmIDylCqD
 0S51bXqQuVrvQnlnJvrNw/Me04W/r3Vt9DclXGZeHfSYH65WJljvAu0qv
 tT62Z7EJneGT3E8HA1Jj+Oc5RyxSg++a5rYMQHj1BxmaiUSog9PXbGc1r A==;
X-CSE-ConnectionGUID: DJb8/sqNS7WZnaBqPM/1pA==
X-CSE-MsgGUID: 1VFQYNFPRP6b5BqkmkGdGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77494789"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="77494789"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 00:53:47 -0700
X-CSE-ConnectionGUID: qDdjn8KCSN29ReDAN20Xqw==
X-CSE-MsgGUID: cpN69CZ8RoKOyENbweVGiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="236649745"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 22 Apr 2026 00:53:43 -0700
Date: Wed, 22 Apr 2026 16:21:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zide Chen <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH V3 11/13] target/i386: Add pebs-fmt CPU option
Message-ID: <aeiE9ZZ5AE+uMgmN@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-12-zide.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304180713.360471-12-zide.chen@intel.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Zide,

On Wed, Mar 04, 2026 at 10:07:10AM -0800, Zide Chen wrote:
> Date: Wed, 4 Mar 2026 10:07:10 -0800
> From: Zide Chen <zide.chen@intel.com>
> Subject: [PATCH V3 11/13] target/i386: Add pebs-fmt CPU option
> X-Mailer: git-send-email 2.53.0
> 
> Similar to lbr-fmt, target/i386 does not support multi-bit CPU
> properties, so the PEBS record format cannot be exposed as a
> user-visible CPU feature.
> 
> Add a pebs-fmt option to allow users to specify the PEBS format via the
> command line.  Since the PEBS state is part of the vmstate, this option
> is considered migratable.
> 
> We do not support PEBS record format 0.  Although it is a valid format
> on some very old CPUs, it is unlikely to be used in practice.  This
> allows pebs-fmt=0 to be used to explicitly disable PEBS in the case of
> migratable=off.
> 
> If PEBS is not enabled, mark it as unavailable in IA32_MISC_ENABLE and
> clear the PEBS-related bits in IA32_PERF_CAPABILITIES.
> 
> If migratable=on on PEBS capable host and pmu is enabled:
> - PEBS is disabled if pebs-fmt is not specified or pebs-fmt=0.
> - PEBS is enabled if pebs-fmt is set to the same value as the host.
> 
> When migratable=off, the behavior is similar, except that omitting
> the pebs-fmt option does not disable PEBS.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>

...

>      if (user_req != -1) {
> +        if (!is_lbr_fmt && !(env->features[FEAT_1_EDX] & CPUID_DTS)) {
> +            error_setg(errp, "vPMU: %s is unsupported without Debug Store", name);
> +            return false;
> +        }
> +

This is a general code path to check user_req != -1... but

> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 1d0047d037c7..60bf3899852a 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -231,6 +231,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
>      }
>  
>      cpu->lbr_fmt = -1;
> +    cpu->pebs_fmt = -1;

-1 is only set for KVM, so other accelerators have lbr_fmt=0 by default.

This will cause make check fail:

stderr:
qemu-system-x86_64: vPMU: pebs is unsupported without Debug Store
Broken pipe
../tests/qtest/libqtest.c:201: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)

(test program exited with status code -6)

So I think the initialization should be placed in the general code path
as well (x86_cpu_initfn()) - and move lbr_fmt initialization back to
general x86 codes.

Thanks,
Zhao


