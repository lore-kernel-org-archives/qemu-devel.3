Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1694FE8383F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 23:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs80l-0004XQ-Ht; Mon, 16 Feb 2026 18:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vs80j-0004WJ-Id; Mon, 16 Feb 2026 18:28:13 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vs80g-0007G1-VQ; Mon, 16 Feb 2026 18:28:13 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C5D5C596A0A;
 Tue, 17 Feb 2026 00:28:07 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id pjNQObljGVje; Tue, 17 Feb 2026 00:28:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BA1295969FD; Tue, 17 Feb 2026 00:28:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B7E995969FA;
 Tue, 17 Feb 2026 00:28:05 +0100 (CET)
Date: Tue, 17 Feb 2026 00:28:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Chinmay Rath <rathc@linux.ibm.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de" <qemu-ppc@nongnu.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 7/8] hw/ppc: Set graphic display dimensions generically
In-Reply-To: <aa07574a-2bd4-6490-7508-2db86a1c4446@eik.bme.hu>
Message-ID: <a02ccd2e-0972-08fa-af90-33d4ec7c050f@eik.bme.hu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-8-philmd@linaro.org>
 <252b2fa2-9251-3949-625b-7071c525c8e2@eik.bme.hu>
 <56a0f465-2055-4c82-b0c0-963b376609e9@linaro.org>
 <0492fc65-e156-1afe-ea72-520134ccca41@eik.bme.hu>
 <CABgObfZpxHmdmX7La7kQLRWY0=nPZSysOYiJsU7h99JEgzio5A@mail.gmail.com>
 <aa07574a-2bd4-6490-7508-2db86a1c4446@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 16 Feb 2026, BALATON Zoltan wrote:
> On Mon, 16 Feb 2026, Paolo Bonzini wrote:
>> Il dom 15 feb 2026, 10:51 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:
>>>>>> +void ppc_graphic_dimensions(int *width, int *height, int *depth)
>>>>>> +{
>>>>>> +    *width = graphic_width ?: 800;
>>>>>> +    *height = graphic_height ?: 600;
>>>>>> +    *depth = graphic_depth ?: 32;
>>>>>> +}
>>>>> 
>>>>> I think there's no reason to have this common to all ppc machines.
>> 
>> 
>> I agree with you here that it's better to just inline this in all the
>> boards that need it, because there's no reason to have 800x600x32 across
>> such disparate machines.
>> 
>>> Can you provide a patch showing how you'd prefer it to be done?
>>> 
>>> Maybe turning these into properties could work. I could look at adding
>>> such properties but don't know how to change the -g option. But
>>> considering these are all machines that Mark maintains maybe he should do
>>> something about it
>> 
>> 
>> I am not sure what you'd be requesting of him?
>> 
>> The easiest were if he agreed to drop -g option but he
>>> never agrees removing anything
>> 
>> 
>> Not sure who's he? Is it me since I asked Philippe to keep -g, or Mark? And
>> if it's Mark, I am not sure what you're trying to obtain by involving (and
>> in a pretty rude way, too) someone who's not even part of the thread.
>
> Mark is cc-ed on this thread and it seems this -g option is only used by 
> machines he maintains. My previous experience with patches submitted to 
> things he maintains is that this most of the time leads to long discussions 
> on why what I propose is wrong and how else should it be done instead. (I'm 
> not saying that it's because it's me who submits the patch, I've seen this 
> happening to other contributors too but it looks like Mark has strong views 
> on how things should be done and he's reluctant to accept anything else.) 
> Because of that I try not to touch anything that Mark maintains unless he 
> says beforehand what would be acceptable. I did not mean it to be rude or 
> attack him but I also think this isn't the best way to work either. But given 
> these cicrumstances I think Mark should state his peference about this as at 
> the end he is the maintainer who will have to approve it.
>
>> so then he should provide patches to clean
>>> this up the way he prefers. I could try to make patches but I'm afraid
>>> those would become wasted effort so may I only do it when there's an
>>> approved way that will be accepted.
>> 
>> The -g 800x600x32 option, if desired, can become simply a shortcut for -M
>> gfxwidth=800,gfxheight=600,gfxdepth=32 (or
>> gfx.width=800,gfx.height=600,gfx.depth=32), which is more similar to how
>> smp or boot work). This would actually be easier to implement with
>> Philippe's move of all graphics_* accesses to board code, so his patches
>> should go in either way. And then the globals can be removed altogether.
>
> A problem with global option may be that resolution is not really a machine 
> property but that of the display and one machine may have more than one 
> display. Currently those display devices that support EDID use 
> xres,yres,xmin,ymin,xmax,ymax properties and some devices like VGA have

Ther's no xmin,ymin but there's refresh_rate. However depth is missing.

> DEFINE_EDID_PROPERTIES to forward these to the edid generation. For others it 
> can be set less intuitively with -global. (This was asked by somebody for 
> ati-vga recently so I plan to add forwarding properties for that.) Maybe we 
> should move into that direction and make these properties of the display 
> devices and call them xres,yres too for consistency. But there may be some 
> complication here with fw_cfg and OpenBIOS too so in that case just keeping 
> the globals and using machine properties may be simpler.

Another problem with -g is that it only works with a few obscure machines 
and will do nothing for most of the other machines which is confusing. So 
in the longer term I think it should either be deprecated and these 
machines changed to use properties on display devices like the others or 
as you proposed last year it may need to become an option to set defaults 
for all displays which is simliar to audiodev that was turned into a 
machine property from a top level option a while ago.

Anyway these are just my comments to this topic that I wanted to share and 
then the involved parties will do whatever they want. I wanted to share 
this in the hope to add some points that I think may be relevant.

Regards,
BALATON Zoltan

