Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A23CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 20:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL5RA-00078L-Tl; Mon, 17 Nov 2025 15:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vL5R8-00077d-J3
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 15:02:54 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vL5R5-0002pz-36
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 15:02:53 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34374febdefso5048836a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 12:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763409769; x=1764014569; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M89lt4r1OgH79h7NkHqkSWq7WWo96/hWwy6+cFEQQ3s=;
 b=H8wCney0EVpOMd3hSkhxaKDOjmJWMUStqh09NxQXiVQb7e4A4jLT1NBF9FkA6OFwUB
 qjdrkR3wAtjzAB6y7w/GB1Pgd/PAKihIF83d5KIqiIaufGtiiWg9ri51IYXGK3pjEsTR
 a/QG0n04ro3kY2V+kv+lEL74jQNrVg2dT9oAlJXbaVKQUgR1NQ+JoZEzAX7G8PxWP0Ls
 bl1nGDgsp1gtoXd+u6dfxGXgHxtK4KNbb8RVNLU9ELZxEdnwQ7tHLpTDOv0dCdPYCGyt
 glBO6ZFdmnqKByeGFiRUD49c0AkcxnZ1PwPOLRWSQ/XAximN74waMsTYxTuVTXaPF2p/
 /qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763409769; x=1764014569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M89lt4r1OgH79h7NkHqkSWq7WWo96/hWwy6+cFEQQ3s=;
 b=htgwPqbrkFVYvUwekmbStBYIQGrSkTG/PXt+yhSHv31Zz0JxtwIn6smbSHSgZYHUFI
 N62FTyv83qdo/hcE/a355ilemmLO+VgY29lTs7v+h9/rNS5rjWerVARx9yNA7LPhCF13
 8+JkE0QkZ2vYoNbWCAKdJyNPqyYUnc1Eh7Z477alST03EOnER7wUKISyGDLqdA7vyosM
 Z+X10iSDERiIY4dYvno6kvbbY1zRSP34xqj91MF45OxlcqRHB9W+J53tsSZYiP6YjjVa
 4GTTwQAem6YoNgUvTMNO4GZKGzLTGBHvWNUA9Nk2lbgdVi8qZRDewUXFPYqA548P3xM1
 hf1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGDWySXk+jLRq7wGlcvvCvdgQS82jtJTr/RCdcuytGPSKCbuVGzWWlk5v5PoHaIJUNCq8LUZdukwPs@nongnu.org
X-Gm-Message-State: AOJu0YxDOpIRfUI4FpA9tECjyigR68x3RJi/Fe1aS0uEqHZRjrAhkwrY
 OLZF881Ts0i2b6RHyDSfQc6e5N0QIoC2HHoChhgKdIm+IXGZ+Ju2OHNuSHUSRM/h/BhLP23eXKB
 xkxgS/+zl28sdCLljF4dU1xgL8P0fPEo=
X-Gm-Gg: ASbGncuzJp5VjmwsbCvi5aOYXSo5ZOC5Pa2gGhX9O8wwvRXayi/f6B8MVCHvxkGtQ/E
 x/w+o6VzwG/aBYEch7QCBWnHSlxOd8mDzG1lD1DbR90lAUqyJNfXotQ5PZqLtbn1b+ArPw3Pvsy
 iF3KpET8cYw1DnHWUWLlbdS4V0mTavg8atRo6yLsDFYJu1U/bTMOby86YSeIgw0Nj7riCqKwcii
 IGGJwW9Qfc7jzkFTiQoITvhJH3QeyfYOvnRTIq6OEJ99qBD/BNvpZrnhByOgAia9AVlf1yUbvRe
 8tf1InRa2IJNyp+ibfe65z0e8l8=
X-Google-Smtp-Source: AGHT+IHV6Q37rcMtkClCWkVhCIjC/gS4Z3fLgh+ZpHtPGwOptOxJg/lY7QjB2BWrUAI0KK2QRJhMONyNawVrJMdo2d4=
X-Received: by 2002:a17:90b:5105:b0:341:8ac7:39b7 with SMTP id
 98e67ed59e1d1-343fa7489e0mr14212580a91.25.1763409769260; Mon, 17 Nov 2025
 12:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <d3323b18-5822-431e-aad6-cbe4470d1a2d@linaro.org>
 <CAEqNhNYCUwK6UDXKSONA67yfmLPaSt14gtgrK26AfAQqyBopTg@mail.gmail.com>
 <CAATN3Nps8qxYPBHxM6NfP6qt+NSNHzhiC_C-tuK796rQG+qbAQ@mail.gmail.com>
