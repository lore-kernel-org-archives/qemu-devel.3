Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD872F327CA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF77y-0002Wr-Cg; Tue, 21 Apr 2026 05:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wF77w-0002VP-ER
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:10:40 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wF77u-0001Ey-Oj
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 05:10:40 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso1526222a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776762637; x=1777367437; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y8HCy1+43sqNSEsPud3XbFDkwmsOfFjsfO/1SzVk3qo=;
 b=UoULwgSitCruXSpjfhWtrdiuTu4XRkhXw/mWA09X4sPnyT5csQZ6xEr9nYyFtEu0gS
 pzPl1Brs29wwXEKyhFJz9TWtaDQlvwaAw312r1BHgb9vApAMPCfV/QKdjMGspV1BmZbB
 gSGWznO6iypfYYzMaJnYRgWlGQTt0MkTnVoGscHn39Ba5B0vMObGCstA1XpYlPLoz8v/
 8Uja5eEcGjqduDMhmyQWH05Umhai670xviWi1iPecTyYIfKf8/+f7KkVE2z1ZNR2B8vB
 XApyyNG5AlRJvn4sEdtK+yk5Cr0OZZi4/v7ZfDKtUBj0jAo9VInL8e5hSDirQtzXvhTS
 yzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776762637; x=1777367437;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8HCy1+43sqNSEsPud3XbFDkwmsOfFjsfO/1SzVk3qo=;
 b=RsEgtp0cqo0Zn2mKRtIsQ3xTNhu+nGeUwWinnwnAqUNTWF2AqbCeTUZOfzxfyVD7xq
 tNgRzdg7IY1JxgM8M9kjMGNIK/HiMQHlW9Yd+SQel3NM7RsM+qvOdtKbm8E1gl00hOLL
 hA2BPnxq0pd5G5L18LEhhB748/duOWHyb5wKEUkRqGNrbin67h+8i6OR+Q5zo+0G2DYV
 L3d/DgHdnVvpxbAW+k8apr0oHx84Fx2Fh6t1pV0kfQiJ71Edx9KQjuzffIsR6H8SCdBJ
 Wbtcm716Q09uiCijXF+ZSQMwp6ls2lhn0yNsdisSMnxM5ymZkAsJo1FvqF/4ZhoMFbwo
 3/8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Zd5EHMomO4t7qG4QhP3EZ5h/1lCyonCkr2cDy3uxL2xY8/lMQTGJ/LADCDeN9b/cCcDcRDzRPjXpn@nongnu.org
X-Gm-Message-State: AOJu0YzyVSBr669VlXyHkDeqAiZyVpqYx+PoegUI2IZo7bLI2PCBGSk7
 bHA1zWVAns1zyo9f/wwf34r01zYw/1wMGhRECFRi140ldUhjf5S+HBTX
X-Gm-Gg: AeBDiesbnfZrr3vDf6zu22WALKmGCoPamXvmgbxcjpAcyjBw6K0hbppi7lZrq3dZ/pt
 yj5+mDdpdJOFm6ztETcDWX/GEBtmq4ngpYhCvBL4Aq0UKpssCDoG/dQgdj3NSozNZXufjhK3wZe
 WWOIT54aqs9BM/u1FE10CaEYWwmiD7AdcB5Oqen2+9cozIqm6CQ7Si63Adh9RIk/pSLQki4f7Uq
 JBjTvc5bmiZ3WGR8pZM19Nwmq5Cm01NltvLenyiyFHj+3CeIB02Zfj+x/FwfAOJHxbwJpMiMdtH
 Cl0S54NPqFfW2hyUmMb1dJNcpvNAixDv0EEQ0sCmu+62VQvudqtWvtYr2h47TYCj5i+2THQTMPF
 7+z6T5Mq6Ut1eG1LknE/oMjRyBPzg4W3/hJ8t7T66rLA6ibW0wXTKKCHCZ9n61tAXu/VuFyQKou
 NX8b3D1UrqtsPZlvE8hVG51gePEVuPIB7OKOKnv2X06uZ58XatIvQeDGy48RsXf87lZWY5ZnPlv
 Q==
X-Received: by 2002:a05:6a00:22c5:b0:82c:e670:7691 with SMTP id
 d2e1a72fcca58-82f8c9300ebmr18200427b3a.48.1776762636808; 
 Tue, 21 Apr 2026 02:10:36 -0700 (PDT)
