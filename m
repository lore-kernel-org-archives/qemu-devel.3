Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A53DF55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 01:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv3L6-00088m-Hx; Tue, 24 Feb 2026 20:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vv3Kw-00087b-Ii
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 20:05:12 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vv3Kt-0006jG-2F
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 20:05:10 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 96388596A29;
 Wed, 25 Feb 2026 02:05:03 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id V2KexAjBrJVZ; Wed, 25 Feb 2026 02:05:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D909F5969F6; Wed, 25 Feb 2026 02:05:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D372C5969F4;
 Wed, 25 Feb 2026 02:05:00 +0100 (CET)
Date: Wed, 25 Feb 2026 02:05:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH] hw/core: Avoid attaching qdevs to /machine/unattached
 if they have a bus
In-Reply-To: <ef1aeb7f-d79c-446f-be58-28245b84ccfa@nutanix.com>
Message-ID: <3a72c0f3-ba85-1e98-3964-5f43efb80375@eik.bme.hu>
References: <20260217164049.543975-1-thuth@redhat.com>
 <874ind5da6.fsf@pond.sub.org> <aZ1zsoyKcD1ChK--@redhat.com>
 <CAFEAcA-30xkboF_mt2HD+9TG+j9W7k2FCuSHGSVk9H=gbXnx2A@mail.gmail.com>
 <ef1aeb7f-d79c-446f-be58-28245b84ccfa@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1498801505-1771979778=:99179"
Content-ID: <9e42de32-f1b8-48c5-2bde-b345c70a8b59@eik.bme.hu>
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

--3866299591-1498801505-1771979778=:99179
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <c0855167-3621-d773-0638-e9aba28c5c40@eik.bme.hu>

On Tue, 24 Feb 2026, Mark Cave-Ayland wrote:
> On 24/02/2026 11:10, Peter Maydell wrote:
>> On Tue, 24 Feb 2026 at 09:48, Daniel P. Berrangé <berrange@redhat.com> 
>> wrote:
>>> IMHO, it is slightly more subtle - people believe they are already
>>> adding children.
>>> 
>>> Consider this code.
>>>
>>>      port92 = isa_create_simple(isa_bus, TYPE_PORT92);
>>> 
>>> my reading of that is that I'm creating a "port92" device that is a
>>> child of "isa_bus". Why would I need to tell QEMU that it is a child
>>> for a second time ?
>>> 
>>> If I trace calls through isa_create_simple I get to a call to:
>>>
>>>     qdev_realize_and_unref(dev, parent, errp);
>>> 
>>> and once I again I'm left wondering why I would need to tell
>>> QEMU 'dev' is a child of 'parent' a second time.
>>> 
>>> Of course I know the answer. We need to give a name for the
>>> child and it isn't trivial to "do the right thing" to invent
>>> an automatic name.
>>> 
>>> Still, overall I'm inclined to largely blame our API designs for
>>> not guiding people into doing the right thing.
>>> 
>>> 
>>> Picking another random unattached set of objects "smbus-eeprom"
>>> I again find they've being created with qdev_realize_and_unref.
>>> 
>>> Pick another unattached device 'i8259_init_chip', and again
>>> we end up calling into qdev_realize_and_unref()
>>> 
>>> 
>>> It feels like qdev_realize_and_unref() is a common point of
>>> blame in unattached devices. IMHO it ought to be taking a
>>> "const char *name" parameter.
>> 
>> I think that is because this is the function that is used
>> in older code that predates the "everything should be in
>> the QOM tree" model. Newer code doesn't use it, I think;
>> and it's not surprising that old pre-QOM code doesn't do
>> anything to put objects into the QOM tree.
>> 
>> The two patterns are:
>>
>>   dev = qdev_new(...);
>>   ...
>>   qdev_realize_and_unref(dev, bus, errp);
>> 
>> and
>>
>>   object_initialize_child(...);
>>   ...
>>   qdev_realize(dev, bus, errp);
>> 
>> This also is somewhat tangled up with the question of whether you want:
>>
>>   * call a function which allocates memory and initializes it
>>     with an object of this type
>>   * I have the memory here, init the object in-place

