Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CD9CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GSz-0003lZ-HF; Fri, 10 Oct 2025 12:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GSw-0003lL-R1
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:59:39 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GSl-00022n-Jw
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:59:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso2321365b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760115562; x=1760720362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/dfyMMVQkgFWueD87jl8FIratJ2iLwvj9auzwM2beic=;
 b=x4A8WzA4dR6pXS0CMRmOH69nkujgm8+yZG/ZwPDeG29KdZMhcUHClO2QUJY9CkKR4g
 iRt4rU4/vyUv9qFQItzeH/TyRiqiJ0rHEs5amCuL9Ga3lKXWyTtq/ZZpLMWYifU/7/M2
 fEOB9522R7szmtT8MYOZY69XGIeFUUnU4MP1eEM4M1g9+GpCpJed9O7neDTLppEpzmPB
 t3enxAK40Ux+VpRxAQO7SDhJvSbfdR7zEMkSjWbtLC+2HK0vHLglNX66C9BVA0Qr3ojN
 G6TGef7goQtZG0rKP91Cry+XTvHGB314gPyVjDn+dQ5KDT6Oqw4ZbuMi3fRZ+1sbwJN+
 Ud9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760115562; x=1760720362;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/dfyMMVQkgFWueD87jl8FIratJ2iLwvj9auzwM2beic=;
 b=NB2011Ma6kANWAr3O5PtiATA3zxUwh1FNaFeiLtyaRZWyiQhCMamiexbgbeU/QIk+6
 4EmM2cki6k6UFY1QnUdk/6zgOu+Kit9pqGwaKeNJucnBngAZvoetLtWn6kQeKSgYWl08
 tWi/Xhxpudf8gy1KVxK4mWQRlfdg2ao2cYuVvV6THDamDQxRpDPKUPrcucmSSLcSrBXv
 +jsZ3CRqckagdX8yW+21qjfYSEWB8CpjjqVwlQ8OxEOfC+OpOaaqFzTGPgXrWjtqAwqm
 PRKpQg/9cp5I2crpAABr4KhVVMOHwxzHM2ATzOIXTAuPMx3/mfly7VP8Tup+Og9v+uKb
 NcHg==
X-Gm-Message-State: AOJu0YzEegU4j+8tAdjOccItEORBM/BDwfVrCF+7sNSmZGLn33okhk8D
 SXNitul2Wugsy9DvuWnvdmYv5BXebjD6O9t/vAMkjnPPPmnUoy5M1tsQPcjGRaAyOu+CrpdcZOz
 r7Xw4yJQ=
X-Gm-Gg: ASbGncvEyzZkdmeJ8M9z8gqRk3gyOER8J0h6+Vng36JsqLJjKL80vUh5ha3BROsqjoy
 S3S5h9tuT50XXpwGZgdkMVBb4frEr7RYm2Ir5wDRcThGXBchDo5pytV9QHJxhOUI0RAZhvYzToq
 n7odDoEHHOnAPmUkJeGRm72bNYeGAVGJoPccM+a9JHLaWL23jmPtG+aAJHXO1lXDRDbGc0V/goM
 EDfb2vIqWPvmJzlR9t6h8nCOOslrglWqrFJwoaE211Jm0qMlQGHMvU5imb8QpPK/Jsv8HAqLsQS
 MLJvvPMbGfAsXWWyk7r09LD+048OahNkpc9LgRG3nyAl2P4DEmvBXhJYJxApRczrfubFGNkjcjt
 6+VFj5dKo8HNqNANuCYivJBF01a2Euz8p6ay+EBY9UBqULjKAQ9DR5edBOio=
X-Google-Smtp-Source: AGHT+IE1V9kXY4SIfUEkV2nW29JsWj6PYjudlFaQRboWA4nhSQFLyC3W9YD6PE1bwW7Xx8PVTOYmMQ==
X-Received: by 2002:a05:6a00:1706:b0:77f:50df:df31 with SMTP id
 d2e1a72fcca58-793870523b6mr12318952b3a.20.1760115561991; 
 Fri, 10 Oct 2025 09:59:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992db864c7sm3438154b3a.82.2025.10.10.09.59.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 09:59:21 -0700 (PDT)
Message-ID: <fcdd5ab1-a49d-4832-9b26-8159eb68a71a@linaro.org>
Date: Fri, 10 Oct 2025 09:59:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] target/tricore: Remove target_ulong use in
 gen_addi_d()
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> Callers pass either int32_t or int16_t.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 4b769b204ab..116f45135bb 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -1308,7 +1308,7 @@ gen_msubui64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
>       gen_msubu64_d(ret_low, ret_high, r1, r2_low, r2_high, temp);
>   }
>   
> -static inline void gen_addi_d(TCGv ret, TCGv r1, target_ulong r2)
> +static inline void gen_addi_d(TCGv ret, TCGv r1, int32_t r2)
>   {
>       TCGv temp = tcg_constant_i32(r2);
>       gen_add_d(ret, r1, temp);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

