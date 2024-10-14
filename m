Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AA2D16271
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0La7-0001Ni-6h; Mon, 14 Oct 2024 09:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0La5-0001NR-18
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:57:53 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0La3-0006O4-8l
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:57:52 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4604bd47e35so14663431cf.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728914270; x=1729519070; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kFQjaMmebX/GNfns5YbzfhnYeTTu2UtxY531guWUTY8=;
 b=HiWK0a0FmB6bkAsufESQXBSX5uibVQcmfTdutvtwRoddjIZ/ZqPaUQs5s3Ey3TH19e
 hsIKvfkKLn2lPOO1QB/+1mSDRzB9bLGmop/P5bvr6AgGUSxBOsHgzpdo6EdJSwu7/eFS
 8wuuprNdnLv5LugEJgi44coQJ6SSQsprsMC12GA4U+16kE2/SuXLQr35bZgHHR+czcV6
 udpdI0g8vT8gpzqKPupwu6a0SpQmFZ6GU0G2k6n5aC0sUBeRaTFplCh7kyFJN2b6nbHr
 jwPFBvG6q5OZOUQi+p1E+aD3mgHT+fRtVcOTPgPKkOSpCQ65NR3xlEI807/DuVTpLkIR
 DWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728914270; x=1729519070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kFQjaMmebX/GNfns5YbzfhnYeTTu2UtxY531guWUTY8=;
 b=I8Vv7MJAX7rQFgiKGMYk1g7/sEZHbS4d1/fXraXxnGhVFPoUj9wRARj6OjO7QAMkBb
 kWRvHSLyBen6ExPa7yYFyl2mnQx/VAZUVSqaK5jzywoPLqSUUyFjAqdiVU8ycfDPUIdX
 82Y8SfuKJtYAOfdIEFtoYgZ1E13Qk77MtUhH/RLYLNXDEi7PnN27wDn4g0LJ+VhwRw4r
 rDnUb2dntXwYL+W2JMJVjilUnyG0bKQui5DK6Yv1ohAJsPUOot4uA5zJVLLtVvabKpG1
 8py+3x2TzqylMGYxX8/hO5u3wxO4L08umrDCttQozgK+egQceoDhW2Pvtxn7P2PO/BS3
 RVUA==
X-Gm-Message-State: AOJu0YxxOKf446CrP9KxJ/u+P+09/yFnv0Ad8rbtxt/hSRaXciMYeBgj
 tgiLruT9l4YvtbKWes4LFbxhPCkFhQVeY3QEv8bQu6RaYAENZabXOUO8rLHyV9xRvGGFvhsXaUs
 YxtVaL4I17k8J8yXqvkh3UFzxQwk=
X-Google-Smtp-Source: AGHT+IE51s+DshBrhie/b26WeJiqNIKaccK5DvoN82vU3BV7S7S+cpgyEXhu6vu0Ar1zwsDPJ8FiFAxbFq0/H6aYWT4=
X-Received: by 2002:a05:622a:2c5:b0:458:4d55:fdf7 with SMTP id
 d75a77b69052e-4604bc38e77mr201595021cf.40.1728914269935; Mon, 14 Oct 2024
 06:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241010101838.331032-1-r.peniaev@gmail.com>
 <20241010101838.331032-2-r.peniaev@gmail.com>
In-Reply-To: <20241010101838.331032-2-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 14 Oct 2024 17:57:37 +0400
Message-ID: <CAJ+F1CJ1ymDa3+R88RL8BF+fi=MwwrEd6_0s6-eG1S=LxZn9yw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] chardev/char: rename `char-mux.c` to
 `char-mux-fe.c`
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e82205062470383b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x835.google.com
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

--000000000000e82205062470383b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Thu, Oct 10, 2024 at 2:21=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:

> In the following patches backend multiplexer will be
> introduced and the implementation will be named as
> follows: `char-mux-be.c`. This patch renames the
> frontend multiplexer from `char-mux.c` to
> `char-mux-fe.c`.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org


thanks, it looks like the series is missing a cover letter (and thus not
handled by patchew)

Also it seems to fail to apply on master, and I wonder if it will conflict
with your other mux cleanup series.

thanks

>
> ---
>  chardev/{char-mux.c =3D> char-mux-fe.c} | 0
>  chardev/meson.build                   | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename chardev/{char-mux.c =3D> char-mux-fe.c} (100%)
>
> diff --git a/chardev/char-mux.c b/chardev/char-mux-fe.c
> similarity index 100%
> rename from chardev/char-mux.c
> rename to chardev/char-mux-fe.c
> diff --git a/chardev/meson.build b/chardev/meson.build
> index 70070a8279a9..778444a00ca6 100644
> --- a/chardev/meson.build
> +++ b/chardev/meson.build
> @@ -2,7 +2,7 @@ chardev_ss.add(files(
>    'char-fe.c',
>    'char-file.c',
>    'char-io.c',
> -  'char-mux.c',
> +  'char-mux-fe.c',
>    'char-null.c',
>    'char-pipe.c',
>    'char-ringbuf.c',
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000e82205062470383b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Roman,<br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 10, 2024 at 2:21=
=E2=80=AFPM Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com">r.peni=
aev@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">In the following patches backend multiplexer will be<br>
introduced and the implementation will be named as<br>
follows: `char-mux-be.c`. This patch renames the<br>
frontend multiplexer from `char-mux.c` to<br>
`char-mux-fe.c`.<br>
<br>
Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" tar=
get=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a></blockquote><div><br></div><div>thanks, it looks like the ser=
ies is missing a cover letter (and thus not handled by patchew)</div><div><=
br></div><div>Also it seems to fail to apply on master, and I wonder if it =
will conflict with your other mux cleanup series.</div><div><br></div><div>=
thanks <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
---<br>
=C2=A0chardev/{char-mux.c =3D&gt; char-mux-fe.c} | 0<br>
=C2=A0chardev/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A02 files changed, 1 insertion(+), 1 deletion(-)<br>
=C2=A0rename chardev/{char-mux.c =3D&gt; char-mux-fe.c} (100%)<br>
<br>
diff --git a/chardev/char-mux.c b/chardev/char-mux-fe.c<br>
similarity index 100%<br>
rename from chardev/char-mux.c<br>
rename to chardev/char-mux-fe.c<br>
diff --git a/chardev/meson.build b/chardev/meson.build<br>
index 70070a8279a9..778444a00ca6 100644<br>
--- a/chardev/meson.build<br>
+++ b/chardev/meson.build<br>
@@ -2,7 +2,7 @@ chardev_ss.add(files(<br>
=C2=A0 =C2=A0&#39;char-fe.c&#39;,<br>
=C2=A0 =C2=A0&#39;char-file.c&#39;,<br>
=C2=A0 =C2=A0&#39;char-io.c&#39;,<br>
-=C2=A0 &#39;char-mux.c&#39;,<br>
+=C2=A0 &#39;char-mux-fe.c&#39;,<br>
=C2=A0 =C2=A0&#39;char-null.c&#39;,<br>
=C2=A0 =C2=A0&#39;char-pipe.c&#39;,<br>
=C2=A0 =C2=A0&#39;char-ringbuf.c&#39;,<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000e82205062470383b--

