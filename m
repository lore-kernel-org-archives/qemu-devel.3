Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1C3CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7IF-0005Ml-Gu; Wed, 27 May 2026 01:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7ID-0005Ly-7y
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:59:01 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7I9-0006gU-6s
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:58:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso6632137f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779861535; x=1780466335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ee9sZzGLyJG1wXFOjF8tJxNucWSj46QyTiS43w6T5Bg=;
 b=KPbopEFNfgTfYDADQlhurGPuk7Dw0sV7ZGgPko7B2Smi/vHMkztPYIo56N/fQaIPmN
 fC2ClyBT6q2CbVl8ySnHz9ZHvAbNVNXT2uJaWXmhE2nH01JY8PO5WzWi69LP1A8cNbe8
 fLy/QwRCoOJ7/Svfy9MfwVmib4gYZQcxJRZuYALf0VU65PqLM4zrxAz+ZhNQHzWUobqe
 VoZNom/UnlvRJrhdmcPEUXOWwOTF7H7Jj7SvgNGYi5YoD+34AQCnz75JLHlqASMo3NrI
 SyQyiaxanAsUwihWCbCe2jiqcvki+GpHEZ+65/GN2j5Zpj02SD299RWI769AzGIsaQU7
 f34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779861535; x=1780466335;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ee9sZzGLyJG1wXFOjF8tJxNucWSj46QyTiS43w6T5Bg=;
 b=nWmVb26vQLnIP97vAwO56sxZAu1IPHQQzmrjUUTrVOja+B4JpJVaYsov3/Mb8/2CAs
 guUCTpio+HBWDB+ZgtDn9x3CqMxqU6KWJgnX/jlqI7TPidm4gXAmyQOibL4lY8+6FFI3
 CQcaBRdYMUXNkOF+m8OQVoXYTY8hs4hl5DHeobHcZUJV398OutBox5uMjuwF13D0emzq
 aSbT//jHbtbEXPQ1JawpR+V6gZ0ATTWGmdQqcNTpSFLfeM9HXuAXm3K1dal66rEcqmkP
 SAzX6noj6Dgx4isViw3Sk4xp/uCOd0rrYUxjd+XiaoehX360OzXnCGZo+sroftCXSqxg
 GoiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2VuN4pOb946BwFt5VLWzPU5nLuz2l64jJwd3bpQKzUvgLRfka09S9PvkyhZbq2ghW1HAD9WroS8/n@nongnu.org
X-Gm-Message-State: AOJu0Yx9zrvBIhMXLpt2lMHQHKONrbM8Vrpn/eCK4wA4NfamnMIHEHY7
 KzlQchXUGlVd1llOsS/Qhzs1/nXtuLcm5wKY3WkcYTYXcnC6b57BT4Oxy0v3nO2K+Ek=
X-Gm-Gg: Acq92OFul6PmKT9mQIV1cdZ8Pzg2U5fpDyjSAr/9/Myc1YrKI2hudhswK8nACGs2Onf
 7YBpRIr6ea67d2rKQCe3eJhVy7a38Igjp7opbJE+IMrHvN+pLHiof1M6xC8kyiNa99gRdpaDbDp
 WEkhkMLuszSKxi4reLLMNaO/CZNRltSDpaMsgITPNXQG++c3ljznSQs1bC5/xKbaJbugmdSgLjO
 PXLN33uVrBYaEAJQvHdGk+hwkuWFAUQmQORrp8uI7Ci8q26lBK7z5pg+DpQlI6Lam0Ggpi94411
 XBPCnKTwsTpFzQhawxNLuwSOwnsfn2Wcpq+Z5kZH5uiDvls4n9aZKHuQekFQqc2YTCjSKjK/fLw
 NEkRVj3S2+aGst9UO6UDf2WqXSqjXyErHglOY1I1x9eGySz2KxxrR1traav1o4bI9qnWYqvJpod
 KLIqVIq3d69Yp9S5Iw+kQUl4kf9kvUMOE/axUevlW1/OYZnjSOU4OtkOeHGDUZ9R4BJEnH5YMwd
 CbZCugaMEoiWas=
X-Received: by 2002:a05:6000:41dd:b0:43d:7883:87ce with SMTP id
 ffacd0b85a97d-45eb39f9ab2mr36433904f8f.34.1779861535425; 
 Tue, 26 May 2026 22:58:55 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb549addsm3689917f8f.5.2026.05.26.22.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 22:58:54 -0700 (PDT)
