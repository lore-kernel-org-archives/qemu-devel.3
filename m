Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D544C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftzv-0005Qq-Ra; Mon, 19 Aug 2024 00:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftvm-00020X-Ea
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:23:48 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftvg-0004Xp-JN
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:23:45 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7a1be7b7bb5so2736270a12.0
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724041419; x=1724646219; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0EVO4TPq7zEeDhrpfxb/u7bFPuWUTGTEzv2yfJHA6xk=;
 b=Gsmm9DSZpqmQMhaplexTOSp3hGTOkav8J6sCHxlA6+jPcPTa8int5juisK3kzZal0J
 IFcF6IITlmvyqE+aIjIcwhpDFfDOaWoLdVzpRUaVM3+HaVYMY7pyX0in80kmvEYQXwS0
 H3QWao10ILtdUL2jDywIqvzN1Bi9gvL32wqang9YxpjM64TjfkXWS2YYI+lY5g05Pzgl
 zXM6FrXx3dOT2i+q98rWDa0OTd4p9b4bApZjVHvlaABh3OSpcf6AyhViMsJcuKwFmQNN
 JiERVt5DqzsRx1Wurn6XeR2s+r0OmvAhqT4QkL3k8NLJ169YzTf/Fqv2FQMJitG/VOc+
 YmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724041419; x=1724646219;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0EVO4TPq7zEeDhrpfxb/u7bFPuWUTGTEzv2yfJHA6xk=;
 b=JM8cWmaGsyj0h6L1T0c5BS255w2mL3kc4Z4Zt4smgSvv436fQkrt6npbMxOWrnkthb
 9AYNhPiaoDyLezyGLrP4MWZOMKqUAjZq99fcAl+cEunC3WtQg84nmenYpo4GChKeTGvb
 FjZaXrl0pAkgowNsbYvMZ+13NQDckNCgVhq6pk0yTTiV7yDTzXUNE5Vm+DmfGIN2YQ0Y
 4vPzz147T13JQuH6Z04axGeVbJ3YP3tmOGb6sPAAWnSBafQ0ry8wsvECqgwALZ5Csiq+
 yRgydxqmQk59F+ii9Vix/WanMmyEhsDCyfayVeglEhlODio7qqjmOlUs2slbtY8+tesr
 koxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0QwUCJsrP6mf8SgC8a3RzhcJvCHGczD8LIbbhRWQ+zvNxVm1F6ZoaDZWFr8No7H0U0vrP7Gjev6nozUhxeyWvceOBgDY=
X-Gm-Message-State: AOJu0Yz++a2LCR2ziISpLs5giJmBBlx3QmOytljuUeaXQQoHglJnoKaT
 vun1rYtNfTdxN0xt7S7xR/KjCpMgHF0ZhbaRqmYQrK0UQWp6OTOdwuAio3tKUI8=
X-Google-Smtp-Source: AGHT+IHeXBPBl2nz3ey//IV8NOtCWsyLIU0+2yFfF95IdWYcc3PzNX2iq1/EEBnXDA/NAXk5pPWdwQ==
X-Received: by 2002:a05:6a20:43a8:b0:1c4:a531:bafd with SMTP id
 adf61e73a8af0-1c904fab22bmr13890308637.18.1724041418718; 
 Sun, 18 Aug 2024 21:23:38 -0700 (PDT)
Received: from [192.168.0.103] ([191.205.40.123])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e3d9ab28sm6217384a91.55.2024.08.18.21.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 21:23:38 -0700 (PDT)
Subject: Re: [PATCH 7/8] hw/pci-host/designware: Move MSI registers from root
 func to host bridge
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
 <20231012121857.31873-8-philmd@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <f9fa0215-006b-5dd1-b634-13e1a2b4448f@linaro.org>
Date: Mon, 19 Aug 2024 01:23:35 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20231012121857.31873-8-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.588,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Hi Phil

On 10/12/23 9:18 AM, Philippe Mathieu-Daudé wrote:
> The MSI registers belong the the host bridge. Move the
> DesignwarePCIEMSI field to the host bridge state.

I would say MSI registers are more tied to the PCI/PCIe network
side than to the host side. The MSI registers control if an
interrupt will be delivered to a host by looking at MSI data
payload to determine which end point sent the MSI packet and
which interrupt vector it corresponds to.

