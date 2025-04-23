Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630C5C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 14:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7alG-0003OT-CR; Wed, 23 Apr 2025 10:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u7alD-0003Nm-F8
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:07:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u7alA-00086O-5S
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:07:35 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 678D155D21A;
 Wed, 23 Apr 2025 16:07:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id XaWpNuNWN2dv; Wed, 23 Apr 2025 16:07:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6707555C592; Wed, 23 Apr 2025 16:07:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 64774745682;
 Wed, 23 Apr 2025 16:07:27 +0200 (CEST)
Date: Wed, 23 Apr 2025 16:07:27 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org, 
 "Edgar E.Iglesias" <edgar.iglesias@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 0/2] Move device tree files in a subdir in pc-bios
In-Reply-To: <aAjlEd5aSx578AJ0@redhat.com>
Message-ID: <96a9f5d9-576e-bfe7-6da5-411aaaf745e9@eik.bme.hu>
References: <cover.1745402140.git.balaton@eik.bme.hu>
 <f3501944-f278-45a8-91a7-0dab5a5416e0@nutanix.com>
 <dc690610-8484-4da0-9233-74d711f263cf@linaro.org>
 <aAjTT6qRwp139RII@redhat.com>
 <fe7faa77-6480-b6cb-fb7e-b0ae17735646@eik.bme.hu>
 <aAjlEd5aSx578AJ0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1742991278-1745417247=:36822"
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

--3866299591-1742991278-1745417247=:36822
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 23 Apr 2025, Daniel P. Berrangé wrote:
> On Wed, Apr 23, 2025 at 02:54:26PM +0200, BALATON Zoltan wrote:
>> On Wed, 23 Apr 2025, Daniel P. Berrangé wrote:
>>> On Wed, Apr 23, 2025 at 01:23:28PM +0200, Philippe Mathieu-Daudé wrote:
>>>> Hi Mark,
>>>>
>>>> On 23/4/25 12:18, Mark Cave-Ayland wrote:
>>>>> On 23/04/2025 11:02, BALATON Zoltan wrote:
>>>>>
>>>>>> Simple series doing what the subject says.
>>>>>>
>>>>>> v2:
>>>>>> - Added changes to qemu.nsi (Philippe)
>>>>>> - Changed order of enum to keep it sorted. This changes value of
>>>>>> existing define but the value is not relevant, always used by name.
>>>>>>
>>>>>> BALATON Zoltan (2):
>>>>>>    system/datadir: Add new type constant for DTB files
>>>>>>    pc-bios: Move device tree files in their own subdir
>>>>>>
>>>>>>   MAINTAINERS                                |   2 +-
>>>>>>   hw/microblaze/boot.c                       |   2 +-
>>>>>>   hw/ppc/ppc440_bamboo.c                     |   2 +-
>>>>>>   hw/ppc/sam460ex.c                          |   2 +-
>>>>>>   hw/ppc/virtex_ml507.c                      |   2 +-
>>>>>>   include/qemu/datadir.h                     |  11 +++++++---
>>>>>>   pc-bios/{ => dtb}/bamboo.dtb               | Bin
>>>>>>   pc-bios/{ => dtb}/bamboo.dts               |   0
>>>>>>   pc-bios/{ => dtb}/canyonlands.dtb          | Bin
>>>>>>   pc-bios/{ => dtb}/canyonlands.dts          |   0
>>>>>>   pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
>>>>>>   pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
>>>>>>   pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
>>>>>>   pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
>>>>>>   pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
>>>>>>   pc-bios/meson.build                        |  23 +--------------------
>>>>>>   qemu.nsi                                   |   2 +-
>>>>>>   system/datadir.c                           |   5 ++++-
>>>>>>   18 files changed, 42 insertions(+), 32 deletions(-)
>>>>>>   rename pc-bios/{ => dtb}/bamboo.dtb (100%)
>>>>>>   rename pc-bios/{ => dtb}/bamboo.dts (100%)
>>>>>>   rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
>>>>>>   rename pc-bios/{ => dtb}/canyonlands.dts (100%)
>>>>>>   create mode 100644 pc-bios/dtb/meson.build
>>>>>>   rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
>>>>>>   rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
>>>>>>   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
>>>>>>   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)
>>>>>
>>>>> In previous discussions we've had around what to do with pc-bios, wasn't
>>>>> the consensus that we should aim towards dividing up the directory on a
>>>>> per-target basis? I'm wondering if this is going in right direction, as
>>>>> I can certainly see that a per-target split would be more useful to
>>>>> packagers.
>>
>> One problem is that pc-bios doesn't only contain machine firmware but also
>> card ROMs which would belong to more targets (or archs) as e.g. PCI cards
>> work on multiple archs. So it's not trivial to split by target, you'd still
>> have a lot of files not easily assigned to any target.
>>
>> This series is in preparation for another that will add a dtb for pegasos2
>> and I did not want to increase the mess and took the opportunity to try to
>> tidy it a bit. I don't intend to do any major refactoring of the pc-bios
>> dir, that's out of scope of these patches.
>>
>>>> pc-bios/ is already a mess, packagers usually take it as a whole. This
>>>> series isn't making the current situation worse.
>>>>
>>>> I don't recall a per-target split discussion, but one moving firmware
>>>> blobs out of tree in a more adapted storage like git-lfs.
>>>
>>> Talking about the pc-bios dir in general is a bit of a can of worms
>>> and we never make concrete progress historically :-(
>>>
>>> Probably best to split up the problem to some extent.
>>>
>>> The device tree files are conceptually quite different from the
>>> 3rd party pre-built firmware images, which are diffferent from
>>> the keymaps.
>>>
>>> IIUC, device tree files are tied to specific machine types, so
>>> I wonder if they should not simply live alongside their machine
>>> type .c impl file, completely outside of pc-bios ?
>>>
>>> eg
>>>
>>>  petalogix-ml605.{dts,dtb} live alongside hw/microblaze/petalogix_ml605_mmu.c
>>>  babmboo.{dts,dtb} live alongside ./hw/ppc/ppc440_bamboo.c
>>
>> You need the dtbs at run time and the dir where we can look files up is the
>> pc-bios. So these need to be installed there at the end. We could scatter
>> them around in the source to put them next their machines but that would
>> make installation of them more difficult than having it in one dir.
>>
>>> For the keymaps it feels like an probable easy win to move them to a
>>> ui/keymaps/ directory instead.
>>
>> Currently you can run a git build directly from build dir and it will find
>> the roms/dtbs/keymaps. You can also run a binary copied elsewhere if you
>> pass -L path/to/pc-bios. Moving things out of it would break this and may
>> cause more problems than it would solve.
>
>
> This is just describing a limitation of the current resource locating
> implementation. For running in tree there's no reason why we can't
> look in a different directory for keymaps/dtbs - we just took the
> lazy option historically of putting them alongside firmware. That
> can be fixed.

Yes but then you would need either two or more options for copied binary 
to point it to different directories for rom/dtb/keymap or make -L take a 
search path and list multiple directories. That's not too convenient for 
users.

Regards,
BALATON Zoltan
--3866299591-1742991278-1745417247=:36822--

