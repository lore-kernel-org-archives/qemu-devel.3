Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FFFCD342A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 07:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slNcP-00061u-0p; Tue, 03 Sep 2024 03:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1slNcJ-00060m-EZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 03:06:19 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1slNcH-0007Ss-3g
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 03:06:19 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2d86f71353dso2615422a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 00:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725347175; x=1725951975; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jJfRR78QMoENvLSo68uf7+bMsNtFQR9myIMnpPX+p3I=;
 b=TJMbkG+vzYRz4apv1VSuIwG/N4rY4dU+T+VJ/g7SVHvVxj28bfqNOH+4DOtiXfvwlu
 xZ366unH1GuXZuA/fgiuZ8xE11YvSx7WDNlUAcPIJKL/1m9QcKYEihNGZClXwywuO09g
 DpIVmJgFyezuTmWR74C4oXiRjnQ/mAsGnuAKMcoVAtEx7xuxqSlx6N/xYRODJ4BaLfHw
 +SOg0qpgTQGFDw+WMBH9z7Q6oBu98nMkdpoe/ymq/Q0vjSNm2YsS8XAc1dZuIX6T8kKo
 TcP0W/OgKRXNJouz20DZEULKW+ICAVS5wu1J3RB+LgpQqFE8VvBD9GVJf3I6lrNEavjn
 LDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725347175; x=1725951975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jJfRR78QMoENvLSo68uf7+bMsNtFQR9myIMnpPX+p3I=;
 b=TV2xnZLyWpZERSMUT6zz0GkO7skS4Q+IxXQFyriFNdlJ2380+6bHMOZt3D0u8CYP1R
 YBeVOauKVI5eyKYaaaX/JBhbzWSZKP6kJRCy/eQyDB+sGpsXt3kbnG8OW0t12up4U4NM
 OI+90TeNH7fkX/iS+09aq0cnlkIxOYc73RRVDP1igFG2uQAYm8htD93Fqbn8E+8AA4Cq
 dPBWfPjoQOhw6kBjYliVoJ70Jamo3YcEzM6gyE0UJBgGdIVr+0TaqItjpJxlUWYcV4m9
 T86UczvJooX6McL0HE5rp2Ss2lSbruiuILoll2cj6XfnR+GFd1vxlkoaJKWk+56IwyaT
 SOfg==
X-Gm-Message-State: AOJu0Yzs6z0WZtCOXOzMrDB5oLWasGvfJIL1pKNtuuS7nevgT3uSxloe
 UX5AXPJKBDTJESIPav1cha/5LdDq5fFs1VB0MiHE+4ujigq6cN65bzZCYX745URsxEV7DfC7N4V
 FgKw7AC3rj3PkOSNKnW5dhTRUXGk0+v33fDI=
X-Google-Smtp-Source: AGHT+IEV0R/Utfw26vMIRScNxbmDVNA/MH6aG9x9m/oAcypz977ulRsOCYzi2GuaaQO26uvMHkTPMNxWASTcXIrCyWY=
X-Received: by 2002:a17:90b:2246:b0:2d8:f7e2:eff with SMTP id
 98e67ed59e1d1-2d8f7e2126cmr3291888a91.36.1725347175166; Tue, 03 Sep 2024
 00:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240816162044.5764-1-just4now666666@gmail.com>
 <871q2ae24s.fsf@draig.linaro.org>
 <CACkyd_anZKrjNUKE+nwzSvJGQwxQ2zq2J8sGawq3pKYLVT9vXQ@mail.gmail.com>
 <CACkyd_ZNPzhg8pqkdLucyJ70wZKJARR_65r5CJBy0+U=7GR_1Q@mail.gmail.com>
 <87h6b452m5.fsf@draig.linaro.org>
 <CACkyd_YG-r837VfoPaOw5bKCczAUQYFOobW=2SF37esppbc0XQ@mail.gmail.com>
 <CACkyd_ZhByWwPQtFmHGRQxmBcVwCEyeSKX6fqhS3K=1480ASOA@mail.gmail.com>
 <87wmjudwyp.fsf@draig.linaro.org>
