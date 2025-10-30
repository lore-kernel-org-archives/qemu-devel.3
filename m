Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1EDCCF9F1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 10:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEPul-0005sv-E2; Thu, 30 Oct 2025 06:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEPug-0005sa-9l; Thu, 30 Oct 2025 06:29:50 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEPud-0005dD-1Q; Thu, 30 Oct 2025 06:29:50 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 91B885972E4;
 Thu, 30 Oct 2025 11:29:40 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id JzLKmNOGYRjV; Thu, 30 Oct 2025 11:29:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8897D5972E3; Thu, 30 Oct 2025 11:29:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 868065972E8;
 Thu, 30 Oct 2025 11:29:38 +0100 (CET)
Date: Thu, 30 Oct 2025 11:29:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
In-Reply-To: <2dc5e0d6-2b98-49d6-99ef-8969d58a02ed@ilande.co.uk>
Message-ID: <d7bbe400-f404-81c7-a2c9-c1109720ae8d@eik.bme.hu>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
 <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
 <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
 <28c6f065-ba8d-e5e2-922e-d5fd1fb58b60@eik.bme.hu>
 <db06bf5e-b7f5-4980-a054-393529e188eb@rsg.ci.i.u-tokyo.ac.jp>
 <759b6b4c-1155-184a-fa99-1df384f0fac3@eik.bme.hu>
 <cad75a33-ddc0-6fbc-c7e9-68e05877213c@eik.bme.hu>
 <2dc5e0d6-2b98-49d6-99ef-8969d58a02ed@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-973429279-1761820178=:43010"
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

--3866299591-973429279-1761820178=:43010
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 30 Oct 2025, Mark Cave-Ayland wrote:
> On 29/10/2025 13:25, BALATON Zoltan wrote:
>> On Wed, 29 Oct 2025, BALATON Zoltan wrote:
>>> On Wed, 29 Oct 2025, Akihiko Odaki wrote:
>>>> On 2025/10/29 6:28, BALATON Zoltan wrote:
>>>>> On Wed, 29 Oct 2025, Akihiko Odaki wrote:
>>>>>> On 2025/10/28 21:59, BALATON Zoltan wrote:
>>>>>>> On Tue, 28 Oct 2025, Philippe Mathieu-Daudé wrote:
>>>>>>>> On 27/10/25 20:47, BALATON Zoltan wrote:
>>>>>>>>> On Mon, 27 Oct 2025, Philippe Mathieu-Daudé wrote:
>>>>>>>>>> On 25/10/25 01:31, BALATON Zoltan wrote:
>>>>>>>>>>> These memory windows are a result of the address decoding in the
>>>>>>>>>>> Articia S north bridge so better model it there and not in board 
>>>>>>>>>>> code.
>>>>>>>>>>> 
>>>>>>>>>>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>>>>>>> ---
>>>>>>>>>>>   hw/pci-host/articia.c | 15 ++++++++++++++-
>>>>>>>>>>>   hw/ppc/amigaone.c     | 28 +++++-----------------------
>>>>>>>>>>>   hw/ppc/pegasos2.c     | 13 -------------
>>>>>>>>>>>   3 files changed, 19 insertions(+), 37 deletions(-)
>>>>>>>>>> 
>> [...]
>>> It looks like we won't be able to come to an agreement before the freeze 
>>> and I don't have time now to change this patch but don't want to miss the 
>>> release with this series that finishes pegasos renaming because of this. 
>>> So for this patch I'd say since this is already how it is now and it does 
>>> not make it worse and this object is not user creatable anyway so cannot 
>>> leak please take it as it is and we'll do a clean up later after we finish 
>>> discussion.
>> 
>> As for all of these files I'm the maintainer let me make an executive 
>> decision here to keep this patch without Philippe's reviewed-by for now to 
>> be able to move on with this series before the freeze. Fixing the 
>> theoretical leak can be done on top and since that's a fix it can be done 
>> during soft freeze that would give us more time. So Harsh please go ahead 
>> and merge this series too if there are no other concerns. I'll then address 
>> this later together with other similar issues elsewhere.
>
> I think the issue here is that several people have now raised concerns as to 
> the way you are trying to use MemoryRegions (both here and in the raven 
> series): simply put, if reviewers didn't see any problems with this approach, 
> your series would already have review tags.

I got that and did not mean to ignore those comments forever.

> If you want to suggest a different approach to managing MemoryRegions, then I 
> would suggest you send a proposal to the mailing list so it can be reviewed 
> by the QOM and memory people (along with updated code style documentation so

That's what I plan to do but got no time right now.

> we can all use it). But with freeze coming up in a few days this is certainly 
> out of scope for 10.2.

That's why I proposed to take this patch for now as it only moves existing 
code to another place so it does not introduce a new problem that's not 
already there. And the problem is theoretical as it does not cause a leak 
in this case and nobody raised concerns so far and it was only noticed by 
this patch making it clearer removing duplicated code. So I still think 
this patch has merit, it helped to find a bug and would make code simpler 
without making it worse so it could be taken for that. But I'm OK with 
dropping it too, I'll include it again in the series with the other 
proposed changes to fix the problem.

> For now I would suggest the easiest way to get review tags is to stick with 
> the existing inline MemoryRegion approach for 10.2 to aid getting your 
> patches merged: it's simply not fair to put time pressure on Harsh to merge 
> patches in this way.

I'm not putting time pressure on Harsh, the coming freeze does and I don't 
have time right now to change patches only later but I don't want to miss 
a release again. I've already submitted these pegasos1 emulation series 
for the previous release but due to missing maintainer it was missed then. 
I think it's now resolved by dropping this patch and taking the rest of 
the series which is fine with me. Thanks everybody for the reviews and 
help. I'll prepare patches to resolve concerns when I'll have time again.

Regards,
BALATON Zoltan
--3866299591-973429279-1761820178=:43010--

