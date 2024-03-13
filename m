Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DBDC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkLnr-0002IZ-Sg; Wed, 13 Mar 2024 06:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkLnZ-0002Cu-Bf
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:25:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkLnD-00013Y-Ip
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:25:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33ddd1624beso503124f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710325501; x=1710930301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JjObnrYudOZ65bRXofCfG3Pr+nau5HcZmS4kvpbvXP8=;
 b=tmsyTPeKXDD7nMglaxlXksqEEH2DdOIdGIMttuofsgi+Ew2HMqdccIG9mi6AvaE3bv
 JsN1OJIYFN12Dss+oclqYkIEVpI51UDwNHh9lYKx2O1OHgURZ+6qJV4cSXPjXwpvpjyH
 MEXPX2WD8uH7gUiQNhtLR4j9ShdXLQLoiAlg4raeZXSXHw+qlF+sCK+E8HOt7AtpWrVB
 rp6ixz9CWrHMhUVIWyq823b3Q401bV71hT38fgIt5UUGD9G43BOgbfYmpigtGzPCt9Fn
 LNbCNRy2wSMXOXNq6QyKiDQNktQF6+Dd7g4tPoH3wuZU9cT4JaS09u3eIkj4zgYnE3Xw
 gLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710325501; x=1710930301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjObnrYudOZ65bRXofCfG3Pr+nau5HcZmS4kvpbvXP8=;
 b=AMuh/vKIaaIXY8hz31bWGflSZ3gB7je3/WBpdNaEfcPrC4emlzJk1y9khjLxG+3ERZ
 3AmuOQW2Fa2fWOBZj4UJxtMNtkeslvtgzO7KVi9bUxS0vJtOwS9YdlETRpxLiPdkvxcK
 UbIIAcW1jokbbO0TqxB6rQdJwA7dmizFoYFWZueGBgpEpseLa02mCiukmGEyIXX0Qes0
 z02T76TRG8/GGITvNV1eOffp6g/LSE07uN1mQFeYicfDimlj0zBVycxHAh7lDdJJC+oC
 +F+OQhe1KM7c7RovLHpXW5yqlERLHl3Eloo7HKzXpCjHZ+h3dEXMO+MF01NMtcKpqZxw
 slLw==
X-Gm-Message-State: AOJu0YxhBtsjZst9Ju3Re7xnwqOHWjDWJEOH2sWrdiX91fYrChZ/mLnL
 7B6A7nUGE71Gi0H6lzeHaYVyN3GEU/U3ky8orhd3928C0nKWwAVDp0iPqLxqKAZPXyO6AM5nENB
 8oUk=
X-Google-Smtp-Source: AGHT+IHrMmtnpAUlnZ2XvT4d/3Tp9WaCAFrjIy+JVXJXJAKSpJYE6DV7jAFg0ZKoBdo7FkEKD3WNog==
X-Received: by 2002:adf:d046:0:b0:33e:bcc2:7ee0 with SMTP id
 v6-20020adfd046000000b0033ebcc27ee0mr565123wrh.6.1710325501166; 
 Wed, 13 Mar 2024 03:25:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a056000108900b0033e206a0a7asm11371442wrw.26.2024.03.13.03.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:25:00 -0700 (PDT)
Message-ID: <b24dead7-b178-452c-ad76-05e4bc86ce79@linaro.org>
Date: Wed, 13 Mar 2024 11:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv/kvm: fix timebase-frequency when using
 KVM acceleration
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com,
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240313081359.20845-1-yongxuan.wang@sifive.com>
 <20240313-d11a0490609909bd354f01b2@orel>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313-d11a0490609909bd354f01b2@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/3/24 09:56, Andrew Jones wrote:
> On Wed, Mar 13, 2024 at 04:13:57PM +0800, Yong-Xuan Wang wrote:
>> The timebase-frequency of guest OS should be the same with host
>> machine. The timebase-frequency value in DTS should be got from
>> hypervisor when using KVM acceleration.
>>
>> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
>> ---
>>   hw/riscv/virt.c              | 11 +++++++++--
>>   target/riscv/kvm/kvm-cpu.c   |  9 +++++++++
>>   target/riscv/kvm/kvm_riscv.h | 13 +++++++++++++
>>   3 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index a094af97c32a..a7ed7fa13010 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -710,8 +710,15 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
>>       int socket_count = riscv_socket_count(ms);
>>   
>>       qemu_fdt_add_subnode(ms->fdt, "/cpus");
>> -    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",

Alternatively:
                      kvm_enabled() ?
                      kvm_riscv_get_timebase_frequency(first_cpu) :


>> -                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
>> +
>> +    if (kvm_enabled()) {
>> +        qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
>> +                              kvm_riscv_get_timebase_frequency(first_cpu));
>> +    } else {
>> +        qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
>> +                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
>> +    }
>> +
>>       qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
>>       qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
>>       qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index c7afdb1e81b7..bbb115eaa867 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -739,6 +739,15 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
>>       env->kvm_timer_dirty = false;
>>   }
>>   
>> +uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
>> +{
>> +    uint64_t reg;
>> +
>> +    KVM_RISCV_GET_TIMER(cs, frequency, reg);
>> +
>> +    return reg;
>> +}
>> +
>>   static int kvm_riscv_get_regs_vector(CPUState *cs)
>>   {
>>       RISCVCPU *cpu = RISCV_CPU(cs);
>> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
>> index 4bd98fddc776..130a4bde0480 100644
>> --- a/target/riscv/kvm/kvm_riscv.h
>> +++ b/target/riscv/kvm/kvm_riscv.h
>> @@ -29,4 +29,17 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level);
>>   int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
>>   void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>>   
>> +#ifdef CONFIG_KVM
>> +
>> +uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs);
>> +
>> +#else
>> +
>> +static inline uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
>> +{
>> +    g_assert_not_reached();
>> +}
>> +
>> +#endif
>> +
> 
> I think we've decided we don't need stubs like these since kvm_riscv_*
> functions should always be called within 'if (kvm_enabled())' blocks (as
> you have above), and then we leave it to the compile testing to point
> out kvm function calls without kvm_enabled().

Yes please!

> 
>>   #endif
>> -- 
>> 2.17.1


