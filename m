Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2A1C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cWj-00052X-CZ; Wed, 08 May 2024 04:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1s4cWh-00051m-9h; Wed, 08 May 2024 04:19:47 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1s4cWf-0004wN-2w; Wed, 08 May 2024 04:19:47 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f0812c4500so1419662a34.0; 
 Wed, 08 May 2024 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715156383; x=1715761183; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XI2BpQK6OsL3TbZxQJOFvnNA6HfZALkfZfMV8OVrxts=;
 b=cYOrYNPyRBQNfXvgMJYXiuZNV/T0NktXabYevRuxAE5l7Jw4oHfQyho2SM9amsQKIb
 DCLGNrepGkjAgu9+baZeG4klBfCGRC/u8I1ZwtREObTtZhs+v1zLCqWjsT70x8XjfX+k
 S/W6XoJuA2mp6SjLT9VjgpJqeXsJoxk0d297cBnVLikLLmalaDp8YhrXEgBCrGEXH8au
 WG46O0u01AnZXr8fg8sP6vPykbqzKyGgh49wrPh1+oMjUR3RSwqqXwIAAiZNSOXyZyfF
 E4b+V8VmkQUG8YTx11fLRrARCMdxejlPWk6qYiTJ/4Sd6+6iHqoaf5DZiPG8afpVp9ER
 dTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715156383; x=1715761183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XI2BpQK6OsL3TbZxQJOFvnNA6HfZALkfZfMV8OVrxts=;
 b=PpwqFM+Z4tDUibPrYOnLcGlVUQLutpZh+mI/BBBhkorjoxTrxAzFrUYKBZnJk+1Kz/
 QsJhU+TiPJFqD0dQZyZBmxbYSBcDLsnsJI4RHOyOI6UBLFDncr2DgO+vDpBFY7rjI8In
 NVuoWQCT7lhroDYi520If9mjCkyYnUJJlnaonzW2If3Tvst4wscFdfy3klChGULyFV8v
 kfs44zglPZYXI4FcaXgHk5G0Cbw58swIOEYOKzPuRBqVHz9GyGau/tnfNdiMdcW3spph
 k+C2KjU60xe8LDil061PYgdgcmDyGk68UVARbb8EW8OWwXtRS7VCo4DtsUlplDfpOIlr
 PUeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO5/hSD+JSALvplXbK2/HvG+ebUOQP7H3sjscNiUFwoJSjLavPajbbYUwnJBoGbjzhcVaYe7P2Ck8fUMCfcl8qQMvy
X-Gm-Message-State: AOJu0YwnZCpEM9LY6hPtOuxQvLsTqo8uwXukmSx7r+HpfEb1sTg1OKkm
 IQjt2btoqdoyxFNRRkzkEyHzHRNh0MDjtQCNBI7SNsL9fvsb5CRQw5lT6ifSTwQ01rKjOKPGd3U
 Dw1rP7yAGTCv8jCEpsD+z5v7GX6I=
X-Google-Smtp-Source: AGHT+IFvMC6yYKNYr2USmvE9fKSXuQRrm6YmTpVg8rj6ikf/Rixcudu2Pd6uGqFhnq7dUhg+GCU0IhM5M1aRVFxZE3g=
X-Received: by 2002:a05:6870:b418:b0:23e:7432:6f1d with SMTP id
 586e51a60fabf-24097bdf635mr2056859fac.7.1715156383344; Wed, 08 May 2024
 01:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnsOnN6AkE3visU9jaycp61G87XRJFwDGx4D1=HJSJpA2tfXw@mail.gmail.com>
 <CAFEAcA8S1HJgcJdC5M=V1UHZHwNKhX_ii9PNNc88uC2Gi2E3sw@mail.gmail.com>
In-Reply-To: <CAFEAcA8S1HJgcJdC5M=V1UHZHwNKhX_ii9PNNc88uC2Gi2E3sw@mail.gmail.com>
From: Tanmay <tanmaynpatil105@gmail.com>
Date: Wed, 8 May 2024 13:49:32 +0530
Message-ID: <CAHnsOnPmo1FmDWgF-cnJKhjQ5sXJ7AmNvcf_Mg03+UKP+u+LXw@mail.gmail.com>
Subject: Re: [PATCH] Fixes: Indentation using TABs and improve formatting
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: multipart/alternative; boundary="000000000000f6af1e0617ecf6f0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=tanmaynpatil105@gmail.com; helo=mail-ot1-x332.google.com
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

--000000000000f6af1e0617ecf6f0
Content-Type: text/plain; charset="UTF-8"

Hi,

I just sent a patch with fewer files to address using git-send-email.

Thanks,
Tanmay

