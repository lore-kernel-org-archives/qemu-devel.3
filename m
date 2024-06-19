Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3FDC27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 18:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK0Bq-0004o8-GV; Wed, 19 Jun 2024 14:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sK0Bo-0004mv-Au; Wed, 19 Jun 2024 14:37:48 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sK0Bm-0000G7-8Z; Wed, 19 Jun 2024 14:37:48 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6f1da33826so9321566b.0; 
 Wed, 19 Jun 2024 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718822264; x=1719427064; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x+Lw90YIBppABy+IKzM0yJDgLaz7wC7e5w5v5hc8fX8=;
 b=OGxaXbQVrSlFt3cBpw7PqjZ4R42qVTPaBA07ZaD3xVJQR0VmhMYkDHA77lkrZdgt/0
 gk3HQnmSY7kIZvXGjT/unybgWm93X5K/JRH0he0mYpXrFAU7+dvHAr2lR85pIRyHtgSt
 m74BX1FJQeh0xtqoUGxKr04R+7XyTNPA/GjU6k44GjCohLKIN7dO9mdQqtrkVsBnUh2J
 pndGiQ/axsDVAxgQK1Y1V5LitysI1jIMO1cEBaGycbgW84zpnFbeUb8C8qc517Rt6fvY
 qn1NT0IzX7fgdxo0EM/F5NPfnk03EhZlGy4nnGe43CKbGkFwzVeHYAIhlri5bcgYK3pi
 MoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718822264; x=1719427064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x+Lw90YIBppABy+IKzM0yJDgLaz7wC7e5w5v5hc8fX8=;
 b=Qq8funOKnBx+fn23brA4l7pMgkj1BnCRsQ2IqEjsy/nZkgJWdp/5iFNKOYtJLi/eP3
 Lf7snQkPGHGUBvRzJw6wRLjup25w6VFd8CWhNw6sYqiizuqGY08DdSCGwnMDTf+T1EyG
 5YkTqN7+KXqiwf8Jh63rITkaxlgmuCUiVrrQ303t4RrbgDhv7KW0bNLN335gelH1EgdX
 1k8rz2shxRGjgc83REEL5uglQQPgXccLdx2I9hzLZ8itIe+Yx3L+nrJyfezab/BeSkTS
 jnU1YF7PUaSTjDwq+ZS1r3nSdTCEN36CrrREsOVSoOvo4RhftNydxQh3sXht2iAMd1Jm
 /dnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrsK82DNcknuKCf+2GqOBH/1KjtJmwhDXI9eU1ODocUhwNblBGAMrwtRA18is4REmseVbrpj6pDIeKqTy/+zz3o1mEeiioO5SLVKadKxLOZNX1nQe6peQHaBU=
X-Gm-Message-State: AOJu0YyoUMDl4U0wjLp8PNSz81sU9Ma8IvkMk8iqR1AsUXR6iZfzUU6R
 cc0tk8No35OnWiAh1al1Ec9204qPnzW5+/VrGixfXAZhU+VcMwbdtwxpie1E3camRDz/ePKXdDa
 NAF62ssNCpyeT6m9DCAUXkG3Sow==
X-Google-Smtp-Source: AGHT+IGgG9M4drILCgh6cPkguqfHidGPt/khEPLJNmThINn3KwRFX8tvNw/aUZ8S9ikxDUlHTn0ts9gH0WUVMORFn3U=
X-Received: by 2002:a17:906:57c6:b0:a6f:1004:dc30 with SMTP id
 a640c23a62f3a-a6fab7d6a75mr204584966b.65.1718822263834; Wed, 19 Jun 2024
 11:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240618130928.3075494-1-zheyuma97@gmail.com>
 <bd15ab0597caad4564ca8f9498dfd3bbbe67df89.camel@codeconstruct.com.au>
 <CAMhUBjm6vBO8RWx9OqCvFqGBNVRy3j2FyhZM4tTp0dZwh3L2aA@mail.gmail.com>
 <49028fcf-40a9-446c-9606-da4471a4456f@linaro.org>
