Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7394C021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnC58-0002U1-PZ; Wed, 26 Feb 2025 02:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnC58-0002Tp-1e
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:43:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnC54-00057m-2P
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:43:49 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso40946815e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740555823; x=1741160623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8t+T9G+yHu9JbK9WhTia5N6b/9x/acvrQu5h26gwb/U=;
 b=bZn1q6hH/ZtTZRHQFuwHrLGAJ1pT0mGOg7yJX0YCzhWFW0zx4OKtT7e1lKKdd580HX
 9Am/ThM98WbL2ElrUyzddjd15JTyP9Ig1T1zglbUj66rdExR0+tYflWMHewBR1eju0uv
 KvPQL2hxqVZzV0oL/QjsCu7aNVnva9gXrRCZ72+j3y6l2dPKdIKRJRmGULGZpvot3uO1
 NYJ+ePmOXp5UshPcNwUByxWMOhGkHZjLDxWNBuc5S/PjgHJjl4AtmFSk9VQOD+qdZLtW
 OOq9rWIFMyCZUxVbQTnL1CRvrNU7V85stlUT2smdEjV8PVJKsy5TVEIrGdAcMRU++muu
 UboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740555823; x=1741160623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8t+T9G+yHu9JbK9WhTia5N6b/9x/acvrQu5h26gwb/U=;
 b=Of73yP2gRhIodl3Dgc6dpP58p7fxjM1IOR6HlYI/fL8xpVHKWHQ3165LFx9tVm204U
 NXTD5oCYEuu+fmjiKsEPy7VCM+VqPCRJKdqIPvrSVoc1tCSnawqpUi1+PDDko2BzRA/7
 3wbhIBjM3wMPZ6fVcikTjU5qrsZ9aF5y+xYyQ/nJwbEAKDLCecla6gDJ8Ei3naQw+D3i
 2xvlYgF0u8dFGHphEj+BUFiTMyKRH4tX5QehxmIkHLRDj1KfjqfZNvvADKcGGT0JsDsq
 wRz0/v08gHaBPfEHudO1ZbxWqE0arGfYG5Z4AsBuo86qqYT9sk4GTXbjO6ov+C4Xpit4
 13lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8B6OlCEwnfkpR7amjVq0m3QXgV9/pSyegpei4N+8Et09/WGcS31mziAfBFnXHOOOxavzHU/pAhBs/@nongnu.org
X-Gm-Message-State: AOJu0YwGhyL7isiy1zOIwv3Ks7w6Xywp5DKISommOYD41ZJI/akDcJxj
 JaQ3qA0M/dR0y0L6++TtHY2CQ1aGfvTXEmSdXgzoe5ZmeaEyKVpl2e5C792YGqJuwAOqDAsRj1Z
 xjlE=
X-Gm-Gg: ASbGncvP7BLmQBcsKM+Eq75Y/HYQIC1mM5dbNumiEwHyJtDeFuc0qRgjHNCTbxWFRaB
 MTTPM82IHySGfgYJe4ORft6qNcud4oMfG0IaaMt7foMJPWzf1nVWtgejF3IgI/7mj3uJEWcbKLJ
 XoVK1aDKvjgNgFUCdpWPAxgZ7wmi4EI8BzVYIMFMqBIo1XBmdXvw7UwMYjb3GhP7nnWuaDSKOCO
 4L0W1MRk3mFpB5gJ3Bz10xOHoES+T0iFNffiWVbxXTKqYaSMSUg4PVes/C3rAudPeMeVfAW0Mz1
 7wxRQcqTG2+z0kRRVQPSV5DTz/y9j0uYp09EaEK3Kwc2+arI7Mf/bWQewLXifziu+ic1k+E9v3Q
 =
X-Google-Smtp-Source: AGHT+IEJ/nmdtz57Oo1iMeGm64SjqTmHZ/sLWvHvEhG4SrcA0WFAt3iYci1ayYg/r/dJW90adbBgLg==
X-Received: by 2002:a05:600c:3148:b0:439:88bb:d024 with SMTP id
 5b1f17b1804b1-43ab902aa93mr15587075e9.25.1740555823012; 
 Tue, 25 Feb 2025 23:43:43 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba543ebfsm11620275e9.25.2025.02.25.23.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 23:43:41 -0800 (PST)
Message-ID: <10d4a054-7cae-4a97-bcdb-f380918722b1@linaro.org>
Date: Wed, 26 Feb 2025 08:43:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 017/162] tcg: Convert xor to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-18-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 17/2/25 00:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        |  4 +++
>   tcg/aarch64/tcg-target.c.inc     | 31 +++++++++++---------
>   tcg/arm/tcg-target.c.inc         | 25 +++++++++++-----
>   tcg/i386/tcg-target.c.inc        | 27 ++++++++++++-----
>   tcg/loongarch64/tcg-target.c.inc | 29 +++++++++++-------
>   tcg/mips/tcg-target.c.inc        | 28 +++++++++++-------
>   tcg/ppc/tcg-target.c.inc         | 30 +++++++++++--------
>   tcg/riscv/tcg-target.c.inc       | 29 +++++++++++-------
>   tcg/s390x/tcg-target.c.inc       | 50 ++++++++++++++++----------------
>   tcg/sparc64/tcg-target.c.inc     | 23 +++++++++++----
>   tcg/tci/tcg-target.c.inc         | 14 +++++++--
>   11 files changed, 186 insertions(+), 104 deletions(-)


> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc

> +static void tgen_xori(TCGContext *s, TCGType type,
> +                      TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    tgen_arithi(s, ARITH_XOR + rexw, a0, a2, 0);

s/0/false/

> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


