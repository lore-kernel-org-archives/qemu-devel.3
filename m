Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2E5C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnAz-0000XW-IK; Mon, 22 Jul 2024 03:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sVnAx-0000RD-QW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:09:39 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sVnAs-0007wP-D4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:09:36 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-79f17d6be18so241493085a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 00:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721632171; x=1722236971; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L/ALWNxQdZivRnUqyoCbNjh/amFjxJE1OY4FPKSYoe0=;
 b=lvjGgNUn1FVoAWgkpmvEWlLLJVj63FkhP0pz0QaI063krguSSGdtDdFGUXS5sUH4pG
 V9m33XaGYnzCkqJKzPcK0dcO0Cd6DEP5TbvuVj9+7/tYZxH69hYNDNyoUEqwA9EI/KxR
 VlRkkgoL2VO8n/yORWBWArNwgDTf0nPXzJKSQnA1kz+4/gxC4uwZoI0M3HsT7fvsUSfp
 QAqQnLQou2QNUMf9WguzSipO2NeyEKodsRkzybMrqoJgzCHpo01iJm0n3pZ70AM2eoXu
 ZwpLVmfNUFq2yq2CZ3PbYgNS72WHukW8dyrk3z1nEbcvBpuF45d0KfzTtjuYii9aSjXC
 lfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721632171; x=1722236971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L/ALWNxQdZivRnUqyoCbNjh/amFjxJE1OY4FPKSYoe0=;
 b=bY9rSxJHSKf0dU6nFTPlQbcN8oqyQHJZy+BwR5+iHVL+Rp0xJ+waUiRZ0z0+Whg2dc
 LOMdaDuki/sgLCBTHCUho1+nLzS4bTPrn6XkROsiLs5sMaZ6mX5/Q35RANb8KFlddXOP
 toBBUsJaU3IReuSQ+jKSeK8GexHSU1R20H6HMDC90GTvczylvHXexGxt5om8bQjP8vx+
 DDvo4LF73FjYFIfduWvfQhEx7WOtMaC2pZRPm3EOnbcSpH5zDPvrT0e3XRt6Y9b3M5dz
 7xLY2pc28AU4xQy1EWoUtEOtxMTzIW60AFhlgBnzZy7c0Q1LY23UpvzbN0hj+2CcHhdT
 ZCKA==
X-Gm-Message-State: AOJu0YwVj5W/7bdBLOATqzfZHIIvPc/GZaGK09iHxWXIw2apZTkBDz54
 pLgZIqpM4YiJsggTCT+JnesIGONCKZ21TM2aYPAW3G0fXxzez/p9b34uU44mMpsKtS5vhB4bXQc
 /8S5i0RcJvpvEewUis9MfUjEIMH4=
X-Google-Smtp-Source: AGHT+IEu35VUd3A2wosaz7AzV90pazyuNNgxpZAaRwufTyJgH4HFoqvKgSC9libpqX4ebDgCIV6qF1CP2lq2r1kWJCs=
X-Received: by 2002:a05:622a:353:b0:446:59ab:56a6 with SMTP id
 d75a77b69052e-44fa535e4e8mr102638121cf.47.1721632171216; Mon, 22 Jul 2024
 00:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <ME3P282MB25482B87915BEBE85CCE7E898CAF2@ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <ME3P282MB25482B87915BEBE85CCE7E898CAF2@ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jul 2024 11:09:19 +0400
Message-ID: <CAJ+F1CJXWRSktYPucOvO5F-zC73VMaUFfxUxksxMTLKugYNB8A@mail.gmail.com>
Subject: Re: [PATCH] chardev/char-win-stdio.c: restore old console mode
To: songziming <s.ziming@hotmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ffd796061dd0b98e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x732.google.com
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

--000000000000ffd796061dd0b98e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jul 22, 2024 at 12:01=E2=80=AFAM songziming <s.ziming@hotmail.com> =
wrote:

> If I use `-serial stdio` on Windows, after QEMU exits, the terminal
> could not handle arrow keys and tab any more. Because stdio backend
> on Windows sets console mode to virtual terminal input when starts,
> but does not restore the old mode when finalize.
>
> This small patch saves the old console mode and set it back.
>

Thanks, we had a similar patch from Irina Ryapolova, but it didn't save the
old mode and she didn't update it.


> Signed-off-by: Ziming Song <s.ziming@hotmail.com>
>

