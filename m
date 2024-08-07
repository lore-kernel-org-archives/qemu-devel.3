Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E1CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 15:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbiWK-0008RS-8i; Wed, 07 Aug 2024 11:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbiWJ-0008Qy-5N
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 11:24:11 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbiWH-0003al-9f
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 11:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723044249; x=1754580249;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1C4N7azzbwbfTVKCZSe9FZT0areAlLy1fUB37HjW0wA=;
 b=ndddy7CbO0f+Bugf6y3EHiSg95rDfLlftVAdsvhwCZoEtkFXxqgIOrkm
 NOO4dhcytWC/2RLsv90p7txGkH+yoJvYqBa+9DgWjednT7mKzLcOswHaj
 L5EwKztMZZBGpmR3R0z8Oom8AKCCknwDjqJKnk/e8wIAqfE+li5suvmwJ
 u6COP5a4DSRjKhkIYZ7BEv1qU16IVavKFhKCiecbshJLNWgTcJnrBzs5m
 X6cyaFO6Mj7m/ONmcFggpcYz8dEn0upkv0lVCr/2oXQ9/FJWLM58tDvLe
 4myiCFRr6JS+YaWSFvphNYsRw6mIldtEWJV2CAZwGYJRRAzVAKjVR6E1M w==;
X-CSE-ConnectionGUID: HfknPZS4TamnRJV2Ncbtpg==
X-CSE-MsgGUID: 1H2dT+COQ0a4I8Yv4HQI9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="12903062"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="12903062"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 08:24:05 -0700
X-CSE-ConnectionGUID: 4cMn+c+jSGqtQI20IKgudA==
X-CSE-MsgGUID: qtql8pdFTQOatiq5fY0XqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="61828536"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 07 Aug 2024 08:24:04 -0700
Date: Wed, 7 Aug 2024 23:39:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 lei4.wang@intel.com, xin3.li@intel.com
Subject: Re: [PATCH v1 3/3] target/i386: Raise the highest index value used
 for any VMCS encoding
Message-ID: <ZrOVSXX2uvezT3J1@intel.com>
References: <20240807081813.735158-1-xin@zytor.com>
 <20240807081813.735158-4-xin@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807081813.735158-4-xin@zytor.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Xin,

On Wed, Aug 07, 2024 at 01:18:12AM -0700, Xin Li (Intel) wrote:
> Date: Wed,  7 Aug 2024 01:18:12 -0700
> From: "Xin Li (Intel)" <xin@zytor.com>
> Subject: [PATCH v1 3/3] target/i386: Raise the highest index value used for
>  any VMCS encoding
> X-Mailer: git-send-email 2.45.2
> 
> From: Lei Wang <lei4.wang@intel.com>
> 
> Because the index value of the VMCS field encoding of FRED injected-event
> data (one of the newly added VMCS fields for FRED transitions), 0x52, is
> larger than any existing index value, raise the highest index value used
> for any VMCS encoding to 0x52.
> 
> Because the index value of the VMCS field encoding of Secondary VM-exit
> controls, 0x44, is larger than any existing index value, raise the highest
> index value used for any VMCS encoding to 0x44.
> 
> Co-developed-by: Xin Li <xin3.li@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  target/i386/cpu.h     | 1 +
>  target/i386/kvm/kvm.c | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 118ef9cb68..62324c3dcd 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1186,6 +1186,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>  #define VMX_VM_EXIT_PT_CONCEAL_PIP                  0x01000000
>  #define VMX_VM_EXIT_CLEAR_IA32_RTIT_CTL             0x02000000
>  #define VMX_VM_EXIT_LOAD_IA32_PKRS                  0x20000000
> +#define VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS     0x80000000

It's necessary to add the corresponding feat_name to FEAT_VMX_EXIT_CTLS
feat word array, which could help filter the user's settings in the -cpu.

>  #define VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS            0x00000004
>  #define VMX_VM_ENTRY_IA32E_MODE                     0x00000200
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 31f149c990..fac5990274 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3694,7 +3694,14 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
>      kvm_msr_entry_add(cpu, MSR_IA32_VMX_CR4_FIXED0,
>                        CR4_VMXE_MASK);
>  
> -    if (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_TSC_SCALING) {
> +    if (f[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
> +        /* FRED injected-event data (0x2052).  */
> +        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x52);

HMM, I have the questions when I check the FRED spec.

Section 9.3.4 said, (for injected-event data) "This field has uses the
encoding pair 2052H/2053H."

So why adjust the highest index to 0x52 other than 0x53?

And it seems FRED introduces another field "original-event data"
(0x2404/0x2405), why not consider this field here as well?

> +    } else if (f[FEAT_VMX_EXIT_CTLS] &
> +               VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
> +        /* Secondary VM-exit controls (0x2044).  */
> +        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x44);
> +    } else if (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_TSC_SCALING) {
>          /* TSC multiplier (0x2032).  */
>          kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x32);
>      } else {

Maybe we could adjust the index in a cleaner way like
x86_cpu_adjust_level(), but the current case-by-case is ok for me as
well.

Regards,
Zhao



