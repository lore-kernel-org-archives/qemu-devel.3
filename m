Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AC1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 09:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbdEM-00006T-Nd; Wed, 07 Aug 2024 05:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbdEK-0008P5-Ds
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:45:16 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sbdEG-0002hn-Mi
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723023913; x=1754559913;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=52qBbsPBw1CW9TaWGnYB9fhKWhRZ0gzJVUln8IvbArI=;
 b=FUdLxClooGU7eIk7tpDNlEnd80euBj1lOKLB9D7H29sFoaQUxV4sGDtf
 jpftontrr+9dvrHSleorKx00nqGkriQQwTKwQY7p5Vw7zSB4JNV4/FyFM
 bNKMFC7H+oEASI1BSQvMjfeaHO9o1SFXkqpgh6OlpSNuwym+GyDbe2Ryv
 UTkV9SFSjdK2JjTpEcwILDoBYpVI4sQ67VGfY1yUVxY8DpeXqoHdfF6k3
 SLN0LlGrj96DGUGHFzj6m+mJrWcGqygVn9IedNROMaNMXBb4tq5NBteWn
 q7q4hUsYfaxLIFGUXxjekKu7mjNgkrtVpwzVY0pbwZ3PgKtfSzl+WEUc0 A==;
X-CSE-ConnectionGUID: 25e/JwK2TjOMkHF6rwfEzA==
X-CSE-MsgGUID: 0ic44X0NR9KU3ylfTLsY6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32486475"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; d="scan'208";a="32486475"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 02:45:09 -0700
X-CSE-ConnectionGUID: JNzXxyT0QwWPJHLXE0WANw==
X-CSE-MsgGUID: YjK0r+O/TcaC1t4EM2x6kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; d="scan'208";a="56482022"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 07 Aug 2024 02:45:07 -0700
Date: Wed, 7 Aug 2024 18:00:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache object
Message-ID: <ZrNF2Q0YxseXCJGA@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-9-zhao1.liu@intel.com>
 <87r0bl35ug.fsf@pond.sub.org> <Zp5vxtXWDeHAdPok@intel.com>
 <87bk2nnev2.fsf@pond.sub.org> <ZqEN1kZaQcuY4UPG@intel.com>
 <87le1psuv3.fsf@pond.sub.org> <ZqtXP9MViOlyhEsu@intel.com>
 <87mslweb38.fsf@pond.sub.org> <ZqyRik4UHHz3xaKl@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqyRik4UHHz3xaKl@intel.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Hi Markus,

Just a kindly ping. Hopefully we can continue this discussion when
you're free.

Regards,
Zhao

