Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73262CCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 21:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAb9Q-0002fh-J8; Sun, 19 Oct 2025 17:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vAb9O-0002eq-Uz; Sun, 19 Oct 2025 17:41:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vAb9M-0006GG-Qk; Sun, 19 Oct 2025 17:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=suaanf4twvvD9SQGrkNlps/Nh7szhpTcDagnTus2siE=; b=f3JrFOGdEZrh5T+5z8OUmdKort
 4iBuuCPz7SyZfU8GpPQWqG+Nq5/Y9ZAMudM6vtW7aNTYIgpvlFjUZA6HFpbvNAWd55N+X2FjLZgAL
 4MjkYPMVGBl/r6YfGF5lJJIX5UHOdA4SdfKY/OtHHj++S5TTcygnHHyt8Qb2+csmvXFfItqypNJSv
 MRsiCyJ97BbLOo5A9qECfDDiqiH9tP9s9MENhfdFnfw9n0+ediVgc6rjohAFl1HsWNf4z4HfYMxic
 ZnYDKpxOuEoBXbwAWMQNrtf34dzplb3TcVihn9dAlRRzUb+jOhLm8B7oWaKfsaMosJ+TMqxelPQBc
 t9Ylhn6XKjz8UwsJHgNFiHQT2mrfuKbBP85794X6v9xHLk3qEUBVd0k23IGKPEPClMXJCmmbAgO9w
 cXsaVmdRk8bbHJDOlob9pa312dkTRKwLuNrrvIqaww2K0mRHh3MfwGPtiIqiS/GESQlv3TmBRDvzz
 tU4aDkzzE+SJxmwA791OTy4u1mC2IAXKJydlIDoxEEPd0AMnYVNEKLfn0NgfwkhecJLpv9z1MJKI0
 Vr1owFjNLiOono6BLpg79ud5vWBqzrwlEeYK+PEmeVH4Elg+Q1ZnPjrmpcknL/m1cnZ1GcRwm1nQU
 fJ2hM6FKKdCURJIBWSHu/uSjxpmirE7Uql4oOJ4SA=;
Received: from [2a02:8012:2f01:0:9713:abb1:52ac:51f3]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vAb6r-000AfO-Qo; Sun, 19 Oct 2025 22:38:42 +0100
Message-ID: <b83b904c-6dcc-4b4f-afc0-499ffafca15c@ilande.co.uk>
Date: Sun, 19 Oct 2025 22:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <ebfd5b64421e8a876c5a6e2ce3dc871de500b69d.1758219840.git.balaton@eik.bme.hu>
 <b5db600a-3278-427d-9f67-b222cb0c1bd1@ilande.co.uk>
 <db65a6dd-cfdf-18b8-1764-8a1d7d3fcc24@eik.bme.hu>
 <a95fed21-de1c-4dc8-a776-a6a2acd4b7d3@linux.ibm.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <a95fed21-de1c-4dc8-a776-a6a2acd4b7d3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:9713:abb1:52ac:51f3
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 01/14] hw/pci-host/raven: Simplify PCI facing part
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 18/10/2025 03:41, Harsh Prateek Bora wrote:

> Hi Mark,
> 
> Thanks much for pitching in to help with reviewing this series.

Hi Harsh,

No worries - I've looked at raven before when working on adding 40p support for 
OpenBIOS, so I do have some familiarity.

> On 9/19/25 01:51, BALATON Zoltan wrote:
>> On Thu, 18 Sep 2025, Mark Cave-Ayland wrote:
>>> On 18/09/2025 19:50, BALATON Zoltan wrote:
>>>> The raven PCI device does not need a state struct as it has no data to
>>>> store there any more, so we can remove that to simplify code.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>   hw/pci-host/raven.c | 30 +-----------------------------
>>>>   1 file changed, 1 insertion(+), 29 deletions(-)
>>>>
>>>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>>>> index f8c0be5d21..172f01694c 100644
>>>> --- a/hw/pci-host/raven.c
>>>> +++ b/hw/pci-host/raven.c
>>>> @@ -31,7 +31,6 @@
>>>>   #include "hw/pci/pci_bus.h"
>>>>   #include "hw/pci/pci_host.h"
>>>>   #include "hw/qdev-properties.h"
>>>> -#include "migration/vmstate.h"
>>>>   #include "hw/intc/i8259.h"
>>>>   #include "hw/irq.h"
>>>>   #include "hw/or-irq.h"
>>>> @@ -40,12 +39,6 @@
>>>>   #define TYPE_RAVEN_PCI_DEVICE "raven"
>>>>   #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
>>>>   -OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
>>>> -
>>>> -struct RavenPCIState {
>>>> -    PCIDevice dev;
>>>> -};
>>>> -
>>>>   typedef struct PRePPCIState PREPPCIState;
>>>>   DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
>>>>                            TYPE_RAVEN_PCI_HOST_BRIDGE)
>>>> @@ -65,7 +58,6 @@ struct PRePPCIState {
>>>>       MemoryRegion bm_ram_alias;
>>>>       MemoryRegion bm_pci_memory_alias;
>>>>       AddressSpace bm_as;
>>>> -    RavenPCIState pci_dev;
>>>>         int contiguous_map;
>>>>   };
>>>> @@ -268,8 +260,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error 
>>>> **errp)
>>>>                             "pci-intack", 1);
>>>>       memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
>>>>   -    /* TODO Remove once realize propagates to child devices. */
>>>> -    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
>>>> +    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
>>>>   }
> 
> <snip>
> 
>>>> @@ -361,7 +334,6 @@ static void raven_class_init(ObjectClass *klass, const void 
>>>> *data)
>>>>   static const TypeInfo raven_info = {
>>>>       .name = TYPE_RAVEN_PCI_DEVICE,
>>>>       .parent = TYPE_PCI_DEVICE,
>>>> -    .instance_size = sizeof(RavenPCIState),
>>>>       .class_init = raven_class_init,
>>>>       .interfaces = (const InterfaceInfo[]) {
>>>>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>>>
>>> I agree with removing RavenPCIState, but pci_create_simple() isn't the right 
>>> solution here because it both init()s and realize()s the inner object. The right 
>>> way to do this is for the parent to init() its inner object(s) within its init() 
>>> function, and similarly for it to realize() its inner object(s) within its 
>>> realize() function.
>>>
>>> FWIW it looks as if the same mistake is present in several other hw/pci-host devices.
>>
>> So maybe that's not a mistake then. There's no need to init and realize it 
>> separately as this is an internal object which is enough to be created in realize 
>> method and init and realize there at one go for which pci_create_simple is 
>> appropriate. I think this inner object would only need to be init separately if it 
>> exposed something (like a property) that could be inspected or set before realize 
>> but that's not the case here so it does not have to be created in init only in 
>> realize. (A lot of simple devices don't even have init method only realize so init 
>> is only needed for things that have to be set before realize.)
> 
> Do we have a consensus here ?
> 
> regards,
> Harsh
Given there is still some ongoing discussion regarding object modelling, I think this 
will require a separate tidy-up so let's go with the pci_create_simple() approach for 
now.

The changes to the interrupt routing and readability of some of the changes from a 
developer's perspective are still of concern to me.


ATB,

Mark.


