Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC00C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 18:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYryb-0003f8-7u; Tue, 30 Jul 2024 14:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYryY-0003e6-2L
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYryV-0005kC-D8
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722365609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7b02CWXbm5YUrMNDi/6X5cokb+yPyu/dB2SOGtleIY=;
 b=I1TbyV2Ha07uf5qYkNdOHFPVPK6LWLGY2tfQyVjt76WhSEw0GjLMaRVkOe6BD3w80c3Rf+
 5rdDFRsk/ieeqzw/GSpa/99inu2/EGxX+dgSQ8XqHFAjSh8xfpLpKwt48RFHBQKO9pPtTL
 li/YCaR0MX/EXvYj7Mp19PS7t8d/giw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-IZ4d3X9cNKieHci4iQzDdA-1; Tue, 30 Jul 2024 14:53:27 -0400
X-MC-Unique: IZ4d3X9cNKieHci4iQzDdA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52efe4c2261so6677508e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 11:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722365606; x=1722970406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7b02CWXbm5YUrMNDi/6X5cokb+yPyu/dB2SOGtleIY=;
 b=g2rGjWWX4yngDDbwoqat67cq6RjKZNeL6M40gYk5wYTnWV4YGhBcWrf5eK96pODsDJ
 372aJzN+5B89O5+n6DVnO200RmBbBYdQosuU1ksKIR8vgM/gUrFJ8NE+NrbVpdhEjvV9
 IZ7s6MOJFRwWicLxs5RdXbZJlOlTRr5GbWSmL0yJakJgcQz4xxQYPDC1pUo9+pUvNitY
 Cm7DmDWYEGaIunEmXmxdgP7zYIXUyJaxCKiiETxzDmLszC03CD1TItCKMBdhRgfwBsPq
 cf4pnNLpuQwmpAw6oYUJowwpL8nGCDXwMA0atu1tPZWidsdNby94B2UP6qlOXXCSf/Gd
 3hrw==
X-Gm-Message-State: AOJu0YwQQqqJ69WkAG8nti/VWHF3qbu//eQqrKVcucxCcwtzqZeskkzc
 pJYI1lXfz4jAiPMEjz32SaqXQLDHeecA0Np8eUBXzo67Xd49ksiMnywjBXHkSXqsToRDXId1/5b
 pCNMNIpZHW1KJsdZRzy3IlioNegydgxkSewLfS+ZbbkaGg5rUbW5m
X-Received: by 2002:ac2:4143:0:b0:52e:a03f:ef53 with SMTP id
 2adb3069b0e04-5309b28097amr9296518e87.24.1722365605479; 
 Tue, 30 Jul 2024 11:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRJH7+exzZM4Y0spZUEyBixCWOX+qwTAjLQAs0ep0knvEeWLS5ShQjzz+huNNIxlXusmQc6Q==
X-Received: by 2002:ac2:4143:0:b0:52e:a03f:ef53 with SMTP id
 2adb3069b0e04-5309b28097amr9296499e87.24.1722365604634; 
 Tue, 30 Jul 2024 11:53:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:ce53:abb9:7fe9:ef80:6a78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad41479sm678934166b.123.2024.07.30.11.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 11:53:24 -0700 (PDT)
