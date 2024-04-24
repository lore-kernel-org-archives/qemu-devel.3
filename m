Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4276EC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 20:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzjTM-00031g-2z; Wed, 24 Apr 2024 16:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rzjTK-00031R-8M
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:44:06 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rzjTH-0003T2-U8
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:44:05 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-479c0e8b1c5so101682137.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713991442; x=1714596242; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7NENGB7+MujexqzIEOAAiN7hFLIusJj6R3eldhfPdkQ=;
 b=hQKEQoZyX4TSUfNUxlcd2Ni3iKHTeTktfGTlGaNMrAnIkhwplcyCjY9eJCrgw+0rv0
 cDb7lxEzxAoUZjp7r7rI0NE8B+X4gLGTyYcPzCO7bPbJbQdwyD2eWif5BMRnDhcSlnsz
 gniyjEq3Lc24PdhHkN2lOetK9Hr/gQxCUrgL6qhCW0n0amn4+zLMMV0Lxshf+UHpK4a5
 l44ugK1FhTH8AmULTQIlehFqg6Wue5ppQqgYAeUG1bSyV6V2i6WlUW/3pTQcdPWOJDrn
 LeXMtdpfxfUsY0NT9H1GvuIvKSmjcTCvINOtR8OD7IQdD2PjlEk0BwoI5dEcDOWhJSs6
 UxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713991442; x=1714596242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7NENGB7+MujexqzIEOAAiN7hFLIusJj6R3eldhfPdkQ=;
 b=gBIgdUsjKxms+cJUB0CuxQSLR9CuO1OBMXrg+gv4jOv9XlvxPQKhjRL2CYJn44MieJ
 +YIUvGmIhUR4qhCzKhwIwwL6pduukA6DXboT1h3JqK4QN5ELOfXPl+m7kgcFKVI6P8Pl
 xh50bVhYPr6XV5Ia15rr6okwBEBK1lEiaKCym8Ls4u+LzCh1AQoM75Ie8X6rk+5shKFb
 zfySJ7AeikNix9+ur5EULIhATk3GCR03FRTfIznxaNyRCxRVYi1B2kSi4eNTT0RXPqQx
 9PGEKMLVyVD8vZV0YGQXX4Rengs3YWD1Y+bgCFY2hymdyHh2fdEuDamJVWhx027RruAO
 NUUw==
X-Gm-Message-State: AOJu0Yw8y6CaisvvvthmqNMIp51WfNK89YRYDC8wcu9qw/4t1R0I7ED7
 JZZlRVgSy8JBh2IOS4d59Vk3UGxtYwMqMf0s+801rUH0MfFhHKprYLMH8GTyb9LRBljRnNdFKGQ
 9+/cFcHseRE7WK2oCGOvOVlTaTMc=
X-Google-Smtp-Source: AGHT+IHh0p34fkpOhScEkp2Ko+tBBaQmXzb4sILeNfSKAfzIwDrmY/bdYpnnJitLTARKCdDnyQfg2TXiOXMDq8XWjzI=
X-Received: by 2002:a67:e207:0:b0:47b:b673:5fd4 with SMTP id
 g7-20020a67e207000000b0047bb6735fd4mr4182765vsa.28.1713991442440; Wed, 24 Apr
 2024 13:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
In-Reply-To: <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Wed, 24 Apr 2024 15:43:51 -0500
Message-ID: <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000132dcc0616ddbb5c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=dmamfmgm@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, HTML_MESSAGE=0.001,
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

--000000000000132dcc0616ddbb5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 10:43=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> w=
rote:

