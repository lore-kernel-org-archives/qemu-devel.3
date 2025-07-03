Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC86EC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 15:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMGW-0008Bt-JC; Thu, 03 Jul 2025 11:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXMGD-0008A1-4i
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 11:54:06 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXMG9-0000LU-VE
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 11:54:04 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-40b859461easo67260b6e.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751558039; x=1752162839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NF+no9p+3maMSsijBYB32Ph41608BK9I+kmKZxnFeOY=;
 b=DBTUfzOwPzDPl3AyVODM7pi3rvV4xfVwmxtJwIad2t+RbZdYxb0IiTtMAly4f+Swg2
 EeWB88ySp6Eza9UkztmMP++pfvTSElmd1cna5+NLhw5GZ4wYqO9bd4Hg/6MFtP1QIGHj
 zCSE1fZOIuWZJ4eb/ro6tq/4WcoQBFQsPMnPaKVY1rpTd5M0bnmrMYElSOHVyf4i0qqt
 4tEz936xNWjsZjoXih8BcpZAV3NwmcQ7zENdCT3PkhSvNaF4kMOF7/ByNRPwV8DlATGZ
 lA6B3mWf3IbFKS+6l9DkbUbKAL1bj6iVoYhBnwfX0IROkruqtBTdWhBnIJIlQNvHdhmN
 UzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751558039; x=1752162839;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NF+no9p+3maMSsijBYB32Ph41608BK9I+kmKZxnFeOY=;
 b=UKzQYZ/IJ/A0xu048SjDhb/Am4a1ssR6srHxwwyiVYg38gOivRsdTbXJjsFJuSnyfi
 fAoc1RTRvSiI6L+ocYU9V8C2pm3umg5zwXhfv7ikFuBNszk5d8Wtx/oF05VCg2AnVNEF
 nNJ1VTOdhgOCp2/cezhI+Ih8S9B2/A/f29ZSryJZZi+yGZJVOke0iFBR910OZmBZDP9h
 /bSb9wzxhjErn9fkOybg560mwa3c3rMjf4JwbFmAn/MSjhaJxfTmVSvrPRSIPqC1AhK0
 bxU9NtfV5JVBu5WZcMJux4fH+K0+d5+xmKhRDmQjV9hNdR2KtVJxxNKgVVjFnL2/v5Q3
 qaYw==
X-Gm-Message-State: AOJu0YxqmJ2DjpM3d+vDTbQ9sjKr7tup1I/9aPCIjJ5cofR/LU0jXdXw
 9dEpoMTHPSr5bxffwwuIjrAOjxl8qCJdP+SbZd1VbRfnE+yeo4IJmJPz+tqdUDtRvio=
X-Gm-Gg: ASbGncuboK9lmlkKFsIjZXbxzxzEQd/6tRcMUdjjDhQ+e+G9PUT8ILizn7zn9RYH0mQ
 Kuu/Z+LTpfzWLiluq463z8kkcsGcxKCY7t6BxpO9ljG9Phogjz15/pjQPxmM930oR9EzJiInrYp
 WMKREtpC+MgJPXLi9Bh82P1TdHuOZmL7BD3SZhKq6yAuNQ0ghUdsSTDLguHBmgbc1Q5Zs5p0Rg/
 RDA735AUxa+ZciHn4pckdKOb+Ov9+6WMg4Ss9Q+9Xg0GBwSj4qK+HvfO+aZDsGUliSOBtLRo2Dk
 hEy9OnuoR3yZueOym6IpAlIH0h+P1Tri4Nlpc8sGmg8J46YxRygHlJvu0zZfi/K99Nv1dQnu/S5
 d
X-Google-Smtp-Source: AGHT+IHZkUQqiN+BBXCH9yxEFdvbDG0PolD/5VMqqH0S2FF8QOHnqL2RQi05Q9EHpGmQqq+7MW63dA==
X-Received: by 2002:a05:6808:300e:b0:403:50e7:83db with SMTP id
 5614622812f47-40c0fd85993mr2902399b6e.25.1751558038977; 
 Thu, 03 Jul 2025 08:53:58 -0700 (PDT)
Received: from [10.25.6.71] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32421a92sm3015237b6e.42.2025.07.03.08.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 08:53:58 -0700 (PDT)
Message-ID: <49b1a585-6249-48b3-86bb-2dbc81963899@linaro.org>
Date: Thu, 3 Jul 2025 09:53:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 49/97] target/arm: Implement SME2 SQCVT, UQCVT, SQCVTU
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-50-richard.henderson@linaro.org>
 <CAFEAcA-Qj5Vv6x08epwiWs0ihDLa4=mihMvrx=D+xOLkdYFvYQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-Qj5Vv6x08epwiWs0ihDLa4=mihMvrx=D+xOLkdYFvYQ@mail.gmail.com>
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

On 7/3/25 04:20, Peter Maydell wrote:
> On Wed, 2 Jul 2025 at 13:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/helper-sme.h    |  20 ++++++
>>   target/arm/tcg/sme_helper.c    | 116 +++++++++++++++++++++++++++++++++
>>   target/arm/tcg/translate-sme.c |  35 ++++++++++
>>   target/arm/tcg/sme.decode      |  22 +++++++
>>   4 files changed, 193 insertions(+)
> 
> 
>> index d69d57c4cb..906d369d37 100644
>> --- a/target/arm/tcg/sme_helper.c
>> +++ b/target/arm/tcg/sme_helper.c
>> @@ -1561,6 +1561,64 @@ void HELPER(sme2_fcvt_n)(void *vd, void *vs, float_status *fpst, uint32_t desc)
>>       }
>>   }
>>
>> +#define SQCVT2(NAME, TW, TN, HW, HN, SAT)                       \
>> +void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
>> +{                                                               \
>> +    ARMVectorReg scratch;                                       \
>> +    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
>> +    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
>> +    TN *d = vd;                                                 \
>> +    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \
> 
> Does this do the right thing if Vd is less than Vs?
> Pointer differences are signed, I think, so for eg vd == 0
> vs == 16 we unnecessarily use the scratch reg.
> Maybe clearer to write
>     (vd >= vs && vd < (vs + 2 * sizeof(..))
> 
> (Similarly for other use of this condition later in the patch.)

I should probably split out a helper for this, there are so many instances.


> 
> 
>> +        d = (TN *)&scratch;                                     \
>> +    }                                                           \
>> +    for (size_t i = 0; i < n; ++i) {                            \
>> +        d[HN(i)] = SAT(s0[HW(i)]);                              \
>> +        d[HN(i) + n] = SAT(s1[HW(i)]);                          \
> 
> Should this be HN(i + n) ?

They're equivalent, because n is the whole vector size, and so does not overlap the xor on 
8-byte endianness.

>> +    for (size_t i = 0; i < n; ++i) {                            \
>> +        d[HN(2 * i + 0)] = SAT(s0[HW(i)]);                      \
>> +        d[HN(2 * i + 1)] = SAT(s1[HW(i)]);                      \
> 
> Hmm, here we do do HN(whole expr)...

None of these inputs is known to be a multiple of 8.


r~

