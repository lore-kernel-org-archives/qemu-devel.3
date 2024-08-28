Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4545DC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 10:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjG34-0007VP-Bt; Wed, 28 Aug 2024 06:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1sjG32-0007Us-6r
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 06:37:08 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1sjG30-0006YE-7E
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 06:37:07 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so4189266a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 03:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724841424; x=1725446224; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B9Lu1GuLdPX8bkjoICY3OZv8cTJUsK79NjFogW1jU0E=;
 b=gHvihvxVkuHFexkm1Rf8VjujPLX3RQR8CiN5pmKe5zqGKuYRHy6JnhUxSEte8+QWAT
 1AOZ07bdtdiLFfLxuH58HED0reEWvsa2CYfhID0kK/yeRBJsPB2fcoN6XkCOvNTfLRLq
 qn09wRlZ1mDQSsCb1FI1fWHX7tJTcFq6V9ziAXGAXYk+7M9hq0yiB7RcSQs3LyGUVDbG
 mUW+9pRkk4OnxtfuQOT0AfcQOwsYDj+ES8+7vTkEUPPVo4S4jVwdIjVFbVvih0Dw/FqR
 HqwhQIXDkJ7nOaQFi8+pc8ju4pTpNh3vlVIpDXfQUXgTz/4GFZIHKrimgoq45kftDtlv
 gqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724841424; x=1725446224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B9Lu1GuLdPX8bkjoICY3OZv8cTJUsK79NjFogW1jU0E=;
 b=IB59+VXoroxpVmxPPkdcW3dSplyLQumt7qnFJh6SY9D1BXhJwz3pVak9b7JTsuDyzn
 cL4L1Oag9k8DohrFATBcueb0AdjqToIO+DpJ1yW0yC7JsVPmSMmscoSyB5353BKjoSYC
 i03ZdnX4luijq+Hbv0rwbvSiTMteg0juNy3nNkgrkhowFbaz7s3Rf0KHYx5T9xYyIQld
 zX6wqxo1lGWKBrRcutgAbCa+R6DkWSV9bfyuRYCux9JhkcNDosXtFs2hUyT9u58M4Pzb
 6SQTciktCpS8jd8GMIn2Kz51E7BR8yZ2rdBJ8vN+uIZw2X2f3V/xtEMWGTsQGHlamZcV
 +rOg==
X-Gm-Message-State: AOJu0YwsJCGqe9jZq+vN7iEV9xbXvW6VTYKQzhZWkMKze/Co01SKz4sL
 vSaUXHGamvgCNaYe6pIsQzHknk6H6MfyuJRF1C4daDLfxs1OoWVhMUyrAwngQIHi8lWe6zIOHJb
 XPf1QeCuvMglFy3RDhh65cAVjC9U=
X-Google-Smtp-Source: AGHT+IFXDEScVjvcZ+7CrjU/h2PHE0gBMVqF9br1vUnHMw6XuVmIKPsFgMkDPdvqDyWBXA6Z0+2Mw1CUDxnA10gyu84=
X-Received: by 2002:a17:90b:3852:b0:2d3:db91:ee82 with SMTP id
 98e67ed59e1d1-2d646d59aa1mr13864887a91.40.1724841423840; Wed, 28 Aug 2024
 03:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240816162044.5764-1-just4now666666@gmail.com>
 <871q2ae24s.fsf@draig.linaro.org>
 <CACkyd_anZKrjNUKE+nwzSvJGQwxQ2zq2J8sGawq3pKYLVT9vXQ@mail.gmail.com>
In-Reply-To: <CACkyd_anZKrjNUKE+nwzSvJGQwxQ2zq2J8sGawq3pKYLVT9vXQ@mail.gmail.com>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Wed, 28 Aug 2024 13:36:52 +0300
Message-ID: <CACkyd_ZNPzhg8pqkdLucyJ70wZKJARR_65r5CJBy0+U=7GR_1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005cac5f0620bbf040"
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=just4now666666@gmail.com; helo=mail-pg1-x533.google.com
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

--0000000000005cac5f0620bbf040
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Although it gives `undefined symbol: qemu_plugin_scoreboard_free`. But
probably I messed something up...

On Tue, Aug 27, 2024, 14:59 Elisha Hollander <just4now666666@gmail.com>
wrote:

> Oh nice, I didn't know that
>
> On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>> Elisha Hollander <just4now666666@gmail.com> writes:
>>
>> > Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
>>
>> What is the use-case for this patch?
>>
>> If you are simply looking to slow the emulated system down please have a
>> look at:
>>
>>
>> https://qemu.readthedocs.io/en/master/about/emulation.html#limit-instruc=
tions-per-second
>>
>> which uses the plugin system to limit the run rate and sleep if its
>> running too fast. The longer term goal is to deprecate the icount clock
>> alignment feature from the core code and leave icount to just provide
>> the deterministic execution needed for record/replay and reverse
>> debugging.
>>
>>
>> > ---
>> >  accel/tcg/cpu-exec.c      | 4 +---
>> >  accel/tcg/icount-common.c | 4 ++--
>> >  2 files changed, 3 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> > index 8163295f34..4c2baf8ed4 100644
>> > --- a/accel/tcg/cpu-exec.c
>> > +++ b/accel/tcg/cpu-exec.c
>> > @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc, CPUState
>> *cpu)
>> >  static void print_delay(const SyncClocks *sc)
>> >  {
>> >      static float threshold_delay;
>> > -    static int64_t last_realtime_clock;
>> >      static int nb_prints;
>> >
>> >      if (icount_align_option &&
>> > -        sc->realtime_clock - last_realtime_clock >=3D
>> MAX_DELAY_PRINT_RATE &&
>> > +        sc->diff_clk >=3D MAX_DELAY_PRINT_RATE &&
>> >          nb_prints < MAX_NB_PRINTS) {
>> >          if ((-sc->diff_clk / (float)1000000000LL > threshold_delay) |=
|
>> >              (-sc->diff_clk / (float)1000000000LL <
>> > @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)
>> >                          threshold_delay - 1,
>> >                          threshold_delay);
>> >              nb_prints++;
>> > -            last_realtime_clock =3D sc->realtime_clock;
>> >          }
>> >      }
>> >  }
>> > diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
>> > index 8d3d3a7e9d..f07f8baf4d 100644
>> > --- a/accel/tcg/icount-common.c
>> > +++ b/accel/tcg/icount-common.c
>> > @@ -46,8 +46,8 @@
>> >   * is TCG-specific, and does not need to be built for other accels.
>> >   */
>> >  static bool icount_sleep =3D true;
>> > -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
>> > -#define MAX_ICOUNT_SHIFT 10
>> > +/* Arbitrarily pick the minimum allowable speed.  */
>> > +#define MAX_ICOUNT_SHIFT 30
>> >
>> >  /* Do not count executed instructions */
>> >  ICountMode use_icount =3D ICOUNT_DISABLED;
>>
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>>
>

--0000000000005cac5f0620bbf040
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Although it gives `undefined symbol: qemu_plugin_scoreboard_=
free`. But probably I messed something up...</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, Aug 27, 2024, 14:59 Elisha Hollander &lt;<a href=3D"mailto:just4now666666=
@gmail.com">just4now666666@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><p dir=3D"ltr">Oh nice, I didn&#39;t know that</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, Aug 27, 2024, 12:39 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">Elisha Hollander &lt;<a h=
ref=3D"mailto:just4now666666@gmail.com" rel=3D"noreferrer noreferrer" targe=
t=3D"_blank">just4now666666@gmail.com</a>&gt; writes:<br>
<br>
&gt; Signed-off-by: Elisha Hollander &lt;<a href=3D"mailto:just4now666666@g=
mail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">just4now666666@gm=
ail.com</a>&gt;<br>
<br>
What is the use-case for this patch?<br>
<br>
If you are simply looking to slow the emulated system down please have a<br=
>
look at:<br>
<br>
=C2=A0 <a href=3D"https://qemu.readthedocs.io/en/master/about/emulation.htm=
l#limit-instructions-per-second" rel=3D"noreferrer noreferrer noreferrer" t=
arget=3D"_blank">https://qemu.readthedocs.io/en/master/about/emulation.html=
#limit-instructions-per-second</a><br>
<br>
which uses the plugin system to limit the run rate and sleep if its<br>
running too fast. The longer term goal is to deprecate the icount clock<br>
alignment feature from the core code and leave icount to just provide<br>
the deterministic execution needed for record/replay and reverse<br>
debugging.<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 accel/tcg/cpu-exec.c=C2=A0 =C2=A0 =C2=A0 | 4 +---<br>
&gt;=C2=A0 accel/tcg/icount-common.c | 4 ++--<br>
&gt;=C2=A0 2 files changed, 3 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c<br>
&gt; index 8163295f34..4c2baf8ed4 100644<br>
&gt; --- a/accel/tcg/cpu-exec.c<br>
&gt; +++ b/accel/tcg/cpu-exec.c<br>
&gt; @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc, CPUState =
*cpu)<br>
&gt;=C2=A0 static void print_delay(const SyncClocks *sc)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 static float threshold_delay;<br>
&gt; -=C2=A0 =C2=A0 static int64_t last_realtime_clock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 static int nb_prints;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (icount_align_option &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&gt;realtime_clock - last_realtime_clo=
ck &gt;=3D MAX_DELAY_PRINT_RATE &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&gt;diff_clk &gt;=3D MAX_DELAY_PRINT_R=
ATE &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_prints &lt; MAX_NB_PRINTS) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((-sc-&gt;diff_clk / (float)10000=
00000LL &gt; threshold_delay) ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (-sc-&gt;diff_clk / (f=
loat)1000000000LL &lt;<br>
&gt; @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 threshold_delay - 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 threshold_delay);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_prints++;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_realtime_clock =3D sc-=
&gt;realtime_clock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c<br>
&gt; index 8d3d3a7e9d..f07f8baf4d 100644<br>
&gt; --- a/accel/tcg/icount-common.c<br>
&gt; +++ b/accel/tcg/icount-common.c<br>
&gt; @@ -46,8 +46,8 @@<br>
&gt;=C2=A0 =C2=A0* is TCG-specific, and does not need to be built for other=
 accels.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 static bool icount_sleep =3D true;<br>
&gt; -/* Arbitrarily pick 1MIPS as the minimum allowable speed.=C2=A0 */<br=
>
&gt; -#define MAX_ICOUNT_SHIFT 10<br>
&gt; +/* Arbitrarily pick the minimum allowable speed.=C2=A0 */<br>
&gt; +#define MAX_ICOUNT_SHIFT 30<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* Do not count executed instructions */<br>
&gt;=C2=A0 ICountMode use_icount =3D ICOUNT_DISABLED;<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>
</blockquote></div>

--0000000000005cac5f0620bbf040--

