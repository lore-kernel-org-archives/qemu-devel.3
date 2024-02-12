Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FAEC48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRH5-0006zR-Sl; Mon, 12 Feb 2024 03:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZRH3-0006yh-Fj
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:02:45 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZRGu-0007E7-4u
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:02:40 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a38271c0bd5so347443266b.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707724953; x=1708329753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNzoWBqbHrfV1/juV/XuYyT0u+K3FHNc+hHCRkBGNO0=;
 b=XdndjJue0e5Vag8rdGNS2PDCNVV9Audozjmks/zRIciO7fua1DV9Ekw4jW9ffzO906
 PjRpGh1NXje0vccpFo8PJX+OZsfwSoDLGQkYNf6/6ew0PTWo99LoYX4dF70GFl01i6b1
 XUHlLxSxPqCo4hBErgePKU4el6T2+vRm0nA5BurxsK4JmwtSwlqFI9N+/jsUm9D+8O02
 D4riJa+BURwNa9WaNgoCGgtyofjr8KmUGQYH/R98kmnRQcBQ9ZgvbpyPxFvX6ugR9d25
 5wAisvfWkpyjlgUeAT/rNmUFlLbiCfE4CpoRfftf28IAu38AsrRnsLmRqfytJDymHHIA
 qVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707724953; x=1708329753;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNzoWBqbHrfV1/juV/XuYyT0u+K3FHNc+hHCRkBGNO0=;
 b=n6vIM8E7txCdHYl2zsr22/HXDZuBxszlRGDqUCFxiT0qRGNpSspcB4wVjOKhByWym1
 4F+ZcGCei5Wy/bCvClqBPjZDh4VM+58GC6w8VMvS3DJI1Gjkz4BrxJI6jqS7RWcxwrog
 AzbpBwW7vvicAed1SrPvdZ6PFANTcTDmmiK40nx8D6LzmFgBjkO3I8UQugXGrCDqvzfj
 LfR34SxHz2Ql+FjYs9ufHc02oWl5ztE5ZCsTsu73egEm9+C6wQNzpTNak4YTLpJGNGfZ
 w4cBJch+6TwSpVmBWCFYot9TfKTMhJV8J/tAN2MoqQatkh6KzA3hlWWZuRrImRwgAIf3
 a2gw==
X-Gm-Message-State: AOJu0YyWKRPt2f/2uS6rJ+H9i81HEyawRjlAFz6ZF1zhHyJ8s73+Qj2x
 bAWRGuKSqug748xhKnrex1TWiSuhcrE8vDhKdnju7BkW46DSubQmwWgVPEopMY0=
X-Google-Smtp-Source: AGHT+IHnL5XuXuKonchzCHj8a8kmwMQwqd/Qoz2YtDHiIlNgVzn/h6YJz74vvTao+Ov2WsBzCkMXNQ==
X-Received: by 2002:a17:906:4a05:b0:a3c:bb0e:f76f with SMTP id
 w5-20020a1709064a0500b00a3cbb0ef76fmr617460eju.67.1707724953272; 
 Mon, 12 Feb 2024 00:02:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVUyW3Met7JyxZU9gwOiXit/9yhYcTvaKX8ABZRaD87EVXPcPG+jPKNKQH3fMoXTw2ChgVGKr+PbuJmY/mdx2g6ZsAEIOrH56v2m8Tx+1irTQs0JEMx9QQ29pqcVLw//Ge3OOA/Ioams1LHHQW/MX3mUlLEi3EzG8DwZ6TBJhySW4uT9Sn4Ca1PAwAG3xVpGl+n7nVw31HfT0fP7ynjfXEj0c42/4W61BUJ8egPhwwPhgvtRDR9u+WoCxddsbOnflch/Afh/L38Cbchz7w77ieaPmpCthe+l/o/4X/2E0IEFGRza/90qvswkDJnNL/7T+UyjwdtS6bDghXR5mIjZ7e+4J+HG2FHhDeqUdEJnz/LXy0jHSrfjSzwBKOYSjTqBjEhmMJ2AxuygrKYdW2FP1gVEhaG
Received: from [192.168.69.100] (vau06-h02-176-184-43-97.dsl.sta.abo.bbox.fr.
 [176.184.43.97]) by smtp.gmail.com with ESMTPSA id
 ha25-20020a170906a89900b00a379ef08ecbsm3600742ejb.74.2024.02.12.00.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 00:02:32 -0800 (PST)
Message-ID: <804187f0-fc82-4b90-8afd-31b9ebf2dd05@linaro.org>
Date: Mon, 12 Feb 2024 09:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/pci: Determine if rombar is explicitly enabled
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
 <20240210-reuse-v2-1-24ba2a502692@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240210-reuse-v2-1-24ba2a502692@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Akihiko,

On 10/2/24 11:24, Akihiko Odaki wrote:
> vfio determines if rombar is explicitly enabled by inspecting QDict.
> Inspecting QDict is not nice because QDict is untyped and depends on the
> details on the external interface. Add an infrastructure to determine if
> rombar is explicitly enabled to hw/pci. PCIDevice::rom_bar is changed to
> have -1 by the default to tell rombar is explicitly enabled. It is
> consistent with other properties like addr and romsize.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/hw/pci/pci_device.h | 5 +++++
>   hw/pci/pci.c                | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index d3dd0f64b273..54fa0676abf1 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
>       return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
>   }
>   
> +static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
> +{
> +    return dev->rom_bar && dev->rom_bar != -1;

Or     return dev->rom_bar >= 0;

> +}
> +
>   uint16_t pci_requester_id(PCIDevice *dev);
>   
>   /* DMA access functions */
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 76080af580d7..d08548d8ffe9 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -71,7 +71,7 @@ static Property pci_props[] = {
>       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>       DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
>       DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, -1),
> -    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
> +    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, -1),

You are changing a default affecting many devices. Please
document in the commit description it is safe because there
are few uses and you audited them:

$ git grep -w rom_bar
hw/display/qxl.c:328:    QXLRom *rom = 
memory_region_get_ram_ptr(&d->rom_bar);
hw/display/qxl.c:431:    qxl_set_dirty(&qxl->rom_bar, 0, qxl->rom_size);
hw/display/qxl.c:1048:    QXLRom *rom = 
memory_region_get_ram_ptr(&qxl->rom_bar);
hw/display/qxl.c:2131:    memory_region_init_rom(&qxl->rom_bar, 
OBJECT(qxl), "qxl.vrom",
hw/display/qxl.c:2154: 
PCI_BASE_ADDRESS_SPACE_MEMORY, &qxl->rom_bar);
hw/display/qxl.h:101:    MemoryRegion       rom_bar;
hw/pci/pci.c:74:    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
hw/pci/pci.c:2329:    if (!pdev->rom_bar) {
hw/vfio/pci.c:1019:    if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
hw/xen/xen_pt_load_rom.c:29:    if (dev->romfile || !dev->rom_bar) {
include/hw/pci/pci_device.h:150:    uint32_t rom_bar;

Alternatively split this patch in 2, first introduce
pci_rom_bar_explicitly_enabled() and use it, then change the default
value and adapt it.

Regards,

Phil.

