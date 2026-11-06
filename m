Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE0606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVurARni
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIxY-0004aU-Ns; Fri, 06 Nov 2026 07:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPIwb-0004FZ-Tm
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:21:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPIwY-0007u9-KE
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967677;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oAD7WKSGToakozziCMvvfK3T1gXU5+WM47oZ0DsL9U=;
 b=fVurARniXPWWFnMAMU6CYDHAViiwubnqN+k/a/qrnIPP2kZHxfdXC8VdYfUDvvnWPj+aLM
 9Ua//+q+70qWLvWQmgkEFLMnrNz6uvLw5p9wo/r3mF54vMeYM1VzlGQIzOrP4Y6GZoKAbh
 WI86jv6MGG4OHQPPLvuGHl0nO4RvS0M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-7d9RaXtaNHOwWXGcoO_eJw-1; Fri,
 06 Nov 2026 07:21:14 -0500
X-MC-Unique: 7d9RaXtaNHOwWXGcoO_eJw-1
X-Mimecast-MFC-AGG-ID: 7d9RaXtaNHOwWXGcoO_eJw_1793967673
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF19619560B9; Fri,  6 Nov 2026 12:21:12 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8FBA1956089; Fri,  6 Nov 2026 12:21:09 +0000 (UTC)
Date: Fri, 6 Nov 2026 12:21:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 08/28] hw/usb: mark commonly used USB devices/hosts as
 secure
Message-ID: <au3GMul0v2BSPP5M@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-9-berrange@redhat.com>
 <31de7814-4be9-4224-9659-854cdffe409f@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31de7814-4be9-4224-9659-854cdffe409f@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 01:05:05PM +0100, Thomas Huth wrote:
> On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> > Modern virtualized guests are expected to be deployed with the
> > XHCI controller which supports all of USB 1, 2 and 3, so should
> > be declared secure.
> > 
> > The "NEC" XHCI variant is slightly non-standard, but since it is
> > a trivial sub-class of the generic XHCI, there's no reason to
> > exclude it.
> > 
> > The set of devices that are expected to be used is HID (mouse,
> > tablet, keyboard), host passthrough, CCID (smartcard), hub,
> > storage and the redirect tunnelling.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   hw/usb/ccid-card-emulated.c   | 1 +
> >   hw/usb/ccid-card-passthru.c   | 1 +
> >   hw/usb/dev-hid.c              | 3 +++
> >   hw/usb/dev-hub.c              | 1 +
> >   hw/usb/dev-smartcard-reader.c | 2 ++
> >   hw/usb/dev-storage-bot.c      | 1 +
> >   hw/usb/dev-storage-classic.c  | 1 +
> >   hw/usb/hcd-xhci-nec.c         | 1 +
> >   hw/usb/hcd-xhci-pci.c         | 1 +
> >   hw/usb/hcd-xhci-sysbus.c      | 3 ++-
> >   hw/usb/hcd-xhci.c             | 1 +
> >   hw/usb/host-libusb.c          | 1 +
> >   hw/usb/redirect.c             | 1 +
> >   13 files changed, 17 insertions(+), 1 deletion(-)
> ...
> > diff --git a/hw/usb/dev-storage-bot.c b/hw/usb/dev-storage-bot.c
> > index a7f8d80c17a..b156f1c5c9a 100644
> > --- a/hw/usb/dev-storage-bot.c
> > +++ b/hw/usb/dev-storage-bot.c
> > @@ -52,6 +52,7 @@ static const TypeInfo bot_info = {
> >       .name          = "usb-bot",
> >       .parent        = TYPE_USB_STORAGE,
> >       .class_init    = usb_msd_class_bot_initfn,
> > +    .secure        = true,
> >   };
> >   static void register_types(void)
> > diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
> > index 977151c4a08..7e0699cb518 100644
> > --- a/hw/usb/dev-storage-classic.c
> > +++ b/hw/usb/dev-storage-classic.c
> > @@ -133,6 +133,7 @@ static const TypeInfo msd_info = {
> >       .parent        = TYPE_USB_STORAGE,
> >       .class_init    = usb_msd_class_storage_initfn,
> >       .instance_init = usb_msd_instance_init,
> > +    .secure        = true,
> >   };
> Can we exclude usb-bot and usb-storage from the secure list? I've never seen
> them really being used for real virtualization installations, and I think
> they are not that well tested?

We've shipped them as part of RHEL essentially forever so from a
downstream POV we're on the hook to support them.

I would see them as a way to provide adhoc removable storage to a
VM which doesn't require any special drivers, since everything
supports USB storage for 20+ years. We don't have a SCSI controller
beyond virtio-scsi that's declared secure, and SCSI isn't
accessible to unprivileged users, so USB is useful for desktop
virtualization use cases IMHO.

> 
> With those two hunks being removed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


