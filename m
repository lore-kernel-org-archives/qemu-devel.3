Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CD4EE4987
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 10:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soKFg-0005au-BJ; Wed, 11 Sep 2024 06:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1soKFe-0005aI-9X
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:07:06 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1soKFc-0000PA-JX
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:07:06 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-45812fdcd0aso6398301cf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 03:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726049223; x=1726654023; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2v/3FJD5JxCOjSEO48JyCyHSOewCfx/w73gS/grPSo4=;
 b=L0IWaLi+mos8Aq7fI46ndRz98NfiTE2HyeF4itABpzjR6oaNDdS0eChNYg4VpaZ6D5
 0rpO9WRJE1SoyAFLRkq9B5Jh9Qwsd70y7+Pqd5O4Ko409O5DMR6AaT1J45Gdau5nQAFS
 zo5feJ4GcJ3RHyDpdYe0rAwYTlvnOUZUcvTU6I2PKMlVIw3VcDBUdVpUTjgEZPGRIIDW
 ALE92JIolPd0obnf0VZ8VNTzAWX2jGjMS5wV/rGb3QO9IeJM30J0MWCPz+IWu0gMEc6n
 bklJJA3sryU/stp7zj5OR5lxEHxil3dv7OoY2rpD+cTin3NnUN7hD10f9rmgTqaI1S3y
 1Yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726049223; x=1726654023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2v/3FJD5JxCOjSEO48JyCyHSOewCfx/w73gS/grPSo4=;
 b=X1zuJLmA4cPG8+t3WOjIxQT9zmOJbO5NrSTkh6fE3ae+1QjLSwlG4iW8uKVAR02TKh
 2LiG5xt5akJubgJyWkrjRUDe6/5bROAkjtAR0LSf0teKeA/ByxAbfrY2sl5O0iwqLTGM
 2qPOwkKM1D4tcVJ5LaULYmhACrHpGQKr2ppojBM9HZ3Q9LbErmbUU8JdHqmy/3KqY0lr
 IbM5uSMQZlxh4rhWYzbzjxOi081bctPpumsvfKSRpsJ35Bn1Tmz4ywmTQvsmJbbS9soh
 +9TdS7cFIGJ3ZIXhYmLJXBNMC5ElnJQrgcj59mQ6sgOFxS1mOPW3dXaw1rQ8Ui7cQBC0
 VoiQ==
X-Gm-Message-State: AOJu0YxnRW2dixvf9uFQsQGWpoZsG6kg15d5oFOyCL0PSrJ+gzG2FmpZ
 hsE8ll+ZNP2UVfi/8C9wPLgeXG1c5Fhpmq4VheNQZwTy8eryHTxR8/utfe2qbmY8xHWwXfG8qDx
 BgiosOnCR7b4vHU0EOl18wbRUaOE=
X-Google-Smtp-Source: AGHT+IEG3/5eb7hje66YT5OMHbJvOj7XV1ag2Zjp55sPCx/r8gezAjjCpxQmcIk1hqgg28nmbDhUYM75opJIkHHq7/k=
X-Received: by 2002:ac8:7f06:0:b0:446:54f5:3181 with SMTP id
 d75a77b69052e-4583c7adb3amr113873051cf.24.1726049223240; Wed, 11 Sep 2024
 03:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <01020191e05ce6df-84da6386-62c2-4ce8-840e-ad216ac253dd-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020191e05ce6df-84da6386-62c2-4ce8-840e-ad216ac253dd-000000@eu-west-1.amazonses.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 11 Sep 2024 14:06:51 +0400
Message-ID: <CAJ+F1CLs6O57etCY+fEVx5gksWh4UrWsRfGgdxySdEgxpKDn=g@mail.gmail.com>
Subject: Re: [PATCH] qemu/ui: set swap interval explicitly when OpenGL is
 enabled
To: gert.wollny@collabora.com
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d0f5680621d52604"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

--000000000000d0f5680621d52604
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 1:15=E2=80=AFPM <gert.wollny@collabora.com> wrote:

> From: Gert Wollny <gert.wollny@collabora.com>
>
> Before 176e3783f2ab (ui/sdl2: OpenGL window context)
> SDL_CreateRenderer was called unconditionally setting
> the swap interval to 0. Since SDL_CreateRenderer is now no
> longer called when OpenGL is enabled, the swap interval is
> no longer set explicitly and vsync handling depends on
> the environment settings which may lead to a performance
> regression with virgl as reported in
>    https://gitlab.com/qemu-project/qemu/-/issues/2565
>
> Restore the old vsync handling by explicitly calling
> SDL_GL_SetSwapInterval if OpenGL is enabled.
>
> Fixes: 176e3783f2ab (ui/sdl2: OpenGL window context)
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2565
>
> Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/sdl2.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 98ed974371..51299f3645 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -115,6 +115,7 @@ void sdl2_window_create(struct sdl2_console *scon)
>          SDL_SetHint(SDL_HINT_RENDER_BATCHING, "1");
>
>          scon->winctx =3D SDL_GL_CreateContext(scon->real_window);
> +        SDL_GL_SetSwapInterval(0);
>      } else {
>          /* The SDL renderer is only used by sdl2-2D, when OpenGL is
> disabled */
>          scon->real_renderer =3D SDL_CreateRenderer(scon->real_window, -1=
,
> 0);
> --
> 2.44.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d0f5680621d52604
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 11, 2024 at 1:15=E2=80=AF=
PM &lt;<a href=3D"mailto:gert.wollny@collabora.com">gert.wollny@collabora.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">From: Gert Wollny &lt;<a href=3D"mailto:gert.wollny@collabora.com" target=
=3D"_blank">gert.wollny@collabora.com</a>&gt;<br>
<br>
Before 176e3783f2ab (ui/sdl2: OpenGL window context)<br>
SDL_CreateRenderer was called unconditionally setting<br>
the swap interval to 0. Since SDL_CreateRenderer is now no<br>
longer called when OpenGL is enabled, the swap interval is<br>
no longer set explicitly and vsync handling depends on<br>
the environment settings which may lead to a performance<br>
regression with virgl as reported in<br>
=C2=A0 =C2=A0<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2565"=
 rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/=
-/issues/2565</a><br>
<br>
Restore the old vsync handling by explicitly calling<br>
SDL_GL_SetSwapInterval if OpenGL is enabled.<br>
<br>
Fixes: 176e3783f2ab (ui/sdl2: OpenGL window context)<br>
Closes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2565" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/is=
sues/2565</a><br>
<br>
Signed-off-by: Gert Wollny &lt;<a href=3D"mailto:gert.wollny@collabora.com"=
 target=3D"_blank">gert.wollny@collabora.com</a>&gt;<br></blockquote><div><=
br></div><div>Acked-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/sdl2.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
index 98ed974371..51299f3645 100644<br>
--- a/ui/sdl2.c<br>
+++ b/ui/sdl2.c<br>
@@ -115,6 +115,7 @@ void sdl2_window_create(struct sdl2_console *scon)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SDL_SetHint(SDL_HINT_RENDER_BATCHING, &qu=
ot;1&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scon-&gt;winctx =3D SDL_GL_CreateContext(=
scon-&gt;real_window);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SDL_GL_SetSwapInterval(0);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The SDL renderer is only used by sdl2-=
2D, when OpenGL is disabled */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scon-&gt;real_renderer =3D SDL_CreateRend=
erer(scon-&gt;real_window, -1, 0);<br>
-- <br>
2.44.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000d0f5680621d52604--

