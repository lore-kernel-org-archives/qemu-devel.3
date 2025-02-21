Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691BDC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 09:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlP6f-0007Xt-4I; Fri, 21 Feb 2025 04:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlP6d-0007Xa-V6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 04:13:59 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlP6c-0005Vq-4o
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 04:13:59 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso40207275ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 01:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740129236; x=1740734036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3jbTdLdan86tE7UKjnQHnv2Ec51MntltSBmR4WljQqo=;
 b=pcO/J5pEl5MUU8ULv77K9t2VBMWMyE6Zd4IwfAow+FStGtHFW3NAG86SZvcX0bQlvr
 C02QgMiRQINxXJSpzSXrrDhuVckgVYFBCdHdHBsH+wHmt+obF13W7qYMOyEawBGaPDtd
 9KG9W3vTsNaf5wbHvNRQU9rRsWwlIB8u/Mdjv7xYse7d0el9+b0OxayxXPqeI+XnsE8p
 52bu5wMLMKoQMnOYRQwxYWMiH/5Atf0MaNFldVYk4Sxk0BUYcPs5mtaKaYlj4mf/iLnp
 nFZoEQ5iTfEFEBW0JW2XRkyoPiEdRzAxOARwyTeL+uWoPoLlBh0TS1Er3hq8EKi2Uxy3
 76ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740129236; x=1740734036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3jbTdLdan86tE7UKjnQHnv2Ec51MntltSBmR4WljQqo=;
 b=avWHkHV54UJPUyyogKwz/TeF0j5foZ+kG8uvJ2/GoI4A4cjeUWKBzagth0jE8LbkhD
 sar3EmtKZE8NNQMxmMYY95d6xV/89Ae+7QR+5osK1HM7FBONYOmnbytNWqsRlEtf69ki
 2cBpxucJcFdYNkMEr5VDtWeFKSCAjSLbk9XWZ5jv6F9QnCgZurJr0ZVd80UO+Kpv7vLY
 oJ+a9RURfRiYJrGFWbBHQ5d2KR0Fx/1hWx2JZrPZ5pV/7cjhN4TkCekff3rHJaUBDjhG
 uwHH0NRo+1VhcPJJlUZtucMvUteFnAgLt+ufD9RJquUqV/5ZTi3/uPSdHGGoJRQLq08X
 TMvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVOmk0y8ZC4vtkVAHuMMrk/zOVm49s8OCWESJDUAyCNuz3w23s8E/VrY4tc8UiLM2stKH1FG7/7n09@nongnu.org
X-Gm-Message-State: AOJu0YwqrpQYPuTDmJl5YuV9ndxxKrNluzI3NR43aSo05TPDgVvvV8EF
 X8YfrXf6W8cse4uEeaOTGxhaohtAJDZ42BGV08ptHwEMZBqz7q+0BAOOd8UIcP4=
X-Gm-Gg: ASbGnctz399YrswD0V5WMWO8NbZzOpsNSuUP16nrSdYAnvSmAFEyd151kBYiPKWI1t0
 Lu2Zi4QVWyDtTFC4waabIQYp2WUupYyUPkw2qJlyCr2yh8iEE0HAvi0y9czcs4HnjZJ9B+7MUHN
 xx3Vgw3kcoKiwjKOiT6CKpmx+IxiVFpkVnbB2+wRfXA0Mh41odLFzw7+MzCSsXv64DE0hmfd/Dk
 lrbrE8k+T9gATatc9/Hff7nvPsCvawA9quKh5MOEXYLusZIhf0TUUezx6TXVLVwTtJWTJEkUzUe
 ZQVeOi2WexhUz7s6KJECRg5Q94y+xGWmvBbCz+0T
