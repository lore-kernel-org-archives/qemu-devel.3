Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E448CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 02:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ0Jz-00083s-AR; Tue, 11 Nov 2025 21:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ0Jx-00082N-6X
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 21:10:53 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ0Ju-0006Oq-0y
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 21:10:52 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b731b176b5eso67414666b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 18:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762913448; x=1763518248; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAZDnZ1Ii+N9iedkxl9WRFhwFHY61e+LRhP0ah92aOc=;
 b=e3E37/R8EK+gGKxeQzMWZCC+yvVG+/H31A4CKgAWm19jpCBoWvGboGqFCLhT56XwXE
 kA2+DXBslDMN9MLRUdhV3zDAJPw+27pczY+repZmdNFuJ4QnIFeCnRXNdfOaCDxxCSSk
 5sZF5W5r0wXuSG101uNGF2fsKrLGNFsNYfqX/UaXqaCnKF1HK7WfsdtrX28H/3dUUWVk
 JeQMf9GxUwURwfmtFb0++P+2HClU93ruFsaH1NdFM7i0gpY4TI2uHhrqsqTT49Cg0wzl
 FeT+VWudJyiHRhxKlXutM46P2cC7umH62qGAvkTeRUHTUyYpWfIMVU1IBzOvQKdlqdXq
 +emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762913448; x=1763518248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kAZDnZ1Ii+N9iedkxl9WRFhwFHY61e+LRhP0ah92aOc=;
 b=KcWB+8pEjKBJlqwlQuGYSW6fZohcNU1ulNdv5sSex2QXw6F/Tv1x5AwdLKJT4Gr4f/
 Ue2LPrMrUVBmBh/MD6rxZJa56K+T4dBs3YW/dsNv8pmYEWMqDf4y1GQiIaBIO7xbFG3z
 sAFCuN9+Agoy+rpoJ9nV7wTAWVWXgNyCgcXIx3lVAA1Ue9eWPPLnssLw3+vtirmZtOSU
 hakgvgcVOLaPHX+AkB2D4X5D5aoT/TxJgB4s0C/8yCm0st8xq7O2kP+YOUzc2OCU5BWK
 7Qa+gDsxRT8StoCB4pL+J7FmB4GjKKdXy3MA52w2ng2jjWDYl8yjNkZS4zxyYP7JNRXD
 N9Zw==
X-Gm-Message-State: AOJu0Ywq+urw4jsFKGFdBUIPCVSVo0KlcnJaZNNBjNBpQ1pEKwI5erVU
 y6Rck40a/y83/J0Adn9IkCgFXFjmVPCl/oHDcRcUQfWYALcksUyIsf+GX0+IzRz4UEeMnmcsra9
 KOR2o51vgO/S8i6n1fT3Ieu+5weT4tzI=
X-Gm-Gg: ASbGncsI/xhu1wSmuA75O1LDQiOEnV+D2D66iamb6Xu9ubJ+Utwf3xwOeurcqB5byIv
 4r7qZvlSrVk069173W28UFZTvS9Irw1OQ5qjF3Kn3raJYWgshQ2qXWG4/ZSYqPwS5yhSfSFB13t
 Y3jRdf7JveNQwqu3HfFHxDTGWjozYpcON+KL3kpsJQngxt1qtlTaSiqxtQg6qkPZeagA48wAmi3
 5UsypBAi3c5zO1a/ybPRI8QHKE2inmBZIyJMvZj578Rr9GoeSAkg/MvA58mZ3SpzNmKivQx26b6
 LNNgIM8CyASKTds=
X-Google-Smtp-Source: AGHT+IFlv2AQk6Ov8koHMWz7iS79EHF626S1s7qT9LSCCBZ+EstImbYBVrV6jofyszAarQL5jFHmW36fxJk/0FuQ5gI=
X-Received: by 2002:a17:907:7285:b0:b72:dce0:d8e7 with SMTP id
 a640c23a62f3a-b7331973fc7mr114050366b.23.1762913448218; Tue, 11 Nov 2025
 18:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20251027100938.11822-1-michael@videogpu.com>
 <20251027100938.11822-6-michael@videogpu.com>
In-Reply-To: <20251027100938.11822-6-michael@videogpu.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 12:10:21 +1000
X-Gm-Features: AWmQ_bkbynzhqH9DtfuPS9ZCdd3Zz352gSAvLD2Cxi3Ump8euudLH2KNTbC4-3Q
Message-ID: <CAKmqyKPADYN85RAb+WJvZXf724pyXWRsH20-vDDdLOWpXX2Ugg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] hw/riscv: introduce 'neorv32' board, docs, and
 riscv32 device config
