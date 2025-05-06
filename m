Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8EAC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 22:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCQjb-0000lQ-QL; Tue, 06 May 2025 18:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCQja-0000lF-0T
 for qemu-devel@nongnu.org; Tue, 06 May 2025 18:25:54 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCQjU-0003Br-RB
 for qemu-devel@nongnu.org; Tue, 06 May 2025 18:25:53 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30a99e2bdd4so928692a91.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 15:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746570346; x=1747175146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fv+CNz3mxDOJVwkFRb8az82M1Na2/T3R5onkqF+M80Q=;
 b=MR7aCxL1CMyLvZGFHhILzrVxS9Q/wCf3xR77qb1AD2bRU342luLYisUB17m1k/bf/A
 Qf5UXVB4KWy1hYXqZ1G3TNjIccQ5SnhDAo5T/VeGoZcwz1kvJGvuuZazyqPRf9NchoNk
 Zu/i1Kj5DRoDa1fFPUIPWPkhvIAjPUpS9OJ6WzWmopSCiIrb0dy4KCZwbwQkpdxm5P94
 G6kfl26Oxf+9DkwjfEQeTVHxS1Lgb5iCWj4Nl+VNH2OTJXWAWUax6jU2F7nyoZR/JCC3
 ryn8hM4dbAJVRigjj7HYTUYRrjMsN0zcG/K1cNvTDColR3ZAtUrbDFeA+Z8vt7nehNmq
 HWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746570346; x=1747175146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fv+CNz3mxDOJVwkFRb8az82M1Na2/T3R5onkqF+M80Q=;
 b=ZQweaxSozHYgPd1XOikJkmB/c/Qlb8lzFsq/b9arICeFNOUNS0yn1lN0Seoy/VSHxA
 LFeGZxzjq46dWGImd3MaYqpjEscplMSQbaZatHkhW9Vy2xNBkJpVbjllL2vaPSYikq+w
 k8x3JuEvZwfGA5WJVP9oMEDCo4mwwrZD0xlO7+NWeIEgOyk63KTEi3AKqzEAAyXUu1Nl
 Cs7Azttcop8TbPZVjoILvvnH6Bm3Zne1N1/bOEP6adjO6bqSXI46pW8NS9EzoSx0Gdyv
 866b7mW4KU/BYlkhW/jmKpDxKVABUziFKV+qTuuYyXVTxzBxC4AlrS5F03zCBhkBQCtQ
 13zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8bSc2rSl6Vfu9eJoI2uluBowRMyTjKTmI19KEBwf8W5S4qaw46dOweuywjKdRn2emAylbbRAHU/t0@nongnu.org
X-Gm-Message-State: AOJu0YxqORdObzOCFe95pGLcBf7XhFSJbNG6tumWv+wG7GCek1jM4LsQ
 qNW09/WhPnQfqeWRK6Ha70E7P1N9+fDpUfa7GIgU79lH6dV6VBwhjd805ba2rn4uqrBLcPql2He
 SDy62u2tIKdAQICH981h18zo6xmE=
X-Gm-Gg: ASbGnctWVcE15bpyw5zhY4EYm+iHADhHOaqy2QAW9m5n3C4Mq055s37hRE4wTEvahVC
 fQCQJKCy9MTtS0qnFMk91hn5FCEgDHvmw4T8q+LtMazyLqv9yf/uyw2DOq2ynY12WmsOtz2O0mR
 ZI+at9MHqi7wno4r5oF6ydRB9jUxOf4a53azbjaa7QaA==
X-Google-Smtp-Source: AGHT+IFyq4MoUzAOjCMZ+FCdSz2EKN8R6XKxYr/AFOoI/v97wpKQaAaISWsph5L5BC3XHruRGYl6+LXfYBWcpJhlL3I=
X-Received: by 2002:a17:90b:4a51:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-30aac184d78mr1645183a91.5.1746570345516; Tue, 06 May 2025
 15:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <CACkyd_bN=zx1LaLnrg-U35--jzF3Q3BA6ABBokQZjLznaHcjFg@mail.gmail.com>
 <aBo6rDsbZGOfWfLP@redhat.com>
 <CACkyd_YNXivoXE3PFNmK_5QCRQV83JZRf9NUEU+0yM4FOgM4fg@mail.gmail.com>
 <aBo9Z4NjOReXwbni@redhat.com>
