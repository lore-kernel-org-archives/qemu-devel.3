Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A31CD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 02:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snTtb-0005Ol-U2; Sun, 08 Sep 2024 22:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snTtZ-0005Lg-Si; Sun, 08 Sep 2024 22:12:49 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snTtX-0001Io-RN; Sun, 08 Sep 2024 22:12:49 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-502adfff646so722474e0c.2; 
 Sun, 08 Sep 2024 19:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725847966; x=1726452766; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7Q+XeCnQWU5EmsAK84tdRRiiqhZzqFkfHt0Y5SP6ko=;
 b=RYxHs8F5NVBe27pvSmBksIl1/sNbhhSYt3SZG+vE+D7iqWYpoXIynH/l0kG2gGC2eL
 jckZvjHa9w0E0TJV0ctiEl96YjebALSx0T7QG7oye2lvqHocMh0AZ16MKRvHdq0PBaQQ
 i33IosU5aG2dpdMmnX1PdZppTjKIj8H3Mj7NXMRaAn1yNWeaR8Zq5dAaVdAEIMAho9ON
 5fq3erZNt/8SaqKcrPpH/zGlt+qgjBpDqt2gUmizjuB8+FnbzjnmSztyrEvUhDMlDtXh
 cU/b3OTF1dbmYbdOdiGPGy8tKNmBVGZ95nnG1zaghphkLaR4CX16uFNlaT63GWq/HRfP
 L7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725847966; x=1726452766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7Q+XeCnQWU5EmsAK84tdRRiiqhZzqFkfHt0Y5SP6ko=;
 b=Ac7dWvMPh8SDMag1oF/sNKIVCG5YEtkKnW7zVVmZVg7OrPrbjfw7IhhgzJ6mOMp0B4
 Xa4Ix/2zCV2qmnCh3r8h7ctGBgAJy3d2yVwNG/5+ku/byWhHupCDjbcaob2qgEM0M0+5
 3i4c/BrPOwHGkRhRbPnmk0y15PJ1eb999S/jLSG9koPBMM+SZhRiv+lxmY4tnQn1D9YK
 gkgQw4M6HxlNaQxfSqSUI80aiHm7M/K48l7+fo9OFP02499K0ECo4Y0oR8eHlXrrhL+l
 +UYiaN9yrMl9tDzxzXRZuzafBVLEPkr7dbql4gq9scCiYtWPSuqvSBSWyD0fqD3mD0Jz
 cndA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgQXyr+4JRCLx8AH1o2GnzVy5OYQARp2kIB95/56RWuy6Ih5HFT4D7SUdbBRDIZKWLcP9njM+9rz6B@nongnu.org
X-Gm-Message-State: AOJu0Yx1jD0WSKercThfOlUJxUq5LtRat2D9/LeLNKT/FgaOtsUHDu8F
 qBC1MX/VqtZSLotmuRh+g5jHE4y+cz1hViUCkOg5WrTPGip+6IblRbpvIpPYnKd27EYWfkNahC3
 Y25/sTKfjRkIi4ENrGY5q6jAxJw8=
X-Google-Smtp-Source: AGHT+IF8K6rLxHRqh4bdYlDVfMXh2ip0z+2iqJGeyAyCM51DHBdhnrpYeeg3vVm5oLOMqqz7TRWwXlNTZTrJO1e3y6g=
X-Received: by 2002:a05:6122:31a7:b0:501:2851:b3bb with SMTP id
 71dfb90a1353d-50207af2811mr11256544e0c.1.1725847966101; Sun, 08 Sep 2024
 19:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240817002651.3209701-1-samuel.holland@sifive.com>