In-Reply-To: <49028fcf-40a9-446c-9606-da4471a4456f@linaro.org>
From: Zheyu Ma <zheyuma97@gmail.com>
Date: Wed, 19 Jun 2024 20:37:32 +0200
Message-ID: <CAMhUBjk9iSG8ywMZ9wHdYZiFL+Z4btQ2_5_PN7QZTDd9AQn7pw@mail.gmail.com>
Subject: Re: [PATCH] hw/gpio/aspeed: Add bounds checking for register table
 access
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000077ce53061b427e0b"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000077ce53061b427e0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Wed, Jun 19, 2024 at 6:29=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 19/6/24 08:49, Zheyu Ma wrote:
> > Hi Andrew,
> >
> > On Wed, Jun 19, 2024 at 1:58=E2=80=AFAM Andrew Jeffery
> > <andrew@codeconstruct.com.au <mailto:andrew@codeconstruct.com.au>>
> wrote:
> >
> >     Hello Zheyu Ma,
> >
> >     On Tue, 2024-06-18 at 15:09 +0200, Zheyu Ma wrote:
> >      > Added bounds checking in the aspeed_gpio_read() and
> >     aspeed_gpio_write()
> >      > functions to ensure the index idx is within the valid range of t=
he
> >      > reg_table array.
> >      >
> >      > The correct size of reg_table is determined dynamically based on
> >     whether
> >      > it is aspeed_3_3v_gpios or aspeed_1_8v_gpios. If idx exceeds the
> >      > size of reg_table, an error is logged, and the function returns.
> >      >
> >      > AddressSanitizer log indicating the issue:
> >      >
> >      > =3D=3D2602930=3D=3DERROR: AddressSanitizer: global-buffer-overfl=
ow on
> >     address 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp
> >     0x7fff096c4e88
> >      > READ of size 2 at 0x55a5da29e128 thread T0
> >      >     #0 0x55a5d700dc61 in aspeed_gpio_read
> >     hw/gpio/aspeed_gpio.c:564:14
> >      >     #1 0x55a5d933f3ab in memory_region_read_accessor
> >     system/memory.c:445:11
> >      >     #2 0x55a5d92fba40 in access_with_adjusted_size
> >     system/memory.c:573:18
> >      >     #3 0x55a5d92f842c in memory_region_dispatch_read1
> >     system/memory.c:1426:16
> >      >     #4 0x55a5d92f7b68 in memory_region_dispatch_read
> >     system/memory.c:1459:9
> >      >     #5 0x55a5d9376ad1 in flatview_read_continue_step
> >     system/physmem.c:2836:18
> >      >     #6 0x55a5d9376399 in flatview_read_continue
> >     system/physmem.c:2877:19
> >      >     #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12
> >
> >     I'm mildly interested in what you were doing to trigger this.
> Certainly
> >     we could do with a guard in the model to prevent it, but I'm curiou=
s
> >     all the same.
> >
> >
> > Actually, I'm doing the virtual device fuzzing test and trying to
> > discover bugs.
>
> Could you share the reproducer? (As you did in your other patches,
> it is very useful to reproduce).
>

Sure, I've sent a v3 patch.

Zheyu

