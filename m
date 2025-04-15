Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE59C369B5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 14:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4hZS-0001nC-9k; Tue, 15 Apr 2025 10:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4hZN-0001mW-92
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:47:25 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4hZK-0000Vo-KB
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:47:25 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso12393542a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744728441; x=1745333241; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHCpx0Do+1StcIGO1BmmGN4syHYS0QVMXi1Xbg377fo=;
 b=IFUkMOr6IaVuehkjoQh57fZ3HybbNwr0J3FPGgZ9FEeZYMUBoYvc66mAJprUMab9s9
 e7mPrzi17N+Pu+687YKPMFXTbaKMLjm6tm2ifEya918coiNrADDho3Cm9pTr5cMockM5
 FTbt/URCgvSMcgw9n0DQcwbdSDd0943aSfFeWHSAdT88xjBpwWpzOnfgTY/CQmpq01da
 vg329s6l7lTKc1srgOM6P6DCsMN1IiYsrxNdk/ibd+vtw7HigXj97FoH3jAGOiELjnHM
 zzOvM+ZWqsdDLnb1KuvqYaLTtfdoRdHrTumba9k37dRxL5uZaBQi9QQNLBK3I2gVgq6f
 xx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744728441; x=1745333241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHCpx0Do+1StcIGO1BmmGN4syHYS0QVMXi1Xbg377fo=;
 b=tLdgD4g9IX39gC132o9Uva5Og3876Kjgf93ke7xwKlIgZIqXdAtLA+FMiLpGOVXS1/
 zjjobx86mihJp8KYuMRUcZMRNTnZbHVoxLJ/tzw7zYMHpV2G+6NWWpfUYU8UhF+DvE/r
 t331kpLdIeVV2/O8kIcp1ZVKciQRnfqwyT6CW6dmjjXOXYihacM10QzrHbNLuDe3ZTf0
 W2Pu6LE7ImMpgRmwIkKvOaaaNjVTXuqRY0eJ2mPabTk0d1/TZWFwaRHA7rZimyi8k7QW
 k5vOmaemIi0tMfWrNazR6K/3WenGl+MBuVyx9hgylfscNYbpTCdkkOzY1eLolyUCDLMz
 FeSg==
X-Gm-Message-State: AOJu0YwSMGqx1R7OzftZR78xGyc+r7nJhIvscJUfd9xCuxUpqthhVc3o
 5TFfQI1YwkKdLdkq3in3bip1ARuHFhhcsNM64eVgzVZMsBTjwg4Jn3rgcp/o3pr35IBfP1UGXlm
 0RiO+d/QCY9iRLq6DwFgSGTS7T2ujXLYx3EaQBw==
X-Gm-Gg: ASbGnctTMqNVSE1HBofXpm1Lsds2TQQbrKPbpEvhgUzibl31FAZA82Ug3Z4ZGnqhMUj
 f+w5v6LlMgEsaxa27XUxRBLn43y0F/iJf2+sxhXnspOl1UbeH5kPVpasXa8yG8P/E8JsRxwic/A
 jt72QxvRSKMgYUYh9IkhjcH9lq
X-Google-Smtp-Source: AGHT+IFp/JkeTdFiPz8E/4sHx/T4g3XgEpZvji3YukOy8P7sNu0Cd2x0syUFA5JhA6rep2XOoOGvHsFiS3jaIFguCFg=
X-Received: by 2002:a05:6402:4282:b0:5db:68bd:ab78 with SMTP id
 4fb4d7f45d1cf-5f45dfc8ca3mr4070422a12.10.1744728440613; Tue, 15 Apr 2025
 07:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250415081231.21186-1-jim.shu@sifive.com>
 <20250415081231.21186-18-jim.shu@sifive.com>
 <253ef6eb-9aa1-4aba-9dd2-2d0490816199@ventanamicro.com>
