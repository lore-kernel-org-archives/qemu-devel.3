Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6FE606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR8LL-0003VM-Jq; Wed, 11 Nov 2026 08:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xR8LJ-0003Up-Rl
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:26:25 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xR8LH-00068T-3u
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:26:25 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E0E9F60C34D;
 Wed, 11 Nov 2026 14:26:17 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id FnTDjEwMVKCX; Wed, 11 Nov 2026 14:26:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C9C4660C072; Wed, 11 Nov 2026 14:26:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C79C613991F;
 Wed, 11 Nov 2026 14:26:15 +0100 (CET)
Date: Wed, 11 Nov 2026 14:26:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Keith Monahan <keith@techtravels.org>
cc: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] ncr53c710_v2: add new NCR53C710 chipset driver
In-Reply-To: <428ad8c7-d2ed-4183-aa49-f24057977c1d@techtravels.org>
Message-ID: <36c03687-2e72-27c3-184f-4cb08e6c9cc8@eik.bme.hu>
References: <20261106221818.139086-1-deller@kernel.org>
 <20261106221818.139086-3-deller@kernel.org>
 <94ff409d-d896-c4fb-0550-0ffc77cd1006@eik.bme.hu>
 <e3ad4417-8310-42c7-824d-31d60c7221a9@gmx.de>
 <7cc6f66d-59f6-5ff7-7b60-bb6d115e9f10@eik.bme.hu>
 <428ad8c7-d2ed-4183-aa49-f24057977c1d@techtravels.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2045007712-1794403575=:61932"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2045007712-1794403575=:61932
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hello,

On Tue, 10 Nov 2026, Keith Monahan wrote:
> Hi Zoltan,
>
>
> On 11/8/2026 8:01 AM, BALATON Zoltan wrote:
>> On Sun, 8 Nov 2026, Helge Deller wrote:
>>> Hello Balaton,
>>> 
>>> On 11/8/26 12:43, BALATON Zoltan wrote:
>>>> On Fri, 6 Nov 2026, Helge Deller wrote:
>>>>> From: Helge Deller <deller@gmx.de>
>>>>> 
>>>>> This adds a new driver for the NC53C710 chipset. This drover is based on 
>>>>> the
>>>>> lsi53c895a driver, and thus avoids many issues of the existing ncr53c710
>>>>> driver, which was written from scratch.
>>>> 
>>>> There's a typo "drover" above.
>>> 
>>> Thanks! I'll fix it the next round.
>>> 
>>>> I asked this before but would it be possible to modify lsi53c895a.c
>>>> to also emulate the 53c710 too instead of duplicating code?
>>> 
>>> Maybe. At least in theory: Probably.
>>> 
>>>> This device model is almost the same as the 53c895a or at least a
>>>> large part is shared but it's not easy to see that as it uses
>>>> different names for the same structures and functions. It would be
>>>> better to at least split the reused struct definitions from 53c895a
>>>> into a shared header and use that here. Then compare what are the
>>>> differences between the functions and see if the common parts could
>>>> either be split into a common super class or if the differences are
>>>> small enough to just add conditionals in lsi53c895a.c to also emulate 
>>>> 53c710 with most of the code shared instead of duplicated.
>>> Well, this is a lot of work.
>>> And I'm not sure if you gain that much from that exercise.
>> 
>> OK but at least using a common header should not be that much work and 
>> would reduce the differences and make the two device models more easily 
>> comparable.
>> 
>>> If you are a person which really want to know all differences between
>>> those two SCSI chips then this is most likely a very interesting project.
>>> But I fail to see someone who volunteers for this, who has the time and
>>> interest to really do this and who still guarantees he will not break the 
>>> lsi53c895a.
>> 
>> I'm not sure what is the state of AI usage discussion but might also be a 
>> project to try an AI agent with.
>> 
>>> Looking at the Linux kernel, there are lots of different drivers driving
>>> all various variants of those SCSI chips. The 710 was one of the earlier
>>> SCSI chips (e.g. ISA bus, no PCI,...) while the 53c895a is a newer chip
>>> for PCI.
>> 
>> That's a diference in inteface but if the chip otherwise is the same or 
>> very similar it would be more easily modelled as a super class implementing 
>> the SCSI things and two subclasses embedding it one ISADevice and the other 
>> PCIDevice with the parts that's specific to the interface belonging to 
>> those child classes. That way there would be no code duplication.
>> 
>> In any case if there's code duplication then try not to make it worse by 
>> renaming everthing but keep the names and shared structs at least the same 
>> so it can be more easily compared and to what's different. That might also 
>> come in handy when there's a fix in one device that could be applied to the 
>> other too.
>
>
> Right now, HP-UX (both 9.05 and 10.20) can't boot at all on the HP 715. The 
> new model has been tested extensively, so we're keen to get this working for 
> everyone.
>
> You're right that it's hard to see how the two models relate when the shared 
> pieces don't line up. Before I start, here is what I understand you'll accept 
> for this patch series:
>
> I'll move the shared definitions into a common header:
>
> * request struct
> * waiting and message-action enums
> * SCSI phase constants
> * register-bit defines that are common.
>
> Both drivers will include that header. The 710 driver will use the same names 
> as the 895 for the shared definitions. This enables the two to be compared

Yes, that's what I thought that it's not much additional work and would 
reduce code duplication so at least these shared parts could be split in a 
common header used by both models instead of duplicating everthing in the 
710 model.

You could even keep the same names for static functions and not prefix 
them with ncr710_ in the new model. As these are static they don't clash 
between different files but keeping the same name helps with comparing. 
Although the lsi53c895a.c uses lsi_ prefix and the 710 predates when NCR 
became LSI that probably does not matter much so I'd just keep everyting 
with lsi_ prefix so the common header could be called lsi_scsi.h or 
something like that and note in a comment that NCR chips use the same as 
that's the origin of LSI SCSI. The goal is to make the two models as much 
similar as possible to be easy to see the differences by comparing them.

> side by side, and fixes can be carried between them.
>
> The nice part about this approach is that the generated code on the 895 would 
> be identical, when compared properly, so there shouldn't be any behavior 
> changes to test, beyond basic smoke tests.

Yes, just splitting out the common parts to a header and reusing them 
should not break the 895 and it's easy to review so that should be easily 
doable.

> And we'll make sure the MAINTAINERS entry is correct, so we get proper 
> notification for changes.
>
> This would be the scope of this series: the 710 stays its own device model. 
> If the header shows the remaining differences are small, I’m open to 
> revisiting a common base class later.

Trying to unify the two models more can be done later in separate series 
if somebody wants to, the above common code reuse should make it easier to 
see what would be needed for that and if it's worth going further.

> Does this address your concern?

Yes, I think that's all I wanted to say in my review comments. Thank you.

Regards,
BALATON Zoltan
--3866299591-2045007712-1794403575=:61932--