In-Reply-To: <87wmjudwyp.fsf@draig.linaro.org>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Tue, 3 Sep 2024 10:06:03 +0300
Message-ID: <CACkyd_YpxVdGC04cEEPr4O44P+FQ9P51T32AtBxCmOVV1b9f-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007d7f85062131b199"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=just4now666666@gmail.com; helo=mail-pj1-x1033.google.com
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

--0000000000007d7f85062131b199
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure!

`build/qemu-system-i386 -plugin build/contrib/plugins/libips.so,ips=3D1
-display curses -bios bios.raw`

Also, I just tested with 9.1.0-rc4 and it resulted with
`tcg.c:3167:remove_label_use: code should not be reached`

On Mon, Sep 2, 2024, 16:08 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Elisha Hollander <just4now666666@gmail.com> writes:
>
> > But for qemu_plugin_update_ns
> >
> > On Mon, Sep 2, 2024, 15:38 Elisha Hollander <just4now666666@gmail.com>
> wrote:
> >
> >  Just checked with 9.0.2 it it still gives the error...
> >
> >  On Wed, Aug 28, 2024, 14:05 Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >
> >  Elisha Hollander <just4now666666@gmail.com> writes:
> >
> >  > Although it gives `undefined symbol: qemu_plugin_scoreboard_free`. B=
ut
> >  > probably I messed something up...
> >
> >  Are you using an older QEMU? We should trigger an API warning if they
> >  are mismatched but maybe thats not working.
> >
> >  >
> >  > On Tue, Aug 27, 2024, 14:59 Elisha Hollander <
> just4now666666@gmail.com> wrote:
> >  >
> >  >  Oh nice, I didn't know that
> >  >
> >  >  On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
> wrote:
> >  >
> >  >  Elisha Hollander <just4now666666@gmail.com> writes:
> >  >
> >  >  > Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
> >  >
> >  >  What is the use-case for this patch?
> >  >
> >  >  If you are simply looking to slow the emulated system down please
> have a
> >  >  look at:
> >  >
> >  >
> https://qemu.readthedocs.io/en/master/about/emulation.html#limit-instruct=
ions-per-second
> >  >
> >  >  which uses the plugin system to limit the run rate and sleep if its
> >  >  running too fast. The longer term goal is to deprecate the icount
> clock
> >  >  alignment feature from the core code and leave icount to just provi=
de
> >  >  the deterministic execution needed for record/replay and reverse
> >  >  debugging.
> >  >
> >  >  > ---
> >  >  >  accel/tcg/cpu-exec.c      | 4 +---
> >  >  >  accel/tcg/icount-common.c | 4 ++--
> >  >  >  2 files changed, 3 insertions(+), 5 deletions(-)
> >  >  >
> >  >  > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> >  >  > index 8163295f34..4c2baf8ed4 100644
> >  >  > --- a/accel/tcg/cpu-exec.c
> >  >  > +++ b/accel/tcg/cpu-exec.c
> >  >  > @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc,
> CPUState *cpu)
> >  >  >  static void print_delay(const SyncClocks *sc)
> >  >  >  {
> >  >  >      static float threshold_delay;
> >  >  > -    static int64_t last_realtime_clock;
> >  >  >      static int nb_prints;
> >  >  >
> >  >  >      if (icount_align_option &&
> >  >  > -        sc->realtime_clock - last_realtime_clock >=3D
> MAX_DELAY_PRINT_RATE &&
> >  >  > +        sc->diff_clk >=3D MAX_DELAY_PRINT_RATE &&
> >  >  >          nb_prints < MAX_NB_PRINTS) {
> >  >  >          if ((-sc->diff_clk / (float)1000000000LL >
> threshold_delay) ||
> >  >  >              (-sc->diff_clk / (float)1000000000LL <
> >  >  > @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)
> >  >  >                          threshold_delay - 1,
> >  >  >                          threshold_delay);
> >  >  >              nb_prints++;
> >  >  > -            last_realtime_clock =3D sc->realtime_clock;
> >  >  >          }
> >  >  >      }
> >  >  >  }
> >  >  > diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.=
c
> >  >  > index 8d3d3a7e9d..f07f8baf4d 100644
> >  >  > --- a/accel/tcg/icount-common.c
> >  >  > +++ b/accel/tcg/icount-common.c
> >  >  > @@ -46,8 +46,8 @@
> >  >  >   * is TCG-specific, and does not need to be built for other
> accels.
> >  >  >   */
> >  >  >  static bool icount_sleep =3D true;
> >  >  > -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
> >  >  > -#define MAX_ICOUNT_SHIFT 10
> >  >  > +/* Arbitrarily pick the minimum allowable speed.  */
> >  >  > +#define MAX_ICOUNT_SHIFT 30
> >  >  >
> >  >  >  /* Do not count executed instructions */
> >  >  >  ICountMode use_icount =3D ICOUNT_DISABLED;
> >  >
> >  >  --
> >  >  Alex Benn=C3=A9e
> >  >  Virtualisation Tech Lead @ Linaro
> >
> >  --
> >  Alex Benn=C3=A9e
> >  Virtualisation Tech Lead @ Linaro
>
> Can you give me your command line please?
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000007d7f85062131b199
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Sure!</p>
<p dir=3D"ltr">`build/qemu-system-i386 -plugin build/contrib/plugins/libips=
.so,ips=3D1 -display curses -bios bios.raw`</p>
<p dir=3D"ltr">Also, I just tested with 9.1.0-rc4 and it resulted with `tcg=
.c:3167:remove_label_use: code should not be reached`</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, Sep 2, 2024, 16:08 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lin=
aro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Elisha Hollander &lt;<a href=3D"mailto:just4now666666@gmail.c=
om" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</a>&gt; w=
rites:<br>
<br>
&gt; But for qemu_plugin_update_ns<br>
&gt;<br>
&gt; On Mon, Sep 2, 2024, 15:38 Elisha Hollander &lt;<a href=3D"mailto:just=
4now666666@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4now666666@g=
mail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Just checked with 9.0.2 it it still gives the error...<br>
&gt;<br>
&gt;=C2=A0 On Wed, Aug 28, 2024, 14:05 Alex Benn=C3=A9e &lt;<a href=3D"mail=
to:alex.bennee@linaro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee=
@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Elisha Hollander &lt;<a href=3D"mailto:just4now666666@gmail.com"=
 target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</a>&gt; writ=
