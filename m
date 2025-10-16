Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E3DCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9WwZ-0004Nx-3D; Thu, 16 Oct 2025 18:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9WwW-0004N7-Un
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 18:59:32 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9WwR-00068i-RZ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 18:59:32 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42568669606so997093f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 15:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760655566; x=1761260366; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKorZx9/Un9braMs7BtLlnUUR41MBPdwO4W70dVSmV4=;
 b=hNfM0k/dxwPX5G0643sOmXim5Xple/zyRma6pBaiiqKVzFobNmT75hOtbfR7Op+9Cf
 PzHC0BQd7IL9Z6tEAwwzDbyuceOv0Ij7I3wmfdcKS/UzUJdY3hRRGyM8lAK7K6YsR6nZ
 eK7rBkaF+stNhHB9MUD2rnIPKMyeOJI4lSb5pU2pAjg2Yh54tq3WbONCSQADeC3W5BUA
 xSMQjS5eWoeMM1NXGto0cHKXQlQtafFNW0vFhbuhpi5rdWdrUseThLdtz4KU2FTwcfff
 HuGk4YXrucb3y6VmIss0oZxl2+wbRWm5ezgh68kGfFC6Mh9tKWcwHxq6ompiRfpxdLAB
 mnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760655566; x=1761260366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKorZx9/Un9braMs7BtLlnUUR41MBPdwO4W70dVSmV4=;
 b=ra6dTvl+yMLll8WnM2QF+px+yYyFHfha7ETcfILb+QvvHk500mj1wKODcSi0L+B7mY
 0NJHMq48e/Ogm7bSn2ymNClrVqHSF7i6nWCXZqhkEilWYnDYFPxe0H70RuRrgWhQSf8P
 WioIsV2dkJUbfsrjVeI20+p6t1uIe1d4KEZ97uOoZrTpSmjpZHVzAXWjuY7OE1Y8Xd/i
 wYkGDZp8RkS9RCEA7jnAF0XBa8HxciK45bYZXq203BC0kOcCxYBP844wjpPM7+aGAgRY
 oyV1djhi4JhQShTOONVWDVjk5ZcHgt/SB+ENLkLgRifh8sZ6ccGZLkmYc52cDBYMOg2j
 DiGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYXtbO3slXcPcUB2kzcC3UzNzgRBsV3CI83lEpcR10E05RI09f9ctqpJiWHdA2yUnTb4Vubt5kjmua@nongnu.org
X-Gm-Message-State: AOJu0YxETsu10nZxrcJuEZ7QnxyxCPrvzOv4J4fURZXqb+XQ8QgIkMc5
 aIDzJSfwbP0RcACfDn5qmv6vs8PCpkU8/+EfxBBV+xGnrqS9Z/DL7djBn3AmWERBn5VcgbkDGVI
 T33xkRyAKBpvwqp3Fo0xXnODcnbwuxQ8=
X-Gm-Gg: ASbGncuZnlaiDCOe/KVvWQa/hrMkpqLgZr1eSigFp08nXVuZ+SqiW+H/fCiMnl4CEH/
 dALilRwS8gI6vzwOyPYlU4qY9kp8UzQuA4wqZ8Lj4qr4ATq+oO9SH7q/qiQVRBAXiTO6hBlDm2y
 H/y9uzjv9V9xRy57JXhcpyWcMr/uiTlrETia0DG77YpyJ/h7ABbMIO6Ee1a3h8bLrpNOePW98E7
 Tz++BRMV3ynIvaXGLgtg94tZTnmN37lEJGxV8PVucwKuCjVVONnTOJzqqYfSNxa8Vxy1Uqg2QFr
 Owk+rWhClbz/qSO2Vz6sGb/uKmiW4IPjNp2D
X-Google-Smtp-Source: AGHT+IFvadRSMgORHbpvPUUR9uf2abJVSQOrVupNQOJL+Q31ULsK5rgwNneyHuFnB6LC3Ib1v4xv6Dm+axmW6jkFwkc=
X-Received: by 2002:a5d:5f82:0:b0:426:fb28:7962 with SMTP id
 ffacd0b85a97d-42704dd3690mr1201428f8f.61.1760655565552; Thu, 16 Oct 2025
 15:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
 <20251016173502.1261674-3-vishalc@linux.ibm.com>
In-Reply-To: <20251016173502.1261674-3-vishalc@linux.ibm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 08:58:58 +1000
X-Gm-Features: AS18NWBcPYwvJdx49PwPKet69ItjFJDOO9wf6rLWc22Lz31E8Mj_WlqsZEvoj10
Message-ID: <CAKmqyKOJS+rY0NpTpv76SJqZmgjoLnvQX8wiKgxgUP6k=+fpnQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] hw/core/loader: capture Error from load_image_targphys
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com, 
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, berrange@redhat.com, richard.henderson@linaro.org, 
 alistair@alistair23.me, alex.bennee@linaro.org, deller@gmx.de, 
 pbonzini@redhat.com, eduardo@habkost.net, minyard@acm.org, 
 gaosong@loongson.cn, maobibo@loongson.cn, laurent@vivier.eu, 
 edgar.iglesias@gmail.com, hpoussin@reactos.org, balaton@eik.bme.hu, 
 david@redhat.com, chigot@adacore.com, konrad.frederic@yahoo.fr, 
 atar4qemu@gmail.com, jcmvbkbc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Oct 17, 2025 at 4:01=E2=80=AFAM Vishal Chourasia <vishalc@linux.ibm=
