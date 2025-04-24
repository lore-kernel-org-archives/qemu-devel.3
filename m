Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF19EC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tzx-00016T-5k; Thu, 24 Apr 2025 06:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7tzv-00015J-RC; Thu, 24 Apr 2025 06:40:03 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7tzt-00089r-Fq; Thu, 24 Apr 2025 06:40:03 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-524125f6cadso838734e0c.2; 
 Thu, 24 Apr 2025 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745491199; x=1746095999; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFRJwz0xGQPJEi3urhednjouVhXrD2g+aCfeIj4X2TE=;
 b=hotpDEOF1PAKxUwOX/1ocRIG0v+EeOhgDns6VY0ZRa6LnCF94ILuEuIbmKXhxlEoMn
 JCVWhoV5rpteLSbiphehDp3ej6zJqYo+B0Z1b+DsYIK8ehaBQSLKEhq3LMfvKDgqcN+w
 AmVNYu8OMDhPKn4NC0o0NoXXk4sXTNeQKwYG/+cxghIZ0Z0kkaJoINYOb9h4KfwAvPb9
 WLXvxyV04VHVcKf5xposYMywCgthpjerERrHIXiQbX4kh0SN8oPGOb2MXYhiDxPuxpF8
 mSOzX9O5yzxN5L4zY0o5sXH/McdARsyXpW3Rqc0PWK9jGSJIkxapkvQ8d41/DWGd82lq
 FbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745491199; x=1746095999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFRJwz0xGQPJEi3urhednjouVhXrD2g+aCfeIj4X2TE=;
 b=wRIWsYS3alILrlRNRcM7SKQeGsue2mk8TUpiZ7vI8sy/IN5ziP2Qi4wvmfF2gbrMxT
 H3Zn+NSnqDRNUX2Gn/O8Lv2fL6x2MvuY0a89CBYOKWJbfmHzyI6wG/HbRQWUIqES6aGA
 Ggyahp/fZryqH+IbwYJI9TbBKarqwhClN1cZgs2ofTeC88o3zhLJfnCuHfM1LCkaeGq2
 ad4xGHKmivhg3HqAH5oggDUj2MwMlToPtoOIOljs73fed6dIERKIrjUc+l+fAuvuZX61
 PZkan4McGABDfxZE5Ouf8HQu7PPd0V98YdnVPcrxCZq0l3xe6arg+2WP/sDMbtDltee7
 Y4dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/bdT3uF5wUJDo9gAlKQdUXIwr2EmFNsjGbK5nh727ja8NkZvvVAVf39r4lb5/+hgkidED3hSuQfqt@nongnu.org
X-Gm-Message-State: AOJu0Yz+p3llxitkIP38HVpS9qcVD/Qvy+4sLQ81JnIkv0D7BjP3b5co
 07M8Q8o1EkcbdfOVFYJdwUucMMR/y6c/ogSazmCGzzE/ha4zsZyAuJy/rwsXXTwcjinosFUdnEa
 IK26I3/lZKJQ64//vP+3zR3+7XVg=
X-Gm-Gg: ASbGncvYDy0OTav0dSe+uhDBytBrUD05lH+y2bq3i3EKNKc3Dcv0rpwh4xfXVCfi6WF
 osIll7URgCZd1Izg7/mEtEZw+EY99x0pE7Pbs6tGe6qqObreXu4h7hlEaMaYUiQ8LVMane2sTQD
 LUkAH724GPbkYyhyXt4rSOhWFhKOSRdZvQrx6PPjWlb2joYHe5lpLa
X-Google-Smtp-Source: AGHT+IH/7Hm3Yd52+PymyV4BfFgpDm8bHmWJxnJwcMzSUqfSYjz4SobwJEy43FChUoXSimhrO5yz+9YIypuV6wZZCmw=
X-Received: by 2002:a05:6122:1e08:b0:523:a88b:9ac5 with SMTP id
 71dfb90a1353d-52a78387541mr1178889e0c.9.1745491198746; Thu, 24 Apr 2025
 03:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
 <20250423110630.2249904-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250423110630.2249904-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 20:39:32 +1000
