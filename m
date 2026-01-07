Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6FBCF6BF0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdNsJ-0002qn-Nt; Wed, 07 Jan 2026 02:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdNs9-0002mt-IL
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:22:25 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdNs7-00050Q-Qh
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767770544; x=1799306544;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7lXZuzLzfx6HVQQePV4kMY1/hONMlODrwOZeuTwuKGQ=;
 b=Kwq8gL6MYAzpPloShdMAFDo7clJTW3WfUuT7m5x+SlDldskI1fevvf78
 eU9JQZOwHAYBAMbduVGGkzLS1/O+LWLVVV0JtV62USBvZE2WAiD/nxj4O
 B5Si3nIJkDdXe5P78fHADLqhpORQXhjnRz0P62a/qCJF3R4Hs5g5nf4uL
 HN2+KwJE5gOfv5wfcBH2iIP0OG2m1IvwMfyZ9onGXwKFvzq9HAd4MkAoU
 vU+gZD5n095UzHJCqZwfqSIhuVZT66wZRzaXC+T2CflHPIJlySsAJF70D
 4aM7q0Iz5aMEahbdJQtEz5udwIcR6SwuAV7UUI6SL1gLGs9IpGgoHH9Z3 g==;
X-CSE-ConnectionGUID: mYvUSiFoQMSKeoXa2ofqzg==
X-CSE-MsgGUID: ptXaQt+6RMei84aVhQGoww==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69211154"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="69211154"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2026 23:22:22 -0800
X-CSE-ConnectionGUID: iXiuRILPSECNlthpJH7zSg==
X-CSE-MsgGUID: YPri1uymQ/m08GxZoIpDLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="203304854"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 06 Jan 2026 23:22:20 -0800
Date: Wed, 7 Jan 2026 15:47:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, seanjc@google.com, santosh.shukla@amd.com,
 nikunj.dadhania@amd.com, ravi.bangoria@amd.com, babu.moger@amd.com
Subject: Re: [PATCH 3/5] i386: Enable CPUID 80000026 for EPYC-Genoa/Turin vCPU
Message-ID: <aV4PoetP0e319jyL@intel.com>
References: <20251121083452.429261-1-shivansh.dhiman@amd.com>
 <20251121083452.429261-4-shivansh.dhiman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121083452.429261-4-shivansh.dhiman@amd.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Fri, Nov 21, 2025 at 08:34:50AM +0000, Shivansh Dhiman wrote:
> Date: Fri, 21 Nov 2025 08:34:50 +0000
> From: Shivansh Dhiman <shivansh.dhiman@amd.com>
> Subject: [PATCH 3/5] i386: Enable CPUID 80000026 for EPYC-Genoa/Turin vCPU
> X-Mailer: git-send-email 2.43.0
> 
> Enable CPUID leaf 0x80000026 (Extended CPU Topology) for AMD Zen4+ processors,
> i.e, Genoa and above. Add version 3 to EPYC-Genoa and version 2 to EPYC-Turin
> CPU models with x-force-cpuid-0x80000026 property enabled.
> 
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
>  target/i386/cpu.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


