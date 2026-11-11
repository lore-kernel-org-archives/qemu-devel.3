Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690C606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=techtravels.org header.i=@techtravels.org header.a=rsa-sha256 header.s=s1175899 header.b=UupTtIVV;
	dkim=pass (2048-bit key, unprotected) header.d=techtravels.org header.i=@techtravels.org header.a=rsa-sha256 header.s=mail header.b=kg0rRf85
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQys0-00050d-SS; Tue, 10 Nov 2026 22:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.uqq97ogcnecitk3=k18y31b59h7i=7j11zvcgaggq1p@em1175899.techtravels.org>)
 id 1xQyrx-00050S-PM
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:19:29 -0500
Received: from a5i226.smtp2go.com ([170.10.71.226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.uqq97ogcnecitk3=k18y31b59h7i=7j11zvcgaggq1p@em1175899.techtravels.org>)
 id 1xQyrv-00057w-K7
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1794367157; h=from :
 subject : to : message-id : date : list-unsubscribe :
 list-unsubscribe-post;
 bh=FexfsxHBBxCQfVqYkqBmG04/qA1SzPhFXqh989t55Vw=;
 b=UupTtIVVHhqtJtJmGB5BSahPWhF4P0X8slbKKVmytE8GPtdWNQsqXsBaPya+mIdt3piXE
 LxHuw5RMVOj6yNpmIbuEKse1tYgv2hhNntmzjWBL6UQE2LMRDO3ddhWejJ3Vj4W2qICMFGm
 qeAhqUxHYm38aCH3uDB7qg5qyQ11AM9h/9aTKn+DbweI3OxBzROOU91LB56xW5La+FO3dEo
 +Q8aj28UCOc3Af+mubmkWqGrAX6InwNy0lNVLf9UHQb/d8yHrlRvJJzCNustDXBpV6AP88p
 G4HY9+s5zgwKUMpdI9DqaqalqcYdBLLAcFeNQyqptYL8m4gw8ZYXIDNJRyVQ==
Received: from [10.91.249.253] (helo=boxtwo.techtravels.org)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256:X25519)
 (Exim 4.100.1) (envelope-from <keith@techtravels.org>)
 id 1xQyre-FnQW0hQ1i77-v9zr; Wed, 11 Nov 2026 03:19:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=techtravels.org;
 s=mail; t=1794367148;
 bh=LaUX9qlTYdkRBlQ8LEfAQcNv+MSr7ibFachlwsM3sOE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kg0rRf85GrItik5C3WquV4gEY3SdEU8VwpRfvOA+ngyHoJM4sD+6bdi+j1F0caitn
 Ug9xVn8dB2kHcuksPvI7PX+UKtXoCpS/H8yalgrrEiJrfUngEdzeGERzt07B5Sb98t
 lboqsIWxEO+Y03t16c1qkjoXIg78KFHEfu73Ll4lbfIOzFVMmLqCZX8IDPlYKbeMHj
 cR4BdpFVrP3M2wKRWUJbEkJnIHBcLlRM+KlO6zKcdhqXCqBYS1qRXXLL80eCb9+2UM
 JZF/qM2GbWSDTCmyoOqUCqTQfZkZnPDNmW3Ur9sOdwNLk7RAHKE0G080WFx0FxOGQl
 z+yr1qPQgOApQ==
