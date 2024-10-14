Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EABD18157
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 22:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0TOM-0000hE-5k; Mon, 14 Oct 2024 18:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0TOI-0000gq-49
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:18:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0TOG-00007O-G5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:18:13 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20cdb889222so15097615ad.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728944291; x=1729549091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1gf3VKf2RaikEAxZsjvv97C7GehbC/hon1xQVH2Zy0M=;
 b=tPy45iNSLI3s4Cg7BpdNOPHYaeuTVfHWAy+pFiMwSMkSN+5p+e1V8Pt27dD4MKYwiC
 Yvqc9p8UcHvKcmwvqvncl+OFiJNAQwSQTAMOQbz8TPHSpVQzPdnEcIO5LJjCg5I69UJ/
 kgdv71S0xM+1pYEklMAtfNFhuO5g/UUhGEpf5yuxfOBP86I7jnGRFSs+U8sAfFD2plVR
 McsngHzZbFgY9xcI7oaJDtVPb3Qn5RNbpMH6Vc321WtglERihnn8Piup3SN0afSuK2/t
 tEyzt1O2zLF2cRhToIoLccIBzxsjzDo6liPChTJNn3rCDhdcSVFeu9vX2tUCIvlMt1Uq
 h5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728944291; x=1729549091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1gf3VKf2RaikEAxZsjvv97C7GehbC/hon1xQVH2Zy0M=;
 b=w5V4DgfZHJoW1eLmLo/L7BgEm9zdv+H+Na3avTpAig+YZ/cjnSG7oNEz3zHSR6HSZo
 fQaik8DF9KKyX7ZdydUq/FGBKTY64NlLt5wTKletps4PDZRQrft8cP2OAn4U59g0PszG
 mHzsNQweeBWD493es05ibS7SiwKenW3Jr/ETq+jn/RnYKYXmrnsL4zTZ6/8pOYSpDiyE
 4+V/TGfVMkMBOFMVelg2treFgMZCsP1BWEj8Yd86sqeecxkZ9gEZ7RKPAEkQnc7FncrE
 RGokQXZHwIFHyAwbN7nueS55jqqJHPVvvTU68G08pSzIjymI5f6JVanARFLeQG0ec8Hc
 57kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyQE8I438jAAvkEREzFZg5VhbLdR3F5WZcdmhbN/lty81WKtdqXELznG3Zdn04JqhsAsQwCXc+Lqhb@nongnu.org
X-Gm-Message-State: AOJu0YytP2YNWuzx9CZUj290AlaKqp80anS8ubndmtNeck8ooFpUXoz2
 JobjZhIQDuG5to01b/RN5F7Es/kiBMbxB0HG/ic5iqGKLCAQkVFo5O3vIuINMik=
X-Google-Smtp-Source: AGHT+IGE5bPZL6Uv4ZCDmViA9rtvXn4tfSGJ02NnAiHuhgk23B7aKXxSVMcv/TBZ48u02DDs46YgTA==
X-Received: by 2002:a17:903:2b0c:b0:20b:9379:f1f7 with SMTP id
 d9443c01a7336-20ca169e6b5mr183399735ad.40.1728944290704; 
 Mon, 14 Oct 2024 15:18:10 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1805b0basm152195ad.256.2024.10.14.15.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 15:18:10 -0700 (PDT)
Message-ID: <7ffd1d50-197c-4c8a-8362-4f16237366a7@linaro.org>
Date: Mon, 14 Oct 2024 19:18:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] target/mips: Replace MO_TE by mo_endian()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-11-philmd@linaro.org>
 <040de42c-619b-4f69-87e2-fafae27fd8cc@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <040de42c-619b-4f69-87e2-fafae27fd8cc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 13/10/24 13:05, Richard Henderson wrote:
> On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
>> +++ b/target/mips/tcg/msa_helper.c
>> @@ -8213,7 +8213,7 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, 
>> uint32_t df, uint32_t wd,
>>   #if !defined(CONFIG_USER_ONLY)
>>   #define 
>> MEMOP_IDX(DF)                                                   \
>> -    MemOpIdx oi = make_memop_idx(MO_TE | DF | 
>> MO_UNALN,                 \
>> +    MemOpIdx oi = make_memop_idx(mo_endian(dc) | DF | 
>> MO_UNALN,                 \
>>                                    mips_env_mmu_index(env));
>>   #else
> 
> This one is not within a translation context.
> Surely this should be mo_endian_env().
> 
> I would have expected this not to compile?

Dead code since commit 948f88661c6 ("target/mips: Use cpu_*_data_ra
for msa load/store"):

$ git grep -w MEMOP_IDX
target/mips/tcg/msa_helper.c:8215:#define MEMOP_IDX(DF) 
                                  \
target/mips/tcg/msa_helper.c:8219:#define MEMOP_IDX(DF)

I'll send a cleanup patch removing the #define lines.

> 
> The rest of the changes appear correct, based on filenames.

Might I use your R-b tag on this patch, removing the tcg/msa_helper.c 
change?

Regards,

Phil.

