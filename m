Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6F5C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 10:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4Gb-00016l-Mo; Thu, 20 Feb 2025 05:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl4Ga-00016d-2o
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:58:52 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl4GX-0001jT-63
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740049129; x=1771585129;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=peXBWKLlJoZ0te86jGaqhSVx6k4fQXBrx/kZt4Y3dFo=;
 b=LFaPhyO3d7SLDyjEN7V3kA6T5WJGmxEXuCxOkf4G5clr2hetICinOHTP
 D/HExG6ziMN/XETPC3lBynBYibn8aJCv8wQWbPQh9XB/o2feOO80EfOiU
 vqAknK7ZL7aTp7V4pAIx0FnnW5EkP/zqsX5dIi0o0b/7wCYG3F6J0UemM
 aSiVAiP+7ze74Mp5HpholGvuYGF3/IniH681mDV8Z0dudNHozs3htTu4X
 oo5TtHtxa1zoZrh1xrHJ2UxGdgfW5VWUzzKb7ZBftrPgYOWjo5sbVNsAu
 tLFkIFvnD8XjP133S8tFFX/dN6XQDohEW3NM9Zak8MfLQ0BOJIqRH0sXT A==;
X-CSE-ConnectionGUID: CMuedAkKRxmeA1D/tyerbQ==
X-CSE-MsgGUID: vg+DloBkQu2eh7WaMgzuDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40959993"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="40959993"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 02:58:46 -0800
X-CSE-ConnectionGUID: X65XWnxYRJ6my0mf/THp2Q==
X-CSE-MsgGUID: XqCrPXq5T1uDp7bf4/7ASQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="114737261"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 20 Feb 2025 02:58:45 -0800
Date: Thu, 20 Feb 2025 19:18:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 davydov-max@yandex-team.ru
Subject: Re: [PATCH v5 2/6] target/i386: Update EPYC-Rome CPU model for Cache
 property, RAS, SVM feature bits
Message-ID: <Z7cPeyLAuNDL0Oc4@intel.com>
References: <cover.1738869208.git.babu.moger@amd.com>
 <8e40e18b433d2d152433724a15bddcacdecbf154.1738869208.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e40e18b433d2d152433724a15bddcacdecbf154.1738869208.git.babu.moger@amd.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

On Thu, Feb 06, 2025 at 01:28:35PM -0600, Babu Moger wrote:
> Date: Thu, 6 Feb 2025 13:28:35 -0600
> From: Babu Moger <babu.moger@amd.com>
> Subject: [PATCH v5 2/6] target/i386: Update EPYC-Rome CPU model for Cache
>  property, RAS, SVM feature bits
> X-Mailer: git-send-email 2.34.1
> 
> Found that some of the cache properties are not set correctly for EPYC models.
> 
> l1d_cache.no_invd_sharing should not be true.
> l1i_cache.no_invd_sharing should not be true.
> 
> L2.self_init should be true.
> L2.inclusive should be true.
> 
> L3.inclusive should not be true.
> L3.no_invd_sharing should be true.
> 
> Fix these cache properties.
> 
> Also add the missing RAS and SVM features bits on AMD EPYC-Rome. The SVM
> feature bits are used in nested guests.
> 
> succor		: Software uncorrectable error containment and recovery capability.
> overflow-recov	: MCA overflow recovery support.
> lbrv		: LBR virtualization
> tsc-scale	: MSR based TSC rate control
> vmcb-clean	: VMCB clean bits
> flushbyasid	: Flush by ASID
> pause-filter	: Pause intercept filter
> pfthreshold	: PAUSE filter threshold
> v-vmsave-vmload	: Virtualized VMLOAD and VMSAVE
> vgif		: Virtualized GIF
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
> ---
>  target/i386/cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 94292bfaa2..e2c3c797ed 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2342,6 +2342,60 @@ static const CPUCaches epyc_rome_v3_cache_info = {
>      },
>  };
>  
> +static const CPUCaches epyc_rome_v5_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .size = 32 * KiB,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .partitions = 1,
> +        .sets = 64,
> +        .lines_per_tag = 1,
> +        .self_init = 1,

This field could be true,

> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l1i_cache = &(CPUCacheInfo) {
> +        .type = INSTRUCTION_CACHE,
> +        .level = 1,
> +        .size = 32 * KiB,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .partitions = 1,
> +        .sets = 64,
> +        .lines_per_tag = 1,
> +        .self_init = 1,

ditto,

Compared to the previous cache model version, the differences can be
checked. I feel that in the future, when we introduce a new cache model,
it's better to avoid omitting items that default to false. This way, the
cache model can correspond to the output of the cpuid tool, making it
easier to compare and check.

Overall, LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


