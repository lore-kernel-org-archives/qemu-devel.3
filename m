Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A3BC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjH-0005LO-DQ; Fri, 01 Mar 2024 23:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rgCiz-0005S8-15
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:55:33 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rgCiw-00031j-VN
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:55:32 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-563d56ee65cso4418677a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709337326; x=1709942126; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JJ5aRWjWsJYmRVmmKzPYLdKlvf9Lse8dvuFq4N39JEw=;
 b=nfajTLfn15BDczvyg0CXIjqXgbU86uXFHsFwVxrp5vH6ENR1DgmR1xLbxGIlvIPHTo
 8gX7h0UWeN5cyY4so9YfnrGxtbuIldb+IH83uF3R3NLcGB8fsaDhKr4Fst8uzGxmoz8A
 VWH/DPPdm8XD7ABT3xAec2UnbS9FVcqCnACNI/hv5f1zJTLA0iVjNN6o7N8//OeRUcRC
 E26WQhaKpHdAQRrFnq1GOG+IqSDUyscHqfb57aJHoGlxD15oaXlBwb7Q6vNAXix+NQbK
 +XPyquaHIceSi+trMP5UmRt1bG23U2KKqotZcvlcCiod5IMsJG+gwNmP2uKhrlI/bg9c
 oUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709337326; x=1709942126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JJ5aRWjWsJYmRVmmKzPYLdKlvf9Lse8dvuFq4N39JEw=;
 b=fuody0dnFVwCGHzqipjuxIsQPq49BFruq5rshMqOa75w+g9jYoEPxi+UYJ3BZCIQG0
 ZsoGAWAoJSkW5GnQeFp8rj3PwlZYZJI72FJRKaCf9gL9CLCjgDBgIqkCLuW+gFox620c
 idEEmdsRad8SO3k+AyLKA66xeNKMHzjoF9EpnjX23uXsRNFprbYLe+2gg/kCDVJJv+MM
 w6PAcfB/GMqufg9Idk2WfyrdAHFkHFh8+xjYgyJ/3I04DvnsZw4SGuUVlYqp1vwa6wpb
 T3RHJMbDaFYWuAxRqiG/j6LB9jNisKZ6ulu9LY2arInk0QaATRWO1kQhDkDyjTSW3b8X
 aBHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZkqfPU8t6hNneRvZEwpPdTCr+R74KxI2eh4Tg6tmXo124VvzRnFMDPc0HJhtmjeDm+PsrosDNDsXEg0DDHW9+gadZAno=
X-Gm-Message-State: AOJu0YwyUE1GsLXpidCjSttfeW/xoMfmgJA2eumtAy8RoMyJMLU9WE95
 cc89/wT0yjiezAb1i8FL0MNUXSOzUQtRv8jNnI+SuCc2PNgKe3TPLbgc37taDjCbheKLd+Zzo77
 YqR5SwLBEFGJHGAAS6Dgz8DPs8Vk=
X-Google-Smtp-Source: AGHT+IHc8HXU7tUQJ0jC1hJLqvrtfoonTz9c7GksOKzM59Ycvptea8c7tUEjPdCqx7qdhPcu0v44W374dTvPvk+PwAg=
X-Received: by 2002:a05:6402:2153:b0:566:777:af4f with SMTP id
 bq19-20020a056402215300b005660777af4fmr2115077edb.1.1709337326263; Fri, 01
 Mar 2024 15:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20240227222227.74935-1-greg@gpanders.com>
 <CAFEAcA-wrdUaH55ZmoCQAQ=zV=seaCo2hciXys_p4tKE08Tf3w@mail.gmail.com>
In-Reply-To: <CAFEAcA-wrdUaH55ZmoCQAQ=zV=seaCo2hciXys_p4tKE08Tf3w@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 1 Mar 2024 17:55:14 -0600
Message-ID: <CAJy5ezo20Hh7QN6S70fu+akYjhiB_RR=teo+UPigMwzyyb6NzA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: zynq_slcr: set SLC_RST bit in REBOOT_STATUS
 register
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gregory Anders <greg@gpanders.com>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: multipart/alternative; boundary="00000000000022223a0612a21cb0"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000022223a0612a21cb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 10:40=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Wed, 28 Feb 2024 at 01:40, Gregory Anders <greg@gpanders.com> wrote:
> >
> > When the CPU is reset using PSS_RST_CTRL in the SLCR, bit 19 in
> > REBOOT_STATUS should be set.
> >

