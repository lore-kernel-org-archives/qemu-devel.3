Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3254FC021B6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 05:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmR7l-0002u3-Hw; Mon, 24 Feb 2025 00:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmQw6-0000Vf-SQ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 00:23:23 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmQw4-0007Rx-Vy
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 00:23:22 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4be5033a2cbso1715184137.1
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 21:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740374600; x=1740979400; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RO0J7eAO37erjUM9VtY9JG67VYsAfwKUH2VjCb+36XY=;
 b=LOD7fNhwRqbbrqb28bj1M7/3Qbuh1sfJQIHlw2fv52T8DttLZ17Mmy7/R3FYo45fHH
 sNPa0Ps78AlDJWPLZegKINy2Hqndaf/k/XJJtnD7tAF+jf075YLNDm4+NcjiT5zoaZzz
 p3Q+jTRuxFSMJ/Q67JAvE6EAb3k/46oTYXhzKbaZSOauMRd+/WX9X2nQRL6rpy57AdAE
 DCdPz9hK6W2DwNUmVo393dhOxBIvhhXHb94zgkxHG5cSBeKntNDu/FlP8RR9HVeFzaTn
 fYb3Ac/z5V8GQ6UE6TAcYscMxxnnlKOLNQiJuLU6dX8zlZbGJVhtBos3ScI/qLSw5rBm
 grKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740374600; x=1740979400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RO0J7eAO37erjUM9VtY9JG67VYsAfwKUH2VjCb+36XY=;
 b=ZnkAoCR4n/XwtTUHdXb7P/ShCQ9VRXx/wIP/2UL+QhrxdXcmghL3OTfAqoSELn6a4V
 MMuwZvFSu6buNhIuiwqVQ2wtylPZf3Ba0ns9BN7713kLSPNm3o/7OOoXxpj13/m67TbY
 TqVwzmre075Ox7mA0TNXNzq8Xl6bnB5AdRr/ObDf5i3CoY8FE8xFZYkpNuUXUrHpoHUu
 WJMM+h1VyIAZjtxjPOiSvHqKyi/H2gWqWZp11JexA1EzACV57iZ6YfIq4FbNut8otegN
 3Vwv4IjOQC0QmIuPkAkGgKHyal1sZEu+RyVTfrzzZRDbydHX0SBQm13pK/mhdt3XHOWr
 SElw==
X-Gm-Message-State: AOJu0YxwIeYT3zsG69DooFT/EvyTVUP1x2j0JkTPLV0LV7WXbAYFxgVw
 cjJ4nTfNlsMTPsPk3ERvE1Eb2q0p3eiOivgZSmLXhYrJAJJ3Z87XUvpD54aQ1koDv/o56yW5Vz4
 oeVDtuqScLAODV96Aw+yuJ7m/d9s=
X-Gm-Gg: ASbGncsDULiICpb8LM8pguOp1fMAvpZI+UMB8C9p1wTIDqTQtbDsdiXxVp8SxteBSk9
 goI+DM7mMJlEzp6GbOU6pBg8wbcrqcAd3gjya4mlGn9/oAm4O2mukBTF000ABa+6i1px3ge8xRe
 +yUxfvMImbagM/m47hC07BiOTNra137cQ50R7x
X-Google-Smtp-Source: AGHT+IHRAffY8eYCV4LmligcGCbpFAmBm8gU1SQYml3uHMiaHLZcXVU7MaY/GIDRqCBwLgq9KZxMy21OUHM5SrzBmfw=
X-Received: by 2002:a05:6102:38d1:b0:4bb:b589:9da5 with SMTP id
 ada2fe7eead31-4bfc0281f42mr4999716137.25.1740374599753; Sun, 23 Feb 2025
 21:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
 <20250214062443.9936-4-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250214062443.9936-4-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 15:22:53 +1000
X-Gm-Features: AWEUYZne1OnRAVbG28ajNBomxYS60m0W20W311zn7Yt8pDuSlFlueelzgCg1BWc
Message-ID: <CAKmqyKNZfBcqT08v-wYmApYuQgM7in__Q3b_vwEgZp+sXr8ckA@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/riscv: Make FDT optional for MPFS
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, Conor Dooley <conor.dooley@microchip.com>, 
 Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
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

On Fri, Feb 14, 2025 at 4:27=E2=80=AFPM Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> Real-time kernels such as RTEMS or Zephyr may use a static device tree
> built into the kernel image.  Do not require to use the -dtb option if
> -kernel is used for the microchip-icicle-kit machine.

