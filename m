Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8758C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHTxl-0000S4-2u; Wed, 12 Jun 2024 15:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sHTxj-0000Rm-0U
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:48:51 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sHTxg-0000k2-I2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:48:50 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-80ae49954d3so52746241.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718221727; x=1718826527; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ifVLRd5YALlt5s8MXvEBxO/xSWu+JUyPb7OSPjHVMnM=;
 b=YkDBbG4bkvkgPhmpVhXiNcLzoioTPcMmDAYkxEUuWwZt/I5Qk3CvTSslkT5NhRsHAd
 UpI4mWmiVxudqouXhaM2KoezXg7oQLq/YJY55WWrMspzDTSLbSZhONHYN/Ta6/lQ6kKz
 fECXIuzFGdAL2u9VPBHtoRYTyCAJ5nbeB6MA0zPvwXIco7Jm2DZBA+IozYPw4U+1FPsL
 2uiUtGYVZuMXfumF7CEJjUnQo4cQYSiFJbDZqtsYRKEQgWJANmF3caxIavtxQPPusnZv
 4Bz5NVQb0lmA4vQ2qGdsZn+gizNpTaqXFyODUx0hTb3faOU1OkDVC0dapWJS0stAbHts
 GeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718221727; x=1718826527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ifVLRd5YALlt5s8MXvEBxO/xSWu+JUyPb7OSPjHVMnM=;
 b=gY+t+mjG+2zGlQHO0eBPsXWJ7ZuTyZT7lEC270kleT3hoirDHRMW2clGfTTpVbJhfF
 6uHVSOIa8/FMIvBS7HU8N/ya7FvhJjCZn/FX8CFqeJPEMUc+GzWKts/zRsUZOhxKMPQR
 GRUNhem16mfdyHoa5mSzMzgZ8RX3kywH9Zk31C1s2HJmCR6Nv5HdxaoNmR7bMAwdY5Al
 aALm6XdJiEzQ9uQzIx4cCOrQTXcwTXtg1GwlEjf+g+23chQnvuSD7l/LjyMlWDrMAM+C
 OJWCUr2iCEiHubqeQgJ6bszLxCA7/g9QEUKo6Y3BWlOlwC3wn0lfpPepe4moepa4K+dL
 +yUw==
X-Gm-Message-State: AOJu0YyPgy7JG7x2tlXyyvcHfjXxFe2rIeXyNRqgf55gvP+fEYJ/9wCd
 nXsVDkmNT3K8BIRAP4PmVHI0TxO7OZsGFSTwB3NCNO9lBkry2iSlfWF20pcxm8/g4OzUeXSyfm1
 5ECbRqRkjP6yLaqidCghZKGftbnc=
X-Google-Smtp-Source: AGHT+IES15OqhTVQrlSZLtmAU2HXRSSsFc1GbxgQ2Ja5VhvfQhoIn2zRiCOlclS1NSnAQv7Dej5Ex3gqnA3mCYj3inQ=
X-Received: by 2002:a05:6102:418a:b0:48d:931a:fee1 with SMTP id
 ada2fe7eead31-48d931b016cmr4148959137.15.1718221727033; Wed, 12 Jun 2024
 12:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
 <87cyomxmvc.fsf@draig.linaro.org>
 <CACBuX0SMvD6+vWGBv_m0rBnwgp8fbv6rHKUmbr-MWDLknz8LyA@mail.gmail.com>
 <87msnqvtpv.fsf@draig.linaro.org>
In-Reply-To: <87msnqvtpv.fsf@draig.linaro.org>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Wed, 12 Jun 2024 14:48:35 -0500
Message-ID: <CACBuX0SAE4SXujExPvndDDhP+gcoD_LV-=1ti2XaNd-onQbZ0w@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Philippe Mathieu-Daude <philmd@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000af7342061ab6ab19"
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000af7342061ab6ab19
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:36=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Cord Amfmgm <dmamfmgm@gmail.com> writes:
>
> > On Wed, Jun 12, 2024 at 9:21=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org>
> wrote:
> >
> >  David Hubbard <dmamfmgm@gmail.com> writes:
> >
> >  > From: Cord Amfmgm <dmamfmgm@gmail.com>
> >  >
> >  > This changes the way the ohci emulation handles a Transfer Descripto=
r
> with
> >  > "Current Buffer Pointer" set to "Buffer End" + 1.
> >  >
> >  > The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more
> than td.be
> >  > to signal the buffer has zero length. Currently qemu only accepts
> zero-length
> >  > Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI
> hardware
> >  > accepts both cases.
> >  >
> >  > The qemu ohci emulation has a regression in ohci_service_td. Version
> 4.2
> >  > and earlier matched the spec. (I haven't taken the time to bisect
> exactly
> >  > where the logic was changed.)
> >
> >  I find it hard to characterise this as a regression because we've
> >  basically gone from no checks to actually doing bounds checks:
> >
> >    1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number variables)
> >
> >  The argument here seems to be that real hardware is laxer than the spe=
cs
> >  in what it accepts.
> >
> <snip>
> >
> >  With the updated commit message:
> >
> >  Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> > Please forgive my lack of experience on this mailing list. I don't see =
a
> suggested commit message from Alex but in case that
> > was what is being considered, here is one. Feedback welcome, also if
> this is not what is wanted, please just say it.
> >
>
> Something along the lines of what you suggest here (where did this come
> from?)
>
> >> From: Cord Amfmgm <dmamfmgm@gmail.com>
> >>
> >> This changes the way the ohci emulation handles a Transfer Descriptor
> with
> >> "Buffer End" set to "Current Buffer Pointer" - 1, specifically in the
> case of a
> >> zero-length packet.
> >>
> >> The OHCI spec 4.3.1.2 Table 4-2 specifies td.cbp to be zero for a
> zero-length
> >> packet. Peter Maydell tracked down commit
> >> 1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number variables)
> >> where qemu started checking this according to the spec.
> >>
> >> What this patch does is loosen the qemu ohci implementation to allow a
> >> zero-length packet if td.be (Buffer End) is set to td.cbp - 1, and
> with a
> >> non-zero td.cbp value.
> >>
> >> Is this correct? It appears to not follow the spec, so no. But actual =
hw
> >> seems to be ok with it.
> >>
> >> Does any OS rely on this behavior? There have been no reports to
> >> qemu-devel of this problem.
> >>
> >> This is attempting to have qemu behave like actual hardware,
> >> but this is just a minor change.
> >>
> >> With a tiny OS[1] that boots and executes a test, the behavior is
> >> reproducible:
> >>
> >> * OS that sends USB requests to a USB mass storage device
> >>   but sends td.be =3D td.cbp - 1
> >> * qemu 4.2
> >> * qemu HEAD (4e66a0854)
> >> * Actual OHCI controller (hardware)
> >>
> >> Command line:
> >> qemu-system-x86_64 -m 20 \
> >>  -device pci-ohci,id=3Dohci \
> >>  -drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \
> >>  -device usb-storage,bus=3Dohci.0,drive=3Dd \
> >>  --trace "usb_*" --trace "ohci_*" -D qemu.log
> >>
> >> Results are:
> >>
> >>  qemu 4.2   | qemu HEAD  | actual HW
> >> ------------+------------+------------
> >>  works fine | ohci_die() | works fine
> >>
> >> Tip: if the flags "-serial pty -serial stdio" are added to the command
> line
> >> the test will output USB requests like this:
> >>
> >> Testing qemu HEAD:
> >>
> >>> Free mem 2M ohci port2 conn FS
> >>> setup { 80 6 0 1 0 0 8 0 }
> >>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920
> >>>   td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=3Dc20907
> >>>   td1 c20960 nxt=3Dc20980 f3140000    in cbp=3Dc20908 be=3Dc2090f
> >>>   td2 c20980 nxt=3Dc20920 f3080000   out cbp=3Dc20910 be=3Dc2090f ohc=
i20
> host err
> >>> usb stopped
> >>
> >> And in qemu.log:
> >>
> >> usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=3D0x00c20910 >
> next_offset=3D0x00c2090f
> >>
> >> Testing qemu 4.2:
> >>
> >>> Free mem 2M ohci port2 conn FS
> >>> setup { 80 6 0 1 0 0 8 0 }
> >>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620920
> >>>   td0 620880 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907
>  cbp=3D0 be=3D620907
> >>>   td1 620960 nxt=3D620980 f3140000    in cbp=3D620908 be=3D62090f
>  cbp=3D0 be=3D62090f
> >>>   td2 620980 nxt=3D620920 f3080000   out cbp=3D620910 be=3D62090f
>  cbp=3D0 be=3D62090f
> >>>    rx { 12 1 0 2 0 0 0 8 }
> >>> setup { 0 5 1 0 0 0 0 0 } tx {}
> >>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620880
> >>>   td0 620920 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907
>  cbp=3D0 be=3D620907
> >>>   td1 620960 nxt=3D620880 f3100000    in cbp=3D620908 be=3D620907
>  cbp=3D0 be=3D620907
> >>> setup { 80 6 0 1 0 0 12 0 }
> >>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620960
> >>>   td0 620880 nxt=3D6209c0 f2000000 setup cbp=3D620920 be=3D620927
>  cbp=3D0 be=3D620927
> >>>   td1 6209c0 nxt=3D6209e0 f3140000    in cbp=3D620928 be=3D620939
>  cbp=3D0 be=3D620939
> >>>   td2 6209e0 nxt=3D620960 f3080000   out cbp=3D62093a be=3D620939
>  cbp=3D0 be=3D620939
> >>>    rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }
> >>> setup { 80 6 0 2 0 0 0 1 }
> >>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620880
> >>>   td0 620960 nxt=3D6209a0 f2000000 setup cbp=3D620a20 be=3D620a27
>  cbp=3D0 be=3D620a27
> >>>   td1 6209a0 nxt=3D6209c0 f3140004    in cbp=3D620a28 be=3D620b27
>  cbp=3D620a48 be=3D620b27
> >>>   td2 6209c0 nxt=3D620880 f3080000   out cbp=3D620b28 be=3D620b27
>  cbp=3D0 be=3D620b27
> >>>    rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2 40 0 0 7 5 2 =
2
> 40 0 0 }
> >>> setup { 0 9 1 0 0 0 0 0 } tx {}
> >>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900
> >>>   td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a00 be=3D620a07
>  cbp=3D0 be=3D620a07
> >>>   td1 620940 nxt=3D620900 f3100000    in cbp=3D620a08 be=3D620a07
>  cbp=3D0 be=3D620a07
> >>
> >> [1] The OS disk image has been emailed to philmd@linaro.org,
> mjt@tls.msk.ru,
> >> and kraxel@redhat.com:
> >>
> >> * testCbpOffBy1.img.xz
> >> * sha256:
> >> f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3abed
> >>
> >> Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>
>
>
Oh, I just manually put it in blockquotes to clearly delineate what it is.

