Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD240C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 04:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sELLf-0002a6-Lr; Tue, 04 Jun 2024 00:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sELLb-0002ZW-DO
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 00:00:33 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sELLY-0007tW-AM
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 00:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717473628; x=1749009628;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=U9gNdv+NByTLimtreMfD1AOf3Ii9CqGhRkRMOnayw8g=;
 b=RFPyVetrBqTOEXy9a6rdQit7H1fXrVDXHsb172y2vhd2ISZzFFAnS9Y0
 j6lSiOV058cwJiSAhcLmruPnVv3/Np91AKmof7GFW8Lg1eCSWOY6/YGUs
 2+MB6feswvSvjvqUWF9l4G+JzHuSiPnC3H1kMEomhVB7E87GiSV8UEQwP
 JQejRhdySzhwPCG5CyujfSZvekjraMHQykoSEoKsJRWSIXWucJU5iW5wK
 pQMU++zBzq4J9v8vktiZWRTw1TYQ95OlHrF6gq4d3vvcNtsRH/mLnXMvq
 lqo4CUB8KawpsxXP09p03SdadaIAO+h6in+Gu8fEehURUDeiIUO3qF8r9 g==;
X-CSE-ConnectionGUID: g3AYTFjQT/S9RQuns5ASEw==
X-CSE-MsgGUID: b1AjfUYvS9CJKORoaLZ/zg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14182104"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="14182104"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 21:00:10 -0700
X-CSE-ConnectionGUID: 70+xPaqqQqmNVaEeB6JbEg==
X-CSE-MsgGUID: 5Jmt97LJRdyelzj8pWF3EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="36969682"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 03 Jun 2024 21:00:08 -0700
Date: Tue, 4 Jun 2024 12:15:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/core: Rename CpuTopology to CPUTopology
Message-ID: <Zl6U5n+QeEAiCBBv@intel.com>
References: <20240527131837.2630961-1-zhao1.liu@intel.com>
 <87sexus0m0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sexus0m0.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Mon, Jun 03, 2024 at 01:54:15PM +0200, Markus Armbruster wrote:
> Date: Mon, 03 Jun 2024 13:54:15 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH] hw/core: Rename CpuTopology to CPUTopology
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Use CPUTopology to honor the generic style of CPU capitalization
> > abbreviations.
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Is CPUFoo really more common than CpuFoo?  It isn't in the qapi
> schema...

Hi Markus, do you think this style needs to be standardized?

All-caps cases, like the widely used CPUState.

And the common structures declared in include/qemu/typedefs.h, are all
using CPU, not Cpu...

If you feel this is necessary, I'd be happy to help more places change
their names to standardize their style...


