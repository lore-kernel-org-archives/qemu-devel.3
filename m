Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74BAC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 11:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Omu-0006ZL-OQ; Fri, 10 May 2024 07:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5Omt-0006Ym-EJ
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:51:43 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5Omr-0001Q4-8H
 for qemu-devel@nongnu.org; Fri, 10 May 2024 07:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715341902; x=1746877902;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XdBV3mcBLzj/Bxt3ghMKAesLerhgAqdShxT4q/1++rs=;
 b=WBU3TuiXAyP32iG9cMeho4p6QuL2ZZAWxmKD0S0YzYdJ2s1shbLMskzL
 AN9ZHoc8sHDXR9a2iXiaef72lH+mJ+MvkNFK+0JjF6wTgYSL4pc7CO2RM
 4Cuvthr1A8bpNHyxK05VKknNJVffv1UWBW8DhTMcRVojjWtEPMTvZLuqb
 PClwASPEUF7de6d917FX5KXfralUNJ6a0dRc63f76I9zQOyKcSsbpe/QJ
 lLh2scaC7yq7PNiUK4z3R/4MYaTX1RhFeiUeH80wg8FaAUWtaLx724FdL
 sht7QLebJNETzmTMS68hmecHJ4kf+j9nlc5qUnM0Ga+Amy4TyEB8kxhAL g==;
X-CSE-ConnectionGUID: Y1fdbMwISMqi810jDNfMYg==
X-CSE-MsgGUID: +IJU0zYgSpaelZ5x2fqW5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15152737"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="15152737"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 04:51:39 -0700
X-CSE-ConnectionGUID: 7H8tnoTWTKmpCZD/gp1n9A==
X-CSE-MsgGUID: IFfskaW5SGKUlaJeNXEV4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="60444764"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 10 May 2024 04:51:37 -0700
Date: Fri, 10 May 2024 20:05:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Subject: Re: [PATCH 09/13] i386: pc: remove unnecessary MachineClass overrides
Message-ID: <Zj4Nno54w8wlkDu2@intel.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509170044.190795-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Thu, May 09, 2024 at 07:00:40PM +0200, Paolo Bonzini wrote:
> Date: Thu,  9 May 2024 19:00:40 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 09/13] i386: pc: remove unnecessary MachineClass overrides
> X-Mailer: git-send-email 2.45.0
> 
> There is no need to override these fields of MachineClass because they are
> already set to the right value in the superclass.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/hw/i386/x86.h | 4 ----
>  hw/i386/pc.c          | 3 ---
>  hw/i386/x86.c         | 6 +++---
>  3 files changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


