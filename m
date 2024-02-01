Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE81C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVVjF-0004zO-40; Thu, 01 Feb 2024 06:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVVjD-0004zB-OT
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 06:59:35 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVVjC-00042a-4i
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 06:59:35 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33b0f36b808so512066f8f.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 03:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706788772; x=1707393572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLNggEl6kK8C/5ay3gOL9BLXu/Rod+d/clSjE0qhJ74=;
 b=VLYoUb5XnOPbZZNMKHPQ+UrcQRs7V/QQPL2QTS+qLxCvUVSpKa7PPSPvece2cWTq3D
 F/oRPNGyOFHXe4FXgajNnK/7BcSUM6451SuTpXX/PUybR8+KPhbDLlJnCkVRntQg9FpA
 CQ0R0/W18oTTcj/K0Ia8bdI434GejbYkOupZLzbRHLGVY8ig2bqgOKTiYksJRBTTgxwK
 cYry25qIbApXhANG9Cc1I0UQeTSYHl0heX8BLtH47DHG7l8oVQT7dX0a34EpOQiVY8U+
 FXVU4KYua4j5nSxpl1QWRNvqwuqXqtKgGEv6AG/TT7MfGWMp+pv7My5deSUINXdsnqED
 LWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706788772; x=1707393572;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TLNggEl6kK8C/5ay3gOL9BLXu/Rod+d/clSjE0qhJ74=;
 b=Fxv5UzUlyAOKtT8FXG4ir62mlF1yD7AZ8nWXt92QAO5M6XugHGzN3ErLZ+VYTAvGmS
 wGpqTeieOCjx4VBPXAEHjERNeOIc/S/RSiXqk7c31SIFegO3o58CRC03bL5y+5TYqgEj
 ZWML7JCHMTUlAvwqw8MmpMCb5ncLT+AJWmqdC3qkhtXv3iuuStMbTFBCB9jKBS5YMzfe
 dwMe6LyhrhpYXa1xP1fBvnAUiZol/P3YXrxv7iHbYWlOy2kgAz8AJzXGTkgHMcoL1ZQD
 GRTahBRukmmKUMPSVkDnW71U40OCIKo34AkMb9J9yVlmqppkg0cGK3moQkBqEqVrweIX
 UeKg==
X-Gm-Message-State: AOJu0YwwAe6BrG1ZN8kNA4+JY7mXhexrEUwbr3OaF79T3ulq9mB2fxGs
 Sg5FAhXmseHuO+2NQ7JurK34svjekRCXzUsyfFfHNpWYFWzH7xJzPn+ZSiT4NiE=
X-Google-Smtp-Source: AGHT+IG3ssf398iSUA51EYeFxgCBXRHUoBbE9ZgKxWMyvMWSkcARt2xsrC3nhLpT49/4QDEyPbeBmQ==
X-Received: by 2002:adf:dd86:0:b0:33a:ef2c:7a4c with SMTP id
 x6-20020adfdd86000000b0033aef2c7a4cmr4173164wrl.56.1706788772467; 
 Thu, 01 Feb 2024 03:59:32 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUHYXeI9692ANPryfzRkQQ1t9Jl7WveTrN3HlMijj3EZmvkutL0vww7VWjdVzzvWYVAoLTogzuXJEbFScAie68xCY8Yd9tfjAttsWni3knTVy/oArZHASp+z20X6JC6EdQ9T6rf9IIRvuI8o49vxw+kzPGLTeLv
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bn7-20020a056000060700b0033946c0f9e7sm16197376wrb.17.2024.02.01.03.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 03:59:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D6B335F7AF;
 Thu,  1 Feb 2024 11:59:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] gdbstub: Implement follow-fork-mode child
In-Reply-To: <20240131205031.144607-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Wed, 31 Jan 2024 21:43:38 +0100")
References: <20240131205031.144607-1-iii@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 11:59:31 +0000
Message-ID: <87il38mm3g.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Based-on: <20240116094411.216665-1-iii@linux.ibm.com>
>
> Hi,
>
> I needed to debug a linux-user crash between fork() and exec() [1] and
> realized that gdbstub does not allow this. This series lifts this
> restriction (one still cannot debug past exec() though). Patch 1 is a
> preliminary refactoring, I can split it if necessary.

Please, I think introduce the api and then one each for adding the hooks
to *-user

> Patch 2 is the
> implementation, and patch 3 is the test.

Always good to see tests ;-)

>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg06424.html
>
> Best regards,
> Ilya
>
> Ilya Leoshkevich (3):
>   gdbstub: Refactor fork() handling
>   gdbstub: Implement follow-fork-mode child
>   tests/tcg: Add two follow-fork-mode tests
>
>  bsd-user/freebsd/os-proc.h                    |   6 +-
>  bsd-user/main.c                               |   8 +-
>  bsd-user/qemu.h                               |   2 +-
>  gdbstub/gdbstub.c                             |  29 ++-
>  gdbstub/internals.h                           |   3 +
>  gdbstub/user.c                                | 225 +++++++++++++++++-
>  include/gdbstub/user.h                        |  11 +-
>  linux-user/main.c                             |   8 +-
>  linux-user/syscall.c                          |   4 +-
>  linux-user/user-internals.h                   |   2 +-
>  tests/tcg/multiarch/Makefile.target           |  17 +-
>  tests/tcg/multiarch/follow-fork-mode.c        |  56 +++++
>  .../gdbstub/follow-fork-mode-child.py         |  40 ++++
>  .../gdbstub/follow-fork-mode-parent.py        |  16 ++
>  14 files changed, 403 insertions(+), 24 deletions(-)
>  create mode 100644 tests/tcg/multiarch/follow-fork-mode.c
>  create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
>  create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

