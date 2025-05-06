Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7068C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 11:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCGCJ-0000pm-EH; Tue, 06 May 2025 07:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCGCH-0000pM-Ks
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:10:49 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCGCD-0007uO-1R
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746529845; x=1778065845;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=134B174huVrNU1svq1lCpmS92R3Sb0w20q83eRIjDPI=;
 b=dRHsFsjfbLiPAWCfb7I72zNF3uxH/V8lRbTm5XnDzk6RIDO+LZ3SxLKW
 Bt41jgTZNNSwDkAVl1ronD/1caFLRBKu3avnl1KsmH2Qy7bIbT+RXJKLk
 UwjzRD/mWMGL8/ikw3xofnYPKJRQmhcLyuflIfItcyiCr9WkmcR2mac/r
 HTcHfKq1mw50qZ1JTMhHnUrJqGnD82yQcTlG2sVKxYICsssxb/ZyBVhFq
 cUS3wd7FvbMcZ2Aqzq0MjhUc1qLkqWkhooyfmabbdDq6Gs741+K1isoWz
 vmdWtob0gOR/IjquYFbra5+R1d226IacEzfQnIr1PeJrfCKtQWobYwtXI g==;
X-CSE-ConnectionGUID: bgo+LBuwTiOttb6vFpVNoQ==
X-CSE-MsgGUID: 0alpUygvTmGDnN7NA0wwug==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48062521"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="48062521"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 04:10:42 -0700
X-CSE-ConnectionGUID: k85JMqPQTgeUa954l+4pcg==
X-CSE-MsgGUID: 88cF80TSTNKirqJVfTgelg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="166636880"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 06 May 2025 04:10:39 -0700
Date: Tue, 6 May 2025 19:31:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 46/55] i386/tdx: Add supported CPUID bits related to
 TD Attributes
Message-ID: <aBnzG0e+Dea5S3sR@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-47-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-47-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, Apr 01, 2025 at 09:01:56AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:56 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 46/55] i386/tdx: Add supported CPUID bits related to TD
>  Attributes
> X-Mailer: git-send-email 2.34.1
> 
> For TDX, some CPUID feature bit is configured via TD attributes. They
> are not covered by tdx_caps.cpuid (which only contians the configurable
> bits), but they are actually supported when the related attributre bit
> is supported.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.h     |  4 +++
>  target/i386/kvm/tdx.c | 59 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 115137279a1a..0e984ec42bb6 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -903,6 +903,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>  #define CPUID_7_0_ECX_LA57              (1U << 16)
>  /* Read Processor ID */
>  #define CPUID_7_0_ECX_RDPID             (1U << 22)
> +/* KeyLocker */
> +#define CPUID_7_0_ECX_KeyLocker         (1U << 23)
>  /* Bus Lock Debug Exception */
>  #define CPUID_7_0_ECX_BUS_LOCK_DETECT   (1U << 24)
>  /* Cache Line Demote Instruction */
> @@ -963,6 +965,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>  #define CPUID_7_1_EAX_AVX_VNNI          (1U << 4)
>  /* AVX512 BFloat16 Instruction */
>  #define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
> +/* Linear address space separation */
> +#define CPUID_7_1_EAX_LASS              (1U << 6)
>  /* CMPCCXADD Instructions */
>  #define CPUID_7_1_EAX_CMPCCXADD         (1U << 7)
>  /* Fast Zero REP MOVS */

The whole framework is very good for me. 

Since LASS/key locker are not yet supported, I think it's better to add
the note (in the commit message or code) that they are helpful for
future enabling. Of course, removing these two features would be best,
as they cannot be covered by current testing.

Regards,
Zhao



