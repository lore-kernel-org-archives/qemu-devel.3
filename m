Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A69CED63B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLMVc-0001g6-Bk; Tue, 18 Nov 2025 09:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLMVY-0001eW-O3
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:16:37 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLMVW-0005Oa-Rp
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:16:36 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-429c48e05aeso3351353f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 06:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763475393; x=1764080193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G+Af4QdjkVgtDe5aYTVI85tKJi7oVWCXPPLTx5kI1A8=;
 b=rhSKRA5EO5+mbSvkhHN7gR1+Npd5s8kss+Tbvlif4RfVeasqxwlNWjECcHsmYHuAqQ
 UWQGLEsv0/i++im7aiU4kYAfIaNsk4DGUWNiXAVs2rcLA37IWcFvsrErMjzUhXlCKI+s
 9rMHGriXh50Dxh2g4AmMN9+Y+iG8kqVTQ6UAUQwlAa9qm314tNPd5cuQrcenVeT4v07s
 t/UFm8JhWgTNBpEF1n+pUuuDFpW+YiVPmiAo6UGAnT8gtpiiFSJqoUyc+g9BzAAcHQJz
 Zjq7pDWhzh/68wZqKFPJJZT1lYQ0IWfPRMfntZBvlTWhz2j8OTE2986PBZvMVuP0hhyN
 GvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763475393; x=1764080193;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G+Af4QdjkVgtDe5aYTVI85tKJi7oVWCXPPLTx5kI1A8=;
 b=nRf3OfmbNWL5k0/t2buuvbpucMzU28X5iGxXW4+F6rqPAH7x/5Dx2cA6tzDEruqDo7
 g4dNb3uObJPNlxQdWUByn7+ZhviC6FyKkIENBilPPkQz4IHw2dSZ2K2C16H2ohEYgpQm
 SqDlo2qlwF+OS77zMFaVnAT9rz+WrD+PQ8bcLfhOSEIp68b2mGedtQ6M+oaDbqNzJvty
 +23rOrenpvd+aXklc+u5l79aBADKpYC6Thcm4jDul1MR4VHEVPQsbVfmaDsK8uAnO92B
 ARzMOqAsDbcr3W++h/zW2yHyhievO4ZbC3rNdPG0x/l7XrPQFu7XAXAYDLQSLW2Rgxa4
 tWvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX66or5S2ztrHWyhlkTRPIS1xtIKzq4EBqOzzGf8BSiHN4jlbQV5Hy6aoa5MKaY8Q9hjLrUr6KR9EC2@nongnu.org
X-Gm-Message-State: AOJu0YzSG2MwXObZeW8ByfJTgerC941hKFQamZmnFA3UFgoUpW0exm/H
 RDXZW7Nr0LHPCCHamcrcXv/cRGs7cVBLjonhjx3x4MchfaJQX9z8pw9LfO87N/UzoH0=
X-Gm-Gg: ASbGnctG8WMLUm9bgG3mfz3mppw7gzsOezmgeu5650Wht6bFRsZpy5EmWxzpHAlUSx2
 DbnNz/ScZcJfQjPBT70oFsOQ6lSf4kt7NaB0l7WCBro9aqUk5WE7RC3Zx5febeIHRw4ufADpgND
 lFz+J5zlZ4c8LAhC8ZUfd+MoqPel1hnQjvfIEjl44Trbu4Ca45zYuH9/9oO/nxq2OpO2vNAuO7J
 OwokZbsSGryUQcXmVOiPLlIzf62hvVNKoGIby/uhbE+GkMzluE6CGBkhXl/5pv0aLEoFzvHfAEx
 6LPmnD4+3pYhxpLIGTBARkL7bZmxGcsfjP+8VHmi86iLSgYsdAdhgpmWZowODw2w3UtsT08DMeX
 TFwVnZLsZRRygf1EOkTczAGMuq0KCUsiF49ULH7NBw9JqEHysSYrJrRKcFV2PDnOtlWYJyWHUj+
 5z/aX1bkBnWq6ywNAxLV9JYTrGYVMaZLPALxj4pUt74XQ=
X-Google-Smtp-Source: AGHT+IHqOYsH1m6y94Fjq9eQyc4T4FXmE6rPEGJbQhvAoaXrCx9CPI54L5vDyHqRFmxhv3sfo5aPYA==
X-Received: by 2002:a5d:584a:0:b0:425:86da:325f with SMTP id
 ffacd0b85a97d-42ca8cd213cmr3304015f8f.27.1763475392493; 
 Tue, 18 Nov 2025 06:16:32 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f1fd50sm32357869f8f.38.2025.11.18.06.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 06:16:31 -0800 (PST)
Message-ID: <77d7afeb-3dbc-4fcf-976b-09fe01cf542e@linaro.org>
Date: Tue, 18 Nov 2025 15:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] hw/misc/pvpanic: add PCI interface support
Content-Language: en-US
To: Mihai Carabas <mihai.carabas@oracle.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yvugenfi@redhat.com, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <1611759570-3645-1-git-send-email-mihai.carabas@oracle.com>
 <1611759570-3645-3-git-send-email-mihai.carabas@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1611759570-3645-3-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Hi,

(old patch merged as commit d097b3dcb62)