In-Reply-To: <CAATN3Nps8qxYPBHxM6NfP6qt+NSNHzhiC_C-tuK796rQG+qbAQ@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 17 Nov 2025 13:02:38 -0700
X-Gm-Features: AWmQ_blmND1KtE7pi9p4mtqz0Yr9rCQ5ONimidErZrcczmPsLdu34ysOaE8vWdk
Message-ID: <CAATN3NoTqaU84Bctib5h=Fghx4wRs=3bVE2Cw10BSu_dtgnJKA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Clean up end-of-instruction processing
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000e3e97e0643cfd4b5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1029.google.com
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

--000000000000e3e97e0643cfd4b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FWIW, they also apply cleanly to this commit
commit e88510fcdc13380bd4895a17d6f8a0b3a3325b85 (HEAD -> master,
origin/staging, origin/master, origin/HEAD)
Merge: 409be85c2f 522444744e
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Fri Nov 14 17:59:05 2025 +0100

Taylor


On Mon, Nov 17, 2025 at 11:35=E2=80=AFAM Taylor Simpson <ltaylorsimpson@gma=
il.com>
wrote:

>
> They are based on this one
> commit bc831f37398b51dfe65d99a67bcff9352f84a9d2 (origin/staging,
> origin/master, origin/HEAD)
> Merge: 76929d6117 7dbe2d7df0
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Tue Oct 28 11:48:05 2025 +0100
>
> They also apply cleanly to Brian's hex-next-express branch.
>
> What error are you getting on your end?
>
> Thanks,
> Taylor
>
>
> On Mon, Nov 17, 2025 at 10:08=E2=80=AFAM Brian Cain <brian.cain@oss.qualc=
omm.com>
> wrote:
>
>> Maybe they're based on the other commits on my tree which are queued for
>> inclusion after 10.2?
>> https://github.com/quic/qemu/commits/hex-next-express/
>>
>

--000000000000e3e97e0643cfd4b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">FWIW, they also apply cleanly to this commit<div>commit e8=
8510fcdc13380bd4895a17d6f8a0b3a3325b85 (HEAD -&gt; master, origin/staging, =
origin/master, origin/HEAD)<br>Merge: 409be85c2f 522444744e<br>Author: Rich=
ard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.h=
enderson@linaro.org</a>&gt;<br>Date: =C2=A0 Fri Nov 14 17:59:05 2025 +0100<=
br></div><div><br></div><div>Taylor</div><div><br></div></div><br><div clas=
s=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_att=
r">On Mon, Nov 17, 2025 at 11:35=E2=80=AFAM Taylor Simpson &lt;<a href=3D"m=
ailto:ltaylorsimpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><b=
r><div>They are based on this one</div><div>commit bc831f37398b51dfe65d99a6=
7bcff9352f84a9d2 (origin/staging, origin/master, origin/HEAD)<br>Merge: 769=
29d6117 7dbe2d7df0<br>Author: Richard Henderson &lt;<a href=3D"mailto:richa=
rd.henderson@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>=
&gt;<br>Date: =C2=A0 Tue Oct 28 11:48:05 2025 +0100<br></div><div><br></div=
><div>They also apply cleanly to Brian&#39;s hex-next-express branch.</div>=
<div><br></div><div>What error are you getting on your end?</div><div><br><=
/div><div>Thanks,</div><div>Taylor</div><div><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 17, 2025=
 at 10:08=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualco=
mm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Maybe=
 they&#39;re based on the other commits on my tree which are queued for inc=
lusion after 10.2?=C2=A0=C2=A0<a href=3D"https://github.com/quic/qemu/commi=
ts/hex-next-express/" target=3D"_blank">https://github.com/quic/qemu/commit=
s/hex-next-express/</a></div>
</blockquote></div>
</blockquote></div>

--000000000000e3e97e0643cfd4b5--

