Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F4EC8303D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Jul 2025 13:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uY3Ck-0002nM-Ea; Sat, 05 Jul 2025 09:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uY3Ch-0002mp-Je
 for qemu-devel@nongnu.org; Sat, 05 Jul 2025 09:45:19 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uY3Cf-0001m6-HL
 for qemu-devel@nongnu.org; Sat, 05 Jul 2025 09:45:19 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e82278e3889so1220532276.2
 for <qemu-devel@nongnu.org>; Sat, 05 Jul 2025 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751723115; x=1752327915; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vAzADomzvzG3vuEhtWdRZ67ijiw4oxxYZeyBDw4vN98=;
 b=Wb6LrojlSAxw1e5r/ovf/yAtUKya48osbek/bkelr7Ck9xqCnC1Aghz7oV8S0VTgNm
 XEwSrbHtblSrOHFxykP8uiTA4smiIAHNfkyPKWJtQNyNTBwADbRVGceBUTAVlV850zXf
 SDjTkU2nB2b6T/Ah7DVs1uRBmHFYVCTmm7MpeBqZP7lSvJNxVe78tw+suLIdntjZWDiQ
 Y6moS57cdhYjfzO3OXsPtRheoSFqGiviaBIrf2ydOhaFq6+1sF465vv1Cln03xpfbbHs
 EwntFAw5CL1TEXMuUEY1wmn0gh+y6t6w86+97kk4uJRMAPNqIQhs/7/UA3DCwKicwtQr
 avdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751723115; x=1752327915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vAzADomzvzG3vuEhtWdRZ67ijiw4oxxYZeyBDw4vN98=;
 b=ddwgzflw3z2cqx7UJBHEpWTvxAlutQqPO/56P8kS9kQoo7eVikElk/cG9Li4Tf564h
 2iz1uxvicwCuG+2G2fPo6HmElNm7AW+83pULN01K2xG0ASqgCf/WSsNr65mt0IOvAUP1
 aaI99OhuRW/to5JV3MSqIFhlItBvR708UGOSpwnMibJJ1cDDWQPm6OZlaaLyCOZOx3tG
 Fj4z2/4iJxM8WtmCM/Po2I5koUoXsLH985MSxMUOMwnJXf4bTYGobWkZQjXxEWUz+JgK
 ZohCX/WXzqkIioEq7C8p1tLMlZf1vTlj7vs/bywRHy4iQIxgi0iVhjI9NA/S3lVbpLut
 a0Dg==
X-Gm-Message-State: AOJu0YyqW4IAC/YKGttdJwxcTzrONOpu5rkChhGf8Eqhxdt0kZVJZCGh
 hWzAbvgbNeEm+E/4RpKHJuIoG9kkvufhaeOhM2s8isd0ryU5ux0ii6zDayGIh8RxwU9TJMoitqB
 KEtJoBPueyjhgb5OjPNkPPpn6Krs3UDeqbfqL057cCA==
X-Gm-Gg: ASbGncs+MQLjnv1w1QtWklddf3iSasEjiUzFwmueX+Jk1Qmq6v8eAPH2a9Vk4hCPThz
 PnD0FNQ2JR9mxMy+olNqAXqsPW48Edlvs8QbRfnFW90zb8Y8n+WxSioCkHpAvBHX72KxL/OrEFE
 W0R2LSs001hg5C7jPQLQXy3TgwD9p8aIoI/CKWhyYbRshz8bUbRbD2C3g=
X-Google-Smtp-Source: AGHT+IEd/N5LtfHoq3nAR6nc1z/hGIYP+8q2w9shu6DWCmTPI/pUqqfENgyjd61U5+p/hYBhl7ir20TFyGYI4OW/BVk=
X-Received: by 2002:a05:6902:2193:b0:e89:955b:4993 with SMTP id
 3f1490d57ef6-e8b3cdb8becmr2105706276.39.1751723115322; Sat, 05 Jul 2025
 06:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250704200001.1058849-1-richard.henderson@linaro.org>
In-Reply-To: <20250704200001.1058849-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Jul 2025 14:45:03 +0100
X-Gm-Features: Ac12FXwwFMQDLqBLNo5KVWV2BjMvDEgeINa3mD4labLgdCVj1Jp-ao1u5WOVPdU
Message-ID: <CAFEAcA8G8TKnYjmrD-ULcVnfx3wNLCyrCn7TuJ02tVP4jf5Lmg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Move cpregs code into cpregs.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

> Revived a 2023 patch from Fabiano Rosas:
>
>  https://lore.kernel.org/qemu-devel/20230113140419.4013-7-farosas@suse.de/
>
> which was dropped between patch set v3 and v4 without comment.
> Prune the headers from helper.c which are no longer required.
>
> Cc: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> target/arm/internals.h |    1 +
> target/arm/cpregs.c    | 9274 ++++++++++++++++++++++++++++++++++++++++
> target/arm/helper.c    | 9264 +--------------------------------------
> target/arm/meson.build |    2 +
> 4 files changed, 9278 insertions(+), 9263 deletions(-)
> create mode 100644 target/arm/cpregs.c

Rather than this, I would prefer that we continue down the path
of identifying specific pieces of functionality to split
out of helper.c, as we have already done with for example
debug_helper.c and tlb-insns.c.

The PMU is probably the next obvious chunk to split out like that.

This patch is also way too large -- it was practically unmanageable
to reply to in my email client. That also seems to me like an
argument for doing the split in smaller chunks.

-- PMM

