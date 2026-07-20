Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B04AC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmZj-0008SF-5v; Mon, 20 Jul 2026 07:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timo.teras@gmail.com>)
 id 1wlmZe-0008Rf-7R
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:54:19 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timo.teras@gmail.com>)
 id 1wlmZb-0003Xv-RS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:54:17 -0400
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7eb63dbd229so2247910a34.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784548454; x=1785153254;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7kELQ8t+LDEX0C4kGuwieMAsNtxfKr2VYrYjD1QKjdI=;
 b=ldhozvsBlejHIk8EdHb2Twt3Z8PYQ+O+FUA0myiW0IcAl4zY4VG8ZseyUl6MQBGFPk
 w8V8abTQK6e0AWwv1Q1wzYcMUde1ylHT/H2XjxJTApaLmKs4UKtU8qGo4L+IxTgPk0vt
 wi6jAvzjgfoiq3ucDxcqBmCk+NHw4iBeQBrdjyaDYFz7JpfXkrNFYa9rPdX8qTAJr/vt
 fjqIgyV1yVHCoZydcHzPrxli7E9/2JjSqOCxpFFsRHJXjBu1KphMHbtIB+D7LZTMCEO6
 9vnkW0fV3pcJBOYRL35V0SA/jjRzoLjZ/fOF4dSBGz/YOyjQuI/Drql4a4986SGwA8Ni
 pDmw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeBwzqJRdJn6/SNL7QK/FSBUbvx0r8rkQ8d943NgboeTLw89jZ3kJMGNi0VLtmmOQ/HB7mI48A6O1g@nongnu.org
X-Gm-Message-State: AOJu0YwQX2Wrf2vYXuVzpy+g0fCBgo4t86uPvIdDKAZl9GhzPnDfsGRf
 Yb/aQsuNUQRyN/XQh/PKSPs5tA4XCSepyUEzlhBVZlARacoQR+nQhQ6yuFCmb1v8
X-Gm-Gg: AfdE7cl37HDok5RoHF9aEndI5v4Zk6Q5wt1kriiVdN1begiE+RAmnB4NAZVMeJpLjvg
 OQ2/nndaTCyRhqxtiGofJ9q0oL7tT2151yFqH4I56p2P6j9Yed8lryg6q1SFYly8+C67Kw+U7Jd
 UfQZVNvSIUTjH6fCeIMBFtpkMBgmgD54Nsd1WZAquApbQZYjV5mZOHfbPKcVRSLH9tfWbjf6s6M
 Xkio4fxs/qMEt7RUFxK2d2jAGc5G4zvDi8GnMx5H8xOKbJFoezkyDtz9hJdHHhYFRgDiiNTehnc
 KHAssWjAl9GkCLq/jh/gs1GaSSpzdnDbwdRf0MGn/kePvsM4L9DLCNXFCF56Msb+DaHFdDmPyFP
 Rx8Vnq0TA2BdxD8/t7RdfdsYkt24Qq3n27ovFsDW/t334cGCgK318W3OkT2ayV6oph5BqPaWRG2
 N3hGjlhDdcp8c41yDbFI0Qv+VU3fAqNFBWkyoJaGsJOr7pNQ==
