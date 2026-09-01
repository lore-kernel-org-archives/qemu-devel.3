Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0240FC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 22:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1X2e-0005YF-B9; Tue, 01 Sep 2026 18:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x1X2c-0005Xx-7f; Tue, 01 Sep 2026 18:33:18 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x1X2X-0007T4-GS; Tue, 01 Sep 2026 18:33:17 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hZLGt5k3kz80sx;
 Wed,  2 Sep 2026 00:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788301990;
 bh=sYuggDsfAEWpe3EAEIZpQwY0CvCv3tWH4fIswEqW7y4=;
 h=From:Subject:Date:In-Reply-To:Cc:To:References:From;
 b=eHFvLgkmRQ+fafRrpHdgzNZB2i5o9AFb2zKgUeWazR178Lo/HLhiIY4VZJvKgXspU
 Xg3V6dX22lLQTrsRmrxcAXIm0TtMEpyJQ6P7ox31SmB9+usYUGnBtcBJLmSZSw73oF
 TXYSEXB4kaUNAWE7IN4b0b1iBC5MVhPy38CJqe2+ej85mPnwkAg9e6YNiIXg6BgcPN
 wejniBiBDTCbZEk2jkWh+WTJpEPnP+XfyH5PQ4z5j6UFrIethx83CZ3rDYRSq2j4k5
 Zpo+7k1nhJem0z1fFAjDw5o3CDhIww5ftfSXZ/pBEK7xvDSgYeLbsc4lnX3VQ++6VX
 tiGG/c6JBp2pw==