Received: from authenticated-user (boxtwo.techtravels.org [54.196.37.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by boxtwo.techtravels.org (Postfix) with ESMTPSA id 181A73F9D8;
 Tue, 10 Nov 2026 22:19:08 -0500 (EST)
Message-ID: <428ad8c7-d2ed-4183-aa49-f24057977c1d@techtravels.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aieqF3d:1175899sn3nOtgvgp
X-smtpcorp-track: Otd_KXJ52ZNb.TpaO-aOrnBnH.jF0vughvs25
Date: Tue, 10 Nov 2026 22:19:07 -0500
Subject: Re: [PATCH 2/4] ncr53c710_v2: add new NCR53C710 chipset driver
To: BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, Peter Maydell
 <peter.maydell@linaro.org>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261106221818.139086-1-deller@kernel.org>
 <20261106221818.139086-3-deller@kernel.org>
 <94ff409d-d896-c4fb-0550-0ffc77cd1006@eik.bme.hu>
 <e3ad4417-8310-42c7-824d-31d60c7221a9@gmx.de>
 <7cc6f66d-59f6-5ff7-7b60-bb6d115e9f10@eik.bme.hu>
From: Keith Monahan <keith@techtravels.org>
In-Reply-To: <7cc6f66d-59f6-5ff7-7b60-bb6d115e9f10@eik.bme.hu>
Received-SPF: pass client-ip=170.10.71.226;
 envelope-from=bounce.uqq97ogcnecitk3=k18y31b59h7i=7j11zvcgaggq1p@em1175899.techtravels.org;
 helo=a5i226.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Zoltan,


On 11/8/2026 8:01 AM, BALATON Zoltan wrote:
> On Sun, 8 Nov 2026, Helge Deller wrote:
>> Hello Balaton,
>>
>> On 11/8/26 12:43, BALATON Zoltan wrote:
>>> On Fri, 6 Nov 2026, Helge Deller wrote:
>>>> From: Helge Deller <deller@gmx.de>
>>>>
>>>> This adds a new driver for the NC53C710 chipset. This drover is 
>>>> based on the
>>>> lsi53c895a driver, and thus avoids many issues of the existing 
>>>> ncr53c710
>>>> driver, which was written from scratch.
>>>
>>> There's a typo "drover" above.
>>
>> Thanks! I'll fix it the next round.
>>
>>> I asked this before but would it be possible to modify lsi53c895a.c
>>> to also emulate the 53c710 too instead of duplicating code?
>>
>> Maybe. At least in theory: Probably.
>>
>>> This device model is almost the same as the 53c895a or at least a
>>> large part is shared but it's not easy to see that as it uses
>>> different names for the same structures and functions. It would be
>>> better to at least split the reused struct definitions from 53c895a
>>> into a shared header and use that here. Then compare what are the
>>> differences between the functions and see if the common parts could
>>> either be split into a common super class or if the differences are
>>> small enough to just add conditionals in lsi53c895a.c to also emulate 
>>> 53c710 with most of the code shared instead of duplicated.
>> Well, this is a lot of work.
>> And I'm not sure if you gain that much from that exercise.
> 
> OK but at least using a common header should not be that much work and 
> would reduce the differences and make the two device models more easily 
> comparable.
> 
>> If you are a person which really want to know all differences between
>> those two SCSI chips then this is most likely a very interesting project.
>> But I fail to see someone who volunteers for this, who has the time and
>> interest to really do this and who still guarantees he will not break 
>> the lsi53c895a.
> 
> I'm not sure what is the state of AI usage discussion but might also be 
> a project to try an AI agent with.
> 
>> Looking at the Linux kernel, there are lots of different drivers driving
>> all various variants of those SCSI chips. The 710 was one of the earlier
>> SCSI chips (e.g. ISA bus, no PCI,...) while the 53c895a is a newer chip
>> for PCI.
> 
> That's a diference in inteface but if the chip otherwise is the same or 
> very similar it would be more easily modelled as a super class 
> implementing the SCSI things and two subclasses embedding it one 
> ISADevice and the other PCIDevice with the parts that's specific to the 
> interface belonging to those child classes. That way there would be no 
> code duplication.
> 
> In any case if there's code duplication then try not to make it worse by 
> renaming everthing but keep the names and shared structs at least the 
> same so it can be more easily compared and to what's different. That 
> might also come in handy when there's a fix in one device that could be 
> applied to the other too.


Right now, HP-UX (both 9.05 and 10.20) can't boot at all on the HP 715. 
The new model has been tested extensively, so we're keen to get this 
working for everyone.

You're right that it's hard to see how the two models relate when the 
shared pieces don't line up. Before I start, here is what I understand 
you'll accept for this patch series:

I'll move the shared definitions into a common header:

* request struct
* waiting and message-action enums
* SCSI phase constants
* register-bit defines that are common.

Both drivers will include that header. The 710 driver will use the same 
names as the 895 for the shared definitions. This enables the two to be 
compared side by side, and fixes can be carried between them.

The nice part about this approach is that the generated code on the 895 
would be identical, when compared properly, so there shouldn't be any 
behavior changes to test, beyond basic smoke tests.

And we'll make sure the MAINTAINERS entry is correct, so we get proper 
notification for changes.

This would be the scope of this series: the 710 stays its own device 
model. If the header shows the remaining differences are small, I’m open 
to revisiting a common base class later.

Does this address your concern?

Thanks,
Keith

> 
> Regards,
> BALATON Zoltan
> 
>>> A somewhat complex example of such code sharing is hw/isa/vt82c686.c
>>> which uses a common super class or hw/display/ati.c which has
>>> conditionals to emulate simlar devices. I was thinking about such
>>> code sharing would be possible for these devices too to avoid code
>>> duplication that can diverge in the future.
>>
>> Yes, generally I prefer code sharing too.
>> But in this case the 710 is currently only used by the parisc emulation
>> (and might be used by one or two old historic non-x86 arches maybe too).
>>
>> Helge
>>
>>


