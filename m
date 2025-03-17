Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA70BC28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 13:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuAHs-0008WB-Kk; Mon, 17 Mar 2025 09:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tuAHq-0008Tc-1o; Mon, 17 Mar 2025 09:13:46 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tuAHo-0004gI-1o; Mon, 17 Mar 2025 09:13:45 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 076604E601A;
 Mon, 17 Mar 2025 14:13:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4Eyc4qFoEAvr; Mon, 17 Mar 2025 14:13:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 185924E6014; Mon, 17 Mar 2025 14:13:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 15F8674577C;
 Mon, 17 Mar 2025 14:13:38 +0100 (CET)
Date: Mon, 17 Mar 2025 14:13:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] ppc/amigaone: Check blk_pwrite return value
In-Reply-To: <30852eb7-ef37-4da1-b014-ad4131d74c29@redhat.com>
Message-ID: <e183986d-6d2c-7fef-ac8b-9388241b32e0@eik.bme.hu>
References: <20250314200140.2DBE74E6069@zero.eik.bme.hu>
 <30852eb7-ef37-4da1-b014-ad4131d74c29@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1790025071-1742217218=:27327"
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

--3866299591-1790025071-1742217218=:27327
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 17 Mar 2025, Cédric Le Goater wrote:
> On 3/14/25 21:01, BALATON Zoltan wrote:
>> Coverity reported that return value of blk_pwrite() maybe should not
>> be ignored. We can't do much if this happens other than report an
>> error but let's do that to silence this report.
>> 
>> Resolves: Coverity CID 1593725
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/amigaone.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>> 
>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>> index 483512125f..5d787c3059 100644
>> --- a/hw/ppc/amigaone.c
>> +++ b/hw/ppc/amigaone.c
>> @@ -108,8 +108,8 @@ static void nvram_write(void *opaque, hwaddr addr, 
>> uint64_t val,
>>       uint8_t *p = memory_region_get_ram_ptr(&s->mr);
>
> why is the nvram never read ?

There's a comment about that. It's a rom_device which maps the memory 
region directly so does not go through the read callback. But I thin there 
must be a read callback and cannot be null so we have an empty one. 
Previously I had one that worked in case romd mode is turned off but Nick 
said having dead code is not wanted and better to mark it unreachable.

>>         p[addr] = val;
>> -    if (s->blk) {
>> -        blk_pwrite(s->blk, addr, 1, &val, 0);
>> +    if (s->blk && blk_pwrite(s->blk, addr, 1, &val, 0) < 0) {
>> +        error_report("%s: could not write %s", __func__, 
>> blk_name(s->blk));
>
> hmm, guest_error maybe ? since this is a runtime error.

It's not a guest error but some problem on the host with the backing file.

>>       }
>>   }
>>   @@ -151,15 +151,17 @@ static void nvram_realize(DeviceState *dev, Error 
>> **errp)
>>           *c = cpu_to_be32(CRC32_DEFAULT_ENV);
>>           /* Also copies terminating \0 as env is terminated by \0\0 */
>>           memcpy(p + 4, default_env, sizeof(default_env));
>> -        if (s->blk) {
>> -            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 
>> 0);
>> +        if (s->blk &&
>> +            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0) 
>> < 0
>> +           ) {
>> +            error_report("%s: could not write %s", __func__, 
>> blk_name(s->blk));
>
> This should use the errp parameter.
>
>>           }
>>           return;
>>       }
>>       if (*c == 0) {
>>           *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
>> -        if (s->blk) {
>> -            blk_pwrite(s->blk, 0, 4, p, 0);
>> +        if (s->blk && blk_pwrite(s->blk, 0, 4, p, 0) < 0) {
>> +            error_report("%s: could not write %s", __func__, 
>> blk_name(s->blk));
>
> same here.

It could but I think it's not needed. It still works without the backing 
file and the guest works, just may not save the NVRAM contents which is a 
problem on the host. So the error is reported but I'm not sure it should 
abort. In practice if there's some fatal error with the backing file the

blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                      BLK_PERM_ALL, &error_fatal);

earlier will catch that so it won't even get here.

Regards,
BALATON Zoltan
--3866299591-1790025071-1742217218=:27327--

