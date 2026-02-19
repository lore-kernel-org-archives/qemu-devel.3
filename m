Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF40C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 20:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtAQS-0006H3-6O; Thu, 19 Feb 2026 15:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <buenocalvachejoel@gmail.com>)
 id 1vtAQQ-0006Gi-Qx
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 15:15:02 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <buenocalvachejoel@gmail.com>)
 id 1vtAQP-0006za-4Q
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 15:15:02 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c6de5ea6879so105843a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 12:15:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771532099; cv=none;
 d=google.com; s=arc-20240605;
 b=J6XnAe4mWlIQQapLaDjadvXzfSCoP7C9YXjeDjqojFs1nt0Evo+EJL5Ebv1HKAHmNG
 t2qYqGJJoMsmJVUynZfAGXmNJBQe9srQWszBjXLm73rScxC0fq+G6BgST2Se8xCTVJwz
 oLrgvt+JW8iRnfbUJjyXHbEbsLj906CSeV3kFewRR1hmc21/6iIjjikswX7dRMA7X+kI
 BWCiG4RUhqFECCSjkHYudtph3ozUj88W3MC+RNd94fp/ft9S2EVAVHuHlg1wULt1IO87
 fzBppxZfJwL/CZjy2L+/3JPRyaXYlERShAJdlAcXoNc5L6uS78HZP9VP8R7RkzpavWRD
 0lMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oMBPphu1KKb9RbA627PJDN/pd9c4/p9hxkKeEf8SKV0=;
 fh=2NNGlmBlj/+wnfISg5bNet0Uar/QECWjmYeFAdH5Dac=;
 b=E8cUoucKCQfMSYmGGQkIzGzYj+fACBsUKi4jM7gkRfgSLUz/8RG21YZunJQC6qsR3F
 J6tDDw04/UKnSc9pfOO4AiHu+KZX4h4FHFoL8A/Jst0a0bLVPYorYkZjqBw5oqHB6Wrg
 ws24u5PgY5prb868WzJhnoJdLxHNNEDuJU8jkeccHtD2p/qOX+dB69Bd3z894fbs6PrE
 ZrHh8yfDvj6ocwuQ7NBDnsH9Vq6cV/7oD46kpO1u6RYNF51DauS1J4iYr7+ouct82zGf
 XNWjXop9a9tlm8BORhSMQaVgpHKZGGQ0vRR2Ap9koNKtpmZj0bbxV95DkNY5XCgM9vUl
 priA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771532099; x=1772136899; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oMBPphu1KKb9RbA627PJDN/pd9c4/p9hxkKeEf8SKV0=;
 b=RgJII6V4r0ZV6CDWoWcNCRu7Am7iWuW1Rqma5BQi62YmbkADPO2CDnU6pIMNMMhpha
 EXa7HWI0Nxw+3hmWmd5zs0n9bPfTemx5V+KHPUh8r6S25tX8IkBGshDb11D2N8H1v1gM
 ctaQyt/mpnToWWoL0aT6SGqDMOaObhehuB+hCol2HEARiZS0BBFhS+gPPKq3zpGOevfS
 xfX2Dbacb7WxUEj+hkg7JrkphBrokKewKo/wteI+++TAujvQb7rLKveiTFF7gCTmmOhL
 qghWf73MbQ7ywn2ynCzHqRXITEG+rBOR73YTEbiIdAyb6fAA/PzimSqHhPErozmTETPF
 Xzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771532099; x=1772136899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMBPphu1KKb9RbA627PJDN/pd9c4/p9hxkKeEf8SKV0=;
 b=NK68cu/5wMwXRk+Gs9lBz0JFHiA8gNL9J7bPXW4EYDndtiHv/Jy8ox9YEZ5mQRYuVD
 jsY6Gq/ezJrRApVov80/dgNQdk8HQm1+WyzIMT5GciBg/xY1TDZSAsSYqmBi4pRbWBPb
 U7E7ZR7zTlTJ87AT0j8/iJ/Z1W96zkOv0Rn5gl92mBqizho5aEfbvKdp0XfvCxVIrRYj
 C6iVmOhvAlPLFKQB3GDs1VbrfpbswKzWo6CmW2J+0XQascO1g0Qx3vUGghG2/mSoxlwK
 mdexTqa0JDDhb69UoW16tz86F4cmx8pvlXH15qEsOYG52QOwTmJgYQwIGUr1SlDCOG8e
 zurA==
