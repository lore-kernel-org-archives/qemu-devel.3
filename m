Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D50D29FED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 11:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfyiz-0004R0-1r; Wed, 14 Jan 2026 06:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfyir-0004Qe-67
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:07:33 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfyio-0001s2-Je
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:07:32 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8b31a665ba5so1039894285a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 03:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768388848; x=1768993648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dgZQq00nF77FQTRpTqVnwFGW+ekeVIrkNrtU47louAY=;
 b=gyHDYiER5nxlW3FeH7LF/WyksTPAW5BaJowHzlJHQXCQ41gA4gZ/o60HehYlylHwtM
 yGfduyNbLXX/Vfo/Ilo+ybzOY9ZqQ45FaZh5csF0Jhz8gH5xLLmwHRdGa6prZ3OAToqi
 aR2mtRDEmaQbgCfxqTnmoL0r8KErrUx0YX0kYmq3cuAHXH1jjKUjARS7NMEw1CzOb6J/
 f5QQqkfrY20WeRV4xynroWhl0J/UMhx3TgVuWPyUwQQyqLKwYX7WAOtK582OZes3JcAC
 V0D8MOHy+dKj4HzdEj66lM/Uq6DP0KTFryU+AO6PL2ckA69TRTAnQQXvtwFFjqraQijv
 SpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768388848; x=1768993648;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dgZQq00nF77FQTRpTqVnwFGW+ekeVIrkNrtU47louAY=;
 b=RVprJ0xxT5pSdn5+oRWLdaLKrzdHccsJ+sALWvTmg/opyuaYsrn/DjBoiWRrsmgI4g
 cg5UFcrqRmsiYOV16e1AfiPt5ooWYGUiCUY/TJvqNJjOjWYywyDqpyra8uqngdRtq/6e
 nPSQrK+dwZNb9Xnxs0uSEcaFRmtMJmXLUGs03E0YKKYKETerVAwmfHnZK9L5+JRdWrBb
 gobpWw0oelH69WkrV1/AZU8MaY4Z3DKUO2NDo2HfxInaAM9wyXPTKJnazJj4MIQY8Vpf
 Yxcxyvp/5fm6VqKkG7400WX1OTZW4GB/bhDelKrmK2vmcxyfcxQqCGxM220bQAjcl7Aj
 V7AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOTsvA2oO2XnOXKPkeMfreWkpCj207GEDytxy8geadNuLRFcSTnUac2lcO4g0pBpCUiVyEXj302D77@nongnu.org
X-Gm-Message-State: AOJu0YxvfjEAdu6E8kCftrIpPTJFF+T2CDVJdTAmwyUQ/RM4TKrZldpl
 7mg3OCocGlsiildTqpQYRo7lGzxgUyndVdJhBL2F+xfxbKlkUEiWY54jTo0rJJ0cLkk=
X-Gm-Gg: AY/fxX6EV6uk6r/Zxwyp5QfnB5oWJ3GdOMRvZ2D7ETWPrIS6FU1lkW81qW62N6hhLRQ
 gVyOgaEXDQLN1RnEeq45OtglkunrexjWRUuHspfAwNEBdI4NrJjDzR/qEjZRk7PMLu4PLed1BYI
 SeAnp98/aBKufU9i3yjhMIL8AvTXz/4dWaY6GGjrB+kRIXkMBHPuUfqH9NHE+Z7a7Hmi8n2eGSf
 NKuro1+Yk9NpnkkH1/FkkQudTyO5OE/DebqA99+UP9b7YKd6AIeXjwL1NiimjnVi3US4J+JP3Q6
 YeUWW7M1WNgL0rp/XZIuixDc4VGXgxbonce5QwI9dGs1MNw03Kr4iM/3rx7QD6IIUMnHJd6Z5be
 /7kcbojHnHQLN2rK+Td8sm1gT6PBSdv62mH7Q3TYDGToHdpWB+nVmIASMnrmzrNCf30ZDsmOL7z
 Gudj4VYb3zuExSGCAKFF50h1IkpFfUlfpN7qUoza65
X-Received: by 2002:a05:620a:1a03:b0:8c2:9ff4:a8bd with SMTP id
 af79cd13be357-8c52fb2366emr292755685a.15.1768388847827; 
 Wed, 14 Jan 2026 03:07:27 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c530b777c0sm140054485a.33.2026.01.14.03.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 03:07:26 -0800 (PST)
Message-ID: <8fbf8a40-4fa0-4152-8d90-1f24d8f364b4@ventanamicro.com>
Date: Wed, 14 Jan 2026 08:07:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv/aia: Provide number of irq sources
To: Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair.francis@wdc.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
References: <20260114012846.981884-1-joel@jms.id.au>
 <20260114012846.981884-3-joel@jms.id.au>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260114012846.981884-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x731.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/13/2026 10:28 PM, Joel Stanley wrote:
> Instead of hard coding the number of IRQ sources used by the APLIC pass
> it in as a parameter. This allows other machines to configure this as
> required.
> 
> The maximum number of sources is 1023.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