On Fri, Aug 02, 2024 at 03:58:02PM +0800, Zhao Liu wrote:
> Date: Fri, 2 Aug 2024 15:58:02 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
>  object
> 
> On Thu, Aug 01, 2024 at 01:28:27PM +0200, Markus Armbruster wrote:
> > Date: Thu, 01 Aug 2024 13:28:27 +0200
> > From: Markus Armbruster <armbru@redhat.com>
> > Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
> >  object
> > 
> > Zhao Liu <zhao1.liu@intel.com> writes:
> > 
> > > On Thu, Jul 25, 2024 at 11:07:12AM +0200, Markus Armbruster wrote:
> > >> Date: Thu, 25 Jul 2024 11:07:12 +0200
> > >> From: Markus Armbruster <armbru@redhat.com>
> > >> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
> > >>  object
> > >> 
> > >> Zhao Liu <zhao1.liu@intel.com> writes:
> > >> 
> > >> > Hi Markus and Daniel,
> > >> >
> > >> > I have the questions about the -object per cache implementation:
> > >> >
> > >> > On Wed, Jul 24, 2024 at 02:39:29PM +0200, Markus Armbruster wrote:
> > >> >> Date: Wed, 24 Jul 2024 14:39:29 +0200
> > >> >> From: Markus Armbruster <armbru@redhat.com>
> > >> >> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
> > >> >>  object
> > >> >> 
> > >> >> Zhao Liu <zhao1.liu@intel.com> writes:
> > >> >> 
> > >> >> > Hi Markus,
> > >> >> >
> > >> >> > On Mon, Jul 22, 2024 at 03:37:43PM +0200, Markus Armbruster wrote:
> > >> >> >> Date: Mon, 22 Jul 2024 15:37:43 +0200
> > >> >> >> From: Markus Armbruster <armbru@redhat.com>
> > >> >> >> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
> > >> >> >>  object
> > >> >> >> 
> > >> >> >> Zhao Liu <zhao1.liu@intel.com> writes:
> > >> >> >> 
> > >> >> >> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > >> >> >> 
> > >> >> >> This patch is just documentation.  The code got added in some previous
> > >> >> >> patch.  Would it make sense to squash this patch into that previous
> > >> >> >> patch?
> > >> >> >
> > >> >> > OK, I'll merge them.
> > >> >> >
> > >> >> >> > ---
> > >> >> >> > Changes since RFC v2:
> > >> >> >> >  * Rewrote the document of smp-cache object.
> > >> >> >> >
> > >> >> >> > Changes since RFC v1:
> > >> >> >> >  * Use "*_cache=topo_level" as -smp example as the original "level"
> > >> >> >> >    term for a cache has a totally different meaning. (Jonathan)
> > >> >> >> > ---
> > >> >> >> >  qemu-options.hx | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >> >> >> >  1 file changed, 58 insertions(+)
> > >> >> >> >
> > >> >> >> > diff --git a/qemu-options.hx b/qemu-options.hx
> > >> >> >> > index 8ca7f34ef0c8..4b84f4508a6e 100644
> > >> >> >> > --- a/qemu-options.hx
> > >> >> >> > +++ b/qemu-options.hx
> > >> >> >> > @@ -159,6 +159,15 @@ SRST
> > >> >> >> >          ::
> > >> >> >> >  
> > >> >> >> >              -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
> > >> >> >> > +
> > >> >> >> > +    ``smp-cache='id'``
> > >> >> >> > +        Allows to configure cache property (now only the cache topology level).
> > >> >> >> > +
> > >> >> >> > +        For example:
> > >> >> >> > +        ::
> > >> >> >> > +
> > >> >> >> > +            -object '{"qom-type":"smp-cache","id":"cache","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"},{"name":"l2","topo":"module"},{"name":"l3","topo":"die"}]}'
> > >> >> >> > +            -machine smp-cache=cache
> > >> >> >> >  ERST
> > >> >> >> >  
> > >> >> >> >  DEF("M", HAS_ARG, QEMU_OPTION_M,
> > >> >> >> > @@ -5871,6 +5880,55 @@ SRST
> > >> >> >> >          ::
> > >> >> >> >  
> > >> >> >> >              (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> > >> >> >> > +
> > >> >> >> > +    ``-object '{"qom-type":"smp-cache","id":id,"caches":[{"name":cache_name,"topo":cache_topo}]}'``
> > >> >> >> > +        Create an smp-cache object that configures machine's cache
> > >> >> >> > +        property. Currently, cache property only include cache topology
> > >> >> >> > +        level.
> > >> >> >> > +
> > >> >> >> > +        This option must be written in JSON format to support JSON list.
> > >> >> >> 
> > >> >> >> Why?
> > >> >> >
> > >> >> > I'm not familiar with this, so I hope you could educate me if I'm wrong.
> > >> >> >
> > >> >> > All I know so far is for -object that defining a list can only be done in
> > >> >> > JSON format and not with a numeric index like a keyval based option, like:
> > >> >> >
> > >> >> > -object smp-cache,id=cache0,caches.0.name=l1i,caches.0.topo=core: Parameter 'caches' is missing
> > >> >> >
> > >> >> > the above doesn't work.
> > >> >> >
> > >> >> > Is there any other way to specify a list in command line?
> > >> >> 
> > >> >> The command line is a big, sprawling mess :)
> > >> >> 
> > >> >> -object supports either a JSON or a QemuOpts argument.  *Not* keyval!
> > >> >> 
> > >> >> Both QemuOpts and keyval parse something like KEY=VALUE,...  Keyval
> > >> >> supports arrays and objects via dotted keys.  QemuOpts doesn't natively
> > >> >> support arrays and objects, but its users can hack around that
> > >> >> limitation in various ways.  -object doesn't.  So you're right, it's
> > >> >> JSON or bust here.
> > >> >> 
> > >> >> However, if we used one object per cache instead, we could get something
> > >> >> like
> > >> >> 
> > >> >>     -object smp-cache,name=l1d,...
> > >> >>     -object smp-cache,name=l1u,...
> > >> >>     -object smp-cache,name=l2,...
> > >> >>     ...
> > >> >
> > >> > Current, I use -object to create a smp_cache object, and link it to
> > >> > MachineState by -machine,smp-cache=obj_id.
> > >> >
> > >> > Then for the objects per cache, how could I link them to machine?
> > >> >
> > >> > Is it possible that I create something static in smp_cache.c and expose
> > >> > all the cache information to machine through some interface?
> > >> 
> > >> Good questions.  However, before we head deeper into the weeds here, I
> > >> feel we should discuss the things below.  And before we do that, I need
> > >> a clear understanding of the use case.  Elsewhere in this thread, I just
> > >> described the use case as I understand it.  Please reply there.  I'll
> > >> then come back to this message.
> > >> 
> > >> [...]
> > >
> > > Jonathan and I provided different use cases for x86 and Arm. Could we
> > > come back here to continue the discussion? :)
> > 
> > Can you provide a brief summary of the design alternatives that have
> > been proposed so far?  Because I've lost track.
> 
> No problem!
> 
> Currently, we have the following options:
> 
> * 1st: The first one is just to configure cache topology with several
>   options in -smp:
> 
>   -smp l1i-cache-topo=core,l1d-cache-topo-core
> 
>   This one lacks scalability to support the cache size that ARM will
>   need in the future.
> 
> 
> * 2nd: The cache list object in -smp.
> 
>   The idea was to use JSON to configure the cache list. However, the
>   underlying implementation of -smp at the moment is keyval parsing,
>   which is not compatible with JSON.
> 
>   If we can not insist on JSON format, then cache lists can also be
>   implemented in the following way:
>   
>   -smp caches.0.name=l1i,caches.0.topo=core,\
>        caches.1.name=l1d,caches.1.topo=core
> 
> 
> * 3rd: The cache list object linked in -machine.
> 
>   Considering that -object is JSON-compatible so that defining lists via
>   JSON is more friendly, I implemented the caches list via -object and
>   linked it to MachineState:
> 
>   -object '{"qom-type":"smp-cache","id":"obj","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"}]}'
>   -machine smp-caches=obj
> 
> 
> * 4th: The per cache object without any list:
> 
>   -object smp-cache,id=cache0,name=l1i,topo=core \
>   -object smp-cache,id=cache1,name=l1d,topo=core
> 
>   This proposal is clearer, but there are a few opens:
>   - I plan to push qom-topo forward, which would abstract CPU related
>     topology levels and cache to "device" instead of object. Is there a
>     conflict here?
> 
>   - Multiple cache objects can't be linked to the machine on the command
>     line, so I maintain a static cache list in smp_cache.c and expose
>     the cache information to the machine through some interface. is this
>     way acceptable?
> 
> 
> In summary, the 4th proposal was the most up in the air, as it looked to
> be conflict with the hybrid topology I wanted to do (and while hybrid
> topology may not be accepted by the community either, I thought it would
> be best for the two work to be in the same direction).
> 
> The difference between 2nd and 3rd is about the JSON requirement, if JSON
> is mandatory for now then it's 3rd, if it's not mandatory (or accept to
> make -machine/-smp support JSON in the future), 2nd looks cleaner, which
> puts the caches list in -smp.
> 
> Regards,
> Zhao
> 
> 
> 