To: Michael Levit <michael@videogpu.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, philmd@linaro.org, 
 pbonzini@redhat.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 liwei1518@gmail.com, smishash@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
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

On Mon, Oct 27, 2025 at 8:12=E2=80=AFPM Michael Levit <michael@videogpu.com=
> wrote:
>
> From: Michael <michael@videogpu.com>
>
> Introduce the 'neorv32' board wiring IMEM/DMEM/BOOTROM, SYSINFO, UART0, a=
nd SPI0;
> add docs/system/riscv/neorv32.rst and riscv32-softmmu device config entry=
.
>
> Signed-off-by: Michael Levit <michael@videogpu.com>
>
> diff --git a/configs/devices/riscv32-softmmu/default.mak b/configs/device=
s/riscv32-softmmu/default.mak
> index c2cd86ce05..4fdc94ab48 100644
> --- a/configs/devices/riscv32-softmmu/default.mak
> +++ b/configs/devices/riscv32-softmmu/default.mak
> @@ -10,3 +10,4 @@
>  # CONFIG_SIFIVE_U=3Dn
>  # CONFIG_RISCV_VIRT=3Dn
>  # CONFIG_OPENTITAN=3Dn
> +# CONFIG_NEORV32=3Dn
>
> diff --git a/docs/system/riscv/neorv32.rst b/docs/system/riscv/neorv32.rs=
t
> new file mode 100644
> index 0000000000..7f9048a7ad
> --- /dev/null
> +++ b/docs/system/riscv/neorv32.rst
> @@ -0,0 +1,110 @@
> +
> +NEORV32 Soft SoC (``neorv32``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +The ``neorv32`` machine models a minimal NEORV32-based SoC sufficient to
> +exercise the stock NEORV32 bootloader and run example applications from =
an
> +emulated SPI NOR flash. It exposes a UART for console I/O and an MTD-bac=
ked
> +SPI flash device that can be populated with user binaries.
> +
> +Neorv32 full repo:
> +https://github.com/stnolting/neorv32
> +
> +Current QEMU implementation base on commit 7d0ef6b2 in Neorv32 repo.
> +
> +Supported devices
> +-----------------
> +
> +The ``neorv32`` machine provides the core peripherals needed by the
> +bootloader and examples:
> +
> +* UART for console (mapped to the QEMU stdio when ``-nographic`` or
> +  ``-serial stdio`` is used).
> +* SPI controller connected to an emulated SPI NOR flash (exposed to the
> +  guest via QEMU's ``if=3Dmtd`` backend).
> +* Basic timer/CLINT-like facilities required by the example software.
> +
> +(Exact register maps and optional peripherals depend on the QEMU version=
 and
> +the specific patch series you are using.)

Thanks for the patches!

I think the main focus is running the patches through checkpatch and
cleaning up the commits a little bit more.

We also want to make sure that the default machine matches some sort
of default configuration. We can't expect users to be manually editing
C code just to get this running. Then QEMU properties can be used to
allow tweaking some of the more common options

> +
> +
> +QEMU build configuration:
> +------------------------
> +/path/to/qemu/configure \
> +  --python=3D/usr/local/bin/python3.12 \
> +  --target-list=3Driscv32-softmmu \
> +  --enable-fdt \
> +  --enable-debug \
> +  --disable-vnc \
> +  --disable-gtk

You don't need to document how to build QEMU, that's covered elsewhere.

Alistair

> +
> +Boot options
> +------------
> +
> +Typical usage is to boot the NEORV32 bootloader as the QEMU ``-bios`` im=
age,
> +and to provide a raw SPI flash image via an MTD drive. The bootloader wi=
ll
> +then jump to the application image placed at the configured flash offset=
.
> +
> +Preparing the SPI flash with a =E2=80=9CHello World=E2=80=9D example
> +----------------------------------------------------
> +
> +1. Create a 64 MiB flash image (filled with zeros)::
> +
> +   $ dd if=3D/dev/zero of=3D$HOME/flash_contents.bin bs=3D1 count=3D$((0=
x04000000))
> +
> +2. Place your application binary at the **4 MiB** offset inside the flas=
h.
> +   Replace ``/path/to/neorv32_exe.bin`` with the path to your compiled
> +   example application (e.g., the NEORV32 ``hello_world`` example)::
> +
> +   $ dd if=3D/path/to/neorv32_exe.bin of=3D$HOME/flash_contents.bin \
> +        bs=3D1 seek=3D$((0x00400000)) conv=3Dnotrunc
> +
> +Running the =E2=80=9CHello World=E2=80=9D example
> +---------------------------------
> +
> +Run QEMU with the NEORV32 bootloader as ``-bios`` and attach the prepare=
d
> +flash image via the MTD interface. Replace the placeholder paths with yo=
ur
> +local paths::
> +
> +  $ /path/to/qemu-system-riscv32 -nographic -machine neorv32 \
> +      -bios /path/to/neorv32/bootloader/neorv32_raw_exe.bin \
> +      -drive file=3D$HOME/flash_contents.bin,if=3Dmtd,format=3Draw
> +
> +Notes:
> +
> +* ``-nographic`` routes the UART to your terminal (Ctrl-A X to quit when
> +  using the QEMU monitor hotkeys; or just close the terminal).
> +* The bootloader starts first and will transfer control to your applicat=
ion
> +  located at the 4 MiB offset of the flash image.
> +* If you prefer, you can use ``-serial stdio`` instead of ``-nographic``=
.
> +
> +Machine-specific options
> +------------------------
> +
> +Unless otherwise noted by the patch series, there are no special board
> +options beyond the standard QEMU options shown above. Commonly useful
> +generic options include:
> +
> +* ``-s -S`` to open a GDB stub on TCP port 1234 and start paused, so you=
 can
> +  debug both QEMU and the guest.
> +* ``-d guest_errors,unimp`` (or other trace flags) for additional loggin=
g.
> +
> +Example: debugging with GDB::
> +
> +  $ /path/to/qemu-system-riscv32 -nographic -machine neorv32 \
> +      -bios /path/to/neorv32/bootloader/neorv32_raw_exe.bin \
> +      -drive file=3D$HOME/flash_contents.bin,if=3Dmtd,format=3Draw \
> +      -s -S
> +
> +  # In another shell:
> +  $ riscv32-unknown-elf-gdb /path/to/neorv32/bootloader/main.elf
> +  (gdb) target remote :1234
> +
> +
> +Known limitations
> +-----------------
> +
> +This is a functional model intended for software bring-up and testing of
> +example programs. It may not model all timing details or every optional
> +peripheral available in a specific NEORV32 SoC configuration.
> +
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index fc9c35bd98..976acd2a1b 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -128,3 +128,11 @@ config XIANGSHAN_KUNMINGHU
>      select RISCV_APLIC
>      select RISCV_IMSIC
>      select SERIAL_MM
> +
> +config NEORV32
> +    bool
> +    default y
> +    depends on RISCV32
> +    select NEORV32_UART
> +    select NEORV32_SPI
> +    select NEORV32_SYSINFO_QEMU
>
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 2a8d5b136c..b8788e2035 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -14,5 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files=
(
>         'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv=
-iommu-hpm.c'))
>  riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-g=
eneric.c'))
>  riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangsh=
an_kmh.c'))
> +riscv_ss.add(when: 'CONFIG_NEORV32', if_true: files('neorv32.c'))
>
>  hw_arch +=3D {'riscv': riscv_ss}
>
> diff --git a/hw/riscv/neorv32.c b/hw/riscv/neorv32.c
> new file mode 100644
> index 0000000000..87e35a9b0d
> --- /dev/null
> +++ b/hw/riscv/neorv32.c
> @@ -0,0 +1,219 @@
> +/*
> + * QEMU RISC-V Board Compatible with Neorv32 IP
> + *
> + * Provides a board compatible with the Neorv32 IP:
> + *
> + * 0) SYSINFO
> + * 1) IMEM
> + * 2) DMEM
> + * 3) UART
> + * 4) SPI
> + *
> + * Author:
> + *   Michael Levit <michael@videogpu.com>
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
> +#include "qemu/cutils.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "hw/char/serial.h"
> +#include "hw/misc/unimp.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "chardev/char.h"
> +#include "system/system.h"
> +#include "hw/ssi/ssi.h"    /* For ssi_realize_and_unref() */
> +
> +#include "hw/riscv/neorv32.h"
> +#include "hw/misc/neorv32_sysinfo.h"
> +#include "hw/char/neorv32_uart.h"
> +#include "hw/ssi/neorv32_spi.h"
> +
> +static const MemMapEntry neorv32_memmap[] =3D {
> +
> +    [NEORV32_IMEM]           =3D { NEORV32_IMEM_BASE,               SYSI=
NFO_IMEM_SIZE},
> +    [NEORV32_BOOTLOADER_ROM] =3D { NEORV32_BOOTLOADER_BASE_ADDRESS, 0x20=
00},     /* 8K  ROM for bootloader */
> +    [NEORV32_DMEM]           =3D { NEORV32_DMEM_BASE,               SYSI=
NFO_DMEM_SIZE},
> +    [NEORV32_SYSINFO]        =3D { NEORV32_SYSINFO_BASE,            0x10=
0},
> +    [NEORV32_UART0]          =3D { NEORV32_UART0_BASE,              0x10=
0},
> +       [NEORV32_SPI0]           =3D { NEORV32_SPI_BASE,                0=
x100},
> +};
> +
> +static void neorv32_machine_init(MachineState *machine)
> +{
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +    const MemMapEntry *memmap =3D neorv32_memmap;
> +
> +    Neorv32State *s =3D NEORV32_MACHINE(machine);
> +    MemoryRegion *sys_mem =3D get_system_memory();
> +    int i;
> +    RISCVBootInfo boot_info;
> +    hwaddr start_addr =3D memmap[NEORV32_BOOTLOADER_ROM].base;
> +
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        char *sz =3D size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* Initialize SoC */
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_=
NEORV32_SOC);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +
> +    /* Data Tightly Integrated Memory */
> +    memory_region_add_subregion(sys_mem,
> +        memmap[NEORV32_DMEM].base, machine->ram);
> +
> +    /* Instruction Memory (IMEM) */
> +       memory_region_init_ram(&s->soc.imem_region, OBJECT(&s->soc), "ris=
cv.neorv32.imem",
> +                                                memmap[NEORV32_IMEM].siz=
e, &error_fatal);
> +       memory_region_add_subregion(sys_mem, memmap[NEORV32_IMEM].base, &=
s->soc.imem_region);
> +
> +    /* Mask ROM reset vector */
> +    uint32_t reset_vec[4];
> +
> +    reset_vec[1] =3D 0x204002b7;  /* 0x1004: lui     t0,0x20400 */
> +    reset_vec[2] =3D 0x00028067;      /* 0x1008: jr      t0 */
> +    reset_vec[0] =3D reset_vec[3] =3D 0;
> +
> +    /* copy in the reset vector in little_endian byte order */
> +    for (i =3D 0; i < sizeof(reset_vec) >> 2; i++) {
> +        reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
> +    }
> +
> +    /* Neorv32 bootloader */
> +    if (machine->firmware) {
> +        riscv_find_and_load_firmware(machine, machine->firmware,
> +                                            &start_addr, NULL);
> +    }
> +
> +    /* Neorv32 example applications */
> +    riscv_boot_info_init(&boot_info, &s->soc.cpus);
> +    if (machine->kernel_filename) {
> +        riscv_load_kernel(machine, &boot_info,
> +                          memmap[NEORV32_IMEM].base,
> +                          false, NULL);
> +    }
> +}
> +
> +static void neorv32_machine_instance_init(Object *obj)
> +{
> +
> +    /* Placeholder for now */
> +    /* Neorv32State *s =3D NEORV32_MACHINE(obj); */
> +}
> +
> +static void neorv32_machine_class_init(ObjectClass *oc,const void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "RISC-V SOC compatible with Neorv32 SDK";
> +    mc->init =3D neorv32_machine_init;
> +    mc->max_cpus =3D 1;
> +    mc->default_cpu_type =3D NEORV32_CPU;
> +    mc->default_ram_id =3D "riscv.neorv32.dmem";
> +    mc->default_ram_size =3D neorv32_memmap[NEORV32_DMEM].size;
> +
> +}
> +
> +static const TypeInfo neorv32_machine_typeinfo =3D {
> +    .name          =3D MACHINE_TYPE_NAME("neorv32"),
> +    .parent        =3D TYPE_MACHINE,
> +    .class_init    =3D neorv32_machine_class_init,
> +    .instance_init =3D neorv32_machine_instance_init,
> +    .instance_size =3D sizeof(Neorv32State),
> +};
> +
> +static void neorv32_machine_init_register_types(void)
> +{
> +    type_register_static(&neorv32_machine_typeinfo);
> +}
> +
> +type_init(neorv32_machine_init_register_types)
> +
> +static void neorv32_soc_init(Object *obj)
> +{
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    Neorv32SoCState *s =3D RISCV_NEORV32_SOC(obj);
> +
> +    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY=
);
> +    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
> +                            &error_abort);
> +
> +    object_property_set_int(OBJECT(&s->cpus), "resetvec", NEORV32_BOOTLO=
ADER_BASE_ADDRESS, &error_abort);
> +
> +}
> +
> +static void neorv32_soc_realize(DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    const MemMapEntry *memmap =3D neorv32_memmap;
> +    Neorv32SoCState *s =3D RISCV_NEORV32_SOC(dev);
> +    MemoryRegion *sys_mem =3D get_system_memory();
> +
> +    object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
> +                            &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
> +
> +    /* Bootloader ROM */
> +    memory_region_init_rom(&s->bootloader_rom, OBJECT(dev), "riscv.bootl=
oader.rom",
> +                           memmap[NEORV32_BOOTLOADER_ROM].size, &error_f=
atal);
> +    memory_region_add_subregion(sys_mem,
> +        memmap[NEORV32_BOOTLOADER_ROM].base, &s->bootloader_rom);
> +
> +
> +    /* Sysinfo ROM */
> +    neorv32_sysinfo_create(sys_mem, memmap[NEORV32_SYSINFO].base);
> +
> +    /* Uart0 */
> +    neorv32_uart_create(sys_mem, memmap[NEORV32_UART0].base,serial_hd(0)=
);
> +
> +    /* SPI controller */
> +       NEORV32SPIState *spi =3D neorv32_spi_create(sys_mem, memmap[NEORV=
32_SPI0].base);
> +
> +       if (!spi) {
> +               error_setg(errp, "SPI is not created");
> +               return;
> +       }
> +}
> +
> +static void neorv32_soc_class_init(ObjectClass *oc,const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    dc->realize =3D neorv32_soc_realize;
> +    dc->user_creatable =3D false;
> +}
> +
> +static const TypeInfo neorv32_soc_type_info =3D {
> +    .name =3D TYPE_RISCV_NEORV32_SOC,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(Neorv32SoCState),
> +    .instance_init =3D neorv32_soc_init,
> +    .class_init =3D neorv32_soc_class_init,
> +};
> +
> +static void neorv32_soc_register_types(void)
> +{
> +    type_register_static(&neorv32_soc_type_info);
> +}
> +
> +type_init(neorv32_soc_register_types)
>
> diff --git a/include/hw/riscv/neorv32.h b/include/hw/riscv/neorv32.h
> new file mode 100644
> index 0000000000..46c7f6767e
> --- /dev/null
> +++ b/include/hw/riscv/neorv32.h
> @@ -0,0 +1,60 @@
> +/*
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
> +#ifndef HW_NEORV32_H
> +#define HW_NEORV32_H
> +
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/boards.h"
> +
> +#if defined(TARGET_RISCV32)
> +#define NEORV32_CPU TYPE_RISCV_CPU_NEORV32
> +#endif
> +
> +#define TYPE_RISCV_NEORV32_SOC "riscv.neorv32.soc"
> +#define RISCV_NEORV32_SOC(obj) \
> +    OBJECT_CHECK(Neorv32SoCState, (obj), TYPE_RISCV_NEORV32_SOC)
> +
> +typedef struct Neorv32SoCState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    RISCVHartArrayState cpus;
> +    DeviceState *plic;
> +    MemoryRegion imem_region;
> +    MemoryRegion bootloader_rom;
> +} Neorv32SoCState;
> +
> +typedef struct Neorv32State {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +    /*< public >*/
> +    Neorv32SoCState soc;
> +} Neorv32State;
> +
> +#define TYPE_NEORV32_MACHINE MACHINE_TYPE_NAME("neorv32")
> +#define NEORV32_MACHINE(obj) \
> +    OBJECT_CHECK(Neorv32State, (obj), TYPE_NEORV32_MACHINE)
> +
> +enum {
> +       NEORV32_IMEM,
> +       NEORV32_BOOTLOADER_ROM,
> +       NEORV32_DMEM,
> +       NEORV32_SYSINFO,
> +       NEORV32_UART0,
> +       NEORV32_SPI0,
> +};
> +
> +#endif //HW_NEORV32_H
>

