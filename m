Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8136FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 16:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXNYG-0007C2-91; Fri, 26 Jul 2024 12:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sXNYE-0007AN-AQ; Fri, 26 Jul 2024 12:12:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sXNYC-0007dj-G1; Fri, 26 Jul 2024 12:12:13 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc60c3ead4so6728965ad.0; 
 Fri, 26 Jul 2024 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722010330; x=1722615130; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hgXNQEzRLdYHiVI7AHOdUc7zVu+GidlwDBLsRMI2IM=;
 b=jbUMsv4fsQ8qod1XE4T70/L+64d6hExccdWg+BQpn7KzBT1mosiWTdOAfto2upuh4K
 6vgUv33FOv+xBqDymr4op5ykQ2bI1I/6WjtFVK7Nwqn9X6EiyjgiGxd1XSgBeJLFt9aM
 bPbx5+p7rFgIc8AjbEEE1f1EYl7Qi7ovxkb4vZT5v6wVw04tlWufp331M0D5ND5qoQgX
 Mc7k3dw66YHUN3+M8cXPNo/R5ewFmDGxuYnxE/MtZcdXE5FKRnJfB7WC4L6atcYX/7ud
 XrThNlwJQI0PCaK8Lf683KaWIIdE5K6RzZvXbV6vvh9biGVSoh/P/zAyYL6wEoVtCH2g
 gVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722010330; x=1722615130;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4hgXNQEzRLdYHiVI7AHOdUc7zVu+GidlwDBLsRMI2IM=;
 b=HdUaC+N3FEXgXIBszECrcfsDcIoSJJdTRLvfInVh2L5YsgpjTKo1FxS+XA0l149afv
 5FjBz4KeXKfbH/oZO0MRsne3jtvgzATZM8temEH0u1C7wQLDgAzKc3Wn+7KOwZmEJ3bu
 AWr9IgtcPOchNLRd55kuS86EpCsMqkreAesypLz4RUuIpTPAYpf944cjPOrJowGwfbel
 TbX+Yw9sERy5AiMOKl31j+PF8qrFX2QCHSAd/0W4r/EKdGeaKCgQZ2b5QK+/68Y3bBfN
 yT0V8K76Wkh3eTUE0m6CupwPDO2N4B9T+sy66+uzAK/1Fx6GEjEdopKEzOFlsgnyoTZc
 8qEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtzmBNl/KPRFU2xUgbqRzfHXQU98oGKP4ZXBSxxRfDOXIbGZK4Lz+nfoPer/NwsX0rZoKAGTbrCwd7lt064AoH327oe0Q=
X-Gm-Message-State: AOJu0Ywbha3DIq5xo/GHfH3SL88+IhetXEpvECzw3Ku82H8XGikmnowf
 6TQE7ho3PPbTmOu0hlmZR7fWbW6CtCrfMKojIjcioYFVB9zSTrmi
X-Google-Smtp-Source: AGHT+IFVoNhvaebh9lZIMbhm+Rw/SUNhwID2nZLx1BerZejvDkXZHY8JKN4vf6axxazcMsj9SMbKTg==
X-Received: by 2002:a17:903:41ca:b0:1fd:9c2d:2f1b with SMTP id
 d9443c01a7336-1ff04910c43mr1027885ad.52.1722010329948; 
 Fri, 26 Jul 2024 09:12:09 -0700 (PDT)
Received: from localhost ([203.220.44.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7fb67e4sm34389475ad.265.2024.07.26.09.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 09:12:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Jul 2024 02:12:04 +1000
Message-Id: <D2ZLPPXLALZ3.KAYHZFD2OO8B@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Peter Maydell" <peter.maydell@linaro.org>,
 "Richard Henderson" <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] tests/tcg: Skip failing ppc64 multi-threaded tests
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.0
References: <20240725154003.428065-1-npiggin@gmail.com>
 <3919ac75-1cce-4fad-a0eb-4ec11865c011@redhat.com>
In-Reply-To: <3919ac75-1cce-4fad-a0eb-4ec11865c011@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Jul 26, 2024 at 7:11 PM AEST, Thomas Huth wrote:
> On 25/07/2024 17.40, Nicholas Piggin wrote:
> > In Gitlab CI, some ppc64 multi-threaded tcg tests crash when run in the
> > clang-user job with an assertion failure in glibc that seems to
> > indicate corruption:
> >=20
> >    signals: allocatestack.c:223: allocate_stack:
> >      Assertion `powerof2 (pagesize_m1 + 1)' failed.
> >=20
> > Disable these tests for now.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   tests/tcg/ppc64/Makefile.target | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >=20
> > diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile=
.target
> > index 8c3e4e4038..509a20be2b 100644
> > --- a/tests/tcg/ppc64/Makefile.target
> > +++ b/tests/tcg/ppc64/Makefile.target
> > @@ -11,6 +11,18 @@ config-cc.mak: Makefile
> >  =20
> >   -include config-cc.mak
> >  =20
> > +# multi-threaded tests are known to fail (e.g., clang-user CI job)
> > +# See: https://gitlab.com/qemu-project/qemu/-/issues/2456
> > +run-signals: signals
> > +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> > +run-plugin-signals-with-%:
> > +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> > +
> > +run-threadcount: threadcount
> > +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> > +run-plugin-threadcount-with-%:
> > +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> > +
> >   ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
> >   PPC64_TESTS=3Dbcdsub non_signalling_xscv
> >   endif
>
> Could you please check whether this is already fixed by Richard's patch:
>
>   https://gitlab.com/qemu-project/qemu/-/commit/8e466dd092469e5ab0f355775=
c57

Okay removing the sanitizing entirely fixes it, e.g., this patch

https://gitlab.com/npiggin/qemu/-/commit/6160a7dd834b2d0e7bb08f13f709693ffa=
7c8d06

Result:

https://gitlab.com/npiggin/qemu/-/jobs/7436997610

Thanks,
Nick

