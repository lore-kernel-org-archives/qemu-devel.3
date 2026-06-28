Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721FEC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 10:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdmpd-0008Ax-Mq; Sun, 28 Jun 2026 06:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wdmpb-0008Ao-KM
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 06:33:43 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wdmpZ-0000Iw-JA
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 06:33:43 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 523B3596952;
 Sun, 28 Jun 2026 12:33:35 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id uU_z76JEoXxL; Sun, 28 Jun 2026 12:33:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DABB7596948; Sun, 28 Jun 2026 12:33:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D8C5B5968DE;
 Sun, 28 Jun 2026 12:33:32 +0200 (CEST)
Date: Sun, 28 Jun 2026 12:33:32 +0200 (CEST)
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
In-Reply-To: <c8002863-d6cf-465d-99f7-3d3917d13d16@redhat.com>
Message-ID: <bc138fc1-8cdf-2710-540e-89d1119f9ef1@eik.bme.hu>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-5-berrange@redhat.com>
 <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
 <ajpa8kO1bfIhbNAw@redhat.com>
 <c8002863-d6cf-465d-99f7-3d3917d13d16@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1543300468-1782642812=:11169"
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

--3866299591-1543300468-1782642812=:11169
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 25 Jun 2026, Paolo Bonzini wrote:
> On 6/23/26 12:07, Daniel P. Berrangé wrote:
>> On Wed, Jun 17, 2026 at 02:49:57PM +0200, Paolo Bonzini wrote:
>>> For buses, the fact that the parent and child live at the same time is
>>> explicitly tracked with mutual refcount and unparent.
>> 
>> If we get mutual ref counting correct, then there is not benefit
>> to having 2 different ways of allocating QOM objects. We should
>> eliminate the embedding as pointless extra complexity and focus
>> on getting ref counting done correctly.
>
> Nobody really *should* notice that there are 2 different ways of allocating 
> QOM objects, just like you don't think about the difference between:
>
>   char *s = "hello";
>   g_autofree char *t = g_strdup("world")
>
> The problem is that the mutual ref counting is wrong.  Fix that and you won't 
> care about init vs. new.

You can't fix that without more hacks because memory regions cannot be ref 
counted and freed when their ref count goes to zero without 
memory_region_new. Currently memory regions cannot be ref counted so we 
ref count their owners instead which fails if the owners are also owned. 
Maybe this could be fixed somehow but it may be simpler to allow ref 
counted memory regions and fix mutual ref count that way.

If you want to keep a single version of memory_region_init we'll have to 
remove object_initialize from it then you could do

MemoryRegion mr;
object_initialize(&mr);
memory_region_init(&mr);

and

MemoryRegion *mr = object_new();
memory_region_init(mr);

which is similiar to your char * example above (you can't simply do 
allocate and init an object like "hello" does so it will be two lines). 
But that needs to change every current usage. If you insist I can go that 
way but just adding memory_region_new would be more convenient with less 
churn kkeeping the existing lines simple. Wanting to keep the memory API 
simple means the callers will have to do more work which is not the 
purpose of an API, it should allow what callers need.

>>> the hack that Akihiko mentioned
>>> (https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg03459.html):
>> 
>> That hack is too gross.
>
> I agree and it's also wrong.
>
>> The relationship between objects does not need to be expressed with
>> embedding one inside another struct. This should be represented at
>> the class level with properties for the child relationships, which
>> would give us introspection via QMP too.  The embedding isn't adding
>> any real value IMHO.
>
> There is a difference in what the code expresses: you have on one hand an 
> embedded Foo, which has to be tied to the lifetime of the parent, and on the 
> other hand a Foo* which can be anywhere and might be provided by an object 
> property.  One is a child<Foo>, the other is a link<Foo>.

Embedding does not make a child<Foo> relation. object_property_add_child 
does which is independent of embedding. Embedding does not solve anything 
just ties the object storage together and frees the embedded object with 
the owner even if it was not yet finalised or still has refs. 
MemoryRegions are QOM objects so they should behave like all other QOM 
objects and not have special memory management as they are forced to have 
now because of not being able to allocate ref counted memory regions.

Regards,
BALATON Zoltan
--3866299591-1543300468-1782642812=:11169--

