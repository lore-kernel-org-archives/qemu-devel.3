Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE24C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdM8X-00042G-F7; Thu, 22 Feb 2024 22:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rdM8V-000422-22
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:22:07 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rdM8S-0003vh-Be
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708658525; x=1740194525;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VBbAKL/s5QKKAzFQYg0xK0ZTO0fF09wSYm1fPY9nymc=;
 b=NemOHgCNShptzXvpKVLbZ4LwYh71BxIX/vwHunqydTMoJxp8SruiFzaX
 prJkgDioelMiwevdXqhVW2P4e1AwosYbnv6dfaBj8yZvRVJHRyVNZFihN
 m/roFiWYQEinAHMo/jqw+Emw76kEw9OnkBHHjZvUgqBY/pPleFET++9En
 zFg/1dVrvIG2lUPsOJuLiyMbBtArnJ4jqOZIxzZdyGw7EFWexdbJLBcyK
 SG+mHZytMtr3eSvv+mIOTvPpuNFTvAUFXIuGN1CQMLxukeMB0nIQW6lPc
 Vk378npQ6INEHjwTz5qSzw9VqhkFXuRs9ixciA5IbyWwKjk58nwcH4p9B w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3113455"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3113455"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 19:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; d="scan'208";a="36559813"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 22 Feb 2024 19:21:59 -0800
Date: Fri, 23 Feb 2024 11:35:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, robert.hu@linux.intel.com
Subject: Re: [PATCH v4 2/2] target/i386: add control bits support for LAM
Message-ID: <ZdgSi35/Lb9FeNoG@intel.com>
References: <20240112060042.19925-1-binbin.wu@linux.intel.com>
 <20240112060042.19925-3-binbin.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112060042.19925-3-binbin.wu@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 12, 2024 at 02:00:42PM +0800, Binbin Wu wrote:
> Date: Fri, 12 Jan 2024 14:00:42 +0800
> From: Binbin Wu <binbin.wu@linux.intel.com>
> Subject: [PATCH v4 2/2] target/i386: add control bits support for LAM
> X-Mailer: git-send-email 2.25.1
> 
> LAM uses CR3[61] and CR3[62] to configure/enable LAM on user pointers.
> LAM uses CR4[28] to configure/enable LAM on supervisor pointers.
> 
> For CR3 LAM bits, no additional handling needed:
> - TCG
>   LAM is not supported for TCG of target-i386.  helper_write_crN() and
>   helper_vmrun() check max physical address bits before calling
>   cpu_x86_update_cr3(), no change needed, i.e. CR3 LAM bits are not allowed
>   to be set in TCG.
> - gdbstub
>   x86_cpu_gdb_write_register() will call cpu_x86_update_cr3() to update cr3.
>   Allow gdb to set the LAM bit(s) to CR3, if vcpu doesn't support LAM,
>   KVM_SET_SREGS will fail as other reserved bits.
> 
> For CR4 LAM bit, its reservation depends on vcpu supporting LAM feature or
> not.
> - TCG
>   LAM is not supported for TCG of target-i386.  helper_write_crN() and
>   helper_vmrun() check CR4 reserved bit before calling cpu_x86_update_cr4(),
>   i.e. CR4 LAM bit is not allowed to be set in TCG.
> - gdbstub
>   x86_cpu_gdb_write_register() will call cpu_x86_update_cr4() to update cr4.
>   Mask out LAM bit on CR4 if vcpu doesn't support LAM.
> - x86_cpu_reset_hold() doesn't need special handling.
> 
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> ---
>  target/i386/cpu.h    | 7 ++++++-
>  target/i386/helper.c | 4 ++++
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 18ea755644..598a3fa140 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -261,6 +261,7 @@ typedef enum X86Seg {
>  #define CR4_SMAP_MASK   (1U << 21)
>  #define CR4_PKE_MASK   (1U << 22)
>  #define CR4_PKS_MASK   (1U << 24)
> +#define CR4_LAM_SUP_MASK (1U << 28)
>  
>  #define CR4_RESERVED_MASK \
>  (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
> @@ -269,7 +270,8 @@ typedef enum X86Seg {
>                  | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
>                  | CR4_LA57_MASK \
>                  | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
> -                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK))
> +                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
> +                | CR4_LAM_SUP_MASK))
>  
>  #define DR6_BD          (1 << 13)
>  #define DR6_BS          (1 << 14)
> @@ -2522,6 +2524,9 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
>      if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
>          reserved_bits |= CR4_PKS_MASK;
>      }
> +    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
> +        reserved_bits |= CR4_LAM_SUP_MASK;
> +    }
>      return reserved_bits;
>  }
>  
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 2070dd0dda..1da7a7d315 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -219,6 +219,10 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
>          new_cr4 &= ~CR4_PKS_MASK;
>      }
>  
> +    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
> +        new_cr4 &= ~CR4_LAM_SUP_MASK;
> +    }
> +
>      env->cr[4] = new_cr4;
>      env->hflags = hflags;
>  
> -- 
> 2.25.1
> 
> 

