Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A46E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 01:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO5Zu-00067B-3X; Wed, 18 Dec 2024 20:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tO5Zr-00066d-DM; Wed, 18 Dec 2024 20:43:47 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tO5Zn-0000CQ-RC; Wed, 18 Dec 2024 20:43:46 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 18D4F4E603D;
 Thu, 19 Dec 2024 02:43:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 61uOT4suAI_u; Thu, 19 Dec 2024 02:43:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D68364E602D; Thu, 19 Dec 2024 02:43:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D4685757B1C;
 Thu, 19 Dec 2024 02:43:36 +0100 (CET)
Date: Thu, 19 Dec 2024 02:43:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 7/7] hw/ppc/epapr: Do not swap ePAPR magic value
In-Reply-To: <D6F93NM6OW2L.2FDO88L38PABR@gmail.com>
Message-ID: <6525790b-a637-e81c-1885-281b6c7e3d66@eik.bme.hu>
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-8-philmd@linaro.org>
 <277eeed4-0467-1529-f52d-2c128d8d46bb@eik.bme.hu>
 <D6F93NM6OW2L.2FDO88L38PABR@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-436307701-1734572616=:93270"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-436307701-1734572616=:93270
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 19 Dec 2024, Nicholas Piggin wrote:
> On Thu Dec 19, 2024 at 5:18 AM AEST, BALATON Zoltan wrote:
>> On Wed, 18 Dec 2024, Philippe Mathieu-Daudé wrote:
>>> The ePAPR magic value in $r6 doesn't need to be byte swapped.
>>>
>>> See ePAPR-v1.1.pdf chapter 5.4.1 "Boot CPU Initial Register State"
>>> and the following mailing-list thread:
>>> https://lore.kernel.org/qemu-devel/CAFEAcA_NR4XW5DNL4nq7vnH4XRH5UWbhQCxuLyKqYk6_FCBrAA@mail.gmail.com/
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> hw/ppc/sam460ex.c     | 2 +-
>>> hw/ppc/virtex_ml507.c | 2 +-
>>> 2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>>> index 78e2a46e753..db9c8f3fa6e 100644
>>> --- a/hw/ppc/sam460ex.c
>>> +++ b/hw/ppc/sam460ex.c
>>> @@ -234,7 +234,7 @@ static void main_cpu_reset(void *opaque)
>>>
>>>         /* Create a mapping for the kernel.  */
>>>         booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1 << 31);
>>> -        env->gpr[6] = tswap32(EPAPR_MAGIC);
>>> +        env->gpr[6] = EPAPR_MAGIC;
>>
>> I don't know how to test this (or if anything actually uses it).
>
> The Linux kernel boot wrapper tests it AFAIKS. Does this mean
> they never worked on LE hosts?

Linux boots on the sam460ex on LE host, I don't know if it works on BE 
host as I don't have any so this could be broken on BE host but should 
work on LE host. If this breaks Linux boot somebody may report it, I don't 
have time to try testing it now.

Regards,
BALATON Zoltan

>> not sure about is what endianness env->gpr is? It's a host array so maybe
>> it needs to match the host endianness which is little endian most of the
>> time as opposed to PPC big endian on this machine. So maybe tswap is wrong
>> but is removing it right? Maybe we need to only swap on LE hosts. I think
>> it's only used by Linux kernels so maybe trying to boot one could test
>> this change but I'm not sure.
>
> Yes env->gpr is host-endian, and emulated target code will see
> the same value that the host does. It can't be correct because
> the machine running in emulation can't possibly know what endian
> the host is.
>
> I think we should just take it, it looks trivially correct
> (always dangerous words when dealing with early boot code, lol).
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
>>
>> Regards,
>> BALATON Zoltan
>>
>>>         env->gpr[7] = (16 * MiB) - 8; /* bi->ima_size; */
>>>
>>>     } else {
>>> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
>>> index f378e5c4a90..6197d31d88f 100644
>>> --- a/hw/ppc/virtex_ml507.c
>>> +++ b/hw/ppc/virtex_ml507.c
>>> @@ -119,7 +119,7 @@ static void main_cpu_reset(void *opaque)
>>>     /* Create a mapping spanning the 32bit addr space. */
>>>     booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1U << 31);
>>>     booke_set_tlb(&env->tlb.tlbe[1], 0x80000000, 0x80000000, 1U << 31);
>>> -    env->gpr[6] = tswap32(EPAPR_MAGIC);
>>> +    env->gpr[6] = EPAPR_MAGIC;
>>>     env->gpr[7] = bi->ima_size;
>>> }
>>>
>>>
>
>
--3866299591-436307701-1734572616=:93270--