Received: from localhost (203-214-45-63.dyn.iinet.net.au. [203.214.45.63])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e985a72sm13908824b3a.11.2026.04.21.02.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 02:10:35 -0700 (PDT)
Date: Tue, 21 Apr 2026 19:10:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 10/13] hw/riscv/atlantis: Add PCIe controller
Message-ID: <aeceurHJHEa_HgvZ@lima-default>
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-11-joel@jms.id.au>
 <d133505a-8a81-458d-a0f0-8b17ff5c0eab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d133505a-8a81-458d-a0f0-8b17ff5c0eab@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Apr 21, 2026 at 07:59:32AM +0200, Philippe Mathieu-Daudé wrote:
> On 21/4/26 07:31, Joel Stanley wrote:
> > From: Nicholas Piggin <npiggin@gmail.com>
> > 
> > tt-atlantis is likely to use a generic ECAM compatible PCIe memory map,
> > so gpex is not far off the OS programming model
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v3: Avoid leaks in the dt string allocation
> > ---
> >   include/hw/riscv/tt_atlantis.h |   2 +
> >   hw/riscv/tt_atlantis.c         | 225 ++++++++++++++++++++++++++++++++-
> >   hw/riscv/Kconfig               |   2 +
> >   3 files changed, 228 insertions(+), 1 deletion(-)
> 
> 
> > +static void create_fdt_pcie(void *fdt,
> > +                            const MemMapEntry *mem_ecam,
> > +                            const MemMapEntry *mem_pio,
> > +                            const MemMapEntry *mem_mmio32,
> > +                            const MemMapEntry *mem_mmio64,
> > +                            int legacy_irq,
> > +                            uint32_t aplic_s_phandle,
> > +                            uint32_t imsic_s_phandle)
> > +{
> > +    g_autofree char *name = g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
> > +                                            mem_ecam->base);
> > +
> > +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", FDT_PCI_ADDR_CELLS);
> > +    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", FDT_PCI_INT_CELLS);
> > +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0x2);
> > +    qemu_fdt_setprop_string(fdt, name, "compatible", "pci-host-ecam-generic");
> > +    qemu_fdt_setprop_string(fdt, name, "device_type", "pci");
> > +    qemu_fdt_setprop_cells(fdt, name, "bus-range", 0,
> > +                           mem_ecam->size / PCIE_MMCFG_SIZE_MIN - 1);
> > +    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
> > +    qemu_fdt_setprop_cell(fdt, name, "msi-parent", imsic_s_phandle);
> > +
> > +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> > +                                 2, mem_ecam->base,
> > +                                 2, mem_ecam->size);
> > +    if (!(mem_mmio32->base & 0xffffffffUL)) {
> > +        /* XXX: this is a silly hack because it would collide with PIO */
> 
> Could you explain a bit more?

Ah this is a bit incomplete sorry I didn't catch it earlier. Before the
mapping was finalised I just added this hacky way to determining PCIe IO
address based on the physical address.

This should just go away and the IO addresses come from a different table.

> 
> > +        error_report("mmio32 base must not be 0 mod 2^32");
> > +        exit(1);
> > +    }
> > +    uint32_t flags = FDT_PCI_RANGE_MMIO_64BIT | FDT_PCI_RANGE_PREFETCHABLE;
> > +    qemu_fdt_setprop_sized_cells(fdt, name, "ranges",
> > +                                 1, FDT_PCI_RANGE_IOPORT,
> > +                                 2, 0x0,
> > +                                 2, mem_pio->base,
> > +                                 2, mem_pio->size,
> > +                                 1, FDT_PCI_RANGE_MMIO,
> > +                                 2, (mem_mmio32->base & 0xffffffffUL),
> > +                                 2, mem_mmio32->base,
> > +                                 2, mem_mmio32->size,
> > +                                 1, flags,
> > +                                 2, mem_mmio64->base,
> > +                                 2, mem_mmio64->base,
> > +                                 2, mem_mmio64->size);
> > +
> > +    create_pcie_irq_map(fdt, name, legacy_irq, aplic_s_phandle);
> > +}
> 
> 
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index 0601ae1a7494..2ddee591eb90 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -129,6 +129,8 @@ config TENSTORRENT
> >       select DEVICE_TREE
> >       select RISCV_NUMA
> >       select PVPANIC_MMIO
> > +    select PCI
> 
> Do not select PCI explicitly, let the bridge (below) do it.
> Rationale is this machine does not expose a PCI bus directly,
> the bridge device does.

Good to know, thank you.

Thanks,
Nick

