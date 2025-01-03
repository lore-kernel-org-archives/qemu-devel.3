Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D03E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 08:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTciK-0001MF-UV; Fri, 03 Jan 2025 03:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tTciI-0001Lm-O3
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:07:23 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tTciG-0004X5-H7
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735891640; x=1767427640;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=V9eWh/15VXEA7gCguj+BFRdYMLZ5oi0QEKqx0Wixdm0=;
 b=QVFRuxP/ojcKybDCTiEWBrF5422wHJjndmAgUAYwumcFVGQGbIgyisje
 /KM3mJbjDPtcfroVlHfgRSzVwaaayz4AxPncS9wW6AvGFuApPLSjoE2CS
 rpeyxAkjxEPTgJq5mnEeMrOdGd015qw4SAQcbKNATbI/htjRxHvDzvMcW
 zR3pfqWcix30zcfNkHp/gkcK0EjSTFkSnWWSCLm62sLMhh0+J6b29Zpt+
 XjiGY/pdwrreiMQwDR+p1c/P/gjcYmG2CkTQEn+oY074QnTYKliz80KHq
 VPoiRDYR8TAiljey4tEEsiUiQImoSCTNA/NQMxYTof5V4AI0J60oGa2qU g==;
X-CSE-ConnectionGUID: V5fLzTBCQ/mO6KlfdxoFlA==
X-CSE-MsgGUID: 4P36/32hTB2sg27dhqZAhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="47127275"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; d="scan'208";a="47127275"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2025 00:07:16 -0800
X-CSE-ConnectionGUID: GVxnOHgASdqfBFLYpSpnkQ==
X-CSE-MsgGUID: IoJpPDfHRa+7zTghEf19Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; d="scan'208";a="106708690"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 03 Jan 2025 00:07:13 -0800
Date: Fri, 3 Jan 2025 16:25:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: Rob Herring <robh@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v6 0/4] i386: Support SMP Cache Topology
Message-ID: <Z3efFsigJ6SxhqMf@intel.com>
References: <20241219083237.265419-1-zhao1.liu@intel.com>
 <44212226-3692-488b-8694-935bd5c3a333@redhat.com>
 <Z2t2DuMBYb2mioB0@intel.com> <20250102145708.0000354f@huawei.com>
 <CAL_JsqKeA4dSwO40VgARVAiVM=w1PU8Go8GJYv4v8Wri64UFbw@mail.gmail.com>
 <20250102180141.00000647@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250102180141.00000647@huawei.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

On Thu, Jan 02, 2025 at 06:01:41PM +0000, Alireza Sanaee wrote:
> Date: Thu, 2 Jan 2025 18:01:41 +0000
> From: Alireza Sanaee <alireza.sanaee@huawei.com>
> Subject: Re: [PATCH v6 0/4] i386: Support SMP Cache Topology
> X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
> 
> On Thu, 2 Jan 2025 11:09:51 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Thu, Jan 2, 2025 at 8:57 AM Alireza Sanaee
> > <alireza.sanaee@huawei.com> wrote:
> > >
> > > On Wed, 25 Dec 2024 11:03:42 +0800
> > > Zhao Liu <zhao1.liu@intel.com> wrote:
> > >  
> > > > > > About smp-cache
> > > > > > ===============
> > > > > >
> > > > > > The API design has been discussed heavily in [3].
> > > > > >
> > > > > > Now, smp-cache is implemented as a array integrated in
> > > > > > -machine. Though -machine currently can't support JSON
> > > > > > format, this is the one of the directions of future.
> > > > > >
> > > > > > An example is as follows:
> > > > > >
> > > > > > smp_cache=smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=module,smp-cache.3.cache=l3,smp-cache.3.topology=die
> > > > > >
> > > > > > "cache" specifies the cache that the properties will be
> > > > > > applied on. This field is the combination of cache level and
> > > > > > cache type. Now it supports "l1d" (L1 data cache), "l1i" (L1
> > > > > > instruction cache), "l2" (L2 unified cache) and "l3" (L3
> > > > > > unified cache).
> > > > > >
> > > > > > "topology" field accepts CPU topology levels including
> > > > > > "thread", "core", "module", "cluster", "die", "socket",
> > > > > > "book", "drawer" and a special value "default".  
> > > > >
> > > > > Looks good; just one thing, does "thread" make sense?  I think
> > > > > that it's almost by definition that threads within a core share
> > > > > all caches, but maybe I'm missing some hardware configurations.
> > > > >  
> > > >
> > > > Hi Paolo, merry Christmas. Yes, AFAIK, there's no hardware has
> > > > thread level cache.  
> > >
> > > Hi Zhao and Paolo,
> > >
> > > While the example looks OK to me, and makes sense. But would be
> > > curious to know more scenarios where I can legitimately see benefit
> > > there.
> > >
> > > I am wrestling with this point on ARM too. If I were to
> > > have device trees describing caches in a way that threads get their
> > > own private caches then this would not be possible to be
> > > described via device tree due to spec limitations (+CCed Rob) if I
> > > understood correctly.  
> > 
> > You asked me for the opposite though, and I described how you can
> > share the cache. If you want a cache per thread, then you probably
> > want a node per thread.
> > 
> > Rob
> > 
> 
> Hi Rob,
> 
> That's right, I made the mistake in my prior message, and you recalled
> correctly. I wanted shared caches between two threads, though I have
> missed your answer before, just found it.
> 

Thank you all!

Alireza, do you know how to configure arm node through QEMU options?

However, IIUC, arm needs more effort to configure cache per thread (by
configuring node topology)...In that case, since no one has explicitly
requested the need for cache per thread, I can disable cache per thread
for now. I can return an error for this scenario during the general
smp-cache option parsing (in the future, if there is a real need, it can
be easily re-enabled).

Will drop cache per thread in the next version.

Thanks,
Zhao


