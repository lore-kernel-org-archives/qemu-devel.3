Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39A0C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 03:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK7SN-0002do-S8; Tue, 27 May 2025 23:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uK7SL-0002cq-N2
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:27:53 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uK7SK-0004gm-1S
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748402872; x=1779938872;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tGjR23fGXaCK8j8WbOigsq7unGkxhXGSj0KgbbcVxuo=;
 b=kssI1fkGzHg0rfTBriwgK/j7ste9eK6QvmgmTkTefN/hQJmHdsyJ814h
 v2EWycTYJ2VZfyjGY5URvynwsyBv4pArqnt55qQ7pHhkJ+q6jolH6xj90
 KDHMpU+/m4vAzWKV2/sz1J2jr7xDiz/q7kJot4CUMPCDuFxFqLhuO+lon
 8wd12imJn7KA/IH7ICvmX0MuQa1j74Ci9caagTMVKEcib8n1Cs31gdt2W
 SvJQuzZh/JQ2ic4g4DGZX8XaZKTcUKfx/J9Wyp1nrRBkma+0uM2QT1vD9
 kOs/EJ0ClVjjoqkdbhT7/9W5EDCm+87y1qFvD1yTk+SE8fRTmKECIQQ6U Q==;
X-CSE-ConnectionGUID: 6UblzC+1QeGaUlTlWYfBHw==
X-CSE-MsgGUID: LXtvaLTyTv6K5K5IBbQWog==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50520210"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="50520210"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 20:27:50 -0700
X-CSE-ConnectionGUID: rHaT7rz5QFCXAd4XepDqcQ==
X-CSE-MsgGUID: 86UveVlgTrO7JBG70JGq+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="147955799"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 27 May 2025 20:27:49 -0700
Date: Wed, 28 May 2025 11:48:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: elisey.konstantinov@icloud.com, qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] Revert "i386/cpu: Set up CPUID_HT in
 x86_cpu_expand_features() instead of cpu_x86_cpuid()"
Message-ID: <aDaHqhiuowgjMtXK@intel.com>
References: <0C532D10-33ED-41F5-BBA7-13C64AA0633D@icloud.com>
 <aDaCJTkoDYsdJFmJ@intel.com>
 <bbeba807-ef49-4bd1-abfe-dce8b2a5f9a3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbeba807-ef49-4bd1-abfe-dce8b2a5f9a3@intel.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On Wed, May 28, 2025 at 11:22:57AM +0800, Xiaoyao Li wrote:
> Date: Wed, 28 May 2025 11:22:57 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH] Revert "i386/cpu: Set up CPUID_HT in
>  x86_cpu_expand_features() instead of cpu_x86_cpuid()"
> 
> On 5/28/2025 11:25 AM, Zhao Liu wrote:
> > Hi Elisey,
> > 
> > Thank you for your patch! I'm sorry I previously noticed #2894 [*] but
> > missed your report.
> > 
> > Recently there's a fix (commit 5979f50fa9fd ("i386/tcg: Make CPUID_HT
> > and CPUID_EXT3_CMP_LEG supported")). Does that fix address this bug?
> > 
> > [*]: https://lore.kernel.org/qemu-devel/aCWdhIqZiu4q+UJi@intel.com/
> 
> It should be the next one for hvf accelerator in this series that helps.
> Because the regression reported is on macOS.

From Elisey's cli example, this case is using TCG ("-accel tcg").


