Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8165C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 04:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnWxG-0006zF-Fg; Fri, 22 Mar 2024 00:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWxB-0006wq-Ta; Fri, 22 Mar 2024 00:56:31 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWx6-0005UT-R7; Fri, 22 Mar 2024 00:56:29 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4d42d18c683so588659e0c.1; 
 Thu, 21 Mar 2024 21:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711083383; x=1711688183; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGB8t6nczIXGKcKcn0WDMBDFI5atnCDLb1B+vLkp/w8=;
 b=HQC0fxvWTDPwOm9VVi5yRRziVvS+/E94grAFNdZ07Q+ZvbyS3HcPiHSI48boBI/xlV
 h1d8113ir4WBFUVY8YcWeCVIYoJjl3FbLNHAk+U6XIOPP+UPk4dmCX0JOE2XHCIw0EDe
 195EMMhaGJfnMFx7NKhSyc1+nVL5XhYzwEaPF14SRe77sCgowIxEiSbFkRwtPw7V/2pI
 tZzol2jWGyleg2PpNwLNjAwgMMmD5BT0ehNlOU8zsNHpq6S4NQLvBdiufYZGLzKxZ+Tt
 2Pt3uTjW04B/Cs/06tZApgvb6BArRWFBCMC8Y5Mk3/yE6WshB+cKKBZK/2kY7h8HQNm9
 4FmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711083383; x=1711688183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGB8t6nczIXGKcKcn0WDMBDFI5atnCDLb1B+vLkp/w8=;
 b=QNwWH6d8SPyc2F9yehOEEy5nME1MQ8GC2T7SEHaJ6K2/5Wsrn/8zi8jRCiFdB+3b1R
 ECeO84ZRebXuklw3b2fJqnfuRRXXIpoFUgvmuBPvF3I7P1pAeCcMeDdCdMf/AG4Ee48+
 bssO5E/REVcMf6StpSjRFW/jEfnm9MjXc0KIk2dA0qGayJ/xOPP8fIEgIHBlwE6unTdQ
 e/NPq5l84Io6FImOiuGNirwdYyktc8LG+nSJ7ESmwULJDqhTt+e1Tvf4geteERZWxAqC
 CL+BiZSbiJW7Rqnm7ciqyfbBjqrUHmUgM2KLkcZkyZ90aydjsbTj+rJ0kxFerbJKVaTd
 uhUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR9RgN/YiwGdE4HQf0ejCkq1ty6B8B+cxiKcdstleUjSTg63H2vyT+kjwVj0iddWJx5Gvzp14sPFwPCrkimttZWs0w2lJ6uhA8l1JF2mwXQiM/3qadQ6UIJLTlwg==
X-Gm-Message-State: AOJu0Ywd7O+HEbeTfdfzlPxeFTAUu7xCWZt2ua7UN7dbZTDFdLlXipTC
 vCgBqoIagjg4gxlQ9m5JSdvwy/BULEA0fg/TNpDeWuV/P+tq0VW0h3+qVbXMyo6iEDJm9IfxVmO
 U0AIpD1gw+kshXvTDNdVFPNfo1IFeHyfbMneWzQ==
X-Google-Smtp-Source: AGHT+IF6v4CEcMaqzSqT4sZQTrVD5NNvXkYqZbp/k7Ocpy05q6I1FBywQpbZ3Dih/JYRajI1eb4Brxtz2VXoggF5Fc4=
X-Received: by 2002:a05:6122:2010:b0:4d4:6136:a3da with SMTP id
 l16-20020a056122201000b004d46136a3damr1689692vkd.2.1711083383254; Thu, 21 Mar
 2024 21:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240312135222.3187945-1-fei2.wu@intel.com>
 <20240312135222.3187945-3-fei2.wu@intel.com>
