Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B440AD64097
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 23:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9YDC-0001Jw-PU; Fri, 08 Nov 2024 18:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evgenyvoevodin@gmail.com>)
 id 1t9YD8-0001FQ-Ra
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 18:16:15 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <evgenyvoevodin@gmail.com>)
 id 1t9YD6-0007W9-Tr
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 18:16:14 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-26456710cfdso203757fac.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 15:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731107770; x=1731712570; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=346TvJfdAvIlS4ntZEGpHR6EUtGBaIGIonEZ4nlOPjw=;
 b=NIw4pSJJT7VoAUhbFAjbBUnOlTMmqFgiQ3PdWxm8JIk5lp6P/Ki9z7WqKuRREAO2VY
 AQoHN5mfvHx9x4bQxinKtuvMnArRwsoroDxRz5i5g6GIDYmYxt6H/1uepfTv7C1SPI83
 tkHIV8OjTiQRtz79cCAqrGajFSQVzyicJWt01U2suYstdoO0SQO9MlWH4if1vKfnSVCf
 yJbxh4D7Hag+kP8VT6N6/9lvz6Gn4Yjaqzysm50M2gHcn3U+Lf6W0LIFuJSyMxDYHS0f
 lFg52KYGvnauGpPDvfAW1epgW5AncvgMQ7KLxEkQG3mnBZSSeP148PxA+Uhn/ArZ3m02
 5Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731107770; x=1731712570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=346TvJfdAvIlS4ntZEGpHR6EUtGBaIGIonEZ4nlOPjw=;
 b=S1ntXezYFo2pVTag9uN6xgVkE7XV2u4Cx6Rjrxs+7CExuWIguAx02+pPmoaaz/O6n5
 XCVDkDGKWTIHMFktITjzObbINUKfjYst/bET8AXvvRC2KNAWvs1klpqQgmc7t5FLSc5+
 vdTlh8SfM+t0MxJ9+AU2cVV0R4zeubYgi4n2WEa88rNy1OqvZ7+3r3J81wDGAXGyVHQS
 HHGUx+oEJhJWKRYNdlJGfu/SMxN0RpthMABJt48TlobnNy2gjEXQZ/4vQDDNAnJbVau5
 ToHABNxH4KFJ4WakQk/3TCE7mWbh/nvHgj9iMlB76pe8j9cIgBUPl4Gv/nYO51R+b1Ab
 ZFSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx4FHLsl0YhK0zh0DKzdAOnuiXaIWmZ84oyilHF1lyE6N0mBnKdihqfNNTOSQArHPB8kL6jb1VuaZW@nongnu.org
X-Gm-Message-State: AOJu0YxTQJC4ItyB7MdRgHaBj18ydQeIQgkXEXdK7MtUYC+1Qww7bT8K
 qf7w0zgTAHLawHRKR7GhiHDNLjaMVr0rvSu5ABKdUS1V2iImXszp8FL7j9CVhHEHVioeL8T+lpF
 vD2Q8hYDsPv+IOy1P79RUNjEp17Q=
X-Google-Smtp-Source: AGHT+IFDHYlri6KlBTW0INPzxP5B1ttuOSrVlXnAeGGLneRMZu2HB9aseryDfKSoi4ovlMo+4ajMINEjpu1GymYSUHk=
X-Received: by 2002:a05:6808:1b07:b0:3e6:586e:eef5 with SMTP id
 5614622812f47-3e79457c918mr1305708b6e.1.1731107769492; Fri, 08 Nov 2024
 15:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20241106083801.219578-2-frolov@swemel.ru>
 <CAFEAcA9joGGX46UnkVvapvhyFr7ryhMeczWdT7D+wJLfR4wyCA@mail.gmail.com>
 <a94d3c4b-374b-4266-85b6-cee44b54f03f@linaro.org>
In-Reply-To: <a94d3c4b-374b-4266-85b6-cee44b54f03f@linaro.org>
From: =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0JLQvtC10LLQvtC00LjQvQ==?=
 <evgenyvoevodin@gmail.com>
