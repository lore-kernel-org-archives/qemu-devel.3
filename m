Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D438BFF60FB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7VrA-0003sq-RC; Tue, 31 Mar 2026 05:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7VrA-0003sf-0u
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:57:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7Vr6-0000lc-Fr
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:57:55 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 19E94596A47;
 Tue, 31 Mar 2026 11:57:49 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id FM-Ax3SjLYoX; Tue, 31 Mar 2026 11:57:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0B44B596A1D; Tue, 31 Mar 2026 11:57:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 093B35969F3;
 Tue, 31 Mar 2026 11:57:47 +0200 (CEST)
Date: Tue, 31 Mar 2026 11:57:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: VGA default endianness (was: [PATCH] hw/display/cirrus_vga_isa:
 Disable global_vmstate by default for new machines)
In-Reply-To: <acoQV5ZyGAw9hggX@sirius.home.kraxel.org>
Message-ID: <b275f2a7-6733-d6bd-9c4a-e94a0ab63b11@eik.bme.hu>
References: <20260326154850.301609-1-thuth@redhat.com>
 <30981a1a-b895-3829-0f9c-7b22e72bd0fa@eik.bme.hu>
 <acoQV5ZyGAw9hggX@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 30 Mar 2026, Gerd Hoffmann wrote:
> On Sun, Mar 29, 2026 at 09:07:42PM +0200, BALATON Zoltan wrote:
>> On Thu, 26 Mar 2026, Thomas Huth wrote:
>>> In the long run, we would like to get rid of the code that allows to
>>
>> Not related to this patch but there's another hack in vga that might be good
>> to get rid of similarly. At hw/display/vga.c:2263 it says:
>>
>>     /*
>>      * Set default fb endian based on target, could probably be turned
>>      * into a device attribute set by the machine/platform to remove
>>      * all target endian dependencies from this file.
>>      */
>>     s->default_endian_fb = target_big_endian();
>>     s->big_endian_fb = s->default_endian_fb;
>>
>> I think this does not make much sense as VGA is little endian but since this
>> hack is there since forever just changing it may break some guests.
>
> Short history lesson:  Loooong ago vga used to have hard-coded
> endianess.  Then vga got support for switching endianness at runtime,
> and this was added for backward compatibility.

Not all VGA that use hw/display/vga.c can switch endianness. It seems only 
stdvga-pci, bochs-display and ati-vga can but not the others. There are 
even some sysbus vga devices that might need some changes.

> IIRC the arrival of little endian powerpc support triggered all that,
> and I had my share of endian bugs in different places during that time.
>
> Some guest drivers have been fixed since, the linux driver explicitly
> sets endianess since years, but ...
>
>> I've tried that changing the default_endian_fb to false at least
>> breaks OpenBIOS and its QEMU VGA NDRV for MacOS.
>
> ... apparently not all guest drivers.
>
>> So at least those might need some backward compatibility property
>> until they are fixed. I don't know what else could it break
>
> Only the colors will break.  Guest writes big-endian data, host
> interprets that as little-endian data, and you get a funny looking
> screen.

That's enough to make it unusable in practice so we'd need to do something 
about that.

>> but maybe it would be a good opportunity to change it with new machine
>> types with a property that could also be set by users if something breaks
>> just to find out what might need fixing and eventually be able to remove it.
>
> I think it makes sense to try fix the remaining guest drivers first.

Problem is we don't know what those guests are. I've randomly found 
OpenBIOS and the MacOS NDRV because I know they use big endian but don't 
know how many others are there. That's why I thought maybe adding a 
property and changing the default could work as users could just add the 
property to their command until the drivers are adapted.

Regards.
BALATON Zoltan

