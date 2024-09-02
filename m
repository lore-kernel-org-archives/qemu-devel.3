Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750C2CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 12:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl6L7-0002oM-Bv; Mon, 02 Sep 2024 08:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1sl6Kt-0002Xp-Lw
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 08:39:15 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1sl6Km-0001C9-Sq
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 08:39:10 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7b8884631c4so1601022a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725280742; x=1725885542; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DUWDoj+i5rKDxCQTqVAGbxju5/JuZ3QV39vGfzOFbGc=;
 b=M/ITLsGDSXIUzWN7y1EG3uizQ7/VhHxUc5BtHy3GpvTpJDC3QQl3O0Atb0QdnlGZjz
 UxSZHzVIthblMMo2X3feYHydP9uem2PmekNmVH3ZpK43vJAxRKyTrCaNd7rsk7IZvV07
 cK3FXcGUAreoOT+cz2slBD2b6K3lYbJpZ3yyozL2jX413WnWy1sc27yt8P8uk9Jv0vdA
 WQTyTwPR+lrAhN4vq67MGXzr63SpaukumImxVth2s8AelR9fnrmm05v7AA87+HmSFkzM
 4yqG/c3uH/4SGODHnLQwtTGlW6btSQw/Z+NMp728tobWbhbxlp23UeKIsRfcWJcZOQiA
 T7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725280742; x=1725885542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DUWDoj+i5rKDxCQTqVAGbxju5/JuZ3QV39vGfzOFbGc=;
 b=A0XEkcaWYrm2BvUEgan+iH9b/xMp1MXlegNNmmKAtjaefDtrRz2pAzzgrG1bS/JpDC
 cElFrBgDEou4pGzQEacZF43sf7iF+9m28U06hajm77x5pRk+wcBwCalOSo44PX/AFW9D
 N4DrvNrt7gNQCAphfTPJsixiiB1Q3YcCZGzJBdRJZMx4z0thJikcLe7ipKbw2feIj9Ud
 vez6+0S8UAR4sGS1qLCS7BX0Vv6+tLGrtCFz+xL88IFcdUbIm9C1Lxd9MO+WCO3hEceY
 BFRYaJgjqCqRzvVJJNEXReB02WeQk9krr1gvB9W7zlo8TwMVNjBVZXCCWWP4a0hvyn+L
 4wUQ==
X-Gm-Message-State: AOJu0Yz8NpqjstTRJBgjYaovepvuA8UwRweF3N4csUixyGFx00FqmPnE
 7sgJpMlQYrAk74xNB4Idh4h1FG2IQN8fSUF8Q9Vl8+5412lhWcQi13f0ji3SMjn8PWKrpHas770
 qFqAcVtOeTuDTAB7IEuW+aOotUIY=
X-Google-Smtp-Source: AGHT+IGlDRmY1LKu30ljnMwrVPJikQgzAx5aECHUsDAlzoXVMxwSJC6IDxPshZLXC9lgXTo2ZZ6k6umpr9DAaluqhW0=
X-Received: by 2002:a05:6a21:3189:b0:1ca:dcae:a798 with SMTP id
 adf61e73a8af0-1cecf49af4dmr7770815637.9.1725280742183; Mon, 02 Sep 2024
 05:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240816162044.5764-1-just4now666666@gmail.com>
 <871q2ae24s.fsf@draig.linaro.org>
 <CACkyd_anZKrjNUKE+nwzSvJGQwxQ2zq2J8sGawq3pKYLVT9vXQ@mail.gmail.com>
 <CACkyd_ZNPzhg8pqkdLucyJ70wZKJARR_65r5CJBy0+U=7GR_1Q@mail.gmail.com>
 <87h6b452m5.fsf@draig.linaro.org>
 <CACkyd_YG-r837VfoPaOw5bKCczAUQYFOobW=2SF37esppbc0XQ@mail.gmail.com>
In-Reply-To: <CACkyd_YG-r837VfoPaOw5bKCczAUQYFOobW=2SF37esppbc0XQ@mail.gmail.com>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 2 Sep 2024 15:38:48 +0300
Message-ID: <CACkyd_ZhByWwPQtFmHGRQxmBcVwCEyeSKX6fqhS3K=1480ASOA@mail.gmail.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c6993206212239a1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=just4now666666@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000c6993206212239a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

But for qemu_plugin_update_ns

On Mon, Sep 2, 2024, 15:38 Elisha Hollander <just4now666666@gmail.com>
wrote:

> Just checked with 9.0.2 it it still gives the error...
>
> On Wed, Aug 28, 2024, 14:05 Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>> Elisha Hollander <just4now666666@gmail.com> writes:
>>
>> > Although it gives `undefined symbol: qemu_plugin_scoreboard_free`. But
>> > probably I messed something up...
>>
>> Are you using an older QEMU? We should trigger an API warning if they
>> are mismatched but maybe thats not working.
>>
>> >
>> > On Tue, Aug 27, 2024, 14:59 Elisha Hollander <just4now666666@gmail.com=
>
>> wrote:
>> >
>> >  Oh nice, I didn't know that
>> >
>> >  On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> wrote:
>> >
>> >  Elisha Hollander <just4now666666@gmail.com> writes:
>> >
>> >  > Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
>> >
>> >  What is the use-case for this patch?
>> >
>> >  If you are simply looking to slow the emulated system down please hav=
e
>> a
>> >  look at:
>> >
>> >
>> https://qemu.readthedocs.io/en/master/about/emulation.html#limit-instruc=
tions-per-second
>> >
>> >  which uses the plugin system to limit the run rate and sleep if its
>> >  running too fast. The longer term goal is to deprecate the icount clo=
ck
>> >  alignment feature from the core code and leave icount to just provide
>> >  the deterministic execution needed for record/replay and reverse
>> >  debugging.
>> >
>> >  > ---
>> >  >  accel/tcg/cpu-exec.c      | 4 +---
>> >  >  accel/tcg/icount-common.c | 4 ++--
>> >  >  2 files changed, 3 insertions(+), 5 deletions(-)
>> >  >
>> >  > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> >  > index 8163295f34..4c2baf8ed4 100644
>> >  > --- a/accel/tcg/cpu-exec.c
>> >  > +++ b/accel/tcg/cpu-exec.c
>> >  > @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc,
>> CPUState *cpu)
>> >  >  static void print_delay(const SyncClocks *sc)
>> >  >  {
>> >  >      static float threshold_delay;
>> >  > -    static int64_t last_realtime_clock;
>> >  >      static int nb_prints;
>> >  >
>> >  >      if (icount_align_option &&
>> >  > -        sc->realtime_clock - last_realtime_clock >=3D
>> MAX_DELAY_PRINT_RATE &&
>> >  > +        sc->diff_clk >=3D MAX_DELAY_PRINT_RATE &&
>> >  >          nb_prints < MAX_NB_PRINTS) {
>> >  >          if ((-sc->diff_clk / (float)1000000000LL > threshold_delay=
)
>> ||
>> >  >              (-sc->diff_clk / (float)1000000000LL <
>> >  > @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)
>> >  >                          threshold_delay - 1,
>> >  >                          threshold_delay);
>> >  >              nb_prints++;
>> >  > -            last_realtime_clock =3D sc->realtime_clock;
>> >  >          }
>> >  >      }
>> >  >  }
>> >  > diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
>> >  > index 8d3d3a7e9d..f07f8baf4d 100644
>> >  > --- a/accel/tcg/icount-common.c
>> >  > +++ b/accel/tcg/icount-common.c
>> >  > @@ -46,8 +46,8 @@
>> >  >   * is TCG-specific, and does not need to be built for other accels=
.
>> >  >   */
>> >  >  static bool icount_sleep =3D true;
>> >  > -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
>> >  > -#define MAX_ICOUNT_SHIFT 10
>> >  > +/* Arbitrarily pick the minimum allowable speed.  */
>> >  > +#define MAX_ICOUNT_SHIFT 30
>> >  >
>> >  >  /* Do not count executed instructions */
>> >  >  ICountMode use_icount =3D ICOUNT_DISABLED;
>> >
>> >  --
>> >  Alex Benn=C3=A9e
>> >  Virtualisation Tech Lead @ Linaro
>>
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>>
>

