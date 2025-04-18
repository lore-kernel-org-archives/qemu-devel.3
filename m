Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9D3C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 18:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5qt0-0005sO-Db; Fri, 18 Apr 2025 14:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u5qsu-0005la-5O; Fri, 18 Apr 2025 14:56:20 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u5qsr-00033r-62; Fri, 18 Apr 2025 14:56:19 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 97FD555D22E;
 Fri, 18 Apr 2025 20:56:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id nLX93XCT2cb1; Fri, 18 Apr 2025 20:56:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 97C9855C592; Fri, 18 Apr 2025 20:56:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 95875745682;
 Fri, 18 Apr 2025 20:56:10 +0200 (CEST)
Date: Fri, 18 Apr 2025 20:56:10 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, 
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Felipe Balbi <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 00/11] hw/arm: Define machines as generic QOM types
In-Reply-To: <a0d9ed9a-7b97-43a5-a380-0bb607163661@linaro.org>
Message-ID: <3339645a-136d-0e4d-4709-0ab269b78925@eik.bme.hu>
References: <20250417235814.98677-1-philmd@linaro.org>
 <a302fb91-e2d8-ef36-ac53-5e460476c2d0@eik.bme.hu>
 <25a82a76-cd63-4a42-bb68-5dcf826bd948@linaro.org>
 <26c2b844-dc96-448e-8978-e536ed1e61f6@linaro.org>
 <35ae8633-4195-446b-9a22-0c131b9cab88@linaro.org>
 <ee3c9b11-4c4e-41c7-8029-7e5c153215d7@linaro.org>
 <a0d9ed9a-7b97-43a5-a380-0bb607163661@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2086445380-1745002570=:55441"
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

--3866299591-2086445380-1745002570=:55441
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 18 Apr 2025, Pierrick Bouvier wrote:
> On 4/18/25 10:07, Philippe Mathieu-Daudé wrote:
>> On 18/4/25 19:03, Pierrick Bouvier wrote:
>>> On 4/18/25 09:59, Philippe Mathieu-Daudé wrote:
>>>> On 18/4/25 18:33, Pierrick Bouvier wrote:
>>>>> On 4/18/25 01:53, BALATON Zoltan wrote:
>>>>>> On Fri, 18 Apr 2025, Philippe Mathieu-Daudé wrote:
>>>>>>> While DEFINE_MACHINE() is a succinct macro, it doesn't
>>>>>>> allow registering QOM interfaces to the defined machine.
>>>>>>> Convert to the generic DEFINE_TYPES() in preparation to
>>>>>>> register interfaces.
>>>>>>> 
>>>>>>> Philippe Mathieu-Daudé (11):
>>>>>>>     hw/core/null-machine: Define machine as generic QOM type
>>>>>>>     hw/arm/bananapi: Define machine as generic QOM type
>>>>>>>     hw/arm/cubieboard: Define machine as generic QOM type
>>>>>>>     hw/arm/digic: Define machine as generic QOM type
>>>>>>>     hw/arm/imx: Define machines as generic QOM types
>>>>>>>     hw/arm/integratorcp: Define machine as generic QOM type
>>>>>>>     hw/arm/kzm: Define machine as generic QOM type
>>>>>>>     hw/arm/msf2: Define machine as generic QOM type
>>>>>>>     hw/arm/musicpal: Define machine as generic QOM type
>>>>>>>     hw/arm/orangepi: Define machine as generic QOM type
>>>>>>>     hw/arm/stm32: Define machines as generic QOM types
>>>>>>> 
>>>>>>> hw/arm/bananapi_m2u.c      | 13 +++++++++++--
>>>>>>> hw/arm/cubieboard.c        | 13 +++++++++++--
>>>>>>> hw/arm/digic_boards.c      | 14 ++++++++++++--
>>>>>>> hw/arm/imx25_pdk.c         | 14 ++++++++++++--
>>>>>>> hw/arm/imx8mp-evk.c        | 15 +++++++++++++--
>>>>>>> hw/arm/integratorcp.c      | 16 +++++++++++++---
>>>>>>> hw/arm/kzm.c               | 14 ++++++++++++--
>>>>>>> hw/arm/mcimx6ul-evk.c      | 15 +++++++++++++--
>>>>>>> hw/arm/mcimx7d-sabre.c     | 15 +++++++++++++--
>>>>>>> hw/arm/msf2-som.c          | 13 +++++++++++--
>>>>>>> hw/arm/musicpal.c          | 16 +++++++++++++---
>>>>>>> hw/arm/netduino2.c         | 13 +++++++++++--
>>>>>>> hw/arm/netduinoplus2.c     | 13 +++++++++++--
>>>>>>> hw/arm/olimex-stm32-h405.c | 13 +++++++++++--
>>>>>>> hw/arm/orangepi.c          | 13 +++++++++++--
>>>>>>> hw/arm/sabrelite.c         | 14 ++++++++++++--
>>>>>>> hw/arm/stm32vldiscovery.c  | 13 +++++++++++--
>>>>>>> hw/core/null-machine.c     | 14 ++++++++++++--
>>>>>>> 18 files changed, 213 insertions(+), 38 deletions(-)
>>>>>> 
>>>>>> This is much longer and exposing boiler plate code. Is it possible
>>>>>> instead
>>>>>> to change DEFINE_MACHINE or add another similar macro that allows
>>>>>> specifying more details such as class state type and interfaces like we
>>>>>> already have for OBJECT_DEFINE macros to keep the boiler plate code
>>>>>> hidden
>>>>>> and not bring it back?
>>>>>> 
>>>>> 
>>>>> We can eventually modify DEFINE_MACHINES, to take an additional
>>>>> interfaces parameter, and replace all call sites, with an empty list for
>>>>> all boards out of hw/arm.
>>>>> 
>>>>> As long as we avoid something like:
>>>>> DEFINE_MACHINES_WITH_INTERFACE_1(...)
>>>>> DEFINE_MACHINES_WITH_INTERFACE_2(...)
>>>>> DEFINE_MACHINES_WITH_INTERFACE_3(...)
>>>>> I'm ok with keeping the macro.
>>>>> 
>>>>> Would that work for you folks?
>>>> 
>>>> But then we'll want DEFINE_PPC32_MACHINE() ->
>>>> DEFINE_MACHINES_WITH_INTERFACE_1() etc...
>>>> 
>>> 
>>> We can see that later when touching other targets. For now,
>>> DEFINE_MACHINE is not used in a lot of places, so replacing call sites
>>> should be easy, and it will cover hw/arm, which is our point of interest
>>> now.
>> 
>> I concur and share the same goal, but here Zoltan is concerned about
>> converting DEFINE_MACHINE to DEFINE_TYPES adds 12 lines of boilerplate
>> code.
>
> If I understand correctly, Zoltan issue is that we remove usage of 
> DEFINE_MACHINE, and put boilerplate for type definition instead.
> So hiding boilerplate behind the macro would be ok, thus my proposal.
>
> Zoltan, could you please confirm in which way you were qualifying this as 
> boilerplate?

See commit f84203a8c22 and if I remember correctly there was some 
discussion around that on the list where this came from which was partly 
started by me being annoyed to have half of a device model consiting of 
just boiler plate. I would not like that to come back if can be avoided as 
having these macros make the models much more comprehensive for new people 
not having to go through all the QOM boiler plate to see the actual 
functionality.

Regards,
BALATON Zoltan
--3866299591-2086445380-1745002570=:55441--

