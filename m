Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC028D3569E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 10:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl31S-0000MX-Nb; Wed, 28 Jan 2026 05:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vl31O-0000M5-DD
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 05:43:38 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vl31L-0004DO-8O
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 05:43:38 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.75])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4f1Jlj2hG8z5wCB;
 Wed, 28 Jan 2026 10:43:28 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 28 Jan
 2026 11:43:27 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S0025c1b3f92-86ee-4006-adab-6321e0507907,
 41D9459B1804F2642626C47C485872C184A4BC89) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a31bf0d7-6143-439b-b347-3d1cce81be9d@kaod.org>
Date: Wed, 28 Jan 2026 11:43:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] hw/pci-host/aspeed_pcie: Drop AST2600 RC_H
 root-bus remap and bus-nr property
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20260127032348.2238527-1-jamin_lin@aspeedtech.com>
 <20260127032348.2238527-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260127032348.2238527-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 958d4d77-c5c3-4619-8d90-0a8ed5f840fb
X-Ovh-Tracer-Id: 16739879816837893042
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF4znpyU0LLzXx4X2povfBLf2Bf4mfZdWwjPfJaoDk4or40Xa0XZ/zSBuBkvLOBxwuOCUKtjfWYgRTZInFMJqq+Oji0Px57IM0DztP9WyYatWfMJPDdyaOtZZjgnpJ/Fsgudm/tflhee2SKLKeQk66a30I9pIpEMQrmXuht946gR9pbGnBDr94Ra/FNrAO+ZIhvIFGxsL72P/AlaWtkbT3DWONmWLQLGb9ZE6my1+RsFfBMFPW2yazdMuXh4LN7x6nLssEMF+0bGWRqU6VLJV3WTwenqOvFFf3vtxN7f2oEBYaYiNEFuzFdvrbSodo0xNGbscerce84natjcXHLtiHJch/8SLCcYyL5gOwcAAHbdcDd38SbdFfT9L3zPrgx0P3vm9nl4yLGVcNas4k8XSsyhHF/ZEXm6HcO7LkUPOAwjIj1k329eGLqjb8ICon0L/FW8wSOgCqt+LZjxqsOFAdkcJhTlZOuiUsUajiQplrgCTjRbQX+wNOvuzlIXxG+RAXs/AIBOmOeE6eXiGFPXT7TPUufEhZOggyOF9rdfPpQ6QkORjQBbTQtBEDg8q/H35ra3f5YUXrBelBAEqW6yqWq4eIkWZjQR7pAmjb3i6XnTvtdA7Xw7m5v9IHZaq/rTCdmHChrHwbdfogBFBEsLDkrFGZub83nz3vjSHh6CHdLog
DKIM-Signature: a=rsa-sha256; bh=69WebTyioVW5lRdz9JwF71zbZfi8Ud+rMYZ7fuwb3WU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1769597010; v=1;
 b=QG61faLokjYzFm7tFTJw++yXW4tQeMbcNoLocH2KYM+u54FOIGuYUhmhGfMENiUEEpSccsj6
 IF2GbGMWWoj7ytw9ZTZVVduoIkiXVGNQOsVL0wnIX6aQLVVYcepgu+GOcq92yhXxjSdjlUHsSHC
 OMoc7oxNsI5p5FLd4He9DDq2O1t/rlC6arScrG+PU2pLLg9GX5sHjD0P0fcEDa3ciFey0PL7O9w
 fOyY8GAwt3DZCNNOVo4k+GNGusW7jMB5T66TlVKR6H6gji9Es+nDimT/k9ksBnTIxvnAYKL65/c
 RHrjfOenAk1M0h10gwo9EHHARiUJDE96qvCjQy3HESSkA==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 1/27/26 04:23, Jamin Lin via qemu development wrote:
> The original AST2600 PCIe design supported both RC_L and RC_H, using root bus
> number 0 for RC_L and 0x80 for RC_H. In that model, the root port appeared as
> 80:08.0 and QEMU carried a "bus-nr" property plus a config-space bus remap to
> translate bus 0x80 to bus 0x00 for PCI enumeration.
> 
> Linux mainline has since dropped RC_L support and updated the RC_H root bus

Was PCI support for the Aspeed SoC merged in mainline  ?

Thanks,

C.

