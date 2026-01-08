Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F77CD1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 19:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdw8w-0001p7-Sj; Thu, 08 Jan 2026 14:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdw8v-0001oy-Rv
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 14:58:01 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdw8t-0006Li-Pu
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 14:58:01 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c2dd0c24e5cso1701210a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 11:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767902278; x=1768507078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JjOODP6ZmcoTnZTlHvCeJWcXiW4Mm9Ax6gsgCEvRZ9g=;
 b=vxaHQN0BulyHXdIi4fqgfk4MaK/Osd88itm3andRA66xeAdx9zmKodyFeYA7dOFdnP
 LtUURr+voS45N2EzeAFsSG/TLZ37bPx6jPdTMjGJhapCAm9YSfW1n9NdQ9LEcEFO9ZjB
 xnTXZPD4J9RsASMM3P0VDqfUWO6bYYQcHdfqJ3LPTjOHCfo/TbDpVZarluto9ciSMYoc
 /Jb3YKgZmvdpa3N1NFt/9YilG5ou0P/x8ElzXVdFCudoX1FH21xk0SwZVfhJETd0W5qY
 S2Onp35DREiLLslcQxRgB7uWbvbThKnC1P9nj0/j5v00RpxFqtRXG991VYHY1lVhFyHm
 M4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902278; x=1768507078;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JjOODP6ZmcoTnZTlHvCeJWcXiW4Mm9Ax6gsgCEvRZ9g=;
 b=K/wBRfNnyJtEOQO+7XTD4gjEVhY6kI8BCMsYpiEffpeA9nnQ3GWTiHkCh8QCN+OwCA
 9ycmfH0IOCJ5WqixQbLf6wQNQEBiTJqAFmF9u8/N3SOSLSx6BYGPMHcmylvBJ52vO5xs
 wNDyqsPSgL2abZdO1bciaLU6HpQy96e76Z3BL9Z9xx781Z5J3psu13lpu2jegf+jzJNK
 GDwA1rKUnC7QED0uQGzo4upuYYFPesvc4N1HpHBXBqcI61DUyFOaKS9KuihbzWZnKw94
 EuY6v0wjy8CtY0E7LsSNTXrKAey3ODlF6qwKqmECmb+xbjUqFyKYtkRcgik6HPViBCJM
 mnkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8a+zY8k/DtUt7l+huFdVq+k/SJhfE+xGhjpYXLZkwU57nJ806uyE2aPJIQ2iem6iwXEb1A1VKHDup@nongnu.org
X-Gm-Message-State: AOJu0YwYqpVtFzWd1ELwmtgDbYZ51aPJysUbTYiDQVPbsOWjfwskDtlZ
 M0GDE8EeP9SKWhcxH8lvOYdzMd0FCiauAGpzTkSsQtZBmFW7/MI0sSP5UZX03FhgY5U9/wHpFXW
 YFN24zXg=
X-Gm-Gg: AY/fxX6AWmSdCAbk64gKqMmsSzXjW2PhhYiq8ANsnCgwsXD+zVZv8Oi5rOmXkSgvTWy
 rYkg5eFGhBSr+rXpOLjNMus5O+Uf73ShZ/wQl4nCq266k1KSSVABwllMneB7qOZuBCum45MV7Wz
 NQ20MNEJAi6N95vSrul+7lhqXTvVEqImK6oTAtieaE/UWoZ9cc1jyTjS+X/hLTvE5lTZcK2+AgA
 mVYH0nwF/RCLxjzBpITwa3zjlbpK78Sl5cIzruGWalaZ5htjDsHPSiSrkXM9SNuz7C60EOEw9vh
 CueMlqJHvJhrRtXILtutiyIy5VktH3A4+7RwTdO/Xez/iBCfFjfqQ46loamaJV7X1RYbZOIaAnM
 ZyCPvQVN+o0WPWJ6JCbhZ5CU6akbt9yJt9oVjBvYKlQ24aEs07U/Wg6tKIpIC0fmmIe4/rgfOD2
 R+i4N3CvEJn/HGYvg9XaaQKdf+SobLrQ==
X-Google-Smtp-Source: AGHT+IGqMLDlY2QHpwzmFAvuwI/pjO4QWYNCXpcXe4CxzYiqLECXHTFrg2MqI4ZH113JwSk5IgA4lQ==
X-Received: by 2002:a17:90b:17c2:b0:341:194:5e7c with SMTP id
 98e67ed59e1d1-34f68c9131fmr7187468a91.24.1767902277947; 
 Thu, 08 Jan 2026 11:57:57 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6b064243sm2601018a91.2.2026.01.08.11.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 11:57:57 -0800 (PST)
Message-ID: <6a3db414-595b-4a81-aa4e-af8f27b2d0c9@linaro.org>
Date: Fri, 9 Jan 2026 06:57:53 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/50] tcg/i386: Remove TCG_TARGET_REG_BITS tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-11-richard.henderson@linaro.org>
 <07cf5928-1db2-48e6-8872-64950e5b81e6@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <07cf5928-1db2-48e6-8872-64950e5b81e6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 1/8/26 22:14, Thomas Huth wrote:
> On 08/01/2026 06.29, Richard Henderson wrote:
>> We now only support 64-bit code generation.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/i386/tcg-target-has.h      |   8 +-
>>   tcg/i386/tcg-target-reg-bits.h |   2 +-
>>   tcg/i386/tcg-target.h          |  13 +-
>>   tcg/i386/tcg-target.c.inc      | 552 ++++++---------------------------
>>   4 files changed, 97 insertions(+), 478 deletions(-)
> ....
>> @@ -152,26 +127,13 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int 
>> slot)
>>   #define TCG_CT_CONST_TST 0x1000
>>   #define TCG_CT_CONST_ZERO 0x2000
>> -/* Registers used with L constraint, which are the first argument
>> -   registers on x86_64, and two random call clobbered registers on
>> -   i386. */
>> -#if TCG_TARGET_REG_BITS == 64
>> -# define TCG_REG_L0 tcg_target_call_iarg_regs[0]
>> -# define TCG_REG_L1 tcg_target_call_iarg_regs[1]
>> -#else
>> -# define TCG_REG_L0 TCG_REG_EAX
>> -# define TCG_REG_L1 TCG_REG_EDX
>> -#endif
>> +/* Registers used with L constraint. */
>> +#define TCG_REG_L0 TCG_REG_EAX
>> +#define TCG_REG_L1 TCG_REG_EDX
> 
> I just want to double-check: This change looks confusing, since you kept the "else" 
> part ... but the (removed) comment indicated that this was the original intention? So this 
> is also bug fix?

It was unintentional, for sure.

I suspect that the (relatively) recent rewrite of tcg_out_qemu_{ld,st}_slow_path must have 
hidden this change, by automatically adding the extra moves required to get the values 
into the argument registers.

I'll double-check what's going on here...


r~

