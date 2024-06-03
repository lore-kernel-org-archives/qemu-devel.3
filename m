Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC8CC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9tm-0003na-AX; Mon, 03 Jun 2024 11:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9tj-0003m7-7M
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:47:00 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9th-0003Ru-5F
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:46:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35dd0c06577so3273887f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717429615; x=1718034415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vehZwDyfXOECyz+NLuGckWo2fAsupAGi9Nm1cgeCJgY=;
 b=RzM+vfEtttWdYZApIzxdTz2/09mhV64rGI9azZ1mZ1cD99AnyWskoFhSPwHwre8Kin
 i3btXF8d4cCuDy8sQhlf1O/oRVYHDjOlw0WaeNfEqgx3xWGvxrb/UgUKOQtPwdq5hjpG
 nfEsLX+sQBkeh3qNMaITSEX/dWfemPhCygGKbKhMhUrgFRlv1q+rNIBxcB1H1S706k9D
 8N4SP71FOxDYRa441G6pa14nLPKAl0+OabGnLuFExvMGyru22wj1iORIrFsyY5LAVAmJ
 ZEDhGzGXoF/nmlON+GKwi0OPGnFyBcyvN0S4HfYrenqo1MXWFY3mwpsfhOXhDBjR2KfH
 Cqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717429615; x=1718034415;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vehZwDyfXOECyz+NLuGckWo2fAsupAGi9Nm1cgeCJgY=;
 b=H2aAZYA1FpbK4OuINDIwE39X4mmOWnYriRrC9VqqkzSgHiTUp4HLzns7hHrq72BOwC
 Y0/KF1badMs411Znsg09EYYpLPqu6KgSLpPanCLPLoUhtuCDGd+6Ya7NYIV4/aJ87RTy
 +xrjkk7v/1Bm8bYWljoXDCcNeHGy4ECq3cBYjPGzpfY2Sj+x7u/OlR+k0JOLiHo3IieJ
 wNzGuhVvWtH8k5Gje22lhmODIXxVYD9+ZGjL1jvhj4oAF0VxkRllmF/E6Q+c5RTsG2V9
 jqH37E1qtN/bCrMK5bjtAGyOhq6jak2ejb1OOkJx6oilHbHNJaw2Wb+9I8axaTmg9BY7
 BocQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUVfbXiVu4JRH4O8B7E/TjD0dreEmdtHl3i2QoKYTiXhP9+6y+tSJn9CcOaUye/72+KpkuM7ylRFsZGdGYUr7+m0K4L8s=
X-Gm-Message-State: AOJu0YxOJFW9eEgnEPbkrb/HsTPfT491SIuYMqZR9D9RGRehbBydNz7Y
 LWJohQKD0n+MYeyT0abNrIVlKmlGKGwvWJ4Mu2iew2z0j7aOAZ0aVPd7f/Mr7gA=
X-Google-Smtp-Source: AGHT+IFdFhbIGoSY366jRenf8MShLYqBZSZimsRe61Zbciv0ZI2FNv9CLLH8oNGPwWj9e7HchTlWaQ==
X-Received: by 2002:a05:6000:1754:b0:34d:7f9a:ecbd with SMTP id
 ffacd0b85a97d-35e0f25e11amr5966514f8f.1.1717429614697; 
 Mon, 03 Jun 2024 08:46:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04cad5bsm9132217f8f.38.2024.06.03.08.46.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:46:54 -0700 (PDT)
Message-ID: <f2e61128-003c-48c9-bab4-20422d195145@linaro.org>
Date: Mon, 3 Jun 2024 17:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/mips/loongson3_virt: Wire up loongson_ipi device
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
 <20240508-loongson3-ipi-v1-5-1a7b67704664@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508-loongson3-ipi-v1-5-1a7b67704664@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 8/5/24 15:06, Jiaxun Yang wrote:
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


> @@ -534,12 +553,28 @@ static void mips_loongson3_virt_init(MachineState *machine)
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
> +            memory_region_init_alias(core_iocsr, OBJECT(machine), name,

Region owner should be vCPU (core) IMO, not machine. But maybe need
another approach (see my comment on patch #3), although not sure if
easy with KVM.

> +                                     iocsr, 0, UINT32_MAX);
> +            memory_region_add_subregion(&MIPS_CPU(cpu)->env.iocsr.mr,
> +                                        0, core_iocsr);
> +        }
> +
> +        if (node > 0) {
>               continue; /* Only node-0 can be connected to LIOINTC */
>           }
>   
>           for (ip = 0; ip < 4 ; ip++) {
> -            int pin = i * 4 + ip;
> +            int pin = core * LOONGSON3_CORE_PER_NODE + ip;
>               sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
>                                  pin, cpu->env.irq[ip + 2]);
>           }
> 


