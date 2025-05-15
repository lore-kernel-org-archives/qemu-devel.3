Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3739C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 07:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFT5E-0007F8-0D; Thu, 15 May 2025 03:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFT5C-0007Ez-08
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:32:46 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFT59-0004vr-I0
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747294363; x=1778830363;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=x6KqwCn/i0agTo8NqVmQhC6ggUzE4eVYkFcd+vWCGNM=;
 b=AFg+9a/pnKDcnmVvGSChUf4YTaIGOhsnEyvqO+voPV43OMa3aYOcP8SG
 Mi67r0c1Fe43s+u0gCsuDjb7ldOxCDjUCmDntwK/RxVEy0iZdQxU44cpe
 FZhiCH4xWd2vIKNK4R9AwYtUwmVC11LcFoHWE/kJZsvs5uKecZ+y5plp6
 TfG03c6WtUggND9tv4H+zQ4Zt2NT/gV5sZ+ib6G7wuZfFFArU55Po8Sk/
 jfDJloamOTUq0FKIC1uDZNC8t+aQBB3MrAvnvG54oPXhMHWSO/MV6cJEx
 3Ylp06BS31Q2o4h9lrzAGZ5UrLcDwwAxa3rcsXkeu0EPBAZMgb7wNjLoR Q==;
X-CSE-ConnectionGUID: tfKlprexQi6EMs9S+7KljA==
X-CSE-MsgGUID: snF7rvcTTeGcxdTvOCC0iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66768575"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="66768575"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 00:32:38 -0700
X-CSE-ConnectionGUID: 9EhKdpTGTrCcCICKgPZWog==
X-CSE-MsgGUID: 0QZ2Py39Ss+yQhgBAyN4ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="138823155"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 15 May 2025 00:32:36 -0700
Date: Thu, 15 May 2025 15:53:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] i386/tcg: Make CPUID_HT and CPUID_EXT3_CMP_LEG
 supported
Message-ID: <aCWdhIqZiu4q+UJi@intel.com>
References: <20250514031652.838763-1-xiaoyao.li@intel.com>
 <20250514031652.838763-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514031652.838763-2-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

On Tue, May 13, 2025 at 11:16:51PM -0400, Xiaoyao Li wrote:
> Date: Tue, 13 May 2025 23:16:51 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH 1/2] i386/tcg: Make CPUID_HT and CPUID_EXT3_CMP_LEG
>  supported
> X-Mailer: git-send-email 2.43.0
> 
> Since commit c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in
> x86_cpu_expand_features() instead of cpu_x86_cpuid()") and
> commit 99a637a86f55 ("i386/cpu: Set and track CPUID_EXT3_CMP_LEG in
> env->features[FEAT_8000_0001_ECX]"), it gets warnings when booting the
> VM with vcpus >= 2 and with tcg:
> 
>   qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]
>   qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.80000001H:ECX.cmp-legacy [bit 1]
> 
> This is because, after the two commits, CPUID_HT and CPUID_EXT3_CMP_LEG
> are set in env->features[] when vcpus >=2 (in x86_cpu_expand_features())
> later in x86_cpu_filter_features() it will check against the TCG supported
> bits. However, current TCG doesn't mark the two bits as supported, hence
> the warnings.
> 
> Fix it by adding the two bits to the supported bits of TCG since multiple
> vcpus are supported by TCG.
> 
> Fixes: c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in x86_cpu_expand_features() instead of cpu_x86_cpuid()")
> Fixes: 99a637a86f55 ("i386/cpu: Set and track CPUID_EXT3_CMP_LEG in env->features[FEAT_8000_0001_ECX]")
> Reported-by: Ewan Hai <ewanhai-oc@zhaoxin.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2894

Then QEMU gitlab can track this fix.

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Both HT and CMPLegacy depend on CPU topology (mutiple threads per
package), therefore, there's no need for extra work in TCG.

So,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



