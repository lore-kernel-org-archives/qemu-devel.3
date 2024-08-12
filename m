Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AC9C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 09:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdR37-0003jZ-Fb; Mon, 12 Aug 2024 05:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sdR34-0003iI-Mr; Mon, 12 Aug 2024 05:09:06 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sdR31-0000ej-DT; Mon, 12 Aug 2024 05:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723453744; x=1754989744;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9upHtUme4hJXCWHnm4fE6plmVolSyA9aoEU22vIwsLA=;
 b=bhg01RRTH/3Sd/CSE2biBfysXG3HfHw+jceMVUA/aKezTMbXb0DrOTXW
 SelpwI/zKLlR+h1/rKXfXapvGGZ6HVyNNvD9J0iO4oLz5Wmo6HvbUL+VK
 IUQb8NA/UNI9KQEzjEOF8DQu9Qop/XnHOMV5qyvg91rK51mRZKYjL/lxJ
 Kp02GZSpSB5Zqrq2SH2aIFgTF1ylZvM+rXOqVoDxTzeHEuvlvAStkR31s
 YX5uAvmgREeFK5ShTBSeSBuIOLTBM/j6tsi8cy4wKZPQtLxyJiiTMQq12
 JdNCT0dK13RZx9imytK/tXEL3+qbc+bln1yla13wNeg56BYCzqpMK39Ny w==;
X-CSE-ConnectionGUID: 3syRZDzXQhSFB+Y1zoOdrQ==
X-CSE-MsgGUID: YVnssIF5THeYz4aptBe1SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="12961293"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; d="scan'208";a="12961293"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2024 02:08:58 -0700
X-CSE-ConnectionGUID: WVglJYQSR/u4QsfjIWt7qA==
X-CSE-MsgGUID: z5WsMxXFRmm+3kttHZfn7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; d="scan'208";a="88855982"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 12 Aug 2024 02:08:53 -0700
Date: Mon, 12 Aug 2024 17:24:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache object
Message-ID: <ZrnU25wxuqgST7x1@intel.com>
References: <20240704031603.1744546-9-zhao1.liu@intel.com>
 <87r0bl35ug.fsf@pond.sub.org> <Zp5vxtXWDeHAdPok@intel.com>
 <87bk2nnev2.fsf@pond.sub.org> <ZqEN1kZaQcuY4UPG@intel.com>
 <87le1psuv3.fsf@pond.sub.org> <ZqtXP9MViOlyhEsu@intel.com>
 <87mslweb38.fsf@pond.sub.org> <ZqyRik4UHHz3xaKl@intel.com>
 <8734ndj33j.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734ndj33j.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

Hi Markus,

On Fri, Aug 09, 2024 at 02:24:48PM +0200, Markus Armbruster wrote:
> Date: Fri, 09 Aug 2024 14:24:48 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
>  object
> 
> I apologize for the delay.

You're welcome! I appreciate your time, guidance and feedback.

> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > On Thu, Aug 01, 2024 at 01:28:27PM +0200, Markus Armbruster wrote:
> 
> [...]
> 
> >> Can you provide a brief summary of the design alternatives that have
> >> been proposed so far?  Because I've lost track.
> >
> > No problem!
> >
> > Currently, we have the following options:
> >
> > * 1st: The first one is just to configure cache topology with several
> >   options in -smp:
> >
> >   -smp l1i-cache-topo=core,l1d-cache-topo-core
> >
> >   This one lacks scalability to support the cache size that ARM will
> >   need in the future.
> 
> -smp sets machine property "smp" of QAPI type SMPConfiguration.
> 
> So this one adds members l1i-cache-topo, l1d-cache-topo, ... to
> SMPConfiguration.

Yes.

> > * 2nd: The cache list object in -smp.
> >
> >   The idea was to use JSON to configure the cache list. However, the
> >   underlying implementation of -smp at the moment is keyval parsing,
> >   which is not compatible with JSON.
> 
> Keyval is a variation of the QEMU's traditional KEY=VALUE,... syntax
> that can serve as an alternative to JSON, with certain restrictions.
> Ideally, we provide both JSON and keyval syntax on the command line.

I see. It's the ideal state of the CLI, and -machine and -smp haven't
arrived here yet.

