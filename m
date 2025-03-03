Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D395DC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp73K-0006Kq-JM; Mon, 03 Mar 2025 09:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp735-0006HR-9k
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:45:40 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp72z-0005QA-Sv
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:45:39 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 31D664E600E;
 Mon, 03 Mar 2025 15:45:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id NNMSsC8Hc5TM; Mon,  3 Mar 2025 15:45:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3C0324E6014; Mon, 03 Mar 2025 15:45:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3983F74577C;
 Mon, 03 Mar 2025 15:45:28 +0100 (CET)
Date: Mon, 3 Mar 2025 15:45:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host platforms
 only
In-Reply-To: <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
Message-ID: <7fc6c471-f4b4-5844-621a-1d4ac2d2835f@eik.bme.hu>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
 <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1300764181-1741013128=:65423"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--3866299591-1300764181-1741013128=:65423
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 3 Mar 2025, Philippe Mathieu-Daudé wrote:
> On 26/2/25 18:57, BALATON Zoltan wrote:
>> On Wed, 26 Feb 2025, Cédric Le Goater wrote:
>>> On 2/26/25 15:12, BALATON Zoltan wrote:
>>>> On Wed, 26 Feb 2025, Cédric Le Goater wrote:
>>>>> VFIO PCI never worked on PPC32 nor ARM, S390x is 64-bit, it might have
>>>>> worked on i386 long ago but we have no plans to further support VFIO
>>>>> on any 32-bit host platforms. Restrict to 64-bit host platforms.
>>>>> 
>>>>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>> Cc: Eric Farman <farman@linux.ibm.com>
>>>>> Cc: Eric Auger <eric.auger@redhat.com>
>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>> ---
>>>>> hw/vfio/Kconfig | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>> 
>>>>> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
>>>>> index 
>>>>> 7cdba0560aa821c88d3420b36f86020575834202..6ed825429a9151fcdff33e95d1a310210689b258 
>>>>> 100644
>>>>> --- a/hw/vfio/Kconfig
>>>>> +++ b/hw/vfio/Kconfig
>>>>> @@ -7,7 +7,7 @@ config VFIO_PCI
>>>>>     default y
>>>>>     select VFIO
>>>>>     select EDID
>>>>> -    depends on LINUX && PCI
>>>>> +    depends on LINUX && PCI && (AARCH64 || PPC64 || X86_64 || S390X)
>>>> 
>>>> Are these defined for the host or target? 
>>> 
>>> host.
>> 
>> Where are these defined? I thought compiling qemu-system-ppc on x64_64 or 
>> aarch64 would have PPC defined not X86_64 or AARCH64 but I could well be 
>> missing something.
>> 
>>>> I see PPC is defined in target/ppc/Kconfig so I think these mark the 
>>>> target not the host. Vfio-pci works with qemu-system-ppc 
>>> 
>>> Ah ! I am surprised. Which host and QEMU machine please ?
>> 
>> I've seen people do this on x86_64 host
>
> Since this patch does:
>
>  LINUX && PCI && (...  X86_64 ...)
>
> these users won't see any change.

I still don't understand why. X86_64 is defined in target/i386/Kconfig. 
Isn't that only defined when building qemu-x86_64 or qemu-system-x86_64? 
Or is it also defined when building TCG on x86_64 host? This is confusing. 
docs/devel/tcg-ops.rst says "The TCG *target* is the architecture for 
which we generate the code. It is of course not the same as the "target" 
of QEMU which is the emulated architecture." Which of these is marked by 
these defines?

Regards,
BALATON Zoltan
--3866299591-1300764181-1741013128=:65423--