.com> wrote:
>
> Add Error **errp parameter to load_image_targphys(),
> load_image_targphys_as(), and get_image_size() to enable better
> error reporting when image loading fails.
>
> Pass NULL for errp in all existing call sites to maintain current
> behavior. No functional change intended in this patch.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/alpha/dp264.c         |  4 ++--
>  hw/arm/armv7m.c          |  2 +-
>  hw/arm/boot.c            |  5 +++--
>  hw/arm/digic_boards.c    |  2 +-
>  hw/arm/highbank.c        |  3 ++-
>  hw/arm/raspi.c           |  2 +-
>  hw/arm/vexpress.c        |  2 +-
>  hw/core/generic-loader.c |  3 ++-
>  hw/core/guest-loader.c   |  2 +-
>  hw/core/loader.c         | 33 +++++++++++++++++++++++++--------
>  hw/hppa/machine.c        |  5 +++--
>  hw/i386/multiboot.c      |  2 +-
>  hw/i386/x86-common.c     |  4 ++--
>  hw/ipmi/ipmi_bmc_sim.c   |  2 +-
>  hw/loongarch/boot.c      |  5 ++---
>  hw/m68k/an5206.c         |  2 +-
>  hw/m68k/mcf5208.c        |  4 ++--
>  hw/m68k/next-cube.c      |  2 +-
>  hw/m68k/q800.c           |  7 ++++---
>  hw/m68k/virt.c           |  4 ++--
>  hw/microblaze/boot.c     |  5 +++--
>  hw/mips/boston.c         |  2 +-
>  hw/mips/fuloong2e.c      |  9 +++++----
>  hw/mips/jazz.c           |  2 +-
>  hw/mips/loongson3_virt.c | 10 ++++++----
>  hw/mips/malta.c          |  9 +++++----
>  hw/nubus/nubus-device.c  |  2 +-
>  hw/openrisc/boot.c       |  5 +++--
>  hw/pci/pci.c             |  2 +-
>  hw/ppc/amigaone.c        |  4 ++--
>  hw/ppc/e500.c            |  5 +++--
>  hw/ppc/mac_newworld.c    |  9 ++++++---
>  hw/ppc/mac_oldworld.c    |  9 ++++++---
>  hw/ppc/pegasos2.c        |  5 +++--
>  hw/ppc/pnv.c             |  8 +++++---
>  hw/ppc/ppc440_bamboo.c   |  3 ++-
>  hw/ppc/prep.c            |  8 +++++---
>  hw/ppc/sam460ex.c        |  3 ++-
>  hw/ppc/spapr.c           |  5 +++--
>  hw/ppc/virtex_ml507.c    |  5 +++--
>  hw/riscv/boot.c          |  7 ++++---
>  hw/rx/rx-gdbsim.c        |  2 +-
>  hw/s390x/ipl.c           |  8 +++++---
>  hw/sh4/r2d.c             |  8 +++++---
>  hw/smbios/smbios.c       |  2 +-
>  hw/sparc/leon3.c         |  4 ++--
>  hw/sparc/sun4m.c         |  8 +++++---
>  hw/sparc64/sun4u.c       |  7 ++++---
>  hw/xtensa/xtfpga.c       |  3 ++-
>  include/hw/loader.h      |  8 +++++---
>  system/device_tree.c     |  2 +-
>  51 files changed, 159 insertions(+), 105 deletions(-)
>
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 19562b5967..b6155646ef 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -182,7 +182,7 @@ static void clipper_init(MachineState *machine)
>              long initrd_base;
>              int64_t initrd_size;
>
> -            initrd_size =3D get_image_size(initrd_filename);
> +            initrd_size =3D get_image_size(initrd_filename, NULL);
>              if (initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               initrd_filename);
> @@ -192,7 +192,7 @@ static void clipper_init(MachineState *machine)
>              /* Put the initrd image as high in memory as possible.  */
>              initrd_base =3D (ram_size - initrd_size) & TARGET_PAGE_MASK;
>              load_image_targphys(initrd_filename, initrd_base,
> -                                ram_size - initrd_base);
> +                                ram_size - initrd_base, NULL);
>
>              address_space_stq(&address_space_memory, param_offset + 0x10=
0,
>                                initrd_base + 0xfffffc0000000000ULL,
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index cea3eb49ee..c4a9c3ac52 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -611,7 +611,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kern=
el_filename,
>                                   NULL, ELFDATA2LSB, EM_ARM, 1, 0, as);
>          if (image_size < 0) {
>              image_size =3D load_image_targphys_as(kernel_filename, mem_b=
ase,
> -                                                mem_size, as);
> +                                                mem_size, as, NULL);
>          }
>          if (image_size < 0) {
>              error_report("Could not load kernel '%s'", kernel_filename);
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index e77d8679d8..b91660208f 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -964,7 +964,8 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>          /* 32-bit ARM */
>          entry =3D info->loader_start + KERNEL_LOAD_ADDR;
>          kernel_size =3D load_image_targphys_as(info->kernel_filename, en=
try,
> -                                             ram_end - KERNEL_LOAD_ADDR,=
 as);
> +                                             ram_end - KERNEL_LOAD_ADDR,=
 as,
> +                                             NULL);
>          is_linux =3D 1;
>          if (kernel_size >=3D 0) {
>              image_low_addr =3D entry;
> @@ -1025,7 +1026,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cp=
u,
>                                                       info->initrd_start,
>                                                       ram_end -
>                                                       info->initrd_start,
> -                                                     as);
> +                                                     as, NULL);
>              }
>              if (initrd_size < 0) {
>                  error_report("could not load initrd '%s'",
> diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
> index 466b8b84c0..de56991bac 100644
> --- a/hw/arm/digic_boards.c
> +++ b/hw/arm/digic_boards.c
> @@ -97,7 +97,7 @@ static void digic_load_rom(DigicState *s, hwaddr addr,
>              exit(1);
>          }
>
> -        rom_size =3D load_image_targphys(fn, addr, max_size);
> +        rom_size =3D load_image_targphys(fn, addr, max_size, NULL);
>          if (rom_size < 0 || rom_size > max_size) {
>              error_report("Couldn't load rom image '%s'.", filename);
>              exit(1);
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index 165c0b741a..5f686523c3 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -235,7 +235,8 @@ static void calxeda_init(MachineState *machine, enum =
cxmachines machine_id)
>      if (machine->firmware !=3D NULL) {
>          sysboot_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, machine=
->firmware);
>          if (sysboot_filename !=3D NULL) {
> -            if (load_image_targphys(sysboot_filename, 0xfff88000, 0x8000=
) < 0) {
> +            if (load_image_targphys(sysboot_filename, 0xfff88000, 0x8000=
,
> +                        NULL) < 0) {
>                  error_report("Unable to load %s", machine->firmware);
>                  exit(1);
>              }
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 9d9af63d65..fbf3e09c03 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -230,7 +230,7 @@ static void setup_boot(MachineState *machine, ARMCPU =
*cpu,
>                               ? FIRMWARE_ADDR_2 : FIRMWARE_ADDR_3;
>          /* load the firmware image (typically kernel.img) */
>          r =3D load_image_targphys(machine->firmware, firmware_addr,
> -                                ram_size - firmware_addr);
> +                                ram_size - firmware_addr, NULL);
>          if (r < 0) {
>              error_report("Failed to load firmware from %s", machine->fir=
mware);
>              exit(1);
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index 35f8d05ea1..60cd375fe7 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -578,7 +578,7 @@ static void vexpress_common_init(MachineState *machin=
e)
>              exit(1);
>          }
>          image_size =3D load_image_targphys(fn, map[VE_NORFLASH0],
> -                                         VEXPRESS_FLASH_SIZE);
> +                                         VEXPRESS_FLASH_SIZE, NULL);
>          g_free(fn);
>          if (image_size < 0) {
>              error_report("Could not load ROM image '%s'", machine->firmw=
are);
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index e72bbde2a2..6689847c33 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -148,7 +148,8 @@ static void generic_loader_realize(DeviceState *dev, =
Error **errp)
>
>          if (size < 0 || s->force_raw) {
>              /* Default to the maximum size being the machine's ram size =
*/
> -            size =3D load_image_targphys_as(s->file, s->addr, current_ma=
chine->ram_size, as);
> +            size =3D load_image_targphys_as(s->file, s->addr,
> +                    current_machine->ram_size, as, NULL);
>          } else {
>              s->addr =3D entry;
>          }
> diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
> index 3db89d7a2e..59f325ad9c 100644
> --- a/hw/core/guest-loader.c
> +++ b/hw/core/guest-loader.c
> @@ -101,7 +101,7 @@ static void guest_loader_realize(DeviceState *dev, Er=
ror **errp)
>
>      /* Default to the maximum size being the machine's ram size */
>      size =3D load_image_targphys_as(file, s->addr, current_machine->ram_=
size,
> -                                  NULL);
> +                                  NULL, NULL);
>      if (size < 0) {
>          error_setg(errp, "Cannot load specified image %s", file);
>          return;
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 477661a025..63bb0578b1 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -48,6 +48,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-machine.h"
>  #include "qapi/type-helpers.h"
> +#include "qemu/units.h"
>  #include "trace.h"
>  #include "hw/hw.h"
>  #include "disas/disas.h"
> @@ -61,23 +62,31 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "system/memory.h"
>  #include "hw/boards.h"
> +#include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "system/runstate.h"
>  #include "tcg/debuginfo.h"
>
> +#include <errno.h>
>  #include <zlib.h>
>
>  static int roms_loaded;
>
>  /* return the size or -1 if error */
> -int64_t get_image_size(const char *filename)
> +int64_t get_image_size(const char *filename, Error **errp)
>  {
>      int fd;
>      int64_t size;
>      fd =3D open(filename, O_RDONLY | O_BINARY);
> -    if (fd < 0)
> +    if (fd < 0) {
> +        error_setg_file_open(errp, errno, filename);
>          return -1;
> +    }
>      size =3D lseek(fd, 0, SEEK_END);
> +    if (size < 0) {
> +        error_setg_errno(errp, errno, "lseek failure: %s", filename);
> +        return -1;
> +    }
>      close(fd);
>      return size;
>  }
> @@ -118,21 +127,29 @@ ssize_t read_targphys(const char *name,
>  }
>
>  ssize_t load_image_targphys(const char *filename,
> -                            hwaddr addr, uint64_t max_sz)
> +                            hwaddr addr, uint64_t max_sz, Error **errp)
>  {
> -    return load_image_targphys_as(filename, addr, max_sz, NULL);
> +    return load_image_targphys_as(filename, addr, max_sz, NULL, errp);
>  }
>
>  /* return the size or -1 if error */
>  ssize_t load_image_targphys_as(const char *filename,
> -                               hwaddr addr, uint64_t max_sz, AddressSpac=
e *as)
> +                               hwaddr addr, uint64_t max_sz, AddressSpac=
e *as,
> +                               Error **errp)
>  {
> +    ERRP_GUARD();
>      ssize_t size;
>
> -    size =3D get_image_size(filename);
> -    if (size < 0 || size > max_sz) {
> +    size =3D get_image_size(filename, errp);
> +    if (*errp) {
>          return -1;
>      }
> +
> +    if (size > max_sz) {
> +        error_setg(errp, "%s exceeds maximum image size (%lu MiB)", file=
name, max_sz / MiB);
> +        return -1;
> +    }
> +
>      if (size > 0) {
>          if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
>              return -1;
> @@ -150,7 +167,7 @@ ssize_t load_image_mr(const char *filename, MemoryReg=
ion *mr)
>          return -1;
>      }
>
> -    size =3D get_image_size(filename);
> +    size =3D get_image_size(filename, NULL);
>
>      if (size < 0 || size > memory_region_size(mr)) {
>          return -1;
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index cddca69b93..3c92cd9d56 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -495,7 +495,7 @@ static void machine_HP_common_init_tail(MachineState =
*machine, PCIBus *pci_bus,
>              ram_addr_t initrd_base;
>              int64_t initrd_size;
>
> -            initrd_size =3D get_image_size(initrd_filename);
> +            initrd_size =3D get_image_size(initrd_filename, NULL);
>              if (initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               initrd_filename);
> @@ -516,7 +516,8 @@ static void machine_HP_common_init_tail(MachineState =
*machine, PCIBus *pci_bus,
>                  exit(1);
>              }
>
> -            load_image_targphys(initrd_filename, initrd_base, initrd_siz=
e);
> +            load_image_targphys(initrd_filename, initrd_base, initrd_siz=
e,
> +                    NULL);
>              cpu[0]->env.initrd_base =3D initrd_base;
>              cpu[0]->env.initrd_end  =3D initrd_base + initrd_size;
>          }
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index 6e6b96bc34..78690781b7 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -337,7 +337,7 @@ int load_multiboot(X86MachineState *x86ms,
>                  *next_space =3D '\0';
>              }
>              mb_debug("multiboot loading module: %s", one_file);
> -            mb_mod_length =3D get_image_size(one_file);
> +            mb_mod_length =3D get_image_size(one_file, NULL);
>              if (mb_mod_length < 0) {
>                  error_report("Failed to open file '%s'", one_file);
>                  exit(1);
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 7512be64d6..6e78f3d07d 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -924,7 +924,7 @@ void x86_load_linux(X86MachineState *x86ms,
>              exit(1);
>          }
>
> -        dtb_size =3D get_image_size(dtb_filename);
> +        dtb_size =3D get_image_size(dtb_filename, NULL);
>          if (dtb_size <=3D 0) {
>              fprintf(stderr, "qemu: error reading dtb %s: %s\n",
>                      dtb_filename, strerror(errno));
> @@ -1025,7 +1025,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, cons=
t char *default_firmware,
>      bios_name =3D MACHINE(x86ms)->firmware ?: default_firmware;
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (filename) {
> -        bios_size =3D get_image_size(filename);
> +        bios_size =3D get_image_size(filename, NULL);
>      } else {
>          bios_size =3D -1;
>      }
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 04e1dcd0e7..4604d632b1 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -2211,7 +2211,7 @@ static void ipmi_fru_init(IPMIFru *fru)
>          goto out;
>      }
>
> -    fsize =3D get_image_size(fru->filename);
> +    fsize =3D get_image_size(fru->filename, NULL);
>      if (fsize > 0) {
>          size =3D QEMU_ALIGN_UP(fsize, fru->areasize);
>          fru->data =3D g_malloc0(size);
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 3dd48cb8aa..8857a04998 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -328,14 +328,13 @@ static int64_t load_kernel_info(struct loongarch_bo=
ot_info *info)
>      }
>
>      if (info->initrd_filename) {
> -        ssize_t initrd_size =3D get_image_size(info->initrd_filename);
> -
> +        ssize_t initrd_size =3D get_image_size(info->initrd_filename, NU=
LL);
>          if (initrd_size > 0) {
>              initrd_offset =3D ROUND_UP(kernel_high + 4 * kernel_size, 64=
 * KiB);
>              initrd_offset =3D alloc_initrd_memory(info, initrd_offset,
>                                                  initrd_size);
>              initrd_size =3D load_image_targphys(info->initrd_filename,
> -                                              initrd_offset, initrd_size=
);
> +                                              initrd_offset, initrd_size=
, NULL);
>          }
>
>          if (initrd_size =3D=3D -1) {
> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
> index d97399b882..ff21d7779e 100644
> --- a/hw/m68k/an5206.c
> +++ b/hw/m68k/an5206.c
> @@ -82,7 +82,7 @@ static void an5206_init(MachineState *machine)
>      }
>      if (kernel_size < 0) {
>          kernel_size =3D load_image_targphys(kernel_filename, KERNEL_LOAD=
_ADDR,
> -                                          ram_size - KERNEL_LOAD_ADDR);
> +                                          ram_size - KERNEL_LOAD_ADDR, N=
ULL);
>          entry =3D KERNEL_LOAD_ADDR;
>      }
>      if (kernel_size < 0) {
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index 75cc076f78..4a585b231d 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -351,7 +351,7 @@ static void mcf5208evb_init(MachineState *machine)
>              error_report("Could not find ROM image '%s'", machine->firmw=
are);
>              exit(1);
>          }
> -        if (load_image_targphys(fn, 0x0, ROM_SIZE) < 8) {
> +        if (load_image_targphys(fn, 0x0, ROM_SIZE, NULL) < 8) {
>              error_report("Could not load ROM image '%s'", machine->firmw=
are);
>              exit(1);
>          }
> @@ -380,7 +380,7 @@ static void mcf5208evb_init(MachineState *machine)
>      }
>      if (kernel_size < 0) {
>          kernel_size =3D load_image_targphys(kernel_filename, 0x40000000,
> -                                          ram_size);
> +                                          ram_size, NULL);
>          entry =3D 0x40000000;
>      }
>      if (kernel_size < 0) {
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 957644b2d1..cfb2b319e5 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -1325,7 +1325,7 @@ static void next_cube_init(MachineState *machine)
>      memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
>                               0x20000);
>      memory_region_add_subregion(sysmem, 0x0, &m->rom2);
> -    if (load_image_targphys(bios_name, 0x01000000, 0x20000) < 8) {
> +    if (load_image_targphys(bios_name, 0x01000000, 0x20000, NULL) < 8) {
>          if (!qtest_enabled()) {
>              error_report("Failed to load firmware '%s'.", bios_name);
>          }
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 793b23f815..bfb8968d33 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -629,7 +629,7 @@ static void q800_machine_init(MachineState *machine)
>
>          /* load initrd */
>          if (initrd_filename) {
> -            initrd_size =3D get_image_size(initrd_filename);
> +            initrd_size =3D get_image_size(initrd_filename, NULL);
>              if (initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               initrd_filename);
> @@ -638,7 +638,7 @@ static void q800_machine_init(MachineState *machine)
>
>              initrd_base =3D (ram_size - initrd_size) & TARGET_PAGE_MASK;
>              load_image_targphys(initrd_filename, initrd_base,
> -                                ram_size - initrd_base);
> +                                ram_size - initrd_base, NULL);
>              BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
>                        initrd_size);
>          } else {
> @@ -668,7 +668,8 @@ static void q800_machine_init(MachineState *machine)
>
>          /* Load MacROM binary */
>          if (filename) {
> -            bios_size =3D load_image_targphys(filename, MACROM_ADDR, MAC=
ROM_SIZE);
> +            bios_size =3D load_image_targphys(filename, MACROM_ADDR, MAC=
ROM_SIZE,
> +                    NULL);
>              g_free(filename);
>          } else {
>              bios_size =3D -1;
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> index 98cfe43c73..3f65d91556 100644
> --- a/hw/m68k/virt.c
> +++ b/hw/m68k/virt.c
> @@ -283,7 +283,7 @@ static void virt_init(MachineState *machine)
>
>          /* load initrd */
>          if (initrd_filename) {
> -            initrd_size =3D get_image_size(initrd_filename);
> +            initrd_size =3D get_image_size(initrd_filename, NULL);
>              if (initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               initrd_filename);
> @@ -292,7 +292,7 @@ static void virt_init(MachineState *machine)
>
>              initrd_base =3D (ram_size - initrd_size) & TARGET_PAGE_MASK;
>              load_image_targphys(initrd_filename, initrd_base,
> -                                ram_size - initrd_base);
> +                                ram_size - initrd_base, NULL);
>              BOOTINFO2(param_ptr, BI_RAMDISK, initrd_base,
>                        initrd_size);
>          } else {
> diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
> index 4a9c9df318..ec38107f50 100644
> --- a/hw/microblaze/boot.c
> +++ b/hw/microblaze/boot.c
> @@ -170,7 +170,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, bool =
is_little_endian,
>          /* Not an ELF image nor an u-boot image, try a RAW image.  */
>          if (kernel_size < 0) {
>              kernel_size =3D load_image_targphys(kernel_filename, ddr_bas=
e,
> -                                              ramsize);
> +                                              ramsize, NULL);
>              boot_info.bootstrap_pc =3D ddr_base;
>              high =3D (ddr_base + kernel_size + 3) & ~3;
>          }
> @@ -189,7 +189,8 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, bool =
is_little_endian,
>              if (initrd_size < 0) {
>                  initrd_size =3D load_image_targphys(initrd_filename,
>                                                    boot_info.initrd_start=
,
> -                                                  ramsize - initrd_offse=
t);
> +                                                  ramsize - initrd_offse=
t,
> +                                                  NULL);
>              }
>              if (initrd_size < 0) {
>                  error_report("could not load initrd '%s'",
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 149a263bd5..0a3a827b5f 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -778,7 +778,7 @@ static void boston_mach_init(MachineState *machine)
>
>      if (machine->firmware) {
>          fw_size =3D load_image_targphys(machine->firmware,
> -                                      0x1fc00000, 4 * MiB);
> +                                      0x1fc00000, 4 * MiB, NULL);
>          if (fw_size =3D=3D -1) {
>              error_report("unable to load firmware image '%s'",
>                            machine->firmware);
> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index 2a8507b8b0..bd35907684 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -118,7 +118,7 @@ static uint64_t load_kernel(MIPSCPU *cpu)
>      initrd_size =3D 0;
>      initrd_offset =3D 0;
>      if (loaderparams.initrd_filename) {
> -        initrd_size =3D get_image_size(loaderparams.initrd_filename);
> +        initrd_size =3D get_image_size(loaderparams.initrd_filename, NUL=
L);
>          if (initrd_size > 0) {
>              initrd_offset =3D ROUND_UP(kernel_high, INITRD_PAGE_SIZE);
>              if (initrd_offset + initrd_size > loaderparams.ram_size) {
> @@ -127,8 +127,9 @@ static uint64_t load_kernel(MIPSCPU *cpu)
>                  exit(1);
>              }
>              initrd_size =3D load_image_targphys(loaderparams.initrd_file=
name,
> -                                              initrd_offset,
> -                                              loaderparams.ram_size - in=
itrd_offset);
> +                                        initrd_offset,
> +                                        loaderparams.ram_size - initrd_o=
ffset,
> +                                        NULL);
>          }
>          if (initrd_size =3D=3D (target_ulong) -1) {
>              error_report("could not load initial ram disk '%s'",
> @@ -264,7 +265,7 @@ static void mips_fuloong2e_init(MachineState *machine=
)
>                                    machine->firmware ?: FULOONG_BIOSNAME)=
;
>          if (filename) {
>              bios_size =3D load_image_targphys(filename, 0x1fc00000LL,
> -                                            BIOS_SIZE);
> +                                            BIOS_SIZE, NULL);
>              g_free(filename);
>          } else {
>              bios_size =3D -1;
> diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
> index 7fb0b97a38..1d6bdc0091 100644
> --- a/hw/mips/jazz.c
> +++ b/hw/mips/jazz.c
> @@ -245,7 +245,7 @@ static void mips_jazz_init(MachineState *machine,
>                                machine->firmware ?: bios_name);
>      if (filename) {
>          bios_size =3D load_image_targphys(filename, 0xfff00000LL,
> -                                        MAGNUM_BIOS_SIZE);
> +                                        MAGNUM_BIOS_SIZE, NULL);
>          g_free(filename);
>      } else {
>          bios_size =3D -1;
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index 672083dec9..77dc895648 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -371,7 +371,7 @@ static uint64_t load_kernel(CPUMIPSState *env)
>      initrd_size =3D 0;
>      initrd_offset =3D 0;
>      if (loaderparams.initrd_filename) {
> -        initrd_size =3D get_image_size(loaderparams.initrd_filename);
> +        initrd_size =3D get_image_size(loaderparams.initrd_filename, NUL=
L);
>          if (initrd_size > 0) {
>              initrd_offset =3D MAX(loader_memmap[LOADER_INITRD].base,
>                                  ROUND_UP(kernel_high, INITRD_PAGE_SIZE))=
;
> @@ -383,8 +383,9 @@ static uint64_t load_kernel(CPUMIPSState *env)
>              }
>
>              initrd_size =3D load_image_targphys(loaderparams.initrd_file=
name,
> -                                              initrd_offset,
> -                                              loaderparams.ram_size - in=
itrd_offset);
> +                                        initrd_offset,
> +                                        loaderparams.ram_size - initrd_o=
ffset,
> +                                        NULL);
>          }
>
>          if (initrd_size =3D=3D (target_ulong) -1) {
> @@ -650,7 +651,8 @@ static void mips_loongson3_virt_init(MachineState *ma=
chine)
>          if (filename) {
>              bios_size =3D load_image_targphys(filename,
>                                              virt_memmap[VIRT_BIOS_ROM].b=
ase,
> -                                            virt_memmap[VIRT_BIOS_ROM].s=
ize);
> +                                            virt_memmap[VIRT_BIOS_ROM].s=
ize,
> +                                            NULL);
>              g_free(filename);
>          } else {
>              bios_size =3D -1;
> diff --git a/hw/mips/malta.c b/hw/mips/malta.c
> index 02da629b5a..806e8d5078 100644
> --- a/hw/mips/malta.c
> +++ b/hw/mips/malta.c
> @@ -892,7 +892,7 @@ static uint64_t load_kernel(void)
>      initrd_size =3D 0;
>      initrd_offset =3D 0;
>      if (loaderparams.initrd_filename) {
> -        initrd_size =3D get_image_size(loaderparams.initrd_filename);
> +        initrd_size =3D get_image_size(loaderparams.initrd_filename, NUL=
L);
>          if (initrd_size > 0) {
>              /*
>               * The kernel allocates the bootmap memory in the low memory=
 after
> @@ -908,8 +908,9 @@ static uint64_t load_kernel(void)
>                  exit(1);
>              }
>              initrd_size =3D load_image_targphys(loaderparams.initrd_file=
name,
> -                                              initrd_offset,
> -                                              loaderparams.ram_size - in=
itrd_offset);
> +                                        initrd_offset,
> +                                        loaderparams.ram_size - initrd_o=
ffset,
> +                                        NULL);
>          }
>          if (initrd_size =3D=3D (target_ulong) -1) {
>              error_report("could not load initial ram disk '%s'",
> @@ -1176,7 +1177,7 @@ void mips_malta_init(MachineState *machine)
>                                        machine->firmware ?: bios_name);
>              if (filename) {
>                  bios_size =3D load_image_targphys(filename, FLASH_ADDRES=
S,
> -                                                BIOS_SIZE);
> +                                                BIOS_SIZE, NULL);
>                  g_free(filename);
>              } else {
>                  bios_size =3D -1;
> diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
> index 7797e61c7f..0d4d6c0d87 100644
> --- a/hw/nubus/nubus-device.c
> +++ b/hw/nubus/nubus-device.c
> @@ -68,7 +68,7 @@ static void nubus_device_realize(DeviceState *dev, Erro=
r **errp)
>              path =3D g_strdup(nd->romfile);
>          }
>
> -        size =3D get_image_size(path);
> +        size =3D get_image_size(path, NULL);
>          if (size < 0) {
>              error_setg(errp, "failed to find romfile \"%s\"", nd->romfil=
e);
>              g_free(path);
> diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
> index c81efe8138..db6fea071e 100644
> --- a/hw/openrisc/boot.c
> +++ b/hw/openrisc/boot.c
> @@ -44,7 +44,8 @@ hwaddr openrisc_load_kernel(ram_addr_t ram_size,
>          if (kernel_size < 0) {
>              kernel_size =3D load_image_targphys(kernel_filename,
>                                                KERNEL_LOAD_ADDR,
> -                                              ram_size - KERNEL_LOAD_ADD=
R);
> +                                              ram_size - KERNEL_LOAD_ADD=
R,
> +                                              NULL);
>              high_addr =3D KERNEL_LOAD_ADDR + kernel_size;
>          }
>
> @@ -74,7 +75,7 @@ hwaddr openrisc_load_initrd(void *fdt, const char *file=
name,
>
>      size =3D load_ramdisk(filename, start, mem_size - start);
>      if (size < 0) {
> -        size =3D load_image_targphys(filename, start, mem_size - start);
> +        size =3D load_image_targphys(filename, start, mem_size - start, =
NULL);
>          if (size < 0) {
>              error_report("could not load ramdisk '%s'", filename);
>              exit(1);
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index acc03fd470..738b0c41ae 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2557,7 +2557,7 @@ static void pci_add_option_rom(PCIDevice *pdev, boo=
l is_default_rom,
>              path =3D g_strdup(pdev->romfile);
>          }
>
> -        size =3D get_image_size(path);
> +        size =3D get_image_size(path, NULL);
>          if (size < 0) {
>              error_setg(errp, "failed to find romfile \"%s\"", pdev->romf=
ile);
>              return;
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 12279f42bc..5c5acc9872 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -324,7 +324,7 @@ static void amigaone_init(MachineState *machine)
>              error_report("Could not find firmware '%s'", machine->firmwa=
re);
>              exit(1);
>          }
> -        sz =3D load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
> +        sz =3D load_image_targphys(filename, PROM_ADDR, PROM_SIZE, NULL)=
;
>          if (sz <=3D 0 || sz > PROM_SIZE) {
>              error_report("Could not load firmware '%s'", filename);
>              exit(1);
> @@ -413,7 +413,7 @@ static void amigaone_init(MachineState *machine)
>          loadaddr =3D ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
>          loadaddr =3D MAX(loadaddr, INITRD_MIN_ADDR);
>          sz =3D load_image_targphys(machine->initrd_filename, loadaddr,
> -                                 bi->bd_info - loadaddr);
> +                                 bi->bd_info - loadaddr, NULL);
>          if (sz <=3D 0) {
>              error_report("Could not load initrd '%s'",
>                           machine->initrd_filename);
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 723c97fad2..30937a4a92 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1227,7 +1227,7 @@ void ppce500_init(MachineState *machine)
>          kernel_base =3D cur_base;
>          kernel_size =3D load_image_targphys(machine->kernel_filename,
>                                            cur_base,
> -                                          machine->ram_size - cur_base);
> +                                          machine->ram_size - cur_base, =
NULL);
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'",
>                           machine->kernel_filename);
> @@ -1241,7 +1241,8 @@ void ppce500_init(MachineState *machine)
>      if (machine->initrd_filename) {
>          initrd_base =3D (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
>          initrd_size =3D load_image_targphys(machine->initrd_filename, in=
itrd_base,
> -                                          machine->ram_size - initrd_bas=
e);
> +                                          machine->ram_size - initrd_bas=
e,
> +                                          NULL);
>
>          if (initrd_size < 0) {
>              error_report("could not load initial ram disk '%s'",
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 0b6e096116..728525759c 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -188,7 +188,8 @@ static void ppc_core99_init(MachineState *machine)
>
>          if (bios_size <=3D 0) {
>              /* or load binary ROM image */
> -            bios_size =3D load_image_targphys(filename, PROM_BASE, PROM_=
SIZE);
> +            bios_size =3D load_image_targphys(filename, PROM_BASE, PROM_=
SIZE,
> +                    NULL);
>          }
>          g_free(filename);
>      }
> @@ -210,7 +211,8 @@ static void ppc_core99_init(MachineState *machine)
>          if (kernel_size < 0) {
>              kernel_size =3D load_image_targphys(machine->kernel_filename=
,
>                                                kernel_base,
> -                                              machine->ram_size - kernel=
_base);
> +                                              machine->ram_size - kernel=
_base,
> +                                              NULL);
>          }
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'",
> @@ -222,7 +224,8 @@ static void ppc_core99_init(MachineState *machine)
>              initrd_base =3D TARGET_PAGE_ALIGN(kernel_base + kernel_size =
+ KERNEL_GAP);
>              initrd_size =3D load_image_targphys(machine->initrd_filename=
,
>                                                initrd_base,
> -                                              machine->ram_size - initrd=
_base);
> +                                              machine->ram_size - initrd=
_base,
> +                                              NULL);
>              if (initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               machine->initrd_filename);
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 40ae936ad8..a067a191cd 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -143,7 +143,8 @@ static void ppc_heathrow_init(MachineState *machine)
>
>          if (bios_size <=3D 0) {
>              /* or if could not load ELF try loading a binary ROM image *=
/
> -            bios_size =3D load_image_targphys(filename, PROM_BASE, PROM_=
SIZE);
> +            bios_size =3D load_image_targphys(filename, PROM_BASE, PROM_=
SIZE,
> +                    NULL);
>              bios_addr =3D PROM_BASE;
>          }
>          g_free(filename);
> @@ -166,7 +167,8 @@ static void ppc_heathrow_init(MachineState *machine)
>          if (kernel_size < 0) {
>              kernel_size =3D load_image_targphys(machine->kernel_filename=
,
>                                                kernel_base,
> -                                              machine->ram_size - kernel=
_base);
> +                                              machine->ram_size - kernel=
_base,
> +                                              NULL);
>          }
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'",
> @@ -179,7 +181,8 @@ static void ppc_heathrow_init(MachineState *machine)
>                                              KERNEL_GAP);
>              initrd_size =3D load_image_targphys(machine->initrd_filename=
,
>                                                initrd_base,
> -                                              machine->ram_size - initrd=
_base);
> +                                              machine->ram_size - initrd=
_base,
> +                                              NULL);
>              if (initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               machine->initrd_filename);
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index e15cf96427..7fa14fd0e6 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -163,7 +163,8 @@ static void pegasos2_init(MachineState *machine)
>      sz =3D load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
>                    ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
>      if (sz <=3D 0) {
> -        sz =3D load_image_targphys(filename, pm->vof ? 0 : PROM_ADDR, PR=
OM_SIZE);
> +        sz =3D load_image_targphys(filename, pm->vof ? 0 : PROM_ADDR, PR=
OM_SIZE,
> +                NULL);
>      }
>      if (sz <=3D 0 || sz > PROM_SIZE) {
>          error_report("Could not load firmware '%s'", filename);
> @@ -259,7 +260,7 @@ static void pegasos2_init(MachineState *machine)
>          pm->initrd_addr =3D ROUND_UP(pm->initrd_addr, 4);
>          pm->initrd_addr =3D MAX(pm->initrd_addr, INITRD_MIN_ADDR);
>          sz =3D load_image_targphys(machine->initrd_filename, pm->initrd_=
addr,
> -                                 machine->ram_size - pm->initrd_addr);
> +                                 machine->ram_size - pm->initrd_addr, NU=
LL);
>          if (sz <=3D 0) {
>              error_report("Could not load initrd '%s'",
>                           machine->initrd_filename);
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index f0469cdb8b..a3e5203970 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1068,7 +1068,8 @@ static void pnv_init(MachineState *machine)
>          exit(1);
>      }
>
> -    fw_size =3D load_image_targphys(fw_filename, pnv->fw_load_addr, FW_M=
AX_SIZE);
> +    fw_size =3D load_image_targphys(fw_filename, pnv->fw_load_addr, FW_M=
AX_SIZE,
> +                                    NULL);
>      if (fw_size < 0) {
>          error_report("Could not load OPAL firmware '%s'", fw_filename);
>          exit(1);
> @@ -1080,7 +1081,8 @@ static void pnv_init(MachineState *machine)
>          long kernel_size;
>
>          kernel_size =3D load_image_targphys(machine->kernel_filename,
> -                                          KERNEL_LOAD_ADDR, KERNEL_MAX_S=
IZE);
> +                                          KERNEL_LOAD_ADDR, KERNEL_MAX_S=
IZE,
> +                                          NULL);
>          if (kernel_size < 0) {
>              error_report("Could not load kernel '%s'",
>                           machine->kernel_filename);
> @@ -1092,7 +1094,7 @@ static void pnv_init(MachineState *machine)
>      if (machine->initrd_filename) {
>          pnv->initrd_base =3D INITRD_LOAD_ADDR;
>          pnv->initrd_size =3D load_image_targphys(machine->initrd_filenam=
e,
> -                                  pnv->initrd_base, INITRD_MAX_SIZE);
> +                                  pnv->initrd_base, INITRD_MAX_SIZE, NUL=
L);
>          if (pnv->initrd_size < 0) {
>              error_report("Could not load initial ram disk '%s'",
>                           machine->initrd_filename);
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 6fff0d8afb..7c66912c10 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -242,7 +242,8 @@ static void bamboo_init(MachineState *machine)
>      /* Load initrd. */
>      if (initrd_filename) {
>          initrd_size =3D load_image_targphys(initrd_filename, RAMDISK_ADD=
R,
> -                                          machine->ram_size - RAMDISK_AD=
DR);
> +                                          machine->ram_size - RAMDISK_AD=
DR,
> +                                          NULL);
>
>          if (initrd_size < 0) {
>              error_report("could not load ram disk '%s' at %x",
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 982e40e53e..edd3da7102 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -280,7 +280,7 @@ static void ibm_40p_init(MachineState *machine)
>      bios_size =3D load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL,=
 NULL,
>                           ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
>      if (bios_size < 0) {
> -        bios_size =3D load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE=
);
> +        bios_size =3D load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE=
, NULL);
>      }
>      if (bios_size < 0 || bios_size > BIOS_SIZE) {
>          error_report("Could not load bios image '%s'", filename);
> @@ -380,7 +380,8 @@ static void ibm_40p_init(MachineState *machine)
>          kernel_base =3D KERNEL_LOAD_ADDR;
>          kernel_size =3D load_image_targphys(machine->kernel_filename,
>                                            kernel_base,
> -                                          machine->ram_size - kernel_bas=
e);
> +                                          machine->ram_size - kernel_bas=
e,
> +                                          NULL);
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'",
>                           machine->kernel_filename);
> @@ -393,7 +394,8 @@ static void ibm_40p_init(MachineState *machine)
>              initrd_base =3D INITRD_LOAD_ADDR;
>              initrd_size =3D load_image_targphys(machine->initrd_filename=
,
>                                                initrd_base,
> -                                              machine->ram_size - initrd=
_base);
> +                                              machine->ram_size - initrd=
_base,
> +                                              NULL);
>              if (initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               machine->initrd_filename);
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index ee31bd8f34..68d3eacbff 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -494,7 +494,8 @@ static void sam460ex_init(MachineState *machine)
>      if (machine->initrd_filename) {
>          initrd_size =3D load_image_targphys(machine->initrd_filename,
>                                            RAMDISK_ADDR,
> -                                          machine->ram_size - RAMDISK_AD=
DR);
> +                                          machine->ram_size - RAMDISK_AD=
DR,
> +                                          NULL);
>          if (initrd_size < 0) {
>              error_report("could not load ram disk '%s' at %x",
>                      machine->initrd_filename, RAMDISK_ADDR);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 97ab6bebd2..c6e9d46761 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2824,7 +2824,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>          error_report("Could not find LPAR firmware '%s'", bios_name);
>          exit(1);
>      }
> -    fw_size =3D load_image_targphys(filename, 0, FW_MAX_SIZE);
> +    fw_size =3D load_image_targphys(filename, 0, FW_MAX_SIZE, NULL);
>      if (fw_size <=3D 0) {
>          error_report("Could not load LPAR firmware '%s'", filename);
>          exit(1);
> @@ -3089,7 +3089,8 @@ static void spapr_machine_init(MachineState *machin=
e)
>              spapr->initrd_size =3D load_image_targphys(initrd_filename,
>                                                       spapr->initrd_base,
>                                                       load_limit
> -                                                     - spapr->initrd_bas=
e);
> +                                                     - spapr->initrd_bas=
e,
> +                                                     NULL);
>              if (spapr->initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               initrd_filename);
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index c9969ae48a..00d9ab7509 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -253,7 +253,7 @@ static void virtex_init(MachineState *machine)
>              /* If we failed loading ELF's try a raw image.  */
>              kernel_size =3D load_image_targphys(kernel_filename,
>                                                boot_offset,
> -                                              machine->ram_size);
> +                                              machine->ram_size, NULL);
>              boot_info.bootstrap_pc =3D boot_offset;
>              high =3D boot_info.bootstrap_pc + kernel_size + 8192;
>          }
> @@ -264,7 +264,8 @@ static void virtex_init(MachineState *machine)
>          if (machine->initrd_filename) {
>              initrd_base =3D high =3D ROUND_UP(high, 4);
>              initrd_size =3D load_image_targphys(machine->initrd_filename=
,
> -                                              high, machine->ram_size - =
high);
> +                                              high, machine->ram_size - =
high,
> +                                              NULL);
>
>              if (initrd_size < 0) {
>                  error_report("couldn't load ram disk '%s'",
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 828a867be3..f38078c8c2 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -172,7 +172,8 @@ target_ulong riscv_load_firmware(const char *firmware=
_filename,
>
>      firmware_size =3D load_image_targphys_as(firmware_filename,
>                                             *firmware_load_addr,
> -                                           current_machine->ram_size, NU=
LL);
> +                                           current_machine->ram_size, NU=
LL,
> +                                           NULL);
>
>      if (firmware_size > 0) {
>          return *firmware_load_addr + firmware_size;
> @@ -207,7 +208,7 @@ static void riscv_load_initrd(MachineState *machine, =
RISCVBootInfo *info)
>
>      size =3D load_ramdisk(filename, start, mem_size - start);
>      if (size =3D=3D -1) {
> -        size =3D load_image_targphys(filename, start, mem_size - start);
> +        size =3D load_image_targphys(filename, start, mem_size - start, =
NULL);
>          if (size =3D=3D -1) {
>              error_report("could not load ramdisk '%s'", filename);
>              exit(1);
> @@ -262,7 +263,7 @@ void riscv_load_kernel(MachineState *machine,
>      }
>
>      kernel_size =3D load_image_targphys_as(kernel_filename, kernel_start=
_addr,
> -                                         current_machine->ram_size, NULL=
);
> +                                         current_machine->ram_size, NULL=
, NULL);
>      if (kernel_size > 0) {
>          info->kernel_size =3D kernel_size;
>          info->image_low_addr =3D kernel_start_addr;
> diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
> index 5b9004e9e1..ed91c63178 100644
> --- a/hw/rx/rx-gdbsim.c
> +++ b/hw/rx/rx-gdbsim.c
> @@ -63,7 +63,7 @@ static void rx_load_image(RXCPU *cpu, const char *filen=
ame,
>      long kernel_size;
>      int i;
>
> -    kernel_size =3D load_image_targphys(filename, start, size);
> +    kernel_size =3D load_image_targphys(filename, start, size, NULL);
>      if (kernel_size < 0) {
>          fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
>          exit(1);
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 2f082396c7..4f69655ca4 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -169,7 +169,7 @@ static void s390_ipl_realize(DeviceState *dev, Error =
**errp)
>          } else {
>              /* Try to load non-ELF file */
>              bios_size =3D load_image_targphys(bios_filename, ZIPL_IMAGE_=
START,
> -                                            4096);
> +                                            4096, NULL);
>              ipl->bios_start_addr =3D ZIPL_IMAGE_START;
>          }
>          g_free(bios_filename);
> @@ -188,7 +188,8 @@ static void s390_ipl_realize(DeviceState *dev, Error =
**errp)
>                                 &pentry, NULL,
>                                 NULL, NULL, ELFDATA2MSB, EM_S390, 0, 0);
>          if (kernel_size < 0) {
> -            kernel_size =3D load_image_targphys(ipl->kernel, 0, ms->ram_=
size);
> +            kernel_size =3D load_image_targphys(ipl->kernel, 0, ms->ram_=
size,
> +                    NULL);
>              if (kernel_size < 0) {
>                  error_setg(errp, "could not load kernel '%s'", ipl->kern=
el);
>                  return;
> @@ -247,7 +248,8 @@ static void s390_ipl_realize(DeviceState *dev, Error =
**errp)
>                  initrd_offset +=3D 0x100000;
>              }
>              initrd_size =3D load_image_targphys(ipl->initrd, initrd_offs=
et,
> -                                              ms->ram_size - initrd_offs=
et);
> +                                              ms->ram_size - initrd_offs=
et,
> +                                              NULL);
>              if (initrd_size =3D=3D -1) {
>                  error_setg(errp, "could not load initrd '%s'", ipl->init=
rd);
>                  return;
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index d68c94e82e..010be6d539 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -329,8 +329,9 @@ static void r2d_init(MachineState *machine)
>          int kernel_size;
>
>          kernel_size =3D load_image_targphys(kernel_filename,
> -                                          SDRAM_BASE + LINUX_LOAD_OFFSET=
,
> -                                          INITRD_LOAD_OFFSET - LINUX_LOA=
D_OFFSET);
> +                                        SDRAM_BASE + LINUX_LOAD_OFFSET,
> +                                        INITRD_LOAD_OFFSET - LINUX_LOAD_=
OFFSET,
> +                                        NULL);
>          if (kernel_size < 0) {
>              error_report("qemu: could not load kernel '%s'", kernel_file=
name);
>              exit(1);
> @@ -350,7 +351,8 @@ static void r2d_init(MachineState *machine)
>
>          initrd_size =3D load_image_targphys(initrd_filename,
>                                            SDRAM_BASE + INITRD_LOAD_OFFSE=
T,
> -                                          SDRAM_SIZE - INITRD_LOAD_OFFSE=
T);
> +                                          SDRAM_SIZE - INITRD_LOAD_OFFSE=
T,
> +                                          NULL);
>
>          if (initrd_size < 0) {
>              error_report("qemu: could not load initrd '%s'", initrd_file=
name);
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 13e21a9c43..7558b2ad83 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1340,7 +1340,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              return;
>          }
>
> -        size =3D get_image_size(val);
> +        size =3D get_image_size(val, NULL);
>          if (size =3D=3D -1 || size < sizeof(struct smbios_structure_head=
er)) {
>              error_setg(errp, "Cannot read SMBIOS file %s", val);
>              return;
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 09d2cec488..631c6113b5 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -349,7 +349,7 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>
>      if (filename) {
> -        bios_size =3D get_image_size(filename);
> +        bios_size =3D get_image_size(filename, NULL);
>      } else {
>          bios_size =3D -1;
>      }
> @@ -360,7 +360,7 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>      }
>
>      if (bios_size > 0) {
> -        ret =3D load_image_targphys(filename, LEON3_PROM_OFFSET, bios_si=
ze);
> +        ret =3D load_image_targphys(filename, LEON3_PROM_OFFSET, bios_si=
ze, NULL);
>          if (ret < 0 || ret > prom_size) {
>              error_report("could not load prom '%s'", filename);
>              exit(1);
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 8ac7e625ef..53d7ae08ae 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -245,7 +245,8 @@ static unsigned long sun4m_load_kernel(const char *ke=
rnel_filename,
>          if (kernel_size < 0)
>              kernel_size =3D load_image_targphys(kernel_filename,
>                                                KERNEL_LOAD_ADDR,
> -                                              RAM_size - KERNEL_LOAD_ADD=
R);
> +                                              RAM_size - KERNEL_LOAD_ADD=
R,
> +                                              NULL);
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
>              exit(1);
> @@ -256,7 +257,8 @@ static unsigned long sun4m_load_kernel(const char *ke=
rnel_filename,
>          if (initrd_filename) {
>              *initrd_size =3D load_image_targphys(initrd_filename,
>                                                 INITRD_LOAD_ADDR,
> -                                               RAM_size - INITRD_LOAD_AD=
DR);
> +                                               RAM_size - INITRD_LOAD_AD=
DR,
> +                                               NULL);
>              if ((int)*initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               initrd_filename);
> @@ -700,7 +702,7 @@ static void prom_init(hwaddr addr, const char *bios_n=
ame)
>                         translate_prom_address, &addr, NULL,
>                         NULL, NULL, NULL, ELFDATA2MSB, EM_SPARC, 0, 0);
>          if (ret < 0 || ret > PROM_SIZE_MAX) {
> -            ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX);
> +            ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX, N=
ULL);
>          }
>          g_free(filename);
>      } else {
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index e9f9b0a4cb..82c3e7c855 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -182,7 +182,8 @@ static uint64_t sun4u_load_kernel(const char *kernel_=
filename,
>          if (kernel_size < 0) {
>              kernel_size =3D load_image_targphys(kernel_filename,
>                                                KERNEL_LOAD_ADDR,
> -                                              RAM_size - KERNEL_LOAD_ADD=
R);
> +                                              RAM_size - KERNEL_LOAD_ADD=
R,
> +                                              NULL);
>          }
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
> @@ -195,7 +196,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_=
filename,
>
>              *initrd_size =3D load_image_targphys(initrd_filename,
>                                                 *initrd_addr,
> -                                               RAM_size - *initrd_addr);
> +                                               RAM_size - *initrd_addr, =
NULL);
>              if ((int)*initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               initrd_filename);
> @@ -437,7 +438,7 @@ static void prom_init(hwaddr addr, const char *bios_n=
ame)
>          ret =3D load_elf(filename, NULL, translate_prom_address, &addr,
>                         NULL, NULL, NULL, NULL, ELFDATA2MSB, EM_SPARCV9, =
0, 0);
>          if (ret < 0 || ret > PROM_SIZE_MAX) {
> -            ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX);
> +            ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX, N=
ULL);
>          }
>          g_free(filename);
>      } else {
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index 55de1a7a07..db3b015549 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -381,7 +381,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board,=
 MachineState *machine)
>              if (initrd_size < 0) {
>                  initrd_size =3D load_image_targphys(initrd_filename,
>                                                    cur_lowmem,
> -                                                  lowmem_end - cur_lowme=
m);
> +                                                  lowmem_end - cur_lowme=
m,
> +                                                  NULL);
>              }
>              if (initrd_size < 0) {
>                  error_report("could not load initrd '%s'", initrd_filena=
me);
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index c96b5e141c..d035e72748 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -1,6 +1,7 @@
>  #ifndef LOADER_H
>  #define LOADER_H
>  #include "hw/nvram/fw_cfg.h"
> +#include "qemu/typedefs.h"
>
>  /* loader.c */
>  /**
> @@ -10,7 +11,7 @@
>   * Returns the size of the image file on success, -1 otherwise.
>   * On error, errno is also set as appropriate.
>   */
> -int64_t get_image_size(const char *filename);
> +int64_t get_image_size(const char *filename, Error **errp);
>  /**
>   * load_image_size: load an image file into specified buffer
>   * @filename: Path to the image file
> @@ -41,7 +42,8 @@ ssize_t load_image_size(const char *filename, void *add=
r, size_t size);
>   * Returns the size of the loaded image on success, -1 otherwise.
>   */
>  ssize_t load_image_targphys_as(const char *filename,
> -                               hwaddr addr, uint64_t max_sz, AddressSpac=
e *as);
> +                               hwaddr addr, uint64_t max_sz, AddressSpac=
e *as,
> +                               Error **errp);
>
>  /**load_targphys_hex_as:
>   * @filename: Path to the .hex file
> @@ -61,7 +63,7 @@ ssize_t load_targphys_hex_as(const char *filename, hwad=
dr *entry,
>   * an AddressSpace.
>   */
>  ssize_t load_image_targphys(const char *filename, hwaddr,
> -                            uint64_t max_sz);
> +                            uint64_t max_sz, Error **errp);
>
>  /**
>   * load_image_mr: load an image into a memory region
> diff --git a/system/device_tree.c b/system/device_tree.c
> index aa3fe9516f..7850b90fa7 100644
> --- a/system/device_tree.c
> +++ b/system/device_tree.c
> @@ -83,7 +83,7 @@ void *load_device_tree(const char *filename_path, int *=
sizep)
>      void *fdt =3D NULL;
>
>      *sizep =3D 0;
> -    dt_size =3D get_image_size(filename_path);
> +    dt_size =3D get_image_size(filename_path, NULL);
>      if (dt_size < 0) {
>          error_report("Unable to get size of device tree file '%s'",
>                       filename_path);
> --
> 2.51.0
>
>