Received: from smtpclient.apple (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4hZLGt3ddbz6tpV;
 Wed,  2 Sep 2026 00:33:10 +0200 (CEST)
From: gilles grimaud <gilles.grimaud@univ-lille.fr>
Message-Id: <1B8A4AE6-7333-47E7-A23D-5DC98B09EC33@univ-lille.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_BCB8C376-4555-4453-9DC0-FB0194151B23"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH RFC v2 04/30] hw/arm: add RP2040 SoC and Raspberry Pi Pico
 machine
Date: Wed, 2 Sep 2026 00:33:00 +0200
In-Reply-To: <87ld9ku8hy.fsf@draig.linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260829234308.33725-5-gilles.grimaud@univ-lille.fr>
 <87ld9ku8hy.fsf@draig.linaro.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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


--Apple-Mail=_BCB8C376-4555-4453-9DC0-FB0194151B23
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Alex,

Yes. The v2 patch introduced the machine as single-core and deferred =
core 1
to a later patch. That was the wrong split.

For v3 I will instantiate both Cortex-M0+ cores in the initial SoC =
patch.
Core 1 may remain parked until the later SIO and boot ROM patches =
introduce
its launch protocol, but the machine topology will be dual-core from the
start.

I assume that by the last two regions you mean SIO and PPB. I will give =
each
core a separate memory container and address space. Each ARMv7M instance =
will
therefore retain its own PPB, NVIC, and SysTick mapping. SIO will expose
per-core MMIO views over the shared SIO state, instead of inferring the
accessing core from current_cpu.

Thanks,
--
Gilles Grimaud - 2XS/SISE - CRIStAL/IRCICA - CNRS/Univ. Lille =20



> Le 1 sept. 2026 =C3=A0 20:33, Alex Benn=C3=A9e =
<alex.bennee@linaro.org> a =C3=A9crit :
>=20
> Gilles Grimaud <gilles.grimaud@univ-lille.fr =
<mailto:gilles.grimaud@univ-lille.fr>> writes:
>=20
>> From: gilles grimaud <gilles.grimaud@univ-lille.fr>
>>=20
>> Continue the Raspberry Pi Pico machine model introduced by Alex =
Benn=C3=A9e's 2022 RFC on current QEMU APIs. Add the RP2040 QOM =
skeleton, internal ROM and SRAM map, the board XIP window, two =
PL011-backed UARTs, and explicit unimplemented-device placeholders for =
the remaining MMIO blocks.\n\nKeep the model single-core for now. Core 1 =
startup and the SIO launch protocol are introduced later with the =
multicore support.
>>=20
>> Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
>> ---
>> MAINTAINERS                             |   1 +
>> configs/devices/arm-softmmu/default.mak |   1 +
>> hw/arm/Kconfig                          |  13 ++
>> hw/arm/meson.build                      |   2 +
>> hw/arm/raspi_pico.c                     |  85 +++++++++
>> hw/arm/rp2040.c                         | 242 =
++++++++++++++++++++++++
>> include/hw/arm/rp2040.h                 |  46 +++++
>> 7 files changed, 390 insertions(+)
>> create mode 100644 hw/arm/raspi_pico.c
>> create mode 100644 hw/arm/rp2040.c
>> create mode 100644 include/hw/arm/rp2040.h
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index db641d9c4c..8fd7385d83 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1041,6 +1041,7 @@ L: qemu-arm@nongnu.org
>> S: Maintained
>> F: hw/*/rp2040*
>> F: include/hw/*/rp2040*
>> +F: hw/arm/raspi_pico.c
>>=20
>> Real View
>> M: Peter Maydell <peter.maydell@linaro.org>
>> diff --git a/configs/devices/arm-softmmu/default.mak =
b/configs/devices/arm-softmmu/default.mak
>> index 71cf164511..e7f815dd0d 100644
>> --- a/configs/devices/arm-softmmu/default.mak
>> +++ b/configs/devices/arm-softmmu/default.mak
>> @@ -33,6 +33,7 @@
>> # CONFIG_OLIMEX_STM32_H405=3Dn
>> # CONFIG_MPS2=3Dn
>> # CONFIG_RASPI=3Dn
>> +CONFIG_RASPI_PICO=3Dy
>> # CONFIG_DIGIC=3Dn
>> # CONFIG_SABRELITE=3Dn
>> # CONFIG_EMCRAFT_SF2=3Dn
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 260d2f0751..d93303ab80 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -368,6 +368,19 @@ config RASPI
>>     select BCM2835_SPI
>>     select BCM2835_I2C
>>=20
>> +config RASPI_PICO
>> +    bool
>> +    default y
>> +    depends on TCG && ARM
>> +    select RP2040
>> +
>> +config RP2040
>> +    bool
>> +    select ARM_V7M
>> +    select PL011
>> +    select RP2040_NYI
>> +    select UNIMP
>> +
>> config STM32F100_SOC
>>     bool
>>     select ARM_V7M
>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>> index 8ee5307a91..3240ef6637 100644
>> --- a/hw/arm/meson.build
>> +++ b/hw/arm/meson.build
>> @@ -32,6 +32,8 @@ arm_common_ss.add(when: 'CONFIG_RASPI', if_true: =
files(
>>   'raspi.c',
>>   'raspi4b.c'
>> ))
>> +arm_common_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040.c'))
>> +arm_common_ss.add(when: 'CONFIG_RASPI_PICO', if_true: =
files('raspi_pico.c'))
>> arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: =
files('stm32f100_soc.c'))
>> arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: =
files('stm32f205_soc.c'))
>> arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: =
files('stm32f405_soc.c'))
>> diff --git a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c
>> new file mode 100644
>> index 0000000000..2bb7d4e511
>> --- /dev/null
>> +++ b/hw/arm/raspi_pico.c
>> @@ -0,0 +1,85 @@
>> +/*
>> + * Raspberry Pi Pico machine
>> + *
>> + * Copyright (c) 2021 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/units.h"
>> +#include "qapi/error.h"
>> +#include "hw/arm/boot.h"
>> +#include "hw/arm/machines-qom.h"
>> +#include "hw/arm/rp2040.h"
>> +#include "hw/core/boards.h"
>> +#include "hw/core/qdev-properties.h"
>> +#include "system/address-spaces.h"
>> +#include "system/system.h"
>> +#include "qom/object.h"
>> +
>> +#define TYPE_RASPI_PICO_MACHINE MACHINE_TYPE_NAME("raspi-pico")
>> +OBJECT_DECLARE_SIMPLE_TYPE(RaspiPicoMachineState, =
RASPI_PICO_MACHINE)
>> +
>> +#define PICO_FLASH_SIZE (2 * MiB)
>> +
>> +struct RaspiPicoMachineState {
>> +    MachineState parent_obj;
>> +
>> +    RP2040State soc;
>> +    MemoryRegion flash;
>> +};
>> +
>> +static void raspi_pico_init(MachineState *machine)
>> +{
>> +    RaspiPicoMachineState *s =3D RASPI_PICO_MACHINE(machine);
>> +    MemoryRegion *system_memory =3D get_system_memory();
>> +
>> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, =
TYPE_RP2040);
>> +    qdev_prop_set_chr(DEVICE(&s->soc), "serial0", serial_hd(0));
>> +    qdev_prop_set_chr(DEVICE(&s->soc), "serial1", serial_hd(1));
>> +    if (machine->firmware) {
>> +        qdev_prop_set_string(DEVICE(&s->soc), "bootrom-file",
>> +                             machine->firmware);
>> +    }
>> +    object_property_set_link(OBJECT(&s->soc), "memory",
>> +                             OBJECT(system_memory), &error_fatal);
>> +
>> +    memory_region_init_rom(&s->flash, NULL, "raspi-pico.flash",
>> +                           PICO_FLASH_SIZE, &error_fatal);
>> +    memory_region_add_subregion(system_memory, RP2040_XIP_BASE, =
&s->flash);
>> +
>> +    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>> +
>> +    armv7m_load_kernel(s->soc.armv7m.cpu, machine->kernel_filename,
>> +                       RP2040_XIP_BASE, PICO_FLASH_SIZE);
>> +}
>> +
>> +static void raspi_pico_machine_class_init(ObjectClass *oc, const =
void *data)
>> +{
>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>> +
>> +    mc->desc =3D "Raspberry Pi Pico (Cortex-M0+)";
>> +    mc->init =3D raspi_pico_init;
>> +    mc->default_cpus =3D 1;
>> +    mc->min_cpus =3D 1;
>> +    mc->max_cpus =3D 1;
>=20
> picos are duel core aren't they?
>=20
>> +    mc->default_ram_size =3D 0;
>> +    mc->no_parallel =3D 1;
>> +    mc->no_floppy =3D 1;
>> +    mc->no_cdrom =3D 1;
>> +}
>> +
>> +static const TypeInfo raspi_pico_machine_info =3D {
>> +    .name =3D TYPE_RASPI_PICO_MACHINE,
>> +    .parent =3D TYPE_MACHINE,
>> +    .instance_size =3D sizeof(RaspiPicoMachineState),
>> +    .class_init =3D raspi_pico_machine_class_init,
>> +    .interfaces =3D arm_machine_interfaces,
>> +};
>> +
>> +static void raspi_pico_machine_init(void)
>> +{
>> +    type_register_static(&raspi_pico_machine_info);
>> +}
>> +type_init(raspi_pico_machine_init)
>> diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
>> new file mode 100644
>> index 0000000000..2196bad18d
>> --- /dev/null
>> +++ b/hw/arm/rp2040.c
>> @@ -0,0 +1,242 @@
>> +/*
>> + * RP2040 SoC emulation
>> + *
>> + * Copyright (c) 2021 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/units.h"
>> +#include "qapi/error.h"
>> +#include "hw/arm/rp2040.h"
>> +#include "hw/core/loader.h"
>> +#include "hw/core/qdev-clock.h"
>> +#include "hw/core/qdev-properties.h"
>> +#include "hw/misc/unimp.h"
>> +#include "qemu/datadir.h"
>> +#include "target/arm/cpu-qom.h"
>> +
>> +#define RP2040_SYSCLK_FRQ 125000000
>> +
>> +#define RP2040_UART0_BASE 0x40034000
>> +#define RP2040_UART0_IRQ  20
>> +#define RP2040_UART1_BASE 0x40038000
>> +#define RP2040_UART1_IRQ  21
>> +
>> +/*
>> + * Temporary boot ROM used until the synthetic ROM is introduced. It =
loads
>> + * the reset handler from a vector table at the base of the XIP =
window.
>> + */
>> +static const uint8_t rp2040_bootrom[] =3D {
>> +    0x00, 0x20, 0x04, 0x20, /* initial SP: 0x20042000 */
>> +    0x09, 0x00, 0x00, 0x00, /* reset handler: 0x00000009 */
>> +    0x03, 0x48,             /* ldr r0, vtor */
>> +    0x04, 0x49,             /* ldr r1, xip_base */
>> +    0x01, 0x60,             /* str r1, [r0] */
>> +    0x04, 0x48,             /* ldr r0, xip_reset_vector */
>> +    0x01, 0x68,             /* ldr r1, [r0] */
>> +    0x08, 0x47,             /* bx r1 */
>> +    0xfe, 0xe7,             /* b . */
>> +    0xc0, 0x46,             /* nop */
>> +    0x08, 0xed, 0x00, 0xe0, /* VTOR: 0xe000ed08 */
>> +    0x00, 0x00, 0x00, 0x10, /* XIP base: 0x10000000 */
>> +    0x04, 0x00, 0x00, 0x10, /* XIP reset vector: 0x10000004 */
>> +};
>> +
>> +static const struct {
>> +    const char *name;
>> +    hwaddr base;
>> +    hwaddr size;
>> +} rp2040_unimplemented[] =3D {
>> +    { "rp2040.sysinfo",  0x40000000, 0x4000 },
>> +    { "rp2040.syscfg",   0x40004000, 0x4000 },
>> +    { "rp2040.clocks",   0x40008000, 0x4000 },
>> +    { "rp2040.resets",   0x4000c000, 0x4000 },
>> +    { "rp2040.psm",      0x40010000, 0x4000 },
>> +    { "rp2040.iobank0",  0x40014000, 0x4000 },
>> +    { "rp2040.ioqspi",   0x40018000, 0x4000 },
>> +    { "rp2040.padsbank0", 0x4001c000, 0x4000 },
>> +    { "rp2040.padsqspi", 0x40020000, 0x4000 },
>> +    { "rp2040.xosc",     0x40024000, 0x4000 },
>> +    { "rp2040.pll_sys",  0x40028000, 0x4000 },
>> +    { "rp2040.pll_usb",  0x4002c000, 0x4000 },
>> +    { "rp2040.busctrl",  0x40030000, 0x4000 },
>> +    { "rp2040.uart0_aliases", 0x40035000, 0x3000 },
>> +    { "rp2040.uart1_aliases", 0x40039000, 0x3000 },
>> +    { "rp2040.spi0",     0x4003c000, 0x4000 },
>> +    { "rp2040.spi1",     0x40040000, 0x4000 },
>> +    { "rp2040.i2c0",     0x40044000, 0x4000 },
>> +    { "rp2040.i2c1",     0x40048000, 0x4000 },
>> +    { "rp2040.adc",      0x4004c000, 0x4000 },
>> +    { "rp2040.pwm",      0x40050000, 0x4000 },
>> +    { "rp2040.timer",    0x40054000, 0x4000 },
>> +    { "rp2040.watchdog", 0x40058000, 0x4000 },
>> +    { "rp2040.rtc",      0x4005c000, 0x4000 },
>> +    { "rp2040.rosc",     0x40060000, 0x4000 },
>> +    { "rp2040.vreg_and_chip_reset", 0x40064000, 0x4000 },
>> +    { "rp2040.tbman",    0x4006c000, 0x4000 },
>> +    { "rp2040.dma",      0x50000000, 0x1000 },
>> +    { "rp2040.usbctrl_dpram", 0x50100000, 0x10000 },
>> +    { "rp2040.usbctrl_regs",  0x50110000, 0x10000 },
>> +    { "rp2040.pio0",     0x50200000, 0x10000 },
>> +    { "rp2040.pio1",     0x50300000, 0x10000 },
>> +    { "rp2040.sio",      0xd0000000, 0x1000 },
>> +};
>> +
>> +static void rp2040_soc_init(Object *obj)
>> +{
>> +    RP2040State *s =3D RP2040(obj);
>> +    int i;
>> +
>> +    object_initialize_child(obj, "proc0", &s->armv7m, TYPE_ARMV7M);
>> +    qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type",
>> +                         ARM_CPU_TYPE_NAME("cortex-m0"));
>> +    qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq", =
RP2040_NUM_IRQS);
>> +    qdev_prop_set_uint32(DEVICE(&s->armv7m), "mpu-ns-regions", 8);
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(s->uart); i++) {
>> +        g_autofree char *name =3D g_strdup_printf("uart%d", i);
>> +        g_autofree char *property =3D g_strdup_printf("serial%d", =
i);
>> +
>> +        object_initialize_child(obj, name, &s->uart[i], TYPE_PL011);
>> +        object_property_add_alias(obj, property, =
OBJECT(&s->uart[i]),
>> +                                  "chardev");
>> +    }
>> +
>> +    s->sysclk =3D clock_new(obj, "sysclk");
>> +    clock_set_hz(s->sysclk, RP2040_SYSCLK_FRQ);
>> +}
>> +
>> +static bool rp2040_init_memory(RP2040State *s, Error **errp)
>> +{
>> +    int i;
>> +
>> +    if (!memory_region_init_rom(&s->rom, OBJECT(s), "rp2040.rom",
>> +                                RP2040_ROM_SIZE, errp)) {
>> +        return false;
>> +    }
>> +    memory_region_add_subregion(s->board_memory, RP2040_ROM_BASE, =
&s->rom);
>> +
>> +    for (i =3D 0; i < 4; i++) {
>> +        g_autofree char *name =3D g_strdup_printf("rp2040.sram%d", =
i);
>> +
>> +        if (!memory_region_init_ram(&s->sram[i], OBJECT(s), name,
>> +                                    RP2040_SRAM_BANK_SIZE, errp)) {
>> +            return false;
>> +        }
>> +        memory_region_add_subregion(s->board_memory,
>> +                                    RP2040_SRAM_BASE +
>> +                                    i * RP2040_SRAM_BANK_SIZE,
>> +                                    &s->sram[i]);
>> +    }
>> +
>> +    if (!memory_region_init_ram(&s->sram[4], OBJECT(s), =
"rp2040.sram4",
>> +                                RP2040_SRAM_HI_SIZE, errp)) {
>> +        return false;
>> +    }
>> +    memory_region_add_subregion(s->board_memory, RP2040_SRAM4_BASE,
>> +                                &s->sram[4]);
>> +
>> +    if (!memory_region_init_ram(&s->sram[5], OBJECT(s), =
"rp2040.sram5",
>> +                                RP2040_SRAM_HI_SIZE, errp)) {
>> +        return false;
>> +    }
>> +    memory_region_add_subregion(s->board_memory, RP2040_SRAM5_BASE,
>> +                                &s->sram[5]);
>=20
> I think you need multiple addresses spaces for the last two as they =
are
> banked per-CPU right?
>=20
>> +
>> +    return true;
>> +}
>> +
>> +static bool rp2040_load_bootrom(RP2040State *s, Error **errp)
>> +{
>> +    g_autofree char *filename =3D NULL;
>> +
>> +    if (!s->bootrom_file) {
>> +        rom_add_blob_fixed("rp2040.bootrom", rp2040_bootrom,
>> +                           sizeof(rp2040_bootrom), RP2040_ROM_BASE);
>> +        return true;
>> +    }
>> +
>> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, =
s->bootrom_file);
>> +    if (!filename) {
>> +        error_setg(errp, "could not find RP2040 boot ROM image =
'%s'",
>> +                   s->bootrom_file);
>> +        return false;
>> +    }
>> +
>> +    return load_image_targphys(filename, RP2040_ROM_BASE,
>> +                               RP2040_ROM_SIZE, errp) >=3D 0;
>> +}
>> +
>> +static void rp2040_soc_realize(DeviceState *dev, Error **errp)
>> +{
>> +    RP2040State *s =3D RP2040(dev);
>> +    static const hwaddr uart_base[] =3D { RP2040_UART0_BASE, =
RP2040_UART1_BASE };
>> +    static const int uart_irq[] =3D { RP2040_UART0_IRQ, =
RP2040_UART1_IRQ };
>> +    Error *err =3D NULL;
>> +    int i;
>> +
>> +    if (!s->board_memory) {
>> +        error_setg(errp, "memory property was not set");
>> +        return;
>> +    }
>> +    if (!rp2040_init_memory(s, errp) || !rp2040_load_bootrom(s, =
errp)) {
>> +        return;
>> +    }
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(rp2040_unimplemented); i++) {
>> +        create_unimplemented_device(rp2040_unimplemented[i].name,
>> +                                    rp2040_unimplemented[i].base,
>> +                                    rp2040_unimplemented[i].size);
>> +    }
>> +
>> +    qdev_connect_clock_in(DEVICE(&s->armv7m), "cpuclk", s->sysclk);
>> +    object_property_set_link(OBJECT(&s->armv7m), "memory",
>> +                             OBJECT(s->board_memory), &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
>> +        return;
>> +    }
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(s->uart); i++) {
>> +        qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", =
s->sysclk);
>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
>> +            return;
>> +        }
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, =
uart_base[i]);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
>> +                           qdev_get_gpio_in(DEVICE(&s->armv7m), =
uart_irq[i]));
>> +    }
>> +}
>> +
>> +static const Property rp2040_soc_properties[] =3D {
>> +    DEFINE_PROP_LINK("memory", RP2040State, board_memory, =
TYPE_MEMORY_REGION,
>> +                     MemoryRegion *),
>> +    DEFINE_PROP_STRING("bootrom-file", RP2040State, bootrom_file),
>> +};
>> +
>> +static void rp2040_soc_class_init(ObjectClass *klass, const void =
*data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->realize =3D rp2040_soc_realize;
>> +    device_class_set_props(dc, rp2040_soc_properties);
>> +}
>> +
>> +static const TypeInfo rp2040_soc_info =3D {
>> +    .name =3D TYPE_RP2040,
>> +    .parent =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(RP2040State),
>> +    .instance_init =3D rp2040_soc_init,
>> +    .class_init =3D rp2040_soc_class_init,
>> +};
>> +
>> +static void rp2040_soc_types(void)
>> +{
>> +    type_register_static(&rp2040_soc_info);
>> +}
>> +type_init(rp2040_soc_types)
>> diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
>> new file mode 100644
>> index 0000000000..4e5cd06add
>> --- /dev/null
>> +++ b/include/hw/arm/rp2040.h
>> @@ -0,0 +1,46 @@
>> +/*
>> + * RP2040 SoC emulation
>> + *
>> + * Copyright (c) 2021 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_ARM_RP2040_H
>> +#define HW_ARM_RP2040_H
>> +
>> +#include "hw/arm/armv7m.h"
>> +#include "hw/char/pl011.h"
>> +#include "hw/core/clock.h"
>> +#include "hw/core/sysbus.h"
>> +#include "qom/object.h"
>> +
>> +#define TYPE_RP2040 "rp2040"
>> +OBJECT_DECLARE_SIMPLE_TYPE(RP2040State, RP2040)
>> +
>> +#define RP2040_ROM_BASE       0x00000000
>> +#define RP2040_ROM_SIZE       (16 * KiB)
>> +#define RP2040_XIP_BASE       0x10000000
>> +#define RP2040_SRAM_BASE      0x20000000
>> +#define RP2040_SRAM_BANK_SIZE (64 * KiB)
>> +#define RP2040_SRAM4_BASE     0x20040000
>> +#define RP2040_SRAM5_BASE     0x20041000
>> +#define RP2040_SRAM_HI_SIZE   (4 * KiB)
>> +
>> +#define RP2040_NUM_IRQS       32
>> +
>> +struct RP2040State {
>> +    SysBusDevice parent_obj;
>> +
>> +    ARMv7MState armv7m;
>> +    PL011State uart[2];
>> +
>> +    MemoryRegion *board_memory;
>> +    MemoryRegion rom;
>> +    MemoryRegion sram[6];
>> +    char *bootrom_file;
>> +
>> +    Clock *sysclk;
>> +};
>> +
>> +#endif
>=20
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro


--Apple-Mail=_BCB8C376-4555-4453-9DC0-FB0194151B23
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div>Hi =
Alex,</div><div><br></div><div>Yes. The v2 patch introduced the machine =
as single-core and deferred core 1</div><div>to a later patch. That was =
the wrong split.</div><div><br></div><div>For v3 I will instantiate both =
Cortex-M0+ cores in the initial SoC patch.</div><div>Core 1 may remain =
parked until the later SIO and boot ROM patches introduce</div><div>its =
launch protocol, but the machine topology will be dual-core from =
the</div><div>start.</div><div><br></div><div>I assume that by the last =
two regions you mean SIO and PPB. I will give each</div><div>core a =
separate memory container and address space. Each ARMv7M instance =
will</div><div>therefore retain its own PPB, NVIC, and SysTick mapping. =
SIO will expose</div><div>per-core MMIO views over the shared SIO state, =
instead of inferring the</div><div>accessing core from =
current_cpu.</div><div><br></div><div>Thanks,</div><div><div>--<br>Gilles =
Grimaud - 2XS/SISE - CRIStAL/IRCICA -&nbsp;CNRS/Univ. =
Lille&nbsp;&nbsp;</div><div><br></div><br =
class=3D"Apple-interchange-newline">
</div>
<div><br><blockquote type=3D"cite"><div>Le 1 sept. 2026 =C3=A0 20:33, =
Alex Benn=C3=A9e &lt;alex.bennee@linaro.org&gt; a =C3=A9crit :</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Gilles Grimaud &lt;</span><a =
href=3D"mailto:gilles.grimaud@univ-lille.fr" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">gilles.grimaud@univ-lille.fr</a><span style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt; writes:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;">From: gilles grimaud =
&lt;gilles.grimaud@univ-lille.fr&gt;<br><br>Continue the Raspberry Pi =
Pico machine model introduced by Alex Benn=C3=A9e's 2022 RFC on current =
QEMU APIs. Add the RP2040 QOM skeleton, internal ROM and SRAM map, the =
board XIP window, two PL011-backed UARTs, and explicit =
unimplemented-device placeholders for the remaining MMIO blocks.\n\nKeep =
the model single-core for now. Core 1 startup and the SIO launch =
protocol are introduced later with the multicore =
support.<br><br>Signed-off-by: gilles grimaud =
&lt;gilles.grimaud@univ-lille.fr&gt;<br>---<br>MAINTAINERS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 =
+<br>configs/devices/arm-softmmu/default.mak | &nbsp;&nbsp;1 =
+<br>hw/arm/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;| &nbsp;13 ++<br>hw/arm/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 =
+<br>hw/arm/raspi_pico.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;85 =
+++++++++<br>hw/arm/rp2040.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
242 ++++++++++++++++++++++++<br>include/hw/arm/rp2040.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;| &nbsp;46 +++++<br>7 files changed, 390 =
insertions(+)<br>create mode 100644 hw/arm/raspi_pico.c<br>create mode =
100644 hw/arm/rp2040.c<br>create mode 100644 =
include/hw/arm/rp2040.h<br><br>diff --git a/MAINTAINERS =
b/MAINTAINERS<br>index db641d9c4c..8fd7385d83 100644<br>--- =
a/MAINTAINERS<br>+++ b/MAINTAINERS<br>@@ -1041,6 +1041,7 @@ L: =
qemu-arm@nongnu.org<br>S: Maintained<br>F: hw/*/rp2040*<br>F: =
include/hw/*/rp2040*<br>+F: hw/arm/raspi_pico.c<br><br>Real View<br>M: =
Peter Maydell &lt;peter.maydell@linaro.org&gt;<br>diff --git =
a/configs/devices/arm-softmmu/default.mak =
b/configs/devices/arm-softmmu/default.mak<br>index =
71cf164511..e7f815dd0d 100644<br>--- =
a/configs/devices/arm-softmmu/default.mak<br>+++ =
b/configs/devices/arm-softmmu/default.mak<br>@@ -33,6 +33,7 @@<br># =
CONFIG_OLIMEX_STM32_H405=3Dn<br># CONFIG_MPS2=3Dn<br># =
CONFIG_RASPI=3Dn<br>+CONFIG_RASPI_PICO=3Dy<br># CONFIG_DIGIC=3Dn<br># =
CONFIG_SABRELITE=3Dn<br># CONFIG_EMCRAFT_SF2=3Dn<br>diff --git =
a/hw/arm/Kconfig b/hw/arm/Kconfig<br>index 260d2f0751..d93303ab80 =
100644<br>--- a/hw/arm/Kconfig<br>+++ b/hw/arm/Kconfig<br>@@ -368,6 =
+368,19 @@ config RASPI<br>&nbsp;&nbsp;&nbsp;&nbsp;select =
BCM2835_SPI<br>&nbsp;&nbsp;&nbsp;&nbsp;select BCM2835_I2C<br><br>+config =
RASPI_PICO<br>+ &nbsp;&nbsp;&nbsp;bool<br>+ &nbsp;&nbsp;&nbsp;default =
y<br>+ &nbsp;&nbsp;&nbsp;depends on TCG &amp;&amp; ARM<br>+ =
&nbsp;&nbsp;&nbsp;select RP2040<br>+<br>+config RP2040<br>+ =
&nbsp;&nbsp;&nbsp;bool<br>+ &nbsp;&nbsp;&nbsp;select ARM_V7M<br>+ =
&nbsp;&nbsp;&nbsp;select PL011<br>+ &nbsp;&nbsp;&nbsp;select =
RP2040_NYI<br>+ &nbsp;&nbsp;&nbsp;select UNIMP<br>+<br>config =
STM32F100_SOC<br>&nbsp;&nbsp;&nbsp;&nbsp;bool<br>&nbsp;&nbsp;&nbsp;&nbsp;s=
elect ARM_V7M<br>diff --git a/hw/arm/meson.build =
b/hw/arm/meson.build<br>index 8ee5307a91..3240ef6637 100644<br>--- =
a/hw/arm/meson.build<br>+++ b/hw/arm/meson.build<br>@@ -32,6 +32,8 @@ =
arm_common_ss.add(when: 'CONFIG_RASPI', if_true: =
files(<br>&nbsp;&nbsp;'raspi.c',<br>&nbsp;&nbsp;'raspi4b.c'<br>))<br>+arm_=
common_ss.add(when: 'CONFIG_RP2040', if_true: =
files('rp2040.c'))<br>+arm_common_ss.add(when: 'CONFIG_RASPI_PICO', =
if_true: files('raspi_pico.c'))<br>arm_common_ss.add(when: =
'CONFIG_STM32F100_SOC', if_true: =
files('stm32f100_soc.c'))<br>arm_common_ss.add(when: =
'CONFIG_STM32F205_SOC', if_true: =
files('stm32f205_soc.c'))<br>arm_common_ss.add(when: =
'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))<br>diff --git =
a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c<br>new file mode =
100644<br>index 0000000000..2bb7d4e511<br>--- /dev/null<br>+++ =
b/hw/arm/raspi_pico.c<br>@@ -0,0 +1,85 @@<br>+/*<br>+ * Raspberry Pi =
Pico machine<br>+ *<br>+ * Copyright (c) 2021 Linaro Ltd<br>+ *<br>+ * =
SPDX-License-Identifier: GPL-2.0-or-later<br>+ */<br>+<br>+#include =
"qemu/osdep.h"<br>+#include "qemu/units.h"<br>+#include =
"qapi/error.h"<br>+#include "hw/arm/boot.h"<br>+#include =
"hw/arm/machines-qom.h"<br>+#include "hw/arm/rp2040.h"<br>+#include =
"hw/core/boards.h"<br>+#include "hw/core/qdev-properties.h"<br>+#include =
"system/address-spaces.h"<br>+#include "system/system.h"<br>+#include =
"qom/object.h"<br>+<br>+#define TYPE_RASPI_PICO_MACHINE =
MACHINE_TYPE_NAME("raspi-pico")<br>+OBJECT_DECLARE_SIMPLE_TYPE(RaspiPicoMa=
chineState, RASPI_PICO_MACHINE)<br>+<br>+#define PICO_FLASH_SIZE (2 * =
MiB)<br>+<br>+struct RaspiPicoMachineState {<br>+ =
&nbsp;&nbsp;&nbsp;MachineState parent_obj;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;RP2040State soc;<br>+ &nbsp;&nbsp;&nbsp;MemoryRegion =
flash;<br>+};<br>+<br>+static void raspi_pico_init(MachineState =
*machine)<br>+{<br>+ &nbsp;&nbsp;&nbsp;RaspiPicoMachineState *s =3D =
RASPI_PICO_MACHINE(machine);<br>+ &nbsp;&nbsp;&nbsp;MemoryRegion =
*system_memory =3D get_system_memory();<br>+<br>+ =
&nbsp;&nbsp;&nbsp;object_initialize_child(OBJECT(machine), "soc", =
&amp;s-&gt;soc, TYPE_RP2040);<br>+ =
&nbsp;&nbsp;&nbsp;qdev_prop_set_chr(DEVICE(&amp;s-&gt;soc), "serial0", =
serial_hd(0));<br>+ =
&nbsp;&nbsp;&nbsp;qdev_prop_set_chr(DEVICE(&amp;s-&gt;soc), "serial1", =
serial_hd(1));<br>+ &nbsp;&nbsp;&nbsp;if (machine-&gt;firmware) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qdev_prop_set_string(DEVICE(&amp=
;s-&gt;soc), "bootrom-file",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;machine-&gt;firmware);<br>+ &nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;object_property_set_link(OBJECT(&amp;s-&gt;soc), =
"memory",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;OBJECT(system_memory), &amp;error_fatal);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_init_rom(&amp;s-&gt;flash, NULL, =
"raspi-pico.flash",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;PICO_FLASH_SIZE, &amp;error_fatal);<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_add_subregion(system_memory, =
RP2040_XIP_BASE, &amp;s-&gt;flash);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;soc), =
&amp;error_fatal);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;armv7m_load_kernel(s-&gt;soc.armv7m.cpu, =
machine-&gt;kernel_filename,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RP2040_XIP_BASE,=
 PICO_FLASH_SIZE);<br>+}<br>+<br>+static void =
