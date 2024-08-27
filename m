Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8805BC54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 12:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siurc-0004Yk-SG; Tue, 27 Aug 2024 07:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1siurb-0004Y9-Vp
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:59:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1siurZ-0004Dm-Rw
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:59:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7141b04e7a3so4370173b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724759992; x=1725364792; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BKCYfz9tkaVNH6fB9Nh8SltfRjyIfEg/Set3q/m2Rbw=;
 b=YxhtSQ/CgMVOjEvI3vzK1pq+1F0lz3zYvXqmGJJ6hGgx1PcSJX/0xF3sh3/1sURV7U
 Gig9GA9WXZcpLMGF7IsYP7GMSxcP3apnMiuPnS8Gs+hYYE1VI9xgYza25frjNGriklXk
 c4XV5KQdkQ9/t2talUbTtBY1J+QbHY5gM0JwchEs5IqZrCugJqY3+aT9pofcIvRV0oHD
 FxOdeuHiakgMYAJOR4LJqtHaCDSZXsgFnezDHeEpOmwIsRCXKHy+rTbKlYb6babItQJg
 fBUQivbIutKu6PWv3uDfUgnpe0ptm0I2C06QFsEmFojCxMXurFlp9Ws6vjBbpDO6Uz3D
 MobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724759992; x=1725364792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BKCYfz9tkaVNH6fB9Nh8SltfRjyIfEg/Set3q/m2Rbw=;
 b=bRBAM/g+mkNqhH56ANQACxZH0kxkQVujzIVr0oIALHqM6DXEWgEEDteyoYNj8OOOeH
 Aa0uIIvMCrs6MOozF+HFVlIXr4Q1XTTZQkaRdxlCx46RVJwBPFZ0pspKiIYh08mwNrzt
 Sh+8PToY129Hkl7rHEKlpxrC3JPSabTT3YgE0rbo35SVO4ghD8/WssxtkUAuArz7det3
 AWHFmQzWPKXvSmWYeO8sKuML5dR+NOahr5Glh8Zo/O+uEh8/dj8eLyg4dULc6m/vFTYF
 8sIY9ik33IGnVi/m4DevVhcZ7WsJWYaJ9KJRPFs5R9PDaPPyUc+Cvi4C2PFFAf10GJRM
 +1xA==
X-Gm-Message-State: AOJu0YxQreTU2MfnjfloWrtscaT8XkWMV0189b2zXBA8+rg/u4vKSVk/
 bk7VuyjARzoSlInMGOexLfLlhjfLXfryI+kJXcS2PkMhyc++OJtHOULLEKmykRst6VBUl0sxT/8
 cruhfaLX1JPzzTsu/8PjveWhxa/g=
X-Google-Smtp-Source: AGHT+IGeLBL7ILcm4Y8v2uFTEZrHxaXh2Kxh0Zrca8yEx+Z0QIfIMrY4iTK876ncMHdU8RB0Yl1LfC1BDJm9vN5s55w=
X-Received: by 2002:a05:6a21:1584:b0:1c3:b47d:d53f with SMTP id
 adf61e73a8af0-1cc89d7e3b8mr15371097637.25.1724759991356; Tue, 27 Aug 2024
 04:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240816162044.5764-1-just4now666666@gmail.com>
 <871q2ae24s.fsf@draig.linaro.org>
In-Reply-To: <871q2ae24s.fsf@draig.linaro.org>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Tue, 27 Aug 2024 14:59:38 +0300
Message-ID: <CACkyd_anZKrjNUKE+nwzSvJGQwxQ2zq2J8sGawq3pKYLVT9vXQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009b93660620a8fa85"
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=just4now666666@gmail.com; helo=mail-pf1-x436.google.com
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

--0000000000009b93660620a8fa85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh nice, I didn't know that

On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

> Elisha Hollander <just4now666666@gmail.com> writes:
>
> > Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
>
> What is the use-case for this patch?
>
> If you are simply looking to slow the emulated system down please have a
> look at:
>
>
> https://qemu.readthedocs.io/en/master/about/emulation.html#limit-instruct=
ions-per-second
>
> which uses the plugin system to limit the run rate and sleep if its
> running too fast. The longer term goal is to deprecate the icount clock
> alignment feature from the core code and leave icount to just provide
> the deterministic execution needed for record/replay and reverse
> debugging.
>
>
> > ---
> >  accel/tcg/cpu-exec.c      | 4 +---
> >  accel/tcg/icount-common.c | 4 ++--
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 8163295f34..4c2baf8ed4 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc, CPUState
> *cpu)
> >  static void print_delay(const SyncClocks *sc)
> >  {
> >      static float threshold_delay;
> > -    static int64_t last_realtime_clock;
> >      static int nb_prints;
> >
> >      if (icount_align_option &&
> > -        sc->realtime_clock - last_realtime_clock >=3D
> MAX_DELAY_PRINT_RATE &&
> > +        sc->diff_clk >=3D MAX_DELAY_PRINT_RATE &&
> >          nb_prints < MAX_NB_PRINTS) {
> >          if ((-sc->diff_clk / (float)1000000000LL > threshold_delay) ||
> >              (-sc->diff_clk / (float)1000000000LL <
> > @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)
> >                          threshold_delay - 1,
> >                          threshold_delay);
> >              nb_prints++;
> > -            last_realtime_clock =3D sc->realtime_clock;
> >          }
> >      }
> >  }
> > diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
> > index 8d3d3a7e9d..f07f8baf4d 100644
> > --- a/accel/tcg/icount-common.c
> > +++ b/accel/tcg/icount-common.c
> > @@ -46,8 +46,8 @@
> >   * is TCG-specific, and does not need to be built for other accels.
> >   */
> >  static bool icount_sleep =3D true;
> > -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
> > -#define MAX_ICOUNT_SHIFT 10
> > +/* Arbitrarily pick the minimum allowable speed.  */
> > +#define MAX_ICOUNT_SHIFT 30
> >
> >  /* Do not count executed instructions */
> >  ICountMode use_icount =3D ICOUNT_DISABLED;
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000009b93660620a8fa85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Oh nice, I didn&#39;t know that</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, Aug 27, 2024, 12:39 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@li=
naro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Elisha Hollander &lt;<a href=3D"mailto:just4now666666@gmail.c=
om" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</a>&gt; w=
rites:<br>
<br>
&gt; Signed-off-by: Elisha Hollander &lt;<a href=3D"mailto:just4now666666@g=
mail.com" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</a>=
&gt;<br>
<br>
What is the use-case for this patch?<br>
<br>
If you are simply looking to slow the emulated system down please have a<br=
>
look at:<br>
<br>
=C2=A0 <a href=3D"https://qemu.readthedocs.io/en/master/about/emulation.htm=
l#limit-instructions-per-second" rel=3D"noreferrer noreferrer" target=3D"_b=
lank">https://qemu.readthedocs.io/en/master/about/emulation.html#limit-inst=
ructions-per-second</a><br>
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

--0000000000009b93660620a8fa85--

