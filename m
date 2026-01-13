Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669E4D2D108
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfex9-0006t7-JT; Tue, 13 Jan 2026 09:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vfewd-0006Nt-QS
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:00:35 -0500
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vfewW-0001Bb-87
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:00:22 -0500
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-11f3e3f0cacso9522120c88.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 06:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768312816; x=1768917616; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sC0GuvIyUiMA3XEgnR/i+Ers5xl12AhABZt3OAoOZSE=;
 b=hTsuKTpQUskjnpfljhd/nSO0vz9UyUmMmNs3WQCvOzVjzqQv4CicWBMTNs1KOCXyND
 sVJkHkJ0yH/Amw/LNlbQPNZoV0IDXalabrECq7U0sOAT0GK6VXwBmTbGhLrc+BRL3QE0
 8/E6FfZvJOtoTcCEqNNywRDZL2bVeIbF6Hok6DgducRwdbIgKH8oalm0lvi6DEMLpccq
 4PjGkXNbHP/5RekNZ+1G7wa/5jTATG9C4A6kHMiTkh9Ppc63I5VUvQlqjJYX1vWFO5Bu
 t8cdBbsD/uwWSVhavX/dE9Izb8Ff4AXI4Qp9ZTp6dwFvFb8/HPb1o4YuUjIq77JQL+y/
 099w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768312816; x=1768917616;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sC0GuvIyUiMA3XEgnR/i+Ers5xl12AhABZt3OAoOZSE=;
 b=ipI/DN4T5dBWKROB90zl5gT2teMrphgOx7V+lxqw2uA14ZgPW8TTqX5GJsHeJnNp7J
 4mfneqxzhf+BQsy8e10PUEf/v1gPiCs7DtIVkAwP9oXeNFkrToQa2R2N0w+gs5wV6rbu
 Esixxm3KidqRpmr035MFuUZLqnB1CV3qdIXmiMJQaCOJ54nMFKxcV+oUXa+dpjdsO8u3
 P968YWQSS0pkATkpKDiy4cq+KDZqa6OSFF287oLA3KF852h//rHhjEfm1moxXsfJvpLq
 HxgxAu7TThKYx4/wuTR4hTRXVFmxndLsSMmrRvwdX2GRqdtgrZy6Y9ccYQv6vCuQxFKY
 GXpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULGzKV9h5kiOgG0z9dIHJIEJS1UP/MrWw+spaED/aXDmQKDzkShXNRE53nqtfsGk1l7MACdSx+Jzdm@nongnu.org
X-Gm-Message-State: AOJu0YzHH+WAxMYW79PJk4hm6gi4wQjYiXmT3qbJSy0wEkdUJlokcKPW
 EaXFp4Hw4dyUqK06T3aKtNiia9vfbQqTMVlzr+3jo78337eZUT2Tp2eBnojowSIdA5JQSN/QH9e
 4JLfKnps5IvvdHbLK3432jDvU3k3u2Wc=
X-Gm-Gg: AY/fxX7J56u93hqp09Hg1Gpl0d3qZa4PJIGLL6sVHobtyAhzWzcuHyijV7zFJMp/ah0
 G+OS3ARG+5UyQmiJjGE2ulzOV850FnXatQvW35hREzmWM7CnIuiEZZ6r3pUzOhbmN1Y5OEu8sOt
 nPHcWMfoxtTMSeFqbNzc+xKAo9EXAOgxa7tSGwgmOWGNJ9HQYWiqsOUIw/la8rt2Lk2a1uV+AvV
 hxK/jhtEF/KFbnNRBKnpkR2jaDy0bqUD6DH1nIuydOjhfFz0hBBE0d7aI/6XPP6KlDJ+e9ajX9x
 nkHOyGLgLy7C7I7qBkaZeogITw==
X-Google-Smtp-Source: AGHT+IFpRYiRGGixwNInuyT56/42w1kKJ8OMivQFdDvmVHoshlwHNvt8G6uXVA/kMnl35fuDtR72s771qF9QgV9270E=
X-Received: by 2002:a05:701a:ca8c:b0:123:2d4f:ef1c with SMTP id
 a92af1059eb24-1232d4ff0ccmr2102944c88.26.1768312814610; Tue, 13 Jan 2026
 06:00:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1767886100.git.ktokunaga.mail@gmail.com>
 <79ec37f7fa0352d0463ed6ec5496f6a88f47d111.1767886100.git.ktokunaga.mail@gmail.com>
 <a17f477f-bcac-4eac-8fd5-09a6e99c8f30@linaro.org>
 <CAEDrbUbr=ZAZp3sPJOrqimSXcNYS6n=24fDU427fLQDgr2e=og@mail.gmail.com>
