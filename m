Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD1CC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 16:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCLMb-0005Q0-4H; Tue, 06 May 2025 12:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCLMa-0005Po-6W
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:41:48 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCLMY-0003MD-10
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:41:47 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30572effb26so5657328a91.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746549704; x=1747154504; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/NiHJfZrcq1dTjmU222FRN4WCRJvi9LJdKL4xEXJc3k=;
 b=dJv+/NvZ4My9I4OqVXuE4bgDYta0t0LAF/vtH9CzJI8UigBiz1pXqju3dI/SKYeKpI
 ZYJHwFYJmeFX7XSFbR3D5ewkK928zv7ijtBWLQdiITKmx/Zc8pVCy6WOT4SXTuDDe9h2
 BYQOklveyzghp/CaHXSKAChcbMgmqEpoIekH7ufBPbjC+5P30RDHnaVHhdlVduF42NlF
 Xxi8ExMLag8SGycjIj9MRkNkl3Z8iD+KiCLGhQVroNa5F32wnB0EPfJyD117toxdj/y1
 w9VGGXQNeGsCze7ctzt6F63n5mTiHboJu0g8fRF4xxGclL6cdwycsTj//MJ21VAFOEpe
 5ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746549704; x=1747154504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/NiHJfZrcq1dTjmU222FRN4WCRJvi9LJdKL4xEXJc3k=;
 b=PU51LH4Kwq/FPiKgl+evh72zZ/tPB5p47O+b1atA3SU142+c1HCtKONCNQ43lbde0w
 mqBtFONwxRnVtpW5fxBJhijDuadY5kNVgqJflkEMWjQKOKAnwhUfEsbCBKfAmksFrnyL
 Eg8WSABUrBg9emb4Sq6ku4inqmjKACBgIERnvCAtmhDec65EFdixvq8eERq/CTkCvz4V
 9DGuIdvvuBE6qcbuDE0onvxS6mIytscdVGtz9V0AKWcMQaysOmAsvTRvauZcVnozmhWd
 PyvyfBJbvdtpe9rfnUoC0Tm4HuvD8TtlB60t3lIwQntfEnNEzBlu+LgmBvVIz8PGosAZ
 JoUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGyr7Ay1HC/IshjBnomqwlUn1z0+KXQbnbrRhp3zyzb90UW2aHleaZqC9rziLBgF7uUK8UCnhGfR+1@nongnu.org
X-Gm-Message-State: AOJu0YzQGfgwNntCshIRpmVokrCVRE88Ueh6TupEKKIRWlgfcrPyAfr5
 1Kzm8xQb+KjppIHyCpygtDNFjC2+rN3w1pNmT1BHxJ5GQQYN4MaRM5fhM8J2wHdow2+Fy9UjahP
 +izavmPIZ3bPjIlZT8oLdC46Ljjc=
X-Gm-Gg: ASbGncvVrM9jkaxCYrk0ey2I9NOIKAVxlvz7L++3F1Di4T2uHG3/uIqcQEGIIIBqxb4
 7nbxBwypPGAoR45BUWh2o4H+3Xi/9mREmJB6KR1Zi5Y7pHt8DNXnIf9KRKr/VCDMopFuJEtL3nB
 D3qIaKsvhGnncodnRCj+AOQFIFq/kJydwY9IlUhtRj9g==
X-Google-Smtp-Source: AGHT+IE2MIuL0OQU8CQr4/MrCzOBj6k4fhD3ZN/lCt9I05GgISGibVLqS0WZ7IQatyW2tPbXtR8NXqKcqLSHpoty5lI=
X-Received: by 2002:a17:90b:2887:b0:2f6:d266:f462 with SMTP id
 98e67ed59e1d1-30aac2b5ecdmr132248a91.35.1746549704359; Tue, 06 May 2025
 09:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <CACkyd_bN=zx1LaLnrg-U35--jzF3Q3BA6ABBokQZjLznaHcjFg@mail.gmail.com>
 <aBo6rDsbZGOfWfLP@redhat.com>
In-Reply-To: <aBo6rDsbZGOfWfLP@redhat.com>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Tue, 6 May 2025 19:41:32 +0300
X-Gm-Features: ATxdqUGyaBLzHpLgOIjcgHTdD9iVF7qyz2ladZxgpr0dfF7RiNW9pPJ-c3RDoEM
Message-ID: <CACkyd_YNXivoXE3PFNmK_5QCRQV83JZRf9NUEU+0yM4FOgM4fg@mail.gmail.com>
Subject: Re: [PATCH v2] util/memfd: allow allocating 0 bytes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b603c106347a4a82"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=just4now666666@gmail.com; helo=mail-pj1-x1031.google.com
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

--000000000000b603c106347a4a82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gave an example for a case where QEMU would try to allocate 0 bytes thus
fail here in the original version of the patch.

