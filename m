Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAD7E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOdjX-0000PB-PO; Fri, 20 Dec 2024 09:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tOdjW-0000Oy-Ma
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:12:02 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tOdjT-0008Oj-QO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:12:02 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-725f4623df7so1886894b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734703917; x=1735308717;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gxAjTE4QczM0CVS1R6BrzNTA8HmzDI9YQWV5xEVMiLg=;
 b=NxOY5mDpb/UhyduoWIhgT9N9+TojsCDHZVPQrpHnG7qK1shTdirPw+nWge7DO/fGFk
 8F4DhNxbW3kcWHqpL4y4N+fN3IgDjE9PFuyWBZ/6Y8T0l8siAZ5Psp4ox6w4rdQTOJ8n
 CuI12WbYvx3E0BNxB8SppKgGNaNAyV2zGtENOZmrTFTcNiDmrRx/t0SuaTGXSGH+o7Au
 laFfAoJJR3oIFWAr7bWxqipy8geulHERhqvas3gT9ScKaJYisgJfDB06XuvCIhAEhAZ4
 sFTERfojFYTDoay11DDFf+qqO0MLiVlL7O1LpMijWgqgR7NBxh/azVmByzPAKEhZZt8b
 BLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734703917; x=1735308717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxAjTE4QczM0CVS1R6BrzNTA8HmzDI9YQWV5xEVMiLg=;
 b=snTBoQXJizDEwVICkQNxTyBgA7YhfDDBtJQIL66N0iUR/k7Te2cIz4JR+qfL/vbtTu
 1E3ToGvHC4Ob1bGKhAKYUu0dSQaPekMnyJjxMxKGD1ZrURi9GnCReKXRmzsycEs2vOJ0
 ViB02TEe3BX25d9fwNCMGQH+cG6cxfN2C4pQSLQ/74wTHGW8Y680d4bC6ERZizq/P3gj
 uPRwvqJFvZtfeAyEeefRE3m5BCbgThMRSvOuRqSTDRuMmhowtKxAkujc4TJLEcEHyTbr
 3X1gt5dvMeS2fi/4DblPRzRZMV5qBwHPs4EXPSt2/tTNaYajg7N3MDR8/8rbmh+tVmjP
 akyQ==
X-Gm-Message-State: AOJu0Yx7ehzOWjQsPSc2WsE2y4W39b+qH048A9C48fL4A6XXpK4YxQbx
 mwEndv78HKZs1UOCJwynMOA399IfWxv3hjvIFvnQ/+plyjqSISgOjOeBEpnF09JcwyUC86KpkJE
 XfF6cXNkR4Nc6fys+WXlSo22tAm8C+tmFtW5o
X-Gm-Gg: ASbGnctUmkYbG/CVYZ5VDJdF+GhYFkKJMmskjzOW4DJbbcQ1YTFZ3q08AaCKiR/0SLt
 61KumLkqI4CD9BWBukz+C7072dHmEejjubDs1Dg==
X-Google-Smtp-Source: AGHT+IFn0byXqaN9NfwXhtbVMJbGspomMqU9XDFoqyD5+ud8XnH/I/HUa48gyoa73vp5rw2SgmdV7uP3VN9YoksGP1M=
X-Received: by 2002:a05:6a00:410d:b0:725:e5a7:fdac with SMTP id
 d2e1a72fcca58-72abe1ad517mr4596321b3a.26.1734703917417; Fri, 20 Dec 2024
 06:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20241212083502.1439033-1-npiggin@gmail.com>
 <20241212083502.1439033-6-npiggin@gmail.com>
 <CAGCz3vuUoRPk1UN2+_SqLtn_q5qu-RM7kmwTgNeRM2Mf75hoeg@mail.gmail.com>
 <D6FATQ1ETHB0.2WZ09SFCLAH5B@gmail.com>
In-Reply-To: <D6FATQ1ETHB0.2WZ09SFCLAH5B@gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 20 Dec 2024 15:11:46 +0100
Message-ID: <CAGCz3vv-O_tzaWTNsOFsr80doYskSOcwhNFvfPYKO3iad_3qLQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] hw/usb/xhci: Move HCD constants to a header and add
 register constants
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Content-Type: multipart/alternative; boundary="000000000000c9e2d30629b43a23"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::42d;
 envelope-from=lists@philjordan.eu; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000c9e2d30629b43a23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec 2024 at 02:50, Nicholas Piggin <npiggin@gmail.com> wrote:

