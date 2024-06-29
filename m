Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5C2C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 13:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNXpV-0002Ex-8y; Sat, 29 Jun 2024 09:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sNXpO-0002Bp-RZ; Sat, 29 Jun 2024 09:09:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sNXp8-0001jD-Dp; Sat, 29 Jun 2024 09:09:17 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DF4A54E6005;
 Sat, 29 Jun 2024 15:08:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id iA7ZJaOCog0n; Sat, 29 Jun 2024 15:08:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DAD484E6000; Sat, 29 Jun 2024 15:08:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D8248746E3B;
 Sat, 29 Jun 2024 15:08:52 +0200 (CEST)
Date: Sat, 29 Jun 2024 15:08:52 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
cc: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 04/15] hw/isa/vt82c686: Define a GPIO line between
 vt82c686 and i8259
In-Reply-To: <20240627-san-v2-4-750bb0946dbd@daynix.com>
Message-ID: <1e00690f-5c1e-671f-3ba4-57f16eaa9fc4@eik.bme.hu>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-4-750bb0946dbd@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 27 Jun 2024, Akihiko Odaki wrote:
> This fixes qemu_irq array leak.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> hw/isa/vt82c686.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 8582ac0322eb..629d2d568137 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -715,13 +715,14 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>     ViaISAState *s = VIA_ISA(d);
>     DeviceState *dev = DEVICE(d);
>     PCIBus *pci_bus = pci_get_bus(d);
> -    qemu_irq *isa_irq;
> +    qemu_irq isa_irq;
>     ISABus *isa_bus;
>     int i;
>
>     qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
> -    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
> +    qdev_init_gpio_in_named(dev, via_isa_request_i8259_irq, "i8259", 1);

The chip has no such pin so this is a QEMU internal connection that I 
think should not be modelled with a named gpio. I think we really need a 
function to init a qemu_irq (for now we only have one that also allocares 
it) so then we can put this in ViaISAState and init in place. I'll make a 
patch.

Regards,
BALATON Zoltan

> +    isa_irq = qdev_get_gpio_in_named(dev, "i8259", 0);
>     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
>                           errp);
>
> @@ -729,7 +730,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>         return;
>     }
>
> -    s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
> +    s->isa_irqs_in = i8259_init(isa_bus, isa_irq);
>     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
>     i8254_pit_init(isa_bus, 0x40, 0, NULL);
>     i8257_dma_init(OBJECT(d), isa_bus, 0);
>
>

