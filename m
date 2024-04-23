Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123AAC18E72
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 10:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzDJs-0006Bv-Cz; Tue, 23 Apr 2024 06:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1rzDJq-0006BO-1z; Tue, 23 Apr 2024 06:24:10 -0400
Received: from new-mail.astralinux.ru ([51.250.53.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1rzDJn-0001A2-I6; Tue, 23 Apr 2024 06:24:09 -0400
Received: from [10.177.233.137] (unknown [10.177.233.137])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4VNyrh0K2tzyQr;
 Tue, 23 Apr 2024 13:23:47 +0300 (MSK)
Message-ID: <aa967494-d3d1-4896-8006-b5fc2252a56e@astralinux.ru>
Date: Tue, 23 Apr 2024 13:23:33 +0300
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH RFC] prevent overflow in
 xlnx_dpdma_desc_get_source_address()
To: "Konrad, Frederic" <Frederic.Konrad@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sdl.qemu@linuxtesting.org" <sdl.qemu@linuxtesting.org>
References: <20240412081328.11183-1-adiupina@astralinux.ru>
 <CAFEAcA9wfzpc74iA_2G-YbtQtwGCA9VPQuXagg-Q0FwC92tg+w@mail.gmail.com>
 <CY8PR12MB8411CAB26257B5974DAE2CA2E60F2@CY8PR12MB8411.namprd12.prod.outlook.com>
Content-Language: ru
From: Alexandra Diupina <adiupina@astralinux.ru>
In-Reply-To: <CY8PR12MB8411CAB26257B5974DAE2CA2E60F2@CY8PR12MB8411.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehlvgigrghnughrrgcuffhiuhhpihhnrgcuoegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepiedvgfdtudfffeegleevheeltddtffejtdfgveevgfehtdeujeejgfdtteehgeejnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghdprghmugdrtghomhenucfkphepuddtrddujeejrddvfeefrddufeejnecurfgrrhgrmhephhgvlhhopegluddtrddujeejrddvfeefrddufeejngdpihhnvghtpedutddrudejjedrvdeffedrudefjeemheejgedtkedpmhgrihhlfhhrohhmpegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepjedprhgtphhtthhopefhrhgvuggvrhhitgdrmfhonhhrrggusegrmhgurdgtohhmpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvpdhrtghpthhtohepvggughgrrhdrihhglhgvshhirghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhgvmh
 huqdgrrhhmsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepshgulhdrqhgvmhhusehlihhnuhigthgvshhtihhnghdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB;
 Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128,
 SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12626735,
 Updated: 2024-Apr-23 08:25:08 UTC]
Received-SPF: pass client-ip=51.250.53.244;
 envelope-from=adiupina@astralinux.ru; helo=new-mail.astralinux.ru
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




17/04/24 13:05, Konrad, Frederic пишет:
> Hi,
>
>> -----Original Message-----
>> From: qemu-devel-bounces+fkonrad=amd.com@nongnu.org <qemu-devel-bounces+fkonrad=amd.com@nongnu.org> On Behalf Of
>> Peter Maydell
>> Sent: Friday, April 12, 2024 12:07 PM
>> To: Alexandra Diupina <adiupina@astralinux.ru>
>> Cc: Alistair Francis <alistair@alistair23.me>; Edgar E. Iglesias <edgar.iglesias@gmail.com>; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org; sdl.qemu@linuxtesting.org
>> Subject: Re: [PATCH RFC] prevent overflow in xlnx_dpdma_desc_get_source_address()
>>
>> On Fri, 12 Apr 2024 at 09:13, Alexandra Diupina <adiupina@astralinux.ru> wrote:
>>> Overflow can occur in a situation where desc->source_address
>>> has a maximum value (pow(2, 32) - 1), so add a cast to a
>>> larger type before the assignment.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: d3c6369a96 ("introduce xlnx-dpdma")
>>> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
>>> ---
>>>   hw/dma/xlnx_dpdma.c | 20 ++++++++++----------
>>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
>>> index 1f5cd64ed1..224259225c 100644
>>> --- a/hw/dma/xlnx_dpdma.c
>>> +++ b/hw/dma/xlnx_dpdma.c
>>> @@ -175,24 +175,24 @@ static uint64_t xlnx_dpdma_desc_get_source_address(DPDMADescriptor *desc,
>>>
>>>       switch (frag) {
>>>       case 0:
>>> -        addr = desc->source_address
>>> -            + (extract32(desc->address_extension, 16, 12) << 20);
>>> +        addr = (uint64_t)(desc->source_address
>>> +            + (extract32(desc->address_extension, 16, 12) << 20));
>> Unless I'm confused, this cast doesn't help, because we
>> will have already done a 32-bit addition of desc->source_address
>> and the value from the address_extension part, so it doesn't
>> change the result.
>>
>> If we want to do the addition at 64 bits then using extract64()
>> would be the simplest way to arrange for that.
>>
>> However, I can't figure out what this code is trying to do and
>> make that line up with the data sheet; maybe this isn't the
>> right datasheet for this device?
>>
>> https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/ADDR_EXT-Field
>>
>> The datasheet suggests that we should take 32 bits of the address
>> from one field (here desc->source_address) and 16 bits of the
>> address from another (here desc->address_extension's high bits)
>> and combine them to make a 48 bit address. But this code is only
>> looking at 12 bits of the high 16 in address_extension, and it
>> doesn't shift them right enough to put them into bits [47:32]
>> of the final address.
>>
>> Xilinx folks: what hardware is this modelling, and is it
>> really the right behaviour?
> Looks like this is the right documentation.  Most probably the descriptor field changed
> since I did that model, or I got really confused.
>
>> Also, this device looks like it has a host-endianness bug: the
>> DPDMADescriptor struct is read directly from guest memory in
>> dma_memory_read(), but the device never does anything to swap
>> the fields from guest memory order to host memory order. So
>> this is likely broken on big-endian hosts.
>>
> Yes indeed.
>
> Best Regards,
> Fred
>
>> thanks
>> -- PMM

hw/dma/xlnx_dpdma.c defines a dma_ops structure
with the endianness field set to DEVICE_NATIVE_ENDIAN.
Doesn't this guarantee that there will be no endian errors?

Alexandra

