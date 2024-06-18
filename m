Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E48C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWps-0006A6-HT; Tue, 18 Jun 2024 07:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWpr-00069w-8q
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:17:11 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWpp-0005vB-Do
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:17:10 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00ba6so4631591a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718709427; x=1719314227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5JO6aPU/rvXapwUpsJxQBr9hEa+bvufxHl0XhUOqEiU=;
 b=sbdq6qMqFA8IB2qyUl07p3fbiy11YO7i+jg64CoNNDidNLxTnGpSE1fd4xxiQ2PCZP
 RRHlElCp0Dg8KG2mXIs+oeXiJKv4vj/zxJvCBv8JkuMAE2cfGefL0gF/AkS6R3oqbFwP
 R9lgxoQ3g/9pLe0f+/ZqukurYmUvNqhTM/9W57//pz5Ga0ZBLFqrwFt03772sIXRHY6C
 Jta/nf8iX4UWdMhBqm9j2thpQr+Zb/ZqW9byqXhTDWOr9wSUI5yKKQFucm15cFZc5TYd
 9TKoHCf52aY5vn6YCZhTW+WTg19FdUFCTTfqo2Uqw3+e7oOCCGaCMrGErHBbXwvBDDkl
 Xqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718709427; x=1719314227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5JO6aPU/rvXapwUpsJxQBr9hEa+bvufxHl0XhUOqEiU=;
 b=pzZ4eop89GI1hd5XXzqd33eavFyUqFUdEyZ0ggGTgwuxz55S05HJ3KYViumhiYlIHB
 bdcA1a5NM+tKs6QJLEbhUIn46I9kDDb/ofOP1n0zndlBPyFnHrqrTtOHd8eZoHGOEuie
 D02SvETMQ9XGu//5iRk61CsJJxF+RtdgW1KiLO4KRoK1oL2yg6OytIw8hsLwGy2QPCSR
 vYFCQyGoagdzAUL7dOfH2rDvV3aobRYMGtRL4EzWTzNa4B3lnIEiAaGIz5bVhPY0sKiB
 syUySuPqhQByruDucmu6O8VJA2asarJv8WSeOTlVXebBMKVbSG4D8FrYnHGNeIhD9KlW
 cKkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9oo8eURIAd+BvlHezia4ROtEe6GgpngJaWRfo8ZqVG6feRLX9gMARqt9AXUq8eqKIeFwC8i6uzfmDu632U/0/ud4Zzvw=
X-Gm-Message-State: AOJu0YyrAk/n7dYZpWE6gfv8vQUdOG+5UZ5jpHG/3NfxauHRNjGLVZfU
 1eKS9slFtL9If5jn4Eb1GfOAvDn8AIkdpzToCFIH6rsfA90oaNTckxJ+fdVNT0RjoQrqK7vhEbY
 yKNo=
X-Google-Smtp-Source: AGHT+IFvrMu4x5jlYviV3dcRyo6qP3TmgNvYVpo5oxeQgHYIfGQCqBEk2GsbWq7i8HcImNrAXVIPGg==
X-Received: by 2002:a50:ccc4:0:b0:579:c3f8:591c with SMTP id
 4fb4d7f45d1cf-57cbd687a0amr8390144a12.18.1718709427231; 
 Tue, 18 Jun 2024 04:17:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cbdfe1428sm6540673a12.27.2024.06.18.04.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:17:06 -0700 (PDT)
Message-ID: <3561837a-895b-4e5f-bc40-bdf101cb38cb@linaro.org>
Date: Tue, 18 Jun 2024 13:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] hw/mips/loongson3_virt: Wire up loongson_ipi device
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-3-ddd2c0e03fa3@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240605-loongson3-ipi-v3-3-ddd2c0e03fa3@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 5/6/24 04:15, Jiaxun Yang wrote:
> Wire up loongson_ipi device for loongson3_virt machine, so we
> can have SMP support for TCG backend as well.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/mips/Kconfig           |  1 +
>   hw/mips/loongson3_bootp.c |  2 --
>   hw/mips/loongson3_bootp.h |  3 +++
>   hw/mips/loongson3_virt.c  | 39 +++++++++++++++++++++++++++++++++++++--
>   4 files changed, 41 insertions(+), 4 deletions(-)


> @@ -527,6 +531,19 @@ static void mips_loongson3_virt_init(MachineState *machine)
>       create_unimplemented_device("mmio fallback 0", 0x10000000, 256 * MiB);
>       create_unimplemented_device("mmio fallback 1", 0x30000000, 256 * MiB);
>   
> +    memory_region_init(iocsr, OBJECT(machine), "loongson3.iocsr", UINT32_MAX);
> +
> +    /* IPI controller is in kernel for KVM */
> +    if (!kvm_enabled()) {

Generically one could come with another hypervisor support, so better
to check for what you are expecting. You could see some uses of:

   if (tcg) ... else if (kvm) ... else abort().

> +        ipi = qdev_new(TYPE_LOONGSON_IPI);
> +        qdev_prop_set_uint32(ipi, "num-cpu", machine->smp.cpus);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
> +        memory_region_add_subregion(iocsr, SMP_IPI_MAILBOX,
> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
> +        memory_region_add_subregion(iocsr, MAIL_SEND_ADDR,
> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
> +    }
> +
>       liointc = qdev_new("loongson.liointc");
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
>   
> @@ -543,6 +560,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
>       clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
>   
>       for (i = 0; i < machine->smp.cpus; i++) {
> +        int node = i / LOONGSON3_CORE_PER_NODE;
> +        int core = i % LOONGSON3_CORE_PER_NODE;
>           int ip;
>   
>           /* init CPUs */
> @@ -553,12 +572,28 @@ static void mips_loongson3_virt_init(MachineState *machine)
>           cpu_mips_clock_init(cpu);
>           qemu_register_reset(main_cpu_reset, cpu);
>   
> -        if (i >= 4) {
> +        if (ipi) {
> +            hwaddr base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
> +            base += core * 0x100;
> +            qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);
> +            sysbus_mmio_map(SYS_BUS_DEVICE(ipi), i + 2, base);
> +        }
> +
> +        if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
> +            MemoryRegion *core_iocsr = g_new(MemoryRegion, 1);
> +            g_autofree char *name = g_strdup_printf("loongson3.core%d_iocsr", i);
> +            memory_region_init_alias(core_iocsr, OBJECT(cpu), name,
> +                                     iocsr, 0, UINT32_MAX);
> +            memory_region_add_subregion(&MIPS_CPU(cpu)->env.iocsr.mr,
> +                                        0, core_iocsr);
> +        }
> +
> +        if (node > 0) {
>               continue; /* Only node-0 can be connected to LIOINTC */
>           }

Pre-existing, but the logic appears clearer as:

           if (node == 0) {
>   
>           for (ip = 0; ip < 4 ; ip++) {
> -            int pin = i * 4 + ip;
> +            int pin = core * LOONGSON3_CORE_PER_NODE + ip;
>               sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
>                                  pin, cpu->env.irq[ip + 2]);
>           }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