That's a fair point, but it might also confuse people who expect QEMU
to generate a DTB if they don't specify one.

This at least needs a documentation update, but a warning log might
also be warranted if no `-dtb` is supplied

Alistair

>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> ---
>  hw/riscv/microchip_pfsoc.c | 53 ++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 28 deletions(-)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 2ddc3464bb..f9e256df52 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -516,7 +516,6 @@ static void microchip_icicle_kit_machine_init(Machine=
State *machine)
>      uint64_t mem_low_size, mem_high_size;
>      hwaddr firmware_load_addr;
>      const char *firmware_name;
> -    bool kernel_as_payload =3D false;
>      target_ulong firmware_end_addr, kernel_start_addr;
>      uint64_t kernel_entry;
>      uint64_t fdt_load_addr;
> @@ -589,25 +588,12 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
>       *
>       * This ensures backwards compatibility with how we used to expose -=
bios
>       * to users but allows them to run through direct kernel booting as =
well.
> -     *
> -     * When -kernel is used for direct boot, -dtb must be present to pro=
vide
> -     * a valid device tree for the board, as we don't generate device tr=
ee.
>       */
>
> -    if (machine->kernel_filename && machine->dtb) {
> -        int fdt_size;
> -        machine->fdt =3D load_device_tree(machine->dtb, &fdt_size);
> -        if (!machine->fdt) {
> -            error_report("load_device_tree() failed");
> -            exit(1);
> -        }
> -
> +    if (machine->kernel_filename) {
>          firmware_name =3D RISCV64_BIOS_BIN;
>          firmware_load_addr =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
> -        kernel_as_payload =3D true;
> -    }
> -
> -    if (!kernel_as_payload) {
> +    } else {
>          firmware_name =3D BIOS_FILENAME;
>          firmware_load_addr =3D RESET_VECTOR;
>      }
> @@ -617,7 +603,7 @@ static void microchip_icicle_kit_machine_init(Machine=
State *machine)
>                                                       &firmware_load_addr=
, NULL);
>
>      riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
> -    if (kernel_as_payload) {
> +    if (machine->kernel_filename) {
>          kernel_start_addr =3D riscv_calc_kernel_start_addr(&boot_info,
>                                                           firmware_end_ad=
dr);
>
> @@ -625,19 +611,30 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
>                            true, NULL);
>          kernel_entry =3D boot_info.image_low_addr;
>
> -        /* Compute the fdt load address in dram */
> -        hwaddr kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
> -        hwaddr kernel_ram_size =3D memmap[MICROCHIP_PFSOC_DRAM_LO].size;
> -
> -        if (kernel_entry - kernel_ram_base >=3D kernel_ram_size) {
> -            kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_HI].base;
> -            kernel_ram_size =3D mem_high_size;
> +        if (machine->dtb) {
> +            int fdt_size;
> +            machine->fdt =3D load_device_tree(machine->dtb, &fdt_size);
> +            if (!machine->fdt) {
> +                error_report("load_device_tree() failed");
> +                exit(1);
> +            }
> +
> +            /* Compute the FDT load address in DRAM */
> +            hwaddr kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_LO].b=
ase;
> +            hwaddr kernel_ram_size =3D memmap[MICROCHIP_PFSOC_DRAM_LO].s=
ize;
> +
> +            if (kernel_entry - kernel_ram_base >=3D kernel_ram_size) {
> +                kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_HI].base=
;
> +                kernel_ram_size =3D mem_high_size;
> +            }
> +
> +            fdt_load_addr =3D riscv_compute_fdt_addr(kernel_ram_base, ke=
rnel_ram_size,
> +                                                   machine, &boot_info);
> +            riscv_load_fdt(fdt_load_addr, machine->fdt);
> +        } else {
> +            fdt_load_addr =3D 0;
>          }
>
> -        fdt_load_addr =3D riscv_compute_fdt_addr(kernel_ram_base, kernel=
_ram_size,
> -                                               machine, &boot_info);
> -        riscv_load_fdt(fdt_load_addr, machine->fdt);
> -
>          /* Load the reset vector */
>          riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, firmware_load=
_addr,
>                                    memmap[MICROCHIP_PFSOC_ENVM_DATA].base=
,
> --
> 2.43.0
>
>

