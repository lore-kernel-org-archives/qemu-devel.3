Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE61C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raxov-0003Tk-LH; Fri, 16 Feb 2024 08:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1raxot-0003Sx-0X; Fri, 16 Feb 2024 07:59:59 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1raxop-0007QO-UZ; Fri, 16 Feb 2024 07:59:58 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 86F404E602F;
 Fri, 16 Feb 2024 13:59:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id fq1IyR_PI0y4; Fri, 16 Feb 2024 13:59:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4CE974E602D; Fri, 16 Feb 2024 13:59:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A7287456FE;
 Fri, 16 Feb 2024 13:59:50 +0100 (CET)
Date: Fri, 16 Feb 2024 13:59:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Bernhard Beschow <shentey@gmail.com>, clg@kaod.org
Subject: Re: [PATCH] docs/system/ppc: Document running Linux on AmigaNG
 machines
In-Reply-To: <09ec9481-3f80-4625-8a2a-7db3a6947344@redhat.com>
Message-ID: <1938a5dd-08c9-70e6-bba8-8a5dd0c87318@eik.bme.hu>
References: <20240216001019.69A524E601F@zero.eik.bme.hu>
 <09ec9481-3f80-4625-8a2a-7db3a6947344@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1361030856-1708088390=:76485"
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

--3866299591-1361030856-1708088390=:76485
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 16 Feb 2024, Thomas Huth wrote:
> On 16/02/2024 01.10, BALATON Zoltan wrote:
>> Documentation on how to run Linux on the amigaone, pegasos2 and
>> sam460ex machines is currently burried in the depths of the qemu-devel
>
> s/burried/buried/
>
>> mailing list and in the source code. Let's collect the information in
>> the QEMU handbook for a one stop solution.
>> 
>> Co-authored-by: Bernhard Beschow <shentey@gmail.com>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> Supersedes: <20231216123013.67978-1-shentey@gmail.com>
>>
>>   MAINTAINERS                 |   1 +
>>   docs/system/ppc/amigang.rst | 160 ++++++++++++++++++++++++++++++++++++
>>   docs/system/target-ppc.rst  |   1 +
>>   3 files changed, 162 insertions(+)
>>   create mode 100644 docs/system/ppc/amigang.rst
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a24c2b51b6..8e5b47e7b4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1560,6 +1560,7 @@ F: hw/rtc/m41t80.c
>>   F: pc-bios/canyonlands.dt[sb]
>>   F: pc-bios/u-boot-sam460ex-20100605.bin
>>   F: roms/u-boot-sam460ex
>> +F: docs/system/ppc/amigang.rst
>>     pegasos2
>>   M: BALATON Zoltan <balaton@eik.bme.hu>
>> diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rst
>> new file mode 100644
>> index 0000000000..c03a7e0d66
>> --- /dev/null
>> +++ b/docs/system/ppc/amigang.rst
>> @@ -0,0 +1,160 @@
>> +AmigaNG boards (``amigaone``, ``pegasos2``, ``sam460ex``)
>> +=========================================================
>> +
>> +These PowerPC machines emulate boards that are primarily used for
>> +running Amiga like OSes (AmigaOS 4, MorphOS and AROS) but these can
>> +also run Linux which is what this section documents.
>> +
>> +Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
>> +===============================================
>
> Wouldn't it be better to use a subsection here (i.e. "----" instead of 
> "====") ? And also adjust the subsections below to subsubsections?

This used to be the top but I've added another paragraph and forgot to 
change the headings. I'll check how other docs are organised and send 
another version after waiting for some time to see if anobody else spots 
some typos.

Thanks,
BALATON Zoltan

>> +
>> +The ``amigaone`` machine emulates an AmigaOne XE mainboard by Eyetech
>> +which is a rebranded Mai Logic Teron board with modified U-Boot
>> +firmware to support AmigaOS 4.
>> +
>> +Emulated devices
>> +----------------
>> +
>> + * PowerPC 7457 CPU (can also use``-cpu g3, 750cxe, 750fx`` or ``750gx``)
>> + * Articia S north bridge
>> + * VIA VT82C686B south bridge
>> + * PCI VGA compatible card (guests may need other card instead)
>> + * PS/2 keyboard and mouse
>> +
>> +Firmware
>> +--------
>> +
>> +A firmware binary is necessary for the boot process. It is a modified
>> +U-Boot under GPL but its source is lost so it cannot be included in
>> +QEMU. A binary is available at
>> +https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28.
>> +The ROM image is in the last 512kB which can be extracted with the
>> +following command:
>> +
>> +.. code-block:: bash
>> +
>> +  $ tail -c 524288 updater.image > u-boot-amigaone.bin
>> +
>> +The BIOS emulator in the firmware is unable to run QEMU‘s standard
>> +vgabios so ``VGABIOS-lgpl-latest.bin`` is needed instead which can be
>> +downloaded from http://www.nongnu.org/vgabios.
>> +
>> +Running Linux
>> +-------------
>> +
>> +There are some Linux images under the following link that work on the
>> +``amigaone`` machine:
>> +https://sourceforge.net/projects/amigaone-linux/files/debian-installer/.
>> +To boot the system run:
>> +
>> +.. code-block:: bash
>> +
>> +  $ qemu-system-ppc -machine amigaone -bios u-boot-amigaone.bin \
>> +                    -cdrom "A1 Linux Net Installer.iso" \
>> +                    -device 
>> ati-vga,model=rv100,romfile=VGABIOS-lgpl-latest.bin
>> +
>> +From the firmware menu that appears select ``Boot sequence`` →
>> +``Amiga Multiboot Options`` and set ``Boot device 1`` to
>> +``Onboard VIA IDE CDROM``. Then hit escape until the main screen appears 
>> again,
>> +hit escape once more and from the exit menu that appears select either
>> +``Save settings and exit`` or ``Use settings for this session only``. It 
>> may
>> +take a long time loading the kernel into memory but eventually it boots 
>> and the
>> +installer becomes visible. The ``ati-vga`` RV100 emulation is not
>> +complete yet so only frame buffer works, DRM and 3D is not available.
> ...
>
> Thomas
>
>
>
--3866299591-1361030856-1708088390=:76485--

