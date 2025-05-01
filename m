Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A39C369D9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 00:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAHYT-0006cU-Dd; Wed, 30 Apr 2025 20:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHYO-0006cH-TX; Wed, 30 Apr 2025 20:13:28 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHYM-0003Oc-6r; Wed, 30 Apr 2025 20:13:28 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4c300c82ca8so175797137.2; 
 Wed, 30 Apr 2025 17:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746058404; x=1746663204; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7Lqiz1v7dgotyuhSFUqGH5HTEL0Ug9ANtiu/mU0nEo=;
 b=iRGrQbZNcilkFQPvoSDd2XzOpvkTYh6B0ptXY+57zkCCKJEYAna8IkTjFiGpJepSuM
 FezF0dwQ65ysHpIFcfYq8BUyvH2sOqF2DDNbbPKzr9ltTbqAmL++PGDSEEaU5kq53Qwp
 pNNrCPxLDvNxUfALZRJgSMZr9GGUEeq/YZVHAcVAmPAgxM1VhXRuMPC2pT7o3Ep6OaLG
 ktIbAMaPqZu17SR5BTPdaT/ZnauO1Zz40c7UYiq1L+if0tC8HU5scF0y60fNLMc4nXnS
 QXenCwHiARTXW9EWic7c2gTfJVTUvqwyavh65cwkadYJibXimEAOza6GRRbRT3oON7GE
 IxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746058404; x=1746663204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7Lqiz1v7dgotyuhSFUqGH5HTEL0Ug9ANtiu/mU0nEo=;
 b=UPZb6Q/haXaFl3Nx1NS7e2L73bKDvCL1tho3CsGlTcnHYU3lujaS+EyOA1ndd6CxPQ
 N2zZkEr0PALMmSW7jvsj3A6xqFbRUYoY9PTabR/t/N+j7ciZfKp9Hq45n89HWjyUiGmQ
 zSOcVE0jO1wAYlIgFL8N7+Dwl0G6lVh4ADrkU0bUqr2/YPK+UFV25EaMQOVZbeRV5TOE
 3DVHXmPI0exgni9783gL3Qtf5u7zf9J9VE+Z6wk3L7lYXptV72w0nQHnbd9giL8MOA0a
 3IcAJil5QPzC9hTrRr2hkTZ6CBaAOHQwbQUy1lt03OJCBkrzrHBA/3dcHfPk9RUAbSnH
 31FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvlvPKVPWjJqqERvhiCHG2JT3K0dsBji9nwb9NzvbxdhZkXx0EDVYL45BvhyjR7Lka3GNfixxDOild@nongnu.org
X-Gm-Message-State: AOJu0Yx5TaOKqy4VhLvq9otqAJQtoO5W19mXVmse0eyRSO0EVCD9UqFF
 DxLKPGAqm8yLSlyEOBWnlhhjTu+5MxF+kXb/pTaX42u31OebZjjOomPEgHymog6bkZvGZr1JoZY
 7Yy49H1x7KCsuVny95DSl/iDM1Qo=
X-Gm-Gg: ASbGncsz8KLX0uTChDug9FzhoGsWNicxvI3WYITvdIE7IyqBQEPiAgiq9XjJBaVianx
 MNN9OgwiR1ddmM/suTKdvNrZKz6i8q9+D4CHSre7efGF26IlHbR/Z0UuHlTzvQPfwcPVsr0Z8ae
 Jxl4alj/K0loMrrx7Pcv6GTmahWAeXHHB1yeEMbPOp//LcsBkfradX
X-Google-Smtp-Source: AGHT+IHcUCI6SFh7CxdeZ0Gvqc8Z2hdkEPZh9LAeA2XkRC1bioxYoD5rjpZeaWZFlQK1eP3gPxlCgVvIlAoa6SwZ5RM=
X-Received: by 2002:a05:6102:5114:b0:4c8:55b8:6fad with SMTP id
 ada2fe7eead31-4dad4a028cfmr3872358137.17.1746058404401; Wed, 30 Apr 2025
 17:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
 <20250429125811.224803-9-dbarboza@ventanamicro.com>
