Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96320C2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 01:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMHEJ-0006Bx-BH; Tue, 25 Jun 2024 21:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMHDg-0005vt-4O; Tue, 25 Jun 2024 21:13:08 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMHCu-00061i-Lp; Tue, 25 Jun 2024 21:12:59 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4ef64689d24so1181108e0c.1; 
 Tue, 25 Jun 2024 18:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719364226; x=1719969026; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GL/ZwUKc+mBhqLaIRcpvbV84NMv7Xv7anY16hqD68M=;
 b=KhO2xseWOG4L3A5EYNjsJqjHT15fVMR02TFp7PIevDKZDWGznCz9V0cAq52Zx6TYMa
 drMp6rqbKKsrrODLHmJjaqpfwN8YCNXWhDk+BAz6ZFfBmNH03oRmUQoNru1myPSU0kx3
 klBEKq+gGAkXCcxme7oeHqIJfwO5QDo7zB3FQyjhwL9s2KY3CJMFjM/0mDtK5/hze1Fz
 fCr7yn4LLky6w+Ep8ModWu5wvdeH/sPv976RfE/a/BOrsHK7HnaxWCDUf8bmahTZCX7j
 DOIjAGGXIrYORkwSvJ8Ees/WdD9syb92X3EAuEAkTelp1c4ToYaV4SN+VmDphvGXEucX
 XYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719364226; x=1719969026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2GL/ZwUKc+mBhqLaIRcpvbV84NMv7Xv7anY16hqD68M=;
 b=vfoAKGnfCOYMr7c1JdtHcOMl4qFakVrtalPoot7lDnALAMxSAXqat4fkjtOvweb//a
 7OeZw1dxerK6nS/ZZ+ihEBj03nfQh+dmtmWXeOQKqPaoNHNw2gqEABntxfabuiVjRCLM
 vyc/BXu6qlHVMko2PBRB9YCsfs0DiBMO/WNM4oOZZxJzJmE2ghHumgdmayvX1P8rl59s
 lpsLqSiSXI1IO5JraJpVJ+EmN5hzcOk1OY7in8D5GWJRAyJGXfTijYqs3CJcd13iZxz3
 /GlYoc8aTTWeE4BJvIuPks3EWDWCVnf6ZSa0sHSCVJYf71/8V35R3GyT7pDO1GOOijJG
 z8KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMgueagb8LCHFEunc24ArzwFENS8/uPV7maMyJ7Tb8Skvs4WrPvRcrKrMFaGMuabOuJILuRV+BQamRi/lyPtW8h1KagMI=
X-Gm-Message-State: AOJu0YxKdZ3Rxm46NA6a1UQM+srBbigqxr6s29jKQzs8k76966JrYmLW
 bILE7K8kO5PruFdVoTeOftQCwWXLpAq507Aqd5f1QhwNNn+pcAH/9JvB5jpA2v+PsZTNaIGqIPr
 rwTletyPAJ3vP9IPXw1sl2X0D2Aw=
X-Google-Smtp-Source: AGHT+IGUMYteh4Aw3Yb1ZFBFErRRRbGlEhEKf3Feedh3y3luRddH7CJG44qloI2TIbZ/VQdhXBThp/qUcnh4z/BKFbc=
X-Received: by 2002:ac5:cb4c:0:b0:4ef:668f:2438 with SMTP id
 71dfb90a1353d-4ef668f245fmr7016429e0c.0.1719364225957; Tue, 25 Jun 2024
 18:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
 <20240624201825.1054980-8-dbarboza@ventanamicro.com>
In-Reply-To: <20240624201825.1054980-8-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 11:10:00 +1000
Message-ID: <CAKmqyKN6pWsT7CNY=Ov4+8XZy2pEwgxqNiUfFtOcEtp_9g5x6Q@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] test/qtest: add riscv-iommu-pci tests
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com, 
 frank.chang@sifive.com, jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 25, 2024 at 6:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> To test the RISC-V IOMMU emulation we'll use its PCI representation.