> ---
>  chardev/char-win-stdio.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> index 1a18999..5b24893 100644
> --- a/chardev/char-win-stdio.c
> +++ b/chardev/char-win-stdio.c
> @@ -33,6 +33,7 @@
>  struct WinStdioChardev {
>      Chardev parent;
>      HANDLE  hStdIn;
> +    DWORD   dwOldMode;
>      HANDLE  hInputReadyEvent;
>      HANDLE  hInputDoneEvent;
>      HANDLE  hInputThread;
> @@ -159,6 +160,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
>      }
>
>      is_console =3D GetConsoleMode(stdio->hStdIn, &dwMode) !=3D 0;
> +    stdio->dwOldMode =3D dwMode;
>
>      if (is_console) {
>          if (qemu_add_wait_object(stdio->hStdIn,
> @@ -220,6 +222,7 @@ err1:
>  static void char_win_stdio_finalize(Object *obj)
>  {
>      WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(obj);
> +    SetConsoleMode(stdio->hStdIn, stdio->dwOldMode);
>
>
It should not reset if the open callback was not called successfully.

You can check if it's the case by adding a if (stdio->hStdIn !=3D
INVALID_HANDLE_VALUE) condition.

     if (stdio->hInputReadyEvent !=3D INVALID_HANDLE_VALUE) {
>          CloseHandle(stdio->hInputReadyEvent);
> --
> 2.45.1.windows.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000ffd796061dd0b98e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 22, 2024 at 12:01=E2=80=
=AFAM songziming &lt;<a href=3D"mailto:s.ziming@hotmail.com">s.ziming@hotma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">If I use `-serial stdio` on Windows, after QEMU exits, the terminal<b=
r>
could not handle arrow keys and tab any more. Because stdio backend<br>
on Windows sets console mode to virtual terminal input when starts,<br>
but does not restore the old mode when finalize.<br>
<br>
This small patch saves the old console mode and set it back.<br></blockquot=
e><div><br></div><div>Thanks, we had a similar patch from=C2=A0<span>Irina =
Ryapolova, but it didn&#39;t save the old mode and she didn&#39;t update it=
.</span></div><div><span><br></span> </div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
Signed-off-by: Ziming Song &lt;<a href=3D"mailto:s.ziming@hotmail.com" targ=
et=3D"_blank">s.ziming@hotmail.com</a>&gt;<br></blockquote><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
---<br>
=C2=A0chardev/char-win-stdio.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c<br>
index 1a18999..5b24893 100644<br>
--- a/chardev/char-win-stdio.c<br>
+++ b/chardev/char-win-stdio.c<br>
@@ -33,6 +33,7 @@<br>
=C2=A0struct WinStdioChardev {<br>
=C2=A0 =C2=A0 =C2=A0Chardev parent;<br>
=C2=A0 =C2=A0 =C2=A0HANDLE=C2=A0 hStdIn;<br>
+=C2=A0 =C2=A0 DWORD=C2=A0 =C2=A0dwOldMode;<br>
=C2=A0 =C2=A0 =C2=A0HANDLE=C2=A0 hInputReadyEvent;<br>
=C2=A0 =C2=A0 =C2=A0HANDLE=C2=A0 hInputDoneEvent;<br>
=C2=A0 =C2=A0 =C2=A0HANDLE=C2=A0 hInputThread;<br>
@@ -159,6 +160,7 @@ static void qemu_chr_open_stdio(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0is_console =3D GetConsoleMode(stdio-&gt;hStdIn, &amp;dw=
Mode) !=3D 0;<br>
+=C2=A0 =C2=A0 stdio-&gt;dwOldMode =3D dwMode;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (is_console) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qemu_add_wait_object(stdio-&gt;hStdIn=
,<br>
@@ -220,6 +222,7 @@ err1:<br>
=C2=A0static void char_win_stdio_finalize(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(obj);<br>
+=C2=A0 =C2=A0 SetConsoleMode(stdio-&gt;hStdIn, stdio-&gt;dwOldMode);<br>
<br></blockquote><div><br></div><div>It should not reset if the open callba=
ck was not called successfully.</div><div><br></div><div>You can check if i=
t&#39;s the case by adding a if (stdio-&gt;hStdIn !=3D INVALID_HANDLE_VALUE=
) condition.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
=C2=A0 =C2=A0 =C2=A0if (stdio-&gt;hInputReadyEvent !=3D INVALID_HANDLE_VALU=
E) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CloseHandle(stdio-&gt;hInputReadyEvent);<=
br>
-- <br>
2.45.1.windows.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000ffd796061dd0b98e--