raspi_pico_machine_class_init(ObjectClass *oc, const void =
*data)<br>+{<br>+ &nbsp;&nbsp;&nbsp;MachineClass *mc =3D =
MACHINE_CLASS(oc);<br>+<br>+ &nbsp;&nbsp;&nbsp;mc-&gt;desc =3D =
"Raspberry Pi Pico (Cortex-M0+)";<br>+ &nbsp;&nbsp;&nbsp;mc-&gt;init =3D =
raspi_pico_init;<br>+ &nbsp;&nbsp;&nbsp;mc-&gt;default_cpus =3D 1;<br>+ =
&nbsp;&nbsp;&nbsp;mc-&gt;min_cpus =3D 1;<br>+ =
&nbsp;&nbsp;&nbsp;mc-&gt;max_cpus =3D 1;<br></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">picos are duel core aren't they?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: solid;">+ =
&nbsp;&nbsp;&nbsp;mc-&gt;default_ram_size =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;mc-&gt;no_parallel =3D 1;<br>+ =
&nbsp;&nbsp;&nbsp;mc-&gt;no_floppy =3D 1;<br>+ =
&nbsp;&nbsp;&nbsp;mc-&gt;no_cdrom =3D 1;<br>+}<br>+<br>+static const =
TypeInfo raspi_pico_machine_info =3D {<br>+ &nbsp;&nbsp;&nbsp;.name =3D =
TYPE_RASPI_PICO_MACHINE,<br>+ &nbsp;&nbsp;&nbsp;.parent =3D =
TYPE_MACHINE,<br>+ &nbsp;&nbsp;&nbsp;.instance_size =3D =
sizeof(RaspiPicoMachineState),<br>+ &nbsp;&nbsp;&nbsp;.class_init =3D =
raspi_pico_machine_class_init,<br>+ &nbsp;&nbsp;&nbsp;.interfaces =3D =
arm_machine_interfaces,<br>+};<br>+<br>+static void =
raspi_pico_machine_init(void)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;type_register_static(&amp;raspi_pico_machine_info);<br>+=
}<br>+type_init(raspi_pico_machine_init)<br>diff --git a/hw/arm/rp2040.c =
b/hw/arm/rp2040.c<br>new file mode 100644<br>index =
0000000000..2196bad18d<br>--- /dev/null<br>+++ b/hw/arm/rp2040.c<br>@@ =
-0,0 +1,242 @@<br>+/*<br>+ * RP2040 SoC emulation<br>+ *<br>+ * =
Copyright (c) 2021 Linaro Ltd<br>+ *<br>+ * SPDX-License-Identifier: =
GPL-2.0-or-later<br>+ */<br>+<br>+#include "qemu/osdep.h"<br>+#include =
"qemu/units.h"<br>+#include "qapi/error.h"<br>+#include =
"hw/arm/rp2040.h"<br>+#include "hw/core/loader.h"<br>+#include =
"hw/core/qdev-clock.h"<br>+#include =
"hw/core/qdev-properties.h"<br>+#include "hw/misc/unimp.h"<br>+#include =
"qemu/datadir.h"<br>+#include "target/arm/cpu-qom.h"<br>+<br>+#define =
RP2040_SYSCLK_FRQ 125000000<br>+<br>+#define RP2040_UART0_BASE =
0x40034000<br>+#define RP2040_UART0_IRQ &nbsp;20<br>+#define =
RP2040_UART1_BASE 0x40038000<br>+#define RP2040_UART1_IRQ =
&nbsp;21<br>+<br>+/*<br>+ * Temporary boot ROM used until the synthetic =
ROM is introduced. It loads<br>+ * the reset handler from a vector table =
at the base of the XIP window.<br>+ */<br>+static const uint8_t =
rp2040_bootrom[] =3D {<br>+ &nbsp;&nbsp;&nbsp;0x00, 0x20, 0x04, 0x20, /* =
initial SP: 0x20042000 */<br>+ &nbsp;&nbsp;&nbsp;0x09, 0x00, 0x00, 0x00, =
/* reset handler: 0x00000009 */<br>+ &nbsp;&nbsp;&nbsp;0x03, 0x48, =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*=
 ldr r0, vtor */<br>+ &nbsp;&nbsp;&nbsp;0x04, 0x49, =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*=
 ldr r1, xip_base */<br>+ &nbsp;&nbsp;&nbsp;0x01, 0x60, =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*=
 str r1, [r0] */<br>+ &nbsp;&nbsp;&nbsp;0x04, 0x48, =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*=
 ldr r0, xip_reset_vector */<br>+ &nbsp;&nbsp;&nbsp;0x01, 0x68, =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*=
 ldr r1, [r0] */<br>+ &nbsp;&nbsp;&nbsp;0x08, 0x47, =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*=
 bx r1 */<br>+ &nbsp;&nbsp;&nbsp;0xfe, 0xe7, =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*=
 b . */<br>+ &nbsp;&nbsp;&nbsp;0xc0, 0x46, =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*=
 nop */<br>+ &nbsp;&nbsp;&nbsp;0x08, 0xed, 0x00, 0xe0, /* VTOR: =
0xe000ed08 */<br>+ &nbsp;&nbsp;&nbsp;0x00, 0x00, 0x00, 0x10, /* XIP =
base: 0x10000000 */<br>+ &nbsp;&nbsp;&nbsp;0x04, 0x00, 0x00, 0x10, /* =
XIP reset vector: 0x10000004 */<br>+};<br>+<br>+static const struct =
{<br>+ &nbsp;&nbsp;&nbsp;const char *name;<br>+ &nbsp;&nbsp;&nbsp;hwaddr =
base;<br>+ &nbsp;&nbsp;&nbsp;hwaddr size;<br>+} rp2040_unimplemented[] =3D=
 {<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.sysinfo", &nbsp;0x40000000, 0x4000 =
},<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.syscfg", &nbsp;&nbsp;0x40004000, =
0x4000 },<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.clocks", =
&nbsp;&nbsp;0x40008000, 0x4000 },<br>+ &nbsp;&nbsp;&nbsp;{ =
"rp2040.resets", &nbsp;&nbsp;0x4000c000, 0x4000 },<br>+ =
&nbsp;&nbsp;&nbsp;{ "rp2040.psm", =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x40010000, 0x4000 },<br>+ =
&nbsp;&nbsp;&nbsp;{ "rp2040.iobank0", &nbsp;0x40014000, 0x4000 },<br>+ =
&nbsp;&nbsp;&nbsp;{ "rp2040.ioqspi", &nbsp;&nbsp;0x40018000, 0x4000 =
},<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.padsbank0", 0x4001c000, 0x4000 =
},<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.padsqspi", 0x40020000, 0x4000 =
},<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.xosc", =
&nbsp;&nbsp;&nbsp;&nbsp;0x40024000, 0x4000 },<br>+ &nbsp;&nbsp;&nbsp;{ =
"rp2040.pll_sys", &nbsp;0x40028000, 0x4000 },<br>+ &nbsp;&nbsp;&nbsp;{ =
"rp2040.pll_usb", &nbsp;0x4002c000, 0x4000 },<br>+ &nbsp;&nbsp;&nbsp;{ =
"rp2040.busctrl", &nbsp;0x40030000, 0x4000 },<br>+ &nbsp;&nbsp;&nbsp;{ =
"rp2040.uart0_aliases", 0x40035000, 0x3000 },<br>+ &nbsp;&nbsp;&nbsp;{ =
"rp2040.uart1_aliases", 0x40039000, 0x3000 },<br>+ &nbsp;&nbsp;&nbsp;{ =
"rp2040.spi0", &nbsp;&nbsp;&nbsp;&nbsp;0x4003c000, 0x4000 },<br>+ =
&nbsp;&nbsp;&nbsp;{ "rp2040.spi1", &nbsp;&nbsp;&nbsp;&nbsp;0x40040000, =
0x4000 },<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.i2c0", =
&nbsp;&nbsp;&nbsp;&nbsp;0x40044000, 0x4000 },<br>+ &nbsp;&nbsp;&nbsp;{ =
"rp2040.i2c1", &nbsp;&nbsp;&nbsp;&nbsp;0x40048000, 0x4000 },<br>+ =
&nbsp;&nbsp;&nbsp;{ "rp2040.adc", =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x4004c000, 0x4000 },<br>+ =
&nbsp;&nbsp;&nbsp;{ "rp2040.pwm", =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x40050000, 0x4000 },<br>+ =
&nbsp;&nbsp;&nbsp;{ "rp2040.timer", &nbsp;&nbsp;&nbsp;0x40054000, 0x4000 =
},<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.watchdog", 0x40058000, 0x4000 =
},<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.rtc", =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x4005c000, 0x4000 },<br>+ =
&nbsp;&nbsp;&nbsp;{ "rp2040.rosc", &nbsp;&nbsp;&nbsp;&nbsp;0x40060000, =
0x4000 },<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.vreg_and_chip_reset", =
0x40064000, 0x4000 },<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.tbman", =
&nbsp;&nbsp;&nbsp;0x4006c000, 0x4000 },<br>+ &nbsp;&nbsp;&nbsp;{ =
"rp2040.dma", &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x50000000, 0x1000 },<br>+ =
&nbsp;&nbsp;&nbsp;{ "rp2040.usbctrl_dpram", 0x50100000, 0x10000 },<br>+ =
&nbsp;&nbsp;&nbsp;{ "rp2040.usbctrl_regs", &nbsp;0x50110000, 0x10000 =
},<br>+ &nbsp;&nbsp;&nbsp;{ "rp2040.pio0", =
&nbsp;&nbsp;&nbsp;&nbsp;0x50200000, 0x10000 },<br>+ &nbsp;&nbsp;&nbsp;{ =
"rp2040.pio1", &nbsp;&nbsp;&nbsp;&nbsp;0x50300000, 0x10000 },<br>+ =
&nbsp;&nbsp;&nbsp;{ "rp2040.sio", =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0xd0000000, 0x1000 =
},<br>+};<br>+<br>+static void rp2040_soc_init(Object *obj)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;RP2040State *s =3D RP2040(obj);<br>+ =
&nbsp;&nbsp;&nbsp;int i;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;object_initialize_child(obj, "proc0", =
&amp;s-&gt;armv7m, TYPE_ARMV7M);<br>+ =
&nbsp;&nbsp;&nbsp;qdev_prop_set_string(DEVICE(&amp;s-&gt;armv7m), =
"cpu-type",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ARM_=
CPU_TYPE_NAME("cortex-m0"));<br>+ =
&nbsp;&nbsp;&nbsp;qdev_prop_set_uint32(DEVICE(&amp;s-&gt;armv7m), =
"num-irq", RP2040_NUM_IRQS);<br>+ =
&nbsp;&nbsp;&nbsp;qdev_prop_set_uint32(DEVICE(&amp;s-&gt;armv7m), =
"mpu-ns-regions", 8);<br>+<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
ARRAY_SIZE(s-&gt;uart); i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_autofree char *name =3D =
g_strdup_printf("uart%d", i);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_autofree char *property =3D =
g_strdup_printf("serial%d", i);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;object_initialize_child(obj, =
name, &amp;s-&gt;uart[i], TYPE_PL011);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;object_property_add_alias(obj, =
property, OBJECT(&amp;s-&gt;uart[i]),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"chardev");<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;s-&gt;sysclk =3D =
clock_new(obj, "sysclk");<br>+ =
&nbsp;&nbsp;&nbsp;clock_set_hz(s-&gt;sysclk, =
RP2040_SYSCLK_FRQ);<br>+}<br>+<br>+static bool =
rp2040_init_memory(RP2040State *s, Error **errp)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;int i;<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(!memory_region_init_rom(&amp;s-&gt;rom, OBJECT(s), "rp2040.rom",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RP2040_ROM_SIZE, errp)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return false;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_add_subregion(s-&gt;board_memory, =
RP2040_ROM_BASE, &amp;s-&gt;rom);<br>+<br>+ &nbsp;&nbsp;&nbsp;for (i =3D =
0; i &lt; 4; i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_autofree char *name =3D =
g_strdup_printf("rp2040.sram%d", i);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(!memory_region_init_ram(&amp;s-&gt;sram[i], OBJECT(s), name,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RP2040_SRAM_=
BANK_SIZE, errp)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
false;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memory_region_add_subregion(s-&g=
t;board_memory,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RP2040_SRAM_=
BASE +<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i * =
RP2040_SRAM_BANK_SIZE,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;s-&gt;s=
ram[i]);<br>+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(!memory_region_init_ram(&amp;s-&gt;sram[4], OBJECT(s), =
"rp2040.sram4",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RP2040_SRAM_HI_SIZE, errp)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return false;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_add_subregion(s-&gt;board_memory, =
RP2040_SRAM4_BASE,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;s-&gt;sram[4]);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;if (!memory_region_init_ram(&amp;s-&gt;sram[5], =
OBJECT(s), "rp2040.sram5",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RP2040_SRAM_HI_SIZE, errp)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return false;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_add_subregion(s-&gt;board_memory, =
RP2040_SRAM5_BASE,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;s-&gt;sram[5]);<br></blockquote=
><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">I think =
you need multiple addresses spaces for the last two as they =
are</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">banked per-CPU right?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;">+<br>+ &nbsp;&nbsp;&nbsp;return true;<br>+}<br>+<br>+static bool =
rp2040_load_bootrom(RP2040State *s, Error **errp)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;g_autofree char *filename =3D NULL;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;if (!s-&gt;bootrom_file) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rom_add_blob_fixed("rp2040.bootr=
om", rp2040_bootrom,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;sizeof(rp2040_bootrom), RP2040_ROM_BASE);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return true;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;filename =3D =
qemu_find_file(QEMU_FILE_TYPE_BIOS, s-&gt;bootrom_file);<br>+ =
&nbsp;&nbsp;&nbsp;if (!filename) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, "could not =
find RP2040 boot ROM image '%s'",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;bootrom_file);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return false;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;return =
load_image_targphys(filename, RP2040_ROM_BASE,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RP2040_ROM_SIZE, errp) &gt;=3D =
0;<br>+}<br>+<br>+static void rp2040_soc_realize(DeviceState *dev, Error =
**errp)<br>+{<br>+ &nbsp;&nbsp;&nbsp;RP2040State *s =3D =
RP2040(dev);<br>+ &nbsp;&nbsp;&nbsp;static const hwaddr uart_base[] =3D =
{ RP2040_UART0_BASE, RP2040_UART1_BASE };<br>+ &nbsp;&nbsp;&nbsp;static =
const int uart_irq[] =3D { RP2040_UART0_IRQ, RP2040_UART1_IRQ };<br>+ =
&nbsp;&nbsp;&nbsp;Error *err =3D NULL;<br>+ &nbsp;&nbsp;&nbsp;int =
i;<br>+<br>+ &nbsp;&nbsp;&nbsp;if (!s-&gt;board_memory) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, "memory =
property was not set");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;if (!rp2040_init_memory(s, =
errp) || !rp2040_load_bootrom(s, errp)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
ARRAY_SIZE(rp2040_unimplemented); i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;create_unimplemented_device(rp20=
40_unimplemented[i].name,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_unimp=
lemented[i].base,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_unimp=
lemented[i].size);<br>+ &nbsp;&nbsp;&nbsp;}<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qdev_connect_clock_in(DEVICE(&amp;s-&gt;armv7m), =
"cpuclk", s-&gt;sysclk);<br>+ =
&nbsp;&nbsp;&nbsp;object_property_set_link(OBJECT(&amp;s-&gt;armv7m), =
"memory",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;OBJECT(s-&gt;board_memory), &amp;err);<br>+ =
&nbsp;&nbsp;&nbsp;if (err) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_propagate(errp, =
err);<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;if =
(!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;armv7m), errp)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
ARRAY_SIZE(s-&gt;uart); i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qdev_connect_clock_in(DEVICE(&am=
p;s-&gt;uart[i]), "clk", s-&gt;sysclk);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;uart[i]), errp)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<=
br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sysbus_mmio_map(SYS_BUS_DEVICE(&=
amp;s-&gt;uart[i]), 0, uart_base[i]);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sysbus_connect_irq(SYS_BUS_DEVIC=
E(&amp;s-&gt;uart[i]), 0,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;qdev_get_gpio_in(DEVICE(&amp;s-&gt;armv7m), uart_irq[i]));<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static const Property =
rp2040_soc_properties[] =3D {<br>+ =
&nbsp;&nbsp;&nbsp;DEFINE_PROP_LINK("memory", RP2040State, board_memory, =
TYPE_MEMORY_REGION,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MemoryRegion *),<br>+ =
&nbsp;&nbsp;&nbsp;DEFINE_PROP_STRING("bootrom-file", RP2040State, =
bootrom_file),<br>+};<br>+<br>+static void =
rp2040_soc_class_init(ObjectClass *klass, const void *data)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;DeviceClass *dc =3D DEVICE_CLASS(klass);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;dc-&gt;realize =3D rp2040_soc_realize;<br>+ =
&nbsp;&nbsp;&nbsp;device_class_set_props(dc, =
rp2040_soc_properties);<br>+}<br>+<br>+static const TypeInfo =
rp2040_soc_info =3D {<br>+ &nbsp;&nbsp;&nbsp;.name =3D TYPE_RP2040,<br>+ =
&nbsp;&nbsp;&nbsp;.parent =3D TYPE_SYS_BUS_DEVICE,<br>+ =
&nbsp;&nbsp;&nbsp;.instance_size =3D sizeof(RP2040State),<br>+ =
&nbsp;&nbsp;&nbsp;.instance_init =3D rp2040_soc_init,<br>+ =
&nbsp;&nbsp;&nbsp;.class_init =3D =
rp2040_soc_class_init,<br>+};<br>+<br>+static void =
rp2040_soc_types(void)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;type_register_static(&amp;rp2040_soc_info);<br>+}<br>+ty=
pe_init(rp2040_soc_types)<br>diff --git a/include/hw/arm/rp2040.h =
b/include/hw/arm/rp2040.h<br>new file mode 100644<br>index =
0000000000..4e5cd06add<br>--- /dev/null<br>+++ =
b/include/hw/arm/rp2040.h<br>@@ -0,0 +1,46 @@<br>+/*<br>+ * RP2040 SoC =
emulation<br>+ *<br>+ * Copyright (c) 2021 Linaro Ltd<br>+ *<br>+ * =
SPDX-License-Identifier: GPL-2.0-or-later<br>+ */<br>+<br>+#ifndef =
HW_ARM_RP2040_H<br>+#define HW_ARM_RP2040_H<br>+<br>+#include =
"hw/arm/armv7m.h"<br>+#include "hw/char/pl011.h"<br>+#include =
"hw/core/clock.h"<br>+#include "hw/core/sysbus.h"<br>+#include =
"qom/object.h"<br>+<br>+#define TYPE_RP2040 =
"rp2040"<br>+OBJECT_DECLARE_SIMPLE_TYPE(RP2040State, =
RP2040)<br>+<br>+#define RP2040_ROM_BASE =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00000000<br>+#define =
RP2040_ROM_SIZE &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(16 * =
KiB)<br>+#define RP2040_XIP_BASE =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x10000000<br>+#define =
RP2040_SRAM_BASE &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x20000000<br>+#define =
RP2040_SRAM_BANK_SIZE (64 * KiB)<br>+#define RP2040_SRAM4_BASE =
&nbsp;&nbsp;&nbsp;&nbsp;0x20040000<br>+#define RP2040_SRAM5_BASE =
&nbsp;&nbsp;&nbsp;&nbsp;0x20041000<br>+#define RP2040_SRAM_HI_SIZE =
&nbsp;&nbsp;(4 * KiB)<br>+<br>+#define RP2040_NUM_IRQS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;32<br>+<br>+struct RP2040State =
{<br>+ &nbsp;&nbsp;&nbsp;SysBusDevice parent_obj;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;ARMv7MState armv7m;<br>+ &nbsp;&nbsp;&nbsp;PL011State =
uart[2];<br>+<br>+ &nbsp;&nbsp;&nbsp;MemoryRegion *board_memory;<br>+ =
&nbsp;&nbsp;&nbsp;MemoryRegion rom;<br>+ &nbsp;&nbsp;&nbsp;MemoryRegion =
sram[6];<br>+ &nbsp;&nbsp;&nbsp;char *bootrom_file;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;Clock =
*sysclk;<br>+};<br>+<br>+#endif<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">--<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Alex Benn=C3=A9e</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Virtualisation Tech Lead @ =
Linaro</span></div></blockquote></div><br></body></html>=

--Apple-Mail=_BCB8C376-4555-4453-9DC0-FB0194151B23--

