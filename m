Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73F6C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thXc0-0003Es-Ii; Mon, 10 Feb 2025 12:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thXbt-0003DA-BZ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:30:19 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thXbq-0000wh-EZ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:30:16 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e5b1c7c31b2so3785578276.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 09:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739208612; x=1739813412; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yTV1gtQJXCuzOvmeOVZcdZCtxDRMxcVNHFSRUds9zDE=;
 b=k8F/ryNhgbTYFnr1KLG4TtRKgMd/kEFcozsJhxWfKr2hE+J4asZcwrbcdL9Zl5OSzS
 h/AuvE82qRKISdfRU9MZnpEp+rYR8V7PzK0Cct3M/ShsrrHSGNxr7AbshGPE28HHb3Sv
 hrSEMxsKiyqNrZvbfMYINrfIzzk2AWrBvZQKS4Km/g7QniVxOqWKz4KZyz/AYrfYgguk
 w1p7JkC+r6zlMl85UsoOu4uKFhfRH7wOJ2LaCMqcZUwoI/kB7V9KQZq/ACLk0gQ40Jm5
 mApaxXQ+FLgQ7GO2mDKJeZ6c3k/VQ7V+Sm6vRAmvPUaGasUagL7hIwcQKsuCNSqJfhIX
 Y5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739208612; x=1739813412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yTV1gtQJXCuzOvmeOVZcdZCtxDRMxcVNHFSRUds9zDE=;
 b=bBcX8q9ALcR0zNYqT6iZ5+JvvyN9QEvkbYERBhgYT1BSydT26eEfENRebo7NidedrB
 9wsOM0ye3GL8jzD9UQfPQSlctifjWDcDVAP5vSLq9AJGS5MwOwvAqdGoJKhJkvR64QHb
 nXcm1p8ZUshF46Q6fUeZb85xVLmA+aM7+P9HTrcTu6QkU4t8rKTT2Ld2228ibcihkGlb
 2sZUrh3UC3eZftZxDWyFLXNdIZdgU4yfXIEQybq8VJeNSTw/51dnodW0ZCa30z75a1YH
 C+2XQqZeXyEuKvwZj7B51Ecs311yi1hjyHVsyN3EmOyzqkoZnYTCRU329PAB5SEv0M/B
 cWdg==
X-Gm-Message-State: AOJu0YwqvoB2zmBfs38ivHnCwMrNjYWi/IbaVG5IZACqeI6u8U28ySjB
 Dm4UodtBIst1a6iz5EFzbF0agTitmySHB3B+7LchsKxLcciGViuFDGCKCSEsIozt57nkDs/owJ7
 c3LC/7Pz6nYCXd4YJmfZRm+cv38FkOr8c3AaW4RGRPYlaZiRS
X-Gm-Gg: ASbGnctBeq8ypmwf5p3N7TDoSHdtR7dOzqabcPkdwXioyJGHtyyYg6RQB9UR6JCA9jW
 g4B7Sh7ItVpgOtERSimJeSQugSsFXJQaVuAxW+zBWcrwOYqkfzXftJ0dY7s/nwjWxeT85Cpw2mQ
 ==
X-Google-Smtp-Source: AGHT+IHJHPbn8KZftKYlZ7aRFknwEEkhXvvBzY2iGGQxqwLZkWq7tFSGUVmuVHyhbIxmB3O0Dn9+hK9L16ruir9M2zw=
X-Received: by 2002:a05:6902:845:b0:e58:fd2:2cdb with SMTP id
 3f1490d57ef6-e5d944aff0cmr265481276.7.1739208612298; Mon, 10 Feb 2025
 09:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-5-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-5-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 17:30:01 +0000
X-Gm-Features: AWEUYZkt0TzgjFWoDy3en0nSKcIPMvozQJq51tp_ZYDlFAfd_M4Ws65rhLZ3Kbg
Message-ID: <CAFEAcA8qgEDAnfaQDmpUjy77KZBiqwdKSmyLE-ZwEAhMNLWn4Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] hw/arm: Add i.MX 8M Plus EVK board
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
>
> As a first step, implement the bare minimum: CPUs, RAM, interrupt controller,
> serial. All other devices of the A53 memory map are represented as
> TYPE_UNIMPLEMENTED_DEVICE, i.e. the whole memory map is provided. This allows
> for running Linux without it crashing due to invalid memory accesses.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---



