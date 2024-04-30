Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CEDC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 03:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1eFW-00080J-Be; Mon, 29 Apr 2024 23:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s1eFS-0007zT-ES
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 23:33:42 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s1eFQ-0005NK-B2
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 23:33:42 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-516d4d80d00so6555007e87.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 20:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1714448018; x=1715052818; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NL1hKcR690m19HCUSiIpKQeZmFyqkz/mL6QgCqMpFZU=;
 b=iknFN+Vt4wYZ2QVZkIKbvTtZKYMzrnf14DCD2XRQB8yUWhdY2IGXiObSOgKUjs94UK
 2ZW5nxZJC+1H9Ar23f36fYY0iatKO5Kjjn8FsC3W7ZXNbPiY1LzA8uO46CeqhfrN1xxK
 dVNxrBYmk0S5Z/LcgJKB15x0f1Xw0L16+tYmbsXCKkb57zNp2i7ngWKfFzpaV93h4A7Z
 rdQzRBh8b7OxdcNyQshTs8Ejhmiddld5NbOotjUQZAZmjPuB+tKaUISuxuKrOuIUo0rz
 ClS5KbqzgDeSTeI8Tg6fYiSzMieFgAB8aP7+0Mpq5PyJ2hcZwmWOg50rnpu7wttBu7bB
 jStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714448018; x=1715052818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NL1hKcR690m19HCUSiIpKQeZmFyqkz/mL6QgCqMpFZU=;
 b=w197ndD3yuxfjjG2Z5QwGbhO/ljCFO9V3BuN2XDGKwV2NFrhJZQrFMafj/XsZbhrYE
 JVyxFgdVbwG08kK1uxvHvojHnLPuQyBJPWbwR4PcVm7ShIf0g2kRQ+zYMZJ2GUN5yiuM
 rFWFusIVbuD+0TGNxp+fzg7rdvcyriiF2SddwC98Y5fma0A9JZw+oLXFeSeF+zglL07/
 mbPWivZ49EUxviOPybbxSWmbiC8YjPPjgWjJaJd+w0fEg2AAquQu59wjQUmGh5GzJvBm
 DoUTPe6KdwqiNoEAOKjPsOY5ibrW1kwHYQFwklZfW80qt/XPlJTj/XB5Tm/khVb5KX+r
 TKvA==
X-Gm-Message-State: AOJu0YyRwKTwq9UnsTeEm4ggmsJoH/jmUxhMVnM2A1uzblSEKiyX3/cF
 VhZvbJNhnyXRgoIiyNBXxNEaLVbM4pKWWDznCTPR3m2u563lJ+jGNf23z78AbjP4pHjuXb2+XHO
 SZv1QNGibL+S9tgYgpsCX9zWI5BoMWnIws8TQtp6tyRbZCYr/ujqa3xXm1JN+wTce7Bh27SSuNc
 uFUjyfdhp4A+jacfWg157l3IlP4P/P+CEJsF5CDh4K/A==
X-Google-Smtp-Source: AGHT+IGaYJtW1NfRpTZLsqELEct3ribNaTOcYLZGvC1Pnnhrc9Ux1D3IkPgsgipkinZnPoC6H7GQZg==
X-Received: by 2002:a05:6512:3148:b0:519:6a93:ed3a with SMTP id
 s8-20020a056512314800b005196a93ed3amr7348575lfi.23.1714448017734; 
 Mon, 29 Apr 2024 20:33:37 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172]) by smtp.gmail.com with ESMTPSA id
 o14-20020a198c0e000000b0051da9ac505dsm644102lfd.203.2024.04.29.20.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 20:33:37 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2dd6c14d000so64149711fa.0; 
 Mon, 29 Apr 2024 20:33:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXITvj/ij+UhDBoO78sP3gI/vfY0fR9hC1ByAi3hFXGVYUTLeNETznKSr8HCgh/UqgZ34Wk4Ycw1vnnjzS3mAEspwvarTY=
X-Received: by 2002:a2e:b6cd:0:b0:2da:c37f:655e with SMTP id
 m13-20020a2eb6cd000000b002dac37f655emr8607628ljo.16.1714448016966; Mon, 29
 Apr 2024 20:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-8-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-8-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 30 Apr 2024 11:33:25 +0800
X-Gmail-Original-Message-ID: <CANzO1D1tr2b9WVwcvYsqm521x5vj32tmM1j2tLAjKOUrgm1R=w@mail.gmail.com>
Message-ID: <CANzO1D1tr2b9WVwcvYsqm521x5vj32tmM1j2tLAjKOUrgm1R=w@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] test/qtest: add riscv-iommu-pci tests
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:05=E5=AF=AB=E9=
=81=93=EF=BC=9A
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
> ---
>  tests/qtest/libqos/meson.build   |  4 ++
>  tests/qtest/libqos/riscv-iommu.c | 79 +++++++++++++++++++++++++++
>  tests/qtest/libqos/riscv-iommu.h | 67 +++++++++++++++++++++++
>  tests/qtest/meson.build          |  1 +
>  tests/qtest/riscv-iommu-test.c   | 93 ++++++++++++++++++++++++++++++++
>  5 files changed, 244 insertions(+)
>  create mode 100644 tests/qtest/libqos/riscv-iommu.c
>  create mode 100644 tests/qtest/libqos/riscv-iommu.h
>  create mode 100644 tests/qtest/riscv-iommu-test.c
>
> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.bu=
ild
> index 3aed6efcb8..07fe20eacb 100644
> --- a/tests/qtest/libqos/meson.build
> +++ b/tests/qtest/libqos/meson.build
> @@ -67,6 +67,10 @@ if have_virtfs
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
> index 0000000000..8ae7d4888c
> --- /dev/null
> +++ b/tests/qtest/libqos/riscv-iommu.c
> @@ -0,0 +1,79 @@
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
> +#define PCI_VENDOR_ID_RIVOS           0x1efd
> +#define PCI_DEVICE_ID_RIVOS_IOMMU     0xedf1
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
> +        .vendor_id =3D PCI_VENDOR_ID_RIVOS,
> +        .device_id =3D PCI_DEVICE_ID_RIVOS_IOMMU,
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
> index 0000000000..8c056caa7b
> --- /dev/null
> +++ b/tests/qtest/libqos/riscv-iommu.h
> @@ -0,0 +1,67 @@
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
> +#define RISCV_IOMMU_PCI_VENDOR_ID_RIVOS  0x1efd
> +#define RISCV_IOMMU_PCI_DEVICE_ID_RIVOS  0xedf1
> +#define RISCV_IOMMU_PCI_DEVICE_CLASS     0x0806
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
> index 31b9f4ede4..aeb7346840 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -285,6 +285,7 @@ qos_test_ss.add(
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
> index 0000000000..13b887d15e
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
> +    g_assert_cmpuint(vendorid, =3D=3D, RISCV_IOMMU_PCI_VENDOR_ID_RIVOS);
> +    g_assert_cmpuint(deviceid, =3D=3D, RISCV_IOMMU_PCI_DEVICE_ID_RIVOS);
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
> 2.43.2
>
>