In-Reply-To: <20250429125811.224803-9-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 10:12:58 +1000
X-Gm-Features: ATxdqUHzaisMabHBZb-zRzcuS6SwGb4AIzr8jALBxlHW-CloTCG747Vs_RoPbZ4
Message-ID: <CAKmqyKPQDY=dveWzG+vwj6Zmz=oON2f=W8UBFPWih7CfDcNUEQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] hw/riscv/virt.c: use s->memmap in finalize_fdt()
 functions
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 joel@jms.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Tue, Apr 29, 2025 at 11:01=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Change create_fdt_pcie(), create_fdt_reset(), create_fdt_uart() and
> create_fdt_rtc() to use s->memmap in their logic.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 46ac42058e..f38b64d836 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -871,7 +871,7 @@ static void create_fdt_virtio(RISCVVirtState *s, uint=
32_t irq_virtio_phandle)
>      }
>  }
>
> -static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap=
,
> +static void create_fdt_pcie(RISCVVirtState *s,
>                              uint32_t irq_pcie_phandle,
>                              uint32_t msi_pcie_phandle,
>                              uint32_t iommu_sys_phandle)
> @@ -880,7 +880,7 @@ static void create_fdt_pcie(RISCVVirtState *s, const =
MemMapEntry *memmap,
>      MachineState *ms =3D MACHINE(s);
>
>      name =3D g_strdup_printf("/soc/pci@%lx",
> -        (long) memmap[VIRT_PCIE_ECAM].base);
> +        (long) s->memmap[VIRT_PCIE_ECAM].base);
>      qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
>          FDT_PCI_ADDR_CELLS);
>      qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
> @@ -891,19 +891,19 @@ static void create_fdt_pcie(RISCVVirtState *s, cons=
t MemMapEntry *memmap,
>      qemu_fdt_setprop_string(ms->fdt, name, "device_type", "pci");
>      qemu_fdt_setprop_cell(ms->fdt, name, "linux,pci-domain", 0);
>      qemu_fdt_setprop_cells(ms->fdt, name, "bus-range", 0,
> -        memmap[VIRT_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
> +        s->memmap[VIRT_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
>      qemu_fdt_setprop(ms->fdt, name, "dma-coherent", NULL, 0);
>      if (s->aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC) {
>          qemu_fdt_setprop_cell(ms->fdt, name, "msi-parent", msi_pcie_phan=
dle);
>      }
>      qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0,
> -        memmap[VIRT_PCIE_ECAM].base, 0, memmap[VIRT_PCIE_ECAM].size);
> +        s->memmap[VIRT_PCIE_ECAM].base, 0, s->memmap[VIRT_PCIE_ECAM].siz=
e);
>      qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
>          1, FDT_PCI_RANGE_IOPORT, 2, 0,
> -        2, memmap[VIRT_PCIE_PIO].base, 2, memmap[VIRT_PCIE_PIO].size,
> +        2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].si=
ze,
>          1, FDT_PCI_RANGE_MMIO,
> -        2, memmap[VIRT_PCIE_MMIO].base,
> -        2, memmap[VIRT_PCIE_MMIO].base, 2, memmap[VIRT_PCIE_MMIO].size,
> +        2, s->memmap[VIRT_PCIE_MMIO].base,
> +        2, s->memmap[VIRT_PCIE_MMIO].base, 2, s->memmap[VIRT_PCIE_MMIO].=
size,
>          1, FDT_PCI_RANGE_MMIO_64BIT,
>          2, virt_high_pcie_memmap.base,
>          2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
> @@ -917,8 +917,7 @@ static void create_fdt_pcie(RISCVVirtState *s, const =
MemMapEntry *memmap,
>      create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
>  }
>
> -static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memma=
p,
> -                             uint32_t *phandle)
> +static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
>  {
>      char *name;
>      uint32_t test_phandle;
> @@ -926,7 +925,7 @@ static void create_fdt_reset(RISCVVirtState *s, const=
 MemMapEntry *memmap,
>
>      test_phandle =3D (*phandle)++;
>      name =3D g_strdup_printf("/soc/test@%lx",
> -        (long)memmap[VIRT_TEST].base);
> +        (long)s->memmap[VIRT_TEST].base);
>      qemu_fdt_add_subnode(ms->fdt, name);
>      {
>          static const char * const compat[3] =3D {
> @@ -936,7 +935,7 @@ static void create_fdt_reset(RISCVVirtState *s, const=
 MemMapEntry *memmap,
>                                        (char **)&compat, ARRAY_SIZE(compa=
t));
>      }
>      qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -        0x0, memmap[VIRT_TEST].base, 0x0, memmap[VIRT_TEST].size);
> +        0x0, s->memmap[VIRT_TEST].base, 0x0, s->memmap[VIRT_TEST].size);
>      qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
>      test_phandle =3D qemu_fdt_get_phandle(ms->fdt, name);
>      g_free(name);
> @@ -958,18 +957,19 @@ static void create_fdt_reset(RISCVVirtState *s, con=
st MemMapEntry *memmap,
>      g_free(name);
>  }
>
> -static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap=
,
> +static void create_fdt_uart(RISCVVirtState *s,
>                              uint32_t irq_mmio_phandle)
>  {
>      g_autofree char *name =3D NULL;
>      MachineState *ms =3D MACHINE(s);
>
> -    name =3D g_strdup_printf("/soc/serial@%lx", (long)memmap[VIRT_UART0]=
.base);
> +    name =3D g_strdup_printf("/soc/serial@%lx",
> +                           (long)s->memmap[VIRT_UART0].base);
>      qemu_fdt_add_subnode(ms->fdt, name);
>      qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
>      qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -        0x0, memmap[VIRT_UART0].base,
> -        0x0, memmap[VIRT_UART0].size);
> +        0x0, s->memmap[VIRT_UART0].base,
> +        0x0, s->memmap[VIRT_UART0].size);
>      qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
>      qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_ph=
andle);
>      if (s->aia_type =3D=3D VIRT_AIA_TYPE_NONE) {
> @@ -982,18 +982,18 @@ static void create_fdt_uart(RISCVVirtState *s, cons=
t MemMapEntry *memmap,
>      qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
>  }
>
> -static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
> +static void create_fdt_rtc(RISCVVirtState *s,
>                             uint32_t irq_mmio_phandle)
>  {
>      g_autofree char *name =3D NULL;
>      MachineState *ms =3D MACHINE(s);
>
> -    name =3D g_strdup_printf("/soc/rtc@%lx", (long)memmap[VIRT_RTC].base=
);
> +    name =3D g_strdup_printf("/soc/rtc@%lx", (long)s->memmap[VIRT_RTC].b=
ase);
>      qemu_fdt_add_subnode(ms->fdt, name);
>      qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>          "google,goldfish-rtc");
>      qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -        0x0, memmap[VIRT_RTC].base, 0x0, memmap[VIRT_RTC].size);
> +        0x0, s->memmap[VIRT_RTC].base, 0x0, s->memmap[VIRT_RTC].size);
>      qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
>          irq_mmio_phandle);
>      if (s->aia_type =3D=3D VIRT_AIA_TYPE_NONE) {
> @@ -1143,14 +1143,14 @@ static void finalize_fdt(RISCVVirtState *s)
>          create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
>                               &iommu_sys_phandle);
>      }
> -    create_fdt_pcie(s, s->memmap, irq_pcie_phandle, msi_pcie_phandle,
> +    create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
>                      iommu_sys_phandle);
>
> -    create_fdt_reset(s, s->memmap, &phandle);
> +    create_fdt_reset(s, &phandle);
>
> -    create_fdt_uart(s, s->memmap, irq_mmio_phandle);
> +    create_fdt_uart(s, irq_mmio_phandle);
>
> -    create_fdt_rtc(s, s->memmap, irq_mmio_phandle);
> +    create_fdt_rtc(s, irq_mmio_phandle);
>  }
>
>  static void create_fdt(RISCVVirtState *s)
> --
> 2.49.0
>
>