es:<br>
&gt;<br>
&gt;=C2=A0 &gt; Although it gives `undefined symbol: qemu_plugin_scoreboard=
_free`. But<br>
&gt;=C2=A0 &gt; probably I messed something up...<br>
&gt;<br>
&gt;=C2=A0 Are you using an older QEMU? We should trigger an API warning if=
 they<br>
&gt;=C2=A0 are mismatched but maybe thats not working.<br>
&gt;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; On Tue, Aug 27, 2024, 14:59 Elisha Hollander &lt;<a href=3D=
"mailto:just4now666666@gmail.com" target=3D"_blank" rel=3D"noreferrer">just=
4now666666@gmail.com</a>&gt; wrote:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 Oh nice, I didn&#39;t know that<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e &lt;<a h=
ref=3D"mailto:alex.bennee@linaro.org" target=3D"_blank" rel=3D"noreferrer">=
alex.bennee@linaro.org</a>&gt; wrote:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 Elisha Hollander &lt;<a href=3D"mailto:just4now666666=
@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</=
a>&gt; writes:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; Signed-off-by: Elisha Hollander &lt;<a href=3D"m=
ailto:just4now666666@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4n=
ow666666@gmail.com</a>&gt;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 What is the use-case for this patch?<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 If you are simply looking to slow the emulated system=
 down please have a<br>