> 06.02.2024 10:13, Cord Amfmgm wrote:
> > This changes the ohci validation to not assert if invalid
> > data is fed to the ohci controller. The poc suggested in
> > https://bugs.launchpad.net/qemu/+bug/1907042
> > and then migrated to bug #303 does the following to
> > feed it a SETUP pid and EndPt of 1:
> >
> >          uint32_t MaxPacket =3D 64;
> >          uint32_t TDFormat =3D 0;
> >          uint32_t Skip =3D 0;
> >          uint32_t Speed =3D 0;
> >          uint32_t Direction =3D 0;  /* #define OHCI_TD_DIR_SETUP 0 */
> >          uint32_t EndPt =3D 1;
> >          uint32_t FuncAddress =3D 0;
> >          ed->attr =3D (MaxPacket << 16) | (TDFormat << 15) | (Skip << 1=
4)
> >                     | (Speed << 13) | (Direction << 11) | (EndPt << 7)
> >                     | FuncAddress;
> >          ed->tailp =3D /*TDQTailPntr=3D */ 0;
> >          ed->headp =3D ((/*TDQHeadPntr=3D */ &td[0]) & 0xfffffff0)
> >                     | (/* ToggleCarry=3D */ 0 << 1);
> >          ed->next_ed =3D (/* NextED=3D */ 0 & 0xfffffff0)
> >
> > qemu-fuzz also caught the same issue in #1510. They are
> > both fixed by this patch.
> >
> > The if (td.cbp > td.be) logic in ohci_service_td() causes an
> > ohci_die(). My understanding of the OHCI spec 4.3.1.2
> > Table 4-2 allows td.cbp to be one byte more than td.be to
> > signal the buffer has zero length. The new check in qemu
> > appears to have been added since qemu-4.2. This patch
> > includes both fixes since they are located very close
> > together.
> >
> > Signed-off-by: David Hubbard <dmamfmgm@gmail.com>
>
> Wonder if this got lost somehow.  Or is it not needed?
>
> Thanks,
>
> /mjt
>

Friendly ping! Gerd, can you chime in with how you would like to approach
this? I still need this patch to unblock my qemu workflow - custom OS
development.


>
> > diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> > index d73b53f33c..a53808126f 100644
> > --- a/hw/usb/hcd-ohci.c
> > +++ b/hw/usb/hcd-ohci.c
> > @@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci,
> > struct ohci_ed *ed)
> >       case OHCI_TD_DIR_SETUP:
> >           str =3D "setup";
> >           pid =3D USB_TOKEN_SETUP;
> > +        if (OHCI_BM(ed->flags, ED_EN) > 0) {  /* setup only allowed to
> ep 0 */
> > +            trace_usb_ohci_td_bad_pid(str, ed->flags, td.flags);
> > +            ohci_die(ohci);
> > +            return 1;
> > +        }
> >           break;
> >       default:
> >           trace_usb_ohci_td_bad_direction(dir);
> > @@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
> > ohci_ed *ed)
> >           if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
> >               len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
> >           } else {
> > -            if (td.cbp > td.be) {
> > -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> > +            if (td.cbp > td.be + 1) {
> > +                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
> >                   ohci_die(ohci);
> >                   return 1;
> >               }
> > diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> > index ed7dc210d3..b47d082fa3 100644
> > --- a/hw/usb/trace-events
> > +++ b/hw/usb/trace-events
> > @@ -28,6 +28,8 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len)
> > "DataOverrun %d > %zu"
> >   usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
> >   usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
> >   usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
> > +usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) "Bad cbp =3D 0x%x > be =
=3D
> 0x%x"
> > +usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad
> > pid %s: ed.flags 0x%x td.flags 0x%x"
> >   usb_ohci_port_attach(int index) "port #%d"
> >   usb_ohci_port_detach(int index) "port #%d"
> >   usb_ohci_port_wakeup(int index) "port #%d"
> >
>

