Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FCEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnac-0007ak-WA; Tue, 16 Apr 2024 14:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rwnaN-0007X6-TJ; Tue, 16 Apr 2024 14:31:16 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rwnaL-0000OX-Cl; Tue, 16 Apr 2024 14:31:15 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56fe7dc7f58so4428641a12.2; 
 Tue, 16 Apr 2024 11:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713292271; x=1713897071; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wk7u/9eZ75AaJIIkOV3mpXsCWAmkef56FBtI/Zo3fXg=;
 b=f4XEKaW44Mq6O9kYonzHmeCWrCyWlKiv0uuZbGe1lsPgC43TBo9q27CkOKLKx1QvjT
 D/z/MLNQXLEaC/kDCWW5q2zPCktl/KPae98CN/PBh7qhlNcZIqqpHKblbltS6PD2eUq5
 ITrtdtzljZHE0lHNv5e0Y3lkPBOpCMXcZoCk/61GhpaUadrkYr8MMKz6EuJEQ4y6NHKP
 LT/fOH/mkzAWKKBoLJBQweZimcbMuKDfqHANxRVXAN5/KJXe5/FW0DTsvT52/45pfv8j
 vD22TpJm3Qib1pdxXK/8EK4tymvQz4H9qtYRuf4RU7G50Qfc+tmhMEjbWxXOyxPqYHHW
 8fVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713292271; x=1713897071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wk7u/9eZ75AaJIIkOV3mpXsCWAmkef56FBtI/Zo3fXg=;
 b=t5WXEX8pOjq/Gnv2Y+cG/aUIO05E/F0gAynN7gPNGf5Yq0H66h4l5UVly4znqLWRzQ
 TFx45VezHwWjxAY5cWLVOv11Y8x1/Ed35tXAf5xDmWodwIOWOr5WCZNUaCScoVEXLgXC
 UCXZUsbcdVzYQymJvDmkxCnxtE2LMirzu7F2ry9++qkbM0Y6jd9y+jAP3kyYmt8ouHgT
 18Qp0dvxKJZWSs8Y9pF/8tVKMmvJVRrYj48R2rF7VLcqyNlwiRxzDOKoGf9M1/vTAhtQ
 vHo6g3c9ZnweeyESp43JdS/qRJgJOsKbm5QaHDC9ii71oilDZA4NzGIPb9szjPrRyFiM
 ZGNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL2K54v6SsePzh3V8tvR24T4Rt/s4DtXDT3YdtdiUx4hOL6VwRLNK9JytixpiUp2jUoDJQv6P401Ib5536Mvex8vmzsG5fCOy5nE9PjL7VpTPW9SiaKVEkvwI=
X-Gm-Message-State: AOJu0Yw/TtEX3rQXnGtcHXe2NLlxQ2TDijvfqaQmSDaB5KdvQ6ct8BsK
 nu/d38HQwzffApNGGKK9F23dbwHk9IaGC2QnTt1z9M2HodPY2ezNNYXOR7zb/7wKJobeNbVtYaM
 1ZDqxJtO4nL7G3dmtHb8KNJEVSTk=
X-Google-Smtp-Source: AGHT+IE500nAXWr4yTQk1AnpuAOrF9/hRqGYMTAZ7qKmTVo3GReHO5C17wV4nXLe08X2kKhZHg8LUesmdvOKfdRXd8M=
X-Received: by 2002:a50:9fcb:0:b0:570:5214:f62 with SMTP id
 c69-20020a509fcb000000b0057052140f62mr573816edf.0.1713292271343; Tue, 16 Apr
 2024 11:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240412081328.11183-1-adiupina@astralinux.ru>
 <CAFEAcA9wfzpc74iA_2G-YbtQtwGCA9VPQuXagg-Q0FwC92tg+w@mail.gmail.com>
 <69dffcb3-6424-420d-97b5-7aa72522ee98@astralinux.ru>
In-Reply-To: <69dffcb3-6424-420d-97b5-7aa72522ee98@astralinux.ru>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 16 Apr 2024 20:30:59 +0200
Message-ID: <CAJy5ezoak5hGy7enXQEoiUyBgYiAOP7ZwMLmZebLL49OVFvarg@mail.gmail.com>
Subject: Re: [PATCH RFC] prevent overflow in
 xlnx_dpdma_desc_get_source_address()
