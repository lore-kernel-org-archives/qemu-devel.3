Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DE2C87FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 01:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujps0-0001zt-3Y; Wed, 06 Aug 2025 21:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujprq-0001xY-Og
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 21:56:31 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujpro-0000wT-00
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 21:56:30 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b4233f86067so325500a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 18:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754531786; x=1755136586; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JvD88rAmS3YnWWg9b5BeJcNtybHMRq3u82RqRmWwt7Y=;
 b=iYPj900rFNfggCLECLl6b1SjQJD9dVHaTaJcRtbLrijwMhDjy9k1zJsSjQksBZO74k
 KGLshyhWKK0uGwA1lN6N9SgEMU0ElycW7r0fSNhR6UKJ8rkCmmOsInVkktyDDPDuYUvs
 SkvnzgSvicq+NvMn5mfTCTeTtq8KdN3FPyXxewva9WHYVjMXdOdy7GG73w1f8VpKEyUg
 Hf512S06qxpX2ydeEka28Yhg1WTbFFiGiScp0j18FLIguiJc2p1dW427HL+Q7Yan1ESD
 8reJFdA9Z0mIYCWICKJzv5ahiE8vLaosdqDxEogqjWISE+JDsZbID3eAQvxKc7nlwoIQ
 pt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754531786; x=1755136586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JvD88rAmS3YnWWg9b5BeJcNtybHMRq3u82RqRmWwt7Y=;
 b=sbYIxaA7fEbzG2FXaamDjLDT1xlEKJcTgBoKGEEVKqG5NDizGAtNVlRqIN/k9+KCSC
 66DmorKEhJJqW8Z3zby9Ml9/qNU5agmce4NDl07qGnGJm7wyb158/kdVkkiiLecAECgw
 taaH4eQHbCbqBgNI5S67oe25nL/asvO4Z/Ha8w6UzfCiZhKQLYO/ekJ79qfdjcYypDlW
 CtttsQxSa8WrPr2HrjMcJuMTDG06rP76tzRGEG0Binek6AVBEc8EtRW8SUkKZEczSWdH
 /leZJxiqJff/ODwWVUlBrKn434L//cALrqI8FHOQw+0dVn87JWKVskf+ro9umhEFFmtP
 lpLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUoudNBQU9LbSPscQOqeg66wfQBdqB23wyd9OJMO4d5QwzFZqgWWyOH3LWz0ziBbKXnkFj5sv9Fo/2@nongnu.org
X-Gm-Message-State: AOJu0Yxtrsv5cmHaqY7v97AvD4Dx78h5TATDNtzba7W3ACUsDtv+XXJr
 QbPf8zp74MOuexOr9wpZl5HqX7D/u8PPIkEgUKY6TJ4n4v0NW+kMNPSbAmx8ha5SAvTLl3f9scX
 qHjoUt39aC/4pSwciloi0CNQ7LQTZX8I=
X-Gm-Gg: ASbGncsE8UZfGhRZp3Yjd2Yd2PYNMZArZP167mQNbf5rl48c7JFuwHAChKLDmL/LHQC
 12GVe8R74n43vlk8Hl8W8dHnoyX9Rb7AZMA8ZPrbuDbfqYMt8dWbykywiqnz4hPSp+VqJbQaXmO
 t09Pq8CGcSYncx1VNHy128B2uEUVjujBWd3zrHXao1U9kDKeG691R5q1Q93Z8aci9BLevvFGfJ6
 zhdeZao/pqCOBL+JOoo2YtjDNKrPK8Dna0qNGKKGnFsbIXX
X-Google-Smtp-Source: AGHT+IEQh0SJsjkopU5/IkJ8aPoUPr3l28Ve0d6i0RQK+3+QrgTO/dxkSmS3vaa+Jnoxx2W854/nA2y4wbquhGkpNUM=
X-Received: by 2002:a17:903:120a:b0:242:5f6c:6b4e with SMTP id
 d9443c01a7336-242b064052dmr23829865ad.7.1754531786350; Wed, 06 Aug 2025
 18:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1754494089.git.ktokunaga.mail@gmail.com>
 <c10d9f2b85a2791d9f734678fba186e6eacc1b37.1754494089.git.ktokunaga.mail@gmail.com>
 <9772039a-53c3-4850-82e4-d0efdfa94f2d@linaro.org>
