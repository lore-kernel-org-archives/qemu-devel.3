Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B202FFD7073
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Rb6-0001Ew-0P; Tue, 17 Mar 2026 06:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2Rb4-0001El-Nn
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:24:22 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2Rb2-0003wC-JD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:24:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E8852596A4F;
 Tue, 17 Mar 2026 11:24:18 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Hc3Gb7PIiblp; Tue, 17 Mar 2026 11:24:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E1728596A47; Tue, 17 Mar 2026 11:24:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DFCF6596A4C;
 Tue, 17 Mar 2026 11:24:16 +0100 (CET)
Date: Tue, 17 Mar 2026 11:24:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/display/tcx: Init memory regions in realize
In-Reply-To: <3e9fddbc-2a2c-4163-09b2-8c29048bfc9e@eik.bme.hu>
Message-ID: <a6e7e27c-5fe7-5451-d793-e746719014d8@eik.bme.hu>
References: <20260316130651.5C8735968DE@zero.eik.bme.hu>
 <abgqjKVFHKxuKupP@x1.local> <812f2a8d-f6bb-f127-a3f9-4629de5a03e5@eik.bme.hu>
 <abh2ZdpzQNepUTIy@x1.local> <ebd251c9-a1d1-4956-af11-ae9858e76254@eik.bme.hu>
 <afa7d52b-7087-4256-996a-b8ca7b2bfb95@redhat.com>
 <035415da-97a1-4929-8e7f-f982acd8d044@redhat.com>
 <3e9fddbc-2a2c-4163-09b2-8c29048bfc9e@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1250848873-1773743056=:98342"
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

--3866299591-1250848873-1773743056=:98342
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 17 Mar 2026, BALATON Zoltan wrote:
> On Tue, 17 Mar 2026, Thomas Huth wrote:
>> On 17/03/2026 06.41, Thomas Huth wrote:
>>> On 16/03/2026 23.30, BALATON Zoltan wrote:
>>>> On Mon, 16 Mar 2026, Peter Xu wrote:
>>>>> On Mon, Mar 16, 2026 at 07:10:05PM +0100, BALATON Zoltan wrote:
>>>>>> On Mon, 16 Mar 2026, Peter Xu wrote:
>>>>>>> On Mon, Mar 16, 2026 at 02:06:51PM +0100, BALATON Zoltan wrote:
>>>>>>>> Due to aux-ram-share property qemu_ram_alloc_internal dereferences
>>>>>>>> current_machine which is not set during init when inspecting the
>>>>>>>> device. This causes the qtest/device-introspect-test to fail since a
>>>>>>> 
>>>>>>> Does it has anything to do with aux-ram-share?  I thought it's because 
>>>>>>> the
>>>>>>> qom introspect test will create yet another sun-tcx device, causing 
>>>>>>> double
>>>>>>> registration?
>>>>>> 
>>>>>> I could reproduce it like this:
>>>>> 
>>>>> I would treat this one a separate bug, because it doesn't look special 
>>>>> to
>>>>> sparc systems.
>>>> 
>>>> I thought this is the issue Thomas has reported. I found this command by 
>>>> looking at what the test does but looks like this gets a different error 
>>>> but the fix is the same.
>>> 
>>> It's slightly different. The bug that I found via the device introspection 
>>> test is using "-M SS-20" and then it's crashing when a second sun-tcx 
>>> device is instantiated.
>>> The bug that you found is crashing because using "-device sun-tcx,help" 
>>> instantiates the device for introspection before the machine has been 
>>> created, so code that dereferences current_machine is running into a NULL 
>>> pointer related segmentation fault.
>> 
>> By the way, "qemu-system-sparc -device cgthree,help" crashes in the same 
>> way.
>
> OK, I'll send a v2 fixing that and updating the commit message to mention 
> both issues.

Looks like you were faster, Then I won't do it.

Regards,
BALATON Zoltan
--3866299591-1250848873-1773743056=:98342--

