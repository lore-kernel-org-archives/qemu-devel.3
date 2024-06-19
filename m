Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6622C27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 06:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJp8o-0003Y3-4Z; Wed, 19 Jun 2024 02:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJp8h-0003Uq-9t; Wed, 19 Jun 2024 02:49:51 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJp8e-0003No-W2; Wed, 19 Jun 2024 02:49:50 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so954150666b.2; 
 Tue, 18 Jun 2024 23:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718779787; x=1719384587; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sROiLnN74b1tjP5dGp41RIIZzU0uLRAJzU+LlS8eF1Y=;
 b=luOFZUQwd5zh6MwymaV5lyjIL3ZCLBeXF/O3dmTFGLz3nFf3kC8+a3/7fYlEHhKL4R
 iVjSkMvVImjuHt/ebgUVyLblYQ2v6jPGc/Xbnt0oR/ySqhLUaQtIBGvBGm8BRMQr+g70
 WFXS0H3a3O93W/83vPCpZ3YVEHoUXn7qZOLL1EkT2tPnc7f8uySggltql9aDBNqFMCAH
 ISlc/8mL8jWYbpjpKVvs9+F+FCT7tI9H6KMzhmQVhpq+IpzR/u5zT54TiIbVoNSqX4bv
 CWo1J2gmwUn3esV1CQlNEJLNk5ycgruSgLoZNaqnkrToU5KXo4EI5b2SyiaNImlyaz5p
 +KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718779787; x=1719384587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sROiLnN74b1tjP5dGp41RIIZzU0uLRAJzU+LlS8eF1Y=;
 b=w1lVrKfIcq4FMTI9EGjf00BMUgbTbmsoYRSvTsfzsTNFrDKWeiTJtPxB+8QV1xEP6P
 30XjqaWs9hch7IUJv7Z5RWWRWoGlPX/M1jvw4idTjuhq011fPWdveNRNVMYBPYDmVNq2
 hAhesDQK7xqa0ZejjDb3G9/Un1tkbRs1qgyPJfmO5hzova8RrEsA8TFjTWCOimV6yr7a
 3RpB2PHs0QPCP/ymp2OFM5rWh9piBmYPHc+7jxcQvleiLk366MBZlZ9/2B42fZmM5vVK
 RjX3NtsB/qUr4iH1kWu1oS+eb60qCIswtgqeNwdsv6fqe7D/0t8+5lEhB3x6cAI/Qs4/
 4SrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6wKfWQ1g6ectb20p7/KAsPwF2JFeMYpPoR+wnw6BOQSq51vUaVj77jqtfFNsyj3OUlEa0UwOVjgzvsNYkkORdF7P5p9h3BTjKHoo1tXFYLYWZv6Pste++ywU=
X-Gm-Message-State: AOJu0YyEG5iXPSG2LlcmHaUMS1TN6RJgcu4dlUNSXYmBe4oFU+3v+AVE
 i3g5vM5P2xAOuuEWqBLBD1Ms2j02UMI8N77k1S4gaCyWIoRj6a2HiSBeuIYZKCdrU5Pin0xIyoO
 rjXFn3rJ5rBah4NP3Oe4DkmGkJrBqSC8=
X-Google-Smtp-Source: AGHT+IHiNSmb7rXbFQDlllEvftLHmO4f70NWZZPKz6mFllzD7Nih3WsLxf1o8VasVVXNvjVvgK9eAW9sVb00wKeARv8=
X-Received: by 2002:a17:907:72c4:b0:a6f:2e28:4008 with SMTP id
 a640c23a62f3a-a6fab77a1ddmr98737966b.54.1718779786378; Tue, 18 Jun 2024
 23:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240618130928.3075494-1-zheyuma97@gmail.com>
 <bd15ab0597caad4564ca8f9498dfd3bbbe67df89.camel@codeconstruct.com.au>
In-Reply-To: <bd15ab0597caad4564ca8f9498dfd3bbbe67df89.camel@codeconstruct.com.au>
From: Zheyu Ma <zheyuma97@gmail.com>
Date: Wed, 19 Jun 2024 08:49:35 +0200
Message-ID: <CAMhUBjm6vBO8RWx9OqCvFqGBNVRy3j2FyhZM4tTp0dZwh3L2aA@mail.gmail.com>
Subject: Re: [PATCH] hw/gpio/aspeed: Add bounds checking for register table
 access
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009d4402061b389a31"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x631.google.com
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

