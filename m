Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D46C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJTO-0000lg-28; Mon, 12 Jan 2026 10:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vfJTE-0000ck-It
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:04:44 -0500
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vfJTC-0002iH-OT
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:04:40 -0500
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-11f3e3f0cacso8010568c88.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 07:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768230276; x=1768835076; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d/pxK99B9B2mkIQh0b8mY/816QWwHVx9EcSgvnqgDoo=;
 b=dwQ8rJ9SmH3LlKO3xdm1wINNFsClEdOfa3iVJWpR1IypYr+wUtfOrKw16PfM8Fps9x
 UuStFeYAs1XURCxfwnYSx32QL4wYdHvdi91QF/7WCqgSprKZM78i7HCEp/FLa2k74taW
 CipoR1NUCKQ4F7MZypKGubGXEAR7xzJkzTq88St8w7fWcHhyFx2dgF9lIrgyMLEur4au
 QDKlWuE6l5KaZydMTaAalyTyCJk7oUellnivBhCIIlJUGZG3aMygkvVzuFwe71CUwv7a
 bSJRo8MCbMoxQe7l7VJS3KulbkpfjJ9jWl6gheGhq1w3kJZzbJn4hTDNZZXpfMFz8Yz4
 FCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768230276; x=1768835076;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/pxK99B9B2mkIQh0b8mY/816QWwHVx9EcSgvnqgDoo=;
 b=h/uDCbfPJFAvYo47Il9k9OH7jAuKgnizytXg/OzuhKZVWE70Ns62NojscRBjev6P1j
 8S28Ql/zwXVwGmrNZFpUHoJz6upvJ6LJLFLzwra+Gshpqijt+VXvgp+NsEhT8aA8MOEe
 QAAPOIJ/2DOCjQ8+/eriWh2JdrWdK/+qSPJrZ5YPmiJNgNPrK5AlzIOkVAyQLKA0mxGO
 4U/cQESywEcMRplFDJDFkEhJ7Ff+IuGKZxDh9RPF6/bjDaJ8eOZIs6ajskqVfJPl6YUW
 FabqCwGOwErwEfiUU47VLhYZ3gpf2C0f8XPmrCMbnBIag7eQsbvnc28Qljdv5eoO6un2
 MeTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlxN6kVt210D6/eqoObtQsLpM1O3wa1Epm3LteRyDsWqNwaXSooevdx/chACG8RMctOp3S7yExIuxm@nongnu.org
X-Gm-Message-State: AOJu0YwEGSttyw7IIbG2AlVSpazJ+VXrMhCzM+qPf8YWXLNQ+sbz+H1c
 S9NXQJxkCm2DyEhO86NOQ8xHyMClXDQI6adJrtFPRLQivI9ju8WLg148ufAZXWRwHBP5jWzHMho
 CRB/y/j5IOgLZi5KE7QDPG95gdTukLKw=
X-Gm-Gg: AY/fxX7SXdYbQR7yYVs2nkhGHvWWjb5vGJYf0xdkygGD7FOut2fO+q40wOvxndOyL6j
 QQnzjUwqDqJdr1GZ97mhyY013NujxOyYbYpr+e9p/dKyewo199YKUdvTdj4Fn913wNsUlWJVt4d
 se73nDFFW9S8MypzYTOvpQWhVvDtOLAOXvVs69FN5rABjCoDXIyPa9wMqS4n0cJHB8DbwkRgQ8Y
 vttIe03Xpn5XXMd+s1WpGoqfGhwYhRMTD/Y3eHyTssRq1myBGPvKjDYWZqut8TP5l/wqbo2IKub
 0Jojp1n8RDq8/vkbj8yn+pCpRQ==
