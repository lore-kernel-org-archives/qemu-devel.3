Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D61C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 23:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta1ZS-0005Xn-6s; Mon, 20 Jan 2025 18:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1ta1ZP-0005XO-Mm
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 18:52:40 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1ta1ZN-0003rE-VS
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 18:52:39 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5401af8544bso9163e87.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 15:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1737417154; x=1738021954; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ISEyHJOQ5WFrqtdgAxL81FLvJauks5nM3LBV0hOWqoI=;
 b=g7A2NuZxEqiHSXOKCuPUvSEfq+DwiulgZEY3KwwkBAZ/RlqejZPY7NDdQ1CioQqws5
 65QEowj0Dj3DdlHMEdqIdSGMlwy0Pnm7KGvnVLUPUgKZ8URWayyaXbLouHEsIrG2rHPN
 SSa+mSVMWZzu0t1TfCMkuBL9LE4lTGkcZoZstLes8O2b0e/UBUbut8bEWrZUMzga5ZmE
 uG/Lf3UIihJ83/TVkYCNWrSJqkRmzY+ffb6/c+MfvWiNfAI+oNeWO2PC2hM5jdm1CyZt
 +3l/aU8q3Cu4n1pJPhUtt0pGzyWgeOZDTPTis/aggCH5UtZLPnbNMat25ZUOj/gKP3Sl
 LgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737417154; x=1738021954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ISEyHJOQ5WFrqtdgAxL81FLvJauks5nM3LBV0hOWqoI=;
 b=Q9VNNOEcRa+HlEP5mKVZGlaI6zy41tHo8D8NWI0HYZKFtUnC44VRPK5lRDcanpc+4+
 GHw1TjMwlMf+cNqOFBrDCBiaqTq9YQB0ZTsorzhuvbBxfL4QVvryBcgUQMHJSlv/VmWC
 w7yFbIjwoMQF9Lcitbyy0/eyhfGomzc4vn9XUuumHGjlJQg23JxHbH6cWQjuNiXhxt3S
 pPRtXRRLpWnWymeRiGOJdfIFnwnxqMXIWA8jGWqqwsa2AEwkrNAK3Z8tEITcngYY5QAF
 XF5tVBM8VYaVmfjZNOm7XoMtBcPBJbI4B8qNsCDMKnd3wSoQjXFzZAyQu8L8LsjEW6AB
 L1vw==
X-Gm-Message-State: AOJu0Yy8Y0Lpt803U6fEiEoCnki1RWy9tN9psKnJKh1s2vlMgmLl45ph
 JIfna8NJoY/+FmZr4kCToAVFJfyB+P1c95vsqK999uFv9CIGae+n1O7bF5LANydlirIuSOE/JgM
 sYFmyHGR9CogBFlRwNkfTl2ON5NvrygLL9+Xd
X-Gm-Gg: ASbGncuSej/L73aH4hwPHBb5+urRHjX53KSRns9oSBSwmd/+5l5yvR9yr/mIVu36ugt
 OhW8dWXC8StWXRQTnh3Ek8up4sVaQ5XM/D8K3mBZtKdVDAjwXKo3bmjtuS7qAI5rCoflU
X-Google-Smtp-Source: AGHT+IG5y+K2o8vuXjA9PQTTTU2rUpXj6s9DcCjdz7SSqo3B4Vu+GoNK2JBaYoaQB+5jwtm00kjwYHC7UB+AHh+BKGM=
X-Received: by 2002:ac2:4319:0:b0:542:9910:b298 with SMTP id
 2adb3069b0e04-543a4690357mr300953e87.7.1737417154335; Mon, 20 Jan 2025
 15:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20250120150049.3611864-1-alex.bennee@linaro.org>
In-Reply-To: <20250120150049.3611864-1-alex.bennee@linaro.org>
From: Hao Wu <wuhaotsh@google.com>
Date: Tue, 21 Jan 2025 07:52:22 +0800
X-Gm-Features: AbW1kvZ2xgysIX3NtM9L8XFfWJNWPOnMFDdwlR7-VuSg76CUGqfhYZMD-TjFHvA
Message-ID: <CAGcCb10gHVZdN6CbUm02w7jTaUUoBH4-VTohmy+yiP1OLWFBxg@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/qtest: don't step clock at start of npcm7xx
 periodic IRQ test
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Tyrone Ting <kfting@nuvoton.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Nuvoton NPCM7xx" <qemu-arm@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000500298062c2bf4c5"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=wuhaotsh@google.com; helo=mail-lf1-x130.google.com
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

--000000000000500298062c2bf4c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Have you tried that the test can pass with this? If I remember correctly,
interrupt won't trigger properly if not advancing the timer

If the test passes it's probably fine to remove that.

On Mon, Jan 20, 2025 at 11:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:

> Until there are timers enabled the semantics of clock_step_next() will
> fail. Since d524441a36 (system/qtest: properly feedback results of
> clock_[step|set]) we will signal a FAIL if time doesn't advance.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/qtest/npcm7xx_timer-test.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tests/qtest/npcm7xx_timer-test.c
> b/tests/qtest/npcm7xx_timer-test.c
> index 58f58c2f71..43711049ca 100644
> --- a/tests/qtest/npcm7xx_timer-test.c
> +++ b/tests/qtest/npcm7xx_timer-test.c
> @@ -465,7 +465,6 @@ static void test_periodic_interrupt(gconstpointer
> test_data)
>      int i;
>
>      tim_reset(td);
> -    clock_step_next();
>
>      tim_write_ticr(td, count);
>      tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));
> --
> 2.39.5
>
>

--000000000000500298062c2bf4c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Have you tried that the test can pass with this? If I reme=
mber correctly, interrupt won&#39;t trigger properly if not advancing the t=
imer<div><br></div><div>If the test passes it&#39;s probably fine to remove=
 that.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 20, 2025 at 11:00=E2=80=AFPM =
Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@=
linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Until there are timers enabled the semantics of clock_step_next(=
) will<br>
fail. Since d524441a36 (system/qtest: properly feedback results of<br>
clock_[step|set]) we will signal a FAIL if time doesn&#39;t advance.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
---<br>
=C2=A0tests/qtest/npcm7xx_timer-test.c | 1 -<br>
=C2=A01 file changed, 1 deletion(-)<br>
<br>
diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-t=
est.c<br>
index 58f58c2f71..43711049ca 100644<br>
--- a/tests/qtest/npcm7xx_timer-test.c<br>
+++ b/tests/qtest/npcm7xx_timer-test.c<br>
@@ -465,7 +465,6 @@ static void test_periodic_interrupt(gconstpointer test_=
data)<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0tim_reset(td);<br>
-=C2=A0 =C2=A0 clock_step_next();<br>
<br>
=C2=A0 =C2=A0 =C2=A0tim_write_ticr(td, count);<br>
=C2=A0 =C2=A0 =C2=A0tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(=
ps));<br>
-- <br>
2.39.5<br>
<br>
</blockquote></div>

--000000000000500298062c2bf4c5--