On Tue, 7 May 2024 at 15:56, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 6 May 2024 at 07:20, Tanmay <tanmaynpatil105@gmail.com> wrote:
> >
> > Hi,
> >
> > I have added a patch inline that fixes indentation and formatting for
> some files as listed in https://gitlab.com/qemu-project/qemu/-/issues/373.
> >
> > Thanks,
> > Tanmay
>
> Hi; thanks for this patch. Unfortunately there seem to be some
> problems with the formatting, which mean it doesn't apply correctly.
>
> In particular you've sent it as a plain/text + HTML email, and
> something (probably your mail client) is wrapping long lines.
> I can usually fix something like this up on my end for a first
> time submitter, but in this case the patch is just way too big
> for that to be practical.
>
> I generally don't recommend trying to send patch emails directly
> through the gmail web UI -- it unfortunately mangles them too
> much. Personally I use git-send-email; it is a bit awkward to
> set up, but https://git-send-email.io/ has a nice step-by-step
> guide including specific details on how to configure it to send
> via Gmail.
>
> > From 46026574821c46804111eea6607a1b39314b7abe Mon Sep 17 00:00:00 2001
> > From: Tanmay Patil <tanmaynpatil105@gmail.com>
> > Date: Sat, 25 Nov 2023 00:53:54 +0530
> > Subject: [PATCH] Fixes: Indentation using TABs and improve formatting
> >  Resolves: https://gitlab.com/qemu-project/qemu/-/issues/373
> >
> >    Files changed:
> >         - hw/arm/boot.c
> >         - hw/char/omap_uart.c
> >         - hw/dma/pxa2xx_dma.c
> >         - hw/gpio/omap_gpio.c
> >         - hw/gpio/zaurus.c
> >         - hw/input/tsc2005.c
> >         - hw/input/tsc210x.c
> >         - hw/intc/omap_intc.c
> >         - hw/misc/cbus.c
> >         - hw/misc/omap_clk.c
> >         - hw/misc/omap_l4.c
> >         - hw/misc/omap_sdrc.c
> >         - hw/misc/omap_tap.c
> >         - hw/sd/omap_mmc.c
> >         - hw/sd/pxa2xx_mmci.c
> >         - hw/timer/omap_gptimer.c
> >         - hw/timer/omap_synctimer.c
> >         - hw/timer/pxa2xx_timer.c
> >         - include/hw/arm/pxa.h
> >         - include/hw/arm/sharpsl.h
> >         - include/hw/arm/soc_dma.h
> >         - tcg/arm/tcg-target.h
> >
> > Signed-off-by: Tanmay Patil <tanmaynpatil105@gmail.com>
> > ---
> >  hw/arm/boot.c             |   8 +-
> >  hw/char/omap_uart.c       |  49 +-
> >  hw/dma/pxa2xx_dma.c       | 198 ++++----
> >  hw/gpio/omap_gpio.c       | 243 +++++-----
> >  hw/gpio/zaurus.c          |  61 +--
> >  hw/input/tsc2005.c        | 130 ++---
> >  hw/input/tsc210x.c        | 442 +++++++++--------
> >  hw/intc/omap_intc.c       | 261 +++++-----
> >  hw/misc/cbus.c            | 202 ++++----
> >  hw/misc/omap_clk.c        | 999 +++++++++++++++++++-------------------
> >  hw/misc/omap_l4.c         |  21 +-
> >  hw/misc/omap_sdrc.c       | 135 +++---
> >  hw/misc/omap_tap.c        |  28 +-
> >  hw/sd/omap_mmc.c          | 208 ++++----
> >  hw/sd/pxa2xx_mmci.c       | 149 +++---
> >  hw/timer/omap_gptimer.c   | 126 ++---
> >  hw/timer/omap_synctimer.c |   7 +-
> >  hw/timer/pxa2xx_timer.c   | 279 ++++++-----
> >  include/hw/arm/pxa.h      | 100 ++--
> >  include/hw/arm/sharpsl.h  |   2 +-
> >  include/hw/arm/soc_dma.h  |   4 +-
> >  tcg/arm/tcg-target.h      |   4 +-
> >  22 files changed, 1903 insertions(+), 1753 deletions(-)
>
> This is a lot of changes to do all in one commit, even though they're
> all just whitespace fixes. Could you split them up, please, into
> multiple patches that tackle fewer files at a time?
>
> thanks
> -- PMM
>

