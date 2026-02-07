Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D70EE0AC4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 11:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vogJS-0000eB-JZ; Sat, 07 Feb 2026 06:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vogJM-0000dp-VP; Sat, 07 Feb 2026 06:17:12 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vogJE-0008Ps-94; Sat, 07 Feb 2026 06:17:06 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B6311596E8E;
 Sat, 07 Feb 2026 12:16:57 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id rSDwpq0xSpmV; Sat,  7 Feb 2026 12:16:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 90CC1596E89; Sat, 07 Feb 2026 12:16:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8EFC9596A0D;
 Sat, 07 Feb 2026 12:16:55 +0100 (CET)
Date: Sat, 7 Feb 2026 12:16:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Sergei Heifetz <heifetz@yandex-team.com>
cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org
Subject: Re: [PATCH 3/4] system/physmem.c: reorder usage and assertion of block
In-Reply-To: <14605571-e078-4d93-9f0b-411889a70076@yandex-team.com>
Message-ID: <724854d5-7c26-0fc1-dfb5-4050b58122da@eik.bme.hu>
References: <20260204075754.21078-1-heifetz@yandex-team.com>
 <20260204075754.21078-4-heifetz@yandex-team.com>
 <722eb7df-0eb2-49c1-af07-90004ad46a8e@vivier.eu>
 <14605571-e078-4d93-9f0b-411889a70076@yandex-team.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-355140030-1770463015=:51054"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-355140030-1770463015=:51054
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 7 Feb 2026, Sergei Heifetz wrote:
> On 2/4/26 17:53, Laurent Vivier wrote:
>> Le 04/02/2026 à 08:57, Sergei Heifetz a écrit :
>>> Reorder the code so the assertion of block occurs before it is
>>> used in the subsequent lines.
>>> 
>>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>>> ---
>>>   system/physmem.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index b0311f4531..4308e02940 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -2054,11 +2054,11 @@ static int memory_try_enable_merging(void *addr, 
>>> size_t len)
>>>    */
>>>   int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>>>   {
>>> +    assert(block);
>>> +
>>>       const ram_addr_t oldsize = block->used_length;
>>>       const ram_addr_t unaligned_size = newsize;
>>>   -    assert(block);
>>> -
>> 
>> According to coding style (docs/devel/style.rst):
>> 
>> Mixed declarations (interleaving statements and declarations within
>> blocks) are generally not allowed.
>> 
>>>       newsize = TARGET_PAGE_ALIGN(newsize);
>>>       newsize = REAL_HOST_PAGE_ALIGN(newsize);
>> 
>> Thanks,
>> Laurent
>
> Should I remove the assertion altogether, then? I think the const qualifier 
> on oldsize is more useful than the assertion.

What does the const qualifier have to do with dereferencing block when 
it's NULL? You'd just need to split the line as:

int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
{
    const ram_addr_t oldsize;
    const ram_addr_t unaligned_size = newsize;

    assert(block);
    oldsize = block->used_length;

How is that not obvious? The commit message also does not say why do you 
want to change this. How did you come up with this patch, what issue does 
it fix when block is NULL here?

Regards,
BALATON Zoltan
--3866299591-355140030-1770463015=:51054--

