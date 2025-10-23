Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B5ACCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBthe-0000CE-0i; Thu, 23 Oct 2025 07:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBthb-0000C2-JT; Thu, 23 Oct 2025 07:41:55 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBthY-0001Tx-E4; Thu, 23 Oct 2025 07:41:55 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B26175972E1;
 Thu, 23 Oct 2025 13:41:49 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id nVgUZyWee2Er; Thu, 23 Oct 2025 13:41:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AB4395972DE; Thu, 23 Oct 2025 13:41:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A9AC359703F;
 Thu, 23 Oct 2025 13:41:47 +0200 (CEST)
Date: Thu, 23 Oct 2025 13:41:47 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 08/12] hw/ppc/pegasos2: Move hardware specific parts
 out of machine reset
In-Reply-To: <0b12701a-827f-4f17-969b-5da124cd2e36@linux.ibm.com>
Message-ID: <3b16afc9-4a41-fde9-f16e-645dde8b7bb3@eik.bme.hu>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <f6633a68a72aad4fefb8d2373b52561f8ca8d41d.1761176219.git.balaton@eik.bme.hu>
 <ee9b01ab-fd91-453e-b1d3-1a91d9447a2a@linaro.org>
 <0b12701a-827f-4f17-969b-5da124cd2e36@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1110318835-1761219707=:4926"
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

--3866299591-1110318835-1761219707=:4926
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 23 Oct 2025, Harsh Prateek Bora wrote:
> On 10/23/25 12:16, Philippe Mathieu-Daudé wrote:
>> On 23/10/25 02:06, BALATON Zoltan wrote:
>>> Move the pegasos2 specific chipset reset out from machine reset to a
>>> separate function and move generic parts that are not pegasos2
>>> specific from build_fdt to machine reset so now build_fdt only
>>> contains pegasos2 specific parts and can be renamed accordingly.
>>> 
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/ppc/pegasos2.c | 79 ++++++++++++++++++++++++-----------------------
>>>   1 file changed, 41 insertions(+), 38 deletions(-)
>> 
>> 
>>> -#define PCI1_IO_BASE  0xfe000000
>> 
>> Can't we keep such definition?
>> 
>>> @@ -308,23 +307,12 @@ static void 
>>> pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
>>>   static void pegasos2_superio_write(uint8_t addr, uint8_t val)
>>>   {
>>> -    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f0, &addr, 1);
>>> -    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
>>> +    cpu_physical_memory_write(0xfe0003f0, &addr, 1);
>>> +    cpu_physical_memory_write(0xfe0003f1, &val, 1);
>> 
>> Otherwise it is harder to notice we are accessing the MMIO mapped ISA 
>> space.
>> 
>>>   }
>> Consider renaming as pegasos_superio_write() since this method becomes
>> common to PegasOS I and II.
>
> Thanks Philippe for reviewing the series.
>
> Hi BALATON,
> Would you mind addressing the above (and other?) review comments or I can 
> queue it in the interest of time if you can send a follow-up patch later?

I'll send another version of this series after rebasing the prep series. 
We still have time until the freeze begins so I think we can wait a few 
more days.

Thank you,
BALATON Zoltan

> Thanks
> Harsh
>
>> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> 
>
>
--3866299591-1110318835-1761219707=:4926--

