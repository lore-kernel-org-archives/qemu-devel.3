Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92480FD2D6E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 12:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzwVU-0006bZ-C7; Tue, 10 Mar 2026 08:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzwVD-0005dV-8L
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:48:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzwVB-0003Fw-OQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:47:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 19AD65969EC;
 Tue, 10 Mar 2026 13:47:56 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Fsy9AT6B7iUN; Tue, 10 Mar 2026 13:47:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CDB9E596A41; Tue, 10 Mar 2026 13:47:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CBD0E596A13;
 Tue, 10 Mar 2026 13:47:53 +0100 (CET)
Date: Tue, 10 Mar 2026 13:47:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Chad Jablonski <chad@jablonski.xyz>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] ati-vga: Fix sign extension in DEFAULT_SC_BOTTOM_RIGHT
 read
In-Reply-To: <18a50a29-1deb-41c5-91f1-ae5f76129a05@linaro.org>
Message-ID: <9233d54a-1a95-0cc9-c118-9c557b8bae4b@eik.bme.hu>
References: <20260309212206.2457691-1-chad@jablonski.xyz>
 <1931a6d0-d351-cc43-1b3d-fa3b3b0809a9@eik.bme.hu>
 <e2824e5c-4d1d-4d08-ba24-a8c3056c2edc@linaro.org>
 <de83d589-99c0-9d40-b29e-61f8deb3d249@eik.bme.hu>
 <18a50a29-1deb-41c5-91f1-ae5f76129a05@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-117789527-1773146873=:57328"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--3866299591-117789527-1773146873=:57328
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 10 Mar 2026, Philippe Mathieu-Daudé wrote:
> On 9/3/26 23:59, BALATON Zoltan wrote:
>> On Mon, 9 Mar 2026, Philippe Mathieu-Daudé wrote:
>>> On 9/3/26 22:41, BALATON Zoltan wrote:
>>>> On Mon, 9 Mar 2026, Chad Jablonski wrote:
>>>>> Cast default_sc_bottom to uint32_t before shifting left to prevent
>>>>> sign extension when assigning to uint64_t.
>>>>> 
>>>>> Fixes: CID 1645615
>>>>> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
>>>>> ---
>>>>> hw/display/ati.c | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>> 
>>>>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>>>>> index 6cf243bcf9..f9773e1154 100644
>>>>> --- a/hw/display/ati.c
>>>>> +++ b/hw/display/ati.c
>>>>> @@ -514,7 +514,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr 
>>>>> addr, unsigned int size)
>>>>>         val |= s->regs.default_tile << 16;
>>>>>         break;
>>>>>     case DEFAULT_SC_BOTTOM_RIGHT:
>>>>> -        val = (s->regs.default_sc_bottom << 16) |
>>>>> +        val = ((uint32_t)s->regs.default_sc_bottom << 16) |
>>>>>               s->regs.default_sc_right;
>>> 
>>> What about using deposit64() which is uncontroversial?
>>> 
>>>            val = deposit64(s->regs.default_sc_right, 16,
>>>                            13, s->regs.default_sc_bottom);
>
> (alternatively deposit32)
>
>> I can't make sense of that without going and looking what the arguments of 
>> this function are so I'd rather keep it simple. As I said, the values here 
>> can't be large enough to sign extend and there may be other similar cases 
>> that are already marked in Coverity. But if we still want to fix all of 
>> them then maybe we could try to make val uint32_t then do something about 
>> it once at the return for all cases. That seems better than trying to 
>> handle in each case inconsistently. The simplest would still be to tell 
>> Converity it's wrong here.
>
> Until the next register is implemented and Coverity complains again,
> and another round-up on the mailing list until Peter manually marks it.
> I was hoping for a way to avoid all that hassle.

Changing local val to uint32_t and cast it at the last return line should 
also solve this if the issue is assigning to uint64_t without a cast. To 
me that seems better than making changes to every case separately and 
would allow me to avoid additional complexity. If you think it would help 
I can make a patch but I can't test it.

Regards,
BALATON Zoltan
--3866299591-117789527-1773146873=:57328--

