Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FE4C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 17:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqy3C-00052V-0H; Sat, 08 Mar 2025 12:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1tqy32-0004zE-DJ
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 12:33:17 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1tqy30-0006cb-ML
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 12:33:16 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fee4d9c2efso5035585a91.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 09:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1741455193; x=1742059993;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1lV/16lAA5aKQRfYNLXlCTa7y1dixzCA7JPqIOpAzTA=;
 b=K7dNWsxwvnbt75JFzxsa83/7OzidtyMJTeZLy0Ztvkql0Or9CgZkl6RMSS0C8QLE2N
 L3pm7WClb7NeNpaCNzj1aQ/nGygI+wZiLlyN72pEph14KLW/7W31y1p8wBS7oY7LbZ++
 kEkhFkcWSB2PSILS0ZG8BQugNcGODflr6ZdCcxap1XkPyyhG5G3pn9XVFQyr8Drb4hOG
 gWGkIS9njPqx/cAXpZg+oah5hlR2pozojiCZ0/1F5Xla/x1eeWotdiZIVDxY3oaoA4Xh
 yaRfZ3tz8LsdRexRsTJ0sqIIFmg9buVugK/zrxVvcO+0k7+PVo/rb1Auvuy1JqxZKENs
 Niqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741455193; x=1742059993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1lV/16lAA5aKQRfYNLXlCTa7y1dixzCA7JPqIOpAzTA=;
 b=IdJeWqe+R7bhsvWVONs68ALGPwE4n29WFeNARaJIHFjnVoIMVQE4WVO/kTEyC+OeE+
 bWrwffkLA5fYvlEHe5/0PNK3118LJdenjOVmUswkFN4d4xL9iKjCcPU3l5AaGRZOI6NB
 afJE5ySstLOCfnzXrfEDreSqYNE5nQdGBoY+rd6AapXOn9mOlUC8x8aA1MiQggtY8IYM
 zbwkpdx+oZxOaqWS+/WCvaGIl8h1VRGD6wAJc6YlgP+/8W02hIN4EonyqcN57jWXcF+O
 7jikibMEMM8AZuXkMGB7nFOcrXOCSxAFxA6pJllNDu2NfD8Z23umAGxzyMwCj3mPf6BQ
 i+rQ==
X-Gm-Message-State: AOJu0YxX9rvWI9xuTYBUI9rVOMQSWbLx9U9vczjZ43FErZzB4BktYwVM
 AikwN1bo9eBMRJiZvEQqWhvFgOdpgp0pz5rBh4ToCga8bGcD4fiqQWLn1HLVlnFCcFP4GKRwJor
 /GXAvidOuysbfCiyiJRw1BsTyTzUfFFEJdb71hg==
X-Gm-Gg: ASbGncsd9Njq8qeUu3aPnWsbYuXEC7ogWn3xpZpVTWO/1ihDr0wJ8dbBPq4Mv+VS7Dk
 ylW2jxzAwLwJbTg6bv51IeZ7/lytT52Re/W+NLWl9TRv2VjrA0ibY/SROV1sZltHMLt79yGLO6c
 3DfZEiIvIHzi/fJ24LK/8qLFf6r06Zis+oEXN/
X-Google-Smtp-Source: AGHT+IHisUYdw1a1ZQWDrxQo+qw3mKo23gTj1nzd06zExQPK8WkJ2ycRT3Ukytvz0lIH5iKVo2oQM+jBAVexnExsFYE=
X-Received: by 2002:a17:90b:4c8a:b0:2f6:d266:f45e with SMTP id
 98e67ed59e1d1-2ff7ce50364mr13015879a91.2.1741455192995; Sat, 08 Mar 2025
 09:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20250308122842.76377-1-philmd@linaro.org>
 <20250308122842.76377-2-philmd@linaro.org>
In-Reply-To: <20250308122842.76377-2-philmd@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 8 Mar 2025 10:33:02 -0700
X-Gm-Features: AQ5f1JrNFCWPze32CXIaeIeR1cADqvfDd3yYvJ6PnBB2AuZ8wTfo1VO_mXatN5I
Message-ID: <CANCZdfoe6ezPCb07mRyyEsv0GO1MJFDDaR4rGRW+cEJVmROcCA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] bsd-user: Always use mmap_find_vma_aligned() in
 target_mmap()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002bdb2f062fd82251"
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000002bdb2f062fd82251
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 5:28=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Massage target_mmap(): calculate alignment once, then
> unconditionally call mmap_find_vma_aligned().
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  bsd-user/mmap.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Here I get why you have a new variable since it's a  little easier to read.

Warner


> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 346f2cefd32..dfa6e728ab5 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -489,13 +489,12 @@ abi_long target_mmap(abi_ulong start, abi_ulong len=
,
> int prot,
>       * before we truncate the length for mapping files below.
>       */
>      if (!(flags & MAP_FIXED)) {
> +        abi_ulong alignment;
> +
>          host_len =3D len + offset - host_offset;
>          host_len =3D HOST_PAGE_ALIGN(host_len);
> -        if ((flags & MAP_ALIGNMENT_MASK) !=3D 0)
> -            start =3D mmap_find_vma_aligned(real_start, host_len,
> -                (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT);
> -        else
> -            start =3D mmap_find_vma(real_start, host_len);
> +        alignment =3D (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIF=
T;
> +        start =3D mmap_find_vma_aligned(real_start, host_len, alignment)=
;
>          if (start =3D=3D (abi_ulong)-1) {
>              errno =3D ENOMEM;
>              goto fail;
> --
> 2.47.1
>
>

--0000000000002bdb2f062fd82251
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 8, =
2025 at 5:28=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Massage target_mmap(): calculate alignme=
nt once, then<br>
unconditionally call mmap_find_vma_aligned().<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/mmap.c | 9 ++++-----<br>
=C2=A01 file changed, 4 insertions(+), 5 deletions(-)<br></blockquote><div>=
<br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.co=
m">imp@bsdimp.com</a>&gt;</div><div><br></div><div>Here I get why you have =
a new variable since it&#39;s a=C2=A0 little easier to read.</div><div><br>=
</div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>
index 346f2cefd32..dfa6e728ab5 100644<br>
--- a/bsd-user/mmap.c<br>
+++ b/bsd-user/mmap.c<br>
@@ -489,13 +489,12 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int prot,<br>
=C2=A0 =C2=A0 =C2=A0 * before we truncate the length for mapping files belo=
w.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (!(flags &amp; MAP_FIXED)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong alignment;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host_len =3D len + offset - host_offset;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host_len =3D HOST_PAGE_ALIGN(host_len);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((flags &amp; MAP_ALIGNMENT_MASK) !=3D 0)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D mmap_find_vma_aligned(=
real_start, host_len,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (flags &amp; MAP_A=
LIGNMENT_MASK) &gt;&gt; MAP_ALIGNMENT_SHIFT);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D mmap_find_vma(real_sta=
rt, host_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 alignment =3D (flags &amp; MAP_ALIGNMENT_MASK)=
 &gt;&gt; MAP_ALIGNMENT_SHIFT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D mmap_find_vma_aligned(real_start, ho=
st_len, alignment);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (start =3D=3D (abi_ulong)-1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENOMEM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
-- <br>
2.47.1<br>
<br>
</blockquote></div></div>

--0000000000002bdb2f062fd82251--

