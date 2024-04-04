Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11D9CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsONR-0005Vp-JB; Thu, 04 Apr 2024 10:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsONQ-0005VV-Du
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:47:40 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsONO-0002HR-FV
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:47:40 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56829f41f81so1540762a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712242057; x=1712846857; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rGYwOgcAUPynPg2lojlXUG7dNbcVuKkdrfVA3emSyFg=;
 b=JD4/KUpZCmmRHLzuUBTupmFdMJVT743N0YIeCp4qhjcjla2ZeHM39TItGh9Jbvgh7C
 7u3VEwyzLocgeAxLmty3az+nu7yQRu+peJFZbmWNALaKASSSOKio5v79TgMTaKAHmb8t
 mD5szZP3PRU9dKfY+SOF63KlvFDB3aKubkF6bECTOub0doEH3CnOwvLVXyU5CfTTxfr5
 uQOYWC0/RmMQvyLgNhxtHBio7CnHT/nWERbO5ZZX/ptN0zRQ4xtJ88iUu6EWM1MlL/PB
 /jEIzMRmdQXKUQHx1qzgyUVpl1CBIBPgNgPNrmAZHUD4y5YlbWN9Ww6L3E7LFAGSKzy/
 Mn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712242057; x=1712846857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rGYwOgcAUPynPg2lojlXUG7dNbcVuKkdrfVA3emSyFg=;
 b=OB/ETTzHzzLNKOHINOP15JETtjJ3iKM4NF5l1+K44hkmm8tGzHoA8DwDHT3TJ14i3a
 d0F5Lcn23kXVKbK9kEnk00V9QmKHK+r9091IM3rN5lEYzljsOHyhEj5SJSkcSlTuTXg9
 AVk3aS99cvViHkMupDpUvjISSQtbDZF1hh9szREZ1h8jXSPfhYQ0R2QK9fqv9Ms670bE
 ugHaTGvc/Hh9EswPwdjDfpZFeNidSS7b77GUt+fwQiIwvH2D682TG4/juBgAUdTczZMP
 f5KMHHmVkdy0Y6nTFNyudvIXB1alqi0RVWoRAuUjPRGR3LXQO/Wesu0d81wDzng3Mjru
 M3yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZKOS2iHj5R1BG0uR3yNUPKPt3hryHQ7OAbg930RrGWAK+F9byiGVAeVRdXAU8TNd+PqlL5wDzGS2kgdIYjMoiIrKWgzE=
X-Gm-Message-State: AOJu0Yx+rL6bwUDDZPZnR4PbSgamp+fOLXPpY2zEb74YF7+5i36HQqNy
 vQPe6SCgEnIb8gHwZZllegKLeZDUk18Y3xejjJaySePivd3B96PA3YKvCW4EcdzGY5UEpyh12ao
 TRqQ49+g7bILNKc99Vg8aTAe1eT1pXoJNgv6BlA==
X-Google-Smtp-Source: AGHT+IFr+3QWgFhn6VxiuH13c/6D9CsxG+QEjJ2sZn/YfD2cnK34vGYsVQa71lDyPmCbMfv5xp2kGgK5nnL1E9LOawg=
X-Received: by 2002:a50:a6d0:0:b0:56b:94e3:856c with SMTP id
 f16-20020a50a6d0000000b0056b94e3856cmr1670037edc.36.1712242056771; Thu, 04
 Apr 2024 07:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-11-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-11-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:47:26 +0100
Message-ID: <CAFEAcA8ESSRQtemj7xefeb8Fp0__EEiJh2FamGy7w7_iTpyf4A@mail.gmail.com>
Subject: Re: [PATCH v12 10/23] hw/arm/virt: Wire NMI and VINMI irq lines from
 GIC to CPU
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Wire the new NMI and VINMI interrupt line from the GIC to each CPU.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v9:
> - Rename ARM_CPU_VNMI to ARM_CPU_VINMI.
> - Update the commit message.
> v4:
> - Add Reviewed-by.
> v3:
> - Also add VNMI wire.
> ---
>  hw/arm/virt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a9a913aead..ef2e6c2c4d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -821,7 +821,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>
>      /* Wire the outputs from each CPU's generic timer and the GICv3
>       * maintenance interrupt signal to the appropriate GIC PPI inputs,
> -     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
> +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ/NMI/VINMI interrupt outputs to the
> +     * CPU's inputs.
>       */
>      for (i = 0; i < smp_cpus; i++) {
>          DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
> @@ -865,6 +866,10 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>                             qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
>          sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
>                             qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> +        sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
> +        sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
>      }

This patch needs to go after patch 11. Otherwise at this point
in the patchseries we are trying to wire up GPIOs on the GIC
which don't exist, and QEMU will assert:

$ ./build/x86/qemu-system-aarch64 -M virt,gic-version=3
Unexpected error in object_property_find_err() at ../../qom/object.c:1366:
qemu-system-aarch64: Property 'arm-gicv3.sysbus-irq[4]' not found
Aborted (core dumped)

We also need to only connect these up if vms->gic_version
is not VIRT_GIC_VERSION_2. This is because these GPIOs don't
exist on the GICv2, and otherwise we again assert if you
try to wire them up but you're using GICv2:

$ ./build/x86/qemu-system-aarch64 -M virt,gic-version=2
Unexpected error in object_property_find_err() at ../../qom/object.c:1366:
qemu-system-aarch64: Property 'arm_gic.sysbus-irq[4]' not found
Aborted (core dumped)

thanks
-- PMM

