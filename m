Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A395DCE7B08
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtoB-0000Ti-HB; Fri, 14 Nov 2025 08:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vJto1-0000RT-Tb; Fri, 14 Nov 2025 08:25:37 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vJtnx-0006AD-Qd; Fri, 14 Nov 2025 08:25:36 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B7F3E5972E8;
 Fri, 14 Nov 2025 14:25:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id FyWVkKh9w2Yi; Fri, 14 Nov 2025 14:25:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A3A415972E2; Fri, 14 Nov 2025 14:25:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A18435972E4;
 Fri, 14 Nov 2025 14:25:26 +0100 (CET)
Date: Fri, 14 Nov 2025 14:25:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>
cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com, 
 eblake@redhat.com
Subject: Re: [PATCH v2 1/5] vvfat: introduce partitioned option
In-Reply-To: <CAJ307EjFMrXOmQMF5YckQ6hMGdFGtdYdAH3fWShcvwEXAtBrrw@mail.gmail.com>
Message-ID: <87c7d0d6-8f8f-b6f2-3c81-0b0572dbad2c@eik.bme.hu>
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-2-chigot@adacore.com> <878qgenqum.fsf@pond.sub.org>
 <CAJ307Eg7x_rKb5qybgW3XxAKLP=1ds524gqgXettv2cZ8WTMww@mail.gmail.com>
 <757f66d0-625c-9d1b-5090-3d5210903173@eik.bme.hu>
 <87346mkos9.fsf@pond.sub.org> <aRH_2gcYOH31UB38@redhat.com>
 <87ecq5f201.fsf@pond.sub.org>
 <CAJ307EjFMrXOmQMF5YckQ6hMGdFGtdYdAH3fWShcvwEXAtBrrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1758519928-1763126726=:96084"
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

--3866299591-1758519928-1763126726=:96084
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 14 Nov 2025, Clément Chigot wrote:
> On Tue, Nov 11, 2025 at 8:43 AM Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Kevin Wolf <kwolf@redhat.com> writes:
>>
>>> Am 10.11.2025 um 14:20 hat Markus Armbruster geschrieben:
>>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>>
>>>>> On Mon, 10 Nov 2025, Clément Chigot wrote:
>>>>>> On Mon, Nov 10, 2025 at 11:07 AM Markus Armbruster <armbru@redhat.com> wrote:
>>>>>>>
>>>>>>> Clément Chigot <chigot@adacore.com> writes:
>>>>>>>
>>>>>>>> This option tells whether a hard disk should be partitioned or not. It
>>>>>>>> defaults to true and have the prime effect of preventing a master boot
>>>>>>>> record (MBR) to be initialized.
>>>>>>>>
>>>>>>>> This is useful as some operating system (QNX, Rtems) don't
>>>>>>>> recognized FAT mounted disks (especially SD cards) if a MBR is present.
>>>>>>>>
>>>>>>>> Signed-off-by: Clément Chigot <chigot@adacore.com>
>>
>> [...]
>>
>>>>>>> Not sure I like "partitioned".  Is a disk with an MBR and a partition
>>>>>>> table contraining a single partition partitioned?  Call it "mbr"?
>>>>>>
>>>>>> It used to be called "mbr/no-mbr" but Kevin suggested renaming it in
>>>>>> V1. Honestly I'm fine with both options:
>>>>>> - Technically, the option prevents MBR which has a side effect for
>>>>>> preventing partition tables
>>>>
>>>> Yes, because the partition table is part of the MBR.  I'd rather name
>>>> the option after the entire thing it controls, not one of its parts.
>>>>
>>>>>> - Even it has a single partition, I think it makes sense to call a
>>>>>> disk "partitioned" as long as it has a partition table
>>>>>>
>>>>>> But I'm not that familiar with disk formats, etc. I'll let you decide
>>>>>> with Kevin, which one you prefer.
>>>>
>>>> Kevin is the maintainer, I just serve as advisor here.
>>>
>>> I figured that the meaning of "partitioned" is easier to understand for
>>> a casual user than having or not having an MBR ("I don't want to boot
>>> from this disk, why would I care about a boot record?").
>>
>> Fair point.
>>
>> Possible counter-points:
>>
>> * The default is almost always right for the casual user.  The
>>   exception, as far as I understand, is certain guest OSes refuse to
>>   play ball with certain devices when they have an MBR.
>>
>> * The configuration interface isn't exactly casual-user-friendly to
>>   begin with.  @fat-type, what's that, and why do I care?  @floppy,
>>   what's that, and why do I care?
>>
>> Anyway, you decide.
>
> AFAICT, there are two open questions for that patch:
>
> 1. "mbr" vs "partitioned".
> I do think "partitioned" is clearer, a bit more casual friendly. "mbr"
> requires knowledge about FAT format, while what's a partition should
> be known by a wider audience.
> Side note, in V3, I'll remove the "unpartitioned" keyword to simply
> replace it by "partitoned=false" (I wasn't aware such an obvious
> possibility was working...). So we might even call it
> "partition/partitions=true|false".
>
> 2. The default value. Should it be "false" for @floppy ?
> IMO, having a default value independent of other arguments is always
> better. Hence, I'll push for keeping "partitioned=true" as the
> default, and having users forcing "partitioned=false" for floppy (an
> error being raised otherwise). As we'll probably change the default
> behavior with floppy anyway (cf patch 2), I don't think it will hurt a
> lot to make users passing a new flag.

Combined with the option called partinioned=false that's quite unfriendly 
for users trying to type a command line. Maybe not many do but those who 
don't also don't care about what are the defaults or if it's called mbr or 
partitioned as whatever generates the command line for them takes care 
of that. So I'm still for user friendly CLI but I also don't care enough 
to insist more if others don't think it's worth to keep this user friendly 
for command line users.

There was another question if the fat-size option is really needed or it 
could just use size if the default format=raw was changed to behave like 
format=vvfat if file=fat: is given which I think would make more sense 
than only truncating the underlying raw format that's not even needed to 
be there but I don't know how difficult it is to implement this or the 
default format=raw is hard coded and hard to change for fat: protocol.

So in summary:

1. format=vvfat,size=xMB was said to work so could file=fat:/dir,size=xMB 
imply format=vvfat so it would also work? Then no other size option is 
needed.

2. Having different defaults for floppy or disk would keep existing 
command lines working. Otherwise why not make partitioned=false the 
default and let users who need it set explicitly. That would also work for 
most cases without having to type out this option.

Regards,
BALATON Zoltan
--3866299591-1758519928-1763126726=:96084--

