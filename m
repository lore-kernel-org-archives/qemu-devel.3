Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3D0C31D97
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOhnt-0002Ji-LX; Tue, 02 Jul 2024 14:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOhnp-0002JB-52
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:00:29 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOhnk-0003aN-5r
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:00:28 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ee794ebffbso11721011fa.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719943221; x=1720548021; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wR2BmCT6VDT1Y5obj8gTeCOH/DiiacLEMDmrsBy0+tM=;
 b=Q9CUMLxPAAOtBZ5OAmGfYm4PTW0RVHwUe46c849v1qwQKXm/Z7sN4EIsUS3wqKpjDL
 bqUFLlcGXmo5mJGpZDyFpyg27keB/s2GpSsXtZwU9iNvNX4k152d0yv8rsiR9g8Yx8UB
 iMPVEULN9Ws+KABnfQKoDUWZgvQMDShspMHkZFM0f7oO88cOXN0TzBQqp3aFEwqgBBxG
 X/XLKJC5dyznZJOFStsXPyifMniDQNUQSc/mUDL6hMykmbz7zI2/fG8Hh4feRMj2fd3K
 WGwsTIx1XgQKBNuBu4JnHXuytpluBEMvyrfzZU8+iaF3zOih+mKTfss4aEZrTzfjuIE8
 hhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719943221; x=1720548021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wR2BmCT6VDT1Y5obj8gTeCOH/DiiacLEMDmrsBy0+tM=;
 b=GbDaTLz98WtXs7RvUOi6hJIlkkhZ16dje0xDA72njY88Tsk3bylBnsHjQMNyV3kxz0
 FVPthqKXIkIhJTA8qcKMY42scB2TDrXPPESLy2/ueGWduTv8Uvx/Cuief0wxwOx8Xnkx
 V96ElVvnyu+bpkIpgwdKXkCLwyjeSNQOZsJXwN8xvD5QdtrMpDWuvFq6YmZZwbKl473E
 uY23T88oNUG2qumb9bItICm8uR1d3RnHGDJSrK5ldgnI1Tpr/7IQMGqJXyohiTaYv6aq
 R+/sSNGdC47GIt+rafYiEOGUIKDmQbRmA13fb1wQq8+LDFqIbTfNFyFrtb3iiAgV+n5w
 2qFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Q1J70FMrMtDmAt3qU02sJ8RFGs8jjkmaF+C5opn9m7UQP/QruUPPqirrxKrSpS6LzeHKztHsM5t6CQA43hKtV5oW3FQ=
X-Gm-Message-State: AOJu0YzJboVIWMfyuPfNP5TLYeiJ30wOo+BaPk1jKJG7CzHB8do2jAC9
 aYA6DkSW61i74ySAU4zTat+e9YUpL6rhGROCQ6kENAXEDrt9SnMQBfPdQD+9GoGaUNBXy1EISrZ
 +nQwOQbdU7NbWEsR57fkUdg1h5w==
X-Google-Smtp-Source: AGHT+IE8V4/xdMUOauWscFRLqYnRFcQjunWekBpZXFe3SZbuyvwP16h9P1rsKwuVib7+WTNlRkTZsycWuzwmJJ4/Fvk=
X-Received: by 2002:a05:651c:b13:b0:2ec:4093:ec7 with SMTP id
 38308e7fff4ca-2ee5e3bf0f1mr84201781fa.30.1719943220352; Tue, 02 Jul 2024
 11:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240630130426.2966539-1-zheyuma97@gmail.com>
 <OSZPR01MB6453E079CFEB83C0577D37228DD32@OSZPR01MB6453.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB6453E079CFEB83C0577D37228DD32@OSZPR01MB6453.jpnprd01.prod.outlook.com>
From: Zheyu Ma <zheyuma97@gmail.com>
Date: Tue, 2 Jul 2024 20:00:04 +0200
Message-ID: <CAMhUBjnXNC_mm6CBZzknExKCoOsSQVjVA78ZeH=PTd_gdbXyVQ@mail.gmail.com>
Subject: Re: [PATCH] hw/display/tcx: Fix out-of-bounds access in
 tcx_blit_writel
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000aee075061c477cc2"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=zheyuma97@gmail.com; helo=mail-lj1-x234.google.com
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

