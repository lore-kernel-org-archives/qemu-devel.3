Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED64CC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqCPb-0003uG-DI; Thu, 06 Mar 2025 09:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqCPY-0003th-QQ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:41:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqCPW-0005HV-Uy
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741272077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mtCXg6grMPLJClan6P+6p+RZIhSvFMABkaMd0ADEUE8=;
 b=EQ9yhyUU/7OKtnHpYgacfAcunO1meoQLyF58hDf69jlFcAQx+HytoEtuNTJJNMlyp4hGXM
 GoaEh8LWV5MBXBYYy9u3HrCOUxjcHgZSQ2Lg6nMnA3YYCmrDFCw0KqPQdZJiOHkCtMR5we
 WuduyYQmsE459sqpwUS570Gzp9vhzwA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-H9MYiPZENLyxfJG-1DbvwQ-1; Thu, 06 Mar 2025 09:41:06 -0500
X-MC-Unique: H9MYiPZENLyxfJG-1DbvwQ-1
X-Mimecast-MFC-AGG-ID: H9MYiPZENLyxfJG-1DbvwQ_1741272065
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390de58dc09so540576f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 06:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741272064; x=1741876864;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtCXg6grMPLJClan6P+6p+RZIhSvFMABkaMd0ADEUE8=;
 b=nm1LkQUz8Bwd2WeXraUwj5ykEFJ7+dILKg7STWd2vWYl93L4zoxOlGfueJFc0hwxKo
 XWCUV00zMYLPSPbgaxBAkzF1jmI/JEpngCFBhDwLxZhLF3AcjKbZIHOLi6NKFhce4/7J
 aZOT6XRa59ZMuHvZIDQCjT1CfOrRMOgSmxyDxHM2Ho4GE0j6FVA8sT0XQrPX75mc/A+o
 I7FRl2RozCeQhtKFjZR8rLp7GF2H+rKDEaPtEamjdhuZZ1sWbkTmv1CmoZ3k+clSTAVc
 93tCO1a6Tby3BZnzDc0XTPd0JQEx8q9jYjAXzbRHDU1JGFyua+2hFS/Y6sQcfapUDG6E
 RrOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWudgPLGxWBIjzDE9WXgrqM1pySoy0jRt83s97YH9Rd91P2hP69P55TLaCNd0eE434cX25vJEQfD7B@nongnu.org
X-Gm-Message-State: AOJu0YwOTKttSidAmp6H3uDxKnFAP5soEW+LxFbn0bIFqZ1WhNivRkad
 loLK7VaTJTPqLC6uvkq6hIFNpU7XgskQmz6PrH+WpejNogU5kTTl18pcZsxSSRtoBz/Y5fsO7sl
 JzhUBnoqVH3EKKc4eiobRlKD32cNrgJIIRz2nAwUTtkWh+dQQUY43
X-Gm-Gg: ASbGncut0YwfQD7f37/KK5meRSrA+EUgUa7mWK1+U0nsW4BfgXS45EgusOyh9CIW9Lo
 dsherQgsXHSB/dE0b20kSZFiRvQFB5yXYoax5Lf16rQ7AW3dJeXpWF5GnB/f6pmxwCLnHmTlOxN
 cy2lzkWETxo6a6K8Q+js0Ed78CJfZJOINROagpILlPkUoMetIR/HFPYtT/4RI8hXvE8RF49UF/k
 tQgaCnMmEOfZNoRNqMdcl6I8OFdbTf3yNH6YEpXd8+XsbTmT6sLxbhOrRs/PofyAHoxUoSXAO7I
 HaUEVJ8hYF7KiPr93Qigj9ibNBb7ZdLh/SgYU9wQ5Q2zlghYtSwMKw==
X-Received: by 2002:a5d:5885:0:b0:390:e62e:f31f with SMTP id
 ffacd0b85a97d-3911f7205c6mr7245748f8f.3.1741272064421; 
 Thu, 06 Mar 2025 06:41:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzCAAg7v2nL5opbsaPFLUzpk1VLplx8LGJ6WegGFWNcki2ph/9iX0igWzfjiauWUsf7b5u2w==
X-Received: by 2002:a5d:5885:0:b0:390:e62e:f31f with SMTP id
 ffacd0b85a97d-3911f7205c6mr7245718f8f.3.1741272064005; 
 Thu, 06 Mar 2025 06:41:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb79adsm2227942f8f.7.2025.03.06.06.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 06:41:03 -0800 (PST)
Message-ID: <b73d5989-f5a8-4370-be6f-6f6bb609a38e@redhat.com>
Date: Thu, 6 Mar 2025 15:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] cpu: Introduce cpu_get_phys_bits()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-8-clg@redhat.com>
 <4dc45084-fb9d-4fed-88b0-18b0034c8c74@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4dc45084-fb9d-4fed-88b0-18b0034c8c74@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/6/25 11:37, Philippe Mathieu-Daudé wrote:
