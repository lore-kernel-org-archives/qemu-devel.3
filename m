Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8F8C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 15:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4jEE-0000jQ-Rr; Wed, 08 May 2024 11:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s4jEC-0000jA-Tx
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:29:08 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s4jEA-0005ol-Mj
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:29:08 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7f3317ff3c2so1475606241.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715182145; x=1715786945; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/10wyPI4q1uco1SsZv99383x6cFUbIZMzlIS7hGPswE=;
 b=YceGdjXgtrRBi67Pof4JxPAd3nArbW26o0QlR9K7iB8l9E9EldZM4TBiH4v51qXo5S
 DKkxQBIClx9SeUx+3CXzIcqjtnmKOMiSmU9UwKhM4Z/l5QgRuwtZT+Rc0oPAkFu0OGPP
 tiIebE+AW4SEV9RVM6Vo4534q/Dd8aizI+Eq0sWhnfzGrybh0xz8X0WGe8CE6fw8tRqX
 1/PiEBDGXUQGXyh5xbJcKAzEPIcQSNUxSDSGt6xYaZBtHLIiEQaThFj+ONko0nMroNYr
 JNvEreHpkKUugP7h/L2Q9ZwAlWyJZ+js0VFnNUbSqRMrctBBb/Tgyl+aJe5MvJd+49EZ
 brMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715182145; x=1715786945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/10wyPI4q1uco1SsZv99383x6cFUbIZMzlIS7hGPswE=;
 b=emIhYpzeahOhRiDZ89onPMpWToxT6XiDGmr9xrpe1K3O0L8dwE40lnkHDrHjo18eCh
 vRMur1jUsmGMf2WErKoHbl/cxtOUCQuSYOcbvVXAbH2m/s02pBWiwPF3qaEigsUTj7hn
 dAvVaUDVbe1ovM78SMdEgxEVdsPra8rI5H3CJcNgsHY83WjN4SGRsswqTh/lt6J1VPDz
 c2n45IyZfIWuxru1owZz3WYkZw6ltNhXoepAIVtf2Dbb0lkk5PvUnjNuAGWL6wfzlPPP
 8oYctUsiubuxXhHk6lorU7c7ip0FLpxOq13sj55CzA4uRYE6qJjKftwXm8el4wqmcOhF
 E9Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPkRGXVuOg66Ji+TuHSK5qi5gDRc937EBofxJUtCD6ZDrA8Dsac3PoPP/GQ/Yw1FYYi7cf8PDYKWRZmsigBwzzqCHGBWk=
X-Gm-Message-State: AOJu0YxaMOnAw1Isl53GdgBBO+CPE0+bu4lAYmVW6/qyuvjxp6WOmaer
 s5uD9YZGhyA69ZVQFTrjK35oTVQuT0jimqckURRxM+c1Mc0gSxiiR1a+Wk9e7Iad7fifqjVU9J/
 aHf2CWEJ6uL8027j3KB2r3necGp8=
X-Google-Smtp-Source: AGHT+IF6BwiBTQasBfo/4NZ6c3WgIuAdBr7ivV57oOoZnf65JXfSn4o91074SgQEW1AaBb4SZivqWYjqaP5NrquMdiw=
X-Received: by 2002:a05:6102:b03:b0:47c:2fd4:e1f8 with SMTP id
 ada2fe7eead31-47f3c38c4b0mr3369516137.33.1715182145186; Wed, 08 May 2024
 08:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
 <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
 <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
 <8dadea4d-ab16-4102-93e6-61559fb5b00c@linaro.org>
In-Reply-To: <8dadea4d-ab16-4102-93e6-61559fb5b00c@linaro.org>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Wed, 8 May 2024 10:28:53 -0500
Message-ID: <CACBuX0QepgcGW=X9gYZzY9_9voZT1L+vstfqn_9FQmvpG0-sXQ@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007d38230617f2f66e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000007d38230617f2f66e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:53=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 7/5/24 22:20, Cord Amfmgm wrote:
> >
> >
> > On Wed, Apr 24, 2024 at 3:43=E2=80=AFPM Cord Amfmgm <dmamfmgm@gmail.com
> > <mailto:dmamfmgm@gmail.com>> wrote:
> >
> >     On Thu, Apr 18, 2024 at 10:43=E2=80=AFAM Michael Tokarev <mjt@tls.m=
sk.ru
> >     <mailto:mjt@tls.msk.ru>> wrote:
> >
> >         06.02.2024 10:13, Cord Amfmgm wrote:
> >          > This changes the ohci validation to not assert if invalid
> >          > data is fed to the ohci controller. The poc suggested in
> >          > https://bugs.launchpad.net/qemu/+bug/1907042
> >         <https://bugs.launchpad.net/qemu/+bug/1907042>
> >          > and then migrated to bug #303 does the following to
> >          > feed it a SETUP pid and EndPt of 1:
> >          >
> >          >          uint32_t MaxPacket =3D 64;
> >          >          uint32_t TDFormat =3D 0;
> >          >          uint32_t Skip =3D 0;
> >          >          uint32_t Speed =3D 0;
> >          >          uint32_t Direction =3D 0;  /* #define
> >         OHCI_TD_DIR_SETUP 0 */
> >          >          uint32_t EndPt =3D 1;
> >          >          uint32_t FuncAddress =3D 0;
> >          >          ed->attr =3D (MaxPacket << 16) | (TDFormat << 15) |
> >         (Skip << 14)
> >          >                     | (Speed << 13) | (Direction << 11) |
> >         (EndPt << 7)
> >          >                     | FuncAddress;
> >          >          ed->tailp =3D /*TDQTailPntr=3D */ 0;
> >          >          ed->headp =3D ((/*TDQHeadPntr=3D */ &td[0]) & 0xfff=
ffff0)
> >          >                     | (/* ToggleCarry=3D */ 0 << 1);
> >          >          ed->next_ed =3D (/* NextED=3D */ 0 & 0xfffffff0)
> >          >
> >          > qemu-fuzz also caught the same issue in #1510. They are
> >          > both fixed by this patch.
> >          >
> >          > The if (td.cbp > td.be <http://td.be>) logic in
> >         ohci_service_td() causes an
> >          > ohci_die(). My understanding of the OHCI spec 4.3.1.2
> >          > Table 4-2 allows td.cbp to be one byte more than td.be
> >         <http://td.be> to
> >          > signal the buffer has zero length. The new check in qemu
> >          > appears to have been added since qemu-4.2. This patch
> >          > includes both fixes since they are located very close
> >          > together.
> >          >
> >          > Signed-off-by: David Hubbard <dmamfmgm@gmail.com
> >         <mailto:dmamfmgm@gmail.com>>
> >
> >         Wonder if this got lost somehow.  Or is it not needed?
> >
> >         Thanks,
> >
> >         /mjt
> >
> >
> >     Friendly ping! Gerd, can you chime in with how you would like to
> >     approach this? I still need this patch to unblock my qemu workflow =
-
> >     custom OS development.
> >
> >
> > Can I please ask for an update on this? I'm attempting to figure out if
> > this patch has been rejected and I need to resubmit / rework it at HEAD=
?
> >
> >
> >          > diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> >          > index d73b53f33c..a53808126f 100644
> >          > --- a/hw/usb/hcd-ohci.c
> >          > +++ b/hw/usb/hcd-ohci.c
> >          > @@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState
> *ohci,
> >          > struct ohci_ed *ed)
> >          >       case OHCI_TD_DIR_SETUP:
> >          >           str =3D "setup";
> >          >           pid =3D USB_TOKEN_SETUP;
> >          > +        if (OHCI_BM(ed->flags, ED_EN) > 0) {  /* setup only
> >         allowed to ep 0 */
> >          > +            trace_usb_ohci_td_bad_pid(str, ed->flags,
> td.flags);
> >          > +            ohci_die(ohci);
> >          > +            return 1;
> >          > +        }
> >          >           break;
>
> I made a comment on April 18 but it is not showing on the list...
>
> https://lore.kernel.org/qemu-devel/593072d7-614b-4197-9c9a-12bb70c31d31@l=
inaro.org/
>
> It was:
>
>  > Please split in 2 different patches.
>
> Even if closely related, it simplifies the workflow to have
> single fix in single commit; for example if one is invalid,
> we can revert it and not the other.
>

