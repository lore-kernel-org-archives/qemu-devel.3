Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFE7C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 05:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raUQ4-0006wi-9i; Thu, 15 Feb 2024 00:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raUQ0-0006vL-Ac; Thu, 15 Feb 2024 00:36:20 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raUPy-0001lO-8S; Thu, 15 Feb 2024 00:36:20 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4c03b2ac77aso179145e0c.3; 
 Wed, 14 Feb 2024 21:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707975376; x=1708580176; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hQBK5H5ykb6WrhPN/OpgRpu4/CIHFkDJVaNSCPgi3s=;
 b=LBcPFy9gHgKwrQ59tPUwFSajGjd7LhJqTYiUiE57rRIzo6nPBFr34lhMMg2y0vghqp
 Css2fNP59cRppT3ASaOjBZSnITzzsWmS2gznjJSikI+8NG0E/4FwaEOiQ3QOSPl0dYMz
 nq+atNoerT4hGs/FAuGHeUv8BC1A6dAfLCi4tb45CqgnHV0EDmcGdBBWoawwV7RbpjBL
 JIR4g5ZzORFPpzr7ziszX0BSnRDGJi+8tRflJfEu2JqSgjxvRMGEUVpfn1mVxP3kVtWw
 rI9NFu52ZL8wZUiB9+hKMHck0+sa9KIkuTZthVPyq5+hTg/xPj6Pc3RwUscQMjAPGDQo
 ly5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707975376; x=1708580176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hQBK5H5ykb6WrhPN/OpgRpu4/CIHFkDJVaNSCPgi3s=;
 b=bgFPX3SZ10DWHYD8jCvNaBELH1Ygx1y4XYWwfw585fkBuUZwzqXd6aqG3TXTrr3rqr
 GlpG1+GvA6mvFssigXEsQPekRkfWQpd/r4Wa36fO9t3TZQHW/8AO/jcmwXroOru54p9/
 CblCJWOhfLiCWGLnE/bzWyzWPEWWOnbX8xbRy8Y1N3+oBRo13Vsi/or/bFIV9Kjc4fY2
 ECCZeQmppujJO9HFr2zkzY1s95S9/7iUDlBWzU4t9IgSMRrNQVjfPJr0zi+YJ2XjMq6l
 vP/gyvNSYBHHXOagnmwyJVLmvoG4gyzqpHw/X/XaOuZkTSGcBVIG69D6tT3lFXb9/BKh
 0G7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQH9kyC+d3jCXDJT8I33IXdbMlWuZ4pImHOpTe9apQcV8b2imczGQtsJhL2ELbakUdfpV3IMXn09/I/nXSrCci8PKLBbE=
X-Gm-Message-State: AOJu0YzBpEXwDB4agR20jDTM5qlN1b5yUhvK50uAxndw4cC5xKiXhbak
 GiTqCLf1cY/WXzaMx3hrxQcNZU8bauUNSFavCKugrHEr3sZCSxqEAvbBGUN1p/EGFc3sPANp6km
 tI4q7SekpSf/SzCbDu6Z3/OaV6NE=
X-Google-Smtp-Source: AGHT+IES1gZRAmwK+crsPF2n3g8lDQrP1A6alNtzjiuoZhk48G8ZBXu16tyOueVhYCQslRSMO4TrOxepF1tCRrXQR+Q=
X-Received: by 2002:a1f:4907:0:b0:4c0:3ea1:a4a0 with SMTP id
 w7-20020a1f4907000000b004c03ea1a4a0mr381899vka.16.1707975376541; Wed, 14 Feb
 2024 21:36:16 -0800 (PST)
MIME-Version: 1.0
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
 <20240213191736.733334-7-dbarboza@ventanamicro.com>
In-Reply-To: <20240213191736.733334-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 15:35:50 +1000
Message-ID: <CAKmqyKNHXwNR7Pb636-CK5FU499kGyMxyos7fijH-=3ZG5+kew@mail.gmail.com>
Subject: Re: [PATCH 6/6] tests/libqos: add riscv/virt machine nodes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, thuth@redhat.com, lvivier@redhat.com, 
 pbonzini@redhat.com, ajones@ventanamicro.com, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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
