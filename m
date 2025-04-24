Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7FBC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 14:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7xSi-0002ES-RZ; Thu, 24 Apr 2025 10:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7xSg-0002DL-8y
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:21:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7xSe-0001m5-9O
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 10:21:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so17595215ad.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745504514; x=1746109314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zjlf7f/BE0JfCATXRz/V+ON4p7bRKPsZIUZECNyXgZo=;
 b=LJEe+AjfS4TntTIFoGPUEx5O00onu84Y1NitP8CI+hd1PCYNef/4hdf9rQNiGe8Npc
 sg/m0GorgxR+ubUM3K40itt98+l+Jz6dZJMN+CfSM61GjJ1fd3HaE7rfP3Bgej3gU0zt
 Bl3heuKEIa17S/3z6Wri5nzXUDyVqHaU6lki8FtGHQKhP08eX6Z77a71J+Ub4oZ4oxgQ
 7i4wp9WJ4R633ADXyibulKNPTMZ/8ewOK9cyxwTFUwFPzx07wfXocpKfWkWGQy4gV7hd
 LAMlV7n9gJO6h+FHpEeTZlOaRez3qvc+BGmhXQ2wonF/rzxTMZjGOxRmcZayDSMV5ppU
 brow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745504514; x=1746109314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zjlf7f/BE0JfCATXRz/V+ON4p7bRKPsZIUZECNyXgZo=;
 b=oxQiqV/NfqeFdZbHuLSj88fn77ABYFDELPIGTaG0POmYN7+cvuPlJXsPNQ756H1EME
 ucdbwMDJ3AZ3xm9FT1Y2LbhIB65rMh4BemwFYwpBEmn2s3s52p4HpZHl1ci8QGs4/lwr
 XkgCvUSwdFM6t+VFeUVOm1NI5UyJcEnwtKiAHN8Q+hTQyOwFcZ0xZK41HK2xUHSjgz6m
 2NOqtxSBiMxqi3Oy6ngdCz42OjEMhMM0HODUDC52fm41AeQGKXK/l8CB9HwDr+a2yZIn
 MkbLqqxrTIHLUytu3jdiS5rKckPAyJiUUKhPickSJscf7o2bsWX2CLBvHLvhzLnl175c
 YRtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcGzael6so7aGm84bD/jPbH80SQI1wWIqLOBev0I1zlzrwsc7T7Q5V35w9dWRq+fBef+OBb6JKO/OJ@nongnu.org
X-Gm-Message-State: AOJu0YzwJljYUcPnhmeWYAbQPLKkINIJjPuLpkqtOiAJub1ycLLxeMQb
 juOChR4yVyzzDG1KoDbXKxEW67zpvsagWbiKYktiv38ibKYzdD01BvtnBwJOLEA=
X-Gm-Gg: ASbGncukS0J5YOgKmaaBk9zoReiuYT5Yd2e2wy77dQWIyX/KXOk1iA/fW9fRk/VsLnb
 Blfq7Ht3Ysgyjioi5wxBRx7fUpqBJVB8VbW2Sk6RVTwawDP1nZLUL+9wTY6dI455JkDWdUXJ7oU
 jqSLPb7SM4IPQVGvkA1zWQeo8CaS1NvbKgYx20JscGAFqmT0O2T7EkA5KKfV043iakQ3NUST/ln
 YpGPSt7TzmFJS0lQWdRHCE8zT2qVxIxcYO8YjJu6Kv6UVHLuyc5I0IKuGPpn0uqex3puh5EiiCl
 YYWiEJG3isIWhWkNvJAMT2BmIkSX91m1ZTOJQb8Iayyp7eQrZ8M5cVeSBeFYQyBfLw==
X-Google-Smtp-Source: AGHT+IHZcQgsF8P3REMCRspIJWXFuLveZTa4j33h/Y5ULYfRTRXwDBGRf5dOu2zaPdSUfM9/YxO8Pw==
X-Received: by 2002:a17:902:d2cb:b0:227:e74a:a05a with SMTP id
 d9443c01a7336-22db3dcd51amr50970715ad.44.1745504514686; 
 Thu, 24 Apr 2025 07:21:54 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5216adbsm13800195ad.234.2025.04.24.07.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 07:21:54 -0700 (PDT)
