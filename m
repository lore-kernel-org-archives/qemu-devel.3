Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42903606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OK9nwMrr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYK6-0000Z6-98; Thu, 29 Oct 2026 18:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xMYJx-0000Qo-2j
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:10:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xMYJu-0007H8-8h
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:10:04 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2e940d5d2beso400255ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793311800; x=1793916600; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iWxGzUiL9af49cd3f3h7Wfqs2xiIj0zeQzBJaUAAk5Y=;
 b=OK9nwMrrPx3V7YddnNJ6z97OPM12IXw9hjJ1wtGd9EjO9toygTynFvjJjO7Rif407y
 JZXmLszgfhAqefy5uWSvak0vKTfEpXSDYv7WCjbHQ4YFp1wZFw1W25cagIpYOsgC0eyl
 5L5zkS6tAlDVVchcgkEvepGbdt778hBUpexxbm2NLyu1nK0vtEJ50/1EfuDyqt2yewm6
 25Xeg6JZfJa6iTWXXsWGfYfbSPwajOWbptR1E1FhZZWVN3qvKnKcJ+BYnrgUFQzEoQ4U
 OCoycnypqcQjVdRsJJBxxXZPA27WafyRLL8K6L3+MCj5djP+nXyKTZ1n0ebkV5vCGbX2
 rlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311800; x=1793916600;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iWxGzUiL9af49cd3f3h7Wfqs2xiIj0zeQzBJaUAAk5Y=;
 b=TAcrzn9bKWO2SSaOD1WWbevUbUaZKEVTYhpxLYpccKotcx5z9OHqwimste4pWn5VX2
 9qXxRQGfVB7AwoEDWVoa9W4gO0AEC6OtWstMrM7axGlZmoHlc1swecYGntTXlcaxJEeo
 69bykAqo6ZU9heI75y7KOK8W8D84HblDceSZcOWAEZUS4ITfcCNPpo41FhEL0ndmsnM9
 pfPuDOZcG6qlgAvLaJdtMhzjJdXEI9jDvNpsrKRhCZ92CxqPoPRcILeAbC+vbk/crjU5
 v7flINTRgZEn2L6QP8kiPLnfsdJgDKisefuj6bZI9TsEJFBD/HKyiIZC0arIBgYo1xbA
 aKBg==
X-Forwarded-Encrypted: i=1;
 AKwUvByApOYzkpI7zjK2aUIvqH21l2ENWgsE6LfShl1kgCjUUL3irbJ3tM6UojpCXcmHzTb83PEcelBXTIyq@nongnu.org
X-Gm-Message-State: AFq9FYI58Lk/u+9VycDLffLH6LHgvpe6Ws8wA/9IxuxUC94UhV3OIjNq
 fiKw3IwP4y5gz8NykK/VgiHXLsWlB1m0LKK13/eAsjmqeuH9rUqm7rPrH1FKP/unbAI=
X-Gm-Gg: AYBFou3Hx3NsLix6jXBXKUd0vSXBvy2vUOmylZrZAc9EQxyb/6MX8GyulzB0HwIuF5f
 NSc+piVWBOot2QA3a0O5WUBCMWpbHKKWzwKEr2t1xTbVYjbrr8eW+UfEO/SfPWiXGTKMx9FZB0T
 ue2Vtm/HoIBTONIwVlM/UcJ4ax3sb79vvZgjuWdvFSILMIKl+vrNvzuAPWg7aWQXu5UaTDIlSbZ
 d7iwaerNZV1egy+ol+y7zmPm5JSwtfFolJFzFz0/GqwbojyqdSCMXFkKo2UWHzjY56Qd+w/5LIY
 INKo3X67lTNZsrLD8UfZm3LlrnJvjqS3BwpbsvDuo9ofgAEwqOyXGccZ62q6/0jiTlNZio02vOT
 9+76dx3/BbeRekQbdvRo4vfXnHE6nZ/GllqGXPOeNBv1xl4JYdjRtP0XCSQn+hZiVdig3HktaQj
 IgyHwMbxnWDVdkvJpdmXREFBUsjt6l4Q18FfD254jA8dIa+AvLB2SZEmry57gdTBBF2g88q5JIj
 QQUFRqoWAGD0xRSQIgZefDUaAHoe5k47Ztl/7EvSPtjBP34IUIdDBHMUsJFRVjhNQyoUCaJk7oY
 Kyecb0YEGyO/EM1zFkTEqOVnxLAVk4pF
