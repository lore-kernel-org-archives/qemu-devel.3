Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969A8C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 10:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMl91-0000N6-BK; Wed, 04 Jun 2025 06:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMl8z-0000Mp-QV
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:14:49 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMl8x-0004Nx-Gb
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749032088; x=1780568088;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=b2x/SBTZdx5m1874By/R50oUm6tWLKncS+ZsvQj+nWs=;
 b=Uv+fJz9Qw0ZrLaPnTsm8SxJDOudlZtXHR29V+KYfBqgjN2Em3XWNb6ae
 itS1mDxZtXXaICxwuRxyQhxTwRcCX/2VtYbh2YTkCmIdt816Tgz7UNitQ
 XFlSpSn32w2dZmsMo4Z+RF88BKjPuJBTlpv1OTtLbgAQPn/jiJMoGHDfm
 GqSp9tPE/XfaBaC9eem8AR/zvIfDdfUrVrxHg0g3xmjSZpqTPQFLm4miU
 vMCQ1PVsgyGqgUVpI7ucSUPF1bYgcNfpDxsqrjw6T1yFqJujoyjrWIDd9
 2EWbDRT79rIx+KBasD224ZcmtxSXT+d1Uvga7wCo3CekKrKAmjqf6xgfO w==;
X-CSE-ConnectionGUID: IdCB8eIcShuOx8h2JDuWQQ==
X-CSE-MsgGUID: DBTx7K7+TR+hAo2RUUHGQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51106711"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="51106711"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 03:14:40 -0700
X-CSE-ConnectionGUID: flB4ZCt4Spa9qYxNy37VPA==
X-CSE-MsgGUID: +IQV4C7iSrO3S4zBQhh2Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="149934287"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 04 Jun 2025 03:14:39 -0700
Date: Wed, 4 Jun 2025 18:35:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] i386/cpu: Rename enable_cpuid_0x1f to force_cpuid_0x1f
Message-ID: <aEAhiAVXu8FVoOeS@intel.com>
References: <20250603050305.1704586-1-xiaoyao.li@intel.com>
 <20250603050305.1704586-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603050305.1704586-2-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

On Tue, Jun 03, 2025 at 01:03:03AM -0400, Xiaoyao Li wrote:
> Date: Tue,  3 Jun 2025 01:03:03 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH 1/3] i386/cpu: Rename enable_cpuid_0x1f to force_cpuid_0x1f
> X-Mailer: git-send-email 2.43.0
> 
> The name of "enable_cpuid_0x1f" isn't right to its behavior because the
> leaf 0x1f can be enabled even when "enable_cpuid_0x1f" is false.
> 
> Rename it to "force_cpuid_0x1f" to better reflect its behavior.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Suggested by Igor at https://lore.kernel.org/qemu-devel/20250513144515.37615651@imammedo.users.ipa.redhat.com/
> ---
>  target/i386/cpu.h     | 4 ++--
>  target/i386/kvm/tdx.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


