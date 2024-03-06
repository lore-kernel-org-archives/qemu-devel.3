Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CF8C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 19:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhwhv-0004vS-B4; Wed, 06 Mar 2024 14:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rhwhu-0004uj-9I
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 14:13:38 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rhwhm-0004VW-Mr
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 14:13:38 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5135486cfccso31815e87.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 11:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709752407; x=1710357207;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLi+ud+SlMWsmpKsdg7v23/chJbLaxfb6R0VlxqeK+Y=;
 b=Vd9AQiW2l5SK2KvVuWeyqXjxQf/0O3wRemlJokSPsCdbP64b43OBw5iegnBTXJgoex
 4JWNTVXiuZBiWUmut1KZ1exNiQL+GOXIfK5IcNNn98lSY5MxEFkAGVlFwWOP+3oCVNHM
 J4TWQd2f7CwJTGXVeAZAAN0tyvsUH1xeLdqRwWLmffwrhe4jQrTTHOq+YgFPtgDC09O4
 OIs4IJrn56sg0A6MjAwSQ9p5seAFYNLfOzpXspdcxlxvsDFl+OukhimdrDaVkG9D5GyI
 KWZ6cF3BkznBfsLsahC5L3bT5codVosObtKH9dgxO1DahAyzWrGYfaywO775BHniPheB
 Ua+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709752407; x=1710357207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLi+ud+SlMWsmpKsdg7v23/chJbLaxfb6R0VlxqeK+Y=;
 b=BDiw0gYQQeZj0cqd9HkDhDCRnTXtADZ+vf13X2xhFU7C5s37oQfg+NauKw0fPIFAG4
 79V9lcYA95VBsrzOepoDxVvb4ioRKdhXTQO5rnkn/EAzx6mu/TeY6n/1oV3jDlhCROhA
 RfeIkK0yltguKUzLwY5UN8AD6hzHb7EEDYRyP4+Wfr3A3DvmNOOYkIZ54UtkvIwTmkCF
 HOcU8AlLXhCO9XrKA9qwLdfWPC5e0XLgEp8oUu4e/23kBbA12DxH8YIPwlL7sfaYWJXT
 SgrAQ7Tw+GfPUUl5yTWCxyhY7NXsIh46WIckSw57Crm9lR6COHM1Y2h5nvaANMAgjIUg
 /SJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlzI8pcQBRGI2oTQSCCURLDZpHc7VyMxuAGdFi/PECgF7VD5ffWPnZZ2JmPO1jnKDbg6IuL0l/j35ubcRpZLNRS8bVsrQ=
X-Gm-Message-State: AOJu0YxldOVdfpiRSeQzAJBl4ZMQbYQKXnK4I54ubBw7bXlo3jLktmA9
 iZ4+S/3bfjYPfZ0lfMAEHkMKjIKipqooJmRhu0SF3RsvgeGQbwy95MLyj4AQqTpL9gaRg/oHhF5
 nGpxjPdIaOBEBxcew3Jn+xeOoERllzcd8xf9paQ==
X-Google-Smtp-Source: AGHT+IHLpqsg/w4lRaqqHgavdxJWMVBVFKSSksowKjb/KFaTRAYLTyXx11Cafj++hnxioF8HP1Sx/ExPWBL0MeaC7Dg=
X-Received: by 2002:a05:6512:3a8:b0:512:f679:665b with SMTP id
 v8-20020a05651203a800b00512f679665bmr15699lfp.42.1709752406840; Wed, 06 Mar
 2024 11:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-2-fei2.wu@intel.com>
 <CAKmqyKMQyDjLkeo+aU58rE6_Vb84QeeZP3FUafw5GuWpk1JmZQ@mail.gmail.com>
 <8f5d6664-c075-4d31-bf33-ce24ceeb9b13@intel.com>
