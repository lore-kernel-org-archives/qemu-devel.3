Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBA8C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 19:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVd6c-0002UH-7w; Thu, 01 Feb 2024 14:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rVd6R-0002MW-8m; Thu, 01 Feb 2024 14:52:04 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rVd6N-0004f6-6Q; Thu, 01 Feb 2024 14:52:02 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 87BEF4E601F;
 Thu,  1 Feb 2024 20:51:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id q6lRP_WyK7Ea; Thu,  1 Feb 2024 20:51:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8B5164E601E; Thu,  1 Feb 2024 20:51:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8991F7456B4;
 Thu,  1 Feb 2024 20:51:51 +0100 (CET)
Date: Thu, 1 Feb 2024 20:51:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 Miroslav Rezanina <mrezanin@redhat.com>
Subject: Re: [PATCH] hw/ide: Add the possibility to disable the CompactFlash
 device in the build
In-Reply-To: <bffd1672-c084-4177-8a5a-51e0dbcf38be@redhat.com>
Message-ID: <25d24f0f-550d-2d38-3c26-b225f03a967f@eik.bme.hu>
References: <20240201082916.20857-1-thuth@redhat.com>
 <alpine.LMD.2.03.2402011326360.16176@eik.bme.hu>
 <13ab647c-df89-49ab-8f76-8ce57d519aab@redhat.com>
 <alpine.LMD.2.03.2402011352080.16176@eik.bme.hu>
 <bffd1672-c084-4177-8a5a-51e0dbcf38be@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-292732250-1706817111=:91312"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--3866299591-292732250-1706817111=:91312
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 1 Feb 2024, Thomas Huth wrote:
> On 01/02/2024 13.54, BALATON Zoltan wrote:
>> On Thu, 1 Feb 2024, Thomas Huth wrote:
>>> On 01/02/2024 13.39, BALATON Zoltan wrote:
>>>> On Thu, 1 Feb 2024, Thomas Huth wrote:
>>>>> For distros like downstream RHEL, it would be helpful to allow to 
>>>>> disable
>>>>> the CompactFlash device. For making this possible, we need a separate
>>>>> Kconfig switch for this device, and the code should reside in a separate
>>>>> file.
>>>>> 
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>> hw/ide/qdev-ide.h  | 41 ++++++++++++++++++++++++++++++++
>>>>> hw/ide/cf.c        | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>> hw/ide/qdev.c      | 51 ++--------------------------------------
>>>>> hw/ide/Kconfig     |  4 ++++
>>>>> hw/ide/meson.build |  1 +
>>>>> 5 files changed, 106 insertions(+), 49 deletions(-)
>>>>> create mode 100644 hw/ide/qdev-ide.h
>>>>> create mode 100644 hw/ide/cf.c
>>>>> 
>>>>> diff --git a/hw/ide/qdev-ide.h b/hw/ide/qdev-ide.h
>>>>> new file mode 100644
>>>>> index 0000000000..3dd977466c
>>>>> --- /dev/null
>>>>> +++ b/hw/ide/qdev-ide.h
>>>> 
>>>> This may be unrelated to this patch but we already have 
>>>> include/hw/ide/internal.h which may be a place these should go in but 
>>>> that header is in inlcude because some files outside hw/ide include it. 
>>>> I've found three places that include ide/internal.h: hw/arm/sbsa-ref.c, 
>>>> hw/i386/pc.c and hw/misc/macio.h. Only macio is really needing internal 
>>>> IDE parts the other two just uses some functions so macio is probably the 
>>>> reason this wasn't cleaned up yet. In any case, maybe this could go in 
>>>> include/hw/ide/internal.h to avoid introducing a new header or somehow 
>>>> make this a local header where non-public parts of hw/ide/internal.h 
>>>> could be moved in the future. Such as rename include/hw/ide/internal.h to 
>>>> ide.h and name this one internal.h maybe?
>>> 
>>> I don't like headers that much that just collect a lot of only slightly 
>>> related things. That only causes problems again when you have to 
>>> unentangle the stuff one day. So what's wrong with having a dedicated 
>>> header for the stuff in hw/ide/qdev.c ?
>> 
>> Maybe that it's not obvious from the name that it belongs to qdev.c as the 
>> names are not the same.
>
> I didn't want to just name the header "qdev.h" since that could easily be 
> confused in #include statements...
> IMHO qdev.c is already a very bad idea for a file name here... maybe 
> something like ide-dev.c and ide-dev.h would be better?

The comment at the beginning of qdev.c says "ide bus support" but a lot of 
functions in it have ide_dev prefix. Maybe this comes from the original 
qdev-ification of this code and then adding some more unrelated parts in 
this file. It's clearly beyond scope of this patch to clean all this but 
since you're changing it maybe this is a good opportunity to reduce the 
mess a bit. I'm OK with renaming qdev.c to ide-dev.c or qdev-ide.c or 
whatever else as long as it's clear that the header belongs to the c file.

>> Also some of the qdev stuff that should be in this header are in 
>> include/hw/ide/internal.h so these will still be split arbitrarily.
>
> Oh, well, it seems to be a mess already... hw/ide/pci.h includes the 
> internal.h header and thus opens the internal definitions to all PCI-based 
> IDE devices :-/

I've missed that so besides files directly including internal.h there 
could be others using some stuff from it through pci.h so this makes it 
more difficult to untangle.

> If we can agree on a better name for qdev-ide.h, I can try to clean that mess 
> up a little bit...

My comment was only that if you make changes then do it in a way that 
leaves the possibility to move stuff here to clean the current situation 
but if you can also do some of it now that's even better but not required.

Regards,
BALATON Zoltan
--3866299591-292732250-1706817111=:91312--