In-Reply-To: <20240817002651.3209701-1-samuel.holland@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Sep 2024 12:12:20 +1000
Message-ID: <CAKmqyKPVJ1FvLh8DxCtRKKPTBKRZZR8C0E7NyqfbMqYRg25NYg@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: Respect firmware ELF entry point
To: Samuel Holland <samuel.holland@sifive.com>
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Vijai Kumar K <vijai@behindbytes.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Sat, Aug 17, 2024 at 10:56=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> When riscv_load_firmware() loads an ELF, the ELF segment addresses are
> used, not the passed-in firmware_load_addr. The machine models assume
> the firmware entry point is what they provided for firmware_load_addr,
> and use that address to generate the boot ROM, so if the ELF is linked
> at any other address, the boot ROM will jump to empty memory.
>
> Pass back the ELF entry point to use when generating the boot ROM, so
> the boot ROM can jump to firmware loaded anywhere in RAM. For example,
> on the virt machine, this allows using an OpenSBI fw_dynamic.elf built
> with FW_TEXT_START values other than 0x80000000.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>
>  hw/riscv/boot.c            | 11 ++++++-----
>  hw/riscv/microchip_pfsoc.c |  2 +-
>  hw/riscv/opentitan.c       |  3 ++-
>  hw/riscv/shakti_c.c        | 13 ++++++-------
>  hw/riscv/sifive_u.c        |  4 ++--
>  hw/riscv/spike.c           |  5 +++--
>  hw/riscv/virt.c            |  4 ++--
>  include/hw/riscv/boot.h    |  4 ++--
>  8 files changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 47281ca853..9115ecd91f 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -128,11 +128,11 @@ char *riscv_find_firmware(const char *firmware_file=
name,
>
>  target_ulong riscv_find_and_load_firmware(MachineState *machine,
>                                            const char *default_machine_fi=
rmware,
> -                                          hwaddr firmware_load_addr,
> +                                          hwaddr *firmware_load_addr,
>                                            symbol_fn_t sym_cb)
>  {
>      char *firmware_filename;
> -    target_ulong firmware_end_addr =3D firmware_load_addr;
> +    target_ulong firmware_end_addr =3D *firmware_load_addr;
>
>      firmware_filename =3D riscv_find_firmware(machine->firmware,
>                                              default_machine_firmware);
> @@ -148,7 +148,7 @@ target_ulong riscv_find_and_load_firmware(MachineStat=
e *machine,
>  }
>
>  target_ulong riscv_load_firmware(const char *firmware_filename,
> -                                 hwaddr firmware_load_addr,
> +                                 hwaddr *firmware_load_addr,
>                                   symbol_fn_t sym_cb)
>  {
>      uint64_t firmware_entry, firmware_end;
> @@ -159,15 +159,16 @@ target_ulong riscv_load_firmware(const char *firmwa=
re_filename,
>      if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
>                           &firmware_entry, NULL, &firmware_end, NULL,
>                           0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
> +        *firmware_load_addr =3D firmware_entry;
>          return firmware_end;
>      }
>
>      firmware_size =3D load_image_targphys_as(firmware_filename,
> -                                           firmware_load_addr,
> +                                           *firmware_load_addr,
>                                             current_machine->ram_size, NU=
LL);
>
>      if (firmware_size > 0) {
> -        return firmware_load_addr + firmware_size;
> +        return *firmware_load_addr + firmware_size;
>      }
>
>      error_report("could not load firmware '%s'", firmware_filename);
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 7725dfbde5..f9a3b43d2e 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -613,7 +613,7 @@ static void microchip_icicle_kit_machine_init(Machine=
State *machine)
>
>      /* Load the firmware */
>      firmware_end_addr =3D riscv_find_and_load_firmware(machine, firmware=
_name,
> -                                                     firmware_load_addr,=
 NULL);
> +                                                     &firmware_load_addr=
, NULL);
>
>      if (kernel_as_payload) {
>          kernel_start_addr =3D riscv_calc_kernel_start_addr(&s->soc.u_cpu=
s,
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 436503f1ba..e2830e9dc2 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -98,7 +98,8 @@ static void opentitan_machine_init(MachineState *machin=
e)
>          memmap[IBEX_DEV_RAM].base, machine->ram);
>
>      if (machine->firmware) {
> -        riscv_load_firmware(machine->firmware, memmap[IBEX_DEV_RAM].base=
, NULL);
> +        hwaddr firmware_load_addr =3D memmap[IBEX_DEV_RAM].base;
> +        riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL=
);
>      }
>
>      if (machine->kernel_filename) {
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index 3888034c2b..2dccc1eff2 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -45,6 +45,7 @@ static void shakti_c_machine_state_init(MachineState *m=
state)
>  {
>      ShaktiCMachineState *sms =3D RISCV_SHAKTI_MACHINE(mstate);
>      MemoryRegion *system_memory =3D get_system_memory();
> +    hwaddr firmware_load_addr =3D shakti_c_memmap[SHAKTI_C_RAM].base;
>
>      /* Initialize SoC */
>      object_initialize_child(OBJECT(mstate), "soc", &sms->soc,
> @@ -56,16 +57,14 @@ static void shakti_c_machine_state_init(MachineState =
*mstate)
>                                  shakti_c_memmap[SHAKTI_C_RAM].base,
>                                  mstate->ram);
>
> +    if (mstate->firmware) {
> +        riscv_load_firmware(mstate->firmware, &firmware_load_addr, NULL)=
;
> +    }
> +
>      /* ROM reset vector */
> -    riscv_setup_rom_reset_vec(mstate, &sms->soc.cpus,
> -                              shakti_c_memmap[SHAKTI_C_RAM].base,
> +    riscv_setup_rom_reset_vec(mstate, &sms->soc.cpus, firmware_load_addr=
,
>                                shakti_c_memmap[SHAKTI_C_ROM].base,
>                                shakti_c_memmap[SHAKTI_C_ROM].size, 0, 0);
> -    if (mstate->firmware) {
> -        riscv_load_firmware(mstate->firmware,
> -                            shakti_c_memmap[SHAKTI_C_RAM].base,
> -                            NULL);
> -    }
>  }
>
>  static void shakti_c_machine_instance_init(Object *obj)
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index af5f923f54..35a689309d 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -515,7 +515,7 @@ static void sifive_u_machine_init(MachineState *machi=
ne)
>      SiFiveUState *s =3D RISCV_U_MACHINE(machine);
>      MemoryRegion *system_memory =3D get_system_memory();
>      MemoryRegion *flash0 =3D g_new(MemoryRegion, 1);
> -    target_ulong start_addr =3D memmap[SIFIVE_U_DEV_DRAM].base;
> +    hwaddr start_addr =3D memmap[SIFIVE_U_DEV_DRAM].base;
>      target_ulong firmware_end_addr, kernel_start_addr;
>      const char *firmware_name;
>      uint32_t start_addr_hi32 =3D 0x00000000;
> @@ -589,7 +589,7 @@ static void sifive_u_machine_init(MachineState *machi=
ne)
>
>      firmware_name =3D riscv_default_firmware_name(&s->soc.u_cpus);
>      firmware_end_addr =3D riscv_find_and_load_firmware(machine, firmware=
_name,
> -                                                     start_addr, NULL);
> +                                                     &start_addr, NULL);
>
>      if (machine->kernel_filename) {
>          kernel_start_addr =3D riscv_calc_kernel_start_addr(&s->soc.u_cpu=
s,
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 64074395bc..fceb91d946 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -198,6 +198,7 @@ static void spike_board_init(MachineState *machine)
>      MemoryRegion *system_memory =3D get_system_memory();
>      MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
>      target_ulong firmware_end_addr =3D memmap[SPIKE_DRAM].base;
> +    hwaddr firmware_load_addr =3D memmap[SPIKE_DRAM].base;
>      target_ulong kernel_start_addr;
>      char *firmware_name;
>      uint32_t fdt_load_addr;
> @@ -290,7 +291,7 @@ static void spike_board_init(MachineState *machine)
>      /* Load firmware */
>      if (firmware_name) {
>          firmware_end_addr =3D riscv_load_firmware(firmware_name,
> -                                                memmap[SPIKE_DRAM].base,
> +                                                &firmware_load_addr,
>                                                  htif_symbol_callback);
>          g_free(firmware_name);
>      }
> @@ -320,7 +321,7 @@ static void spike_board_init(MachineState *machine)
>      riscv_load_fdt(fdt_load_addr, machine->fdt);
>
>      /* load the reset vector */
> -    riscv_setup_rom_reset_vec(machine, &s->soc[0], memmap[SPIKE_DRAM].ba=
se,
> +    riscv_setup_rom_reset_vec(machine, &s->soc[0], firmware_load_addr,
>                                memmap[SPIKE_MROM].base,
>                                memmap[SPIKE_MROM].size, kernel_entry,
>                                fdt_load_addr);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 9981e0f6c9..aef5e284a7 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1336,7 +1336,7 @@ static void virt_machine_done(Notifier *notifier, v=
oid *data)
>                                       machine_done);
>      const MemMapEntry *memmap =3D virt_memmap;
>      MachineState *machine =3D MACHINE(s);
> -    target_ulong start_addr =3D memmap[VIRT_DRAM].base;
> +    hwaddr start_addr =3D memmap[VIRT_DRAM].base;
>      target_ulong firmware_end_addr, kernel_start_addr;
>      const char *firmware_name =3D riscv_default_firmware_name(&s->soc[0]=
);
>      uint64_t fdt_load_addr;
> @@ -1368,7 +1368,7 @@ static void virt_machine_done(Notifier *notifier, v=
oid *data)
>      }
>
>      firmware_end_addr =3D riscv_find_and_load_firmware(machine, firmware=
_name,
> -                                                     start_addr, NULL);
> +                                                     &start_addr, NULL);
>
>      pflash_blk0 =3D pflash_cfi01_get_blk(s->flash[0]);
>      if (pflash_blk0) {
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index a2e4ae9cb0..18bfe9f7bf 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -35,13 +35,13 @@ target_ulong riscv_calc_kernel_start_addr(RISCVHartAr=
rayState *harts,
>                                            target_ulong firmware_end_addr=
);
>  target_ulong riscv_find_and_load_firmware(MachineState *machine,
>                                            const char *default_machine_fi=
rmware,
> -                                          hwaddr firmware_load_addr,
> +                                          hwaddr *firmware_load_addr,
>                                            symbol_fn_t sym_cb);
>  const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
>  char *riscv_find_firmware(const char *firmware_filename,
>                            const char *default_machine_firmware);
>  target_ulong riscv_load_firmware(const char *firmware_filename,
> -                                 hwaddr firmware_load_addr,
> +                                 hwaddr *firmware_load_addr,
>                                   symbol_fn_t sym_cb);
>  target_ulong riscv_load_kernel(MachineState *machine,
>                                 RISCVHartArrayState *harts,
> --
> 2.45.1
>
>