> number to start at 0. The root port is now enumerated as 00:08.0, matching the
> default QEMU PCIe subsystem root bus numbering.
> 
> Remove the bus number setting and the AST2600 bus remap logic, and drop the
> corresponding "bus-nr"/rc_bus_nr fields and property plumbing. QEMU now relies
> on the default root bus 0 behavior.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/pci-host/aspeed_pcie.h |  2 --
>   hw/pci-host/aspeed_pcie.c         | 19 +------------------
>   2 files changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
> index fde5816ea3..143b356591 100644
> --- a/include/hw/pci-host/aspeed_pcie.h
> +++ b/include/hw/pci-host/aspeed_pcie.h
> @@ -69,7 +69,6 @@ struct AspeedPCIERcState {
>       uint64_t dram_base;
>       uint32_t msi_addr;
>       uint32_t rp_addr;
> -    uint32_t bus_nr;
>       char name[16];
>       qemu_irq irq;
>   
> @@ -102,7 +101,6 @@ struct AspeedPCIECfgClass {
>   
>       uint32_t rc_msi_addr;
>       uint32_t rc_rp_addr;
> -    uint64_t rc_bus_nr;
>       uint64_t nr_regs;
>       bool rc_has_rd;
>   };
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index 4fdda95939..4f896f855c 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -268,7 +268,7 @@ static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
>       AspeedPCIECfgState *cfg =
>              container_of(rc, AspeedPCIECfgState, rc);
>   
> -    snprintf(rc->name, sizeof(rc->name), "%04x:%02x", cfg->id, rc->bus_nr);
> +    snprintf(rc->name, sizeof(rc->name), "%04x:00", cfg->id);
>   
>       return rc->name;
>   }
> @@ -283,7 +283,6 @@ static void aspeed_pcie_rc_instance_init(Object *obj)
>   }
>   
>   static const Property aspeed_pcie_rc_props[] = {
> -    DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
>       DEFINE_PROP_UINT32("rp-addr", AspeedPCIERcState, rp_addr, 0),
>       DEFINE_PROP_UINT32("msi-addr", AspeedPCIERcState, msi_addr, 0),
>       DEFINE_PROP_UINT64("dram-base", AspeedPCIERcState, dram_base, 0),
> @@ -490,17 +489,6 @@ static void aspeed_pcie_cfg_readwrite(AspeedPCIECfgState *s,
>       offset = cfg_addr & 0xffc;
>   
>       pci = PCI_HOST_BRIDGE(rc);
> -
> -    /*
> -     * On the AST2600, the RC_H bus number range from 0x80 to 0xFF, with the
> -     * root device and root port assigned to bus 0x80 instead of the standard
> -     * 0x00. To allow the PCI subsystem to correctly discover devices on the
> -     * root bus, bus 0x80 is remapped to 0x00.
> -     */
> -    if (bus == rc->bus_nr) {
> -        bus = 0;
> -    }
> -
>       pdev = pci_find_device(pci->bus, bus, devfn);
>       if (!pdev) {
>           s->regs[desc->rdata_reg] = ~0;
> @@ -650,9 +638,6 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
>                             apc->nr_regs << 2);
>       sysbus_init_mmio(sbd, &s->mmio);
>   
> -    object_property_set_int(OBJECT(&s->rc), "bus-nr",
> -                            apc->rc_bus_nr,
> -                            &error_abort);
>       object_property_set_int(OBJECT(&s->rc), "rp-addr",
>                               apc->rc_rp_addr,
>                               &error_abort);
> @@ -691,7 +676,6 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
>       apc->reg_map = &aspeed_regmap;
>       apc->nr_regs = 0x100 >> 2;
>       apc->rc_msi_addr = 0x1e77005C;
> -    apc->rc_bus_nr = 0x80;
>       apc->rc_rp_addr = PCI_DEVFN(8, 0);
>   }
>   
> @@ -811,7 +795,6 @@ static void aspeed_2700_pcie_cfg_class_init(ObjectClass *klass,
>       apc->reg_map = &aspeed_2700_regmap;
>       apc->nr_regs = 0x100 >> 2;
>       apc->rc_msi_addr = 0x000000F0;
> -    apc->rc_bus_nr = 0;
>       apc->rc_rp_addr = PCI_DEVFN(0, 0);
>   }
>   


