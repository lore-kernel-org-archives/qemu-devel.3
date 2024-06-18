Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F70C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWwb-0000wh-H7; Tue, 18 Jun 2024 07:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWwZ-0000w5-Lk
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:24:07 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWwX-00073W-Oi
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:24:07 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6f04afcce1so678422866b.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718709844; x=1719314644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6nbJScOoRKhqtIy/3HNESZI5DaWAXa8KjZ01Ce9wnFM=;
 b=ECooE9YKFEHfWiAgs5CwcL4kO5dLG/SdH+bYiwKO/hZk7WRzNA1rt+H6cYJNTYZaQM
 zNTLIe/qciOtWm4PFV6VGJgVbMHDN8F7OFJgcmF/94meg61O8A3kKReaZigrA2oIiLzt
 tWYbno7V6vmEgrYi3cm/ffe/TVVlaY2THZItJnBMfrEMAp5fJNKhEmnMvl6uQiOzobeQ
 oSU7UmSYeb3SJnxBmIjNTK8lU4PaRo9unhF0rxTCIVDj9qr6tEfPFZCR3vhgpSxCyufb
 87zbs9MB3STWXlQaRcypeVoR0T81iODELXCR0/vKZhdmWf3pHkTrmJQ+XtLxjyRn9sMA
 Pf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718709844; x=1719314644;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6nbJScOoRKhqtIy/3HNESZI5DaWAXa8KjZ01Ce9wnFM=;
 b=nbGaXNE9v/u3NvnAIpeCuf3c2b/J0urvSeESR4ipVBze/alu+n2omaf682JZ6VMST3
 f87PmRw9fF6p/dG3i4WDm/hiot+BDYExGjrq/fCTKer/e8f56CGfFDhOMl1wfh9EJ5vz
 Hi7QlaeF2AL+Xdki6o6ZNa+8+wgwq028pymbtGxLeJlyJM9KzzPUIq/GPyAHBlcD72yD
 4MaNV9hnkFXDoSE9rb2Zm3E0F8G6qEAOpzPkw2Bkl1cIOAlc1h6SnZrSsQDWcoW9iACw
 fTSfzrqtSlmxjHN3jM19q/hUupho3d/Ru7yePI+6DqfPqwU9YxP8Fzxs+Bu8FONnLC9O
 u/qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjofgBykurBM4rJK/7ZRFLQYUAhZ6Dd0vl6YCcrEn3qYAJEUOB/e4TBNMmRQwV55aTdwfKlK/EONG2LPtjVIyl/SuRpGk=
X-Gm-Message-State: AOJu0YyITJxi6/RlUzldOSp4N9qTv4M8IYlSc541dqXGl26oNlPlW/Hn
 hEeXr32JQt7Bsyjnp/SCgiuq2cgKSklh0/QgeOTopeBpMngO7jD25dF6xLxanSg=
X-Google-Smtp-Source: AGHT+IE9kpm7BHbmCHiXKYNbQjHE8VNcLq+3QpNbrids6jwaREs5/ec0yqW0qFosQr0SJvZTHiBrng==
X-Received: by 2002:a17:907:160e:b0:a6f:9da3:69a1 with SMTP id
 a640c23a62f3a-a6f9da36a81mr84928766b.47.1718709844036; 
 Tue, 18 Jun 2024 04:24:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f5b5ce0c2sm581521166b.78.2024.06.18.04.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:24:03 -0700 (PDT)
Message-ID: <972034d6-23b3-415a-b401-b8bc1cc515c9@linaro.org>
Date: Tue, 18 Jun 2024 13:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] hw/mips/loongson3_virt: Wire up loongson_ipi device
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-3-ddd2c0e03fa3@flygoat.com>
 <3561837a-895b-4e5f-bc40-bdf101cb38cb@linaro.org>