X-Google-Smtp-Source: AGHT+IHbSZ6z+IMmihqRzY5cozGmDFrNO9eNAJ4y0ZfbPD5Q0iQuM07eOjcFquMhxL4KDOuS7bDE8w==
X-Received: by 2002:a05:6a20:3d8f:b0:1ee:aa06:1a47 with SMTP id
 adf61e73a8af0-1eef52c9ffcmr4727747637.2.1740129235975; 
 Fri, 21 Feb 2025 01:13:55 -0800 (PST)
Received: from [192.168.68.110] ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73256a5680dsm13161680b3a.112.2025.02.21.01.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 01:13:55 -0800 (PST)
Message-ID: <b1132069-8684-4ecc-bb82-b9bab597e809@ventanamicro.com>
Date: Fri, 21 Feb 2025 06:13:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: fix C extension disabling on misa write
To: Vladimir Isaev <vladimir.isaev@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 mjc@sifive.com
References: <20250220163120.77328-1-vladimir.isaev@syntacore.com>
 <3ffe3ecf-4bd8-447e-a984-442c71a94f89@ventanamicro.com>
 <8e495335-7f21-47a5-925d-09ecf4b3a08b@syntacore.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <8e495335-7f21-47a5-925d-09ecf4b3a08b@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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



On 2/21/25 4:58 AM, Vladimir Isaev wrote:
> 
> 
> 20.02.2025 20:59, Daniel Henrique Barboza wrote:
>>
>>
>> On 2/20/25 1:31 PM, Vladimir Isaev wrote:
>>> According to spec:
>>> Writing misa may increase IALIGN, e.g., by disabling the "C" extension. If an instruction that would
>>> write misa increases IALIGN, and the subsequent instruction’s address is not IALIGN-bit aligned, the
>>> write to misa is suppressed, leaving misa unchanged.
>>>
>>> So we should suppress disabling "C" if it is already enabled and
>>> next instruction is not aligned to 4.
>>>
>>> Fixes: f18637cd611c ("RISC-V: Add misa runtime write support")
>>> Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
>>> ---
>>>    target/riscv/csr.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>> index afb7544f0780..32f9b7b16f6f 100644
>>> --- a/target/riscv/csr.c
>>> +++ b/target/riscv/csr.c
>>> @@ -2067,11 +2067,12 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
>>>        val &= env->misa_ext_mask;
>>>          /*
>>> -     * Suppress 'C' if next instruction is not aligned
>>> +     * Disabling 'C' increases IALIGN to 32. If subsequent instruction's address
>>> +     * is not 32-bit aligned, write to misa is suppressed.
>>>         * TODO: this should check next_pc
>>>         */
>>> -    if ((val & RVC) && (GETPC() & ~3) != 0) {
>>> -        val &= ~RVC;
>>
>> Not related to your changes but it would be nice if we made more use of
>> QEMU_IS_ALIGNED() instead of doing these bitwise ops to check alignment.
>> E.g. to check if pc is aligned to 4: QEMU_IS_ALIGNED(GETPC(), 4).
> 
> will fix, thank you!
> 
>>
>>
>>> +    if (!(val & RVC) && (env->misa_ext & RVC) && (GETPC() & 0x3)) {
>>> +        return RISCV_EXCP_NONE;
>>>        }
>>
>> This will abort the write altogether, skipping valid changes to other bits. What
>> we want is a "val &= ~RVC" if the proper conditions for clearing RVC are met.
> 
> Not sure since specification says:
> 
>> If an instruction that would write misa increases IALIGN, and the subsequent instruction’s
>> address is not IALIGN-bit aligned, the write to misa is suppressed, leaving misa unchanged.
> 
> In my understanding here we should skip all changes to misa, not just C.

Oh, and changing RVC would change IALIGN. Makes sense then to keep this
early exit then. Thanks,

Daniel



> 
> Thank you,
> Vladimir Isaev
> 
>>
>> Thanks,
>>
>> Daniel
>>
>>>          /* Disable RVG if any of its dependencies are disabled */
>>
>>
> 
> 


