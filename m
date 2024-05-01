Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FF7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2AmD-0005DN-4I; Wed, 01 May 2024 10:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dario.binacchi@amarulasolutions.com>)
 id 1s2Am7-0005Ca-Ne
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:17:39 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dario.binacchi@amarulasolutions.com>)
 id 1s2Am6-00046R-5D
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:17:35 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-61bec6bab2bso17880897b3.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1714573053; x=1715177853; darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XThxcoil6vuOfWD4ZQjOc9lK9wnFqDEeiRYOO1Mx3I=;
 b=nDDGkNGVCaN3I9DFUzEzM7wCPyrM8aPqq4yq7KDHWdEDcNO0KWSN66o0o3QjW7x5Da
 ts0AYce6vBaaiN/sp9fUckGIjqh8kRlr8SuU5R3YNBCNv2hPPKW9alLOv3Fm8zcyt8UA
 QM7YiORa7cqMZ/bLpfN+1vVJ/9hAkXpqtKNg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714573053; x=1715177853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XThxcoil6vuOfWD4ZQjOc9lK9wnFqDEeiRYOO1Mx3I=;
 b=LfQ3ywmDYtlSVGSofYTTv2vGGj/OZIbOhnLxu3kh6jmsT/PWLzb/vkG0wdAubGhvCA
 omEJFGLsZB8K1nYonE8mkH8ISKLtDJXLL1Ce4wImtBUSpgPxNSP43NfAHeRw93lJVhmY
 TZUP+uvAhgCTIMt5IGJCHYDvEBbftr9n0apzsPm1sdmMU1ctWUzVGPU6cgQMNIIToJmt
 xYKmL3VklqoU8BJpEbtzbj7wXW5gHWDoK1D0jopSfSB3Ept+tVI6HdcjL5WrhSuq9u6G
 Kwb+qrqVANEOVPP5Yp8TyAbqBrAA5bgwYSy1qOB9L7fTUHKqTm22NQpH538iQ3f7yqlF
 R/wA==
X-Gm-Message-State: AOJu0Ywk+RA84sGcVUaFKb7oiu5bMn2kA7cTmIwMfqeTILwzH0bSesZ2
 2rj1n5fQwqKGzKGPFhFWn8EVfNRVAn8qxT9npVH6B1BGZfsooEI/JYJwVZ1FGknn/NVjB7bWHq2
 guZK0UXgYcV6ztO1i8ILU9QGJYfSScLbI2YZCmw==
X-Google-Smtp-Source: AGHT+IGdrdc8OrHKE+Wsu1WVCh7TrENYxsBvWR7OpR1l4sT4Z0ETvwm07OPbZHsDuUtl7mZe9NDcb5mGwNrlFdYanTs=
X-Received: by 2002:a05:690c:39c:b0:61b:6b6:5cb2 with SMTP id
 bh28-20020a05690c039c00b0061b06b65cb2mr3118946ywb.43.1714573052830; Wed, 01
 May 2024 07:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
 <63094227-235e-4274-b308-2d7c27e50b81@linaro.org>
 <CABGWkvrCNoWDB=V5f_7qwCd97dAfOC3XT2ukXYt-FsxuUKK-KQ@mail.gmail.com>
 <4ad368ae-74d0-4a38-b4d9-d907c1b8dc7c@linaro.org>
In-Reply-To: <4ad368ae-74d0-4a38-b4d9-d907c1b8dc7c@linaro.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Wed, 1 May 2024 16:17:21 +0200
Message-ID: <CABGWkvo_eaDFC15JQF8+Pu14M75CKWvVr8JWQ7XJuHc8fCc7LA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests/fp/meson: don't build fp-bench test if fenv.h
 is missing
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, michael@amarulasolutions.com, 
 linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=dario.binacchi@amarulasolutions.com;
 helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hello Richard,

On Wed, May 1, 2024 at 3:31=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/1/24 05:18, Dario Binacchi wrote:
> > Hello Richard,
> >
> > On Tue, Apr 30, 2024 at 8:15=E2=80=AFPM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 4/30/24 09:47, Dario Binacchi wrote:
> >>> The fp-bench test (i. e. tests/fp/fp-bench.c) use fenv.h that is not
> >>> always provided by the libc (uClibc). The patch disables its compilat=
ion
> >>> in case the header is not available.
> >>
> >> Since uclibc has had fenv.h since 2008, are you sure this isn't simply=
 a case of a corrupt
> >> installation?
> >
> >>
> >>
> >> r~
> >
> > It's not an issue of corrupted installation but rather of compilation:
>
> Installation of your cross-compiler or buildroot, I mean.
>
> >
> > ../tests/fp/fp-bench.c:15:10: fatal error: fenv.h: No such file or dire=
ctory
> >     15 | #include <fenv.h>
> >        |          ^~~~~~~~
> > compilation terminated.
>
> Yes, yes.  However, <fenv.h> is present in uclibc-ng, and has been since =
2008.
> So *why* is fenv.h not present?

I found the fenv.h files here:
out/emulator/host/opt/ext-toolchain/i686-buildroot-linux-uclibc/include/c++=
/11.3.0/tr1/fenv.h
out/emulator/host/opt/ext-toolchain/i686-buildroot-linux-uclibc/include/c++=
/11.3.0/fenv.h

But the compiler expects them in:
out/emulator/host/i686-buildroot-linux-uclibc/sysroot/usr/include/

So, I think that the fenv support has not been enabled in uClibc
configuration of Buildroot.

Thanks and regards,
Dario

>
>
> r~



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