--0000000000009d4402061b389a31
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Jun 19, 2024 at 1:58=E2=80=AFAM Andrew Jeffery <andrew@codeconstruc=
t.com.au>
wrote:

> Hello Zheyu Ma,
>
> On Tue, 2024-06-18 at 15:09 +0200, Zheyu Ma wrote:
> > Added bounds checking in the aspeed_gpio_read() and aspeed_gpio_write()
> > functions to ensure the index idx is within the valid range of the
> > reg_table array.
> >
> > The correct size of reg_table is determined dynamically based on whethe=
r
> > it is aspeed_3_3v_gpios or aspeed_1_8v_gpios. If idx exceeds the
> > size of reg_table, an error is logged, and the function returns.
> >
> > AddressSanitizer log indicating the issue:
> >
> > =3D=3D2602930=3D=3DERROR: AddressSanitizer: global-buffer-overflow on a=
ddress
> 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp 0x7fff096c4e88
> > READ of size 2 at 0x55a5da29e128 thread T0
> >     #0 0x55a5d700dc61 in aspeed_gpio_read hw/gpio/aspeed_gpio.c:564:14
> >     #1 0x55a5d933f3ab in memory_region_read_accessor
> system/memory.c:445:11
> >     #2 0x55a5d92fba40 in access_with_adjusted_size system/memory.c:573:=
18
> >     #3 0x55a5d92f842c in memory_region_dispatch_read1
> system/memory.c:1426:16
> >     #4 0x55a5d92f7b68 in memory_region_dispatch_read
> system/memory.c:1459:9
> >     #5 0x55a5d9376ad1 in flatview_read_continue_step
> system/physmem.c:2836:18
> >     #6 0x55a5d9376399 in flatview_read_continue system/physmem.c:2877:1=
9
> >     #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12
>
> I'm mildly interested in what you were doing to trigger this. Certainly
> we could do with a guard in the model to prevent it, but I'm curious
> all the same.
>

Actually, I'm doing the virtual device fuzzing test and trying to discover
bugs.

>
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  hw/gpio/aspeed_gpio.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> > index c1781e2ba3..1441046f6c 100644
> > --- a/hw/gpio/aspeed_gpio.c
> > +++ b/hw/gpio/aspeed_gpio.c
> > @@ -550,6 +550,7 @@ static uint64_t aspeed_gpio_read(void *opaque,
> hwaddr offset, uint32_t size)
> >      GPIOSets *set;
> >      uint32_t value =3D 0;
> >      uint64_t debounce_value;
> > +    uint32_t reg_table_size;
> >
> >      idx =3D offset >> 2;
> >      if (idx >=3D GPIO_DEBOUNCE_TIME_1 && idx <=3D GPIO_DEBOUNCE_TIME_3=
) {
> > @@ -559,6 +560,18 @@ static uint64_t aspeed_gpio_read(void *opaque,
> hwaddr offset, uint32_t size)
> >          return debounce_value;
> >      }
> >
> > +    if (agc->reg_table =3D=3D aspeed_3_3v_gpios) {
> > +        reg_table_size =3D GPIO_3_3V_REG_ARRAY_SIZE;
> > +    } else {
> > +        reg_table_size =3D GPIO_1_8V_REG_ARRAY_SIZE;
> > +    }
>
> I think I'd prefer we add reg_table_size as a member of AspeedGPIOClass
> and initialise it at the same time as we initialise reg_table. I feel
> it would help maintain safety in the face of future changes (i.e. if
> another reg table were introduced). With that approach the hunk above
> can be dropped.
>
> > +
> > +    if (idx >=3D reg_table_size) {
>
> This condition would then become:
>
> ```
> if (idx >=3D agc->reg_table_size) {
> ```
>
> Thoughts?
>

I agree with you, adding a new member is a more maintainable way, I'll send
a v2 patch, thanks!

Zheyu

--0000000000009d4402061b389a31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Andrew,</div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 19, 2024 at 1:=
58=E2=80=AFAM Andrew Jeffery &lt;<a href=3D"mailto:andrew@codeconstruct.com=
.au">andrew@codeconstruct.com.au</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hello Zheyu Ma,<br>
<br>
On Tue, 2024-06-18 at 15:09 +0200, Zheyu Ma wrote:<br>
&gt; Added bounds checking in the aspeed_gpio_read() and aspeed_gpio_write(=
)<br>
&gt; functions to ensure the index idx is within the valid range of the<br>
&gt; reg_table array.<br>
&gt; <br>
&gt; The correct size of reg_table is determined dynamically based on wheth=
er<br>
&gt; it is aspeed_3_3v_gpios or aspeed_1_8v_gpios. If idx exceeds the<br>
&gt; size of reg_table, an error is logged, and the function returns.<br>
&gt; <br>
&gt; AddressSanitizer log indicating the issue:<br>
&gt; <br>
&gt; =3D=3D2602930=3D=3DERROR: AddressSanitizer: global-buffer-overflow on =
address 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp 0x7fff096c=
4e88<br>
&gt; READ of size 2 at 0x55a5da29e128 thread T0<br>
&gt;=C2=A0 =C2=A0 =C2=A0#0 0x55a5d700dc61 in aspeed_gpio_read hw/gpio/aspee=
d_gpio.c:564:14<br>
&gt;=C2=A0 =C2=A0 =C2=A0#1 0x55a5d933f3ab in memory_region_read_accessor sy=
stem/memory.c:445:11<br>
&gt;=C2=A0 =C2=A0 =C2=A0#2 0x55a5d92fba40 in access_with_adjusted_size syst=
em/memory.c:573:18<br>
&gt;=C2=A0 =C2=A0 =C2=A0#3 0x55a5d92f842c in memory_region_dispatch_read1 s=
ystem/memory.c:1426:16<br>
&gt;=C2=A0 =C2=A0 =C2=A0#4 0x55a5d92f7b68 in memory_region_dispatch_read sy=
stem/memory.c:1459:9<br>
&gt;=C2=A0 =C2=A0 =C2=A0#5 0x55a5d9376ad1 in flatview_read_continue_step sy=
stem/physmem.c:2836:18<br>
&gt;=C2=A0 =C2=A0 =C2=A0#6 0x55a5d9376399 in flatview_read_continue system/=
physmem.c:2877:19<br>
&gt;=C2=A0 =C2=A0 =C2=A0#7 0x55a5d93775b8 in flatview_read system/physmem.c=
:2907:12<br>
<br>
I&#39;m mildly interested in what you were doing to trigger this. Certainly=
<br>
we could do with a guard in the model to prevent it, but I&#39;m curious<br=
>
all the same.<br></blockquote><div><br></div><div>Actually, I&#39;m doing t=
he virtual device fuzzing test and trying to discover bugs.=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Signed-off-by: Zheyu Ma &lt;<a href=3D"mailto:zheyuma97@gmail.com" tar=
get=3D"_blank">zheyuma97@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/gpio/aspeed_gpio.c | 26 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 26 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c<br>
&gt; index c1781e2ba3..1441046f6c 100644<br>
&gt; --- a/hw/gpio/aspeed_gpio.c<br>
&gt; +++ b/hw/gpio/aspeed_gpio.c<br>
&gt; @@ -550,6 +550,7 @@ static uint64_t aspeed_gpio_read(void *opaque, hwa=
ddr offset, uint32_t size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GPIOSets *set;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t value =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t debounce_value;<br>
&gt; +=C2=A0 =C2=A0 uint32_t reg_table_size;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 idx =3D offset &gt;&gt; 2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (idx &gt;=3D GPIO_DEBOUNCE_TIME_1 &amp;&amp; id=
x &lt;=3D GPIO_DEBOUNCE_TIME_3) {<br>
&gt; @@ -559,6 +560,18 @@ static uint64_t aspeed_gpio_read(void *opaque, hw=
addr offset, uint32_t size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return debounce_value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (agc-&gt;reg_table =3D=3D aspeed_3_3v_gpios) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_table_size =3D GPIO_3_3V_REG_ARRAY_SI=
ZE;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_table_size =3D GPIO_1_8V_REG_ARRAY_SI=
ZE;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
I think I&#39;d prefer we add reg_table_size as a member of AspeedGPIOClass=
<br>
and initialise it at the same time as we initialise reg_table. I feel<br>
it would help maintain safety in the face of future changes (i.e. if<br>
another reg table were introduced). With that approach the hunk above<br>
can be dropped.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (idx &gt;=3D reg_table_size) {<br>
<br>
This condition would then become:<br>
<br>
```<br>
if (idx &gt;=3D agc-&gt;reg_table_size) {<br>
```<br>
<br>
Thoughts?<br></blockquote><div><br></div><div>I agree with you, adding a ne=
w member is a more maintainable way, I&#39;ll send a v2 patch, thanks!<br><=
br></div><div>Zheyu=C2=A0</div></div></div>

--0000000000009d4402061b389a31--

