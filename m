Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01305C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWwBj-0002CX-V8; Thu, 25 Jul 2024 06:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sWwBi-0002A1-64; Thu, 25 Jul 2024 06:59:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sWwBf-0003tU-SG; Thu, 25 Jul 2024 06:59:09 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WV79d5jBwz6K9Gq;
 Thu, 25 Jul 2024 18:56:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id B2103140594;
 Thu, 25 Jul 2024 18:59:03 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 25 Jul
 2024 11:59:03 +0100
Date: Thu, 25 Jul 2024 11:59:02 +0100
To: Markus Armbruster <armbru@redhat.com>
CC: Zhao Liu <zhao1.liu@intel.com>, <berrange@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Michael S.Tsirkin " <mst@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>, "Marcelo
 Tosatti" <mtosatti@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "Sia Jee
 Heng" <jeeheng.sia@starfivetech.com>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>, <qemu-riscv@nongnu.org>, <qemu-arm@nongnu.org>,
 "Zhenyu Wang" <zhenyu.z.wang@intel.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 2/8] qapi/qom: Introduce smp-cache object
Message-ID: <20240725115902.000037e4@Huawei.com>
In-Reply-To: <20240725115059.000016c5@Huawei.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-3-zhao1.liu@intel.com>
 <87wmld361y.fsf@pond.sub.org> <Zp5tBHBoeXZy44ys@intel.com>
 <87h6cfowei.fsf@pond.sub.org> <ZqEV8uErCn+QkOw8@intel.com>
 <871q3hua56.fsf@pond.sub.org> <20240725115059.000016c5@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 25 Jul 2024 11:50:59 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

Resending as this bounced due (I think) to an address typo.

> Hi Markus, Zhao Liu
> 
> From the ARM server side this is something I want to see as well.
> So I can comment on why we care.
> 
> > >> This series adds a way to configure caches.
> > >> 
> > >> Structure of the configuration data: a list
> > >> 
> > >>     [{"name": N, "topo": T}, ...]
> > >> 
> > >> where N can be "l1d", "l1i", "l2", or "l3",
> > >>   and T can be "invalid", "thread", "core", "module", "cluster",
> > >>                "die", "socket", "book", "drawer", or "default".
> > >> 
> > >> What's the use case?  The commit messages don't tell.    
> > >
> > > i386 has the default cache topology model: l1 per core/l2 per core/l3
> > > per die.
> > >
> > > Cache topology affects scheduler performance, e.g., kernel's cluster
> > > scheduling.
> > >
> > > Of course I can hardcode some cache topology model in the specific cpu
> > > model that corresponds to the actual hardware, but for -cpu host/max,
> > > the default i386 cache topology model has no flexibility, and the
> > > host-cpu-cache option doesn't have enough fine-grained control over the
> > > cache topology.
> > >
> > > So I want to provide a way to allow user create more fleasible cache
> > > topology. Just like cpu topology.    
> > 
> > 
> > So the use case is exposing a configurable cache topology to the guest
> > in order to increase performance.  Performance can increase when the
> > configured virtual topology is closer to the physical topology than a
> > default topology would be.  This can be the case with CPU host or max.
> > 
> > Correct?  
> 
> That is definitely why we want it on arm64 where this info fills in
> the topology we can't get from the CPU registers.
> (we should have patches on top of this to send out shortly).
> 
> As a side note we also need this for MPAM emulation for TCG
> (any maybe eventually paravirtualized MPAM) as this is needed
> to build the right PPTT to describe the caches which we then
> query to figure out association of MPAM controls with particularly
> caches.
> 
> Size configuration is something we'll need down the line (presenting
> only part of an L3 may make sense if it's shared by multiple VMs
> or partitioned with MPAM) but that's a future question.
> 
> 
> >   
> > >> Why does that use case make no sense without SMP?    
> > >
> > > As the example I mentioned, for Intel hyrbid architecture, P cores has
> > > l2 per core and E cores has l2 per module. Then either setting the l2
> > > topology level as core nor module, can emulate the real case.
> > >
> > > Even considering the more extreme case of Intel 14th MTL CPU, where
> > > some E cores have L3 and some don't even have L3. As well as the last
> > > time you and Daniel mentioned that in the future we could consider
> > > covering more cache properties such as cache size. But the l3 size can
> > > be different in the same system, like AMD's x3D technology. So
> > > generally configuring properties for @name in a list can't take into
> > > account the differences of heterogeneous caches with the same @name.
> > >
> > > Hope my poor english explains the problem well. :-)    
> > 
> > I think I understand why you want to configure caches.  My question was
> > about the connection to SMP.
> > 
> > Say we run a guest with a single core, no SMP.  Could configuring caches
> > still be useful then?  
> 
> Probably not useful to configure topology (sizes are a separate question)
> - any sensible default should be fine.
> 
> Jonathan
> 
> 


