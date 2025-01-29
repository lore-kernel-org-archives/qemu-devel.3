Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FCEC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC5M-0008Se-Qd; Wed, 29 Jan 2025 12:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC5L-0008RF-9f
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:42:43 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC5J-00045c-UW
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:42:43 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436249df846so48728575e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172560; x=1738777360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vR2LlLQyLhJCoAQsX05IW6IymGCHfWdSp7r/12LB53U=;
 b=OGNyDejj3AHdE7yu51cj2CTF3HPrg/RcsA2Xl6+5FhT3h3sB3R+BHCzK9F+qKO08c7
 LAQmTL8rg2QbgPdg53D4kPKkiq15kFwyUwBSQkUj3Q6cnX5O8y6fI1S16EIB4rNdJabf
 iGi/exDgfnNPdWkB+HyzSYc6sShX80WxDuGv49Bdgbe+qsjNYvBTxzGKv9KHDanVVsKj
 m6oKeIz/mkD+LrOE120RzaG9vXrpf70NVSlD4mtoSnG99SFTIzGN1eqg8ApH1BZQKoTP
 zOCCoKpZTCLeSkOXiVgNqNDKVfFGi3aX93ZQGmBSxDwFGSNtqRZumaWEZDJya5eNNGIY
 PB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172560; x=1738777360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vR2LlLQyLhJCoAQsX05IW6IymGCHfWdSp7r/12LB53U=;
 b=ANc+RvMNXA4v0RSWLdQQ+BjnNllBD16xBpN2TC7rHsImBaWg5488QMRKr0evAriJIJ
 GQG0rtshsM64EjUIpwNlTl8sUoZ1u5INBlY00I98uGLbopyNp8MWzxTKGb30GHkbLZ/K
 /fDg9rIXO8NDSVAYmTrkpY8KHgUP4ZlFJMIkZgW6HD9nCCz5I6y8rRHD6xEAv7w+11/z
 nzuUz8E4sJHnjl8m7NKVzkkCLtT4slL0f5KflpjQ8P0McHrBLvdXedDDEL5VvuvQDuSP
 5WIdwgUAKTPH2fWKUgQmhlOAgCjEYdVDA331gKUjoKQXQwzbaqWNNDo5o5cGHu9VJX97
 9gCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpJHf92ox9kTz5PQPmieGyyEvk6oAiZQzAbqSFHugZh7j040GAWJIw7e9g4miI3G2B34yLxOkuRVRs@nongnu.org
X-Gm-Message-State: AOJu0Yw7AXkhw7yMDgGVJns0QctZLuZD18KdeuV65Wfz0aajNObFF9ls
 I18++duS44jMmjRD048bAUo3i7uNHMGTprcCIKlFV2VRCZbnazl3ZrG4+yJXa92bNvNHuop9d66
 gHro=
X-Gm-Gg: ASbGncuifp416nKXlG2b2v25A4rHv/e275HofS2DuR4/066a284YK5YWNHcmzL7gsVR
 +5kpE/o8re52rGvAJmvVLPW+0xoegicFwOFjnvU+DE7MCRdEg8TNYqVIa4q9Y7NSfkSHyUk9CRF
 FsPBfR/YH7J32I6N+1WfLOqER/JG2Jf90RL3wTgtaV9QR3TrVUbRElFTLAhpPKkixL8AyMDi53z
 fLi1VdVwPT7T4cbVHZYlatWB22seixMgYYB8gznn58/fuyTY9UeVZ5HOgwdTPdQTF4h0vhhNA5p
 8tEiYAsp20HzFQn66DwMx/q367lp4FCLSztDANrkC5vdDx6O2thfF4KS3/Y=
X-Google-Smtp-Source: AGHT+IHUrSlSNo6v54XgkKnMVZaJuFomRbeUMSAUbMsGG1HJlk/6tGgWYqSk0noEdG3NgKA4dCTE1g==
X-Received: by 2002:a5d:64ee:0:b0:385:f3fb:46aa with SMTP id
 ffacd0b85a97d-38c5209627cmr3906603f8f.43.1738172560506; 
 Wed, 29 Jan 2025 09:42:40 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188d5dsm18150064f8f.55.2025.01.29.09.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:42:39 -0800 (PST)
Message-ID: <a15c20bb-06fc-46a5-825a-6d2099d9eee8@linaro.org>
Date: Wed, 29 Jan 2025 18:42:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/34] target/arm: Rename FPST_FPCR_F16_A64 to
 FPST_A64_F16
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     |  8 ++---
>   target/arm/tcg/translate-a64.c | 44 +++++++++++------------
>   target/arm/tcg/translate-sve.c | 66 +++++++++++++++++-----------------
>   3 files changed, 59 insertions(+), 59 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


