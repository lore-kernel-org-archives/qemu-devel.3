Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D42C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8Kp-0003t9-M8; Thu, 22 Feb 2024 07:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rd8Ko-0003sr-8g
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:37:54 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rd8Kg-0002D8-TU
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:37:54 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d953fa3286so54149285ad.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708605465; x=1709210265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xrvwjP0Hb+b3w8KG0wWYxs30wNfruxhjAgPCKAwfW6E=;
 b=O7g18gEwL6b/mD6zMaGZoXldLWiNmvipi9EKwKdT6hjrenRUyaathrWT9s6Vmx6Iig
 RZ6Yrfm4V+S/YIGlW3REEyxeR+SyV1ckQDoQwXIBm5eBNqhQJicIpk0F09zwSvi9RZz8
 lhZtKJ+3wl1xedrZUK4ZyYGZ2meHwjMfhAIJE8kEhqu7NUYvvx4Cldf4+AGKcG3SRGBQ
 Y+Ba86wtYmACNxLM7ayjbL9I+po6XbEPb6MUKsPqBy/K3zyXwvUMyGQPrRE/Yk217+0j
 rqpQCVwjLxREadxdw2NRL3gywr6UbNR/+wJVnS80A7rz6VVWAv6n4aA1N3wybahMRIF1
 iBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708605465; x=1709210265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xrvwjP0Hb+b3w8KG0wWYxs30wNfruxhjAgPCKAwfW6E=;
 b=f/CQsbmi6PLBa3lSfA71V4jKVId4YVstYbXzW6dfDnQnBsuJv/RpnWYGf/bKyTHi8W
 KilkFmMuQICHqYSNdTOedrC5rUhXsPIpG+fHE9C9QFgNOzIi63jAaHTLYbU8T+/SgU4g
 V6lU+6NIypms+7VLoMMzNbf9ONqcmfWwQfWv1hsdHi79M5wYk0Dh30N/nw+LImPzEPif
 QVy4WDTWP7PkOS8PZaPdShsxfQWmc55jLe8ERZFxtiBarhJZbay3ttEIBskHyKfrspd3
 HiS31SRgHdrpQgAIE08hFqpHtCmEKkG/l8eLF8Ot2I8LWSXH0XKPxeDfyTJ1+wyZu+Rp
 Mn3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEn0CXBiaE4Jyu1oNMldRM1KO6Ev+CwENt8wWjZnm3RNcm+i0duOTtoJQNmwqBe7l7s/baVIFoJUziSCOvLbd1GgnsYTM=
X-Gm-Message-State: AOJu0Yw+/CAPiIk0XjCr7JLZSZ3gK7184OWgrpH40nFXqa0qSJZohiLG
 V44oRHYTeuWOeEbUadUGLX8geSUfebJQjotE550kd5cPJZHaDP7cyq2KxNjvElM=
X-Google-Smtp-Source: AGHT+IG2x8eVxDs3qzDoDDyqa0omePT+X5AfKsvlLi3BkihsMpijGHTBF//qkDYYqfuB7ukNJIwAtg==
X-Received: by 2002:a17:902:bc86:b0:1d9:7ab0:5e20 with SMTP id
 bb6-20020a170902bc8600b001d97ab05e20mr22278224plb.69.1708605464695; 
 Thu, 22 Feb 2024 04:37:44 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a170902d38200b001da0a698095sm9865684pld.282.2024.02.22.04.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 04:37:44 -0800 (PST)
Message-ID: <eb13a04e-420a-4db7-a324-25520bcc32ea@ventanamicro.com>
Date: Thu, 22 Feb 2024 09:37:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/riscv: Apply modularized matching conditions
 for breakpoint
To: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
References: <20240219032559.79665-1-alvinga@andestech.com>
 <20240219032559.79665-3-alvinga@andestech.com>
 <801fb2e4-bb09-47e9-b7f6-899de574c4a3@ventanamicro.com>
 <SEYPR03MB6700A34DA4F22756C3C72CF0A8562@SEYPR03MB6700.apcprd03.prod.outlook.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <SEYPR03MB6700A34DA4F22756C3C72CF0A8562@SEYPR03MB6700.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 2/21/24 22:46, Alvin Che-Chia Chang(張哲嘉) wrote:
> Hi Daniel,
> 
>> -----Original Message-----
>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Sent: Thursday, February 22, 2024 1:26 AM
>> To: Alvin Che-Chia Chang(張哲嘉) <alvinga@andestech.com>;
>> qemu-riscv@nongnu.org; qemu-devel@nongnu.org
>> Cc: alistair.francis@wdc.com; bin.meng@windriver.com;
>> liwei1518@gmail.com; zhiwei_liu@linux.alibaba.com
>> Subject: Re: [PATCH 2/4] target/riscv: Apply modularized matching conditions
>> for breakpoint
>>
>>
>>
>> On 2/19/24 00:25, Alvin Chang wrote:
>>> We have implemented trigger_common_match(), which checks if the
>>> enabled privilege levels of the trigger match CPU's current privilege level.
>>> Remove the related code in riscv_cpu_debug_check_breakpoint() and
>>> invoke
>>> trigger_common_match() to check the privilege levels of the type 2 and
>>> type 6 triggers for the breakpoints.
>>>
>>> Only the execution bit and the executed PC should be futher checked in
>>
>> typo: further
> 
> Thanks! Will fix it.
> 
>>
>>> riscv_cpu_debug_check_breakpoint().
>>>
>>> Signed-off-by: Alvin Chang <alvinga@andestech.com>
>>> ---
>>>    target/riscv/debug.c | 26 ++++++--------------------
>>>    1 file changed, 6 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/target/riscv/debug.c b/target/riscv/debug.c index
>>> 7932233073..b971ed5d7a 100644
>>> --- a/target/riscv/debug.c
>>> +++ b/target/riscv/debug.c
>>> @@ -855,21 +855,17 @@ bool riscv_cpu_debug_check_breakpoint(CPUState
>> *cs)
>>>            for (i = 0; i < RV_MAX_TRIGGERS; i++) {
>>>                trigger_type = get_trigger_type(env, i);
>>>
>>> +            if (!trigger_common_match(env, trigger_type, i)) {
>>> +                continue;
>>> +            }
>>> +
>>
>> I believe this will change how the function behaves. Before this patch, we
>> would 'return false' if we have a TRIGGER_TYPE_AD_MATCH and
>> env->virt_enabled is true.
>>
>> Now, for the same case, we'll keep looping until we found a match, or return
>> 'false'
>> if we run out of triggers.
> 
> Oh! I didn't notice that the behavior is changed.. thank you.
> 
> Image that CPU supports both type 2 and type 6 triggers, and the debugger sets two identical breakpoints.(this should be a mistake, but we should not restrict the debugger)
> One of them is type 2 breakpoint at trigger index 0, and the other is type 6 breakpoint at trigger index 1.
> Now if the system runs in VS/VU modes, it could match type 6 breakpoint, so the looping is necessary.
> If the system runs in M/HS/U modes, it could match type 2 breakpoint.
> Is my understanding correct?

It looks correct to me. We just need to mention in the commit msg that the behavior
change is intentional, not an accident.


Thanks,

Daniel


> 
> 
> Sincerely,
> Alvin
> 
>>
>> This seems ok to do, but we should state in the commit msg that we're
>> intentionally change how the function works. If that's not the idea and we want
>> to preserve the existing behavior, we would need to do:
>>
>>>
>>> +            if (!trigger_common_match(env, trigger_type, i)) {
>>> +                return false;
>>> +            }
>>
>> Instead of just continue looping. Thanks,
>>
>>
>> Daniel
>>
>>>                switch (trigger_type) {
>>>                case TRIGGER_TYPE_AD_MATCH:
>>> -                /* type 2 trigger cannot be fired in VU/VS mode */
>>> -                if (env->virt_enabled) {
>>> -                    return false;
>>> -                }
>>> -
>>>                    ctrl = env->tdata1[i];
>>>                    pc = env->tdata2[i];
>>>
>>>                    if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
>>> -                    /* check U/S/M bit against current privilege level
>> */
>>> -                    if ((ctrl >> 3) & BIT(env->priv)) {
>>> -                        return true;
>>> -                    }
>>> +                    return true;
>>>                    }
>>>                    break;
>>>                case TRIGGER_TYPE_AD_MATCH6:
>>> @@ -877,17 +873,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState
>> *cs)
>>>                    pc = env->tdata2[i];
>>>
>>>                    if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
>>> -                    if (env->virt_enabled) {
>>> -                        /* check VU/VS bit against current privilege
>> level */
>>> -                        if ((ctrl >> 23) & BIT(env->priv)) {
>>> -                            return true;
>>> -                        }
>>> -                    } else {
>>> -                        /* check U/S/M bit against current privilege
>> level */
>>> -                        if ((ctrl >> 3) & BIT(env->priv)) {
>>> -                            return true;
>>> -                        }
>>> -                    }
>>> +                    return true;
>>>                    }
>>>                    break;
>>>                default:

