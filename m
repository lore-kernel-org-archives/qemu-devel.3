Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CADC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 08:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri8zJ-0007Yk-KT; Thu, 07 Mar 2024 03:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ri8zG-0007YE-7B
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 03:20:22 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ri8z0-0000pI-87
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 03:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709799606; x=1741335606;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bU1bR6Z/iIJ6UKt6aZNwr31APBwl/ByF86ouCImsRP0=;
 b=nL8b5j+IccFZaByp8ymtRe7aiL06kk9ai2T/VBjZKSLyiFCm/1yRzelp
 VcHD53VOJyeS6huajQ19n5OuoNO0CvA21Cfvtif9f4/Eo+dfFxxrv12B9
 hawkDPvr1Vg93Dfiv59t2dZ2p+S0PyWcSyRE/qEVSqns0v52bWME4Vsww
 EJTVwz3+mUU1+gFzkUjZ3L3T9ECtnAqVXJ+SQs2vOU3FlzYkMa078Ajrl
 RU82T03skd/4EQH5K+/7YmlaXYKYh36aTnLqOOJFreyKeco6CERqGv0Ni
 MKqEIP+nhGFdqqLvJOlqwDDkgfdOTriZwgTF5uGl/vm8unWUoUx7bZpk/ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4322714"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4322714"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 00:20:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; d="scan'208";a="14722304"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 07 Mar 2024 00:20:00 -0800
Date: Thu, 7 Mar 2024 16:33:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RESEND v3 3/3] docs/system: Add recommendations to
 Hyper-V enlightenments doc
Message-ID: <Zel7612e3rSgcBjv@intel.com>
References: <20240305164204.525575-1-vkuznets@redhat.com>
 <20240305164204.525575-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305164204.525575-4-vkuznets@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Vitaly,

On Tue, Mar 05, 2024 at 05:42:04PM +0100, Vitaly Kuznetsov wrote:
> Date: Tue,  5 Mar 2024 17:42:04 +0100
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Subject: [PATCH RESEND v3 3/3] docs/system: Add recommendations to Hyper-V
>  enlightenments doc
> 
> While hyperv.rst already has all currently implemented Hyper-V
> enlightenments documented, it may be unclear what is the recommended set to
> achieve the best result. Add the corresponding section to the doc.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  docs/system/i386/hyperv.rst | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
> index 009947e39141..1c1de77feb65 100644
> --- a/docs/system/i386/hyperv.rst
> +++ b/docs/system/i386/hyperv.rst
> @@ -283,6 +283,36 @@ Supplementary features
>    feature alters this behavior and only allows the guest to use exposed Hyper-V
>    enlightenments.
>  
> +Recommendations
> +---------------

This guide is very helpful!

> +To achieve the best performance of Windows and Hyper-V guests and unless there
> +are any specific requirements (e.g. migration to older QEMU/KVM versions,
> +emulating specific Hyper-V version, ...), it is recommended to enable all
> +currently implemented Hyper-V enlightenments with the following exceptions:
> +
> +- ``hv-syndbg``, ``hv-passthrough``, ``hv-enforce-cpuid`` should not be enabled
> +  in production configurations as these are debugging/development features.
> +- ``hv-reset`` can be avoided as modern Hyper-V versions don't expose it.

Does the "Hyper-V versions" means Hyper-V guest version or Microsoft's Hyper-V
hypervisor version? It would be better to clarify Hyper-V guest and
Hyper-v hypervisor.

And it would be better to have a clear version number.

> +- ``hv-evmcs`` can (and should) be enabled on Intel CPUs only. While the feature
> +  is only used in nested configurations (Hyper-V, WSL2), enabling it for regular
> +  Windows guests should not have any negative effects.
> +- ``hv-no-nonarch-coresharing`` must only be enabled if vCPUs are properly pinned
> +  so no non-architectural core sharing is possible.
> +- ``hv-vendor-id``, ``hv-version-id-build``, ``hv-version-id-major``,
> +  ``hv-version-id-minor``, ``hv-version-id-spack``, ``hv-version-id-sbranch``,
> +  ``hv-version-id-snumber`` can be left unchanged, guests are not supposed to
> +  behave differently when different Hyper-V version is presented to them.
> +- ``hv-crash`` must only be enabled if the crash information is consumed via
> +  QAPI by higher levels of the virtualization stack. Enabling this feature
> +  effectively prevents Windows from creating dumps upon crashes.
> +- ``hv-reenlightenment`` can only be used on hardware which supports TSC
> +  scaling or when guest migration is not needed.
> +- ``hv-spinlocks`` should be set to e.g. 0xfff when host CPUs are overcommited
> +  (meaning there are other scheduled tasks or guests) and can be left unchanged
> +  from the default value (0xffffffff) otherwise.
> +- ``hv-avic``/``hv-apicv`` should not be enabled if the hardware does not
> +  support APIC virtualization (Intel APICv, AMD AVIC).
>

It's also better to add blank lines between paragraphs above.

BTW, may I ask another Windows question? I understand that Windows such
as Windows 10 and later is already a virtualized architecture with
built-in Hyper-V to run root partation.

So is it true that booting Windows VM via KVM + QEMU is running Windows
Guest in L2? Or what is the relationship between Hyper-V within Windows
and Hyper-V enlightenments with QEMU + KVM?

Thanks,
Zhao