X-Gm-Message-State: AOJu0YyfCMOx7eibuF7H5L9YLQrQeU8dIRL97BIDb2lxCznQiZNIyclC
 Z4KXnGvhgkn9gXAnpWaa6ehQSN5+UYW7MS2YL4gIyF7UtRZ7NKSmFB5Tbp41xtMQPGt3ns5/oTc
 GIiG6DCQ8RjmsV08nFxPPpIzSTuqu0aQ=
X-Gm-Gg: AZuq6aIqOHnLXAAj6/1oTDJumLCyBGrtwCSN4KEuGXIw0OM9qWpulMugzT/ouK4n6rN
 OQqB+gRJYVn3QY6ignfmVHfdA2AIK1NqtTFtpNqMPpJqzUdeLv4D7ACutDAPihvnvbbytBsnWXg
 aan3Gk25c7+zztDRijoguVhD+wF3VcpQTyHUUNhOp/Q6ASQztFar0sfTOZWQ0gSCI0YHr7GYMdY
 bZEGIw+I8RQGtsfpTBin42/5umyQhoC0rRLLtIAsC2IHJCSfLviReCPNu43tSumG+Vm0r6yM+Yp
 bc6mrZ9wGBISQmrZR6j8WL2EPJEuC4EjAcpsDQ4=
X-Received: by 2002:a17:90b:47:b0:356:216c:ed64 with SMTP id
 98e67ed59e1d1-356a7a8adf3mr15356068a91.6.1771532098838; Thu, 19 Feb 2026
 12:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20251221105340.2699327-1-buenocalvachejoel@gmail.com>
 <CAPDLHD5HGNAu1=JD=V-9YQMpR_8-tWjONex2jj4ZFHbNe9qVcg@mail.gmail.com>
 <CAFEAcA8xsFeCAnvna4+mFQuZCx8gNEJX5BbFzTYkr6rcaX43Lw@mail.gmail.com>
In-Reply-To: <CAFEAcA8xsFeCAnvna4+mFQuZCx8gNEJX5BbFzTYkr6rcaX43Lw@mail.gmail.com>
From: Joel Bueno <buenocalvachejoel@gmail.com>
Date: Thu, 19 Feb 2026 21:14:47 +0100
X-Gm-Features: AaiRm50HAO3YHWRYvkyKVEUmPCfC4cEcXtS_zVXjwLb9gPYuijEcG5k6eV5zkIo
Message-ID: <CAPDLHD5q2J_SV74Hnt3cPcwyrh7w=Rtz9w7y3H9ZVvse88UmOA@mail.gmail.com>
Subject: Re: [PATCH] hw/block/m25p80: Fix Winbond Fast Read dummy cycles
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000075a820064b32f5cf"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=buenocalvachejoel@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000075a820064b32f5cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It=E2=80=99s a board we=E2=80=99re trying to bringup at my current company,=
 we were trying
to understand why the hardware was working fine but didn=E2=80=99t under QE=
MU.

Turns out the logic that was used to determine the timing value was
slightly incorrect and was making the flash completely unresponsive under
certain conditions early on the boot process.

Thanks for adding C=C3=A9dric!

