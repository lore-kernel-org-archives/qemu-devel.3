Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263A3EF48C4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 13:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrG7e-0008Uo-5v; Sat, 14 Feb 2026 08:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrG7U-0008UZ-Sx
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:55:38 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrG7R-0007Ud-7L
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:55:36 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0C2DA596A0B;
 Sat, 14 Feb 2026 14:55:29 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id lNwNHznHUnN0; Sat, 14 Feb 2026 14:55:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 72DB45969F6; Sat, 14 Feb 2026 14:55:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7111F5969F0;
 Sat, 14 Feb 2026 14:55:26 +0100 (CET)
Date: Sat, 14 Feb 2026 14:55:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Xu <peterx@redhat.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/6] Implement memory_region_new_* functions
In-Reply-To: <f4bcbbfd-1f6c-00ac-cd24-3089cb005b8b@eik.bme.hu>
Message-ID: <73c23787-83da-77fa-c501-a88c5faf4eaf@eik.bme.hu>
References: <cover.1770753117.git.balaton@eik.bme.hu>
 <CABgObfYpW0YMofv4O8gf4p-aWVxfvQ+BCMPsm2w+5MtD8-9s0Q@mail.gmail.com>
 <42233b06-f058-152d-645e-e16528a1640d@eik.bme.hu> <aYyTtz1B2Qz3aQWA@x1.local>
 <e3fdbd4f-df7b-0adc-06ff-4c5a25ab80cc@eik.bme.hu>
 <f4bcbbfd-1f6c-00ac-cd24-3089cb005b8b@eik.bme.hu>
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

On Sat, 14 Feb 2026, BALATON Zoltan wrote:
> On Thu, 12 Feb 2026, BALATON Zoltan wrote:
>> Memory regions are registered as a child with an owner and when the owner 
>> is destroyed it unparents the memory region which decreases its ref count 
>> so it would be freed if there are no other uses of the memory region. This 
>> is implemented and documented like that but there's currently no way to 
>> actually create a memory region that would be managed and freed by QOM that 
>> way and a memory region created with memory_region_init would never be 
>> freed and the code to manage memory region lifecycle is effectively dead. 
>> Because of this we have all sorts of hacks to solve problems that arise 
>> from this such as memory_region_ref/unref not using the ref count of the 
>> memory region itself but the ref count of the owner and we embed memory 
>> regions in devices to avoid leaking them.
>
> This is an example of hacks that I think arise from not being able to create 
> a memory region that is freed with its parent:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg03876.html
>
> This code does a few strange things meddling with internals of memory region 
> trying to handle what the ref counts should already take care of. It also 
> abuses the free function for something that I'd expect to be done in a 
> finalize or unrealize method. I think this could be simplified with QOM 
> managed memory regions that this series allow even without untangling memory 
> region ref count from the owner but I don't know that code so not trying to 
> do a fix. With the current memory_region_init we need to add more hacks to 
> make it work but that's both confusing and fragile.
>
>> or drop an unneeded field from PCIHostState as proposed here:
>> 
>> https://patchew.org/QEMU/cover.1761232472.git.balaton@eik.bme.hu/797587b52159d2db79ed924b4962be7e7ba84207.1761232472.git.balaton@eik.bme.hu/
>
> Another point I'd like to clear up here. For the linked patch I was told to 
> do this:
>
> struct PREPPCIState {
>    PCIHostState parent_obj;
>
>    MemoryRegion mmfg;
> }
>
> static void raven_pcihost_init(Object *obj)
> {
>    PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
>    PCIHostState *h = PCI_HOST_BRIDGE(dev);
>
>    memory_region_init_io(&s->mmcfg, OBJECT(h), &raven_mmcfg_ops, h->bus,
>                          "pci-mmcfg", 0x00400000);
> }
>
> static void raven_pcihost_realize(DeviceState *d, Error **errp)
> {
>    PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(dev);
>
>    memory_region_add_subregion(address_space_mem, 0x80800000, &s->mmcfg);
> }
>
> instead of what I think should also work and should be enough:
>
> static void raven_pcihost_realize(DeviceState *d, Error **errp)
> {
>    PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(dev);
>    PCIHostState *h = PCI_HOST_BRIDGE(dev);

dev above is d or obj

>    MemoryRegion *mr;
>
>    mr = memory_region_new_io(OBJECT(s), &raven_mmcfg_ops, h->bus,
>                              "pci-mmcfg", 0x00400000);
>    memory_region_add_subregion(address_space_mem, 0x80800000, &s->mmcfg);

and s->mmcfg here is mr (just copy&pasted these) but you get the idea.

> }
>
> When asking why and if that's really necessary I got referred to some obscure 
> conventions that may or may not exist but not documented anywhere or just 
> because that's a more canonical way to do this. But is there really such 
> convention or any reason to do it the hard way instead of allowing simpler 
> device models? I'm all for simplifying devices and be able to do it with just 
> the two lines in my second example which works as demonstrated by my prep 
> clean up series but was not accepted for reasons I could not quite 
> understand. So could this be cleared up too and if there are reasons for the 
> first way then explain and document that somewhere?
>
> Regards,
> BALATON Zoltan
>
>