&gt;=C2=A0 &gt;=C2=A0 look at:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 <a href=3D"https://qemu.readthedocs.io/en/mast=
er/about/emulation.html#limit-instructions-per-second" rel=3D"noreferrer no=
referrer" target=3D"_blank">https://qemu.readthedocs.io/en/master/about/emu=
lation.html#limit-instructions-per-second</a><br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 which uses the plugin system to limit the run rate an=
d sleep if its<br>
&gt;=C2=A0 &gt;=C2=A0 running too fast. The longer term goal is to deprecat=
e the icount clock<br>
&gt;=C2=A0 &gt;=C2=A0 alignment feature from the core code and leave icount=
 to just provide<br>
&gt;=C2=A0 &gt;=C2=A0 the deterministic execution needed for record/replay =
and reverse<br>
&gt;=C2=A0 &gt;=C2=A0 debugging.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; ---<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 accel/tcg/cpu-exec.c=C2=A0 =C2=A0 =C2=A0 |=
 4 +---<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 accel/tcg/icount-common.c | 4 ++--<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 2 files changed, 3 insertions(+), 5 deleti=
ons(-)<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cp=
u-exec.c<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; index 8163295f34..4c2baf8ed4 100644<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; --- a/accel/tcg/cpu-exec.c<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; +++ b/accel/tcg/cpu-exec.c<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; @@ -95,11 +95,10 @@ static void align_clocks(Syn=
cClocks *sc, CPUState *cpu)<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 static void print_delay(const SyncClocks *=
sc)<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 {<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 static float threshold_delay=
;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; -=C2=A0 =C2=A0 static int64_t last_realtime_cloc=
k;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 static int nb_prints;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (icount_align_option &amp=
;&amp;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&gt;realtime_clo=
ck - last_realtime_clock &gt;=3D MAX_DELAY_PRINT_RATE &amp;&amp;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&gt;diff_clk &gt=
;=3D MAX_DELAY_PRINT_RATE &amp;&amp;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nb_prints &lt;=
 MAX_NB_PRINTS) {<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((-sc-&gt;d=
iff_clk / (float)1000000000LL &gt; threshold_delay) ||<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
(-sc-&gt;diff_clk / (float)1000000000LL &lt;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; @@ -109,7 +108,6 @@ static void print_delay(cons=
t SyncClocks *sc)<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 threshold_delay - 1,<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 threshold_delay);<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
nb_prints++;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_=
realtime_clock =3D sc-&gt;realtime_clock;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; diff --git a/accel/tcg/icount-common.c b/accel/t=
cg/icount-common.c<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; index 8d3d3a7e9d..f07f8baf4d 100644<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; --- a/accel/tcg/icount-common.c<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; +++ b/accel/tcg/icount-common.c<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; @@ -46,8 +46,8 @@<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0* is TCG-specific, and does not need=
 to be built for other accels.<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 static bool icount_sleep =3D true;<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; -/* Arbitrarily pick 1MIPS as the minimum allowa=
ble speed.=C2=A0 */<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; -#define MAX_ICOUNT_SHIFT 10<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; +/* Arbitrarily pick the minimum allowable speed=
.=C2=A0 */<br>
&gt;=C2=A0 &gt;=C2=A0 &gt; +#define MAX_ICOUNT_SHIFT 30<br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 /* Do not count executed instructions */<b=
r>
&gt;=C2=A0 &gt;=C2=A0 &gt;=C2=A0 ICountMode use_icount =3D ICOUNT_DISABLED;=
<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 -- <br>
&gt;=C2=A0 &gt;=C2=A0 Alex Benn=C3=A9e<br>
&gt;=C2=A0 &gt;=C2=A0 Virtualisation Tech Lead @ Linaro<br>
&gt;<br>
&gt;=C2=A0 -- <br>
&gt;=C2=A0 Alex Benn=C3=A9e<br>
&gt;=C2=A0 Virtualisation Tech Lead @ Linaro<br>
<br>
Can you give me your command line please?<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--0000000000007d7f85062131b199--

