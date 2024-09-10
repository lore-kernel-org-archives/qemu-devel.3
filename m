Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4B2EDE99A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 15:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2fy-0001hs-72; Tue, 10 Sep 2024 11:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2fv-0001gp-V6
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2fr-0006XB-Qg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725981659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2eBZZSaT/noc8zxoUukuJ+/YKZMlXgaL80npL4vDvvY=;
 b=CWagMOe+4nlDCJXYicjfNcPDl0P3GJKTULxoRVFbKVmvDNptzx3JrRd9uIIEGZp8s2LvAW
 hGRe68K73ctFjkzuDmcKtVYX9HM/W2N/++sZdj8qQd4KJWPobCLWC4P4jKzCH6ARzuciRP
 6Tni/Adn+ScgbOEY0miBMe93RIhS3KM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-ggGEn_A8PGCA_tK849SP1Q-1; Tue, 10 Sep 2024 11:20:57 -0400
X-MC-Unique: ggGEn_A8PGCA_tK849SP1Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cc4345561so4099465e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 08:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725981656; x=1726586456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2eBZZSaT/noc8zxoUukuJ+/YKZMlXgaL80npL4vDvvY=;
 b=vX5kjCs8+JlM3dU0pKz5X0oCQj/vWaecfX9QfpR8+aBVXyzV2oipbjGw07rfJZ+0KQ
 kAAlL/i5JxOP9jJNm+f1hmZFIqadrOAOiqa0NnEJ66G/KKeNmgVLm+ZlZyvhhpQFqQ0f
 gAUaXKvPFovvgboB2GC0R61iKl4ZgvP0TGNFhSF/c9eUwJCR/5O4e9ywaQTG/Ks9fVvp
 TASHnXPTHoYpshuXe1rKKy71IPuFacQzXtvDXdmDcc0sjvr13XpN/4iQyN2AbYwx/lR+
 ZTQiXNBbssIRCeiXx3F8toOPl/L68xOWlGLg5VDd5JfVgSId268olmT/rYy3R3teG2Sf
 +gmA==
X-Gm-Message-State: AOJu0YzS2ZKRbpoKJIqPrTMn6tIr+/VtYVjUV7hGq27Gl+y3/7/k7NhH
 VwHLdEvN2pdMjrTJrVSoLH57RUqYNmKuZNQDPk5wH/tGKzPe1CRbGFMMUUcKupBukUVuG0uraEV
 WNLghWHNEAVo7oQQRuYaZPJy1J7AudjacCS3myVujb42ajjuFC4OS
X-Received: by 2002:a05:600c:1c86:b0:426:554a:e0bf with SMTP id
 5b1f17b1804b1-42cad763777mr88094325e9.16.1725981656206; 
 Tue, 10 Sep 2024 08:20:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFllXsT7Yt7D+GHl1Jnfx/DFE2eL3DPk8K38hiPaT2kcX1mJFScOe8B7tqUJEY80BWEZHTCNw==
X-Received: by 2002:a05:600c:1c86:b0:426:554a:e0bf with SMTP id
 5b1f17b1804b1-42cad763777mr88093705e9.16.1725981655176; 
 Tue, 10 Sep 2024 08:20:55 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dd9a1sm9216771f8f.101.2024.09.10.08.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 08:20:54 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:20:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dominic Prinz <git@dprinz.de>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2] hw/acpi/ich9: Add periodic and swsmi timer
Message-ID: <20240910111914-mutt-send-email-mst@kernel.org>
References: <20240730145240-mutt-send-email-mst@kernel.org>
 <1e4d59a49e7f2e02cf522e799a7bf5f3fa3fba1f.1722414006.git.git@dprinz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e4d59a49e7f2e02cf522e799a7bf5f3fa3fba1f.1722414006.git.git@dprinz.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 31, 2024 at 10:28:34AM +0200, Dominic Prinz wrote:
> This patch implements the periodic and the swsmi ICH9 chipset timer. They are
> especially useful when prototyping UEFI firmware (e.g. with EDK2's OVMF)
> using QEMU.
> 
> For backwards compatibility, the compat properties "x-smi-swsmi-timer",
> and "x-smi-periodic-timer" are introduced.
> 
> Additionally, writes to the SMI_STS register are enabled for the
> corresponding two bits.
> 
> Signed-off-by: Dominic Prinz <git@dprinz.de>
> ---
> Changes since previous version:
>   - Ensured backwards compatablity by introducing two compat properties
>   - Introduced write mask for SMI_STS register to make future work easier
> 
>  hw/acpi/ich9.c                | 23 +++++++++
>  hw/acpi/ich9_timer.c          | 93 +++++++++++++++++++++++++++++++++++
>  hw/acpi/meson.build           |  2 +-
>  hw/i386/pc.c                  |  2 +
>  hw/isa/lpc_ich9.c             | 14 ++++++
>  include/hw/acpi/ich9.h        |  6 +++
>  include/hw/acpi/ich9_timer.h  | 23 +++++++++
>  include/hw/southbridge/ich9.h |  4 ++
>  8 files changed, 166 insertions(+), 1 deletion(-)
>  create mode 100644 hw/acpi/ich9_timer.c
>  create mode 100644 include/hw/acpi/ich9_timer.h
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 02d8546bd3..c15e5b8281 100644
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
> @@ -108,6 +109,18 @@ static void ich9_smi_writel(void *opaque, hwaddr addr, uint64_t val,
>          }
>          pm->smi_en &= ~pm->smi_en_wmask;
>          pm->smi_en |= (val & pm->smi_en_wmask);
> +        if (pm->swsmi_timer_enabled) {
> +            ich9_pm_update_swsmi_timer(pm, pm->smi_en &
> +                                               ICH9_PMIO_SMI_EN_SWSMI_EN);
> +        }
> +        if (pm->periodic_timer_enabled) {
> +            ich9_pm_update_periodic_timer(pm, pm->smi_en &
> +                                                  ICH9_PMIO_SMI_EN_PERIODIC_EN);
> +        }
> +        break;
> +    case 4:
> +        pm->smi_sts &= ~pm->smi_sts_wmask;
> +        pm->smi_sts |= (val & pm->smi_sts_wmask);
>          break;
>      }
>  }
> @@ -286,6 +299,8 @@ static void pm_powerdown_req(Notifier *n, void *opaque)
>  
>  void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
>  {
> +    pm->smi_sts_wmask = 0;
> +
>      memory_region_init(&pm->io, OBJECT(lpc_pci), "ich9-pm", ICH9_PMIO_SIZE);
>      memory_region_set_enabled(&pm->io, false);
>      memory_region_add_subregion(pci_address_space_io(lpc_pci),
> @@ -305,6 +320,14 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
>                            "acpi-smi", 8);
>      memory_region_add_subregion(&pm->io, ICH9_PMIO_SMI_EN, &pm->io_smi);
>  
> +    if (pm->swsmi_timer_enabled) {
> +        ich9_pm_swsmi_timer_init(pm);
> +    }
> +
> +    if (pm->periodic_timer_enabled) {
> +        ich9_pm_periodic_timer_init(pm);
> +    }
> +
>      if (pm->enable_tco) {
>          acpi_pm_tco_init(&pm->tco_regs, &pm->io);
>      }
> diff --git a/hw/acpi/ich9_timer.c b/hw/acpi/ich9_timer.c
> new file mode 100644
> index 0000000000..5b1c910156
> --- /dev/null
> +++ b/hw/acpi/ich9_timer.c
> @@ -0,0 +1,93 @@
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
> +static void ich9_pm_swsmi_timer_expired(void *opaque)
> +{
> +    ICH9LPCPMRegs *pm = opaque;
> +
> +    pm->smi_sts |= ICH9_PMIO_SMI_STS_SWSMI_STS;
> +    ich9_generate_smi();
> +
> +    ich9_pm_update_swsmi_timer(pm, pm->smi_en & ICH9_PMIO_SMI_EN_SWSMI_EN);
> +}
> +
> +void ich9_pm_swsmi_timer_init(ICH9LPCPMRegs *pm)
> +{
> +    pm->smi_sts_wmask |= ICH9_PMIO_SMI_STS_SWSMI_STS;
> +    pm->swsmi_timer =
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, ich9_pm_swsmi_timer_expired, pm);
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
> +static void ich9_pm_periodic_timer_expired(void *opaque)
> +{
> +    ICH9LPCPMRegs *pm = opaque;
> +
> +    pm->smi_sts = ICH9_PMIO_SMI_STS_PERIODIC_STS;
> +    ich9_generate_smi();
> +
> +    ich9_pm_update_periodic_timer(pm,
> +                                  pm->smi_en & ICH9_PMIO_SMI_EN_PERIODIC_EN);
> +}
> +
> +void ich9_pm_periodic_timer_init(ICH9LPCPMRegs *pm)
> +{
> +    pm->smi_sts_wmask |= ICH9_PMIO_SMI_STS_PERIODIC_STS;
> +    pm->periodic_timer =
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, ich9_pm_periodic_timer_expired, pm);
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
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c74931d577..a97b1b1f57 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -85,6 +85,8 @@ GlobalProperty pc_compat_9_0[] = {
>      { TYPE_X86_CPU, "guest-phys-bits", "0" },
>      { "sev-guest", "legacy-vm-type", "on" },
>      { TYPE_X86_CPU, "legacy-multi-node", "on" },
> +    { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
> +    { "ICH9-LPC", "x-smi-periodic-timer", "off" },
>  };
>  const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
>

this needs to be 9.1 now, right?
  
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index bd727b2320..ab17b76f54 100644
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
> @@ -531,6 +532,15 @@ ich9_lpc_pmcon_update(ICH9LPCState *lpc)
>      uint16_t gen_pmcon_1 = pci_get_word(lpc->d.config + ICH9_LPC_GEN_PMCON_1);
>      uint16_t wmask;
>  
> +    if (lpc->pm.swsmi_timer_enabled) {
> +        ich9_pm_update_swsmi_timer(
> +            &lpc->pm, lpc->pm.smi_en & ICH9_PMIO_SMI_EN_SWSMI_EN);
> +    }
> +    if (lpc->pm.periodic_timer_enabled) {
> +        ich9_pm_update_periodic_timer(
> +            &lpc->pm, lpc->pm.smi_en & ICH9_PMIO_SMI_EN_PERIODIC_EN);
> +    }
> +
>      if (gen_pmcon_1 & ICH9_LPC_GEN_PMCON_1_SMI_LOCK) {
>          wmask = pci_get_word(lpc->d.wmask + ICH9_LPC_GEN_PMCON_1);
>          wmask &= ~ICH9_LPC_GEN_PMCON_1_SMI_LOCK;
> @@ -826,6 +836,10 @@ static Property ich9_lpc_properties[] = {
>                        ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
>      DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_features,
>                        ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT, true),
> +    DEFINE_PROP_BOOL("x-smi-swsmi-timer", ICH9LPCState,
> +                     pm.swsmi_timer_enabled, true),
> +    DEFINE_PROP_BOOL("x-smi-periodic-timer", ICH9LPCState,
> +                     pm.periodic_timer_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index 2faf7f0cae..245fe08dc2 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -46,6 +46,7 @@ typedef struct ICH9LPCPMRegs {
>      uint32_t smi_en;
>      uint32_t smi_en_wmask;
>      uint32_t smi_sts;
> +    uint32_t smi_sts_wmask;
>  
>      qemu_irq irq;      /* SCI */
>  
> @@ -68,6 +69,11 @@ typedef struct ICH9LPCPMRegs {
>      bool smm_compat;
>      bool enable_tco;
>      TCOIORegs tco_regs;
> +
> +    bool swsmi_timer_enabled;
> +    bool periodic_timer_enabled;
> +    QEMUTimer *swsmi_timer;
> +    QEMUTimer *periodic_timer;
>  } ICH9LPCPMRegs;
>  
>  #define ACPI_PM_PROP_TCO_ENABLED "enable_tco"
> diff --git a/include/hw/acpi/ich9_timer.h b/include/hw/acpi/ich9_timer.h
> new file mode 100644
> index 0000000000..5112df4385
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
> +void ich9_pm_swsmi_timer_init(ICH9LPCPMRegs *pm);
> +
> +void ich9_pm_update_periodic_timer(ICH9LPCPMRegs *pm, bool enable);
> +
> +void ich9_pm_periodic_timer_init(ICH9LPCPMRegs *pm);
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


