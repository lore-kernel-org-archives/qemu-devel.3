Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C11CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjIs-0005rI-Jy; Tue, 28 Oct 2025 08:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vDjIq-0005od-8s; Tue, 28 Oct 2025 08:59:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vDjIh-00085c-Uc; Tue, 28 Oct 2025 08:59:54 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DA0115972E5;
 Tue, 28 Oct 2025 13:59:40 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 2ABzisIEmF5J; Tue, 28 Oct 2025 13:59:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 81D905972E3; Tue, 28 Oct 2025 13:59:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7FD025972E7;
 Tue, 28 Oct 2025 13:59:38 +0100 (CET)
Date: Tue, 28 Oct 2025 13:59:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
In-Reply-To: <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
Message-ID: <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-174818736-1761656378=:96783"
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

--3866299591-174818736-1761656378=:96783
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 28 Oct 2025, Philippe Mathieu-Daudé wrote:
> On 27/10/25 20:47, BALATON Zoltan wrote:
>> On Mon, 27 Oct 2025, Philippe Mathieu-Daudé wrote:
>>> On 25/10/25 01:31, BALATON Zoltan wrote:
>>>> These memory windows are a result of the address decoding in the
>>>> Articia S north bridge so better model it there and not in board code.
>>>> 
>>>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>   hw/pci-host/articia.c | 15 ++++++++++++++-
>>>>   hw/ppc/amigaone.c     | 28 +++++-----------------------
>>>>   hw/ppc/pegasos2.c     | 13 -------------
>>>>   3 files changed, 19 insertions(+), 37 deletions(-)
>>> 
>>> 
>>>> @@ -169,6 +174,7 @@ static void articia_realize(DeviceState *dev, Error 
>>>> **errp)
>>>>   {
>>>>       ArticiaState *s = ARTICIA(dev);
>>>>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>>>> +    MemoryRegion *mr;
>>>>       PCIDevice *pdev;
>>>>         bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
>>>> @@ -180,6 +186,14 @@ static void articia_realize(DeviceState *dev, Error 
>>>> **errp)
>>>>       memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
>>>>                             TYPE_ARTICIA, 0x1000000);
>>>>       memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
>>>> +    mr = g_new(MemoryRegion, 1);
>>> 
>>> Won't Coverity or other analysis tools complain about the leak?
>>> (this is why we usually keep a reference in the device state, here
>>> ArticiaState). Otherwise:
>> 
>> According to https://www.qemu.org/docs/master/devel/memory.html#region- 
>> lifecycle
>> there should be no leak and keeping a reference should not be necessary as 
>> the lifetime is managed by attaching it to the owner object so no need to 
>> keep a reference when it's not needed otherwise. Not littering the state 
>> struct with unneded references makes it easier to comprehend so I'd only 
>> keep things there that are necessary.
>
> IIUC this doc is about what happens within the allocated MemoryRegion,
> regardless of where it is allocated.

That doc explicitely says:

"Destruction of a memory region happens automatically when the owner 
object dies. When there are multiple memory regions under the same owner 
object, the memory API will guarantee all memory regions will be properly 
detached and finalized one by one. The order in which memory regions will 
be finalized is not guaranteed."

(and these pci-host objects are created once at machine init and never die 
so the question seems quite theoretical). I'd like to keep object state 
simple and not keep around references in it that nothing uses and should 
be managed automatically. I'd only add fields to the state struct that 
other methods need.

Regards,
BALATON Zoltan
--3866299591-174818736-1761656378=:96783--

