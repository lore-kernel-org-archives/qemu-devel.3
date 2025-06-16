Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F208BC71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6aa-0004JE-VI; Mon, 16 Jun 2025 05:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uR6aL-00042A-ID
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:57:02 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uR6aJ-000367-Im
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:57:01 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-710fe491842so30967847b3.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750067818; x=1750672618; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I235erRaayFx7BYOEeId81HFtNTQgLr8vcqgU7Z0iuI=;
 b=nrqGx2UR5elY41J58VmEhxi8ryEdIboEPr8QR5KCqtnKAMOIsQsmdaoMgcw0DOwABg
 4xnz6kS41mQUWr/YspRDvTX+qxQYgSrN+n4MA2lhwfNnPk56mHs0Cvul/PK9qOez9WSW
 LMFDvvB1DmJ9JBscosNbOLO1Q7pd45GpaHYdUC32HrRcD423RPftIQ5t4/EUaCJQ/JTg
 wFalW9lcDaO6c62TqbjDICXMPyypr7tv60NEuQny4yj2k0qWA+CdpsuqQKzH30/c40ZJ
 CIiogkxYCCf/wrgqpJd4TwQV5X1WbV/hIl1K6UgHqwg4Q9aD/ATqV9Hy8SSUEHCD9u/8
 CogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750067818; x=1750672618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I235erRaayFx7BYOEeId81HFtNTQgLr8vcqgU7Z0iuI=;
 b=W3pRRgLyLUP+2fz8HydwQ3qAHVNUSlABCZga6Xp5hupa8ZYnbv4LkcMWJ6P02fxk6Y
 Q3Qt2F5kDawBcl27kpdVl25o0b/8nbQk3FrzhYrC6gVr013iEQkj4aqLCacmMJpi0I8v
 z0WWgT+lBHsStEkVf/v6oLBB23mcPiy9dmv885mT1tFZvQobhXfOe/2IQ08itef0JpTK
 c5nsbz0koyCno2CBB75jAvRLJItFSh8YSgtH/es5JQGPgwIIms3xLVs/WyYbNz9vtsrJ
 IMdeMgU/HykbaKVfagmG9SlJA081mA1EJjAlbBV9+4qdDMZzwikFNRs2t0cJuVPLolyF
 Oxxw==
X-Gm-Message-State: AOJu0YziXro3fC03Uq7XE9VCLAV0B9lRoPhDkuAAphks33ZW4lfUBcFr
 JaTmLiMopVMRqAzc/OzItSwMyNjZnDSejT1AV8sBMaqHyJug9yehIfqKBcCKcPF0puSP2iFKRhI
 tywMEkMHRTLiz+Ek0D4heIbtagI/BLcTWDKCKSDqoig==
X-Gm-Gg: ASbGnctRdz4AHR79GQm25vkhw6bwPQg2SXPKzcpxuDvS/CrPnfDBhvjcCi8wWQh7FSK
 fqVjUJC7eYqfC2eL5Y5PahT9c0x6QZH8uROtCqLRr6gHAopDF/RWK85JyZFgLx5td17z7tgJLqg
 x48fcXjeXvkxvau49PCR3kacTPPw7wknHzH8zboEaoPiHkOlRHVPAOY9M=
X-Google-Smtp-Source: AGHT+IH1b9ORrUmBrwwoo5kXePYtutdazqPQBKkvme32P2sU5A1G2NCcH1B1VeTIGuom34r0DAxADMnrkedbS1cTcSw=
X-Received: by 2002:a05:690c:4901:b0:703:b5ae:a3da with SMTP id
 00721157ae682-71175457d73mr126992267b3.32.1750067818209; Mon, 16 Jun 2025
 02:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250510042043.2056265-1-jcksn@duck.com>
 <D705B9CD-82EC-42AF-A370-21038E35BDC1.1@smtp-inbound1.duck.com>
In-Reply-To: <D705B9CD-82EC-42AF-A370-21038E35BDC1.1@smtp-inbound1.duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jun 2025 10:56:46 +0100
X-Gm-Features: AX0GCFsOdMl3U_gcU8YKi8GM00c_z8VA6n5RHXIAOTqhohQTStioIgHzaiSiH3U
Message-ID: <CAFEAcA83NzkG7NgwAyW9X12YLm5m439_b4y=M0dS6eR14-y2Gw@mail.gmail.com>
Subject: Re: [PATCH 5/6] MAX78000 TRNG Implementation
To: jcksn@duck.com
Cc: qemu-devel@nongnu.org, alistair@alistair.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sat, 10 May 2025 at 07:57, <jcksn@duck.com> wrote:
>
> This patch implements the True Random Number Generator for the MAX78000 SOC
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  hw/arm/Kconfig                  |   1 +
>  hw/arm/max78000_soc.c           |   9 ++-
>  hw/misc/Kconfig                 |   3 +
>  hw/misc/max78000_gcr.c          |   3 +
>  hw/misc/max78000_trng.c         | 115 ++++++++++++++++++++++++++++++++
>  hw/misc/meson.build             |   1 +
>  include/hw/arm/max78000_soc.h   |   2 +
>  include/hw/misc/max78000_trng.h |  35 ++++++++++
>  8 files changed, 168 insertions(+), 1 deletion(-)
>  create mode 100644 hw/misc/max78000_trng.c
>  create mode 100644 include/hw/misc/max78000_trng.h
> +static uint64_t max78000_trng_read(void *opaque, hwaddr addr,
> +                                    unsigned int size)
> +{
> +    uint8_t buf[4];
> +    Error *errp = NULL;
> +
> +    Max78000TrngState *s = opaque;
> +    switch (addr) {
> +        case CTRL:{
> +            return s->ctrl;
> +        }
> +        case STATUS:{
> +            return 1;
> +        }
> +        case DATA:{
> +            qcrypto_random_bytes(buf, 4, &errp);
> +            return *(uint32_t *)buf;
> +        }

No other code in hw/ calls qcrypto_random_bytes(). This kind
of "almost no other use of this function like this" is usually
a hint that it's not a good idea in new code. You want
qemu_guest_getrandom_nofail().

Also, instead of using a uint8_t buf[], use a
uint32_t and pass the address of that to the function:

     uint32_t data;
     qemu_guest_getrandom_nofail(&data, sizeof(data));
     return data;

That avoids the need for a cast.


Your interrupt generation code in this device doesn't look
right: the interrupt is supposed to be generated when each
new random number is ready, so in our "generation takes
zero time" model a read from DATA should provoke a new
interrupt immediately (assuming the interrupt is enabled):
you need to simulate the ready status bit going low and
then high again.

See also my comments on an earlier patch about the usual
logic being to have an update function which does
"set interrupt to (condition && enabled)".

-- PMM

