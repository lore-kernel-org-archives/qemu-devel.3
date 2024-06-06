Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0254EC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBk9-0001AN-BK; Thu, 06 Jun 2024 07:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFBk3-00019E-FM
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:57:15 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFBk0-00028w-Oc
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:57:14 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57a31d63b6bso1127382a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717675031; x=1718279831; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xqdoq/APR3bDO52VhiKSuVhnfFgHAXsLRW+In6BGibA=;
 b=bktwR+suN99VMxiDZ+Hjp07YfEM9j4o8/JVf4xNzN58XEidQGBreb/svdrr1TaaEZN
 Denav5w3Tg6QsXBpGrTr65j6owpFDv3ezne+LssZxFmCrWjEX66S5gY7cclkBVDagB0O
 PIWDhaX9s1xPhCu2yeLEznjrNPhf62iw8tZ4c2xXRAfq1q4NYFiLEYC2h9zBGasGQGWR
 HGj2FSlbovnAIt9WgTFoIeFOmzEQRnSCPVJU5X2ZaeYY0YCoWkb29fC0DyD9FFcZwxty
 Lbcr7cIAmfcM4PNpVWBhEN2P2i5btt7g9Xp5V3mFWq+DaZLzTi38WSckEjmZgGAcWB3x
 3iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717675031; x=1718279831;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xqdoq/APR3bDO52VhiKSuVhnfFgHAXsLRW+In6BGibA=;
 b=J32Mv3QZaGh5s99D9Nk19sF6CPt3CbC7mva05Cs4JsB8ycIlDeazHimZewYs8AvSHZ
 TjoqZhdAPwGZlW5G67ALySsdBkhKVa7qItNUiP193T4lTvs8O7pRsmYmWboKE6OnlD8O
 TGy2JDYukE/4oRnFTSiCHroqqwILe4xMPwdJ9mr6LbIasJylyQ/qZNIoFzBjYj0UAAok
 O5sfV4Bpv7mSLu8MhJNMSYTz41D6n23jD825d6jFeWLbN31fVu30pNsw73exDw74iozZ
 uUr3uIy3BQPDhy4UnkP0JqPOcuZGWRutop4jO4cjsplCEyjpIYZadTHbIeNavGSLuXUf
 XNCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFdi2PMFegBGx9XGeQwnd34ix1ReXmi1CzbvBD5CZXooIXPgkjDzvm3Df5wD/e+jk6h9mYdUifxO6jriU3xE3a2A2+h6w=
X-Gm-Message-State: AOJu0YwxRBA7IIMGX7ZCB94t6axx5SemY2ARrbCBDR2rga4a2vDlz4Kl
 tWR5uOaUWi0jAVeIPcWw4JEj6jZW9omKwteLuLK8ZDKAYr8El2XF1Yy8AVRtBDAoUYxEDlnJ8QA
 KgvBKIgpTidf8pah2cBp35aDm6NA3CLvIKQ3SlQ==
X-Google-Smtp-Source: AGHT+IGTK8rMrUaJzt9NExE7iSMlWbFGP+uJ680Fe4S0dycYqHY2xF8qfMiU/9pvW5MhEtlH6EbhebHwuaUf4IJTP0Y=
X-Received: by 2002:a50:875c:0:b0:57a:4af6:319e with SMTP id
 4fb4d7f45d1cf-57a8b69d02amr3589351a12.1.1717675030743; Thu, 06 Jun 2024
 04:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240606104745.291330-1-zhenyzha@redhat.com>
In-Reply-To: <20240606104745.291330-1-zhenyzha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jun 2024 12:56:59 +0100
Message-ID: <CAFEAcA_ovHZWFi8Xn1YdPNkFjNWQ+BGQTA0Oc9oXTNuPD+bmmA@mail.gmail.com>
Subject: Re: [PATCH RFC] hw/arm/virt: Avoid unexpected warning from Linux
 guest on host with Fujitsu CPUs
To: Zhenyu Zhang <zhenyzha@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, gshan@redhat.com, 
 eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com, ddutile@redhat.com, 
 shahuang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 6 Jun 2024 at 11:48, Zhenyu Zhang <zhenyzha@redhat.com> wrote:
>
> Multiple warning messages and corresponding backtraces are observed when Linux
> guest is booted on the host with Fujitsu CPUs. One of them is shown as below.
>
> [    0.032443] ------------[ cut here ]------------
> [    0.032446] uart-pl011 9000000.pl011: ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (128 < 256)
> [    0.032454] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/dma-mapping.c:54 arch_setup_dma_ops+0xbc/0xcc
> [    0.032470] Modules linked in:
> [    0.032475] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-452.el9.aarch64 #1
> [    0.032481] Hardware name: linux,dummy-virt (DT)
> [    0.032484] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.032490] pc : arch_setup_dma_ops+0xbc/0xcc
> [    0.032496] lr : arch_setup_dma_ops+0xbc/0xcc
> [    0.032501] sp : ffff80008003b860
> [    0.032503] x29: ffff80008003b860 x28: 0000000000000000 x27: ffffaae4b949049c
> [    0.032510] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> [    0.032517] x23: 0000000000000100 x22: 0000000000000000 x21: 0000000000000000
> [    0.032523] x20: 0000000100000000 x19: ffff2f06c02ea400 x18: ffffffffffffffff
> [    0.032529] x17: 00000000208a5f76 x16: 000000006589dbcb x15: ffffaae4ba071c89
> [    0.032535] x14: 0000000000000000 x13: ffffaae4ba071c84 x12: 455f525443206e61
> [    0.032541] x11: 68742072656c6c61 x10: 0000000000000029 x9 : ffffaae4b7d21da4
> [    0.032547] x8 : 0000000000000029 x7 : 4c414e494d5f414d x6 : 0000000000000029
> [    0.032553] x5 : 000000000000000f x4 : ffffaae4b9617a00 x3 : 0000000000000001
> [    0.032558] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff2f06c029be40
> [    0.032564] Call trace:
> [    0.032566]  arch_setup_dma_ops+0xbc/0xcc
> [    0.032572]  of_dma_configure_id+0x138/0x300
> [    0.032591]  amba_dma_configure+0x34/0xc0
> [    0.032600]  really_probe+0x78/0x3dc
> [    0.032614]  __driver_probe_device+0x108/0x160
> [    0.032619]  driver_probe_device+0x44/0x114
> [    0.032624]  __device_attach_driver+0xb8/0x14c
> [    0.032629]  bus_for_each_drv+0x88/0xe4
> [    0.032634]  __device_attach+0xb0/0x1e0
> [    0.032638]  device_initial_probe+0x18/0x20
> [    0.032643]  bus_probe_device+0xa8/0xb0
> [    0.032648]  device_add+0x4b4/0x6c0
> [    0.032652]  amba_device_try_add.part.0+0x48/0x360
> [    0.032657]  amba_device_add+0x104/0x144
> [    0.032662]  of_amba_device_create.isra.0+0x100/0x1c4
> [    0.032666]  of_platform_bus_create+0x294/0x35c
> [    0.032669]  of_platform_populate+0x5c/0x150
> [    0.032672]  of_platform_default_populate_init+0xd0/0xec
> [    0.032697]  do_one_initcall+0x4c/0x2e0
> [    0.032701]  do_initcalls+0x100/0x13c
> [    0.032707]  kernel_init_freeable+0x1c8/0x21c
> [    0.032712]  kernel_init+0x28/0x140
> [    0.032731]  ret_from_fork+0x10/0x20
> [    0.032735] ---[ end trace 0000000000000000 ]---
>
> In Linux, a check is applied to every device which is exposed through device-tree
> node. The warning message is raised when the device isn't DMA coherent and the
> cache line size is larger than ARCH_DMA_MINALIGN (128 bytes). The cache line is
> sorted from CTR_EL0[CWG], which corresponds to 256 bytes on the guest CPUs.
> The DMA coherent capability is claimed through 'dma-coherent' in their
> device-tree nodes.

For QEMU emulated all our DMA is always coherent, so where we
have DMA-capable devices we should definitely tell the kernel
that that DMA is coherent.

Our pl011 does not do DMA, though (we do not set the dmas property), so
it's kind of bogus for the kernel to complain about that.

So I think we should take these changes where they refer to DMA
capable devices and ask the kernel folks to fix the warnings
where they refer to devices that aren't doing DMA. Looking through
the patch, though, my initial impression is that all these are
in the latter category...

> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index d480a7da02..cdf99966e6 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -509,6 +509,7 @@ static void fdt_add_psci_node(void *fdt)
>      qemu_fdt_setprop_cell(fdt, "/psci", "cpu_off", cpu_off_fn);
>      qemu_fdt_setprop_cell(fdt, "/psci", "cpu_on", cpu_on_fn);
>      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
> +    qemu_fdt_setprop(fdt, "/psci", "dma-coherent", NULL, 0);

The PSCI node is describing the firmware interface for
HVC or SMC calls -- I don't think it makes any sense
to think of this as doing DMA. So I would query the kernel
folks about this warning.

>  }
>
>  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3c93c0c0a6..d3e5f512e2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -652,6 +652,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
>          qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
>                                 GIC_FDT_IRQ_TYPE_PPI,
>                                 INTID_TO_PPI(VIRTUAL_PMU_IRQ), irqflags);
> +        qemu_fdt_setprop(ms->fdt, "/pmu", "dma-coherent", NULL, 0);

What DMA interface does the PMU have?

>      }
>  }
>
> @@ -936,6 +937,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
>                                 vms->clock_phandle, vms->clock_phandle);
>      qemu_fdt_setprop(ms->fdt, nodename, "clock-names",
>                           clocknames, sizeof(clocknames));
> +    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);

As above, our PL011 doesn't do any DMA and we do not advertise
to the kernel that it does.

>      if (uart == VIRT_UART) {
>          qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
> @@ -972,6 +974,7 @@ static void create_rtc(const VirtMachineState *vms)
>                             GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>      qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
>      qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
> +    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
>      g_free(nodename);
>  }

What DMA does the pl031 do?

>
> @@ -1077,6 +1080,7 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
>      qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
>      qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
>      qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", phandle);
> +    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);

As far as I know the PL061 is also not a DMA-capable device.

>      if (gpio != VIRT_GPIO) {
>          /* Mark as not usable by the normal world */
> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> index eebcd28f9a..da47071a95 100644
> --- a/hw/core/sysbus-fdt.c
> +++ b/hw/core/sysbus-fdt.c
> @@ -554,6 +554,7 @@ void platform_bus_add_all_fdt_nodes(void *fdt, const char *intc, hwaddr addr,
>      qemu_fdt_setprop_cells(fdt, node, "ranges", 0, addr >> 32, addr, bus_size);
>
>      qemu_fdt_setprop_phandle(fdt, node, "interrupt-parent", intc);
> +    qemu_fdt_setprop(fdt, node, "dma-coherent", NULL, 0);

Isn't this the fdt node for a bus, not a device?

thanks
-- PMM