Content-Language: en-US
In-Reply-To: <3561837a-895b-4e5f-bc40-bdf101cb38cb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 18/6/24 13:17, Philippe Mathieu-Daudé wrote:
> On 5/6/24 04:15, Jiaxun Yang wrote:
>> Wire up loongson_ipi device for loongson3_virt machine, so we
>> can have SMP support for TCG backend as well.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   hw/mips/Kconfig           |  1 +
>>   hw/mips/loongson3_bootp.c |  2 --
>>   hw/mips/loongson3_bootp.h |  3 +++
>>   hw/mips/loongson3_virt.c  | 39 +++++++++++++++++++++++++++++++++++++--
>>   4 files changed, 41 insertions(+), 4 deletions(-)
> 
> 
>> @@ -527,6 +531,19 @@ static void mips_loongson3_virt_init(MachineState 
>> *machine)
>>       create_unimplemented_device("mmio fallback 0", 0x10000000, 256 * 
>> MiB);
>>       create_unimplemented_device("mmio fallback 1", 0x30000000, 256 * 
>> MiB);
>> +    memory_region_init(iocsr, OBJECT(machine), "loongson3.iocsr", 
>> UINT32_MAX);
>> +
>> +    /* IPI controller is in kernel for KVM */
>> +    if (!kvm_enabled()) {
> 
> Generically one could come with another hypervisor support, so better
> to check for what you are expecting. You could see some uses of:
> 
>    if (tcg) ... else if (kvm) ... else abort().
> 
>> +        ipi = qdev_new(TYPE_LOONGSON_IPI);
>> +        qdev_prop_set_uint32(ipi, "num-cpu", machine->smp.cpus);
>> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
>> +        memory_region_add_subregion(iocsr, SMP_IPI_MAILBOX,
>> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
>> +        memory_region_add_subregion(iocsr, MAIL_SEND_ADDR,
>> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
>> +    }
>> +
>>       liointc = qdev_new("loongson.liointc");
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
>> @@ -543,6 +560,8 @@ static void mips_loongson3_virt_init(MachineState 
>> *machine)
>>       clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
>>       for (i = 0; i < machine->smp.cpus; i++) {
>> +        int node = i / LOONGSON3_CORE_PER_NODE;
>> +        int core = i % LOONGSON3_CORE_PER_NODE;
>>           int ip;
>>           /* init CPUs */
>> @@ -553,12 +572,28 @@ static void 
>> mips_loongson3_virt_init(MachineState *machine)
>>           cpu_mips_clock_init(cpu);
>>           qemu_register_reset(main_cpu_reset, cpu);
>> -        if (i >= 4) {
>> +        if (ipi) {
>> +            hwaddr base = ((hwaddr)node << 44) + 
>> virt_memmap[VIRT_IPI].base;
>> +            base += core * 0x100;
>> +            qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);
>> +            sysbus_mmio_map(SYS_BUS_DEVICE(ipi), i + 2, base);
>> +        }
>> +
>> +        if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
>> +            MemoryRegion *core_iocsr = g_new(MemoryRegion, 1);

Please store this in LoongsonMachineState (new patch):

   MemoryRegion core_iocsr[LOONGSON_MAX_VCPUS];

>> +            g_autofree char *name = 
>> g_strdup_printf("loongson3.core%d_iocsr", i);
>> +            memory_region_init_alias(core_iocsr, OBJECT(cpu), name,
>> +                                     iocsr, 0, UINT32_MAX);
>> +            memory_region_add_subregion(&MIPS_CPU(cpu)->env.iocsr.mr,
>> +                                        0, core_iocsr);
>> +        }
>> +
>> +        if (node > 0) {
>>               continue; /* Only node-0 can be connected to LIOINTC */
>>           }
> 
> Pre-existing, but the logic appears clearer as:
> 
>            if (node == 0) {
>>           for (ip = 0; ip < 4 ; ip++) {
>> -            int pin = i * 4 + ip;
>> +            int pin = core * LOONGSON3_CORE_PER_NODE + ip;
>>               sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
>>                                  pin, cpu->env.irq[ip + 2]);
>>           }
>>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


