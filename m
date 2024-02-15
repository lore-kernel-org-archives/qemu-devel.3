Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEF0C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raci0-0002fM-7x; Thu, 15 Feb 2024 09:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rachw-0002f4-W9
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:27:25 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rachu-0001W2-QS
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:27:24 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 889344E602F;
 Thu, 15 Feb 2024 15:27:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4invbTU6KD2j; Thu, 15 Feb 2024 15:27:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 977C04E6013; Thu, 15 Feb 2024 15:27:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 944CC7456B4;
 Thu, 15 Feb 2024 15:27:16 +0100 (CET)
Date: Thu, 15 Feb 2024 15:27:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 shentey@gmail.com
Subject: Re: [PATCH v3 8/9] mips/loongson3_virt: do not require CONFIG_USB
In-Reply-To: <47a999a8-a0e0-4995-8f8c-8d18f564c30b@linaro.org>
Message-ID: <d02bde71-c4b8-4b07-bc40-3b74d37b0738@eik.bme.hu>
References: <20240213155005.109954-1-pbonzini@redhat.com>
 <20240213155005.109954-9-pbonzini@redhat.com>
 <47a999a8-a0e0-4995-8f8c-8d18f564c30b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1810300859-1708007236=:15691"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--3866299591-1810300859-1708007236=:15691
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 15 Feb 2024, Philippe Mathieu-Daudé wrote:
> On 13/2/24 16:50, Paolo Bonzini wrote:
>> Once the Kconfig for hw/mips is cleaned up, it will be possible to build a
>> binary that does not include any USB host controller and therefore that
>> does not include the code guarded by CONFIG_USB.  While the simpler
>> creation functions such as usb_create_simple can be inlined, this is not
>> true of usb_bus_find().  Remove it, replacing it with a search of the
>> single USB bus created by loongson3_virt_devices_init().
>> 
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   hw/mips/loongson3_virt.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
>> index caedde2df00..bedd3d496bd 100644
>> --- a/hw/mips/loongson3_virt.c
>> +++ b/hw/mips/loongson3_virt.c
>> @@ -447,8 +447,9 @@ static inline void 
>> loongson3_virt_devices_init(MachineState *machine,
>>         if (defaults_enabled() && object_class_by_name("pci-ohci")) {
>>           pci_create_simple(pci_bus, -1, "pci-ohci");
>> -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
>> -        usb_create_simple(usb_bus_find(-1), "usb-tablet");
>> +        Object *usb_bus = object_resolve_path_type("", TYPE_USB_BUS, 
>> NULL);
>> +        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
>> +        usb_create_simple(USB_BUS(usb_bus), "usb-tablet");
>>       }
>>         pci_init_nic_devices(pci_bus, mc->default_nic);
>
> Can we remove usb_bus_find() completely instead?
>
> $ git grep -w usb_bus_find
> hw/hppa/machine.c:401:        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> hw/hppa/machine.c:402:        usb_create_simple(usb_bus_find(-1), 
> "usb-mouse");
> hw/mips/loongson3_virt.c:450:        usb_create_simple(usb_bus_find(-1), 
> "usb-kbd");
> hw/mips/loongson3_virt.c:451:        usb_create_simple(usb_bus_find(-1), 
> "usb-tablet");
> hw/ppc/mac_newworld.c:434:            USBBus *usb_bus = usb_bus_find(-1);
> hw/ppc/sam460ex.c:423:    usb_create_simple(usb_bus_find(-1), "usb-kbd");
> hw/ppc/sam460ex.c:424:    usb_create_simple(usb_bus_find(-1), "usb-mouse");
> hw/ppc/spapr.c:3027:            USBBus *usb_bus = usb_bus_find(-1);
> hw/sh4/r2d.c:315:    usb_create_simple(usb_bus_find(-1), "usb-kbd");
> hw/usb/bus.c:103:USBBus *usb_bus_find(int busnr)
> hw/usb/bus.c:669:    USBBus *bus = usb_bus_find(-1 /* any */);
> include/hw/usb.h:500:USBBus *usb_bus_find(int busnr);

These are all the machines that add devices to a USB bus, there's no other 
example to do it in a different way currently. We could change this to get 
the usb bus in a different way but how? We could either peek into the 
object that owns the usb_bus or try using qdev_get_child_bus() but that 
needs the name of the bus which might change if other usb hosts are added 
so neither of these options seem better than this function. What would it 
bring to remove this function other than more complex or uglier code? I 
don't mind if you remove it just don't see the benefit in that.

Regards,
BALATON Zoltan
--3866299591-1810300859-1708007236=:15691--

