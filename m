Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA30CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZqyP-0001rL-TI; Wed, 17 Jun 2026 10:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZqyH-0001ke-Ue
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:10:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZqyE-0005Rt-S7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:10:25 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9538E596952;
 Wed, 17 Jun 2026 16:10:16 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 4ErZrakzh5vD; Wed, 17 Jun 2026 16:10:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0F11059694F; Wed, 17 Jun 2026 16:10:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0CF08596858;
 Wed, 17 Jun 2026 16:10:14 +0200 (CEST)
Date: Wed, 17 Jun 2026 16:10:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [RFC 4/7] system: add memory_region_new / memory_region_new_io
In-Reply-To: <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
Message-ID: <817a9061-bc64-9503-0b5a-3ab1117567a2@eik.bme.hu>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-5-berrange@redhat.com>
 <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-502672408-1781705414=:6462"
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

--3866299591-502672408-1781705414=:6462
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 17 Jun 2026, Paolo Bonzini wrote:
> On 6/16/26 17:55, Daniel P. Berrangé wrote:
>> Prepare for the move to dynamically allocated memory regions by
>> introducing memory_region_new and memory_region_new_io functions
>> which call through to object_new instead of object_initialize.
>> 
>> TBD: add "new" variants for all the other memory_region_init
>> variants.
>> 
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>
> Zoltan already proposed this, but I really think it's a bad idea.
>
> MemoryRegionOps callback will certainly access fields in the parent. Having a 
> separate object gives you no benefit because you still have the same 
> use-after-free if the MemoryRegion outlives the device.  Likewise for buses.
>
> For buses, the fact that the parent and child live at the same time is 
> explicitly tracked with mutual refcount and unparent.  If it's not, we have 
> the hack that Akihiko mentioned 
> (https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg03459.html):
>
>> However, this is insufficient to avoid calling object_ref() for all
>> embedded objects. For example, consider an embedded Device that has a
>> MemoryRegion. When referencing a MemoryRegion for guest memory access,
>> QEMU automatically references the owning Device to keep the MemoryRegion
>> alive. However, that reference is ineffective if the Device itself is
>> embedded, because object_ref() does not keep the containing storage
>> alive.
>
> If the device itself is embedded, then all the invariants must hold 
> recursively:
>
> - the device must be kept alive by mutual references between the device 
> itself and its parent;
>
> - unparent for the device should wait for all guest memory accesses to be 
> either completed or cancelled.
>
> So, the problem is that "QEMU automatically references the owning Device to 
> keep the MemoryRegion alive" is a hack that should die.  I added it, mea 
> culpa.
>
> The model is that if it makes sense to have B outlive A, you use new. If it 
> doesn't, you use init.  For MemoryRegions or anything that has callbacks, it 
> makes no sense to outlive the implementor of the callbacks.  There are 
> exceptions if the number of objects is dynamic but they're very rare.
>
> I agree that there's extra complexity added by embedding; but I disagree that 
> removing embedding will fix any bugs, and because it will hide a relationship 
> between objects, I believe the complexity is not accidental.

The problem is that memory regions cannot be ref counted because they are 
piggybacking on their owner's ref count instead of using their own. So 
while memory regions are QOM objects and the code is there to ref count 
and free them with their owners this can't be used and we hack around that 
by referencing the owner instead. If there's a dependency on the parent 
then maybe the memory region should take a ref of the parent so it does 
not go away until the memory region is freed or the owner relation needs 
to be taken into account instead of using the parent ref count and 
forbidding to make memory regions proper QOM objects which is very 
confusing and leads to all sorts of other hacks.

And it also forces me to embed a bunch of memory regions in device states 
that are otherwise not needed and already stored as PCI BARs or sysbus 
regions so I should not need them in my device state. This added 
complexity was my motivation but it turned out to be a larger issue and I 
think restoring the ability to ref count memory regions and clean up the 
hacks of keeping the parent alive with every object using its own ref 
counts would be cleaner than keeping to the current way.

Regards,
BALATON Zoltan
--3866299591-502672408-1781705414=:6462--