--000000000000f6af1e0617ecf6f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi,</p><p>I just sent a patch with fewer files to addre=
ss using git-send-email.</p><p>Thanks,<br>Tanmay</p></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 7 May 2024 at 1=
5:56, Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.m=
aydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Mon, 6 May 2024 at 07:20, Tanmay &lt;<a href=3D"mailto:=
tanmaynpatil105@gmail.com" target=3D"_blank">tanmaynpatil105@gmail.com</a>&=
gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; I have added a patch inline that fixes indentation and formatting for =
some files as listed in <a href=3D"https://gitlab.com/qemu-project/qemu/-/i=
ssues/373" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-pro=
ject/qemu/-/issues/373</a>.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Tanmay<br>
<br>
Hi; thanks for this patch. Unfortunately there seem to be some<br>
problems with the formatting, which mean it doesn&#39;t apply correctly.<br=
>
<br>
In particular you&#39;ve sent it as a plain/text + HTML email, and<br>
something (probably your mail client) is wrapping long lines.<br>
I can usually fix something like this up on my end for a first<br>
time submitter, but in this case the patch is just way too big<br>
for that to be practical.<br>
<br>
I generally don&#39;t recommend trying to send patch emails directly<br>
through the gmail web UI -- it unfortunately mangles them too<br>
much. Personally I use git-send-email; it is a bit awkward to<br>
set up, but <a href=3D"https://git-send-email.io/" rel=3D"noreferrer" targe=
t=3D"_blank">https://git-send-email.io/</a> has a nice step-by-step<br>
guide including specific details on how to configure it to send<br>
via Gmail.<br>
<br>
&gt; From 46026574821c46804111eea6607a1b39314b7abe Mon Sep 17 00:00:00 2001=
<br>
&gt; From: Tanmay Patil &lt;<a href=3D"mailto:tanmaynpatil105@gmail.com" ta=
rget=3D"_blank">tanmaynpatil105@gmail.com</a>&gt;<br>
&gt; Date: Sat, 25 Nov 2023 00:53:54 +0530<br>
&gt; Subject: [PATCH] Fixes: Indentation using TABs and improve formatting<=
br>
&gt;=C2=A0 Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issu=
es/373" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-projec=
t/qemu/-/issues/373</a><br>
&gt;<br>
&gt;=C2=A0 =C2=A0 Files changed:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/arm/boot.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/char/omap_uart.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/dma/pxa2xx_dma.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/gpio/omap_gpio.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/gpio/zaurus.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/input/tsc2005.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/input/tsc210x.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/intc/omap_intc.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/misc/cbus.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/misc/omap_clk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/misc/omap_l4.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/misc/omap_sdrc.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/misc/omap_tap.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/sd/omap_mmc.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/sd/pxa2xx_mmci.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/timer/omap_gptimer.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/timer/omap_synctimer.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- hw/timer/pxa2xx_timer.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- include/hw/arm/pxa.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- include/hw/arm/sharpsl.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- include/hw/arm/soc_dma.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- tcg/arm/tcg-target.h<br>
&gt;<br>
&gt; Signed-off-by: Tanmay Patil &lt;<a href=3D"mailto:tanmaynpatil105@gmai=
l.com" target=3D"_blank">tanmaynpatil105@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/arm/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A08 +-<br>
&gt;=C2=A0 hw/char/omap_uart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 49 +-<br>
&gt;=C2=A0 hw/dma/pxa2xx_dma.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 198 ++++----<br>
&gt;=C2=A0 hw/gpio/omap_gpio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 243 +++++-----<b=
r>
&gt;=C2=A0 hw/gpio/zaurus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 61 +-=
-<br>
&gt;=C2=A0 hw/input/tsc2005.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 130 ++---<br>
&gt;=C2=A0 hw/input/tsc210x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 442 +++++++++---=
-----<br>
&gt;=C2=A0 hw/intc/omap_intc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 261 +++++-----<b=
r>
&gt;=C2=A0 hw/misc/cbus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 202 ++=
++----<br>
&gt;=C2=A0 hw/misc/omap_clk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 999 ++++++++++++=
+++++++-------------------<br>
&gt;=C2=A0 hw/misc/omap_l4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 21 +-=
<br>
&gt;=C2=A0 hw/misc/omap_sdrc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 135 +++---<br>
&gt;=C2=A0 hw/misc/omap_tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 28 +-<br>
&gt;=C2=A0 hw/sd/omap_mmc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 208 ++++---=
-<br>
&gt;=C2=A0 hw/sd/pxa2xx_mmci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 149 +++---<br>
&gt;=C2=A0 hw/timer/omap_gptimer.c=C2=A0 =C2=A0| 126 ++---<br>
&gt;=C2=A0 hw/timer/omap_synctimer.c |=C2=A0 =C2=A07 +-<br>
&gt;=C2=A0 hw/timer/pxa2xx_timer.c=C2=A0 =C2=A0| 279 ++++++-----<br>
&gt;=C2=A0 include/hw/arm/pxa.h=C2=A0 =C2=A0 =C2=A0 | 100 ++--<br>
&gt;=C2=A0 include/hw/arm/sharpsl.h=C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 include/hw/arm/soc_dma.h=C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tcg/arm/tcg-target.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 22 files changed, 1903 insertions(+), 1753 deletions(-)<br>
<br>
This is a lot of changes to do all in one commit, even though they&#39;re<b=
r>
all just whitespace fixes. Could you split them up, please, into<br>
multiple patches that tackle fewer files at a time?<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000f6af1e0617ecf6f0--

