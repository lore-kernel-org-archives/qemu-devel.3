Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75862C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 13:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHkC9-0007SI-FS; Thu, 13 Jun 2024 09:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHkC7-0007S2-Fv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 09:08:47 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHkC5-00066r-Tl
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 09:08:47 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b0745efaeeso5078656d6.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718284125; x=1718888925; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9A2UsVHaAsavVqOvvzKOoa54gyqgoUcFzdCp5G83Vc4=;
 b=VyXtfWA1K8Mh/1sX20DHjFbkPsopY0t3gDuO+L3ONcGhiHlF9s54dgyUYDv1pCLft4
 bGTwTlvHlXaxpCQuwOKePtjQ4Dp1k7QitC4ARAkcodv+xMJGDvTXidj1qefEvzYXVCtL
 I5TadX1sT5kM62lHiUc8qsm/dkCWR8/V8+vRGp5dmIIwXAqzyO7Ui9ZcFuTGAmR2Fy8C
 +tf1yx6DpH6xUGfgLMSwhK1prjq+6LzNsmEtK3e640WfWuOsmnfXF/F8UUnPOL423y5M
 iQdR0K06tO4QOAOD9yoUawzgbaTJotPr9wzR7aqT+bxL8iGDR3RXLBnikBGteZbiuYCn
 HzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718284125; x=1718888925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9A2UsVHaAsavVqOvvzKOoa54gyqgoUcFzdCp5G83Vc4=;
 b=cpZCT1T68TuaCMy2lDLbeh2WcKB8wAbJbs2jTt+fI/U14xUpS2iorRy4igkPFXsrRw
 q5vkk5EYswwSaIcm1lFedpnpi2tGiJ+a6pmM6+HIBU+HeR8ih8Bm7XFBFeFi98UyYHbp
 5dTCYMNAZGfW4NXrSIzdJeEBsGt1kY39+8h3tdME5jN1yPJ2zWS6gBUchzoXkz1Ri342
 XrgkqBatAio5lczhXCaVhrJhsFaxaVpHFtu5fo9HeyNxJaPh5O5q71L5rb4Fyhe7Mwj7
 9XokkspG8xvlLXxK+JnA5bBkU/M6a0hHZAPlF3+rf/UB85pLUwWnl5W7fe6asG0kLxkK
 +/mQ==
X-Gm-Message-State: AOJu0Yx7rGzajzcgo8kwVtUpffjJANrq1DD2aG/M6pT5x6WKtbrmwC2x
 sV2XKUDn2fmGTMsnn5XV5AI34amx7KZL2RopUXKh0xJiL4TOcLX6VkABYSVOu2WCXpPzaE6PeTt
 tuY1ow5YD3iV9476Lv7uJvG48VufyuMHn
X-Google-Smtp-Source: AGHT+IGQoFc++kcN+sbCc5v74j7kARvTVmqCADToG+TAO/LMB7DGzLamjXeqOt+i2ktZiGK0Y9neWK7IpJ8K5wCIl1w=
X-Received: by 2002:a05:6214:4520:b0:6b0:7fc4:7744 with SMTP id
 6a1803df08f44-6b1a62a7675mr49331996d6.29.1718284123997; Thu, 13 Jun 2024
 06:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <readline-shortcuts-v1.1718265822.manos.pitsidianakis@linaro.org>
In-Reply-To: <readline-shortcuts-v1.1718265822.manos.pitsidianakis@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 13 Jun 2024 17:08:31 +0400
Message-ID: <CAJ+F1C+FhP4LGnmEWNYXp1CX4fQ4V41Cs-OEkZrZYmq1vtq6cA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] util/readline.c: Add common but missing shortcuts
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d592de061ac53250"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000d592de061ac53250
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 13, 2024 at 12:07=E2=80=AFPM Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

> Some commonly used readline shortcuts are missing from our
> implementation. This series adds:
>
> - Control-n next line, same as Down arrow key
> - Control-p previous line, same as Up arrow key
> - Control-u erase line starting from cursor
>
> Manos Pitsidianakis (3):
>   util/readline.c:fix lints for readline_handle_byte
>   util/readline.c: add C-n, C-p shortcuts
>   util/readline.c: add C-u shortcut
>
>  util/readline.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
>
>
>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

--000000000000d592de061ac53250
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 12:07=E2=80=
=AFPM Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.=
org">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Some commonly used readline shortcuts ar=
e missing from our <br>
implementation. This series adds:<br>
<br>
- Control-n next line, same as Down arrow key<br>
- Control-p previous line, same as Up arrow key<br>
- Control-u erase line starting from cursor<br>
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Manos Pitsidianakis (3):<br>
=C2=A0 util/readline.c:fix lints for readline_handle_byte<br>
=C2=A0 util/readline.c: add C-n, C-p shortcuts<br>
=C2=A0 util/readline.c: add C-u shortcut<br>
<br>
=C2=A0util/readline.c | 35 +++++++++++++++++++++++++++++++----<br>
=C2=A01 file changed, 31 insertions(+), 4 deletions(-)<br>
<br clear=3D"all"><br></blockquote><div><br></div><div>Reviewed-by: Marc-An=
dr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandr=
e.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br></div></div><br><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000d592de061ac53250--

