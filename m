Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51366C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfygc-0002aa-Ia; Thu, 06 Feb 2025 05:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfygV-0002Zy-Vr; Thu, 06 Feb 2025 05:00:36 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfygT-0006gZ-2T; Thu, 06 Feb 2025 05:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738836034; x=1770372034;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=MU874FEMTTz129Wl0GzXGt5/AqElqEZSPesXYVwITzg=;
 b=Sbup0LoYTTgTs94LAMa1wLH7VvRDXPup/ufkwrmtQXntv+zTAzlb0x8e
 LCsVlXLjnO35HdPeKxUtiM4wHqbtPadhrTAqSEFiSY9oW9T9X7Ty+fd3a
 sbm8eO4/kv+3ikrSVUTH+tesqCvcNY7dZIzdia2Tz0hR22/xTHsnAk9Ne
 7Vo26zU08q91WxbqfOcNXJnd6WZSxoUZzKJxLaFet5zPf1wkE8tvvQE8D
 00joTUJxOlUWo0iDIHL8yzs3okCIXL7Sca2p5zRP0nwFioD+hW8MSOWPd
 LFpPSFS0oa6PG90+NLkNu0Eu6Nx7Q6FbCzl3mTZays0WQ6nhVIdQz0iX+ w==;
X-CSE-ConnectionGUID: 9/bAfngoQaGicD6MoveraQ==
X-CSE-MsgGUID: TZyqQ+K5Tvy4gNC2OdBFwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39456944"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="39456944"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 02:00:30 -0800
X-CSE-ConnectionGUID: cx0BQhqjQt27D6NsVtSqcQ==
X-CSE-MsgGUID: QCjIMYF1Qie+rufoFs4vsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="116147595"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 06 Feb 2025 02:00:22 -0800
Date: Thu, 6 Feb 2025 18:19:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 1/5] qapi/qom: Introduce kvm-pmu-filter object
Message-ID: <Z6SMxlWhHgronott@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-2-zhao1.liu@intel.com>
 <871pwc3dyw.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pwc3dyw.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Wed, Feb 05, 2025 at 11:03:51AM +0100, Markus Armbruster wrote:
> Date: Wed, 05 Feb 2025 11:03:51 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [RFC v2 1/5] qapi/qom: Introduce kvm-pmu-filter object
> 
> Quick & superficial review for now.

Thanks!

> > diff --git a/qapi/kvm.json b/qapi/kvm.json
> > new file mode 100644
> > index 000000000000..d51aeeba7cd8
> > --- /dev/null
> > +++ b/qapi/kvm.json
> > @@ -0,0 +1,116 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=python
> > +
> > +##
> > +# = KVM based feature API
> 
> This is a top-level section.  It ends up between sections "QMP
> introspection" and "QEMU Object Model (QOM)".  Is this what we want?  Or
> should it be a sub-section of something?  Or next to something else?

Do you mean it's not in the right place in the qapi-schema.json?

diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index b1581988e4eb..742818d16e45 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -64,6 +64,7 @@
 { 'include': 'compat.json' }
 { 'include': 'control.json' }
 { 'include': 'introspect.json' }
+{ 'include': 'kvm.json' }
 { 'include': 'qom.json' }
 { 'include': 'qdev.json' }
 { 'include': 'machine-common.json' }

Because qom.json includes kvm.json, so I have to place it before
qom.json.

It doesn't have any dependencies itself, so placing it in the previous
position should be fine, where do you prefer?

> > +##
> > +
> > +##
> > +# @KVMPMUFilterAction:
> > +#
> > +# Actions that KVM PMU filter supports.
> > +#
> > +# @deny: disable the PMU event/counter in KVM PMU filter.
> > +#
> > +# @allow: enable the PMU event/counter in KVM PMU filter.
> > +#
> > +# Since 10.0
> > +##
> > +{ 'enum': 'KVMPMUFilterAction',
> > +  'prefix': 'KVM_PMU_FILTER_ACTION',
> > +  'data': ['allow', 'deny'] }
> > +
> > +##
> > +# @KVMPMUEventEncodeFmt:
> 
> Please don't abbreviate Format to Fmt.  We use Format elsewhere, and
> consistency is desirable.

OK, will fix.

> >  ##
> >  # = QEMU Object Model (QOM)
> > @@ -1108,6 +1109,7 @@
> >        'if': 'CONFIG_LINUX' },
> >      'iommufd',
> >      'iothread',
> > +    'kvm-pmu-filter',
> >      'main-loop',
> >      { 'name': 'memory-backend-epc',
> >        'if': 'CONFIG_LINUX' },
> > @@ -1183,6 +1185,7 @@
> >                                        'if': 'CONFIG_LINUX' },
> >        'iommufd':                    'IOMMUFDProperties',
> >        'iothread':                   'IothreadProperties',
> > +      'kvm-pmu-filter':             'KVMPMUFilterPropertyVariant',
> 
> The others are like
> 
>          'mumble': 'MumbleProperties'
> 
> Let's stick to that, and also avoid running together multiple
> capitalized acronyms: KvmPmuFilterProperties.

IIUC, then I should use the name "KvmPmuFilterProperties" (string version
for QAPI), and the name "KvmPmuFilterPropertiesVariant" (numeric version
in codes), do you agree?
 
> >        'main-loop':                  'MainLoopProperties',
> >        'memory-backend-epc':         { 'type': 'MemoryBackendEpcProperties',
> >                                        'if': 'CONFIG_LINUX' },
> 