X-Google-Smtp-Source: AGHT+IESklGTTWKBppiCFvlJOU/3lBAwL8TRlA1B+fntDmHd7hFuBEiTkDMaviQyjzRIVnopp+dv2ErqvgAQsDtT3ng=
X-Received: by 2002:a05:7022:6b87:b0:119:e56b:91d1 with SMTP id
 a92af1059eb24-121f8ac007dmr13851526c88.2.1768230276092; Mon, 12 Jan 2026
 07:04:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1767886100.git.ktokunaga.mail@gmail.com>
 <79ec37f7fa0352d0463ed6ec5496f6a88f47d111.1767886100.git.ktokunaga.mail@gmail.com>
 <a17f477f-bcac-4eac-8fd5-09a6e99c8f30@linaro.org>
In-Reply-To: <a17f477f-bcac-4eac-8fd5-09a6e99c8f30@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Tue, 13 Jan 2026 00:04:24 +0900
X-Gm-Features: AZwV_QjJ4rIryh11oJRbiDHa4po1W1k2nqsLp4tL0Up1yNQXfOkKl5G11HvWgdA
Message-ID: <CAEDrbUbr=ZAZp3sPJOrqimSXcNYS6n=24fDU427fLQDgr2e=og@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] .gitlab-ci.d: Add build tests for wasm64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007cd6f706483231fc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x122d.google.com
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

--0000000000007cd6f706483231fc
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

> On 1/9/26 04:11, Kohei Tokunaga wrote:
> > +wasm64-64bit-emsdk-cross-container:
> > +  extends: .container_job_template
> > +  variables:
> > +    NAME: emsdk-wasm64-64bit-cross
> > +    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg
WASM64_MEMORY64=1
> > +    DOCKERFILE: emsdk-wasm-cross
> > +
> > +wasm64-32bit-emsdk-cross-container:
> > +  extends: .container_job_template
> > +  variables:
> > +    NAME: emsdk-wasm64-32bit-cross
> > +    BUILD_ARGS: --build-arg TARGET_CPU=wasm64 --build-arg
WASM64_MEMORY64=2
> > +    DOCKERFILE: emsdk-wasm-cross
>
> To expand on my question about WASM64_MEMORY64 vs
--wasm64-32bit-address-limit, I would
> expect the two wasm64 build jobs to share the same container.

Thanks for the feedback, I'll fix this in the next version of the series.

Regards,
Kohei

--0000000000007cd6f706483231fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Richard,<br><br>&gt; On 1/9/26 04:11, =
Kohei Tokunaga wrote:<br>&gt; &gt; +wasm64-64bit-emsdk-cross-container:<br>=
&gt; &gt; + =C2=A0extends: .container_job_template<br>&gt; &gt; + =C2=A0var=
iables:<br>&gt; &gt; + =C2=A0 =C2=A0NAME: emsdk-wasm64-64bit-cross<br>&gt; =
&gt; + =C2=A0 =C2=A0BUILD_ARGS: --build-arg TARGET_CPU=3Dwasm64 --build-arg=
 WASM64_MEMORY64=3D1<br>&gt; &gt; + =C2=A0 =C2=A0DOCKERFILE: emsdk-wasm-cro=
ss<br>&gt; &gt; +<br>&gt; &gt; +wasm64-32bit-emsdk-cross-container:<br>&gt;=
 &gt; + =C2=A0extends: .container_job_template<br>&gt; &gt; + =C2=A0variabl=
es:<br>&gt; &gt; + =C2=A0 =C2=A0NAME: emsdk-wasm64-32bit-cross<br>&gt; &gt;=
 + =C2=A0 =C2=A0BUILD_ARGS: --build-arg TARGET_CPU=3Dwasm64 --build-arg WAS=
M64_MEMORY64=3D2<br>&gt; &gt; + =C2=A0 =C2=A0DOCKERFILE: emsdk-wasm-cross<b=
r>&gt; <br>&gt; To expand on my question about WASM64_MEMORY64 vs --wasm64-=
32bit-address-limit, I would<br>&gt; expect the two wasm64 build jobs to sh=
are the same container.<br><br>Thanks for the feedback, I&#39;ll fix this i=
n the next version of the series.<br><br>Regards,<br>Kohei<br><br></div></d=
iv>

--0000000000007cd6f706483231fc--

