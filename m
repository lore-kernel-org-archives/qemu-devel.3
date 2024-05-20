Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6A5C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 22:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9BDa-0005Fa-Kc; Mon, 20 May 2024 18:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s9BDZ-0005FL-1z
 for qemu-devel@nongnu.org; Mon, 20 May 2024 18:10:53 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s9BDV-0003Os-BP
 for qemu-devel@nongnu.org; Mon, 20 May 2024 18:10:52 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7f8df927790so1241201241.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716243047; x=1716847847; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NrRSWq0NKS5exByLg561XZTSIwvmA1zXPuj7xfpPw+o=;
 b=JghYOp8D141BbEV4c58snUzjKh1TXs/MttdeOL+6aDzoT8XUmgopDNUPgK/836Ylhd
 z70jeVF0xfSozh2Ww3s/Ql+duaXHr0htvFLCDrrjK55hY4hlXsCoj2knXfN4Xnm1t24r
 joY3kQsZ3fY9XwJXSrGjEN09/hUOtJeWzgnzWq3aZBoVm3d87gVkst9OKGYRSyjmjoG2
 en/hOY/flkcnlwP6EUqF07Ky4cDsf58xBKR7lGpUrPCjdEsz9IZl7RdiTJS5R3PVpjUQ
 uT7kcxilT4/nJo91lODeTxSZOmwK+JfIbp9AdE1RXLy0aBQvKVDwZpjzvdgtNEj+uVmT
 WQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716243047; x=1716847847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NrRSWq0NKS5exByLg561XZTSIwvmA1zXPuj7xfpPw+o=;
 b=rSYzRzFeq+XKDU+79yo04avcMGLWJ59011g08Cc79DSHFGBnbHFPqEe3x4ZG9P32wr
 kSDU3nNs3HbuykIIr4ECkzAyFJ2K9hGMax0Hz6BH1fbAJkr/XkTnFi8oCHy2bK1hbJbR
 dJpYES3w+yq5sDrlAYsb8KS0YKS1SRAj30MjTVHE0AINfObEQii8zknwndQ9NW7Atijg
 GpO0SK0UmF7gCUTELep2IPyunC9dhK5QnYpK6VEubFbs68nEG5ssxNxjT2+/uaidfkZ6
 wK8go1fQdvf18gGtNOZihW4fdC/ljOctCPHm1WemofQe+8oGcX2cvkjUTsvhM5O80DYB
 J5zw==
X-Gm-Message-State: AOJu0YyarAOkDZOmE97AN8ZVgXK4tF83RxKGqMKH0QHh/rWPm0L/ZoTS
 PMsqxqcWSqbzvgQIwNCF+DD5rYCkWYaGQZFOa7rRki0657iGPFwJTUyTLFl0j9gWMN4EH1uT/t+
 UfMxchj4zMS8VnNna7rmf/X/WfBo=
X-Google-Smtp-Source: AGHT+IEHpNlSOxbHIBExf2jjLLO4t4z6bDXRM4CYDXaRICGD30YjhFsIsCnWdPnKQiGa3DvwVs/lYg5LKVd8clt+6ZI=
X-Received: by 2002:a05:6102:4187:b0:47c:2a81:a98 with SMTP id
 ada2fe7eead31-48077e176fbmr31090571137.20.1716243046180; Mon, 20 May 2024
 15:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240509002916.138802-1-dmamfmgm@gmail.com>
 <CAFEAcA_FgqggnQTrJYFuLkazz9YNysNwOt8Q=9e+kr+nr_UA4g@mail.gmail.com>
In-Reply-To: <CAFEAcA_FgqggnQTrJYFuLkazz9YNysNwOt8Q=9e+kr+nr_UA4g@mail.gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Mon, 20 May 2024 17:10:35 -0500
Message-ID: <CACBuX0RW0DHLPseksRJ6OOso48wc9WaRhnXRvZ13CnW7bPo89Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001dafa20618e9f9a9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000001dafa20618e9f9a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 11:55=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> On Thu, 9 May 2024 at 01:30, David Hubbard <dmamfmgm@gmail.com> wrote:
> >
> > From: Cord Amfmgm <dmamfmgm@gmail.com>
> >
> > This changes the ohci validation to not assert if invalid data is fed t=
o
> the
> > ohci controller. The poc in https://bugs.launchpad.net/qemu/+bug/190704=
2
> and
> > migrated to bug #303 does the following to feed it a SETUP pid (valid)
> > at an EndPt of 1 (invalid - all SETUP pids must be addressed to EndPt 0=
):
> >
> >         uint32_t MaxPacket =3D 64;
> >         uint32_t TDFormat =3D 0;
> >         uint32_t Skip =3D 0;
> >         uint32_t Speed =3D 0;
> >         uint32_t Direction =3D 0;  /* #define OHCI_TD_DIR_SETUP 0 */
> >         uint32_t EndPt =3D 1;
> >         uint32_t FuncAddress =3D 0;
> >         ed->attr =3D (MaxPacket << 16) | (TDFormat << 15) | (Skip << 14=
)
> >                    | (Speed << 13) | (Direction << 11) | (EndPt << 7)
> >                    | FuncAddress;
> >         ed->tailp =3D /*TDQTailPntr=3D */ 0;
> >         ed->headp =3D ((/*TDQHeadPntr=3D */ &td[0]) & 0xfffffff0)
> >                    | (/* ToggleCarry=3D */ 0 << 1);
> >         ed->next_ed =3D (/* NextED=3D */ 0 & 0xfffffff0)
> >
> > qemu-fuzz also caught the same issue in #1510. They are both fixed by
> this
> > patch.
> >
> > With a tiny OS[1] that boots and executes the poc the repro shows the
> issue:
> >
> > * OS that sends USB requests to a USB mass storage device
> >   but sends a SETUP with EndPt =3D 1
> > * qemu 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.19)
> > * qemu HEAD (4e66a0854)
> > * Actual OHCI controller (hardware)
> >
> > Command line:
> > qemu-system-x86_64 -m 20 \
> >  -device pci-ohci,id=3Dohci \
> >  -drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \
> >  -device usb-storage,bus=3Dohci.0,drive=3Dd \
> >  --trace "usb_*" --trace "ohci_*" -D qemu.log
> >
> > Results are:
> >
> >  qemu 6.2.0 | qemu HEAD | actual HW
> > ------------+-----------+----------------
> >  assertion  | assertion | sets stall bit
> >
> > The assertion message is:
> >
> > > qemu-system-x86_64: ../../hw/usb/core.c:744: usb_ep_get: Assertion
> `pid =3D=3D USB_TOKEN_IN || pid =3D=3D USB_TOKEN_OUT' failed.
> > > Aborted (core dumped)
> >
> > Tip: if the flags "-serial pty -serial stdio" are added to the command
> line
> > the poc outputs its USB requests like this:
> >
> > > Free mem 2M ohci port0 conn FS
> > > setup { 80 6 0 1 0 0 8 0 }
> > > ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920
> > >   td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=3Dc20907
>  cbp=3D0 be=3Dc20907
> > >   td1 c20960 nxt=3Dc20980 f3140000    in cbp=3Dc20908 be=3Dc2090f
>  cbp=3D0 be=3Dc2090f
> > >   td2 c20980 nxt=3Dc20920 f3080000   out cbp=3D0 be=3D0
>  cbp=3D0 be=3D0
> > >    rx { 12 1 0 2 0 0 0 8 }
> > > setup { 0 5 1 0 0 0 0 0 } tx {}
> > > ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20880
> > >   td0 c20920 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=3Dc20907
>  cbp=3D0 be=3Dc20907
> > >   td1 c20960 nxt=3Dc20880 f3100000    in cbp=3D0 be=3D0
>  cbp=3D0 be=3D0
> > > setup { 80 6 0 1 0 0 12 0 }
> > > ED info=3D80081 { mps=3D8 en=3D0 d=3D1 } tail=3Dc20960
> > >   td0 c20880 nxt=3Dc209c0 f2000000 setup cbp=3Dc20920 be=3Dc20927
> > >   td1 c209c0 nxt=3Dc209e0 f3140000    in cbp=3Dc20928 be=3Dc20939
> > >   td2 c209e0 nxt=3Dc20960 f3080000   out cbp=3D0 be=3D0qemu-system-x8=
6_64:
> ../../hw/usb/core.c:744: usb_ep_get: Assertion `pid =3D=3D USB_TOKEN_IN |=
| pid
> =3D=3D USB_TOKEN_OUT' failed.
> > > Aborted (core dumped)
> >
> > [1] The OS disk image has been emailed to philmd@linaro.org,
> mjt@tls.msk.ru,
> > and kraxel@redhat.com:
> >
> > * testBadSetup.img.xz
> > * sha256:
> 045b43f4396de02b149518358bf8025d5ba11091e86458875339fc649e6e5ac6
> >
> > Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>
> > ---
> >  hw/usb/hcd-ohci.c   | 5 +++++
> >  hw/usb/trace-events | 1 +
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> > index fc8fc91a1d..acd6016980 100644
> > --- a/hw/usb/hcd-ohci.c
> > +++ b/hw/usb/hcd-ohci.c
> > @@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci, struct
> ohci_ed *ed)
> >      case OHCI_TD_DIR_SETUP:
> >          str =3D "setup";
> >          pid =3D USB_TOKEN_SETUP;
> > +        if (OHCI_BM(ed->flags, ED_EN) > 0) {  /* setup only allowed to
> ep 0 */
> > +            trace_usb_ohci_td_bad_pid(str, ed->flags, td.flags);
> > +            ohci_die(ohci);
> > +            return 1;
> > +        }
> >          break;
> >      default:
> >          trace_usb_ohci_td_bad_direction(dir);
> > diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> > index ed7dc210d3..fd7b90d70c 100644
> > --- a/hw/usb/trace-events
> > +++ b/hw/usb/trace-events
> > @@ -28,6 +28,7 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len)
> "DataOverrun %d > %zu"
> >  usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
> >  usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
> >  usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
> > +usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad pi=
d
> %s: ed.flags 0x%x td.flags 0x%x"
> >  usb_ohci_port_attach(int index) "port #%d"
> >  usb_ohci_port_detach(int index) "port #%d"
> >  usb_ohci_port_wakeup(int index) "port #%d"
> > --
>
> For this patch,
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> Are you happy for me to take this patch and apply it to
> target-arm.next with the git Author and Signed-off-by:
> lines both being "David Hubbard" ? (I think if I understand
> our conversation in the other mail thread that that's the
> right thing.)
>
> thanks
> -- PMM
>

For this patch (the SETUP pid validation), I am happy if you take the patch
and apply it with Author and Signed-off-by set to "David Hubbard." Please
go ahead.

--0000000000001dafa20618e9f9a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 20, 2024 at 11:55=E2=80=
=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.m=
aydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Thu, 9 May 2024 at 01:30, David Hubbard &lt;<a href=3D"=
mailto:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; From: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"=
_blank">dmamfmgm@gmail.com</a>&gt;<br>
&gt;<br>
&gt; This changes the ohci validation to not assert if invalid data is fed =
to the<br>
&gt; ohci controller. The poc in <a href=3D"https://bugs.launchpad.net/qemu=
/+bug/1907042" rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.=
net/qemu/+bug/1907042</a> and<br>
&gt; migrated to bug #303 does the following to feed it a SETUP pid (valid)=
<br>
&gt; at an EndPt of 1 (invalid - all SETUP pids must be addressed to EndPt =
0):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t MaxPacket =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t TDFormat =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t Skip =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t Speed =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t Direction =3D 0;=C2=A0 /* #d=
efine OHCI_TD_DIR_SETUP 0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t EndPt =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t FuncAddress =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ed-&gt;attr =3D (MaxPacket &lt;&lt; 1=
6) | (TDFormat &lt;&lt; 15) | (Skip &lt;&lt; 14)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 (Speed &lt;&lt; 13) | (Direction &lt;&lt; 11) | (EndPt &lt;&lt; 7)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 FuncAddress;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ed-&gt;tailp =3D /*TDQTailPntr=3D */ =
0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ed-&gt;headp =3D ((/*TDQHeadPntr=3D *=
/ &amp;td[0]) &amp; 0xfffffff0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 (/* ToggleCarry=3D */ 0 &lt;&lt; 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ed-&gt;next_ed =3D (/* NextED=3D */ 0=
 &amp; 0xfffffff0)<br>
&gt;<br>
&gt; qemu-fuzz also caught the same issue in #1510. They are both fixed by =
this<br>
&gt; patch.<br>
&gt;<br>
&gt; With a tiny OS[1] that boots and executes the poc the repro shows the =
issue:<br>
&gt;<br>
&gt; * OS that sends USB requests to a USB mass storage device<br>
&gt;=C2=A0 =C2=A0but sends a SETUP with EndPt =3D 1<br>
&gt; * qemu 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.19)<br>
&gt; * qemu HEAD (4e66a0854)<br>
&gt; * Actual OHCI controller (hardware)<br>
&gt;<br>
&gt; Command line:<br>
&gt; qemu-system-x86_64 -m 20 \<br>
&gt;=C2=A0 -device pci-ohci,id=3Dohci \<br>
&gt;=C2=A0 -drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \<br>
&gt;=C2=A0 -device usb-storage,bus=3Dohci.0,drive=3Dd \<br>
&gt;=C2=A0 --trace &quot;usb_*&quot; --trace &quot;ohci_*&quot; -D qemu.log=
<br>
&gt;<br>
&gt; Results are:<br>
&gt;<br>
&gt;=C2=A0 qemu 6.2.0 | qemu HEAD | actual HW<br>
&gt; ------------+-----------+----------------<br>
&gt;=C2=A0 assertion=C2=A0 | assertion | sets stall bit<br>
&gt;<br>
&gt; The assertion message is:<br>
&gt;<br>
&gt; &gt; qemu-system-x86_64: ../../hw/usb/core.c:744: usb_ep_get: Assertio=
n `pid =3D=3D USB_TOKEN_IN || pid =3D=3D USB_TOKEN_OUT&#39; failed.<br>
&gt; &gt; Aborted (core dumped)<br>
&gt;<br>
&gt; Tip: if the flags &quot;-serial pty -serial stdio&quot; are added to t=
he command line<br>
&gt; the poc outputs its USB requests like this:<br>
&gt;<br>
&gt; &gt; Free mem 2M ohci port0 conn FS<br>
&gt; &gt; setup { 80 6 0 1 0 0 8 0 }<br>
&gt; &gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920<br>
&gt; &gt;=C2=A0 =C2=A0td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 b=
e=3Dc20907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3Dc20907<br>
&gt; &gt;=C2=A0 =C2=A0td1 c20960 nxt=3Dc20980 f3140000=C2=A0 =C2=A0 in cbp=
=3Dc20908 be=3Dc2090f=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3Dc2090f<br>
&gt; &gt;=C2=A0 =C2=A0td2 c20980 nxt=3Dc20920 f3080000=C2=A0 =C2=A0out cbp=
=3D0 be=3D0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cb=
p=3D0 be=3D0<br>
&gt; &gt;=C2=A0 =C2=A0 rx { 12 1 0 2 0 0 0 8 }<br>
&gt; &gt; setup { 0 5 1 0 0 0 0 0 } tx {}<br>
&gt; &gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20880<br>
&gt; &gt;=C2=A0 =C2=A0td0 c20920 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 b=
e=3Dc20907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3Dc20907<br>
&gt; &gt;=C2=A0 =C2=A0td1 c20960 nxt=3Dc20880 f3100000=C2=A0 =C2=A0 in cbp=
=3D0 be=3D0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cb=
p=3D0 be=3D0<br>
&gt; &gt; setup { 80 6 0 1 0 0 12 0 }<br>
&gt; &gt; ED info=3D80081 { mps=3D8 en=3D0 d=3D1 } tail=3Dc20960<br>
&gt; &gt;=C2=A0 =C2=A0td0 c20880 nxt=3Dc209c0 f2000000 setup cbp=3Dc20920 b=
e=3Dc20927<br>
&gt; &gt;=C2=A0 =C2=A0td1 c209c0 nxt=3Dc209e0 f3140000=C2=A0 =C2=A0 in cbp=
=3Dc20928 be=3Dc20939<br>
&gt; &gt;=C2=A0 =C2=A0td2 c209e0 nxt=3Dc20960 f3080000=C2=A0 =C2=A0out cbp=
=3D0 be=3D0qemu-system-x86_64: ../../hw/usb/core.c:744: usb_ep_get: Asserti=
on `pid =3D=3D USB_TOKEN_IN || pid =3D=3D USB_TOKEN_OUT&#39; failed.<br>
&gt; &gt; Aborted (core dumped)<br>
&gt;<br>
&gt; [1] The OS disk image has been emailed to <a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>, <a href=3D"mailto:mjt@tls=
.msk.ru" target=3D"_blank">mjt@tls.msk.ru</a>,<br>
&gt; and <a href=3D"mailto:kraxel@redhat.com" target=3D"_blank">kraxel@redh=
at.com</a>:<br>
&gt;<br>
&gt; * testBadSetup.img.xz<br>
&gt; * sha256: 045b43f4396de02b149518358bf8025d5ba11091e86458875339fc649e6e=
5ac6<br>
&gt;<br>
&gt; Signed-off-by: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" t=
arget=3D"_blank">dmamfmgm@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/usb/hcd-ohci.c=C2=A0 =C2=A0| 5 +++++<br>
&gt;=C2=A0 hw/usb/trace-events | 1 +<br>
&gt;=C2=A0 2 files changed, 6 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c<br>
&gt; index fc8fc91a1d..acd6016980 100644<br>
&gt; --- a/hw/usb/hcd-ohci.c<br>
&gt; +++ b/hw/usb/hcd-ohci.c<br>
&gt; @@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci, struc=
t ohci_ed *ed)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case OHCI_TD_DIR_SETUP:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D &quot;setup&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pid =3D USB_TOKEN_SETUP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (OHCI_BM(ed-&gt;flags, ED_EN) &gt; 0) =
{=C2=A0 /* setup only allowed to ep 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohci_td_bad_pid(s=
tr, ed-&gt;flags, td.flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ohci_die(ohci);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohci_td_bad_direction(dir)=
;<br>
&gt; diff --git a/hw/usb/trace-events b/hw/usb/trace-events<br>
&gt; index ed7dc210d3..fd7b90d70c 100644<br>
&gt; --- a/hw/usb/trace-events<br>
&gt; +++ b/hw/usb/trace-events<br>
&gt; @@ -28,6 +28,7 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len) &=
quot;DataOverrun %d &gt; %zu&quot;<br>
&gt;=C2=A0 usb_ohci_iso_td_data_underrun(int ret) &quot;DataUnderrun %d&quo=
t;<br>
&gt;=C2=A0 usb_ohci_iso_td_nak(int ret) &quot;got NAK/STALL %d&quot;<br>
&gt;=C2=A0 usb_ohci_iso_td_bad_response(int ret) &quot;Bad device response =
%d&quot;<br>
&gt; +usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) &quot;=
Bad pid %s: ed.flags 0x%x td.flags 0x%x&quot;<br>
&gt;=C2=A0 usb_ohci_port_attach(int index) &quot;port #%d&quot;<br>
&gt;=C2=A0 usb_ohci_port_detach(int index) &quot;port #%d&quot;<br>
&gt;=C2=A0 usb_ohci_port_wakeup(int index) &quot;port #%d&quot;<br>
&gt; --<br>
<br>
For this patch,<br>
<br>
Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" =
target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
<br>
Are you happy for me to take this patch and apply it to<br>
target-arm.next with the git Author and Signed-off-by:<br>
lines both being &quot;David Hubbard&quot; ? (I think if I understand<br>
our conversation in the other mail thread that that&#39;s the<br>
right thing.)<br>
<br>
thanks<br>
-- PMM<br></blockquote><div><br></div><div>For this patch (the SETUP pid va=
lidation), I am happy if you take the patch and apply it with Author and Si=
gned-off-by set to &quot;David Hubbard.&quot; Please go ahead.=C2=A0</div><=
/div></div>

--0000000000001dafa20618e9f9a9--

