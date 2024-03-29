Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463CACD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 17:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqGGT-0004vC-UY; Fri, 29 Mar 2024 13:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alison.schofield@intel.com>)
 id 1rqGGS-0004v3-1K
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 13:43:40 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alison.schofield@intel.com>)
 id 1rqGGQ-00077Q-5R
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 13:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711734219; x=1743270219;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8+m0+9kTXHDmzApqownqXccYvxDRzk9RZtXpnSr/xMs=;
 b=Qz6ACu6I+Rx4Cgg47IoL44Kdd9s2UAmFykxqfDM/ArnVuujHy2DiFx5I
 wBbkfJSyNICxvMc682ZpMOad4cWu2z6a6xa4IrzfEBTYL1a0CDXJZSM8d
 uclqntIYMP2vo2RGg3PPLw91qZmtonSISca6xoCP/4s3fJz/GcvSA8LZt
 HDdHTtJk0sbW5bpViO1s9Zf3WfoSENxbrzR4G4jULx9huEQOvN/ghdQP0
 eh0F/BnqeWi3iO9TiJ0zj1eWzVFdQET5H9nOJRWhZnbwiN993WbMKdQCY
 qFnaGbiGyDSK3V/gfQOs2PRPMRkEq1ObJpfBcQQuXnAwgXEd/sv+SUyMv w==;
X-CSE-ConnectionGUID: DHq2yWmTRr+PhFfU/vEhHA==
X-CSE-MsgGUID: /SitHtWzTEGUv5nsqLKNoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="6824710"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="6824710"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 10:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; d="scan'208";a="48239761"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2)
 ([10.209.86.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 10:43:32 -0700
Date: Fri, 29 Mar 2024 10:43:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
 dave@stgolabs.net, ira.weiny@intel.com
Subject: Re: [RFC PATCH v2 0/6] cxl: add poison event handler
Message-ID: <Zgb9wjTIu1CE4S5r@aschofie-mobl2>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=alison.schofield@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Fri, Mar 29, 2024 at 02:36:08PM +0800, Shiyang Ruan wrote:
> Changes:
> RFCv1 -> RFCv2:
> 1. update commit message of PATCH 1
> 2. use memory_failure_queue() instead of MCE
> 3. also report poison in debugfs when injecting poison
> 4. correct DPA->HPA logic:
>      find memdev's endpoint decoder to find the region it belongs to
> 5. distinguish transaction_type of GMER, only handle POISON related
>      event for now
> 
> 
> Currently driver only traces cxl events, poison injection (for both vmem
> and pmem type) on cxl memdev is silent.  OS needs to be notified then it
> could handle poison range in time.  Per CXL spec, the device error event
> could be signaled through FW-First and OS-First methods.
> 
> So, add poison event handler in OS-First method:
>   - qemu:
>     - CXL device report POISON event to OS by MSI by sending GMER after
>       injecting a poison record
>   - CXL driver                                  <-- this patchset
>     a. parse the POISON event from GMER;
>     b. retrieve POISON list from memdev;
>     c. translate poisoned DPA to HPA;
>     d. enqueue poisoned PFN to memory_failure's work queue;

Hi,

Yesterday I posted code adding the HPAs to cxl_general_media & dram
events[1], so as I review this patchset today it's fresh in my mind.

Can we integrate this into the trace_ path directly:

1) On any GMER/poison, trigger a new poison list read

BTW - I'm not sure where to trigger that because we want to keep all
the locking in place and read by endpoints like is done now. It may
not be safe to sneak in a direct call to cxl_mem_get_poison()
as is done in this patch set.

2) Teach the poison list read trace event handler to call
memory_failure_queue().

Upon receipt of that new poison list, call memory_failture_queue()
on *any* poison in a mapped space. Is that OK?  Can we call
memory_failure_queue() on any and every poison report that is in
HPA space regardless of whether it first came to us through a GMER?
I'm actually wondering if that is going to be the next ask anyway -
ie report all poison.

I'll comment a bit more on individual patches.

--Alison

[1] https://lore.kernel.org/linux-cxl/cover.1711598777.git.alison.schofield@intel.com/

> 
> 
> Shiyang Ruan (6):
>   cxl/core: correct length of DPA field masks
>   cxl/core: introduce cxl_mem_report_poison()
>   cxl/core: add report option for cxl_mem_get_poison()
>   cxl/core: report poison when injecting from debugfs
>   cxl: add definition for transaction_type
>   cxl/core: add poison injection event handler
> 
>  drivers/cxl/core/mbox.c   | 126 +++++++++++++++++++++++++++++++++-----
>  drivers/cxl/core/memdev.c |   5 +-
>  drivers/cxl/core/region.c |   8 +--
>  drivers/cxl/core/trace.h  |   6 +-
>  drivers/cxl/cxlmem.h      |  13 ++--
>  include/linux/cxl-event.h |  17 ++++-
>  6 files changed, 144 insertions(+), 31 deletions(-)
> 
> -- 
> 2.34.1
> > 

