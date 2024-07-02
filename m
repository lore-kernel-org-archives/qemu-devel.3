Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A15C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOi2N-0001VT-U2; Tue, 02 Jul 2024 14:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOi2H-0001UF-VZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:15:28 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOi2F-00006c-5f
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:15:24 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a724a8097deso557446466b.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 11:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719944120; x=1720548920; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=scAnN+6VlyTCWq5VDQgCtq54oTN8rXw79YCYeRj4UKc=;
 b=ij9Opbhe5pEA67axj4INNmh25i4rU3ogVKaDWEkDCPjbeIQhGWATmJDrBF3vi4GTdJ
 a1xRrCQ+ljtUj0Kpv3yWjMcVa2f+43xCeEo2VAeix1ys0EvWThTLZzuzpAhXijmxnp3o
 1VKIib38vwinsSrZ2oEyp1O625lOlyj+72q9BlmlUToPpWSC56Psm3nw324Nu076kpVr
 wCGpO85GORq7+lSO7ZdQva5xFz2teHVJzND3XhvuCoD1w69BQcLhKBRF0OPchxJv4zR7
 UA6uzDwzp9h4VWh9ivkfdtcEnxCx3V9kmtupahp/aBicd+w8/OkzSx3wwa4DIg6aPdHm
 fGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944120; x=1720548920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=scAnN+6VlyTCWq5VDQgCtq54oTN8rXw79YCYeRj4UKc=;
 b=GLb4VAd/uS040b8uzFB0YZ+F2YYyaJxmK3SSGI2aiI7v9lfulx7/Llo0LN3PnsEbVJ
 bCJ9wLzE2oxytJwsFp30sssEwH2ioByBqpYQ3+Av1iFzfEx1pycCU+HR2NivkqSHe+R7
 D0CgFroKRHUekauSJFJnw9FEAVjRctXudrIuE3uaV94tGko8BslI9Ss13XkOrWiqetQA
 8KR55f/wgRnEU6LPHXX4JX1UzZ6oqKQETC7LCLterDpET/+XcO3NBPNEb/oLp1F4EB1U
 Fn8siChZmLVwNXVkjRsrzQ1LlT8q7mD1D9A7ePJS8THsQYk/+gIXuHIddJMD/aqlloqy
 oINQ==
X-Gm-Message-State: AOJu0YwNNtXD67u8Vgl38Fxi9UYKNXr49LFDiewWrljm9S1DhdCA0lzW
 qiirFCc5Qau9R6Eys2W7KuntIHoEEsI+jyyPPnxvURVVrK0t/6a3rSpMmBg29/HUu4NSpyRzU3M
 wZUGSO/6LgTlYRTPaBNKzhJKf8K15xGA=
X-Google-Smtp-Source: AGHT+IEu1TqL3wchwrM2cGVRCwQDIfR8b96EFPdDwteGDTD6urvONSf8C57siw1yv48Z1S4s7B07AY9uh0siFhqLwqw=
X-Received: by 2002:a17:906:a1cb:b0:a6f:b58f:ae3c with SMTP id
 a640c23a62f3a-a751440e8acmr578584166b.26.1719944120189; Tue, 02 Jul 2024
 11:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240630130426.2966539-1-zheyuma97@gmail.com>
 <e9072d75-06e2-4439-bc47-668d921e3202@ilande.co.uk>
