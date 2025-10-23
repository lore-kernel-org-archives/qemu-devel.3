Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45899CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBv9x-0001GH-04; Thu, 23 Oct 2025 09:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBv9q-0001DE-6d; Thu, 23 Oct 2025 09:15:10 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBv9l-0007uz-2E; Thu, 23 Oct 2025 09:15:09 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5F4815972ED;
 Thu, 23 Oct 2025 15:15:00 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id yihhUPoAiEOB; Thu, 23 Oct 2025 15:14:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 53E3C5972E8; Thu, 23 Oct 2025 15:14:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 523E25972DE;
 Thu, 23 Oct 2025 15:14:58 +0200 (CEST)
Date: Thu, 23 Oct 2025 15:14:58 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v4 11/12] hw/ppc/pegasos2: Add Pegasos I emulation
In-Reply-To: <63bb6500-56f7-4d4c-86ec-7aef613de6b6@linaro.org>
Message-ID: <b81e1b45-304e-e6a6-98aa-6eeee8f4ff25@eik.bme.hu>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <8f5bd07553b41d83a54f9df0bb93b76b22dea5c5.1761176219.git.balaton@eik.bme.hu>
 <63bb6500-56f7-4d4c-86ec-7aef613de6b6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-399995252-1761225298=:38722"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-399995252-1761225298=:38722
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 23 Oct 2025, Philippe Mathieu-Daudé wrote:
> On 23/10/25 02:06, BALATON Zoltan wrote:
>> The Pegasos II is a redesign of the original Pegasos (later marked I)
>> that replaces the north bridge and has updated firmware but otherwise
>> these are very similar. The Pegasos uses the same north bridge that
>> AmigaOne used which we already emulate so we can also easily emulate
>> Pegasos I.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/pegasos2.c | 156 ++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 117 insertions(+), 39 deletions(-)
>
>
>> @@ -89,6 +96,8 @@ static void pegasos2_cpu_reset(void *opaque)
>>       if (pm->vof) {
>>           cpu->env.gpr[1] = 2 * VOF_STACK_SIZE - 0x20;
>>           cpu->env.nip = 0x100;
>> +    } else if (pm->type == PEGASOS1) {
>> +        cpu->env.nip = 0xfffc0100;
>
> Preferably add a comment explaining/describing this value (think
> at your future you in 3 years ;) ).

I think I can figure that out even 3 years from now :-). PPC reset vector 
is 0x100 so it should point to somewhere in ROM at offset 0x100. I'm not 
quite sure how real machine gets to this address (there are pins that set 
initial vectors address that we don't model or maybe ROM is remapped at 
startup) but it seems to be the right start address so not much I can 
explain about that.

>> +    case PEGASOS1:
>> +    {
>> +        MemoryRegion *pci_mem, *mr;
>> +
>> +        /* Articia S */
>> +        pm->nb = DEVICE(sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, 
>> NULL));
>> +        pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 1);
>> +        mr = g_new(MemoryRegion, 1);
>> +        memory_region_init_alias(mr, OBJECT(pm->nb), "pci-mem-low", 
>> pci_mem,
>> +                                 0, 0x1000000);
>> +        memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
>> +        mr = g_new(MemoryRegion, 1);
>> +        memory_region_init_alias(mr, OBJECT(pm->nb), "pci-mem-high", 
>> pci_mem,
>> +                                 0x80000000, 0x7d000000);
>> +        memory_region_add_subregion(get_system_memory(), 0x80000000, mr);
>
> Since I don't want to delay this series any further, as a future
> cleanup consider passing the host MR (get_system_memory) as a link
> property, and map PCI hi/lo regions in the host bridge realize.

I'll consider this as future clean up. These should really be controlled 
by registers in the north bridge but I don't have docs on Articia S so I 
don't know how this should work but these are probably the default values 
that we could move to the articia model but have to check if that works 
for amigaone too. I'd skip the link property though to keep it simple. 
This is a simple machine and other host bridges also access system memory 
currently. Until get_system_memory goes away I don't see a reason to make 
it more complicated.

Regards,
BALATON Zoltan

>> +        pci_bus = PCI_BUS(qdev_get_child_bus(pm->nb, "pci.0"));
>> +        break;
>> +    }
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>
--3866299591-399995252-1761225298=:38722--

