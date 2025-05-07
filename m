Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B165C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCh3I-0003Rn-Pr; Wed, 07 May 2025 11:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCh3G-0003RG-3m
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:51:18 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCh3C-0002Kn-HY
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:51:17 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30a93d80a80so55732a91.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746633073; x=1747237873; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Auu6VpXNiN6VQwL5R2mKiik9jQE5wEHtNA5i0RssprQ=;
 b=WY59daa/1rM4kQnjgY8HLqQYgyWHIvjYd1ec/IobMEZKCv8SbGz/SrQjnTRvCDgset
 eXEuNFkbt423Utx+FUhHbH4nod5UQ5Q5i+nxrZrPG1JFS6tTFBN/Dx3SZPOjX1O491hA
 LSaBRa7EMUG3SQhfc7uDslKhechnmyzxVAkIkXqCSf8Q8kjbpRcY3+vsOAX1mXSRFS/Z
 7hQKnvEaUCUP9INw8+Kw2jDKr2cTeBELY5EJyFllEjsaNQaNISqqk8Au+tKZRzztGosw
 2tZMJ/9LT5S9EEfiWZiuZ53VJb9nRxHulw5+aYqXmbDo/fs7jvdM6CCHLw0rrVDfLhp7
 3Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746633073; x=1747237873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Auu6VpXNiN6VQwL5R2mKiik9jQE5wEHtNA5i0RssprQ=;
 b=JytOuA1ZLO54qiJYs0ntbn39MTQwd4lb9Wx1qQkt+LCmPNbecOUzFKVkgQGJ5EkmhB
 VttohmGjw7pfo7OoUShQ5yo8wRUHy9v2RwadF+F6Ju6HUDN+zNGfeyLh8Drt4fWLhchl
 z3BqfR29deMPm28+1NqTmfjrDsu6g6gPUtZ47WlxXbnoznGBewhCnQAScWRfhLUa2ztJ
 BSkwufOYy9Lnt9aO2Wt8qQz26jQocB1yIJetqlr5TGUlGXCzybHdXA8zu6De9V33FzO4
 WcwTpBcwWQSNUGlxAJArB8ZvDDFtq0cVIzvvzm20GOk9E5t4xPUuvMoUEfPR+/uyDmhC
 8vzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSbrgpqB98pVir5A+p2kOziniPSMlOfEE/KWVm0cio1c+69L5dR7IcyfBBmaQIjMfiO1Dtd38QAqCY@nongnu.org
X-Gm-Message-State: AOJu0YxbLj0WojZZ+ZUAtvI1U95Ge2eYBxGibiME+NVMzLxgGdKWKOnI
 s6QJkBlVEFmkQkP+X79DVQKrrtfqUiUyT/tK93nJFXFo3PvFGy0BkKIgsOTU4VdAdUebQrVfBe3
 Hfiompl/ZXOO/Y5KrdS82NcqIRsc=
X-Gm-Gg: ASbGncsF6UnU4KX2z2kKqsVaViT7Bwil/dxaXlzS1bCztvY0fHWzkDVHLWlngZH6nzU
 ETwuhNqC8ArQeF7hjD6nwW4EUQmnkLIQ1sq3uRSWbFxDlKSvlwuobgzdGP+1ejfKE6zY4M1jYZ8
 HPQqK2U3VHhk5Ut8xqzKaOMXUCJXsuw+XdSXOcSmI=
X-Google-Smtp-Source: AGHT+IEl82pYQVLbxJfAIGI0x0s89tYWscOOO6IDuhUqAG5V1tPO9I292eMLGikYTvQmBMnoD7wKpqp5n5F6aywVI2M=
X-Received: by 2002:a17:90b:3e83:b0:2ee:d433:7c50 with SMTP id
 98e67ed59e1d1-30aac21f34dmr4665183a91.23.1746633072751; Wed, 07 May 2025
 08:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACkyd_aL_KAgG1FzoC+H+TpNm2KCvWq+35HMUsVaBKWThNSBNQ@mail.gmail.com>
 <0dc12168-6742-4c39-ae5c-4a703cd83dde@linaro.org>
In-Reply-To: <0dc12168-6742-4c39-ae5c-4a703cd83dde@linaro.org>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Wed, 7 May 2025 18:51:00 +0300
X-Gm-Features: ATxdqUFm1CZjiTgMT-CM1M6w3tIG97M_BR-fQPhpQmzPFPQdMyQTzm_GydMRfIc
Message-ID: <CACkyd_ZYssy9jJTpm-HExDOnNHgyVVswH9_D=2J2OsYF_vPH3A@mail.gmail.com>
Subject: Re: [PATCH v2] util/memfd: allow allocating 0 bytes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000dab73706348db338"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=just4now666666@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000dab73706348db338
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> "As I mentioned earlier": where?
> Otherwise this description will be of
> little relevance in 5 years from now in our history.