> v2: Add assert for the number of irq sources
> ---
>   hw/riscv/aia.h             |  1 +
>   include/hw/riscv/virt.h    |  1 +
>   hw/riscv/aia.c             |  8 ++++++--
>   hw/riscv/virt-acpi-build.c | 25 ++++++++++++++++---------
>   hw/riscv/virt.c            |  2 ++
>   5 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index 50c48ea4d79c..a63a1ab293fe 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -48,6 +48,7 @@
>   uint32_t imsic_num_bits(uint32_t count);
>   
>   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             uint16_t num_sources,
>                                const MemMapEntry *aplic_m,
>                                const MemMapEntry *aplic_s,
>                                const MemMapEntry *imsic_m,
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 25ec5c665780..fa7fe8d4f648 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -64,6 +64,7 @@ struct RISCVVirtState {
>       struct GPEXHost *gpex_host;
>       OnOffAuto iommu_sys;
>       uint16_t pci_iommu_bdf;
> +    uint16_t num_sources;
>   };
>   
>   enum {
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index 0a89d7b49b7b..a9130896fba2 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
>   }
>   
>   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             uint16_t num_sources,
>                                const MemMapEntry *aplic_m,
>                                const MemMapEntry *aplic_s,
>                                const MemMapEntry *imsic_m,
> @@ -37,6 +38,9 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>       DeviceState *aplic_s_dev = NULL;
>       DeviceState *aplic_m_dev = NULL;
>   
> +    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
> +    g_assert(num_sources <= 1023);
> +
>       if (msimode) {
>           if (!kvm_enabled()) {
>               /* Per-socket M-level IMSICs */
> @@ -65,7 +69,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>                                        aplic_m->size,
>                                        (msimode) ? 0 : base_hartid,
>                                        (msimode) ? 0 : hart_count,
> -                                     VIRT_IRQCHIP_NUM_SOURCES,
> +                                     num_sources,
>                                        VIRT_IRQCHIP_NUM_PRIO_BITS,
>                                        msimode, true, NULL);
>       }
> @@ -76,7 +80,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>                                    aplic_s->size,
>                                    (msimode) ? 0 : base_hartid,
>                                    (msimode) ? 0 : hart_count,
> -                                 VIRT_IRQCHIP_NUM_SOURCES,
> +                                 num_sources,
>                                    VIRT_IRQCHIP_NUM_PRIO_BITS,
>                                    msimode, false, aplic_m_dev);
>   
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index b091a9df9e0f..350912903174 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -144,6 +144,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
>   }
>   
>   static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
> +                                     uint16_t num_sources,
>                                        uint64_t mmio_base, uint64_t mmio_size,
>                                        const char *hid)
>   {
> @@ -151,9 +152,12 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
>       uint32_t gsi_base;
>       uint8_t  socket;
>   
> +    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
> +    g_assert(num_sources <= 1023);
> +
>       for (socket = 0; socket < socket_count; socket++) {
>           plic_aplic_addr = mmio_base + mmio_size * socket;
> -        gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +        gsi_base = num_sources * socket;
>           Aml *dev = aml_device("IC%.02X", socket);
>           aml_append(dev, aml_name_decl("_HID", aml_string("%s", hid)));
>           aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> @@ -469,10 +473,13 @@ static void build_dsdt(GArray *table_data,
>       socket_count = riscv_socket_count(ms);
>   
>       if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> -        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_PLIC].base,
> -                                 memmap[VIRT_PLIC].size, "RSCV0001");
> +        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
> +                                 memmap[VIRT_PLIC].base,
> +                                 memmap[VIRT_PLIC].size,
> +                                 "RSCV0001");
>       } else {
> -        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_APLIC_S].base,
> +        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
> +                                 memmap[VIRT_APLIC_S].base,
>                                    memmap[VIRT_APLIC_S].size, "RSCV0002");
>       }
>   
> @@ -489,15 +496,15 @@ static void build_dsdt(GArray *table_data,
>       } else if (socket_count == 2) {
>           virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                                memmap[VIRT_VIRTIO].size,
> -                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
> +                             VIRTIO_IRQ + s->num_sources, 0,
>                                VIRTIO_COUNT);
> -        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES);
> +        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources);
>       } else {
>           virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                                memmap[VIRT_VIRTIO].size,
> -                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
> +                             VIRTIO_IRQ + s->num_sources, 0,
>                                VIRTIO_COUNT);
> -        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
> +        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources * 2);
>       }
>   
>       aml_append(dsdt, scope);
> @@ -576,7 +583,7 @@ static void build_madt(GArray *table_data,
>           for (socket = 0; socket < riscv_socket_count(ms); socket++) {
>               aplic_addr = s->memmap[VIRT_APLIC_S].base +
>                                s->memmap[VIRT_APLIC_S].size * socket;
> -            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            gsi_base = s->num_sources * socket;
>               build_append_int_noprefix(table_data, 0x1A, 1);    /* Type */
>               build_append_int_noprefix(table_data, 36, 1);      /* Length */
>               build_append_int_noprefix(table_data, 1, 1);       /* Version */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 01115a0fb946..e5df5a5d4638 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1556,6 +1556,7 @@ static void virt_machine_init(MachineState *machine)
>           } else {
>               s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
>                                                s->aia_guests,
> +                                             s->num_sources,
>                                                &s->memmap[VIRT_APLIC_M],
>                                                &s->memmap[VIRT_APLIC_S],
>                                                &s->memmap[VIRT_IMSIC_M],
> @@ -1690,6 +1691,7 @@ static void virt_machine_instance_init(Object *obj)
>       s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
>       s->acpi = ON_OFF_AUTO_AUTO;
>       s->iommu_sys = ON_OFF_AUTO_AUTO;
> +    s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
>   }
>   
>   static char *virt_get_aia_guests(Object *obj, Error **errp)


