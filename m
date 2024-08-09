Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CF1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 03:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scFy4-0007pw-Hk; Thu, 08 Aug 2024 23:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scFxz-0007oa-An
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:06:59 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scFxw-0002nu-Lz
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723172817; x=1754708817;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=CBPGZ/tcgStsZTs9Kh/tiqLVUbB3PRbcG2ljWtXOBXA=;
 b=gDll4SEry5hY4kREZp5kFZN9Gz3M3yNmtDueANGnRLwvhufsWWEWC7M5
 Jd7sMeQ1ND860nagVNI+1bp2TO2IzAqRq2y4/juSVLOXL67iQXm+3k6Tc
 CWuX08TbXPe8SXRi761TpojVbIb1yYw8vmhguDcepFBOXTFNwvCGOVGe9
 aUWDXDpnpap+aMthfq6GfBmjZHfY5GoTTkgY6gs+LqRJW8J8+rIQ3pKoc
 hs7Rh9RNwid93raUS1LH1bW1waSspIyF1IdBOn6G7YcQ/Ga0nVpXtQf6B
 8I54Z8kypWT+CMJwjVPvmratvSzUBgorHOEuC4Rt7HB6IHkHi3ujFnhnG w==;
X-CSE-ConnectionGUID: 31i96WYCQDC68JKjA8Ol9g==
X-CSE-MsgGUID: vR/9qbaOSG6XGhiGgwTAGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21474853"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="21474853"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 20:06:53 -0700
X-CSE-ConnectionGUID: VBunJ89KTaSFOTECrO/hRg==
X-CSE-MsgGUID: lJjw4Z49SzCfoAZtv/K1tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="88307444"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 08 Aug 2024 20:06:50 -0700
Date: Fri, 9 Aug 2024 11:22:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, rockcui@zhaoxin.com,
 louisqi@zhaoxin.com, liamni@zhaoxin.com, frankzhu@zhaoxin.com
Subject: Re: [PATCH v2 4/4] target/i386: Update CMPLegacy handling for
 Zhaoxin CPUs
Message-ID: <ZrWLgN1L280h75QF@intel.com>
References: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
 <20240704112511.184257-5-ewanhai-oc@zhaoxin.com>
 <ZrSeMfpBm8NrXRWK@intel.com>
 <236c8032-6e17-4002-86e1-4483b55977f7@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <236c8032-6e17-4002-86e1-4483b55977f7@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Thu, Aug 08, 2024 at 09:44:18PM -0400, Ewan Hai wrote:
> Date: Thu, 8 Aug 2024 21:44:18 -0400
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: Re: [PATCH v2 4/4] target/i386: Update CMPLegacy handling for
>  Zhaoxin CPUs
> 
> 
> Hi Zhao Liu,
> 
> Thank you for your feedback.
> 
> On 8/8/24 06:30, Zhao Liu wrote:
> > Hi EwanHai,
> > 
> > On Thu, Jul 04, 2024 at 07:25:11AM -0400, EwanHai wrote:
> > > Date: Thu, 4 Jul 2024 07:25:11 -0400
> > > From: EwanHai <ewanhai-oc@zhaoxin.com>
> > > Subject: [PATCH v2 4/4] target/i386: Update CMPLegacy handling for Zhaoxin
> > >   CPUs
> > > X-Mailer: git-send-email 2.34.1
> > > 
> > > Zhaoxin CPUs handle the CMPLegacy bit in the same way
> > > as Intel CPUs.

Here it could be clearer to say "Don't set up CMPLegacy bit in
CPUID[0x80000001].ecx for VIA/Zhaoxin CPUs".

> This patch simplifies the existing logic by
> > > using the IS_XXX_CPU macro and includes checks for Zhaoxin
> > > vendor to align their behavior with Intel.
> > > 
> > > Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
> > > ---
> > >   target/i386/cpu.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index a3747fc487..c52a4cf3ba 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -6945,9 +6945,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> > >            * So don't set it here for Intel to make Linux guests happy.
> > >            */
> > >           if (threads_per_pkg > 1) {
> > > -            if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
> > > -                env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
> > > -                env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
> > > +            if (!IS_INTEL_CPU(env) && !IS_ZHAOXIN_CPU(env)) {
> > This change implicitly changes the behavior of existing VIA CPU.
> > 
> > Is this a bug for the original VIA? If so, I suggest a separate patch to
> > fix it and explain the effect on the VIA (Zhaoxin1) CPU.
> > 
> > Regards,
> > Zhao
>
> The reason for this change is not due to a discovered bug, but rather
> because both Centaurhauls and Shanghai CPUs follow Intel¡¯s behavior
> regarding the CMPLegacy bit. Specifically, AMD CPUs enumerate the
> threads per package information in the CPUID leaf 0x80000001 output
> ECX register, while Intel (and **other processors following Intel¡¯s
> behavior**) do not. Therefore, this modification is simply intended to
> logically supplement the existing code.

I see, thanks.

> Given this, do you think it would be appropriate for me to submit
> a separate patch to explain this behavior and its effect on
> VIA (Zhaoxin1) CPUs? If so, I will submmit this change in a separate
> patch.

I think there's no need to split this.

However, I think it's necessary to state the effect of the change in
the changelog/commit message. It's also worth stating if it won't have
any effect on the OS/software. Afterall, the comment of this bit said
it affects Linux kernel.

Also, changes to the old VIA behavior are worth stating in the commit
message, i.e., this patch's changes to Zhaoxin CPUs include the previous
VIA CPUs.

Additionally, considering this change is to fix the CPUID which doesn't
match the bare metal, then what about changing the subject to

"target/i386: Mask CMPLegacy bit in CPUID[0x80000001].ecx for Zhaoxin/VIA
CPUs"?

Thanks,
Zhao

> > >                   *ecx |= 1 << 1;    /* CmpLegacy bit */
> > >               }
> > >           }
> > > --
> > > 2.34.1
> > > 
> 