Message-ID: <3455d2a8-2345-4810-a8bd-8cb9b0c284bb@linaro.org>
Date: Wed, 27 May 2026 07:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Add support for a custom CPU arch state
To: Alistair <alistair@alistair23.me>,
 Portia Stephens <stephensportia@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Portia Stephens <portias@oss.tenstorrent.com>
References: <20260527030327.2289-1-stephensportia@gmail.com>
 <02b1f49a-84f8-4762-a21d-13c8087f6c0a@app.fastmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <02b1f49a-84f8-4762-a21d-13c8087f6c0a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi,

On 27/5/26 05:41, Alistair wrote:
> On Wed, 27 May 2026, at 1:03 PM, stephensportia@gmail.com wrote:
>> From: Portia Stephens <portias@oss.tenstorrent.com>
>>
>> Custom vendor CSR implementations may require custom state information.
>> This adds a custom_arch-state struct to the CPUArchState. It also adds a
>> RISCVCPUDef function pointer for handling allocation and initialization
>> of the custom_arch_state as well as a reset function pointer for setting
>> the custom_arch_state fields to known values on reset.
>>
>> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
>> ---
>> target/riscv/cpu.c | 15 +++++++++++++++
>> target/riscv/cpu.h |  7 +++++++
>> 2 files changed, 22 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 862834b480..ca557d27b5 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -819,6 +819,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>>       if (kvm_enabled()) {
>>           kvm_riscv_reset_vcpu(cpu);
>>       }
>> +
>> +    if (mcc->def->custom_arch_state_reset) {
>> +        mcc->def->custom_arch_state_reset(env);

ResetType shouldn't be discarded IMO.

>> +    }
>> #endif
>> }
>>   
>> @@ -1167,6 +1171,9 @@ static void riscv_cpu_init(Object *obj)
>>       if (mcc->def->custom_csrs) {
>>           riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
>>       }
>> +    if (mcc->def->custom_arch_state_init) {
>> +        mcc->def->custom_arch_state_init(&cpu->env);
>> +    }
>> #endif
>>   
>>       accel_cpu_instance_init(CPU(obj));
>> @@ -2706,6 +2713,14 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>>               assert(!mcc->def->custom_csrs);
>>               mcc->def->custom_csrs = def->custom_csrs;
>>           }
>> +        if (def->custom_arch_state_init) {
>> +            assert(!mcc->def->custom_arch_state_init);
>> +            mcc->def->custom_arch_state_init = def->custom_arch_state_init;
>> +        }
>> +        if (def->custom_arch_state_reset) {
>> +            assert(!mcc->def->custom_arch_state_reset);
>> +            mcc->def->custom_arch_state_reset = def->custom_arch_state_reset;
>> +        }
>>       }
>>   
>>       if (!object_class_is_abstract(c)) {
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 7d79c7a5a7..8132c65012 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -213,6 +213,9 @@ typedef struct PMUFixedCtrState {
>>           uint64_t counter_virt_prev[2];
>> } PMUFixedCtrState;
>>   
>> +typedef void (*riscv_csr_custom_init_fn)(CPURISCVState *env);
>> +typedef void (*riscv_csr_custom_reset_fn)(CPURISCVState *env);
>> +
>> struct CPUArchState {
>>       target_ulong gpr[32];
>>       target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
>> @@ -509,6 +512,8 @@ struct CPUArchState {
>>       uint64_t rnmip;
>>       uint64_t rnmi_irqvec;
>>       uint64_t rnmi_excpvec;
>> +
>> +    const void *custom_arch_state;
>> };
>>   
>> /*
>> @@ -561,6 +566,8 @@ typedef struct RISCVCPUDef {
>>       RISCVCPUConfig cfg;
>>       bool bare;
>>       const RISCVCSR *custom_csrs;
>> +    riscv_csr_custom_init_fn custom_arch_state_init;
>> +    riscv_csr_custom_reset_fn custom_arch_state_reset;
> 
> Why do we need an init and a reset? I assume init is to allocate the stuct, but that should probably be commented here.
> 
> How do you expect these to be set? Do you have an example?

I don't see the point of upstreaming this patch without concrete
example. So far it is maintenance burden without any value.

> 
> Alistair
> 
>> } RISCVCPUDef;
>>   
>> /**
>> -- 
>> 2.43.0
>>
>>
>>
> 


