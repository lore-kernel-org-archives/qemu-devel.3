Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8215FC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1TIl-0007ac-AP; Tue, 01 Sep 2026 14:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1TIe-0007Zm-IL
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:33:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1TIb-0004UD-RD
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:33:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so972085e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788287612; x=1788892412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=35xf/sIa/hrvrY+qidHEOtzly7kq8UMhfSgaV7hJ40s=;
 b=BTtH7n09O1pHcJLebmtyDFHb+KKGZAgHzpdOPtswnIHPlK2hjpb9iP/WwwYM13CdTX
 R6CsF0PEEKRdkUkV/IuX81v1yy39k/brvwE82rfNXC/OJsaTHKC3uK3O6EsyOIhneJbn
 cyMxiMU0lNfOjBhTz4sgjWJpt49L+LisMauNgmNOAvzZ1luYkb6z26rADM2qxdhB0c7a
 g7VwvYEfrQOysHi0BVR3sqitiusMMFFU7XudkOSOWwhARLeB0Mtj1znrGdw/5kVLq0Rn
 hDFJTeHUmciUzNLTPOXgbELREI4wLNb3hk4ih+Upt4n2jQJ7eqgY7z6IfSkyxKHyA8F0
 uGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788287612; x=1788892412;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=35xf/sIa/hrvrY+qidHEOtzly7kq8UMhfSgaV7hJ40s=;
 b=TFZ4VZA3OayR+KNF3wF3GCFs63eTPYownPKbAiV9NU3FnuI5CvcxzH6PQqzmbG4TrR
 i61KmrTGnqI7WFtuKFzbBisRz8pKtYLFhap0OZ0UEpXJu0rvBi/iXcgHqWddIrFgznx3
 Upw10YC3UoCJGIFlA8VUh7idMzUsbv6zZt4yi7MstxV/1FGa/cifSY3oeGd6JlMZSsv+
 zSHLwkkJoQ0D334+fOwWK9BVgJ08mGXWTPLf9/DTLErbXzuAndLcA5LaftDaGQsyghJm
 +l2/3+Io4DsCDdG2fN9KVu7EDRRg35jpjBef0eTYMliyEhL5/3rIJpGrjSdLhf1ogv72
 s+Mw==
X-Gm-Message-State: AFuF++mYSLuBoqz8rLdBY08R02iuIg0VJfa/uT8B6PkWWZtnKu7Eq4Pp
 H/FqPzaMd5Dg1tBmr1etQeKt4cu54SjivsIIo+di5+ioXEdezRH4voeSbJtG7mRaZzo=
X-Gm-Gg: AR+sD10hskYLMvFcL93O/6e+zFdg/p85M12xCOs7VL9hkAY3UGIcW+dZH2JMnEx6XPg
 xTjXjrLPB05cHj2f8WVWeRd68F5TX9qhOt7/Zu69D59MzVTh5SQ9jn14oaaM8Yz+xhA3RvZYwOL
 g1kYAREqbF+RFgLLkAvkHfHquQNVvxW/2VDNru97MHYqBFi4jKsr9tLgK8pOcjw7bejYdLJ0oMK
 7wJDv9CdfJXsJAFNbVHC3cmYtPezwJ30NUHWyOXK8/0cUg9JohIDqIrXxfRLYPpre4yoiR4RUDc
 Sn1jTSoeWlJJSu83Hw5AFnL0fKTb5K3hA+B3gszkLGVwV6HcGMk84q1ABin3eBMWMogENVxQMJT
 XbDwYC6VsNgRVkxHb/JEgjLWO2WKrgHdKHEiV4o7qzgSGYWQqKVnAAc1SsiP7fresiJQRyeGsz+
 +XXu6UxH2C+u1XxizD8M+oCLCDuAt6Ith3JCk5PXLg7TytiI9GMKofx5nKpxNj
X-Received: by 2002:a05:600c:4e01:b0:49c:cedc:768a with SMTP id
 5b1f17b1804b1-49ccedc76a1mr527318155e9.16.1788287611853; 
 Tue, 01 Sep 2026 11:33:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdcdd9206sm85809315e9.0.2026.09.01.11.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 11:33:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E07245F829;
 Tue, 01 Sep 2026 19:33:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH RFC v2 04/30] hw/arm: add RP2040 SoC and Raspberry Pi
 Pico machine
In-Reply-To: <20260829234308.33725-5-gilles.grimaud@univ-lille.fr> (Gilles
 Grimaud's message of "Sun, 30 Aug 2026 01:42:38 +0200")
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260829234308.33725-5-gilles.grimaud@univ-lille.fr>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Tue, 01 Sep 2026 19:33:29 +0100
Message-ID: <87ld9ku8hy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Gilles Grimaud <gilles.grimaud@univ-lille.fr> writes:

> From: gilles grimaud <gilles.grimaud@univ-lille.fr>
>
> Continue the Raspberry Pi Pico machine model introduced by Alex Benn=C3=
=A9e's 2022 RFC on current QEMU APIs. Add the RP2040 QOM skeleton, internal=
 ROM and SRAM map, the board XIP window, two PL011-backed UARTs, and explic=
it unimplemented-device placeholders for the remaining MMIO blocks.\n\nKeep=
 the model single-core for now. Core 1 startup and the SIO launch protocol =
are introduced later with the multicore support.
>
> Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
> ---
>  MAINTAINERS                             |   1 +
>  configs/devices/arm-softmmu/default.mak |   1 +
>  hw/arm/Kconfig                          |  13 ++
>  hw/arm/meson.build                      |   2 +
>  hw/arm/raspi_pico.c                     |  85 +++++++++
>  hw/arm/rp2040.c                         | 242 ++++++++++++++++++++++++
>  include/hw/arm/rp2040.h                 |  46 +++++
>  7 files changed, 390 insertions(+)
>  create mode 100644 hw/arm/raspi_pico.c
>  create mode 100644 hw/arm/rp2040.c
>  create mode 100644 include/hw/arm/rp2040.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index db641d9c4c..8fd7385d83 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1041,6 +1041,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/rp2040*
>  F: include/hw/*/rp2040*
> +F: hw/arm/raspi_pico.c
>=20=20
>  Real View
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/ar=
m-softmmu/default.mak
> index 71cf164511..e7f815dd0d 100644
> --- a/configs/devices/arm-softmmu/default.mak
> +++ b/configs/devices/arm-softmmu/default.mak
> @@ -33,6 +33,7 @@
>  # CONFIG_OLIMEX_STM32_H405=3Dn
>  # CONFIG_MPS2=3Dn
>  # CONFIG_RASPI=3Dn
> +CONFIG_RASPI_PICO=3Dy
>  # CONFIG_DIGIC=3Dn
>  # CONFIG_SABRELITE=3Dn
>  # CONFIG_EMCRAFT_SF2=3Dn
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 260d2f0751..d93303ab80 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -368,6 +368,19 @@ config RASPI
>      select BCM2835_SPI
>      select BCM2835_I2C
>=20=20
> +config RASPI_PICO
> +    bool
> +    default y
> +    depends on TCG && ARM
> +    select RP2040
> +
> +config RP2040
> +    bool
> +    select ARM_V7M
> +    select PL011
> +    select RP2040_NYI
> +    select UNIMP
> +
>  config STM32F100_SOC
>      bool
>      select ARM_V7M
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 8ee5307a91..3240ef6637 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -32,6 +32,8 @@ arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files(
>    'raspi.c',
>    'raspi4b.c'
>  ))
> +arm_common_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040.c'))
> +arm_common_ss.add(when: 'CONFIG_RASPI_PICO', if_true: files('raspi_pico.=
c'))
>  arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f10=
0_soc.c'))
>  arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f20=
5_soc.c'))
>  arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f40=
5_soc.c'))
> diff --git a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c
> new file mode 100644
> index 0000000000..2bb7d4e511
> --- /dev/null
> +++ b/hw/arm/raspi_pico.c
> @@ -0,0 +1,85 @@
> +/*
> + * Raspberry Pi Pico machine
> + *
> + * Copyright (c) 2021 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "hw/arm/boot.h"
> +#include "hw/arm/machines-qom.h"
> +#include "hw/arm/rp2040.h"
> +#include "hw/core/boards.h"
> +#include "hw/core/qdev-properties.h"
> +#include "system/address-spaces.h"
> +#include "system/system.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RASPI_PICO_MACHINE MACHINE_TYPE_NAME("raspi-pico")
> +OBJECT_DECLARE_SIMPLE_TYPE(RaspiPicoMachineState, RASPI_PICO_MACHINE)
> +
> +#define PICO_FLASH_SIZE (2 * MiB)
> +
> +struct RaspiPicoMachineState {
> +    MachineState parent_obj;
> +
> +    RP2040State soc;
> +    MemoryRegion flash;
> +};
> +
> +static void raspi_pico_init(MachineState *machine)
> +{
> +    RaspiPicoMachineState *s =3D RASPI_PICO_MACHINE(machine);
> +    MemoryRegion *system_memory =3D get_system_memory();
> +
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RP2040=
);
> +    qdev_prop_set_chr(DEVICE(&s->soc), "serial0", serial_hd(0));
> +    qdev_prop_set_chr(DEVICE(&s->soc), "serial1", serial_hd(1));
> +    if (machine->firmware) {
> +        qdev_prop_set_string(DEVICE(&s->soc), "bootrom-file",
> +                             machine->firmware);
> +    }
> +    object_property_set_link(OBJECT(&s->soc), "memory",
> +                             OBJECT(system_memory), &error_fatal);
> +
> +    memory_region_init_rom(&s->flash, NULL, "raspi-pico.flash",
> +                           PICO_FLASH_SIZE, &error_fatal);
> +    memory_region_add_subregion(system_memory, RP2040_XIP_BASE, &s->flas=
h);
> +
> +    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
> +
> +    armv7m_load_kernel(s->soc.armv7m.cpu, machine->kernel_filename,
> +                       RP2040_XIP_BASE, PICO_FLASH_SIZE);
> +}
> +
> +static void raspi_pico_machine_class_init(ObjectClass *oc, const void *d=
ata)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "Raspberry Pi Pico (Cortex-M0+)";
> +    mc->init =3D raspi_pico_init;
> +    mc->default_cpus =3D 1;
> +    mc->min_cpus =3D 1;
> +    mc->max_cpus =3D 1;

picos are duel core aren't they?

> +    mc->default_ram_size =3D 0;
> +    mc->no_parallel =3D 1;
> +    mc->no_floppy =3D 1;
> +    mc->no_cdrom =3D 1;
> +}
> +
> +static const TypeInfo raspi_pico_machine_info =3D {
> +    .name =3D TYPE_RASPI_PICO_MACHINE,
> +    .parent =3D TYPE_MACHINE,
> +    .instance_size =3D sizeof(RaspiPicoMachineState),
> +    .class_init =3D raspi_pico_machine_class_init,
> +    .interfaces =3D arm_machine_interfaces,
> +};
> +
> +static void raspi_pico_machine_init(void)
> +{
> +    type_register_static(&raspi_pico_machine_info);
> +}
> +type_init(raspi_pico_machine_init)
> diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
> new file mode 100644
> index 0000000000..2196bad18d
> --- /dev/null
> +++ b/hw/arm/rp2040.c
> @@ -0,0 +1,242 @@
> +/*
> + * RP2040 SoC emulation
> + *
> + * Copyright (c) 2021 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "hw/arm/rp2040.h"
> +#include "hw/core/loader.h"
> +#include "hw/core/qdev-clock.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/misc/unimp.h"
> +#include "qemu/datadir.h"
> +#include "target/arm/cpu-qom.h"
> +
> +#define RP2040_SYSCLK_FRQ 125000000
> +
> +#define RP2040_UART0_BASE 0x40034000
> +#define RP2040_UART0_IRQ  20
> +#define RP2040_UART1_BASE 0x40038000
> +#define RP2040_UART1_IRQ  21
> +
> +/*
> + * Temporary boot ROM used until the synthetic ROM is introduced. It loa=
ds
> + * the reset handler from a vector table at the base of the XIP window.
> + */
> +static const uint8_t rp2040_bootrom[] =3D {
> +    0x00, 0x20, 0x04, 0x20, /* initial SP: 0x20042000 */
> +    0x09, 0x00, 0x00, 0x00, /* reset handler: 0x00000009 */
> +    0x03, 0x48,             /* ldr r0, vtor */
> +    0x04, 0x49,             /* ldr r1, xip_base */
> +    0x01, 0x60,             /* str r1, [r0] */
> +    0x04, 0x48,             /* ldr r0, xip_reset_vector */
> +    0x01, 0x68,             /* ldr r1, [r0] */
> +    0x08, 0x47,             /* bx r1 */
> +    0xfe, 0xe7,             /* b . */
> +    0xc0, 0x46,             /* nop */
> +    0x08, 0xed, 0x00, 0xe0, /* VTOR: 0xe000ed08 */
> +    0x00, 0x00, 0x00, 0x10, /* XIP base: 0x10000000 */
> +    0x04, 0x00, 0x00, 0x10, /* XIP reset vector: 0x10000004 */
> +};
> +
> +static const struct {
> +    const char *name;
> +    hwaddr base;
> +    hwaddr size;
> +} rp2040_unimplemented[] =3D {
> +    { "rp2040.sysinfo",  0x40000000, 0x4000 },
> +    { "rp2040.syscfg",   0x40004000, 0x4000 },
> +    { "rp2040.clocks",   0x40008000, 0x4000 },
> +    { "rp2040.resets",   0x4000c000, 0x4000 },
> +    { "rp2040.psm",      0x40010000, 0x4000 },
> +    { "rp2040.iobank0",  0x40014000, 0x4000 },
> +    { "rp2040.ioqspi",   0x40018000, 0x4000 },
> +    { "rp2040.padsbank0", 0x4001c000, 0x4000 },
> +    { "rp2040.padsqspi", 0x40020000, 0x4000 },
> +    { "rp2040.xosc",     0x40024000, 0x4000 },
> +    { "rp2040.pll_sys",  0x40028000, 0x4000 },
> +    { "rp2040.pll_usb",  0x4002c000, 0x4000 },
> +    { "rp2040.busctrl",  0x40030000, 0x4000 },
> +    { "rp2040.uart0_aliases", 0x40035000, 0x3000 },
> +    { "rp2040.uart1_aliases", 0x40039000, 0x3000 },
> +    { "rp2040.spi0",     0x4003c000, 0x4000 },
> +    { "rp2040.spi1",     0x40040000, 0x4000 },
> +    { "rp2040.i2c0",     0x40044000, 0x4000 },
> +    { "rp2040.i2c1",     0x40048000, 0x4000 },
> +    { "rp2040.adc",      0x4004c000, 0x4000 },
> +    { "rp2040.pwm",      0x40050000, 0x4000 },
> +    { "rp2040.timer",    0x40054000, 0x4000 },
> +    { "rp2040.watchdog", 0x40058000, 0x4000 },
> +    { "rp2040.rtc",      0x4005c000, 0x4000 },
> +    { "rp2040.rosc",     0x40060000, 0x4000 },
> +    { "rp2040.vreg_and_chip_reset", 0x40064000, 0x4000 },
> +    { "rp2040.tbman",    0x4006c000, 0x4000 },
> +    { "rp2040.dma",      0x50000000, 0x1000 },
> +    { "rp2040.usbctrl_dpram", 0x50100000, 0x10000 },
> +    { "rp2040.usbctrl_regs",  0x50110000, 0x10000 },
> +    { "rp2040.pio0",     0x50200000, 0x10000 },
> +    { "rp2040.pio1",     0x50300000, 0x10000 },
> +    { "rp2040.sio",      0xd0000000, 0x1000 },
> +};
> +
> +static void rp2040_soc_init(Object *obj)
> +{
> +    RP2040State *s =3D RP2040(obj);
> +    int i;
> +
> +    object_initialize_child(obj, "proc0", &s->armv7m, TYPE_ARMV7M);
> +    qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type",
> +                         ARM_CPU_TYPE_NAME("cortex-m0"));
> +    qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq", RP2040_NUM_IRQS);
> +    qdev_prop_set_uint32(DEVICE(&s->armv7m), "mpu-ns-regions", 8);
> +
> +    for (i =3D 0; i < ARRAY_SIZE(s->uart); i++) {
> +        g_autofree char *name =3D g_strdup_printf("uart%d", i);
> +        g_autofree char *property =3D g_strdup_printf("serial%d", i);
> +
> +        object_initialize_child(obj, name, &s->uart[i], TYPE_PL011);
> +        object_property_add_alias(obj, property, OBJECT(&s->uart[i]),
> +                                  "chardev");
> +    }
> +
> +    s->sysclk =3D clock_new(obj, "sysclk");
> +    clock_set_hz(s->sysclk, RP2040_SYSCLK_FRQ);
> +}
> +
> +static bool rp2040_init_memory(RP2040State *s, Error **errp)
> +{
> +    int i;
> +
> +    if (!memory_region_init_rom(&s->rom, OBJECT(s), "rp2040.rom",
> +                                RP2040_ROM_SIZE, errp)) {
> +        return false;
> +    }
> +    memory_region_add_subregion(s->board_memory, RP2040_ROM_BASE, &s->ro=
m);
> +
> +    for (i =3D 0; i < 4; i++) {
> +        g_autofree char *name =3D g_strdup_printf("rp2040.sram%d", i);
> +
> +        if (!memory_region_init_ram(&s->sram[i], OBJECT(s), name,
> +                                    RP2040_SRAM_BANK_SIZE, errp)) {
> +            return false;
> +        }
> +        memory_region_add_subregion(s->board_memory,
> +                                    RP2040_SRAM_BASE +
> +                                    i * RP2040_SRAM_BANK_SIZE,
> +                                    &s->sram[i]);
> +    }
> +
> +    if (!memory_region_init_ram(&s->sram[4], OBJECT(s), "rp2040.sram4",
> +                                RP2040_SRAM_HI_SIZE, errp)) {
> +        return false;
> +    }
> +    memory_region_add_subregion(s->board_memory, RP2040_SRAM4_BASE,
> +                                &s->sram[4]);
> +
> +    if (!memory_region_init_ram(&s->sram[5], OBJECT(s), "rp2040.sram5",
> +                                RP2040_SRAM_HI_SIZE, errp)) {
> +        return false;
> +    }
> +    memory_region_add_subregion(s->board_memory, RP2040_SRAM5_BASE,
> +                                &s->sram[5]);

I think you need multiple addresses spaces for the last two as they are
banked per-CPU right?

> +
> +    return true;
> +}
> +
> +static bool rp2040_load_bootrom(RP2040State *s, Error **errp)
> +{
> +    g_autofree char *filename =3D NULL;
> +
> +    if (!s->bootrom_file) {
> +        rom_add_blob_fixed("rp2040.bootrom", rp2040_bootrom,
> +                           sizeof(rp2040_bootrom), RP2040_ROM_BASE);
> +        return true;
> +    }
> +
> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, s->bootrom_file);
> +    if (!filename) {
> +        error_setg(errp, "could not find RP2040 boot ROM image '%s'",
> +                   s->bootrom_file);
> +        return false;
> +    }
> +
> +    return load_image_targphys(filename, RP2040_ROM_BASE,
> +                               RP2040_ROM_SIZE, errp) >=3D 0;
> +}
> +
> +static void rp2040_soc_realize(DeviceState *dev, Error **errp)
> +{
> +    RP2040State *s =3D RP2040(dev);
> +    static const hwaddr uart_base[] =3D { RP2040_UART0_BASE, RP2040_UART=
1_BASE };
> +    static const int uart_irq[] =3D { RP2040_UART0_IRQ, RP2040_UART1_IRQ=
 };
> +    Error *err =3D NULL;
> +    int i;
> +
> +    if (!s->board_memory) {
> +        error_setg(errp, "memory property was not set");
> +        return;
> +    }
> +    if (!rp2040_init_memory(s, errp) || !rp2040_load_bootrom(s, errp)) {
> +        return;
> +    }
> +
> +    for (i =3D 0; i < ARRAY_SIZE(rp2040_unimplemented); i++) {
> +        create_unimplemented_device(rp2040_unimplemented[i].name,
> +                                    rp2040_unimplemented[i].base,
> +                                    rp2040_unimplemented[i].size);
> +    }
> +
> +    qdev_connect_clock_in(DEVICE(&s->armv7m), "cpuclk", s->sysclk);
> +    object_property_set_link(OBJECT(&s->armv7m), "memory",
> +                             OBJECT(s->board_memory), &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
> +        return;
> +    }
> +
> +    for (i =3D 0; i < ARRAY_SIZE(s->uart); i++) {
> +        qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", s->sysclk);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, uart_base[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
> +                           qdev_get_gpio_in(DEVICE(&s->armv7m), uart_irq=
[i]));
> +    }
> +}
> +
> +static const Property rp2040_soc_properties[] =3D {
> +    DEFINE_PROP_LINK("memory", RP2040State, board_memory, TYPE_MEMORY_RE=
GION,
> +                     MemoryRegion *),
> +    DEFINE_PROP_STRING("bootrom-file", RP2040State, bootrom_file),
> +};
> +
> +static void rp2040_soc_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D rp2040_soc_realize;
> +    device_class_set_props(dc, rp2040_soc_properties);
> +}
> +
> +static const TypeInfo rp2040_soc_info =3D {
> +    .name =3D TYPE_RP2040,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(RP2040State),
> +    .instance_init =3D rp2040_soc_init,
> +    .class_init =3D rp2040_soc_class_init,
> +};
> +
> +static void rp2040_soc_types(void)
> +{
> +    type_register_static(&rp2040_soc_info);
> +}
> +type_init(rp2040_soc_types)
> diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
> new file mode 100644
> index 0000000000..4e5cd06add
> --- /dev/null
> +++ b/include/hw/arm/rp2040.h
> @@ -0,0 +1,46 @@
> +/*
> + * RP2040 SoC emulation
> + *
> + * Copyright (c) 2021 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_ARM_RP2040_H
> +#define HW_ARM_RP2040_H
> +
> +#include "hw/arm/armv7m.h"
> +#include "hw/char/pl011.h"
> +#include "hw/core/clock.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RP2040 "rp2040"
> +OBJECT_DECLARE_SIMPLE_TYPE(RP2040State, RP2040)
> +
> +#define RP2040_ROM_BASE       0x00000000
> +#define RP2040_ROM_SIZE       (16 * KiB)
> +#define RP2040_XIP_BASE       0x10000000
> +#define RP2040_SRAM_BASE      0x20000000
> +#define RP2040_SRAM_BANK_SIZE (64 * KiB)
> +#define RP2040_SRAM4_BASE     0x20040000
> +#define RP2040_SRAM5_BASE     0x20041000
> +#define RP2040_SRAM_HI_SIZE   (4 * KiB)
> +
> +#define RP2040_NUM_IRQS       32
> +
> +struct RP2040State {
> +    SysBusDevice parent_obj;
> +
> +    ARMv7MState armv7m;
> +    PL011State uart[2];
> +
> +    MemoryRegion *board_memory;
> +    MemoryRegion rom;
> +    MemoryRegion sram[6];
> +    char *bootrom_file;
> +
> +    Clock *sysclk;
> +};
> +
> +#endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

