Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A41606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=WNPUGHg9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLvdc-0007Ul-Bl; Wed, 28 Oct 2026 00:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1xLvdZ-0007Tg-7R; Wed, 28 Oct 2026 00:51:45 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1xLvdW-0003Tl-49; Wed, 28 Oct 2026 00:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1793163109; x=1824699109;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vEQHe4OQbDaVWWPIT41fh0Pgui+NyNm61DH2obcWQ/k=;
 b=WNPUGHg9ddUQNIH3Aa9oLo7+OySEGVoCQoastZIhMKGqOSaPsIYwSPst
 /BvDv6I14rp9qRrqwUfxDk6ZUcejQJ3hnt4UiSps2yjlmq7jS9VEaYpwD
 9Lz0q8+yoaglmi2XA0CLYm2IaEZZnZP5Ixr+ZKOAPiOePVM1iLWkPlsn6
 OKLAqtPVHTYMbepFvUu2ukjq7Lad7mcuZjMFCyhRKHiBNMuZ1S/bAhFqc
 w5Z1qNtJ4J+odeFV1WMIA2FOAg+DnhEnW+YOqiYEGuqzO6twF6rM7HxVD
 HpTZKd4SD8A3WyWuCu9fY7Um7VY2brLdsNAWH64q32Zw/zZNkwHwEuDrl Q==;
X-CSE-ConnectionGUID: 3PIG1CU6RfmwYrM2t4o1VQ==
X-CSE-MsgGUID: dG0b7eWxTvaWEYT1GNWvxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="259631869"
X-IronPort-AV: E=Sophos;i="6.27,182,1786978800"; d="scan'208";a="259631869"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 13:51:45 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 681C682113B;
 Wed, 28 Oct 2026 04:51:37 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 1DB738D29F3;
 Wed, 28 Oct 2026 04:51:37 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.69.152])
 by az2uksmom2.o.css.fujitsu.com (Postfix) with SMTP id ACAD814002FE;
 Wed, 28 Oct 2026 04:51:30 +0000 (UTC)
Date: Wed, 28 Oct 2026 13:51:29 +0900
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, michael.roth@amd.com,
 berrange@redhat.com, kchamart@redhat.com, 
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com,
 cohuck@redhat.com, 
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <auF8rstVcvsDUO6C@FCCLS0092175.localdomain>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain> <ataBkrIvULJXj4v6@p14s>
 <784dfea3-24cb-4e70-ab46-b96b4b9a1831@redhat.com>
 <at-Wkw7a3Tn3Oh3M@red-moon>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <at-Wkw7a3Tn3Oh3M@red-moon>