I authored this new message in the previous message.

--000000000000af7342061ab6ab19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 12, 2024 at 2:36=E2=80=AFPM A=
lex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@l=
inaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"=
_blank">dmamfmgm@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Wed, Jun 12, 2024 at 9:21=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org=
</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 David Hubbard &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=
=3D"_blank">dmamfmgm@gmail.com</a>&gt; writes:<br>
&gt;<br>
&gt;=C2=A0 &gt; From: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com"=
 target=3D"_blank">dmamfmgm@gmail.com</a>&gt;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; This changes the way the ohci emulation handles a Transfer =
Descriptor with<br>
&gt;=C2=A0 &gt; &quot;Current Buffer Pointer&quot; set to &quot;Buffer End&=
quot; + 1.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byt=
e more than <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">t=
d.be</a><br>
&gt;=C2=A0 &gt; to signal the buffer has zero length. Currently qemu only a=
ccepts zero-length<br>
&gt;=C2=A0 &gt; Transfer Descriptors if the td.cbp is equal to 0, while act=
ual OHCI hardware<br>
&gt;=C2=A0 &gt; accepts both cases.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; The qemu ohci emulation has a regression in ohci_service_td=
. Version 4.2<br>
&gt;=C2=A0 &gt; and earlier matched the spec. (I haven&#39;t taken the time=
 to bisect exactly<br>
&gt;=C2=A0 &gt; where the logic was changed.)<br>
&gt;<br>
&gt;=C2=A0 I find it hard to characterise this as a regression because we&#=
39;ve<br>
&gt;=C2=A0 basically gone from no checks to actually doing bounds checks:<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number=
 variables)<br>
