Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CB5D5D69F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 01:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Dcf-0005Bt-W9; Thu, 07 Nov 2024 20:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t9Dce-0005Ba-FI; Thu, 07 Nov 2024 20:17:12 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t9Dcc-0007IQ-RF; Thu, 07 Nov 2024 20:17:12 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5139cd01814so573777e0c.0; 
 Thu, 07 Nov 2024 17:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731028629; x=1731633429; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GY4X7Jukfu73JXdcTDfHYASVuVcZyb/zo+u/lRG5tE=;
 b=AuHPODUcs+SLT0rtcyJPfu729XkcSWVTc+SmKSjDCHF7M4shdJZfOboLYeeNahv8yc
 /rY1boWhz5umXAxcPdoMfIH7eeDMk46N7I89cF+Rz98xi4FHbI+/YjEGo5vvwm/L1YV1
 N7TWSjfmszT27DPQyrIlqR3fUgVSbTHfYXb8DZ0tHbpw4HwYLjvsNGE/E+SMiBNwJnXv
 1PGBYKhhxASmg/xUJB6OdZVq6gxj4YSbgXOgdKTav5SRiQBNTCPL86HRhb13xdwYUto7
 6vnE4EZ8I5CIOWd2OJ0siL2QSGX3RYgxW6QNvzCZHWbKmQqfSkY5hdNI5YGzLEiVcdwZ
 PvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731028629; x=1731633429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2GY4X7Jukfu73JXdcTDfHYASVuVcZyb/zo+u/lRG5tE=;
 b=afzTVEI/51LzOn7G9qa5lU2fsQYfMddnMW15bHEwic/iuCShZ90fjbA4twTtpl4m77
 SpCedNBP5JJVUHLJ1jKPLQSroqm0fLPrzefGPhnNp8fF2LRQUneb8dfNsxYa+PHSTErs
 8RdvtJFcQGIlQVayDrfokLVAGoN9TaDm6XEEvXOaHulRgYCOQLiSrYAHc6uV9LzP/LXM
 SG0sDdkdf11UwQdRktzvmDhrhlhB8FplTjPWwg/MuJjw18bofRjtglC9Ma5i56m+n7wx
 tf81BarKNRonbHBAnh9kr4x824J83042y5Spz0yptV8+Lu0e0ZpxLr6ywV2dRpUZ6ifO
 6XWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK32akVpLvP0m1f9fkV8Sh5ykI1YdGAdDGxHESG65Cziev39hYtVLUK46Q0/3PVgZQlIu7laF0G8aO@nongnu.org
X-Gm-Message-State: AOJu0YwY1IC0MibgpON/cv4IBsImkmD4X8EW3bNB+PNgr0mURY0OvHA0
 dXVQ5liIYSvKqzpi7EjPZWhMmf+O07ARl3/pWL1s5KHKJe04fSrUzxjXIKgeBQtJQZdXtX/XmCa
 yiZRet9DCd9bLVvpfrQBm+S8bHIY=
X-Google-Smtp-Source: AGHT+IGukBPkGBM+2PLY2YUvlY/vLDz3hz6R9wN7tfz9i+yMl8notVakeaUJSnbnbg/7A9GV1YP7Jqja8IFhDJYgbZg=
X-Received: by 2002:a05:6122:2a4f:b0:50d:85d7:d94b with SMTP id
 71dfb90a1353d-51401ebcea6mr1215752e0c.11.1731028629187; Thu, 07 Nov 2024
 17:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20241107063133.28339-1-jim.shu@sifive.com>
 <20241107063133.28339-2-jim.shu@sifive.com>
