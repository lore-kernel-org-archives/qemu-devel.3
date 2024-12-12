Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF24AE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLl5E-000428-Cs; Thu, 12 Dec 2024 10:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLl5D-0003zn-2p
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:26:31 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLl5B-0007HW-CY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:26:30 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3eb8db8ae9aso283351b6e.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734017187; x=1734621987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DFLg+2cWiUb5Ep9I8wbJDj2CMM9zNWwCSlXF614FY34=;
 b=LdrGjz6I/akMSGq93UUmzxI3iI8X4+JFr+F2E5C1IQmogHP2GQ2I2jI6BFrtXKBNf1
 v5BQWTwUZkeQSG8kmrX9EqM7luSACj9j+H3Okv3e/d8hGEtnOOdrHM4c6IHQsiS7TLaE
 nNz/47Mey8yory8k4iWkqLblRNUHWYrVLhifhdVJOHDN07FtmAJEmrnrhiyXkhwj6z4c
 QJPFtrKl7jCN6aDVU8UqZKClrh37vsGLXl7CpV0n/8Mw+tz+hW2sRiPfpWzjDnbtoHgd
 r/VsL/fzSPFqnhidzCS4GqApnSgmFZczpCuvg8yDxApp9SX73c1+mXlz/10fqROIuniK
 4ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734017187; x=1734621987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFLg+2cWiUb5Ep9I8wbJDj2CMM9zNWwCSlXF614FY34=;
 b=nXzuCiXLV7PrifY/6wZE84P7SyxCoduAwwuAzqTB9Uaf+3fMMj8dbFTubon1xbsvz2
 QI39R1WVvrAiXRHirXJf6TcRZ19lpo6bbC3m9uagV+y1e1xxauuo64RndO4JY0EUsA6f
 u1YflqkSUA29YxX6HeUPwwlyg4+Nd4oY6pks91VzymC/nuic6GA83+qN7un0ku45+iMX
 qLgdrBscQmuz+FxBv5eo0fEdt6rk/UpyqSmw+6gs5bul/JduA0g6yFsRzpiNtiUScnLZ
 03trd0SCybFKPzkCXmHya7ftutoifoCkSofIhGMs8CApYx+aUMvZnsK+JPSKR0/nDe3W
 +XJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIvEw5CMEGI6MBuYh08ns/gEqd15mt9Cp2SFyaOJIwdaTwuh3FRe1JgH0+P9XLxr0fzy8EVjyW94Db@nongnu.org
X-Gm-Message-State: AOJu0Yz0JNr22Lkr5bNY6suYEG0rKL4O5VpN8jKn0hqCK47yDNy5Wfb7
 E9zWqNiytn+HZndJOdNNPKqdNqjT0OSBn/DZTcQuCZl69lXEm9uNXSirUSmGTDQ=
X-Gm-Gg: ASbGnctDe9SEjiyyCxwCU8SUEXzZbs0Z4o987NqhF7lB8S2K5ZZ2/ltJ1KBfBpj12Iy
 VIJ/yv3NKOE2hWqcgT+86Srp7uEU8yRXeyoMmS74EtNZo9Q4D9FoMFtDZ1IWbxZs2sSMltegQ5D
 4CF3HszqAQ/Xa7jS7WpGdA09AU6ku3qvmeRX62ApPIEMIfmU/hcoKQ/YZLbOB/hZZOBp7DEbu/9
 iQZ698qcByZmG5EuY6vNy0FWsukrg1Xfq8O76uRU0CCdHskTkN4ZQrzojg+mkPsrCan6jz5TSmA
 I34CXDoUpln2IxNBQ1QvqOV8NJzbeL+7V0M=
X-Google-Smtp-Source: AGHT+IFZWNzgsaRmmgToHjQdZCco2FwNDRz05C0BWxU3iBOxMZG0NMaTWvRfFgxPSjDJjIFNUIsUcw==
X-Received: by 2002:a05:6808:218d:b0:3eb:9064:cf25 with SMTP id
 5614622812f47-3eb940dabbemr2396748b6e.28.1734017187057; 
 Thu, 12 Dec 2024 07:26:27 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb8ffcc130sm597404b6e.39.2024.12.12.07.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:26:26 -0800 (PST)
Message-ID: <21d47030-7998-4b0a-908d-761daa9afd64@linaro.org>
Date: Thu, 12 Dec 2024 09:26:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/11] target/ppc: introduce gen_st_tl() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, npiggin@gmail.com,
 danielhb413@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
 <20241212151412.570454-4-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212151412.570454-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 12/12/24 09:14, Mark Cave-Ayland wrote:
> This function is intended to be used for all memory store operations. Convert the
> GEN_QEMU_STORE_TL() macro to use it as a starting point.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/ppc/translate.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 5fb0aa36ce..bf94f3a5de 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2616,12 +2616,18 @@ GEN_QEMU_LOAD_64(ld64,  DEF_MEMOP(MO_UQ))
>   GEN_QEMU_LOAD_64(ld64ur, BSWAP_MEMOP(MO_UQ))
>   #endif
>   
> +static void gen_st_tl(DisasContext *ctx, TCGv val, TCGv addr, TCGArg idx,
> +                      MemOp memop)
> +{
> +    tcg_gen_qemu_st_tl(val, addr, idx, memop);
> +}
> +
>   #define GEN_QEMU_STORE_TL(stop, op)                                     \
>   static void glue(gen_qemu_, stop)(DisasContext *ctx,                    \
>                                     TCGv val,                             \
>                                     TCGv addr)                            \
>   {                                                                       \
> -    tcg_gen_qemu_st_tl(val, addr, ctx->mem_idx, op);                    \
> +    gen_st_tl(ctx, val, addr, ctx->mem_idx, op);                        \
>   }
>   
>   #if defined(TARGET_PPC64) || !defined(CONFIG_USER_ONLY)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