In-Reply-To: <aBo9Z4NjOReXwbni@redhat.com>
From: Elisha Hollander <just4now666666@gmail.com>
Date: Wed, 7 May 2025 01:25:34 +0300
X-Gm-Features: ATxdqUFc95BEkWAWz0PYxVLDPtlJP_k0Ag8SfFskLf0T6PUmBVuLln84RghiSys
Message-ID: <CACkyd_bWqaTFpxP22d37dX-gF+-+vbJCOeJpz_DMTd8Gh_H9zA@mail.gmail.com>
Subject: Re: [PATCH v2] util/memfd: allow allocating 0 bytes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000005117706347f19d3"
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

--00000000000005117706347f19d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maybe an assert is really more appropriate, but technically doing so on
actual hardware should run flawlessly so I think the emu should work too...
Maybe I'm wrong though

On Tue, May 6, 2025, 19:48 Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:

> On Tue, May 06, 2025 at 07:41:32PM +0300, Elisha Hollander wrote:
> > Gave an example for a case where QEMU would try to allocate 0 bytes thu=
s
> > fail here in the original version of the patch.
> >
> > > As I mentioned earlier, let's say you don't initialize the vertical
> > display end registers, and set the minimum scanline register, the
> emulation
> > will then have to allocate some display buffer, but because the vertica=
l
> > display end is initilized as 0 the buffer will be empty and the program
> > break.
>
> Isn't this an invalid hardware configuration that should be detected
> in the emulation code, and either force the display end to a minimum
> value, or trigger an assert ?
>
> Patching a bug in a specific HW impl, by changing the qemu_memfd_alloc
> code feels like it is probably the wrong place to address this.
>
> >
> > I have no idea as for why my emails are getting messed up... :/
> >
> > Have to go now, will try and send it again tomorrow probably...
> >
> > On Tue, May 6, 2025, 19:37 Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
> wrote:
> >
> > > On Tue, May 06, 2025 at 07:17:25PM +0300, Elisha Hollander wrote:
> > > > Sorry for former patch something is messed up with my email.
> > >
> > > The commit message needs to explain what problem is being solved by
> > > making this change as allowing 0 bytes looks dubious on the surface.
> > >
> > > >
> > > > Signed-off-by: donno2048 <just4now666666@gmail.com>
> > > > ---
> > > >  util/memfd.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/util/memfd.c b/util/memfd.c
> > > > index 8a2e906..e96e5af 100644
> > > > --- a/util/memfd.c
> > > > +++ b/util/memfd.c
> > > > @@ -108,7 +108,7 @@ err:
> > > >  void *qemu_memfd_alloc(const char *name, size_t size, unsigned int
> > > seals,
> > > >                         int *fd, Error **errp)
> > > >  {
> > > > - void *ptr;
> > > > + void *ptr =3D NULL;
> > > >      int mfd =3D qemu_memfd_create(name, size, false, 0, seals, NUL=
L);
> > > >
> > > >      /* some systems have memfd without sealing */
> > > > @@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_=
t
> > > size,
> > > > unsigned int seals,
> > > >          }
> > > >      }
> > > >
> > > > - ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0)=
;
> > > > - if (ptr =3D=3D MAP_FAILED) {
> > > > - goto err;
> > > > + if (size !=3D 0) {
> > > > + ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0)=
;
> > > > + if (ptr =3D=3D MAP_FAILED) {
> > > > + goto err;
> > > > + }
> > > >      }
> > >
> > > This patch is mangled.
> > >
> > >
> > > With regards,
> > > Daniel
> > > --
> > > |: https://berrange.com      -o-
> > > https://www.flickr.com/photos/dberrange :|
> > > |: https://libvirt.org         -o-
> > > https://fstop138.berrange.com :|
> > > |: https://entangle-photo.org    -o-
> > > https://www.instagram.com/dberrange :|
> > >
> > >
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

