Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAD3C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtzy-00015V-7A; Mon, 22 Jul 2024 10:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sVtzv-00011Q-9d; Mon, 22 Jul 2024 10:26:43 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sVtzs-000586-76; Mon, 22 Jul 2024 10:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721658401; x=1753194401;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OsrIUd37YeYaTA7dO/rYy+a/KCssuHBkjLNEx5suQu0=;
 b=hSy0PDa5l4BjzoKO+qruCPMD8eV2cxIblGpKaiZk0q8sBpx/3SCUBgX+
 e2gW6+IlgvsMscaRb8H+jPewCEuV8zvdw10wY77JamicExpNWx2Qe1YL6
 qjsxHa59Vi3pZDjBh2Gu0KEVrQ2Wy8Hy3F1upHTf8G8r7eJsEXzxxSP90
 +cK7zHqIbiT6yiJ7NMKhdzylKEUfmp6cSwC7mvNgHW35ohyL0089XCDOL
 6Vy5pdKbkSoDjDSKixOtwgpCRkLhoDVFhw0w08czvyVOWr1hD9uk56ejE
 BHvj82WWvWUaVG9K0Px+C9vwUTXK7hnt41HeuZRm8WySQqKjX8NMSzRUO g==;
X-CSE-ConnectionGUID: Tu7lbsH3SXqLzG1Or8lVwg==
X-CSE-MsgGUID: MtyZea+2RhOpcy2+dXY8fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30617142"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; d="scan'208";a="30617142"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 07:26:37 -0700
X-CSE-ConnectionGUID: +SEajsCAQSm91RWdetg5tQ==
X-CSE-MsgGUID: RxjqKHH3QVySpkXovI9GSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; d="scan'208";a="51555979"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 22 Jul 2024 07:26:30 -0700
Date: Mon, 22 Jul 2024 22:42:14 +0800
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
Message-ID: <Zp5vxtXWDeHAdPok@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-9-zhao1.liu@intel.com>
 <87r0bl35ug.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0bl35ug.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

Hi Markus,

On Mon, Jul 22, 2024 at 03:37:43PM +0200, Markus Armbruster wrote:
> Date: Mon, 22 Jul 2024 15:37:43 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 8/8] qemu-options: Add the description of smp-cache
>  object
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> This patch is just documentation.  The code got added in some previous
> patch.  Would it make sense to squash this patch into that previous
> patch?

OK, I'll merge them.

> > ---
> > Changes since RFC v2:
> >  * Rewrote the document of smp-cache object.
> >
> > Changes since RFC v1:
> >  * Use "*_cache=topo_level" as -smp example as the original "level"
> >    term for a cache has a totally different meaning. (Jonathan)
> > ---
> >  qemu-options.hx | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 8ca7f34ef0c8..4b84f4508a6e 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -159,6 +159,15 @@ SRST
> >          ::
> >  
> >              -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
> > +
> > +    ``smp-cache='id'``
> > +        Allows to configure cache property (now only the cache topology level).
> > +
> > +        For example:
> > +        ::
> > +
> > +            -object '{"qom-type":"smp-cache","id":"cache","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"},{"name":"l2","topo":"module"},{"name":"l3","topo":"die"}]}'
> > +            -machine smp-cache=cache
> >  ERST
> >  
> >  DEF("M", HAS_ARG, QEMU_OPTION_M,
> > @@ -5871,6 +5880,55 @@ SRST
> >          ::
> >  
> >              (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> > +
> > +    ``-object '{"qom-type":"smp-cache","id":id,"caches":[{"name":cache_name,"topo":cache_topo}]}'``
> > +        Create an smp-cache object that configures machine's cache
> > +        property. Currently, cache property only include cache topology
> > +        level.
> > +
> > +        This option must be written in JSON format to support JSON list.
> 
> Why?

I'm not familiar with this, so I hope you could educate me if I'm wrong.

All I know so far is for -object that defining a list can only be done in
JSON format and not with a numeric index like a keyval based option, like:

-object smp-cache,id=cache0,caches.0.name=l1i,caches.0.topo=core: Parameter 'caches' is missing

the above doesn't work.

Is there any other way to specify a list in command line?

> > +
> > +        The ``caches`` parameter accepts a list of cache property in JSON
> > +        format.
> > +
> > +        A list element requires the cache name to be specified in the
> > +        ``name`` parameter (currently ``l1d``, ``l1i``, ``l2`` and ``l3``
> > +        are supported). ``topo`` parameter accepts CPU topology levels
> > +        including ``thread``, ``core``, ``module``, ``cluster``, ``die``,
> > +        ``socket``, ``book``, ``drawer`` and ``default``. The ``topo``
> > +        parameter indicates CPUs winthin the same CPU topology container
> > +        are sharing the same cache.
> > +
> > +        Some machines may have their own cache topology model, and this
> > +        object may override the machine-specific cache topology setting
> > +        by specifying smp-cache object in the -machine. When specifying
> > +        the cache topology level of ``default``, it will honor the default
> > +        machine-specific cache topology setting. For other topology levels,
> > +        they will override the default setting.
> > +
> > +        An example list of caches to configure the cache model (l1d cache
> > +        per core, l1i cache per core, l2 cache per module and l3 cache per
> > +        socket) supported by PC machine might look like:
> > +
> > +        ::
> > +
> > +              {
> > +                "caches": [
> > +                   { "name": "l1d", "topo": "core" },
> > +                   { "name": "l1i", "topo": "core" },
> > +                   { "name": "l2", "topo": "module" },
> > +                   { "name": "l3", "topo": "socket" },
> > +                ]
> > +              }
> > +
> > +        An example smp-cache object would look like:()
> > +
> > +        .. parsed-literal::
> > +
> > +             # |qemu_system| \\
> > +                 ... \\
> > +                 -object '{"qom-type":"smp-cache","id":id,"caches":[{"name":cache_name,"topo":cache_topo}]}' \\
> > +                 ...
> >  ERST
> 

