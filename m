Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0806C369D9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 00:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAHLn-0000tE-VK; Wed, 30 Apr 2025 20:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHLm-0000sJ-8Z; Wed, 30 Apr 2025 20:00:26 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHLk-0000us-9B; Wed, 30 Apr 2025 20:00:25 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4c300c82ca8so170369137.2; 
 Wed, 30 Apr 2025 17:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746057622; x=1746662422; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eA21bI3r15/2PQ3usgFj+0rhYeAo6ZyUS8lgVCCBD2s=;
 b=UAGsbrIFYzY+gOSPqVeIk/ub2spMzL68xglhefv8rpU0DG8NDb2vYuAyY5FCSeiuqr
 Okg0MDeJSipbJPiBqAxLGOurirMN19WtQ5Uhz/vlJy1fOZ+Sj5884hDT8teJv3V23MvD
 FwjqgCIzrbqkcEWfeWi+9MjvcMmhzjs0FcSeKHMkCai0WVOzGyCb853n+73tA9iuJg3x
 pX8McGzSweAIpDtZIKDwhKcL4e4/fhHr7bVBk+LOH0mDJzZGFERSMXFQt3KqNgMWZdiJ
 1K18MT/9kQydHZRJMXrzm6R241mpthGQACXuFsE3rwntauITFN9gF/2F3Y8EjkdE2mbo
 HZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746057622; x=1746662422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eA21bI3r15/2PQ3usgFj+0rhYeAo6ZyUS8lgVCCBD2s=;
 b=EI2r1EUZT6PkxJ+emhRkwuCTF3x7Gg/4t6ieMyPAdKlSDSQeJtlZyuNKPyYdwHWfc9
 sJ9QcMTT0v8PLEpkDdWDTe6FujSyDR3L+AyPBni0maMOfT1TBce+QAL4LH4HqrpnSpDv
 ZDfpbQVpU3l6D30DLwTiYbkLb35mhrljl7mb5eMRkTRlM6EojaQVr55wWU1XpSEZm/kM
 SAq8gPJIMzTNLRwh4QYbuO40cu1EuuQLoGs6cRQEqAXlDcJh49jEqSm6mU0MAZ9H0iGM
 Bz1RwLEhkWf57PX3/peQbjolT+a0yTrOQShWpkViAKXJnVgQ7mwcWseuxyNoFIdk+CKZ
 mHdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8SpEmq7wvBjIMBm3xpHvVpDYCfe3gjdGnQjjKJSY76rQ4x+uSGLe0TMSXshj6JzZJZdVY+PCJSgGw@nongnu.org
X-Gm-Message-State: AOJu0YxElW7163qvO7lVbeSluV18GaZA7Nt7ZUqv1FOuceOBPNItEXQv
 C+RFoDkoWsLuoff4nvrSlOu5BXyMKgs8OAbH356VRnXZkG/Ox3pyaZP/cXg6CE7alGrKbn5i3UD
 91NanSDvE+RHQJFbjn9x/JHNcCTU=
X-Gm-Gg: ASbGncvYhGPXCoP/hc3RLkKMRyVDXbuB3vRTBHIdNLZoUlVrlgkLr4Q0BpOXyxlwS5I
 sbL/GdvNTZOVLwAfst6g4iv5x87+j47c2CBgH2O/RcRT2tWHHc1f+wux4PjDGmU8QNtaHeIkaR4
 ltB9vhR564mSF+mowz4DwDanjZr/EvdwReYsy/eQ+IyFoA17Wy5n7Y
X-Google-Smtp-Source: AGHT+IE2/fTRz5rVvbUzOM+znNkqyzut6uY5tH5nmlvGfypdwl9q9athsrWrsmMMfw6ZHdkaj7h6/v1Sg0H691Pf7Wo=
X-Received: by 2002:a67:ff97:0:b0:4da:e6e1:c3ee with SMTP id
 ada2fe7eead31-4dae6e1c796mr512065137.2.1746057622127; Wed, 30 Apr 2025
 17:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
 <20250429125811.224803-3-dbarboza@ventanamicro.com>
In-Reply-To: <20250429125811.224803-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 09:59:55 +1000
X-Gm-Features: ATxdqUH3v68NhyyvyA9P9kGYOZ-eOkE8qd09WdijoFDVV4tnDXzshSOhX77TYMQ
Message-ID: <CAKmqyKOiTk0bxbT-rWaOxMW9ber4QmP7mwUj-Fx=-ZatW-7U7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] hw/riscv/virt.c: remove trivial virt_memmap
 references
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 joel@jms.id.au
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

