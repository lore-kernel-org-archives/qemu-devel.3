Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49C510F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYbu-000453-IP; Wed, 08 Apr 2026 15:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAY9A-0000LF-Mr
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:01:04 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAS9h-0001Jz-EF
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 08:37:14 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59e4a04f059so5822599e87.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775651831; x=1776256631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x9l7Y+FcS/abnFKTQjLb/clsdwbnnMt1ssrftjB3hL4=;
 b=zEUEkadegSJaI3wuT6h4eEC2X43z386zg31ITC2wTGhI1DFUJ4r0wrM0zJM3HflKvF
 dCodv3H6mgf/vsQiB+M1rG+CEMxSE1cS5lCTkBHlwLafVYMZmVlBRw1MpCtJqegOXmUt
 6t+jdVNInSAU04pebWWAr2ZgbD0Xown+ZMcHuYoVzcxhjWJHFE73H3duYspZsXJSEQ3W
 3wr+r9HZqpJx1PdejmiKUWVeK75uJulPGyXvpfAq3YDmH0zwaQXlaSKZWboHmd7ppKG4
 PBZFC+NhkMgyRFOqVt099PnZPAofQfOq8LUA5/bKwp03cuWjdcSrHjIJIlY4HWEddqmh
 D+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775651831; x=1776256631;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x9l7Y+FcS/abnFKTQjLb/clsdwbnnMt1ssrftjB3hL4=;
 b=tXBZHKXy7cjWBnWNMOGRG8vm5ZW5wxWOAIvY/iTyjLJMERyGuXwpYEyFt/nsK3neTa
 7Z1Ga0hdXLAUHDKEvo/XEnLcOah5QYLwFa0SdQpDwBghrq2TYtlEHQukMGSmE9ZjhRwp
 GOo8/pb2LDqgcbQBPbuIVXGBzeAF4i7f05cuPjqaeoA/cQcH5PKqwhys3mHWStybxK7u
 PjsamVB/AyFE7HBns8Lr8b2qL4gzz1Jb9iTXG09Pok9xPLsXr4iI2llvkG869nWigOcv
 B0/CvtWqBJlW6H4o4ROurQ0lDhRybynr47JJzBMoAO5cNFvEbjlfwyDN3gjdloOl3y2J
 hUHA==
X-Gm-Message-State: AOJu0YwvKvceIoVqYR9cMimU2eArpJ+WQgipeBVQhjepFsWjxWvzApX2
 JmaooUXACrR83lb2dPGauyousI2ea59ZFQ8UALNqtRlD/8yakiT3s0HtZzmHQTBic/h2AoGreDZ
 TDFjjhas=
X-Gm-Gg: AeBDietIAt3Isth5jr7uAxfD67t0juHj1CKN+MgFwZIzZdsSEx3tCBMZpfvh6+Wc9+k
 s0geG092UKB1nu885gUW/hEf5FhrmSh+IfhOT1HZJWM4ywItlPWXSUwy0C+zNECStNOsTVraxmM
 mWydfoAUSnpDLMGGMt+77rqAPQEhcSIp2/GZd7wThl7J9HZ2N+ZmK3jYg4l7u66cphx34RyuCvq
 i9uQ53DBeVuqanzOEcflkWU6y2sI5QneHN5pVU6tLyFd6h2IL3k7HaMqXoiWKNTR3UL74Wo8hY0
 wU0KyYJ4IEUyMv/t5fTyl/eUbj+CoOUxAC1KnjC+FRyg2wZpj0LjrWLOkFc6XPcgLOMM0ZuZrDy
 qroXLiyZ5wpXr6D0d7Xzo4v9EEL0HH1F6bysekOch7R2aB32ATRWT25cQ34EMD+mnu1RbBIRQAd
 Gm8Cb0sS3SRfPgPU2PoTp1aoDJXYQI0g7UB6bcCX1U9NkiVyqtcE8+vchgcQTzUvMSUA==
X-Received: by 2002:a05:6512:3191:b0:5a2:c9d0:16ba with SMTP id
 2adb3069b0e04-5a337560ab2mr5786884e87.16.1775651830814; 
 Wed, 08 Apr 2026 05:37:10 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cd37besm4674808e87.79.2026.04.08.05.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 05:37:09 -0700 (PDT)
Message-ID: <14805e95-c831-4eea-ae67-f011cb463cd2@linaro.org>
Date: Wed, 8 Apr 2026 14:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 0/6] Misc patches for 2026-04-07
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
References: <20260407215900.63390-1-philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <20260407215900.63390-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Cc'ing Peter directly due to mailing-list issues.

On 7/4/26 23:58, Philippe Mathieu-Daudé wrote:
> The following changes since commit b6a7d06213e5d2f7d124d16418bc289c4a8a4b82:
> 
>    Update version for v11.0.0-rc2 release (2026-04-01 20:48:02 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20260407
> 
> for you to fetch changes up to 992e01e838733c8063f8a17e92034c5f35e34963:
> 
>    ati-vga: Do not crash on 24 bits per pixel (2026-04-07 22:40:29 +0200)
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> Few fixes, mostly for VGA display models.
> ----------------------------------------------------------------
> 
> BALATON Zoltan (4):
>    cirrus-vga: Make frame buffer endianness little endian by default
>    ati-vga: Fix setting CRTC_OFFSET
>    ati-vga: Update mode on CRTC_PITCH change
>    ati-vga: Do not crash on 24 bits per pixel
> 
> GuoHan Zhao (1):
>    hw/arm/omap_sx1: map CS3 at the correct base
> 
> Philippe Mathieu-Daudé (1):
>    docs/about/removed-features: Replace 'since' -> 'removed in'
> 
>   docs/about/removed-features.rst | 32 +++++++++++++-------------
>   hw/arm/omap_sx1.c               |  2 +-
>   hw/display/ati.c                | 40 ++++++++++++++++++---------------
>   hw/display/ati_2d.c             |  9 ++++++++
>   hw/display/cirrus_vga.c         |  2 ++
>   5 files changed, 50 insertions(+), 35 deletions(-)
> 


