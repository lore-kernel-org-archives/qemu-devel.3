Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB02CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 13:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIRrk-0000rk-CV; Mon, 10 Nov 2025 08:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vIRQj-0007mx-Ou; Mon, 10 Nov 2025 07:55:36 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vIRQh-0005Sf-2R; Mon, 10 Nov 2025 07:55:33 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B5D6B597313;
 Mon, 10 Nov 2025 13:55:24 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id q3dWCVei1blB; Mon, 10 Nov 2025 13:55:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A974D5972FF; Mon, 10 Nov 2025 13:55:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A79455972F3;
 Mon, 10 Nov 2025 13:55:22 +0100 (CET)
Date: Mon, 10 Nov 2025 13:55:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>
cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 eblake@redhat.com
Subject: Re: [PATCH v2 1/5] vvfat: introduce partitioned option
In-Reply-To: <CAJ307Eg7x_rKb5qybgW3XxAKLP=1ds524gqgXettv2cZ8WTMww@mail.gmail.com>
Message-ID: <757f66d0-625c-9d1b-5090-3d5210903173@eik.bme.hu>
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-2-chigot@adacore.com> <878qgenqum.fsf@pond.sub.org>
 <CAJ307Eg7x_rKb5qybgW3XxAKLP=1ds524gqgXettv2cZ8WTMww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-7860530-1762779322=:96832"
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

--3866299591-7860530-1762779322=:96832
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Nov 2025, Clément Chigot wrote:
> On Mon, Nov 10, 2025 at 11:07 AM Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Clément Chigot <chigot@adacore.com> writes:
>>
>>> This option tells whether a hard disk should be partitioned or not. It
>>> defaults to true and have the prime effect of preventing a master boot
>>> record (MBR) to be initialized.
>>>
>>> This is useful as some operating system (QNX, Rtems) don't
>>> recognized FAT mounted disks (especially SD cards) if a MBR is present.
>>>
>>> Signed-off-by: Clément Chigot <chigot@adacore.com>
>>
>> [...]
>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index b82af74256..8a479ba090 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -3464,8 +3464,8 @@
>>>  #
>>>  # @fat-type: FAT type: 12, 16 or 32
>>>  #
>>> -# @floppy: whether to export a floppy image (true) or partitioned hard
>>> -#     disk (false; default)
>>> +# @floppy: whether to export a floppy image (true) or hard disk
>>> +#     (false; default)
>>>  #
>>>  # @label: set the volume label, limited to 11 bytes.  FAT16 and FAT32
>>>  #     traditionally have some restrictions on labels, which are
>>> @@ -3474,11 +3474,15 @@
>>>  #
>>>  # @rw: whether to allow write operations (default: false)
>>>  #
>>> +# @partitioned: whether a hard disk will be partitioned
>>
>> How does "partitioned" combine with "floppy": true?
>>
>> Is it silently ignored?
>>
>> Is it an error if present?
>>
>> Is it an error if true?
>>
>> Does it add a partition table if true?
>>
>>> +#     (default: true)
>>
>> Hmm, this suggests it's silently ignored.
>>
>> Silently ignoring nonsensical configuration is usually a bad idea.
>
> True, but that would mean "unpartitioned" must always be passed when
> "floppy" is requested. That would make such command lines a bit more
> verbose, but otherwise I don't think there is any issue to that.
>
> Note that I didn't add "partition" as a keyword in the command line.
> Currently, it's either the default (thus partitioned) or
> "unpartitioned" being requested. Do you think it makes sense to add it
> as well, even if it's redundant ?
>
>>> +#     (since 10.2)
>>> +#
>>
>> Not sure I like "partitioned".  Is a disk with an MBR and a partition
>> table contraining a single partition partitioned?  Call it "mbr"?
>
> It used to be called "mbr/no-mbr" but Kevin suggested renaming it in
> V1. Honestly I'm fine with both options:
> - Technically, the option prevents MBR which has a side effect for
> preventing partition tables
> - Even it has a single partition, I think it makes sense to call a
> disk "partitioned" as long as it has a partition table
>
> But I'm not that familiar with disk formats, etc. I'll let you decide
> with Kevin, which one you prefer.

I'd also vote for mbr or similar shorter name; unpartitioned is awkward to 
type out in a command line. Maybe it can default to false for floppy and 
true for disk to preserve current behaviour but allow controlling it.

Regards,
BALATON Zoltan

>>>  # Since: 2.9
>>>  ##
>>>  { 'struct': 'BlockdevOptionsVVFAT',
>>>    'data': { 'dir': 'str', '*fat-type': 'int', '*floppy': 'bool',
>>> -            '*label': 'str', '*rw': 'bool' } }
>>> +            '*label': 'str', '*rw': 'bool', '*partitioned': 'bool' } }
>>>
>>>  ##
>>>  # @BlockdevOptionsGenericFormat:
>>
>
>
--3866299591-7860530-1762779322=:96832--

