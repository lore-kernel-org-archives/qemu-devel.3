Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23295C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENXY-0006Jr-8r; Tue, 04 Jun 2024 02:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sENXS-0006JO-OJ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:20:56 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sENXN-0006OB-BB
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717482050; x=1749018050;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jkmF1Sdu7dprfyTrmrSTK2ZzrkvZl905OiDhjvu6h3M=;
 b=TgLvhYKwwL2kET6UW3g4awTPftxHIqc8aKRQd299PYo1nOHUNw8x3TSZ
 Po1+HPtF/OhYz5LNk5wsVjPQI62K73ivl4f22df1dmGM9Jyc72TJqUuHY
 gYWYhAxHsNO+0sMXptGYJWcBfW22VIN+Io51r/L7KxHvbjfSnifwiY8ZM
 3+KU9EkyVAWr3GcADsa+RJOCVLOYaxJJvyvuJ8Y19YlhqMT3G33jQtYQV
 G4r4KOqWcL8tBbfXa17jkUYAMV+cCVnaGIjDmq3gzJlyrNFhzr7YONcgg
 vsc6t56Q7aaOTjvJ+L2hyjPXJtajprduFAIY1KWO8BjoP/tEnxwm0zHeU g==;
X-CSE-ConnectionGUID: O/mF8BURRfG04ySjT5Ab8g==
X-CSE-MsgGUID: IXfiDO5/TPuiI2L0k1+1qA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24581519"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="24581519"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 23:20:47 -0700
X-CSE-ConnectionGUID: +Id/oB9DTsqGH9e6xkakaQ==
X-CSE-MsgGUID: tHlThJAoTTCeoGqVqirk8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37758601"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 03 Jun 2024 23:20:44 -0700
Date: Tue, 4 Jun 2024 14:36:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/core: Rename CpuTopology to CPUTopology
Message-ID: <Zl612v8IK+RyufE+@intel.com>
References: <20240527131837.2630961-1-zhao1.liu@intel.com>
 <87sexus0m0.fsf@pond.sub.org> <Zl6U5n+QeEAiCBBv@intel.com>
 <87r0ddcm38.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0ddcm38.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 04, 2024 at 07:29:15AM +0200, Markus Armbruster wrote:
> Date: Tue, 04 Jun 2024 07:29:15 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH] hw/core: Rename CpuTopology to CPUTopology
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > On Mon, Jun 03, 2024 at 01:54:15PM +0200, Markus Armbruster wrote:
> >> Date: Mon, 03 Jun 2024 13:54:15 +0200
> >> From: Markus Armbruster <armbru@redhat.com>
> >> Subject: Re: [PATCH] hw/core: Rename CpuTopology to CPUTopology
> >> 
> >> Zhao Liu <zhao1.liu@intel.com> writes:
> >> 
> >> > Use CPUTopology to honor the generic style of CPU capitalization
> >> > abbreviations.
> >> >
> >> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> >> 
> >> Is CPUFoo really more common than CpuFoo?  It isn't in the qapi
> >> schema...
> >
> > Hi Markus, do you think this style needs to be standardized?
> >
> > All-caps cases, like the widely used CPUState.
> >
> > And the common structures declared in include/qemu/typedefs.h, are all
> > using CPU, not Cpu...
> >
> > If you feel this is necessary, I'd be happy to help more places change
> > their names to standardize their style...
> 
> The situation is unfortunate[*].  The renaming cure could be worse than
> the disease, though.
> 
> In a situation like this, settling for local consistency is often the
> least bad.  machine.json is locally consistent: it consistently uses
> CpuFoo.
> 
> 
> [*] We suck at systematic, disciplined naming.

I see, by local consistency principle, my another patch (adding topology
enumeration in machine.json) should use Cpu...

The CpuTopology that this patch modifies is located in include/hw/boards.h,
where that looks as if this file prefers to use CPUs (defining the
CPUArchIdList and CPUArchId). And there's also another case for all-caps,
SMPCompatProps (using SMP not Smp). So I feel like this patch change
still makes sense... Sorry if I'm being a bit obsessive.

The most confusing thing in include/hw/boards.h is this structure:

typedef struct CPUArchId {
    ...
    CpuInstanceProperties props;
    CPUState *cpu;
    ...
} CPUArchId;

CPU and Cpu are mixed together, but this is also explained by the local
consistency principle, since the CpuInstanceProperties belong to
machine.json. ;-)


