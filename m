Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4014C44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whlzL-0000mh-Bn; Thu, 09 Jul 2026 06:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whlzI-0000ka-Mn; Thu, 09 Jul 2026 06:28:13 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whlzF-0007Gn-MM; Thu, 09 Jul 2026 06:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783592890; x=1815128890;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oGsi1kLbteu6y4kmd7cEf8W3QP7gLdrJ4seoF+ab/rw=;
 b=jBTihBPvMJjsZhT5tHIoWN5PuBwv63nFlj/tNQiNzqvp9L51dDU/hq7w
 J58anrxyO7J3IaeoADa8s6g8cAGr+2VtAD9/w4wsPQNF3PfngmxQnuE1s
 OC5lqHLvOyxegi7a25Nvhe9vLra3QW//CGR1bnQtNy2SPC/2iWagd/sx3
 az3JpYtdvYH4i+a73DO1z6ksI9XopHIFwFF2DIIUIHgBrgSFFOAaSjstf
 w6T9QtOpUmTkaCuemc7vWdh0gtMiLsQU+lO8hAagjgbj5NuqIfNf/oW5n
 eQ+WKG6SvwB4aEll1MUUpPC+Lym05f6DQ7XU+vTUsq+6jI5uNxQ1zYk2z Q==;
X-CSE-ConnectionGUID: GcFWDxHjQJugvCfjHEgkdw==
X-CSE-MsgGUID: 9vTUYOHKQNyvgYMNxtr7Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84127572"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84127572"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 03:28:05 -0700
X-CSE-ConnectionGUID: bVghiQWVSh+iqfUkYknbCQ==
X-CSE-MsgGUID: kFDCW2y8SRWnOtTRANrceg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="253453080"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 09 Jul 2026 03:28:04 -0700
Date: Thu, 9 Jul 2026 18:56:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 seanjc@google.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] i386/cpu: Remove AMX-TF32 CPUID bit
Message-ID: <ak9+ZaWdzxr4eCju@intel.com>
References: <20260708210326.402054-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708210326.402054-1-chang.seok.bae@intel.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 08, 2026 at 09:03:26PM +0000, Chang S. Bae wrote:
> Date: Wed, 8 Jul 2026 21:03:26 +0000
> From: "Chang S. Bae" <chang.seok.bae@intel.com>
> Subject: [PATCH] i386/cpu: Remove AMX-TF32 CPUID bit
> X-Mailer: git-send-email 2.51.0
> 
> A recent revision of the Intel document [1] removed AMX-TF32, confirming
> that the feature will not be implemented in future processors. Remove the
> feature bit definition and its enumeration from the Diamond Rapids CPU
> model.
> 
> [1] Intel Architecture Instruction Set Extensions and Future Features
>     (Rev.062)
> 
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> KVM side posting: 
> https://lore.kernel.org/all/20260708210118.402005-1-chang.seok.bae@intel.com
> ---
>  target/i386/cpu.c | 5 ++---
>  target/i386/cpu.h | 2 --
>  2 files changed, 2 insertions(+), 5 deletions(-)> 

(Cc stable list)

At present, there's no user for DMR CPU model, so I think it's safe to
drop this feature flag from DMR CPU model driectly.

But to avoid unnecessary warning on older QEMU, IMO this patch should
be backported to the stable QEMU as well.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Regards,
Zhao