In-Reply-To: <20240312135222.3187945-3-fei2.wu@intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 14:55:56 +1000
Message-ID: <CAKmqyKN-Yj-HZrR2MtxD2jC=JR6nFn5cEq866EXm0OfaEydXsQ@mail.gmail.com>
Subject: Re: [RFC v2 2/2] hw/riscv: Add server platform reference machine
To: Fei Wu <fei2.wu@intel.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com, 
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com, 
 yin.wang@intel.com, tech-server-platform@lists.riscv.org, 
 tech-server-soc@lists.riscv.org, atishp@rivosinc.com, ajones@ventanamicro.com, 
 conor@kernel.org, heinrich.schuchardt@canonical.com, 
 marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Mar 12, 2024 at 11:55=E2=80=AFPM Fei Wu <fei2.wu@intel.com> wrote:
>
> The RISC-V Server Platform specification[1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
>
> A corresponding Qemu RISC-V server platform reference (rvsp-ref for
> short) machine type is added to provide a environment for firmware/OS
> development and testing. The main features included in rvsp-ref are:
>
>  - Based on riscv virt machine type
>  - A new memory map as close as virt machine as possible
>  - A new virt CPU type rvsp-ref-cpu for server platform compliance
>  - AIA
>  - PCIe AHCI
>  - PCIe NIC
>  - No virtio device
>  - No fw_cfg device
>  - No ACPI table provided
>  - Only minimal device tree nodes
>
> [1] https://github.com/riscv-non-isa/riscv-server-platform
>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>  configs/devices/riscv64-softmmu/default.mak |    1 +
>  hw/riscv/Kconfig                            |   12 +
>  hw/riscv/meson.build                        |    1 +
>  hw/riscv/server_platform_ref.c              | 1276 +++++++++++++++++++
>  4 files changed, 1290 insertions(+)
>  create mode 100644 hw/riscv/server_platform_ref.c
>
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/device=
s/riscv64-softmmu/default.mak
> index 3f68059448..a1d98e49ef 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -10,5 +10,6 @@ CONFIG_SPIKE=3Dy
>  CONFIG_SIFIVE_E=3Dy
>  CONFIG_SIFIVE_U=3Dy
>  CONFIG_RISCV_VIRT=3Dy
> +CONFIG_SERVER_PLATFORM_REF=3Dy
>  CONFIG_MICROCHIP_PFSOC=3Dy
>  CONFIG_SHAKTI_C=3Dy
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 5d644eb7b1..5674589e66 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -48,6 +48,18 @@ config RISCV_VIRT
>      select ACPI
>      select ACPI_PCI
>
> +config SERVER_PLATFORM_REF
> +    bool
> +    select RISCV_NUMA
> +    select GOLDFISH_RTC
> +    select PCI
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PFLASH_CFI01
> +    select SERIAL
> +    select RISCV_ACLINT
> +    select RISCV_APLIC
> +    select RISCV_IMSIC
> +
>  config SHAKTI_C
>      bool
>      select RISCV_ACLINT
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 2f7ee81be3..bb3aff91ea 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('n=
uma.c'))
>  riscv_ss.add(files('riscv_hart.c'))
>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> +riscv_ss.add(when: 'CONFIG_SERVER_PLATFORM_REF', if_true: files('server_=
platform_ref.c'))
>  riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_re=
f.c
> new file mode 100644
> index 0000000000..b552650265
> --- /dev/null
> +++ b/hw/riscv/server_platform_ref.c
> @@ -0,0 +1,1276 @@
> +/*
> + * QEMU RISC-V Server Platform (RVSP) Reference Board
> + *
> + * Copyright (c) 2024 Intel, Inc.
> + *
> + * This board is compliant RISC-V Server platform specification and leve=
raging
> + * a lot of riscv virt code.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "qemu/guest-random.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/char/serial.h"
> +#include "hw/block/flash.h"
> +#include "hw/ide/pci.h"
> +#include "hw/ide/ahci-pci.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/core/sysbus-fdt.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/riscv/numa.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/intc/riscv_aplic.h"
> +#include "hw/intc/riscv_imsic.h"
> +#include "chardev/char.h"
> +#include "sysemu/device_tree.h"
> +#include "sysemu/runstate.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/tcg.h"
> +#include "target/riscv/cpu.h"
> +#include "target/riscv/pmu.h"
> +#include "net/net.h"
> +
> +#define RVSP_CPUS_MAX_BITS             9
> +#define RVSP_CPUS_MAX                  (1 << RVSP_CPUS_MAX_BITS)
> +#define RVSP_SOCKETS_MAX_BITS          2
> +#define RVSP_SOCKETS_MAX               (1 << RVSP_SOCKETS_MAX_BITS)
> +
> +#define RVSP_IRQCHIP_NUM_MSIS 255
> +#define RVSP_IRQCHIP_NUM_SOURCES 96
> +#define RVSP_IRQCHIP_NUM_PRIO_BITS 3
> +#define RVSP_IRQCHIP_MAX_GUESTS_BITS 3
> +#define RVSP_IRQCHIP_MAX_GUESTS ((1U << RVSP_IRQCHIP_MAX_GUESTS_BITS) - =
1U)
> +
> +#define FDT_PCI_ADDR_CELLS    3
> +#define FDT_PCI_INT_CELLS     1
> +#define FDT_APLIC_INT_CELLS   2
> +#define FDT_IMSIC_INT_CELLS   0
> +#define FDT_MAX_INT_CELLS     2
> +#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + =
\
> +                                 1 + FDT_MAX_INT_CELLS)
> +#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS =
+ \
> +                                 1 + FDT_APLIC_INT_CELLS)
> +
> +#define NUM_SATA_PORTS  6
> +
> +#define SYSCON_RESET     0x1
> +#define SYSCON_POWEROFF  0x2
> +
> +#define TYPE_RVSP_REF_MACHINE MACHINE_TYPE_NAME("rvsp-ref")
> +OBJECT_DECLARE_SIMPLE_TYPE(RVSPMachineState, RVSP_REF_MACHINE)
> +
> +struct RVSPMachineState {
> +    /*< private >*/
> +    MachineState parent;
> +
> +    /*< public >*/
> +    Notifier machine_done;
> +    RISCVHartArrayState soc[RVSP_SOCKETS_MAX];
> +    DeviceState *irqchip[RVSP_SOCKETS_MAX];
> +    PFlashCFI01 *flash[2];
> +
> +    int fdt_size;
> +    int aia_guests;
> +    const MemMapEntry *memmap;
> +};
> +
> +enum {
> +    RVSP_DEBUG,
> +    RVSP_MROM,
> +    RVSP_RESET_SYSCON,
> +    RVSP_RTC,
> +    RVSP_ACLINT,
> +    RVSP_APLIC_M,
> +    RVSP_APLIC_S,
> +    RVSP_UART0,
> +    RVSP_IMSIC_M,
> +    RVSP_IMSIC_S,
> +    RVSP_FLASH,
> +    RVSP_DRAM,
> +    RVSP_PCIE_MMIO,
> +    RVSP_PCIE_PIO,
> +    RVSP_PCIE_ECAM,
> +    RVSP_PCIE_MMIO_HIGH
> +};
> +
> +enum {
> +    RVSP_UART0_IRQ =3D 10,
> +    RVSP_RTC_IRQ =3D 11,
> +    RVSP_PCIE_IRQ =3D 0x20, /* 32 to 35 */
> +};
> +
> +/*
> + * The server soc reference machine physical address space used by some =
of the
> + * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, n=
umber
> + * of CPUs, and number of IMSIC guest files.
> + *
> + * Various limits defined by RVSP_SOCKETS_MAX_BITS, RVSP_CPUS_MAX_BITS, =
and
> + * RVSP_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization of ser=
ver soc
> + * reference machine physical address space.
> + */
> +
> +#define RVSP_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT=
)
> +#if RVSP_IMSIC_GROUP_MAX_SIZE < \
> +    IMSIC_GROUP_SIZE(RVSP_CPUS_MAX_BITS, RVSP_IRQCHIP_MAX_GUESTS_BITS)
> +#error "Can't accomodate single IMSIC group in address space"
> +#endif
> +
> +#define RVSP_IMSIC_MAX_SIZE            (RVSP_SOCKETS_MAX * \
> +                                        RVSP_IMSIC_GROUP_MAX_SIZE)
> +#if 0x4000000 < RVSP_IMSIC_MAX_SIZE
> +#error "Can't accomodate all IMSIC groups in address space"
> +#endif
> +
> +static const MemMapEntry rvsp_ref_memmap[] =3D {
> +    [RVSP_DEBUG] =3D          {        0x0,         0x100 },
> +    [RVSP_MROM] =3D           {     0x1000,        0xf000 },
> +    [RVSP_RESET_SYSCON] =3D   {   0x100000,        0x1000 },
> +    [RVSP_RTC] =3D            {   0x101000,        0x1000 },
> +    [RVSP_ACLINT] =3D         {  0x2000000,       0x10000 },
> +    [RVSP_PCIE_PIO] =3D       {  0x3000000,       0x10000 },
> +    [RVSP_APLIC_M] =3D        {  0xc000000, APLIC_SIZE(RVSP_CPUS_MAX) },
> +    [RVSP_APLIC_S] =3D        {  0xd000000, APLIC_SIZE(RVSP_CPUS_MAX) },
> +    [RVSP_UART0] =3D          { 0x10000000,         0x100 },
> +    [RVSP_FLASH] =3D          { 0x20000000,     0x4000000 },
> +    [RVSP_IMSIC_M] =3D        { 0x24000000, RVSP_IMSIC_MAX_SIZE },
> +    [RVSP_IMSIC_S] =3D        { 0x28000000, RVSP_IMSIC_MAX_SIZE },
> +    [RVSP_PCIE_ECAM] =3D      { 0x30000000,    0x10000000 },
> +    [RVSP_PCIE_MMIO] =3D      { 0x40000000,    0x40000000 },
> +    [RVSP_DRAM] =3D           { 0x80000000, 0xff80000000ull },
> +    [RVSP_PCIE_MMIO_HIGH] =3D { 0x10000000000ull, 0x10000000000ull },
> +};
> +
> +#define RVSP_FLASH_SECTOR_SIZE (256 * KiB)
> +
> +static PFlashCFI01 *rvsp_flash_create(RVSPMachineState *s,
> +                                      const char *name,
> +                                      const char *alias_prop_name)
> +{
> +    /*
> +     * Create a single flash device.  We use the same parameters as
> +     * the flash devices on the ARM virt board.
> +     */
> +    DeviceState *dev =3D qdev_new(TYPE_PFLASH_CFI01);
> +
> +    qdev_prop_set_uint64(dev, "sector-length", RVSP_FLASH_SECTOR_SIZE);
> +    qdev_prop_set_uint8(dev, "width", 4);
> +    qdev_prop_set_uint8(dev, "device-width", 2);
> +    qdev_prop_set_bit(dev, "big-endian", false);
> +    qdev_prop_set_uint16(dev, "id0", 0x89);
> +    qdev_prop_set_uint16(dev, "id1", 0x18);
> +    qdev_prop_set_uint16(dev, "id2", 0x00);
> +    qdev_prop_set_uint16(dev, "id3", 0x00);
> +    qdev_prop_set_string(dev, "name", name);
> +
> +    object_property_add_child(OBJECT(s), name, OBJECT(dev));
> +    object_property_add_alias(OBJECT(s), alias_prop_name,
> +                              OBJECT(dev), "drive");
> +
> +    return PFLASH_CFI01(dev);
> +}
> +
> +static void rvsp_flash_map(PFlashCFI01 *flash,
> +                           hwaddr base, hwaddr size,
> +                           MemoryRegion *sysmem)
> +{
> +    DeviceState *dev =3D DEVICE(flash);
> +
> +    assert(QEMU_IS_ALIGNED(size, RVSP_FLASH_SECTOR_SIZE));
> +    assert(size / RVSP_FLASH_SECTOR_SIZE <=3D UINT32_MAX);
> +    qdev_prop_set_uint32(dev, "num-blocks", size / RVSP_FLASH_SECTOR_SIZ=
E);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    memory_region_add_subregion(sysmem, base,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(de=
v),
> +                                                       0));
> +}
> +
> +static void rvsp_flash_maps(RVSPMachineState *s,
> +                            MemoryRegion *sysmem)
> +{
> +    hwaddr flashsize =3D rvsp_ref_memmap[RVSP_FLASH].size / 2;
> +    hwaddr flashbase =3D rvsp_ref_memmap[RVSP_FLASH].base;
> +
> +    rvsp_flash_map(s->flash[0], flashbase, flashsize, sysmem);
> +    rvsp_flash_map(s->flash[1], flashbase + flashsize, flashsize, sysmem=
);
> +}
> +
> +static void create_pcie_irq_map(RVSPMachineState *s, void *fdt, char *no=
dename,
> +                                uint32_t irqchip_phandle)
> +{
> +    int pin, dev;
> +    uint32_t irq_map_stride =3D 0;
> +    uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> +                          FDT_MAX_INT_MAP_WIDTH] =3D {};
> +    uint32_t *irq_map =3D full_irq_map;
> +
> +    /*
> +     * This code creates a standard swizzle of interrupts such that
> +     * each device's first interrupt is based on it's PCI_SLOT number.
> +     * (See pci_swizzle_map_irq_fn())
> +     *
> +     * We only need one entry per interrupt in the table (not one per
> +     * possible slot) seeing the interrupt-map-mask will allow the table
> +     * to wrap to any number of devices.
> +     */
> +    for (dev =3D 0; dev < GPEX_NUM_IRQS; dev++) {
> +        int devfn =3D dev * 0x8;
> +
> +        for (pin =3D 0; pin < GPEX_NUM_IRQS; pin++) {
> +            int irq_nr =3D RVSP_PCIE_IRQ +
> +                         ((pin + PCI_SLOT(devfn)) % GPEX_NUM_IRQS);
> +            int i =3D 0;
> +
> +            /* Fill PCI address cells */
> +            irq_map[i] =3D cpu_to_be32(devfn << 8);
> +            i +=3D FDT_PCI_ADDR_CELLS;
> +
> +            /* Fill PCI Interrupt cells */
> +            irq_map[i] =3D cpu_to_be32(pin + 1);
> +            i +=3D FDT_PCI_INT_CELLS;
> +
> +            /* Fill interrupt controller phandle and cells */
> +            irq_map[i++] =3D cpu_to_be32(irqchip_phandle);
> +            irq_map[i++] =3D cpu_to_be32(irq_nr);
> +            irq_map[i++] =3D cpu_to_be32(0x4);
> +
> +            if (!irq_map_stride) {
> +                irq_map_stride =3D i;
> +            }
> +            irq_map +=3D irq_map_stride;
> +        }
> +    }
> +
> +    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
> +                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> +                     irq_map_stride * sizeof(uint32_t));
> +
> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
> +                           0x1800, 0, 0, 0x7);
> +}
> +
> +static void create_fdt_socket_cpus(RVSPMachineState *s, int socket,

I see no mention of device trees in the spec, but I do see ACPI. Do we
really expect a server platform to use DTs?

These functions should be shared with the virt machine if we really do
want DTs, but I'm not convinced we do

Alistair

