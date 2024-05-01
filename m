Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5596EC10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 12:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s28uz-0002js-1Y; Wed, 01 May 2024 08:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dario.binacchi@amarulasolutions.com>)
 id 1s28ux-0002jX-Ed
 for qemu-devel@nongnu.org; Wed, 01 May 2024 08:18:35 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dario.binacchi@amarulasolutions.com>)
 id 1s28uv-0006P8-He
 for qemu-devel@nongnu.org; Wed, 01 May 2024 08:18:35 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-61ab31d63edso6384397b3.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1714565912; x=1715170712; darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnzBvCVqhbTGTt6nanSYSYSaNoB0RC+t14a83D/oX0g=;
 b=SEAx8123VgBqWxQdxmUTuYrAbv7SCZU440OpeXP8FCiyufn51gzbhO1qZRiB+R4fZa
 MzWd6XE/dqodYR9Opfw/BUnQu7LnhBKnw3xiaNbMX5OE33C67ETkSy+NwyuougTAe/To
 rj2pf4pfUiEONADUpJmy2MYxWA7am7xGVhSIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714565912; x=1715170712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnzBvCVqhbTGTt6nanSYSYSaNoB0RC+t14a83D/oX0g=;
 b=jlEWEXPJtVICciMgmcsKVc9EPEhbSxU4x3ZYzIhhjNW2YHn918/IqxucdGfyncnywJ
 oQUB8Lo3HCBC3oAlqICknHGoW8x6KJ/gOpLHfb+g3M8vbN45+kiW0CHZv7R1acQQZq8Y
 lW1AILH3LEpNgLQ+b40yZB+mQ3jntr3KIO8bXYR0RYwi1Dx2wNwy0V5AMQyTdS2Lpubc
 A2M1HLpi82ENqjy8e45yzGlr9jfIIxDvByq28Gf2V9wgg+JZmZDCifokJrjT4AmT3mEP
 hpG6sI4tdkXLbc6NawxooYYhizMaaB3Tg/oi+YbByPsoinCtnXi8KwZB9R2889Tgci9Y
 tGZg==
X-Gm-Message-State: AOJu0Yxv8W/G3tlsBYnjt5xTczjstuNL46ST/TucONyRIJiWMT/gSM7e
 uMz7MP6OQYKkAZn/lRF3QETTGrhOM9QJ19UkyndJDWFg4jA+5mgmXrSW3bvAW1U+6v+hJzFQxBM
 syIJWKvJ4v4lhex2jKwEcI8peNVtkwIrHYpTZ4g==
X-Google-Smtp-Source: AGHT+IFU/mQiW1l52nqBXqV2sZH77FLPwfONZHWukguWybp7fo/laTmY6UJ80T2iWnn0PCompRMM1gIKgd0knhQfLpE=
X-Received: by 2002:a05:690c:700c:b0:61a:e5b8:7a18 with SMTP id
 jf12-20020a05690c700c00b0061ae5b87a18mr1807121ywb.20.1714565912301; Wed, 01
 May 2024 05:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
 <63094227-235e-4274-b308-2d7c27e50b81@linaro.org>
In-Reply-To: <63094227-235e-4274-b308-2d7c27e50b81@linaro.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Wed, 1 May 2024 14:18:21 +0200
Message-ID: <CABGWkvrCNoWDB=V5f_7qwCd97dAfOC3XT2ukXYt-FsxuUKK-KQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=dario.binacchi@amarulasolutions.com;
 helo=mail-yw1-x1135.google.com
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

On Tue, Apr 30, 2024 at 8:15=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/30/24 09:47, Dario Binacchi wrote:
> > The fp-bench test (i. e. tests/fp/fp-bench.c) use fenv.h that is not
> > always provided by the libc (uClibc). The patch disables its compilatio=
n
> > in case the header is not available.
>
> Since uclibc has had fenv.h since 2008, are you sure this isn't simply a =
case of a corrupt
> installation?

>
>
> r~

It's not an issue of corrupted installation but rather of compilation:

../tests/fp/fp-bench.c:15:10: fatal error: fenv.h: No such file or director=
y
   15 | #include <fenv.h>
      |          ^~~~~~~~
compilation terminated.

In Buildroot, where the error above is occurring, there already exists
a patch to
disable the compilation of the fp-bench test. This patch was created and ap=
plied
when bumping QEMU to version 6.1.0, but it is no longer applicable to
version 8.1.1.
In fixing the issue, I followed the approach suggested by Paolo
Bonzini, hoping that
this patch can be accepted and merged into QEMU.

This is the patch I just sent to Buildroot:
https://patchwork.ozlabs.org/project/buildroot/patch/20240501120050.670109-=
1-dario.binacchi@amarulasolutions.com/

Thanks and regards,
Dario

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

