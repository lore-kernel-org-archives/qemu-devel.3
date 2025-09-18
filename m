Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9113CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 19:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzKPf-00031X-3o; Thu, 18 Sep 2025 15:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKPa-000303-LB; Thu, 18 Sep 2025 15:35:22 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKPY-0004LI-2X; Thu, 18 Sep 2025 15:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=iRw8QiHPyjHkZyHVJRGxMWcAgSPU2T5HTgafQP0Xcf4=; b=Z1h8pO6THN0LmWCB9XpZb+YJWk
 hRMvcoKjD4NOBWFf26JAPcTkrTKwYW09yn+wBrEO4DFOw52YShX/zRktQx4abdi72sLxLw8jc3ZOp
 ogJ/4EpA2h2Ra2nOIbrr8WEB4u8FJBn8/P9DVZ9MYm3dA3bbRUyzYldQ2aq3JystgqzrTMLdX4vms
 bQaGrw2iyNcAiDg4ja36WdB4h4qlUZ2FZVFwiNd/VerPchZZIMzyLJ3SB0FVl/bh7cjemq3aBsLI4
 K1jbHMvRdC42YX4M3SFA0sOuisAdoGZXsNPwEaFLq7OdCEOf9GhUVFU4e0xBRQu8CBzqupFbXGikE
 mXdw4CEyC5VI1UCgVy0mOXGs4PPvlVhA1m+u/Vy8RJ8VPiNEbbMrsExGnHQM//MvJmUr4CPXSQqkJ
 eoy9XmNoNrwyXo7nPvBMu6vIJzJWV7gbJCJ+eErvhusNlFLDlkWuceb3I9LUeOSpZmHowWWOKzAy7
 6W+0uyO7e9jRLZ4eIJlOMeK2sZcGd/x5cQ3wg4iDGUqE86vzeZWk7vgfKsZQnKeqjmVKIBwqpHoxj
 XiSpbbjVTkL9p7VqBAOZXRV5vIQxQpT1vb5uRe+P8Uz/I+kd736LiUbckHALEkXvuHJqSjnfci6TF
 M2aUg7PL6nSbLQwnB1b61xv1yYuAra5hnLMJoUuMk=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKNT-0006MM-Vr; Thu, 18 Sep 2025 20:33:12 +0100
Message-ID: <8d2835f0-d4c3-419e-922a-8f1859877d3c@ilande.co.uk>
Date: Thu, 18 Sep 2025 20:35:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <d1d979ab0da126dd9d812373bf0e522ea6e937fc.1758219840.git.balaton@eik.bme.hu>
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
In-Reply-To: <d1d979ab0da126dd9d812373bf0e522ea6e937fc.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 05/14] hw/pci-host/raven: Simplify PCI interrupt routing
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

> No need to use an or-irq to map interrupt lines to a single IRQ as the
> PCI code can handle this internally so simplify by dropping the or-irq.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 39 +++++++++++++++------------------------
>   hw/ppc/prep.c       |  5 ++++-
>   2 files changed, 19 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index 51427553b2..a400a22df3 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -30,11 +30,8 @@
>   #include "hw/pci/pci_device.h"
>   #include "hw/pci/pci_bus.h"
>   #include "hw/pci/pci_host.h"
> -#include "hw/qdev-properties.h"
>   #include "hw/intc/i8259.h"
>   #include "hw/irq.h"
> -#include "hw/or-irq.h"
> -#include "qom/object.h"
>   
>   #define TYPE_RAVEN_PCI_DEVICE "raven"
>   #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
> @@ -44,8 +41,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PREPPCIState, RAVEN_PCI_HOST_BRIDGE)
>   struct PREPPCIState {
>       PCIHostState parent_obj;
>   
> -    OrIRQState *or_irq;
> -    qemu_irq pci_irqs[PCI_NUM_PINS];
> +    qemu_irq irq;
>       AddressSpace pci_io_as;
>       MemoryRegion pci_io;
>       MemoryRegion pci_io_non_contiguous;
> @@ -183,16 +179,25 @@ static const MemoryRegionOps raven_io_ops = {
>       .valid.unaligned = true,
>   };
>   
> +/*
> + * All four IRQ[ABCD] pins from all slots are tied to a single board
> + * IRQ, so our mapping function here maps everything to IRQ 0.
> + * The code in pci_change_irq_level() tracks the number of times
> + * the mapped IRQ is asserted and deasserted, so if multiple devices
> + * assert an IRQ at the same time the behaviour is correct.
> + *
> + * This may need further refactoring for boards that use multiple IRQ lines.
> + */
>   static int raven_map_irq(PCIDevice *pci_dev, int irq_num)
>   {
> -    return (irq_num + (pci_dev->devfn >> 3)) & 1;
> +    return 0;
>   }
>   
>   static void raven_set_irq(void *opaque, int irq_num, int level)
>   {
> -    PREPPCIState *s = opaque;
> +    qemu_irq *irq = opaque;
>   
> -    qemu_set_irq(s->pci_irqs[irq_num], level);
> +    qemu_set_irq(*irq, level);
>   }
>   
>   static AddressSpace *raven_pcihost_set_iommu(PCIBus *bus, void *opaque,
> @@ -220,26 +225,12 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>       PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(dev);
>       MemoryRegion *address_space_mem = get_system_memory();
> -    int i;
> -
> -    /*
> -     * According to PReP specification section 6.1.6 "System Interrupt
> -     * Assignments", all PCI interrupts are routed via IRQ 15
> -     */
> -    s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
> -    object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
> -                            &error_fatal);
> -    qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
> -    sysbus_init_irq(dev, &s->or_irq->out_irq);
> -
> -    for (i = 0; i < PCI_NUM_PINS; i++) {
> -        s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
> -    }
>   
>       qdev_init_gpio_in(d, raven_change_gpio, 1);
>   
> +    sysbus_init_irq(dev, &s->irq);
>       h->bus = pci_register_root_bus(d, NULL, raven_set_irq, raven_map_irq,
> -                                   s, &s->pci_memory, &s->pci_io, 0, 4,
> +                                   &s->irq, &s->pci_memory, &s->pci_io, 0, 1,
>                                      TYPE_PCI_BUS);
>   
>       memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops, s,
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 982e40e53e..d3365414d2 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -304,7 +304,10 @@ static void ibm_40p_init(MachineState *machine)
>       qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
>       qdev_connect_gpio_out(i82378_dev, 0,
>                             qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
> -
> +    /*
> +     * According to PReP specification section 6.1.6 "System Interrupt
> +     * Assignments", all PCI interrupts are routed via IRQ 15
> +     */
>       sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
>       isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));

I'm not convinced this is the right approach, because in the past people have 
expressed interest in monitoring the individual PCI IRQ lines (and in fact, I think 
you've exposed them as gpios for the VIA device). I can certainly see the value of 
modelling the OR function and driving the individual PCI IRQs from the raven device.


ATB,

Mark.


