Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34381C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 19:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVzBm-0001x8-MC; Fri, 02 Feb 2024 14:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rVzBk-0001wk-Gy
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:27:00 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rVzBi-0007v8-Fh
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706902002; x=1707506802; i=deller@gmx.de;
 bh=OWKRE1mLFUbaBkUkTGKObYiFI6ZugZ05HLJ+mSdrhLo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=W3smc5ANojoqk7BHKy0zAfHYY1uqymY2cJGd7E58v7BKXz921d44pFlxbTELci0J
 vMmrb//QRS+ef8GxHdT46FhUDK2TRpFwqBVZ/W/iDDumguWAbo58UTlDztzv1bmOw
 tzHYXja5t8h1YNsOEDx7NLF6XZc4vd0sNixvizUrtSDSJ8ed8H+RWrR+kUtTZ5537
 N22oihzdA7j/M1cHPNj4UqSO8Vss2RIky1pz7CuB16pS/Lo6O41m5bmGbnWxVhq75
 tMfyLgKx/YRT6zgPEuvB4KcXbCNqs9LAVx2OuZGYMDLLzdmr53eIxUn+JbqOG5n3K
 UhyMTHUFLx0A7f3rUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.153.18]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1rIq1K0otM-00DEBv; Fri, 02
 Feb 2024 20:26:42 +0100
Message-ID: <c075b35e-5dcf-4a59-bb09-7f8912dd44cd@gmx.de>
Date: Fri, 2 Feb 2024 20:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/10] hw/hppa/machine: Disable default devices with
 --nodefaults option
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
Cc: deller@kernel.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240113055729.4480-1-deller@kernel.org>
 <20240113055729.4480-3-deller@kernel.org>
 <b907f081-5848-4441-a285-f5fca47ace14@roeck-us.net>
 <a9b2c811-f623-4cf3-ab22-99f98d2d1c55@gmx.de>
 <2384ab73-1907-4f63-bc98-dac5d8b3b48b@roeck-us.net>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <2384ab73-1907-4f63-bc98-dac5d8b3b48b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:klllt2WJ237IeT9D/pjtMDZswX2Bt1h8BmQHOMi+iX6zIOycYDJ
 lfR4OwDXFsgOapTAsUbuA3WACbSrde3yI7+Jhtv/WtH7ObqGClS9wu0mAJXipEApHUC+ywi
 SO+stS2qkxt9qwoXkfQe2HzKVdCn2Ki1AAh9US7awsw6/Fz6fi06mqJhuv5I2bHOxMg4cHv
 fIFNHadSwIqx6p7gc67ZA==
UI-OutboundReport: notjunk:1;M01:P0:oMaoveCLxlM=;TDlE6YT11XzP50MzDAjiXfzxMwH
 UVwz9mlwFBo9PB5jQfOBgjK6gllRfpE8WxWeL+D2DhnockJc4Z1nGeOj+dlRgzuRxJvgZH+2S
 cydV1uv5R1iPqxr50zEluCfEIrbDlUhNfScMIMpn2XgXN3RAGXi8oruln4wH7JjgEWu9xfYYd
 npsyREboDOZH7/vIPyMvLjWW0sV64GsTxN0hbHBUaw/i1NllZE+kABoLB7XELvrNP2tmNjE1+
 11krwI60MBC8zFCs2iQ8iWoH+d3uvE686LKtpGPXRHlmxwxNCahm+prXEQ9jHFktait1ZxXs9
 tw0IpR03OOpwFbDH3IL321nKb0wYMDCWEBzJewDTZUIrG7DEcXlNbtqJKGS6qMftHK18lGPD9
 U3DF9RohNUFdLaqU7gjoJUripxjHQIIeqFBd/dJuMRHD8wcXcPXTmCWAiVYQqGxvYwxtBoder
 UGb2VfF/U20hAwTb0hUEiWVhPO7losLpIZlviNsmuKdNSyV0Gq8r5Gs5SUKFjR4r7uyvM99VB
 WgxZG1OG8SUEMSpDGVctoF4XjkdrtKB7iNmb9JJFOwJo+KopUyxvdvywXL81/lyAWc6uB5ag2
 5umB18rOAAm6BNV8B1ChtlOsPFTxRXfJTaKnAg9oab3UHwXFbG6bYaMZ+o6TBKhGIgPElrY/B
 gsEAisP8otNstk4vWyYfeNl8aq8TNBPkht+IdTjO+5Yue5G8U+17FKHhcNM6RDXR46SF8vRkP
 ViLHQ0bpDOWiFH/O1aS05TVCtbPaFEXPv75TpP+ZCHjHohJy8php4LzxMDDkWWCFD3bNH041v
 mzJMTFqwFCTk0vrz6QumNaNKE2PD6pta/IoJsWRn3AF3Y=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/2/24 19:04, Guenter Roeck wrote:
> On Fri, Feb 02, 2024 at 10:54:20AM +0100, Helge Deller wrote:
>> Hi Guenter,
>>
>> On 2/2/24 05:22, Guenter Roeck wrote:
>>> On Sat, Jan 13, 2024 at 06:57:20AM +0100, deller@kernel.org wrote:
>>>> From: Helge Deller <deller@gmx.de>
>>>>
>>>> Recognize the qemu --nodefaults option, which will disable the
>>>> following default devices on hppa:
>>>> - lsi53c895a SCSI controller,
>>>> - artist graphics card,
>>>> - LASI 82596 NIC,
>>>> - tulip PCI NIC,
>>>> - second serial PCI card,
>>>> - USB OHCI controller.
>>>>
>>>> Adding this option is very useful to allow manual testing and
>>>> debugging of the other possible devices on the command line.
>>>>
>>>
>>> With this patch in the tree, I get some interesting crashes in Seabios
>>> if I provide a somewhat unusual command line option. For example,
>>> something like
>>>
>>>       -usb -device usb-ehci,id=3Dehci \
>>>       -device usb-uas,bus=3Dehci.0,id=3Duas \
>>>       -device scsi-hd,bus=3Duas.0,scsi-id=3D0,lun=3D0,drive=3Dd0 \
>>>       -drive file=3D ...
>>>
>>> is accepted as command line option but results in
>>>
>>> SeaBIOS PA-RISC 32-bit Firmware Version 15 (QEMU 8.2.1)
>>> Duplex Console IO Dependent Code (IODC) revision 1
>>> ----------------------------------------------------------------------=
--------
>>>     (c) Copyright 2017-2024 Helge Deller <deller@gmx.de> and SeaBIOS d=
evelopers.
>>> ----------------------------------------------------------------------=
--------
>>>     Processor   Speed            State           Coprocessor State  Ca=
che Size
>>>     ---------  --------   ---------------------  -----------------  --=
--------
>>>         0      250 MHz    Active                 Functional           =
 0 KB
>>>         1      250 MHz    Idle                   Functional           =
 0 KB
>>>         2      250 MHz    Idle                   Functional           =
 0 KB
>>>         3      250 MHz    Idle                   Functional           =
 0 KB
>>>     Emulated machine:     HP C3700 (64-bit PA2.0) with 32-bit PDC
>>>     Available memory:     1024 MB
>>>     Good memory required: 16 MB
>>>     Primary boot path:    FWSCSI.0.0
>>>     Alternate boot path:  FWSCSI.0.0
>>>     Console path:         SERIAL_2.9600.8.none
>>>     Keyboard path:        SERIAL_2.9600.8.none
>>> *ERROR* in SeaBIOS-hppa-v15:
>>> prepare_boot_path:2898
>>> SeaBIOS wants SYSTEM HALT.
>>>
>>> This is without --nodefaults, and it used to work. Is that intentional=
 ?
>>
>> This should now be fixed in the upcoming SeaBIOS-hppa-v16 version ("dev=
el" branch):
>> https://github.com/hdeller/seabios-hppa/tree/devel
>> Could you test?
>
> I was able to build from the 'master' branch, but 'devel' gives me
>
> hppa64-linux-ld: target elf32-hppa-linux not found

The devel branch now includes a 64-bit firmware too.
You need both, hppa (32-bit) and hppa64 (64-bit) gcc
and binutils packages installed.

> Do you have a binary seabios image, by any chance ?

http://www.dellerweb.de/temp/hppa-firmware.img

>> If it doesn't work, please give me the full command line.
>>
>
> qemu-system-hppa -M C3700 -smp 4 \
> 	-kernel vmlinux -no-reboot -snapshot \
> 	-usb -device usb-ehci,id=3Dehci \
> 	-device usb-uas,bus=3Dehci.0,id=3Duas \
> 	-device scsi-hd,bus=3Duas.0,scsi-id=3D0,lun=3D0,drive=3Dd0 \
> 	-drive file=3Drootfs.ext2,if=3Dnone,format=3Draw,id=3Dd0 \
> 	-append "root=3D/dev/sda rootwait console=3DttyS0,115200" \
> 	-nographic -monitor null

That line boots for me now.

> This is with qemu 8.2.1. Note that the number of CPUs doesn't make a
> difference. It turns out this also crashes/aborts immediately with
> "nodefaults".

Adding "--nodefaults -serial mon:stdio" to the line above works too.

>>> If I do use the --nodefaults parameter, I was unable to figure out how
>>> to configure the serial console. What command line parameter(s) do I n=
eed to
>>> get it ?
>>
>> You need to add:
>> -serial mon:stdio
>> This will create a serial port if it's not yet there.
>>
>
> And there was me trying all variants of "-device pci-serial-4x..." I cou=
ld
> think of ;-).

:-)

Helge


