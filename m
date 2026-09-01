Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6C6C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 23:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Xva-0006C4-SO; Tue, 01 Sep 2026 19:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x1XvY-0006Br-T0; Tue, 01 Sep 2026 19:30:04 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x1XvR-0007Ea-D4; Tue, 01 Sep 2026 19:30:04 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hZMXL47Gwz7xFb;
 Wed,  2 Sep 2026 01:29:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788305394;
 bh=u9NiUkf7JRrrVZt3cweqlvJDwV7FF847MPzzzHD751M=;
 h=From:Subject:Date:In-Reply-To:Cc:To:References:From;
 b=Miybn397tttVvG+DYvNX26AJy6+CA0CesU9Oh0vDthsTsFJst0SscQX9+0Vo02UU5
 Dn+d4KaQvLuurw/96K1fRhOfQx63wBkVcknbBVM3zTjBS3ySbYnXpSWDRZr/aqPAt7
 VmYlL21P69bbZza90CcMhlwbyAHHaoK0uFYl4orU8u6/K2ytAjgldDKwgxYjRuuIGZ
 sdyg42IJ1qetGc1K5srH3vwhu5DojX7M5p2E+hYgjD1fDcW0IMXkHqrvUH3XmLNjIs
 2nZ+BwcifSV/+4/lc0b1EDUw0nYi5VxNq05xE8rVuVetNKgeyKrW7NgqbkRFYI0Kua
 8eE1TJhWFSNDQ==