In-Reply-To: <8f5d6664-c075-4d31-bf33-ce24ceeb9b13@intel.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 6 Mar 2024 11:13:15 -0800
Message-ID: <CAHBxVyHP1hgGWg6EByX6XzqmTm_Tr0uw7tk65KWcytNYsKdw8w@mail.gmail.com>
Subject: Re: [RFC 1/2] hw/riscv: Add server platform reference machine
To: "Wu, Fei" <fei2.wu@intel.com>
Cc: Alistair Francis <alistair23@gmail.com>, pbonzini@redhat.com,
 palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, andrei.warkentin@intel.com, 
 shaolin.xie@alibaba-inc.com, ved@rivosinc.com, sunilvl@ventanamicro.com, 
 haibo1.xu@intel.com, evan.chai@intel.com, yin.wang@intel.com, 
 tech-server-platform@lists.riscv.org, tech-server-soc@lists.riscv.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 6, 2024 at 4:56=E2=80=AFAM Wu, Fei <fei2.wu@intel.com> wrote:
>
> On 3/6/2024 8:19 AM, Alistair Francis wrote:
> > On Mon, Mar 4, 2024 at 8:28=E2=80=AFPM Fei Wu <fei2.wu@intel.com> wrote=
:
> >>
> >> The RISC-V Server Platform specification[1] defines a standardized set
> >> of hardware and software capabilities, that portable system software,
> >> such as OS and hypervisors can rely on being present in a RISC-V serve=
r
> >> platform.
> >>
> >> A corresponding Qemu RISC-V server platform reference (rvsp-ref for
> >> short) machine type is added to provide a environment for firmware/OS
> >> development and testing. The main features included in rvsp-ref are:
> >>
> >>  - Based on riscv virt machine type
> >>  - A new memory map as close as virt machine as possible
> >>  - A new virt CPU type rvsp-ref-cpu for server platform compliance
> >>  - AIA
> >>  - PCIe AHCI
> >>  - PCIe NIC
> >>  - No virtio device
> >>  - No fw_cfg device
> >>  - No ACPI table provided
> >>  - Only minimal device tree nodes
> >>
> >> [1] https://github.com/riscv-non-isa/riscv-server-platform
> >
> > + Atish
> >
> >>
> >> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> >> ---
> >>  configs/devices/riscv64-softmmu/default.mak |    1 +
> >>  hw/riscv/Kconfig                            |   13 +
> >>  hw/riscv/meson.build                        |    1 +
> >>  hw/riscv/server_platform_ref.c              | 1244 ++++++++++++++++++=
+
> >>  4 files changed, 1259 insertions(+)
> >>  create mode 100644 hw/riscv/server_platform_ref.c
> >>
> >> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/dev=
ices/riscv64-softmmu/default.mak
> >> index 3f68059448..a1d98e49ef 100644
> >> --- a/configs/devices/riscv64-softmmu/default.mak
> >> +++ b/configs/devices/riscv64-softmmu/default.mak
> >> @@ -10,5 +10,6 @@ CONFIG_SPIKE=3Dy
> >>  CONFIG_SIFIVE_E=3Dy
> >>  CONFIG_SIFIVE_U=3Dy
> >>  CONFIG_RISCV_VIRT=3Dy
> >> +CONFIG_SERVER_PLATFORM_REF=3Dy
> >>  CONFIG_MICROCHIP_PFSOC=3Dy
> >>  CONFIG_SHAKTI_C=3Dy
> >> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> >> index 5d644eb7b1..debac5a7f5 100644
> >> --- a/hw/riscv/Kconfig
> >> +++ b/hw/riscv/Kconfig
> >> @@ -48,6 +48,19 @@ config RISCV_VIRT
> >>      select ACPI
> >>      select ACPI_PCI
> >>
> >> +config SERVER_PLATFORM_REF
> >> +    bool
> >> +    select RISCV_NUMA
> >> +    select GOLDFISH_RTC
> >> +    select PCI
> >> +    select PCI_EXPRESS_GENERIC_BRIDGE
> >> +    select PFLASH_CFI01
> >> +    select SERIAL
> >> +    select RISCV_ACLINT
> >> +    select RISCV_APLIC
> >> +    select RISCV_IMSIC
> >> +    select SIFIVE_TEST
> >
> > Do we really need SiFive Test in the server platform?
> >
> It's used to reset the system, is there any better choice?
>
> Probably I can remove the "sifive,test1 sifive,test0" from the
> compatible list in fdt, and only keep "syscon", I see opensbi has
> already removed that support in commit c2e602707.
>
> > Same with the goldfish RTC?
> >
> Although the spec doesn't make RTC mandatory, it should be a common
> practice having a RTC on server, so I add a RTC here no matter it's
> goldfish or not.
>