Received-SPF: pass client-ip=207.54.90.49; envelope-from=enju.kohei@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Kohei Enju <enju.kohei@fujitsu.com>
From:  Kohei Enju via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26 19:06, Lorenzo Pieralisi wrote:
> On Wed, Oct 21, 2026 at 11:42:14PM +1000, Gavin Shan wrote:
> > On 10/20/26 6:46 AM, Mathieu Poirier wrote:
> > > On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
> > > > On 09/22 10:01, Lorenzo Pieralisi wrote:
> > > > > On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > > > > > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > 
> > > > > > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > > > > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > > > > > passing on the command-line:
> > > > > > > 
> > > > > > >    -M virt,confidential-guest-support=<id>
> > > > > > >    -object rme-guest,id=<id>
> > > > > > > 
> > > > > > > This is only the skeleton. Support will be added in following patches.
> > > > > > > 
> > > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > > ---
> > > > > > >   docs/system/confidential-guest-support.rst |  1 +
> > > > > > >   qapi/qom.json                              | 13 +++++++
> > > > > > >   target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > > > > >   target/arm/meson.build                     |  5 ++-
> > > > > > >   4 files changed, 60 insertions(+), 1 deletion(-)
> > > > > > >   create mode 100644 target/arm/kvm-rme.c
> > > > > > > 
> > > > > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > > > > index 562a7c3c2852..abb56923ad13 100644
> > > > > > > --- a/docs/system/confidential-guest-support.rst
> > > > > > > +++ b/docs/system/confidential-guest-support.rst
> > > > > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > > > > >   * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > > > > >   * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > > > > >   * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > > > > +* Arm Realm Management Extension (RME)
> > > > > > >   Other mechanisms may be supported in future.
> > > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > > index 776b13027fd8..52997c29a32d 100644
> > > > > > > --- a/qapi/qom.json
> > > > > > > +++ b/qapi/qom.json
> > > > > > > @@ -1288,6 +1288,17 @@
> > > > > > >     'data': { '*pretty': 'bool',
> > > > > > >               '*close-action': 'MonitorQMPCloseAction' } }
> > > > > > > +##
> > > > > > > +# @RmeGuestProperties:
> > > > > > > +#
> > > > > > > +# Properties for rme-guest objects.
> > > > > > > +#
> > > > > > > +# Since: 11.1
> > > > > > > +##
> > > > > > > +{ 'struct': 'RmeGuestProperties',
> > > > > > > +  'base': 'ConfidentialGuestSupportProperties',
> > > > > > 
> > > > > > Just FYI, based on input from Markus I'm planning to drop this
> > > > > > ConfidentialGuestSupportProperties base type from my series
> > > > > > since it's probably only SNP/TDX that need to be able to switch
> > > > > > it on/off, whereas this series appears to use/require it from
> > > > > > the start.
> > > > > > 
> > > > > > I'm not exactly sure what it will look like for v3 yet, but if you
> > > > > > were based on v2 you'd instead probably just do the following in the
> > > > > > instance_init function for your rme-guest instance:
> > > > > > 
> > > > > >    cgs->allow_convert_in_place = true;
> > > > > >    cgs->convert_in_place = true;
> > > > > > 
> > > > > > rather than exposing it as a cmdline option.
> > > > > 
> > > > > Yep, it won't be an option for CCA Realms anyway since that will be
> > > > > the baseline.
> > > > 
> > > > IIUC, in-place conversion requires RAM backed by a shared/mappable
> > > > guest_memfd. If in-place conversion is always enabled for CCA Realms,
> > > > could QEMU also select the equivalent of
> > > > 
> > > >    -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> > > > 
> > > > automatically for the default RAM, so that specifying the RAM size with
> > > > `-m` is sufficient?
> > > 
> > > Are you suggesting that on Arm, we completely get rid of
> > > 
> > >      -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on
> > > 
> > > or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> > > with "-m $(RAMSIZE)"?
> > > 
> > > Gavin and Michael, what is your take on that suggestion?
> > > 
> > 
> > I don't think that's what Kohei meant. He actually suggested the memory backend
> > shall be pinned to memory-backend-guest-memfd and its in-place conversion shall
> > be enabled when the memory backend isn't explicitly specified by users through
> > "-object memory-backend-xxxx". For this inexplicit case, where the memory backend
> > is determined by '-mem-path', the memory backend is either TYPE_MEMORY_BACKEND_FILE
> > or TYPE_MEMORY_BACKEND_RAM. Please refer to create_default_memdev().
> > 
> > I think Kohei's suggestion makes sense. Besides, I think '-mem-path' should be
> > disallowed for CCA Realms as TYPE_MEMORY_BACKEND_FILE isn't what we want.
> 
> Kohei, what were you suggesting then please ? I think TYPE_MEMORY_BACKEND_FILE
> would not pass the checks required by Michael's v3 [0] on CCA - I will test this
> and report back but the only backend allowed, rightly, is memfd,share=on, so it
> _is_ disallowed.

Sorry for the late response.

To clarify, I meant the latter: when rme-guest is selected and the user
has not explicitly provided a memory backend, QEMU could automatically
create the default RAM as a shared guest-memfd backend.

In other words, rather than only rejecting the default file/RAM backend,
the Realm configuration could select the equivalent of

  -object memory-backend-guest-memfd,id=<default-ram-id>,size=<RAMSIZE>,share=on

by default. Explicitly specified memory backends would still need to be
validated against the Realm requirements.

My intention was that, if in-place conversion is the baseline for CCA
Realms, `-m <size>` should be sufficient for the common Realm case,
while preserving an explicit memory-backend option for users who need to
control it.

That said, I do not have a strong preference for deciding the default
`-m` behavior at this stage. If it is premature to make that decision
before the memory-backend and conversion interfaces have settled, I am
happy to keep the explicit guest-memfd backend requirement for now and
revisit the default behavior later.

Thanks,
Kohei

> 
> Lorenzo
> 
> [0] https://lore.kernel.org/kvm/20261007134323.1606088-1-michael.roth@amd.com/
> 
> > Thanks,
> > Gavin
> > 
> > > Thanks,
> > > Mathieu
> > > 
> > > > 
> > > > Thanks,
> > > > Kohei
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Lorenzo
> > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > Mike
> > > > > > 
> > > > > > > +  'data': {} }
> > > > > > > +
> > > > > > >   ##
> > > > > > >   # @ObjectType:
> > > > > > >   #
> > > > > > > @@ -1346,6 +1357,7 @@
> > > > > > >       { 'name': 'pr-manager-helper',
> > > > > > >         'if': 'CONFIG_LINUX' },
> > > > > > >       'qtest',
> > > > > > > +    'rme-guest',
> > > > > > >       'rng-builtin',
> > > > > > >       'rng-egd',
> > > > > > >       { 'name': 'rng-random',
> > > > > > > @@ -1427,6 +1439,7 @@
> > > > > > >         'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > > > > >                                         'if': 'CONFIG_LINUX' },
> > > > > > >         'qtest':                      'QtestProperties',
> > > > > > > +      'rme-guest':                  'RmeGuestProperties',
> > > > > > >         'rng-builtin':                'RngProperties',
> > > > > > >         'rng-egd':                    'RngEgdProperties',
> > > > > > >         'rng-random':                 { 'type': 'RngRandomProperties',
> > > > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..42e1d1e7b859
> > > > > > > --- /dev/null
> > > > > > > +++ b/target/arm/kvm-rme.c
> > > > > > > @@ -0,0 +1,42 @@
> > > > > > > +/*
> > > > > > > + * QEMU Arm RME support
> > > > > > > + *
> > > > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > + *
> > > > > > > + * Copyright Linaro 2026
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include "qemu/osdep.h"
> > > > > > > +
> > > > > > > +#include "hw/core/boards.h"
> > > > > > > +#include "hw/core/cpu.h"
> > > > > > > +#include "kvm_arm.h"
> > > > > > > +#include "migration/blocker.h"
> > > > > > > +#include "qapi/error.h"
> > > > > > > +#include "qom/object_interfaces.h"
> > > > > > > +#include "system/confidential-guest-support.h"
> > > > > > > +#include "system/kvm.h"
> > > > > > > +#include "system/runstate.h"
> > > > > > > +
> > > > > > > +#define TYPE_RME_GUEST "rme-guest"
> > > > > > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > > > > > +
> > > > > > > +struct RmeGuest {
> > > > > > > +    ConfidentialGuestSupport parent_obj;
> > > > > > > +};
> > > > > > > +
> > > > > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > > > > +                                          { TYPE_USER_CREATABLE }, { })
> > > > > > > +
> > > > > > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > > > > > +{
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void rme_guest_init(Object *obj)
> > > > > > > +{
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void rme_guest_finalize(Object *obj)
> > > > > > > +{
> > > > > > > +}
> > > > > > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > > > > > index 0369f96b4cc6..9d322a7aad28 100644
> > > > > > > --- a/target/arm/meson.build
> > > > > > > +++ b/target/arm/meson.build
> > > > > > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > > > > > >   arm_common_system_ss.add(files(
> > > > > > >     'arm-qmp-cmds.c',
> > > > > > >   ))
> > > > > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > > > > +  'hyp_gdbstub.c',
> > > > > > > +  'kvm.c',
> > > > > > > +  'kvm-rme.c'))
> > > > > > >   arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > > > > >   arm_user_ss.add(files('cpu.c'))
> > > > > > > -- 
> > > > > > > 2.43.0
> > > > > > > 
> > > > > > > 
> > > 
> > 

