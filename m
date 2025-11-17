Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57340CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 18:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL44r-0006sm-Mn; Mon, 17 Nov 2025 13:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vL44p-0006sJ-VM
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:35:47 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vL44o-0005v4-BB
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:35:47 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-786d1658793so41952317b3.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763404545; x=1764009345; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K73Ao705R0Dy5FBdMxo0IeNm5wVkP23X22ouQxRWOBo=;
 b=K1b2lyRDF9C/0axmtjQNmicZRb04VyO91TG7TZ3sF/pQWs5l4h6DRtAlm0dAf9pAcR
 fXtY3ef1U7jT42c5fWIqaCr+DY4UdggCaNyEDKRo2ic60P9bPfxsApG8IlznI0+4/ctR
 Z2akB//UeY6G7i2oM6bYDvcxmt6a+UJdycFGG/k8VEMjg4lzh8qHKo7EBiz0hRhy8rt6
 ZIzDD3Qs3H2R5K8jhvCm5MNdQqxvd8KfS0kRyI8sCrOWav8mB+POmstCiHTxrAy2MFTn
 yT5yqdYMBa63rviClFqijshcVpiZLQNJQhfQrjdtQovaezezaQj1tHuRmRB85RTP4hpr
 rz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763404545; x=1764009345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K73Ao705R0Dy5FBdMxo0IeNm5wVkP23X22ouQxRWOBo=;
 b=SM3GpPdq0KyXFy3++Bz9zRGC+28nisldiIVY4X+GW0WYCKiiE9diFOxcRZQYYevwE5
 2MKfNn0uv11pOBs0V20EjkFv/PoG3XAslP+Yf4Gdyh8Juq8R/MkkaDYBKeU4WF85cJ9E
 JvcBJ2D+G4yV4dOFlwLUH14uLVrm3a1Jv3DVVGgArtZGyU5GA5dCZ5uL+oAH7ch+VlOl
 XCNZtmXIztbN6R90silR15koSXh30VMP9RYQ51ApKGILJaLFwQiKh4zJrPTs0SR772ip
 XrPKOngEI1q46Xj8ZqoCT441GHYBwpT/nXi/QcP9/SJJSLBAI+UvX1CrDWBtjT2Z0lG0
 fuuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0iKJ6PpW6R9pgudDfwk4kXBHc3vKNfD0crMlVHjtEElGgnHXXGA68hnU6Y5We9o5R+egtAJKktJvH@nongnu.org
X-Gm-Message-State: AOJu0Yy4sWpZoe8dvtXDGw7VpwHMLu3pT6F3urrWygTIj1SmSnternzO
 aW2GniUxwfxgjBVVuEu5RQdu4MYL/SpZ+AZfiDZogInfYddsS6wY9B3CWqRoFFzroPIShVyHl4Y
 zU+HEQTGb/BkEhRmfb3ywLjsU0O29j1U=
X-Gm-Gg: ASbGncvy6pmnoMkRSBNHg7kPgZTKzmycrh4o5N8gyLvtSA73y2vHeYBrKojH/rF09rR
 SP+Iutf9+JX35DOBqDWJzOjBsOQCkClWPIBc/8VHkLw90Hk+7iGytFv0HWD2yiS71GHnmb6rRCY
 fcko9mYBGa+IKRXMeO7r/SzBhGHDUzuMqy5bFfLf2orHlqoZRg6uHS3YrmWti6DyUpkatO/64SQ
 vs3gepNKCkMau48ZLSauBsk/Ur/hMYISSVncVaQqL1etdYFCwDBEV507zE/v+7mkJP5FwNzq2TO
 V8NaQn4hz9B5vBpPWjOi5c7x5JQ=
X-Google-Smtp-Source: AGHT+IHKzUuvpg714Fgo+Zdh6Dv9mPLPmmROWTXjiHyYBjT9xeTDpJd3MCNR+hTIN1nx69dtw8MKdp1ztjvWyf3c1/I=
X-Received: by 2002:a05:690c:3613:b0:786:5471:f44c with SMTP id
 00721157ae682-78929f1df9amr227961867b3.63.1763404544526; Mon, 17 Nov 2025
 10:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <d3323b18-5822-431e-aad6-cbe4470d1a2d@linaro.org>
 <CAEqNhNYCUwK6UDXKSONA67yfmLPaSt14gtgrK26AfAQqyBopTg@mail.gmail.com>
In-Reply-To: <CAEqNhNYCUwK6UDXKSONA67yfmLPaSt14gtgrK26AfAQqyBopTg@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 17 Nov 2025 11:35:32 -0700
X-Gm-Features: AWmQ_bnkvRxB9OIyZBKxygPNwTO3DJSnMWGZ_PA8SxmhyMFt7WJIzeBfG9Pnsmw
Message-ID: <CAATN3Nps8qxYPBHxM6NfP6qt+NSNHzhiC_C-tuK796rQG+qbAQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Clean up end-of-instruction processing
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="00000000000078cef50643ce9dc2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-yw1-x112a.google.com
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

--00000000000078cef50643ce9dc2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

They are based on this one
commit bc831f37398b51dfe65d99a67bcff9352f84a9d2 (origin/staging,
origin/master, origin/HEAD)
Merge: 76929d6117 7dbe2d7df0
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Tue Oct 28 11:48:05 2025 +0100

They also apply cleanly to Brian's hex-next-express branch.

What error are you getting on your end?

Thanks,
Taylor


On Mon, Nov 17, 2025 at 10:08=E2=80=AFAM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> Maybe they're based on the other commits on my tree which are queued for
> inclusion after 10.2?
> https://github.com/quic/qemu/commits/hex-next-express/
>

--00000000000078cef50643ce9dc2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>They are based on this one</div><div>commit bc831=
f37398b51dfe65d99a67bcff9352f84a9d2 (origin/staging, origin/master, origin/=
HEAD)<br>Merge: 76929d6117 7dbe2d7df0<br>Author: Richard Henderson &lt;<a h=
ref=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a=
>&gt;<br>Date: =C2=A0 Tue Oct 28 11:48:05 2025 +0100<br></div><div><br></di=
v><div>They also apply cleanly to Brian&#39;s hex-next-express branch.</div=
><div><br></div><div>What error are you getting on your end?</div><div><br>=
</div><div>Thanks,</div><div>Taylor</div><div><br></div></div><br><div clas=
s=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_att=
r">On Mon, Nov 17, 2025 at 10:08=E2=80=AFAM Brian Cain &lt;<a href=3D"mailt=
o:brian.cain@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">=
Maybe they&#39;re based on the other commits on my tree which are queued fo=
r inclusion after 10.2?=C2=A0=C2=A0<a href=3D"https://github.com/quic/qemu/=
commits/hex-next-express/" target=3D"_blank">https://github.com/quic/qemu/c=
ommits/hex-next-express/</a></div>
</blockquote></div>

--00000000000078cef50643ce9dc2--

