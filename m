Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4CAC3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBc28-0004Ek-Cw; Sun, 04 May 2025 12:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBc26-0004DV-OB
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:17:38 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uBc24-0006yu-4r
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746375456; x=1777911456;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XL4KqaA98CFbohx2F7VXhlRfmY/0MsG/v9FlzpoYTxQ=;
 b=YuAJWPY/Ci2E2Wp93nnqkotE98LQGgczI/qf3n9iCLAZ56xmPMr/QEQS
 EkZPpYCxZ6e9O91K2OdlZF24zlok5kiLAaCvoFuvktPPK3SDGzuX+qtJL
 +ozY9fYl4z442ltZLZsk08DDSDG1BYpB29c4KO/2+a6rjemVSE6WAe8hA
 7Gk1tj4048Z1kqFmmD/9JsaRFVzjUgA7d+gsQF97uTcsG1MUc0EVnyF0A
 MZiqJx7rcjKob4Q5FdhOF82ThtXv8HEUl5ERG1GLfVOEKd/N23j5+CzGG
 5WxXTy5HEUX3sJnNaSl0y8YMscSClxZwUImlGhZpPwXgsRXPlz8wf2xX1 Q==;
X-CSE-ConnectionGUID: LMXMJfJZS5i+rsjNsAXsQQ==
X-CSE-MsgGUID: uG1nTGjUTa+uvlp3oIUHfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="51643718"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="51643718"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2025 09:17:32 -0700
X-CSE-ConnectionGUID: 3o9nrQ5KS22DSyItOtFSkQ==
X-CSE-MsgGUID: qU3PEyUBS8WlyItRShmf5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; d="scan'208";a="135015103"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 04 May 2025 09:17:30 -0700
Date: Mon, 5 May 2025 00:38:30 +0800
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
Subject: Re: [PATCH v8 45/55] i386/tdx: Add TDX fixed1 bits to supported CPUIDs
Message-ID: <aBeYBtWcteGBDsuN@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-46-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-46-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
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

On Tue, Apr 01, 2025 at 09:01:55AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:55 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 45/55] i386/tdx: Add TDX fixed1 bits to supported CPUIDs
> X-Mailer: git-send-email 2.34.1
> 
> TDX architecture forcibly sets some CPUID bits for TD guest that VMM
> cannot disable it. They are fixed1 bits.
> 
> Fixed1 bits are not covered by tdx_caps.cpuid (which only contians the
> directly configurable bits), while fixed1 bits are supported for TD guest
> obviously.
> 
> Add fixed1 bits to tdx_supported_cpuid. Besides, set all the fixed1
> bits to the initial set of KVM's support since KVM might not report them
> as supported.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.h          |   2 +
>  target/i386/kvm/kvm_i386.h |   7 ++
>  target/i386/kvm/tdx.c      | 132 +++++++++++++++++++++++++++++++++++++
>  target/i386/sev.c          |   5 --
>  4 files changed, 141 insertions(+), 5 deletions(-)
 
LGTM, (only some nits)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> +    .entries[3] = {
> +        .function = 0x7,
> +        .index = 2,
> +        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
> +        .edx = (1U << 0) | (1U << 1) | (1U << 2) | (1U << 4),

Missed to use macro?

.edx = CPUID_7_2_EDX_PSFD | CPUID_7_2_EDX_IPRED_CTRL |
       CPUID_7_2_EDX_RRSBA_CTRL | CPUID_7_2_EDX_BHI_CTRL

> +    },
> +    .entries[4] = {
> +        .function = 0xD,
> +        .index = 0,
> +        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
> +        .eax = XSTATE_FP_MASK | XSTATE_SSE_MASK,
> +    },
> +    .entries[5] = {
> +        .function = 0xD,
> +        .index = 1,
> +        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
> +        .eax = CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC|
> +               CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
> +    },
> +    .entries[6] = {
> +        .function = 0x80000001,
> +        .index = 0,
> +        .ecx = CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
> +        /* strictly speaking, SYSCALL is not fixed1 bit since it depends on

style nit?

/*
 * strictly ...
 */

> +         * the CPU to be in 64-bit mode. But here fixed1 is used to serve the
> +         * purpose of supported bits for TDX. In this sense, SYACALL is always
> +         * supported.
> +         */
> +        .edx = CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
> +               CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
> +    },
> +    .entries[7] = {
> +        .function = 0x80000007,
> +        .index = 0,
> +        .edx = CPUID_APM_INVTSC,
> +    },
> +};
> +

...

> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index a6c0a697250b..217b19ad7bc6 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -214,11 +214,6 @@ static const char *const sev_fw_errlist[] = {
>  /* <linux/kvm.h> doesn't expose this, so re-use the max from kvm.c */
>  #define KVM_MAX_CPUID_ENTRIES 100

This macro can also be cleaned up in this patch or in your patch 5.


