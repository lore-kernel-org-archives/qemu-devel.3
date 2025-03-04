Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485EEC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 15:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpULe-0006UI-JL; Tue, 04 Mar 2025 10:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpULc-0006U5-Iu
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:38:21 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpULa-000400-MW
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:38:20 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so27171615e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 07:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102696; x=1741707496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YwNzzAyQ1o5S0I5x3s/W34ZzWR0a+SoV8r1uuwHnZs0=;
 b=KQ7ugwM9C4uXj2uJFoGzg93GmVC9/fZjbwbsq+cv7yiza+MaAJdN0GMLNAMvWxI1TJ
 mdsCeARmRH4sM/C3MmojWLq3rfsX1KDT/mSdqqoaq0AYUp1/L6Z/lGcFjoclT0I8mdiJ
 1E6FRfHd0Lj6c99QL822P7YlrWuayFqNYlkDpiQgLPGDNmUDlBDNZJ3PKumBjL+zPkoN
 W4YrD4GHYLS+pXFSMeB2WghV5ADHNy6ag6QHfAolzFoJhPVtP4fNKKPSiqA2lSA8X/Un
 tOxKhgsLRc+wlC6IppqXZlYAs9gGaIUa9Gh6X78oEb7BGFK2ep6cnjij4gTEU7TxVjYB
 ooJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102696; x=1741707496;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YwNzzAyQ1o5S0I5x3s/W34ZzWR0a+SoV8r1uuwHnZs0=;
 b=ktJ2WUKSZDIjcv9nmUWGsELHd6xBLqPkTAlyM3ROadi5HFkqJwwIv6FwoGDSQhbuEf
 /587DX0mDWHglmMp5+u1vZLXyEwFEeutl9jBVm51uU6csmqiwcxQEqE47z3lGCzz8j58
 JgqNAPwAICaQMKCwiUAu2v38IeV9oIbd5FTPmMS1KnSqq+tJJMy1rHqm9FLZQKKdYh9g
 AWjy9cdlg5LwQwscLTX0qvU2tmhRRN+Mc986LsvyW5jmgNY+OIAFfc6a7twRPNyGyr2y
 3LcBWZEJJPs+A0ZNdZaYN5sA7jmdx8b+TMKeupdLAf6k4d4BcgZSvEJrs/W880QQi8E7
 LhbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl8vaABZWucakkTuCeqZXgV3qz/+IE449PIg9i+7WAD+E3WQmEKTliLWq2CwSTg9UVRkvjwUl2LKOX@nongnu.org
X-Gm-Message-State: AOJu0Yw9GcN9JKicEKjngirYGYTO4RqsImWb8cOCp+N7+qelBtJ0X5kG
 Pgh9mr5AoFwR6ESD5XAD8H235vC9LzXnoOECd4YQYA07xBVkT0N1/7DtQNK9jeU=
X-Gm-Gg: ASbGncv5P9yFdX4OD/yWezsg40PgBQoh6JHd/tCopy4KBrQtBvPM4Pm7Da3yH03opws
 u+lt/cTwDz04amGFgAh4QFIv4zdMz848oqM7JHcBQUNOaQ9/JdySbiX2Jd93jO/rG3T1YfxSuhn
 58AOjjlPWJ+sTARiJyictKgc8fUGDyyaSk1ok0f15xqbrvw5VKP4arbeiblwjTceQjXLgVQUqKf
 26i919MM4rnrTmwLTbabY5yes75pVzBIHqlG5LhLtQoU8Xw7oA3CHk42y0svS5qXq+kr4HuSM12
 kcOw7NVhoG7y6VK0dthI+X4wwK8f6ZdTtAQ734iJA/SOzhKa+nUEHAIEOuUDs/Zw1SvtOCm+v0H
 UriuZtf5Kb8IS
X-Google-Smtp-Source: AGHT+IEip3JlaMdbbDdVlur6jhGQMD8YJGkxJRjZZCqxOU3aP3ggozYPDkj2PvtC0EwfaEUqZpAvZA==
X-Received: by 2002:a05:600c:4e93:b0:43b:c94d:e1c6 with SMTP id
 5b1f17b1804b1-43bc94de367mr54764285e9.3.1741102696552; 
 Tue, 04 Mar 2025 07:38:16 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391188029e0sm2216492f8f.52.2025.03.04.07.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 07:38:15 -0800 (PST)
Message-ID: <c5f9c1b1-f710-4b84-bddd-6ba6dd14d54e@linaro.org>
Date: Tue, 4 Mar 2025 16:38:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/hexagon: Define hexagon "virt" machine
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-8-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250301172045.1295412-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 1/3/25 18:20, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   configs/devices/hexagon-softmmu/default.mak |   1 +
>   configs/targets/hexagon-softmmu.mak         |   1 +
>   include/hw/hexagon/virt.h                   |  41 ++
>   hw/hexagon/virt.c                           | 395 ++++++++++++++++++++
>   target/hexagon/cpu.c                        |   2 +-
>   hw/hexagon/Kconfig                          |   8 +
>   hw/hexagon/meson.build                      |   2 +
>   7 files changed, 449 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/hexagon/virt.h
>   create mode 100644 hw/hexagon/virt.c


> +static void fdt_add_clocks(const HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    clock_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +    qemu_fdt_add_subnode(ms->fdt, "/apb-pclk");
> +    qemu_fdt_setprop_string(ms->fdt, "/apb-pclk", "compatible", "fixed-clock");
> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "#clock-cells", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "clock-frequency", 24000000);
> +    qemu_fdt_setprop_string(ms->fdt, "/apb-pclk", "clock-output-names",
> +                            "clk24mhz");
> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "phandle", clock_phandle);
> +}
> +
> +static void fdt_add_uart(const HexagonVirtMachineState *vms, int uart)
> +{
> +    char *nodename;
> +    hwaddr base = base_memmap[uart].base;
> +    hwaddr size = base_memmap[uart].size;
> +    assert(uart == 0);
> +    int irq = irqmap[VIRT_UART0 + uart];
> +    const char compat[] = "arm,pl011\0arm,primecell";
> +    const char clocknames[] = "uartclk\0apb_pclk";
> +    MachineState *ms = MACHINE(vms);
> +
> +    pl011_create(base, qdev_get_gpio_in(vms->l2vic, irq), serial_hd(0));

pl011_create() seems an incomplete API since it let the UART with
no clock connected. IIUC here you feed with a 24MHz from APB.

> +
> +    nodename = g_strdup_printf("/pl011@%" PRIx64, base);
> +    qemu_fdt_add_subnode(ms->fdt, nodename);
> +
> +    /* Note that we can't use setprop_string because of the embedded NUL */
> +    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, size);
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", 32 + irq, 0);
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "clocks", clock_phandle,
> +                           clock_phandle);
> +    qemu_fdt_setprop(ms->fdt, nodename, "clock-names", clocknames,
> +                     sizeof(clocknames));
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
> +                          irq_hvm_ic_phandle);
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
> +    qemu_fdt_add_subnode(ms->fdt, "/aliases");
> +    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
> +
> +    g_free(nodename);
> +}


