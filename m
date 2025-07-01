Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021A7C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 08:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWWHe-0002gL-NM; Tue, 01 Jul 2025 04:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWWHb-0002fa-OI; Tue, 01 Jul 2025 04:24:04 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWWHY-0005z8-OF; Tue, 01 Jul 2025 04:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751358241; x=1782894241;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XJ1nQvdfy/CCiwDDxxCvaKYEkbla0xj9i+OIJDssyq4=;
 b=eDKmsx8hjdFyZ360t1QPqoShD6UUfk2rwuCDgvMiTHGQCfkhhP3QJBPJ
 TKhFFl4yhkzVjqUWpDUeS913pWm1j0DYbcGVYczSobS0K/ByJRUan/qen
 egiFOBFyE8vmSBshPUZicWf/R3q01jtA9qb/yuwz9JzPBJtQIXzqKggi5
 EKMu0SMpqUdVWeS1v2kA2X6CyplbNfMFQH66pFV8Tu5QQ8ZFe5GsOf+Si
 oD38jlJunzko39yIM1THYYMfGDsc8uzFX6XYqLH6j36eUG8csXQwgERhK
 CDwMP/VxTtE3cghMWBOzntRdPYtfIMwEiVB9GqCh+CYSbJYCDjTfkg9Mt w==;
X-CSE-ConnectionGUID: bu3sW+O8QLSWheClp12aNw==
X-CSE-MsgGUID: jJ4u7KlVQ6aGteLsDkPzCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="52841558"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="52841558"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 01:23:54 -0700
X-CSE-ConnectionGUID: NlBc+ZzPR/2Nbgh8hdR5mg==
X-CSE-MsgGUID: a0p+2f+sT4WLchxyFjd6gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="159413702"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 01:23:52 -0700
Message-ID: <3a9c8152-3202-4962-a1fe-a2d7fdc33b76@intel.com>
Date: Tue, 1 Jul 2025 16:23:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
To: Alexandre Chartre <alexandre.chartre@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Cc: qemu-stable@nongnu.org, zhao1.liu@intel.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/30/2025 9:30 PM, Alexandre Chartre wrote:
> KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
> cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
> MSR and it makes no sense to emulate it on AMD.
> 
> As a consequence, VMs created on AMD with qemu -cpu host and using
> KVM will advertise the ARCH_CAPABILITIES feature and provide the
> IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
> as the guest OS might not expect this MSR to exist on such cpus (the
> AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
> are not defined on the AMD architecture).
> 
> A fix was proposed in KVM code, however KVM maintainers don't want to
> change this behavior that exists for 6+ years and suggest changes to be
> done in qemu instead.
> 
> So this commit changes the behavior in qemu so that ARCH_CAPABILITIES
> is not provided by default on AMD cpus when the hypervisor emulates it,
> but it can still be provided by explicitly setting arch-capabilities=on.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>   target/i386/cpu.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0d35e95430..7e136c48df 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8324,6 +8324,20 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>           }
>       }
>   
> +    /*
> +     * For years, KVM has inadvertently emulated the ARCH_CAPABILITIES
> +     * MSR on AMD although this is an Intel-specific MSR; and KVM will
> +     * continue doing so to not change its ABI for existing setups.
> +     *
> +     * So ensure that the ARCH_CAPABILITIES MSR is disabled on AMD cpus
> +     * to prevent providing a cpu with an MSR which is not supposed to
> +     * be there, unless it was explicitly requested by the user.
> +     */
> +    if (IS_AMD_CPU(env) &&
> +        !(env->user_features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
> +        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
> +    }

This changes the result for the existing usage of "-cpu host" on AMD. So 
it will need a compat_prop to keep the old behavior for old machine.

But I would like discuss if we really want to do it in QEMU. 
ARCH_CAPABILITIES is not the only one KVM emulates unconditionally. We 
have TSC_DEADLINE_TIMER as well. So why to treat them differently? just 
because some Windows cannot boot? To me, it looks just the bug of 
Windows. So please fix Windows. And to run with the buggy Windows, we 
have the workaround: "-cpu host,-arch-capabilities"

>       if (x86_threads_per_pkg(&env->topo_info) > 1) {
>           env->features[FEAT_1_EDX] |= CPUID_HT;
>   