Received: from smtpclient.apple (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hZMXL1j8Xz7tBy;
 Wed,  2 Sep 2026 01:29:54 +0200 (CEST)
From: gilles grimaud <gilles.grimaud@univ-lille.fr>
Message-Id: <AC79D616-7FD9-46BA-9761-CC64E2E3E056@univ-lille.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_54FC612A-2576-4FBB-AE11-4F6609C24349"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH RFC v2 06/30] hw/misc: add RP2040 SYSINFO and SYSCFG
Date: Wed, 2 Sep 2026 01:29:43 +0200
In-Reply-To: <87a4q0u7ys.fsf@draig.linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260829234308.33725-7-gilles.grimaud@univ-lille.fr>
 <87a4q0u7ys.fsf@draig.linaro.org>
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


--Apple-Mail=_54FC612A-2576-4FBB-AE11-4F6609C24349
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Alex,

Thanks for the review. I have looked at the impact of these comments, =
and
for v3 I propose to:

* split the current patch into two focused patches: one for SYSINFO and =
one
  for SYSCFG;
* remove the powered-off memory overlays. They were intended to make CPU
  and DMA accesses fail after setting MEMPOWERDOWN, but this goes beyond =
the
  documented register behavior;
* retain the documented MEMPOWERDOWN register state, reset value, and =
write
  mask, without claiming to model physical ROM or SRAM power gating;
* route PROC0_NMI_MASK and PROC1_NMI_MASK independently to the =
corresponding
  core;
* remove the MemoryRegionOps.with_attrs callbacks, since they are only
  needed by the powered-off memory overlays;
* remove the per-subsystem RP2040 Kconfig symbols and build the internal
  devices under the single CONFIG_RP2040 symbol.

I will add focused qtests to the separate SYSINFO and SYSCFG patches.

Does this sound in the right direction?

Thanks,
--
Gilles Grimaud - 2XS/SISE - CRIStAL/IRCICA - CNRS/Univ. Lille =20



> Le 1 sept. 2026 =C3=A0 20:44, Alex Benn=C3=A9e =
<alex.bennee@linaro.org> a =C3=A9crit :
>=20
> Gilles Grimaud <gilles.grimaud@univ-lille.fr =
<mailto:gilles.grimaud@univ-lille.fr>> writes:
>=20
>> From: gilles grimaud <gilles.grimaud@univ-lille.fr =
<mailto:gilles.grimaud@univ-lille.fr>>
>>=20
>> Model the RP2040 identification and system configuration registers,
>> including APB atomic aliases and documented reset and write masks.
>> Wire SYSCFG into the SoC so NMI masks reroute interrupt inputs and
>> MEMPOWERDOWN blocks access to powered-off ROM and SRAM banks.
>=20
> What exactly is going to be accessing ROM and SRAM while powered off?
>=20
> Why do all three things need to be done at the same time?
>=20
>> \n\nAdd focused qtests for register values, aliases, power-down =
behavior, and UART0 IRQ routing to NMI.
>>=20
>> Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
>> ---
>> MAINTAINERS                              |   1 +
>> hw/arm/Kconfig                           |   2 +
>> hw/arm/rp2040.c                          | 129 +++++++++++-
>> hw/misc/Kconfig                          |   6 +
>> hw/misc/meson.build                      |   2 +
>> hw/misc/rp2040_syscfg.c                  | 244 =
+++++++++++++++++++++++
>> hw/misc/rp2040_sysinfo.c                 | 103 ++++++++++
>> include/hw/arm/rp2040.h                  |  12 ++
>> include/hw/misc/rp2040_syscfg.h          |  42 ++++
>> include/hw/misc/rp2040_sysinfo.h         |  25 +++
>> tests/qtest/meson.build                  |   1 +
>> tests/qtest/rp2040-sysinfo-syscfg-test.c | 176 ++++++++++++++++
>> 12 files changed, 740 insertions(+), 3 deletions(-)
>> create mode 100644 hw/misc/rp2040_syscfg.c
>> create mode 100644 hw/misc/rp2040_sysinfo.c
>> create mode 100644 include/hw/misc/rp2040_syscfg.h
>> create mode 100644 include/hw/misc/rp2040_sysinfo.h
>> create mode 100644 tests/qtest/rp2040-sysinfo-syscfg-test.c
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b000b3287d..fd35521947 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1042,6 +1042,7 @@ S: Maintained
>> F: hw/*/rp2040*
>> F: include/hw/*/rp2040*
>> F: hw/arm/raspi_pico.c
>> +F: tests/qtest/rp2040*
>> F: tests/tcg/arm/system/rp2040*
>>=20
>> Real View
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index d93303ab80..5d55ca06fd 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -379,6 +379,8 @@ config RP2040
>>     select ARM_V7M
>>     select PL011
>>     select RP2040_NYI
>> +    select RP2040_SYSCFG
>> +    select RP2040_SYSINFO
>=20
> I'm not sure we are going to need Kconfig vars for every sub-system. =
If
> they come with the RP2040 as a piece we should only need one symbol to
> select the board, peripheral and CPU models.
>=20
>>     select UNIMP
>>=20
>> config STM32F100_SOC
>> diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
>> index 2196bad18d..a184d527e1 100644
>> --- a/hw/arm/rp2040.c
>> +++ b/hw/arm/rp2040.c
>> @@ -13,6 +13,7 @@
>> #include "hw/core/loader.h"
>> #include "hw/core/qdev-clock.h"
>> #include "hw/core/qdev-properties.h"
>> +#include "hw/core/irq.h"
>> #include "hw/misc/unimp.h"
>> #include "qemu/datadir.h"
>> #include "target/arm/cpu-qom.h"
>> @@ -49,8 +50,6 @@ static const struct {
>>     hwaddr base;
>>     hwaddr size;
>> } rp2040_unimplemented[] =3D {
>> -    { "rp2040.sysinfo",  0x40000000, 0x4000 },
>> -    { "rp2040.syscfg",   0x40004000, 0x4000 },
>>     { "rp2040.clocks",   0x40008000, 0x4000 },
>>     { "rp2040.resets",   0x4000c000, 0x4000 },
>>     { "rp2040.psm",      0x40010000, 0x4000 },
>> @@ -84,6 +83,80 @@ static const struct {
>>     { "rp2040.sio",      0xd0000000, 0x1000 },
>> };
>>=20
>> +static MemTxResult rp2040_powered_off_read(void *opaque, hwaddr =
addr,
>> +                                           uint64_t *data, unsigned =
size,
>> +                                           MemTxAttrs attrs)
>> +{
>> +    *data =3D 0;
>> +    return MEMTX_ERROR;
>> +}
>> +
>> +static MemTxResult rp2040_powered_off_write(void *opaque, hwaddr =
addr,
>> +                                            uint64_t data, unsigned =
size,
>> +                                            MemTxAttrs attrs)
>> +{
>> +    return MEMTX_ERROR;
>> +}
>> +
>> +static const MemoryRegionOps rp2040_powered_off_ops =3D {
>> +    .read_with_attrs =3D rp2040_powered_off_read,
>> +    .write_with_attrs =3D rp2040_powered_off_write,
>=20
> You choose to have _with_attrs access functions here but not later. =
Why?=20
>=20
>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 4,
>> +    },
>> +};
>> +
>> +static void rp2040_update_mempowerdown(RP2040State *s)
>> +{
>> +    uint32_t mempowerdown;
>> +    int i;
>> +
>> +    if (!s->mempowerdown_ready) {
>> +        return;
>> +    }
>> +
>> +    mempowerdown =3D rp2040_syscfg_get_mempowerdown(&s->syscfg);
>> +    for (i =3D 0; i < ARRAY_SIZE(s->sram_poweroff); i++) {
>> +        memory_region_set_enabled(&s->sram_poweroff[i],
>> +                                  mempowerdown & BIT(i));
>> +    }
>> +    memory_region_set_enabled(&s->rom_poweroff, mempowerdown & =
BIT(7));
>> +}
>> +
>> +static void rp2040_update_nmi(RP2040State *s)
>> +{
>> +    uint32_t nmi_mask =3D =
rp2040_syscfg_get_proc0_nmi_mask(&s->syscfg);
>> +    bool nmi_level =3D false;
>> +    int i;
>> +
>> +    for (i =3D 0; i < RP2040_NUM_IRQS; i++) {
>> +        bool route_to_nmi =3D nmi_mask & BIT(i);
>> +
>> +        qemu_set_irq(s->cpu_irq[i], s->irq_level[i] && =
!route_to_nmi);
>> +        nmi_level |=3D s->irq_level[i] && route_to_nmi;
>> +    }
>> +    qemu_set_irq(s->nmi_irq, nmi_level);
>> +}
>> +
>> +static void rp2040_syscfg_update(void *opaque)
>> +{
>> +    RP2040State *s =3D opaque;
>> +
>> +    rp2040_update_mempowerdown(s);
>> +    rp2040_update_nmi(s);
>> +}
>> +
>> +static void rp2040_set_irq(void *opaque, int irq, int level)
>> +{
>> +    RP2040State *s =3D opaque;
>> +
>> +    assert(irq >=3D 0 && irq < RP2040_NUM_IRQS);
>> +    s->irq_level[irq] =3D level;
>> +    rp2040_update_nmi(s);
>> +}
>> +
>> static void rp2040_soc_init(Object *obj)
>> {
>>     RP2040State *s =3D RP2040(obj);
>> @@ -104,6 +177,10 @@ static void rp2040_soc_init(Object *obj)
>>                                   "chardev");
>>     }
>>=20
>> +    object_initialize_child(obj, "syscfg", &s->syscfg, =
TYPE_RP2040_SYSCFG);
>> +    object_initialize_child(obj, "sysinfo", &s->sysinfo, =
TYPE_RP2040_SYSINFO);
>> +
>> +    s->irq =3D qemu_allocate_irqs(rp2040_set_irq, s, =
RP2040_NUM_IRQS);
>>     s->sysclk =3D clock_new(obj, "sysclk");
>>     clock_set_hz(s->sysclk, RP2040_SYSCLK_FRQ);
>> }
>> @@ -117,9 +194,17 @@ static bool rp2040_init_memory(RP2040State *s, =
Error **errp)
>>         return false;
>>     }
>>     memory_region_add_subregion(s->board_memory, RP2040_ROM_BASE, =
&s->rom);
>> +    memory_region_init_io(&s->rom_poweroff, OBJECT(s),
>> +                          &rp2040_powered_off_ops, s,
>> +                          "rp2040.rom.poweroff", RP2040_ROM_SIZE);
>> +    memory_region_add_subregion_overlap(s->board_memory, =
RP2040_ROM_BASE,
>> +                                        &s->rom_poweroff, 1);
>> +    memory_region_set_enabled(&s->rom_poweroff, false);
>>=20
>>     for (i =3D 0; i < 4; i++) {
>>         g_autofree char *name =3D g_strdup_printf("rp2040.sram%d", =
i);
>> +        g_autofree char *poweroff_name =3D
>> +            g_strdup_printf("rp2040.sram%d.poweroff", i);
>>=20
>>         if (!memory_region_init_ram(&s->sram[i], OBJECT(s), name,
>>                                     RP2040_SRAM_BANK_SIZE, errp)) {
>> @@ -129,6 +214,14 @@ static bool rp2040_init_memory(RP2040State *s, =
Error **errp)
>>                                     RP2040_SRAM_BASE +
>>                                     i * RP2040_SRAM_BANK_SIZE,
>>                                     &s->sram[i]);
>> +        memory_region_init_io(&s->sram_poweroff[i], OBJECT(s),
>> +                              &rp2040_powered_off_ops, s, =
poweroff_name,
>> +                              RP2040_SRAM_BANK_SIZE);
>> +        memory_region_add_subregion_overlap(s->board_memory,
>> +                                            RP2040_SRAM_BASE +
>> +                                            i * =
RP2040_SRAM_BANK_SIZE,
>> +                                            &s->sram_poweroff[i], =
1);
>> +        memory_region_set_enabled(&s->sram_poweroff[i], false);
>>     }
>>=20
>>     if (!memory_region_init_ram(&s->sram[4], OBJECT(s), =
"rp2040.sram4",
>> @@ -137,6 +230,12 @@ static bool rp2040_init_memory(RP2040State *s, =
Error **errp)
>>     }
>>     memory_region_add_subregion(s->board_memory, RP2040_SRAM4_BASE,
>>                                 &s->sram[4]);
>> +    memory_region_init_io(&s->sram_poweroff[4], OBJECT(s),
>> +                          &rp2040_powered_off_ops, s,
>> +                          "rp2040.sram4.poweroff", =
RP2040_SRAM_HI_SIZE);
>> +    memory_region_add_subregion_overlap(s->board_memory, =
RP2040_SRAM4_BASE,
>> +                                        &s->sram_poweroff[4], 1);
>> +    memory_region_set_enabled(&s->sram_poweroff[4], false);
>>=20
>>     if (!memory_region_init_ram(&s->sram[5], OBJECT(s), =
"rp2040.sram5",
>>                                 RP2040_SRAM_HI_SIZE, errp)) {
>> @@ -144,6 +243,14 @@ static bool rp2040_init_memory(RP2040State *s, =
Error **errp)
>>     }
>>     memory_region_add_subregion(s->board_memory, RP2040_SRAM5_BASE,
>>                                 &s->sram[5]);
>> +    memory_region_init_io(&s->sram_poweroff[5], OBJECT(s),
>> +                          &rp2040_powered_off_ops, s,
>> +                          "rp2040.sram5.poweroff", =
RP2040_SRAM_HI_SIZE);
>> +    memory_region_add_subregion_overlap(s->board_memory, =
RP2040_SRAM5_BASE,
>> +                                        &s->sram_poweroff[5], 1);
>> +    memory_region_set_enabled(&s->sram_poweroff[5], false);
>> +
>> +    s->mempowerdown_ready =3D true;
>>=20
>>     return true;
>> }
>> @@ -201,6 +308,22 @@ static void rp2040_soc_realize(DeviceState *dev, =
Error **errp)
>>     if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
>>         return;
>>     }
>> +    for (i =3D 0; i < RP2040_NUM_IRQS; i++) {
>> +        s->cpu_irq[i] =3D qdev_get_gpio_in(DEVICE(&s->armv7m), i);
>> +    }
>> +    s->nmi_irq =3D qdev_get_gpio_in_named(DEVICE(&s->armv7m), "NMI", =
0);
>> +
>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
>> +        return;
>> +    }
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->syscfg), 0, =
RP2040_SYSCFG_BASE);
>> +    rp2040_syscfg_set_update_callback(&s->syscfg, =
rp2040_syscfg_update, s);
>> +
>> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysinfo), errp)) {
>> +        return;
>> +    }
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, =
RP2040_SYSINFO_BASE);
>> +    rp2040_syscfg_update(s);
>>=20
>>     for (i =3D 0; i < ARRAY_SIZE(s->uart); i++) {
>>         qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", s->sysclk);
>> @@ -209,7 +332,7 @@ static void rp2040_soc_realize(DeviceState *dev, =
Error **errp)
>>         }
>>         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, =
uart_base[i]);
>>         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
>> -                           qdev_get_gpio_in(DEVICE(&s->armv7m), =
uart_irq[i]));
>> +                           s->irq[uart_irq[i]]);
>>     }
>> }
>>=20
>> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>> index de7a0f56fa..f6f344ab51 100644
>> --- a/hw/misc/Kconfig
>> +++ b/hw/misc/Kconfig
>> @@ -104,6 +104,12 @@ config FSL_IMX8MP_CCM
>> config RP2040_NYI
>>     bool
>>=20
>> +config RP2040_SYSCFG
>> +    bool
>> +
>> +config RP2040_SYSINFO
>> +    bool
>> +
>> config STM32_RCC
>>     bool
>>=20
>> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
>> index 8611d59437..7be9f45c78 100644
>> --- a/hw/misc/meson.build
>> +++ b/hw/misc/meson.build
>> @@ -99,6 +99,8 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>>   'bcm2835_powermgt.c',
>> ))
>> system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: =
files('rp2040_nyi.c'))
>> +system_ss.add(when: 'CONFIG_RP2040_SYSCFG', if_true: =
files('rp2040_syscfg.c'))
>> +system_ss.add(when: 'CONFIG_RP2040_SYSINFO', if_true: =
files('rp2040_sysinfo.c'))
>> system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
>> system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
>> system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: =
files('xlnx-zynq-ddrc.c'))
>> diff --git a/hw/misc/rp2040_syscfg.c b/hw/misc/rp2040_syscfg.c
>> new file mode 100644
>> index 0000000000..69b4164ccd
>> --- /dev/null
>> +++ b/hw/misc/rp2040_syscfg.c
>> @@ -0,0 +1,244 @@
>> +/*
>> + * RP2040 syscfg emulation
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/misc/rp2040_nyi.h"
>> +#include "hw/misc/rp2040_syscfg.h"
>> +#include "migration/vmstate.h"
>> +#include "qemu/module.h"
>> +
>> +#define SYSCFG_PROC0_NMI_MASK          0x00
>> +#define SYSCFG_PROC1_NMI_MASK          0x04
>> +#define SYSCFG_PROC_CONFIG             0x08
>> +#define SYSCFG_PROC_IN_SYNC_BYPASS     0x0c
>> +#define SYSCFG_PROC_IN_SYNC_BYPASS_HI  0x10
>> +#define SYSCFG_DBGFORCE                0x14
>> +#define SYSCFG_MEMPOWERDOWN            0x18
>> +
>> +#define PROC_CONFIG_RW_MASK            0xff000000
>> +#define PROC_CONFIG_RESET              0x10000000
>> +#define PROC_IN_SYNC_BYPASS_MASK       0x3fffffff
>> +#define PROC_IN_SYNC_BYPASS_HI_MASK    0x0000003f
>> +#define DBGFORCE_RW_MASK               0x000000ee
>> +#define DBGFORCE_RESET                 0x00000066
>> +#define MEMPOWERDOWN_MASK              0x000000ff
>> +
>> +#define ATOMIC_ALIAS_MASK              0x3000
>> +#define ATOMIC_XOR                     0x1000
>> +#define ATOMIC_SET                     0x2000
>> +#define ATOMIC_CLR                     0x3000
>> +
>> +static uint32_t rp2040_syscfg_apply_alias(uint32_t old, uint32_t =
value,
>> +                                          hwaddr alias)
>> +{
>> +    switch (alias) {
>> +    case ATOMIC_XOR:
>> +        return old ^ value;
>> +    case ATOMIC_SET:
>> +        return old | value;
>> +    case ATOMIC_CLR:
>> +        return old & ~value;
>> +    default:
>> +        return value;
>> +    }
>> +}
>> +
>> +static void rp2040_syscfg_update(RP2040SysCfgState *s)
>> +{
>> +    if (s->update) {
>> +        s->update(s->update_opaque);
>> +    }
>> +}
>> +
>> +void rp2040_syscfg_set_update_callback(RP2040SysCfgState *s,
>> +                                       RP2040SysCfgUpdateFn update,
>> +                                       void *opaque)
>> +{
>> +    s->update =3D update;
>> +    s->update_opaque =3D opaque;
>> +}
>> +
>> +uint32_t rp2040_syscfg_get_proc0_nmi_mask(RP2040SysCfgState *s)
>> +{
>> +    return s->proc0_nmi_mask;
>> +}
>> +
>> +uint32_t rp2040_syscfg_get_mempowerdown(RP2040SysCfgState *s)
>> +{
>> +    return s->mempowerdown;
>> +}
>> +
>> +static uint64_t rp2040_syscfg_read(void *opaque, hwaddr addr, =
unsigned size)
>> +{
>> +    RP2040SysCfgState *s =3D opaque;
>> +    hwaddr offset =3D addr & 0xfff;
>> +    uint64_t value;
>> +
>> +    switch (offset) {
>> +    case SYSCFG_PROC0_NMI_MASK:
>> +        value =3D s->proc0_nmi_mask;
>> +        break;
>> +    case SYSCFG_PROC1_NMI_MASK:
>> +        value =3D s->proc1_nmi_mask;
>> +        break;
>> +    case SYSCFG_PROC_CONFIG:
>> +        value =3D s->proc_config;
>> +        break;
>> +    case SYSCFG_PROC_IN_SYNC_BYPASS:
>> +        value =3D s->proc_in_sync_bypass;
>> +        break;
>> +    case SYSCFG_PROC_IN_SYNC_BYPASS_HI:
>> +        value =3D s->proc_in_sync_bypass_hi;
>> +        break;
>> +    case SYSCFG_DBGFORCE:
>> +        value =3D s->dbgforce;
>> +        break;
>> +    case SYSCFG_MEMPOWERDOWN:
>> +        value =3D s->mempowerdown;
>> +        break;
>> +    default:
>> +        value =3D 0;
>> +        rp2040_log_unimplemented_read("syscfg", size,
>> +                                      RP2040_SYSCFG_BASE + addr, =
offset,
>> +                                      value);
>> +        break;
>> +    }
>> +
>> +    return value;
>> +}
>> +
>> +static void rp2040_syscfg_write(void *opaque, hwaddr addr,
>> +                                uint64_t value64, unsigned size)
>> +{
>> +    RP2040SysCfgState *s =3D opaque;
>> +    hwaddr alias =3D addr & ATOMIC_ALIAS_MASK;
>> +    hwaddr offset =3D addr & 0xfff;
>> +    uint32_t value =3D value64;
>> +
>> +    switch (offset) {
>> +    case SYSCFG_PROC0_NMI_MASK:
>> +        s->proc0_nmi_mask =3D
>> +            rp2040_syscfg_apply_alias(s->proc0_nmi_mask, value, =
alias);
>> +        rp2040_syscfg_update(s);
>> +        break;
>> +    case SYSCFG_PROC1_NMI_MASK:
>> +        s->proc1_nmi_mask =3D
>> +            rp2040_syscfg_apply_alias(s->proc1_nmi_mask, value, =
alias);
>> +        break;
>> +    case SYSCFG_PROC_CONFIG:
>> +        s->proc_config =3D
>> +            rp2040_syscfg_apply_alias(s->proc_config, value, alias) =
&
>> +            PROC_CONFIG_RW_MASK;
>> +        break;
>> +    case SYSCFG_PROC_IN_SYNC_BYPASS:
>> +        s->proc_in_sync_bypass =3D
>> +            rp2040_syscfg_apply_alias(s->proc_in_sync_bypass, value, =
alias) &
>> +            PROC_IN_SYNC_BYPASS_MASK;
>> +        break;
>> +    case SYSCFG_PROC_IN_SYNC_BYPASS_HI:
>> +        s->proc_in_sync_bypass_hi =3D
>> +            rp2040_syscfg_apply_alias(s->proc_in_sync_bypass_hi, =
value,
>> +                                      alias) &
>> +            PROC_IN_SYNC_BYPASS_HI_MASK;
>> +        break;
>> +    case SYSCFG_DBGFORCE:
>> +        s->dbgforce =3D
>> +            rp2040_syscfg_apply_alias(s->dbgforce, value, alias) &
>> +            DBGFORCE_RW_MASK;
>> +        break;
>> +    case SYSCFG_MEMPOWERDOWN:
>> +        s->mempowerdown =3D
>> +            rp2040_syscfg_apply_alias(s->mempowerdown, value, alias) =
&
>> +            MEMPOWERDOWN_MASK;
>> +        rp2040_syscfg_update(s);
>> +        break;
>> +    default:
>> +        rp2040_log_unimplemented_write("syscfg", size,
>> +                                       RP2040_SYSCFG_BASE + addr, =
offset,
>> +                                       value64);
>> +        break;
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps rp2040_syscfg_ops =3D {
>> +    .read =3D rp2040_syscfg_read,
>> +    .write =3D rp2040_syscfg_write,
>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 4,
>> +        .max_access_size =3D 4,
>> +    },
>> +};
>> +
>> +static void rp2040_syscfg_reset(DeviceState *dev)
>> +{
>> +    RP2040SysCfgState *s =3D RP2040_SYSCFG(dev);
>> +
>> +    s->proc0_nmi_mask =3D 0;
>> +    s->proc1_nmi_mask =3D 0;
>> +    s->proc_config =3D PROC_CONFIG_RESET;
>> +    s->proc_in_sync_bypass =3D 0;
>> +    s->proc_in_sync_bypass_hi =3D 0;
>> +    s->dbgforce =3D DBGFORCE_RESET;
>> +    s->mempowerdown =3D 0;
>> +    rp2040_syscfg_update(s);
>> +}
>> +
>> +static int rp2040_syscfg_post_load(void *opaque, int version_id)
>> +{
>> +    RP2040SysCfgState *s =3D opaque;
>> +
>> +    rp2040_syscfg_update(s);
>> +    return 0;
>> +}
>> +
>> +static void rp2040_syscfg_init(Object *obj)
>> +{
>> +    RP2040SysCfgState *s =3D RP2040_SYSCFG(obj);
>> +
>> +    memory_region_init_io(&s->iomem, obj, &rp2040_syscfg_ops, s,
>> +                          "rp2040.syscfg", RP2040_SYSCFG_SIZE);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
>> +}
>> +
>> +static const VMStateDescription rp2040_syscfg_vmstate =3D {
>> +    .name =3D TYPE_RP2040_SYSCFG,
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .post_load =3D rp2040_syscfg_post_load,
>> +    .fields =3D (const VMStateField[]) {
>> +        VMSTATE_UINT32(proc0_nmi_mask, RP2040SysCfgState),
>> +        VMSTATE_UINT32(proc1_nmi_mask, RP2040SysCfgState),
>> +        VMSTATE_UINT32(proc_config, RP2040SysCfgState),
>> +        VMSTATE_UINT32(proc_in_sync_bypass, RP2040SysCfgState),
>> +        VMSTATE_UINT32(proc_in_sync_bypass_hi, RP2040SysCfgState),
>> +        VMSTATE_UINT32(dbgforce, RP2040SysCfgState),
>> +        VMSTATE_UINT32(mempowerdown, RP2040SysCfgState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void rp2040_syscfg_class_init(ObjectClass *klass, const void =
*data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    device_class_set_legacy_reset(dc, rp2040_syscfg_reset);
>> +    dc->vmsd =3D &rp2040_syscfg_vmstate;
>> +}
>> +
>> +static const TypeInfo rp2040_syscfg_info =3D {
>> +    .name          =3D TYPE_RP2040_SYSCFG,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(RP2040SysCfgState),
>> +    .instance_init =3D rp2040_syscfg_init,
>> +    .class_init    =3D rp2040_syscfg_class_init,
>> +};
>> +
>> +static void rp2040_syscfg_register_types(void)
>> +{
>> +    type_register_static(&rp2040_syscfg_info);
>> +}
>> +type_init(rp2040_syscfg_register_types)
>> diff --git a/hw/misc/rp2040_sysinfo.c b/hw/misc/rp2040_sysinfo.c
>> new file mode 100644
>> index 0000000000..15c50df6af
>> --- /dev/null
>> +++ b/hw/misc/rp2040_sysinfo.c
>> @@ -0,0 +1,103 @@
>> +/*
>> + * RP2040 sysinfo emulation
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/misc/rp2040_nyi.h"
>> +#include "hw/misc/rp2040_sysinfo.h"
>> +#include "migration/vmstate.h"
>> +#include "qemu/log.h"
>> +#include "qemu/module.h"
>> +
>> +#define SYSINFO_CHIP_ID        0x00
>> +#define SYSINFO_PLATFORM       0x04
>> +#define SYSINFO_GITREF_RP2040  0x40
>> +
>> +#define SYSINFO_PLATFORM_ASIC  BIT(1)
>> +
>> +static uint64_t rp2040_sysinfo_read(void *opaque, hwaddr addr, =
unsigned size)
>> +{
>> +    hwaddr offset =3D addr & 0xfff;
>> +    uint64_t value;
>> +
>> +    switch (offset) {
>> +    case SYSINFO_CHIP_ID:
>> +    case SYSINFO_GITREF_RP2040:
>> +        value =3D 0;
>> +        break;
>> +    case SYSINFO_PLATFORM:
>> +        value =3D SYSINFO_PLATFORM_ASIC;
>> +        break;
>> +    default:
>> +        value =3D 0;
>> +        rp2040_log_unimplemented_read("sysinfo", size,
>> +                                      RP2040_SYSINFO_BASE + addr, =
offset,
>> +                                      value);
>> +        break;
>> +    }
>> +
>> +    return value;
>> +}
>> +
>> +static void rp2040_sysinfo_write(void *opaque, hwaddr addr,
>> +                                 uint64_t value, unsigned size)
>> +{
>> +    hwaddr offset =3D addr & 0xfff;
>> +
>> +    qemu_log_mask(LOG_GUEST_ERROR, "rp2040.sysinfo: write to =
read-only "
>> +                  "register (size %d, addr 0x%08" HWADDR_PRIx
>> +                  ", offset 0x%04" HWADDR_PRIx
>> +                  ", value 0x%0*" PRIx64 ")\n",
>> +                  size, RP2040_SYSINFO_BASE + addr, offset, size << =
1, value);
>> +}
>> +
>> +static const MemoryRegionOps rp2040_sysinfo_ops =3D {
>> +    .read =3D rp2040_sysinfo_read,
>> +    .write =3D rp2040_sysinfo_write,
>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 4,
>> +        .max_access_size =3D 4,
>> +    },
>> +};
>> +
>> +static void rp2040_sysinfo_init(Object *obj)
>> +{
>> +    RP2040SysInfoState *s =3D RP2040_SYSINFO(obj);
>> +
>> +    memory_region_init_io(&s->iomem, obj, &rp2040_sysinfo_ops, s,
>> +                          "rp2040.sysinfo", RP2040_SYSINFO_SIZE);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
>> +}
>> +
>> +static const VMStateDescription rp2040_sysinfo_vmstate =3D {
>> +    .name =3D TYPE_RP2040_SYSINFO,
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .fields =3D (const VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void rp2040_sysinfo_class_init(ObjectClass *klass, const void =
*data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->vmsd =3D &rp2040_sysinfo_vmstate;
>> +}
>> +
>> +static const TypeInfo rp2040_sysinfo_info =3D {
>> +    .name          =3D TYPE_RP2040_SYSINFO,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(RP2040SysInfoState),
>> +    .instance_init =3D rp2040_sysinfo_init,
>> +    .class_init    =3D rp2040_sysinfo_class_init,
>> +};
>> +
>> +static void rp2040_sysinfo_register_types(void)
>> +{
>> +    type_register_static(&rp2040_sysinfo_info);
>> +}
>> +type_init(rp2040_sysinfo_register_types)
>> diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
>> index 4e5cd06add..caa1f9127f 100644
>> --- a/include/hw/arm/rp2040.h
>> +++ b/include/hw/arm/rp2040.h
>> @@ -13,6 +13,8 @@
>> #include "hw/char/pl011.h"
>> #include "hw/core/clock.h"
>> #include "hw/core/sysbus.h"
>> +#include "hw/misc/rp2040_syscfg.h"
>> +#include "hw/misc/rp2040_sysinfo.h"
>> #include "qom/object.h"
>>=20
>> #define TYPE_RP2040 "rp2040"
>> @@ -34,12 +36,22 @@ struct RP2040State {
>>=20
>>     ARMv7MState armv7m;
>>     PL011State uart[2];
>> +    RP2040SysCfgState syscfg;
>> +    RP2040SysInfoState sysinfo;
>>=20
>>     MemoryRegion *board_memory;
>>     MemoryRegion rom;
>> +    MemoryRegion rom_poweroff;
>>     MemoryRegion sram[6];
>> +    MemoryRegion sram_poweroff[6];
>>     char *bootrom_file;
>>=20
>> +    qemu_irq *irq;
>> +    qemu_irq cpu_irq[RP2040_NUM_IRQS];
>> +    qemu_irq nmi_irq;
>> +    bool irq_level[RP2040_NUM_IRQS];
>> +    bool mempowerdown_ready;
>> +
>>     Clock *sysclk;
>> };
>>=20
>> diff --git a/include/hw/misc/rp2040_syscfg.h =
b/include/hw/misc/rp2040_syscfg.h
>> new file mode 100644
>> index 0000000000..c31799ae7a
>> --- /dev/null
>> +++ b/include/hw/misc/rp2040_syscfg.h
>> @@ -0,0 +1,42 @@
>> +/*
>> + * RP2040 syscfg emulation
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_MISC_RP2040_SYSCFG_H
>> +#define HW_MISC_RP2040_SYSCFG_H
>> +
>> +#include "hw/core/sysbus.h"
>> +#include "qom/object.h"
>> +
>> +#define TYPE_RP2040_SYSCFG "rp2040-syscfg"
>> +OBJECT_DECLARE_SIMPLE_TYPE(RP2040SysCfgState, RP2040_SYSCFG)
>> +
>> +#define RP2040_SYSCFG_BASE 0x40004000
>> +#define RP2040_SYSCFG_SIZE 0x4000
>> +
>> +typedef void (*RP2040SysCfgUpdateFn)(void *opaque);
>> +
>> +struct RP2040SysCfgState {
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion iomem;
>> +    RP2040SysCfgUpdateFn update;
>> +    void *update_opaque;
>> +    uint32_t proc0_nmi_mask;
>> +    uint32_t proc1_nmi_mask;
>> +    uint32_t proc_config;
>> +    uint32_t proc_in_sync_bypass;
>> +    uint32_t proc_in_sync_bypass_hi;
>> +    uint32_t dbgforce;
>> +    uint32_t mempowerdown;
>> +};
>> +
>> +void rp2040_syscfg_set_update_callback(RP2040SysCfgState *s,
>> +                                       RP2040SysCfgUpdateFn update,
>> +                                       void *opaque);
>> +uint32_t rp2040_syscfg_get_proc0_nmi_mask(RP2040SysCfgState *s);
>> +uint32_t rp2040_syscfg_get_mempowerdown(RP2040SysCfgState *s);
>> +
>> +#endif
>> diff --git a/include/hw/misc/rp2040_sysinfo.h =
b/include/hw/misc/rp2040_sysinfo.h
>> new file mode 100644
>> index 0000000000..d521659488
>> --- /dev/null
>> +++ b/include/hw/misc/rp2040_sysinfo.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + * RP2040 sysinfo emulation
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_MISC_RP2040_SYSINFO_H
>> +#define HW_MISC_RP2040_SYSINFO_H
>> +
>> +#include "hw/core/sysbus.h"
>> +#include "qom/object.h"
>> +
>> +#define TYPE_RP2040_SYSINFO "rp2040-sysinfo"
>> +OBJECT_DECLARE_SIMPLE_TYPE(RP2040SysInfoState, RP2040_SYSINFO)
>> +
>> +#define RP2040_SYSINFO_BASE 0x40000000
>> +#define RP2040_SYSINFO_SIZE 0x4000
>> +
>> +struct RP2040SysInfoState {
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion iomem;
>> +};
>> +
>> +#endif
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 5555ce4eae..692d51a78a 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -255,6 +255,7 @@ qtests_arm =3D \
>>   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? =
['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
>>   (config_all_devices.has_key('CONFIG_VEXPRESS') ? =
['test-arm-mptimer'] : []) + \
>>   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] =
: []) + \
>> +  (config_all_devices.has_key('CONFIG_RASPI_PICO') ? =
['rp2040-sysinfo-syscfg-test'] : []) + \
>>   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? =
qtests_stm32l4x5 : []) + \
>>   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? =
['aspeed_fsi-test'] : []) + \
>>   (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? =
['flexcan-test'] : []) + \
>> diff --git a/tests/qtest/rp2040-sysinfo-syscfg-test.c =
b/tests/qtest/rp2040-sysinfo-syscfg-test.c
>> new file mode 100644
>> index 0000000000..18da6561bd
>> --- /dev/null
>> +++ b/tests/qtest/rp2040-sysinfo-syscfg-test.c
>> @@ -0,0 +1,176 @@
>> +/*
>> + * QTest testcase for the RP2040 sysinfo and syscfg blocks.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +#include "qemu/bitops.h"
>> +
>> +#define SYSINFO_BASE                  0x40000000
>> +#define SYSINFO_CHIP_ID               0x00
>> +#define SYSINFO_PLATFORM              0x04
>> +#define SYSINFO_GITREF_RP2040         0x40
>> +#define SYSINFO_PLATFORM_ASIC         BIT(1)
>> +
>> +#define SYSCFG_BASE                   0x40004000
>> +#define SYSCFG_PROC0_NMI_MASK         0x00
>> +#define SYSCFG_PROC1_NMI_MASK         0x04
>> +#define SYSCFG_PROC_CONFIG            0x08
>> +#define SYSCFG_PROC_IN_SYNC_BYPASS    0x0c
>> +#define SYSCFG_PROC_IN_SYNC_BYPASS_HI 0x10
>> +#define SYSCFG_DBGFORCE               0x14
>> +#define SYSCFG_MEMPOWERDOWN           0x18
>> +
>> +#define SRAM0_BASE                    0x20000000
>> +#define UART0_BASE                    0x40034000
>> +#define UARTDR                        0x00
>> +#define UARTCR                        0x30
>> +#define UARTIMSC                      0x38
>> +#define UARTICR                       0x44
>> +#define UART_INT_TX                   BIT(5)
>> +#define UART0_IRQ                     20
>> +#define NVIC_ISPR                     0xe000e200
>> +#define NVIC_ICPR                     0xe000e280
>> +#define NVIC_ICSR                     0xe000ed04
>> +#define NVIC_ICSR_NMIPENDSET          BIT(31)
>> +
>> +#define PROC_CONFIG_RESET             0x10000000
>> +#define DBGFORCE_RESET                0x00000066
>> +
>> +#define ATOMIC_SET_ALIAS              0x2000
>> +#define ATOMIC_CLR_ALIAS              0x3000
>> +
>> +static QTestState *rp2040_start(void)
>> +{
>> +    return qtest_init("-machine raspi-pico");
>> +}
>> +
>> +static void test_sysinfo_read_values(void)
>> +{
>> +    QTestState *qts =3D rp2040_start();
>> +
>> +    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + =
SYSINFO_CHIP_ID), =3D=3D, 0);
>> +    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + =
SYSINFO_PLATFORM), =3D=3D,
>> +                    SYSINFO_PLATFORM_ASIC);
>> +    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + =
SYSINFO_GITREF_RP2040),
>> +                    =3D=3D, 0);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_syscfg_reset_values(void)
>> +{
>> +    QTestState *qts =3D rp2040_start();
>> +
>> +    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_PROC0_NMI_MASK),
>> +                    =3D=3D, 0);
>> +    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_PROC1_NMI_MASK),
>> +                    =3D=3D, 0);
>> +    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_PROC_CONFIG), =3D=3D,
>> +                    PROC_CONFIG_RESET);
>> +    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_DBGFORCE), =
=3D=3D,
>> +                    DBGFORCE_RESET);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_syscfg_rw_masks(void)
>> +{
>> +    QTestState *qts =3D rp2040_start();
>> +
>> +    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, =
0xa5a5a5a5);
>> +    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC1_NMI_MASK, =
0x5a5a5a5a);
>> +    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_PROC0_NMI_MASK),
>> +                    =3D=3D, 0xa5a5a5a5);
>> +    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_PROC1_NMI_MASK),
>> +                    =3D=3D, 0x5a5a5a5a);
>> +
>> +    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS, =
0xffffffff);
>> +    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS_HI,
>> +                 0xffffffff);
>> +    qtest_writel(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, =
0xffffffff);
>> +    g_assert_cmphex(qtest_readl(qts,
>> +                                SYSCFG_BASE + =
SYSCFG_PROC_IN_SYNC_BYPASS),
>> +                    =3D=3D, 0x3fffffff);
>> +    g_assert_cmphex(qtest_readl(qts,
>> +                                SYSCFG_BASE + =
SYSCFG_PROC_IN_SYNC_BYPASS_HI),
>> +                    =3D=3D, 0x0000003f);
>> +    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_MEMPOWERDOWN), =3D=3D,
>> +                    0x000000ff);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_syscfg_atomic_aliases(void)
>> +{
>> +    QTestState *qts =3D rp2040_start();
>> +
>> +    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, 0);
>> +    qtest_writel(qts, SYSCFG_BASE + ATOMIC_SET_ALIAS + =
SYSCFG_PROC0_NMI_MASK,
>> +                 0x0000000f);
>> +    qtest_writel(qts, SYSCFG_BASE + ATOMIC_CLR_ALIAS + =
SYSCFG_PROC0_NMI_MASK,
>> +                 0x00000003);
>> +    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_PROC0_NMI_MASK),
>> +                    =3D=3D, 0x0000000c);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_syscfg_mempowerdown_blocks_sram(void)
>> +{
>> +    QTestState *qts =3D rp2040_start();
>> +
>> +    qtest_writel(qts, SRAM0_BASE, 0x11223344);
>> +    g_assert_cmphex(qtest_readl(qts, SRAM0_BASE), =3D=3D, =
0x11223344);
>> +
>> +    qtest_writel(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, BIT(0));
>> +    qtest_writel(qts, SRAM0_BASE, 0xaabbccdd);
>> +    qtest_writel(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, 0);
>> +
>> +    g_assert_cmphex(qtest_readl(qts, SRAM0_BASE), =3D=3D, =
0x11223344);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_syscfg_nmi_mask_routes_uart0_irq(void)
>> +{
>> +    QTestState *qts =3D rp2040_start();
>> +
>> +    qtest_writel(qts, UART0_BASE + UARTCR, BIT(0) | BIT(8));
>> +    qtest_writel(qts, UART0_BASE + UARTIMSC, UART_INT_TX);
>> +
>> +    qtest_writel(qts, UART0_BASE + UARTICR, UART_INT_TX);
>> +    qtest_writel(qts, NVIC_ICPR, BIT(UART0_IRQ));
>> +    qtest_writel(qts, UART0_BASE + UARTDR, 'a');
>> +    g_assert_cmphex(qtest_readl(qts, NVIC_ISPR) & BIT(UART0_IRQ), =
=3D=3D,
>> +                    BIT(UART0_IRQ));
>> +
>> +    qtest_writel(qts, UART0_BASE + UARTICR, UART_INT_TX);
>> +    qtest_writel(qts, NVIC_ICPR, BIT(UART0_IRQ));
>> +    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, =
BIT(UART0_IRQ));
>> +    qtest_writel(qts, UART0_BASE + UARTDR, 'b');
>> +    g_assert_cmphex(qtest_readl(qts, NVIC_ISPR) & BIT(UART0_IRQ), =
=3D=3D, 0);
>> +    g_assert_cmphex(qtest_readl(qts, NVIC_ICSR) & =
NVIC_ICSR_NMIPENDSET, =3D=3D,
>> +                    NVIC_ICSR_NMIPENDSET);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +
>> +    qtest_add_func("/rp2040-sysinfo/read-values", =
test_sysinfo_read_values);
>> +    qtest_add_func("/rp2040-syscfg/reset-values", =
test_syscfg_reset_values);
>> +    qtest_add_func("/rp2040-syscfg/rw-masks", test_syscfg_rw_masks);
>> +    qtest_add_func("/rp2040-syscfg/atomic-aliases",
>> +                   test_syscfg_atomic_aliases);
>> +    qtest_add_func("/rp2040-syscfg/mempowerdown-blocks-sram",
>> +                   test_syscfg_mempowerdown_blocks_sram);
>> +    qtest_add_func("/rp2040-syscfg/nmi-mask-routes-uart0-irq",
>> +                   test_syscfg_nmi_mask_routes_uart0_irq);
>> +
>> +    return g_test_run();
>> +}
>=20
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro


--Apple-Mail=_54FC612A-2576-4FBB-AE11-4F6609C24349
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div>Hi =
Alex,</div><div><br></div><div>Thanks for the review. I have looked at =
the impact of these comments, and</div><div>for v3 I propose =
to:</div><div><br></div><div>* split the current patch into two focused =
patches: one for SYSINFO and one</div><div>&nbsp; for =
SYSCFG;</div><div>* remove the powered-off memory overlays. They were =
intended to make CPU</div><div>&nbsp; and DMA accesses fail after =
setting MEMPOWERDOWN, but this goes beyond the</div><div>&nbsp; =
documented register behavior;</div><div>* retain the documented =
MEMPOWERDOWN register state, reset value, and write</div><div>&nbsp; =
mask, without claiming to model physical ROM or SRAM power =
gating;</div><div>* route PROC0_NMI_MASK and PROC1_NMI_MASK =
independently to the corresponding</div><div>&nbsp; core;</div><div>* =
remove the MemoryRegionOps.with_attrs callbacks, since they are =
only</div><div>&nbsp; needed by the powered-off memory =
overlays;</div><div>* remove the per-subsystem RP2040 Kconfig symbols =
and build the internal</div><div>&nbsp; devices under the single =
CONFIG_RP2040 symbol.</div><div><br></div><div>I will add focused qtests =
to the separate SYSINFO and SYSCFG =
patches.</div><div><br></div><div>Does this sound in the right =
direction?</div><div><br></div><div>Thanks,</div><div><div>--<br>Gilles =
Grimaud - 2XS/SISE - CRIStAL/IRCICA -&nbsp;CNRS/Univ. =
Lille&nbsp;&nbsp;</div><div><br></div><br =
class=3D"Apple-interchange-newline">
</div>
<div><br><blockquote type=3D"cite"><div>Le 1 sept. 2026 =C3=A0 20:44, =
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
solid;">From: gilles grimaud &lt;<a =
href=3D"mailto:gilles.grimaud@univ-lille.fr">gilles.grimaud@univ-lille.fr<=
/a>&gt;<br><br>Model the RP2040 identification and system configuration =
registers,<br>including APB atomic aliases and documented reset and =
write masks.<br>Wire SYSCFG into the SoC so NMI masks reroute interrupt =
inputs and<br>MEMPOWERDOWN blocks access to powered-off ROM and SRAM =
banks.<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">What exactly is going to be accessing ROM =
and SRAM while powered off?</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
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
display: inline !important;">Why do all three things need to be done at =
the same time?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
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
solid;">\n\nAdd focused qtests for register values, aliases, power-down =
behavior, and UART0 IRQ routing to NMI.<br><br>Signed-off-by: gilles =
grimaud &lt;gilles.grimaud@univ-lille.fr&gt;<br>---<br>MAINTAINERS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 +<br>hw/arm/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;| &nbsp;&nbsp;2 +<br>hw/arm/rp2040.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;| 129 +++++++++++-<br>hw/misc/Kconfig =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;| &nbsp;&nbsp;6 +<br>hw/misc/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;2 =
+<br>hw/misc/rp2040_syscfg.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| 244 =
+++++++++++++++++++++++<br>hw/misc/rp2040_sysinfo.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;| 103 ++++++++++<br>include/hw/arm/rp2040.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;12 =
++<br>include/hw/misc/rp2040_syscfg.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;42 =
++++<br>include/hw/misc/rp2040_sysinfo.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;25 =
+++<br>tests/qtest/meson.build =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;1 =
+<br>tests/qtest/rp2040-sysinfo-syscfg-test.c | 176 =
++++++++++++++++<br>12 files changed, 740 insertions(+), 3 =
deletions(-)<br>create mode 100644 hw/misc/rp2040_syscfg.c<br>create =
mode 100644 hw/misc/rp2040_sysinfo.c<br>create mode 100644 =
include/hw/misc/rp2040_syscfg.h<br>create mode 100644 =
include/hw/misc/rp2040_sysinfo.h<br>create mode 100644 =
tests/qtest/rp2040-sysinfo-syscfg-test.c<br><br>diff --git a/MAINTAINERS =
b/MAINTAINERS<br>index b000b3287d..fd35521947 100644<br>--- =
a/MAINTAINERS<br>+++ b/MAINTAINERS<br>@@ -1042,6 +1042,7 @@ S: =
Maintained<br>F: hw/*/rp2040*<br>F: include/hw/*/rp2040*<br>F: =
hw/arm/raspi_pico.c<br>+F: tests/qtest/rp2040*<br>F: =
tests/tcg/arm/system/rp2040*<br><br>Real View<br>diff --git =
a/hw/arm/Kconfig b/hw/arm/Kconfig<br>index d93303ab80..5d55ca06fd =
100644<br>--- a/hw/arm/Kconfig<br>+++ b/hw/arm/Kconfig<br>@@ -379,6 =
+379,8 @@ config RP2040<br>&nbsp;&nbsp;&nbsp;&nbsp;select =
ARM_V7M<br>&nbsp;&nbsp;&nbsp;&nbsp;select =
PL011<br>&nbsp;&nbsp;&nbsp;&nbsp;select RP2040_NYI<br>+ =
&nbsp;&nbsp;&nbsp;select RP2040_SYSCFG<br>+ &nbsp;&nbsp;&nbsp;select =
RP2040_SYSINFO<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">I'm not sure we are going to need Kconfig =
vars for every sub-system. If</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">they come with the RP2040 as a piece we =
should only need one symbol to</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">select the board, peripheral and CPU =
models.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;">&nbsp;&nbsp;&nbsp;&nbsp;select UNIMP<br><br>config =
STM32F100_SOC<br>diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c<br>index =
2196bad18d..a184d527e1 100644<br>--- a/hw/arm/rp2040.c<br>+++ =
b/hw/arm/rp2040.c<br>@@ -13,6 +13,7 @@<br>#include =
"hw/core/loader.h"<br>#include "hw/core/qdev-clock.h"<br>#include =
"hw/core/qdev-properties.h"<br>+#include "hw/core/irq.h"<br>#include =
"hw/misc/unimp.h"<br>#include "qemu/datadir.h"<br>#include =
"target/arm/cpu-qom.h"<br>@@ -49,8 +50,6 @@ static const struct =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;hwaddr =
base;<br>&nbsp;&nbsp;&nbsp;&nbsp;hwaddr size;<br>} =
rp2040_unimplemented[] =3D {<br>- &nbsp;&nbsp;&nbsp;{ "rp2040.sysinfo", =
&nbsp;0x40000000, 0x4000 },<br>- &nbsp;&nbsp;&nbsp;{ "rp2040.syscfg", =
&nbsp;&nbsp;0x40004000, 0x4000 },<br>&nbsp;&nbsp;&nbsp;&nbsp;{ =
"rp2040.clocks", &nbsp;&nbsp;0x40008000, 0x4000 =
},<br>&nbsp;&nbsp;&nbsp;&nbsp;{ "rp2040.resets", &nbsp;&nbsp;0x4000c000, =
0x4000 },<br>&nbsp;&nbsp;&nbsp;&nbsp;{ "rp2040.psm", =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x40010000, 0x4000 },<br>@@ -84,6 +83,80 =
@@ static const struct {<br>&nbsp;&nbsp;&nbsp;&nbsp;{ "rp2040.sio", =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0xd0000000, 0x1000 },<br>};<br><br>+static =
MemTxResult rp2040_powered_off_read(void *opaque, hwaddr addr,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t *data, unsigned size,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MemTxAttrs attrs)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;*data =3D 0;<br>+ &nbsp;&nbsp;&nbsp;return =
MEMTX_ERROR;<br>+}<br>+<br>+static MemTxResult =
rp2040_powered_off_write(void *opaque, hwaddr addr,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t data, unsigned size,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MemTxAttrs attrs)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;return MEMTX_ERROR;<br>+}<br>+<br>+static const =
MemoryRegionOps rp2040_powered_off_ops =3D {<br>+ =
&nbsp;&nbsp;&nbsp;.read_with_attrs =3D rp2040_powered_off_read,<br>+ =
&nbsp;&nbsp;&nbsp;.write_with_attrs =3D =
rp2040_powered_off_write,<br></blockquote><br style=3D"caret-color: =
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
display: inline !important;">You choose to have _with_attrs access =
functions here but not later. Why?<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
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
&nbsp;&nbsp;&nbsp;.endianness =3D DEVICE_LITTLE_ENDIAN,<br>+ =
&nbsp;&nbsp;&nbsp;.valid =3D {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.min_access_size =3D 1,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.max_access_size =3D 4,<br>+ =
&nbsp;&nbsp;&nbsp;},<br>+};<br>+<br>+static void =
rp2040_update_mempowerdown(RP2040State *s)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;uint32_t mempowerdown;<br>+ &nbsp;&nbsp;&nbsp;int =
i;<br>+<br>+ &nbsp;&nbsp;&nbsp;if (!s-&gt;mempowerdown_ready) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;mempowerdown =3D =
rp2040_syscfg_get_mempowerdown(&amp;s-&gt;syscfg);<br>+ =
&nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; ARRAY_SIZE(s-&gt;sram_poweroff); =
i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memory_region_set_enabled(&amp;s=
-&gt;sram_poweroff[i],<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mempowerdown &amp; =
BIT(i));<br>+ &nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_set_enabled(&amp;s-&gt;rom_poweroff, =
mempowerdown &amp; BIT(7));<br>+}<br>+<br>+static void =
rp2040_update_nmi(RP2040State *s)<br>+{<br>+ &nbsp;&nbsp;&nbsp;uint32_t =
nmi_mask =3D rp2040_syscfg_get_proc0_nmi_mask(&amp;s-&gt;syscfg);<br>+ =
&nbsp;&nbsp;&nbsp;bool nmi_level =3D false;<br>+ &nbsp;&nbsp;&nbsp;int =
i;<br>+<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; RP2040_NUM_IRQS; =
i++) {<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bool route_to_nmi =
=3D nmi_mask &amp; BIT(i);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu_set_irq(s-&gt;cpu_irq[i], =
s-&gt;irq_level[i] &amp;&amp; !route_to_nmi);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nmi_level |=3D =
s-&gt;irq_level[i] &amp;&amp; route_to_nmi;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;qemu_set_irq(s-&gt;nmi_irq, =
nmi_level);<br>+}<br>+<br>+static void rp2040_syscfg_update(void =
*opaque)<br>+{<br>+ &nbsp;&nbsp;&nbsp;RP2040State *s =3D =
opaque;<br>+<br>+ &nbsp;&nbsp;&nbsp;rp2040_update_mempowerdown(s);<br>+ =
&nbsp;&nbsp;&nbsp;rp2040_update_nmi(s);<br>+}<br>+<br>+static void =
rp2040_set_irq(void *opaque, int irq, int level)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;RP2040State *s =3D opaque;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;assert(irq &gt;=3D 0 &amp;&amp; irq &lt; =
RP2040_NUM_IRQS);<br>+ &nbsp;&nbsp;&nbsp;s-&gt;irq_level[irq] =3D =
level;<br>+ &nbsp;&nbsp;&nbsp;rp2040_update_nmi(s);<br>+}<br>+<br>static =
void rp2040_soc_init(Object =
*obj)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;RP2040State *s =3D =
RP2040(obj);<br>@@ -104,6 +177,10 @@ static void rp2040_soc_init(Object =
*obj)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"chardev"=
);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>+ =
&nbsp;&nbsp;&nbsp;object_initialize_child(obj, "syscfg", =
&amp;s-&gt;syscfg, TYPE_RP2040_SYSCFG);<br>+ =
&nbsp;&nbsp;&nbsp;object_initialize_child(obj, "sysinfo", =
&amp;s-&gt;sysinfo, TYPE_RP2040_SYSINFO);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;irq =3D qemu_allocate_irqs(rp2040_set_irq, s, =
RP2040_NUM_IRQS);<br>&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;sysclk =3D =
clock_new(obj, =
"sysclk");<br>&nbsp;&nbsp;&nbsp;&nbsp;clock_set_hz(s-&gt;sysclk, =
RP2040_SYSCLK_FRQ);<br>}<br>@@ -117,9 +194,17 @@ static bool =
rp2040_init_memory(RP2040State *s, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
false;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;memory_regi=
on_add_subregion(s-&gt;board_memory, RP2040_ROM_BASE, =
&amp;s-&gt;rom);<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_init_io(&amp;s-&gt;rom_poweroff, =
OBJECT(s),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&amp;rp2040_powered_off_ops, s,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;"rp2040.rom.poweroff", RP2040_ROM_SIZE);<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_add_subregion_overlap(s-&gt;board_memory, =
RP2040_ROM_BASE,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&amp;s-&gt;rom_poweroff, 1);<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_set_enabled(&amp;s-&gt;rom_poweroff, =
false);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; 4; i++) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_autofree char =
*name =3D g_strdup_printf("rp2040.sram%d", i);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_autofree char *poweroff_name =
=3D<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_strdup=
_printf("rp2040.sram%d.poweroff", =
i);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(!memory_region_init_ram(&amp;s-&gt;sram[i], OBJECT(s), =
name,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;RP2040_SRAM_BANK_SIZE, errp)) {<br>@@ -129,6 +214,14 @@ static bool =
rp2040_init_memory(RP2040State *s, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;RP2040_SRAM_BASE =
+<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i=
 * =
RP2040_SRAM_BANK_SIZE,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&amp;s-&gt;sram[i]);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memory_region_init_io(&amp;s-&gt=
;sram_poweroff[i], OBJECT(s),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&amp;rp2040_powered_off_ops, s, =
poweroff_name,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;RP2040_SRAM_BANK_SIZE);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memory_region_add_subregion_over=
lap(s-&gt;board_memory,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RP2040_SRAM_BASE +<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i * RP2040_SRAM_BANK_SIZE,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;s-&gt;sram_poweroff[i], =
1);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memory_region_set_enabled(&amp;s=
-&gt;sram_poweroff[i], =
false);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if =
(!memory_region_init_ram(&amp;s-&gt;sram[4], OBJECT(s), =
"rp2040.sram4",<br>@@ -137,6 +230,12 @@ static bool =
rp2040_init_memory(RP2040State *s, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;memory_reg=
ion_add_subregion(s-&gt;board_memory, =
RP2040_SRAM4_BASE,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;s-&=
gt;sram[4]);<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_init_io(&amp;s-&gt;sram_poweroff[4], =
OBJECT(s),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&amp;rp2040_powered_off_ops, s,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;"rp2040.sram4.poweroff", RP2040_SRAM_HI_SIZE);<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_add_subregion_overlap(s-&gt;board_memory, =
RP2040_SRAM4_BASE,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&amp;s-&gt;sram_poweroff[4], 1);<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_set_enabled(&amp;s-&gt;sram_poweroff[4], =
false);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;if =
(!memory_region_init_ram(&amp;s-&gt;sram[5], OBJECT(s), =
"rp2040.sram5",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RP2040_SRAM=
_HI_SIZE, errp)) {<br>@@ -144,6 +243,14 @@ static bool =
rp2040_init_memory(RP2040State *s, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;memory_reg=
ion_add_subregion(s-&gt;board_memory, =
RP2040_SRAM5_BASE,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&amp;s-&=
gt;sram[5]);<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_init_io(&amp;s-&gt;sram_poweroff[5], =
OBJECT(s),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&amp;rp2040_powered_off_ops, s,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;"rp2040.sram5.poweroff", RP2040_SRAM_HI_SIZE);<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_add_subregion_overlap(s-&gt;board_memory, =
RP2040_SRAM5_BASE,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&amp;s-&gt;sram_poweroff[5], 1);<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_set_enabled(&amp;s-&gt;sram_poweroff[5], =
false);<br>+<br>+ &nbsp;&nbsp;&nbsp;s-&gt;mempowerdown_ready =3D =
true;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;return true;<br>}<br>@@ -201,6 =
+308,22 @@ static void rp2040_soc_realize(DeviceState *dev, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;&nbsp;if =
(!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;armv7m), errp)) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>&nbsp;&nbs=
p;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;for (i =3D 0; i &lt; =
RP2040_NUM_IRQS; i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;cpu_irq[i] =3D =
qdev_get_gpio_in(DEVICE(&amp;s-&gt;armv7m), i);<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;s-&gt;nmi_irq =3D =
qdev_get_gpio_in_named(DEVICE(&amp;s-&gt;armv7m), "NMI", 0);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;syscfg), =
errp)) {<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;syscfg), 0, =
RP2040_SYSCFG_BASE);<br>+ =
&nbsp;&nbsp;&nbsp;rp2040_syscfg_set_update_callback(&amp;s-&gt;syscfg, =
rp2040_syscfg_update, s);<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;sysinfo), errp)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sysinfo), 0, =
RP2040_SYSINFO_BASE);<br>+ =
&nbsp;&nbsp;&nbsp;rp2040_syscfg_update(s);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;=
for (i =3D 0; i &lt; ARRAY_SIZE(s-&gt;uart); i++) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qdev_connect_clock_in=
(DEVICE(&amp;s-&gt;uart[i]), "clk", s-&gt;sysclk);<br>@@ -209,7 +332,7 =
@@ static void rp2040_soc_realize(DeviceState *dev, Error =
**errp)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sysbus_mmio_map(SYS_BUS_DEVICE(&amp;=
s-&gt;uart[i]), 0, =
uart_base[i]);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sysbus_c=
onnect_irq(SYS_BUS_DEVICE(&amp;s-&gt;uart[i]), 0,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;qdev_get_gpio_in(DEVICE(&amp;s-&gt;armv7m), uart_irq[i]));<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;s-&gt;irq[uart_irq[i]]);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>}<br><br>=
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig<br>index =
de7a0f56fa..f6f344ab51 100644<br>--- a/hw/misc/Kconfig<br>+++ =
b/hw/misc/Kconfig<br>@@ -104,6 +104,12 @@ config =
FSL_IMX8MP_CCM<br>config =
RP2040_NYI<br>&nbsp;&nbsp;&nbsp;&nbsp;bool<br><br>+config =
RP2040_SYSCFG<br>+ &nbsp;&nbsp;&nbsp;bool<br>+<br>+config =
RP2040_SYSINFO<br>+ &nbsp;&nbsp;&nbsp;bool<br>+<br>config =
STM32_RCC<br>&nbsp;&nbsp;&nbsp;&nbsp;bool<br><br>diff --git =
a/hw/misc/meson.build b/hw/misc/meson.build<br>index =
8611d59437..7be9f45c78 100644<br>--- a/hw/misc/meson.build<br>+++ =
b/hw/misc/meson.build<br>@@ -99,6 +99,8 @@ system_ss.add(when: =
'CONFIG_RASPI', if_true: =
files(<br>&nbsp;&nbsp;'bcm2835_powermgt.c',<br>))<br>system_ss.add(when: =
'CONFIG_RP2040_NYI', if_true: =
files('rp2040_nyi.c'))<br>+system_ss.add(when: 'CONFIG_RP2040_SYSCFG', =
if_true: files('rp2040_syscfg.c'))<br>+system_ss.add(when: =
'CONFIG_RP2040_SYSINFO', if_true: =
files('rp2040_sysinfo.c'))<br>system_ss.add(when: 'CONFIG_SLAVIO', =
if_true: files('slavio_misc.c'))<br>system_ss.add(when: 'CONFIG_ZYNQ', =
if_true: files('zynq_slcr.c'))<br>system_ss.add(when: =
'CONFIG_XLNX_ZYNQ_DDRC', if_true: files('xlnx-zynq-ddrc.c'))<br>diff =
--git a/hw/misc/rp2040_syscfg.c b/hw/misc/rp2040_syscfg.c<br>new file =
mode 100644<br>index 0000000000..69b4164ccd<br>--- /dev/null<br>+++ =
b/hw/misc/rp2040_syscfg.c<br>@@ -0,0 +1,244 @@<br>+/*<br>+ * RP2040 =
syscfg emulation<br>+ *<br>+ * SPDX-License-Identifier: =
GPL-2.0-or-later<br>+ */<br>+<br>+#include "qemu/osdep.h"<br>+#include =
"hw/misc/rp2040_nyi.h"<br>+#include =
"hw/misc/rp2040_syscfg.h"<br>+#include =
"migration/vmstate.h"<br>+#include "qemu/module.h"<br>+<br>+#define =
SYSCFG_PROC0_NMI_MASK =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00<br>+#define =
SYSCFG_PROC1_NMI_MASK =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x04<br>+#define =
SYSCFG_PROC_CONFIG =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x=
08<br>+#define SYSCFG_PROC_IN_SYNC_BYPASS =
&nbsp;&nbsp;&nbsp;&nbsp;0x0c<br>+#define SYSCFG_PROC_IN_SYNC_BYPASS_HI =
&nbsp;0x10<br>+#define SYSCFG_DBGFORCE =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;0x14<br>+#define SYSCFG_MEMPOWERDOWN =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x18<br>=
+<br>+#define PROC_CONFIG_RW_MASK =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0xff0000=
00<br>+#define PROC_CONFIG_RESET =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;0x10000000<br>+#define PROC_IN_SYNC_BYPASS_MASK =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x3fffffff<br>+#define =
PROC_IN_SYNC_BYPASS_HI_MASK &nbsp;&nbsp;&nbsp;0x0000003f<br>+#define =
DBGFORCE_RW_MASK =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;0x000000ee<br>+#define DBGFORCE_RESET =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;0x00000066<br>+#define MEMPOWERDOWN_MASK =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;0x000000ff<br>+<br>+#define ATOMIC_ALIAS_MASK =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;0x3000<br>+#define ATOMIC_XOR =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x1000<br>+#define =
ATOMIC_SET =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x2000<br>+#define =
ATOMIC_CLR =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x3000<br>+<br>+static =
uint32_t rp2040_syscfg_apply_alias(uint32_t old, uint32_t value,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;hwaddr alias)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;switch (alias) {<br>+ &nbsp;&nbsp;&nbsp;case =
ATOMIC_XOR:<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return old ^ =
value;<br>+ &nbsp;&nbsp;&nbsp;case ATOMIC_SET:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return old | value;<br>+ =
&nbsp;&nbsp;&nbsp;case ATOMIC_CLR:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return old &amp; ~value;<br>+ =
&nbsp;&nbsp;&nbsp;default:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return value;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static void =
rp2040_syscfg_update(RP2040SysCfgState *s)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;if (s-&gt;update) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;update(s-&gt;update_opaque=
);<br>+ &nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+void =
rp2040_syscfg_set_update_callback(RP2040SysCfgState *s,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;RP2040SysCfgUpdateFn update,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;void *opaque)<br>+{<br>+ &nbsp;&nbsp;&nbsp;s-&gt;update =3D =
update;<br>+ &nbsp;&nbsp;&nbsp;s-&gt;update_opaque =3D =
opaque;<br>+}<br>+<br>+uint32_t =
rp2040_syscfg_get_proc0_nmi_mask(RP2040SysCfgState *s)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;return s-&gt;proc0_nmi_mask;<br>+}<br>+<br>+uint32_t =
rp2040_syscfg_get_mempowerdown(RP2040SysCfgState *s)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;return s-&gt;mempowerdown;<br>+}<br>+<br>+static =
uint64_t rp2040_syscfg_read(void *opaque, hwaddr addr, unsigned =
size)<br>+{<br>+ &nbsp;&nbsp;&nbsp;RP2040SysCfgState *s =3D opaque;<br>+ =
&nbsp;&nbsp;&nbsp;hwaddr offset =3D addr &amp; 0xfff;<br>+ =
&nbsp;&nbsp;&nbsp;uint64_t value;<br>+<br>+ &nbsp;&nbsp;&nbsp;switch =
(offset) {<br>+ &nbsp;&nbsp;&nbsp;case SYSCFG_PROC0_NMI_MASK:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;value =3D =
s-&gt;proc0_nmi_mask;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_PROC1_NMI_MASK:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;value =3D =
s-&gt;proc1_nmi_mask;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_PROC_CONFIG:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;value =3D =
s-&gt;proc_config;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_PROC_IN_SYNC_BYPASS:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;value =3D =
s-&gt;proc_in_sync_bypass;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_PROC_IN_SYNC_BYPASS_HI:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;value =3D =
s-&gt;proc_in_sync_bypass_hi;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_DBGFORCE:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;value =3D s-&gt;dbgforce;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_MEMPOWERDOWN:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;value =3D =
s-&gt;mempowerdown;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;default:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;value =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_log_unimplemented_read("s=
yscfg", size,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
RP2040_SYSCFG_BASE + addr, offset,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
value);<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;return =
value;<br>+}<br>+<br>+static void rp2040_syscfg_write(void *opaque, =
hwaddr addr,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t value64, unsigned =
size)<br>+{<br>+ &nbsp;&nbsp;&nbsp;RP2040SysCfgState *s =3D opaque;<br>+ =
&nbsp;&nbsp;&nbsp;hwaddr alias =3D addr &amp; ATOMIC_ALIAS_MASK;<br>+ =
&nbsp;&nbsp;&nbsp;hwaddr offset =3D addr &amp; 0xfff;<br>+ =
&nbsp;&nbsp;&nbsp;uint32_t value =3D value64;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;switch (offset) {<br>+ &nbsp;&nbsp;&nbsp;case =
SYSCFG_PROC0_NMI_MASK:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;proc0_nmi_mask =3D<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_s=
yscfg_apply_alias(s-&gt;proc0_nmi_mask, value, alias);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_syscfg_update(s);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_PROC1_NMI_MASK:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;proc1_nmi_mask =3D<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_s=
yscfg_apply_alias(s-&gt;proc1_nmi_mask, value, alias);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_PROC_CONFIG:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;proc_config =3D<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_s=
yscfg_apply_alias(s-&gt;proc_config, value, alias) &amp;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PROC_CON=
FIG_RW_MASK;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_PROC_IN_SYNC_BYPASS:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;proc_in_sync_bypass =
=3D<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_s=
yscfg_apply_alias(s-&gt;proc_in_sync_bypass, value, alias) &amp;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PROC_IN_=
SYNC_BYPASS_MASK;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_PROC_IN_SYNC_BYPASS_HI:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;proc_in_sync_bypass_hi =
=3D<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_s=
yscfg_apply_alias(s-&gt;proc_in_sync_bypass_hi, value,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
alias) &amp;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PROC_IN_=
SYNC_BYPASS_HI_MASK;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_DBGFORCE:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;dbgforce =3D<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_s=
yscfg_apply_alias(s-&gt;dbgforce, value, alias) &amp;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DBGFORCE=
_RW_MASK;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSCFG_MEMPOWERDOWN:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;mempowerdown =3D<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_s=
yscfg_apply_alias(s-&gt;mempowerdown, value, alias) &amp;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MEMPOWER=
DOWN_MASK;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_syscfg_update(s);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;default:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_log_unimplemented_write("=
syscfg", size,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;RP2040_SYSCFG_BASE + addr, offset,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;value64);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static const MemoryRegionOps =
rp2040_syscfg_ops =3D {<br>+ &nbsp;&nbsp;&nbsp;.read =3D =
rp2040_syscfg_read,<br>+ &nbsp;&nbsp;&nbsp;.write =3D =
rp2040_syscfg_write,<br>+ &nbsp;&nbsp;&nbsp;.endianness =3D =
DEVICE_LITTLE_ENDIAN,<br>+ &nbsp;&nbsp;&nbsp;.valid =3D {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.min_access_size =3D 4,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.max_access_size =3D 4,<br>+ =
&nbsp;&nbsp;&nbsp;},<br>+};<br>+<br>+static void =
rp2040_syscfg_reset(DeviceState *dev)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;RP2040SysCfgState *s =3D RP2040_SYSCFG(dev);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;proc0_nmi_mask =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;proc1_nmi_mask =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;proc_config =3D PROC_CONFIG_RESET;<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;proc_in_sync_bypass =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;proc_in_sync_bypass_hi =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;dbgforce =3D DBGFORCE_RESET;<br>+ =
&nbsp;&nbsp;&nbsp;s-&gt;mempowerdown =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;rp2040_syscfg_update(s);<br>+}<br>+<br>+static int =
rp2040_syscfg_post_load(void *opaque, int version_id)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;RP2040SysCfgState *s =3D opaque;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;rp2040_syscfg_update(s);<br>+ &nbsp;&nbsp;&nbsp;return =
0;<br>+}<br>+<br>+static void rp2040_syscfg_init(Object *obj)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;RP2040SysCfgState *s =3D RP2040_SYSCFG(obj);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_init_io(&amp;s-&gt;iomem, obj, =
&amp;rp2040_syscfg_ops, s,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;"rp2040.syscfg", RP2040_SYSCFG_SIZE);<br>+ =
&nbsp;&nbsp;&nbsp;sysbus_init_mmio(SYS_BUS_DEVICE(obj), =
&amp;s-&gt;iomem);<br>+}<br>+<br>+static const VMStateDescription =
rp2040_syscfg_vmstate =3D {<br>+ &nbsp;&nbsp;&nbsp;.name =3D =
TYPE_RP2040_SYSCFG,<br>+ &nbsp;&nbsp;&nbsp;.version_id =3D 1,<br>+ =
&nbsp;&nbsp;&nbsp;.minimum_version_id =3D 1,<br>+ =
&nbsp;&nbsp;&nbsp;.post_load =3D rp2040_syscfg_post_load,<br>+ =
&nbsp;&nbsp;&nbsp;.fields =3D (const VMStateField[]) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VMSTATE_UINT32(proc0_nmi_mask, =
RP2040SysCfgState),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VMSTATE_UINT32(proc1_nmi_mask, =
RP2040SysCfgState),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VMSTATE_UINT32(proc_config, =
RP2040SysCfgState),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VMSTATE_UINT32(proc_in_sync_bypa=
ss, RP2040SysCfgState),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VMSTATE_UINT32(proc_in_sync_bypa=
ss_hi, RP2040SysCfgState),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VMSTATE_UINT32(dbgforce, =
RP2040SysCfgState),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VMSTATE_UINT32(mempowerdown, =
RP2040SysCfgState),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VMSTATE_END_OF_LIST()<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+};<br>+<br>+static void =
rp2040_syscfg_class_init(ObjectClass *klass, const void =
*data)<br>+{<br>+ &nbsp;&nbsp;&nbsp;DeviceClass *dc =3D =
DEVICE_CLASS(klass);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;device_class_set_legacy_reset(dc, =
rp2040_syscfg_reset);<br>+ &nbsp;&nbsp;&nbsp;dc-&gt;vmsd =3D =
&amp;rp2040_syscfg_vmstate;<br>+}<br>+<br>+static const TypeInfo =
rp2040_syscfg_info =3D {<br>+ &nbsp;&nbsp;&nbsp;.name =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D =
TYPE_RP2040_SYSCFG,<br>+ &nbsp;&nbsp;&nbsp;.parent =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D TYPE_SYS_BUS_DEVICE,<br>+ =
&nbsp;&nbsp;&nbsp;.instance_size =3D sizeof(RP2040SysCfgState),<br>+ =
&nbsp;&nbsp;&nbsp;.instance_init =3D rp2040_syscfg_init,<br>+ =
&nbsp;&nbsp;&nbsp;.class_init &nbsp;&nbsp;&nbsp;=3D =
rp2040_syscfg_class_init,<br>+};<br>+<br>+static void =
rp2040_syscfg_register_types(void)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;type_register_static(&amp;rp2040_syscfg_info);<br>+}<br>=
+type_init(rp2040_syscfg_register_types)<br>diff --git =
a/hw/misc/rp2040_sysinfo.c b/hw/misc/rp2040_sysinfo.c<br>new file mode =
100644<br>index 0000000000..15c50df6af<br>--- /dev/null<br>+++ =
b/hw/misc/rp2040_sysinfo.c<br>@@ -0,0 +1,103 @@<br>+/*<br>+ * RP2040 =
sysinfo emulation<br>+ *<br>+ * SPDX-License-Identifier: =
GPL-2.0-or-later<br>+ */<br>+<br>+#include "qemu/osdep.h"<br>+#include =
"hw/misc/rp2040_nyi.h"<br>+#include =
"hw/misc/rp2040_sysinfo.h"<br>+#include =
"migration/vmstate.h"<br>+#include "qemu/log.h"<br>+#include =
"qemu/module.h"<br>+<br>+#define SYSINFO_CHIP_ID =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00<br>+#define =
SYSINFO_PLATFORM &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x04<br>+#define =
SYSINFO_GITREF_RP2040 &nbsp;0x40<br>+<br>+#define SYSINFO_PLATFORM_ASIC =
&nbsp;BIT(1)<br>+<br>+static uint64_t rp2040_sysinfo_read(void *opaque, =
hwaddr addr, unsigned size)<br>+{<br>+ &nbsp;&nbsp;&nbsp;hwaddr offset =3D=
 addr &amp; 0xfff;<br>+ &nbsp;&nbsp;&nbsp;uint64_t value;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;switch (offset) {<br>+ &nbsp;&nbsp;&nbsp;case =
SYSINFO_CHIP_ID:<br>+ &nbsp;&nbsp;&nbsp;case SYSINFO_GITREF_RP2040:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;value =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case SYSINFO_PLATFORM:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;value =3D =
SYSINFO_PLATFORM_ASIC;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;default:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;value =3D 0;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rp2040_log_unimplemented_read("s=
ysinfo", size,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
RP2040_SYSINFO_BASE + addr, offset,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
value);<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+<br>+ &nbsp;&nbsp;&nbsp;return =
value;<br>+}<br>+<br>+static void rp2040_sysinfo_write(void *opaque, =
hwaddr addr,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t value, unsigned =
size)<br>+{<br>+ &nbsp;&nbsp;&nbsp;hwaddr offset =3D addr &amp; =
0xfff;<br>+<br>+ &nbsp;&nbsp;&nbsp;qemu_log_mask(LOG_GUEST_ERROR, =
"rp2040.sysinfo: write to read-only "<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;"register (size %d, addr 0x%08" =
HWADDR_PRIx<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;", offset 0x%04" HWADDR_PRIx<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;", value 0x%0*" PRIx64 ")\n",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;size, RP2040_SYSINFO_BASE + addr, offset, =
size &lt;&lt; 1, value);<br>+}<br>+<br>+static const MemoryRegionOps =
rp2040_sysinfo_ops =3D {<br>+ &nbsp;&nbsp;&nbsp;.read =3D =
rp2040_sysinfo_read,<br>+ &nbsp;&nbsp;&nbsp;.write =3D =
rp2040_sysinfo_write,<br>+ &nbsp;&nbsp;&nbsp;.endianness =3D =
DEVICE_LITTLE_ENDIAN,<br>+ &nbsp;&nbsp;&nbsp;.valid =3D {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.min_access_size =3D 4,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.max_access_size =3D 4,<br>+ =
&nbsp;&nbsp;&nbsp;},<br>+};<br>+<br>+static void =
rp2040_sysinfo_init(Object *obj)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;RP2040SysInfoState *s =3D =
RP2040_SYSINFO(obj);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;memory_region_init_io(&amp;s-&gt;iomem, obj, =
&amp;rp2040_sysinfo_ops, s,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;"rp2040.sysinfo", RP2040_SYSINFO_SIZE);<br>+ =
&nbsp;&nbsp;&nbsp;sysbus_init_mmio(SYS_BUS_DEVICE(obj), =
&amp;s-&gt;iomem);<br>+}<br>+<br>+static const VMStateDescription =
rp2040_sysinfo_vmstate =3D {<br>+ &nbsp;&nbsp;&nbsp;.name =3D =
TYPE_RP2040_SYSINFO,<br>+ &nbsp;&nbsp;&nbsp;.version_id =3D 1,<br>+ =
&nbsp;&nbsp;&nbsp;.minimum_version_id =3D 1,<br>+ =
&nbsp;&nbsp;&nbsp;.fields =3D (const VMStateField[]) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VMSTATE_END_OF_LIST()<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+};<br>+<br>+static void =
rp2040_sysinfo_class_init(ObjectClass *klass, const void =
*data)<br>+{<br>+ &nbsp;&nbsp;&nbsp;DeviceClass *dc =3D =
DEVICE_CLASS(klass);<br>+<br>+ &nbsp;&nbsp;&nbsp;dc-&gt;vmsd =3D =
&amp;rp2040_sysinfo_vmstate;<br>+}<br>+<br>+static const TypeInfo =
rp2040_sysinfo_info =3D {<br>+ &nbsp;&nbsp;&nbsp;.name =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D =
TYPE_RP2040_SYSINFO,<br>+ &nbsp;&nbsp;&nbsp;.parent =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D TYPE_SYS_BUS_DEVICE,<br>+ =
&nbsp;&nbsp;&nbsp;.instance_size =3D sizeof(RP2040SysInfoState),<br>+ =
&nbsp;&nbsp;&nbsp;.instance_init =3D rp2040_sysinfo_init,<br>+ =
&nbsp;&nbsp;&nbsp;.class_init &nbsp;&nbsp;&nbsp;=3D =
rp2040_sysinfo_class_init,<br>+};<br>+<br>+static void =
rp2040_sysinfo_register_types(void)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;type_register_static(&amp;rp2040_sysinfo_info);<br>+}<br=
>+type_init(rp2040_sysinfo_register_types)<br>diff --git =
a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h<br>index =
4e5cd06add..caa1f9127f 100644<br>--- a/include/hw/arm/rp2040.h<br>+++ =
b/include/hw/arm/rp2040.h<br>@@ -13,6 +13,8 @@<br>#include =
"hw/char/pl011.h"<br>#include "hw/core/clock.h"<br>#include =
"hw/core/sysbus.h"<br>+#include "hw/misc/rp2040_syscfg.h"<br>+#include =
"hw/misc/rp2040_sysinfo.h"<br>#include "qom/object.h"<br><br>#define =
TYPE_RP2040 "rp2040"<br>@@ -34,12 +36,22 @@ struct RP2040State =
{<br><br>&nbsp;&nbsp;&nbsp;&nbsp;ARMv7MState =
armv7m;<br>&nbsp;&nbsp;&nbsp;&nbsp;PL011State uart[2];<br>+ =
&nbsp;&nbsp;&nbsp;RP2040SysCfgState syscfg;<br>+ =
&nbsp;&nbsp;&nbsp;RP2040SysInfoState =
sysinfo;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;MemoryRegion =
*board_memory;<br>&nbsp;&nbsp;&nbsp;&nbsp;MemoryRegion rom;<br>+ =
&nbsp;&nbsp;&nbsp;MemoryRegion =
rom_poweroff;<br>&nbsp;&nbsp;&nbsp;&nbsp;MemoryRegion sram[6];<br>+ =
&nbsp;&nbsp;&nbsp;MemoryRegion =
sram_poweroff[6];<br>&nbsp;&nbsp;&nbsp;&nbsp;char =
*bootrom_file;<br><br>+ &nbsp;&nbsp;&nbsp;qemu_irq *irq;<br>+ =
&nbsp;&nbsp;&nbsp;qemu_irq cpu_irq[RP2040_NUM_IRQS];<br>+ =
&nbsp;&nbsp;&nbsp;qemu_irq nmi_irq;<br>+ &nbsp;&nbsp;&nbsp;bool =
irq_level[RP2040_NUM_IRQS];<br>+ &nbsp;&nbsp;&nbsp;bool =
mempowerdown_ready;<br>+<br>&nbsp;&nbsp;&nbsp;&nbsp;Clock =
*sysclk;<br>};<br><br>diff --git a/include/hw/misc/rp2040_syscfg.h =
b/include/hw/misc/rp2040_syscfg.h<br>new file mode 100644<br>index =
0000000000..c31799ae7a<br>--- /dev/null<br>+++ =
b/include/hw/misc/rp2040_syscfg.h<br>@@ -0,0 +1,42 @@<br>+/*<br>+ * =
RP2040 syscfg emulation<br>+ *<br>+ * SPDX-License-Identifier: =
GPL-2.0-or-later<br>+ */<br>+<br>+#ifndef =
HW_MISC_RP2040_SYSCFG_H<br>+#define =
HW_MISC_RP2040_SYSCFG_H<br>+<br>+#include =
"hw/core/sysbus.h"<br>+#include "qom/object.h"<br>+<br>+#define =
TYPE_RP2040_SYSCFG =
"rp2040-syscfg"<br>+OBJECT_DECLARE_SIMPLE_TYPE(RP2040SysCfgState, =
RP2040_SYSCFG)<br>+<br>+#define RP2040_SYSCFG_BASE =
0x40004000<br>+#define RP2040_SYSCFG_SIZE 0x4000<br>+<br>+typedef void =
(*RP2040SysCfgUpdateFn)(void *opaque);<br>+<br>+struct RP2040SysCfgState =
{<br>+ &nbsp;&nbsp;&nbsp;SysBusDevice parent_obj;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;MemoryRegion iomem;<br>+ =
&nbsp;&nbsp;&nbsp;RP2040SysCfgUpdateFn update;<br>+ =
&nbsp;&nbsp;&nbsp;void *update_opaque;<br>+ &nbsp;&nbsp;&nbsp;uint32_t =
proc0_nmi_mask;<br>+ &nbsp;&nbsp;&nbsp;uint32_t proc1_nmi_mask;<br>+ =
&nbsp;&nbsp;&nbsp;uint32_t proc_config;<br>+ &nbsp;&nbsp;&nbsp;uint32_t =
proc_in_sync_bypass;<br>+ &nbsp;&nbsp;&nbsp;uint32_t =
proc_in_sync_bypass_hi;<br>+ &nbsp;&nbsp;&nbsp;uint32_t dbgforce;<br>+ =
&nbsp;&nbsp;&nbsp;uint32_t mempowerdown;<br>+};<br>+<br>+void =
rp2040_syscfg_set_update_callback(RP2040SysCfgState *s,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;RP2040SysCfgUpdateFn update,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;void *opaque);<br>+uint32_t =
rp2040_syscfg_get_proc0_nmi_mask(RP2040SysCfgState *s);<br>+uint32_t =
rp2040_syscfg_get_mempowerdown(RP2040SysCfgState =
*s);<br>+<br>+#endif<br>diff --git a/include/hw/misc/rp2040_sysinfo.h =
b/include/hw/misc/rp2040_sysinfo.h<br>new file mode 100644<br>index =
0000000000..d521659488<br>--- /dev/null<br>+++ =
b/include/hw/misc/rp2040_sysinfo.h<br>@@ -0,0 +1,25 @@<br>+/*<br>+ * =
RP2040 sysinfo emulation<br>+ *<br>+ * SPDX-License-Identifier: =
GPL-2.0-or-later<br>+ */<br>+<br>+#ifndef =
HW_MISC_RP2040_SYSINFO_H<br>+#define =
HW_MISC_RP2040_SYSINFO_H<br>+<br>+#include =
"hw/core/sysbus.h"<br>+#include "qom/object.h"<br>+<br>+#define =
TYPE_RP2040_SYSINFO =
"rp2040-sysinfo"<br>+OBJECT_DECLARE_SIMPLE_TYPE(RP2040SysInfoState, =
RP2040_SYSINFO)<br>+<br>+#define RP2040_SYSINFO_BASE =
0x40000000<br>+#define RP2040_SYSINFO_SIZE 0x4000<br>+<br>+struct =
RP2040SysInfoState {<br>+ &nbsp;&nbsp;&nbsp;SysBusDevice =
parent_obj;<br>+<br>+ &nbsp;&nbsp;&nbsp;MemoryRegion =
iomem;<br>+};<br>+<br>+#endif<br>diff --git a/tests/qtest/meson.build =
b/tests/qtest/meson.build<br>index 5555ce4eae..692d51a78a 100644<br>--- =
a/tests/qtest/meson.build<br>+++ b/tests/qtest/meson.build<br>@@ -255,6 =
+255,7 @@ qtests_arm =3D =
\<br>&nbsp;&nbsp;(config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? =
['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + =
\<br>&nbsp;&nbsp;(config_all_devices.has_key('CONFIG_VEXPRESS') ? =
['test-arm-mptimer'] : []) + =
\<br>&nbsp;&nbsp;(config_all_devices.has_key('CONFIG_MICROBIT') ? =
['microbit-test'] : []) + \<br>+ =
&nbsp;(config_all_devices.has_key('CONFIG_RASPI_PICO') ? =
['rp2040-sysinfo-syscfg-test'] : []) + =
\<br>&nbsp;&nbsp;(config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? =
qtests_stm32l4x5 : []) + =
\<br>&nbsp;&nbsp;(config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') =
? ['aspeed_fsi-test'] : []) + =
\<br>&nbsp;&nbsp;(config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? =
['flexcan-test'] : []) + \<br>diff --git =
a/tests/qtest/rp2040-sysinfo-syscfg-test.c =
b/tests/qtest/rp2040-sysinfo-syscfg-test.c<br>new file mode =
100644<br>index 0000000000..18da6561bd<br>--- /dev/null<br>+++ =
b/tests/qtest/rp2040-sysinfo-syscfg-test.c<br>@@ -0,0 +1,176 =
@@<br>+/*<br>+ * QTest testcase for the RP2040 sysinfo and syscfg =
blocks.<br>+ *<br>+ * SPDX-License-Identifier: GPL-2.0-or-later<br>+ =
*/<br>+<br>+#include "qemu/osdep.h"<br>+#include =
"libqtest.h"<br>+#include "qemu/bitops.h"<br>+<br>+#define SYSINFO_BASE =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;0x40000000<br>+#define SYSINFO_CHIP_ID =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;0x00<br>+#define SYSINFO_PLATFORM =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;0x04<br>+#define SYSINFO_GITREF_RP2040 =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x40<br>+#define =
SYSINFO_PLATFORM_ASIC =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BIT(1)<br>+<br>+#define =
SYSCFG_BASE =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x40004000<br>+#define =
SYSCFG_PROC0_NMI_MASK =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00<br>+#define =
SYSCFG_PROC1_NMI_MASK =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x04<br>+#define =
SYSCFG_PROC_CONFIG =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x08<br>=
+#define SYSCFG_PROC_IN_SYNC_BYPASS &nbsp;&nbsp;&nbsp;0x0c<br>+#define =
SYSCFG_PROC_IN_SYNC_BYPASS_HI 0x10<br>+#define SYSCFG_DBGFORCE =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;0x14<br>+#define SYSCFG_MEMPOWERDOWN =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x18<br>+<br>+=
#define SRAM0_BASE =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x20000000<br>+#define =
UART0_BASE =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x40034000<br>+#define UARTDR =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00<br>+#=
define UARTCR =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x30<br>+#=
define UARTIMSC =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x38<br>+#define =
UARTICR =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x44<br>+#define=
 UART_INT_TX =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BIT(5)<br>+#define UART0_IRQ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;20<br>+#define NVIC_ISPR =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0xe000e200<br>+#define =
NVIC_ICPR =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0xe000e280<br>+#define =
NVIC_ICSR =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0xe000ed04<br>+#define =
NVIC_ICSR_NMIPENDSET =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BIT(31)<br>+<br>+#de=
fine PROC_CONFIG_RESET =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x=
10000000<br>+#define DBGFORCE_RESET =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;0x00000066<br>+<br>+#define ATOMIC_SET_ALIAS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;0x2000<br>+#define ATOMIC_CLR_ALIAS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;0x3000<br>+<br>+static QTestState *rp2040_start(void)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;return qtest_init("-machine =
raspi-pico");<br>+}<br>+<br>+static void =
test_sysinfo_read_values(void)<br>+{<br>+ &nbsp;&nbsp;&nbsp;QTestState =
*qts =3D rp2040_start();<br>+<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + =
SYSINFO_CHIP_ID), =3D=3D, 0);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + =
SYSINFO_PLATFORM), =3D=3D,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SYSINFO_PLATFORM_ASIC);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + =
SYSINFO_GITREF_RP2040),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=3D, 0);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qtest_quit(qts);<br>+}<br>+<br>+static void =
test_syscfg_reset_values(void)<br>+{<br>+ &nbsp;&nbsp;&nbsp;QTestState =
*qts =3D rp2040_start();<br>+<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_PROC0_NMI_MASK),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=3D, 0);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_PROC1_NMI_MASK),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=3D, 0);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_PROC_CONFIG), =3D=3D,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PROC_CONFIG_RESET);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_DBGFORCE), =3D=3D,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DBGFORCE_RESET);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qtest_quit(qts);<br>+}<br>+<br>+static void =
test_syscfg_rw_masks(void)<br>+{<br>+ &nbsp;&nbsp;&nbsp;QTestState *qts =
=3D rp2040_start();<br>+<br>+ &nbsp;&nbsp;&nbsp;qtest_writel(qts, =
SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, 0xa5a5a5a5);<br>+ =
&nbsp;&nbsp;&nbsp;qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC1_NMI_MASK, =
0x5a5a5a5a);<br>+ &nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, =
SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=3D, 0xa5a5a5a5);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_PROC1_NMI_MASK),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=3D, 0x5a5a5a5a);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qtest_writel(qts, SYSCFG_BASE + =
SYSCFG_PROC_IN_SYNC_BYPASS, 0xffffffff);<br>+ =
&nbsp;&nbsp;&nbsp;qtest_writel(qts, SYSCFG_BASE + =
SYSCFG_PROC_IN_SYNC_BYPASS_HI,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;0xffffffff);<br>+ =
&nbsp;&nbsp;&nbsp;qtest_writel(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, =
0xffffffff);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SYSCFG_BASE + =
SYSCFG_PROC_IN_SYNC_BYPASS),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=3D, 0x3fffffff);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SYSCFG_BASE + =
SYSCFG_PROC_IN_SYNC_BYPASS_HI),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=3D, 0x0000003f);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_MEMPOWERDOWN), =3D=3D,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x000000ff);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qtest_quit(qts);<br>+}<br>+<br>+static void =
test_syscfg_atomic_aliases(void)<br>+{<br>+ &nbsp;&nbsp;&nbsp;QTestState =
*qts =3D rp2040_start();<br>+<br>+ &nbsp;&nbsp;&nbsp;qtest_writel(qts, =
SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, 0);<br>+ =
&nbsp;&nbsp;&nbsp;qtest_writel(qts, SYSCFG_BASE + ATOMIC_SET_ALIAS + =
SYSCFG_PROC0_NMI_MASK,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;0x0000000f);<br>+ =
&nbsp;&nbsp;&nbsp;qtest_writel(qts, SYSCFG_BASE + ATOMIC_CLR_ALIAS + =
SYSCFG_PROC0_NMI_MASK,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;0x00000003);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + =
SYSCFG_PROC0_NMI_MASK),<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=3D, 0x0000000c);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qtest_quit(qts);<br>+}<br>+<br>+static void =
test_syscfg_mempowerdown_blocks_sram(void)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;QTestState *qts =3D rp2040_start();<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qtest_writel(qts, SRAM0_BASE, 0x11223344);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SRAM0_BASE), =3D=3D, =
0x11223344);<br>+<br>+ &nbsp;&nbsp;&nbsp;qtest_writel(qts, SYSCFG_BASE + =
SYSCFG_MEMPOWERDOWN, BIT(0));<br>+ &nbsp;&nbsp;&nbsp;qtest_writel(qts, =
SRAM0_BASE, 0xaabbccdd);<br>+ &nbsp;&nbsp;&nbsp;qtest_writel(qts, =
SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, 0);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, SRAM0_BASE), =3D=3D, =
0x11223344);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qtest_quit(qts);<br>+}<br>+<br>+static void =
test_syscfg_nmi_mask_routes_uart0_irq(void)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;QTestState *qts =3D rp2040_start();<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qtest_writel(qts, UART0_BASE + UARTCR, BIT(0) | =
BIT(8));<br>+ &nbsp;&nbsp;&nbsp;qtest_writel(qts, UART0_BASE + UARTIMSC, =
UART_INT_TX);<br>+<br>+ &nbsp;&nbsp;&nbsp;qtest_writel(qts, UART0_BASE + =
UARTICR, UART_INT_TX);<br>+ &nbsp;&nbsp;&nbsp;qtest_writel(qts, =
NVIC_ICPR, BIT(UART0_IRQ));<br>+ &nbsp;&nbsp;&nbsp;qtest_writel(qts, =
UART0_BASE + UARTDR, 'a');<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, NVIC_ISPR) &amp; =
BIT(UART0_IRQ), =3D=3D,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BIT(UART0_IRQ));<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qtest_writel(qts, UART0_BASE + UARTICR, =
UART_INT_TX);<br>+ &nbsp;&nbsp;&nbsp;qtest_writel(qts, NVIC_ICPR, =
BIT(UART0_IRQ));<br>+ &nbsp;&nbsp;&nbsp;qtest_writel(qts, SYSCFG_BASE + =
SYSCFG_PROC0_NMI_MASK, BIT(UART0_IRQ));<br>+ =
&nbsp;&nbsp;&nbsp;qtest_writel(qts, UART0_BASE + UARTDR, 'b');<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, NVIC_ISPR) &amp; =
BIT(UART0_IRQ), =3D=3D, 0);<br>+ =
&nbsp;&nbsp;&nbsp;g_assert_cmphex(qtest_readl(qts, NVIC_ICSR) &amp; =
NVIC_ICSR_NMIPENDSET, =3D=3D,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NVIC_ICSR_NMIPENDSET);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qtest_quit(qts);<br>+}<br>+<br>+int main(int argc, =
char **argv)<br>+{<br>+ &nbsp;&nbsp;&nbsp;g_test_init(&amp;argc, =
&amp;argv, NULL);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;qtest_add_func("/rp2040-sysinfo/read-values", =
test_sysinfo_read_values);<br>+ =
&nbsp;&nbsp;&nbsp;qtest_add_func("/rp2040-syscfg/reset-values", =
test_syscfg_reset_values);<br>+ =
&nbsp;&nbsp;&nbsp;qtest_add_func("/rp2040-syscfg/rw-masks", =
test_syscfg_rw_masks);<br>+ =
&nbsp;&nbsp;&nbsp;qtest_add_func("/rp2040-syscfg/atomic-aliases",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;test_syscfg_atomic_aliases);<br>+ =
&nbsp;&nbsp;&nbsp;qtest_add_func("/rp2040-syscfg/mempowerdown-blocks-sram"=
,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;test_syscfg_mempowerdown_blocks_sram);<b=
r>+ =
&nbsp;&nbsp;&nbsp;qtest_add_func("/rp2040-syscfg/nmi-mask-routes-uart0-irq=
",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;test_syscfg_nmi_mask_routes_uart0_irq);<=
br>+<br>+ &nbsp;&nbsp;&nbsp;return =
g_test_run();<br>+}<br></blockquote><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
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

--Apple-Mail=_54FC612A-2576-4FBB-AE11-4F6609C24349--

