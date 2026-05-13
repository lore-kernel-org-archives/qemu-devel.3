Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22788CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3oh-0000zR-2H; Wed, 13 May 2026 03:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3oe-0000xM-1Z
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:15:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3ob-0004nX-RK
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:15:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so40370675e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778656532; x=1779261332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6AhVvk+APLilg+Vl4Q/1BmRyBvfQxfO4oECHE5bOiYI=;
 b=cNc0uHfdz44dTjewiwgTNkdHkEZOAAPsXsuoOjH+lmNo6zAvQB1S+KaqZm9UK6ohK0
 yFnJNjg2eWw6RFc2r/dmQH5LnVtWP7JY7vK5abPk/tv7pIpFB+ilHdX9O55Z+xiDbwD3
 503Zi2HiKxazQQ3ZEyiNUHkytvYWBZRke38UZzrzChT0oREyW1IsOJ0I78XM1JhEqwHH
 vGdqYcFQmDrZHCMLACd1HjvshQ074zj/v4hJ2VJR7ZyGT3xJJHIzDaT+/u54J7TdUoYZ
 W/g6lMWCPArteP9hhrU3YEdK+LtWeGvWHWSbt6RC57qWeRenTSwHKuLgri4MyjMaczML
 4rKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778656532; x=1779261332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6AhVvk+APLilg+Vl4Q/1BmRyBvfQxfO4oECHE5bOiYI=;
 b=DXd7cfmatBU6zt6XdiVSfZgkZHYMikDVnIW4hwWcdE/CZLJ1F5ePD6I4iZAMKd8YYg
 17lrK+vXXc96+1zGd+xE96kgg1fvQ/IMbdKHM0t3HJst4snAQYZmUKnlJLIf7km2Fa0i
 R85mNDhJIi8jbqLMCCS05uwUu6igatBGzaLqE8HA/ntD1Tj0ZE+SU8vSHnSlYjmc4TZD
 B8qHZi0plYQwh7VhclBIqlIyejXN+B3EvIwZGPNkrNtM0NzXfXiNfu7ueN+d3RMvKhTA
 VgRyMKbJNr+oN+2UMUrDJRnAybcnD09WxanU+p/rhj93CANndWQJnU/jyEh4jel5NZVG
 kQDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qIWG5J4mpn4O6LyMJ86ZfXVrU6EYE4Wyn3s1BCrziNS0TZQfv2/QTCzbVpliPR3lOHCfpQnYZt67/@nongnu.org
X-Gm-Message-State: AOJu0Yz6h/HtjpyhKi+0zynpETF68ybOdpdwq44beih5llh3+j5OU0NG
 PINOnsf+ZNkt7mhW6eG3MWKaRRfNeBS6iD50kn4MFbX6xa9XNqnLTpOVTW9AiOvD7bk=
X-Gm-Gg: Acq92OERiVhoXAaydebzGHo6oTEH6ZJPrQ3jILHpDMV+RD+9nAFdOih7rQaldvrOvl2
 yDJ98gjRM56WdBW5zAInvj7OFEnJASJoGYG84po7WqthkDrCcMtwZsjW8ULzH0L/6z1pjBJ+XnU
 WeI+VPWCm8yt3F5kj87uWB1TRWn4BR63rYS/1SjKqpKPiShRDjFMl4d7Gk89Kr63mRVqKWSqspy
 xufSQPA5Je9Itu3C1HYLx+BBQLkrinvJps+qTNucDQ5ATpZRYs5NuD08j7/eR2uIGLeWLiXWd+8
 Ym88SzLTsJFMtHWd+blocDeXyKZxwXfeGJH3g9PLoqS+zkVAPtND8wWfQlT8yn8GfK2SL6odssA
 mbm5uVD8oaEbrK0lmkxqaymS/w05cWa45nR9t5wsLPcLRDDr94sjkKxemoQdIzClHu3soCrl3T/
 NEthjCpoRwdSG6isjMEKAbChwhLz3YpCXRPRweq9XXm+w5CqvDwDAokH063NQG0vLMJg==
X-Received: by 2002:a05:600c:a011:b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-48fc9a0e65emr28273325e9.7.1778656531694; 
 Wed, 13 May 2026 00:15:31 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f442129sm34884895e9.28.2026.05.13.00.15.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 00:15:31 -0700 (PDT)
Message-ID: <c0be90f8-baca-49cb-8024-06bc4fb0471d@linaro.org>
Date: Wed, 13 May 2026 09:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: target/riscv: rdcycleh problem
Content-Language: en-US
To: Antony Pavlov <antonynpavlov@gmail.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <CAA4bVAFS4aRjW7On7C0Y5MQH94TmLfXMwcD+8dWzKBD4JZL3Fg@mail.gmail.com>
 <9a6f4a8a-9917-4384-b36e-9eafe2461725@linaro.org>
 <CAKmqyKMTnn_oVUhKDCBkCDSwivgnf3U0hcyvUEkfEOcMy53m9A@mail.gmail.com>
 <CAA4bVAFMbiqZvBeDDYYjHAX_Zrw_k+5mD=baxdSSyBe-KJiRhQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAA4bVAFMbiqZvBeDDYYjHAX_Zrw_k+5mD=baxdSSyBe-KJiRhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/5/26 07:44, Antony Pavlov wrote:
> On Wed, 13 May 2026 at 04:50, Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Tue, May 12, 2026 at 1:43 PM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>
>>> Cc'ing qemu-riscv@ list
>>>
>>> On 12/5/26 02:50, Antony Pavlov wrote:
>>>> Hi!
>>>>
>>>> I use qemu-system-riscv32 v11.0.0 for running this code:
>>>>
>>>>       15258:    c80025f3    rdcycleh a1
>>>>       1525c:    c0002573    rdcycle  a0
>>>>       15260:    c80027f3    rdcycleh a5
>>>>       15264:    fef59ae3    bne      a1,a5,15258
>>>>
>>>> The code is recommended by riscv specification for reading 64-bit
>>>> cycle counter on 32-bit system (see
>>>> https://docs.riscv.org/reference/isa/unpriv/counters.html#7-1-1-zicntr-extension-for-base-counters-and-timers
>>>> for details).
>>>>
>>>> When running on qemu-system-riscv32 both the rdcycle and the rdcycleh
>>>> instructions read low 32-bit of the cycle counter so the branch
>>>> instruction always go to 15258.
>>>
>>> Interestingly I'm having similar 32/64 bit conversion issue with
>>> the set of CSR functions in my single binary prototype due to this
>>> target_ulong use.
>>>
>>>>
>>>> This quick and dirty patch fixes my problem:
>>>>
>>>> --- a/target/riscv/csr.c
>>>> +++ b/target/riscv/csr.c
>>>> @@ -1389,8 +1389,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState
>>>> *env, target_ulong *val,
>>>>         */
>>>>        if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>>>>            riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>>>> -        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
>>>> +        uint64_t t;
>>>> +
>>>> +        t = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
>>>>                                                        ctr_prev + ctr_val;
>>>> +        *val = extract64(t, start, length);
>>>>        } else {
>>>>            *val = ctr_val;
>>>>        }
>>>>
>>>> Have you any suggestion?
>>
>> Yeah, it looks like a bug using the `target_ulong` (which is only
>> 32-bits on RV32). This is something that should be fixed, if you can
>> send a patch that would be great
> 
> I'll send the patch within a few days.

As you said this change is "quick and dirty". I suppose what Alistair
suggested is to replace 'target_ulong *' by 'uint64_t *' where relevant,
doing the appropriate truncations when riscv_cpu_mxl(env) == MXL_RV32.

