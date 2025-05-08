Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE98CC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 08:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCwqo-0007Zi-MA; Thu, 08 May 2025 04:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCwqm-0007Yc-HR
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:43:28 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCwqk-0001WY-LY
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746693807; x=1778229807;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=47N7/5hbDRSZqNUgkGm7luIjBLHEUhSBxhLFH2Pvrrc=;
 b=Xl5w03ki6MwqCsFmNfN6eSBE9o6HqyStDJvcVwUGchkSHtqDEMuU+Ld1
 +GVRPpZCa2Wd/RJFcbRPCI2eIS1/jyIp5tktUXJzS6mOS2n/VWj9IIrQA
 oXYhy36Eg7aiO84gVXgFQ0rjCv5eGjgpaNVeghMSKOTAiqBkNm8lfQNd/
 qMB7wB/vRI2mP4+0ELbkfAhErnfl9u2ShDzqxZD096QgAZ7wqjhDQopos
 LbhMQzs6Sg6uVSwaJT2eSB5XKR81CLm4VEQqFm72iO/GZXbMJr+A1viiK
 lsKRU9Rdkwkps8kjuuO3Q79Vxy+5Xl2OApa0Wb1dGZOKATn+L6xbutK9p A==;
X-CSE-ConnectionGUID: II0/v5EcQK295W7osICl4g==
X-CSE-MsgGUID: NO6nBKTJR2qoM2ZSCtWbLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="65877967"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="65877967"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 01:43:23 -0700
X-CSE-ConnectionGUID: vySyN8tqQ/6y6dWgu0pLZQ==
X-CSE-MsgGUID: 52j0XdXJQGqvLtWbydndlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="173425416"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 08 May 2025 01:43:19 -0700
Date: Thu, 8 May 2025 17:04:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 yeeli@zhaoxin.com, cobechen@zhaoxin.com, ewanhai@zhaoxin.com,
 MaryFeng@zhaoxin.com, Runaguo@zhaoxin.com, Xanderchen@zhaoxin.com,
 Alansong@zhaoxin.com, qemu-devel@nongnu.org
Subject: Re: [Bug] QEMU TCG warnings after commit c6bd2dd63420 - HTT /
 CMP_LEG bits
Message-ID: <aBxzlUFqYj1Ltc+4@intel.com>
References: <c111d9f9-2914-4b41-811a-b3a9ad0d83a9@zhaoxin.com>
 <006111a2-8406-46ed-a6bd-71d0c68edf4b@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <006111a2-8406-46ed-a6bd-71d0c68edf4b@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

> > [3] My colleague Alan noticed what appears to be a related problem: if
> > we launch a guest with '-cpu <model>,-ht --enable-kvm', which means
> > explicitly removing the ht flag, but the guest still reports HT(cat
> > /proc/cpuinfo in linux guest) enabled. In other words, under KVM the ht
> > bit seems to be forced on even when the user tries to disable it.
> 
> XiaoYao reminded me that issue [3] stems from a different patch. Please
> ignore it for now—I'll start a separate thread to discuss that one
> independently.

I haven't found any other thread :-).

By the way, just curious, in what cases do you need to disbale the HT
flag? "-smp 4" means 4 cores with 1 thread per core, and is it not
enough?

As for the “-ht” behavior, I'm also unsure whether this should be fixed
or not - one possible consideration is whether “-ht” would be useful.