In-Reply-To: <CAEDrbUbr=ZAZp3sPJOrqimSXcNYS6n=24fDU427fLQDgr2e=og@mail.gmail.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Tue, 13 Jan 2026 23:00:02 +0900
X-Gm-Features: AZwV_QgjnHWmaP6YOa1lGdbs-1RNT2BGPjjsgyN1YCIBITYamj8TwaPtyziWzrc
Message-ID: <CAEDrbUbSO1bQK2FVrfB-SNeA1pimrK6ikw=cL=2FvVS_9Wko_A@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] .gitlab-ci.d: Add build tests for wasm64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002aab3a0648456954"
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x122f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000002aab3a0648456954
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

> > On 1/9/26 04:11, Kohei Tokunaga wrote:
> > > +wasm64-64bit-emsdk-cross-container:
> > > +  extends: .container_job_template
> > > +  variables:
> > > +    NAME: emsdk-wasm64-64bit-cross
> > > +    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg
WASM64_MEMORY64=1
> > > +    DOCKERFILE: emsdk-wasm-cross
> > > +
> > > +wasm64-32bit-emsdk-cross-container:
> > > +  extends: .container_job_template
> > > +  variables:
> > > +    NAME: emsdk-wasm64-32bit-cross
> > > +    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg
WASM64_MEMORY64=2
> > > +    DOCKERFILE: emsdk-wasm-cross
> >
> > To expand on my question about WASM64_MEMORY64 vs
--wasm64-32bit-address-limit, I would
> > expect the two wasm64 build jobs to share the same container.
>
> Thanks for the feedback, I'll fix this in the next version of the series.

I've fixed the test to share the same container. Dependencies are now
compiled with -sMEMORY64=1 to produce wasm64 object files. The
build-wasm64-32bit test compiles QEMU with --wasm64-32bit-address-limit so
that the final linked output is lowered by Emscripten's -sMEMORY64=2.

https://patchew.org/QEMU/cover.1768308374.git.ktokunaga.mail@gmail.com/

Regards,
Kohei

--0000000000002aab3a0648456954
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div>Hi Richard,<br><br>&gt; &gt; On=
 1/9/26 04:11, Kohei Tokunaga wrote:<br>&gt; &gt; &gt; +wasm64-64bit-emsdk-=
cross-container:<br>&gt; &gt; &gt; + =C2=A0extends: .container_job_template=
<br>&gt; &gt; &gt; + =C2=A0variables:<br>&gt; &gt; &gt; + =C2=A0 =C2=A0NAME=
: emsdk-wasm64-64bit-cross<br>&gt; &gt; &gt; + =C2=A0 =C2=A0BUILD_ARGS: --b=
uild-arg TARGET_CPU=3Dwasm64 --build-arg WASM64_MEMORY64=3D1<br>&gt; &gt; &=
gt; + =C2=A0 =C2=A0DOCKERFILE: emsdk-wasm-cross<br>&gt; &gt; &gt; +<br>&gt;=
 &gt; &gt; +wasm64-32bit-emsdk-cross-container:<br>&gt; &gt; &gt; + =C2=A0e=
xtends: .container_job_template<br>&gt; &gt; &gt; + =C2=A0variables:<br>&gt=
; &gt; &gt; + =C2=A0 =C2=A0NAME: emsdk-wasm64-32bit-cross<br>&gt; &gt; &gt;=
 + =C2=A0 =C2=A0BUILD_ARGS: --build-arg TARGET_CPU=3Dwasm64 --build-arg WAS=
M64_MEMORY64=3D2<br>&gt; &gt; &gt; + =C2=A0 =C2=A0DOCKERFILE: emsdk-wasm-cr=
oss<br>&gt; &gt; <br>&gt; &gt; To expand on my question about WASM64_MEMORY=
64 vs --wasm64-32bit-address-limit, I would<br>&gt; &gt; expect the two was=
m64 build jobs to share the same container.<br>&gt; <br>&gt; Thanks for the=
 feedback, I&#39;ll fix this in the next version of the series.<br><br>I&#3=
9;ve fixed the test to share the same container. Dependencies are now<br>co=
mpiled with -sMEMORY64=3D1 to produce wasm64 object files. The<br>build-was=
m64-32bit test compiles QEMU with --wasm64-32bit-address-limit so<br>that t=
he final linked output is lowered by Emscripten&#39;s -sMEMORY64=3D2.<br><b=
r><a href=3D"https://patchew.org/QEMU/cover.1768308374.git.ktokunaga.mail@g=
mail.com/">https://patchew.org/QEMU/cover.1768308374.git.ktokunaga.mail@gma=
il.com/</a><br><br>Regards,<br>Kohei<br><br></div>

--0000000000002aab3a0648456954--