>
> >
> >      >
> >      > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com
> >     <mailto:zheyuma97@gmail.com>>
> >      > ---
> >      >  hw/gpio/aspeed_gpio.c | 26 ++++++++++++++++++++++++++
> >      >  1 file changed, 26 insertions(+)
> >      >
> >      > diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> >      > index c1781e2ba3..1441046f6c 100644
> >      > --- a/hw/gpio/aspeed_gpio.c
> >      > +++ b/hw/gpio/aspeed_gpio.c
> >      > @@ -550,6 +550,7 @@ static uint64_t aspeed_gpio_read(void
> >     *opaque, hwaddr offset, uint32_t size)
> >      >      GPIOSets *set;
> >      >      uint32_t value =3D 0;
> >      >      uint64_t debounce_value;
> >      > +    uint32_t reg_table_size;
> >      >
> >      >      idx =3D offset >> 2;
> >      >      if (idx >=3D GPIO_DEBOUNCE_TIME_1 && idx <=3D
> >     GPIO_DEBOUNCE_TIME_3) {
> >      > @@ -559,6 +560,18 @@ static uint64_t aspeed_gpio_read(void
> >     *opaque, hwaddr offset, uint32_t size)
> >      >          return debounce_value;
> >      >      }
> >      >
> >      > +    if (agc->reg_table =3D=3D aspeed_3_3v_gpios) {
> >      > +        reg_table_size =3D GPIO_3_3V_REG_ARRAY_SIZE;
> >      > +    } else {
> >      > +        reg_table_size =3D GPIO_1_8V_REG_ARRAY_SIZE;
> >      > +    }
> >
> >     I think I'd prefer we add reg_table_size as a member of
> AspeedGPIOClass
> >     and initialise it at the same time as we initialise reg_table. I fe=
el
> >     it would help maintain safety in the face of future changes (i.e. i=
f
> >     another reg table were introduced). With that approach the hunk abo=
ve
> >     can be dropped.
> >
> >      > +
> >      > +    if (idx >=3D reg_table_size) {
> >
> >     This condition would then become:
> >
> >     ```
> >     if (idx >=3D agc->reg_table_size) {
> >     ```
> >
> >     Thoughts?
> >
> >
> > I agree with you, adding a new member is a more maintainable way, I'll
> > send a v2 patch, thanks!
> >
> > Zheyu
>
>

--00000000000077ce53061b427e0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Philippe,</div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 19, 2024 at 6:29=E2=80=
=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">=
philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On 19/6/24 08:49, Zheyu Ma wrote:<br>
&gt; Hi=C2=A0Andrew,<br>
&gt; <br>
&gt; On Wed, Jun 19, 2024 at 1:58=E2=80=AFAM Andrew Jeffery <br>
&gt; &lt;<a href=3D"mailto:andrew@codeconstruct.com.au" target=3D"_blank">a=
ndrew@codeconstruct.com.au</a> &lt;mailto:<a href=3D"mailto:andrew@codecons=
truct.com.au" target=3D"_blank">andrew@codeconstruct.com.au</a>&gt;&gt; wro=
te:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hello Zheyu Ma,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, 2024-06-18 at 15:09 +0200, Zheyu Ma wrote:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Added bounds checking in the aspeed_gpio_read=
() and<br>
&gt;=C2=A0 =C2=A0 =C2=A0aspeed_gpio_write()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; functions to ensure the index idx is within t=
he valid range of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; reg_table array.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The correct size of reg_table is determined d=
ynamically based on<br>
&gt;=C2=A0 =C2=A0 =C2=A0whether<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; it is aspeed_3_3v_gpios or aspeed_1_8v_gpios.=
 If idx exceeds the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; size of reg_table, an error is logged, and th=
e function returns.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; AddressSanitizer log indicating the issue:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; =3D=3D2602930=3D=3DERROR: AddressSanitizer: g=
lobal-buffer-overflow on<br>
&gt;=C2=A0 =C2=A0 =C2=A0address 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7f=
ff096c4e90 sp<br>
&gt;=C2=A0 =C2=A0 =C2=A00x7fff096c4e88<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; READ of size 2 at 0x55a5da29e128 thread T0<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0#0 0x55a5d700dc61 in aspee=
d_gpio_read<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/gpio/aspeed_gpio.c:564:14<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0#1 0x55a5d933f3ab in memor=
y_region_read_accessor<br>
&gt;=C2=A0 =C2=A0 =C2=A0system/memory.c:445:11<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0#2 0x55a5d92fba40 in acces=
s_with_adjusted_size<br>
&gt;=C2=A0 =C2=A0 =C2=A0system/memory.c:573:18<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0#3 0x55a5d92f842c in memor=
y_region_dispatch_read1<br>
&gt;=C2=A0 =C2=A0 =C2=A0system/memory.c:1426:16<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0#4 0x55a5d92f7b68 in memor=
y_region_dispatch_read<br>
&gt;=C2=A0 =C2=A0 =C2=A0system/memory.c:1459:9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0#5 0x55a5d9376ad1 in flatv=
iew_read_continue_step<br>
&gt;=C2=A0 =C2=A0 =C2=A0system/physmem.c:2836:18<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0#6 0x55a5d9376399 in flatv=
iew_read_continue<br>
&gt;=C2=A0 =C2=A0 =C2=A0system/physmem.c:2877:19<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0#7 0x55a5d93775b8 in flatv=
iew_read system/physmem.c:2907:12<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;m mildly interested in what you were doing to=
 trigger this. Certainly<br>
&gt;=C2=A0 =C2=A0 =C2=A0we could do with a guard in the model to prevent it=
, but I&#39;m curious<br>
&gt;=C2=A0 =C2=A0 =C2=A0all the same.<br>
&gt; <br>
&gt; <br>
&gt; Actually, I&#39;m doing the virtual device fuzzing test and trying to =
<br>
&gt; discover bugs.<br>
<br>
Could you share the reproducer? (As you did in your other patches,<br>
it is very useful to reproduce).<br></blockquote><div><br></div><div>Sure, =
I&#39;ve sent a v3 patch.</div><div><br></div><div>Zheyu=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Zheyu Ma &lt;<a href=3D"mailto=
:zheyuma97@gmail.com" target=3D"_blank">zheyuma97@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:zheyuma97@gmail.com" t=
arget=3D"_blank">zheyuma97@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 hw/gpio/aspeed_gpio.c | 26 ++++++++++++=
++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 1 file changed, 26 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/=
aspeed_gpio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index c1781e2ba3..1441046f6c 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/gpio/aspeed_gpio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/gpio/aspeed_gpio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -550,6 +550,7 @@ static uint64_t aspeed_gp=
io_read(void<br>
&gt;=C2=A0 =C2=A0 =C2=A0*opaque, hwaddr offset, uint32_t size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 GPIOSets *set;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t value =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 uint64_t debounce_value;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 uint32_t reg_table_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 idx =3D offset &gt;&gt; 2=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (idx &gt;=3D GPIO_DEBO=
UNCE_TIME_1 &amp;&amp; idx &lt;=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0GPIO_DEBOUNCE_TIME_3) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -559,6 +560,18 @@ static uint64_t aspeed_g=
pio_read(void<br>
&gt;=C2=A0 =C2=A0 =C2=A0*opaque, hwaddr offset, uint32_t size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return debo=
unce_value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (agc-&gt;reg_table =3D=3D a=
speed_3_3v_gpios) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_table_size =
=3D GPIO_3_3V_REG_ARRAY_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_table_size =
=3D GPIO_1_8V_REG_ARRAY_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I think I&#39;d prefer we add reg_table_size as a m=
ember of AspeedGPIOClass<br>
&gt;=C2=A0 =C2=A0 =C2=A0and initialise it at the same time as we initialise=
 reg_table. I feel<br>
&gt;=C2=A0 =C2=A0 =C2=A0it would help maintain safety in the face of future=
 changes (i.e. if<br>
&gt;=C2=A0 =C2=A0 =C2=A0another reg table were introduced). With that appro=
ach the hunk above<br>
&gt;=C2=A0 =C2=A0 =C2=A0can be dropped.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (idx &gt;=3D reg_table_size=
) {<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This condition would then become:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0```<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (idx &gt;=3D agc-&gt;reg_table_size) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0```<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thoughts?<br>
&gt; <br>
&gt; <br>
&gt; I agree with you, adding a new member is a more maintainable way, I&#3=
9;ll <br>
&gt; send a v2 patch, thanks!<br>
&gt; <br>
&gt; Zheyu<br>
<br>
</blockquote></div></div>

--00000000000077ce53061b427e0b--

