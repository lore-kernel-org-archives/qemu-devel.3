Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4B8C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdLmI-0000NP-Ae; Thu, 22 Feb 2024 21:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rdLmF-0000Mv-B0
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 21:59:07 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rdLmC-0008CW-2q
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 21:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708657144; x=1740193144;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lYf315eDkP0LzIDpbuMezRD5udJ+FvuHc99oYsTfVnI=;
 b=DfEbz6m1S8tB9+mVAu2hcxDdJ7rdCTJFvZxNlDfYdQpdq+X2ZAoGTzew
 u2Shce7U53zwzGIOeb47Q2jnpe6R9WLopz6KP9sUuSny+kKiu+f3C2jND
 3LzWr9lkggRUPtXB5MLOFSFmHjoWIYDa12BPaaFcmPSbGHQxTjXs4pMRx
 jW3T0i22IADeVktUM1KZightIzZ9HXZiJEKVe1k09dbrdlxxdxDcSetMN
 hLzUziRGnloHweO/llIbpPV0Rr+5++SFFHAKG43DdeLdd8xZAD0lgRAZj
 eV55dt3JYkihUtAvPWJwRDm0tY3fGPgNLlZYsvDonXfhoTQpp/sRjzIuX w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2838514"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2838514"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 18:59:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="936985813"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; d="scan'208";a="936985813"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2024 18:58:59 -0800
Date: Fri, 23 Feb 2024 11:12:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, robert.hu@linux.intel.com
Subject: Re: [PATCH v4 1/2] target/i386: add support for LAM in CPUID
 enumeration
Message-ID: <ZdgNKDW+jTcXPvyH@intel.com>
References: <20240112060042.19925-1-binbin.wu@linux.intel.com>
 <20240112060042.19925-2-binbin.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112060042.19925-2-binbin.wu@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

On Fri, Jan 12, 2024 at 02:00:41PM +0800, Binbin Wu wrote:
> Date: Fri, 12 Jan 2024 14:00:41 +0800
> From: Binbin Wu <binbin.wu@linux.intel.com>
> Subject: [PATCH v4 1/2] target/i386: add support for LAM in CPUID
>  enumeration
> X-Mailer: git-send-email 2.25.1
> 
> From: Robert Hoo <robert.hu@linux.intel.com>
> 
> Linear Address Masking (LAM) is a new Intel CPU feature, which allows
> software to use of the untranslated address bits for metadata.
> 
> The bit definition:
> CPUID.(EAX=7,ECX=1):EAX[26]
> 
> Add CPUID definition for LAM.
> 
> Note LAM feature is not supported for TCG of target-i386, LAM CPIUD bit
> will not be added to TCG_7_1_EAX_FEATURES.
> 
> More info can be found in Intel ISE Chapter "LINEAR ADDRESS MASKING(LAM)"
> https://cdrdv2.intel.com/v1/dl/getContent/671368
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2524881ce2..fc862dfeb1 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -967,7 +967,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              "fsrc", NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, "amx-fp16", NULL, "avx-ifma",
> -            NULL, NULL, NULL, NULL,
> +            NULL, NULL, "lam", NULL,
>              NULL, NULL, NULL, NULL,
>          },
>          .cpuid = {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 7f0786e8b9..18ea755644 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -925,6 +925,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>  #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
>  /* Support for VPMADD52[H,L]UQ */
>  #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
> +/* Linear Address Masking */
> +#define CPUID_7_1_EAX_LAM               (1U << 26)
>  
>  /* Support for VPDPB[SU,UU,SS]D[,S] */
>  #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)
> -- 
> 2.25.1
> 
> 

