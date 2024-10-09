Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC41ACED618
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 07:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syRAB-0000kR-C3; Wed, 09 Oct 2024 03:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syRA8-0000kC-OW
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 03:31:13 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syRA4-0000Ur-Dq
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 03:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728459068; x=1759995068;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xo5g02Xx2KyKHaRY1zGM1c4tTbdyS0pz6yItGa7TCnE=;
 b=kjR6HzIspURatab1WHis4qd3I24fRALEgDSMCTmAxzZlXScMT5XD3gZA
 7piZHbnaZKkan0Z6askGpGpzhYsgjEHRT5X4loB4wNHkVsN4IYJf4OGAG
 yDYNIyuHb+Y+Sm1cTDZzdgmXOz/Up/jk5vmFaUMgVUzbTFe3MEopLpDrb
 9J4X1vZbILuCowYvJ3vQJ7eT7nj85JkjyxquYZ7AbPtoEoMzYpyAbMVbe
 32Kl0ywnQ7+0NRN3S5y+Atzhm2KDFCj8YfJxIqbC5PcxfN/VuIUDzMRZ8
 01uVAuDrqh2NSWKEnGhl6mLXSUozIfAUXrIaOr4bXaZpF/UM8AuE4mz1E Q==;
X-CSE-ConnectionGUID: VjVlt+SUQY6B0gHmfyS+pQ==
X-CSE-MsgGUID: o/UPNJHoTfKaA3aG+VDUeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27556088"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="27556088"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2024 00:31:03 -0700
X-CSE-ConnectionGUID: Wc1NOWWOQfG0H5sGUGQNGQ==
X-CSE-MsgGUID: BZdyLgUwS0qtCxDxIHbyLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="76981104"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 09 Oct 2024 00:31:02 -0700
Date: Wed, 9 Oct 2024 15:47:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jmattson@google.com,
 pawan.kumar.gupta@linux.intel.com, jon@nutanix.com
Subject: Re: [PATCH] target/i386: Add more features enumerated by CPUID.7.2.EDX
Message-ID: <ZwY1AeJPlrniISB1@intel.com>
References: <20240919051011.118309-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919051011.118309-1-chao.gao@intel.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Sep 19, 2024 at 01:10:11PM +0800, Chao Gao wrote:
> Date: Thu, 19 Sep 2024 13:10:11 +0800
> From: Chao Gao <chao.gao@intel.com>
> Subject: [PATCH] target/i386: Add more features enumerated by CPUID.7.2.EDX
> X-Mailer: git-send-email 2.46.1
> 
> Following 5 bits in CPUID.7.2.EDX are supported by KVM. Add their
> supports in QEMU. Each of them indicates certain bits of IA32_SPEC_CTRL
> are supported. Those bits can control CPU speculation behavior which can
> be used to defend against side-channel attacks.
> 
> bit0: intel-psfd
>   if 1, indicates bit 7 of the IA32_SPEC_CTRL MSR is supported. Bit 7 of
>   this MSR disables Fast Store Forwarding Predictor without disabling
>   Speculative Store Bypass
> 
> bit1: ipred-ctrl
>   If 1, indicates bits 3 and 4 of the IA32_SPEC_CTRL MSR are supported.
>   Bit 3 of this MSR enables IPRED_DIS control for CPL3. Bit 4 of this
>   MSR enables IPRED_DIS control for CPL0/1/2
> 
> bit2: rrsba-ctrl
>   If 1, indicates bits 5 and 6 of the IA32_SPEC_CTRL MSR are supported.
>   Bit 5 of this MSR disables RRSBA behavior for CPL3. Bit 6 of this MSR
>   disables RRSBA behavior for CPL0/1/2
> 
> bit3: ddpd-u
>   If 1, indicates bit 8 of the IA32_SPEC_CTRL MSR is supported. Bit 8 of
>   this MSR disables Data Dependent Prefetcher.
> 
> bit4: bhi-ctrl
>   if 1, indicates bit 10 of the IA32_SPEC_CTRL MSR is supported. Bit 10
>   of this MSR enables BHI_DIS_S behavior.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 85ef7452c0..18ba958f46 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1148,8 +1148,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      [FEAT_7_2_EDX] = {
>          .type = CPUID_FEATURE_WORD,
>          .feat_names = {
> -            NULL, NULL, NULL, NULL,
> -            NULL, "mcdt-no", NULL, NULL,
> +            "intel-psfd", "ipred-ctrl", "rrsba-ctrl", "ddpd-u",
> +            "bhi-ctrl", "mcdt-no", NULL, NULL,

IIUC, these bits depend on "spec-ctrl", which indicates the presence of
IA32_SPEC_CTRL.

Then I think we'd better add dependencies in feature_dependencies[].

-Zhao

>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
> -- 
> 2.46.1
> 
> 

