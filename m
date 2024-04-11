Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CAFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 20:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv0hh-0003K0-Dd; Thu, 11 Apr 2024 16:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv0hc-0003J1-O3
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:07:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv0hb-0006nQ-4C
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:07:20 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6eddff25e4eso231490b3a.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 13:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712866032; x=1713470832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RjJZcjUlCUYpyhqM4iU+yENzWXNTqDQyMdK9vg5KE50=;
 b=vvvlhYmPSuG3KVuR8PlTsI+GzS8f9We6wQvsf2RUf4EypUgA6RyykrmdI9B0INuj+4
 0NGrw1ePuwrA5fr1tauim/Fp305y3/aVeLn47ccKCAPmTePmPX4YZwxKutXnNKLuMwQ8
 YxXbOSXauzp/32QnS3r5ScZuGePbx2kgHIEv5D9Bi9Ylx3DvIfHX6xzAU2i350YVqqDe
 V0eGPwFTiaH8guo9SANf/Cj2upsSBXOMVlYSeY/sN+o0ohvDUnAxUo37Ftdzd2JFPk67
 S78ZoMKsjSOOFMc68s26yX8Eb6TmPSDXegT2SifFoTT8EPlnma2947TXBKb6iZFW4NKL
 Sigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712866032; x=1713470832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RjJZcjUlCUYpyhqM4iU+yENzWXNTqDQyMdK9vg5KE50=;
 b=H/Sgv+pwmWPS7ZykawyPLEc7OCtaP5I7e3OyBjkXhUeZMOlzuBJapiEP8gHVD71zQQ
 w6Xy27TMOpnLrpcPFuh4sQWM0Te6fjQQZyhcRMzuIcbNLBxC8NLVbEI/+lfQ7a/j7v67
 4f03mb94CHYcfhln7U4oupzODw8YBhAKjPoZA0omKPSfmiM7hfBaI/Uf4c/sC1Gx0KJk
 gPfdPE5sFzzlvh/lICFSqRNxXegc+K1xzuDQ6tK1otSPXW4q93XapwsqytqjkQsfojXb
 4wYGCJ+mz3pnZWQcoZzJoaP0DGPb8xo8FR+iQC7SPI2FiPPuFGqnNuIne2/fAR+IZu9B
 iKng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKjvTo0zkZxwX0RxO6u0egd+7MYWmMAfVMV4NEQJH4r1AsLgcbn8muYSz9t1d4u9ywYVjAwCHF+7khaznQUvmqrL3uXRc=
X-Gm-Message-State: AOJu0Yz88zJYrtiFkRQFNRhpsCamaQQgu/im3CUaQQaAsuZwMWAxtx6E
 A4Md3KNb5TBdAIOhJXdENjPBIAn4+wxJhrU4s3XRp8iTafEPGNOYag6HPTz34Cg=
X-Google-Smtp-Source: AGHT+IGOroPCnijKcpiVfNJheA+vCQftL/2zq+q48PIFQ5Twy5l0fut1uimYCxQgVkSTEfNJny+e9A==
X-Received: by 2002:a05:6a00:3d42:b0:6ec:ed90:65ea with SMTP id
 lp2-20020a056a003d4200b006eced9065eamr786916pfb.32.1712866032399; 
 Thu, 11 Apr 2024 13:07:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 x23-20020a056a000bd700b006e6b180d87asm1582041pfu.35.2024.04.11.13.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 13:07:12 -0700 (PDT)
Message-ID: <89453f6f-1ffe-4141-a8aa-fde7319f3e17@linaro.org>
Date: Thu, 11 Apr 2024 13:07:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] hw/mips/malta: Add re-usable rng_seed_hex_new()
 method
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240411101550.99392-1-philmd@linaro.org>
 <20240411101550.99392-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411101550.99392-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/11/24 03:15, Philippe Mathieu-Daudé wrote:
> Extract common code from reinitialize_rng_seed() and
> load_kernel() to rng_seed_hex_new().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/malta.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/mips/malta.c b/hw/mips/malta.c
> index af74008c82..9fc6a7d313 100644
> --- a/hw/mips/malta.c
> +++ b/hw/mips/malta.c
> @@ -850,15 +850,24 @@ static void G_GNUC_PRINTF(3, 4) prom_set(uint32_t *prom_buf, int index,
>       va_end(ap);
>   }
>   
> -static void reinitialize_rng_seed(void *opaque)
> +static char *rng_seed_hex_new(void)
>   {
> -    char *rng_seed_hex = opaque;
>       uint8_t rng_seed[32];
> +    char rng_seed_hex[sizeof(rng_seed) * 2 + 1];
>   
>       qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
>       for (size_t i = 0; i < sizeof(rng_seed); ++i) {
>           sprintf(rng_seed_hex + i * 2, "%02x", rng_seed[i]);
>       }
> +
> +    return g_strdup(rng_seed_hex);
> +}
> +
> +static void reinitialize_rng_seed(void *opaque)
> +{
> +    g_autofree char *rng_seed_hex = rng_seed_hex_new();
> +
> +    strcpy(opaque, rng_seed_hex);
>   }

Though it isn't deprecated, strcpy isn't really any safer than sprintf.
We don't need to be copying text around quite as much as this.

How about:

#define RNG_SEED_SIZE 32

static void rng_seed_hex_new(char buf[2 * RNG_SEED_SIZE + 1])
{
     static const char hex = "0123456789abcdef";
     uint8_t rng_seed[RNG_SEED_SIZE];

     qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
     for (int i = 0; i < RNG_SEED_SIZE; ++i) {
         buf[i * 2 + 0] = hex[rng_seed[i] / 16];
         buf[i * 2 + 1] = hex[rng_seed[i] % 16];
     }
     buf[RNG_SEED_SIZE * 2] = '\0';
}

static void reinitialize_rng_seed(void *opaque)
{
     rng_seed_hex_new(opaque);
}

with little change in load_kernel.


r~