&gt;<br>
&gt;=C2=A0 The argument here seems to be that real hardware is laxer than t=
he specs<br>
&gt;=C2=A0 in what it accepts.<br>
&gt;<br>
&lt;snip&gt;<br>
&gt;<br>
&gt;=C2=A0 With the updated commit message:<br>
&gt;<br>
&gt;=C2=A0 Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@=
linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
&gt;<br>
&gt; Please forgive my lack of experience on this mailing list. I don&#39;t=
 see a suggested commit message from Alex but in case that<br>
&gt; was what is being considered, here is one. Feedback welcome, also if t=
his is not what is wanted, please just say it.<br>
&gt;<br>
<br>
Something along the lines of what you suggest here (where did this come<br>
from?)<br>
<br>
&gt;&gt; From: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=
=3D"_blank">dmamfmgm@gmail.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; This changes the way the ohci emulation handles a Transfer Descrip=
tor with<br>
&gt;&gt; &quot;Buffer End&quot; set to &quot;Current Buffer Pointer&quot; -=
 1, specifically in the case of a<br>
&gt;&gt; zero-length packet.<br>
&gt;&gt;<br>
&gt;&gt; The OHCI spec 4.3.1.2 Table 4-2 specifies td.cbp to be zero for a =
zero-length<br>
&gt;&gt; packet. Peter Maydell tracked down commit<br>
&gt;&gt; 1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number variable=
s)<br>
&gt;&gt; where qemu started checking this according to the spec.<br>
&gt;&gt;<br>
&gt;&gt; What this patch does is loosen the qemu ohci implementation to all=
ow a<br>
&gt;&gt; zero-length packet if <a href=3D"http://td.be" rel=3D"noreferrer" =
target=3D"_blank">td.be</a> (Buffer End) is set to td.cbp - 1, and with a<b=
r>
&gt;&gt; non-zero td.cbp value.<br>
&gt;&gt;<br>
&gt;&gt; Is this correct? It appears to not follow the spec, so no. But act=
ual hw<br>
&gt;&gt; seems to be ok with it.<br>
&gt;&gt;<br>
&gt;&gt; Does any OS rely on this behavior? There have been no reports to<b=
r>
&gt;&gt; qemu-devel of this problem.<br>
&gt;&gt;<br>
&gt;&gt; This is attempting to have qemu behave like actual hardware,<br>
&gt;&gt; but this is just a minor change.<br>
&gt;&gt;<br>
&gt;&gt; With a tiny OS[1] that boots and executes a test, the behavior is<=
br>
&gt;&gt; reproducible:<br>
&gt;&gt;<br>
&gt;&gt; * OS that sends USB requests to a USB mass storage device<br>
&gt;&gt;=C2=A0 =C2=A0but sends <a href=3D"http://td.be" rel=3D"noreferrer" =
target=3D"_blank">td.be</a> =3D td.cbp - 1<br>
&gt;&gt; * qemu 4.2<br>
&gt;&gt; * qemu HEAD (4e66a0854)<br>
&gt;&gt; * Actual OHCI controller (hardware)<br>
&gt;&gt;<br>
&gt;&gt; Command line:<br>
&gt;&gt; qemu-system-x86_64 -m 20 \<br>
&gt;&gt;=C2=A0 -device pci-ohci,id=3Dohci \<br>
&gt;&gt;=C2=A0 -drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \<br=
>
&gt;&gt;=C2=A0 -device usb-storage,bus=3Dohci.0,drive=3Dd \<br>
&gt;&gt;=C2=A0 --trace &quot;usb_*&quot; --trace &quot;ohci_*&quot; -D qemu=
.log<br>
&gt;&gt;<br>
&gt;&gt; Results are:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 qemu 4.2=C2=A0 =C2=A0| qemu HEAD=C2=A0 | actual HW<br>
&gt;&gt; ------------+------------+------------<br>
&gt;&gt;=C2=A0 works fine | ohci_die() | works fine<br>
&gt;&gt;<br>
&gt;&gt; Tip: if the flags &quot;-serial pty -serial stdio&quot; are added =
to the command line<br>
&gt;&gt; the test will output USB requests like this:<br>
&gt;&gt;<br>
&gt;&gt; Testing qemu HEAD:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Free mem 2M ohci port2 conn FS<br>
&gt;&gt;&gt; setup { 80 6 0 1 0 0 8 0 }<br>
&gt;&gt;&gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc2090=
0 be=3Dc20907<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td1 c20960 nxt=3Dc20980 f3140000=C2=A0 =C2=A0 in c=
bp=3Dc20908 be=3Dc2090f<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td2 c20980 nxt=3Dc20920 f3080000=C2=A0 =C2=A0out c=
bp=3Dc20910 be=3Dc2090f ohci20 host err<br>
&gt;&gt;&gt; usb stopped<br>
&gt;&gt;<br>
&gt;&gt; And in qemu.log:<br>
&gt;&gt;<br>
&gt;&gt; usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=3D0x00c20910 &g=
t; next_offset=3D0x00c2090f<br>
&gt;&gt;<br>
&gt;&gt; Testing qemu 4.2:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Free mem 2M ohci port2 conn FS<br>
&gt;&gt;&gt; setup { 80 6 0 1 0 0 8 0 }<br>
&gt;&gt;&gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620920<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td0 620880 nxt=3D620960 f2000000 setup cbp=3D62090=
0 be=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td1 620960 nxt=3D620980 f3140000=C2=A0 =C2=A0 in c=
bp=3D620908 be=3D62090f=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D62090f<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td2 620980 nxt=3D620920 f3080000=C2=A0 =C2=A0out c=
bp=3D620910 be=3D62090f=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D62090f<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 rx { 12 1 0 2 0 0 0 8 }<br>
&gt;&gt;&gt; setup { 0 5 1 0 0 0 0 0 } tx {}<br>
&gt;&gt;&gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620880<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td0 620920 nxt=3D620960 f2000000 setup cbp=3D62090=
0 be=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td1 620960 nxt=3D620880 f3100000=C2=A0 =C2=A0 in c=
bp=3D620908 be=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt;&gt;&gt; setup { 80 6 0 1 0 0 12 0 }<br>
&gt;&gt;&gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620960<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td0 620880 nxt=3D6209c0 f2000000 setup cbp=3D62092=
0 be=3D620927=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620927<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td1 6209c0 nxt=3D6209e0 f3140000=C2=A0 =C2=A0 in c=
bp=3D620928 be=3D620939=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620939<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td2 6209e0 nxt=3D620960 f3080000=C2=A0 =C2=A0out c=
bp=3D62093a be=3D620939=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620939<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }<br>
&gt;&gt;&gt; setup { 80 6 0 2 0 0 0 1 }<br>
&gt;&gt;&gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620880<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td0 620960 nxt=3D6209a0 f2000000 setup cbp=3D620a2=
0 be=3D620a27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a27<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td1 6209a0 nxt=3D6209c0 f3140004=C2=A0 =C2=A0 in c=
bp=3D620a28 be=3D620b27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D620a48 be=3D620b27<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0td2 6209c0 nxt=3D620880 f3080000=C2=A0 =C2=A0out c=
bp=3D620b28 be=3D620b27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620b27<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 8=
1 2 40 0 0 7 5 2 2 40 0 0 }<br>
&gt;&gt;&gt; setup { 0 9 1 0 0 0 0 0 } tx {}<br>
&gt;&gt;&gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a0=
0 be=3D620a07=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a07<br>
&gt;&gt;&gt;=C2=A0 =C2=A0td1 620940 nxt=3D620900 f3100000=C2=A0 =C2=A0 in c=
bp=3D620a08 be=3D620a07=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a07<br>
&gt;&gt;<br>
&gt;&gt; [1] The OS disk image has been emailed to <a href=3D"mailto:philmd=
@linaro.org" target=3D"_blank">philmd@linaro.org</a>, <a href=3D"mailto:mjt=
@tls.msk.ru" target=3D"_blank">mjt@tls.msk.ru</a>,<br>
&gt;&gt; and <a href=3D"mailto:kraxel@redhat.com" target=3D"_blank">kraxel@=
redhat.com</a>:<br>
&gt;&gt;<br>
&gt;&gt; * testCbpOffBy1.img.xz<br>
&gt;&gt; * sha256:<br>
&gt;&gt; f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3abed<b=
r>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.co=
m" target=3D"_blank">dmamfmgm@gmail.com</a>&gt;<br>
<br></blockquote><div><br></div><div>Oh, I just manually put it in blockquo=
tes to clearly delineate what it is.</div><div><br></div><div>I authored th=
is new message in the previous message.=C2=A0</div></div></div>

--000000000000af7342061ab6ab19--