Date: Fri, 8 Nov 2024 15:15:58 -0800
Message-ID: <CAGoMRSbR90oVK9uCirZtvxTuNwGUL4LdAbrc5vMb78adb2ArHQ@mail.gmail.com>
Subject: Re: [PATCH] hw/timer: fix possible int overflow
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Dmitry Frolov <frolov@swemel.ru>,
 i.mitsyanko@gmail.com, sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ab2d5206266eefc8"
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=evgenyvoevodin@gmail.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000ab2d5206266eefc8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey guys,
I can't remember details about this particular work which has been done
more than decade ago, but I guess that these uint32_t variables reflect the
architectural state of the HW, so if it might overflow over time, there is
high probability that this is what was architecturally going to happen.

=D0=BF=D1=82, 8 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 09:22=
, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> +Evgeny
>
> On 8/11/24 16:47, Peter Maydell wrote:
> > On Wed, 6 Nov 2024 at 08:38, Dmitry Frolov <frolov@swemel.ru> wrote:
> >>
> >> The product "icnto * s->tcntb" may overflow uint32_t.
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >>
> >> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> >> ---
> >>   hw/timer/exynos4210_mct.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> >> index e807fe2de9..5c6e139b20 100644
> >> --- a/hw/timer/exynos4210_mct.c
> >> +++ b/hw/timer/exynos4210_mct.c
> >> @@ -815,7 +815,7 @@ static uint32_t
> exynos4210_ltick_cnt_get_cnto(struct tick_timer *s)
> >>           /* Both are counting */
> >>           icnto =3D remain / s->tcntb;
> >>           if (icnto) {
> >> -            tcnto =3D remain % (icnto * s->tcntb);
> >> +            tcnto =3D remain % ((uint64_t)icnto * s->tcntb);
> >>           } else {
> >>               tcnto =3D remain % s->tcntb;
> >>           }
> >> --
>
> Alternatively we can declaring icnto as uint64_t locally:
>
> -- >8 --
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index e807fe2de9..9fae2ceda9 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -787,7 +787,6 @@ static void exynos4210_ltick_tx_commit(struct
> tick_timer *s)
>   static uint32_t exynos4210_ltick_cnt_get_cnto(struct tick_timer *s)
>   {
>       uint32_t tcnto;
> -    uint32_t icnto;
>       uint64_t remain;
>       uint64_t counted;
>       uint64_t count;
> @@ -813,7 +812,7 @@ static uint32_t exynos4210_ltick_cnt_get_cnto(struct
> tick_timer *s)
>           tcnto =3D remain % s->tcntb;
>       } else {
>           /* Both are counting */
> -        icnto =3D remain / s->tcntb;
> +        uint64_t icnto =3D remain / s->tcntb;
>           if (icnto) {
>               tcnto =3D remain % (icnto * s->tcntb);
>           } else {
> ---
>
> But then isn't it equivalent to this? Dunno, I might be
> missing something...
>
> -- >8 --
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index e807fe2de9..d8b2c72b73 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -787,7 +787,6 @@ static void exynos4210_ltick_tx_commit(struct
> tick_timer *s)
>   static uint32_t exynos4210_ltick_cnt_get_cnto(struct tick_timer *s)
>   {
>       uint32_t tcnto;
> -    uint32_t icnto;
>       uint64_t remain;
>       uint64_t counted;
>       uint64_t count;
> @@ -813,9 +812,8 @@ static uint32_t exynos4210_ltick_cnt_get_cnto(struct
> tick_timer *s)
>           tcnto =3D remain % s->tcntb;
>       } else {
>           /* Both are counting */
> -        icnto =3D remain / s->tcntb;
> -        if (icnto) {
> -            tcnto =3D remain % (icnto * s->tcntb);
> +        if (remain / s->tcntb) {
> +            tcnto =3D 0;
>           } else {
>               tcnto =3D remain % s->tcntb;
>           }
> ---
>
> > Applied to target-arm.next, thanks.
> >
> > -- PMM
> >
>
>

--000000000000ab2d5206266eefc8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey guys,<div>I can&#39;t remember details about this part=
icular work which has been done more than decade ago, but I guess that thes=
e uint32_t variables reflect=C2=A0the architectural state of the HW, so if =
it might overflow over time, there is high probability that this is what wa=
s architecturally going to happen.</div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=82, 8 =D0=BD=D0=BE=D1=8F=
=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 09:22, Philippe Mathieu-Daud=C3=A9 &lt;=
<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt;:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">+Evgeny<br>
<br>
On 8/11/24 16:47, Peter Maydell wrote:<br>
&gt; On Wed, 6 Nov 2024 at 08:38, Dmitry Frolov &lt;<a href=3D"mailto:frolo=
v@swemel.ru" target=3D"_blank">frolov@swemel.ru</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; The product &quot;icnto * s-&gt;tcntb&quot; may overflow uint32_t.=
<br>
&gt;&gt;<br>
&gt;&gt; Found by Linux Verification Center (<a href=3D"http://linuxtesting=
.org" rel=3D"noreferrer" target=3D"_blank">linuxtesting.org</a>) with SVACE=
.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Dmitry Frolov &lt;<a href=3D"mailto:frolov@swemel.r=
u" target=3D"_blank">frolov@swemel.ru</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0hw/timer/exynos4210_mct.c | 2 +-<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c=
<br>
&gt;&gt; index e807fe2de9..5c6e139b20 100644<br>
&gt;&gt; --- a/hw/timer/exynos4210_mct.c<br>
&gt;&gt; +++ b/hw/timer/exynos4210_mct.c<br>
&gt;&gt; @@ -815,7 +815,7 @@ static uint32_t exynos4210_ltick_cnt_get_cnto(=
struct tick_timer *s)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Both are counting */<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0icnto =3D remain / s-&gt;t=
cntb;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (icnto) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcnto =3D remain % (icn=
to * s-&gt;tcntb);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcnto =3D remain % ((ui=
nt64_t)icnto * s-&gt;tcntb);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcnto =3D re=
main % s-&gt;tcntb;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; --<br>
<br>
Alternatively we can declaring icnto as uint64_t locally:<br>
<br>
-- &gt;8 --<br>
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c<br>
index e807fe2de9..9fae2ceda9 100644<br>
--- a/hw/timer/exynos4210_mct.c<br>
+++ b/hw/timer/exynos4210_mct.c<br>
@@ -787,7 +787,6 @@ static void exynos4210_ltick_tx_commit(struct <br>
tick_timer *s)<br>
=C2=A0 static uint32_t exynos4210_ltick_cnt_get_cnto(struct tick_timer *s)<=
br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 uint32_t tcnto;<br>
-=C2=A0 =C2=A0 uint32_t icnto;<br>
=C2=A0 =C2=A0 =C2=A0 uint64_t remain;<br>
=C2=A0 =C2=A0 =C2=A0 uint64_t counted;<br>
=C2=A0 =C2=A0 =C2=A0 uint64_t count;<br>
@@ -813,7 +812,7 @@ static uint32_t exynos4210_ltick_cnt_get_cnto(struct <b=
r>
tick_timer *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcnto =3D remain % s-&gt;tcntb;<br>
=C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Both are counting */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 icnto =3D remain / s-&gt;tcntb;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t icnto =3D remain / s-&gt;tcntb;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (icnto) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcnto =3D remain % (icnto =
* s-&gt;tcntb);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
---<br>
<br>
But then isn&#39;t it equivalent to this? Dunno, I might be<br>
missing something...<br>
<br>
-- &gt;8 --<br>
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c<br>
index e807fe2de9..d8b2c72b73 100644<br>
--- a/hw/timer/exynos4210_mct.c<br>
+++ b/hw/timer/exynos4210_mct.c<br>
@@ -787,7 +787,6 @@ static void exynos4210_ltick_tx_commit(struct <br>
tick_timer *s)<br>
=C2=A0 static uint32_t exynos4210_ltick_cnt_get_cnto(struct tick_timer *s)<=
br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 uint32_t tcnto;<br>
-=C2=A0 =C2=A0 uint32_t icnto;<br>
=C2=A0 =C2=A0 =C2=A0 uint64_t remain;<br>
=C2=A0 =C2=A0 =C2=A0 uint64_t counted;<br>
=C2=A0 =C2=A0 =C2=A0 uint64_t count;<br>
@@ -813,9 +812,8 @@ static uint32_t exynos4210_ltick_cnt_get_cnto(struct <b=
r>
tick_timer *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcnto =3D remain % s-&gt;tcntb;<br>
=C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Both are counting */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 icnto =3D remain / s-&gt;tcntb;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (icnto) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcnto =3D remain % (icnto * s-&g=
t;tcntb);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (remain / s-&gt;tcntb) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcnto =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcnto =3D remain % s-&gt;t=
cntb;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
---<br>
<br>
&gt; Applied to target-arm.next, thanks.<br>
&gt; <br>
&gt; -- PMM<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000ab2d5206266eefc8--

