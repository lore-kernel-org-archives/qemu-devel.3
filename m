Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F535F327A0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF49A-0004aj-GN; Tue, 21 Apr 2026 01:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF493-0004ZI-U9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:59:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF491-00049V-SN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:59:37 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43eb012ac4fso2301054f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776751174; x=1777355974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mCdULCUioBAGp6XLEtSoigPFvwj9v5WScb98DUzMimI=;
 b=xco9YRDHVqtQt4p9Yr9IPDwsB+8/QHYJ3j45MHq2W8qMd0Z0AqujL7mBduoB4aHROK
 u5BHuDyJraKhwgyZQU5rCLqKVerJcuSaNhrbLzVwf88eLg+Fko5O3moggtCEBmSg68x9
 QVD4n1W+HRTSpjQ2kLrD0f+ps4X/OKzhDny2Pf2L3srbND7jyZplLh1jtm1ST8nnHKl2
 Gl38AvCMYDgyYF+NZCl4nu5bnTtB6z2PnDHcP740tBMCRHV1lVWEzXnlIVRCEvraba9b
 Cz3vLDLlo6Y4hpS+P9s7zF1yzAUvQeOrplHiTpBxJR5tOZDN4YYo/mVc811/OrTxZxlv
 ysEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776751174; x=1777355974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mCdULCUioBAGp6XLEtSoigPFvwj9v5WScb98DUzMimI=;
 b=DtWRkTYYBEwujFgFkR/IeHlqeg6zgwVo3HOcgnrQkbzN2JzckSHqpauBEJ9TfFAhfz
 UETkctnCw2qOAds59fhEVDNqE6ZlglqSuT0Y76v9BPZfGTTb0z8BJPh8BP5hjOM8iU0x
 RPNvKVWu9b1H2OqSJjngJwEjahB6bedmNIXDyk9tLW2kAag+9zS5pYiqi8C3o8g1PHfw
 KasbwAP+X5sYFz4KI2kFeE9vCHdqIq0PStdNwdFDi28ij50SKTerRzqJu0U0hSgjExoL
 Djj6GAvvI/57aELlyrdcL8M7s86Xp7kkKWP3AErJ9K4c+n6b7ASGxsdppWeWkn+hrYTX
 jJ6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0tiBvzyyP1QGMK887qzdKfklFa6pVfaZJbcUJITSzAGsM2yH0602RbdlbzrfwA5VsJzpWDn5zfJy6@nongnu.org
X-Gm-Message-State: AOJu0Yy2JMW6ymDybl4dI9Ao34EGgd1qjV01P5H/T1zCkxA/HO1Obo58
 +XcLcB+tL0Kkdc5G41pPeR+LvxYbAPdNFdQcMmSGkcg/ZIZrVfg+pPFQwljhEC55N6M=
X-Gm-Gg: AeBDiet/runwLGa+zSZoexuBvCDgNHS73dah5PvyTySlZZdwEhibw2/BoJhHd/rEPH5
 647GkZ5y3REaooHVf6LhbmdxshGk9VeBhH2iCNcRDl9bgm2XvOOgP4b8zQgJVG1uxnLBP6pzrNS
 uSTkY7f0pFPJ/OBgfPu0VquZwaW9B5JH+0fFReOjf3fkK4IAkmyymVdDvN3DunU65ldm4Qdaaek
 992SrR/FdbWyTBl2WeqtMkl+5l9z6uF+xNtbjeCDOTttvr74LAEuug+D5g+tI+5hV29etO+rAfx
 EpgWByRSRmlT63ods8iG5K70oifbTfZr93lxnLD+OpoVsdVVeLTawYieKr5KyKUy2Rk2yFNMKEP
 OriEtEIBihwPHQDfjYFPWX7+jRYxNTyZIJ6wKK0Pg6XJaq8qsH1CofWqoi+04ZMesFTAIeXc1ff
 rbS9AeYUfUH2uH09xVLdXpamZ97TBlwqh+z9KdVE3afzDuXAHa0ugGN0G5aUXoPj5Xx07gKTFCf
 C49