> Create a new 'riscv-iommu-pci' libqos device that will be present with
> CONFIG_RISCV_IOMMU.  This config is only available for RISC-V, so this
> device will only be consumed by the RISC-V libqos machine.
>
> Start with basic tests: a PCI sanity check and a reset state register
> test. The reset test was taken from the RISC-V IOMMU spec chapter 5.2,
> "Reset behavior".
>
> More tests will be added later.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/libqos/meson.build   |  4 ++
>  tests/qtest/libqos/riscv-iommu.c | 76 ++++++++++++++++++++++++++
>  tests/qtest/libqos/riscv-iommu.h | 71 ++++++++++++++++++++++++
>  tests/qtest/meson.build          |  1 +
>  tests/qtest/riscv-iommu-test.c   | 93 ++++++++++++++++++++++++++++++++
>  5 files changed, 245 insertions(+)
>  create mode 100644 tests/qtest/libqos/riscv-iommu.c
>  create mode 100644 tests/qtest/libqos/riscv-iommu.h
>  create mode 100644 tests/qtest/riscv-iommu-test.c
>
> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.bu=
ild
> index 558eb4c24b..03fd51b804 100644
> --- a/tests/qtest/libqos/meson.build
> +++ b/tests/qtest/libqos/meson.build
> @@ -68,6 +68,10 @@ if have_virtfs
>    libqos_srcs +=3D files('virtio-9p.c', 'virtio-9p-client.c')
>  endif
>
> +if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
> +  libqos_srcs +=3D files('riscv-iommu.c')
> +endif
> +
>  libqos =3D static_library('qos', libqos_srcs + genh,
>                          name_suffix: 'fa',
>                          build_by_default: false)
> diff --git a/tests/qtest/libqos/riscv-iommu.c b/tests/qtest/libqos/riscv-=
iommu.c
> new file mode 100644
> index 0000000000..01e3b31c0b
> --- /dev/null
> +++ b/tests/qtest/libqos/riscv-iommu.c
> @@ -0,0 +1,76 @@
> +/*
> + * libqos driver riscv-iommu-pci framework
> + *
> + * Copyright (c) 2024 Ventana Micro Systems Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t your
> + * option) any later version.  See the COPYING file in the top-level dir=
ectory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "../libqtest.h"
> +#include "qemu/module.h"
> +#include "qgraph.h"
> +#include "pci.h"
> +#include "riscv-iommu.h"
> +
> +static void *riscv_iommu_pci_get_driver(void *obj, const char *interface=
)
> +{
> +    QRISCVIOMMU *r_iommu_pci =3D obj;
> +
> +    if (!g_strcmp0(interface, "pci-device")) {
> +        return &r_iommu_pci->dev;
> +    }
> +
> +    fprintf(stderr, "%s not present in riscv_iommu_pci\n", interface);
> +    g_assert_not_reached();
> +}
> +
> +static void riscv_iommu_pci_start_hw(QOSGraphObject *obj)
> +{
> +    QRISCVIOMMU *pci =3D (QRISCVIOMMU *)obj;
> +    qpci_device_enable(&pci->dev);
> +}
> +
> +static void riscv_iommu_pci_destructor(QOSGraphObject *obj)
> +{
> +    QRISCVIOMMU *pci =3D (QRISCVIOMMU *)obj;
> +    qpci_iounmap(&pci->dev, pci->reg_bar);
> +}
> +
> +static void *riscv_iommu_pci_create(void *pci_bus, QGuestAllocator *allo=
c,
> +                                    void *addr)
> +{
> +    QRISCVIOMMU *r_iommu_pci =3D g_new0(QRISCVIOMMU, 1);
> +    QPCIBus *bus =3D pci_bus;
> +
> +    qpci_device_init(&r_iommu_pci->dev, bus, addr);
> +    r_iommu_pci->reg_bar =3D qpci_iomap(&r_iommu_pci->dev, 0, NULL);
> +
> +    r_iommu_pci->obj.get_driver =3D riscv_iommu_pci_get_driver;
> +    r_iommu_pci->obj.start_hw =3D riscv_iommu_pci_start_hw;
> +    r_iommu_pci->obj.destructor =3D riscv_iommu_pci_destructor;
> +    return &r_iommu_pci->obj;
> +}
> +
> +static void riscv_iommu_pci_register_nodes(void)
> +{
> +    QPCIAddress addr =3D {
> +        .vendor_id =3D RISCV_IOMMU_PCI_VENDOR_ID,
> +        .device_id =3D RISCV_IOMMU_PCI_DEVICE_ID,
> +        .devfn =3D QPCI_DEVFN(1, 0),
> +    };
> +
> +    QOSGraphEdgeOptions opts =3D {
> +        .extra_device_opts =3D "addr=3D01.0",
> +    };
> +
> +    add_qpci_address(&opts, &addr);
> +
> +    qos_node_create_driver("riscv-iommu-pci", riscv_iommu_pci_create);
> +    qos_node_produces("riscv-iommu-pci", "pci-device");
> +    qos_node_consumes("riscv-iommu-pci", "pci-bus", &opts);
> +}
> +
> +libqos_init(riscv_iommu_pci_register_nodes);
> diff --git a/tests/qtest/libqos/riscv-iommu.h b/tests/qtest/libqos/riscv-=
iommu.h
> new file mode 100644
> index 0000000000..d123efb41f
> --- /dev/null
> +++ b/tests/qtest/libqos/riscv-iommu.h
> @@ -0,0 +1,71 @@
> +/*
> + * libqos driver riscv-iommu-pci framework
> + *
> + * Copyright (c) 2024 Ventana Micro Systems Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t your
> + * option) any later version.  See the COPYING file in the top-level dir=
ectory.
> + *
> + */
> +
> +#ifndef TESTS_LIBQOS_RISCV_IOMMU_H
> +#define TESTS_LIBQOS_RISCV_IOMMU_H
> +
> +#include "qgraph.h"
> +#include "pci.h"
> +#include "qemu/bitops.h"
> +
> +#ifndef GENMASK_ULL
> +#define GENMASK_ULL(h, l) (((~0ULL) >> (63 - (h) + (l))) << (l))
> +#endif
> +
> +/*
> + * RISC-V IOMMU uses PCI_VENDOR_ID_REDHAT 0x1b36 and
> + * PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014.
> + */
> +#define RISCV_IOMMU_PCI_VENDOR_ID       0x1b36
> +#define RISCV_IOMMU_PCI_DEVICE_ID       0x0014
> +#define RISCV_IOMMU_PCI_DEVICE_CLASS    0x0806
> +
> +/* Common field positions */
> +#define RISCV_IOMMU_QUEUE_ENABLE        BIT(0)
> +#define RISCV_IOMMU_QUEUE_INTR_ENABLE   BIT(1)
> +#define RISCV_IOMMU_QUEUE_MEM_FAULT     BIT(8)
> +#define RISCV_IOMMU_QUEUE_ACTIVE        BIT(16)
> +#define RISCV_IOMMU_QUEUE_BUSY          BIT(17)
> +
> +#define RISCV_IOMMU_REG_CAP             0x0000
> +#define RISCV_IOMMU_CAP_VERSION         GENMASK_ULL(7, 0)
> +
> +#define RISCV_IOMMU_REG_DDTP            0x0010
> +#define RISCV_IOMMU_DDTP_BUSY           BIT_ULL(4)
> +#define RISCV_IOMMU_DDTP_MODE           GENMASK_ULL(3, 0)
> +#define RISCV_IOMMU_DDTP_MODE_OFF       0
> +
> +#define RISCV_IOMMU_REG_CQCSR           0x0048
> +#define RISCV_IOMMU_CQCSR_CQEN          RISCV_IOMMU_QUEUE_ENABLE
> +#define RISCV_IOMMU_CQCSR_CIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
> +#define RISCV_IOMMU_CQCSR_CQON          RISCV_IOMMU_QUEUE_ACTIVE
> +#define RISCV_IOMMU_CQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
> +
> +#define RISCV_IOMMU_REG_FQCSR           0x004C
> +#define RISCV_IOMMU_FQCSR_FQEN          RISCV_IOMMU_QUEUE_ENABLE
> +#define RISCV_IOMMU_FQCSR_FIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
> +#define RISCV_IOMMU_FQCSR_FQON          RISCV_IOMMU_QUEUE_ACTIVE
> +#define RISCV_IOMMU_FQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
> +
> +#define RISCV_IOMMU_REG_PQCSR           0x0050
> +#define RISCV_IOMMU_PQCSR_PQEN          RISCV_IOMMU_QUEUE_ENABLE
> +#define RISCV_IOMMU_PQCSR_PIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
> +#define RISCV_IOMMU_PQCSR_PQON          RISCV_IOMMU_QUEUE_ACTIVE
> +#define RISCV_IOMMU_PQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
> +
> +#define RISCV_IOMMU_REG_IPSR            0x0054
> +
> +typedef struct QRISCVIOMMU {
> +    QOSGraphObject obj;
> +    QPCIDevice dev;
> +    QPCIBar reg_bar;
> +} QRISCVIOMMU;
> +
> +#endif
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 12792948ff..a838450d2d 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -293,6 +293,7 @@ qos_test_ss.add(
>    'vmxnet3-test.c',
>    'igb-test.c',
>    'ufs-test.c',
> +  'riscv-iommu-test.c',
>  )
>
>  if config_all_devices.has_key('CONFIG_VIRTIO_SERIAL')
> diff --git a/tests/qtest/riscv-iommu-test.c b/tests/qtest/riscv-iommu-tes=
t.c
> new file mode 100644
> index 0000000000..7f0dbd0211
> --- /dev/null
> +++ b/tests/qtest/riscv-iommu-test.c
> @@ -0,0 +1,93 @@
> +/*
> + * QTest testcase for RISC-V IOMMU
> + *
> + * Copyright (c) 2024 Ventana Micro Systems Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t your
> + * option) any later version.  See the COPYING file in the top-level dir=
ectory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +#include "qemu/module.h"
> +#include "libqos/qgraph.h"
> +#include "libqos/riscv-iommu.h"
> +#include "hw/pci/pci_regs.h"
> +
> +static uint32_t riscv_iommu_read_reg32(QRISCVIOMMU *r_iommu, int reg_off=
set)
> +{
> +    uint32_t reg;
> +
> +    qpci_memread(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
> +                 &reg, sizeof(reg));
> +    return reg;
> +}
> +
> +static uint64_t riscv_iommu_read_reg64(QRISCVIOMMU *r_iommu, int reg_off=
set)
> +{
> +    uint64_t reg;
> +
> +    qpci_memread(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
> +                 &reg, sizeof(reg));
> +    return reg;
> +}
> +
> +static void test_pci_config(void *obj, void *data, QGuestAllocator *t_al=
loc)
> +{
> +    QRISCVIOMMU *r_iommu =3D obj;
> +    QPCIDevice *dev =3D &r_iommu->dev;
> +    uint16_t vendorid, deviceid, classid;
> +
> +    vendorid =3D qpci_config_readw(dev, PCI_VENDOR_ID);
> +    deviceid =3D qpci_config_readw(dev, PCI_DEVICE_ID);
> +    classid =3D qpci_config_readw(dev, PCI_CLASS_DEVICE);
> +
> +    g_assert_cmpuint(vendorid, =3D=3D, RISCV_IOMMU_PCI_VENDOR_ID);
> +    g_assert_cmpuint(deviceid, =3D=3D, RISCV_IOMMU_PCI_DEVICE_ID);
> +    g_assert_cmpuint(classid, =3D=3D, RISCV_IOMMU_PCI_DEVICE_CLASS);
> +}
> +
> +static void test_reg_reset(void *obj, void *data, QGuestAllocator *t_all=
oc)
> +{
> +    QRISCVIOMMU *r_iommu =3D obj;
> +    uint64_t cap;
> +    uint32_t reg;
> +
> +    cap =3D riscv_iommu_read_reg64(r_iommu, RISCV_IOMMU_REG_CAP);
> +    g_assert_cmpuint(cap & RISCV_IOMMU_CAP_VERSION, =3D=3D, 0x10);
> +
> +    reg =3D riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_CQCSR);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_CQEN, =3D=3D, 0);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_CIE, =3D=3D, 0);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_CQON, =3D=3D, 0);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_CQCSR_BUSY, =3D=3D, 0);
> +
> +    reg =3D riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_FQCSR);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_FQEN, =3D=3D, 0);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_FIE, =3D=3D, 0);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_FQON, =3D=3D, 0);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_FQCSR_BUSY, =3D=3D, 0);
> +
> +    reg =3D riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_PQCSR);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_PQEN, =3D=3D, 0);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_PIE, =3D=3D, 0);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_PQON, =3D=3D, 0);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_PQCSR_BUSY, =3D=3D, 0);
> +
> +    reg =3D riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_DDTP);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_DDTP_BUSY, =3D=3D, 0);
> +    g_assert_cmpuint(reg & RISCV_IOMMU_DDTP_MODE, =3D=3D,
> +                     RISCV_IOMMU_DDTP_MODE_OFF);
> +
> +    reg =3D riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IPSR);
> +    g_assert_cmpuint(reg, =3D=3D, 0);
> +}
> +
> +static void register_riscv_iommu_test(void)
> +{
> +    qos_add_test("pci_config", "riscv-iommu-pci", test_pci_config, NULL)=
;
> +    qos_add_test("reg_reset", "riscv-iommu-pci", test_reg_reset, NULL);
> +}
> +
> +libqos_init(register_riscv_iommu_test);
> --
> 2.45.2
>
>

