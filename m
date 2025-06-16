Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED52C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 10:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR7Et-0002DM-UG; Mon, 16 Jun 2025 06:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uR7El-0002CV-Ex; Mon, 16 Jun 2025 06:38:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uR7Eh-0007zQ-Mx; Mon, 16 Jun 2025 06:38:47 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 22BB655C0CD;
 Mon, 16 Jun 2025 12:38:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id yhA2ui6kauT6; Mon, 16 Jun 2025 12:38:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0DA3355C0CF; Mon, 16 Jun 2025 12:38:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0B766745682;
 Mon, 16 Jun 2025 12:38:36 +0200 (CEST)
Date: Mon, 16 Jun 2025 12:38:36 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Subject: Re: [PULL 70/72] ppc/amigaone: Add kernel and initrd support
In-Reply-To: <42af58ad-4e19-4d44-85d8-b78634af8cef@linaro.org>
Message-ID: <698f2718-8c95-445e-2ad1-d29f2c88a2d1@eik.bme.hu>
References: <20250311125815.903177-1-npiggin@gmail.com>
 <20250311125815.903177-71-npiggin@gmail.com>
 <42af58ad-4e19-4d44-85d8-b78634af8cef@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1427990379-1750070316=:42759"
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

--3866299591-1427990379-1750070316=:42759
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 16 Jun 2025, Philippe Mathieu-Daudé wrote:
> On 11/3/25 13:58, Nicholas Piggin wrote:
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>> 
>> Add support for -kernel, -initrd and -append command line options.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> Message-ID: 
>> <489b1be5d95d5153e924c95b0691b8b53f9ffb9e.1740673173.git.balaton@eik.bme.hu>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/ppc/amigaone.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 112 insertions(+), 1 deletion(-)
>> 
>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>> index 1c6f2a944d..359f5fa125 100644
>> --- a/hw/ppc/amigaone.c
>> +++ b/hw/ppc/amigaone.c
>
>
>> @@ -301,6 +362,56 @@ static void amigaone_init(MachineState *machine)
>>       }
>>       pci_ide_create_devs(PCI_DEVICE(object_resolve_path_component(via, 
>> "ide")));
>>       pci_vga_init(pci_bus);
>> +
>> +    if (!machine->kernel_filename) {
>> +        return;
>> +    }
>> +
>> +    /* handle -kernel, -initrd, -append options and emulate U-Boot */
>> +    bi = g_new0(struct boot_info, 1);
>> +    cpu->env.load_info = bi;
>> +
>> +    loadaddr = MIN(machine->ram_size, 256 * MiB);
>> +    bi->bd_info = loadaddr - 8 * MiB;
>> +    create_bd_info(bi->bd_info, machine->ram_size);
>> +    bi->stack = bi->bd_info - 64 * KiB - 8;
>> +
>> +    if (machine->kernel_cmdline && machine->kernel_cmdline[0]) {
>> +        size_t len = strlen(machine->kernel_cmdline);
>> +
>> +        loadaddr = bi->bd_info + 1 * MiB;
>> +        cpu_physical_memory_write(loadaddr, machine->kernel_cmdline, len + 
>> 1);
>
> This patch introduces a call to a legacy API (documented since at least
> 2017 in commit b7ecba0f6f6: "docs/devel/loads-stores.rst: Document our
> various load and store APIs").

It does not say deprecated but only if you're in a device you probably 
need something else as this implicitly operates on system address space 
and does not report errors. But we're in a machine here and there's 
nothing to be done for a failure which is not expected at this point.

> Can we load via &address_space_memory instead?

I guess we could but that would just make this line much longer and less 
readable. There are plenty of places using this still so unless it's about 
to be removed I'd leave it as it is. Get back to this when it's the last 
instance.

Regards,
BALATON Zoltan
--3866299591-1427990379-1750070316=:42759--

