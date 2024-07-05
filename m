Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55509C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPWuz-0003NZ-Ib; Thu, 04 Jul 2024 20:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sPWuv-0003Ck-KI; Thu, 04 Jul 2024 20:35:14 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sPWur-0000Lc-LM; Thu, 04 Jul 2024 20:35:11 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 903234E6001;
 Fri, 05 Jul 2024 02:35:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ZjpcvgTFKp_u; Fri,  5 Jul 2024 02:35:04 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 901BF4E600F; Fri, 05 Jul 2024 02:35:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8E3FF746E3B;
 Fri, 05 Jul 2024 02:35:04 +0200 (CEST)
Date: Fri, 5 Jul 2024 02:35:04 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/3] hw/isa/vt82c686: Resolve intermediate IRQ
 forwarder
In-Reply-To: <20240704205854.18537-3-shentey@gmail.com>
Message-ID: <6ec5354e-1a1e-93a1-956c-1d0b5e0e5024@eik.bme.hu>
References: <20240704205854.18537-1-shentey@gmail.com>
 <20240704205854.18537-3-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1146491698-1720139704=:66834"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1146491698-1720139704=:66834
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 4 Jul 2024, Bernhard Beschow wrote:
> When @cpu_intr is populated before vt82xx's realize(), it can be directly passed
> to i8259_init(), avoiding the need for the intermediate
> via_isa_request_i8259_irq() handler. The result is less code and runtime
> overhead, and a fixed memory leak caused by qemu_allocate_irqs().
>
> Inspired-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/isa/vt82c686.c   | 12 ++----------
> hw/mips/fuloong2e.c |  2 +-
> hw/ppc/amigaone.c   |  8 ++++----
> hw/ppc/pegasos2.c   |  4 ++--
> 4 files changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 505b44c4e6..ca02ad4c20 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -624,6 +624,7 @@ static void via_isa_init(Object *obj)
>     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_USB_UHCI);
>     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
>     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
> +    qdev_init_gpio_out_named(DEVICE(obj), &s->cpu_intr, "intr", 1);
> }
>
> static const TypeInfo via_isa_info = {
> @@ -704,24 +705,15 @@ static void via_isa_pirq(void *opaque, int pin, int level)
>     via_isa_set_irq(opaque, pin, level);
> }
>
> -static void via_isa_request_i8259_irq(void *opaque, int irq, int level)
> -{
> -    ViaISAState *s = opaque;
> -    qemu_set_irq(s->cpu_intr, level);
> -}
> -
> static void via_isa_realize(PCIDevice *d, Error **errp)
> {
>     ViaISAState *s = VIA_ISA(d);
>     DeviceState *dev = DEVICE(d);
>     PCIBus *pci_bus = pci_get_bus(d);
> -    qemu_irq *isa_irq;
>     ISABus *isa_bus;
>     int i;
>
> -    qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
>     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);

I still don't like how this makes handling of out and in gpios different 
and it also prevents to create the device with 
pci_create_simple_multifunction() and needs tweaking before realize. I 
think the fix should be in i8259 and not in this device.

Regards,
BALATON Zoltan

> -    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
>     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
>                           errp);
>
> @@ -729,7 +721,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>         return;
>     }
>
> -    s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
> +    s->isa_irqs_in = i8259_init(isa_bus, s->cpu_intr);
>     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
>     i8254_pit_init(isa_bus, 0x40, 0, NULL);
>     i8257_dma_init(OBJECT(d), isa_bus, 0);
> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index 6e4303ba47..e6487c34d8 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -286,6 +286,7 @@ static void mips_fuloong2e_init(MachineState *machine)
>     /* South bridge -> IP5 */
>     pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
>                                     TYPE_VT82C686B_ISA);
> +    qdev_connect_gpio_out_named(DEVICE(pci_dev), "intr", 0, env->irq[5]);
>
>     /* Set properties on individual devices before realizing the south bridge */
>     if (machine->audiodev) {
> @@ -299,7 +300,6 @@ static void mips_fuloong2e_init(MachineState *machine)
>                               object_resolve_path_component(OBJECT(pci_dev),
>                                                             "rtc"),
>                               "date");
> -    qdev_connect_gpio_out_named(DEVICE(pci_dev), "intr", 0, env->irq[5]);
>
>     dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
>     pci_ide_create_devs(PCI_DEVICE(dev));
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 9dcc486c1a..2110875f56 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -148,13 +148,13 @@ static void amigaone_init(MachineState *machine)
>     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
>
>     /* VIA VT82c686B South Bridge (multifunction PCI device) */
> -    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(7, 0),
> -                                                 TYPE_VT82C686B_ISA));
> +    via = OBJECT(pci_new_multifunction(PCI_DEVFN(7, 0), TYPE_VT82C686B_ISA));
> +    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
> +                                qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
> +    pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
>     object_property_add_alias(OBJECT(machine), "rtc-time",
>                               object_resolve_path_component(via, "rtc"),
>                               "date");
> -    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
> -                                qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
>     for (i = 0; i < PCI_NUM_PINS; i++) {
>         qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via),
>                                                              "pirq", i));
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index 9b0a6b70ab..54e60082ce 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -181,6 +181,8 @@ static void pegasos2_init(MachineState *machine)
>
>     /* VIA VT8231 South Bridge (multifunction PCI device) */
>     via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
> +    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
> +                                qdev_get_gpio_in_named(pm->mv, "gpp", 31));
>
>     /* Set properties on individual devices before realizing the south bridge */
>     if (machine->audiodev) {
> @@ -195,8 +197,6 @@ static void pegasos2_init(MachineState *machine)
>     object_property_add_alias(OBJECT(machine), "rtc-time",
>                               object_resolve_path_component(via, "rtc"),
>                               "date");
> -    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
> -                                qdev_get_gpio_in_named(pm->mv, "gpp", 31));
>
>     dev = PCI_DEVICE(object_resolve_path_component(via, "ide"));
>     pci_ide_create_devs(dev);
>
--3866299591-1146491698-1720139704=:66834--

