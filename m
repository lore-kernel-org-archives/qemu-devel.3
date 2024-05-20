Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC7DC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 13:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s93XV-0005ln-A7; Mon, 20 May 2024 09:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s93XT-0005kr-Fh
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:58:55 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s93XO-0000zS-2c
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:58:55 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51f72a29f13so3917292e87.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716213528; x=1716818328; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XUNEEf6o0vIvlGoVCkOBNOApbEzu6uUelzCwIt8oTZw=;
 b=RRxTfyucRxDOJnsc0adxc7pkvSG0SKWyQ0oS0ZITKJn2D0aZzhqE6VNP2mba9dWP18
 +B8m2to+PYgsPWHWnXTA763CdeBLmMhDue6fiB8V5jAnhn5+BWBK/EbJzxgqPqbcWbxo
 dNgaIOPHylEilcFpVrWc93dNKGjeqvLQIXF5M3gcGIzlPIryZiS3Z4CvbAYL0917YMWU
 kwlPuGzFhfqm87AQXiRrm5ECwkxZ4mpZD4Evzb45Y9/0BOT+T2l++coFwyfTNDrH2Dvk
 nnnl995RdSQ9jRe7DCjwlZaeNGuk8nyDG3eFXCLGc73iPVE4CyTJYg04lzXvbBmG+lis
 PDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716213528; x=1716818328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XUNEEf6o0vIvlGoVCkOBNOApbEzu6uUelzCwIt8oTZw=;
 b=CI055FAEwiQBo2VMW1tZ34qIMoqP9bbDgSIkqwvKau6u4gaUAgL7q7itOYLuphqsqb
 5FAoMD2cCKNyulewV0yU9OYB3o2YRdKeKHKsIvsR8wjfH+TEtfzkBLuNYkVZtckoRKmm
 P+92ZyCw5Df2XMQJrKwmXC973UxlPgrdMOhSr6oXmFSxb0ek4szx+SG46SV0/91Tk+lA
 Smr/GRZXVhW2tJdol+jgQyYIDFj3VOP1CnHWZZ9XiIcpr46XPTGaMgE3fUCj+kxbXSks
 9/8eioFfBTzFYzObY0SZuujnFM/bge82d0ihi1WS+4KfneaqsD5aNiEJTebW4Jy61pLW
 lQBg==
X-Gm-Message-State: AOJu0YxaQdGFqoDijKXGeirbbzM2kYZtl5G3i0rXhR4Sk5kZICTzd+Cn
 ScBd8Y8SAT9x+NIVb3FeeAh7bupXkX9vFmmaia7H2HnH3LZ2wT6Fqpc/538VXru7nj1nNHH5NXa
 VyoJ1iFy5KjEWV+WYGpU+kOWJYVrtZ7MLrxeon9ZmUMeAfolw
X-Google-Smtp-Source: AGHT+IFYrPWwRxlbRR5BkspD7WQ1euUprVd+rzz2LeZOw3meysRtxVKfVamxdcUPvYwzL0yZKiKTiBr+Bo5+M0TpRgE=
X-Received: by 2002:a05:6512:15a8:b0:51d:9ea3:5649 with SMTP id
 2adb3069b0e04-5220ff71d30mr24451019e87.10.1716213527923; Mon, 20 May 2024
 06:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240507130349.86851-1-sebastian.huber@embedded-brains.de>
 <20240507130349.86851-3-sebastian.huber@embedded-brains.de>
In-Reply-To: <20240507130349.86851-3-sebastian.huber@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 14:58:36 +0100
Message-ID: <CAFEAcA_KBcL9UsqpOMk7GhWwokdEmC3fKZg_q7tdyt9LM7RFpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/xilinx_zynq: Support up to two CPU cores
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 7 May 2024 at 14:04, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> The Zynq 7000 SoCs contain two Arm Cortex-A9 MPCore (the Zynq 7000S have only
> one core).  Add support for up to two simulated cores.
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> ---
>  hw/arm/xilinx_zynq.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 078abd77bd..3b858e3e9a 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -184,6 +184,8 @@ static void zynq_init(MachineState *machine)
>      SysBusDevice *busdev;
>      qemu_irq pic[64];
>      int n;
> +    unsigned int smp_cpus = machine->smp.cpus;
> +    qemu_irq cpu_irq[2];