Date: Tue, 30 Jul 2024 14:53:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dominic Prinz <git@dprinz.de>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] hw/acpi/ich9: Add periodic and swsmi timer
Message-ID: <20240730145240-mutt-send-email-mst@kernel.org>
References: <20240719102053.316744-1-git@dprinz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719102053.316744-1-git@dprinz.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 19, 2024 at 12:20:53PM +0200, Dominic Prinz wrote:
> This patch implements the periodic and the swsmi ICH9 chipset timer. They are
> especially useful when prototyping UEFI firmware (e.g. with EDK2's OVMF)
> with QEMU.
> 
> This includes that writes to the SMI_STS register are enabled for the
> corresponding two bits.
> 
> Signed-off-by: Dominic Prinz <git@dprinz.de>

Without getting too deep into it, generally any guest visible
behaviour change is best gated on a compat property,
to prevent changing existing machine types.

> ---
>  hw/acpi/ich9.c                | 15 +++++++
>  hw/acpi/ich9_timer.c          | 79 +++++++++++++++++++++++++++++++++++
>  hw/acpi/meson.build           |  2 +-
>  hw/isa/lpc_ich9.c             |  6 +++
>  include/hw/acpi/ich9.h        |  3 ++
>  include/hw/acpi/ich9_timer.h  | 23 ++++++++++
>  include/hw/southbridge/ich9.h |  4 ++
>  7 files changed, 131 insertions(+), 1 deletion(-)
>  create mode 100644 hw/acpi/ich9_timer.c
>  create mode 100644 include/hw/acpi/ich9_timer.h
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 02d8546bd3..97d645b750 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -35,6 +35,7 @@
>  #include "sysemu/runstate.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/ich9_tco.h"
> +#include "hw/acpi/ich9_timer.h"
>  
>  #include "hw/southbridge/ich9.h"
>  #include "hw/mem/pc-dimm.h"
> @@ -108,6 +109,16 @@ static void ich9_smi_writel(void *opaque, hwaddr addr, uint64_t val,
>          }
>          pm->smi_en &= ~pm->smi_en_wmask;
>          pm->smi_en |= (val & pm->smi_en_wmask);
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
>          break;
>      }
>  }
> @@ -305,6 +316,10 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
>                            "acpi-smi", 8);
>      memory_region_add_subregion(&pm->io, ICH9_PMIO_SMI_EN, &pm->io_smi);
>  
> +    pm->swsmi_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ich9_swsmi_timer, pm);
> +
> +    pm->periodic_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ich9_periodic_timer, pm);
> +
>      if (pm->enable_tco) {
>          acpi_pm_tco_init(&pm->tco_regs, &pm->io);
>      }
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
>  acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_true: files('pcihp.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
> -acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c'))
> +acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
>  acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
>  acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index bd727b2320..56daeeedbf 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -43,6 +43,7 @@
>  #include "hw/southbridge/ich9.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/ich9.h"
> +#include "hw/acpi/ich9_timer.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/qdev-properties.h"
>  #include "sysemu/runstate.h"
> @@ -531,6 +532,11 @@ ich9_lpc_pmcon_update(ICH9LPCState *lpc)
>      uint16_t gen_pmcon_1 = pci_get_word(lpc->d.config + ICH9_LPC_GEN_PMCON_1);
>      uint16_t wmask;
>  
> +    ich9_pm_update_swsmi_timer(&lpc->pm, lpc->pm.smi_en &
> +                                             ICH9_PMIO_SMI_EN_SWSMI_EN);
> +    ich9_pm_update_periodic_timer(&lpc->pm, lpc->pm.smi_en &
> +                                                ICH9_PMIO_SMI_EN_PERIODIC_EN);
> +
>      if (gen_pmcon_1 & ICH9_LPC_GEN_PMCON_1_SMI_LOCK) {
>          wmask = pci_get_word(lpc->d.wmask + ICH9_LPC_GEN_PMCON_1);
>          wmask &= ~ICH9_LPC_GEN_PMCON_1_SMI_LOCK;
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index 2faf7f0cae..940a3d795f 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -68,6 +68,9 @@ typedef struct ICH9LPCPMRegs {
>      bool smm_compat;
>      bool enable_tco;
>      TCOIORegs tco_regs;
> +
> +    QEMUTimer *swsmi_timer;
> +    QEMUTimer *periodic_timer;
>  } ICH9LPCPMRegs;
>  
>  #define ACPI_PM_PROP_TCO_ENABLED "enable_tco"
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
>  #define ICH9_PMIO_GPE0_LEN                      16
>  #define ICH9_PMIO_SMI_EN                        0x30
>  #define ICH9_PMIO_SMI_EN_APMC_EN                (1 << 5)
> +#define ICH9_PMIO_SMI_EN_SWSMI_EN               (1 << 6)
>  #define ICH9_PMIO_SMI_EN_TCO_EN                 (1 << 13)
> +#define ICH9_PMIO_SMI_EN_PERIODIC_EN            (1 << 14)
>  #define ICH9_PMIO_SMI_STS                       0x34
> +#define ICH9_PMIO_SMI_STS_SWSMI_STS             (1 << 6)
> +#define ICH9_PMIO_SMI_STS_PERIODIC_STS          (1 << 14)
>  #define ICH9_PMIO_TCO_RLD                       0x60
>  #define ICH9_PMIO_TCO_LEN                       32
>  
> -- 
> 2.34.1


