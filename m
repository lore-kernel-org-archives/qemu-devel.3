Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32EDC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 15:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBy2E-0004qe-Lj; Mon, 05 May 2025 11:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uBy2D-0004qQ-GR
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:47:13 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uBy2B-0003Nx-W2
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:47:13 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b0db0b6a677so4404625a12.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746460029; x=1747064829; darn=nongnu.org;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aJwo5ihlCf2/0azgSaDsT7cTIQ09gLWPDfaj9PyZek4=;
 b=YJ7sCjdp4oRp7jDg92Es63DMLFA47io4F1aC985g9vGoeMz+Tt841Y8yZyb0Zjc9bV
 PkhLy+nx0iNdPQQtW1L9A6xVLgYrkwFLQq0RLdgjhIPid4x2jPOGCcinMk+hS+mGrV6v
 wKFgNXA3wtY7YWfEKkdpJQWicUkQX9AhgpQVSTA1NJYpwcG269LqW4yv/lXjmnpDQB3C
 9+w9kbWgpPQCK9M9t56gz4gg6yaJGlZly5bKcU1Guu/dgUdD5tMmQ/sMmzaAFXIx3G2n
 gBlIVvWigdsTYngx7ZN7pP/MulOrNg+PpZFZ1/WGsHDeVTnfbTQYhRHxSUPVnF8gUzUK
 WeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746460029; x=1747064829;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aJwo5ihlCf2/0azgSaDsT7cTIQ09gLWPDfaj9PyZek4=;
 b=CGgwnUDehXm6HJpGiIYapjs1r4Qp/D1IxVFu99DpCriHQBYsdHAEt6HQVNz+p23VVq
 Ft4ml+DWP4cNxONHW/CPDGt+2Fk/Z1PEdyLjZdYSduNC4QRfW3/T6q0CcWZz6B9U90jP
 Fh5e2uAAYNz5cW+aZJjr/HQSL8o4DYvQEkHm/TFqzn1GvJuonjSygLoXs0nbPXr+puc+
 RV4b0j2gqnrtw+g16mwN1+DzipT7AQCD13Eb/kKD2nTupAVNfRx2j115w5SzNxRfzD7e
 K1L6wD7UEVjmVXHWpsi+ziTrOXUpUTNeRScN9pTec8v+FqiPzdjIwQVLu3+jq0b5tIgm
 U2Ow==
X-Gm-Message-State: AOJu0YzF/2H9DjI7e9xNK6Iq5V9F7RSy88oXpsWz27V1hJVt1WwLakD7
 xbhLDaofIGg/3+D0ybkB7Hp4aEGYofR+GShiZSUEcLPZGNziu+jBSgq5+7uCHCW7NO5RwldWZGu
 8JWjuNGS2SxXhdvHeV9olAWnKfOYO+GFiuNU=
X-Gm-Gg: ASbGnctofZt/blAbXMLz6zee4gNkbPYy1SnjiY2LZZkF0BqovcbIxJzgloxHZQpKH7U
 8X/uuaFHk74O5ATY+Hrarr/WD6zha7IhtcPhiFByWE/pEeeJ1/0TKMvAuceb9DPfCKmbaZ8XI+b
 R0S4zzgIMFRj2BD6dxYjKEuUV8I1o5XurzMQXAyxPRrA==
X-Google-Smtp-Source: AGHT+IEHtjsv6GN0p8pwoz66vcoepeQFLFMojkwdIyIjzVOP16Ehh2QSzyDBVMageOsr229NnWuNZFrKBMTfZW0cnpE=
X-Received: by 2002:a17:90b:4ec7:b0:309:e351:2e3d with SMTP id
 98e67ed59e1d1-30a5ae132e5mr17831174a91.12.1746460029305; Mon, 05 May 2025
 08:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250326161927.15572-1-just4now666666@gmail.com>
In-Reply-To: <20250326161927.15572-1-just4now666666@gmail.com>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 5 May 2025 18:46:57 +0300
X-Gm-Features: ATxdqUFqAS6n3DpZrs9q8xawGLyFW-kT9fky2zC2Ruh-1NGYVnag5jZ_evjl00o
Message-ID: <CACkyd_aAtKE9jta0rdBJ3orBejTJ-ErmM0zyVoxCDux+vj9vcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/memfd: allow allocating 0 bytes
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a944f206346569ea"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=just4now666666@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, MALFORMED_FREEMAIL=2.16,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000a944f206346569ea
Content-Type: text/plain; charset="UTF-8"

ping

On Wed, Mar 26, 2025, 18:20 donno2048 <just4now666666@gmail.com> wrote:

> This silently fixes issues resulting from trying to allocate 0 bytes.
>
> Fixes error, for example, for writing byte 0x20 to port 0x3c0, then word
> 0xf09 to port 0x3b4 when CPU is initiated, which shouldn't break.
>
> Signed-off-by: donno2048 <just4now666666@gmail.com>
> ---
>  util/memfd.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/util/memfd.c b/util/memfd.c
> index 07beab174d..4f2c4ea1dd 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -131,9 +131,13 @@ void *qemu_memfd_alloc(const char *name, size_t size,
> unsigned int seals,
>          }
>      }
>
> -    ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> -    if (ptr == MAP_FAILED) {
> -        goto err;
> +    if (size != 0) {
> +        ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> +        if (ptr == MAP_FAILED) {
> +            goto err;
> +        }
> +    } else {
> +        ptr = fdopen(mfd, "rw");
>      }
>
>      *fd = mfd;
> --
> 2.30.2
>
>

--000000000000a944f206346569ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><p dir=3D"ltr">ping</p></div>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed=
, Mar 26, 2025, 18:20 donno2048 &lt;<a href=3D"mailto:just4now666666@gmail.=
com" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">This silently fixes issues r=
esulting from trying to allocate 0 bytes.<br>
<br>
Fixes error, for example, for writing byte 0x20 to port 0x3c0, then word 0x=
f09 to port 0x3b4 when CPU is initiated, which shouldn&#39;t break.<br>
<br>
Signed-off-by: donno2048 &lt;<a href=3D"mailto:just4now666666@gmail.com" re=
l=3D"noreferrer noreferrer" target=3D"_blank">just4now666666@gmail.com</a>&=
gt;<br>
---<br>
=C2=A0util/memfd.c | 10 +++++++---<br>
=C2=A01 file changed, 7 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/util/memfd.c b/util/memfd.c<br>
index 07beab174d..4f2c4ea1dd 100644<br>
--- a/util/memfd.c<br>
+++ b/util/memfd.c<br>
@@ -131,9 +131,13 @@ void *qemu_memfd_alloc(const char *name, size_t size, =
unsigned int seals,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mf=
d, 0);<br>
-=C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 if (size !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, =
MAP_SHARED, mfd, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D fdopen(mfd, &quot;rw&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0*fd =3D mfd;<br>
-- <br>
2.30.2<br>
<br>
</blockquote></div>

--000000000000a944f206346569ea--