Message-ID: <57e994b8-67c8-4022-9964-961ca13ceab3@ventanamicro.com>
Date: Thu, 24 Apr 2025 11:21:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/27] target/riscv: store RISCVCPUDef struct directly in
 the class
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-9-pbonzini@redhat.com>
 <8f3bae37-e1f3-4e55-9dc6-b7876992b47e@ventanamicro.com>
 <b92509a8-43e5-4515-b609-fcc17805c32f@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <b92509a8-43e5-4515-b609-fcc17805c32f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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



On 4/24/25 11:04 AM, Philippe Mathieu-Daudé wrote:
> On 24/4/25 15:52, Daniel Henrique Barboza wrote:
>> Hi,
>>
>> This patch breaks RISC-V KVM build in my env. The issues are down there:
>>
>> On 4/6/25 4:02 AM, Paolo Bonzini wrote:
>>> Prepare for adding more fields to RISCVCPUDef and reading them in
>>> riscv_cpu_init: instead of storing the misa_mxl_max field in
>>> RISCVCPUClass, ensure that there's always a valid RISCVCPUDef struct
>>> and go through it.
>>>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   target/riscv/cpu.h         |  2 +-
>>>   hw/riscv/boot.c            |  2 +-
>>>   target/riscv/cpu.c         | 23 ++++++++++++++++++-----
>>>   target/riscv/gdbstub.c     |  6 +++---
>>>   target/riscv/kvm/kvm-cpu.c | 21 +++++++++------------
>>>   target/riscv/machine.c     |  2 +-
>>>   target/riscv/tcg/tcg-cpu.c | 10 +++++-----
>>>   target/riscv/translate.c   |  2 +-
>>>   8 files changed, 39 insertions(+), 29 deletions(-)
> 
> 
>>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>>> index 0f4997a9186..d7e6970a670 100644
>>> --- a/target/riscv/kvm/kvm-cpu.c
>>> +++ b/target/riscv/kvm/kvm-cpu.c
>>> @@ -1997,22 +1997,19 @@ static void kvm_cpu_accel_register_types(void)
>>>   }
>>>   type_init(kvm_cpu_accel_register_types);
>>> -static void riscv_host_cpu_class_init(ObjectClass *c, void *data)
>>> -{
>>> -    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
>>> -
>>> -#if defined(TARGET_RISCV32)
>>> -    mcc->misa_mxl_max = MXL_RV32;
>>> -#elif defined(TARGET_RISCV64)
>>> -    mcc->misa_mxl_max = MXL_RV64;
>>> -#endif
>>> -}
>>> -
>>>   static const TypeInfo riscv_kvm_cpu_type_infos[] = {
>>>       {
>>>           .name = TYPE_RISCV_CPU_HOST,
>>>           .parent = TYPE_RISCV_CPU,
>>> -        .class_init = riscv_host_cpu_class_init,
>>> +#if defined(TARGET_RISCV32)
>>> +        .class_data = &((const RISCVCPUDef) {
>>> +            .misa_mxl_max = MXL_RV32,
>>> +        },
>>> +#elif defined(TARGET_RISCV64)
>>> +        .class_data = &((const RISCVCPUDef) {
>>> +            .misa_mxl_max = MXL_RV64,
>>> +        },
>>> +#endif
>>>       }
>>>   };
>>
>>
>> ../target/riscv/kvm/kvm-cpu.c:2013:5: error: expected expression before '}' token
>>   2013 |     }
>>        |     ^
>> ../target/riscv/kvm/kvm-cpu.c:2011:10: error: value computed is not used [-Werror=unused-value]
>>   2011 |         },
>>        |          ^
>> cc1: all warnings being treated as errors
>> [11/13] Linking target qemu-nbd
>>
>>
>> We're missing closing parenthesis after the "}".
>>
>> If we fix that we'll get another error:
>>
>> ../target/riscv/kvm/kvm-cpu.c:2009:23: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>>   2009 |         .class_data = &((const RISCVCPUDef) {
>>        |                       ^
>> cc1: all warnings being treated as errors
>>
>>
>> Removing the 'const' qualifier fixes this other error.
> 
> Likely based on:
> https://lore.kernel.org/qemu-devel/20250210133134.90879-1-philmd@linaro.org/
> which was too late to get merged before soft-freeze, but
> should get it soon.

Oh yeah, sorry. I forgot to mention that I tested the patch in Alistair's
branch. The branch doesn't have these class_data changes.

In case these changes land upstream first then we can keep the 'const'
qualifier in this patch. Thanks,


Daniel


> 


