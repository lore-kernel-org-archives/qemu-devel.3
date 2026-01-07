Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8CBCF6BE3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdK2v-0003cq-N9; Tue, 06 Jan 2026 22:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdK2t-0003ci-BR
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:17:15 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdK2p-0007TQ-Op
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767755832; x=1799291832;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=I+JhpEp77DDEuePeGuwoQJyUL7I5s0qj1VNr0cVv9k4=;
 b=QiCF6wmfEJn0xqwMM0HKfO7xN0aDv3/geK6KqDY17XR8hRr+O08C/pHS
 7iT5ZqGdy2VjgqT5JxB8IX9XOfhrDXiCXGgFMy4B6XjPw7T+5mvtQVcgk
 YjgkNmjnxGSvS+BoEQIUArbo5zaHziIb/wU2owYyqO4P8Hk0mxm3rXz3m
 9yqMc8sipT74jeVWh7lWM3vCU/NHbHdOJpNvGZmZIeDJNh0QSGD65EA7l
 x38lCsN90gp+qMgk6l6RP30NW6WQ3uwoSp0kgUfIS/tOUtiINrBqqzQmb
 gYNtZLezDM40pMCbfINGVHaUXiENN6XclvBlgRnvMOJZhnH3Pwsz4v2ii w==;
X-CSE-ConnectionGUID: cQ+Z1aW8SF6n2ITn7BqxVg==
X-CSE-MsgGUID: DhSM0r0wTz+ANZhSeHJNDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69024695"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; d="scan'208";a="69024695"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2026 19:17:04 -0800
X-CSE-ConnectionGUID: x8ojevQeRlqD8WvpwRMMKA==
X-CSE-MsgGUID: GeJSrDnyRh6QdnLhQs7j4A==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 06 Jan 2026 19:17:02 -0800
Date: Wed, 7 Jan 2026 11:42:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Xudong Hao <xudong.hao@intel.com>, Yu Chen <yu.c.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 10/10] dosc/cpu-models-x86: Add documentation for
 DiamondRapids
Message-ID: <aV3WI44CYzWECDHh@intel.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
 <20251120071030.961230-11-zhao1.liu@intel.com>
 <aVzwGBeRaNWC3-s7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVzwGBeRaNWC3-s7@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

Hi Daniel,

> > +``DiamondRapids``
> > +    Intel Xeon Processor.
> > +
> > +    Diamond Rapids product has a topology which differs from previous Xeon
> > +    products. It does not support SMT, but instead features a dual core
> > +    module (DCM) architecture. It also has core building blocks (CBB - die
> > +    level in CPU topology). The cache hierarchy is organized as follows:
> > +    L1 i/d cache is per thread, L2 cache is per DCM, and L3 cache is per
> > +    CBB. This cache topology can be emulated for DiamondRapids CPU model
> > +    using the smp-cache configuration as shown below:
> 
> Can I request a slight rewording to simplify this:

Yes, of course.

>   ``DiamondRapids``
>      Intel Xeon Processor (DiamondRapids, 2025). This does not include SMT
>      but allows the module and die topology levels. The cache hierarchy is
>      L1 i/d cache per thread, L2 cache per module, and L3 cache per die,
>      which can be emulated using using the smp-cache option:

Thanks for your words!

In the previous text, I also aimed to clarify the relationship between
DCM/CBB and the QEMU topology hierarchy, as these terms appear frequently
in DMR-related materials. Therefore, I thought a brief explanation of
DCM/CBB may be helpful:

This does not include SMT but allows the module (dual core module - DCM)
and die (core building block - CBB) topology levels.

What do you think?


>      Example:
> 
>         ::
> 
>             -machine smp-cache.0.cache=l1d,smp-cache.0.topology=thread,\
>                      smp-cache.1.cache=l1i,smp-cache.1.topology=thread,\
>                      smp-cache.2.cache=l2,smp-cache.2.topology=module,\
>                      smp-cache.3.cache=l3,smp-cache.3.topology=die,\
>                      ...

Thanks,
Zhao


