Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA521D74971
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 09:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWX08-0005G4-Uh; Fri, 19 Dec 2025 04:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vWX07-0005FY-Mg; Fri, 19 Dec 2025 04:42:19 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vWX06-0003RR-6d; Fri, 19 Dec 2025 04:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766137338; x=1797673338;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=64FUL1fuC4qQa2vjdkbCW1X0ZULlfKcE0RzA6/SGYnU=;
 b=CMdwZ4NQXUNm+g7DysTIYpjV6bRdChXuYVmf3O6mgjQm8U6H+SPKkflI
 IFknhwbQhPTs1meHrbIMV/Bp8pIsrh9PhYWs66DCdlXCWSBE4elis2sIn
 z6W0EOyHsoV+bPqX1wyLo4l8VGPn2exr/UQgXXMFZKjS1fTUUZgESEoto
 NfUxMFOej+HcRemdMp1vC8ReN04VcIag7EYafB/1ekTMO5iOh2VcIFop9
 6Cn3QOmP8LYuIcMENOc2zzb9bTJVwe1JYW9ElIdQDKi0xcfZHjNdOFCZl
 pnfU8Yzt+vSQFHByLpNxWCwbENP1Ghk/39CnLX74istcRiGyBahyltL0U g==;
X-CSE-ConnectionGUID: aWsbQhb3TYm995kIlT5ItQ==
X-CSE-MsgGUID: lUXdh/45Q/eFulvsYOmJ/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="79218379"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="79218379"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 01:41:10 -0800
X-CSE-ConnectionGUID: 5Tpuv2WOSvempHeSLYuQGg==
X-CSE-MsgGUID: d7b3Kn8bTouuPBcl8v8SCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198833056"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Dec 2025 01:41:07 -0800
Date: Fri, 19 Dec 2025 18:05:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH-for-11.0 v6 08/13] hw/sparc64/sun4u: Use
 fw_cfg_init_io_nodma()
Message-ID: <aUUjhXq6+rftKQN5@intel.com>
References: <20251203060942.57851-1-philmd@linaro.org>
 <20251203060942.57851-9-philmd@linaro.org>
 <aTBccn2LIv7puGzR@intel.com>
 <05f92a77-7587-4441-a252-01e4705a6892@linaro.org>
 <c03820b8-7745-4b8e-8e69-a37c872257f8@ilande.co.uk>
 <aUPAysAYqTPAfgzD@intel.com>
 <7d238d0d-df26-43fd-bfac-a7d94064d486@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d238d0d-df26-43fd-bfac-a7d94064d486@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

> fw_cfg is per guest, and there can only be once instance of it; so IMHO it
> makes sense to use the machine as parent. I should have posted a better
> commit description upfront, sorry.

You're welcome. It looks like most issues with the another series for
removing v2.6 & 2.7 pc have been resolved, so I'm trying to help clarify
this part to move things forward a bit.

Regards,
Zhao


