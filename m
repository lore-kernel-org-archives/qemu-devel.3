Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80284C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoTy-0008LY-8O; Wed, 21 Feb 2024 10:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rcoNE-0001hh-P8
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:06 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rcld6-0005OG-CC
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 07:23:18 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 21FDC4E6006;
 Wed, 21 Feb 2024 13:23:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id X2afBcmoLxhu; Wed, 21 Feb 2024 13:23:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2A42C4E6004; Wed, 21 Feb 2024 13:23:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 27F527456B4;
 Wed, 21 Feb 2024 13:23:09 +0100 (CET)
Date: Wed, 21 Feb 2024 13:23:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: [PATCH 3/5] hw/isa: Embed TYPE_PORT92 in south bridges used in
 PC machines
In-Reply-To: <6a2333d7-9dea-4a0e-9d91-0889e6205128@ilande.co.uk>
Message-ID: <477ea9cd-7f2b-b09a-db60-f13defa5c6d3@eik.bme.hu>
References: <20240218131701.91132-1-shentey@gmail.com>
 <20240218131701.91132-4-shentey@gmail.com>
 <6a2333d7-9dea-4a0e-9d91-0889e6205128@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 21 Feb 2024, Mark Cave-Ayland wrote:
> On 18/02/2024 13:16, Bernhard Beschow wrote:
>> Port 92 is an integral part of the PIIX and ICH south bridges, so 
>> instantiate it
>> there. The isapc machine now needs to instantiate it explicitly, analoguous 
>> to
>> the RTC.
>> 
>> Note that due to migration compatibility, port92 is optional in the south
>> bridges. It is always instantiated the isapc machine for simplicity.
>> 
>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>> ---
>>   include/hw/i386/pc.h          |  2 +-
>>   include/hw/southbridge/ich9.h |  4 ++++
>>   include/hw/southbridge/piix.h |  3 +++
>>   hw/i386/pc.c                  | 18 ++++++++++++------
>>   hw/i386/pc_piix.c             |  9 +++++++--
>>   hw/i386/pc_q35.c              |  8 +++++---
>>   hw/isa/lpc_ich9.c             |  9 +++++++++
>>   hw/isa/piix.c                 |  9 +++++++++
>>   hw/isa/Kconfig                |  2 ++
>>   9 files changed, 52 insertions(+), 12 deletions(-)
[...] 
>> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
>> index efdf43e92c..f42a087c07 100644
>> --- a/hw/isa/Kconfig
>> +++ b/hw/isa/Kconfig
>> @@ -47,6 +47,7 @@ config PIIX
>>       select IDE_PIIX
>>       select ISA_BUS
>>       select MC146818RTC
>> +    select PORT92
>>       select USB_UHCI
>>     config PORT92
>> @@ -78,3 +79,4 @@ config LPC_ICH9
>>       select ISA_BUS
>>       select ACPI_ICH9
>>       select MC146818RTC
>> +    select PORT92
>
> I had a look at this (and did a bit of revision around 8042 and A20), and I 
> am starting to wonder if the PORT92 device isn't something that belongs to 
> the southbridge, but more specifically to the superio chip?
>
> A couple of thoughts as to why I came to this conclusion: firstly the superio 
> chip is generally considered to be a single integrated implementation of 
> legacy IO devices, so this feels like a natural home for the PORT92 device. 
> Secondly the value of the "has-port92" property is controlled by 
> pcms->i8042_enabled, and this value is already passed into functions such as 
> pc_superio_init() for example.

One more argument for that may be that this A20 gate was originally 
controlled by the keyboard controller and that's part of the superio. The 
VIA southbridge docs even mention something about the KBC and this port92 
register controlling the A20 gate together. So to implement that correctly 
it may need to be in the same device. However this may be specific to the 
VIA chip so not sure if this implementation can be shared by all the 
southbridge devices.

> I think this would also help reduce the changes required for the individual 
> machines, however the devil is always in the details particularly when 
> migration is involved.

One thing that bothers me very much about this port92 device is that we 
have about 100 lines of code of which the actual functionality is just a 
qemu_irq and an uint8_t controlling it and storing the register value. 
That shouldn't be more than 10 lines or maybe 20 with migration support, 
it's only 100 lines because it's wrapped in a QDev. Bernhard wanted to 
move it out from the PC machines to clean those up but as a result this 
mess is just pushed down in the southbridge (or into superio as you 
propose). It could easily be implemented in the southbridge or superio by 
just adding the qemu_irq and the register value and maybe export it as a 
property so the machine can set it for migration compatibility and then we 
don't need a separate QDev wrapper around it as the superio or southbridge 
is already a QDev and has the needed stuff to store this.

But one could also argue that while these southbridges implement this 
functionality, it's only used on the PC machines so as we already have it 
modelled in a separate object we could just let the PC machines 
instantiate it and leave it as it is and don't add this to other machines 
where it's not needed.

(I like Mark's proposal a bit better only because that leaves the 
southbridge untouched and changes the superio instead that I care less 
about but the issue is the same there.)

Regards,
BALATON Zoltan

