Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977DFC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7EFQ-0002tt-Qn; Tue, 22 Apr 2025 10:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7EFJ-0002p7-H2
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:05:09 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7EFG-0007M4-6O
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745330706; x=1776866706;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eD3/9iW0ld81eZPY/Axle2N7wEZSpRcFe9aQKrt1bj0=;
 b=Z6G184j6I5EEPXofmwA6itGIXz64rIi9tUOh9GkaRGdp3moaGBGHFLvm
 wP7VDZpUElvOcnC71Gb6McNLK9DNsMTG55MQkJoBsDFuEZQt3j2+Cm5EQ
 khYPzLbsBNxjqyqSBEX89wAhmnOim17AIGw7AqzCcP4dJPBy6o6uQ+pZS
 YNEU9jsb3evOwI1/lVrhCZB0fEkn9tUansTABQs01pRMdT33E2yq7IesF
 1aaxGlKQt1IUdu2qSKGjtSd6Fc6GcL++mrqfctJj2Wv9wZtmJ0KoCClaJ
 cltYjXIq+0e8skqouMTuu50gIrrWr5mV7uD39iti1hLeD4cTi/rN7Dxv+ Q==;
X-CSE-ConnectionGUID: bY0Weo1eSA+VNkw5S4bPwQ==
X-CSE-MsgGUID: bGXD8WzSRS2PYPt14+TeIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50719801"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="50719801"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 07:05:02 -0700
X-CSE-ConnectionGUID: m3xQIYq/T5S5o/blpmfaAQ==
X-CSE-MsgGUID: mbixgD6VSnSBpriUInJfxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="132976086"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 22 Apr 2025 07:05:00 -0700
Date: Tue, 22 Apr 2025 22:25:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 02/55] i386: Introduce tdx-guest object
Message-ID: <aAem8k1hY3P8Nchg@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-3-xiaoyao.li@intel.com>
 <aAIYjpetyP9LKW6L@intel.com> <aAdSMExEAy45NIeB@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAdSMExEAy45NIeB@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

> > > index 000000000000..f3b725336161
> > > --- /dev/null
> > > +++ b/target/i386/kvm/tdx.h
> > > @@ -0,0 +1,21 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +
> > > +#ifndef QEMU_I386_TDX_H
> > > +#define QEMU_I386_TDX_H
> > 
> > I386_TDX_H is enough... the QEMU prefix is rarely seen in the whole
> > project.
> 
> IMHO having a QEMU_ prefix here is "best practice", so don't remove it.
> 
> That lots of other QEMU code doesn't follow best practice is unfortunate.

Thanks, now I see!


