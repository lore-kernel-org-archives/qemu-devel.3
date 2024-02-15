Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F42C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 05:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raU2R-0006Qg-NL; Thu, 15 Feb 2024 00:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raU2Q-0006Q4-Eu; Thu, 15 Feb 2024 00:11:58 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raU2O-0003UA-5F; Thu, 15 Feb 2024 00:11:57 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4c02779e68cso136371e0c.3; 
 Wed, 14 Feb 2024 21:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707973910; x=1708578710; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtvLiUOhjI6TYhk5Azv7wfrMjxB64+qt+9ntYZO+Cn0=;
 b=KjH6KlvqnWn3orJpZz7Q2wxkoU1rlR582RUkOYUKSxN4aGi9FEaf3I2Lc6pxnsX9ej
 fVdTtYeo+N243t51kdsRnMdXVWkpBdCEP3FChFOrqTZ4Z2x7S7nTkd01CblF5JZiQBUP
 vcYIhiORXfBOxvKS1iR4J+uKHt4uxnTF2SgZbsAp6x+lN3799EH/m5EbdxxxNO+6g2do
 WuFuqS1LEHvoNS6aOHRb6CTZXvrX8c58eyzLK7pTQFbSBngppofJoZLGHyzZluQ+TR3t
 zOCj//XUzFkKG7tqHqc3Xki/bswpzhBspIYFV7Bl3QioOYqSkyIfW6mmoI6Y5Wp/pOLp
 Sanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707973910; x=1708578710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtvLiUOhjI6TYhk5Azv7wfrMjxB64+qt+9ntYZO+Cn0=;
 b=CRG9dvI3Q/zQg8XCyOXUyRA5duB4NrCOZGCYQYm7TYZu9bQNPxHZUJFR7cM3GzpxUx
 OlfKC1YEJJKP0Jfh2OQqMBYByoCmPNXCtDnITxfeswrziVglx0kQM23KYHa1T82RcLcj
 dRFvbPx708sHY2H7grlgBaM1q9awFcyNMRgb+lbc+7zXv1dke4297WDZVx22bJvOVJUy
 E3WuUj/kP3rXh/Tm6iO9Mf5o8A26e/xAe0YXcB0eUZGt1JaDlx575H+pEpsu25vGLeUj
 GQnS+LVLysdSm3EmbGoGQxsqZZzIt9+Uu3hHnwMm56bJ4tmvQTPVg/zgDlTMpvlkEMlO
 lWnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjpFvldWBDI7VzM8Cimj5HtcuZW0cKqUkZ3G1yjXaE4gScd9w9lKlCQ+SlvWq+yCc+gjQKgK27sKbDqNsc+GmCHjtPdbQ=
X-Gm-Message-State: AOJu0Yy15IyHB+m8br9+p3mx/6FK+VwRStvLkNmBPS/XyLq+wD4Fj0LF
 gqhOEaHyyZEEGWu/cN5f/XJ7JQG6q929Ibuve4hBSsdAPUwaHZeLvuuDk2/eFh3LxEhubx1vh83
 757UTNAUjDvbBpf/wC7vconJ/f+0=
X-Google-Smtp-Source: AGHT+IF6HJX9nvuxFy2vSj3yMiex1kN6oNNbJ6gFLMZaeVQx727n7vnZZ/1KAsncdk9vpQU93LKiiSqfIiBOf019CwU=
X-Received: by 2002:a1f:ccc4:0:b0:4c0:23bd:1f0d with SMTP id
 c187-20020a1fccc4000000b004c023bd1f0dmr472145vkg.15.1707973910487; Wed, 14
 Feb 2024 21:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
 <20240213191736.733334-5-dbarboza@ventanamicro.com>
In-Reply-To: <20240213191736.733334-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 15:11:24 +1000
Message-ID: <CAKmqyKNE_DAq6z3Yn8Uugdu2vqSerwh=kM-a65uW-VfRXFrbcA@mail.gmail.com>
Subject: Re: [PATCH 4/6] hw/riscv/virt.c: add virtio-iommu-pci hotplug support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, thuth@redhat.com, lvivier@redhat.com, 
 pbonzini@redhat.com, ajones@ventanamicro.com, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 14, 2024 at 5:18=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We want to add a RISC-V 'virt' libqos machine to increase our test
> coverage. Some of the tests will try to plug a virtio-iommu-pci
> device into the board and do some tests with it.
>
> Enable virtio-iommu-pci in the 'virt' machine.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index b540f4d3da..54ad809b44 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -53,6 +53,7 @@
>  #include "hw/display/ramfb.h"
>  #include "hw/acpi/aml-build.h"
>  #include "qapi/qapi-visit-common.h"
> +#include "hw/virtio/virtio-iommu.h"
>
>  /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QE=
MU. */
>  static bool virt_use_kvm_aia(RISCVVirtState *s)
> @@ -971,6 +972,34 @@ static void create_fdt_fw_cfg(RISCVVirtState *s, con=
st MemMapEntry *memmap)
>      qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
>  }
>
> +static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
> +{
> +    const char compat[] =3D "virtio,pci-iommu\0pci1af4,1057";
> +    void *fdt =3D MACHINE(s)->fdt;
> +    uint32_t iommu_phandle;
> +    g_autofree char *iommu_node =3D NULL;
> +    g_autofree char *pci_node =3D NULL;
> +
> +    pci_node =3D g_strdup_printf("/soc/pci@%lx",
> +                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
> +    iommu_node =3D g_strdup_printf("%s/virtio_iommu@%x,%x", pci_node,
> +                                 PCI_SLOT(bdf), PCI_FUNC(bdf));
> +    iommu_phandle =3D qemu_fdt_alloc_phandle(fdt);
> +
> +    qemu_fdt_add_subnode(fdt, iommu_node);
> +
> +    qemu_fdt_setprop(fdt, iommu_node, "compatible", compat, sizeof(compa=
t));
> +    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg",
> +                                 1, bdf << 8, 1, 0, 1, 0,
> +                                 1, 0, 1, 0);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
> +
> +    qemu_fdt_setprop_cells(fdt, pci_node, "iommu-map",
> +                           0, iommu_phandle, 0, bdf,
> +                           bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf=
);
> +}
> +
>  static void finalize_fdt(RISCVVirtState *s)
>  {
>      uint32_t phandle =3D 1, irq_mmio_phandle =3D 1, msi_pcie_phandle =3D=
 1;
> @@ -1680,7 +1709,8 @@ static HotplugHandler *virt_machine_get_hotplug_han=
dler(MachineState *machine,
>  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>
> -    if (device_is_dynamic_sysbus(mc, dev)) {
> +    if (device_is_dynamic_sysbus(mc, dev) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          return HOTPLUG_HANDLER(machine);
>      }
>      return NULL;
> @@ -1699,6 +1729,10 @@ static void virt_machine_device_plug_cb(HotplugHan=
dler *hotplug_dev,
>                                       SYS_BUS_DEVICE(dev));
>          }
>      }
> +
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
> +    }
>  }
>
>  static void virt_machine_class_init(ObjectClass *oc, void *data)
> --
> 2.43.0
>
>

