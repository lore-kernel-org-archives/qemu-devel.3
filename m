Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9335BCAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oD3-0007HR-L7; Thu, 25 Sep 2025 11:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1oCw-0007Fi-PJ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:48:37 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1oCk-0005oE-0J
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758815302; x=1790351302;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6jRnfbN8/31Fw5rEfraQVnTTPcvtsXf+CfbhRcCHwDI=;
 b=CH1gQMWxauHupwOICb8QnKJVmJDaFLoUisR7Cy8O2YvIR51QscLcMhX8
 EciwDRX6NHfur2CL3rQEowHZVup9jyWRTt0MU+2yu6q3aWKpJ38qeWpBL
 c/OvlVTDeCJIM9fTRjOwEEU8vpcLfljlfIrp1nQaQQ7jzeYszL1OV6eKI
 pohWsD+2Hb+YPpRSaqI591P+rDTpfyhq8NOydzpeIRNQ/rX7HbVEk6dvG
 b5fJsIB4axF8O1xT9PhjZnpO54D01SyCjeGMvvG1fm0zjZMW+DggPJHOJ
 kgEhAeYXH/7X8Oy0Em3hjLATzWAysDA589tDbrnhfrJ7vKhyUdazfuUK0 A==;
X-CSE-ConnectionGUID: IArOiKsfQWCHzs5WrZEHjA==
X-CSE-MsgGUID: fOS/onZ8TvihcjZqyNAOWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="60838819"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="60838819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 08:48:13 -0700
X-CSE-ConnectionGUID: VCemASL0SkyPxzDahHWoFw==
X-CSE-MsgGUID: GWJO0FXkQ16UZ4Fmw65WbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="181375221"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 25 Sep 2025 08:48:13 -0700
Date: Fri, 26 Sep 2025 00:10:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, hector.cao@canonical.com, lk@c--e.de,
 berrange@redhat.com
Subject: Re: [RFT PATCH v2 2/2] target/i386: add compatibility property for
 pdcm feature
Message-ID: <aNVpYlFmo2dXgoSF@intel.com>
References: <20250923104136.133875-1-pbonzini@redhat.com>
 <20250923104136.133875-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923104136.133875-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 23, 2025 at 12:41:36PM +0200, Paolo Bonzini wrote:
> Date: Tue, 23 Sep 2025 12:41:36 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [RFT PATCH v2 2/2] target/i386: add compatibility property for
>  pdcm feature
> X-Mailer: git-send-email 2.51.0
> 
> From: Hector Cao <hector.cao@canonical.com>
> 
> The pdcm feature is supposed to be disabled when PMU is not
> available. Up until v10.1, pdcm feature is enabled even when PMU
> is off. This behavior has been fixed but this change breaks the
> migration of VMs that are run with QEMU < 10.0 and expect the pdcm
> feature to be enabled on the destination host.
> 
> This commit restores the legacy behavior for machines with version
> prior to 10.1 to allow the migration from older QEMU to QEMU 10.1.
> 
> Signed-off-by: Hector Cao <hector.cao@canonical.com>
> Link: https://lore.kernel.org/r/20250910115733.21149-3-hector.cao@canonical.com
> Fixes: e68ec298090 ("i386/cpu: Move adjustment of CPUID_EXT_PDCM before feature_dependencies[] check", 2025-06-20)
> [Move property from migration object to CPU. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.h |  6 ++++++
>  hw/i386/pc.c      |  1 +
>  target/i386/cpu.c | 15 ++++++++++++---
>  3 files changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


