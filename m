Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CBDC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 07:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTSJ-0004nW-JI; Thu, 15 May 2025 03:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFTSB-0004fs-Pi
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:56:32 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFTS9-0007eT-Ip
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747295789; x=1778831789;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=d/uAI1stqwfhW1tdA2rECmcN2OVfSmJWFS45w2ZofY0=;
 b=R2PzV/v7Co5vIetGaR1iO9A2Kbmn1k+CU6zoU4Hwla7IZeCy69n5tjs6
 KpkUdCDFIEAFiOl/nNumqhZaBdLSxqEuNT7ystbv1Lr7pXplnq5H37Per
 hZDdVuePSd8zTcO5jlZMIMMv0eT/9kvqqXpfReYFlkHztK3bCd2FlbCKM
 Ai4MY5wcLem69m6q8+VJXzVtqEWGewEH4LP+DteEbuFPM0gxMXi97IMOE
 K8HvWPDWGORPtA64NA6xGOyKnZbSypTXDyEAcpnY+WFlXBaMK5xBZzUCV
 D9cbD3g1B3uKwg2jWCWJQrM7zwkz/U8FW3nbtx7N4zWawdo7tOQWIrIBi w==;
X-CSE-ConnectionGUID: JzSQVXQjSTO27Aa3ieGWZA==
X-CSE-MsgGUID: nRj5yWhiTwGCblQR/aGgQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59449277"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="59449277"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 00:56:25 -0700
X-CSE-ConnectionGUID: 2mjGk6BOQBiPyaU1Bb7ZeA==
X-CSE-MsgGUID: xix7kRVHSTiQ5qsfPTz3Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="138161571"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 15 May 2025 00:56:23 -0700
Date: Thu, 15 May 2025 16:17:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] i386/hvf: Make CPUID_HT supported
Message-ID: <aCWjGFFlKqwOyY0/@intel.com>
References: <20250514031652.838763-1-xiaoyao.li@intel.com>
 <20250514031652.838763-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514031652.838763-3-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, May 13, 2025 at 11:16:52PM -0400, Xiaoyao Li wrote:
> Date: Tue, 13 May 2025 23:16:52 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH 2/2] i386/hvf: Make CPUID_HT supported
> X-Mailer: git-send-email 2.43.0
> 
> Since Commit c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in
> x86_cpu_expand_features() instead of cpu_x86_cpuid()"), CPUID_HT will be
> set in env->features[] in x86_cpu_expand_features() when vcpus >= 2.
> 
> Later in x86_cpu_filter_features() it will check against the HVF
> supported bits. It will trigger the warning like
> 
>     qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]
> 
> Add CPUID_HT to HVF supported CPUID bits to fix it.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Note, the issue is totally by my analysis (which should be the same as
> the TCG warnings) because I don't have HVF environment to verify it.
> 
> If would be helpful if anyone can help reproduce it and test the patch
> in HVF environment.

Ah, I found someone has reported a bug on HVF. In his log, there's the
ht warning:

https://gitlab.com/qemu-project/qemu/-/issues/2938

But I don't know if this fix can help on his bug...let's wait for his
feedback.

> ---
>  target/i386/hvf/x86_cpuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Anyway, this fix is fine for me, so,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


