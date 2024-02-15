Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FC9C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXIA-00086d-9t; Thu, 15 Feb 2024 03:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raXI7-00083A-Hx
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:40:23 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raXI2-0000B4-9W
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:40:23 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33aea66a31cso312083f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707986416; x=1708591216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gKl7kb+JeFYkzIuL7BAqCk9yiLY+dKXVUwicIE8Mz5U=;
 b=kAv8GL4atHHRa6+xkRI45hH/gcFdsGfsttKKNuaUYsD/WvcE+HxekpGMcnJyfXgnJv
 ne/HvRoNZmGSJ5MzbEwQm73nuxFLShUqh7yHr0w07YiaTiN3rp+AL4OqUzGSLY77uQfK
 Fr7/y09qpnm1u++IUhFKaekBDEK48VlVPrqKEwOMnKmVskxcvBcGQGSr0rVE6L43oIeJ
 pI2Ka/3/GvM21+rhfBr6hDZV7XeMarjSEbf9ghZL+Thh9e2xjb760UpThh0qOn/uT0Dg
 eVbCKON9w8aAbaETZukXi6ZbESXKjNT4fCc9ASIPRCHsktSYnr7B5Fw6S6s5dVob41+4
 hWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707986416; x=1708591216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gKl7kb+JeFYkzIuL7BAqCk9yiLY+dKXVUwicIE8Mz5U=;
 b=Cy+6226m7An+1mlP/sPvDX58fbUu36F5LDTuJn+mG40YaHK5zTJmRbugWOGza4Ks2z
 WrAPJekQRzWmfX2wD+9mGW8DRUcfj2jsj7I2T+vzjAqbjNmmPLzkcNMZw9P9HytaPnit
 DDgcIVaVe0l5ypaUJBeEibCYA3NCM8vzjTSLsJL6OgOV9Y/w9NRlt4+MaHfB58L8m9r1
 3DKYyEkMBnKg6Ja/UzAIoa+uI4hrUO9Rv6YTsFXSuxcBWZi/9Eyi8mugJcTBh4A81+YK
 n/aKSXLbHDGaYr014r6by1N4x2yq4N6ShjdXe/wZG6FCxBO9c8SYasZVQs+MeRXdy8XW
 Ny9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDLIJtd6McbpKVgEsN5wrMCIOfM2S/2zj4P5T+dWGMR6dsFE1Ni7n7g994Yd9pys6aQvrstMEpjhBA52eVDSnyihr4ues=
X-Gm-Message-State: AOJu0YwiLEzedZyqUldeVo0tUI4QI3tnPaXurtM0Nq2iGBCNTWMlXBn0
 ZlJ5cu+nOxsUN2sZ0nQu6F5zL+xK4h+7T4HCpKPrjoL99ZMj/ezYkqsKaH8OvfU=
X-Google-Smtp-Source: AGHT+IHzutJY2RinbqFlQBB3WEczGAh+5abpXDsqtWWQefPDreuD0IhI138TEJuCcCRA0l3WzmTiFA==
X-Received: by 2002:a5d:6106:0:b0:33c:e0a7:dd05 with SMTP id
 v6-20020a5d6106000000b0033ce0a7dd05mr747347wrt.27.1707986416363; 
 Thu, 15 Feb 2024 00:40:16 -0800 (PST)
Received: from [192.168.124.175] (14.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.14]) by smtp.gmail.com with ESMTPSA id
 bu3-20020a056000078300b0033b198efbedsm1060483wrb.15.2024.02.15.00.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 00:40:15 -0800 (PST)
Message-ID: <cea06f88-e79e-41cb-bb70-6d05937a78c0@linaro.org>
Date: Thu, 15 Feb 2024 09:40:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] util/bufferiszero: Simplify
 test_buffer_is_zero_next_accel
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: amonakov@ispras.ru, mmromanov@ispras.ru
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <20240215081449.848220-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215081449.848220-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 15/2/24 09:14, Richard Henderson wrote:
> Because the three alternatives are monotonic, we don't
> need to keep a couple of bitmasks, just identify the
> strongest alternative at startup.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   util/bufferiszero.c | 56 ++++++++++++++++++---------------------------
>   1 file changed, 22 insertions(+), 34 deletions(-)

enum {
   ACCEL_DEFAULT,
   ACCEL_SSE2,
   ACCEL_AVX2,
};

> +static biz_accel_fn const accel_table[] = {

   [ACCEL_DEFAULT] =

> +    buffer_is_zero_int_ge256,

   [ACCEL_SSE2] =

> +    buffer_zero_sse2,
>   #ifdef CONFIG_AVX2_OPT

   [ACCEL_AVX2] =

> +    buffer_zero_avx2,
>   #endif


> +static unsigned accel_index;
>   
>   static void __attribute__((constructor)) init_accel(void)
>   {
> -    used_accel = select_accel_cpuinfo(cpuinfo_init());
> +    unsigned info = cpuinfo_init();
> +    unsigned index = (info & CPUINFO_SSE2 ? 1 : 0);

   ... ? ACCEL_SSE2 : ACCEL_DEFAULT;

> +
> +#ifdef CONFIG_AVX2_OPT
> +    if (info & CPUINFO_AVX2) {
> +        index = 2;

   ... = ACCEL_AVX2

> +    }
> +#endif
> +
> +    accel_index = index;
> +    buffer_is_zero_accel = accel_table[index];
>   }
Preferably introducing accel enum:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

