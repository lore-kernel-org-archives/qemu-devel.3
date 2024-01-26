Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E68C47258
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 02:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTBl2-0005w4-QG; Thu, 25 Jan 2024 21:15:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rTBl1-0005vg-OT
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 21:15:51 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rTBkx-0002Wy-3B
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 21:15:51 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55817a12ad8so8290439a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 18:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1706235344; x=1706840144; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sEYysIsTm2nVLd9gaEYgB8AZf3Ac4lhWlfsQ/WHbzkY=;
 b=PYKExnq1pmj1yFo/PDm/BxY8iYA+BYwJu8RdK7Az3JDHFDOPdpAS8LObVSFI/+Al/u
 cmonI3HgWfLaCL9TewdMG+CuwVH4qSmgmWsaH2L6n3slkwvVyyhjrlfMc5G6x+ey7GOI
 l7AWn9OQg9qmbrc4ogQTzaI+r23JTaDlwM5L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706235344; x=1706840144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sEYysIsTm2nVLd9gaEYgB8AZf3Ac4lhWlfsQ/WHbzkY=;
 b=uoRE/mh1ubi+prF6yI0OR1YL0KKTjTaUrq08tEwgOIGXB0Nj0qx5OhgowrMQwXWZnR
 skfua5tUkWKUbWPd9c3imMl5RzTQcHPcL1PGQKaU9P4QiVx6rJ9wfT6YQn67IhNi/qBs
 7MTPcm4tQBB/cQrXB6MDHd2xJlMCw5xrn+dkll5uOU7Q9AAMfR0VrA5WBKEWVxNdu7q4
 ZGFV1KURE2Hmh4+v2C9WwM5tRJ4VfaVoNUqZxxTQygd5pxWjJljhNv2sqEw5xw2a6lbu
 AscJ2YLtnMeoi76IonyqozKCdFKdyt1zbHb7tKD+RzGdxA9jiIGCvWVeZ0Grgjh46+g8
 9i3Q==
X-Gm-Message-State: AOJu0YxIkcyxKqbMKqBcnypS2Y0rOagOCkIdZQGo8bfmgWnVe3NcAGI6
 NBJlN1qjZr/gmz9dwOz6OQIjiNI11CRXE82sH41phADtCmGvEAYS+nBYd4yhPuGwiBm53QIkZCZ
 thw==
X-Google-Smtp-Source: AGHT+IF6AFtdl8wYFDJTWzLwn7y7i7mpKyY+rNZAwgrxVahi/MwBiwdPwHdZtpfRUbWhGHQLXG2QGQ==
X-Received: by 2002:a17:906:5293:b0:a31:52f6:a6a5 with SMTP id
 c19-20020a170906529300b00a3152f6a6a5mr313308ejm.35.1706235344221; 
 Thu, 25 Jan 2024 18:15:44 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com.
 [209.85.208.43]) by smtp.gmail.com with ESMTPSA id
 w13-20020a1709064a0d00b00a3187de3487sm78575eju.82.2024.01.25.18.15.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 18:15:43 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-55d1d32d781so7470a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 18:15:43 -0800 (PST)
X-Received: by 2002:a05:6402:b9d:b0:55c:ebca:e69e with SMTP id
 cf29-20020a0564020b9d00b0055cebcae69emr60220edb.5.1706235343085; Thu, 25 Jan
 2024 18:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20231003204500.518-1-gurchetansingh@chromium.org>
 <87wms9d0fi.fsf@alyssa.is>
 <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
 <87cytxni1n.fsf@alyssa.is>
 <CAAfnVBmV3m0-Kh5gcrxzQXotEQ9ktXfEhJr92XAMKi6rXXkuOg@mail.gmail.com>
 <87cytwnqoj.fsf@alyssa.is>
In-Reply-To: <87cytwnqoj.fsf@alyssa.is>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 25 Jan 2024 18:15:31 -0800
X-Gmail-Original-Message-ID: <CAAfnVBkuKW7gfG5KAh8g26Keq_VCqmNrJwJi9+YZ-Lm+7rOUNA@mail.gmail.com>
Message-ID: <CAAfnVBkuKW7gfG5KAh8g26Keq_VCqmNrJwJi9+YZ-Lm+7rOUNA@mail.gmail.com>
Subject: Re: [PATCH v15 0/9] rutabaga_gfx + gfxstream
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Content-Type: multipart/alternative; boundary="00000000000087e6b3060fcfdf5c"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

--00000000000087e6b3060fcfdf5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 4:19=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:

> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>
> > On Fri, Jan 19, 2024 at 1:13=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrot=
e:
> >>
> >> Hi Gurchetan,
> >>
> >> > Thanks for the reminder.  I did make a request to create the release
> >> > tags, but changes were requested by Fedora packaging effort:
> >> >
> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2242058
> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2241701
> >> >
> >> > So the request was canceled, but never re-requested.  I'll fire off
> >> > another request, with:
> >> >
> >> > gfxstream: 23d05703b94035ac045df60823fb1fc4be0fdf1c ("gfxstream:
> >> > manually add debug logic")
> >> > AEMU: dd8b929c247ce9872c775e0e5ddc4300011d0e82 ("aemu: improve
> licensing")
> >> >
> >> > as the commits.  These match the Fedora requests, and the AEMU one h=
as
> >> > been merged into Fedora already it seems.
> >>
> >> These revisions have the problem I mentioned in my previous message:
> >>
> >> >> The gfxstream ref mentioned here isn't compatible with
> >> >> v0.1.2-rutabaga-release, because it no longer provides
> logging_base.pc,
> >>
> >> rutabaga was not fixed to use the new AEMU package names until after t=
he
> >> v0.1.2-rutabaga-release tag, in commit 5dfd74a06.  So will there be a
> >> new Rutabaga release that's compatible with these release versions of
> >> gfxstream and AEMU?
> >
> > Good catch.
> >
> > One possible workaround is to build gfxstream as a shared library.  I
> > think that would avoid rutabaga looking for AEMU package config files.
> >
> > But if another rutabaga release is desired with support for a static
> > library, then we can make that happen too.
>
> We're exclusively building gfxstream as a shared library.
>
> Looking at rutabaga's build.rs, it appears to me like pkg-config is
> always used for gfxstream unless overridden by GFXSTREAM_PATH.
>

Hmm, it seems we should be checking pkg-config --static before looking for
AEMU in build.rs -- oh well.

Would this be a suitable commit for the 0.1.3 release of rutabaga?

https://chromium.googlesource.com/crosvm/crosvm/+/5dfd74a0680d317c6edf44138=
def886f47cb1c7c

The gfxstream/AEMU commits would remain unchanged.

--00000000000087e6b3060fcfdf5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 20, 2024 at 4:19=E2=80=AF=
AM Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Gurchetan Si=
ngh &lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gu=
rchetansingh@chromium.org</a>&gt; writes:<br>
<br>
&gt; On Fri, Jan 19, 2024 at 1:13=E2=80=AFPM Alyssa Ross &lt;<a href=3D"mai=
lto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Gurchetan,<br>
&gt;&gt;<br>
&gt;&gt; &gt; Thanks for the reminder.=C2=A0 I did make a request to create=
 the release<br>
&gt;&gt; &gt; tags, but changes were requested by Fedora packaging effort:<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D2242=
058" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_=
bug.cgi?id=3D2242058</a><br>
&gt;&gt; &gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D2241=
701" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_=
bug.cgi?id=3D2241701</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; So the request was canceled, but never re-requested.=C2=A0 I&=
#39;ll fire off<br>
&gt;&gt; &gt; another request, with:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; gfxstream: 23d05703b94035ac045df60823fb1fc4be0fdf1c (&quot;gf=
xstream:<br>
&gt;&gt; &gt; manually add debug logic&quot;)<br>
&gt;&gt; &gt; AEMU: dd8b929c247ce9872c775e0e5ddc4300011d0e82 (&quot;aemu: i=
mprove licensing&quot;)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; as the commits.=C2=A0 These match the Fedora requests, and th=
e AEMU one has<br>
&gt;&gt; &gt; been merged into Fedora already it seems.<br>
&gt;&gt;<br>
&gt;&gt; These revisions have the problem I mentioned in my previous messag=
e:<br>
&gt;&gt;<br>
&gt;&gt; &gt;&gt; The gfxstream ref mentioned here isn&#39;t compatible wit=
h<br>
&gt;&gt; &gt;&gt; v0.1.2-rutabaga-release, because it no longer provides lo=
gging_base.pc,<br>
&gt;&gt;<br>
&gt;&gt; rutabaga was not fixed to use the new AEMU package names until aft=
er the<br>
&gt;&gt; v0.1.2-rutabaga-release tag, in commit 5dfd74a06.=C2=A0 So will th=
ere be a<br>
&gt;&gt; new Rutabaga release that&#39;s compatible with these release vers=
ions of<br>
&gt;&gt; gfxstream and AEMU?<br>
&gt;<br>
&gt; Good catch.<br>
&gt;<br>
&gt; One possible workaround is to build gfxstream as a shared library.=C2=
=A0 I<br>
&gt; think that would avoid rutabaga looking for AEMU package config files.=
<br>
&gt;<br>
&gt; But if another rutabaga release is desired with support for a static<b=
r>
&gt; library, then we can make that happen too.<br>
<br>
We&#39;re exclusively building gfxstream as a shared library.<br>
<br>
Looking at rutabaga&#39;s <a href=3D"http://build.rs" rel=3D"noreferrer" ta=
rget=3D"_blank">build.rs</a>, it appears to me like pkg-config is<br>
always used for gfxstream unless overridden by GFXSTREAM_PATH.<br></blockqu=
ote><div><br></div><div>Hmm, it seems we should be checking pkg-config --st=
atic before looking for AEMU in <a href=3D"http://build.rs">build.rs</a> --=
 oh well.</div><div><br></div><div>Would this be a suitable commit for the =
0.1.3 release of rutabaga?</div><div><br></div><div><a href=3D"https://chro=
mium.googlesource.com/crosvm/crosvm/+/5dfd74a0680d317c6edf44138def886f47cb1=
c7c">https://chromium.googlesource.com/crosvm/crosvm/+/5dfd74a0680d317c6edf=
44138def886f47cb1c7c</a><br></div><div><br></div><div>The gfxstream/AEMU co=
mmits would remain unchanged.</div><div>=C2=A0</div></div></div>

--00000000000087e6b3060fcfdf5c--

