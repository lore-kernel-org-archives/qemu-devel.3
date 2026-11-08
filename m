Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF5B606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 13:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ2X9-0000p8-GK; Sun, 08 Nov 2026 08:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xQ2Wz-0000la-HR
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 08:01:58 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xQ2Wx-0007mf-DU
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 08:01:57 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5F28860C2B6;
 Sun, 08 Nov 2026 14:01:52 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id hSaLkKBA5lmL; Sun,  8 Nov 2026 14:01:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 50FFC60C0F3; Sun, 08 Nov 2026 14:01:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4F44B13991F;
 Sun, 08 Nov 2026 14:01:50 +0100 (CET)
Date: Sun, 8 Nov 2026 14:01:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Helge Deller <deller@gmx.de>
cc: Helge Deller <deller@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 Keith Monahan <keith@techtravels.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] ncr53c710_v2: add new NCR53C710 chipset driver
In-Reply-To: <e3ad4417-8310-42c7-824d-31d60c7221a9@gmx.de>
Message-ID: <7cc6f66d-59f6-5ff7-7b60-bb6d115e9f10@eik.bme.hu>
References: <20261106221818.139086-1-deller@kernel.org>
 <20261106221818.139086-3-deller@kernel.org>
 <94ff409d-d896-c4fb-0550-0ffc77cd1006@eik.bme.hu>
 <e3ad4417-8310-42c7-824d-31d60c7221a9@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Sun, 8 Nov 2026, Helge Deller wrote:
> Hello Balaton,
>
> On 11/8/26 12:43, BALATON Zoltan wrote:
>> On Fri, 6 Nov 2026, Helge Deller wrote:
>>> From: Helge Deller <deller@gmx.de>
>>> 
>>> This adds a new driver for the NC53C710 chipset. This drover is based on 
>>> the
>>> lsi53c895a driver, and thus avoids many issues of the existing ncr53c710
>>> driver, which was written from scratch.
>> 
>> There's a typo "drover" above.
>
> Thanks! I'll fix it the next round.
> 
>> I asked this before but would it be possible to modify lsi53c895a.c
>> to also emulate the 53c710 too instead of duplicating code?
>
> Maybe. At least in theory: Probably.
>
>> This device model is almost the same as the 53c895a or at least a
>> large part is shared but it's not easy to see that as it uses
>> different names for the same structures and functions. It would be
>> better to at least split the reused struct definitions from 53c895a
>> into a shared header and use that here. Then compare what are the
>> differences between the functions and see if the common parts could
>> either be split into a common super class or if the differences are
>> small enough to just add conditionals in lsi53c895a.c to also emulate 
>> 53c710 with most of the code shared instead of duplicated.
> Well, this is a lot of work.
> And I'm not sure if you gain that much from that exercise.

OK but at least using a common header should not be that much work and 
would reduce the differences and make the two device models more easily 
comparable.

> If you are a person which really want to know all differences between
> those two SCSI chips then this is most likely a very interesting project.
> But I fail to see someone who volunteers for this, who has the time and
> interest to really do this and who still guarantees he will not break the 
> lsi53c895a.

I'm not sure what is the state of AI usage discussion but might also be a 
project to try an AI agent with.

> Looking at the Linux kernel, there are lots of different drivers driving
> all various variants of those SCSI chips. The 710 was one of the earlier
> SCSI chips (e.g. ISA bus, no PCI,...) while the 53c895a is a newer chip
> for PCI.

That's a diference in inteface but if the chip otherwise is the same or 
very similar it would be more easily modelled as a super class 
implementing the SCSI things and two subclasses embedding it one ISADevice 
and the other PCIDevice with the parts that's specific to the interface 
belonging to those child classes. That way there would be no code 
duplication.

In any case if there's code duplication then try not to make it worse by 
renaming everthing but keep the names and shared structs at least the same 
so it can be more easily compared and to what's different. That might also 
come in handy when there's a fix in one device that could be applied to 
the other too.

Regards,
BALATON Zoltan

>> A somewhat complex example of such code sharing is hw/isa/vt82c686.c
>> which uses a common super class or hw/display/ati.c which has
>> conditionals to emulate simlar devices. I was thinking about such
>> code sharing would be possible for these devices too to avoid code
>> duplication that can diverge in the future.
>
> Yes, generally I prefer code sharing too.
> But in this case the 710 is currently only used by the parisc emulation
> (and might be used by one or two old historic non-x86 arches maybe too).
>
> Helge
>
>