> Refer to page 1602 of the Xilinx Zynq 7000 Technical Reference Manual.
> >
> > Signed-off-by: Gregory Anders <greg@gpanders.com>
> > ---
> >  hw/misc/zynq_slcr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
> > index d2ac2e77f2..a8f1792bf6 100644
> > --- a/hw/misc/zynq_slcr.c
> > +++ b/hw/misc/zynq_slcr.c
> > @@ -120,6 +120,7 @@ REG32(RS_AWDT_CTRL, 0x24c)
> >  REG32(RST_REASON, 0x250)
> >
> >  REG32(REBOOT_STATUS, 0x258)
> > +    FIELD(REBOOT_STATUS, SLC_RST, 19, 1)
> >  REG32(BOOT_MODE, 0x25c)
> >
> >  REG32(APU_CTRL, 0x300)
> > @@ -562,6 +563,7 @@ static void zynq_slcr_write(void *opaque, hwaddr
> offset,
> >      switch (offset) {
> >      case R_PSS_RST_CTRL:
> >          if (FIELD_EX32(val, PSS_RST_CTRL, SOFT_RST)) {
> > +            s->regs[R_REBOOT_STATUS] |=3D R_REBOOT_STATUS_SLC_RST_MASK=
;
> >              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> >          }
> >          break;
> > --
>
> The manual also says that "This field is written by ROM code",
> so as a model of the hardware should QEMU be writing it?
>
> I've cc'd the Zynq maintainers for their opinion.
>
>
Hi,

I don't have great answers unfortunately...

We haven't been super consistent with these things but on the ZynqMP we
sometimes require the user to apply ROM behaviour using -device loader on
the command-line (not great for this case since we wouldn't want the mask
to be set until a soft reset) or we conditionalize the ROM behaviour
checking if we're doing direct Linux boots..

Best regards,
Edgar




> thanks
> -- PMM
>

--00000000000022223a0612a21cb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Mar 1, 2024 at 10:40=E2=80=AFAM P=
eter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@=
linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Wed, 28 Feb 2024 at 01:40, Gregory =
Anders &lt;<a href=3D"mailto:greg@gpanders.com" target=3D"_blank">greg@gpan=
ders.com</a>&gt; wrote:<br>
&gt;<br>
&gt; When the CPU is reset using PSS_RST_CTRL in the SLCR, bit 19 in<br>
&gt; REBOOT_STATUS should be set.<br>
&gt;=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&g=
t; Refer to page 1602 of the Xilinx Zynq 7000 Technical Reference Manual.<b=
r>
&gt;<br>
&gt; Signed-off-by: Gregory Anders &lt;<a href=3D"mailto:greg@gpanders.com"=
 target=3D"_blank">greg@gpanders.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/misc/zynq_slcr.c | 2 ++<br>
&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c<br>
&gt; index d2ac2e77f2..a8f1792bf6 100644<br>
&gt; --- a/hw/misc/zynq_slcr.c<br>
&gt; +++ b/hw/misc/zynq_slcr.c<br>
&gt; @@ -120,6 +120,7 @@ REG32(RS_AWDT_CTRL, 0x24c)<br>
&gt;=C2=A0 REG32(RST_REASON, 0x250)<br>
&gt;<br>
&gt;=C2=A0 REG32(REBOOT_STATUS, 0x258)<br>
&gt; +=C2=A0 =C2=A0 FIELD(REBOOT_STATUS, SLC_RST, 19, 1)<br>
&gt;=C2=A0 REG32(BOOT_MODE, 0x25c)<br>
&gt;<br>
&gt;=C2=A0 REG32(APU_CTRL, 0x300)<br>
&gt; @@ -562,6 +563,7 @@ static void zynq_slcr_write(void *opaque, hwaddr o=
ffset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (offset) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case R_PSS_RST_CTRL:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FIELD_EX32(val, PSS_RST_CTRL, SO=
FT_RST)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_REBOOT_STATUS]=
 |=3D R_REBOOT_STATUS_SLC_RST_MASK;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_reset_requ=
est(SHUTDOWN_CAUSE_GUEST_RESET);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; --<br>
<br>
The manual also says that &quot;This field is written by ROM code&quot;,<br=
>
so as a model of the hardware should QEMU be writing it?<br>
<br>
I&#39;ve cc&#39;d the Zynq maintainers for their opinion.<br>
<br></blockquote><div><br></div><div><div>Hi,</div><div><br></div><div>I do=
n&#39;t have great answers unfortunately...</div><div><br></div><div>We hav=
en&#39;t been super consistent with these things but on the ZynqMP we somet=
imes require the user to apply ROM behaviour using -device loader on the co=
mmand-line (not great for this case since we wouldn&#39;t want the mask to =
be set until a soft reset) or we conditionalize the ROM behaviour checking=
=C2=A0if we&#39;re doing direct Linux boots..</div><div><br></div><div>Best=
 regards,</div><div>Edgar</div><div><br></div><div><br></div><div></div></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
thanks<br>
-- PMM<br>
</blockquote></div></div>

--00000000000022223a0612a21cb0--