We prefer not to have arrays of qemu_irq like this that are
just passing qemu_irqs from one place to another. Instead
at the point where you want the ARM_CPU_IRQ of a particular
CPU, call qdev_get_gpio_in() on the CPU object there.

I suggest dropping the "ARMCPU *cpu" local from this function
and instead adding an "ARMCPU *cpu[ZYNQ_MAX_CPUS]" array to
the ZynqMachineState struct.

>      /* max 2GB ram */
>      if (machine->ram_size > 2 * GiB) {
> @@ -191,21 +193,27 @@ static void zynq_init(MachineState *machine)
>          exit(EXIT_FAILURE);
>      }
>
> -    cpu = ARM_CPU(object_new(machine->cpu_type));
> +    for (n = 0; n < smp_cpus; n++) {
> +        Object *cpuobj = object_new(machine->cpu_type);
>
> -    /* By default A9 CPUs have EL3 enabled.  This board does not
> -     * currently support EL3 so the CPU EL3 property is disabled before
> -     * realization.
> -     */
> -    if (object_property_find(OBJECT(cpu), "has_el3")) {
> -        object_property_set_bool(OBJECT(cpu), "has_el3", false, &error_fatal);
> -    }
> +        /* By default A9 CPUs have EL3 enabled.  This board does not
> +         * currently support EL3 so the CPU EL3 property is disabled before
> +         * realization.
> +         */

If you're moving comment text around checkpatch will suggest that
you fix it up to our current coding standard, which is that
a multiline comment has the "/*" on a line of its own.

> +        if (object_property_find(cpuobj, "has_el3")) {
> +            object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
> +        }
> +
> +        object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
> +                                &error_fatal);
> +        object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
> +                                &error_fatal);
>
> -    object_property_set_int(OBJECT(cpu), "midr", ZYNQ_BOARD_MIDR,
> -                            &error_fatal);
> -    object_property_set_int(OBJECT(cpu), "reset-cbar", MPCORE_PERIPHBASE,
> -                            &error_fatal);
> -    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> +
> +        cpu_irq[n] = qdev_get_gpio_in(DEVICE(cpuobj), ARM_CPU_IRQ);
> +    }
> +    cpu = ARM_CPU(first_cpu);
>
>      /* DDR remapped to address zero.  */
>      memory_region_add_subregion(address_space_mem, 0, machine->ram);
> @@ -238,10 +246,14 @@ static void zynq_init(MachineState *machine)
>      sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
>
>      dev = qdev_new(TYPE_A9MPCORE_PRIV);
> -    qdev_prop_set_uint32(dev, "num-cpu", 1);
> +    qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
>      busdev = SYS_BUS_DEVICE(dev);
>      sysbus_realize_and_unref(busdev, &error_fatal);
>      sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
> +    for (n = 0; n < smp_cpus; n++) {
> +        sysbus_connect_irq(busdev, n, cpu_irq[n]);
> +    }

Looks like you have based this on a version of QEMU which doesn't
have commit 68a5827b80117973 which wires up the FIQ line of the
A9MPCORE_PRIV device to the CPUs.

> +    zynq_binfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
>      sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
>      sysbus_connect_irq(busdev, 0,
>                         qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
> @@ -357,7 +369,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
>      MachineClass *mc = MACHINE_CLASS(oc);
>      mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
>      mc->init = zynq_init;
> -    mc->max_cpus = 1;
> +    mc->max_cpus = 2;
>      mc->no_sdcard = 1;
>      mc->ignore_memory_transaction_failures = true;
>      mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
> --

I'm not making this a condition for accepting this patch, but
since you're working on this board model would you consider
writing up some documentation for it? It's one of the boards
we do not currently have documented at all. This doesn't have to
be very extensive: a few paragraphs describing what the board
type is, maybe linking to a reference to the hardware, listing
what is and isn't implemented, and (if there are some convenient
examples available) perhaps listing some examples of use.
docs/system/arm/xlnx-versal-virt.rst is the docs for the
Xilinx Versal board; the rendered version of that is:
https://www.qemu.org/docs/master/system/arm/xlnx-versal-virt.html
or https://www.qemu.org/docs/master/system/arm/realview.html
is an example of a more minimal board documentation page.

thanks
-- PMM

