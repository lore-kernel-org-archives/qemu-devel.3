Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9EBC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 04:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4uxV-0006AH-At; Thu, 09 May 2024 00:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s4uxT-00069Q-0O
 for qemu-devel@nongnu.org; Thu, 09 May 2024 00:00:39 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s4uxP-0000SP-RN
 for qemu-devel@nongnu.org; Thu, 09 May 2024 00:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715227235; x=1746763235;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=H//acHjEYG8ZxUsVv4JnSHE+OrP2om8DNKMSeTyc55Y=;
 b=M2qFb2q4n1aL8UhUEmroPiysgRXXOkiwmbOT/k/KozP5ANoQNpYw1N97
 IZ87QA8Jj0xGj4+ndNA8cTdUtmYN68m4N+7q7idCVcZijwd6f1e21GKVb
 L9bvLCJ4zKK/OorX6JIVBnpvbyR9JnrQndb+xLyeiSUaN7zJnqaB5F5qu
 YbzOFnkN/zQSrubRkXEXOi7GQiGMdggd9u9yiwnmPfF+6ivopGEuK5Nk5
 lO2oLjchqaqCLvwadX5IDf8ytZIMJPdGBdD+y5ewCFUoEYzULIAFTR0gJ
 /vyG7jS1mTsDSollqrF6KpRRnPh8IHiWOb/AQ+VN6bykJRNa9YcsXOutB g==;
X-CSE-ConnectionGUID: Iqia1Ez4TV2WS1IDH9G/pA==
X-CSE-MsgGUID: Iorb5u6QS8KsBDo/h2tkPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14919187"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; d="scan'208";a="14919187"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 21:00:30 -0700
X-CSE-ConnectionGUID: EWtto/BuQBuYKK3TRMT8zQ==
X-CSE-MsgGUID: mQD+1FiMSfe7+6HULu1rmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; d="scan'208";a="66539391"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 08 May 2024 21:00:29 -0700
Date: Thu, 9 May 2024 12:14:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable timestamp
 as WARN
Message-ID: <ZjxNsUJGsm73a+eJ@intel.com>
References: <20240508043229.3433128-1-zhao1.liu@intel.com>
 <210757c3-c949-4dd1-bd7d-c33db3aa390e@linaro.org>
 <ZjuEOPPbGaZgY6gG@intel.com>
 <3cf22fc2-222d-40a1-b27f-fda72d4b2be5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cf22fc2-222d-40a1-b27f-fda72d4b2be5@linaro.org>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, May 08, 2024 at 04:23:00PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed, 8 May 2024 16:23:00 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable
>  timestamp as WARN
> 
> On 8/5/24 15:55, Zhao Liu wrote:
> > Hi Philippe,
> > 
> > On Wed, May 08, 2024 at 03:09:39PM +0200, Philippe Mathieu-Daudé wrote:
> > > Date: Wed, 8 May 2024 15:09:39 +0200
> > > From: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable
> > >   timestamp as WARN
> > > 
> > > On 8/5/24 06:32, Zhao Liu wrote:
> > > > In some trace log, there're unstable timestamp breaking temporal
> > > > ordering of trace records. For example:
> > > > 
> > > > kvm_run_exit -0.015 pid=3289596 cpu_index=0x0 reason=0x6
> > > > kvm_vm_ioctl -0.020 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> > > > kvm_vm_ioctl -0.021 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> > > > 
> > > > Negative delta intervals tend to get drowned in the massive trace logs,
> > > > and an unstable timestamp can corrupt the calculation of intervals
> > > > between two events adjacent to it.
> > > > 
> > > > Therefore, mark the outputs with unstable timestamps as WARN like:
> > > > 
> > > > WARN: skip unstable timestamp: kvm_run_exit cur(8497404907761146)-pre(8497404907761161) pid=3289596 cpu_index=0x0 reason=0x6
> > > > WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908603653)-pre(8497404908603673) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> > > > WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908625787)-pre(8497404908625808) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> > > > 
> > > > This would help to identify unusual events.
> > > > 
> > > > And skip them without updating Formatter2.last_timestamp_ns to avoid
> > > > time back.
> > > 
> > > Can't we reorder them instead?
> > 
> > I think so...IIUC, when the current event with "wrong" timestamp is
> > detected, its previous events records have already been output and
> > cannot be reordered.
> 
> Well, this certainly need rework to cleverly handle out of sync
> events, reordering them to display them correctly.
> 
> Skipping events really sounds a bad idea to me. Even more out
> of sync ones.
> 
> Some simple approach could be to queue up to N events, then sort them
> and unqueue N/2, while processing all events.

Reordering might be possible, but as Stefan replied, some psitive value
might also be problematic too. 

Maybe my negative value check is not enough in itself...

Thanks,
Zhao


