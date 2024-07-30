Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4FBC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 20:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYtBL-0000KI-0s; Tue, 30 Jul 2024 16:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominic@dprinz.de>) id 1sYroL-0005du-37
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:43:01 -0400
Received: from mail.dprinz.de ([178.254.36.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominic@dprinz.de>) id 1sYroI-0003tE-TO
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:43:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1230353F6E; Tue, 30 Jul 2024 20:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dprinz.de; s=dkim;
 t=1722364960; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=yIHXDBvMpOzy0b1FfF9QYseyidEbSlxkJ9gemzOH1Gk=;
 b=gutvCdD70eTOek+EjyL2mabbVMmZ1r+bATCQE2Ve9ZNP+UxPSn7P+jY6BNSKtz8u6LmaKc
 PirgMLxepx8ljF+QS8Wh+5us35v1KoBkuFIf7DcBBsD402LW9xdjFpoZT03J61CA8elIPN
 jp9ZUcCdjPKZJWKDTlGXuXnYc6UZLRPOc9FbHAA0UPSPaRDwpRNaNGT1xuy8+l5ZHH3uqa
 guBOHxFqx4ybcNR54XLu4HeeiaE5pT+cm74XaiWOh3EuzLKF8e0+aVi4w6LOvnhYaQt2L/
 YZCu/Zn0Q3XP3aC0vjirsvHDQPRTyNvcaBCIjeto5oqSO16ewwRIZAvS3MXEbQ==
Message-ID: <b1d4e6f3-ff64-4377-aa1c-edae3fa246de@dprinz.de>
Date: Tue, 30 Jul 2024 20:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/acpi/ich9: Add periodic and swsmi timer
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Dominic Prinz <git@dprinz.de>
References: <20240719102053.316744-1-git@dprinz.de>
Content-Language: de-DE, en-US
From: Dominic Prinz <dominic@dprinz.de>
In-Reply-To: <20240719102053.316744-1-git@dprinz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Received-SPF: pass client-ip=178.254.36.89; envelope-from=dominic@dprinz.de;
 helo=mail.dprinz.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jul 2024 16:10:47 -0400
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

Ping for my patch from last Friday.

https://patchew.org/QEMU/20240719102053.316744-1-git@dprinz.de/
https://lore.kernel.org/qemu-devel/20240719102053.316744-1-git@dprinz.de/


On 19.07.24 12:20, Dominic Prinz wrote:
> This patch implements the periodic and the swsmi ICH9 chipset timer. They are
> especially useful when prototyping UEFI firmware (e.g. with EDK2's OVMF)
> with QEMU.
>
> This includes that writes to the SMI_STS register are enabled for the
> corresponding two bits.
>
> Signed-off-by: Dominic Prinz <git@dprinz.de>
> ---
>   hw/acpi/ich9.c                | 15 +++++++
>   hw/acpi/ich9_timer.c          | 79 +++++++++++++++++++++++++++++++++++
>   hw/acpi/meson.build           |  2 +-
>   hw/isa/lpc_ich9.c             |  6 +++
>   include/hw/acpi/ich9.h        |  3 ++
>   include/hw/acpi/ich9_timer.h  | 23 ++++++++++
>   include/hw/southbridge/ich9.h |  4 ++
>   7 files changed, 131 insertions(+), 1 deletion(-)
>   create mode 100644 hw/acpi/ich9_timer.c
>   create mode 100644 include/hw/acpi/ich9_timer.h
>
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 02d8546bd3..97d645b750 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -35,6 +35,7 @@
>   #include "sysemu/runstate.h"
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/ich9_tco.h"
> +#include "hw/acpi/ich9_timer.h"
>   
>   #include "hw/southbridge/ich9.h"
>   #include "hw/mem/pc-dimm.h"
> @@ -108,6 +109,16 @@ static void ich9_smi_writel(void *opaque, hwaddr addr, uint64_t val,
>           }
>           pm->smi_en &= ~pm->smi_en_wmask;
>           pm->smi_en |= (val & pm->smi_en_wmask);
> +        ich9_pm_update_swsmi_timer(pm, pm->smi_en &
> +                                           ICH9_PMIO_SMI_EN_SWSMI_EN);
> +        ich9_pm_update_periodic_timer(pm, pm->smi_en &
> +                                              ICH9_PMIO_SMI_EN_PERIODIC_EN);
> +        break;
> +    case 4:
> +        pm->smi_sts &= ~(ICH9_PMIO_SMI_STS_SWSMI_STS |
> +                         ICH9_PMIO_SMI_STS_PERIODIC_STS);
> +        pm->smi_sts |= val & (ICH9_PMIO_SMI_STS_SWSMI_STS |
> +                              ICH9_PMIO_SMI_STS_PERIODIC_STS);
>           break;
>       }
>   }
> @@ -305,6 +316,10 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
>                             "acpi-smi", 8);
>       memory_region_add_subregion(&pm->io, ICH9_PMIO_SMI_EN, &pm->io_smi);
>   
> +    pm->swsmi_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ich9_swsmi_timer, pm);
> +
> +    pm->periodic_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ich9_periodic_timer, pm);
> +
>       if (pm->enable_tco) {
>           acpi_pm_tco_init(&pm->tco_regs, &pm->io);
>       }
> diff --git a/hw/acpi/ich9_timer.c b/hw/acpi/ich9_timer.c
> new file mode 100644
> index 0000000000..2e6b68f0fb
> --- /dev/null
> +++ b/hw/acpi/ich9_timer.c
> @@ -0,0 +1,79 @@
> +/*
> + * QEMU ICH9 Timer emulation
> + *
> + * Copyright (c) 2024 Dominic Prinz <git@dprinz.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/cpu.h"
> +#include "hw/pci/pci.h"
> +#include "hw/southbridge/ich9.h"
> +#include "qemu/timer.h"
> +
> +#include "hw/acpi/ich9_timer.h"
> +
> +void ich9_pm_update_swsmi_timer(ICH9LPCPMRegs *pm, bool enable)
> +{
> +    uint16_t swsmi_rate_sel;
> +    int64_t expire_time;
> +    ICH9LPCState *lpc;
> +
> +    if (enable) {
> +        lpc = container_of(pm, ICH9LPCState, pm);
> +        swsmi_rate_sel =
> +            (pci_get_word(lpc->d.config + ICH9_LPC_GEN_PMCON_3) & 0xc0) >> 6;
> +
> +        if (swsmi_rate_sel == 0) {
> +            expire_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1500000LL;
> +        } else {
> +            expire_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                          8 * (1 << swsmi_rate_sel) * 1000000LL;
> +        }
> +
> +        timer_mod(pm->swsmi_timer, expire_time);
> +    } else {
> +        timer_del(pm->swsmi_timer);
> +    }
> +}
> +
> +void ich9_swsmi_timer(void *opaque)
> +{
> +    ICH9LPCPMRegs *pm = opaque;
> +
> +    pm->smi_sts |= ICH9_PMIO_SMI_STS_SWSMI_STS;
> +    ich9_generate_smi();
> +
> +    ich9_pm_update_swsmi_timer(pm, pm->smi_en & ICH9_PMIO_SMI_EN_SWSMI_EN);
> +}
> +
> +void ich9_pm_update_periodic_timer(ICH9LPCPMRegs *pm, bool enable)
> +{
> +    uint16_t per_smi_sel;
> +    int64_t expire_time;
> +    ICH9LPCState *lpc;
> +
> +    if (enable) {
> +        lpc = container_of(pm, ICH9LPCState, pm);
> +        per_smi_sel = pci_get_word(lpc->d.config + ICH9_LPC_GEN_PMCON_1) & 3;
> +        expire_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                      8 * (1 << (3 - per_smi_sel)) * NANOSECONDS_PER_SECOND;
> +
> +        timer_mod(pm->periodic_timer, expire_time);
> +    } else {
> +        timer_del(pm->periodic_timer);
> +    }
> +}
> +
> +void ich9_periodic_timer(void *opaque)
> +{
> +    ICH9LPCPMRegs *pm = opaque;
> +
> +    pm->smi_sts = ICH9_PMIO_SMI_STS_PERIODIC_STS;
> +    ich9_generate_smi();
> +
> +    ich9_pm_update_periodic_timer(pm,
> +                                  pm->smi_en & ICH9_PMIO_SMI_EN_PERIODIC_EN);
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index fa5c07db90..7f8ccc9b7a 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -24,7 +24,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_true: files('pci-bridge.c'))
>   acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_true: files('pcihp.c'))
>   acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug-stub.c'))
>   acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
> -acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c'))
> +acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c'))
>   acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
>   acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
>   acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index bd727b2320..56daeeedbf 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -43,6 +43,7 @@
>   #include "hw/southbridge/ich9.h"
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/ich9.h"
> +#include "hw/acpi/ich9_timer.h"
>   #include "hw/pci/pci_bus.h"
>   #include "hw/qdev-properties.h"
>   #include "sysemu/runstate.h"
> @@ -531,6 +532,11 @@ ich9_lpc_pmcon_update(ICH9LPCState *lpc)
>       uint16_t gen_pmcon_1 = pci_get_word(lpc->d.config + ICH9_LPC_GEN_PMCON_1);
>       uint16_t wmask;
>   
> +    ich9_pm_update_swsmi_timer(&lpc->pm, lpc->pm.smi_en &
> +                                             ICH9_PMIO_SMI_EN_SWSMI_EN);
> +    ich9_pm_update_periodic_timer(&lpc->pm, lpc->pm.smi_en &
> +                                                ICH9_PMIO_SMI_EN_PERIODIC_EN);
> +
>       if (gen_pmcon_1 & ICH9_LPC_GEN_PMCON_1_SMI_LOCK) {
>           wmask = pci_get_word(lpc->d.wmask + ICH9_LPC_GEN_PMCON_1);
>           wmask &= ~ICH9_LPC_GEN_PMCON_1_SMI_LOCK;
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index 2faf7f0cae..940a3d795f 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -68,6 +68,9 @@ typedef struct ICH9LPCPMRegs {
>       bool smm_compat;
>       bool enable_tco;
>       TCOIORegs tco_regs;
> +
> +    QEMUTimer *swsmi_timer;
> +    QEMUTimer *periodic_timer;
>   } ICH9LPCPMRegs;
>   
>   #define ACPI_PM_PROP_TCO_ENABLED "enable_tco"
> diff --git a/include/hw/acpi/ich9_timer.h b/include/hw/acpi/ich9_timer.h
> new file mode 100644
> index 0000000000..e48f9918d8
> --- /dev/null
> +++ b/include/hw/acpi/ich9_timer.h
> @@ -0,0 +1,23 @@
> +/*
> + * QEMU ICH9 Timer emulation
> + *
> + * Copyright (c) 2024 Dominic Prinz <git@dprinz.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_ACPI_ICH9_TIMER_H
> +#define HW_ACPI_ICH9_TIMER_H
> +
> +#include "hw/acpi/ich9.h"
> +
> +void ich9_pm_update_swsmi_timer(ICH9LPCPMRegs *pm, bool enable);
> +
> +void ich9_swsmi_timer(void *opaque);
> +
> +void ich9_pm_update_periodic_timer(ICH9LPCPMRegs *pm, bool enable);
> +
> +void ich9_periodic_timer(void *opaque);
> +
> +#endif
> diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
> index fd01649d04..6c60017024 100644
> --- a/include/hw/southbridge/ich9.h
> +++ b/include/hw/southbridge/ich9.h
> @@ -196,8 +196,12 @@ struct ICH9LPCState {
>   #define ICH9_PMIO_GPE0_LEN                      16
>   #define ICH9_PMIO_SMI_EN                        0x30
>   #define ICH9_PMIO_SMI_EN_APMC_EN                (1 << 5)
> +#define ICH9_PMIO_SMI_EN_SWSMI_EN               (1 << 6)
>   #define ICH9_PMIO_SMI_EN_TCO_EN                 (1 << 13)
> +#define ICH9_PMIO_SMI_EN_PERIODIC_EN            (1 << 14)
>   #define ICH9_PMIO_SMI_STS                       0x34
> +#define ICH9_PMIO_SMI_STS_SWSMI_STS             (1 << 6)
> +#define ICH9_PMIO_SMI_STS_PERIODIC_STS          (1 << 14)
>   #define ICH9_PMIO_TCO_RLD                       0x60
>   #define ICH9_PMIO_TCO_LEN                       32
>   


