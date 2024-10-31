Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB81FE68953
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6N3O-0001yO-S4; Thu, 31 Oct 2024 00:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6N3M-0001xt-J6
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:45:00 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6N3J-0000HE-Cz
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730349898; x=1761885898;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=HRCmAZnWLGDrm4bikgE5sZyFS7uzA9BWSNmBIVUMsKU=;
 b=OeT/yWipnGs+jzyehXGrsBAObxZAI1XJe1csd83tYTEK5gCvuj54BtKk
 /5rKSs57v25A6a9PJuDxgyJvlB2DQ+qcEdbIR1VABAlwebka7ZiBItcGl
 yN66Tnz7Wk2CjjuA/nFX+2c0CPhl633qrIJhPx5vyf9+GXh5/x1NAtyhM
 2KY6CVukFMOiKRd+Z8uxs7pbQNDFxaEygBkT2bA7LCkDRO2Y9aTzXxUSV
 774yCyNVLxoXswXNwBgfncDYb/dPVR5e6pL6PzdK9t9Vxi1Hx6gk8wVBm
 7AlITcfGti3aCxyZy9IfNm08QC6ZAOr2S/EUm5tMseRm5GC0g/Z7vUogz Q==;
X-CSE-ConnectionGUID: wnVEp4vTSnmC9MRFw07DEA==
X-CSE-MsgGUID: Yi6N2sG0TXOIMRzbMg/9/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33767357"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="33767357"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 21:44:46 -0700
X-CSE-ConnectionGUID: RTM2PlljTZer3m4r80BP1w==
X-CSE-MsgGUID: eGFlQGv5SheqCLdpQUQ3XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; d="scan'208";a="113375182"
Received: from linux.bj.intel.com ([10.238.157.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 21:44:41 -0700
Date: Thu, 31 Oct 2024 12:39:31 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: Re: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyMKAwq4lsk+ozu3@linux.bj.intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-5-pbonzini@redhat.com>
 <ZyHyBnPvOHsSdh8D@intel.com> <ZyH+RB3v55cQ43+S@linux.bj.intel.com>
 <ZyIy4OGSGPhAZutK@intel.com> <ZyI9P1ftFOTUhDzb@linux.bj.intel.com>
 <ZyJW9nGgpEXqiyli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyJW9nGgpEXqiyli@intel.com>
Received-SPF: none client-ip=198.175.65.15;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 30, 2024 at 11:55:34PM +0800, Zhao Liu wrote:
> On Wed, Oct 30, 2024 at 10:05:51PM +0800, Tao Su wrote:
> > Date: Wed, 30 Oct 2024 22:05:51 +0800
> > From: Tao Su <tao1.su@linux.intel.com>
> > Subject: Re: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
> >  property
> > 
> > On Wed, Oct 30, 2024 at 09:21:36PM +0800, Zhao Liu wrote:
> > > > > > Introduce avx10-version property so that avx10 version can be controlled
> > > > > > by user and cpu model. Per spec, avx10 version can never be 0, the default
> > > > > > value of avx10-version is set to 0 to determine whether it is specified by
> > > > > > user.
> > > > > 
> > > > > The default value of 0 does not reflect whether the user has set it to 0.
> > > > > According to the description here, the spec clearly prohibits 0, so
> > > > > should we report an error when the user sets it to 0?
> > > > > 
> > > > > If so, it might be better to change the default value to -1 and adjust
> > > > > based on the host's support.
> > > > > 
> > > > 
> > > > If user sets version to 0, it will directly use reported version, this
> > > > should be a more neat and intuitive way?
> > > 
> > > The code implementation is actually similar for different initial
> > > values. And about this:
> > > 
> > > > If user sets version to 0, it will directly use reported version", 
> > > 
> > > It's defining a special behavior for the API, which is based on the
> > > special 0 value, and there needs to be documentation to let the user
> > > know that 0 will be considered legal as well as that it will be quietly
> > > overridden... But AFAIK there doesn't seem to be any place to add
> > > documentation for the property ...
> > > 
> > > There may be similar problems with -1, e.g. if the user writes -1, there
> > > is no way to report an error for the user's behavior. But it's better
> > > than 0. After all, no one would think that a version of -1 is correct.
> > > Topology IDs have been initialized to -1 to include the user's 0 value
> > > in the check.
> > 
> > Thanks for your explanation, but I really think the users who set
> > avx10-version should also know avx10.0 doesn’t exist, so using 0 is same
> > as -1…
> 
> I see. "Per spec, avx10 version can never be 0", so showing the warning
> for avx10-version=0 is as it should be.
> 
> > To solve the initial value issue fundamentally, maybe we can add get/set
> > callbacks when adding avx10-version property? It should be simpler to
> > limit what users set.
> 
> It's unnecessary. Similar cases using -1 are already common, such as for
> APIC ID, NUMA node ID, topology IDs, etc. The initial value is -1 simply
> because we need to handle the case where users explicitly set it to 0.
> If you don’t want to see -1, you can define a macro like APIC ID did
> (#define UNSET_AVX10_VERSION -1).
> 

OK, I will change the default value to -1.

> > > > > @@ -7674,13 +7682,21 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
> > > > >                                      &eax_0, &ebx_0, &ecx_0, &edx_0);
> > > > >          uint8_t version = ebx_0 & 0xff;
> > > > > 
> > > > > -        if (version < env->avx10_version) {
> > > > > +        if (!env->avx10_version) {
> > > > > +            env->avx10_version = version;
> > > > 
> > > > x86_cpu_filter_features() is not a good place to assign avx10_version, I
> > > > still tend to set it in max_x86_cpu_realize().
> > > 
> > > It's not proper to get the host's version when AVX10 cannot be enabled,
> > > even maybe host doesn't support AVX10.
> > > 
> > > As you found out earlier, max_x86_cpu_realize doesn't know if AVX10 can
> > > be enabled or not.
> > > 
> > 
> > How about moving to x86_cpu_expand_features()? We can set when checking
> > cpu->max_features.
> 
> The feature bit set in x86_cpu_expand_features() is unstable since it
> may be masked later in x86_cpu_filter_features(). :)
> 

A lot of feature bits are set in x86_cpu_expand_features() with reported
value, so I think avx10_version can also be set to reported value there.

I mainly want to let avx10_version be assigned only when -cpu host or max,
so that it can be distinguished from the cpu model. This should also be
Paolo's original intention in v2.


