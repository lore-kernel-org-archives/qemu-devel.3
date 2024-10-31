Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF19E68956
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 07:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6PXf-0005qU-D7; Thu, 31 Oct 2024 03:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6PXd-0005qE-NG
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:24:25 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6PXa-0000YE-BA
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730359462; x=1761895462;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WYP0MXSn7t4wnA7qxi6MRVAUezIV9psOcckRlSojAE0=;
 b=UVb2mNBxyR1cnRmp1m+oYbW5XP/M1E+Pxk3N0osfXHol4LDmdV8OktIM
 ySUeXb9n4lajMZofjc3q4jgZePBuKPsGQRvkgnuhqg0oV1VFa564KewDL
 fihjfkgnp6rHz2K3qmVDngTVBo+Y3wbwGAx887FfUfBov08rXYdrZzlUd
 JHgsocsdmR1f84zr0mEyHmK1xhzifkvSFdwNhg0ImSRMHjoX3eCWJPzQK
 1J9DFgCwZmIlZrzvIS+4hFl53n38r93PNndzvpohF17n/l4rGXCqiXdBZ
 u0ytYUZNom1eHZMh3IwCmZLpXaW4rfwdC4gWhfcbOT2PHHl0KorcVCWEZ g==;
X-CSE-ConnectionGUID: rm/0X7saQWOKIkJg8ljEmA==
X-CSE-MsgGUID: JojIAKT6Q2WSuCRl0WBOYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30298328"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="30298328"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 00:24:19 -0700
X-CSE-ConnectionGUID: NdN7i7YtS76ILlPFXanLKA==
X-CSE-MsgGUID: cda5iVK7Qxi0LR821hNRUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="87138763"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 00:24:18 -0700
Date: Thu, 31 Oct 2024 15:19:12 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: Re: [PATCH 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Message-ID: <ZyMvcPlRWH7v0z9O@linux.bj.intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-5-pbonzini@redhat.com>
 <ZyHyBnPvOHsSdh8D@intel.com> <ZyH+RB3v55cQ43+S@linux.bj.intel.com>
 <ZyIy4OGSGPhAZutK@intel.com> <ZyI9P1ftFOTUhDzb@linux.bj.intel.com>
 <ZyJW9nGgpEXqiyli@intel.com> <ZyMKAwq4lsk+ozu3@linux.bj.intel.com>
 <ZyMvTcW1QzA1ycUI@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyMvTcW1QzA1ycUI@intel.com>
Received-SPF: none client-ip=192.198.163.14;
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

On Thu, Oct 31, 2024 at 03:18:37PM +0800, Zhao Liu wrote:
> > > > > > > @@ -7674,13 +7682,21 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
> > > > > > >                                      &eax_0, &ebx_0, &ecx_0, &edx_0);
> > > > > > >          uint8_t version = ebx_0 & 0xff;
> > > > > > > 
> > > > > > > -        if (version < env->avx10_version) {
> > > > > > > +        if (!env->avx10_version) {
> > > > > > > +            env->avx10_version = version;
> > > > > > 
> > > > > > x86_cpu_filter_features() is not a good place to assign avx10_version, I
> > > > > > still tend to set it in max_x86_cpu_realize().
> > > > > 
> > > > > It's not proper to get the host's version when AVX10 cannot be enabled,
> > > > > even maybe host doesn't support AVX10.
> > > > > 
> > > > > As you found out earlier, max_x86_cpu_realize doesn't know if AVX10 can
> > > > > be enabled or not.
> > > > > 
> > > > 
> > > > How about moving to x86_cpu_expand_features()? We can set when checking
> > > > cpu->max_features.
> > > 
> > > The feature bit set in x86_cpu_expand_features() is unstable since it
> > > may be masked later in x86_cpu_filter_features(). :)
> > > 
> > 
> > A lot of feature bits are set in x86_cpu_expand_features() with reported
> > value, so I think avx10_version can also be set to reported value there.
> > 
> > I mainly want to let avx10_version be assigned only when -cpu host or max,
> > so that it can be distinguished from the cpu model. This should also be
> > Paolo's original intention in v2.
> 
> OK. In this case, extend avx10-version is also consistent with the
> semantics of this function. Even if host doesn't support avx10, then in
> principle it's ok to read unimplemented avx10-version as 0.
> 
> Pls go ahead. :)

I will submit v3 based on all your comments, thanks for review :)