> On 30/1/25 14:43, Cédric Le Goater wrote:
>> The Intel CPU has a complex history regarding setting of the physical
>> address space width on KVM. A 'phys_bits' field and a "phys-bits"
>> property were added by commit af45907a1328 ("target-i386: Allow
>> physical address bits to be set") to tune this value.
>>
>> In certain circumstances, it is interesting to know this value to
>> check that all the conditions are met for optimal operation. For
>> instance, when the system has a 39-bit IOMMU address space width and a
>> larger CPU physical address space, we expect issues when mapping the
>> MMIO regions of passthrough devices and it would good to report to the
>> user. These hybrid HW configs can be found on some consumer grade
>> processors or when using a vIOMMU device with default settings.
>>
>> For this purpose, add an helper routine and a CPUClass callback to
>> return the physical address space width of a CPU.
>>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Eduardo Habkost <eduardo@habkost.net>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
>> Cc: Yanan Wang <wangyanan55@huawei.com>
>> Cc: Zhao Liu <zhao1.liu@intel.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/hw/core/cpu.h            |  9 +++++++++
>>   include/hw/core/sysemu-cpu-ops.h |  6 ++++++
>>   cpu-target.c                     |  5 +++++
>>   hw/core/cpu-system.c             | 11 +++++++++++
>>   target/i386/cpu.c                |  6 ++++++
>>   5 files changed, 37 insertions(+)
>>
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index fb397cdfc53d12d40d3e4e7f86251fc31c48b9f6..1b3eead102ce62fcee55ab0ed5e0dff327fa2fc5 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -748,6 +748,14 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
>>    */
>>   bool cpu_virtio_is_big_endian(CPUState *cpu);
>> +/**
>> + * cpu_get_phys_bits:
>> + * @cpu: CPU
>> + *
>> + * Return the physical address space width of the CPU @cpu.
>> + */
>> +uint32_t cpu_get_phys_bits(const CPUState *cpu);
>> +
>>   #endif /* CONFIG_USER_ONLY */
>>   /**
>> @@ -1168,6 +1176,7 @@ void cpu_exec_unrealizefn(CPUState *cpu);
>>   void cpu_exec_reset_hold(CPUState *cpu);
>>   const char *target_name(void);
>> +uint32_t target_phys_bits(void);
>>   #ifdef COMPILING_PER_TARGET
>> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
>> index 0df5b058f50073e47d2a6b8286be5204776520d2..210b3ed57985525795b81559e41e0085969210d5 100644
>> --- a/include/hw/core/sysemu-cpu-ops.h
>> +++ b/include/hw/core/sysemu-cpu-ops.h
>> @@ -81,6 +81,12 @@ typedef struct SysemuCPUOps {
>>        */
>>       bool (*virtio_is_big_endian)(CPUState *cpu);
>> +    /**
>> +     * @get_phys_bits: Callback to return the physical address space
>> +     * width of a CPU.
>> +     */
>> +    uint32_t (*get_phys_bits)(const CPUState *cpu);
>> +
>>       /**
>>        * @legacy_vmsd: Legacy state for migration.
>>        *               Do not use in new targets, use #DeviceClass::vmsd instead.
>> diff --git a/cpu-target.c b/cpu-target.c
>> index 667688332c929aa53782c94343def34571272d5f..88158272c06cc42424d435b9701e33735f080239 100644
>> --- a/cpu-target.c
>> +++ b/cpu-target.c
>> @@ -472,3 +472,8 @@ const char *target_name(void)
>>   {
>>       return TARGET_NAME;
>>   }
>> +
>> +uint32_t target_phys_bits(void)
>> +{
>> +    return TARGET_PHYS_ADDR_SPACE_BITS;
>> +}
>> diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
>> index 6aae28a349a7a377d010ff9dcab5ebc29e1126ca..05067d84f4258facf4252216f17729e390d38eae 100644
>> --- a/hw/core/cpu-system.c
>> +++ b/hw/core/cpu-system.c
>> @@ -60,6 +60,17 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>>       return cc->sysemu_ops->get_phys_page_debug(cpu, addr);
>>   }
>> +uint32_t cpu_get_phys_bits(const CPUState *cpu)
>> +{
>> +    CPUClass *cc = CPU_GET_CLASS(cpu);
>> +
>> +    if (cc->sysemu_ops->get_phys_bits) {
>> +        return cc->sysemu_ops->get_phys_bits(cpu);
>> +    }
>> +
>> +    return target_phys_bits();
> 
> I might have suggested to return TARGET_PHYS_ADDR_SPACE_BITS
> by default in v1, I'm not sure about it anymore. Maybe default
> to 0 and have each target register its helper if necessary?

sure. No problem. I can change that.


Thanks,

C.


> 
>> +}
>> +
>>   hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
>>   {
>>       MemTxAttrs attrs = {};
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index b5dd60d2812e0c3d13c1743fd485a9068ab29c4f..01cf9a44963710a415c755c17582730f75233143 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -8393,6 +8393,11 @@ static bool x86_cpu_get_paging_enabled(const CPUState *cs)
>>       return cpu->env.cr[0] & CR0_PG_MASK;
>>   }
>> +
>> +static uint32_t x86_cpu_get_phys_bits(const CPUState *cs)
>> +{
>> +    return X86_CPU(cs)->phys_bits;
>> +}
>>   #endif /* !CONFIG_USER_ONLY */
>>   static void x86_cpu_set_pc(CPUState *cs, vaddr value)
>> @@ -8701,6 +8706,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
>>       .get_memory_mapping = x86_cpu_get_memory_mapping,
>>       .get_paging_enabled = x86_cpu_get_paging_enabled,
>>       .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
>> +    .get_phys_bits = x86_cpu_get_phys_bits,
>>       .asidx_from_attrs = x86_asidx_from_attrs,
>>       .get_crash_info = x86_cpu_get_crash_info,
>>       .write_elf32_note = x86_cpu_write_elf32_note,
> 


