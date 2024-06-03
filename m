Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF44C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE63p-0006bB-S6; Mon, 03 Jun 2024 07:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE63n-0006aU-4G
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE63i-0003oD-FN
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717414860;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKHXnJkat+uHI1yav1+9+tpLjkVqX1a2hkex4OsaKGA=;
 b=YUGk50y24QrvVG0aGb9xYtvm1/9qtx4oAqoy4WE74iRFMTlm91tYUvAMaAND+0izqu3FJ3
 FxPWdFdbfsfWDKLb31HdhCtA4G6W2fmkZjxpra0U0YfHdopyo+kXEb5eW9kFZM+M8i/R2S
 tqs2fjJR2w/3ImygfhippD4PGiHCNFI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-xkmjkT2RPNGNcN5QZB-zDg-1; Mon,
 03 Jun 2024 07:40:56 -0400
X-MC-Unique: xkmjkT2RPNGNcN5QZB-zDg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B9821C0512B;
 Mon,  3 Jun 2024 11:40:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6801A40147E;
 Mon,  3 Jun 2024 11:40:54 +0000 (UTC)
Date: Mon, 3 Jun 2024 12:40:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/4] vga/cirrus: deprecate, don't build by default
Message-ID: <Zl2rxIYdohROHXbg@redhat.com>
References: <20240530112718.1752905-1-kraxel@redhat.com>
 <20240530112718.1752905-5-kraxel@redhat.com>
 <3efcf132-dec1-3765-e77e-3fd207224eeb@eik.bme.hu>
 <c928e9e7-21b2-4017-be45-b0a4b91f1d06@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c928e9e7-21b2-4017-be45-b0a4b91f1d06@ilande.co.uk>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

On Thu, May 30, 2024 at 01:22:11PM +0100, Mark Cave-Ayland wrote:
> On 30/05/2024 12:40, BALATON Zoltan wrote:
> 
> > On Thu, 30 May 2024, Gerd Hoffmann wrote:
> > > stdvga is the much better option.
> > > 
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > > hw/display/cirrus_vga.c     | 1 +
> > > hw/display/cirrus_vga_isa.c | 1 +
> > > hw/display/Kconfig          | 1 -
> > > 3 files changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> > > index 150883a97166..81421be1f89d 100644
> > > --- a/hw/display/cirrus_vga.c
> > > +++ b/hw/display/cirrus_vga.c
> > > @@ -3007,6 +3007,7 @@ static void cirrus_vga_class_init(ObjectClass
> > > *klass, void *data)
> > >     dc->vmsd = &vmstate_pci_cirrus_vga;
> > >     device_class_set_props(dc, pci_vga_cirrus_properties);
> > >     dc->hotpluggable = false;
> > > +    klass->deprecation_note = "use stdvga instead";
> > > }
> > > 
> > > static const TypeInfo cirrus_vga_info = {
> > > diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
> > > index 84be51670ed8..3abbf4dddd90 100644
> > > --- a/hw/display/cirrus_vga_isa.c
> > > +++ b/hw/display/cirrus_vga_isa.c
> > > @@ -85,6 +85,7 @@ static void isa_cirrus_vga_class_init(ObjectClass
> > > *klass, void *data)
> > >     dc->realize = isa_cirrus_vga_realizefn;
> > >     device_class_set_props(dc, isa_cirrus_vga_properties);
> > >     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> > > +    klass->deprecation_note = "use stdvga instead";
> > 
> > Excepr some old OSes work better with this than stdvga so could this be
> > left and not removed? Does it cause a lot of work to keep this device? I
> > thought it's stable already and were not many changes for it lately. If
> > something works why drop it?
> 
> Seconded: whilst stdvga is preferred, there are a lot of older OSs that work
> well in QEMU using the Cirrus emulation. I appreciate that the code could do
> with a bit of work, but is there a more specific reason that it should be
> deprecated?

I think there's different answers here for upstream vs downstream.

Upstream QEMU's scope is to emulate pretty much arbitrary hardware that
may have existed at any point in time. Emulating Cirrus is very much
in scope upstream, and even if there are other better VGA devices, that
doesn't make emulation of Cirrus redundant.

Downstream is a different matter - if a downstream vendor wants to be
opinionated and limit the scope of devices they ship to customers, it
is totally valid to cull Cirrus.

IOW, I think device deprecation *framework* is relevant to include
upstream, but most actual usage of it will be downstream.

Upstream might use *object* deprecation, if we replace an backend
implementation with a different one.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


