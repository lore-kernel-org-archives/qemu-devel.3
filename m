Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6F4C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 04:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO8L3-0004zB-Ba; Mon, 01 Jul 2024 00:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sO8Kx-0004yy-BV
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 00:08:19 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sO8Ku-0004u8-P4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 00:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719806896; x=1751342896;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=I78+8o4y5TO/43sNey+piGJbq6eN+6lk2q0DLezIb5A=;
 b=ZCxYDK6dk0nXf05cDv50nAyGL7xSC5PVTjyaMH1U0za+eyBtT8qjE4jf
 oS7WDFPZINkFn8YQM3m4EDG8rY9lRU2+Asbm91MdOD7+zkaOD3X7SFusX
 6VYrvrhRtnvz6ToonbBilF+iOd33zcmTk+ZQcC2mH/0fPQ8Tl+r3Y5P0b
 5OE2vCLGe5F6kLX1qZx024ZPZJSG7OwK2aHeXVowaTtd4JT9YrSvHwaVg
 jwKjUkaPC4KRNWpqw+Y0pVO1OeYs9d1lD1aRIE5krHOLA6GOy+RTI8ZVO
 YYgzxuTeCP+wOM1/mUhn7fSzYUoKjqfDyFneLyDL8u8SVCySblnukuxC3 A==;
X-CSE-ConnectionGUID: Mt75o2f1Qq+XhuHD1N75DQ==
X-CSE-MsgGUID: krduxK+GSqGyOSkTD4mMqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17128006"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="17128006"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2024 21:08:11 -0700
X-CSE-ConnectionGUID: VzCKJDD4Q/SCgmtEWvVBEw==
X-CSE-MsgGUID: 2dgP7byzR3GxMdsw541gEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="45352101"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 30 Jun 2024 21:08:11 -0700
Date: Mon, 1 Jul 2024 12:23:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel <qemu-devel@nongnu.org>,
 John Allen <john.allen@amd.com>
Subject: Re: [PATCH 2/2] target/i386: drop AMD machine check bits from Intel
 CPUID
Message-ID: <ZoIvUtVOgK91UuvF@intel.com>
References: <20240627140628.1025317-1-pbonzini@redhat.com>
 <20240627140628.1025317-3-pbonzini@redhat.com>
 <a8f5d517-7037-4146-824e-3f985774c780@intel.com>
 <CABgObfa24iTNt7V_VjsKYRhLyD3pt6oGDHEUFxe1A_A-4HF7MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfa24iTNt7V_VjsKYRhLyD3pt6oGDHEUFxe1A_A-4HF7MA@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Jun 28, 2024 at 03:23:11PM +0200, Paolo Bonzini wrote:
> Date: Fri, 28 Jun 2024 15:23:11 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 2/2] target/i386: drop AMD machine check bits from
>  Intel CPUID
> 
> Il ven 28 giu 2024, 10:32 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:
> 
> > On 6/27/2024 10:06 PM, Paolo Bonzini wrote:
> > > The recent addition of the SUCCOR bit to kvm_arch_get_supported_cpuid()
> > > causes the bit to be visible when "-cpu host" VMs are started on Intel
> > > processors.
> > >
> > > While this should in principle be harmless, it's not tidy and we don't
> > > even know for sure that it doesn't cause any guest OS to take unexpected
> > > paths.  Since x86_cpu_get_supported_feature_word() can return different
> > > different values depending on the guest, adjust it to hide the SUCCOR
> >
> > superfluous different
> >
> > > bit if the guest has non-AMD vendor.
> >
> > It seems to adjust it based on vendor in kvm_arch_get_supported_cpuid()
> > is better than in x86_cpu_get_supported_feature_word(). Otherwise
> > kvm_arch_get_supported_cpuid() still returns "risky" value for Intel VMs.
> >
> 
> But the cpuid bit is only invalid for Intel *guest* vendor, not host. It is
> not a problem to have it if you run on Intel host but have a guest model
> with AMD vendor.
> 
> I will check if there are other callers of kvm_arch_get_supported_cpuid(),
> or callers of x86_cpu_get_supported_feature_word() with NULL cpu, that
> might care about the difference.

Another example is CPUID_EXT3_TOPOEXT, though it's a no_autoenable_flags,
it can be set by "-cpu host,+topoext" on Intel platforms.

For this case, we have recognized that that the host/max CPU should only
contain vender specific features, and I think it would be hard to expand
such a rule afterwards, especially since there's other x86 vender like
zhaoxin who implement a subset of Intel/AMD:

https://lore.kernel.org/qemu-devel/d4c0dae5-b9d5-4deb-b300-78492ab11ed8@zhaoxin.com/#t

What about a new flag "host_bare_metal_check" in FeatureWordInfo? Then
if a feature is marked as "host_bare_metal_check", in addition to the
current checks in x86_cpu_get_supported_feature_word(), bare-metal CPUID
check is also needed (by host_cpuid()) for "host" CPU.

-Zhao


