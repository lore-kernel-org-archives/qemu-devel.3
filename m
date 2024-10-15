Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D357D216BF
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0inv-0001Um-Ve; Tue, 15 Oct 2024 10:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0ini-0001Tl-9L
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:45:37 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0ing-0006kX-QR
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:45:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20cb47387ceso30299255ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729003526; x=1729608326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=arRE9IRwohVtkqMjtJ02oTpUNmkd6pcH1OaeypcIZ/c=;
 b=ebGMKeuKyIgierOh7O5eCtUgQmNw74rfdgaUhZdMXtbNSZdyiRpHRRj8+xAjN8zcEC
 /WYPYfhaWrIQiBz2rpCNi5YeebLHplpohk0aYX/mLFwUpc2o6azVjXCm4VD9imcY2DWP
 exv9u6xtHW0n3NmNK1/blksCYVyvUMZXiUcbNnybI3QAqlXeBZ/29pDCu1z61gbbNnX9
 j/Ei43tFi5OvgW1SOnnQVGx8JyiDvYQ2RD+yoZORyF4M4kQW9R7S9BwRUNJT4+pycgCa
 3lKM9G0dtn3hJFv044Wg21mS6hYhv+d8zqRl1j6RQoEjQdEBz1K9wq6nm6Voqq/wZrC5
 R1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729003526; x=1729608326;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=arRE9IRwohVtkqMjtJ02oTpUNmkd6pcH1OaeypcIZ/c=;
 b=fVcOX28LMQup0WRNr35oVYtM05ivE3VYaltD2qe0J9I4lq6zqRNjaXIlVVFnVUdbxy
 s4CrOARKy4I0UkGfWlFQT1n7RrHyL2kGclkHz8Oud1Xj/RcJn73u2OQW9q5Vfgo3dq8V
 TYMI7HeXN3GKVCqeWNmTH+oRGHijaafYKTuPFOfqxRhl7kpCYG6hKo/QdfRSgPv0kcO3
 C6k3wyatRWBD83XRMeUpGhToe+q/xhJ4dLFL0Qm+TkoyP0mO6t6qppnlMSlLBHPNXK6X
 Av4kS4yH8GNrq0Tk+2o+IpKaKNiE/2t+iTpfQ6J32VAmWFL+Yja9tYpebZLoK0buOUPv
 bkSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW36E7R5MYcg3YaEJYkE6YlnH6mHSdTVJwSxCjItrdzjrBe+EdqKga/kLuO5gPNdWAR7bDM6aJZWROD@nongnu.org
X-Gm-Message-State: AOJu0Yy8itq8IAw+bkv2WYYG6oB3YAdC1wYJWgZLfgvnZaMwS4n5EisM
 e4vKKLGQthb0AKDoy21E5jacp8zH/R08m13F2pmSLwo9i5UaUDWz04+z3M3bb7k=
X-Google-Smtp-Source: AGHT+IFEN4WXBjHK2ZRyDO/uRRwOgNSlktKokNiU0v8yYmg9Tb8QFBbDpEpFExWInUmQOJk4qN4R9A==
X-Received: by 2002:a05:6a21:1505:b0:1cf:49a6:9933 with SMTP id
 adf61e73a8af0-1d905ef9076mr636218637.20.1729003525898; 
 Tue, 15 Oct 2024 07:45:25 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1805da3fsm12784455ad.243.2024.10.15.07.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 07:45:25 -0700 (PDT)
Message-ID: <4d46291a-e016-451a-806c-a1be7a91624e@linaro.org>
Date: Tue, 15 Oct 2024 11:45:21 -0300
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
 <7ffd1d50-197c-4c8a-8362-4f16237366a7@linaro.org>
 <a3a9667c-5f02-4963-bdf9-ddf6aa164224@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a3a9667c-5f02-4963-bdf9-ddf6aa164224@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x635.google.com
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

On 14/10/24 20:13, Richard Henderson wrote:
> On 10/14/24 15:18, Philippe Mathieu-Daudé wrote:
>> On 13/10/24 13:05, Richard Henderson wrote:
>>> On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
>>>> +++ b/target/mips/tcg/msa_helper.c
>>>> @@ -8213,7 +8213,7 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, 
>>>> uint32_t df, uint32_t wd,
>>>>   #if !defined(CONFIG_USER_ONLY)
>>>>   #define 
>>>> MEMOP_IDX(DF)                                                   \
>>>> -    MemOpIdx oi = make_memop_idx(MO_TE | DF | 
>>>> MO_UNALN,                 \
>>>> +    MemOpIdx oi = make_memop_idx(mo_endian(dc) | DF | 
>>>> MO_UNALN,                 \
>>>>                                    mips_env_mmu_index(env));
>>>>   #else
>>>
>>> This one is not within a translation context.
>>> Surely this should be mo_endian_env().
>>>
>>> I would have expected this not to compile?
>>
>> Dead code since commit 948f88661c6 ("target/mips: Use cpu_*_data_ra
>> for msa load/store"):
>>
>> $ git grep -w MEMOP_IDX
>> target/mips/tcg/msa_helper.c:8215:#define MEMOP_IDX(DF) 
>>                                  \
>> target/mips/tcg/msa_helper.c:8219:#define MEMOP_IDX(DF)
>>
>> I'll send a cleanup patch removing the #define lines.
> 
> Ah, excellent.
> 
>> Might I use your R-b tag on this patch, removing the tcg/msa_helper.c 
>> change?
> 
> Yes.

Thanks! Series queued then.