> Add a RISC-V 'virt' machine to the graph. This implementation is a
> modified copy of the existing arm machine in arm-virt-machine.c
>
> It contains a virtio-mmio and a generic-pcihost controller. The
> generic-pcihost controller hardcodes assumptions from the ARM 'virt'
> machine, like ecam and pio_base addresses, so we'll add an extra step to
> set its parameters after creating it.
>
> Our command line is incremented with 'aclint' parameters to allow the
> machine to run MSI tests.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/libqos/meson.build          |   1 +
>  tests/qtest/libqos/riscv-virt-machine.c | 137 ++++++++++++++++++++++++
>  2 files changed, 138 insertions(+)
>  create mode 100644 tests/qtest/libqos/riscv-virt-machine.c
>
> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.bu=
ild
> index 90aae42a22..3aed6efcb8 100644
> --- a/tests/qtest/libqos/meson.build
> +++ b/tests/qtest/libqos/meson.build
> @@ -60,6 +60,7 @@ libqos_srcs =3D files(
>          'arm-xilinx-zynq-a9-machine.c',
>          'ppc64_pseries-machine.c',
>          'x86_64_pc-machine.c',
> +        'riscv-virt-machine.c',
>  )
>
>  if have_virtfs
> diff --git a/tests/qtest/libqos/riscv-virt-machine.c b/tests/qtest/libqos=
/riscv-virt-machine.c
> new file mode 100644
> index 0000000000..c4364c9c5d
> --- /dev/null
> +++ b/tests/qtest/libqos/riscv-virt-machine.c
> @@ -0,0 +1,137 @@
> +/*
> + * libqos driver framework for risc-v
> + *
> + * Initial version based on arm-virt-machine.c
> + *
> + * Copyright (c) 2024 Ventana Micro
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2.1 as published by the Free Software Foundation.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "../libqtest.h"
> +#include "qemu/module.h"
> +#include "libqos-malloc.h"
> +#include "qgraph.h"
> +#include "virtio-mmio.h"
> +#include "generic-pcihost.h"
> +#include "hw/pci/pci_regs.h"
> +
> +#define RISCV_PAGE_SIZE            4096
> +
> +/* VIRT_DRAM */
> +#define RISCV_VIRT_RAM_ADDR        0x80000000
> +#define RISCV_VIRT_RAM_SIZE        0x20000000
> +
> +/*
> + * VIRT_VIRTIO. BASE_ADDR  points to the last
> + * virtio_mmio device.
> + */
> +#define VIRTIO_MMIO_BASE_ADDR      0x10008000
> +#define VIRTIO_MMIO_SIZE           0x00001000
> +
> +/* VIRT_PCIE_PIO  */
> +#define RISCV_GPEX_PIO_BASE        0x3000000
> +#define RISCV_BUS_PIO_LIMIT        0x10000
> +
> +/* VIRT_PCIE_MMIO */
> +#define RISCV_BUS_MMIO_ALLOC_PTR   0x40000000
> +#define RISCV_BUS_MMIO_LIMIT       0x80000000
> +
> +/* VIRT_PCIE_ECAM */
> +#define RISCV_ECAM_ALLOC_PTR   0x30000000
> +
> +typedef struct QVirtMachine QVirtMachine;
> +
> +struct QVirtMachine {
> +    QOSGraphObject obj;
> +    QGuestAllocator alloc;
> +    QVirtioMMIODevice virtio_mmio;
> +    QGenericPCIHost bridge;
> +};
> +
> +static void virt_destructor(QOSGraphObject *obj)
> +{
> +    QVirtMachine *machine =3D (QVirtMachine *) obj;
> +    alloc_destroy(&machine->alloc);
> +}
> +
> +static void *virt_get_driver(void *object, const char *interface)
> +{
> +    QVirtMachine *machine =3D object;
> +    if (!g_strcmp0(interface, "memory")) {
> +        return &machine->alloc;
> +    }
> +
> +    fprintf(stderr, "%s not present in riscv/virtio\n", interface);
> +    g_assert_not_reached();
> +}
> +
> +static QOSGraphObject *virt_get_device(void *obj, const char *device)
> +{
> +    QVirtMachine *machine =3D obj;
> +    if (!g_strcmp0(device, "generic-pcihost")) {
> +        return &machine->bridge.obj;
> +    } else if (!g_strcmp0(device, "virtio-mmio")) {
> +        return &machine->virtio_mmio.obj;
> +    }
> +
> +    fprintf(stderr, "%s not present in riscv/virt\n", device);
> +    g_assert_not_reached();
> +}
> +
> +static void riscv_config_qpci_bus(QGenericPCIBus *qpci)
> +{
> +    qpci->gpex_pio_base =3D RISCV_GPEX_PIO_BASE;
> +    qpci->bus.pio_limit =3D RISCV_BUS_PIO_LIMIT;
> +
> +    qpci->bus.mmio_alloc_ptr =3D RISCV_BUS_MMIO_ALLOC_PTR;
> +    qpci->bus.mmio_limit =3D RISCV_BUS_MMIO_LIMIT;
> +
> +    qpci->ecam_alloc_ptr =3D RISCV_ECAM_ALLOC_PTR;
> +}
> +
> +static void *qos_create_machine_riscv_virt(QTestState *qts)
> +{
> +    QVirtMachine *machine =3D g_new0(QVirtMachine, 1);
> +
> +    alloc_init(&machine->alloc, 0,
> +               RISCV_VIRT_RAM_ADDR,
> +               RISCV_VIRT_RAM_ADDR + RISCV_VIRT_RAM_SIZE,
> +               RISCV_PAGE_SIZE);
> +    qvirtio_mmio_init_device(&machine->virtio_mmio, qts, VIRTIO_MMIO_BAS=
E_ADDR,
> +                              VIRTIO_MMIO_SIZE);
> +
> +    qos_create_generic_pcihost(&machine->bridge, qts, &machine->alloc);
> +    riscv_config_qpci_bus(&machine->bridge.pci);
> +
> +    machine->obj.get_device =3D virt_get_device;
> +    machine->obj.get_driver =3D virt_get_driver;
> +    machine->obj.destructor =3D virt_destructor;
> +    return machine;
> +}
> +
> +static void virt_machine_register_nodes(void)
> +{
> +    qos_node_create_machine_args("riscv32/virt", qos_create_machine_risc=
v_virt,
> +                                 "aclint=3Don,aia=3Daplic-imsic");
> +    qos_node_contains("riscv32/virt", "virtio-mmio", NULL);
> +    qos_node_contains("riscv32/virt", "generic-pcihost", NULL);
> +
> +    qos_node_create_machine_args("riscv64/virt", qos_create_machine_risc=
v_virt,
> +                                 "aclint=3Don,aia=3Daplic-imsic");
> +    qos_node_contains("riscv64/virt", "virtio-mmio", NULL);
> +    qos_node_contains("riscv64/virt", "generic-pcihost", NULL);
> +}
> +
> +libqos_init(virt_machine_register_nodes);
> --
> 2.43.0
>
>

