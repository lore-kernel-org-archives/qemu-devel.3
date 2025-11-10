Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22126CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 21:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIZZa-0005Gb-NT; Mon, 10 Nov 2025 16:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vIZZG-00051n-Vg; Mon, 10 Nov 2025 16:36:55 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vIZZE-00012h-Dg; Mon, 10 Nov 2025 16:36:54 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0F868597476;
 Mon, 10 Nov 2025 22:36:49 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id yZlOxMaIdSPy; Mon, 10 Nov 2025 22:36:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EEBF65972F3; Mon, 10 Nov 2025 22:36:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EC6915972E2;
 Mon, 10 Nov 2025 22:36:46 +0100 (CET)
Date: Mon, 10 Nov 2025 22:36:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Kevin Wolf <kwolf@redhat.com>
cc: Markus Armbruster <armbru@redhat.com>, 
 =?ISO-8859-15?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com, 
 eblake@redhat.com
Subject: Re: [PATCH v2 5/5] vvfat: add support for "fat-size" options
In-Reply-To: <aRITWJo6R_oG9t7R@redhat.com>
Message-ID: <bbf81b11-2583-02e7-0014-c30123419f62@eik.bme.hu>
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-6-chigot@adacore.com> <87zf8umbzh.fsf@pond.sub.org>
 <CAJ307EjObqJ6Pr5N+WrEffTr3pWOpRCKVVamZhCG9ZgwHczVYw@mail.gmail.com>
 <87bjlakpa5.fsf@pond.sub.org>
 <CAJ307EjZwiGj3N93Td9vA0JHyK0COZBXHqv-7cjpxxg+eKiisg@mail.gmail.com>
 <87o6paj96k.fsf@pond.sub.org> <aRIC1NZXQUxkR7iR@redhat.com>
 <f301fcab-a7d6-1d89-aa56-52397f0d940a@eik.bme.hu>
 <aRITWJo6R_oG9t7R@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-154205461-1762810606=:42229"
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

--3866299591-154205461-1762810606=:42229
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Nov 2025, Kevin Wolf wrote:
> Am 10.11.2025 um 16:36 hat BALATON Zoltan geschrieben:
>> On Mon, 10 Nov 2025, Kevin Wolf wrote:
>>> Am 10.11.2025 um 14:42 hat Markus Armbruster geschrieben:
>>>> Clément Chigot <chigot@adacore.com> writes:
>>>>
>>>>> On Mon, Nov 10, 2025 at 2:09 PM Markus Armbruster <armbru@redhat.com> wrote:
>>>>>>
>>>>>> Clément Chigot <chigot@adacore.com> writes:
>>>>>>
>>>>>>> On Mon, Nov 10, 2025 at 11:13 AM Markus Armbruster <armbru@redhat.com> wrote:
>>>>>>>>
>>>>>>>> Clément Chigot <chigot@adacore.com> writes:
>>>>>>>>
>>>>>>>>> This allows more flexibility to vvfat backend. The values of "Number of
>>>>>>>>> Heads" and "Sectors per track" are based on SD specifications Part 2.
>>>>>>>>>
>>>>>>>>> Due to the FAT architecture, not all sizes are reachable. Therefore, it
>>>>>>>>> could be round up to the closest available size.
>>>>>>>>>
>>>>>>>>> FAT32 has not been adjusted and thus still default to 504 Mib.
>>>>>>>>>
>>>>>>>>> For floppy, only 1440 Kib and 2880 Kib are supported.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Clément Chigot <chigot@adacore.com>
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>>>>>>> index 8a479ba090..0bcb360320 100644
>>>>>>>>> --- a/qapi/block-core.json
>>>>>>>>> +++ b/qapi/block-core.json
>>>>>>>>> @@ -3478,11 +3478,17 @@
>>>>>>>>>  #     (default: true)
>>>>>>>>>  #     (since 10.2)
>>>>>>>>>  #
>>>>>>>>> +# @fat-size: size of the device in bytes.  Due to FAT underlying
>>>>>>>>> +#     architecture, this size can be rounded up to the closest valid
>>>>>>>>> +#     size.
>>>>>>>>> +#     (since 10.2)
>>>>>>>>> +#
>>>>>>>>
>>>>>>>> Can you explain again why you moved from @size to @fat-size?
>>>>>>>
>>>>>>> Just to be sure, you mean in the above comment, in the commit message or both ?
>>>>>>
>>>>>> Just to me, because I'm not sure I like the change, but that may well be
>>>>>> due to a lack of understanding of your reasons.
>>>>>
>>>>> Naming `fat-size` instead of `size` ensures the parameter is only
>>>>> recognized by the vvfat backend. In particular, it will be refused by
>>>>> the default raw format, avoiding confusion:
>>>>>  "-drive file=fat:<path>,size=256M" results in a 504M FAT disk
>>>>> truncated to 256M, raw format being implicit.
>>>>>  "-drive file=fat:<path>,fat-size=256M" is refused. "fat-size" is
>>>>> unsupported by raw format.
>>>>
>>>> I figure throwing in format=raw to make raw format explicit doesn't
>>>> change anything.  Correct?
>>>>
>>>>>  "-drive file=fat:<path>,format=vvfat,fat-size=256M" results in a 256M FAT disk.
>>>>>  "-drive file=fat:<path>,format=vvfat,size=256M" is refused. "size" is
>>>>> unsupported by vvfat format.
>>>>
>>>> If it was called @size, what behavior would we get?  Just two cases, I
>>>> think:
>>>>
>>>> 1. With raw format:
>>>>
>>>>     -drive file=fat:<path>,size=256M
>>>
>>> You'd silently get a 504 MiB filesystem truncated to 256 MiB (i.e. a
>>> corrupted file system). It's quite easy to forget format=vvfat, so
>>> something that initially looks like it might be working is not a great
>>> result for this user error.
>>
>> Why doesn't file=fat: imply format=vvfat? For what is the fat: part in
>> file then?
>
> -drive is built pretty much on the assumption that you have an image
> format that runs on top of a protocol. Format probing probes the image
> format, not the protocol, while prefixes like fat: (or nbd:, http: etc.)
> specify the protocol.

