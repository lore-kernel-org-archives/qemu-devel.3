Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F82CC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWDB-0000sx-LF; Fri, 06 Jun 2025 08:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uNWDA-0000qm-3J
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:30:16 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uNWCx-0004wA-3p
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=TP9zixZc6p07lO6UHxKLDUvYWlj6E2NNyB/0TPwLe1M=; b=mfgoESb3+WRUHZj1
 dzcYoyZYdBBx405BSPdW/MHgInHMgRMVO8lnEjhBk1dwoZjCkQ9Li7rjgvlJVCHamfUDkJX9ZssNj
 fc7HmngbrOZski5wk1JdBki6oAXlQQhmj2VKjed1t6SGf7w+8oU1e+sXAGWwnaQGYncVBn/VuiA0t
 q6FjU8MffD2UuwLyBTSuxSC83qqzURvWBAmFpupjJ5SAv7sp+kLqI1/eBqfQlqQv79lIKNdVdFhy0
 bW8R8kwHmqNZbO6P9NdtzakjR/Za6rUozjU4SRxVw29m7yp5+SJbGUSlOM4+YF7XEJD4DECjRb1eR
 P8sgg/kluKluvagVYg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uNWCk-0082bL-2P;
 Fri, 06 Jun 2025 12:29:50 +0000
Date: Fri, 6 Jun 2025 12:29:50 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, davydov-max@yandex-team.ru
Subject: Re: [PATCH v7 4/6] target/i386: Add couple of feature bits in
 CPUID_Fn80000021_EAX
Message-ID: <aELfPr7snDmIirNk@gallifrey>
References: <cover.1746734284.git.babu.moger@amd.com>
 <a5f6283a59579b09ac345b3f21ecb3b3b2d92451.1746734284.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a5f6283a59579b09ac345b3f21ecb3b3b2d92451.1746734284.git.babu.moger@amd.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 12:28:21 up 39 days, 20:41,  2 users,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

* Babu Moger (babu.moger@amd.com) wrote:
> Add CPUID bit indicates that a WRMSR to MSR_FS_BASE, MSR_GS_BASE, or
> MSR_KERNEL_GS_BASE is non-serializing amd PREFETCHI that the indicates
> support for IC prefetch.
> 
> CPUID_Fn80000021_EAX
> Bit    Feature description
> 20     Indicates support for IC prefetch.
> 1      FsGsKernelGsBaseNonSerializing.

I'm curious about this:
  a) Is this new CPUs are non-serialising on that write?
  b) If so, what happens if you run existing kernels/firmware on them?
  c) Bonus migration question; what happens if you live migrate from a host
     that claims to be serialising to one that has the extra non-serialising
     flag but is disabled in the emulated CPU model.

Dave

>        WRMSR to FS_BASE, GS_BASE and KernelGSbase are non-serializing.
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 4 ++--
>  target/i386/cpu.h | 4 ++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 98fad3a2f9..741be0eaa8 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1239,12 +1239,12 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      [FEAT_8000_0021_EAX] = {
>          .type = CPUID_FEATURE_WORD,
>          .feat_names = {
> -            "no-nested-data-bp", NULL, "lfence-always-serializing", NULL,
> +            "no-nested-data-bp", "fs-gs-base-ns", "lfence-always-serializing", NULL,
>              NULL, NULL, "null-sel-clr-base", NULL,
>              "auto-ibrs", NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            "prefetchi", NULL, NULL, NULL,
>              "eraps", NULL, NULL, "sbpb",
>              "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
>          },
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 4f8ed8868e..d251e32ae9 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1070,12 +1070,16 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>  
>  /* Processor ignores nested data breakpoints */
>  #define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP            (1U << 0)
> +/* WRMSR to FS_BASE, GS_BASE, or KERNEL_GS_BASE is non-serializing */
> +#define CPUID_8000_0021_EAX_FS_GS_BASE_NS                (1U << 1)
>  /* LFENCE is always serializing */
>  #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
>  /* Null Selector Clears Base */
>  #define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
>  /* Automatic IBRS */
>  #define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
> +/* Indicates support for IC prefetch */
> +#define CPUID_8000_0021_EAX_PREFETCHI                    (1U << 20)
>  /* Enhanced Return Address Predictor Scurity */
>  #define CPUID_8000_0021_EAX_ERAPS                        (1U << 24)
>  /* Selective Branch Predictor Barrier */
> -- 
> 2.34.1
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