> As I mentioned earlier, let's say you don't initialize the vertical
display end registers, and set the minimum scanline register, the emulation
will then have to allocate some display buffer, but because the vertical
display end is initilized as 0 the buffer will be empty and the program
break.

I have no idea as for why my emails are getting messed up... :/

Have to go now, will try and send it again tomorrow probably...

On Tue, May 6, 2025, 19:37 Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:

> On Tue, May 06, 2025 at 07:17:25PM +0300, Elisha Hollander wrote:
> > Sorry for former patch something is messed up with my email.
>
> The commit message needs to explain what problem is being solved by
> making this change as allowing 0 bytes looks dubious on the surface.
>
> >
> > Signed-off-by: donno2048 <just4now666666@gmail.com>
> > ---
> >  util/memfd.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/util/memfd.c b/util/memfd.c
> > index 8a2e906..e96e5af 100644
> > --- a/util/memfd.c
> > +++ b/util/memfd.c
> > @@ -108,7 +108,7 @@ err:
> >  void *qemu_memfd_alloc(const char *name, size_t size, unsigned int
> seals,
> >                         int *fd, Error **errp)
> >  {
> > - void *ptr;
> > + void *ptr =3D NULL;
> >      int mfd =3D qemu_memfd_create(name, size, false, 0, seals, NULL);
> >
> >      /* some systems have memfd without sealing */
> > @@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t
> size,
> > unsigned int seals,
> >          }
> >      }
> >
> > - ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> > - if (ptr =3D=3D MAP_FAILED) {
> > - goto err;
> > + if (size !=3D 0) {
> > + ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> > + if (ptr =3D=3D MAP_FAILED) {
> > + goto err;
> > + }
> >      }
>
> This patch is mangled.
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000b603c106347a4a82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><p dir=3D"ltr">Gave an example for a case where QEMU woul=
d try to allocate 0 bytes thus fail here in the original version of the pat=
ch.</p><p dir=3D"ltr">&gt; As I mentioned earlier, let&#39;s say you don&#3=
9;t initialize the vertical display end registers, and set the minimum scan=
line register, the emulation will then have to allocate some display buffer=
, but because the vertical display end is initilized as 0 the buffer will b=
e empty and the program break.</p><p dir=3D"ltr">I have no idea as for why =
my emails are getting messed up... :/</p><p dir=3D"ltr">Have to go now, wil=
l try and send it again tomorrow probably...</p></div>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue=
, May 6, 2025, 19:37 Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange=
@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, May 06, 2025 at 0=
7:17:25PM +0300, Elisha Hollander wrote:<br>
&gt; Sorry for former patch something is messed up with my email.<br>
<br>
The commit message needs to explain what problem is being solved by<br>
making this change as allowing 0 bytes looks dubious on the surface.<br>
<br>
&gt; <br>
&gt; Signed-off-by: donno2048 &lt;<a href=3D"mailto:just4now666666@gmail.co=
m" rel=3D"noreferrer noreferrer" target=3D"_blank">just4now666666@gmail.com=
</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 util/memfd.c | 10 ++++++----<br>
&gt;=C2=A0 1 file changed, 6 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/util/memfd.c b/util/memfd.c<br>
&gt; index 8a2e906..e96e5af 100644<br>
&gt; --- a/util/memfd.c<br>
&gt; +++ b/util/memfd.c<br>
&gt; @@ -108,7 +108,7 @@ err:<br>
&gt;=C2=A0 void *qemu_memfd_alloc(const char *name, size_t size, unsigned i=
nt seals,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0int *fd, Error **errp)<br>
&gt;=C2=A0 {<br>
&gt; - void *ptr;<br>
&gt; + void *ptr =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mfd =3D qemu_memfd_create(name, size, false, 0=
, seals, NULL);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* some systems have memfd without sealing */<br>
&gt; @@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t s=
ize,<br>
&gt; unsigned int seals,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; - ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);<b=
r>
&gt; - if (ptr =3D=3D MAP_FAILED) {<br>
&gt; - goto err;<br>
&gt; + if (size !=3D 0) {<br>
&gt; + ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);<b=
r>
&gt; + if (ptr =3D=3D MAP_FAILED) {<br>
&gt; + goto err;<br>
&gt; + }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
This patch is mangled.<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer noreferrer=
" target=3D"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =
=C2=A0 <a href=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferre=
r noreferrer noreferrer" target=3D"_blank">https://www.flickr.com/photos/db=
errange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer noreferrer"=
 target=3D"_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-o-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138=
.berrange.com" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">h=
ttps://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer nore=
ferrer" target=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=
=C2=A0 =C2=A0 <a href=3D"https://www.instagram.com/dberrange" rel=3D"norefe=
rrer noreferrer noreferrer" target=3D"_blank">https://www.instagram.com/dbe=
rrange</a> :|<br>
<br>
</blockquote></div>

--000000000000b603c106347a4a82--