X-Received: by 2002:a05:6830:7309:b0:7e9:dabf:fba0 with SMTP id
 46e09a7af769-7eda927fe99mr6496546a34.15.1784548453931; 
 Mon, 20 Jul 2026 04:54:13 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com.
 [209.85.160.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edaf94c13csm7977275a34.16.2026.07.20.04.54.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 04:54:13 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-44aeefa1c00so4966334fac.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:54:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoEOvcZB1hSq/TZigqr/ZEMrqjvnO1yOJfjTt5fs5x8MAODnos/cXiznN72359bXG0DuwieYKlgqszS@nongnu.org
X-Received: by 2002:a05:687c:3022:b0:43b:516f:5f0e with SMTP id
 586e51a60fabf-45660cc955bmr7383353fac.9.1784548452799; Mon, 20 Jul 2026
 04:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250912-usbhost-disconnect-v1-1-9c7c5fa9b50a@iki.fi>
 <bb76dd56-e97e-4d1c-aaf8-9eb55e6858b3@redhat.com>
 <al4GiC3G1u2lgTJD@sirius.home.kraxel.org>
In-Reply-To: <al4GiC3G1u2lgTJD@sirius.home.kraxel.org>
From: =?UTF-8?Q?Timo_Ter=C3=A4s?= <timo.teras@iki.fi>
Date: Mon, 20 Jul 2026 14:54:01 +0300
X-Gmail-Original-Message-ID: <CABTJ_OeeS8YW95jfdhB_YUfcvTa-zof8e6bXrdi3R8uQbMUoQA@mail.gmail.com>
X-Gm-Features: AUfX_mwrn6SgspX1aGUGBqVUpAu416OrajJAqQZtpw_miYIeqzK4icbFvjSc2Ug
Message-ID: <CABTJ_OeeS8YW95jfdhB_YUfcvTa-zof8e6bXrdi3R8uQbMUoQA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/host-libusb: keep autoscan enabled for bus+addr
 selector
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009d1c6706570990ef"
Received-SPF: pass client-ip=209.85.210.54; envelope-from=timo.teras@gmail.com;
 helo=mail-ot1-f54.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000009d1c6706570990ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

The more specific use case that does not work without this (not realized
until after writing issue/commit) is devices that need to switch modes, or
hot plugging new items to the specific physical port. In these scenarios
the original device disconnects and later new one connects to the port.
Detection of the new device does not work in any device combination without
this commit.

Timo


On Mon, 20 Jul 2026, 14.39 Gerd Hoffmann, <kraxel@redhat.com> wrote:

> On Mon, Jul 20, 2026 at 10:12:27AM +0200, Thomas Huth wrote:
> >
> >  Hi Gerd,
> >
> > since you originally wrote commit e058fa2dd599, could you maybe have a
> look
> > at this patch?
>
> Not sure what is going on here, I'm confident I had tested this back
> then.  Maybe behavior depends on the kind of usb device or libusb
> version or host os or a combination of those.  If disconnect detection
> does not work reliable (as written in the gitlab issue) turning
> autoscan back on should indeed fix it and it should also not cause
> other problems.
>
> Commit message should be a bit more verbose so it is not needed to
> visit gitlab for additional info.  With that:
>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>
> take care,
>   Gerd
>
> >
> >  Thanks,
> >   Thomas
> >
> >
> > On 12/09/2025 13.14, Timo Ter=C3=A4s wrote:
> > > This is partial revert of commit e058fa2dd599.
> > >
> > > The portion to immediately validate the device is kept, but this
> > > adds and enables again the autoscan functionality. This is needed
> > > to detect and relay USB device disconnect event to the guest.
> > >
> > > Fixes: e058fa2dd599 ("usb-host: add special case for bus+addr")
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3111
> > > Signed-off-by: Timo Ter=C3=A4s <timo.teras@iki.fi>
> > > ---
> > >   hw/usb/host-libusb.c | 14 ++++----------
> > >   1 file changed, 4 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> > > index
> b74670ae25696b5252f0d034cb9b759e338a050f..f0baf6b2f2d12fbf8feb5b788b46d31=
87028df58
> 100644
> > > --- a/hw/usb/host-libusb.c
> > > +++ b/hw/usb/host-libusb.c
> > > @@ -90,7 +90,6 @@ struct USBHostDevice {
> > >       uint32_t                         iso_urb_frames;
> > >       uint32_t                         options;
> > >       uint32_t                         loglevel;
> > > -    bool                             needs_autoscan;
> > >       bool                             allow_one_guest_reset;
> > >       bool                             allow_all_guest_resets;
> > >       bool                             suppress_remote_wake;
> > > @@ -1211,7 +1210,6 @@ static void usb_host_realize(USBDevice *udev,
> Error **errp)
> > >   #if LIBUSB_API_VERSION >=3D 0x01000107 && !defined(CONFIG_WIN32)
> > >       if (s->hostdevice) {
> > >           int fd;
> > > -        s->needs_autoscan =3D false;
> > >           fd =3D qemu_open(s->hostdevice, O_RDWR, errp);
> > >           if (fd < 0) {
> > >               return;
> > > @@ -1227,7 +1225,6 @@ static void usb_host_realize(USBDevice *udev,
> Error **errp)
> > >           !s->match.vendor_id &&
> > >           !s->match.product_id &&
> > >           !s->match.port) {
> > > -        s->needs_autoscan =3D false;
> > >           ldev =3D usb_host_find_ref(s->match.bus_num,
> > >                                    s->match.addr);
> > >           if (!ldev) {
> > > @@ -1242,14 +1239,13 @@ static void usb_host_realize(USBDevice *udev,
> Error **errp)
> > >                          s->match.bus_num, s->match.addr);
> > >               return;
> > >           }
> > > -    } else {
> > > -        s->needs_autoscan =3D true;
> > > -        QTAILQ_INSERT_TAIL(&hostdevs, s, next);
> > > -        usb_host_auto_check(NULL);
> > >       }
> > >       s->exit.notify =3D usb_host_exit_notifier;
> > >       qemu_add_exit_notifier(&s->exit);
> > > +
> > > +    QTAILQ_INSERT_TAIL(&hostdevs, s, next);
> > > +    usb_host_auto_check(NULL);
> > >   }
> > >   static void usb_host_instance_init(Object *obj)
> > > @@ -1267,9 +1263,7 @@ static void usb_host_unrealize(USBDevice *udev)
> > >       USBHostDevice *s =3D USB_HOST_DEVICE(udev);
> > >       qemu_remove_exit_notifier(&s->exit);
> > > -    if (s->needs_autoscan) {
> > > -        QTAILQ_REMOVE(&hostdevs, s, next);
> > > -    }
> > > +    QTAILQ_REMOVE(&hostdevs, s, next);
> > >       usb_host_close(s);
> > >   }
> > >
> > > ---
> > > base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d
> > > change-id: 20250912-usbhost-disconnect-192ecaa8fc3e
> > >
> > > Best regards,
> >
>
> --
>
>

