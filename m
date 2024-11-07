Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5C3D4336D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 15:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t94SJ-0000mU-8C; Thu, 07 Nov 2024 10:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t94SF-0000mD-6m
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t94SB-0001P8-Qa
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730993385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l1r0Z81EjXEulL94PUtsqjIl9X/kH9C/l95EnoWjmaI=;
 b=JSso7/vwl4fSs6IVy02y9Hvs27qUvcBdAuwy0AGsym47wqdBawTrzAsTyx40dAyi/TtFjK
 IUABipI1ewGcdoTdEWpRMqNcCPvxW42QWCPBmxB+DGJVU0VyfEb0Q+LyZjGT4kJxEgP1NY
 gnEoqikcPt8/gQgDz8EU0daJAou6suo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-AbE7Q25TMcqnOHV-iew_pA-1; Thu, 07 Nov 2024 10:29:43 -0500
X-MC-Unique: AbE7Q25TMcqnOHV-iew_pA-1
X-Mimecast-MFC-AGG-ID: AbE7Q25TMcqnOHV-iew_pA
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7180cb79f3cso1160733a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 07:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730993382; x=1731598182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1r0Z81EjXEulL94PUtsqjIl9X/kH9C/l95EnoWjmaI=;
 b=rstHsuXn8EtRr0/XycK3UjBUrfUZiMx/WxLUsVPpR7VqAICfiAc+ndvrPvNOYwKUU8
 SmfEVkKkjOfMdARTiHpMIylP0llfNhHnm+CMWgYZ/UXSdMlFhg7eAECcrFx4I2OqEBgE
 xcApMSmmM2x+vx/GLVhotspzN7PVlfIKxGlWg5ctHoKNevEEQodsDswKVfeYJE+8Z6G5
 ms4oR3CjNS2kSrD2F4M5vaUuJEK7G1tSMXlt2e9Wy/lLOZc90qWrfxgj6AJBsRHMXX52
 wp2qKBF2VGeW4Hy21yPPi85r90SlmHDVWpg/idRony+JDQBEbdYXagiH/jBJPa30ElNY
 m4sQ==
X-Gm-Message-State: AOJu0YwCCz/d/SPvxCcaybabqG0//GHCvOyTKYaRWAEJasfMkGDYbowD
 xn6ovDlf+xoZ4E818S3UXHDkXUPvFmd0oMy5UDfqrYjDmX/U13p6hD/dKjmVIIQ3amLNKQGC+0y
 GMkyqaHMDR2o+ZnPSGhjkawH+NXvpJ05snONMk2MkFQtmMF/4XDez
X-Received: by 2002:a05:6830:7001:b0:718:9f3e:6bcb with SMTP id
 46e09a7af769-719ca190145mr25465065a34.10.1730993382429; 
 Thu, 07 Nov 2024 07:29:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHucaHE1U9NjquVEAcqo4VbtWCOI7fk42gnhBItvUw8M82Mep/lQJDjRlX2QBbOiHUPZ2Ph2Q==
X-Received: by 2002:a05:6830:7001:b0:718:9f3e:6bcb with SMTP id
 46e09a7af769-719ca190145mr25465025a34.10.1730993382048; 
 Thu, 07 Nov 2024 07:29:42 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32acae4e1sm72987485a.74.2024.11.07.07.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 07:29:41 -0800 (PST)
Date: Thu, 7 Nov 2024 10:29:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/4] x86/iommu: Make x86-iommu a singleton object
Message-ID: <Zyzc4kSQ6zuRePsF@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-3-peterx@redhat.com>
 <87jzdwlekc.fsf@pond.sub.org> <ZxwT79JG0NzsDmPn@x1n>
 <ZxwYBeLGDLkTL0PJ@x1n> <87jzdfl2lx.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzdfl2lx.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 07, 2024 at 12:12:10PM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Oct 25, 2024 at 05:55:59PM -0400, Peter Xu wrote:
> >> On Fri, Oct 25, 2024 at 11:25:23AM +0200, Markus Armbruster wrote:
> >> > Peter Xu <peterx@redhat.com> writes:
> >> > 
> >> > > X86 IOMMUs cannot be created more than one on a system yet.  Make it a
> >> > > singleton so it guards the system from accidentally create yet another
> >> > > IOMMU object when one already presents.
> >> > >
> >> > > Now if someone tries to create more than one, e.g., via:
> >> > >
> >> > >   ./qemu -M q35 -device intel-iommu -device intel-iommu
> >> > >
> >> > > The error will change from:
> >> > >
> >> > >   qemu-system-x86_64: -device intel-iommu: QEMU does not support multiple vIOMMUs for x86 yet.
> >> > >
> >> > > To:
> >> > >
> >> > >   qemu-system-x86_64: -device intel-iommu: Class 'intel-iommu' only supports one instance
> >> > >
> >> > > Unfortunately, yet we can't remove the singleton check in the machine
> >> > > hook (pc_machine_device_pre_plug_cb), because there can also be
> >> > > virtio-iommu involved, which doesn't share a common parent class yet.
> >> > >
> >> > > But with this, it should be closer to reach that goal to check singleton by
> >> > > QOM one day.
> >> > >
> >> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > 
> >> > $ qemu-system-x86_64 -device amd-iommu,help
> >> > /work/armbru/qemu/include/hw/boards.h:24:MACHINE: Object 0x56473906f960 is not an instance of type machine
> >> > Aborted (core dumped)
> 
> [...]
> 
> >> Thanks for the report!
> >> 
> >> It turns out that qdev_get_machine() cannot be invoked too early, and the
> >> singleton code can make it earlier..
> >> 
> >> We may want a pre-requisite patch to allow qdev_get_machine() to be invoked
> >> anytime, like:
> >> 
> >> ===8<===
> >> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> >> index db36f54d91..7ceae47139 100644
> >> --- a/hw/core/qdev.c
> >> +++ b/hw/core/qdev.c
> >> @@ -831,6 +831,16 @@ Object *qdev_get_machine(void)
> >>  {
> >>      static Object *dev;
> >>  
> >> +    if (!phase_check(PHASE_MACHINE_CREATED)) {
> >> +        /*
> >> +         * When the machine is not created, below can wrongly create
> >> +         * /machine to be a container.. this enables qdev_get_machine() to
> >> +         * be used at any time and return NULL properly when machine is not
> >> +         * created.
> >> +         */
> >> +        return NULL;
> >> +    }
> >> +
> >>      if (dev == NULL) {
> >>          dev = container_get(object_get_root(), "/machine");
> >>      }
> >> ===8<===
> >> 
> >> I hope it makes sense on its own.
> >
> > My apologies, spoke too soon here.  This helper is used too after machine
> > is created, but right before switching to PHASE_MACHINE_CREATE stage..
> 
> container_get() is a trap.

I had the same feeling..  Though I'd confess I'm not familiar enough with
this part of code.

> 
> When the object to be gotten is always "container", it merely
> complicates container creation: it's implicitly created on first get.
> Which of the calls creates may be less than obvious.
> 
> When the object to be gotten is something else, such as a machine,
> container_get() before creation is *wrong*, and will lead to trouble
> later.
> 
> In my opinion:
> 
> * Hiding creation in getters is a bad idea unless creation has no
>   material side effects.
> 
> * Getting anything but a container with container_get() is in bad taste.

Agreed.

IMHO container_get() interface might still be ok to implicitly create
containers, but only if it will: (1) always make sure what it walks is a
container along the way, and (2) never return any non-container.

> 
> 
> > So we need another way, like:
> >
> > ===8<===
> >
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index db36f54d91..36a9fdb428 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -832,7 +832,13 @@ Object *qdev_get_machine(void)
> >      static Object *dev;
> >  
> >      if (dev == NULL) {
> > -        dev = container_get(object_get_root(), "/machine");
> > +        /*
> > +         * NOTE: dev can keep being NULL if machine is not yet created!
> > +         * In which case the function will properly return NULL.
> > +         *
> > +         * Whenever machine object is created and found once, we cache it.
> > +         */
> > +        dev = object_resolve_path_component(object_get_root(), "machine");
> >      }
> >  
> >      return dev;
> 
> Now returns null instead of a bogus container when called before machine
> creation.  Improvement of sorts.  But none of the callers expect null...
> shouldn't we assert(dev) here?
> 
> Hmm, below you add a caller that checks for null.
> 
> Another nice mess.

I plan to put aside the application of singletons to x86-iommu as of now,
due to the fact that qdev complexity may better be done separately.

IOW, before that, I wonder whether we should clean up the container_get()
as you discussed: it doesn't sound like a good interface to return
non-container objects.

I had a quick look, I only see two outliers of such, and besides the
"abuse" in qdev_get_machine(), the only other one is
e500_pcihost_bridge_realize():

*** hw/core/qdev.c:
qdev_get_machine[820]          dev = container_get(object_get_root(), "/machine");

*** hw/pci-host/ppce500.c:
e500_pcihost_bridge_realize[422] PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),

If any of us thinks this is the right way to go, I can try to clean it up
(for 10.0).  qdev_get_machine() may still need to be able to return NULL
when singleton applies to IOMMUs, but that can be for later.  Before that,
we can still assert(qdev), I think.

Just to mention I've posted rfcv2 for this series, again feel free to
ignore patch 3-5 as of now:

[PATCH RFC v2 0/7] QOM: Singleton interface
https://lore.kernel.org/r/20241029211607.2114845-1-peterx@redhat.com

I think the plan is Dan may keep collecting feedbacks on his other rfc:

[RFC 0/5] RFC: require error handling for dynamically created objects
https://lore.kernel.org/r/20241031155350.3240361-1-berrange@redhat.com

Then after Dan's lands, I'll rebase my rfcv2 on top of his, dropping
iommu/qdev changes.

Thanks,

-- 
Peter Xu