On 27/1/21 15:59, Mihai Carabas wrote:
> Add PCI interface support for PVPANIC device. Create a new file pvpanic-pci.c
> where the PCI specific routines reside and update the build system with the new
> files and config structure.
> 
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>   docs/specs/pci-ids.txt    |  1 +
>   hw/misc/Kconfig           |  6 +++
>   hw/misc/meson.build       |  1 +
>   hw/misc/pvpanic-pci.c     | 94 +++++++++++++++++++++++++++++++++++++++++++++++
>   include/hw/misc/pvpanic.h |  1 +
>   include/hw/pci/pci.h      |  1 +
>   6 files changed, 104 insertions(+)
>   create mode 100644 hw/misc/pvpanic-pci.c
> 
> diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
> index abbdbca..5e407a6 100644
> --- a/docs/specs/pci-ids.txt
> +++ b/docs/specs/pci-ids.txt
> @@ -64,6 +64,7 @@ PCI devices (other than virtio):
>   1b36:000d  PCI xhci usb host adapter
>   1b36:000f  mdpy (mdev sample device), linux/samples/vfio-mdev/mdpy.c
>   1b36:0010  PCIe NVMe device (-device nvme)
> +1b36:0011  PCI PVPanic device (-device pvpanic-pci)
>   
>   All these devices are documented in docs/specs.
>   
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 23bc978..19c216f 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -124,6 +124,12 @@ config IOTKIT_SYSINFO
>   config PVPANIC_COMMON
>       bool
>   
> +config PVPANIC_PCI
> +    bool
> +    default y if PCI_DEVICES
> +    depends on PCI
> +    select PVPANIC_COMMON
> +
>   config PVPANIC_ISA
>       bool
>       depends on ISA_BUS
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index edaaec2..6292839 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -100,6 +100,7 @@ softmmu_ss.add(when: 'CONFIG_ARMSSE_CPUID', if_true: files('armsse-cpuid.c'))
>   softmmu_ss.add(when: 'CONFIG_ARMSSE_MHU', if_true: files('armsse-mhu.c'))
>   
>   softmmu_ss.add(when: 'CONFIG_PVPANIC_ISA', if_true: files('pvpanic-isa.c'))
> +softmmu_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
>   softmmu_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
>   softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_scu.c', 'aspeed_sdmc.c', 'aspeed_xdma.c'))
>   softmmu_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-sysreg.c'))
> diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
> new file mode 100644
> index 0000000..d629639
> --- /dev/null
> +++ b/hw/misc/pvpanic-pci.c
> @@ -0,0 +1,94 @@
> +/*
> + * QEMU simulated PCI pvpanic device.
> + *
> + * Copyright (C) 2020 Oracle
> + *
> + * Authors:
> + *     Mihai Carabas <mihai.carabas@oracle.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "sysemu/runstate.h"
> +
> +#include "hw/nvram/fw_cfg.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/pvpanic.h"
> +#include "qom/object.h"
> +#include "hw/pci/pci.h"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(PVPanicPCIState, PVPANIC_PCI_DEVICE)
> +
> +/*
> + * PVPanicPCIState for PCI device
> + */
> +typedef struct PVPanicPCIState {
> +    PCIDevice dev;
> +    PVPanicState pvpanic;
> +} PVPanicPCIState;
> +
> +static const VMStateDescription vmstate_pvpanic_pci = {
> +    .name = "pvpanic-pci",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(dev, PVPanicPCIState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
> +{
> +    PVPanicPCIState *s = PVPANIC_PCI_DEVICE(dev);
> +    PVPanicState *ps = &s->pvpanic;
> +
> +    pvpanic_setup_io(&s->pvpanic, DEVICE(s), 2);

Why registering 2-bytes of I/O when the underlying device is 1-byte
wide? Is this to allow 16-bit I/O instructions?

> +
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &ps->mr);
> +}
> +
> +static Property pvpanic_pci_properties[] = {
> +    DEFINE_PROP_UINT8("events", PVPanicPCIState, pvpanic.events, PVPANIC_PANICKED | PVPANIC_CRASHLOADED),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pvpanic_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, pvpanic_pci_properties);
> +
> +    pc->realize = pvpanic_pci_realizefn;
> +    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
> +    pc->device_id = PCI_DEVICE_ID_REDHAT_PVPANIC;
> +    pc->revision = 1;
> +    pc->class_id = PCI_CLASS_SYSTEM_OTHER;
> +    dc->vmsd = &vmstate_pvpanic_pci;
> +
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static TypeInfo pvpanic_pci_info = {
> +    .name          = TYPE_PVPANIC_PCI_DEVICE,
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(PVPanicPCIState),
> +    .class_init    = pvpanic_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    }
> +};
> +
> +static void pvpanic_register_types(void)
> +{
> +    type_register_static(&pvpanic_pci_info);
> +}
> +
> +type_init(pvpanic_register_types);
> diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
> index abc9dde..ca3c5bb 100644
> --- a/include/hw/misc/pvpanic.h
> +++ b/include/hw/misc/pvpanic.h
> @@ -18,6 +18,7 @@
>   #include "qom/object.h"
>   
>   #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
> +#define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
>   
>   #define PVPANIC_IOPORT_PROP "ioport"
>   
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 259f9c9..66db084 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -107,6 +107,7 @@ extern bool pci_available;
>   #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
>   #define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
>   #define PCI_DEVICE_ID_REDHAT_NVME        0x0010
> +#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
>   #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
>   
>   #define FMT_PCIBUS                      PRIx64


