Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA64C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 14:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWcch-0007bS-BA; Wed, 24 Jul 2024 10:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWccf-0007Zn-UV; Wed, 24 Jul 2024 10:05:41 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWcca-0007tQ-DB; Wed, 24 Jul 2024 10:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721829936; x=1753365936;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nHiDPbIFPaMJ6FYvivlu7Y0409aOZMDmB6P2KkiCJoM=;
 b=Zdlm8XP7b3QhOGSJEoMsuxR9hYi5vpLicx9LxnFrDIIgOiy5MIn91zHx
 48wBHic6sjCODl7CIEd6tn9qCVgARXiEbI+5Y5wmRdkTrlaHdR11E4gM0
 qp36h+ku75udX+0kttfGdzzyKeAkNiVsJSTusKUf6L5CYPOqsZIKxlKDZ
 YY9P5y1N27uU1vnB8U99AADeX4ea3LqjGMSmBFPgZG+NombfB7WnjoyLG
 QwhjTr88Duv6P00+eDZ7hOUSY2TK92P2+7XqAG1pC1oH1/juf8Wp+n8dX
 TROh9Q+8swVYIR8Wrqa+xH5eeOrH5yvyY3r4qxRxe5Y/z7uWCr6kEzWFA g==;
X-CSE-ConnectionGUID: rNG5exV5Q6a8S03BQS0ZUQ==
X-CSE-MsgGUID: VJnA62CdRJSanRd90Ql/rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="23270115"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="23270115"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 07:05:31 -0700
X-CSE-ConnectionGUID: +ugYcPMiQx6y3EvboMm6nw==
X-CSE-MsgGUID: y6FeXgEjQiKv6wybWSsJSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="56914510"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 24 Jul 2024 07:05:26 -0700
Date: Wed, 24 Jul 2024 22:21:10 +0800
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
Message-ID: <ZqEN1kZaQcuY4UPG@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-9-zhao1.liu@intel.com>
 <87r0bl35ug.fsf@pond.sub.org> <Zp5vxtXWDeHAdPok@intel.com>
 <87bk2nnev2.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk2nnev2.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Markus and Daniel,

I have the questions about the -object per cache implementation:

On Wed, Jul 24, 2024 at 02:39:29PM +0200, Markus Armbruster wrote:
> Date: Wed, 24 Jul 2024 14:39:29 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
>  object
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Hi Markus,
> >
> > On Mon, Jul 22, 2024 at 03:37:43PM +0200, Markus Armbruster wrote:
> >> Date: Mon, 22 Jul 2024 15:37:43 +0200
> >> From: Markus Armbruster <armbru@redhat.com>
> >> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
> >>  object
> >> 
> >> Zhao Liu <zhao1.liu@intel.com> writes:
> >> 
> >> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> >> 
> >> This patch is just documentation.  The code got added in some previous
> >> patch.  Would it make sense to squash this patch into that previous
> >> patch?
> >
> > OK, I'll merge them.
> >
> >> > ---
> >> > Changes since RFC v2:
> >> >  * Rewrote the document of smp-cache object.
> >> >
> >> > Changes since RFC v1:
> >> >  * Use "*_cache=topo_level" as -smp example as the original "level"
> >> >    term for a cache has a totally different meaning. (Jonathan)
> >> > ---
> >> >  qemu-options.hx | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
> >> >  1 file changed, 58 insertions(+)
> >> >
> >> > diff --git a/qemu-options.hx b/qemu-options.hx
> >> > index 8ca7f34ef0c8..4b84f4508a6e 100644
> >> > --- a/qemu-options.hx
> >> > +++ b/qemu-options.hx
> >> > @@ -159,6 +159,15 @@ SRST
> >> >          ::
> >> >  
> >> >              -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
> >> > +
> >> > +    ``smp-cache='id'``
> >> > +        Allows to configure cache property (now only the cache topology level).
> >> > +
> >> > +        For example:
> >> > +        ::
> >> > +
> >> > +            -object '{"qom-type":"smp-cache","id":"cache","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"},{"name":"l2","topo":"module"},{"name":"l3","topo":"die"}]}'
> >> > +            -machine smp-cache=cache
> >> >  ERST
> >> >  
> >> >  DEF("M", HAS_ARG, QEMU_OPTION_M,
> >> > @@ -5871,6 +5880,55 @@ SRST
> >> >          ::
> >> >  
> >> >              (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> >> > +
> >> > +    ``-object '{"qom-type":"smp-cache","id":id,"caches":[{"name":cache_name,"topo":cache_topo}]}'``
> >> > +        Create an smp-cache object that configures machine's cache
> >> > +        property. Currently, cache property only include cache topology
> >> > +        level.
> >> > +
> >> > +        This option must be written in JSON format to support JSON list.
> >> 
> >> Why?
> >
> > I'm not familiar with this, so I hope you could educate me if I'm wrong.
> >
> > All I know so far is for -object that defining a list can only be done in
> > JSON format and not with a numeric index like a keyval based option, like:
> >
> > -object smp-cache,id=cache0,caches.0.name=l1i,caches.0.topo=core: Parameter 'caches' is missing
> >
> > the above doesn't work.
> >
> > Is there any other way to specify a list in command line?
> 
> The command line is a big, sprawling mess :)
> 
> -object supports either a JSON or a QemuOpts argument.  *Not* keyval!
> 
> Both QemuOpts and keyval parse something like KEY=VALUE,...  Keyval
> supports arrays and objects via dotted keys.  QemuOpts doesn't natively
> support arrays and objects, but its users can hack around that
> limitation in various ways.  -object doesn't.  So you're right, it's
> JSON or bust here.
> 
> However, if we used one object per cache instead, we could get something
> like
> 
>     -object smp-cache,name=l1d,...
>     -object smp-cache,name=l1u,...
>     -object smp-cache,name=l2,...
>     ...

Current, I use -object to create a smp_cache object, and link it to
MachineState by -machine,smp-cache=obj_id.

Then for the objects per cache, how could I link them to machine?

Is it possible that I create something static in smp_cache.c and expose
all the cache information to machine through some interface?

Additionally, I would like to consider for the long term heterogeneous
cache, as asked before in [1], does the object per cache conflict with
the cache device I'm considering? Considering cache device is further
because I want to create CPU/cache topology via -device and build a
topology tree.

[1]: https://lore.kernel.org/qemu-devel/Zl88DYwLE3ScDF5F@intel.com/

I think this is becoming a nightmare I can't get around. Naming is
difficult, and sorting out interface design I think is also a difficult
task.

If you feel that there is indeed a conflict, then I'm also willing
to fall back to -smp again and do it based on keyval's list, as originally
suggested by Daniel. Sorry for the repetition on thoughts/design, I hope
that discussion with you I can make sense of the current and subsequent
paths without getting out of hand!

Best Regards,
Zhao