--000000000000aee075061c477cc2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xingtao,

On Mon, Jul 1, 2024 at 5:13=E2=80=AFAM Xingtao Yao (Fujitsu) <yaoxt.fnst@fu=
jitsu.com>
wrote:

> Hi, zheyu
>
> > -----Original Message-----
> > From: qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org
> > <qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org> On Behalf Of
> Zheyu
> > Ma
> > Sent: Sunday, June 30, 2024 9:04 PM
> > To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Cc: Zheyu Ma <zheyuma97@gmail.com>; qemu-devel@nongnu.org
> > Subject: [PATCH] hw/display/tcx: Fix out-of-bounds access in
> tcx_blit_writel
> >
> > This patch addresses a potential out-of-bounds memory access issue in t=
he
> > tcx_blit_writel function. It adds bounds checking to ensure that memory
> > accesses do not exceed the allocated VRAM size. If an out-of-bounds
> access
> > is detected, an error is logged using qemu_log_mask.
> >
> > ASAN log:
> > =3D=3D2960379=3D=3DERROR: AddressSanitizer: SEGV on unknown address
> > 0x7f524752fd01 (pc 0x7f525c2c4881 bp 0x7ffdaf87bfd0 sp 0x7ffdaf87b788 T=
0)
> > =3D=3D2960379=3D=3DThe signal is caused by a READ memory access.
> >     #0 0x7f525c2c4881 in memcpy
> > string/../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:222
> >     #1 0x55aa782bd5b1 in __asan_memcpy
> > llvm/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:22:3
> >     #2 0x55aa7854dedd in tcx_blit_writel hw/display/tcx.c:590:13
> >
> > Reproducer:
> > cat << EOF | qemu-system-sparc -display none \
> > -machine accel=3Dqtest, -m 512M -machine LX -m 256 -qtest stdio
> > writel 0x562e98c4 0x3d92fd01
> > EOF
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  hw/display/tcx.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> > index 99507e7638..af43bea7f2 100644
> > --- a/hw/display/tcx.c
> > +++ b/hw/display/tcx.c
> > @@ -33,6 +33,7 @@
> >  #include "migration/vmstate.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/module.h"
> > +#include "qemu/log.h"
> >  #include "qom/object.h"
> >
> >  #define TCX_ROM_FILE "QEMU,tcx.bin"
> > @@ -577,6 +578,14 @@ static void tcx_blit_writel(void *opaque, hwaddr
> addr,
> >          addr =3D (addr >> 3) & 0xfffff;
> >          adsr =3D val & 0xffffff;
> >          len =3D ((val >> 24) & 0x1f) + 1;
> > +
> > +        if (addr + len > s->vram_size || adsr + len > s->vram_size) {
> if adsr =3D=3D 0xffffff, this condition may be always true, thus the bran=
ch
> =E2=80=9Cif (adsr =3D=3D 0xffffff) {=E2=80=9D will be never
> reached.
>

You are right, I misunderstood the condition :(

Thanks,
Zheyu

>
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: VRAM access out of bounds. addr: 0x%lx,
> adsr:
> > 0x%x, len: %u\n",
> > +                          __func__, addr, adsr, len);
> > +            return;
> > +        }
> > +
> >          if (adsr =3D=3D 0xffffff) {
> >              memset(&s->vram[addr], s->tmpblit, len);
> >              if (s->depth =3D=3D 24) {
> > --
> > 2.34.1
> >
>
>

--000000000000aee075061c477cc2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Xingtao,</div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 1, 2024 at 5:=
13=E2=80=AFAM Xingtao Yao (Fujitsu) &lt;<a href=3D"mailto:yaoxt.fnst@fujits=
u.com">yaoxt.fnst@fujitsu.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Hi, zheyu<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: qemu-devel-bounces+yaoxt.fnst=3D<a href=3D"mailto:fujitsu.com@no=
ngnu.org" target=3D"_blank">fujitsu.com@nongnu.org</a><br>
&gt; &lt;qemu-devel-bounces+yaoxt.fnst=3D<a href=3D"mailto:fujitsu.com@nong=
nu.org" target=3D"_blank">fujitsu.com@nongnu.org</a>&gt; On Behalf Of Zheyu=
<br>
&gt; Ma<br>
&gt; Sent: Sunday, June 30, 2024 9:04 PM<br>
&gt; To: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.=
uk" target=3D"_blank">mark.cave-ayland@ilande.co.uk</a>&gt;<br>
&gt; Cc: Zheyu Ma &lt;<a href=3D"mailto:zheyuma97@gmail.com" target=3D"_bla=
nk">zheyuma97@gmail.com</a>&gt;; <a href=3D"mailto:qemu-devel@nongnu.org" t=
arget=3D"_blank">qemu-devel@nongnu.org</a><br>
&gt; Subject: [PATCH] hw/display/tcx: Fix out-of-bounds access in tcx_blit_=
writel<br>
&gt; <br>
&gt; This patch addresses a potential out-of-bounds memory access issue in =
the<br>
&gt; tcx_blit_writel function. It adds bounds checking to ensure that memor=
y<br>
&gt; accesses do not exceed the allocated VRAM size. If an out-of-bounds ac=
cess<br>
&gt; is detected, an error is logged using qemu_log_mask.<br>
&gt; <br>
&gt; ASAN log:<br>
&gt; =3D=3D2960379=3D=3DERROR: AddressSanitizer: SEGV on unknown address<br=
>
&gt; 0x7f524752fd01 (pc 0x7f525c2c4881 bp 0x7ffdaf87bfd0 sp 0x7ffdaf87b788 =
T0)<br>
&gt; =3D=3D2960379=3D=3DThe signal is caused by a READ memory access.<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0 0x7f525c2c4881 in memcpy<br>
&gt; string/../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:222<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0#1 0x55aa782bd5b1 in __asan_memcpy<br>
&gt; llvm/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:22:3<br>
&gt;=C2=A0 =C2=A0 =C2=A0#2 0x55aa7854dedd in tcx_blit_writel hw/display/tcx=
.c:590:13<br>
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
&gt;=C2=A0 hw/display/tcx.c | 9 +++++++++<br>
&gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/display/tcx.c b/hw/display/tcx.c<br>
&gt; index 99507e7638..af43bea7f2 100644<br>
&gt; --- a/hw/display/tcx.c<br>
&gt; +++ b/hw/display/tcx.c<br>
&gt; @@ -33,6 +33,7 @@<br>
&gt;=C2=A0 #include &quot;migration/vmstate.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/error-report.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt;=C2=A0 #include &quot;qom/object.h&quot;<br>
&gt; <br>
&gt;=C2=A0 #define TCX_ROM_FILE &quot;QEMU,tcx.bin&quot;<br>
&gt; @@ -577,6 +578,14 @@ static void tcx_blit_writel(void *opaque, hwaddr =
addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D (addr &gt;&gt; 3) &amp; 0xf=
ffff;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adsr =3D val &amp; 0xffffff;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D ((val &gt;&gt; 24) &amp; 0x1=
f) + 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (addr + len &gt; s-&gt;vram_size || ad=
sr + len &gt; s-&gt;vram_size) {<br>
if adsr =3D=3D 0xffffff, this condition may be always true, thus the branch=
 =E2=80=9Cif (adsr =3D=3D 0xffffff) {=E2=80=9D will be never<br>
reached.<br></blockquote><div><br></div><div>You are right, I misunderstood=
 the condition :(</div><div><br></div><div>Thanks,</div><div>Zheyu=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERR=
OR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;%s: VRAM access out of bounds. addr: 0x%lx, ads=
r:<br>
&gt; 0x%x, len: %u\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __func__, addr, adsr, len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adsr =3D=3D 0xffffff) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;s-&gt;vram=
[addr], s-&gt;tmpblit, len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;depth =3D=3D=
 24) {<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000aee075061c477cc2--

