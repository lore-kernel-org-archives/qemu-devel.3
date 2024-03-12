Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEECC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjyv0-0006jC-OW; Tue, 12 Mar 2024 05:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rjyux-0006dn-M6; Tue, 12 Mar 2024 05:59:31 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rjyuv-0000Wg-Gx; Tue, 12 Mar 2024 05:59:31 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 356894E601D;
 Tue, 12 Mar 2024 10:59:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ugo4rQ0hCfa0; Tue, 12 Mar 2024 10:59:25 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3DA8C4E6006; Tue, 12 Mar 2024 10:59:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3B1867456B4;
 Tue, 12 Mar 2024 10:59:25 +0100 (CET)
Date: Tue, 12 Mar 2024 10:59:25 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Benjamin Gray <bgray@linux.ibm.com>
Subject: Re: [PATCH 06/13] ppc/spapr: Add pa-features for POWER10 machines
In-Reply-To: <CZRI248HGG4Y.2KVSZ18AGD6CA@wheely>
Message-ID: <17ed9bd3-61ed-a7f4-4ecb-5990ab585539@eik.bme.hu>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-7-npiggin@gmail.com>
 <020a53d8-3b90-4b30-b0c7-862951fbef43@linaro.org>
 <ef4c48d1-9e11-d6af-d4cc-3ae6c567f098@eik.bme.hu>
 <CZRI248HGG4Y.2KVSZ18AGD6CA@wheely>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-630685081-1710237565=:57611"
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

--3866299591-630685081-1710237565=:57611
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 12 Mar 2024, Nicholas Piggin wrote:
> On Tue Mar 12, 2024 at 7:07 AM AEST, BALATON Zoltan wrote:
>> On Mon, 11 Mar 2024, Philippe Mathieu-Daudé wrote:
>>> On 11/3/24 19:51, Nicholas Piggin wrote:
>>>> From: Benjamin Gray <bgray@linux.ibm.com>
>>>>
>>>> Add POWER10 pa-features entry.
>>>>
>>>> Notably DEXCR and and [P]HASHST/[P]HASHCHK instruction support is
>>>> advertised. Each DEXCR aspect is allocated a bit in the device tree,
>>>> using the 68--71 byte range (inclusive). The functionality of the
>>>> [P]HASHST/[P]HASHCHK instructions is separately declared in byte 72,
>>>> bit 0 (BE).
>>>>
>>>> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
>>>> [npiggin: reword title and changelog, adjust a few bits]
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>> ---
>>>>   hw/ppc/spapr.c | 34 ++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 34 insertions(+)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 247f920f07..128bfe11a8 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -265,6 +265,36 @@ static void spapr_dt_pa_features(SpaprMachineState
>>>> *spapr,
>>>>           /* 60: NM atomic, 62: RNG */
>>>>           0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
>>>>       };
>>>> +    /* 3.1 removes SAO, HTM support */
>>>> +    uint8_t pa_features_31[] = { 74, 0,
>>>
>>> Nitpicking because pre-existing, all these arrays could be static const.
>>
>> If we are at it then maybe also s/0x00/   0/ because having a stream of
>> 0x80 and 0x00 is not the most readable.
>
> Eh, it's more readable because it aligns colums.

Not sure it you've noticed the 3 spaces before the 0 replacing 0x0 that 
would keep alignment. But it's not something that needs to be changed just 
commented on it as it came up but I don't expect it to be done now on the 
day of the freeze. It's more important to get the already reviewed and 
queued patches in a pull request to not miss the release. So this comment 
is just for the fuuture.

Regards,
BALATON Zoltan

> But probably better
> more readable and  less error prone would be like -
>
>    PA_FEATURE_SET(pa_features_31,  6, 0); /* DS207 */
>    PA_FEATURE_SET(pa_features_31, 18, 0); /* Vector scalar */
>
> I just didn't quite find something I like yet. I won't change style
> before adding the missing bits either way, but certainly would be
> good to clean it up after.
>
> Thanks,
> Nick
>
>
--3866299591-630685081-1710237565=:57611--