In-Reply-To: <253ef6eb-9aa1-4aba-9dd2-2d0490816199@ventanamicro.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Tue, 15 Apr 2025 22:47:08 +0800
X-Gm-Features: ATxdqUH64ZPtpZpmq8aPsugt0bw2RBsM_kSGLZJBJM0RVtmuQ_OUUUQlJc1VYb8
Message-ID: <CALw707piJp2iK_Cs==UpYa2iGMGfLX6p5=3ik4+2P68gNogt8Q@mail.gmail.com>
Subject: Re: [PATCH 17/17] hw/riscv: virt: Add WorldGuard support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, 
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, 
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, 
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Thanks Daniel. I will fix the RST doc and typo issue in the v2 patch!

Jim

On Tue, Apr 15, 2025 at 9:20=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 4/15/25 5:12 AM, Jim Shu wrote:
> > * Add 'wg=3Don' option to enable RISC-V WorldGuard
> > * Add wgChecker to protect several resources:
> >    DRAM, FLASH, UART.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >   docs/system/riscv/virt.rst |  20 +++++
> >   hw/riscv/Kconfig           |   1 +
> >   hw/riscv/virt.c            | 163 ++++++++++++++++++++++++++++++++++++=
-
> >   include/hw/riscv/virt.h    |  15 +++-
> >   4 files changed, 195 insertions(+), 4 deletions(-)
> >
> > diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> > index 60850970ce..d2bc65f71c 100644
> > --- a/docs/system/riscv/virt.rst
> > +++ b/docs/system/riscv/virt.rst
> > @@ -146,6 +146,26 @@ The following machine-specific options are support=
ed:
> >
> >     Enables the riscv-iommu-sys platform device. Defaults to 'off'.
> >
> > +- wg=3D[on|off]
> > +
> > +  When this option is "on", RISC-V WorldGuard will be enabled in the s=
ystem
> > +  to provide the isolation of multiple worlds. RISC-V HARTs will enabl=
e WG
> > +  extensions to have WID in memory transaction. wgCheckers in front of=
 RAMs
> > +  and device MMIO will be enabled to provide the access control of res=
ources
> > +  if the transaction contains WID. When not specified, this option is =
assumed
> > +  to be "off".
> > +
> > +  The WG configuration of virt machine includes 4 worlds. For WG confi=
guration
> > +  of CPUs, the M-mode WID of CPU (`mwid`) is set to the largest WID nu=
mber,
> > +  and the authorized WID list of CPU (`mwidlist`) includes all WIDs. W=
e can
> > +  modify the configuration of all CPUs via `x-mwid` and `x-mwidlist`
>
> This change will break the doc build:
>
> =3D=3D=3D=3D
>
> [3002/3003] Generating docs/QEMU manual with a custom command
> FAILED: docs/docs.stamp
> /usr/bin/env CONFDIR=3Detc/qemu /home/danielhb/work/qemu/build/pyvenv/bin=
/sphinx-build -q -W -Dkerneldoc_werror=3D1 -j auto -Dversion=3D9.2.92 -Drel=
ease=3D -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp -b html -=
d /home/danielhb/work/qemu/build/docs/manual.p /home/danielhb/work/qemu/doc=
s /home/danielhb/work/qemu/build/docs/manual
>
> Warning, treated as error:
> /home/danielhb/work/qemu/docs/system/riscv/virt.rst:158:'any' reference t=
arget not found: mwid
> ninja: build stopped: subcommand failed.
>
> =3D=3D=3D=3D
>
> This happens because you're wrapping words with a single back-quote, and =
RST
> thinks that you're referring to an internal page/link.
>
> You need double back-quotes (``) in this case:
>
> $ git diff
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index d2bc65f71c..69b028bd73 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -156,9 +156,9 @@ The following machine-specific options are supported:
>     to be "off".
>
>     The WG configuration of virt machine includes 4 worlds. For WG config=
uration
> -  of CPUs, the M-mode WID of CPU (`mwid`) is set to the largest WID numb=
er,
> -  and the authorized WID list of CPU (`mwidlist`) includes all WIDs. We =
can
> -  modify the configuration of all CPUs via `x-mwid` and `x-mwidlist`
> +  of CPUs, the M-mode WID of CPU (``mwid``) is set to the largest WID nu=
mber,
> +  and the authorized WID list of CPU (``mwidlist``) includes all WIDs. W=
e can
> +  modify the configuration of all CPUs via ``x-mwid`` and ``x-mwidlist``
>     CPU options. There are 3 wgCheckers in the virt machine, which sepera=
tely
>     protects DRAM, FLASH, and UART. Default WG configuration on the virt =
machine
>     is enough to run the demo of dual OSes in the different worlds. For e=
xample,
>
>
>
> > +  CPU options. There are 3 wgCheckers in the virt machine, which seper=
ately
>
> s/seperately/separately
>
>
> Code looks good otherwise. Thanks,
>
> Daniel
>
> > +  protects DRAM, FLASH, and UART. Default WG configuration on the virt=
 machine
