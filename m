Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD0CC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJaw2-0007mj-QV; Tue, 18 Jun 2024 11:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJaw1-0007mM-CC
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:39:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJavz-0003BM-MY
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:39:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42172ed3597so35228755e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718725186; x=1719329986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yu6Dtl5Me2scqu5zqgdTdZQnMfpjxhir/OsuntZ3Lmk=;
 b=d5DvPYGMPiO+xLFXQlUzdzMwrMinM9IL/pPbGegb1nDWXuHenUc9tk/WzUwBG7SOOl
 5TcbTrOoMQHprT22bBLcFrszIKg7qrZCA8ddiX4M5nGhuxtL46Fc+OfbR9GOiN3/LuAh
 o1MIlRx5h1wU6hh/+88Ml4F8wDS11vgXosgtbqJJXPN+tBb4N9+eHUUmuV9J5V+5tfm4
 sLJ4aqiCIhWbG8ZMQWAwoI06aopoB6ibf5LL1wghoVMRdhLzTIZFMdncSW4CdC7CKXos
 myLp9dDmbohZGwAXI8I/zcy/GhJYY9tsR6DpcDAoZVTAxzAELssUAdztNT0Fn8lrdJLa
 1czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718725186; x=1719329986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yu6Dtl5Me2scqu5zqgdTdZQnMfpjxhir/OsuntZ3Lmk=;
 b=RlGkCJJYzmr0O7dduDtHo+QtQejXMh/ZgT7XLKh4Ol1q+RTihqEE/jB2fcRrKhtFxa
 ttVV06ld+cbnf4bL1Z95qRW/dTQUJB1DZTkkEK95NV8U9S2jgTOsv7iRM0VEtQwhG37A
 CzUJfUlXPGSMdTYqt3ISBeCmXURV1p/cvVcEd/dNSoAhcq0OKmrzR0Z+TxQiYAGD3Lg5
 tEddm1zNym9tYO2UQ+plstuvbjgx8PbSNNNU+ZTm0W1cqdzmJ71fJIXYk82p9P8uqp3m
 xQ4G9SJLpnEnuQYS7iCxJM4sBHukvZIJV06s9eWBEDmYIhf45dccDwg1bICddkbAjZyN
 yMlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPlxebFLkFm6iZ6oBvFCYUyxvbl3Bv2WuIQmHZRqouRO7xGGZo2WF97tnhU4nstAIGnQvpyJ/my1Sc13Z05TB9ebv7OVI=
X-Gm-Message-State: AOJu0YwvybXxADmTIIZzePLB7sjXeeci0BwbSjKCaY9eE5hZUHp6/iOV
 lE36SwvkUyBV/kYPaJOMlpxr46VItfACprdBnTwu40zsWxgHCiIYtvkFqcdjm1afOemKhoFiL4m
 e
X-Google-Smtp-Source: AGHT+IFKCHLOzKeU/Pi/e6eQyzceAGhWTjq46RgDmM+Hb17HgP0Ngb4Ks5hqQgOHQROVaCndFSG25Q==
X-Received: by 2002:a05:600c:2d88:b0:422:12bf:27be with SMTP id
 5b1f17b1804b1-42474d1ee2bmr2522145e9.11.1718725186078; 
 Tue, 18 Jun 2024 08:39:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874e74c7sm228213845e9.47.2024.06.18.08.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 08:39:45 -0700 (PDT)
Message-ID: <9c61a7d8-c456-44ff-8062-c7eeca9dfd42@linaro.org>
Date: Tue, 18 Jun 2024 17:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc: Fix invalid size assertions in exynos4210_rng
 read/write functions
To: Zheyu Ma <zheyuma97@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240618145054.3144311-1-zheyuma97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618145054.3144311-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 18/6/24 16:50, Zheyu Ma wrote:
> This commit updates the exynos4210_rng_read() and exynos4210_rng_write()
> functions to handle cases where the size is not 4 bytes. Instead of
> asserting, which causes the program to abort, the functions now log an
> error message and return a default value for reads or do nothing for
> writes when the size is invalid.
> 
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display none \
> -machine accel=qtest, -m 512M -machine smdkc210 -qtest stdio
> readb 0x10830454
> EOF
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>   hw/misc/exynos4210_rng.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
> index 0756bd3205..307d4eea43 100644
> --- a/hw/misc/exynos4210_rng.c
> +++ b/hw/misc/exynos4210_rng.c
> @@ -146,7 +146,12 @@ static uint64_t exynos4210_rng_read(void *opaque, hwaddr offset,
>       Exynos4210RngState *s = (Exynos4210RngState *)opaque;
>       uint32_t val = 0;
>   
> -    assert(size == 4);

Here if these registers are 32-bit only:

-- >8 --
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 0756bd3205..674d8eece5 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -217,6 +217,8 @@ static const MemoryRegionOps exynos4210_rng_ops = {
      .read = exynos4210_rng_read,
      .write = exynos4210_rng_write,
      .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
  };
---

Otherwise:

-- >8 --
static const MemoryRegionOps exynos4210_rng_ops = {
     .read = exynos4210_rng_read,
     .write = exynos4210_rng_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
};
---

> +    if (size != 4) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid read size %u at offset 0x%" HWADDR_PRIx
> +                      "\n", __func__, size, offset);
> +        return 0;
> +    }
>   
>       switch (offset) {
>       case EXYNOS4210_RNG_CONTROL_1:
> @@ -181,7 +186,12 @@ static void exynos4210_rng_write(void *opaque, hwaddr offset,
>   {
>       Exynos4210RngState *s = (Exynos4210RngState *)opaque;
>   
> -    assert(size == 4);
> +    if (size != 4) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid write size %u at offset 0x%" HWADDR_PRIx
> +                      "\n", __func__, size, offset);
> +        return;
> +    }
>   
>       switch (offset) {
>       case EXYNOS4210_RNG_CONTROL_1:


