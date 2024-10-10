Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48E0CF11C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqHD-0006LI-00; Thu, 10 Oct 2024 06:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1syqHB-0006K2-ED
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:09 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1syqH8-0003Tg-LK
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:09 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-46041d86566so3376201cf.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728555605; x=1729160405; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/2k0y3LaJZ+N4GOiZeGr18q3sGaDuASYM4iLUC6otDk=;
 b=WDa1n9a+DeSpv3rj8u3fQqr8oiL0BAIJ1yek0GvrDZ0Ka2BYQCCE0Mi2i3gJ4LvZ4H
 WC++PcW0PNY9kVH1CCBUP9xGSoTGFfuNgrRTy2L5IC6MTsySkPDGSCIzznKAEUjvEvh/
 ad224ajtjx+KsLA8Rs7uN1rEeAybbfi1sICzXQHrUsk+E3SdW4HmAjbURHNKuoowB55u
 HYsNRPYk9796xESZwCch4oW11djAoX7nfsVLaX9jZPRcm8vdbePTFEDApdQ+ilAVr8+m
 Qn9FgWTsIm/Jq4w6oSCShWHpKTPWuKGfvVetTcl+MWZXvTMzPTOdLza2eP1iO870f8E2
 lcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728555605; x=1729160405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/2k0y3LaJZ+N4GOiZeGr18q3sGaDuASYM4iLUC6otDk=;
 b=HAwvluZpOySsrBiXxb52Q8jlg+hEkXoBMWRB33GYBvPeAsdqmL5eycSLSWuXpeGIZn
 XZXLkNuqn3IAMX9tRRR5yeOmZD3h+UaaZjUMXO3zDH7irFXZcaIdlvdwtYKI0qBWdJyG
 khV58AwYDuAxR6SoqD9twQkkZXQZlkIXirL/8XjWNXofw/RmgCD8pEt5LpXweiYoNOPX
 E4MHuuWIWuHnndD7mT4N/gRdutTrvjxWFOVPKHmRQkQIMCxdNM9leh5ZRXWVLPdr1RG/
 JOscxHMnV3yUEBPHvZ4wCVRoG84jo5qbuQglF+HErNKtr2UD+yKe9BcVmg5/YrWHYDXI
 jG/g==
X-Gm-Message-State: AOJu0YxN6XV36gCZULgeVIM+X+87ICfKLKRwBBm9UAVnoBLEM2FaiZDQ
 V1KI26OtkoCBGWSQTnDsqo1WnVTgmMCixZwoM8JUgWIXHq/jaSsh7gf9ZbmiDoOWdlZHjo82uO5
 R9RK2XhQucRh5lZYyxfHeBIOdFhU=
X-Google-Smtp-Source: AGHT+IHh6uuIsXVYjEOyQMnFeuxjMaAM7e8f1rnS7ugUa5XhimDMYEzcwN2+ja3PdmDrFvjGydc6eOwsDQ861dO9+Zc=
X-Received: by 2002:a05:622a:528d:b0:45d:9689:9de4 with SMTP id
 d75a77b69052e-45fb0e53552mr78433381cf.43.1728555605154; Thu, 10 Oct 2024
 03:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241010092619.323489-1-r.peniaev@gmail.com>
In-Reply-To: <20241010092619.323489-1-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 10 Oct 2024 14:19:53 +0400
Message-ID: <CAJ+F1CL8VPo64DVty94FY4KyKr1h8_dbmrqLfy06VuMzoNyYYA@mail.gmail.com>
Subject: Re: [PATCH 1/1] chardev/char: fix qemu_chr_is_busy() check
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d1e29506241cb6e5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

--000000000000d1e29506241cb6e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman

On Thu, Oct 10, 2024 at 1:28=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:

> `mux_cnt` struct member never goes negative or decrements,
> so mux chardev can be !busy only when there are no
> frontends attached. This patch fixes the always-true
> check.
>
> Fixes: a4afa548fc6d ("char: move front end handlers in CharBackend")
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

That would be worth some new tests for chardev removal. It seems to be
lacking. And mux probably need extra fixing. I can take a look if you don't=
.

thanks


> ---
>  chardev/char.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index c0cc52824b48..f54dc3a86286 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)
>  {
>      if (CHARDEV_IS_MUX(s)) {
>          MuxChardev *d =3D MUX_CHARDEV(s);
> -        return d->mux_cnt >=3D 0;
> +        return d->mux_cnt > 0;
>      } else {
>          return s->be !=3D NULL;
>      }
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d1e29506241cb6e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Roman<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 10, 2024 at 1:28=
=E2=80=AFPM Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com">r.peni=
aev@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">`mux_cnt` struct member never goes negative or decrements,<br>
so mux chardev can be !busy only when there are no<br>
frontends attached. This patch fixes the always-true<br>
check.<br>
<br>
Fixes: a4afa548fc6d (&quot;char: move front end handlers in CharBackend&quo=
t;)<br>
Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" tar=
get=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a></blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 =
Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@=
redhat.com</a>&gt;</div><div><br></div><div>That would be worth some new te=
sts for chardev removal. It seems to be lacking. And mux probably need extr=
a fixing. I can take a look if you don&#39;t.</div><div><br></div><div>than=
ks<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><br>
---<br>
=C2=A0chardev/char.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index c0cc52824b48..f54dc3a86286 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (CHARDEV_IS_MUX(s)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MuxChardev *d =3D MUX_CHARDEV(s);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return d-&gt;mux_cnt &gt;=3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return d-&gt;mux_cnt &gt; 0;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;be !=3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000d1e29506241cb6e5--