Thanks for clarifying. Is this described somewhere in the docs? The file 
formats are mentioned but the protocol and their relation to formats is 
not clearly described. Maybe it's worth clarifying that in the docs.

> So if you don't specify the format, we first open the protocol level
> (which is vvfat) and then probing will detect that over this protocol,
> we access a raw image. So it's mostly like saying format=raw.

I'm still not sure I completely get this but vvfat is not backed by a raw 
image but a host directory so why is the raw file format comes into play 
here at all? Shouldn't this always assume that for fat: the format is 
vvfat (or no format) and not a raw file? Then size property then would 
also work as expected.

> I think that format=<protocol driver> works is really more accidental,
> but we can't change it now (and probably also don't want to). It results
> in opening only the protocol layer and not stacking any format driver on
> top of it.

Does any format make sense for fat: at all considering the above that it 
does not access an image file with a format but a host directory? So maybe 
using and defaulting to format=raw is not quite right here?

> Options that you specify in -drive generally go to the top layer. So the
> consequence in our case is that with format=vvfat, the option goes to
> vvfat, but with format=raw (or unspecified format), it goes to the raw
> forma driver.

It would work if it would not default to format=raw for fat: which seems 
to make more sense to me than the current default but I don't know if it's 
easy or possible to change that.

>> I currently recommend using:
>>
>> -drive if=none,id=ufat,format=raw,file=fat:rw:/dir/to/export
>> -device usb-storage,drive=ufat
>>
>> to my users which I got from somewhere but don't remember where and it
>> seems to work but maybe not the best way to specify this.
>
> It's fine, and I might use the same one myself (though you should be
> aware that fat:rw: is risky, it's full of bugs).
>
> But if you add an option like size=64M, it goes to the raw driver, which
> will take whatever image you access on the protocol level and truncate
> it at 64 MiB.
>
> If you want to give the size option on the vvfat level (and create a
> filesystem that is actually only 64 MiB instead of truncating a larger
> one), then obviously format=vvfat allows you to do that because then
> there is no raw format layer to begin with. Or if you do have the raw
> format layer, you can access options of the protocol layer by prefixing
> "file.". So format=raw,file.size=64M would still pass the size option to
> vvfat.
>
> So the command line does allow you to get the option to the right place,
> it's just very easy to get confused about this and to specify the option
> for the wrong layer.

In that case maybe it's enough to give a warning in case we detect the 
wrong usage and point users to use the right way to specify size instead 
of adding another fat-size, fs-size or mbr-size option for this? 
Considering that format=vvfat,size=256M works I think either changing the 
default format for fat: or giving an error if fat: and size is specified 
without format=vvfat would solve this without a new option.

Regards,
BALATON Zoltan

>> After reading this thread I'm confused about how to use this
>> correctly. Is there some documentation on this? There only seems to be
>> some mentions in docs/system/qemu-block-drivers.rst.inc but all of
>> them using older options:
>>
>>   |qemu_system| linux.img -hdb fat:/my_directory
>>   |qemu_system| linux.img -fda fat:floppy:/my_directory
>>   |qemu_system| linux.img -fda fat:floppy:rw:/my_directory
>
> All of those are honestly fine, too, if you're happy with the defaults
> and don't want to set more advanced options.
>
> I'll give you this bonus option if you want to be modern:
>
>    -blockdev vvfat,node-name=ufat,dir=/my_directory,rw=on
>    -device usb-storage,drive=ufat
>
> But I don't think any of the other options is going away anytime soon.
>
> Kevin
>
>
--3866299591-154205461-1762810606=:42229--

