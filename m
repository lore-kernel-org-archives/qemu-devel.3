Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ACBC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 12:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMREI-00088i-Dx; Tue, 03 Jun 2025 08:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uMRED-00088K-CE
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:58:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uMRE4-0003Rs-Mh
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:58:53 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4C33655C16F;
 Tue, 03 Jun 2025 14:58:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 1HGAlJL95Inf; Tue,  3 Jun 2025 14:58:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 613E655BC02; Tue, 03 Jun 2025 14:58:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5EEDA745682;
 Tue, 03 Jun 2025 14:58:37 +0200 (CEST)
Date: Tue, 3 Jun 2025 14:58:37 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Subject: Re: [PULL 36/58] pc-bios: Move device tree files in their own subdir
In-Reply-To: <05174912-B148-4ECB-9F8C-4C0641FFC2BB@gmail.com>
Message-ID: <5ac9d7f1-f04a-2566-3373-eee9d8f8770a@eik.bme.hu>
References: <20250425152843.69638-1-philmd@linaro.org>
 <20250425152843.69638-37-philmd@linaro.org>
 <621F23F2-05FC-4C8C-8AA8-F61DED04B306@gmail.com>
 <83dcb220-dd06-fb7f-1960-432fb2696b60@eik.bme.hu>
 <0648af18-2e50-4eaa-96fb-b0e64eb706d9@linaro.org>
 <05174912-B148-4ECB-9F8C-4C0641FFC2BB@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1933132707-1748955517=:48109"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--3866299591-1933132707-1748955517=:48109
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 3 Jun 2025, Bernhard Beschow wrote:
> Am 2. Juni 2025 08:12:39 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> On 30/5/25 02:54, BALATON Zoltan wrote:
>>> On Thu, 29 May 2025, Bernhard Beschow wrote:
>>>> Am 25. April 2025 15:28:20 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>>>>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>
>>>>> We have several device tree files already and may have more in the
>>>>> future so add a new dtb subdirectory and move device tree files there
>>>>> so they are not mixed with ROM binaries.
>>>>>
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> Message-ID: <57f179bd3904c1f2ca062ca4d4ff9592bb4f4daa.1745402140.git.balaton@eik.bme.hu>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>> MAINTAINERS                                |   2 +-
>>>>> system/datadir.c                           |   4 +++-
>>>>> pc-bios/{ => dtb}/bamboo.dtb               | Bin
>>>>> pc-bios/{ => dtb}/bamboo.dts               |   0
>>>>> pc-bios/{ => dtb}/canyonlands.dtb          | Bin
>>>>> pc-bios/{ => dtb}/canyonlands.dts          |   0
>>>>> pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
>>>>> pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
>>>>> pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
>>>>> pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
>>>>> pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
>>>>> pc-bios/meson.build                        |  23 +--------------------
>>>>> qemu.nsi                                   |   2 +-
>>>>> 13 files changed, 29 insertions(+), 25 deletions(-)
>>>>> rename pc-bios/{ => dtb}/bamboo.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/bamboo.dts (100%)
>>>>> rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/canyonlands.dts (100%)
>>>>> create mode 100644 pc-bios/dtb/meson.build
>>>>> rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
>>>>> rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 661a47db5ac..d82d962f1a4 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -1581,7 +1581,7 @@ F: hw/pci-host/ppc440_pcix.c
>>>>> F: hw/display/sm501*
>>>>> F: hw/ide/sii3112.c
>>>>> F: hw/rtc/m41t80.c
>>>>> -F: pc-bios/canyonlands.dt[sb]
>>>>> +F: pc-bios/dtb/canyonlands.dt[sb]
>>>>> F: pc-bios/u-boot-sam460ex-20100605.bin
>>>>> F: roms/u-boot-sam460ex
>>>>> F: docs/system/ppc/amigang.rst
>>>>> diff --git a/system/datadir.c b/system/datadir.c
>>>>> index e450b84ce91..f96f8fc2646 100644
>>>>> --- a/system/datadir.c
>>>>> +++ b/system/datadir.c
>>>>> @@ -44,9 +44,11 @@ char *qemu_find_file(QemuFileType type, const char *name)
>>>>>
>>>>>     switch (type) {
>>>>>     case QEMU_FILE_TYPE_BIOS:
>>>>> -    case QEMU_FILE_TYPE_DTB:
>>>>>         subdir = "";
>>>>>         break;
>>>>> +    case QEMU_FILE_TYPE_DTB:
>>>>> +        subdir = "dtb/";
>>>>> +        break;
>>>>>     case QEMU_FILE_TYPE_KEYMAP:
>>>>>         subdir = "keymaps/";
>>>>>         break;
>>>>> diff --git a/pc-bios/bamboo.dtb b/pc-bios/dtb/bamboo.dtb
>>>>> similarity index 100%
>>>>> rename from pc-bios/bamboo.dtb
>>>>> rename to pc-bios/dtb/bamboo.dtb
>>>>> diff --git a/pc-bios/bamboo.dts b/pc-bios/dtb/bamboo.dts
>>>>> similarity index 100%
>>>>> rename from pc-bios/bamboo.dts
>>>>> rename to pc-bios/dtb/bamboo.dts
>>>>> diff --git a/pc-bios/canyonlands.dtb b/pc-bios/dtb/canyonlands.dtb
>>>>> similarity index 100%
>>>>> rename from pc-bios/canyonlands.dtb
>>>>> rename to pc-bios/dtb/canyonlands.dtb
>>>>> diff --git a/pc-bios/canyonlands.dts b/pc-bios/dtb/canyonlands.dts
>>>>> similarity index 100%
>>>>> rename from pc-bios/canyonlands.dts
>>>>> rename to pc-bios/dtb/canyonlands.dts
>>>>> diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
>>>>> new file mode 100644
>>>>> index 00000000000..7a71835bca7
>>>>> --- /dev/null
>>>>> +++ b/pc-bios/dtb/meson.build
>>>>> @@ -0,0 +1,23 @@
>>>>> +dtbs = [
>>>>> +  'bamboo.dtb',
>>>>> +  'canyonlands.dtb',
>>>>> +  'petalogix-ml605.dtb',
>>>>> +  'petalogix-s3adsp1800.dtb',
>>>>
>>>> Was it intended that the suffix changed from .dts to .dtb? This change isn't motivated in the commit message and usually source files rather than generated artifacts are listed in build files.
>>>
>>> I think I either found similar python code somewhere and followed that because meson and python is not something I understand well. Or changed it because we always need the list of dtbs to install but only need the dts when compiling so this way we don't need another list or replacing suffix twice.
>>
>> Should we revert?
>
> What's the idea behind having dtbs in the repository instead of making 
> dtc mandatory? If there is any perspective that we could remove the dtbs 
> in the future I vote for restoring the original logic. I could send a 
> patch since I have further dtb fixes for the e500 and arm.

This patch did not change that, dtbs were already there so this is a 
proposed unrelated further change. Reverting the patch leaves you with dtb 
and dts files mixed with rom binaries. This patch only aimed to separate 
device tree files from rom binaries. So you're nitpicking if the array in 
the makefile should list dts or dtb files while both of them are there so 
I don't think it matters much which are listed. Dtbs are used when dtc is 
not found and only installing pre-built files while list of dts is only 
needed when building from dts and it is easy to replace the extension so 
if you want we can change it to list dts at the expense of adding one 
extra line to make the dtb array without dtc. I saved that one line by 
listing dtbs.

Now you propose another change to drop dtbs and always build from dts. I'm 
not against that but that's not related to this patch. I think dtbs were 
included for convenience so we don't need dtc.

Regards,
BALATON Zoltan
--3866299591-1933132707-1748955517=:48109--