Why do you say the belong to the host bridge?

In 0/8 you mentioned you "noticed few discrepancies due to the
fact that host bridge pieces were managed by the root function",
is this patch addressing some of these discrepancies? What are
them exactly?

This patch also needs a rebase onto master.


Cheers,
Gustavo


> This is a migration compatibility break for the machines
> using the i.MX7 SoC (currently the mcimx7d-sabre machine).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/pci-host/designware.h |  2 +-
>   hw/pci-host/designware.c         | 79 ++++++++++++++++----------------
>   2 files changed, 40 insertions(+), 41 deletions(-)
> 
> diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
> index 702777ab17..fe8e8a9f24 100644
> --- a/include/hw/pci-host/designware.h
> +++ b/include/hw/pci-host/designware.h
> @@ -63,7 +63,6 @@ typedef struct DesignwarePCIEMSI {
>   struct DesignwarePCIERoot {
>       PCIBridge parent_obj;
>   
> -    DesignwarePCIEMSI msi;
>       DesignwarePCIEHost *host;
>   };
>   
> @@ -71,6 +70,7 @@ struct DesignwarePCIEHost {
>       PCIHostState parent_obj;
>   
>       DesignwarePCIERoot root;
> +    DesignwarePCIEMSI msi;
>   
>       uint32_t atu_viewport;
>   #define DESIGNWARE_PCIE_VIEWPORT_OUTBOUND    0
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 2ef17137e2..6cb8655a75 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -57,7 +57,7 @@
>   
>   #define DESIGNWARE_PCIE_IRQ_MSI                    3
>   
> -static uint64_t designware_pcie_root_msi_read(void *opaque, hwaddr addr,
> +static uint64_t designware_pcie_host_msi_read(void *opaque, hwaddr addr,
>                                                 unsigned size)
>   {
>       /*
> @@ -74,22 +74,21 @@ static uint64_t designware_pcie_root_msi_read(void *opaque, hwaddr addr,
>       return 0;
>   }
>   
> -static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
> +static void designware_pcie_host_msi_write(void *opaque, hwaddr addr,
>                                              uint64_t val, unsigned len)
>   {
> -    DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(opaque);
> -    DesignwarePCIEHost *host = root->host;
> +    DesignwarePCIEHost *host = opaque;
>   
> -    root->msi.intr[0].status |= BIT(val) & root->msi.intr[0].enable;
> +    host->msi.intr[0].status |= BIT(val) & host->msi.intr[0].enable;
>   
> -    if (root->msi.intr[0].status & ~root->msi.intr[0].mask) {
> +    if (host->msi.intr[0].status & ~host->msi.intr[0].mask) {
>           qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 1);
>       }
>   }
>   
>   static const MemoryRegionOps designware_pci_host_msi_ops = {
> -    .read = designware_pcie_root_msi_read,
> -    .write = designware_pcie_root_msi_write,
> +    .read = designware_pcie_host_msi_read,
> +    .write = designware_pcie_host_msi_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid = {
>           .min_access_size = 4,
> @@ -97,12 +96,12 @@ static const MemoryRegionOps designware_pci_host_msi_ops = {
>       },
>   };
>   
> -static void designware_pcie_root_update_msi_mapping(DesignwarePCIERoot *root)
> +static void designware_pcie_host_update_msi_mapping(DesignwarePCIEHost *host)
>   
>   {
> -    MemoryRegion *mem   = &root->msi.iomem;
> -    const uint64_t base = root->msi.base;
> -    const bool enable   = root->msi.intr[0].enable;
> +    MemoryRegion *mem   = &host->msi.iomem;
> +    const uint64_t base = host->msi.base;
> +    const bool enable   = host->msi.intr[0].enable;
>   
>       memory_region_set_address(mem, base);
>       memory_region_set_enabled(mem, enable);
> @@ -147,23 +146,23 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_ADDR_LO:
> -        val = root->msi.base;
> +        val = host->msi.base;
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_ADDR_HI:
> -        val = root->msi.base >> 32;
> +        val = host->msi.base >> 32;
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_INTR0_ENABLE:
> -        val = root->msi.intr[0].enable;
> +        val = host->msi.intr[0].enable;
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_INTR0_MASK:
> -        val = root->msi.intr[0].mask;
> +        val = host->msi.intr[0].mask;
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_INTR0_STATUS:
> -        val = root->msi.intr[0].status;
> +        val = host->msi.intr[0].status;
>           break;
>   
>       case DESIGNWARE_PCIE_PHY_DEBUG_R1:
> @@ -305,29 +304,29 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_ADDR_LO:
> -        root->msi.base &= 0xFFFFFFFF00000000ULL;
> -        root->msi.base |= val;
> -        designware_pcie_root_update_msi_mapping(root);
> +        host->msi.base &= 0xFFFFFFFF00000000ULL;
> +        host->msi.base |= val;
> +        designware_pcie_host_update_msi_mapping(host);
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_ADDR_HI:
> -        root->msi.base &= 0x00000000FFFFFFFFULL;
> -        root->msi.base |= (uint64_t)val << 32;
> -        designware_pcie_root_update_msi_mapping(root);
> +        host->msi.base &= 0x00000000FFFFFFFFULL;
> +        host->msi.base |= (uint64_t)val << 32;
> +        designware_pcie_host_update_msi_mapping(host);
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_INTR0_ENABLE:
> -        root->msi.intr[0].enable = val;
> -        designware_pcie_root_update_msi_mapping(root);
> +        host->msi.intr[0].enable = val;
> +        designware_pcie_host_update_msi_mapping(host);
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_INTR0_MASK:
> -        root->msi.intr[0].mask = val;
> +        host->msi.intr[0].mask = val;
>           break;
>   
>       case DESIGNWARE_PCIE_MSI_INTR0_STATUS:
> -        root->msi.intr[0].status ^= val;
> -        if (!root->msi.intr[0].status) {
> +        host->msi.intr[0].status ^= val;
> +        if (!host->msi.intr[0].status) {
>               qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 0);
>           }
>           break;
> @@ -495,7 +494,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>       viewport->cr[1] = DESIGNWARE_PCIE_ATU_ENABLE;
>       designware_pcie_update_viewport(root, viewport);
>   
> -    memory_region_init_io(&root->msi.iomem, OBJECT(root),
> +    memory_region_init_io(&host->msi.iomem, OBJECT(root),
>                             &designware_pci_host_msi_ops,
>                             root, "pcie-msi", 0x4);
>       /*
> @@ -504,8 +503,8 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>        * in designware_pcie_root_update_msi_mapping() as a part of
>        * initialization done by guest OS
>        */
> -    memory_region_add_subregion(address_space, dummy_offset, &root->msi.iomem);
> -    memory_region_set_enabled(&root->msi.iomem, false);
> +    memory_region_add_subregion(address_space, dummy_offset, &host->msi.iomem);
> +    memory_region_set_enabled(&host->msi.iomem, false);
>   }
>   
>   static void designware_pcie_set_irq(void *opaque, int irq_num, int level)
> @@ -564,15 +563,10 @@ static const VMStateDescription vmstate_designware_pcie_viewport = {
>   
>   static const VMStateDescription vmstate_designware_pcie_root = {
>       .name = "designware-pcie-root",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>       .fields = (VMStateField[]) {
>           VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
> -        VMSTATE_STRUCT(msi,
> -                       DesignwarePCIERoot,
> -                       1,
> -                       vmstate_designware_pcie_msi,
> -                       DesignwarePCIEMSI),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> @@ -704,8 +698,8 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
>   
>   static const VMStateDescription vmstate_designware_pcie_host = {
>       .name = "designware-pcie-host",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>       .fields = (VMStateField[]) {
>           VMSTATE_STRUCT(root,
>                          DesignwarePCIEHost,
> @@ -720,6 +714,11 @@ static const VMStateDescription vmstate_designware_pcie_host = {
>                                  1,
>                                  vmstate_designware_pcie_viewport,
>                                  DesignwarePCIEViewport),
> +        VMSTATE_STRUCT(msi,
> +                       DesignwarePCIEHost,
> +                       1,
> +                       vmstate_designware_pcie_msi,
> +                       DesignwarePCIEMSI),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> 