I explained the motivation on the first revision of the patch

On Wed, May 7, 2025, 14:58 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> =
wrote:

> Hi Elisha,
>
> On 6/5/25 18:44, Elisha Hollander wrote:
> >  > As I mentioned earlier, let's say you don't initialize the vertical
>
> "As I mentioned earlier": where? Otherwise this description will be of
> little relevance in 5 years from now in our history.
>
> > display end registers, and set the minimum scanline register, the
> > emulation will then have to allocate some display buffer, but because
> > the vertical display end is initilized as 0 the buffer will be empty an=
d
>
> Typo "initialized".
>
> > the program break.
> >
> > Signed-off-by: donno2048 <just4now666666@gmail.com
> > <mailto:just4now666666@gmail.com>>
> >
> > ---
> >   util/memfd.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/util/memfd.c b/util/memfd.c
> > index 8a2e906..e96e5af 100644
> > --- a/util/memfd.c
> > +++ b/util/memfd.c
> > @@ -108,7 +108,7 @@ err:
> >   void *qemu_memfd_alloc(const char *name, size_t size, unsigned int
> seals,
> >                          int *fd, Error **errp)
> >   {
> > -    void *ptr;
> > +    void *ptr =3D NULL;
> >       int mfd =3D qemu_memfd_create(name, size, false, 0, seals, NULL);
> >
> >       /* some systems have memfd without sealing */
> > @@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t
> > size, unsigned int seals,
> >           }
> >       }
> >
> > -    ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> > -    if (ptr =3D=3D MAP_FAILED) {
> > -        goto err;
> > +    if (size !=3D 0) {
> > +        ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd,=
 0);
> > +        if (ptr =3D=3D MAP_FAILED) {
> > +            goto err;
> > +        }
> >       }
> >
> >       *fd =3D mfd;
> > --
> > 2.30.2
>
> Alternatively always set *fd, removing the @err label:
>
> -- >8 --
> @@ -132,0 +133 @@ void *qemu_memfd_alloc(const char *name, size_t size,
> unsigned int seals,
> +    *fd =3D mfd;
> @@ -134,3 +135,2 @@ void *qemu_memfd_alloc(const char *name, size_t
> size, unsigned int seals,
> -    ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> -    if (ptr =3D=3D MAP_FAILED) {
> -        goto err;
> +    if (!size) {
> +        return NULL;
> @@ -139,2 +139,4 @@ void *qemu_memfd_alloc(const char *name, size_t
> size, unsigned int seals,
> -    *fd =3D mfd;
> -    return ptr;
> +    ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> +    if (ptr !=3D MAP_FAILED) {
> +        return ptr;
> +    }
> @@ -142 +143,0 @@ void *qemu_memfd_alloc(const char *name, size_t size,
> unsigned int seals,
> -err:
> ---
>
> Or more similar to your approach:
>
> -- >8 --
> @@ -111 +111 @@ void *qemu_memfd_alloc(const char *name, size_t size,
> unsigned int seals,
> -    void *ptr;
> +    void *ptr =3D NULL;
> @@ -134,5 +133,0 @@ void *qemu_memfd_alloc(const char *name, size_t
> size, unsigned int seals,
> -    ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> -    if (ptr =3D=3D MAP_FAILED) {
> -        goto err;
> -    }
> -
> @@ -140 +134,0 @@ void *qemu_memfd_alloc(const char *name, size_t size,
> unsigned int seals,
> -    return ptr;
> @@ -142,4 +136,2 @@ void *qemu_memfd_alloc(const char *name, size_t
> size, unsigned int seals,
> -err:
> -    error_setg_errno(errp, errno, "failed to allocate shared memory");
> -    if (mfd >=3D 0) {
> -        close(mfd);
> +    if (!size) {
> +        return NULL;
> @@ -147 +139,11 @@ err:
> -    return NULL;
> +
> +    if (size) {
> +        ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0=
);
> +        if (ptr =3D=3D MAP_FAILED) {
> +            error_setg_errno(errp, errno, "failed to allocate shared
> memory");
> +            if (mfd >=3D 0) {
> +                close(mfd);
> +            }
> +        }
> +    }
> +    return ptr;
> ---
>

--000000000000dab73706348db338
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">&gt; &quot;As I mentioned earlier&quot;: where?<br>
&gt; Otherwise this description will be of<br>
&gt; little relevance in 5 years from now in our history.</p>
<p dir=3D"ltr">I explained the motivation on the first revision of the patc=
h</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, May 7, 2025, 14:58 Philippe Mathieu-Daud=C3=A9 &lt;=
<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Hi Elisha,<br>
<br>
On 6/5/25 18:44, Elisha Hollander wrote:<br>
&gt;=C2=A0 &gt; As I mentioned earlier, let&#39;s say you don&#39;t initial=
ize the vertical <br>
<br>
&quot;As I mentioned earlier&quot;: where? Otherwise this description will =
be of<br>
little relevance in 5 years from now in our history.<br>
<br>
&gt; display end registers, and set the minimum scanline register, the <br>
&gt; emulation will then have to allocate some display buffer, but because =
<br>
&gt; the vertical display end is initilized as 0 the buffer will be empty a=
nd <br>
<br>
Typo &quot;initialized&quot;.<br>
<br>
&gt; the program break.<br>
&gt; <br>
&gt; Signed-off-by: donno2048 &lt;<a href=3D"mailto:just4now666666@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:just4now666666@gmail.com" target=3D"_blan=
k" rel=3D"noreferrer">just4now666666@gmail.com</a>&gt;&gt;<br>
&gt; <br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0util/memfd.c | 10 ++++++----<br>
&gt;=C2=A0 =C2=A01 file changed, 6 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/util/memfd.c b/util/memfd.c<br>
&gt; index 8a2e906..e96e5af 100644<br>
&gt; --- a/util/memfd.c<br>
&gt; +++ b/util/memfd.c<br>
&gt; @@ -108,7 +108,7 @@ err:<br>
&gt;=C2=A0 =C2=A0void *qemu_memfd_alloc(const char *name, size_t size, unsi=
gned int seals,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 int *fd, Error **errp)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 void *ptr;<br>
&gt; +=C2=A0 =C2=A0 void *ptr =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int mfd =3D qemu_memfd_create(name, size, fa=
lse, 0, seals, NULL);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* some systems have memfd without sealing *=
/<br>
&gt; @@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t <=
br>
&gt; size, unsigned int seals,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARE=
D, mfd, 0);<br>
&gt; -=C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 if (size !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | PROT_WR=
ITE, MAP_SHARED, mfd, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*fd =3D mfd;<br>
&gt; --<br>
&gt; 2.30.2<br>
<br>
Alternatively always set *fd, removing the @err label:<br>
<br>
-- &gt;8 --<br>
@@ -132,0 +133 @@ void *qemu_memfd_alloc(const char *name, size_t size, <br=
>
unsigned int seals,<br>
+=C2=A0 =C2=A0 *fd =3D mfd;<br>
@@ -134,3 +135,2 @@ void *qemu_memfd_alloc(const char *name, size_t <br>
size, unsigned int seals,<br>
-=C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mf=
d, 0);<br>
-=C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 if (!size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
@@ -139,2 +139,4 @@ void *qemu_memfd_alloc(const char *name, size_t <br>
size, unsigned int seals,<br>
-=C2=A0 =C2=A0 *fd =3D mfd;<br>
-=C2=A0 =C2=A0 return ptr;<br>
+=C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mf=
d, 0);<br>
+=C2=A0 =C2=A0 if (ptr !=3D MAP_FAILED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ptr;<br>
+=C2=A0 =C2=A0 }<br>
@@ -142 +143,0 @@ void *qemu_memfd_alloc(const char *name, size_t size, <br=
>
unsigned int seals,<br>
-err:<br>
---<br>
<br>
Or more similar to your approach:<br>
<br>
-- &gt;8 --<br>
@@ -111 +111 @@ void *qemu_memfd_alloc(const char *name, size_t size, <br>
unsigned int seals,<br>
-=C2=A0 =C2=A0 void *ptr;<br>
+=C2=A0 =C2=A0 void *ptr =3D NULL;<br>
@@ -134,5 +133,0 @@ void *qemu_memfd_alloc(const char *name, size_t <br>
size, unsigned int seals,<br>
-=C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mf=
d, 0);<br>
-=C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
@@ -140 +134,0 @@ void *qemu_memfd_alloc(const char *name, size_t size, <br=
>
unsigned int seals,<br>
-=C2=A0 =C2=A0 return ptr;<br>
@@ -142,4 +136,2 @@ void *qemu_memfd_alloc(const char *name, size_t <br>
size, unsigned int seals,<br>
-err:<br>
-=C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;failed to allocate share=
d memory&quot;);<br>
-=C2=A0 =C2=A0 if (mfd &gt;=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(mfd);<br>
+=C2=A0 =C2=A0 if (!size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
@@ -147 +139,11 @@ err:<br>
-=C2=A0 =C2=A0 return NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, =
MAP_SHARED, mfd, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;failed to allocate shared <br>
memory&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mfd &gt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(mfd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return ptr;<br>
---<br>
</blockquote></div>

--000000000000dab73706348db338--