> On Thu Dec 19, 2024 at 1:08 AM AEST, Phil Dennis-Jordan wrote:
> > This looks sensible to me overall.
> >
> > For the new symbolic constants for MMIO register offsets such as
> > XHCI_OPER_*, XHCI_INTR_* and so on, I'm wondering if it would be cleare=
r
> to
> > give them all an _OFFSET suffix. It's not perfectly consistent to do so
> > across the code base, but quite a few device types do follow that
> > convention. In my opinion it improves readability, especially in the
> header
> > file, where these offset constants are frequently mixed in with constan=
t
> > values that can be written to or read from these registers.
>
> I'm not strongly attached. I slightly prefer suffix, like
> XHCI_HCCAP_REG_CAPLENGTH) for MMIO regs, so all the common
> part of the name lines up.
>

I'm guessing you mean prefix? (_REG_ here) Works fine as well from my point
of view.


> Should the entire codebase have a guideline for memory offset
> naming conventions? Or does it not matter that much.
>

I'm not aware of a *documented* convention.


> [snip]
>
> > > -    case 0x0c: /* HCSPARAMS 3 */
> > > +    case XHCI_HCCAP_HCSPARAMS3:
> > >          ret =3D 0x00000000;
> > >          break;
> > > -    case 0x10: /* HCCPARAMS */
> > > -        if (sizeof(dma_addr_t) =3D=3D 4) {
> > > -            ret =3D 0x00080000 | (xhci->max_pstreams_mask << 12);
> > > -        } else {
> > > -            ret =3D 0x00080001 | (xhci->max_pstreams_mask << 12);
> > > +    case XHCI_HCCAP_HCCPARAMS1:
> > > +        ret =3D (XHCI_HCCAP_EXTCAP_START >> 2) |
> (xhci->max_pstreams_mask
> > > << 12);
> > >
> >
> > This doesn't look like it's equivalent to the original code. I think yo=
u
> > want
> > ((XHCI_HCCAP_EXTCAP_START >> 2) << 16) | (xhci->max_pstreams_mask << 12=
);
>
> Good catch.
>
> >
> > That's=E2=80=A6 not particularly readable either though, so if we're go=
ing to
> break
> > up the magic numbers here, how about something like:
> >
> > ret =3D (XHCI_HCCAP_EXTCAP_START / 4) << XHCI_HCCPARAM_EXTPTR_SHIFT;
> > ret |=3D xhci->max_pstreams_mask << XHCI_HCCPARAM_MAXPSASIZE_SHIFT;
> >
> >
> > > +        if (sizeof(dma_addr_t) =3D=3D 8) {
> > > +            ret |=3D 0x00000001; /* AC64 */
> > >
> >
> > and then this can become
> > ret |=3D XHCI_HCCPARAM_AC64;
> >
> > or something like that.
>
> Sure.
>
> [snip]
>
> > >      switch (reg) {
> > > -    case 0x00: /* PORTSC */
> > > +    case XHCI_PORT_PORTSC:
> > >          ret =3D port->portsc;
> > >          break;
> > > -    case 0x04: /* PORTPMSC */
> > > -    case 0x08: /* PORTLI */
> > > +    case XHCI_PORT_PORTPMSC:
> > > +    case XHCI_PORT_PORTLI:
> > >          ret =3D 0;
> > >          break;
> > > -    case 0x0c: /* reserved */
> > >
> >
> > I think it's worth keeping explicitly unhandled case labels documented
> like
> > this. (This one appears to be XHCI_PORT_PORTHLPMC nowadays, I assume it
> was
> > reserved in an earlier spec version.)
>
> Okay.
>
> >      default:
> > >          trace_usb_xhci_unimplemented("port read", reg);
> > >          ret =3D 0;
> > > @@ -2829,7 +2668,7 @@ static void xhci_port_write(void *ptr, hwaddr
> reg,
> > >      trace_usb_xhci_port_write(port->portnr, reg, val);
> > >
> > >      switch (reg) {
> > > -    case 0x00: /* PORTSC */
> > > +    case XHCI_PORT_PORTSC:
> > >          /* write-1-to-start bits */
> > >          if (val & PORTSC_WPR) {
> > >              xhci_port_reset(port, true);
> > > @@ -2880,8 +2719,6 @@ static void xhci_port_write(void *ptr, hwaddr
> reg,
> > >              xhci_port_notify(port, notify);
> > >          }
> > >          break;
> > > -    case 0x04: /* PORTPMSC */
> > > -    case 0x08: /* PORTLI */
> > >
> >
> > Hmm. Looks like PORTLI is actually a read-only register, so writing thi=
s
> > ought to trigger a LOG_GUEST_ERROR. And I don't think it's a bad thing =
to
> > explicitly document PORTPMSC as unimplemented. (And I guess that ought =
to
> > be a LOG_UNIMP, not a trace, sigh.) The improved logging can be a
> separate
> > commit - in fact I don't mind tagging that fix onto my own pending XHCI
> > patch set, but I think for this commit we ought to keep the case labels
> > (with the new symbolic constants).
>
> Okay I'll add back the reserved cases.
>

Thanks - I can only speak for myself, but I do tend to find those useful
when first getting into the code for a device. (Plus turning on GUEST_ERROR
and UNIMP logging is usually my first step when debugging issues in a
new-to-me device, and we can only really wire those up if all the labels
are there.)

I've put together a patch to wire up the correct logging for these cases,
and I'll add that to the next iteration of my pending XHCI patch set, so
don't need to bother with that. It'll cause merge conflicts with your patch
but that'll be easy to fix in whichever patch ends up getting merged second=
.


> Yeah, memory access handling in drivers is really inconsistent all over
> the tree. It would be nice if there was some helpers or something that
> added common template for access tracing, unimp and guest error logs,
> etc.
>

Yeah, it's a bit of a jungle out there in the code base, but there's also
tons of weird edge cases that need handling, so I guess setting hard rules
is just difficult. Still, calling out some positive examples in the
contributor docs might be useful.


> Thanks,
> Nick
>

--000000000000c9e2d30629b43a23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 19 Dec 2024 =
at 02:50, Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" target=
=3D"_blank">npiggin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Thu Dec 19, 2024 at 1:08 AM AEST, Phil Denn=
is-Jordan wrote:<br>
&gt; This looks sensible to me overall.<br>
&gt;<br>
&gt; For the new symbolic constants for MMIO register offsets such as<br>
&gt; XHCI_OPER_*, XHCI_INTR_* and so on, I&#39;m wondering if it would be c=
learer to<br>
&gt; give them all an _OFFSET suffix. It&#39;s not perfectly consistent to =
do so<br>
&gt; across the code base, but quite a few device types do follow that<br>
&gt; convention. In my opinion it improves readability, especially in the h=
eader<br>
&gt; file, where these offset constants are frequently mixed in with consta=
nt<br>
&gt; values that can be written to or read from these registers.<br>
<br>
I&#39;m not strongly attached. I slightly prefer suffix, like<br>
XHCI_HCCAP_REG_CAPLENGTH) for MMIO regs, so all the common<br>
part of the name lines up.<br></blockquote><div><br></div><div>I&#39;m gues=
sing you mean prefix? (_REG_ here) Works fine as well from my point of view=
.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
Should the entire codebase have a guideline for memory offset<br>
naming conventions? Or does it not matter that much.<br></blockquote><div><=
br></div><div>I&#39;m not aware of a *documented* convention.<br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
[snip]<br>
<br>
&gt; &gt; -=C2=A0 =C2=A0 case 0x0c: /* HCSPARAMS 3 */<br>
&gt; &gt; +=C2=A0 =C2=A0 case XHCI_HCCAP_HCSPARAMS3:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0x00000000;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; -=C2=A0 =C2=A0 case 0x10: /* HCCPARAMS */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sizeof(dma_addr_t) =3D=3D 4) {<b=
r>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0x00080000 | (=
xhci-&gt;max_pstreams_mask &lt;&lt; 12);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0x00080001 | (=
xhci-&gt;max_pstreams_mask &lt;&lt; 12);<br>
&gt; &gt; +=C2=A0 =C2=A0 case XHCI_HCCAP_HCCPARAMS1:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (XHCI_HCCAP_EXTCAP_START &gt=
;&gt; 2) | (xhci-&gt;max_pstreams_mask<br>
&gt; &gt; &lt;&lt; 12);<br>
&gt; &gt;<br>
&gt;<br>
&gt; This doesn&#39;t look like it&#39;s equivalent to the original code. I=
 think you<br>
&gt; want<br>
&gt; ((XHCI_HCCAP_EXTCAP_START &gt;&gt; 2) &lt;&lt; 16) | (xhci-&gt;max_pst=
reams_mask &lt;&lt; 12);<br>
<br>
Good catch.<br>
<br>
&gt;<br>
&gt; That&#39;s=E2=80=A6 not particularly readable either though, so if we&=
#39;re going to break<br>
&gt; up the magic numbers here, how about something like:<br>
&gt;<br>
&gt; ret =3D (XHCI_HCCAP_EXTCAP_START / 4) &lt;&lt; XHCI_HCCPARAM_EXTPTR_SH=
IFT;<br>
&gt; ret |=3D xhci-&gt;max_pstreams_mask &lt;&lt; XHCI_HCCPARAM_MAXPSASIZE_=
SHIFT;<br>
&gt;<br>
&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sizeof(dma_addr_t) =3D=3D 8) {<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret |=3D 0x00000001; /=
* AC64 */<br>
&gt; &gt;<br>
&gt;<br>
&gt; and then this can become<br>
&gt; ret |=3D XHCI_HCCPARAM_AC64;<br>
&gt;<br>
&gt; or something like that.<br>
<br>
Sure.<br>
<br>
[snip]<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 switch (reg) {<br>
&gt; &gt; -=C2=A0 =C2=A0 case 0x00: /* PORTSC */<br>
&gt; &gt; +=C2=A0 =C2=A0 case XHCI_PORT_PORTSC:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D port-&gt;portsc;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; -=C2=A0 =C2=A0 case 0x04: /* PORTPMSC */<br>
&gt; &gt; -=C2=A0 =C2=A0 case 0x08: /* PORTLI */<br>
&gt; &gt; +=C2=A0 =C2=A0 case XHCI_PORT_PORTPMSC:<br>
&gt; &gt; +=C2=A0 =C2=A0 case XHCI_PORT_PORTLI:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; -=C2=A0 =C2=A0 case 0x0c: /* reserved */<br>
&gt; &gt;<br>
&gt;<br>
&gt; I think it&#39;s worth keeping explicitly unhandled case labels docume=
nted like<br>
&gt; this. (This one appears to be XHCI_PORT_PORTHLPMC nowadays, I assume i=
t was<br>
&gt; reserved in an earlier spec version.)<br>
<br>
Okay.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_xhci_unimplemented(&q=
uot;port read&quot;, reg);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0;<br>
&gt; &gt; @@ -2829,7 +2668,7 @@ static void xhci_port_write(void *ptr, hwad=
dr reg,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 trace_usb_xhci_port_write(port-&gt;portnr, re=
g, val);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 switch (reg) {<br>
&gt; &gt; -=C2=A0 =C2=A0 case 0x00: /* PORTSC */<br>
&gt; &gt; +=C2=A0 =C2=A0 case XHCI_PORT_PORTSC:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write-1-to-start bits */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; PORTSC_WPR) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xhci_port_reset(p=
ort, true);<br>
&gt; &gt; @@ -2880,8 +2719,6 @@ static void xhci_port_write(void *ptr, hwad=
dr reg,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xhci_port_notify(=
port, notify);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; -=C2=A0 =C2=A0 case 0x04: /* PORTPMSC */<br>
&gt; &gt; -=C2=A0 =C2=A0 case 0x08: /* PORTLI */<br>
&gt; &gt;<br>
&gt;<br>
&gt; Hmm. Looks like PORTLI is actually a read-only register, so writing th=
is<br>
&gt; ought to trigger a LOG_GUEST_ERROR. And I don&#39;t think it&#39;s a b=
ad thing to<br>
&gt; explicitly document PORTPMSC as unimplemented. (And I guess that ought=
 to<br>
&gt; be a LOG_UNIMP, not a trace, sigh.) The improved logging can be a sepa=
rate<br>
&gt; commit - in fact I don&#39;t mind tagging that fix onto my own pending=
 XHCI<br>
&gt; patch set, but I think for this commit we ought to keep the case label=
s<br>
&gt; (with the new symbolic constants).<br>
<br>
Okay I&#39;ll add back the reserved cases.<br></blockquote><div><br></div><=
div>Thanks - I can only speak for myself, but I do tend to find those usefu=
l when first getting into the code for a device. (Plus turning on GUEST_ERR=
OR and UNIMP logging is usually my first step when debugging issues in a ne=
w-to-me device, and we can only really wire those up if all the labels are =
there.)</div><div><br></div><div>I&#39;ve put together a patch to wire up t=
he correct logging for these cases, and I&#39;ll add that to the next itera=
tion of my pending XHCI patch set, so don&#39;t need to bother with that. I=
t&#39;ll cause merge conflicts with your patch but that&#39;ll be easy to f=
ix in whichever patch ends up getting merged second.<br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
Yeah, memory access handling in drivers is really inconsistent all over<br>
the tree. It would be nice if there was some helpers or something that<br>
added common template for access tracing, unimp and guest error logs,<br>
etc.<br></blockquote><div><br></div><div>Yeah, it&#39;s a bit of a jungle o=
ut there in the code base, but there&#39;s also tons of weird edge cases th=
at need handling, so I guess setting hard rules is just difficult. Still, c=
alling out some positive examples in the contributor docs might be useful.<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
Thanks,<br>
Nick<br>
</blockquote></div></div>
</div>

--000000000000c9e2d30629b43a23--