X-Received: by 2002:a17:90b:5847:b0:3ac:17c:6e89 with SMTP id
 98e67ed59e1d1-3ae89773f17mr244310a91.19.1793311800386; 
 Thu, 29 Oct 2026 15:10:00 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:97b0:7603:db48:102e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85f662basm344514a91.1.2026.10.29.15.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:09:59 -0700 (PDT)
Date: Thu, 29 Oct 2026 16:09:57 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Gavin Shan <gshan@redhat.com>, michael.roth@amd.com,
 berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <auPENXGj6cVN1lSt@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain> <ataBkrIvULJXj4v6@p14s>
 <784dfea3-24cb-4e70-ab46-b96b4b9a1831@redhat.com>
 <at-Wkw7a3Tn3Oh3M@red-moon>
 <auF8rstVcvsDUO6C@FCCLS0092175.localdomain> <auO3OKQGWiqtTcWU@p14s>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auO3OKQGWiqtTcWU@p14s>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 03:14:32PM -0600, Mathieu Poirier wrote:
> On Wed, Oct 28, 2026 at 01:51:29PM +0900, Kohei Enju wrote:
> > On 10/26 19:06, Lorenzo Pieralisi wrote:
> > > On Wed, Oct 21, 2026 at 11:42:14PM +1000, Gavin Shan wrote:
> > > > On 10/20/26 6:46 AM, Mathieu Poirier wrote:
> > > > > On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
> > > > > > On 09/22 10:01, Lorenzo Pieralisi wrote:
> > > > > > > On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > > > > > > > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > > > > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > > > 
> > > > > > > > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > > > > > > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > > > > > > > passing on the command-line:
> > > > > > > > > 
> > > > > > > > >    -M virt,confidential-guest-support=<id>
> > > > > > > > >    -object rme-guest,id=<id>
> > > > > > > > > 
> > > > > > > > > This is only the skeleton. Support will be added in following patches.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > > > > ---
> > > > > > > > >   docs/system/confidential-guest-support.rst |  1 +
> > > > > > > > >   qapi/qom.json                              | 13 +++++++
> > > > > > > > >   target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > > > > > > >   target/arm/meson.build                     |  5 ++-
> > > > > > > > >   4 files changed, 60 insertions(+), 1 deletion(-)
> > > > > > > > >   create mode 100644 target/arm/kvm-rme.c
> > > > > > > > > 
> > > > > > > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > > > > > > index 562a7c3c2852..abb56923ad13 100644
> > > > > > > > > --- a/docs/system/confidential-guest-support.rst
> > > > > > > > > +++ b/docs/system/confidential-guest-support.rst
> > > > > > > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > > > > > > >   * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > > > > > > >   * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > > > > > > >   * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > > > > > > +* Arm Realm Management Extension (RME)
> > > > > > > > >   Other mechanisms may be supported in future.
> > > > > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > > > > index 776b13027fd8..52997c29a32d 100644
> > > > > > > > > --- a/qapi/qom.json
> > > > > > > > > +++ b/qapi/qom.json
> > > > > > > > > @@ -1288,6 +1288,17 @@
> > > > > > > > >     'data': { '*pretty': 'bool',
> > > > > > > > >               '*close-action': 'MonitorQMPCloseAction' } }
> > > > > > > > > +##
> > > > > > > > > +# @RmeGuestProperties:
> > > > > > > > > +#
> > > > > > > > > +# Properties for rme-guest objects.
> > > > > > > > > +#
> > > > > > > > > +# Since: 11.1
> > > > > > > > > +##
> > > > > > > > > +{ 'struct': 'RmeGuestProperties',
> > > > > > > > > +  'base': 'ConfidentialGuestSupportProperties',
> > > > > > > > 
> > > > > > > > Just FYI, based on input from Markus I'm planning to drop this
> > > > > > > > ConfidentialGuestSupportProperties base type from my series
> > > > > > > > since it's probably only SNP/TDX that need to be able to switch
> > > > > > > > it on/off, whereas this series appears to use/require it from
> > > > > > > > the start.
> > > > > > > > 
> > > > > > > > I'm not exactly sure what it will look like for v3 yet, but if you
> > > > > > > > were based on v2 you'd instead probably just do the following in the
> > > > > > > > instance_init function for your rme-guest instance:
> > > > > > > > 
> > > > > > > >    cgs->allow_convert_in_place = true;
> > > > > > > >    cgs->convert_in_place = true;
> > > > > > > > 
> > > > > > > > rather than exposing it as a cmdline option.
> > > > > > > 
> > > > > > > Yep, it won't be an option for CCA Realms anyway since that will be
> > > > > > > the baseline.
> > > > > > 
> > > > > > IIUC, in-place conversion requires RAM backed by a shared/mappable
> > > > > > guest_memfd. If in-place conversion is always enabled for CCA Realms,
> > > > > > could QEMU also select the equivalent of
> > > > > > 
> > > > > >    -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> > > > > > 
> > > > > > automatically for the default RAM, so that specifying the RAM size with
> > > > > > `-m` is sufficient?
> > > > > 
> > > > > Are you suggesting that on Arm, we completely get rid of
> > > > > 
> > > > >      -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on
> > > > > 
> > > > > or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> > > > > with "-m $(RAMSIZE)"?
> > > > > 
> > > > > Gavin and Michael, what is your take on that suggestion?
> > > > > 
> > > > 
> > > > I don't think that's what Kohei meant. He actually suggested the memory backend
> > > > shall be pinned to memory-backend-guest-memfd and its in-place conversion shall
> > > > be enabled when the memory backend isn't explicitly specified by users through
> > > > "-object memory-backend-xxxx". For this inexplicit case, where the memory backend
> > > > is determined by '-mem-path', the memory backend is either TYPE_MEMORY_BACKEND_FILE
> > > > or TYPE_MEMORY_BACKEND_RAM. Please refer to create_default_memdev().
> > > > 
> > > > I think Kohei's suggestion makes sense. Besides, I think '-mem-path' should be
> > > > disallowed for CCA Realms as TYPE_MEMORY_BACKEND_FILE isn't what we want.
> > > 
> > > Kohei, what were you suggesting then please ? I think TYPE_MEMORY_BACKEND_FILE
> > > would not pass the checks required by Michael's v3 [0] on CCA - I will test this
> > > and report back but the only backend allowed, rightly, is memfd,share=on, so it
> > > _is_ disallowed.
> > 
> > Sorry for the late response.
> > 
> > To clarify, I meant the latter: when rme-guest is selected and the user
> > has not explicitly provided a memory backend, QEMU could automatically
> > create the default RAM as a shared guest-memfd backend.
> > 
> > In other words, rather than only rejecting the default file/RAM backend,
> > the Realm configuration could select the equivalent of
> > 
> >   -object memory-backend-guest-memfd,id=<default-ram-id>,size=<RAMSIZE>,share=on
> > 
> > by default. Explicitly specified memory backends would still need to be
> > validated against the Realm requirements.
> > 
> > My intention was that, if in-place conversion is the baseline for CCA
> > Realms, `-m <size>` should be sufficient for the common Realm case,
> > while preserving an explicit memory-backend option for users who need to
> > control it.
> 
> Many thanks for the clarification, it is very helpful.  I will look into
> implementing something along those lines for V6 and we can reconsider how to
> move forward at that time.  

And then I read Michael's comment again, and again and again...

> 
> Thanks,
> Mathieu
> 
> > 
> > That said, I do not have a strong preference for deciding the default
> > `-m` behavior at this stage. If it is premature to make that decision
> > before the memory-backend and conversion interfaces have settled, I am
> > happy to keep the explicit guest-memfd backend requirement for now and
> > revisit the default behavior later.
> > 

For the time being I will hold back on moving forward with this request.  Let's
revisit at some point in the future.

> > Thanks,
> > Kohei
> > 
> > > 
> > > Lorenzo
> > > 
> > > [0] https://lore.kernel.org/kvm/20261007134323.1606088-1-michael.roth@amd.com/
> > > 
> > > > Thanks,
> > > > Gavin
> > > > 
> > > > > Thanks,
> > > > > Mathieu
> > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Kohei
> > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Lorenzo
> > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > 
> > > > > > > > Mike
> > > > > > > > 
> > > > > > > > > +  'data': {} }
> > > > > > > > > +
> > > > > > > > >   ##
> > > > > > > > >   # @ObjectType:
> > > > > > > > >   #
> > > > > > > > > @@ -1346,6 +1357,7 @@
> > > > > > > > >       { 'name': 'pr-manager-helper',
> > > > > > > > >         'if': 'CONFIG_LINUX' },
> > > > > > > > >       'qtest',
> > > > > > > > > +    'rme-guest',
> > > > > > > > >       'rng-builtin',
> > > > > > > > >       'rng-egd',
> > > > > > > > >       { 'name': 'rng-random',
> > > > > > > > > @@ -1427,6 +1439,7 @@
> > > > > > > > >         'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > > > > > > >                                         'if': 'CONFIG_LINUX' },
> > > > > > > > >         'qtest':                      'QtestProperties',
> > > > > > > > > +      'rme-guest':                  'RmeGuestProperties',
> > > > > > > > >         'rng-builtin':                'RngProperties',
> > > > > > > > >         'rng-egd':                    'RngEgdProperties',
> > > > > > > > >         'rng-random':                 { 'type': 'RngRandomProperties',
> > > > > > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..42e1d1e7b859
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/target/arm/kvm-rme.c
> > > > > > > > > @@ -0,0 +1,42 @@
> > > > > > > > > +/*
> > > > > > > > > + * QEMU Arm RME support
> > > > > > > > > + *
> > > > > > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > > > + *
> > > > > > > > > + * Copyright Linaro 2026
> > > > > > > > > + */
> > > > > > > > > +
> > > > > > > > > +#include "qemu/osdep.h"
> > > > > > > > > +
> > > > > > > > > +#include "hw/core/boards.h"
> > > > > > > > > +#include "hw/core/cpu.h"
> > > > > > > > > +#include "kvm_arm.h"
> > > > > > > > > +#include "migration/blocker.h"
> > > > > > > > > +#include "qapi/error.h"
> > > > > > > > > +#include "qom/object_interfaces.h"
> > > > > > > > > +#include "system/confidential-guest-support.h"
> > > > > > > > > +#include "system/kvm.h"
> > > > > > > > > +#include "system/runstate.h"
> > > > > > > > > +
> > > > > > > > > +#define TYPE_RME_GUEST "rme-guest"
> > > > > > > > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > > > > > > > +
> > > > > > > > > +struct RmeGuest {
> > > > > > > > > +    ConfidentialGuestSupport parent_obj;
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > > > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > > > > > > +                                          { TYPE_USER_CREATABLE }, { })
> > > > > > > > > +
> > > > > > > > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > > > > > > > +{
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void rme_guest_init(Object *obj)
> > > > > > > > > +{
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void rme_guest_finalize(Object *obj)
> > > > > > > > > +{
> > > > > > > > > +}
> > > > > > > > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > > > > > > > index 0369f96b4cc6..9d322a7aad28 100644
> > > > > > > > > --- a/target/arm/meson.build
> > > > > > > > > +++ b/target/arm/meson.build
> > > > > > > > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > > > > > > > >   arm_common_system_ss.add(files(
> > > > > > > > >     'arm-qmp-cmds.c',
> > > > > > > > >   ))
> > > > > > > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > > > > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > > > > > > +  'hyp_gdbstub.c',
> > > > > > > > > +  'kvm.c',
> > > > > > > > > +  'kvm-rme.c'))
> > > > > > > > >   arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > > > > > > >   arm_user_ss.add(files('cpu.c'))
> > > > > > > > > -- 
> > > > > > > > > 2.43.0
> > > > > > > > > 
> > > > > > > > > 
> > > > > 
> > > > 

