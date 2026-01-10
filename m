Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E23D277CD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 03:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vePdC-0007sy-5c; Fri, 09 Jan 2026 22:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vePdA-0007sn-Sv
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 22:27:12 -0500
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vePd8-0001DX-Qs
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 22:27:12 -0500
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-88fca7bce90so50034236d6.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 19:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768015629; x=1768620429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=unOy5ThX3+kMsLsXNfauwTTAzYDjGViDwumIPUCPvCM=;
 b=VPvzAumKGYibUuBLDuTGJqeuSIYQoB934Wa8BXO/+SIOPu+5YjaipUQP2iYDkngk1s
 zyYmT0WU/faWQ91JdDCQ510it5MwmnyZ5AJaIyXiEZPpzgQa44/ndKXxfgT5bQGds+gM
 VptoEbZV46exTXVDfBTRhu8u4bF/w6MPRCa6kJYk8Rgo2Ibw4JPd/PSV5hpbq9gCm2YS
 2ad5zq//JlNo8dUbIc9f8QYQkLWV7U/wSzvQBnu3KXI76zKW4aqxJKEYy0WV9Bsi9N0f
 W3eUCCG5L1vm5Inof/JqJLf/Fs/XnJqirsukjF+CSoug4X/D79mqiE2h5O/sIRc1yD5w
 HY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768015629; x=1768620429;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=unOy5ThX3+kMsLsXNfauwTTAzYDjGViDwumIPUCPvCM=;
 b=KfDUr3+ODCWSgdeGXnzX6eWPvpLKlokMXMe8TPpYEyJ+zd4sDi3AVCsrbJLu0RHG8Q
 8GpYRViIcTJJyjgbn/h3nYFYQqrj0JWOwRJR+aAqoBAF7Un7h10Mt4IW7iC1KuHaP612
 rOLLr6Kl1Cpuad5fA0TQgrZoSZCKE6mqKwqGLTN4liPx8icT8iA2O7gNG2ih/hhLg179
 eLjXREh76Yi8qGGgZ/KELJ9h8IAwU5hTLvIul5GyCbBRA8jVPXyYCZBcZ0j+UpG5pYCW
 wtKrqOTYdiY5fB0du/NZ/mAbYMcv4x1Nmg1H1AhZ4yyeBWytGIP0VirFVhRzJGq7kxT3
 6tHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVXjNvmB/xLYfq4yUb+o/OyYX4dKe5bU1wM5ICY2Dy9IhpM5H6mxUbrkt4MvAhM8daNl34zMxuroBU@nongnu.org
X-Gm-Message-State: AOJu0YzRaTGrvsnatLd/D3M7xQVcI5PKNNxVatVCcH3T2eEZwX0NlK6F
 YBkzXCoPbkvrj1tECp827pgfKSwJwmB/9yF82v6rjbMMXOMOzcQMOxBT7LDN0xjWI2hEmsBUojL
 rQrUEJJs=
X-Gm-Gg: AY/fxX69Ve9LD/5px7VRZG1uucgKDj4eDNsOceB7JdCdg5gvDDM80ciM4OrXORy9zZl
 snuQKRXqZreB/UQFCf3xBiO5Su6Ja9v18LoeDsWjPSswiSZYoZWspX5zloxEfXWmVxP+ZUpmPTx
 ENoHZEINrtKbDd5oMLpXTDZOm5cWFvDZjW3cUDVcGEUWDs/sWMSrDbPBkyenJvON8NHRyRD4ZlE
 8bWCrZ4BUAOgGqJSAYGonB9fQP1MVg2sUWJPbtRPp3w4SKcynsIItQ/nkBtGqYykysjR5vbQPD9
 JTtn9X9lPLNehA9lVPDd2eJ/mX4YoeaMKMCD491bF2LsYdya4AhlzXxfQXX6zHwqC00ZzOx3GFt
 jupHtpeGb7R2HAJDoGDlpH7887K613tPdf6KX9bp8W/dWX70usi3zGSO2oLQnSudbiHsot4nFaN
 th+xtgKbQ8c+jjL/tmq0dsW9olOw==
X-Google-Smtp-Source: AGHT+IG+8djKZSr/HfkMe4/K51LtGCiv5hgEy27n0GkhSnjXhUPtu+zEMkWK2kGunYgj4ylD/PQFFg==
X-Received: by 2002:a17:90b:4b88:b0:340:6f07:fefa with SMTP id
 98e67ed59e1d1-34f68c03251mr11433417a91.20.1768015240092; 
 Fri, 09 Jan 2026 19:20:40 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6ae3c7e7sm4098825a91.0.2026.01.09.19.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 19:20:39 -0800 (PST)
Message-ID: <ef2b8965-9c7a-4b81-a6cb-3cd387a71472@linaro.org>
Date: Sat, 10 Jan 2026 14:20:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] fpu/softfloat: Add convert operations(bf16, fp32)
 for OFP8 data types
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-4-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108151650.16329-4-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf35.google.com
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

On 1/9/26 02:16, Max Chou wrote:
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 8094358c2e..0c7f052ec0 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -544,6 +544,8 @@ typedef struct {
>       int frac_shift;
>       bool arm_althp;
>       bool has_explicit_bit;
> +    bool ocpfp;
> +    bool ocpfp_sat;
>       uint64_t round_mask;
>   } FloatFmt;
>   
> @@ -560,6 +562,28 @@ typedef struct {
>       .frac_shift     = (-F - 1) & 63,                    \
>       .round_mask     = (1ull << ((-F - 1) & 63)) - 1
>   
> +static const FloatFmt float8_e4m3_params = {
> +    FLOAT_PARAMS(4, 3),
> +    .ocpfp = true
> +};
> +
> +static const FloatFmt float8_e4m3_params_sat = {
> +    FLOAT_PARAMS(4, 3),
> +    .ocpfp = true,
> +    .ocpfp_sat = true
> +};
> +
> +static const FloatFmt float8_e5m2_params = {
> +    FLOAT_PARAMS(5, 2),
> +    .ocpfp = true
> +};
> +
> +static const FloatFmt float8_e5m2_params_sat = {
> +    FLOAT_PARAMS(5, 2),
> +    .ocpfp = true,
> +    .ocpfp_sat = true
> +};

Saturation is not part of the format, it's part of the conversion operation.

I suggest you pass that as a bool parameter to bfloat16_to_float8_e4m3 etc.
This would then be handled as part of round-and-pack, maybe a separate step, maybe via 
float_round_nearest_even_max.

I'm not sure what to do with arm_althp vs ocpfp.  It seems like they have a couple of 
things in common.  Perhaps we should decompose these to separate behavior flags.


r~

