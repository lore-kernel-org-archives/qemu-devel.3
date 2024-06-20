Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6B0C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKIOG-0002Rh-Gk; Thu, 20 Jun 2024 10:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sKIO6-0002Ny-Pv; Thu, 20 Jun 2024 10:03:43 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sKIO5-0001fF-8Z; Thu, 20 Jun 2024 10:03:42 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57d1d45ba34so995030a12.3; 
 Thu, 20 Jun 2024 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718892219; x=1719497019; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+tu9WGfbjcq4lGy6RU0PDp8/3OjFL0eLiT8DXx0B/4I=;
 b=JpxVTxE99dqaewPMsIr1mZ5vjNGsYFVXdzkUlO3JE+QZ76n/S+zprdUen4h8BFxLy4
 JIF1NwyBc6H0wb64JWSPXdomSwMxnyNhe0R1t+ny8XFY8+wIb+MXeHEw3dgqmgB7/8ob
 LfSJpMGP0VvNTgikaYfA2RgvRnYDpaNWVFGfwGyh/FHlti2L8VDPQ9lSaueREz9aXBv3
 fwagF3mbpWHiowvr6e7FkXs/nfZy4I1H+/+njQoiIgL9dpWPnYs1txpqnMIN4cGCRLeq
 4RUJGpdm9liF3U61EUmIci1KPWMcFMr3R6jdm96PcqhnE6wL8Omgf5bNRfh2f1gyc+k5
 HjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718892219; x=1719497019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+tu9WGfbjcq4lGy6RU0PDp8/3OjFL0eLiT8DXx0B/4I=;
 b=ATYwDAQm8FjrkesFQYp7sCR013Zyr1R8SNDZRoFLqhe6m/+09jgotebr84Y6pfHu/D
 aNUFXqG+EOnelnaWI81h5Uhl3p+YJTpiT445F6cgBG/cnVhuCtfOG1naH16Rdou0+T2+
 ixRNWkWWw+xU+mC+GOt0PMhJN4lRS+ri0MrAHdzCaZKOnc/EhMhz57v5q7eDRHxaca1v
 1WKTam4tnDfY/aTEWm8tDPA8l17zj8cBTLYd5p1Q2ODqnt4alnWpsbdX09b33LIbfJoF
 fJGIA9D3nVrR2/Ztx32ufqgPou15f/cmiNvcKI11uwJEsOEE4v6NMUZ2ED3/9k8Afz0z
 +ohQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0i2bh8ppg/o0q2yuH2HQgPlSfbp1dKrLepqfmtWFvUJTNGslO7fpVeV/hVIsC+LSwuaPWjz24PkFcTF2rG5Dqz4MU9veHx7q696d0L896crS/SSy1wkeWPbA=
X-Gm-Message-State: AOJu0Yw4YMYN+HXMVEOwrSQOdUbrq835kWglW6iLLi33x18fUHf+6aqO
 g7ZQeji+qyP2P7nQ54CIeK3MZbbyl+DM2hoRhGWTJdlzTvalrptxxgn+ZFyqdRFBZRJR1IOwGFt
 Bd9cyalhQvPJBBdXomjRYUMnaGA==
X-Google-Smtp-Source: AGHT+IEVdZb3XaUrk6QTf0Cg+ywtu/9lVZZ89ub+ngURzOuL3WyktoOnv8YV3rnXF/Mevvwwu2BhjkGb/wncCx5hOro=
X-Received: by 2002:a17:907:c24d:b0:a6f:6c57:603c with SMTP id
 a640c23a62f3a-a6fab7d7cbbmr410576766b.70.1718892218814; Thu, 20 Jun 2024
 07:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240619183638.4073070-1-zheyuma97@gmail.com>
 <f446fdbf-90f2-4d07-8f1f-06b697ec8c01@linaro.org>
 <5d617ff8-dc3d-4126-8466-ed1596d3389d@kaod.org>
In-Reply-To: <5d617ff8-dc3d-4126-8466-ed1596d3389d@kaod.org>
From: Zheyu Ma <zheyuma97@gmail.com>
Date: Thu, 20 Jun 2024 16:03:27 +0200
Message-ID: <CAMhUBjme1Pj7k5=O9yBwABqM0kF9f29upfpJRTxZJAyz43T9Kw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/gpio/aspeed: Add reg_table_size to AspeedGPIOClass
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001c161e061b52c8a0"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=zheyuma97@gmail.com; helo=mail-ed1-x530.google.com
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

--0000000000001c161e061b52c8a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 2:35=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:

>
> >> @@ -75,6 +75,7 @@ struct AspeedGPIOClass {
> >>       uint32_t nr_gpio_pins;
> >>       uint32_t nr_gpio_sets;
> >>       const AspeedGPIOReg *reg_table;
> >> +    uint32_t reg_table_size;
> >>   };
> >
> > - "reg_table_size" is a number of registers, using s/size/count/ might
> >    be clearer.
> > - No point in specifying 32-bit, "unsigned" is sufficient.
> >
> > (C=C3=A9dric, if you agree, you might update your tree).
> >
> > Unrelated to this patch but figured out while reviewing, in
> > aspeed_gpio_read/write 'idx' is
> > - pointlessly assigned to -1
> > - of type 'uint64_t', also pointless, 'unsigned' is clearer.
>
> Zheyu, could you please send a v4 ? Thanks,
>

Sure. I've sent it.

Zheyu

--0000000000001c161e061b52c8a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Thu, Jun 20, 2024 at 2:35=E2=80=AFPM C=C3=A9dr=
ic Le Goater &lt;<a href=3D"mailto:clg@kaod.org">clg@kaod.org</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
&gt;&gt; @@ -75,6 +75,7 @@ struct AspeedGPIOClass {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t nr_gpio_pins;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t nr_gpio_sets;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const AspeedGPIOReg *reg_table;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t reg_table_size;<br>
&gt;&gt; =C2=A0 };<br>
&gt; <br>
&gt; - &quot;reg_table_size&quot; is a number of registers, using s/size/co=
unt/ might<br>
&gt;=C2=A0 =C2=A0 be clearer.<br>
&gt; - No point in specifying 32-bit, &quot;unsigned&quot; is sufficient.<b=
r>
&gt; <br>
&gt; (C=C3=A9dric, if you agree, you might update your tree).<br>
&gt; <br>
&gt; Unrelated to this patch but figured out while reviewing, in<br>
&gt; aspeed_gpio_read/write &#39;idx&#39; is<br>
&gt; - pointlessly assigned to -1<br>
&gt; - of type &#39;uint64_t&#39;, also pointless, &#39;unsigned&#39; is cl=
earer.<br>
<br>
Zheyu, could you please send a v4 ? Thanks,<br></blockquote><div>=C2=A0</di=
v><div>Sure. I&#39;ve sent it.<br><br>Zheyu=C2=A0</div></div></div>

--0000000000001c161e061b52c8a0--

