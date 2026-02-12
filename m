Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F333FECD6FE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 02:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqM4r-0002CV-TH; Wed, 11 Feb 2026 21:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vqM4p-0002B2-EC
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 21:05:07 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vqM4m-0005Wp-6r
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 21:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770861904; x=1802397904;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Q7AuZLfn1sRzoRG30+drC4km/GtNflm9rxrXjZ9Ni/s=;
 b=jStOSoAnqHqTj2/6eTLKDVO1JIbGpbK64dL4P3tZU34WRLzplyMaGd0Y
 ylN2KYEErrc/kAYR4j4Ehpy+PxdMGgHo3gSadsivxnpWqv6HQBPEASTJp
 W0fBjaoJa2anG/yJtVgZU2gdHQpg3nSP0o2MffAa0DoHjaswlpWl9+fXc
 inU5vruPtVpXyf+ZSrCyXrDjnNcN21aXNkb8FmtdQGmZ9YVi1b8MSHyav
 M5nIsUeR9dSu1lP75Q8qexrnV0wL3Ab7zfqCRLngnUEp+FCKNb4cE5ql1
 oLpxf/oPudEqGkfHO0bDWCo/G37Q+OL8bW+5I4VsQrifwSIjjz7euIgrB A==;
X-CSE-ConnectionGUID: OjSVEDi1Ru+cKYUJonybUA==
X-CSE-MsgGUID: B9XBpPAcQ3SE0dU+kFiWmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71931725"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="71931725"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 18:05:00 -0800
X-CSE-ConnectionGUID: gSZOPWmtSyGXPHyKfB4guw==
X-CSE-MsgGUID: FmeM7YF5QIKxr7/Qu9sCxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="211536801"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 11 Feb 2026 18:04:58 -0800
Date: Thu, 12 Feb 2026 10:30:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] docs: simplify DiamondRapids CPU docs
Message-ID: <aY07YNr9/RvKn3nF@intel.com>
References: <20260211180021.1057478-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260211180021.1057478-1-berrange@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 11, 2026 at 06:00:21PM +0000, Daniel P. Berrangé wrote:
> Date: Wed, 11 Feb 2026 18:00:21 +0000
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH] docs: simplify DiamondRapids CPU docs
> 
> This aligns the first line of the docs with the style used for previous
> CPU models, and simplifies the text in the remaining docs.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/system/cpu-models-x86.rst.inc | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
> index 3605d05a8c..9d4486c978 100644
> --- a/docs/system/cpu-models-x86.rst.inc
> +++ b/docs/system/cpu-models-x86.rst.inc
> @@ -72,17 +72,13 @@ compatibility is required, use the newest CPU model that is compatible
>  across all desired hosts.
>  
>  ``DiamondRapids``
> -    Intel Xeon Processor.
> +    Intel Xeon Processor (DiamondRapids, 2025)

Maybe 2026? I think the year should be the release data instead of patch
data.

> -    Diamond Rapids product has a topology which differs from previous Xeon
> -    products. It does not support SMT, but instead features a dual core
> -    module (DCM) architecture. It also has core building blocks (CBB - die
> -    level in CPU topology). The cache hierarchy is organized as follows:
> -    L1 i/d cache is per thread, L2 cache is per DCM, and L3 cache is per
> -    CBB. This cache topology can be emulated for DiamondRapids CPU model
> -    using the smp-cache configuration as shown below:
> -
> -    Example:
> +    This does not include SMT but allows the module (dual core module
> +    - DCM) and die (core building block - CBB) topology levels. The
> +    cache hierarchy is L1 i/d cache per thread, L2 cache per module,
> +    and L3 cache per die, which can be emulated using the smp-cache
> +    option:

Otherwise, look good to me, and thanks!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Regards,
Zhao