> Example: -blockdev supports both JSON and keyval.
>     JSON:   -blockdev '{"driver": "null-co", "node-name": "node0"}'
>     keyval: -blockdev null-co,node-name=node0
> 
> Unfortunately, we have many old interfaces that still lack JSON support.
> 
> >   If we can not insist on JSON format, then cache lists can also be
> >   implemented in the following way:
> >   
> >   -smp caches.0.name=l1i,caches.0.topo=core,\
> >        caches.1.name=l1d,caches.1.topo=core
> 
> This one adds a single member caches to SMPConfiguration.  It is an
> array of objects.

Yes.

> > * 3rd: The cache list object linked in -machine.
> >
> >   Considering that -object is JSON-compatible so that defining lists via
> >   JSON is more friendly, I implemented the caches list via -object and
> >   linked it to MachineState:
> >
> >   -object '{"qom-type":"smp-cache","id":"obj","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"}]}'
> >   -machine smp-caches=obj
> 
> This one wraps the same array of objects in a new user-creatable object,
> then sets machine property "smp-caches" to that object.
> 
> We can set machine properties directly with -machine.  But -machine
> doesn't support JSON, yet.
> 
> Wrapping in an object moves the configuration to -object, which does
> support JSON.
> 
> Half way between 2nd and 3rd:
> 
>   * Cache list object in machine
> 
>     -machine caches.0.name=l1i,caches.0.topo=core,\
>              caches.1.name=l1d,caches.1.topo=core

I got your point, and putting the array in -machine does align with the
design of the other machine options nowadays.

> > * 4th: The per cache object without any list:
> >
> >   -object smp-cache,id=cache0,name=l1i,topo=core \
> >   -object smp-cache,id=cache1,name=l1d,topo=core
> >
> >   This proposal is clearer, but there are a few opens:
> >   - I plan to push qom-topo forward, which would abstract CPU related
> >     topology levels and cache to "device" instead of object. Is there a
> >     conflict here?
> 
> Can't say, since I don't understand where you want to go.
> 
> Looks like your trying to design an interface for what you want to do
> now, and are wondering whether it could evolve to accomodate what you
> want to do later.
> 
> It's often better to design the interface for everything you already
> know you want to do, then take out the parts you want to do later.

Thanks! From this point of view, then per cache of objects does not meet
my needs.

> >   - Multiple cache objects can't be linked to the machine on the command
> >     line, so I maintain a static cache list in smp_cache.c and expose
> >     the cache information to the machine through some interface. is this
> >     way acceptable?
> >
> >
> > In summary, the 4th proposal was the most up in the air, as it looked to
> > be conflict with the hybrid topology I wanted to do (and while hybrid
> > topology may not be accepted by the community either, I thought it would
> > be best for the two work to be in the same direction).
> >
> > The difference between 2nd and 3rd is about the JSON requirement, if JSON
> > is mandatory for now then it's 3rd, if it's not mandatory (or accept to
> > make -machine/-smp support JSON in the future), 2nd looks cleaner, which
> > puts the caches list in -smp.
> 
> I'd rather not let syntactic limitations of our CLI dictate the
> structure of our configuration data.  Design the structure *first*.
> Only then start to think about CLI.  Our CLI is an unholy mess, and
> thinking about it too early risks getting lost in the weeds.  I fear
> this is what happened to you.

Indeed, that's my dilemma, lost in the world of CLIs.

> If I forcibly ignore all the considerations related to concrete syntax
> in your message, a structure seems to emerge: there's a set of caches
> identified by name (l1i, l1d, ...), and for each cache, we have a number
> of configurable properties (topology level, ...).  Makes sense?

Yes, you're right!

> What else will you need to configure in the future?

Maybe cache size, as Jonathan mentioned for Arm side.

> By the way, extending -machine to support JSON looks feasible to me at a
> glance.
 
Thanks again! Then I made it clear that it would be most appropriate to
place the cache array in -machine, i.e., it's extensible and consistent
with the design of the rest of the machine's properties, as well as
consistent with my long-term needs.

Later on, if -machine is able to support JSON, it will also benefit from
it. If I have time, I will also think about how -machine can support
JSON.

Regards,
Zhao