> > +  is enough to run the demo of dual OSes in the different worlds. For =
example,
> > +  running both Linux kernel and Secure OS (e.g. OP-TEE) in it's own wo=
rld.
> > +
> > +  This option is restricted to the TCG accelerator.
> > +
> >   Running Linux kernel
> >   --------------------
> >
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index e6a0ac1fa1..5c3e7b3479 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -68,6 +68,7 @@ config RISCV_VIRT
> >       select PLATFORM_BUS
> >       select ACPI
> >       select ACPI_PCI
> > +    select RISCV_WORLDGUARD
> >
> >   config SHAKTI_C
> >       bool
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index e517002fdf..da873bc8b8 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -58,6 +58,7 @@
> >   #include "qapi/qapi-visit-common.h"
> >   #include "hw/virtio/virtio-iommu.h"
> >   #include "hw/uefi/var-service-api.h"
> > +#include "hw/misc/riscv_worldguard.h"
> >
> >   /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by=
 QEMU. */
> >   static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
> > @@ -89,6 +90,9 @@ static const MemMapEntry virt_memmap[] =3D {
> >       [VIRT_PCIE_PIO] =3D     {  0x3000000,       0x10000 },
> >       [VIRT_IOMMU_SYS] =3D    {  0x3010000,        0x1000 },
> >       [VIRT_PLATFORM_BUS] =3D {  0x4000000,     0x2000000 },
> > +    [VIRT_WGC_DRAM] =3D     {  0x6000000,        0x1000 },
> > +    [VIRT_WGC_FLASH] =3D    {  0x6001000,        0x1000 },
> > +    [VIRT_WGC_UART] =3D     {  0x6002000,        0x1000 },
> >       [VIRT_PLIC] =3D         {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MA=
X * 2) },
> >       [VIRT_APLIC_M] =3D      {  0xc000000, APLIC_SIZE(VIRT_CPUS_MAX) }=
,
> >       [VIRT_APLIC_S] =3D      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) }=
,
> > @@ -114,6 +118,38 @@ static MemMapEntry virt_high_pcie_memmap;
> >
> >   #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
> >
> > +/* wgChecker helpers */
> > +typedef struct WGCInfo {
> > +    int memmap_idx;
> > +    uint32_t irq_num;
> > +    uint32_t slot_count;
> > +
> > +    int num_of_child;
> > +    MemoryRegion *c_region[WGC_NUM_REGIONS];
> > +    uint64_t c_offset[WGC_NUM_REGIONS];
> > +} WGCInfo;
> > +
> > +enum {
> > +    WGC_DRAM,
> > +    WGC_FLASH,
> > +    WGC_UART,
> > +    WGC_NUM,
> > +};
> > +
> > +static WGCInfo virt_wgcinfo[] =3D {
> > +    [WGC_DRAM]  =3D { VIRT_WGC_DRAM, WGC_DRAM_IRQ, 16 },
> > +    [WGC_FLASH] =3D { VIRT_WGC_FLASH, WGC_FLASH_IRQ, 16 },
> > +    [WGC_UART]  =3D { VIRT_WGC_UART, WGC_UART_IRQ, 1 },
> > +};
> > +
> > +static void wgc_append_child(WGCInfo *info, MemoryRegion *region,
> > +                             uint64_t offset)
> > +{
> > +    info->c_region[info->num_of_child] =3D region;
> > +    info->c_offset[info->num_of_child] =3D offset;
> > +    info->num_of_child +=3D 1;
> > +}
> > +
> >   static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
> >                                          const char *name,
> >                                          const char *alias_prop_name)
> > @@ -164,7 +200,8 @@ static void virt_flash_map1(PFlashCFI01 *flash,
> >   }
> >
> >   static void virt_flash_map(RISCVVirtState *s,
> > -                           MemoryRegion *sysmem)
> > +                           MemoryRegion *sysmem,
> > +                           WGCInfo *info)
> >   {
> >       hwaddr flashsize =3D virt_memmap[VIRT_FLASH].size / 2;
> >       hwaddr flashbase =3D virt_memmap[VIRT_FLASH].base;
> > @@ -173,6 +210,15 @@ static void virt_flash_map(RISCVVirtState *s,
> >                       sysmem);
> >       virt_flash_map1(s->flash[1], flashbase + flashsize, flashsize,
> >                       sysmem);
> > +
> > +    if (info) {
> > +        wgc_append_child(info,
> > +                         sysbus_mmio_get_region(SYS_BUS_DEVICE(s->flas=
h[0]), 0),
> > +                         flashbase);
> > +        wgc_append_child(info,
> > +                         sysbus_mmio_get_region(SYS_BUS_DEVICE(s->flas=
h[1]), 0),
> > +                         flashbase + flashsize);
> > +    }
> >   }
> >
> >   static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *n=
odename,
> > @@ -1426,6 +1472,71 @@ static void virt_build_smbios(RISCVVirtState *s)
> >       }
> >   }
> >
> > +static DeviceState *create_wgc(WGCInfo *info, DeviceState *irqchip)
> > +{
> > +    MemoryRegion *system_memory =3D get_system_memory();
> > +    DeviceState *wgc;
> > +    MemoryRegion *upstream_mr, *downstream_mr;
> > +    qemu_irq irq =3D qdev_get_gpio_in(irqchip, info->irq_num);
> > +    hwaddr base, size;
> > +
> > +    /* Unmap downstream_mr from system_memory if it is already mapped.=
 */
> > +    for (int i=3D0; i<info->num_of_child; i++) {
> > +        downstream_mr =3D info->c_region[i];
> > +
> > +        g_assert(downstream_mr);
> > +        if (downstream_mr->container =3D=3D system_memory) {
> > +            memory_region_del_subregion(system_memory, downstream_mr);
> > +        }
> > +
> > +        /*
> > +         * Clear the offset of downstream_mr, so we could correctly do
> > +         * address_space_init() to it in wgchecker.
> > +         */
> > +        memory_region_set_address(downstream_mr, 0);
> > +    }
> > +
> > +    base =3D virt_memmap[info->memmap_idx].base;
> > +    size =3D virt_memmap[info->memmap_idx].size;
> > +
> > +    wgc =3D riscv_wgchecker_create(
> > +        base, size, irq, info->slot_count, 0, 0,
> > +        info->num_of_child, info->c_region, info->c_offset, 0, NULL);
> > +
> > +    /* Map upstream_mr to system_memory */
> > +    for (int i=3D0; i<info->num_of_child; i++) {
> > +        upstream_mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(wgc), i+=
1);
> > +        g_assert(upstream_mr);
> > +        memory_region_add_subregion(system_memory, info->c_offset[i], =
upstream_mr);
> > +    }
> > +
> > +    return wgc;
> > +}
> > +
> > +static void virt_create_worldguard(WGCInfo *wgcinfo, int wgc_num,
> > +                                   DeviceState *irqchip)
> > +{
> > +    CPUState *cpu;
> > +
> > +    /* Global WG config */
> > +    riscv_worldguard_create(VIRT_WG_NWORLDS,
> > +                            VIRT_WG_TRUSTEDWID,
> > +                            VIRT_WG_HWBYPASS,
> > +                            VIRT_WG_TZCOMPAT);
> > +
> > +    /* Enable WG extension of each CPU */
> > +    CPU_FOREACH(cpu) {
> > +        CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
> > +
> > +        riscv_worldguard_apply_cpu(env->mhartid);
> > +    }
> > +
> > +    /* Create all wgChecker devices */
> > +    for (int i=3D0; i<wgc_num; i++) {
> > +        create_wgc(&wgcinfo[i], DEVICE(irqchip));
> > +    }
> > +}
> > +
> >   static void virt_machine_done(Notifier *notifier, void *data)
> >   {
> >       RISCVVirtState *s =3D container_of(notifier, RISCVVirtState,
> > @@ -1527,10 +1638,12 @@ static void virt_machine_done(Notifier *notifie=
r, void *data)
> >   static void virt_machine_init(MachineState *machine)
> >   {
> >       const MemMapEntry *memmap =3D virt_memmap;
> > +    WGCInfo *wgcinfo =3D virt_wgcinfo;
> >       RISCVVirtState *s =3D RISCV_VIRT_MACHINE(machine);
> >       MemoryRegion *system_memory =3D get_system_memory();
> >       MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
> >       DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
> > +    SerialMM *uart;
> >       int i, base_hartid, hart_count;
> >       int socket_count =3D riscv_socket_count(machine);
> >
> > @@ -1546,6 +1659,11 @@ static void virt_machine_init(MachineState *mach=
ine)
> >           exit(1);
> >       }
> >
> > +    if (!tcg_enabled() && s->have_wg) {
> > +        error_report("'wg' is only available with TCG acceleration");
> > +        exit(1);
> > +    }
> > +
> >       /* Initialize sockets */
> >       mmio_irqchip =3D virtio_irqchip =3D pcie_irqchip =3D NULL;
> >       for (i =3D 0; i < socket_count; i++) {
> > @@ -1673,6 +1791,10 @@ static void virt_machine_init(MachineState *mach=
ine)
> >       memory_region_add_subregion(system_memory, memmap[VIRT_DRAM].base=
,
> >           machine->ram);
> >
> > +    if (tcg_enabled() && s->have_wg) {
> > +        wgc_append_child(&wgcinfo[WGC_DRAM], machine->ram, memmap[VIRT=
_DRAM].base);
> > +    }
> > +
> >       /* boot rom */
> >       memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
> >                              memmap[VIRT_MROM].size, &error_fatal);
> > @@ -1700,10 +1822,16 @@ static void virt_machine_init(MachineState *mac=
hine)
> >
> >       create_platform_bus(s, mmio_irqchip);
> >
> > -    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> > +    uart =3D serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> >           0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
> >           serial_hd(0), DEVICE_LITTLE_ENDIAN);
> >
> > +    if (tcg_enabled() && s->have_wg) {
> > +        wgc_append_child(&wgcinfo[WGC_UART],
> > +                         sysbus_mmio_get_region(SYS_BUS_DEVICE(uart), =
0),
> > +                         memmap[VIRT_UART0].base);
> > +    }
> > +
> >       sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
> >           qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
> >
> > @@ -1712,7 +1840,16 @@ static void virt_machine_init(MachineState *mach=
ine)
> >           pflash_cfi01_legacy_drive(s->flash[i],
> >                                     drive_get(IF_PFLASH, 0, i));
> >       }
> > -    virt_flash_map(s, system_memory);
> > +
> > +    if (tcg_enabled() && s->have_wg) {
> > +        virt_flash_map(s, system_memory, &wgcinfo[WGC_FLASH]);
> > +    } else {
> > +        virt_flash_map(s, system_memory, NULL);
> > +    }
> > +
> > +    if (tcg_enabled() && s->have_wg) {
> > +        virt_create_worldguard(wgcinfo, WGC_NUM, mmio_irqchip);
> > +    }
> >
> >       /* load/create device tree */
> >       if (machine->dtb) {
> > @@ -1757,6 +1894,20 @@ static void virt_machine_instance_init(Object *o=
bj)
> >       s->iommu_sys =3D ON_OFF_AUTO_AUTO;
> >   }
> >
> > +static bool virt_get_wg(Object *obj, Error **errp)
> > +{
> > +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > +
> > +    return s->have_wg;
> > +}
> > +
> > +static void virt_set_wg(Object *obj, bool value, Error **errp)
> > +{
> > +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > +
> > +    s->have_wg =3D value;
> > +}
> > +
> >   static char *virt_get_aia_guests(Object *obj, Error **errp)
> >   {
> >       RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> > @@ -1977,6 +2128,12 @@ static void virt_machine_class_init(ObjectClass =
*oc, void *data)
> >                                 NULL, NULL);
> >       object_class_property_set_description(oc, "iommu-sys",
> >                                             "Enable IOMMU platform devi=
ce");
> > +
> > +    object_class_property_add_bool(oc, "wg", virt_get_wg,
> > +                                   virt_set_wg);
> > +    object_class_property_set_description(oc, "wg",
> > +                                              "Set on/off to enable/di=
sable the "
> > +                                              "RISC-V WorldGuard.");
> >   }
> >
> >   static const TypeInfo virt_machine_typeinfo =3D {
> > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > index 48a14bea2e..3a631a6a23 100644
> > --- a/include/hw/riscv/virt.h
> > +++ b/include/hw/riscv/virt.h
> > @@ -57,6 +57,7 @@ struct RISCVVirtState {
> >       bool have_aclint;
> >       RISCVVirtAIAType aia_type;
> >       int aia_guests;
> > +    bool have_wg;
> >       char *oem_id;
> >       char *oem_table_id;
> >       OnOffAuto acpi;
> > @@ -87,11 +88,17 @@ enum {
> >       VIRT_PLATFORM_BUS,
> >       VIRT_PCIE_ECAM,
> >       VIRT_IOMMU_SYS,
> > +    VIRT_WGC_DRAM,
> > +    VIRT_WGC_FLASH,
> > +    VIRT_WGC_UART
> >   };
> >
> >   enum {
> >       UART0_IRQ =3D 10,
> >       RTC_IRQ =3D 11,
> > +    WGC_DRAM_IRQ =3D 15,
> > +    WGC_FLASH_IRQ =3D 16,
> > +    WGC_UART_IRQ =3D 17,
> >       VIRTIO_IRQ =3D 1, /* 1 to 8 */
> >       VIRTIO_COUNT =3D 8,
> >       PCIE_IRQ =3D 0x20, /* 32 to 35 */
> > @@ -102,7 +109,7 @@ enum {
> >   #define VIRT_PLATFORM_BUS_NUM_IRQS 32
> >
> >   #define VIRT_IRQCHIP_NUM_MSIS 255
> > -#define VIRT_IRQCHIP_NUM_SOURCES 96
> > +#define VIRT_IRQCHIP_NUM_SOURCES 128
> >   #define VIRT_IRQCHIP_NUM_PRIO_BITS 3
> >   #define VIRT_IRQCHIP_MAX_GUESTS_BITS 3
> >   #define VIRT_IRQCHIP_MAX_GUESTS ((1U << VIRT_IRQCHIP_MAX_GUESTS_BITS)=
 - 1U)
> > @@ -158,4 +165,10 @@ uint32_t imsic_num_bits(uint32_t count);
> >   #error "Can't accommodate all IMSIC groups in address space"
> >   #endif
> >
> > +/* WorldGuard */
> > +#define VIRT_WG_NWORLDS         4
> > +#define VIRT_WG_TRUSTEDWID      3
> > +#define VIRT_WG_HWBYPASS        true
> > +#define VIRT_WG_TZCOMPAT        false
> > +
> >   #endif
>