--000000000000c6993206212239a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">But for qemu_plugin_update_ns</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, Sep 2, 2024, 15:38 Elisha Hollander &lt;<a href=3D"mailto:just4now666666@=
gmail.com">just4now666666@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><p dir=3D"ltr">Just checked with 9.0.2 it it still gives th=
e error...</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed=
, Aug 28, 2024, 14:05 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">Elisha Hollander &lt;<a h=
ref=3D"mailto:just4now666666@gmail.com" rel=3D"noreferrer noreferrer" targe=
t=3D"_blank">just4now666666@gmail.com</a>&gt; writes:<br>
<br>
&gt; Although it gives `undefined symbol: qemu_plugin_scoreboard_free`. But=
<br>
&gt; probably I messed something up...<br>
<br>
Are you using an older QEMU? We should trigger an API warning if they<br>
are mismatched but maybe thats not working.<br>
<br>
&gt;<br>
&gt; On Tue, Aug 27, 2024, 14:59 Elisha Hollander &lt;<a href=3D"mailto:jus=
t4now666666@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">just=
4now666666@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Oh nice, I didn&#39;t know that<br>
&gt;<br>
&gt;=C2=A0 On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e &lt;<a href=3D"mail=
to:alex.bennee@linaro.org" rel=3D"noreferrer noreferrer" target=3D"_blank">=
alex.bennee@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Elisha Hollander &lt;<a href=3D"mailto:just4now666666@gmail.com"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">just4now666666@gmail.com</=
a>&gt; writes:<br>
&gt;<br>
&gt;=C2=A0 &gt; Signed-off-by: Elisha Hollander &lt;<a href=3D"mailto:just4=
now666666@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">just4n=
ow666666@gmail.com</a>&gt;<br>
&gt;<br>
&gt;=C2=A0 What is the use-case for this patch?<br>
&gt;<br>
&gt;=C2=A0 If you are simply looking to slow the emulated system down pleas=
e have a<br>
&gt;=C2=A0 look at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://qemu.readthedocs.io/en/master/about/em=
ulation.html#limit-instructions-per-second" rel=3D"noreferrer noreferrer no=
referrer" target=3D"_blank">https://qemu.readthedocs.io/en/master/about/emu=
lation.html#limit-instructions-per-second</a><br>
&gt;<br>
&gt;=C2=A0 which uses the plugin system to limit the run rate and sleep if =
its<br>
&gt;=C2=A0 running too fast. The longer term goal is to deprecate the icoun=
t clock<br>
&gt;=C2=A0 alignment feature from the core code and leave icount to just pr=
ovide<br>
&gt;=C2=A0 the deterministic execution needed for record/replay and reverse=
<br>
&gt;=C2=A0 debugging.<br>
&gt;<br>
&gt;=C2=A0 &gt; ---<br>
&gt;=C2=A0 &gt;=C2=A0 accel/tcg/cpu-exec.c=C2=A0 =C2=A0 =C2=A0 | 4 +---<br>
&gt;=C2=A0 &gt;=C2=A0 accel/tcg/icount-common.c | 4 ++--<br>
&gt;=C2=A0 &gt;=C2=A0 2 files changed, 3 insertions(+), 5 deletions(-)<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c<br=
>
&gt;=C2=A0 &gt; index 8163295f34..4c2baf8ed4 100644<br>
&gt;=C2=A0 &gt; --- a/accel/tcg/cpu-exec.c<br>
&gt;=C2=A0 &gt; +++ b/accel/tcg/cpu-exec.c<br>
&gt;=C2=A0 &gt; @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc=
, CPUState *cpu)<br>
&gt;=C2=A0 &gt;=C2=A0 static void print_delay(const SyncClocks *sc)<br>
&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 static float threshold_delay;<br>
&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 static int64_t last_realtime_clock;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 static int nb_prints;<br>
&gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (icount_align_option &amp;&amp;<br>
&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&gt;realtime_clock - last_r=
ealtime_clock &gt;=3D MAX_DELAY_PRINT_RATE &amp;&amp;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&gt;diff_clk &gt;=3D MAX_DE=
LAY_PRINT_RATE &amp;&amp;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_prints &lt; MAX_NB_PRI=
NTS) {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((-sc-&gt;diff_clk / (=
float)1000000000LL &gt; threshold_delay) ||<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (-sc-&gt;di=
ff_clk / (float)1000000000LL &lt;<br>
&gt;=C2=A0 &gt; @@ -109,7 +108,6 @@ static void print_delay(const SyncClock=
s *sc)<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 threshold_delay - 1,<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 threshold_delay);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_prints++=
;<br>
&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_realtime_cl=
ock =3D sc-&gt;realtime_clock;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt;=C2=A0 &gt; diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-c=
ommon.c<br>
&gt;=C2=A0 &gt; index 8d3d3a7e9d..f07f8baf4d 100644<br>
&gt;=C2=A0 &gt; --- a/accel/tcg/icount-common.c<br>
&gt;=C2=A0 &gt; +++ b/accel/tcg/icount-common.c<br>
&gt;=C2=A0 &gt; @@ -46,8 +46,8 @@<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0* is TCG-specific, and does not need to be buil=
t for other accels.<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 &gt;=C2=A0 static bool icount_sleep =3D true;<br>
&gt;=C2=A0 &gt; -/* Arbitrarily pick 1MIPS as the minimum allowable speed.=
=C2=A0 */<br>
&gt;=C2=A0 &gt; -#define MAX_ICOUNT_SHIFT 10<br>
&gt;=C2=A0 &gt; +/* Arbitrarily pick the minimum allowable speed.=C2=A0 */<=
br>
&gt;=C2=A0 &gt; +#define MAX_ICOUNT_SHIFT 30<br>
&gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 /* Do not count executed instructions */<br>
&gt;=C2=A0 &gt;=C2=A0 ICountMode use_icount =3D ICOUNT_DISABLED;<br>
&gt;<br>
&gt;=C2=A0 -- <br>
&gt;=C2=A0 Alex Benn=C3=A9e<br>
&gt;=C2=A0 Virtualisation Tech Lead @ Linaro<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>
</blockquote></div>

--000000000000c6993206212239a1--

