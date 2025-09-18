Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB53CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 19:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzKCv-0007Ok-IV; Thu, 18 Sep 2025 15:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKCt-0007Nn-P5; Thu, 18 Sep 2025 15:22:15 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKCr-0001vA-Vc; Thu, 18 Sep 2025 15:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=RJTVN6iEHktmXI/1YOsjWLynC3LWuvOctDzcWsZi/CY=; b=0S6UjkiK2wA2EMvmQqwv5LxxNS
 ffr8HYpNJcXNi4LcNE7BSrp+CyHqbw83sEdruNMPP2YVcnN/xAsrMpxRf+zeCp7mcVM4X847XSIhD
 f0a9oaegOBUa4990HzbaoVyyo6YHejvXzp5brXvT9FA9YEFajpLfkxsraCI3xEPEF9QjnTe2ITQ9o
 OjfSwm31Gyd/9t/gJcz8+06Jp+GLb1O1f0bYcGasyycQQZDZBOZb/nNnTaH2FkJnwD9UW9bXIL2Wu
 0t/9OvEzxdx7uNAQjotixMAQ2sUd9FvzrqQ4NEC/h2U82G+BHg4mo5j9m5EXYRldKjNUCDeNWfxTJ
 yoB5K4I/CpksixZK7quJy76JC2PBlbKtONpGXbZrEob4XDjR/NSr6W7p4+rMYCfUFv67BmNQh8vCO
 E8Q5gL1lIOLystDpMa1h41w9hbemc59xhRIPXNBXfuRg+BCjq2xKchrw7HO+ZOvWWTe0AKyXpRVJ7
 d3MvOTn50Nzn+u2TxJX+0mqA2vua5dIGoJ1sQAuRAttM9UYbgPZdomYVLM/aaWft8LUYJrZYC2uzw
 ijbyz4nka6AZW9G/zCqZmpx8v37BArUovDR13xL2RoplIjdEFk48dj4LpOPHISsiiMgp7IuZ0NHXf
 Niq7dT7NamZAIJYepllqQeqcXj+xAo3VU6vpIPf8Y=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKAr-0006HM-Mf; Thu, 18 Sep 2025 20:20:09 +0100
Message-ID: <5e80548c-14e2-4bb9-8d96-e7946f613735@ilande.co.uk>
Date: Thu, 18 Sep 2025 20:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <84b03bb9a504c392fee466e6195d355eba28a76e.1758219840.git.balaton@eik.bme.hu>
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
In-Reply-To: <84b03bb9a504c392fee466e6195d355eba28a76e.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 04/14] hw/pci-host/raven: Simplify PCI bus creation
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

> Instead of doing it manually use pci_register_root_bus() to create and
> register the PCI bus.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index e0f98afebf..51427553b2 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -46,7 +46,6 @@ struct PREPPCIState {
>   
>       OrIRQState *or_irq;
>       qemu_irq pci_irqs[PCI_NUM_PINS];
> -    PCIBus pci_bus;
>       AddressSpace pci_io_as;
>       MemoryRegion pci_io;
>       MemoryRegion pci_io_non_contiguous;
> @@ -239,8 +238,9 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>   
>       qdev_init_gpio_in(d, raven_change_gpio, 1);
>   
> -    pci_bus_irqs(&s->pci_bus, raven_set_irq, s, PCI_NUM_PINS);
> -    pci_bus_map_irqs(&s->pci_bus, raven_map_irq);
> +    h->bus = pci_register_root_bus(d, NULL, raven_set_irq, raven_map_irq,
> +                                   s, &s->pci_memory, &s->pci_io, 0, 4,
> +                                   TYPE_PCI_BUS);
>   
>       memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops, s,
>                             "pci-conf-idx", 4);
> @@ -258,12 +258,14 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>                             "pci-intack", 1);
>       memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
>   
> -    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
> +    pci_create_simple(h->bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
> +
> +    address_space_init(&s->bm_as, &s->bm, "raven-bm");
> +    pci_setup_iommu(h->bus, &raven_iommu_ops, s);
>   }
>   
>   static void raven_pcihost_initfn(Object *obj)
>   {
> -    PCIHostState *h = PCI_HOST_BRIDGE(obj);
>       PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
>       MemoryRegion *address_space_mem = get_system_memory();
>   
> @@ -286,8 +288,6 @@ static void raven_pcihost_initfn(Object *obj)
>       memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
>                                           &s->pci_io_non_contiguous, 1);
>       memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
> -    pci_root_bus_init(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), NULL,
> -                      &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
>   
>       /* Bus master address space */
>       memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
> @@ -298,10 +298,6 @@ static void raven_pcihost_initfn(Object *obj)
>                                get_system_memory(), 0, 0x80000000);
>       memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
>       memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
> -    address_space_init(&s->bm_as, &s->bm, "raven-bm");
> -    pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
> -
> -    h->bus = &s->pci_bus;
>   }
>   
>   static void raven_pcihost_class_init(ObjectClass *klass, const void *data)

It also looks as if this patch removes PREPPCIState::pci_bus in favour of the 
existing PCIHostState::bus which is probably worth mentioning in the commit message. 
Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