On Tue, Apr 29, 2025 at 10:59=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We should use s->memmap instead of virt_memmap to be able to use an
> updated memmap when we start versioning the board.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index bcf0ddd6c6..b4a6916abb 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -166,8 +166,8 @@ static void virt_flash_map1(PFlashCFI01 *flash,
>  static void virt_flash_map(RISCVVirtState *s,
>                             MemoryRegion *sysmem)
>  {
> -    hwaddr flashsize =3D virt_memmap[VIRT_FLASH].size / 2;
> -    hwaddr flashbase =3D virt_memmap[VIRT_FLASH].base;
> +    hwaddr flashsize =3D s->memmap[VIRT_FLASH].size / 2;
> +    hwaddr flashbase =3D s->memmap[VIRT_FLASH].base;
>
>      virt_flash_map1(s->flash[0], flashbase, flashsize,
>                      sysmem);
> @@ -998,8 +998,8 @@ static void create_fdt_rtc(RISCVVirtState *s, const M=
emMapEntry *memmap,
>  static void create_fdt_flash(RISCVVirtState *s, const MemMapEntry *memma=
p)
>  {
>      MachineState *ms =3D MACHINE(s);
> -    hwaddr flashsize =3D virt_memmap[VIRT_FLASH].size / 2;
> -    hwaddr flashbase =3D virt_memmap[VIRT_FLASH].base;
> +    hwaddr flashsize =3D s->memmap[VIRT_FLASH].size / 2;
> +    hwaddr flashbase =3D s->memmap[VIRT_FLASH].base;
>      g_autofree char *name =3D g_strdup_printf("/flash@%" PRIx64, flashba=
se);
>
>      qemu_fdt_add_subnode(ms->fdt, name);
> @@ -1034,7 +1034,7 @@ static void create_fdt_virtio_iommu(RISCVVirtState =
*s, uint16_t bdf)
>      g_autofree char *pci_node =3D NULL;
>
>      pci_node =3D g_strdup_printf("/soc/pci@%lx",
> -                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
> +                               (long) s->memmap[VIRT_PCIE_ECAM].base);
>      iommu_node =3D g_strdup_printf("%s/virtio_iommu@%x,%x", pci_node,
>                                   PCI_SLOT(bdf), PCI_FUNC(bdf));
>      iommu_phandle =3D qemu_fdt_alloc_phandle(fdt);
> @@ -1103,7 +1103,7 @@ static void create_fdt_iommu(RISCVVirtState *s, uin=
t16_t bdf)
>      g_autofree char *pci_node =3D NULL;
>
>      pci_node =3D g_strdup_printf("/soc/pci@%lx",
> -                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
> +                               (long) s->memmap[VIRT_PCIE_ECAM].base);
>      iommu_node =3D g_strdup_printf("%s/iommu@%x", pci_node, bdf);
>      iommu_phandle =3D qemu_fdt_alloc_phandle(fdt);
>      qemu_fdt_add_subnode(fdt, iommu_node);
> @@ -1125,24 +1125,24 @@ static void finalize_fdt(RISCVVirtState *s)
>      uint32_t irq_pcie_phandle =3D 1, irq_virtio_phandle =3D 1;
>      uint32_t iommu_sys_phandle =3D 1;
>
> -    create_fdt_sockets(s, virt_memmap, &phandle, &irq_mmio_phandle,
> +    create_fdt_sockets(s, s->memmap, &phandle, &irq_mmio_phandle,
>                         &irq_pcie_phandle, &irq_virtio_phandle,
>                         &msi_pcie_phandle);
>
> -    create_fdt_virtio(s, virt_memmap, irq_virtio_phandle);
> +    create_fdt_virtio(s, s->memmap, irq_virtio_phandle);
>
>      if (virt_is_iommu_sys_enabled(s)) {
>          create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
>                               &iommu_sys_phandle);
>      }
> -    create_fdt_pcie(s, virt_memmap, irq_pcie_phandle, msi_pcie_phandle,
> +    create_fdt_pcie(s, s->memmap, irq_pcie_phandle, msi_pcie_phandle,
>                      iommu_sys_phandle);
>
> -    create_fdt_reset(s, virt_memmap, &phandle);
> +    create_fdt_reset(s, s->memmap, &phandle);
>
> -    create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
> +    create_fdt_uart(s, s->memmap, irq_mmio_phandle);
>
> -    create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
> +    create_fdt_rtc(s, s->memmap, irq_mmio_phandle);
>  }
>
>  static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
> @@ -1365,14 +1365,13 @@ static void create_platform_bus(RISCVVirtState *s=
, DeviceState *irqchip)
>  {
>      DeviceState *dev;
>      SysBusDevice *sysbus;
> -    const MemMapEntry *memmap =3D virt_memmap;
>      int i;
>      MemoryRegion *sysmem =3D get_system_memory();
>
>      dev =3D qdev_new(TYPE_PLATFORM_BUS_DEVICE);
>      dev->id =3D g_strdup(TYPE_PLATFORM_BUS_DEVICE);
>      qdev_prop_set_uint32(dev, "num_irqs", VIRT_PLATFORM_BUS_NUM_IRQS);
> -    qdev_prop_set_uint32(dev, "mmio_size", memmap[VIRT_PLATFORM_BUS].siz=
e);
> +    qdev_prop_set_uint32(dev, "mmio_size", s->memmap[VIRT_PLATFORM_BUS].=
size);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      s->platform_bus_dev =3D dev;
>
> @@ -1383,7 +1382,7 @@ static void create_platform_bus(RISCVVirtState *s, =
DeviceState *irqchip)
>      }
>
>      memory_region_add_subregion(sysmem,
> -                                memmap[VIRT_PLATFORM_BUS].base,
> +                                s->memmap[VIRT_PLATFORM_BUS].base,
>                                  sysbus_mmio_get_region(sysbus, 0));
>  }
>
> --
> 2.49.0
>
>

