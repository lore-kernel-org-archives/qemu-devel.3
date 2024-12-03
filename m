Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C16AE6C60C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMYK-00073A-BK; Tue, 03 Dec 2024 01:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMYI-00072o-MN; Tue, 03 Dec 2024 01:38:30 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMYH-0000lE-19; Tue, 03 Dec 2024 01:38:30 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5151e429d53so1254252e0c.3; 
 Mon, 02 Dec 2024 22:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733207908; x=1733812708; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlsJTtN2ccMKjdZ/mBLmdZ+5gE94B/Sq5qpzr0/DHrU=;
 b=FPwC67zJUJLLcY4WLZ4oMUQ4ebBw0Lo6B3tsRJ645yweGWSfvw8pdTlAy9IoOFyj9C
 UPH0DMVNNR4p1TN7lNch3mnscRbNkGXHGkHbbgjS//hY8hm/jLLS+VI9+zQs1G5jUHNw
 qF0pQplAuctWGMuxxjJoPh7VAaWZfXcDuxA9WpMGUnXwr+mX91WUd/B27UnzqKVPF1JE
 g/kQl77JWUYktRXQkh995cHkSCKJ2AHRarU23WSkMYjckB+rouPofLXaA6dram+NMiru
 vfrngpG9mdY1N7DU95wVdi+9NTBnvmbsxZn3IPVrp3YJ9KKcDu3FJe0U/aAwFysvVAGu
 sMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733207908; x=1733812708;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlsJTtN2ccMKjdZ/mBLmdZ+5gE94B/Sq5qpzr0/DHrU=;
 b=VvbSyHQx3tuLfNhb3I0cGYRFR+jjxo1KpLox6ONAGcIppBCGfN1Jbef3VPBkWpjqSF
 KFkFmpW9IjP0PReyT1U1zftdC6XAb3jZQhQKLfx9hj06cnAGw520EDduwAAhgEEEGMUW
 zw0wYHXGcMZCGLYNi9wF7i/nEWkET2bSX0ZeSKNJryGHLBTF0jblqpsoxPoz+A3Ss6ps
 azipAbX1nCfCVowYo2Vic2Lto33Z7q/29gzjMP6BGYdMhcHwVapowzOfdm+4ZfyhOnm7
 5043g7Yi8erNEQrAVvDy/WbKTdCiM2NYz22GkMAF9c3HodizvDXy7ioRRGyI4RSkjz5/
 Mw6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4XxDoyzolZnonk4nf/+Un9aI9qnR+2TOQeZ2Bh/74UWGbwJdq7hfFqdTdPVXwzKOq5MfBI24+BohW@nongnu.org
X-Gm-Message-State: AOJu0Yxlm+JfS42xgKZT25oNSrK18Zx5oDHTH4w04a8MJXBzoRS3VAGN
 XlUu7JxDzJnrtGRt1rb8kJ6pGGEaRUbQKvbM5vQe5uMfAAyOrM6BHYUGAEod87Lh1K+uxImT2KX
 WgLs9+fY4XTiTqazFmcJvOj3tXNI=
X-Gm-Gg: ASbGncuyT3CK3Utwoun+H+4bcra5LeZqH2DES8dELdWWMsyjOvs/CTQxRuNuS2qUM9y
 ImRMGYJadV6OtlF4YUsx0toV3N565vVy0
X-Google-Smtp-Source: AGHT+IGafPN6zJTsXs0dJQeBA8eIly6PHsTVGsMxefpEx4X0NxC0yqtBvx6a4t3mq5xN6Qr39QoPTtKkRHjRTT/cplM=
X-Received: by 2002:a05:6122:3716:b0:50d:4b8d:6745 with SMTP id
 71dfb90a1353d-515bf1367dfmr2193943e0c.0.1733207907673; Mon, 02 Dec 2024
 22:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20241120153935.24706-1-jim.shu@sifive.com>
 <20241120153935.24706-2-jim.shu@sifive.com>
In-Reply-To: <20241120153935.24706-2-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 15:38:01 +0900
Message-ID: <CAKmqyKOrpJRgZunuvHZ6ifZSxM5Ug+YUP-hdmBAeL4NYZQDSjw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] hw/riscv: Support to load DTB after 3GB memory on
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Thu, Nov 21, 2024 at 12:41=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote=
:
>
> Larger initrd image will overlap the DTB at 3GB address. Since 64-bit
> system doesn't have 32-bit addressable issue, we just load DTB to the end
> of dram in 64-bit system.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/boot.c            | 14 +++++++++-----
>  hw/riscv/microchip_pfsoc.c |  4 ++--
>  hw/riscv/sifive_u.c        |  4 ++--
>  hw/riscv/spike.c           |  4 ++--
>  hw/riscv/virt.c            |  2 +-
>  include/hw/riscv/boot.h    |  2 +-
>  6 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 2e319168db..d36d3a7104 100644
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
> @@ -317,11 +317,15 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, h=
waddr dram_size,
>
>      /*
>       * We should put fdt as far as possible to avoid kernel/initrd overw=
riting
> -     * its content. But it should be addressable by 32 bit system as wel=
l.
> -     * Thus, put it at an 2MB aligned address that less than fdt size fr=
om the
> -     * end of dram or 3GB whichever is lesser.
> +     * its content. But it should be addressable by 32 bit system as wel=
l in RV32.
> +     * Thus, put it near to the end of dram in RV64, and put it near to =
the end
> +     * of dram or 3GB whichever is lesser in RV32.
>       */
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

