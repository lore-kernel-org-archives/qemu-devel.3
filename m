Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CF1C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2UW-0005Nv-3e; Sun, 26 Jan 2025 08:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2UN-0005Ji-16
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:15:48 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2UL-0002cP-H4
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:15:46 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so83657675ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897344; x=1738502144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lKKxI1gMfL1dIlJV1iEDBEAd23zUDx/yvtuvsJUzuLY=;
 b=UrxzoqLT8HvqA2QPKFXr41+KKWPNO7Hm/KwhK45wMu33BGBOPNnDYcDma7lBTAx1nB
 /Fz414QveLnfjUW4p/rvVEEQDdwbRlkO3WeLQyXpWLKt7Qy14pW40jdBcmpM/SgRkuVE
 Kd0gYObIZ2m2txdP8DjbJwuOB7OrNPchIdBuem6QDpv7PK9CE2th0WlRiof9gRvrnkwV
 OuhSkAVX6rspxEzmFZ1l/3r314YIri6chM+1A1+sKfJUQutmsTec/VfgIXk1NOKgBJin
 Z+6Qx6bQ5ixWbpgCON4DdS0cInu8801SsocjlkK9L1dR4IwM2eDlOgjS9aBM3hf3JdyD
 WKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897344; x=1738502144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lKKxI1gMfL1dIlJV1iEDBEAd23zUDx/yvtuvsJUzuLY=;
 b=IpfaR/htFylo3edW8bRYieOcUiXjIZxdrPDFbeQEqVudDI9qIqp91QbCIZ51sMMGuM
 YlFZsBZjJCvRb5bAsM98cVqmRWVrcd1XjILzxbz/2X3Zn8Ep2D71Z9vU1vganIWEpU8m
 sbsNWlHSs1f3Lm0A276RU19Sk7C8BKCkkuAe27KnYKkJVGlLkYXtLVfQxTqG8o0dCSHq
 ADwqFRPlvFPgvM+ugxv8fGSwtfFUyOL0aeY+WlM3B2b1F74AjMiMkili3XWvphOk6nwI
 uyVwknAuqtUGBUMDzhjr5NsrZd5M8MH8zon7FmCRsx0xQf9PA+DCw9tQ7EaR0Qbpnasj
 zCYw==
X-Gm-Message-State: AOJu0YxSht6Rk7tFBnopMM1oDOdRvSBYnrFkR2grFK7b5hUxi6byj5Up
 kizLGidayp9yYca5GZ3YOx9PEjpGrMk40cCiOGdJaP2M9rZ8pZFpgi8vHYT1Y9aFPes0x9nYcT9
 M
X-Gm-Gg: ASbGnctqpAGy1o6LecmGU981dRKjTSJ3pFWVTurw84W3VE6NT9V2ld9wogqF8Lap7es
 HbZNt1cQWrwgLUaclfZ0wynMmjDxoC0+wdwpPA2Qfsi6Ivc98yTq5nYdhcoruTIYXdzZ/cG2Xx9
 x4s2W2MmL2AH7e2swnMazCo36ELRr2DJXGb8HAqZccojkuFKVtWEdQh7d0KMhM7YgVXBINTcszL
 Py6fx/I8pxAdf2CZusc7BKhniMxrkFgQVKhKrXARMzRMDoNR2HAGnHnO0eITMAc5VEo2EEoUDnC
 RNk0TgNPD+KpgybIzHoAvHo=
X-Google-Smtp-Source: AGHT+IEMpULhY0+65SrR2AWTHAtjunCGh2dh15Oj/Lud2VngHmJUveb4xkIwKgBfbljRhyFgda33kQ==
X-Received: by 2002:a05:6a20:d48c:b0:1d9:a94:feec with SMTP id
 adf61e73a8af0-1eb6968a470mr21374090637.2.1737897344057; 
 Sun, 26 Jan 2025 05:15:44 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a78e0f9sm5146177b3a.158.2025.01.26.05.15.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:15:43 -0800 (PST)
Message-ID: <33eb2239-ab2c-4702-8b7d-e81b1e70972d@linaro.org>
Date: Sun, 26 Jan 2025 05:15:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 62/76] target/arm: Handle FPCR.AH in FRECPS and FRSQRTS
 vector insns
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-63-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-63-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/24/25 08:28, Peter Maydell wrote:
> Handle the FPCR.AH "don't negate the sign of a NaN" semantics
> in the vector versions of FRECPS and FRSQRTS, by implementing
> new vector wrappers that call the_ah_ scalar helpers.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
>   target/arm/tcg/translate-a64.c | 21 ++++++++++++++++-----
>   target/arm/tcg/translate-sve.c |  7 ++++++-
>   target/arm/tcg/vec_helper.c    |  8 ++++++++
>   4 files changed, 44 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

