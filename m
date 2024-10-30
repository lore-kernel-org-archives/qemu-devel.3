Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FA4D5CCAF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 14:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t69Pg-0004fe-HC; Wed, 30 Oct 2024 10:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t69Pe-0004fI-En
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:11:06 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t69Pa-0000p7-2q
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730297462; x=1761833462;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=LSWj6FdvsCasDmywKZm4FU/GW8dVrlo82UsJX9yOfBM=;
 b=Vx9WQd2+Z5PSDOtZ+KB42qhvSNnz600048d6MnSCRWRBs+9F4YcBlHeA
 V5hj/4PkX6gT7Pfe8VaA3sAtMoqa0bOBi24KdeQo6AvcbAlHozI+ZyH4y
 G9FrU8ujxYzcRp7ZfxwFHNmOQdId0uOAat4BLaNCecVCwBekwn+eblFBC
 dD7aLvM88MCpmPihWTO1J77BGlqBKNh+UZPuL3ZdpelUMjXd6NlXrudd6
 fFwy8n/ErQfWvtJOLcUmoCU0xCFjvGYGUfzQ2daTBtGJJgG/7sPnMp5zQ
 TQuPshFiJihQ4S6sDZB1TwRM1nBkOwa7uaAKJW7r+y7B5BSL94vX2Le9q w==;
X-CSE-ConnectionGUID: iybHEWmXQRqBkZFO8SnGpA==
X-CSE-MsgGUID: XOQHJxspRueyPxD0Ifb58Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47461728"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="47461728"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 07:11:00 -0700
X-CSE-ConnectionGUID: pkQ//O7dT8+SQFmOJnpRwg==
X-CSE-MsgGUID: R6D2QVVcTYaY2NhFWctUUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; d="scan'208";a="82237513"
Received: from linux.bj.intel.com ([10.238.157.71])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 07:10:58 -0700
Date: Wed, 30 Oct 2024 22:05:51 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: Re: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyI9P1ftFOTUhDzb@linux.bj.intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-5-pbonzini@redhat.com>
 <ZyHyBnPvOHsSdh8D@intel.com> <ZyH+RB3v55cQ43+S@linux.bj.intel.com>
 <ZyIy4OGSGPhAZutK@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyIy4OGSGPhAZutK@intel.com>
Received-SPF: none client-ip=198.175.65.10;
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

On Wed, Oct 30, 2024 at 09:21:36PM +0800, Zhao Liu wrote:
> > > > Introduce avx10-version property so that avx10 version can be controlled
> > > > by user and cpu model. Per spec, avx10 version can never be 0, the default
> > > > value of avx10-version is set to 0 to determine whether it is specified by
> > > > user.
> > > 
> > > The default value of 0 does not reflect whether the user has set it to 0.
> > > According to the description here, the spec clearly prohibits 0, so
> > > should we report an error when the user sets it to 0?
> > > 
> > > If so, it might be better to change the default value to -1 and adjust
> > > based on the host's support.
> > > 
> > 
> > If user sets version to 0, it will directly use reported version, this
> > should be a more neat and intuitive way?
> 
> The code implementation is actually similar for different initial
> values. And about this:
> 
> > If user sets version to 0, it will directly use reported version", 
> 
> It's defining a special behavior for the API, which is based on the
> special 0 value, and there needs to be documentation to let the user
> know that 0 will be considered legal as well as that it will be quietly
> overridden... But AFAIK there doesn't seem to be any place to add
> documentation for the property ...
> 
> There may be similar problems with -1, e.g. if the user writes -1, there
> is no way to report an error for the user's behavior. But it's better
> than 0. After all, no one would think that a version of -1 is correct.
> Topology IDs have been initialized to -1 to include the user's 0 value
> in the check.

Thanks for your explanation, but I really think the users who set
avx10-version should also know avx10.0 doesn’t exist, so using 0 is same
as -1…

To solve the initial value issue fundamentally, maybe we can add get/set
callbacks when adding avx10-version property? It should be simpler to
limit what users set.

[ ... ]

> > > @@ -7674,13 +7682,21 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
> > >                                      &eax_0, &ebx_0, &ecx_0, &edx_0);
> > >          uint8_t version = ebx_0 & 0xff;
> > > 
> > > -        if (version < env->avx10_version) {
> > > +        if (!env->avx10_version) {
> > > +            env->avx10_version = version;
> > 
> > x86_cpu_filter_features() is not a good place to assign avx10_version, I
> > still tend to set it in max_x86_cpu_realize().
> 
> It's not proper to get the host's version when AVX10 cannot be enabled,
> even maybe host doesn't support AVX10.
> 
> As you found out earlier, max_x86_cpu_realize doesn't know if AVX10 can
> be enabled or not.
> 

How about moving to x86_cpu_expand_features()? We can set when checking
cpu->max_features.

[ ... ]