> --- /dev/null
> +++ b/docs/system/arm/imx8mp-evk.rst
> @@ -0,0 +1,56 @@
> +NXP i.MX 8M Plus Evaluation Kit (``imx8mp-evk``)
> +================================================
> +
> +The QEMU i.MX 8M Plus EVK board emulation is intended to emulate a plain i.MX 8M
> +Plus system on chip (SoC). All peripherals the real board has such as flash and
> +I2C devices are intended to be added via configuration, e.g. command line.

Why do this? If they're on the real hardware board, we should
be creating them by default in the machine model in QEMU.
Command line options are for devices that are optional and
pluggable by the user on the hardware.

> +Supported devices
> +-----------------
> +
> +The ``imx8mp-evk`` machine implements the following devices:
> +
> + * Up to 4 Cortex-A53 Cores

"cores"

> + * Generic Interrupt Controller (GICv3)
> + * 4 UARTs
> +
> +Boot options
> +------------
> +
> +The ``imx8mp-evk`` machine can start using the standard -kernel functionality
> +for loading a Linux kernel.
> +
> +Direct Linux Kernel Boot
> +''''''''''''''''''''''''
> +
> +Probably the easiest way to get started with a whole Linux system on the machine
> +is to generate an image with Buildroot. Version 2024.11.1 is tested at the time
> +of writing and involves two steps. First run the following commands in the
> +toplevel directory of the Buildroot source tree:
> +
> +.. code-block:: bash
> +
> +  $ echo "BR2_TARGET_ROOTFS_CPIO=y" >> configs/freescale_imx8mpevk_defconfig
> +  $ make freescale_imx8mpevk_defconfig
> +  $ make
> +
> +Once finished successfully there is an ``output/image`` subfolder. Navigate into
> +it patch the device tree needs to be patched with the following commands which
> +will remove the ``cpu-idle-states`` properties from CPU nodes:

This sentence seems to be confused in the middle -- cut-and-paste
error ?

> +
> +.. code-block:: bash
> +
> +  $ dtc imx8mp-evk.dtb | sed '/cpu-idle-states/d' > imx8mp-evk-patched.dts
> +  $ dtc imx8mp-evk-patched.dts -o imx8mp-evk-patched.dtb
> +
> +Now that everything is prepared the newly built image can be run in the QEMU
> +``imx8mp-evk`` machine:

> +#define NAME_SIZE 20
> +
> +static void fsl_imx8mp_init(Object *obj)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    FslImx8mpState *s = FSL_IMX8MP(obj);
> +    char name[NAME_SIZE];

Better than fixed sized char arrays for object names
is to use
   g_autofree char *name = g_strdup_printf("cpu%d", i);
inside the block of each for() loop etc.

> +    int i;
> +
> +    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX8MP_NUM_CPUS); i++) {
> +        snprintf(name, NAME_SIZE, "cpu%d", i);
> +        object_initialize_child(obj, name, &s->cpu[i],
> +                                ARM_CPU_TYPE_NAME("cortex-a53"));
> +    }
> +
> +    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
> +
> +    for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
> +        snprintf(name, NAME_SIZE, "uart%d", i + 1);
> +        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
> +    }
> +}
> +
> +static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    FslImx8mpState *s = FSL_IMX8MP(dev);
> +    DeviceState *gicdev = DEVICE(&s->gic);
> +    int i;
> +
> +    if (ms->smp.cpus > FSL_IMX8MP_NUM_CPUS) {
> +        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
> +                   TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_CPUS, ms->smp.cpus);
> +        return;
> +    }
> +
> +    /* CPUs */
> +    for (i = 0; i < ms->smp.cpus; i++) {
> +        /* On uniprocessor, the CBAR is set to 0 */
> +        if (ms->smp.cpus > 1) {
> +            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
> +                                    fsl_imx8mp_memmap[FSL_IMX8MP_GIC_DIST].addr,
> +                                    &error_abort);
> +        }
> +
> +        /*
> +         * Magic value from Linux output: "arch_timer: cp15 timer(s) running at
> +         * 8.00MHz (phys)".
> +         */
> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
> +                                &error_abort);

This is the CNTFRQ value in Hz. The datasheet actually tells you
this, so we don't need to call it a magic number (section 4.11.4.1.6.4
of the i.MX 8M Plus Applications Processor Reference Manual says the
base frequency of the system counter is 8MHz).

(Incidentally the memory mapped system counter is a stock Arm
IP block and I have about 60% of a model of it, I just haven't
needed to upstream it yet because in practice no guest software
really tries to mess with it. If we turn out to need it for
this SoC that would be a reason for me to clean it up and
send it out. But I suspect we don't need it in practice.)

thanks
-- PMM

