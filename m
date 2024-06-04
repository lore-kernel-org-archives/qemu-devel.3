Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D90C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPBX-00020e-B5; Tue, 04 Jun 2024 04:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEPBO-0001yj-Q3
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEPBM-00070N-Fa
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717488371;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHFq8Q0KaPVlMwmMywlUitZDICEqPEl3YMDqe0o4abQ=;
 b=JHrbI2NOCUzgsNb4TZsZpc1U556U9Fjk6iPSZyO9TJN3a9vc6tzhpbZyMsrTt4CFIRiWt5
 ZnH7NVjXDbKr8UK+aBVfeq3Zzgr6zcq4FFMem2LRQR87FpLE0DAJeOysQWzuZuxsC4QEdn
 rRGA1WmxMAkKGaGVU9WZizDM0pyvsGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-BbMh_rgaNESpO3V45mhdNg-1; Tue, 04 Jun 2024 04:06:07 -0400
X-MC-Unique: BbMh_rgaNESpO3V45mhdNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8DEB811E8D;
 Tue,  4 Jun 2024 08:06:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D3D0408DA22;
 Tue,  4 Jun 2024 08:06:02 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:05:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/4] vga/cirrus: deprecate, don't build by default
Message-ID: <Zl7K5tEgGUeqPVKk@redhat.com>
References: <20240530112718.1752905-1-kraxel@redhat.com>
 <20240530112718.1752905-5-kraxel@redhat.com>
 <3efcf132-dec1-3765-e77e-3fd207224eeb@eik.bme.hu>
 <c928e9e7-21b2-4017-be45-b0a4b91f1d06@ilande.co.uk>
 <Zl2rxIYdohROHXbg@redhat.com>
 <b3a2ae5f-a6d1-4d13-a7e3-35f4b1417b88@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3a2ae5f-a6d1-4d13-a7e3-35f4b1417b88@ilande.co.uk>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 04, 2024 at 07:50:38AM +0100, Mark Cave-Ayland wrote:
> On 03/06/2024 12:40, Daniel P. Berrangé wrote:
> 
> > On Thu, May 30, 2024 at 01:22:11PM +0100, Mark Cave-Ayland wrote:
> > > On 30/05/2024 12:40, BALATON Zoltan wrote:
> > > 
> > > > On Thu, 30 May 2024, Gerd Hoffmann wrote:
> > > > > stdvga is the much better option.
> > > > > 
> > > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > > ---
> > > > > hw/display/cirrus_vga.c     | 1 +
> > > > > hw/display/cirrus_vga_isa.c | 1 +
> > > > > hw/display/Kconfig          | 1 -
> > > > > 3 files changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> > > > > index 150883a97166..81421be1f89d 100644
> > > > > --- a/hw/display/cirrus_vga.c
> > > > > +++ b/hw/display/cirrus_vga.c
> > > > > @@ -3007,6 +3007,7 @@ static void cirrus_vga_class_init(ObjectClass
> > > > > *klass, void *data)
> > > > >      dc->vmsd = &vmstate_pci_cirrus_vga;
> > > > >      device_class_set_props(dc, pci_vga_cirrus_properties);
> > > > >      dc->hotpluggable = false;
> > > > > +    klass->deprecation_note = "use stdvga instead";
> > > > > }
> > > > > 
> > > > > static const TypeInfo cirrus_vga_info = {
> > > > > diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
> > > > > index 84be51670ed8..3abbf4dddd90 100644
> > > > > --- a/hw/display/cirrus_vga_isa.c
> > > > > +++ b/hw/display/cirrus_vga_isa.c
> > > > > @@ -85,6 +85,7 @@ static void isa_cirrus_vga_class_init(ObjectClass
> > > > > *klass, void *data)
> > > > >      dc->realize = isa_cirrus_vga_realizefn;
> > > > >      device_class_set_props(dc, isa_cirrus_vga_properties);
> > > > >      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> > > > > +    klass->deprecation_note = "use stdvga instead";
> > > > 
> > > > Excepr some old OSes work better with this than stdvga so could this be
> > > > left and not removed? Does it cause a lot of work to keep this device? I
> > > > thought it's stable already and were not many changes for it lately. If
> > > > something works why drop it?
> > > 
> > > Seconded: whilst stdvga is preferred, there are a lot of older OSs that work
> > > well in QEMU using the Cirrus emulation. I appreciate that the code could do
> > > with a bit of work, but is there a more specific reason that it should be
> > > deprecated?
> > 
> > I think there's different answers here for upstream vs downstream.
> > 
> > Upstream QEMU's scope is to emulate pretty much arbitrary hardware that
> > may have existed at any point in time. Emulating Cirrus is very much
> > in scope upstream, and even if there are other better VGA devices, that
> > doesn't make emulation of Cirrus redundant.
> > 
> > Downstream is a different matter - if a downstream vendor wants to be
> > opinionated and limit the scope of devices they ship to customers, it
> > is totally valid to cull Cirrus.
> 
> The concern for me is that if someone such as RedHat decided not to ship
> Cirrus then we'd end up in a place where command lines for some legacy OSs
> would work on an upstream build, but if someone was using RHEL then they
> would fail due to the device not being present. I can see this causing
> confusion for users since they would report that a command line doesn't work
> whilst others would shrug and report back that it works for them.

That ship sailed in RHEL over a decade and a half ago.

There is already a mountain of devices and other QEMU features that are
/not/ shipped in RHEL, disabled at build time. Essentially RHEL is only
targetting virtualization use cases, not emulation, so the priority is
virtio devices, paired with a tiny handful of emulated devices to fill
some gaps. Historically RHEL included Cirrus, but it was marked deprecated
in RHEL quite a few years ago now, and will likely be removed entirely
in RHEL-10. The combo of stdvga and virtio-vga/gpu is sufficient for the
virtualization use case.

Yes, this does cause confusion and annoyance for users who want to try
to use RHEL with QEMU cli configs they find around the web, but that's
considered acceptable pain.

> I do wonder if a solution for this would be to add a blocklist file in /etc
> that prevents the listed QOM types from being instantiated. The file could
> contain also contain a machine regex to match and a reason that can be
> reported to the user e.g.
> 
> # QEMU QOM type blocklist
> #
> # QOM type regex, machine regex list, reason
> "cirrus*","pc*,machine*","contains insecure blitter routines"
> "fdc","pc*","may not be completely secure"
> 
> This feels like a better solution because:
> 
> - It's easy to add a message that reports "The requested QOM type <foo>
> cannot be instantiated because <reason>" for specific machine types. The
> machine regex also fixes the problem where usb-ohci should be allowed for
> PPC machines, but not generally for PC machines.
> 
> - Downstream can ship with a secure policy for production environments but
> also a less restrictive policy for more casual users
>
> - If someone really needs a device that is not enabled by default, a
> privileged user can simply edit the blocklist file and allow it
> 
> - It should work both with or without modules

I don't see a user edittable config being useful in RHEL or Fedora.
For RHEL we have a strict policy of only shipping what we want to
support, and everything else must be fully disabled at build time.
Conversely in Fedora we aim to ship everything that QEMU provides.

I would be nice to have a tagging of "quality" status for devices
upstream, but that's not something that needs to be turned into a
user edittable matrix against machine types. A device impl is either
good or not - the code impl quality doesn't vary per machine usage,
nor should upstream try to artificially block usage per machine.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


