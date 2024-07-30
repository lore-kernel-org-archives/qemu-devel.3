Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E1CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjYm-0001tQ-0O; Tue, 30 Jul 2024 05:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sYjYj-0001kP-R1; Tue, 30 Jul 2024 05:54:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sYjYh-0002t8-Kr; Tue, 30 Jul 2024 05:54:21 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9FBF14E6000;
 Tue, 30 Jul 2024 11:54:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id FEre8zQg5gXg; Tue, 30 Jul 2024 11:54:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A005D4E6005; Tue, 30 Jul 2024 11:54:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9E49D746E3B;
 Tue, 30 Jul 2024 11:54:11 +0200 (CEST)
Date: Tue, 30 Jul 2024 11:54:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org, 
 Sergio Lopez <slp@redhat.com>, 
 =?ISO-8859-15?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 05/11] exec/ioport: Add portio_list_set_address()
In-Reply-To: <05446d09-d5f1-4a6a-a816-ed9c28f6e82c@linaro.org>
Message-ID: <7ead0da2-1f4d-369a-a51b-8c05b1ed5417@eik.bme.hu>
References: <20240114123911.4877-1-shentey@gmail.com>
 <20240114123911.4877-6-shentey@gmail.com>
 <f5f5dfca-d60b-4b0d-add9-e41b42bd4ce2@linaro.org>
 <C0822DF6-EA81-48BB-9102-887E66441EF2@gmail.com>
 <05446d09-d5f1-4a6a-a816-ed9c28f6e82c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1821407361-1722333251=:80219"
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

--3866299591-1821407361-1722333251=:80219
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 30 Jul 2024, Philippe Mathieu-Daudé wrote:
> On 29/7/24 23:07, Bernhard Beschow wrote:
>> Am 29. Juli 2024 09:26:19 UTC schrieb "Philippe Mathieu-Daudé" 
>> <philmd@linaro.org>:
>>> On 14/1/24 13:39, Bernhard Beschow wrote:
>>>> Some SuperI/O devices such as the VIA south bridges or the PC87312 
>>>> controller
>>>> are able to relocate their SuperI/O functions. Add a convenience function 
>>>> for
>>>> implementing this in the VIA south bridges.
>>>> 
>>>> This convenience function relies on previous simplifications in 
>>>> exec/ioport
>>>> which avoids some duplicate synchronization of I/O port base addresses. 
>>>> The
>>>> naming of the function is inspired by its memory_region_set_address() 
>>>> pendant.
>>>> 
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>> ---
>>>>    docs/devel/migration.rst |  5 +++--
>>>>    include/exec/ioport.h    |  2 ++
>>>>    system/ioport.c          | 19 +++++++++++++++++++
>>>>    3 files changed, 24 insertions(+), 2 deletions(-)
>>> 
>>> 
>>>> +void portio_list_set_address(PortioList *piolist, uint32_t addr)
>>>> +{
>>>> +    MemoryRegionPortioList *mrpio;
>>>> +    unsigned i, j;
>>>> +
>>>
>>>        memory_region_transaction_begin();
>>> 
>>>> +    for (i = 0; i < piolist->nr; ++i) {
>>>> +        mrpio = container_of(piolist->regions[i], 
>>>> MemoryRegionPortioList, mr);
>>> 
>>> Should we check mrpio->mr is disabled before changing its base address?
>> 
>> Isn't that the responsibility of the guest? What should we do if the check 
>> fails?
>
> What says the datasheet? At least we should log a GUEST_ERROR here.

It does not say what if it's not enabled but only says that parallel port 
tegs should be located at LPTBase (0xf6 of superio config). So I think 
this should move the memory region independent of if it's enabled but then 
mayube the enable bit should check the address and set it when enabling 
the region? But shouldn't portio take care of that remembering the base? I 
don't know how all this works in QEMU and don't have time to check now.

Reagrds,
BALATON Zoltan
--3866299591-1821407361-1722333251=:80219--