Sure, I can submit 2 separate patches. I'm unfamiliar with how to get those
to show up in this patch request, I assume it's not too bad if I submit
that as a separate patch request?

On Wed, May 8, 2024 at 3:45=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:

> Your Signed-off-by line does not match the From: line ... could you pleas=
e
> fix this? (see
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emai=
ls-must-include-a-signed-off-by-line
> , too)


I'll submit the new patch request with my pseudonym in the From: and
Signed-off-by: lines, per your request. Doesn't matter to me. However, this
arises simply because I don't give gmail my real name -
https://en.wikipedia.org/wiki/Nymwars


>
> >          >       default:
> >          >           trace_usb_ohci_td_bad_direction(dir);
> >          > @@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState
> >         *ohci, struct
> >          > ohci_ed *ed)
> >          >           if ((td.cbp & 0xfffff000) !=3D (td.be <http://td.b=
e>
> >         & 0xfffff000)) {
> >          >               len =3D (td.be <http://td.be> & 0xfff) + 0x100=
1 -
> >         (td.cbp & 0xfff);
> >          >           } else {
> >          > -            if (td.cbp > td.be <http://td.be>) {
> >          > -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp=
,
> >         td.be <http://td.be>);
> >          > +            if (td.cbp > td.be <http://td.be> + 1) {
> >          > +                trace_usb_ohci_td_bad_buf(td.cbp, td.be
> >         <http://td.be>);
> >          >                   ohci_die(ohci);
> >          >                   return 1;
> >          >               }
> >          > diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> >          > index ed7dc210d3..b47d082fa3 100644
> >          > --- a/hw/usb/trace-events
> >          > +++ b/hw/usb/trace-events
> >          > @@ -28,6 +28,8 @@ usb_ohci_iso_td_data_overrun(int ret,
> >         ssize_t len)
> >          > "DataOverrun %d > %zu"
> >          >   usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
> >          >   usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
> >          >   usb_ohci_iso_td_bad_response(int ret) "Bad device response
> %d"
> >          > +usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) "Bad cbp =3D
> >         0x%x > be =3D 0x%x"
> >          > +usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t
> >         tdf) "Bad
> >          > pid %s: ed.flags 0x%x td.flags 0x%x"
> >          >   usb_ohci_port_attach(int index) "port #%d"
> >          >   usb_ohci_port_detach(int index) "port #%d"
> >          >   usb_ohci_port_wakeup(int index) "port #%d"
> >          >
> >
>
>

--0000000000007d38230617f2f66e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 8, 2024 at 4:53=E2=80=AFA=
M Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phil=
md@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On 7/5/24 22:20, Cord Amfmgm wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Apr 24, 2024 at 3:43=E2=80=AFPM Cord Amfmgm &lt;<a href=3D"mai=
lto:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"_blank">dma=
mfmgm@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Thu, Apr 18, 2024 at 10:43=E2=80=AFAM Michael To=
karev &lt;<a href=3D"mailto:mjt@tls.msk.ru" target=3D"_blank">mjt@tls.msk.r=
u</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:mjt@tls.msk.ru" target=
=3D"_blank">mjt@tls.msk.ru</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A006.02.2024 10:13, Cord Amfmgm wrote:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; This changes the ohci validatio=
n to not assert if invalid<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; data is fed to the ohci control=
ler. The poc suggested in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://bugs.launchp=
ad.net/qemu/+bug/1907042" rel=3D"noreferrer" target=3D"_blank">https://bugs=
.launchpad.net/qemu/+bug/1907042</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://bugs.launchpad=
.net/qemu/+bug/1907042" rel=3D"noreferrer" target=3D"_blank">https://bugs.l=
aunchpad.net/qemu/+bug/1907042</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; and then migrated to bug #303 d=
oes the following to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; feed it a SETUP pid and EndPt o=
f 1:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t MaxPacket =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t TDFormat =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t Skip =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t Speed =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t Direction =3D 0;=C2=A0 /* #define<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OHCI_TD_DIR_SETUP 0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t EndPt =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t FuncAddress =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ed-&gt;attr =3D (MaxPacket &lt;&lt; 16) | (TDFormat &lt;&lt; 15) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(Skip &lt;&lt; 14)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (Speed &lt;&lt; 13) | (Direc=
tion &lt;&lt; 11) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(EndPt &lt;&lt; 7)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| FuncAddress;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ed-&gt;tailp =3D /*TDQTailPntr=3D */ 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ed-&gt;headp =3D ((/*TDQHeadPntr=3D */ &amp;td[0]) &amp; 0xfffffff0)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (/* ToggleCarry=3D */ 0 &lt;=
&lt; 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ed-&gt;next_ed =3D (/* NextED=3D */ 0 &amp; 0xfffffff0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; qemu-fuzz also caught the same =
issue in #1510. They are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; both fixed by this patch.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; The if (td.cbp &gt; <a href=3D"=
http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &lt;<a href=3D=
"http://td.be" rel=3D"noreferrer" target=3D"_blank">http://td.be</a>&gt;) l=
ogic in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ohci_service_td() causes an<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; ohci_die(). My understanding of=
 the OHCI spec 4.3.1.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Table 4-2 allows td.cbp to be o=
ne byte more than <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_bl=
ank">td.be</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://td.be" rel=3D"n=
oreferrer" target=3D"_blank">http://td.be</a>&gt; to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; signal the buffer has zero leng=
th. The new check in qemu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; appears to have been added sinc=
e qemu-4.2. This patch<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; includes both fixes since they =
are located very close<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; together.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: David Hubbard &l=
t;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.co=
m</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:dmamfmgm=
@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Wonder if this got lost somehow.=C2=
=A0 Or is it not needed?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/mjt<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Friendly ping! Gerd, can you chime in with how you =
would like to<br>
&gt;=C2=A0 =C2=A0 =C2=A0approach this? I still need this patch to unblock m=
y qemu workflow -<br>
&gt;=C2=A0 =C2=A0 =C2=A0custom OS development.<br>
&gt; <br>
&gt; <br>
&gt; Can I please ask for an update on this? I&#39;m attempting to figure o=
ut if <br>
&gt; this patch has been rejected and I need to resubmit / rework it at HEA=
D?<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/usb/hcd-ohci.c =
b/hw/usb/hcd-ohci.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; index d73b53f33c..a53808126f 10=
0644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/usb/hcd-ohci.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/usb/hcd-ohci.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; @@ -927,6 +927,11 @@ static int=
 ohci_service_td(OHCIState *ohci,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; struct ohci_ed *ed)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case =
OHCI_TD_DIR_SETUP:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0str =3D &quot;setup&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pid =3D USB_TOKEN_SETUP;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (OHCI_BM(ed-&gt;flags, ED_EN) &gt; 0) {=C2=A0 /* setup only<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allowed to ep 0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 trace_usb_ohci_td_bad_pid(str, ed-&gt;flags, td.flags);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ohci_die(ohci);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
<br>
I made a comment on April 18 but it is not showing on the list...<br>
<a href=3D"https://lore.kernel.org/qemu-devel/593072d7-614b-4197-9c9a-12bb7=
0c31d31@linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.kern=
el.org/qemu-devel/593072d7-614b-4197-9c9a-12bb70c31d31@linaro.org/</a><br>
<br>
It was:<br>
<br>
=C2=A0&gt; Please split in 2 different patches.<br>
<br>
Even if closely related, it simplifies the workflow to have<br>
single fix in single commit; for example if one is invalid,<br>
we can revert it and not the other.<br></blockquote><div><br></div><div>Sur=
e, I can submit 2 separate patches. I&#39;m unfamiliar with how to get thos=
e to show up in this patch request, I assume it&#39;s not too bad if I subm=
it that as a separate patch request?</div><div>=C2=A0</div><div><div dir=3D=
"ltr" class=3D"gmail_attr">On Wed, May 8, 2024 at 3:45=E2=80=AFAM Thomas Hu=
th &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Your Signed-off-=
by line does not match the From: line ... could you please<br>fix this? (se=
e<br><a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch.h=
tml#patch-emails-must-include-a-signed-off-by-line" rel=3D"noreferrer" targ=
et=3D"_blank">https://www.qemu.org/docs/master/devel/submitting-a-patch.htm=
l#patch-emails-must-include-a-signed-off-by-line</a><br>, too)</blockquote>=
<div><br></div><div>I&#39;ll submit the new patch request with my pseudonym=
 in the From: and Signed-off-by: lines, per your request. Doesn&#39;t matte=
r to me. However, this arises simply because I don&#39;t give gmail my real=
 name -=C2=A0<a href=3D"https://en.wikipedia.org/wiki/Nymwars">https://en.w=
ikipedia.org/wiki/Nymwars</a></div><div>=C2=A0<br></div></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0defau=
lt:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0trace_usb_ohci_td_bad_direction(dir);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; @@ -936,8 +941,8 @@ static int =
ohci_service_td(OHCIState<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ohci, struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; ohci_ed *ed)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if ((td.cbp &amp; 0xfffff000) !=3D (<a href=3D"http://td.be" rel=
=3D"noreferrer" target=3D"_blank">td.be</a> &lt;<a href=3D"http://td.be" re=
l=3D"noreferrer" target=3D"_blank">http://td.be</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; 0xfffff000)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0len =3D (<a href=3D"http://td.be" rel=3D"noreferrer=
" target=3D"_blank">td.be</a> &lt;<a href=3D"http://td.be" rel=3D"noreferre=
r" target=3D"_blank">http://td.be</a>&gt; &amp; 0xfff) + 0x1001 -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(td.cbp &amp; 0xfff);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"http://td.be" rel=3D"noreferrer" t=
arget=3D"_blank">td.be</a> &lt;<a href=3D"http://td.be" rel=3D"noreferrer" =
target=3D"_blank">http://td.be</a>&gt;) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://td.be" rel=3D"noref=
errer" target=3D"_blank">td.be</a> &lt;<a href=3D"http://td.be" rel=3D"nore=
ferrer" target=3D"_blank">http://td.be</a>&gt;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"http://td.be" rel=3D"noreferrer" t=
arget=3D"_blank">td.be</a> &lt;<a href=3D"http://td.be" rel=3D"noreferrer" =
target=3D"_blank">http://td.be</a>&gt; + 1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohci_td_bad_buf(td.cbp, <a href=3D"ht=
tp://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://td.be" rel=3D"n=
oreferrer" target=3D"_blank">http://td.be</a>&gt;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ohci_die(ohci);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/usb/trace-event=
s b/hw/usb/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; index ed7dc210d3..b47d082fa3 10=
0644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/usb/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/usb/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; @@ -28,6 +28,8 @@ usb_ohci_iso_=
td_data_overrun(int ret,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &quot;DataOverrun %d &gt; %zu&q=
uot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0usb_ohci_iso_td_dat=
a_underrun(int ret) &quot;DataUnderrun %d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0usb_ohci_iso_td_nak=
(int ret) &quot;got NAK/STALL %d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0usb_ohci_iso_td_bad=
_response(int ret) &quot;Bad device response %d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +usb_ohci_td_bad_buf(uint32_t c=
bp, uint32_t be) &quot;Bad cbp =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x%x &gt; be =3D 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; +usb_ohci_td_bad_pid(const char=
 *s, uint32_t edf, uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tdf) &quot;Bad<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; pid %s: ed.flags 0x%x td.flags =
0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0usb_ohci_port_attac=
h(int index) &quot;port #%d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0usb_ohci_port_detac=
h(int index) &quot;port #%d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0usb_ohci_port_wakeu=
p(int index) &quot;port #%d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000007d38230617f2f66e--