In-Reply-To: <20241107063133.28339-2-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 8 Nov 2024 11:16:43 +1000
Message-ID: <CAKmqyKNdpSHCzsMZKpfe+xSupbRxz58jJXYV_RwH2SFeze0DBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/riscv: Support to load DTB after 3GB memory on
 64-bit system.
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Thu, Nov 7, 2024 at 4:32=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> Larger initrd image will overlap the DTB at 3GB address. Since 64-bit
> system doesn't have 32-bit addressable issue, we just load DTB to the end
> of dram in 64-bit system.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  hw/riscv/boot.c            | 8 ++++++--
>  hw/riscv/microchip_pfsoc.c | 4 ++--
>  hw/riscv/sifive_u.c        | 4 ++--
>  hw/riscv/spike.c           | 4 ++--
>  hw/riscv/virt.c            | 2 +-
>  include/hw/riscv/boot.h    | 2 +-
>  6 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 2e319168db..4e4e106a2b 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -293,7 +293,7 @@ out:
>   * The FDT is fdt_packed() during the calculation.
>   */
>  uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
> -                                MachineState *ms)
> +                                MachineState *ms, RISCVHartArrayState *h=
arts)
>  {
>      int ret =3D fdt_pack(ms->fdt);
>      hwaddr dram_end, temp;
> @@ -321,7 +321,11 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hw=
addr dram_size,
>       * Thus, put it at an 2MB aligned address that less than fdt size fr=
om the
>       * end of dram or 3GB whichever is lesser.
>       */

We should probably update this comment to describe what happens for
64-bit systems.

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> -    temp =3D (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram=
_end;
> +    if (!riscv_is_32bit(harts)) {
> +        temp =3D dram_end;
> +    } else {
> +        temp =3D (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : =
dram_end;
> +    }
>
>      return QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
>  }
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index f9a3b43d2e..ba8b0a2c26 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -519,7 +519,7 @@ static void microchip_icicle_kit_machine_init(Machine=
State *machine)
>      bool kernel_as_payload =3D false;
>      target_ulong firmware_end_addr, kernel_start_addr;
>      uint64_t kernel_entry;
> -    uint32_t fdt_load_addr;
> +    uint64_t fdt_load_addr;
>      DriveInfo *dinfo =3D drive_get(IF_SD, 0, 0);
>
>      /* Sanity check on RAM size */
> @@ -625,7 +625,7 @@ static void microchip_icicle_kit_machine_init(Machine=
State *machine)
>          /* Compute the fdt load address in dram */
>          fdt_load_addr =3D riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_=
DRAM_LO].base,
>                                                 memmap[MICROCHIP_PFSOC_DR=
AM_LO].size,
> -                                               machine);
> +                                               machine, &s->soc.u_cpus);
>          riscv_load_fdt(fdt_load_addr, machine->fdt);
>
>          /* Load the reset vector */
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index c5e74126b1..05467e833a 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -519,7 +519,7 @@ static void sifive_u_machine_init(MachineState *machi=
ne)
>      const char *firmware_name;
>      uint32_t start_addr_hi32 =3D 0x00000000;
>      int i;
> -    uint32_t fdt_load_addr;
> +    uint64_t fdt_load_addr;
>      uint64_t kernel_entry;
>      DriveInfo *dinfo;
>      BlockBackend *blk;
> @@ -606,7 +606,7 @@ static void sifive_u_machine_init(MachineState *machi=
ne)
>
>      fdt_load_addr =3D riscv_compute_fdt_addr(memmap[SIFIVE_U_DEV_DRAM].b=
ase,
>                                             memmap[SIFIVE_U_DEV_DRAM].siz=
e,
> -                                           machine);
> +                                           machine, &s->soc.u_cpus);
>      riscv_load_fdt(fdt_load_addr, machine->fdt);
>
>      if (!riscv_is_32bit(&s->soc.u_cpus)) {
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index fceb91d946..acd7ab1ae1 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -201,7 +201,7 @@ static void spike_board_init(MachineState *machine)
>      hwaddr firmware_load_addr =3D memmap[SPIKE_DRAM].base;
>      target_ulong kernel_start_addr;
>      char *firmware_name;
> -    uint32_t fdt_load_addr;
> +    uint64_t fdt_load_addr;
>      uint64_t kernel_entry;
>      char *soc_name;
>      int i, base_hartid, hart_count;
> @@ -317,7 +317,7 @@ static void spike_board_init(MachineState *machine)
>
>      fdt_load_addr =3D riscv_compute_fdt_addr(memmap[SPIKE_DRAM].base,
>                                             memmap[SPIKE_DRAM].size,
> -                                           machine);
> +                                           machine, &s->soc[0]);
>      riscv_load_fdt(fdt_load_addr, machine->fdt);
>
>      /* load the reset vector */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 45a8c4f819..761bce3304 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1424,7 +1424,7 @@ static void virt_machine_done(Notifier *notifier, v=
oid *data)
>
>      fdt_load_addr =3D riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
>                                             memmap[VIRT_DRAM].size,
> -                                           machine);
> +                                           machine, &s->soc[0]);
>      riscv_load_fdt(fdt_load_addr, machine->fdt);
>
>      /* load the reset vector */
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index f778b560de..34a80c5ff4 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -49,7 +49,7 @@ target_ulong riscv_load_kernel(MachineState *machine,
>                                 bool load_initrd,
>                                 symbol_fn_t sym_cb);
>  uint64_t riscv_compute_fdt_addr(hwaddr dram_start, uint64_t dram_size,
> -                                MachineState *ms);
> +                                MachineState *ms, RISCVHartArrayState *h=
arts);
>  void riscv_load_fdt(hwaddr fdt_addr, void *fdt);
>  void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayStat=
e *harts,
>                                 hwaddr saddr,
> --
> 2.17.1
>
>

