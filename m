Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7965DC52D6F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 20:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shxHM-0004DE-37; Sat, 24 Aug 2024 16:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1shwiz-0007gS-72
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 15:47:02 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1shwiv-0007Fs-Kz
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 15:46:59 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d46f2816c0so2416311a91.2
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2024 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724528814; x=1725133614; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IEdZK3+DAD9dICnK1DsaezpebrekE7MKzXbebfYaX1g=;
 b=no8pjcg29hLwT/LGk9UjJQfihIytjSvETY98BiaFF0GIjtGvd+vdCNKBEVgmznxLtM
 x0fnIqC+74AOPyusVwwUP1NpOUsVGBkbcdPxYQxoyGqS0DzuieAuyqbgP3bbvkIWg/Q1
 G69wWCiD8SW9YNlfzRg6dF8oarj0f1jQh2aN9+abtlMWD8X7HhawD+Fdhinf1QI109sJ
 vm24v/uyxodoMVQ/PuY1mVSwcN53GqAEwA2EjXIVt+xsUiq0yScG3jeFLVC1irhBxqB0
 2sUltFv6KgBPl/GpOCYec73I4Hq6vysfh5jTGduPCXDFtZE4uWRtJq9lJYVKKx5xIsV6
 CApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724528814; x=1725133614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IEdZK3+DAD9dICnK1DsaezpebrekE7MKzXbebfYaX1g=;
 b=F3kctnGI+YnKQ4XK2ez+Ban7Avqf7ialtL/0CNmmOP/80W36Ugx6RyzXCWIgKhiggR
 bo00J+Xo0jWmrghWx6cAom7WhhBkguL9enOEbYkQJrKShtyawJJDzBVkE1I5eF+rUeOl
 tWiOvR1CCekB1Tu8FTDkp3KFzaW4vMJ1tdXyd+kNNcow+N1DK6VWctK9n0mstODWKWMB
 sGsOxCHkT184aUp9hEUhKHCVxWR4ZyJ+7vLepI9hOYL3/NQ11+3FkGLc719+13LA0njt
 JexiT7CEskL6gtmgLC0gDvA2oT7a9BC9GBsKUe2RuGMSZNLb1RVq3+DOgMphIpL8I2JH
 Wx/w==
X-Gm-Message-State: AOJu0YzG7YFOBhxHzWv8yMhoGPRB3Cvu2YMB7hxDjrymsPaAg97cx8k+
 Dv2b7Wwhmca7xDf34rkhfemCk6FCyBEMOWSGz0TWNMPrJgXcCTn6T49bF7ok3IRefmKnCQ6uaPZ
 3GkFZxhwIuaaSA1gbZGx6T1gxRxBUP/FZ
X-Google-Smtp-Source: AGHT+IF3dDLE5QBPm+4/1uuXs8P3cfPuw3rAG/JHL46r1gY4wBN2wpyZVOeBuKJfuU8ighv5ho7q42asV7tZw1KK3ow=
X-Received: by 2002:a17:90a:c7c3:b0:2c8:3f5:37d2 with SMTP id
 98e67ed59e1d1-2d646c1e486mr6270609a91.20.1724528814159; Sat, 24 Aug 2024
 12:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240816162044.5764-1-just4now666666@gmail.com>
In-Reply-To: <20240816162044.5764-1-just4now666666@gmail.com>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Sat, 24 Aug 2024 22:46:42 +0300
Message-ID: <CACkyd_a7LmL-++9CD+bfoPS2k5y5kiP5V=Ux-m3FecsJf02wQA@mail.gmail.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005f7fd606207327d3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=just4now666666@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 24 Aug 2024 16:22:31 -0400
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

--0000000000005f7fd606207327d3
Content-Type: text/plain; charset="UTF-8"

Just wanted to ping the patch
<https://lore.kernel.org/qemu-devel/20240816162044.5764-1-just4now666666@gmail.com/>

On Fri, Aug 16, 2024, 19:21 Elisha Hollander <just4now666666@gmail.com>
wrote:

> Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
> ---
>  accel/tcg/cpu-exec.c      | 4 +---
>  accel/tcg/icount-common.c | 4 ++--
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 8163295f34..4c2baf8ed4 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc, CPUState *cpu)
>  static void print_delay(const SyncClocks *sc)
>  {
>      static float threshold_delay;
> -    static int64_t last_realtime_clock;
>      static int nb_prints;
>
>      if (icount_align_option &&
> -        sc->realtime_clock - last_realtime_clock >= MAX_DELAY_PRINT_RATE
> &&
> +        sc->diff_clk >= MAX_DELAY_PRINT_RATE &&
>          nb_prints < MAX_NB_PRINTS) {
>          if ((-sc->diff_clk / (float)1000000000LL > threshold_delay) ||
>              (-sc->diff_clk / (float)1000000000LL <
> @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)
>                          threshold_delay - 1,
>                          threshold_delay);
>              nb_prints++;
> -            last_realtime_clock = sc->realtime_clock;
>          }
>      }
>  }
> diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
> index 8d3d3a7e9d..f07f8baf4d 100644
> --- a/accel/tcg/icount-common.c
> +++ b/accel/tcg/icount-common.c
> @@ -46,8 +46,8 @@
>   * is TCG-specific, and does not need to be built for other accels.
>   */
>  static bool icount_sleep = true;
> -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
> -#define MAX_ICOUNT_SHIFT 10
> +/* Arbitrarily pick the minimum allowable speed.  */
> +#define MAX_ICOUNT_SHIFT 30
>
>  /* Do not count executed instructions */
>  ICountMode use_icount = ICOUNT_DISABLED;
> --
> 2.30.2
>
>

--0000000000005f7fd606207327d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Just wanted to ping <a href=3D"https://lore.kernel.org/qe=
mu-devel/20240816162044.5764-1-just4now666666@gmail.com/" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">the patch</a></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 16, 2024, 19:21 Eli=
sha Hollander &lt;<a href=3D"mailto:just4now666666@gmail.com" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">just4now666666@gmail.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Signed-off-by: Elisha Hollander &lt=
;<a href=3D"mailto:just4now666666@gmail.com" rel=3D"noreferrer noreferrer n=
oreferrer" target=3D"_blank">just4now666666@gmail.com</a>&gt;<br>
---<br>
=C2=A0accel/tcg/cpu-exec.c=C2=A0 =C2=A0 =C2=A0 | 4 +---<br>
=C2=A0accel/tcg/icount-common.c | 4 ++--<br>
=C2=A02 files changed, 3 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c<br>
index 8163295f34..4c2baf8ed4 100644<br>
--- a/accel/tcg/cpu-exec.c<br>
+++ b/accel/tcg/cpu-exec.c<br>
@@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc, CPUState *cpu)=
<br>
=C2=A0static void print_delay(const SyncClocks *sc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0static float threshold_delay;<br>
-=C2=A0 =C2=A0 static int64_t last_realtime_clock;<br>
=C2=A0 =C2=A0 =C2=A0static int nb_prints;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (icount_align_option &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&gt;realtime_clock - last_realtime_clock &g=
t;=3D MAX_DELAY_PRINT_RATE &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sc-&gt;diff_clk &gt;=3D MAX_DELAY_PRINT_RATE &=
amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_prints &lt; MAX_NB_PRINTS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((-sc-&gt;diff_clk / (float)1000000000=
LL &gt; threshold_delay) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(-sc-&gt;diff_clk / (float)=
1000000000LL &lt;<br>
@@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0threshold_delay - 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0threshold_delay);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nb_prints++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_realtime_clock =3D sc-&gt;r=
ealtime_clock;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c<br>
index 8d3d3a7e9d..f07f8baf4d 100644<br>
--- a/accel/tcg/icount-common.c<br>
+++ b/accel/tcg/icount-common.c<br>
@@ -46,8 +46,8 @@<br>
=C2=A0 * is TCG-specific, and does not need to be built for other accels.<b=
r>
=C2=A0 */<br>
=C2=A0static bool icount_sleep =3D true;<br>
-/* Arbitrarily pick 1MIPS as the minimum allowable speed.=C2=A0 */<br>
-#define MAX_ICOUNT_SHIFT 10<br>
+/* Arbitrarily pick the minimum allowable speed.=C2=A0 */<br>
+#define MAX_ICOUNT_SHIFT 30<br>
<br>
=C2=A0/* Do not count executed instructions */<br>
=C2=A0ICountMode use_icount =3D ICOUNT_DISABLED;<br>
-- <br>
2.30.2<br>
<br>
</blockquote></div>

--0000000000005f7fd606207327d3--

