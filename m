Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2B1D74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 03:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5zJA-0001lm-JV; Tue, 29 Oct 2024 23:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5zJ8-0001jn-9O
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 23:23:42 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5zJ5-0002Dd-TA
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 23:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730258620; x=1761794620;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=N4q/a7OLrilMA1oLa4pLlbn9zxUSJtdU1OzPO7GRQGU=;
 b=VcfE7xF6VrlQkMfsptrw9zZC796OEKVkgBr8xjTfgmbLd6ozJIWgzW9R
 /m3x6jJkh0pWvv+O9lJD6UD55RoIJ/63hIeqCEAt4tsyiokf6ZK1i673L
 wIX0GzckZvNIGbc9DnBcY9p0GhimVyYFNgAjpAi1KgM2OyD281iH+wuEP
 mjuyFFM/TRoLyWFfcZZT8GB6UHhixlJfogg9w+OSi58SxoFd3SIngKJ15
 4xKw7+IVHB3k/hsNgcIdCvMJfL/5dE9305vtAavzLjV+0G9AAUcUGmEg8
 nPYrvN415HcTj30zaQQOBr0j++HBbV4Y7ip890K4YGSJRLxHvZ55XL6+i Q==;
X-CSE-ConnectionGUID: JU11/VqITaaABbOAnn8ccw==
X-CSE-MsgGUID: nIZ1fbjgTnqnNm6+pGAN7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30085711"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30085711"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 20:23:37 -0700
X-CSE-ConnectionGUID: enUlSaS1QKuMQH30j5HMCA==
X-CSE-MsgGUID: FVmM0jCTTXeY1aiObrJf1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; d="scan'208";a="86731071"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 20:23:36 -0700
Date: Wed, 30 Oct 2024 11:18:30 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, zhao1.liu@intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v2 0/8] Add AVX10.1 CPUID support and GraniteRapids-v2
 model
Message-ID: <ZyGlhjFULPac5hpi@linux.bj.intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151858.550269-1-pbonzini@redhat.com>
Received-SPF: none client-ip=198.175.65.16;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

On Tue, Oct 29, 2024 at 04:18:50PM +0100, Paolo Bonzini wrote:
> Most of the patches here are from Tao Su's v1.  The main issue in his
> version were two:
> 
> - overlooking kvm_cpu_xsave_init(), which currently looks at ExtSaveArea.
>   This would get a bit ugly for extended save states that are enabled
>   by both AVX512 and AVX10.  Patches 1-2 change kvm_cpu_xsave_init()
>   to look at ExtSaveArea's size field instead of testing features.
> 
> - downgrading silently to KVM reported value if the avx10_version property
>   is >= kvm reported value.  Xiaoyao Li suggested basing this on
>   cpu->check_cpuid and cpu->enforce_cpuid.  Also, the check must accept
>   any accelerator and not just KVM.  I moved the check to
>   x86_cpu_filter_features in patch 4.
> 
> I don't have a Granite Rapids machine, so please test! :)

I test it on Granite Rapids and all meet expection with my minor changes on
patch4 :)

> 
> Paolo
> 
> Paolo Bonzini (3):
>   target/i386: cpu: set correct supported XCR0 features for TCG
>   target/i386: do not rely on ExtSaveArea for accelerator-supported XCR0 bits
>   target/i386: return bool from x86_cpu_filter_features
> 
> Tao Su (5):
>   target/i386: add AVX10 feature and AVX10 version property
>   target/i386: add CPUID.24 features for AVX10
>   target/i386: Add feature dependencies for AVX10
>   target/i386: Add AVX512 state when AVX10 is supported
>   target/i386: Introduce GraniteRapids-v2 model
> 
>  target/i386/cpu.h         |  16 ++++
>  target/i386/cpu.c         | 175 ++++++++++++++++++++++++++++++++++----
>  target/i386/kvm/kvm-cpu.c |   8 --
>  target/i386/kvm/kvm.c     |   3 +-
>  4 files changed, 175 insertions(+), 27 deletions(-)
> 
> -- 
> 2.47.0
> 