X-Gm-Features: ATxdqUHLvCBfpN3KNjIF0D3Gonuu19sZdqelb-Yw_mZiCq3YYQelSnmBhdBEAH4
Message-ID: <CAKmqyKM4tcw+04BG+Y11Xkyh4deh9=Mz73v_Fu8MzfcfOya6YA@mail.gmail.com>
Subject: Re: [PATCH 1/9] hw/riscv/virt.c: enforce s->memmap use in
 machine_init()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
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

On Wed, Apr 23, 2025 at 9:11=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Throughout the code we're accessing the board memmap, most of the time,
> by accessing it statically via 'virt_memmap'. This static map is also
> assigned in the machine state in s->memmap.
>
> We're also passing it as a variable to some fdt functions, which is
> unorthodox since we can spare a function argument by accessing it
> statically or via the machine state.
>
> All the current forms are valid but not all of the are scalable. In the
> future we will version this board, and then all this code will need
> rework because it should point to the updated memmap. In this case,
> we'll want to assign the adequate versioned memmap once during init,
> in s->memmap like it is being done today, and the rest of the code
> will access the updated map via s->memmap.
>
> We're also enforcing the pattern of using s->memmap instead of assigning
> it to a temp variable 'memmap'. Code is copy/pasted around all the time
> and being consistent is important.
>
> We'll start these rather mechanical changes with virt_machine_init().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 54 ++++++++++++++++++++++++-------------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index c9d255d8a8..6e3e34879f 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1527,7 +1527,6 @@ static void virt_machine_done(Notifier *notifier, v=
oid *data)
>
>  static void virt_machine_init(MachineState *machine)
>  {
> -    const MemMapEntry *memmap =3D virt_memmap;
>      RISCVVirtState *s =3D RISCV_VIRT_MACHINE(machine);
>      MemoryRegion *system_memory =3D get_system_memory();
>      MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
> @@ -1535,6 +1534,8 @@ static void virt_machine_init(MachineState *machine=
)
>      int i, base_hartid, hart_count;
>      int socket_count =3D riscv_socket_count(machine);
>
> +    s->memmap =3D virt_memmap;
> +
>      /* Check socket count limit */
>      if (VIRT_SOCKETS_MAX < socket_count) {
>          error_report("number of sockets/nodes should be less than %d",
> @@ -1582,7 +1583,7 @@ static void virt_machine_init(MachineState *machine=
)
>          if (virt_aclint_allowed() && s->have_aclint) {
>              if (s->aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC) {
>                  /* Per-socket ACLINT MTIMER */
> -                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
> +                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
>                              i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                          RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                          base_hartid, hart_count,
> @@ -1591,28 +1592,28 @@ static void virt_machine_init(MachineState *machi=
ne)
>                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
>              } else {
>                  /* Per-socket ACLINT MSWI, MTIMER, and SSWI */
> -                riscv_aclint_swi_create(memmap[VIRT_CLINT].base +
> -                            i * memmap[VIRT_CLINT].size,
> +                riscv_aclint_swi_create(s->memmap[VIRT_CLINT].base +
> +                            i * s->memmap[VIRT_CLINT].size,
>                          base_hartid, hart_count, false);
> -                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
> -                            i * memmap[VIRT_CLINT].size +
> +                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
> +                            i * s->memmap[VIRT_CLINT].size +
>                              RISCV_ACLINT_SWI_SIZE,
>                          RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                          base_hartid, hart_count,
>                          RISCV_ACLINT_DEFAULT_MTIMECMP,
>                          RISCV_ACLINT_DEFAULT_MTIME,
>                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> -                riscv_aclint_swi_create(memmap[VIRT_ACLINT_SSWI].base +
> -                            i * memmap[VIRT_ACLINT_SSWI].size,
> +                riscv_aclint_swi_create(s->memmap[VIRT_ACLINT_SSWI].base=
 +
> +                            i * s->memmap[VIRT_ACLINT_SSWI].size,
>                          base_hartid, hart_count, true);
>              }
>          } else if (tcg_enabled()) {
>              /* Per-socket SiFive CLINT */
>              riscv_aclint_swi_create(
> -                    memmap[VIRT_CLINT].base + i * memmap[VIRT_CLINT].siz=
e,
> +                    s->memmap[VIRT_CLINT].base + i * s->memmap[VIRT_CLIN=
T].size,
>                      base_hartid, hart_count, false);
> -            riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
> -                        i * memmap[VIRT_CLINT].size + RISCV_ACLINT_SWI_S=
IZE,
> +            riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
> +                    i * s->memmap[VIRT_CLINT].size + RISCV_ACLINT_SWI_SI=
ZE,
>                      RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_=
count,
>                      RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_=
MTIME,
>                      RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> @@ -1620,11 +1621,11 @@ static void virt_machine_init(MachineState *machi=
ne)
>
>          /* Per-socket interrupt controller */
>          if (s->aia_type =3D=3D VIRT_AIA_TYPE_NONE) {
> -            s->irqchip[i] =3D virt_create_plic(memmap, i,
> +            s->irqchip[i] =3D virt_create_plic(s->memmap, i,
>                                               base_hartid, hart_count);
>          } else {
>              s->irqchip[i] =3D virt_create_aia(s->aia_type, s->aia_guests=
,
> -                                            memmap, i, base_hartid,
> +                                            s->memmap, i, base_hartid,
>                                              hart_count);
>          }
>
> @@ -1646,8 +1647,8 @@ static void virt_machine_init(MachineState *machine=
)
>      if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
>          kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
>                               VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_=
MSIS,
> -                             memmap[VIRT_APLIC_S].base,
> -                             memmap[VIRT_IMSIC_S].base,
> +                             s->memmap[VIRT_APLIC_S].base,
> +                             s->memmap[VIRT_IMSIC_S].base,
>                               s->aia_guests);
>      }
>
> @@ -1663,21 +1664,20 @@ static void virt_machine_init(MachineState *machi=
ne)
>          virt_high_pcie_memmap.size =3D VIRT32_HIGH_PCIE_MMIO_SIZE;
>      } else {
>          virt_high_pcie_memmap.size =3D VIRT64_HIGH_PCIE_MMIO_SIZE;
> -        virt_high_pcie_memmap.base =3D memmap[VIRT_DRAM].base + machine-=
>ram_size;
> +        virt_high_pcie_memmap.base =3D s->memmap[VIRT_DRAM].base +
> +                                     machine->ram_size;
>          virt_high_pcie_memmap.base =3D
>              ROUND_UP(virt_high_pcie_memmap.base, virt_high_pcie_memmap.s=
ize);
>      }
>
> -    s->memmap =3D virt_memmap;
> -
>      /* register system main memory (actual RAM) */
> -    memory_region_add_subregion(system_memory, memmap[VIRT_DRAM].base,
> -        machine->ram);
> +    memory_region_add_subregion(system_memory, s->memmap[VIRT_DRAM].base=
,
> +                                machine->ram);
>
>      /* boot rom */
>      memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
> -                           memmap[VIRT_MROM].size, &error_fatal);
> -    memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
> +                           s->memmap[VIRT_MROM].size, &error_fatal);
> +    memory_region_add_subregion(system_memory, s->memmap[VIRT_MROM].base=
,
>                                  mask_rom);
>
>      /*
> @@ -1688,12 +1688,12 @@ static void virt_machine_init(MachineState *machi=
ne)
>      rom_set_fw(s->fw_cfg);
>
>      /* SiFive Test MMIO device */
> -    sifive_test_create(memmap[VIRT_TEST].base);
> +    sifive_test_create(s->memmap[VIRT_TEST].base);
>
>      /* VirtIO MMIO devices */
>      for (i =3D 0; i < VIRTIO_COUNT; i++) {
>          sysbus_create_simple("virtio-mmio",
> -            memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
> +            s->memmap[VIRT_VIRTIO].base + i * s->memmap[VIRT_VIRTIO].siz=
e,
>              qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
>      }
>
> @@ -1701,11 +1701,11 @@ static void virt_machine_init(MachineState *machi=
ne)
>
>      create_platform_bus(s, mmio_irqchip);
>
> -    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> +    serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
>          0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
>
> -    sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
> +    sysbus_create_simple("goldfish_rtc", s->memmap[VIRT_RTC].base,
>          qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
>
>      for (i =3D 0; i < ARRAY_SIZE(s->flash); i++) {
> @@ -1723,7 +1723,7 @@ static void virt_machine_init(MachineState *machine=
)
>              exit(1);
>          }
>      } else {
> -        create_fdt(s, memmap);
> +        create_fdt(s, s->memmap);
>      }
>
>      if (virt_is_iommu_sys_enabled(s)) {
> --
> 2.49.0
>
>