X-Received: by 2002:a05:6000:2013:b0:43d:c95c:4259 with SMTP id
 ffacd0b85a97d-43fe3e07216mr24538738f8f.30.1776751173883; 
 Mon, 20 Apr 2026 22:59:33 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a397sm37843585f8f.23.2026.04.20.22.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 22:59:33 -0700 (PDT)
Message-ID: <d133505a-8a81-458d-a0f0-8b17ff5c0eab@linaro.org>
Date: Tue, 21 Apr 2026 07:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] hw/riscv/atlantis: Add PCIe controller
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-11-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260421053140.752059-11-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 21/4/26 07:31, Joel Stanley wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> tt-atlantis is likely to use a generic ECAM compatible PCIe memory map,
> so gpex is not far off the OS programming model
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3: Avoid leaks in the dt string allocation
> ---
>   include/hw/riscv/tt_atlantis.h |   2 +
>   hw/riscv/tt_atlantis.c         | 225 ++++++++++++++++++++++++++++++++-
>   hw/riscv/Kconfig               |   2 +
>   3 files changed, 228 insertions(+), 1 deletion(-)


> +static void create_fdt_pcie(void *fdt,
> +                            const MemMapEntry *mem_ecam,
> +                            const MemMapEntry *mem_pio,
> +                            const MemMapEntry *mem_mmio32,
> +                            const MemMapEntry *mem_mmio64,
> +                            int legacy_irq,
> +                            uint32_t aplic_s_phandle,
> +                            uint32_t imsic_s_phandle)
> +{
> +    g_autofree char *name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
> +                                            mem_ecam->base);
> +
> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", FDT_PCI_ADDR_CELLS);
> +    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", FDT_PCI_INT_CELLS);
> +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0x2);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "pci-host-ecam-generic");
> +    qemu_fdt_setprop_string(fdt, name, "device_type", "pci");
> +    qemu_fdt_setprop_cells(fdt, name, "bus-range", 0,
> +                           mem_ecam->size / PCIE_MMCFG_SIZE_MIN - 1);
> +    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
> +    qemu_fdt_setprop_cell(fdt, name, "msi-parent", imsic_s_phandle);
> +
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +                                 2, mem_ecam->base,
> +                                 2, mem_ecam->size);
> +    if (!(mem_mmio32->base & 0xffffffffUL)) {
> +        /* XXX: this is a silly hack because it would collide with PIO */

Could you explain a bit more?

> +        error_report("mmio32 base must not be 0 mod 2^32");
> +        exit(1);
> +    }
> +    uint32_t flags = FDT_PCI_RANGE_MMIO_64BIT | FDT_PCI_RANGE_PREFETCHABLE;
> +    qemu_fdt_setprop_sized_cells(fdt, name, "ranges",
> +                                 1, FDT_PCI_RANGE_IOPORT,
> +                                 2, 0x0,
> +                                 2, mem_pio->base,
> +                                 2, mem_pio->size,
> +                                 1, FDT_PCI_RANGE_MMIO,
> +                                 2, (mem_mmio32->base & 0xffffffffUL),
> +                                 2, mem_mmio32->base,
> +                                 2, mem_mmio32->size,
> +                                 1, flags,
> +                                 2, mem_mmio64->base,
> +                                 2, mem_mmio64->base,
> +                                 2, mem_mmio64->size);
> +
> +    create_pcie_irq_map(fdt, name, legacy_irq, aplic_s_phandle);
> +}


> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 0601ae1a7494..2ddee591eb90 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -129,6 +129,8 @@ config TENSTORRENT
>       select DEVICE_TREE
>       select RISCV_NUMA
>       select PVPANIC_MMIO
> +    select PCI

Do not select PCI explicitly, let the bridge (below) do it.
Rationale is this machine does not expose a PCI bus directly,
the bridge device does.

> +    select PCI_EXPRESS_GENERIC_BRIDGE
>       select SERIAL_MM
>       select RISCV_ACLINT
>       select RISCV_APLIC