--00000000000005117706347f19d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Maybe an assert is really more appropriate, but technically =
doing so on actual hardware should run flawlessly so I think the emu should=
 work too... Maybe I&#39;m wrong though</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, May 6, 2025, 19:48 Daniel P. Berrang=C3=A9 &lt;<a h=
ref=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Tue, May 06, 2025 at 07:41:32PM +0300=
, Elisha Hollander wrote:<br>
&gt; Gave an example for a case where QEMU would try to allocate 0 bytes th=
us<br>
&gt; fail here in the original version of the patch.<br>
&gt; <br>
&gt; &gt; As I mentioned earlier, let&#39;s say you don&#39;t initialize th=
e vertical<br>
&gt; display end registers, and set the minimum scanline register, the emul=
ation<br>
&gt; will then have to allocate some display buffer, but because the vertic=
al<br>
&gt; display end is initilized as 0 the buffer will be empty and the progra=
m<br>
&gt; break.<br>
<br>
Isn&#39;t this an invalid hardware configuration that should be detected<br=
>
in the emulation code, and either force the display end to a minimum<br>
value, or trigger an assert ?<br>
<br>
Patching a bug in a specific HW impl, by changing the qemu_memfd_alloc<br>
code feels like it is probably the wrong place to address this.<br>
<br>
&gt; <br>
&gt; I have no idea as for why my emails are getting messed up... :/<br>
&gt; <br>
&gt; Have to go now, will try and send it again tomorrow probably...<br>
&gt; <br>
&gt; On Tue, May 6, 2025, 19:37 Daniel P. Berrang=C3=A9 &lt;<a href=3D"mail=
to:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redha=
t.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Tue, May 06, 2025 at 07:17:25PM +0300, Elisha Hollander wrote:=
<br>
&gt; &gt; &gt; Sorry for former patch something is messed up with my email.=
<br>
&gt; &gt;<br>
&gt; &gt; The commit message needs to explain what problem is being solved =
by<br>
&gt; &gt; making this change as allowing 0 bytes looks dubious on the surfa=
ce.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: donno2048 &lt;<a href=3D"mailto:just4now66666=
6@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmail.com<=
/a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 util/memfd.c | 10 ++++++----<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 4 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/util/memfd.c b/util/memfd.c<br>
&gt; &gt; &gt; index 8a2e906..e96e5af 100644<br>
&gt; &gt; &gt; --- a/util/memfd.c<br>
&gt; &gt; &gt; +++ b/util/memfd.c<br>
&gt; &gt; &gt; @@ -108,7 +108,7 @@ err:<br>
&gt; &gt; &gt;=C2=A0 void *qemu_memfd_alloc(const char *name, size_t size, =
unsigned int<br>
&gt; &gt; seals,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *fd, Error **errp)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; - void *ptr;<br>
&gt; &gt; &gt; + void *ptr =3D NULL;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 int mfd =3D qemu_memfd_create(name, size=
, false, 0, seals, NULL);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* some systems have memfd without seali=
ng */<br>
&gt; &gt; &gt; @@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name=
, size_t<br>
&gt; &gt; size,<br>
&gt; &gt; &gt; unsigned int seals,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, =
mfd, 0);<br>
&gt; &gt; &gt; - if (ptr =3D=3D MAP_FAILED) {<br>
&gt; &gt; &gt; - goto err;<br>
&gt; &gt; &gt; + if (size !=3D 0) {<br>
&gt; &gt; &gt; + ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, =
mfd, 0);<br>
&gt; &gt; &gt; + if (ptr =3D=3D MAP_FAILED) {<br>
&gt; &gt; &gt; + goto err;<br>
&gt; &gt; &gt; + }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; This patch is mangled.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; With regards,<br>
&gt; &gt; Daniel<br>
&gt; &gt; --<br>
&gt; &gt; |: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer"=
 target=3D"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-<br>
&gt; &gt; <a href=3D"https://www.flickr.com/photos/dberrange" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">https://www.flickr.com/photos/dberrange<=
/a> :|<br>
&gt; &gt; |: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
-o-<br>
&gt; &gt; <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer noref=
errer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
&gt; &gt; |: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noref=
errer" target=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-<br=
>
&gt; &gt; <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<b=
r>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--00000000000005117706347f19d3--