The platform spec says
HPER_070 : A battery-backed RTC or analogous timekeeping mechanism
MUST be implemented.

Can we consider goldfish RTC in this category ?

But I want to discuss a larger point as the server platform/SoC spec
defines a bunch of optional requirement.
Does this platform intend to be a platform that is a superset of all
those options or allow optionality in
the platform as well ?

> >> +
> >>  config SHAKTI_C
> >>      bool
> >>      select RISCV_ACLINT
> >> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> >> index 2f7ee81be3..bb3aff91ea 100644
> >> --- a/hw/riscv/meson.build
> >> +++ b/hw/riscv/meson.build
> >> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files=
('numa.c'))
> >>  riscv_ss.add(files('riscv_hart.c'))
> >>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
> >>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> >> +riscv_ss.add(when: 'CONFIG_SERVER_PLATFORM_REF', if_true: files('serv=
er_platform_ref.c'))
> >>  riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
> >>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
> >>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
> >> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform=
_ref.c
> >> new file mode 100644
> >> index 0000000000..ae90c4b27a
> >> --- /dev/null
> >> +++ b/hw/riscv/server_platform_ref.c
> >> @@ -0,0 +1,1244 @@
> >> +/*
> >> + * QEMU RISC-V Server Platfrom (RVSP) Reference Board
> >
> > Platform
> >
> OK.
>
> >> +static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
> >> +                                          DeviceState *irqchip,
> >> +                                          RVSPMachineState *s)
> >> +{
> >> +    DeviceState *dev;
> >> +    PCIHostState *pci;
> >> +    PCIDevice *pdev_ahci;
> >> +    AHCIPCIState *ich9;
> >> +    DriveInfo *hd[NUM_SATA_PORTS];
> >> +    MemoryRegion *ecam_alias, *ecam_reg;
> >> +    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
> >> +    hwaddr ecam_base =3D rvsp_ref_memmap[RVSP_PCIE_ECAM].base;
> >> +    hwaddr ecam_size =3D rvsp_ref_memmap[RVSP_PCIE_ECAM].size;
> >> +    hwaddr mmio_base =3D rvsp_ref_memmap[RVSP_PCIE_MMIO].base;
> >> +    hwaddr mmio_size =3D rvsp_ref_memmap[RVSP_PCIE_MMIO].size;
> >> +    hwaddr high_mmio_base =3D rvsp_ref_memmap[RVSP_PCIE_MMIO_HIGH].ba=
se;
> >> +    hwaddr high_mmio_size =3D rvsp_ref_memmap[RVSP_PCIE_MMIO_HIGH].si=
ze;
> >> +    hwaddr pio_base =3D rvsp_ref_memmap[RVSP_PCIE_PIO].base;
> >> +    hwaddr pio_size =3D rvsp_ref_memmap[RVSP_PCIE_PIO].size;
> >> +    MachineClass *mc =3D MACHINE_GET_CLASS(s);
> >> +    qemu_irq irq;
> >> +    int i;
> >> +
> >> +    dev =3D qdev_new(TYPE_GPEX_HOST);
> >> +
> >> +    /* Set GPEX object properties for the rvsp ref machine */
> >> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_BA=
SE,
> >> +                            ecam_base, NULL);
> >> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_SIZ=
E,
> >> +                            ecam_size, NULL);
> >> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
> >> +                             PCI_HOST_BELOW_4G_MMIO_BASE,
> >> +                             mmio_base, NULL);
> >> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_BELOW_4G=
_MMIO_SIZE,
> >> +                            mmio_size, NULL);
> >> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
> >> +                             PCI_HOST_ABOVE_4G_MMIO_BASE,
> >> +                             high_mmio_base, NULL);
> >> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ABOVE_4G=
_MMIO_SIZE,
> >> +                            high_mmio_size, NULL);
> >> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_BAS=
E,
> >> +                            pio_base, NULL);
> >> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_SIZE=
,
> >> +                            pio_size, NULL);
> >> +
> >> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> >> +
> >> +    ecam_alias =3D g_new0(MemoryRegion, 1);
> >> +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> >> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> >> +                             ecam_reg, 0, ecam_size);
> >> +    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_=
alias);
> >> +
> >> +    mmio_alias =3D g_new0(MemoryRegion, 1);
> >> +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> >> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> >> +                             mmio_reg, mmio_base, mmio_size);
> >> +    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_=
alias);
> >> +
> >> +    /* Map high MMIO space */
> >> +    high_mmio_alias =3D g_new0(MemoryRegion, 1);
> >> +    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mmio=
-high",
> >> +                             mmio_reg, high_mmio_base, high_mmio_size=
);
> >> +    memory_region_add_subregion(get_system_memory(), high_mmio_base,
> >> +                                high_mmio_alias);
> >> +
> >> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
> >> +
> >> +    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> >> +        irq =3D qdev_get_gpio_in(irqchip, RVSP_PCIE_IRQ + i);
> >> +
> >> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> >> +        gpex_set_irq_num(GPEX_HOST(dev), i, RVSP_PCIE_IRQ + i);
> >> +    }
> >> +
> >> +    pci =3D PCI_HOST_BRIDGE(dev);
> >> +    pci_init_nic_devices(pci->bus, mc->default_nic);
> >> +    /* IDE disk setup.  */
> >> +    pdev_ahci =3D pci_create_simple(pci->bus, -1, TYPE_ICH9_AHCI);
> >> +    ich9 =3D ICH9_AHCI(pdev_ahci);
> >> +    g_assert(ARRAY_SIZE(hd) =3D=3D ich9->ahci.ports);
> >> +    ide_drive_get(hd, ich9->ahci.ports);
> >> +    ahci_ide_create_devs(&ich9->ahci, hd);
> >> +
> >> +    GPEX_HOST(dev)->gpex_cfg.bus =3D PCI_HOST_BRIDGE(GPEX_HOST(dev))-=
>bus;
> >> +    return dev;
> >> +}
> >
> > We should share as much of this code as possible with the virt machine.
> >
> This function references multiple rvsp specific variables, some
> refactorings are needed to group all the information of
> ecam/mmio/high_mmio/pio/irq and pass them to virt and rvsp respectively.
> I see arm virt/sbsa-ref are seperated clearly and no sharing between
> them. It has the benefit there is no side effect between them. Should we
> use the same policy?
>
> Thanks,
> Fei.
>
> > Alistair
> >
> >> +
> >> +static DeviceState *rvsp_ref_create_aia(int aia_guests,
> >> +                                        const MemMapEntry *memmap, in=
t socket,
> >> +                                        int base_hartid, int hart_cou=
nt)
> >> +{
> >> +    int i;
> >> +    hwaddr addr;
> >> +    uint32_t guest_bits;
> >> +    DeviceState *aplic_s =3D NULL;
> >> +    DeviceState *aplic_m =3D NULL;
> >> +    bool msimode =3D true;
> >> +
> >> +    /* Per-socket M-level IMSICs */
> >> +    addr =3D memmap[RVSP_IMSIC_M].base +
> >> +           socket * RVSP_IMSIC_GROUP_MAX_SIZE;
> >> +    for (i =3D 0; i < hart_count; i++) {
> >> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
> >> +                           base_hartid + i, true, 1,
> >> +                           RVSP_IRQCHIP_NUM_MSIS);
> >> +    }
> >> +
> >> +    /* Per-socket S-level IMSICs */
> >> +    guest_bits =3D imsic_num_bits(aia_guests + 1);
> >> +    addr =3D memmap[RVSP_IMSIC_S].base + socket * RVSP_IMSIC_GROUP_MA=
X_SIZE;
> >> +    for (i =3D 0; i < hart_count; i++) {
> >> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
> >> +                           base_hartid + i, false, 1 + aia_guests,
> >> +                           RVSP_IRQCHIP_NUM_MSIS);
> >> +    }
> >> +
> >> +    /* Per-socket M-level APLIC */
> >> +    aplic_m =3D riscv_aplic_create(memmap[RVSP_APLIC_M].base +
> >> +                                 socket * memmap[RVSP_APLIC_M].size,
> >> +                                 memmap[RVSP_APLIC_M].size,
> >> +                                 (msimode) ? 0 : base_hartid,
> >> +                                 (msimode) ? 0 : hart_count,
> >> +                                 RVSP_IRQCHIP_NUM_SOURCES,
> >> +                                 RVSP_IRQCHIP_NUM_PRIO_BITS,
> >> +                                 msimode, true, NULL);
> >> +
> >> +    /* Per-socket S-level APLIC */
> >> +    aplic_s =3D riscv_aplic_create(memmap[RVSP_APLIC_S].base +
> >> +                                 socket * memmap[RVSP_APLIC_S].size,
> >> +                                 memmap[RVSP_APLIC_S].size,
> >> +                                 (msimode) ? 0 : base_hartid,
> >> +                                 (msimode) ? 0 : hart_count,
> >> +                                 RVSP_IRQCHIP_NUM_SOURCES,
> >> +                                 RVSP_IRQCHIP_NUM_PRIO_BITS,
> >> +                                 msimode, false, aplic_m);
> >> +
> >> +    (void)aplic_s;
> >> +    return aplic_m;
> >> +}
> >> +
> >> +static void rvsp_ref_machine_done(Notifier *notifier, void *data)
> >> +{
> >> +    RVSPMachineState *s =3D container_of(notifier, RVSPMachineState,
> >> +                                       machine_done);
> >> +    const MemMapEntry *memmap =3D rvsp_ref_memmap;
> >> +    MachineState *machine =3D MACHINE(s);
> >> +    target_ulong start_addr =3D memmap[RVSP_DRAM].base;
> >> +    target_ulong firmware_end_addr, kernel_start_addr;
> >> +    const char *firmware_name =3D riscv_default_firmware_name(&s->soc=
[0]);
> >> +    uint64_t fdt_load_addr;
> >> +    uint64_t kernel_entry =3D 0;
> >> +    BlockBackend *pflash_blk0;
> >> +
> >> +    /* load/create device tree */
> >> +    if (machine->dtb) {
> >> +        machine->fdt =3D load_device_tree(machine->dtb, &s->fdt_size)=
;
> >> +        if (!machine->fdt) {
> >> +            error_report("load_device_tree() failed");
> >> +            exit(1);
> >> +        }
> >> +    } else {
> >> +        create_fdt(s, memmap);
> >> +    }
> >> +
> >> +    firmware_end_addr =3D riscv_find_and_load_firmware(machine, firmw=
are_name,
> >> +                                                     start_addr, NULL=
);
> >> +
> >> +    pflash_blk0 =3D pflash_cfi01_get_blk(s->flash[0]);
> >> +    if (pflash_blk0) {
> >> +        if (machine->firmware && !strcmp(machine->firmware, "none")) =
{
> >> +            /*
> >> +             * Pflash was supplied but bios is none and not KVM guest=
,
> >> +             * let's overwrite the address we jump to after reset to
> >> +             * the base of the flash.
> >> +             */
> >> +            start_addr =3D rvsp_ref_memmap[RVSP_FLASH].base;
> >> +        } else {
> >> +            /*
> >> +             * Pflash was supplied but either KVM guest or bios is no=
t none.
> >> +             * In this case, base of the flash would contain S-mode p=
ayload.
> >> +             */
> >> +            riscv_setup_firmware_boot(machine);
> >> +            kernel_entry =3D rvsp_ref_memmap[RVSP_FLASH].base;
> >> +        }
> >> +    }
> >> +
> >> +    if (machine->kernel_filename && !kernel_entry) {
> >> +        kernel_start_addr =3D riscv_calc_kernel_start_addr(&s->soc[0]=
,
> >> +                                                         firmware_end=
_addr);
> >> +
> >> +        kernel_entry =3D riscv_load_kernel(machine, &s->soc[0],
> >> +                                         kernel_start_addr, true, NUL=
L);
> >> +    }
> >> +
> >> +    fdt_load_addr =3D riscv_compute_fdt_addr(memmap[RVSP_DRAM].base,
> >> +                                           memmap[RVSP_DRAM].size,
> >> +                                           machine);
> >> +    riscv_load_fdt(fdt_load_addr, machine->fdt);
> >> +
> >> +    /* load the reset vector */
> >> +    riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
> >> +                              rvsp_ref_memmap[RVSP_MROM].base,
> >> +                              rvsp_ref_memmap[RVSP_MROM].size, kernel=
_entry,
> >> +                              fdt_load_addr);
> >> +
> >> +}
> >> +
> >> +static void rvsp_ref_machine_init(MachineState *machine)
> >> +{
> >> +    const MemMapEntry *memmap =3D rvsp_ref_memmap;
> >> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(machine);
> >> +    MemoryRegion *system_memory =3D get_system_memory();
> >> +    MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
> >> +    char *soc_name;
> >> +    DeviceState *mmio_irqchip, *pcie_irqchip;
> >> +    int i, base_hartid, hart_count;
> >> +    int socket_count =3D riscv_socket_count(machine);
> >> +
> >> +    /* Check socket count limit */
> >> +    if (RVSP_SOCKETS_MAX < socket_count) {
> >> +        error_report("number of sockets/nodes should be less than %d"=
,
> >> +            RVSP_SOCKETS_MAX);
> >> +        exit(1);
> >> +    }
> >> +
> >> +    if (!tcg_enabled()) {
> >> +        error_report("'aclint' is only available with TCG acceleratio=
n");
> >> +        exit(1);
> >> +    }
> >> +
> >> +    /* Initialize sockets */
> >> +    mmio_irqchip =3D pcie_irqchip =3D NULL;
> >> +    for (i =3D 0; i < socket_count; i++) {
> >> +        if (!riscv_socket_check_hartids(machine, i)) {
> >> +            error_report("discontinuous hartids in socket%d", i);
> >> +            exit(1);
> >> +        }
> >> +
> >> +        base_hartid =3D riscv_socket_first_hartid(machine, i);
> >> +        if (base_hartid < 0) {
> >> +            error_report("can't find hartid base for socket%d", i);
> >> +            exit(1);
> >> +        }
> >> +
> >> +        hart_count =3D riscv_socket_hart_count(machine, i);
> >> +        if (hart_count < 0) {
> >> +            error_report("can't find hart count for socket%d", i);
> >> +            exit(1);
> >> +        }
> >> +
> >> +        soc_name =3D g_strdup_printf("soc%d", i);
> >> +        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i]=
,
> >> +                                TYPE_RISCV_HART_ARRAY);
> >> +        g_free(soc_name);
> >> +        object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
> >> +                                machine->cpu_type, &error_abort);
> >> +        object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
> >> +                                base_hartid, &error_abort);
> >> +        object_property_set_int(OBJECT(&s->soc[i]), "num-harts",
> >> +                                hart_count, &error_abort);
> >> +        sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
> >> +
> >> +        /* Per-socket ACLINT MTIMER */
> >> +        riscv_aclint_mtimer_create(memmap[RVSP_ACLINT].base +
> >> +                i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> >> +            RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> >> +            base_hartid, hart_count,
> >> +            RISCV_ACLINT_DEFAULT_MTIMECMP,
> >> +            RISCV_ACLINT_DEFAULT_MTIME,
> >> +            RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> >> +
> >> +        /* Per-socket interrupt controller */
> >> +        s->irqchip[i] =3D rvsp_ref_create_aia(s->aia_guests,
> >> +                                            memmap, i, base_hartid,
> >> +                                            hart_count);
> >> +
> >> +        /* Try to use different IRQCHIP instance based device type */
> >> +        if (i =3D=3D 0) {
> >> +            mmio_irqchip =3D s->irqchip[i];
> >> +            pcie_irqchip =3D s->irqchip[i];
> >> +        }
> >> +        if (i =3D=3D 1) {
> >> +            pcie_irqchip =3D s->irqchip[i];
> >> +        }
> >> +    }
> >> +
> >> +    s->memmap =3D rvsp_ref_memmap;
> >> +
> >> +    /* register system main memory (actual RAM) */
> >> +    memory_region_add_subregion(system_memory, memmap[RVSP_DRAM].base=
,
> >> +        machine->ram);
> >> +
> >> +    /* boot rom */
> >> +    memory_region_init_rom(mask_rom, NULL, "riscv_rvsp_ref_board.mrom=
",
> >> +                           memmap[RVSP_MROM].size, &error_fatal);
> >> +    memory_region_add_subregion(system_memory, memmap[RVSP_MROM].base=
,
> >> +                                mask_rom);
> >> +
> >> +    /* SiFive Test MMIO device */
> >> +    sifive_test_create(memmap[RVSP_TEST].base);
> >> +
> >> +    gpex_pcie_init(system_memory, pcie_irqchip, s);
> >> +
> >> +    serial_mm_init(system_memory, memmap[RVSP_UART0].base,
> >> +        0, qdev_get_gpio_in(mmio_irqchip, RVSP_UART0_IRQ), 399193,
> >> +        serial_hd(0), DEVICE_LITTLE_ENDIAN);
> >> +
> >> +    sysbus_create_simple("goldfish_rtc", memmap[RVSP_RTC].base,
> >> +        qdev_get_gpio_in(mmio_irqchip, RVSP_RTC_IRQ));
> >> +
> >> +    for (i =3D 0; i < ARRAY_SIZE(s->flash); i++) {
> >> +        /* Map legacy -drive if=3Dpflash to machine properties */
> >> +        pflash_cfi01_legacy_drive(s->flash[i],
> >> +                                  drive_get(IF_PFLASH, 0, i));
> >> +    }
> >> +    rvsp_flash_map(s, system_memory);
> >> +
> >> +    s->machine_done.notify =3D rvsp_ref_machine_done;
> >> +    qemu_add_machine_init_done_notifier(&s->machine_done);
> >> +}
> >> +
> >> +static void rvsp_ref_machine_instance_init(Object *obj)
> >> +{
> >> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(obj);
> >> +
> >> +    rvsp_flash_create(s);
> >> +}
> >> +
> >> +static char *rvsp_ref_get_aia_guests(Object *obj, Error **errp)
> >> +{
> >> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(obj);
> >> +    char val[32];
> >> +
> >> +    sprintf(val, "%d", s->aia_guests);
> >> +    return g_strdup(val);
> >> +}
> >> +
> >> +static void rvsp_ref_set_aia_guests(Object *obj, const char *val, Err=
or **errp)
> >> +{
> >> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(obj);
> >> +
> >> +    s->aia_guests =3D atoi(val);
> >> +    if (s->aia_guests < 0 || s->aia_guests > RVSP_IRQCHIP_MAX_GUESTS)=
 {
> >> +        error_setg(errp, "Invalid number of AIA IMSIC guests");
> >> +        error_append_hint(errp, "Valid values be between 0 and %d.\n"=
,
> >> +                          RVSP_IRQCHIP_MAX_GUESTS);
> >> +    }
> >> +}
> >> +
> >> +static void rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
> >> +{
> >> +    char str[128];
> >> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> >> +
> >> +    mc->desc =3D "RISC-V Server SoC Reference board";
> >> +    mc->init =3D rvsp_ref_machine_init;
> >> +    mc->max_cpus =3D RVSP_CPUS_MAX;
> >> +    mc->default_cpu_type =3D TYPE_RISCV_CPU_BASE;
> >> +    mc->pci_allow_0_address =3D true;
> >> +    mc->default_nic =3D "e1000e";
> >> +    mc->possible_cpu_arch_ids =3D riscv_numa_possible_cpu_arch_ids;
> >> +    mc->cpu_index_to_instance_props =3D riscv_numa_cpu_index_to_props=
;
> >> +    mc->get_default_cpu_node_id =3D riscv_numa_get_default_cpu_node_i=
d;
> >> +    mc->numa_mem_supported =3D true;
> >> +    /* platform instead of architectural choice */
> >> +    mc->cpu_cluster_has_numa_boundary =3D true;
> >> +    mc->default_ram_id =3D "riscv_rvsp_ref_board.ram";
> >> +
> >> +    object_class_property_add_str(oc, "aia-guests",
> >> +                                  rvsp_ref_get_aia_guests,
> >> +                                  rvsp_ref_set_aia_guests);
> >> +    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid=
 value "
> >> +                 "should be between 0 and %d.", RVSP_IRQCHIP_MAX_GUES=
TS);
> >> +    object_class_property_set_description(oc, "aia-guests", str);
> >> +}
> >> +
> >> +static const TypeInfo rvsp_ref_typeinfo =3D {
> >> +    .name       =3D TYPE_RVSP_REF_MACHINE,
> >> +    .parent     =3D TYPE_MACHINE,
> >> +    .class_init =3D rvsp_ref_machine_class_init,
> >> +    .instance_init =3D rvsp_ref_machine_instance_init,
> >> +    .instance_size =3D sizeof(RVSPMachineState),
> >> +};
> >> +
> >> +static void rvsp_ref_init_register_types(void)
> >> +{
> >> +    type_register_static(&rvsp_ref_typeinfo);
> >> +}
> >> +
> >> +type_init(rvsp_ref_init_register_types)
> >> --
> >> 2.34.1
> >>
> >>
>