--000000000000132dcc0616ddbb5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 18, 2024 at 10:43=E2=80=
=AFAM Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru" target=3D"_blan=
k">mjt@tls.msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">06.02.2024 10:13, Cord Amfmgm wrote:<br>
&gt; This changes the ohci validation to not assert if invalid<br>
&gt; data is fed to the ohci controller. The poc suggested in<br>
&gt; <a href=3D"https://bugs.launchpad.net/qemu/+bug/1907042" rel=3D"norefe=
rrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1907042</a><br=
>
&gt; and then migrated to bug #303 does the following to<br>
&gt; feed it a SETUP pid and EndPt of 1:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t MaxPacket =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t TDFormat =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t Skip =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t Speed =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t Direction =3D 0;=C2=A0 /* #=
define OHCI_TD_DIR_SETUP 0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t EndPt =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t FuncAddress =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ed-&gt;attr =3D (MaxPacket &lt;&lt; =
16) | (TDFormat &lt;&lt; 15) | (Skip &lt;&lt; 14)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| (Speed &lt;&lt; 13) | (Direction &lt;&lt; 11) | (EndPt &lt;&lt; 7)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| FuncAddress;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ed-&gt;tailp =3D /*TDQTailPntr=3D */=
 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ed-&gt;headp =3D ((/*TDQHeadPntr=3D =
*/ &amp;td[0]) &amp; 0xfffffff0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| (/* ToggleCarry=3D */ 0 &lt;&lt; 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ed-&gt;next_ed =3D (/* NextED=3D */ =
0 &amp; 0xfffffff0)<br>
&gt; <br>
&gt; qemu-fuzz also caught the same issue in #1510. They are<br>
&gt; both fixed by this patch.<br>
&gt; <br>
&gt; The if (td.cbp &gt; <a href=3D"http://td.be" rel=3D"noreferrer" target=
=3D"_blank">td.be</a>) logic in ohci_service_td() causes an<br>
&gt; ohci_die(). My understanding of the OHCI spec 4.3.1.2<br>
&gt; Table 4-2 allows td.cbp to be one byte more than <a href=3D"http://td.=
be" rel=3D"noreferrer" target=3D"_blank">td.be</a> to<br>
&gt; signal the buffer has zero length. The new check in qemu<br>
&gt; appears to have been added since qemu-4.2. This patch<br>
&gt; includes both fixes since they are located very close<br>
&gt; together.<br>
&gt; <br>
&gt; Signed-off-by: David Hubbard &lt;<a href=3D"mailto:dmamfmgm@gmail.com"=
 target=3D"_blank">dmamfmgm@gmail.com</a>&gt;<br>
<br>
Wonder if this got lost somehow.=C2=A0 Or is it not needed?<br>
<br>
Thanks,<br>
<br>
/mjt<br></blockquote><div><br></div><div>Friendly ping! Gerd, can you chime=
 in with how you would like to approach this? I still need this patch to un=
block my qemu workflow - custom OS development.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c<br>
&gt; index d73b53f33c..a53808126f 100644<br>
&gt; --- a/hw/usb/hcd-ohci.c<br>
&gt; +++ b/hw/usb/hcd-ohci.c<br>
&gt; @@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci,<br>
&gt; struct ohci_ed *ed)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case OHCI_TD_DIR_SETUP:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0str =3D &quot;setup&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pid =3D USB_TOKEN_SETUP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (OHCI_BM(ed-&gt;flags, ED_EN) &gt; 0) =
{=C2=A0 /* setup only allowed to ep 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohci_td_bad_pid(s=
tr, ed-&gt;flags, td.flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ohci_die(ohci);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_usb_ohci_td_bad_directio=
n(dir);<br>
&gt; @@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct=
<br>
&gt; ohci_ed *ed)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((td.cbp &amp; 0xfffff000) =
!=3D (<a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</=
a> &amp; 0xfffff000)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D (<a href=
=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &amp; 0xff=
f) + 0x1001 - (td.cbp &amp; 0xfff);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"=
http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a>) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohc=
i_iso_td_bad_cc_overrun(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer"=
 target=3D"_blank">td.be</a>);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"=
http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> + 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohc=
i_td_bad_buf(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"=
_blank">td.be</a>);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0oh=
ci_die(ohci);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/hw/usb/trace-events b/hw/usb/trace-events<br>
&gt; index ed7dc210d3..b47d082fa3 100644<br>
&gt; --- a/hw/usb/trace-events<br>
&gt; +++ b/hw/usb/trace-events<br>
&gt; @@ -28,6 +28,8 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len)<b=
r>
&gt; &quot;DataOverrun %d &gt; %zu&quot;<br>
&gt;=C2=A0 =C2=A0usb_ohci_iso_td_data_underrun(int ret) &quot;DataUnderrun =
%d&quot;<br>
&gt;=C2=A0 =C2=A0usb_ohci_iso_td_nak(int ret) &quot;got NAK/STALL %d&quot;<=
br>
&gt;=C2=A0 =C2=A0usb_ohci_iso_td_bad_response(int ret) &quot;Bad device res=
ponse %d&quot;<br>
&gt; +usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) &quot;Bad cbp =3D 0x%x=
 &gt; be =3D 0x%x&quot;<br>
&gt; +usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) &quot;=
Bad<br>
&gt; pid %s: ed.flags 0x%x td.flags 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0usb_ohci_port_attach(int index) &quot;port #%d&quot;<br>
&gt;=C2=A0 =C2=A0usb_ohci_port_detach(int index) &quot;port #%d&quot;<br>
&gt;=C2=A0 =C2=A0usb_ohci_port_wakeup(int index) &quot;port #%d&quot;<br>
&gt;<br>
</blockquote></div></div>

--000000000000132dcc0616ddbb5c--

