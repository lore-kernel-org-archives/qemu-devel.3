Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083C3D13C0D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 13:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkMkR-0006R2-Mn; Mon, 26 Jan 2026 08:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vkMkQ-0006Qk-Ph
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 08:35:18 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vkMkO-0008OH-Lj
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 08:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769434516; x=1800970516;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jCh48mht7miehsKRmTJAoQbwrpyOtSVhceU919kMXBs=;
 b=Zy+gOAwl4epZEXjMF+f1NME7CvhBf2N65PiSPWdVpUj8l9LIUGo9ns6D
 yuzCdErdyp58CHSEwVYa1B2ey+GHqmq6nKkItkIsKl7eT8sj37/uMSn+o
 JEPumj3gdIpANOC7jzaelj5CsPGZC/gQWt0SnhHSHRh2fwiFIzwva3Cxr
 inna0dioHUNLk63zMxaR4Ypq2KdL564X66DzfvqQoQIMrsBFvq6y1SgZH
 Q67POxVvO5NuKgdzcOWHmMqM/o/ReObSo+Klr1cg57RJCpYS6IcA61XjD
 ecQelYdDgb4gmNU4a144/JOto8zNks4u0E+KCPKU/Rd3rDSLhuLNVyCvE A==;
X-CSE-ConnectionGUID: g3DqikIlSQiZFe7ItSpnDA==
X-CSE-MsgGUID: qOqiOpxpSkSyYo7n3WkjzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="81244079"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="81244079"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 05:35:12 -0800
X-CSE-ConnectionGUID: TMcHVgY+Rt2viTKZn9/8Yg==
X-CSE-MsgGUID: ad4znUOoRqKk/up1fxHiHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="212538960"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 26 Jan 2026 05:35:11 -0800
Date: Mon, 26 Jan 2026 22:00:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ++/vQ==?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Xudong Hao <xudong.hao@intel.com>, Yu Chen <yu.c.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 10/10] dosc/cpu-models-x86: Add documentation for
 DiamondRapids
Message-ID: <aXdzjevRI51J43xy@intel.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
 <20251120071030.961230-11-zhao1.liu@intel.com>
 <aVzwGBeRaNWC3-s7@redhat.com> <aV3WI44CYzWECDHh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV3WI44CYzWECDHh@intel.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel, just a gentle poke.

Thanks,
Zhao

On Wed, Jan 07, 2026 at 11:42:27AM +0800, Zhao Liu wrote:
> Date: Wed, 7 Jan 2026 11:42:27 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH 10/10] dosc/cpu-models-x86: Add documentation for
>  DiamondRapids
> 
> Hi Daniel,
> 
> > > +``DiamondRapids``
> > > +    Intel Xeon Processor.
> > > +
> > > +    Diamond Rapids product has a topology which differs from previous Xeon
> > > +    products. It does not support SMT, but instead features a dual core
> > > +    module (DCM) architecture. It also has core building blocks (CBB - die
> > > +    level in CPU topology). The cache hierarchy is organized as follows:
> > > +    L1 i/d cache is per thread, L2 cache is per DCM, and L3 cache is per
> > > +    CBB. This cache topology can be emulated for DiamondRapids CPU model
> > > +    using the smp-cache configuration as shown below:
> > 
> > Can I request a slight rewording to simplify this:
> 
> Yes, of course.
> 
> >   ``DiamondRapids``
> >      Intel Xeon Processor (DiamondRapids, 2025). This does not include SMT
> >      but allows the module and die topology levels. The cache hierarchy is
> >      L1 i/d cache per thread, L2 cache per module, and L3 cache per die,
> >      which can be emulated using using the smp-cache option:
> 
> Thanks for your words!
> 
> In the previous text, I also aimed to clarify the relationship between
> DCM/CBB and the QEMU topology hierarchy, as these terms appear frequently
> in DMR-related materials. Therefore, I thought a brief explanation of
> DCM/CBB may be helpful:
> 
> This does not include SMT but allows the module (dual core module - DCM)
> and die (core building block - CBB) topology levels.
> 
> What do you think?
> 
> 
> >      Example:
> > 
> >         ::
> > 
> >             -machine smp-cache.0.cache=l1d,smp-cache.0.topology=thread,\
> >                      smp-cache.1.cache=l1i,smp-cache.1.topology=thread,\
> >                      smp-cache.2.cache=l2,smp-cache.2.topology=module,\
> >                      smp-cache.3.cache=l3,smp-cache.3.topology=die,\
> >                      ...
> 
> Thanks,
> Zhao
> 

