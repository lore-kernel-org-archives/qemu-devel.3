Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E90C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 08:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCwi8-0008O3-FD; Thu, 08 May 2025 04:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCwi6-0008Ll-If
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:34:30 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCwi3-0000KW-VC
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746693268; x=1778229268;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=/l0AhjEEqojGSZ/D5qgHtK6wzDpY2Qe3A81fX8qNpHE=;
 b=jLLgG9TqzhM6CO7XvishxzjOZtvLNgis8TLHv96JgGgrKHhl24UxUOYG
 z9Epabosc/CVeRB437IADgZyrS3KTBYNmOR1rwvAA7egJdkCa4WmtorOW
 FcADVKBoktUv6xRB0UvGd+YgZfH6ubLG4WsLxrxaOPukNeErC8frGyKpy
 qAMJQfyW2/bbLkGhOxdo3pAmG9c7ygNBF/CUP/0aMmrrVjTnQcYEzOWqY
 fKp6Oq5yNi4hiirAceCbrH1pHUhDh0pvVj/t1LXB3obMbJtoQqkQmL/CK
 TRnaXm/Fyh40muEUD0f6nCYeCLdWTX+R9Ry8C7SHqTYHfPDP9DIcQ6Bcy A==;
X-CSE-ConnectionGUID: A9c1cqbHQSKLalR5VMNWhA==
X-CSE-MsgGUID: 0aFVUKNCSpOUBmNetmGlMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="47564701"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="47564701"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 01:34:24 -0700
X-CSE-ConnectionGUID: WIpIa8hQQ1qqC07YVMQgbQ==
X-CSE-MsgGUID: wlbvpXm/QOqbYq6l/Aelaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="136717295"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 08 May 2025 01:34:21 -0700
Date: Thu, 8 May 2025 16:55:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Paolo Bonzini <pbonzini@redhat.com>,
 yeeli@zhaoxin.com, cobechen@zhaoxin.com, ewanhai@zhaoxin.com,
 MaryFeng@zhaoxin.com, Runaguo@zhaoxin.com, Xanderchen@zhaoxin.com,
 Alansong@zhaoxin.com, qemu-devel@nongnu.org
Subject: Re: [Bug] QEMU TCG warnings after commit c6bd2dd63420 - HTT /
 CMP_LEG bits
Message-ID: <aBxxe3lsIFs0/xNP@intel.com>
References: <c111d9f9-2914-4b41-811a-b3a9ad0d83a9@zhaoxin.com>
 <4a1cfda7-4077-4754-b5a5-40db744419b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a1cfda7-4077-4754-b5a5-40db744419b4@intel.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, Apr 29, 2025 at 01:55:59PM +0800, Xiaoyao Li wrote:
> Date: Tue, 29 Apr 2025 13:55:59 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [Bug] QEMU TCG warnings after commit c6bd2dd63420 - HTT /
>  CMP_LEG bits
> 
> On 4/29/2025 11:02 AM, Ewan Hai wrote:
> > Hi Community,
> > 
> > This email contains 3 bugs appear to share the same root cause.
> > 
> > [1] We ran into the following warnings when running QEMU v10.0.0 in TCG
> > mode:
> > 
> > qemu-system-x86_64 \
> >    -machine q35 \
> >    -m 4G -smp 4 \
> >    -kernel ./arch/x86/boot/bzImage \
> >    -bios /usr/share/ovmf/OVMF.fd \
> >    -drive file=~/kernel/rootfs.ext4,index=0,format=raw,media=disk \
> >    -drive file=~/kernel/swap.img,index=1,format=raw,media=disk \
> >    -nographic \
> >    -append 'root=/dev/sda rw resume=/dev/sdb console=ttyS0 nokaslr'
> > 
> > qemu-system-x86_64: warning: TCG doesn't support requested feature:
> > CPUID.01H:EDX.ht [bit 28]
> > qemu-system-x86_64: warning: TCG doesn't support requested feature:
> > CPUID.80000001H:ECX.cmp-legacy [bit 1]
> > (repeats 4 times, once per vCPU)
> > 
> > Tracing the history shows that commit c6bd2dd63420 "i386/cpu: Set up
> > CPUID_HT in x86_cpu_expand_features() instead of cpu_x86_cpuid()" is
> > what introduced the warnings.
> > 
> > Since that commit, TCG unconditionally advertises HTT (CPUID 1 EDX[28])
> > and CMP_LEG (CPUID 8000_0001 ECX[1]). Because TCG itself has no SMT
> > support, these bits trigger the warnings above.
> > 
> > [2] Also, Zhao pointed me to a similar report on GitLab:
> > https://gitlab.com/qemu-project/qemu/-/issues/2894
> > The symptoms there look identical to what we're seeing.
> > 
> > By convention we file one issue per email, but these two appear to share
> > the same root cause, so I'm describing them together here.
> 
> It was caused by my two patches. I think the fix can be as follow.
> If no objection from the community, I can submit the formal patch.
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1f970aa4daa6..fb95aadd6161 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -776,11 +776,12 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t
> vendor1,
>            CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC | CPUID_SEP | \
>            CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV | CPUID_PAT | \
>            CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | \
> -          CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE)
> +          CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE | \
> +          CPUID_HT)
>            /* partly implemented:
>            CPUID_MTRR, CPUID_MCA, CPUID_CLFLUSH (needed for Win64) */
>            /* missing:
> -          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_HT, CPUID_TM, CPUID_PBE */
> +          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_TM, CPUID_PBE */
> 
>  /*
>   * Kernel-only features that can be shown to usermode programs even if
> @@ -848,7 +849,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t
> vendor1,
> 
>  #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
>            CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
> -          CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_KERNEL_FEATURES)
> +          CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_KERNEL_FEATURES | \
> +          CPUID_EXT3_CMP_LEG)
> 
>  #define TCG_EXT4_FEATURES 0

This fix is fine for me...at least from SDM, HTT depends on topology and
it should exist when user sets "-smp 4".



