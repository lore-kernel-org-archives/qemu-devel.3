Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF44C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 07:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCEAg-0001Nv-Ul; Wed, 29 May 2024 03:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sCEAf-0001Ni-HS; Wed, 29 May 2024 03:56:29 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sCEAd-0001iQ-GH; Wed, 29 May 2024 03:56:28 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f8cd25ebd5so727368a34.1; 
 Wed, 29 May 2024 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716969385; x=1717574185; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qCDc0qSIrx+gT7/2fYqupgGbWDRahVb7zLFLhhmMUDY=;
 b=eh9TcBTwvsx8+E+75yLXrbdoWYFWu63bd7F9rjeFyB7n/uOw6/MDhk6mhwO+1S0fqW
 614T+iAtB0LQwdNwlQemNfzaTGEtnmCG6gkm0jY+UlHrRvM+jxk7YikyrOFJ7LAlkN6G
 7OBZ/jXWqIan17QpzCPl9pIL9Wa16GsUimyivgn2/Q6trPZwyZdHx1cRacsp4qsoVOjz
 ngizM+EC79xNyVWyz7mafrB2Fg3b/suOHKyflY31f2nyjp6CpTOUlrv0xoiTlBLTAHIK
 jdmiQIjU/uZ577Sd5MQTVqG8ptBigaDK8PCnBz3nj0ul0Yr87HNuM45WqXvraen53zcv
 Yn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716969385; x=1717574185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qCDc0qSIrx+gT7/2fYqupgGbWDRahVb7zLFLhhmMUDY=;
 b=r5JGtKVwoqzedmcsB7zYXAqbJCHb4Pg3OGscA2P9PDPjyxR/m1FWW57opm9MBnPywc
 m0WV2US8zlS/qk5EICeuC87dk29HuY3/D776jP8MeVHnxQv8UwvpIqWWgbaLrfWanJ5V
 SR05t2YUY82Is8GgM852Hvi1WAQGc83X82JFhyOCLP8Z4WdLjXnXOV98BGBj7je48j3U
 t3nUMIfgHVFJesAYzxttW6K+yETSIjO2gWSlRjiP8eZHuKh5D6i4CUEuK6Hrgy/5Ybtp
 yWuJwskLfpL2B9BMeFdHGA78bcpuOTyGk/GFbUmVLvlTsQl4pMttwH+UNnuH2kOiGIF/
 1KIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnaNUqOjHy4yf/Wv03/iRJzIxGsXAUYW9AOGp7YiVOkMdlYm18Q/2i/wMOTLmYc8ieCBK0SrFo47M0aVVlAKsIjDd0K8xy7w==
X-Gm-Message-State: AOJu0YwuAJsid42Z9NXVj2qWES6OhIr2gJYu3WRFbvoghp18oLrY60Uz
 eiqlu2gKgclxkMA3HeMsTpLx4eVYcydsiC34v6NfrDdrOvWo/WmFSmNQOuAn/wR0jt/reBFTuK2
 y/meA9YqZ/bW/iL/CvjcmFedvthmDLEUJ
X-Google-Smtp-Source: AGHT+IEW3pHZ5PPPpE/CMFk51jXTjX4t7+ixwZgJJd9rcCK5Yr0cOre1Jyznv/NedrZoi35Dv085UsJiiRpuqISf8pM=
X-Received: by 2002:a05:6870:818e:b0:24f:d448:c97a with SMTP id
 586e51a60fabf-24fd448cae1mr10707167fac.42.1716969385120; Wed, 29 May 2024
 00:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240423152438.19841-2-mvogt@redhat.com>
In-Reply-To: <20240423152438.19841-2-mvogt@redhat.com>
From: Michael Vogt <michael.vogt@gmail.com>
Date: Wed, 29 May 2024 09:56:14 +0200
Message-ID: <CAPOxN2FyxFp+BJzgFa=EkxDkrctBg5TZWWW1x7r0tKONLHJ7Jg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Add ioctl for BLKBSZSET
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: Michael Vogt <mvogt@redhat.com>, qemu-trivial@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004a5bb30619931669"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=michael.vogt@gmail.com; helo=mail-ot1-x332.google.com
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

--0000000000004a5bb30619931669
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping

I tested the patch as part of cross architecture build (using qemu-user)
with bootc-image-builder in
https://github.com/osbuild/bootc-image-builder/pull/342 (not sure that is
relevant, but I wanted to mention that it is working for my test-case).

On Tue, Apr 23, 2024 at 5:25=E2=80=AFPM Michael Vogt <michael.vogt@gmail.co=
m> wrote:

> Tiny patch to add the ioctl wrapper definition for BLKBSZSET.
>
> Signed-off-by: Michael Vogt <mvogt@redhat.com>
> ---
>  linux-user/ioctls.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index d508d0c04a..3b41128fd7 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -102,6 +102,7 @@
>       IOCTL(BLKRAGET, IOC_R, MK_PTR(TYPE_LONG))
>       IOCTL(BLKSSZGET, IOC_R, MK_PTR(TYPE_INT))
>       IOCTL(BLKBSZGET, IOC_R, MK_PTR(TYPE_INT))
> +     IOCTL(BLKBSZSET, IOC_W, MK_PTR(TYPE_INT))
>       IOCTL_SPECIAL(BLKPG, IOC_W, do_ioctl_blkpg,
>                     MK_PTR(MK_STRUCT(STRUCT_blkpg_ioctl_arg)))
>
> --
> 2.43.0
>
>

--0000000000004a5bb30619931669
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Friendly ping</div><div><br></div><div>I tested the p=
atch as part of cross architecture build (using qemu-user) with bootc-image=
-builder in <a href=3D"https://github.com/osbuild/bootc-image-builder/pull/=
342">https://github.com/osbuild/bootc-image-builder/pull/342</a> (not sure =
that is relevant, but I wanted to mention that it is working for my test-ca=
se).</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Tue, Apr 23, 2024 at 5:25=E2=80=AFPM Michael Vogt &lt;<a href=
=3D"mailto:michael.vogt@gmail.com">michael.vogt@gmail.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Tiny patch to add =
the ioctl wrapper definition for BLKBSZSET.<br>
<br>
Signed-off-by: Michael Vogt &lt;<a href=3D"mailto:mvogt@redhat.com" target=
=3D"_blank">mvogt@redhat.com</a>&gt;<br>
---<br>
=C2=A0linux-user/ioctls.h | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h<br>
index d508d0c04a..3b41128fd7 100644<br>
--- a/linux-user/ioctls.h<br>
+++ b/linux-user/ioctls.h<br>
@@ -102,6 +102,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 IOCTL(BLKRAGET, IOC_R, MK_PTR(TYPE_LONG))<br>
=C2=A0 =C2=A0 =C2=A0 IOCTL(BLKSSZGET, IOC_R, MK_PTR(TYPE_INT))<br>
=C2=A0 =C2=A0 =C2=A0 IOCTL(BLKBSZGET, IOC_R, MK_PTR(TYPE_INT))<br>
+=C2=A0 =C2=A0 =C2=A0IOCTL(BLKBSZSET, IOC_W, MK_PTR(TYPE_INT))<br>
=C2=A0 =C2=A0 =C2=A0 IOCTL_SPECIAL(BLKPG, IOC_W, do_ioctl_blkpg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MK_PT=
R(MK_STRUCT(STRUCT_blkpg_ioctl_arg)))<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000004a5bb30619931669--

