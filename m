Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BFAC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 06:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUKu-0002j8-6i; Wed, 22 Jan 2025 01:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1taUKs-0002iy-T7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:35:35 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1taUKr-0007Wg-2d
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:35:34 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53e64f3c7d0so5284e87.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 22:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1737527730; x=1738132530; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gdxYfllRzhoneMx3pMfJf8yMHFmAxAok/ncwrQ6oC3Y=;
 b=Pw8XBlQYoWIaXYuynVeTOrZgVkrWW188PFcrYu/OpXlnE1rXKuYTrIqzy31rb3Qs3r
 KBhiWFDcaBTCSxYPsmTdWGoyacPI+pNwtqGyBbzUIVHhv7Nq69uI2J/LP6EV1RPzlh/x
 wFsoUoDhReoTFCSag6Si2qLubn6ABslZJvwgrZFvhNXCqIAAMF6BzbJfNV+kK2GowbTB
 vOwK7jjkkSvkFVsaLm6Efe+XRuH3JQHV0n++4pqMlCxNopiqlvnR3oaaOWi8fxGps1mC
 Iio+auG963XoenpHMdMbDrgE1Vt3ldUD1n2fF9oEFunV9NQW32Dnc59Bl+gFXJZVBgcr
 As+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737527730; x=1738132530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gdxYfllRzhoneMx3pMfJf8yMHFmAxAok/ncwrQ6oC3Y=;
 b=qltQDo0Q4wDs10hiWOCCblVZ4n100mIXW0BOArGPRoWNITpZ7WInhwH9UIIKFIUuXc
 +g4VRTv43neL63QesSampHgutQ6SD1kYE9gga8NLPWGMjK/N2npgCG3dNNSsnGSAzSFO
 4hpyZwLSER8LUX7V2Q6CVppJYn2gWQyMZXdstXRc74mHrbBq8jt8v4p/54pQ4iM0kcXK
 OreaqC1ET4pLDicCfk8ZK08w0f63MZF/GHFQFBt8YCx+DdNIgM/4caTpNAmA2sHtdRau
 oDztothzduvwGNG1MJDSscJlp9l8XJObVTvesyIGh3Cm2e5fd/ybDZK0tlY8GF+e2rzq
 EhKw==
X-Gm-Message-State: AOJu0YyPAuqJyB9bnnK13ayI/JA9PMbq5g8lJB/1luGdKq8/Hf1qpb4i
 N+MLV4rTy61fjOfepdAuBcOdHmB2KXP3ENEsWV1JxCW0dsSYuNnTpbuzX2tL2CkEwEoD+WauV2w
 B1mGjJJ1z6lMkRl4HPJUBILlB7UROgZlKhXRJ
X-Gm-Gg: ASbGnct8hA9yzo7/x2ZXmgN9ga1hT+QCmTdkIbAMOqQoRxRqQ3S0Q35+KwNWxAjDKLh
 aAegPbP1SBUbR0SL1IdtOOQQZLUVD8MCwiFghLGt5vw8nN+o5lubArO6giwwLCRAAEOY4
X-Google-Smtp-Source: AGHT+IGao4YF2WyoJUrdgcw+zGQfyv1+kwDcVjXcjFm0DFIYu9O3lYMlkuIrPJFU8SaVXLAP3sXucQwZmUsH2Aibnas=
X-Received: by 2002:ac2:434b:0:b0:543:a58f:f06a with SMTP id
 2adb3069b0e04-543bcc9400amr99813e87.5.1737527729526; Tue, 21 Jan 2025
 22:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20250120150049.3611864-1-alex.bennee@linaro.org>
 <CAGcCb10gHVZdN6CbUm02w7jTaUUoBH4-VTohmy+yiP1OLWFBxg@mail.gmail.com>
 <87ed0wpiy9.fsf@draig.linaro.org>
In-Reply-To: <87ed0wpiy9.fsf@draig.linaro.org>
From: Hao Wu <wuhaotsh@google.com>
Date: Wed, 22 Jan 2025 14:35:18 +0800
X-Gm-Features: AbW1kvYtqbZ7BetA7sI30RVxVrU0EKcBgCUNU4oK5YnFhy30iLuf46rdTtk89N4
Message-ID: <CAGcCb10qKaXQJCyBBs9mPWKM+zLUSWSVV63BRV7d=Qa1hB8oGQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/qtest: don't step clock at start of npcm7xx
 periodic IRQ test
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Tyrone Ting <kfting@nuvoton.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Nuvoton NPCM7xx" <qemu-arm@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000001b9e51062c45b377"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=wuhaotsh@google.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000001b9e51062c45b377
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 6:20=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Hao Wu <wuhaotsh@google.com> writes:
>
> > Have you tried that the test can pass with this? If I remember
> correctly, interrupt won't trigger properly if not advancing the
> > timer
>
> Yes but the IRQ has yet to be enabled at this point.
>
I believe that's the case,  so we should be able to remove this line in the
test.

>
> >
> > If the test passes it's probably fine to remove that.
>
> Of course.
>
> >
> > On Mon, Jan 20, 2025 at 11:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@=
linaro.org>
> wrote:
> >
> >  Until there are timers enabled the semantics of clock_step_next() will
> >  fail. Since d524441a36 (system/qtest: properly feedback results of
> >  clock_[step|set]) we will signal a FAIL if time doesn't advance.
> >
> >  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
Reviewed-by: Hao Wu <wuhaotsh@google.com>

> >  ---
> >   tests/qtest/npcm7xx_timer-test.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> >  diff --git a/tests/qtest/npcm7xx_timer-test.c
> b/tests/qtest/npcm7xx_timer-test.c
> >  index 58f58c2f71..43711049ca 100644
> >  --- a/tests/qtest/npcm7xx_timer-test.c
> >  +++ b/tests/qtest/npcm7xx_timer-test.c
> >  @@ -465,7 +465,6 @@ static void test_periodic_interrupt(gconstpointer
> test_data)
> >       int i;
> >
> >       tim_reset(td);
> >  -    clock_step_next();
> >
> >       tim_write_ticr(td, count);
> >       tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));
> >  --
> >  2.39.5
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000001b9e51062c45b377
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 21,=
 2025 at 6:20=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee=
@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hao Wu &lt;<a href=3D"mailto:wuhaotsh@go=
ogle.com" target=3D"_blank">wuhaotsh@google.com</a>&gt; writes:<br>
<br>
&gt; Have you tried that the test can pass with this? If I remember correct=
ly, interrupt won&#39;t trigger properly if not advancing the<br>
&gt; timer<br>
<br>
Yes but the IRQ has yet to be enabled at this point.<br></blockquote><div>I=
 believe that&#39;s the case,=C2=A0 so we should be able to remove this lin=
e in the test.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; If the test passes it&#39;s probably fine to remove that.<br>
<br>
Of course.<br>
<br>
&gt;<br>
&gt; On Mon, Jan 20, 2025 at 11:00=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org=
</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Until there are timers enabled the semantics of clock_step_next(=
) will<br>
&gt;=C2=A0 fail. Since d524441a36 (system/qtest: properly feedback results =
of<br>
&gt;=C2=A0 clock_[step|set]) we will signal a FAIL if time doesn&#39;t adva=
nce.<br>
&gt;<br>
&gt;=C2=A0 Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.benne=
e@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br></blockqu=
ote><div>Reviewed-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com">wuh=
aotsh@google.com</a>&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt;=C2=A0 ---<br>
&gt;=C2=A0 =C2=A0tests/qtest/npcm7xx_timer-test.c | 1 -<br>
&gt;=C2=A0 =C2=A01 file changed, 1 deletion(-)<br>
&gt;<br>
&gt;=C2=A0 diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm=
7xx_timer-test.c<br>
&gt;=C2=A0 index 58f58c2f71..43711049ca 100644<br>
&gt;=C2=A0 --- a/tests/qtest/npcm7xx_timer-test.c<br>
&gt;=C2=A0 +++ b/tests/qtest/npcm7xx_timer-test.c<br>
&gt;=C2=A0 @@ -465,7 +465,6 @@ static void test_periodic_interrupt(gconstpo=
inter test_data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tim_reset(td);<br>
&gt;=C2=A0 -=C2=A0 =C2=A0 clock_step_next();<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tim_write_ticr(td, count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tim_write_tcsr(td, CEN | IE | MODE_PERIODIC =
| PRESCALE(ps));<br>
&gt;=C2=A0 -- <br>
&gt;=C2=A0 2.39.5<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--0000000000001b9e51062c45b377--