On Thu, Feb 19, 2026 at 21:01 Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Wed, 7 Jan 2026 at 11:30, Joel Bueno <buenocalvachejoel@gmail.com>
> wrote:
> >
> > Is there any feedback on this patch series?
>
> Which board model(s) does this affect? You might have
> some luck cc'ing their maintainers.
>
> I've cc'd C=C3=A9dric who has done review in m25p80.c in the past.
>
> > On Sun, Dec 21, 2025 at 11:53 Joel Bueno <buenocalvachejoel@gmail.com>
> wrote:
> >>
> >> The Fast Read (0Bh) instruction requires 8 dummy clock cycles
> >> according to Winbond datasheets (e.g., W25Q256JV Section 8.2.12).
> >> However, the current code adds 8 to needed_bytes, which represents
> >> bytes, not clock cycles. Since 8 clock cycles equals 1 byte in SPI
> >> communication (1 bit per clock edge), this results in 64 dummy
> >> clock cycles instead of 8.
> >>
> >> Change the Winbond case to add 1 byte (8 clocks) instead of 8 bytes
> >> (64 clocks), matching the existing implementation for SST flash and
> >> the datasheet specifications.
> >>
> >> Signed-off-by: Joel Bueno <buenocalvachejoel@gmail.com>
> >> ---
> >>  hw/block/m25p80.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> >> index a5336d92ff..21c2118b33 100644
> >> --- a/hw/block/m25p80.c
> >> +++ b/hw/block/m25p80.c
> >> @@ -1001,7 +1001,7 @@ static void decode_fast_read_cmd(Flash *s)
> >>          s->needed_bytes +=3D 1;
> >>          break;
> >>      case MAN_WINBOND:
> >> -        s->needed_bytes +=3D 8;
> >> +        s->needed_bytes +=3D 1;
> >>          break;
> >>      case MAN_NUMONYX:
> >>          s->needed_bytes +=3D numonyx_extract_cfg_num_dummies(s);
> >> --
> >> 2.51.0
>
> -- PMM
>

--00000000000075a820064b32f5cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It=E2=80=99s a board we=E2=80=99re trying to bringup at m=
y current company, we were trying to understand why the hardware was workin=
g fine but didn=E2=80=99t=C2=A0under QEMU.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Turns out the logic that was used to determine the timin=
g value was slightly incorrect and was making the flash completely unrespon=
sive under certain conditions early on the boot process.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Thanks for adding C=C3=A9dric!</div><div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Feb 19, 2026 at 21:01 Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-=
color:rgb(204,204,204)">On Wed, 7 Jan 2026 at 11:30, Joel Bueno &lt;<a href=
=3D"mailto:buenocalvachejoel@gmail.com" target=3D"_blank">buenocalvachejoel=
@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Is there any feedback on this patch series?<br>
<br>
Which board model(s) does this affect? You might have<br>
some luck cc&#39;ing their maintainers.<br>
<br>
I&#39;ve cc&#39;d C=C3=A9dric who has done review in m25p80.c in the past.<=
br>
<br>
&gt; On Sun, Dec 21, 2025 at 11:53 Joel Bueno &lt;<a href=3D"mailto:buenoca=
lvachejoel@gmail.com" target=3D"_blank">buenocalvachejoel@gmail.com</a>&gt;=
 wrote:<br>
&gt;&gt;<br>
&gt;&gt; The Fast Read (0Bh) instruction requires 8 dummy clock cycles<br>
&gt;&gt; according to Winbond datasheets (e.g., W25Q256JV Section 8.2.12).<=
br>
&gt;&gt; However, the current code adds 8 to needed_bytes, which represents=
<br>
&gt;&gt; bytes, not clock cycles. Since 8 clock cycles equals 1 byte in SPI=
<br>
&gt;&gt; communication (1 bit per clock edge), this results in 64 dummy<br>
&gt;&gt; clock cycles instead of 8.<br>
&gt;&gt;<br>
&gt;&gt; Change the Winbond case to add 1 byte (8 clocks) instead of 8 byte=
s<br>
&gt;&gt; (64 clocks), matching the existing implementation for SST flash an=
d<br>
&gt;&gt; the datasheet specifications.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Joel Bueno &lt;<a href=3D"mailto:buenocalvachejoel@=
gmail.com" target=3D"_blank">buenocalvachejoel@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 hw/block/m25p80.c | 2 +-<br>
&gt;&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c<br>
&gt;&gt; index a5336d92ff..21c2118b33 100644<br>
&gt;&gt; --- a/hw/block/m25p80.c<br>
&gt;&gt; +++ b/hw/block/m25p80.c<br>
&gt;&gt; @@ -1001,7 +1001,7 @@ static void decode_fast_read_cmd(Flash *s)<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;needed_bytes +=3D 1;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 case MAN_WINBOND:<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;needed_bytes +=3D 8;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;needed_bytes +=3D 1;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 case MAN_NUMONYX:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;needed_bytes +=3D numonyx_=
extract_cfg_num_dummies(s);<br>
&gt;&gt; --<br>
&gt;&gt; 2.51.0<br>
<br>
-- PMM<br>
</blockquote></div></div>

--00000000000075a820064b32f5cf--

