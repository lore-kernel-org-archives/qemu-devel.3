Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DE3CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 21:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLmN-0007dB-Jx; Thu, 18 Sep 2025 17:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLmH-0007cS-KS; Thu, 18 Sep 2025 17:02:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLmF-0000qI-JU; Thu, 18 Sep 2025 17:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=EBSb7ApIonIPmQlH/99pnAnLyHyOPhuR2kBy/9/PN7o=; b=LsnkcEliqjq9ErmR0jLP3kFlAH
 aVt3Tsiv52FZsBcRBkMLecv1h4mdjPC1Pfh9aINRxtXKhpgvKFG7fhIYt3y7y3jEmbxsozr54Jdsm
 hqgiLRU0QzaEYveaU1jmY+L4dHatvFwgzrsBkMyAwUxe5cOqfjRBLVTXI6rKVuc7g/wyMsK99D6JY
 1A0de8ew4tNIFW2DKg4VfND0oycSEbndQkPQltKEf8ERiRA0VAkmotfjax1X7agwbIcyEgyS07nfa
 22Rxgn+inJeW3eLi7+EU9Jw0Y1Pc/+HhvQFqtX8gX/JhSbdKLtHnq/SZ2ViQ4QY/dEXjzIVcLaBTI
 DYq1Cv3GRWsyhvEV0rv/Zi29BW3Qwb6bS9MxJ2Bk537Xw9LroHcypSel4KGlUfIXUw3EmpdJpDQoZ
 HuAYPyr0loB8mqbzkzUS5owPgfuTPji8na+KjrH1qR2Mpyinfc5U8Z1YUHOuTjmRlCgsTWBZtGNAA
 yIrHwFXiM8tNVtoCcCUmPqbLtues1V6AexLQlepU9COiBi5p4nHTeI1IhNBjjJ8fEY7ITWFSMCFrc
 ImJ7Cq8RLA/DQKhOm/owT38MSeKKpOIwSB6vCrvmdXg25LZkGP47xNApGEC/MMWg12ChmEdYGMgaT
 7ncMnd/F0ukQTlEkMmqjQRk05+F3Wq+0PGD07n3po=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLkE-000717-AT; Thu, 18 Sep 2025 22:00:46 +0100
Message-ID: <c3a2ec46-9ae1-439f-b6dd-3f869163dcec@ilande.co.uk>
Date: Thu, 18 Sep 2025 22:02:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <faf045e1d4d9554af46706939e868af06ce256f3.1758219840.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <faf045e1d4d9554af46706939e868af06ce256f3.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 13/14] hw/pci-host/raven: Do not map regions in init
 method
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 18/09/2025 19:50, BALATON Zoltan wrote:

> Export memory regions as sysbus mmio regions and let the board code
> map them similar to how it is done in grackle.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 37 ++++++++++++-------------------------
>   hw/ppc/prep.c       | 11 +++++++++--
>   2 files changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index ebf0c511dc..0c4eca04bb 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -49,8 +49,6 @@ struct PREPPCIState {
>       AddressSpace bm_as;
>   };
>   
> -#define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main bus */
> -
>   static inline uint32_t raven_idsel_to_addr(hwaddr addr)
>   {
>       return (ctz16(addr >> 11) << 11) | (addr & 0x7ff);
> @@ -170,7 +168,7 @@ static void raven_change_gpio(void *opaque, int n, int level)
>       memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
>   }
>   
> -static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
> +static void raven_pcihost_realize(DeviceState *d, Error **errp)

There is a function rename here not mentioned in the commit message.

>   {
>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
> @@ -180,7 +178,17 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>   
>       qdev_init_gpio_in(d, raven_change_gpio, 1);
>   
> +    memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
> +    memory_region_init_io(&s->pci_discontiguous_io, o,
> +                          &raven_io_ops, &s->pci_io,
> +                          "pci-discontiguous-io", 8 * MiB);
> +    memory_region_init(&s->pci_memory, o, "pci-memory", 0x3f000000);
> +
> +    sysbus_init_mmio(dev, &s->pci_io);
> +    sysbus_init_mmio(dev, &s->pci_discontiguous_io);
> +    sysbus_init_mmio(dev, &s->pci_memory);
>       sysbus_init_irq(dev, &s->irq);
> +
>       h->bus = pci_register_root_bus(d, NULL, raven_set_irq, raven_map_irq,
>                                      &s->irq, &s->pci_memory, &s->pci_io, 0, 1,
>                                      TYPE_PCI_BUS);
> @@ -219,32 +227,12 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>       pci_setup_iommu(h->bus, &raven_iommu_ops, s);
>   }
>   
> -static void raven_pcihost_initfn(Object *obj)
> -{
> -    PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
> -    MemoryRegion *address_space_mem = get_system_memory();
> -
> -    memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
> -    memory_region_init_io(&s->pci_discontiguous_io, obj,
> -                          &raven_io_ops, &s->pci_io,
> -                          "pci-discontiguous-io", 8 * MiB);
> -    memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
> -
> -    /* CPU address space */
> -    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
> -                                &s->pci_io);
> -    memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
> -                                        &s->pci_discontiguous_io, 1);
> -    memory_region_set_enabled(&s->pci_discontiguous_io, false);
> -    memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
> -}

Normally if the MemoryRegion does not depend upon a property, it can be initialised 
in an init() function, so these can stay where they are.

But certainly the device should not be mapping itself, so the sysbus-related changes 
look correct.

> -
>   static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    dc->realize = raven_pcihost_realizefn;
> +    dc->realize = raven_pcihost_realize;
>       dc->fw_name = "pci";
>   }
>   
> @@ -278,7 +266,6 @@ static const TypeInfo raven_types[] = {
>           .name = TYPE_RAVEN_PCI_HOST_BRIDGE,
>           .parent = TYPE_PCI_HOST_BRIDGE,
>           .instance_size = sizeof(PREPPCIState),
> -        .instance_init = raven_pcihost_initfn,
>           .class_init = raven_pcihost_class_init,
>       },
>       {
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index d3365414d2..23d0e1eeaa 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -53,8 +53,11 @@
>   
>   #define CFG_ADDR 0xf0000510
>   
> -#define KERNEL_LOAD_ADDR 0x01000000
> -#define INITRD_LOAD_ADDR 0x01800000
> +#define KERNEL_LOAD_ADDR  0x01000000
> +#define INITRD_LOAD_ADDR  0x01800000
> +
> +#define PCI_IO_BASE_ADDR  0x80000000
> +#define PCI_MEM_BASE_ADDR 0xc0000000
>   
>   #define BIOS_ADDR         0xfff00000
>   #define BIOS_SIZE         (1 * MiB)
> @@ -293,6 +296,10 @@ static void ibm_40p_init(MachineState *machine)
>       pcihost = SYS_BUS_DEVICE(dev);
>       object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev));
>       sysbus_realize_and_unref(pcihost, &error_fatal);
> +    sysbus_mmio_map(pcihost, 0, PCI_IO_BASE_ADDR);
> +    sysbus_mmio_map_overlap(pcihost, 1, PCI_IO_BASE_ADDR, 1);
> +    memory_region_set_enabled(sysbus_mmio_get_region(pcihost, 1), false);

Why not leave this within the device itself? It seems odd that something external to 
the device is trying to set its initial state.

> +    sysbus_mmio_map(pcihost, 2, PCI_MEM_BASE_ADDR);
>       pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
>       if (!pci_bus) {
>           error_report("could not create PCI host controller");


ATB,

Mark.


