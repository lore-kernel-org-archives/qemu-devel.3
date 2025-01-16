Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBC9C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSVZ-0000OM-GQ; Thu, 16 Jan 2025 11:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tYSUW-0004iE-IR; Thu, 16 Jan 2025 11:13:10 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tYSUU-0004mF-54; Thu, 16 Jan 2025 11:13:08 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 465E84E603E;
 Thu, 16 Jan 2025 17:13:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4hNBsxdYkAAM; Thu, 16 Jan 2025 17:13:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E57384E6063; Thu, 16 Jan 2025 17:13:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E28F474577C;
 Thu, 16 Jan 2025 17:13:00 +0100 (CET)
Date: Thu, 16 Jan 2025 17:13:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
In-Reply-To: <CAFEAcA87oYqMj1t+yriXHLuTg3G-=eRwOvt4-n4uJmeNujTBxQ@mail.gmail.com>
Message-ID: <d9acf231-829e-4a9c-7429-282fcc2ae756@eik.bme.hu>
References: <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu>
 <Z4AjkXbZeu3T94Y1@x1n> <Z4AldAcucTyqZ0HJ@x1n>
 <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com> <Z4E6TnKaUt8FMWIv@x1n>
 <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com> <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com> <Z4aYpo0VEgaQedKp@x1n>
 <CAFEAcA_mpWZO8V9cE74bKzveEEZDXkqE+XbOFFdhmKUKO3dmSw@mail.gmail.com>
 <Z4a3GxEbz1jjCDc5@x1n>
 <CAFEAcA87oYqMj1t+yriXHLuTg3G-=eRwOvt4-n4uJmeNujTBxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Thu, 16 Jan 2025, Peter Maydell wrote:
> On Tue, 14 Jan 2025 at 19:12, Peter Xu <peterx@redhat.com> wrote:
>>
>> On Tue, Jan 14, 2025 at 05:42:57PM +0000, Peter Maydell wrote:
>>> There's at least one test in the arm qtests that will hit this.
>>> I suspect that you'll find that most architectures except x86
>>> (where we don't have models of complex SoCs and the few
>>> machines we do have tend to be old code that is less QOMified)
>>> will hit similar issues. I think there's a general issue here,
>>> this isn't just "some particular ppc device is wrongly coded".
>>
>> I see.  Do you know how many of them would be important memory leaks that
>> we should fix immediately?
>
> None of these are important memory leaks, because the device is
> almost always present for the lifetime of the simulation. The
> only case you'd actually get a visible leak would be if you
> could hot-unplug the device, and even then you'd have to
> deliberately sit there doing hot-plug-then-unplug cycles to
> leak an interesting amount of memory.
>
> The main reason to want to fix them is that it lets us run
> "make check" under the sanitizer and catch other, more
> interesting leaks.
>
>> I mean, we have known memory leaks in QEMU in many places I assume.  I am
>> curious how important this problem is, and whether such would justify a
>> memory API change that is not reaching a quorum state (and, imho, add
>> complexity to memory core and of course that spreads to x86 too even if it
>> was not affected) to be merged.  Or perhaps we can fix the important ones
>> first from the device model directly instead.
>
> The problem is generic, and the problem is that we have not actually
> nailed down how this is supposed to work, i.e:
> * what are the reference counts counting?

It would be very unintuitive if ref counts not counted the number of 
references to the object that contains this ref count. If I understood 
correctly that's the reason for this discussion that in this case the ref 
count of the owner is counting the MRs instead of its own references and 
the MR's ref count is not used which is confusing.

> * if a device has this kind of memory region inside another,
>   how is it supposed to be coded so as to not leak memory?
>
> If we can figure out how the lifecycle and memory management
> is supposed to work, then yes, we can fix the relevant device
> models so that they follow whatever the rules are. But it seems

If looking for rules to follow one proven and relatively simple set is 
what Cocoa uses on macOS. There's a very short introduction here:
https://www.peachpit.com/articles/article.aspx?p=377302&seqNum=2
and a bit longer more complete here:
https://www.tomdalling.com/blog/cocoa/an-in-depth-look-at-manual-memory-management-in-objective-c/

I think this case is one which is shortly mentioned at the end of the 
second link which is solved by not retaining the contained objects so this 
is closer to what PeterX suggests just dropping the refcounting on the 
owner and consider the MRs owned by the superregions once added there. 
This means add subregion would pass the reference to the owner and remove 
subregion passes it back to who called it so the MR's ref count needs no 
change but then who added the MR should not use it after passing it to the 
superregion and who called remove subregion should release it. But I don't 
really understans the problem so maybe it's more complex.

Regards,
BALATON Zoltan

> to me that at the moment we have not got a consensus on how
> this is supposed to work. Until we have that, there's no way to
> fix this at the device model level, because we don't know what
> changes we need to make.
>
> thanks
> -- PMM
>
>