--0000000000009d1c6706570990ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi!<div dir=3D"auto"><br></div><div dir=3D"auto">The more=
 specific use case that does not work without this (not realized until afte=
r writing issue/commit) is devices that need to switch modes, or hot pluggi=
ng new items to the specific physical port. In these scenarios the original=
 device disconnects and later new one connects to the port. Detection of th=
e new device does not work in any device combination without this commit.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Timo</div><br><br><div cl=
ass=3D"gmail_quote gmail_quote_container" dir=3D"auto"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Mon, 20 Jul 2026, 14.39 Gerd Hoffmann, &lt;<a href=3D"=
mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">On Mon, Jul 20, 2026 at 10:12:27AM +0200, Thomas Hu=
th wrote:<br>
&gt; <br>
&gt;=C2=A0 Hi Gerd,<br>
&gt; <br>
&gt; since you originally wrote commit e058fa2dd599, could you maybe have a=
 look<br>
&gt; at this patch?<br>
<br>
Not sure what is going on here, I&#39;m confident I had tested this back<br=
>
then.=C2=A0 Maybe behavior depends on the kind of usb device or libusb<br>
version or host os or a combination of those.=C2=A0 If disconnect detection=
<br>
does not work reliable (as written in the gitlab issue) turning<br>
autoscan back on should indeed fix it and it should also not cause<br>
other problems.<br>
<br>
Commit message should be a bit more verbose so it is not needed to<br>
visit gitlab for additional info.=C2=A0 With that:<br>
<br>
Acked-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">kraxel@redhat.com</a>&gt;<br>
<br>
take care,<br>
=C2=A0 Gerd<br>
<br>
&gt; <br>
&gt;=C2=A0 Thanks,<br>
&gt;=C2=A0 =C2=A0Thomas<br>
&gt; <br>
&gt; <br>
&gt; On 12/09/2025 13.14, Timo Ter=C3=A4s wrote:<br>
&gt; &gt; This is partial revert of commit e058fa2dd599.<br>
&gt; &gt; <br>
&gt; &gt; The portion to immediately validate the device is kept, but this<=
br>
&gt; &gt; adds and enables again the autoscan functionality. This is needed=
<br>
&gt; &gt; to detect and relay USB device disconnect event to the guest.<br>
&gt; &gt; <br>
&gt; &gt; Fixes: e058fa2dd599 (&quot;usb-host: add special case for bus+add=
r&quot;)<br>
&gt; &gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issue=
s/3111" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/=
qemu-project/qemu/-/issues/3111</a><br>
&gt; &gt; Signed-off-by: Timo Ter=C3=A4s &lt;<a href=3D"mailto:timo.teras@i=
ki.fi" target=3D"_blank" rel=3D"noreferrer">timo.teras@iki.fi</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0hw/usb/host-libusb.c | 14 ++++----------<br>
&gt; &gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 10 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c<br>
&gt; &gt; index b74670ae25696b5252f0d034cb9b759e338a050f..f0baf6b2f2d12fbf8=
feb5b788b46d3187028df58 100644<br>
&gt; &gt; --- a/hw/usb/host-libusb.c<br>
&gt; &gt; +++ b/hw/usb/host-libusb.c<br>
&gt; &gt; @@ -90,7 +90,6 @@ struct USBHostDevice {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iso_urb_frames;<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loglevel;<br>
&gt; &gt; -=C2=A0 =C2=A0 bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0needs_autoscan;<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allow_=
one_guest_reset;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allow_=
all_guest_resets;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0suppre=
ss_remote_wake;<br>
&gt; &gt; @@ -1211,7 +1210,6 @@ static void usb_host_realize(USBDevice *ude=
v, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0#if LIBUSB_API_VERSION &gt;=3D 0x01000107 &amp;&amp; =
!defined(CONFIG_WIN32)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;hostdevice) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int fd;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;needs_autoscan =3D false;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D qemu_open(s-&gt;ho=
stdevice, O_RDWR, errp);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; &gt; @@ -1227,7 +1225,6 @@ static void usb_host_realize(USBDevice *ude=
v, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!s-&gt;match.vendor_id &a=
mp;&amp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!s-&gt;match.product_id &=
amp;&amp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!s-&gt;match.port) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;needs_autoscan =3D false;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ldev =3D usb_host_find_re=
f(s-&gt;match.bus_num,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;match.add=
r);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ldev) {<br>
&gt; &gt; @@ -1242,14 +1239,13 @@ static void usb_host_realize(USBDevice *u=
dev, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;match.bus_num, s-&gt;match.addr);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 } else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;needs_autoscan =3D true;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_INSERT_TAIL(&amp;hostdevs, s,=
 next);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_host_auto_check(NULL);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;exit.notify =3D usb_host_exit_not=
ifier;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_add_exit_notifier(&amp;s-&gt;exit)=
;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_TAIL(&amp;hostdevs, s, next);<br>
&gt; &gt; +=C2=A0 =C2=A0 usb_host_auto_check(NULL);<br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0static void usb_host_instance_init(Object *obj)<br>
&gt; &gt; @@ -1267,9 +1263,7 @@ static void usb_host_unrealize(USBDevice *u=
dev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0USBHostDevice *s =3D USB_HOST_DEVICE(ud=
ev);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_remove_exit_notifier(&amp;s-&gt;ex=
it);<br>
&gt; &gt; -=C2=A0 =C2=A0 if (s-&gt;needs_autoscan) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;hostdevs, s, next=
);<br>
&gt; &gt; -=C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;hostdevs, s, next);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0usb_host_close(s);<br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt; <br>
&gt; &gt; ---<br>
&gt; &gt; base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d<br>
&gt; &gt; change-id: 20250912-usbhost-disconnect-192ecaa8fc3e<br>
&gt; &gt; <br>
&gt; &gt; Best regards,<br>
&gt; <br>
<br>
-- <br>
<br>
</blockquote></div></div>

--0000000000009d1c6706570990ef--

