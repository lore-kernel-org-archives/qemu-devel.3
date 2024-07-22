Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23106C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpLq-0006Nt-2U; Mon, 22 Jul 2024 05:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sVpLi-0006N3-Hu
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:28:56 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sVpLc-0000rE-7r
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:28:51 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-79f178e62d1so268912285a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721640525; x=1722245325; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JOId4DX0aBTpDEJy25abO4D/hypp2TrTJwVUKnFf0fQ=;
 b=F8sbdhEteIWe2L+DHqwIeNV90T4XPWc8kk1du7vMI37usaGmhcc1EiPojmKbLaTNy/
 Rkf28HuNZiXzyrG+r1U9fAQ8eEmeJBD9w/Gm65YmKvJNSGuUpHKorg5OZCIF54X0CXm8
 aZrpmUrNtw3Tje66zdaZL/e2AtAmaC1gBSfEjnHSV7VpBCVawZOwAyeR6RfKgK8wtEOF
 xAsEyA91z8poILSMx8CsmT7XycXAizppRPMcxfs2zH4B9BVTDgAXVTR98/3UV7/NO7H8
 VRJTLPjaXgWdbZ05HsdXAb1hkSklKfYrBto6DslMl3jUwZVFF0dNw8T/00cu+5dg+Det
 Xm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721640525; x=1722245325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JOId4DX0aBTpDEJy25abO4D/hypp2TrTJwVUKnFf0fQ=;
 b=SPko6S7B+3f30B/XTvuWWeVg7f8cnc0oZUJXzPMPoUojhDSq8cR35b2TH5xxhksgQs
 8DJqXdls+C5ofMrNRIU/uSiJM8D31Wt8coktlU3BPG0xQjhZV7DRc6S/CS7wkZRRYxea
 UkJkWA9EUjB3gF/k9MzbZuc/XJTfHrOk9tGCeqquGiEEcNVPhbl4OF/Ql5t1pYvx2LT7
 fw2fB/po1W//qLdwRL1pk7+je999xu+b4CBN+juMtLgtp42gpmqnUYxsHukHoIBPi1k9
 v9Um6S/Oh3qSn07p8XPbAOhvH5xC1LBqSefdhvM2Sz8Fr4SPzsm7snu7vK5XGdnja9Qa
 zKYw==
X-Gm-Message-State: AOJu0YxezW7aI4ow3erIJ1wBFThSFm9CwOaeEB6wZHcLzIZcOm0v8XJu
 Xs0SadAMs6X7ejVwTnK3eoyQhKBAmT0UyrePvTw6OrF4JuoopDwGZ2h8EYjdH/JJVQ6dzMcx13K
 9frcJuQbqhOGjU2FAyjHcMUjiuyY=
X-Google-Smtp-Source: AGHT+IGVFV3wI7SA5MktENrkfYxdX9WSrQxTzXCdF4WksNINxU4VdpGk6prb4NoY74dG2y1VmBM7naOj9bVDAHpGMOY=
X-Received: by 2002:a05:622a:1387:b0:446:56d4:4d6c with SMTP id
 d75a77b69052e-44fa531d66fmr102977041cf.40.1721640525095; Mon, 22 Jul 2024
 02:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1CJXWRSktYPucOvO5F-zC73VMaUFfxUxksxMTLKugYNB8A@mail.gmail.com>
 <ME3P282MB2548B9C3523209F6045785D18CA82@ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <ME3P282MB2548B9C3523209F6045785D18CA82@ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jul 2024 13:28:33 +0400
Message-ID: <CAJ+F1CKC7+prnteeaLMBi8ZQtf8LjBqzEU2v5boobUd7_BuZBA@mail.gmail.com>
Subject: Re: [PATCH] chardev/char-win-stdio.c: restore old console mode
To: songziming <s.ziming@hotmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ede962061dd2ab19"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72e.google.com
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

--000000000000ede962061dd2ab19
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 1:19=E2=80=AFPM songziming <s.ziming@hotmail.com> w=
rote:

> Hi
>
> I've updated the patch.
>
> Now it only reset mode if handle is valid.
>
>
you lost the commit message, and the subject does not' have a version tag
(see
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#when-resendi=
ng-patches-add-a-version-tag
)

thanks


> Signed-off-by: Ziming Song <s.ziming@hotmail.com>
>

> ---
>  chardev/char-win-stdio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> index 1a18999..13325ca 100644
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
> @@ -221,6 +223,9 @@ static void char_win_stdio_finalize(Object *obj)
>  {
>      WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(obj);
>
> +    if (stdio->hStdIn !=3D INVALID_HANDLE_VALUE) {
> +        SetConsoleMode(stdio->hStdIn, stdio->dwOldMode);
> +    }
>      if (stdio->hInputReadyEvent !=3D INVALID_HANDLE_VALUE) {
>          CloseHandle(stdio->hInputReadyEvent);
>      }
> --
> 2.34.1.windows.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000ede962061dd2ab19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 22, 2024 at 1:19=E2=80=AF=
PM songziming &lt;<a href=3D"mailto:s.ziming@hotmail.com">s.ziming@hotmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Hi<br>
<br>
I&#39;ve updated the patch.<br>
<br>
Now it only reset mode if handle is valid.<br>
<br>
</blockquote><div><div><br></div><div>you lost the commit message, and the =
subject does not&#39; have a version tag (see <a href=3D"https://www.qemu.o=
rg/docs/master/devel/submitting-a-patch.html#when-resending-patches-add-a-v=
ersion-tag">https://www.qemu.org/docs/master/devel/submitting-a-patch.html#=
when-resending-patches-add-a-version-tag</a>)</div><div><br></div><div>than=
ks</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Signed-off-by: Ziming Song &lt;<a href=3D"mailto:s.ziming@hotmail.com=
" target=3D"_blank">s.ziming@hotmail.com</a>&gt;<br></blockquote><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
---<br>
=C2=A0chardev/char-win-stdio.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c<br>
index 1a18999..13325ca 100644<br>
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
@@ -221,6 +223,9 @@ static void char_win_stdio_finalize(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(obj);<br>
<br>
+=C2=A0 =C2=A0 if (stdio-&gt;hStdIn !=3D INVALID_HANDLE_VALUE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SetConsoleMode(stdio-&gt;hStdIn, stdio-&gt;dwO=
ldMode);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0if (stdio-&gt;hInputReadyEvent !=3D INVALID_HANDLE_VALU=
E) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CloseHandle(stdio-&gt;hInputReadyEvent);<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.34.1.windows.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000ede962061dd2ab19--

