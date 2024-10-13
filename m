Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99CFCF2576
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 16:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t015w-0000Uf-NB; Sun, 13 Oct 2024 12:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t015u-0000U3-IX
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:05:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t015s-0003wf-Jx
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:05:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20cd76c513cso3856395ad.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728835518; x=1729440318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RaU9boDu2rnmlDQKp9zBDa7bTygI+G1ZrCS5IdrFr8w=;
 b=M21NPKFe+y/oELF4pez1xSum+8CJQxFVkFTMtL0+t/1w/qZ7RzGS6EFT443wJxN+rY
 n+Tdanjg3j2lHLQKehqHJQK1Av++P+kw7GhGV0byjtmjG9XzIAfQiqKTCZMc/H5BqhvW
 hfhMOVtNKZAFQJNs/GPXbn0m6JF4v/2BBnV6hyks75FDcBwd+ZeERDeVsI4SxpBCGUd0
 PIyI8gAmUdXxYOgfzPS1XhKRR70CdQu4D6N2hcPNrFWlTTuq+Z9Mue9rn5ey2qV6W2Lx
 7xhCoEOBjbqEQ3cBzhmK19kJJbHUdxA4ykPhpLmSl0kHXJOPz0i9jeq9BnRod3b32w8e
 XiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728835518; x=1729440318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RaU9boDu2rnmlDQKp9zBDa7bTygI+G1ZrCS5IdrFr8w=;
 b=f832QjbvZyR3f76sG9JdDKCS2ga8g47DRTIiL97NwpN4KmzeY4VUpbu5FYFV6CXk+P
 6DyjrRbVt4nECR4ACu4SBI9qhslxY63pGacjYlANmH/RAeWHldQKX9UydrLF29fQnaCG
 46CDaIukmj1kV5vbesgVBgVE+ZFay1xXiFp+KdBb/YM9M86ijOj9fVuBZ97JpwuFoAbO
 vxYJjK1Ny6QeCGmF/eH/ACNsc2MgQMye5d/pS6eI/cgfVbc0kZ0Voeq9iBX7CEJVVvQA
 RLtiUe2fpumMXnuvNyZ+leJPfHgr/c7HeqFW3s6oPXwnyfv/ua4cW8BYPG9joPX59Zie
 lqLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJsGbDp6i2yPnoZxp8E4a360Y6fUEA7EEmHiGUkSSuJSHuv/fQmBsw3Ac9zrPhr56QCeXCqawxwTwk@nongnu.org
X-Gm-Message-State: AOJu0Yw3bqmoF56/Qpxuwvsw6lChVL1c9y6+hY8Jv6x9MZ5jZQjDQ5YJ
 w7Uh1KhMmmx7MuWiwD9tsRQ5+TgzLI0MOGOieIk2V5BLvQ1899Z24uN6Q/NfgUM=
X-Google-Smtp-Source: AGHT+IHO/eDnZwvqRRLNCRAO3OTCYHHIC6ghwBsX4mx0wZlJPEPRuc1jlTUeZvjsdCq7vNwd+Pl10w==
X-Received: by 2002:a17:902:c40f:b0:207:18f5:7e78 with SMTP id
 d9443c01a7336-20ca16ca0d0mr113985745ad.48.1728835517736; 
 Sun, 13 Oct 2024 09:05:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c0e806bsm51088905ad.125.2024.10.13.09.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 09:05:17 -0700 (PDT)
Message-ID: <040de42c-619b-4f69-87e2-fafae27fd8cc@linaro.org>
Date: Sun, 13 Oct 2024 09:05:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] target/mips: Replace MO_TE by mo_endian()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> +++ b/target/mips/tcg/msa_helper.c
> @@ -8213,7 +8213,7 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
>   
>   #if !defined(CONFIG_USER_ONLY)
>   #define MEMOP_IDX(DF)                                                   \
> -    MemOpIdx oi = make_memop_idx(MO_TE | DF | MO_UNALN,                 \
> +    MemOpIdx oi = make_memop_idx(mo_endian(dc) | DF | MO_UNALN,                 \
>                                    mips_env_mmu_index(env));
>   #else

This one is not within a translation context.
Surely this should be mo_endian_env().

I would have expected this not to compile?

The rest of the changes appear correct, based on filenames.


r~

