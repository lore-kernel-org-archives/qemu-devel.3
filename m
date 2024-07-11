Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E1DC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwXT-0006Wp-TL; Thu, 11 Jul 2024 12:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <halouworls@gmail.com>)
 id 1sRwXS-0006VA-6S
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:20:58 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <halouworls@gmail.com>)
 id 1sRwXQ-0004DI-JX
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:20:57 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a6fd513f18bso151359966b.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720714853; x=1721319653; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1j1Z+eskJXpdz5Nix4pqUFEEydMagJBIPKn2DTfRAG8=;
 b=G0il7J5my1pdyi6xBY5gysYpWsdgh7mdb4Se3DfSzzLjkuoGtLrGg6t5kJDMg9OwC/
 3s6PIkD75n+mhyL6p9mwR7IHOc2Xn3CuIxtD08sgrYvWLz+a6tajX+xDe9WW37WBf3yD
 XQk2x1teRjyStu5qUJdqduHo2y2PMSPdOhXasmuM3WG2LrWdqzJ9+IYCMZ76/m1JTw4m
 hbgpxL3grWfAQkrvaAPC4QMGJfaw3ewbr7/X3IAQrV1/fF8DZAnkw7YDFJkCcoTyR1BV
 Gsyw0EmX7LHlb46d+sI9t1uq8b075sAGkHi2ZDxarAuWEn3wiSooEYXHlZiTSMSMnT90
 jawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720714853; x=1721319653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1j1Z+eskJXpdz5Nix4pqUFEEydMagJBIPKn2DTfRAG8=;
 b=qEQioK6/LtOVOBARvok8EnG5wLNR3KdUJuptmLKHDZPpFe8ZMYVJktjuM+B5uScutq
 DjS4ba2InWFxOf4J7JBlVZCExwrSqQ/x6dp7sQRn/1IyDha0u2O86T7sfgbG2bNEGlXd
 Ch+oXGoN3TjXTtj1mu3Qw9rQhDuo7CsKkrR7ZGb4hLTPeL7txJN5N7GCd9B1I20+s8j8
 5lA5PLW6sQEQvYBtXEThUIczF/UowmdEd/g2vEySxq+eWa0ptWsovhhMUvFh/OPtbWKd
 C7f6OdWsbChv/5HtirVazozJc7NT2M2qvHursBK4KLkNpOd22a8bwmUnm8Y0o0pdiqzu
 C1VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWD6nIZT9RU4wosPoMLPLk9N1W5Z4eoa+tgYzGb5bOCre0ZM5R4fRFo4bxYimR/sx33/vfY4R+sBCS2KiDMOrp88B3t28=
X-Gm-Message-State: AOJu0Yy32bJz4K32w5jbmbnJki4cGEYI61w9aDK4jdlPaQcXkLoxF6TE
 cNC8LW9KhWDvhDbRTg/7d3i6X4TRcdhEkItOtT163QjA17j/VPipuhjxpeclIsrj2SA+yfsM5+Y
 jyP5KFBUqmtyJQ6JynBG9O6nrYxA=
X-Google-Smtp-Source: AGHT+IGOKFDDyX4ZJyKBzjgzo8MOK6q6l9nFcOKmA6305q5cVOnVKpqcShN0rL5q5p0JA07LRVpTQNrUkrcHtdU9jsA=
X-Received: by 2002:a17:906:ac6:b0:a77:cca9:b21c with SMTP id
 a640c23a62f3a-a780b6ff65cmr598216766b.34.1720714852944; Thu, 11 Jul 2024
 09:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240708112520.106127-1-junjiehua@tencent.com>
 <CAFEAcA_pR6VLjKcOgcL+m8aONtey5Lm2ODkWAKv2ne_3ziqknw@mail.gmail.com>
 <CA+TA2aVV8qSK9zEv+HHyp-ib00vqaCLW_s4Hc5pGa_UJskQvUQ@mail.gmail.com>
 <399b661a-9bf4-4f97-be9b-f3d633b8b665@daynix.com>
In-Reply-To: <399b661a-9bf4-4f97-be9b-f3d633b8b665@daynix.com>
From: junjiehua <halouworls@gmail.com>
Date: Fri, 12 Jul 2024 00:20:16 +0800
Message-ID: <CA+TA2aUNecgCQ9Dz5gS4NUuHirGjYJQpE+Cu1K=x8ZY7G676cA@mail.gmail.com>
Subject: Re: [PATCH] contrib/elf2dmp: a workaround for the buggy
 msvcrt.dll!fwrite
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 junjiehua <junjiehua@tencent.com>
Content-Type: multipart/alternative; boundary="00000000000091d290061cfb25d1"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=halouworls@gmail.com; helo=mail-ej1-x632.google.com
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

--00000000000091d290061cfb25d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
>
> On Thu, Jul 11, 2024 at 3:53=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayn=
ix.com>
> wrote:

    On 2024/07/10 17:02, hellord wrote:
> >
> > note:
> > 1. The path of buggy msvcrt.dll is c:\windows\system32\msvcrt.dll(
> > mingw64 links to it );
> > 2. fwrite implementation in another msvc library which is called
> > ucrtbase.dll is correct(msvc links to it by default).
>
> I don't object to this change but you should use ucrt whenever possible.
> I'm not confident that elf2dmp and other QEMU binaries would work well
> with mvcrt.
>
> I even would like to force users to use ucrt and call setlocale(LC_ALL,
> ".UTF8") to fix text encoding, but I haven't done that yet because
> Fedora, which cross-compiles QEMU for CI, still uses msvcrt.
>


Thanks.

Using ucrt by default (or mandatorily) is a good point, helps avoid other
unknown bugs in msvcrt and is
beneficial for the long-term development of QEMU on Windows.

--00000000000091d290061cfb25d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br class=3D"gmail-Apple-interchange-newline">On Thu, Jul 11, 20=
24 at 3:53=E2=80=AFPM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@day=
nix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt; wrote:</blockqu=
ote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 =C2=A0 On 2024=
/07/10 17:02, hellord wrote:<br>&gt;<br>&gt; note:<br>&gt; 1. The path of b=
uggy msvcrt.dll is c:\windows\system32\msvcrt.dll(<br>&gt; mingw64 links to=
 it );<br>&gt; 2. fwrite implementation in another msvc library which is ca=
lled<br>&gt; ucrtbase.dll is correct(msvc links to it by default).<br><br>I=
 don&#39;t object to this change but you should use ucrt whenever possible.=
<br>I&#39;m not confident that elf2dmp and other QEMU binaries would work w=
ell<br>with mvcrt.<br><br>I even would like to force users to use ucrt and =
call setlocale(LC_ALL,<br>&quot;.UTF8&quot;) to fix text encoding, but I ha=
ven&#39;t done that yet because<br>Fedora, which cross-compiles QEMU for CI=
, still uses msvcrt.<br></blockquote><div><br></div><div><br></div><div>Tha=
nks.=C2=A0<br></div><div><br></div><div>Using ucrt by default (or mandatori=
ly) is a good point, helps avoid other unknown bugs in msvcrt and is=C2=A0<=
/div><div>beneficial for the long-term development of QEMU on Windows.<br><=
br></div><div><br></div></div></div>

--00000000000091d290061cfb25d1--