To: Alexandra Diupina <adiupina@astralinux.ru>, "Konrad,
 Frederic" <frederic.konrad@amd.com>
Cc: Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@xilinx.com>, 
 Hyun Kwon <hyun.kwon@xilinx.com>, KONRAD Frederic <fred.konrad@greensocs.com>, 
 Peter Maydell <peter.maydell@linaro.org>, crosthwaitepeter@gmail.com, 
 guillaume.delbergue@greensocs.com, hyunk@xilinx.com, 
 mark.burton@greensocs.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 sdl.qemu@linuxtesting.org
Content-Type: multipart/alternative; boundary="0000000000003ae01606163af164"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000003ae01606163af164
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ To: Fred

On Tue, 16 Apr 2024 at 19:56, Alexandra Diupina <adiupina@astralinux.ru>
wrote:

> Peter, thank you! I agree with you that
> as mentioned in the documentation
> https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/ADDR_EXT-Field,
> we should take 32 bits of the address from one field
> (for example, case 1, SRC_ADDR2_EXT - in code it is desc->source_address2=
)
> and 16 bits (high or low) of the address from another field
> (ADDR_EXT_23 - in code it is desc->address_extension_23, we need [15:0]
> bits)
> and combine them to make a 48 bit address.
>
> Therefore, I suggest making the following changes to the code
> so that it matches the documentation:
>
> static uint64_t xlnx_dpdma_desc_get_source_address(DPDMADescriptor *desc,
>                                                       uint8_t frag)
> {
>      uint64_t addr =3D 0;
>      assert(frag < 5);
>
>      switch (frag) {
>      case 0:
>          addr =3D (uint64_t)desc->source_address
>              + (extract64(desc->address_extension, 16, 16) << 32);
>          break;
>      case 1:
>          addr =3D (uint64_t)desc->source_address2
>              + (extract64(desc->address_extension_23, 0, 16) << 32);
>          break;
>      case 2:
>          addr =3D (uint64_t)desc->source_address3
>              + (extract64(desc->address_extension_23, 16, 16) << 32);
>          break;
>      case 3:
>          addr =3D (uint64_t)desc->source_address4
>              + (extract64(desc->address_extension_45, 0, 16) << 32);
>          break;
>      case 4:
>          addr =3D (uint64_t)desc->source_address5
>              + (extract64(desc->address_extension_45, 16, 16) << 32);
>          break;
>      default:
>          addr =3D 0;
>          break;
>      }
>
>      return addr;
> }
>
>
> This change adds a type cast and also uses extract64() instead of
> extract32()
> to avoid integer overflow on addition (there was a typo in the previous
> letter).
> Also in extract64() extracts a bit field with a length of 16 bits
> instead of 12,
> the shift is changed to 32 so that the extracted field fits into bits
> [47:32] of the final address.
>
> if this calculation is correct, I'm ready to create a second version of
> the patch.
>
>
>
>
> 12/04/24 13:06, Peter Maydell =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, 12 Apr 2024 at 09:13, Alexandra Diupina <adiupina@astralinux.ru=
>
> wrote:
> >> Overflow can occur in a situation where desc->source_address
> >> has a maximum value (pow(2, 32) - 1), so add a cast to a
> >> larger type before the assignment.
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >>
> >> Fixes: d3c6369a96 ("introduce xlnx-dpdma")
> >> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> >> ---
> >>   hw/dma/xlnx_dpdma.c | 20 ++++++++++----------
> >>   1 file changed, 10 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
> >> index 1f5cd64ed1..224259225c 100644
> >> --- a/hw/dma/xlnx_dpdma.c
> >> +++ b/hw/dma/xlnx_dpdma.c
> >> @@ -175,24 +175,24 @@ static uint64_t
> xlnx_dpdma_desc_get_source_address(DPDMADescriptor *desc,
> >>
> >>       switch (frag) {
> >>       case 0:
> >> -        addr =3D desc->source_address
> >> -            + (extract32(desc->address_extension, 16, 12) << 20);
> >> +        addr =3D (uint64_t)(desc->source_address
> >> +            + (extract32(desc->address_extension, 16, 12) << 20));
> > Unless I'm confused, this cast doesn't help, because we
> > will have already done a 32-bit addition of desc->source_address
> > and the value from the address_extension part, so it doesn't
> > change the result.
> >
> > If we want to do the addition at 64 bits then using extract64()
> > would be the simplest way to arrange for that.
> >
> > However, I can't figure out what this code is trying to do and
> > make that line up with the data sheet; maybe this isn't the
> > right datasheet for this device?
> >
> > https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/ADDR_EXT-Field
> >
> > The datasheet suggests that we should take 32 bits of the address
> > from one field (here desc->source_address) and 16 bits of the
> > address from another (here desc->address_extension's high bits)
> > and combine them to make a 48 bit address. But this code is only
> > looking at 12 bits of the high 16 in address_extension, and it
> > doesn't shift them right enough to put them into bits [47:32]
> > of the final address.
> >
> > Xilinx folks: what hardware is this modelling, and is it
> > really the right behaviour?
> >
> > Also, this device looks like it has a host-endianness bug: the
> > DPDMADescriptor struct is read directly from guest memory in
> > dma_memory_read(), but the device never does anything to swap
> > the fields from guest memory order to host memory order. So
> > this is likely broken on big-endian hosts.
> >
> > thanks
> > -- PMM
>
>
>

--0000000000003ae01606163af164
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">+ To: Fred</div><div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, 16 Apr 2024 at 19:56, Alexandra Di=
upina &lt;<a href=3D"mailto:adiupina@astralinux.ru">adiupina@astralinux.ru<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left=
:1ex;border-left-color:rgb(204,204,204)">Peter, thank you! I agree with you=
 that<br>
as mentioned in the documentation<br>
<a href=3D"https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/ADDR_EXT=
-Field" rel=3D"noreferrer" target=3D"_blank">https://docs.amd.com/r/en-US/u=
g1085-zynq-ultrascale-trm/ADDR_EXT-Field</a>,<br>
we should take 32 bits of the address from one field<br>
(for example, case 1, SRC_ADDR2_EXT - in code it is desc-&gt;source_address=
2)<br>
and 16 bits (high or low) of the address from another field<br>
(ADDR_EXT_23 - in code it is desc-&gt;address_extension_23, we need [15:0] =
<br>
bits)<br>
and combine them to make a 48 bit address.<br>
<br>
Therefore, I suggest making the following changes to the code<br>
so that it matches the documentation:<br>
<br>
static uint64_t xlnx_dpdma_desc_get_source_address(DPDMADescriptor *desc,<b=
r>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint8_t frag)<br>
{<br>
=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t addr =3D 0;<br>
=C2=A0=C2=A0=C2=A0=C2=A0 assert(frag &lt; 5);<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0 switch (frag) {<br>
=C2=A0=C2=A0=C2=A0=C2=A0 case 0:<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D (uint64_t)desc-&g=
t;source_address<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + =
(extract64(desc-&gt;address_extension, 16, 16) &lt;&lt; 32);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
=C2=A0=C2=A0=C2=A0=C2=A0 case 1:<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D (uint64_t)desc-&g=
t;source_address2<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + =
(extract64(desc-&gt;address_extension_23, 0, 16) &lt;&lt; 32);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
=C2=A0=C2=A0=C2=A0=C2=A0 case 2:<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D (uint64_t)desc-&g=
t;source_address3<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + =
(extract64(desc-&gt;address_extension_23, 16, 16) &lt;&lt; 32);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
=C2=A0=C2=A0=C2=A0=C2=A0 case 3:<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D (uint64_t)desc-&g=
t;source_address4<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + =
(extract64(desc-&gt;address_extension_45, 0, 16) &lt;&lt; 32);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
=C2=A0=C2=A0=C2=A0=C2=A0 case 4:<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D (uint64_t)desc-&g=
t;source_address5<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + =
(extract64(desc-&gt;address_extension_45, 16, 16) &lt;&lt; 32);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
=C2=A0=C2=A0=C2=A0=C2=A0 default:<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D 0;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0 return addr;<br>
}<br>
<br>
<br>
This change adds a type cast and also uses extract64() instead of <br>
extract32()<br>
to avoid integer overflow on addition (there was a typo in the previous <br=
>
letter).<br>
Also in extract64() extracts a bit field with a length of 16 bits <br>
instead of 12,<br>
the shift is changed to 32 so that the extracted field fits into bits <br>
[47:32] of the final address.<br>
<br>
if this calculation is correct, I&#39;m ready to create a second version of=
 <br>
the patch.<br>
<br>
<br>
<br>
<br>
12/04/24 13:06, Peter Maydell =D0=BF=D0=B8=D1=88=D0=B5=D1=82:<br>
&gt; On Fri, 12 Apr 2024 at 09:13, Alexandra Diupina &lt;<a href=3D"mailto:=
adiupina@astralinux.ru" target=3D"_blank">adiupina@astralinux.ru</a>&gt; wr=
ote:<br>
&gt;&gt; Overflow can occur in a situation where desc-&gt;source_address<br=
>
&gt;&gt; has a maximum value (pow(2, 32) - 1), so add a cast to a<br>
&gt;&gt; larger type before the assignment.<br>
&gt;&gt;<br>
&gt;&gt; Found by Linux Verification Center (<a href=3D"http://linuxtesting=
.org" rel=3D"noreferrer" target=3D"_blank">linuxtesting.org</a>) with SVACE=
.<br>
&gt;&gt;<br>
&gt;&gt; Fixes: d3c6369a96 (&quot;introduce xlnx-dpdma&quot;)<br>
&gt;&gt; Signed-off-by: Alexandra Diupina &lt;<a href=3D"mailto:adiupina@as=
tralinux.ru" target=3D"_blank">adiupina@astralinux.ru</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0hw/dma/xlnx_dpdma.c | 20 ++++++++++----------<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 10 insertions(+), 10 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c<br>
&gt;&gt; index 1f5cd64ed1..224259225c 100644<br>
&gt;&gt; --- a/hw/dma/xlnx_dpdma.c<br>
&gt;&gt; +++ b/hw/dma/xlnx_dpdma.c<br>
&gt;&gt; @@ -175,24 +175,24 @@ static uint64_t xlnx_dpdma_desc_get_source_a=
ddress(DPDMADescriptor *desc,<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (frag) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case 0:<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D desc-&gt;source_address<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + (extract32(desc-&gt;a=
ddress_extension, 16, 12) &lt;&lt; 20);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D (uint64_t)(desc-&gt;source_a=
ddress<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + (extract32(desc-&gt;a=
ddress_extension, 16, 12) &lt;&lt; 20));<br>
&gt; Unless I&#39;m confused, this cast doesn&#39;t help, because we<br>
&gt; will have already done a 32-bit addition of desc-&gt;source_address<br=
>
&gt; and the value from the address_extension part, so it doesn&#39;t<br>
&gt; change the result.<br>
&gt;<br>
&gt; If we want to do the addition at 64 bits then using extract64()<br>
&gt; would be the simplest way to arrange for that.<br>
&gt;<br>
&gt; However, I can&#39;t figure out what this code is trying to do and<br>
&gt; make that line up with the data sheet; maybe this isn&#39;t the<br>
&gt; right datasheet for this device?<br>
&gt;<br>
&gt; <a href=3D"https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/ADD=
R_EXT-Field" rel=3D"noreferrer" target=3D"_blank">https://docs.amd.com/r/en=
-US/ug1085-zynq-ultrascale-trm/ADDR_EXT-Field</a><br>
&gt;<br>
&gt; The datasheet suggests that we should take 32 bits of the address<br>
&gt; from one field (here desc-&gt;source_address) and 16 bits of the<br>
&gt; address from another (here desc-&gt;address_extension&#39;s high bits)=
<br>
&gt; and combine them to make a 48 bit address. But this code is only<br>
&gt; looking at 12 bits of the high 16 in address_extension, and it<br>
&gt; doesn&#39;t shift them right enough to put them into bits [47:32]<br>
&gt; of the final address.<br>
&gt;<br>
&gt; Xilinx folks: what hardware is this modelling, and is it<br>
&gt; really the right behaviour?<br>
&gt;<br>
&gt; Also, this device looks like it has a host-endianness bug: the<br>
&gt; DPDMADescriptor struct is read directly from guest memory in<br>
&gt; dma_memory_read(), but the device never does anything to swap<br>
&gt; the fields from guest memory order to host memory order. So<br>
&gt; this is likely broken on big-endian hosts.<br>
&gt;<br>
&gt; thanks<br>
&gt; -- PMM<br>
<br>
<br>
</blockquote></div></div>

--0000000000003ae01606163af164--