In-Reply-To: <e9072d75-06e2-4439-bc47-668d921e3202@ilande.co.uk>
From: Zheyu Ma <zheyuma97@gmail.com>
Date: Tue, 2 Jul 2024 20:15:04 +0200
Message-ID: <CAMhUBj=Da15FJRMoX2Y=yScOM9L1RyydBK9=WNddQ=rdfJHp5g@mail.gmail.com>
Subject: Re: [PATCH] hw/display/tcx: Fix out-of-bounds access in
 tcx_blit_writel
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000514bde061c47b226"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000514bde061c47b226
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, Jul 1, 2024 at 10:49=E2=80=AFPM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 30/06/2024 14:04, Zheyu Ma wrote:
>
> > This patch addresses a potential out-of-bounds memory access issue in t=
he
> > tcx_blit_writel function. It adds bounds checking to ensure that memory
> > accesses do not exceed the allocated VRAM size. If an out-of-bounds
> access
> > is detected, an error is logged using qemu_log_mask.
> >
> > ASAN log:
> > =3D=3D2960379=3D=3DERROR: AddressSanitizer: SEGV on unknown address
> 0x7f524752fd01 (pc 0x7f525c2c4881 bp 0x7ffdaf87bfd0 sp 0x7ffdaf87b788 T0)
> > =3D=3D2960379=3D=3DThe signal is caused by a READ memory access.
> >      #0 0x7f525c2c4881 in memcpy
> string/../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:222
> >      #1 0x55aa782bd5b1 in __asan_memcpy
> llvm/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:22:3
> >      #2 0x55aa7854dedd in tcx_blit_writel hw/display/tcx.c:590:13
> >
> > Reproducer:
> > cat << EOF | qemu-system-sparc -display none \
> > -machine accel=3Dqtest, -m 512M -machine LX -m 256 -qtest stdio
> > writel 0x562e98c4 0x3d92fd01
> > EOF
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >   hw/display/tcx.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> > index 99507e7638..af43bea7f2 100644
> > --- a/hw/display/tcx.c
> > +++ b/hw/display/tcx.c
> > @@ -33,6 +33,7 @@
> >   #include "migration/vmstate.h"
> >   #include "qemu/error-report.h"
> >   #include "qemu/module.h"
> > +#include "qemu/log.h"
> >   #include "qom/object.h"
> >
> >   #define TCX_ROM_FILE "QEMU,tcx.bin"
> > @@ -577,6 +578,14 @@ static void tcx_blit_writel(void *opaque, hwaddr
> addr,
> >           addr =3D (addr >> 3) & 0xfffff;
> >           adsr =3D val & 0xffffff;
> >           len =3D ((val >> 24) & 0x1f) + 1;
> > +
> > +        if (addr + len > s->vram_size || adsr + len > s->vram_size) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: VRAM access out of bounds. addr: 0x%lx,
> adsr: 0x%x, len: %u\n",
> > +                          __func__, addr, adsr, len);
> > +            return;
> > +        }
> > +
> >           if (adsr =3D=3D 0xffffff) {
> >               memset(&s->vram[addr], s->tmpblit, len);
> >               if (s->depth =3D=3D 24) {
>
> What would happen if the source data plus length goes beyond the end of
> the
> framebuffer but the destination lies completely within it? Presumably the
> length of
> the data copy should be restricted to the length of the source data rathe=
r
> than the
> entire copy being ignored?
>
>
Thanks for your useful tips! However, I'm unfamiliar with the tcx device
and cannot find a specification/datasheet. I apologize for not proposing a
proper fix.

Regards,
Zheyu

--000000000000514bde061c47b226
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Mark,</div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 1, 2024 at 10:49=
=E2=80=AFPM Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.=
co.uk">mark.cave-ayland@ilande.co.uk</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 30/06/2024 14:04, Zheyu Ma wrote:<br=
>
<br>
&gt; This patch addresses a potential out-of-bounds memory access issue in =
the<br>
&gt; tcx_blit_writel function. It adds bounds checking to ensure that memor=
y<br>
&gt; accesses do not exceed the allocated VRAM size. If an out-of-bounds ac=
cess<br>
&gt; is detected, an error is logged using qemu_log_mask.<br>
&gt; <br>
&gt; ASAN log:<br>
&gt; =3D=3D2960379=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x=
7f524752fd01 (pc 0x7f525c2c4881 bp 0x7ffdaf87bfd0 sp 0x7ffdaf87b788 T0)<br>
&gt; =3D=3D2960379=3D=3DThe signal is caused by a READ memory access.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #0 0x7f525c2c4881 in memcpy string/../sysdeps/x86_=
64/multiarch/memmove-vec-unaligned-erms.S:222<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #1 0x55aa782bd5b1 in __asan_memcpy llvm/compiler-r=
t/lib/asan/asan_interceptors_memintrinsics.cpp:22:3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #2 0x55aa7854dedd in tcx_blit_writel hw/display/tc=
x.c:590:13<br>
&gt; <br>
&gt; Reproducer:<br>
&gt; cat &lt;&lt; EOF | qemu-system-sparc -display none \<br>
&gt; -machine accel=3Dqtest, -m 512M -machine LX -m 256 -qtest stdio<br>
&gt; writel 0x562e98c4 0x3d92fd01<br>
&gt; EOF<br>
&gt; <br>
&gt; Signed-off-by: Zheyu Ma &lt;<a href=3D"mailto:zheyuma97@gmail.com" tar=
get=3D"_blank">zheyuma97@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/display/tcx.c | 9 +++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 9 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/display/tcx.c b/hw/display/tcx.c<br>
&gt; index 99507e7638..af43bea7f2 100644<br>
&gt; --- a/hw/display/tcx.c<br>
&gt; +++ b/hw/display/tcx.c<br>
&gt; @@ -33,6 +33,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;migration/vmstate.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/error-report.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qom/object.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define TCX_ROM_FILE &quot;QEMU,tcx.bin&quot;<br>
&gt; @@ -577,6 +578,14 @@ static void tcx_blit_writel(void *opaque, hwaddr =
addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D (addr &gt;&gt; 3) &am=
p; 0xfffff;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adsr =3D val &amp; 0xffffff;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D ((val &gt;&gt; 24) &am=
p; 0x1f) + 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (addr + len &gt; s-&gt;vram_size || ad=
sr + len &gt; s-&gt;vram_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERR=
OR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s: VRAM access out of bounds. addr: 0x%lx, ads=
r: 0x%x, len: %u\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __func__, addr, adsr, len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adsr =3D=3D 0xffffff) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;s-&g=
t;vram[addr], s-&gt;tmpblit, len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;depth =
=3D=3D 24) {<br>
<br>
What would happen if the source data plus length goes beyond the end of the=
 <br>
framebuffer but the destination lies completely within it? Presumably the l=
ength of <br>
the data copy should be restricted to the length of the source data rather =
than the <br>
entire copy being ignored?<br><br></blockquote><div>=C2=A0</div><div>Thanks=
 for your useful tips! However, I&#39;m unfamiliar with the tcx device and =
cannot find a specification/datasheet. I apologize for not proposing a prop=
er fix.=C2=A0</div><div><br></div><div>Regards,</div><div>Zheyu</div></div>=
</div>

--000000000000514bde061c47b226--