Maybe it would not be tangled if there was a qdev_new_child or making the 
child relationship would not be done in object_initialize_child but with 
qdev_realize (but that may be too late). Or maybe we just need a set_child 
or add_child function that one should call after qdev_new or 
object_initialize and not entangle child init with object init as those 
are different operations. I think we don't have to decide if we want to 
allocate objects or init objects at preallocated memory as both could be 
useful in different cases but these should behave symmetrically so if 
there's something is only possible with object_initialize_child then it 
should be possible with allocated objects too.

>> If we could come to a definite conclusion on what we want then
>> we would probably be in a better position to try to enforce it.
>
> Exactly this! I think what tends to happen is that we get stuck in situations 
> where someone suggests an improvement, but then we get hung up trying to work 
> out the corner-cases where it doesn't work and then things don't progress.
>
> The approach I believe we need to take is to work out what we want the API 
> and QOM tree to look like first, and then work backwards from there.
>
> I tend to be in agreement with Akihiko's argument that we want to deprecate 
> in-place initialisation with object_initialize_child() and simply use 
> refcounting everywhere because then we don't hit any lifcycle issues if 
> something retains a reference to the internal object (memory regions!).
>
> The questions I think we need to answer as a starting point:
>
>  1. Which API shall we converge on: qdev or QOM? Can we come up with a
>     code sample(s) showing what we want object/device initialisation to
>     look lie? Longer term can we unify the QOM and qdev trees?

My first question is why do we have separate qom and qdev names and trees? 
The docs aren't very helpful. Qdev does not have a Glossary entry and only 
a brief summary at:
https://www.qemu.org/docs/master/devel/qdev-api.html
and some confusing info in an old doc here
https://habkost.net/posts/2016/11/incomplete-list-of-qemu-apis.html

For a long time I did not even know there was info qom-tree command in 
monitor but I was familiar with and used info qtree. I still don't know 
what the qom-tree is good for therefore I also don't care when creating 
machines or devices as I never use it and don't know why I would want to 
use it. To me it looks like some internal thing of QEMU that I don't have 
to be concerned with. All the useful info about devices are in info qtree.

>  2. Should we convert to use external object allocation with
>     refcounting?
>
>  3. How do we handle memory regions? With Akihiko's recent refcount
>     fixes then Zoltan's memory region changes could work: I don't agree
>     with the motivation of simplifying devices as I think it's i)
>     subjective and ii) harder to debug if we lose the pointer to the
>     memory region, but I can see how it fixes the RCU-thread doing an
>     unref after the owner device has already been destroyed issue.

These probably belong to the other thread and not directly related to 
naming and tree hierarchies but while debugging is also subjective (most 
of the time you can use traces or just add debug printfs) but you still 
have a pointer in the parent object or you may be able to get a pointer to 
the MemoryRegion from QEMU monitor so that's not a good reason to 
duplicate it in the device. The idea in object oriented design is to only 
put things in the subclass that it adds to the superclass and the 
superclass already handles memory regions for most common (PCI and sysbus) 
devices. And since memory regions are also added as children to their 
owner (or unattached) you should also be able to get a list of them from 
QOM.

> As several people have already pointed out in this thread, we do have a poor 
> track record of API conversions but the introduction of memory regions shows 
> how this can be done successfully.
>
> Given that we already have multiple ways of doing the same thing, I tend to 
> lean against not introducing yet-another-API unless we can come up with a 
> long-term strategy for its use. In particular this causes problems in review 
> where e.g. one reviewer may want to use QOM to setup a device whilst another 
> may want to use qdev which is confusing for everyone, including the code 
> submitter.
>
> If we can at least get an answer to 1) then I'd be willing to have a go at 
> writing some kind of specification document and put it out for feedback...

Clarifying the different naming and tree hierarchies would definitely 
help. So far I don't see what qom-tree is useful for and why it's not the 
same as qtree. I don't know if that's related but we also have type names 
and the fdt based machine creation may need to add aliases for those to 
match the names they are referenced in device trees (such as in 
"compatible" properties). Maybe finding a naming and hierarchy that's 
close to a dtb would make it less confusing.

Regards,
BALATON Zoltan
--3866299591-1498801505-1771979778=:99179--

