Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81651CD37B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 06:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMJu2-0001X6-8G; Mon, 11 May 2026 02:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMJu0-0001VM-2M
 for qemu-devel@nongnu.org; Mon, 11 May 2026 02:14:04 -0400
Received: from smtpout2.mo533.mail-out.ovh.net ([51.210.94.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wMJtw-0000iL-P4
 for qemu-devel@nongnu.org; Mon, 11 May 2026 02:14:03 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gDTtd55Zfz5yM8;
 Mon, 11 May 2026 06:13:29 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 11 May 2026 06:13:29 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.179])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gDTtd01tyz7thp; Mon, 11 May 2026 06:13:29 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id D02C71B4363F;
 Mon, 11 May 2026 06:13:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S0064a14c32e-95b7-4b84-bb08-71f84f95a4ac,
 AF0BFEC086191C1369F7EC03D32B7A83D87952B1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5fe87f4d-9c44-44b3-a684-511d243f0f75@kaod.org>
Date: Mon, 11 May 2026 08:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/11] hw/usb/ehci: Add 64-bit descriptor addressing
 support
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Zhao Liu <zhao1.liu@intel.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
 <0abcf804-f16f-43b6-a345-e14642e54718@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <0abcf804-f16f-43b6-a345-e14642e54718@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8325185389208185901
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGRG7swY4LYRBwZZRP+Z0Whfs06LYHVZBcyDkGbfbXwwT3Is9HYZKOs6Qmr4jPnYPT+iZFQFVPeCENA83BFWuQGRzsfxPh96cszycSe7EhRrkwrmUJPwCIVbOZ7aEheoaztHLyPhRYK0t5mr7D065mux3f/gBy4k7AFFFuASQR+i5E5/AEAD6XjiEVUeBlE7fQe1Cn/M46rAY16qeTMnzh9TCZNYl2SE8dZCUrD/fMFYp+O3+ogz9XE+97w1ngKqYB3iCtf0g09oveHou62NHvEY0XGNL0V34T1avrmSOuS8QnfYqcGuf78/Hj/FblD0qafFz4zTwi1NGLF30gNIQxVHeQQQ82gP72KeGotKdTeGtL/GtmXDMTBwhY52JnPSqm7jmIOohcb0eYTReJnRfXCXpGHU8LbwrUnCuqcs7GLqbMOTjnBURUvzVHvuh0F/6Zd2+Q6lY/Vu7fgSykp/+c961zpMI4N+Yt7qIhMayph+OD+kkkiTJ8HW7QSYcBp1uzngcFnWCR9lOdpTcaYRRMHkR8HZO6FNi98fOURKwA70KioF1IISK7sQrsrlGLJXbpJUK+vs4MgLXNX1PDwbbolhLAhLJrw+/Ohnn7Dn8vim/JGOkYecFYzxGER8nwCf6vQACbqL0mV+K5vsOav4ImTaXNrgXaV97FvHcVhcXte5Q
DKIM-Signature: a=rsa-sha256; bh=1+ykgI+ks6hof+ji0bJlerrlZhMA0AhAhWAp3ebb1LI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778480011; v=1;
 b=bVmEyT8wtL1N1OsWFhuLX6vcnrR+PXga0Fi88XxVRF/cJaHQD0t5LX1Bak1ytFPcuPMXKx/f
 rPEkPfH+9ClZwJz4T0oLRvfTblDUgd/F0BWBsoasxwsdKHOM1X0Zp1wLpy//OuI0KsUM1LLKBTM
 YacP0LKRVAQ2WqDwLF85kC7nZ2KGG+NG6JYyE3ROgzc4LdpYjQchuQhyXN9Jx8gAPhmmqtWfxrC
 wqRThL24/RZRuivqeykzDumqU+QUxedM/EHLXJ9+pstQ8pJZTyxcEdPxuVaeg9qhekennWUhTZp
 +2z3jeWOlaYO2Y9SuUlLMdVK2bcIiqiyRWTtG8ju4cTkA==
Received-SPF: pass client-ip=51.210.94.139; envelope-from=clg@kaod.org;
 helo=smtpout2.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/4/26 07:27, Cédric Le Goater wrote:
> On 5/4/26 04:53, Jamin Lin wrote:
>> EHCI supports 64-bit addressing through the CTRLDSSEGMENT register,
>> which provides the upper 32 bits of descriptor addresses when the
>> controller advertises 64-bit capability.
>>
>> Currently QEMU EHCI model only partially supports this functionality and
>> descriptor addresses are effectively treated as 32-bit. This becomes
>> problematic on systems where system memory is located above the 4GB
>> boundary.
>>
>> The Linux EHCI driver enables 64-bit addressing if the controller
>> advertises the capability. During initialization it programs the
>> segment register to zero:
>>
>>    https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c#L600
>>
>> The driver also notes that descriptor structures allocated from the
>> DMA pool use segment zero semantics. Descriptor memory is allocated
>> using the DMA API and platforms may configure a 64-bit DMA mask,
>> allowing descriptor memory to be placed above 4GB.
>>
>> On AST2700 platforms, system DRAM is mapped at 0x400000000. As a
>> result, descriptor addresses constructed directly from the EHCI
>> registers do not match the actual system addresses used by the
>> controller when accessing queue heads (QH) and queue element transfer
>> descriptors (qTD).
>>
>> This patch series implements full 64-bit descriptor addressing support
>> in the EHCI emulation. Descriptor address handling is updated to use
>> 64-bit values and the descriptor structures (QH, qTD, iTD and siTD)
>> are extended to support the upper address bits provided by the segment
>> register.
>>
>> Add a ctrldssegment-default property so platforms can provide a
>> descriptor address offset when constructing descriptor addresses.
>> This allows systems where DRAM resides above 4GB to access EHCI
>> descriptors correctly.
>>
>> The AST2700 machine uses this property to account for its DRAM mapping
>> at 0x400000000 and enables 64-bit EHCI DMA addressing.
>>
>> Test Result:
>> 1. EHCI 32bits with ast2600-evb machine
>> Command line:
>> ./build/qemu-system-arm \
>>    -machine ast2600-evb \
>>    -m 1G \
>>    -drive file=image-bmc,if=mtd,format=raw \
>>    -nographic \
>>    -device usb-kbd,bus=usb-bus.1,id=mykbd \
>>    -drive id=usbdisk,if=none,file=image0.ext4,format=raw \
>>    -device usb-storage,bus=usb-bus.1,id=mystorage,drive=usbdisk
>>    -snapshot \
>>    -nographic
>> Result:
>> unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.3-v00.08.01-g172b7e27a30d ehci_hcd EHCI Host Controller
>> Bus 001 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard
>> Bus 001 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
>> Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.3-v00.08.01-g172b7e27a30d uhci_hcd Generic UHCI Host Controller
>>
>> 2. EHCI 64bits with ast2700a2-evb machine
>> Command line:
>> ./build/qemu-system-aarch64 -M ast2700a2-evb -nographic\
>>   -bios ast27x0_bootrom.bin \
>>   -drive file=image-bmc,format=raw,if=mtd \
>>   -snapshot \
>>   -device usb-kbd,bus=usb-bus.3,id=mykbd \
>>   -drive id=usbdisk,if=none,file=image0.ext4,format=raw \
>>   -device usb-storage,bus=usb-bus.3,id=mystorage,drive=usbdisk
>> Result:
>> root@ast2700-default:~# lsusb
>> unable to initialize usb specBus 001 Device 001: ID 1d6b:0001 Linux 6.18.3-v00.08.01-g172b7e27a30d uhci_hcd Generic UHCI Host Controller
>> Bus 002 Device 001: ID 1d6b:0002 Linux 6.18.3-v00.08.01-g172b7e27a30d ehci_hcd EHCI Host Controller
>> Bus 002 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard
>> Bus 002 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
>> v1
>>   1. Fix checkpatch coding style issues
>>   2. Implement 64-bit addressing for QH/qTD/iTD/siTD descriptors
>>   3. Add descriptor address offset property
>>   4. Enable 64-bit EHCI DMA addressing on AST2700
>>   5. Configure descriptor address offset for AST2700
>>
>> v2
>>   1. Remove unused EHCIfstn structure and dead code
>>   2. Replace fprintf(stderr, ...) with qemu_log_mask(LOG_GUEST_ERROR)
>>   3. Replace DPRINTF debug logs with trace events
>>   4. Add functional tests for USB EHCI on AST2600 and AST2700 A1/A2
>>   5. Fix review issue
>>
>> v3:
>>   1. Add Migration version test function
>>   2. Add EHCI 64-bit buffer pointer fields description in commit log
>>
>> v4:
>>   1. Reorder patches in the series
>>   2. Fix EHCI migration issues
>>   3. Introduce a common properties macro for both sysbus and PCI
>>   4. Drop the descriptor address offset property
>>   5. Add ctrldssegment-default property
>>   6. Address review comments
>>
>> v5:
>>   1. Add 11.0 machine compatibility properties
>>
>> v6:
>>   1. Update reviewer suggested improvements.
>> Jamin Lin (11):
>>    tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for
>>      AST2600 SDK
>>    hw/usb/hcd-ehci: Change descriptor addresses to 64-bit with migration
>>      compatibility
>>    hw/usb/hcd-ehci: Add property to advertise 64-bit addressing
>>      capability
>>    hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing
>>    hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing
>>    hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing
>>    hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing
>>    hw/usb/hcd-ehci: Add ctrldssegment-default property
>>    hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default
>>    hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing
>>    tests/functional/aarch64/test_aspeed_ast2700: Add USB EHCI test for
>>      AST2700 A1/A2
>>
>>   hw/usb/hcd-ehci.h                             |  29 +++-
>>   hw/arm/aspeed_ast27x0.c                       |   5 +
>>   hw/core/machine.c                             |   5 +-
>>   hw/usb/hcd-ehci.c                             | 162 +++++++++++++-----
>>   hw/usb/trace-events                           |  26 +--
>>   .../aarch64/test_aspeed_ast2700a1.py          |   7 +
>>   .../aarch64/test_aspeed_ast2700a2.py          |   7 +
>>   .../functional/arm/test_aspeed_ast2600_sdk.py |   7 +
>>   8 files changed, 185 insertions(+), 63 deletions(-)
>>
> 
> Applied to
> 
>      https://github.com/legoater/qemu aspeed-next

Jamin,

I dropped the series from aspeed-next and kept :

   tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for AST2600 SDK

The USB subsystem is orphan but it is still used in the virt world.
This series is modifying the EHCI internals in such way that migration
is impacted and the CTRLDSSEGMENT (Control Data Structure Segment
Register) implementation is incomplete AFAICT. From EHCI specs :

    This register allows the host software to locate all control data
    structures within the *same 4 Gigabyte memory segment*.

Linux driver seems buggy too.

Overall, the risk of regression is too high given the time I can dedicate
to this topic.

Thanks for all the good work you done there, specially for migration.
If someone can Ack the series and step forward to become USB maintainer,
then I will reconsider.


C.