In-Reply-To: <9772039a-53c3-4850-82e4-d0efdfa94f2d@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 7 Aug 2025 10:56:14 +0900
X-Gm-Features: Ac12FXyNxk8ux46gynCc9XEuTbEKqR4IxmbHOOCt4U2tJ2PqFrlyxxmxCpJm34c
Message-ID: <CAEDrbUaYa9=B7_PeGQFm1prWwX+FgkZ+vqq1RwXZTTMpcP4F4A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] .gitlab-ci.d: Add build tests for wasm64
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000df66a3063bbcc375"
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x532.google.com
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

--000000000000df66a3063bbcc375
Content-Type: text/plain; charset="UTF-8"

> On 6/8/25 17:49, Kohei Tokunaga wrote:
> > The wasm builds are tested for 3 targets: wasm32, wasm64(-sMEMORY64=1)
and
> > wasm64(-sMEMORY64=2). The CI builds the containers using the same
Dockerfile
> > (emsdk-wasm-cross.docker) with different build args.
> >
> > Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> > ---
> >   .gitlab-ci.d/buildtest.yml          | 24 +++++++++++++++++++++---
> >   .gitlab-ci.d/container-cross.yml    | 18 +++++++++++++++++-
> >   .gitlab-ci.d/container-template.yml |  4 +++-
> >   3 files changed, 41 insertions(+), 5 deletions(-)
> >
> > V2:
> > - Fixed to use --wasm64-32bit-address-limit instead of the removed
> >    --wasm64-memory64. This can be considered as a significant change
from the
> >    previous version of this patch so the Reviewed-by tag has been
removed.
> >
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index d888a60063..0dded04188 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -787,11 +787,29 @@ coverity:
> >       # Always manual on forks even if $QEMU_CI == "2"
> >       - when: manual
> >
> > -build-wasm:
> > +build-wasm32:
>
> OK (or following bellow logic, "build-wasm32-32-bit").
>
> >     extends: .wasm_build_job_template
> >     timeout: 2h
> >     needs:
> > -    job: wasm-emsdk-cross-container
> > +    job: wasm32-emsdk-cross-container
> >     variables:
> >       IMAGE: emsdk-wasm32-cross
> > -    CONFIGURE_ARGS: --static --disable-tools --enable-debug
--enable-tcg-interpreter
> > +    CONFIGURE_ARGS: --static --cpu=wasm32 --disable-tools
--enable-debug --enable-tcg-interpreter
> > +
> > +build-wasm-wasm64:
>
> Maybe build-wasm64-64bit?> +  extends: .wasm_build_job_template
> > +  timeout: 2h
> > +  needs:
> > +    job: wasm64-emsdk-cross-container
> > +  variables:
> > +    IMAGE: emsdk-wasm64-cross
> > +    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools
--enable-debug --enable-tcg-interpreter
> > +
> > +build-wasm-wasm64l:
>
> So this one becomes build-wasm64-32bit (or better name, "wasm64[l]" is
> not easy to distinct and figure out this is the 32-bit AS version.
>
> > +  extends: .wasm_build_job_template
> > +  timeout: 2h
> > +  needs:
> > +    job: wasm64l-emsdk-cross-container
> > +  variables:
> > +    IMAGE: emsdk-wasm64l-cross
> > +    CONFIGURE_ARGS: --static --cpu=wasm64 --wasm64-32bit-address-limit
--disable-tools --enable-debug --enable-tcg-interpreter
> > diff --git a/.gitlab-ci.d/container-cross.yml
b/.gitlab-ci.d/container-cross.yml
> > index 8d3be53b75..1bacaff818 100644
> > --- a/.gitlab-ci.d/container-cross.yml
> > +++ b/.gitlab-ci.d/container-cross.yml
> > @@ -92,7 +92,23 @@ win64-fedora-cross-container:
> >     variables:
> >       NAME: fedora-win64-cross
> >
> > -wasm-emsdk-cross-container:
> > +wasm32-emsdk-cross-container:
> >     extends: .container_job_template
> >     variables:
> >       NAME: emsdk-wasm32-cross
> > +    BUILD_ARGS: --build-arg TARGET_CPU=wasm32
> > +    DOCKERFILE: emsdk-wasm-cross
> > +
> > +wasm64-emsdk-cross-container:
> > +  extends: .container_job_template
> > +  variables:
> > +    NAME: emsdk-wasm64-cross
> > +    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg
WASM64_MEMORY64=1
> > +    DOCKERFILE: emsdk-wasm-cross
> > +
> > +wasm64l-emsdk-cross-container:
>
> (same comments)
>
> > +  extends: .container_job_template
> > +  variables:
> > +    NAME: emsdk-wasm64l-cross
> > +    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg
WASM64_MEMORY64=2
> > +    DOCKERFILE: emsdk-wasm-cross
> > diff --git a/.gitlab-ci.d/container-template.yml
b/.gitlab-ci.d/container-template.yml
> > index 4eec72f383..01ca840413 100644
> > --- a/.gitlab-ci.d/container-template.yml
> > +++ b/.gitlab-ci.d/container-template.yml
> > @@ -10,12 +10,14 @@
> >       - export
COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:latest"
> >       - docker login $CI_REGISTRY -u "$CI_REGISTRY_USER" -p
"$CI_REGISTRY_PASSWORD"
> >       - until docker info; do sleep 1; done
> > +    - export DOCKERFILE_NAME=${DOCKERFILE:-$NAME}
> >     script:
> >       - echo "TAG:$TAG"
> >       - echo "COMMON_TAG:$COMMON_TAG"
> >       - docker build --tag "$TAG" --cache-from "$TAG" --cache-from
"$COMMON_TAG"
> >         --build-arg BUILDKIT_INLINE_CACHE=1
> > -      -f "tests/docker/dockerfiles/$NAME.docker" "."
> > +      $BUILD_ARGS
> > +      -f "tests/docker/dockerfiles/$DOCKERFILE_NAME.docker" "."
> >       - docker push "$TAG"
> >     after_script:
> >       - docker logout
> Nitpicking about names, otherwise LGTM!

Hi Philippe,
Thanks for the suggestion. I'll rename them in the next version of the patch
series.

--000000000000df66a3063bbcc375
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; On 6/8/25 17:49, Kohei Tokunaga wrot=
e:<br>&gt; &gt; The wasm builds are tested for 3 targets: wasm32, wasm64(-s=
MEMORY64=3D1) and<br>&gt; &gt; wasm64(-sMEMORY64=3D2). The CI builds the co=
ntainers using the same Dockerfile<br>&gt; &gt; (emsdk-wasm-cross.docker) w=
ith different build args.<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Kohei To=
kunaga &lt;<a href=3D"mailto:ktokunaga.mail@gmail.com">ktokunaga.mail@gmail=
.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0 .gitlab-ci.d/buildtest.ym=
l =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 24 +++++++++++++++++++++---<br>&gt; &=
gt; =C2=A0 .gitlab-ci.d/container-cross.yml =C2=A0 =C2=A0| 18 +++++++++++++=
++++-<br>&gt; &gt; =C2=A0 .gitlab-ci.d/container-template.yml | =C2=A04 +++=
-<br>&gt; &gt; =C2=A0 3 files changed, 41 insertions(+), 5 deletions(-)<br>=
&gt; &gt;<br>&gt; &gt; V2:<br>&gt; &gt; - Fixed to use --wasm64-32bit-addre=
ss-limit instead of the removed<br>&gt; &gt; =C2=A0 =C2=A0--wasm64-memory64=
. This can be considered as a significant change from the<br>&gt; &gt; =C2=
=A0 =C2=A0previous version of this patch so the Reviewed-by tag has been re=
moved.<br>&gt; &gt;<br>&gt; &gt; diff --git a/.gitlab-ci.d/buildtest.yml b/=
.gitlab-ci.d/buildtest.yml<br>&gt; &gt; index d888a60063..0dded04188 100644=
<br>&gt; &gt; --- a/.gitlab-ci.d/buildtest.yml<br>&gt; &gt; +++ b/.gitlab-c=
i.d/buildtest.yml<br>&gt; &gt; @@ -787,11 +787,29 @@ coverity:<br>&gt; &gt;=
 =C2=A0 =C2=A0 =C2=A0 # Always manual on forks even if $QEMU_CI =3D=3D &quo=
t;2&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 - when: manual<br>&gt; &gt; =C2=
=A0 <br>&gt; &gt; -build-wasm:<br>&gt; &gt; +build-wasm32:<br>&gt; <br>&gt;=
 OK (or following bellow logic, &quot;build-wasm32-32-bit&quot;).<br>&gt; <=
br>&gt; &gt; =C2=A0 =C2=A0 extends: .wasm_build_job_template<br>&gt; &gt; =
=C2=A0 =C2=A0 timeout: 2h<br>&gt; &gt; =C2=A0 =C2=A0 needs:<br>&gt; &gt; - =
=C2=A0 =C2=A0job: wasm-emsdk-cross-container<br>&gt; &gt; + =C2=A0 =C2=A0jo=
b: wasm32-emsdk-cross-container<br>&gt; &gt; =C2=A0 =C2=A0 variables:<br>&g=
t; &gt; =C2=A0 =C2=A0 =C2=A0 IMAGE: emsdk-wasm32-cross<br>&gt; &gt; - =C2=
=A0 =C2=A0CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-=
tcg-interpreter<br>&gt; &gt; + =C2=A0 =C2=A0CONFIGURE_ARGS: --static --cpu=
=3Dwasm32 --disable-tools --enable-debug --enable-tcg-interpreter<br>&gt; &=
gt; +<br>&gt; &gt; +build-wasm-wasm64:<br>&gt; <br>&gt; Maybe build-wasm64-=
64bit?&gt; + =C2=A0extends: .wasm_build_job_template<br>&gt; &gt; + =C2=A0t=
imeout: 2h<br>&gt; &gt; + =C2=A0needs:<br>&gt; &gt; + =C2=A0 =C2=A0job: was=
m64-emsdk-cross-container<br>&gt; &gt; + =C2=A0variables:<br>&gt; &gt; + =
=C2=A0 =C2=A0IMAGE: emsdk-wasm64-cross<br>&gt; &gt; + =C2=A0 =C2=A0CONFIGUR=
E_ARGS: --static --cpu=3Dwasm64 --disable-tools --enable-debug --enable-tcg=
-interpreter<br>&gt; &gt; +<br>&gt; &gt; +build-wasm-wasm64l:<br>&gt; <br>&=
gt; So this one becomes build-wasm64-32bit (or better name, &quot;wasm64[l]=
&quot; is<br>&gt; not easy to distinct and figure out this is the 32-bit AS=
 version.<br>&gt; <br>&gt; &gt; + =C2=A0extends: .wasm_build_job_template<b=
r>&gt; &gt; + =C2=A0timeout: 2h<br>&gt; &gt; + =C2=A0needs:<br>&gt; &gt; + =
=C2=A0 =C2=A0job: wasm64l-emsdk-cross-container<br>&gt; &gt; + =C2=A0variab=
les:<br>&gt; &gt; + =C2=A0 =C2=A0IMAGE: emsdk-wasm64l-cross<br>&gt; &gt; + =
=C2=A0 =C2=A0CONFIGURE_ARGS: --static --cpu=3Dwasm64 --wasm64-32bit-address=
-limit --disable-tools --enable-debug --enable-tcg-interpreter<br>&gt; &gt;=
 diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cro=
ss.yml<br>&gt; &gt; index 8d3be53b75..1bacaff818 100644<br>&gt; &gt; --- a/=
.gitlab-ci.d/container-cross.yml<br>&gt; &gt; +++ b/.gitlab-ci.d/container-=
cross.yml<br>&gt; &gt; @@ -92,7 +92,23 @@ win64-fedora-cross-container:<br>=
&gt; &gt; =C2=A0 =C2=A0 variables:<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 NAME: =
fedora-win64-cross<br>&gt; &gt; =C2=A0 <br>&gt; &gt; -wasm-emsdk-cross-cont=
ainer:<br>&gt; &gt; +wasm32-emsdk-cross-container:<br>&gt; &gt; =C2=A0 =C2=
=A0 extends: .container_job_template<br>&gt; &gt; =C2=A0 =C2=A0 variables:<=
br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 NAME: emsdk-wasm32-cross<br>&gt; &gt; + =
=C2=A0 =C2=A0BUILD_ARGS: --build-arg TARGET_CPU=3Dwasm32<br>&gt; &gt; + =C2=
=A0 =C2=A0DOCKERFILE: emsdk-wasm-cross<br>&gt; &gt; +<br>&gt; &gt; +wasm64-=
emsdk-cross-container:<br>&gt; &gt; + =C2=A0extends: .container_job_templat=
e<br>&gt; &gt; + =C2=A0variables:<br>&gt; &gt; + =C2=A0 =C2=A0NAME: emsdk-w=
asm64-cross<br>&gt; &gt; + =C2=A0 =C2=A0BUILD_ARGS: --build-arg TARGET_CPU=
=3Dwasm64 --build-arg WASM64_MEMORY64=3D1<br>&gt; &gt; + =C2=A0 =C2=A0DOCKE=
RFILE: emsdk-wasm-cross<br>&gt; &gt; +<br>&gt; &gt; +wasm64l-emsdk-cross-co=
ntainer:<br>&gt; <br>&gt; (same comments)<br>&gt; <br>&gt; &gt; + =C2=A0ext=
ends: .container_job_template<br>&gt; &gt; + =C2=A0variables:<br>&gt; &gt; =
+ =C2=A0 =C2=A0NAME: emsdk-wasm64l-cross<br>&gt; &gt; + =C2=A0 =C2=A0BUILD_=
ARGS: --build-arg TARGET_CPU=3Dwasm64 --build-arg WASM64_MEMORY64=3D2<br>&g=
t; &gt; + =C2=A0 =C2=A0DOCKERFILE: emsdk-wasm-cross<br>&gt; &gt; diff --git=
 a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.ym=
l<br>&gt; &gt; index 4eec72f383..01ca840413 100644<br>&gt; &gt; --- a/.gitl=
ab-ci.d/container-template.yml<br>&gt; &gt; +++ b/.gitlab-ci.d/container-te=
mplate.yml<br>&gt; &gt; @@ -10,12 +10,14 @@<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 - export COMMON_TAG=3D&quot;$CI_REGISTRY/qemu-project/qemu/qemu/$NAME:l=
atest&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 - docker login $CI_REGISTRY -=
u &quot;$CI_REGISTRY_USER&quot; -p &quot;$CI_REGISTRY_PASSWORD&quot;<br>&gt=
; &gt; =C2=A0 =C2=A0 =C2=A0 - until docker info; do sleep 1; done<br>&gt; &=
gt; + =C2=A0 =C2=A0- export DOCKERFILE_NAME=3D${DOCKERFILE:-$NAME}<br>&gt; =
&gt; =C2=A0 =C2=A0 script:<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 - echo &quot;T=
AG:$TAG&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 - echo &quot;COMMON_TAG:$CO=
MMON_TAG&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 - docker build --tag &quot=
;$TAG&quot; --cache-from &quot;$TAG&quot; --cache-from &quot;$COMMON_TAG&qu=
ot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 --build-arg BUILDKIT_INLINE_CA=
CHE=3D1<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0-f &quot;tests/docker/dockerfile=
s/$NAME.docker&quot; &quot;.&quot;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0$BUIL=
D_ARGS<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0-f &quot;tests/docker/dockerfiles=
/$DOCKERFILE_NAME.docker&quot; &quot;.&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 - docker push &quot;$TAG&quot;<br>&gt; &gt; =C2=A0 =C2=A0 after_script:=
<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 - docker logout<br>&gt; Nitpicking about=
 names, otherwise LGTM!<br><br>Hi Philippe,<br>Thanks for the suggestion. I=
&#39;ll rename them in the next version of the patch<br>series.</div><br><d=
iv class=3D"gmail_quote gmail_quote_container"><br></div></div>

--000000000000df66a3063bbcc375--

