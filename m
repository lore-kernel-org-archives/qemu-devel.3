Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10F9C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETKO-0003mu-1G; Mon, 12 May 2025 09:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uETKJ-0003dd-V0
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:36:15 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uETKH-0001ZA-C7
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747056973; x=1778592973;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=BWanhrcjUc2Guy5WnzRoRspVEfC8/bifM0S35VOeN7g=;
 b=K5+i04xn9ARImDEXNqPBI/D4UhSg4V+mh5x/uJo3M0uc4zwvdsCXQduW
 nWbu7AyD7HRlOXm2oq0mRMwDuAYa8mFsW0Uhm7K1afjzoQ9glW4ya67Xi
 G07zG1tODfxLwkVJNiGy2qXK+A3ExOrHD2hY8xBuPgIwaq2Auj3IJ9ZYp
 fiONiHxAxHyqCcmHhi3UbXbI0Jc4U8h2g22vYxBCQV6u7x3bFVemuTN+Y
 Ij6SfO7I2Bq+fmJ+F2z0whkwGNayjeOGniFcC+Wh8lXjPoJN5uwIjRfom
 8JL0JQqvT4hXoqSD33s6iuktaI5QdUAP9bVwJSJl7OnDllYVKJ8xHKA3s w==;
X-CSE-ConnectionGUID: vLglKM4aQZW3XZL7hNnGKw==
X-CSE-MsgGUID: XSvfyOxgRRmxhXj4L1sXnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52502152"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="52502152"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 06:36:11 -0700
X-CSE-ConnectionGUID: K67uPbrNQaS08KEA9HTLAQ==
X-CSE-MsgGUID: 6SFUYvfVQqqH3NWfqdcC/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="168306243"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 06:36:10 -0700
Message-ID: <74e48026-51e4-4b40-ad1b-c51e5bbf8344@intel.com>
Date: Mon, 12 May 2025 21:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-headers: update from 6.15 + kvm/next
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250512093146.91254-1-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512093146.91254-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/2025 5:31 PM, Paolo Bonzini wrote:
> This brings in the userspace TDX API.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   linux-headers/asm-x86/kvm.h | 71 +++++++++++++++++++++++++++++++++++++
>   linux-headers/linux/kvm.h   |  1 +
>   2 files changed, 72 insertions(+)
> 
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index dc591fb17e5..7fb57ccb2a7 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -439,6 +439,7 @@ struct kvm_sync_regs {
>   #define KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS	(1 << 6)
>   #define KVM_X86_QUIRK_SLOT_ZAP_ALL		(1 << 7)
>   #define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
> +#define KVM_X86_QUIRK_IGNORE_GUEST_PAT		(1 << 9)
>   
>   #define KVM_STATE_NESTED_FORMAT_VMX	0
>   #define KVM_STATE_NESTED_FORMAT_SVM	1
> @@ -928,4 +929,74 @@ struct kvm_hyperv_eventfd {
>   #define KVM_X86_SNP_VM		4
>   #define KVM_X86_TDX_VM		5
>   
> +/* Trust Domain eXtension sub-ioctl() commands. */
> +enum kvm_tdx_cmd_id {
> +	KVM_TDX_CAPABILITIES = 0,
> +	KVM_TDX_INIT_VM,
> +	KVM_TDX_INIT_VCPU,
> +	KVM_TDX_INIT_MEM_REGION,
> +	KVM_TDX_FINALIZE_VM,
> +	KVM_TDX_GET_CPUID,
> +
> +	KVM_TDX_CMD_NR_MAX,
> +};
> +
> +struct kvm_tdx_cmd {
> +	/* enum kvm_tdx_cmd_id */
> +	__u32 id;
> +	/* flags for sub-commend. If sub-command doesn't use this, set zero. */
> +	__u32 flags;
> +	/*
> +	 * data for each sub-command. An immediate or a pointer to the actual
> +	 * data in process virtual address.  If sub-command doesn't use it,
> +	 * set zero.
> +	 */
> +	__u64 data;
> +	/*
> +	 * Auxiliary error code.  The sub-command may return TDX SEAMCALL
> +	 * status code in addition to -Exxx.
> +	 */
> +	__u64 hw_error;
> +};
> +
> +struct kvm_tdx_capabilities {
> +	__u64 supported_attrs;
> +	__u64 supported_xfam;
> +	__u64 reserved[254];
> +
> +	/* Configurable CPUID bits for userspace */
> +	struct kvm_cpuid2 cpuid;
> +};
> +
> +struct kvm_tdx_init_vm {
> +	__u64 attributes;
> +	__u64 xfam;
> +	__u64 mrconfigid[6];	/* sha384 digest */
> +	__u64 mrowner[6];	/* sha384 digest */
> +	__u64 mrownerconfig[6];	/* sha384 digest */
> +
> +	/* The total space for TD_PARAMS before the CPUIDs is 256 bytes */
> +	__u64 reserved[12];
> +
> +	/*
> +	 * Call KVM_TDX_INIT_VM before vcpu creation, thus before
> +	 * KVM_SET_CPUID2.
> +	 * This configuration supersedes KVM_SET_CPUID2s for VCPUs because the
> +	 * TDX module directly virtualizes those CPUIDs without VMM.  The user
> +	 * space VMM, e.g. qemu, should make KVM_SET_CPUID2 consistent with
> +	 * those values.  If it doesn't, KVM may have wrong idea of vCPUIDs of
> +	 * the guest, and KVM may wrongly emulate CPUIDs or MSRs that the TDX
> +	 * module doesn't virtualize.
> +	 */
> +	struct kvm_cpuid2 cpuid;
> +};
> +
> +#define KVM_TDX_MEASURE_MEMORY_REGION   _BITULL(0)
> +
> +struct kvm_tdx_init_mem_region {
> +	__u64 source_addr;
> +	__u64 gpa;
> +	__u64 nr_pages;
> +};
> +
>   #endif /* _ASM_X86_KVM_H */
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index e5f3e8b5a02..99cc82a275c 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -369,6 +369,7 @@ struct kvm_run {
>   #define KVM_SYSTEM_EVENT_WAKEUP         4
>   #define KVM_SYSTEM_EVENT_SUSPEND        5
>   #define KVM_SYSTEM_EVENT_SEV_TERM       6
> +#define KVM_SYSTEM_EVENT_TDX_FATAL      7
>   			__u32 type;
>   			__u32 ndata;
>   			union {


