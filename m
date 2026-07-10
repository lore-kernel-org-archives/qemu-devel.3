Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2617EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 05:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi40U-0001Zu-E1; Fri, 10 Jul 2026 01:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wi40R-0001YM-3b
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:42:35 -0400
Received: from smtpout7.mo540.mail-out.ovh.net ([51.210.91.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wi40N-0007Yh-JF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:42:34 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4gxLM3525Zz4QRR;
 Fri, 10 Jul 2026 05:42:23 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Fri, 10 Jul 2026 05:42:23 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.1])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gxLM26y1kz1xyb;
 Fri, 10 Jul 2026 05:42:22 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 5850D941981; 
 Fri, 10 Jul 2026 05:42:20 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004937c1f3b-ac8a-4937-a4a0-2fd6b698d2e8,
 1D89B3DEAFBB614AFFC0CDAF1342A6FFA73ECDCC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <9b1c4621-0e6c-4ab9-8811-1723cf922efc@kaod.org>
Date: Fri, 10 Jul 2026 07:42:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/11] hw/usb/ehci: Add 64-bit descriptor addressing
 support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "peterx@redhat.com" <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Zhao Liu <zhao1.liu@intel.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, =?UTF-8?Q?=27Marc-Andr=C3=A9_Lureau=27?=
 <marcandre.lureau@redhat.com>, 'Gerd Hoffmann' <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
 <0abcf804-f16f-43b6-a345-e14642e54718@kaod.org>
 <5fe87f4d-9c44-44b3-a684-511d243f0f75@kaod.org>
 <1c2ed0f4-35d1-4dd3-87df-5f8b9aeb800c@kaod.org>
 <f2103a7a-531f-4a88-8ecb-0dd58672c62c@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <f2103a7a-531f-4a88-8ecb-0dd58672c62c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9673450528162622509
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEBoVqKInUiEXBiMXXtJDWlJN3uufozuRBaJdMawgxoyV2SP5rZNwjurhQBZWB9xQbNJ/A1+gvrMebHAENqgE+yHvK3xcc2T3MEjHWzayHsEEJRlx4VRjxWT8FhRyazYROxjsReVfJNV6Qq6Ee5b36jX+LbcK8YeXl0lRjBBMSP4EFSIiYU+M3+VX40r9/C3MK+5in68g+fG+RmN/xw5nK9dgcKXXMhIZWTYiiA6QIReyP5X2KBMNpSlUgXPw/kFzGIQ0ObNjB/Pu9PM34v+pQqXtpdINOlnphKgMC1Oi+hlew79G5QLp4/dGMyBjebopvy0GTJd+QdNgfl3EcWaC2jEeErHpyG583Ov/YLm4ykcagR5DFSeiGgjmM6FIBRuWEmMeMcoqiaEyJRqc+1675HQ5I7N/FcSooIxEkFFsJTxmy2baaMR6ekJxI6bEV029FW3ow92kXVWdidu7P6/sSh55jagFrb2PFwfc6l2gvR1m0EaerrTAKUZAW2MKqKj2waIp2SpsoV7K7s/ytwedUzWb1e/H8IS0S3rfkxuF6AHv0/RAlVxUcl5fSnFAzkbNnZV8QXs/X2AkCpc0ORlCyvoFmSfY2GX9EtkUfgsN3nKJtZJHx7b9n+3yMKkixPtixtkd3R9zK+ZMCA4U65dn5ODNH9a2YTz+4Mn3v/QyQJJQ
DKIM-Signature: a=rsa-sha256; bh=fWoFKBq4Fb80YNZoRVuOCu6bdPWhjEgLJi6Ck13xRok=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1783662145; v=1;
 b=gOmiFbg0or5ymyw1QOjJ0+EFtDleuSf9kjamPeRt05jO9gpl4uwYr6dlSiKDSWpyX2Cfdgun
 8yPjkAVhkC6dc9OTv7lkjH/Wl0WonDSOKHB0ulWdGyaXTr4w9puQRIJ82PXxoxrvEQAAwmd+lse
 AfEMWd/xU0yOwJ5gd1jRm6a05QHWVLaxMCz412SEtZ+9cGOtCFUb6nPq3+JbIF/J0p/TQCXoP7C
 tctga2WPd7Y+wyGvoTUoBMsrNYrqdvicvE3APwUo6Wx2j+HvhaSirgGFPEkBK7mPcMFRZMCvcbN
 +bRo8t9BL895HMQeBYRDN7SmnqsB2t6DLi7/0wxxViNtw==
Received-SPF: pass client-ip=51.210.91.56; envelope-from=clg@kaod.org;
 helo=smtpout7.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/9/26 23:09, Philippe Mathieu-Daudé wrote:
> On 12/5/26 16:47, CÃ©dric Le Goater wrote:
>> + Gerd, Marc-André,
>>
>> May be they can provide some more feedback.
>>
>> On 5/11/26 08:13, Cédric Le Goater wrote:
>>> On 5/4/26 07:27, Cédric Le Goater wrote:
>>>> On 5/4/26 04:53, Jamin Lin wrote:
>>>>> EHCI supports 64-bit addressing through the CTRLDSSEGMENT register,
>>>>> which provides the upper 32 bits of descriptor addresses when the
>>>>> controller advertises 64-bit capability.
>>>>>
>>>>> Currently QEMU EHCI model only partially supports this functionality and
>>>>> descriptor addresses are effectively treated as 32-bit. This becomes
>>>>> problematic on systems where system memory is located above the 4GB
>>>>> boundary.
>>>>>
>>>>> The Linux EHCI driver enables 64-bit addressing if the controller
>>>>> advertises the capability. During initialization it programs the
>>>>> segment register to zero:
>>>>>
>>>>>    https://github.com/torvalds/linux/blob/master/drivers/usb/host/ ehci-hcd.c#L600
>>>>>
>>>>> The driver also notes that descriptor structures allocated from the
>>>>> DMA pool use segment zero semantics. Descriptor memory is allocated
>>>>> using the DMA API and platforms may configure a 64-bit DMA mask,
>>>>> allowing descriptor memory to be placed above 4GB.
>>>>>
>>>>> On AST2700 platforms, system DRAM is mapped at 0x400000000. As a
>>>>> result, descriptor addresses constructed directly from the EHCI
>>>>> registers do not match the actual system addresses used by the
>>>>> controller when accessing queue heads (QH) and queue element transfer
>>>>> descriptors (qTD).
>>>>>
>>>>> This patch series implements full 64-bit descriptor addressing support
>>>>> in the EHCI emulation. Descriptor address handling is updated to use
>>>>> 64-bit values and the descriptor structures (QH, qTD, iTD and siTD)
>>>>> are extended to support the upper address bits provided by the segment
>>>>> register.
>>>>>
>>>>> Add a ctrldssegment-default property so platforms can provide a
>>>>> descriptor address offset when constructing descriptor addresses.
>>>>> This allows systems where DRAM resides above 4GB to access EHCI
>>>>> descriptors correctly.
>>>>>
>>>>> The AST2700 machine uses this property to account for its DRAM mapping
>>>>> at 0x400000000 and enables 64-bit EHCI DMA addressing.
>>>>>
>>>>> Test Result:
>>>>> 1. EHCI 32bits with ast2600-evb machine
>>>>> Command line:
>>>>> ./build/qemu-system-arm \
>>>>>    -machine ast2600-evb \
>>>>>    -m 1G \
>>>>>    -drive file=image-bmc,if=mtd,format=raw \
>>>>>    -nographic \
>>>>>    -device usb-kbd,bus=usb-bus.1,id=mykbd \
>>>>>    -drive id=usbdisk,if=none,file=image0.ext4,format=raw \
>>>>>    -device usb-storage,bus=usb-bus.1,id=mystorage,drive=usbdisk
>>>>>    -snapshot \
>>>>>    -nographic
>>>>> Result:
>>>>> unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.3-v00.08.01-g172b7e27a30d ehci_hcd EHCI Host Controller
>>>>> Bus 001 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard
>>>>> Bus 001 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
>>>>> Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.3-v00.08.01- g172b7e27a30d uhci_hcd Generic UHCI Host Controller
>>>>>
>>>>> 2. EHCI 64bits with ast2700a2-evb machine
>>>>> Command line:
>>>>> ./build/qemu-system-aarch64 -M ast2700a2-evb -nographic\
>>>>>   -bios ast27x0_bootrom.bin \
>>>>>   -drive file=image-bmc,format=raw,if=mtd \
>>>>>   -snapshot \
>>>>>   -device usb-kbd,bus=usb-bus.3,id=mykbd \
>>>>>   -drive id=usbdisk,if=none,file=image0.ext4,format=raw \
>>>>>   -device usb-storage,bus=usb-bus.3,id=mystorage,drive=usbdisk
>>>>> Result:
>>>>> root@ast2700-default:~# lsusb
>>>>> unable to initialize usb specBus 001 Device 001: ID 1d6b:0001 Linux 6.18.3-v00.08.01-g172b7e27a30d uhci_hcd Generic UHCI Host Controller
>>>>> Bus 002 Device 001: ID 1d6b:0002 Linux 6.18.3-v00.08.01- g172b7e27a30d ehci_hcd EHCI Host Controller
>>>>> Bus 002 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard
>>>>> Bus 002 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
>>>>> v1
>>>>>   1. Fix checkpatch coding style issues
>>>>>   2. Implement 64-bit addressing for QH/qTD/iTD/siTD descriptors
>>>>>   3. Add descriptor address offset property
>>>>>   4. Enable 64-bit EHCI DMA addressing on AST2700
>>>>>   5. Configure descriptor address offset for AST2700
>>>>>
>>>>> v2
>>>>>   1. Remove unused EHCIfstn structure and dead code
>>>>>   2. Replace fprintf(stderr, ...) with qemu_log_mask(LOG_GUEST_ERROR)
>>>>>   3. Replace DPRINTF debug logs with trace events
>>>>>   4. Add functional tests for USB EHCI on AST2600 and AST2700 A1/A2
>>>>>   5. Fix review issue
>>>>>
>>>>> v3:
>>>>>   1. Add Migration version test function
>>>>>   2. Add EHCI 64-bit buffer pointer fields description in commit log
>>>>>
>>>>> v4:
>>>>>   1. Reorder patches in the series
>>>>>   2. Fix EHCI migration issues
>>>>>   3. Introduce a common properties macro for both sysbus and PCI
>>>>>   4. Drop the descriptor address offset property
>>>>>   5. Add ctrldssegment-default property
>>>>>   6. Address review comments
>>>>>
>>>>> v5:
>>>>>   1. Add 11.0 machine compatibility properties
>>>>>
>>>>> v6:
>>>>>   1. Update reviewer suggested improvements.
>>>>> Jamin Lin (11):
>>>>>    tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for
>>>>>      AST2600 SDK
>>>>>    hw/usb/hcd-ehci: Change descriptor addresses to 64-bit with migration
>>>>>      compatibility
>>>>>    hw/usb/hcd-ehci: Add property to advertise 64-bit addressing
>>>>>      capability
>>>>>    hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing
>>>>>    hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing
>>>>>    hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing
>>>>>    hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing
>>>>>    hw/usb/hcd-ehci: Add ctrldssegment-default property
>>>>>    hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default
>>>>>    hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing
>>>>>    tests/functional/aarch64/test_aspeed_ast2700: Add USB EHCI test for
>>>>>      AST2700 A1/A2
>>>>>
>>>>>   hw/usb/hcd-ehci.h                             |  29 +++-
>>>>>   hw/arm/aspeed_ast27x0.c                       |   5 +
>>>>>   hw/core/machine.c                             |   5 +-
>>>>>   hw/usb/hcd-ehci.c                             | 162 ++++++++++++ +-----
>>>>>   hw/usb/trace-events                           |  26 +--
>>>>>   .../aarch64/test_aspeed_ast2700a1.py          |   7 +
>>>>>   .../aarch64/test_aspeed_ast2700a2.py          |   7 +
>>>>>   .../functional/arm/test_aspeed_ast2600_sdk.py |   7 +
>>>>>   8 files changed, 185 insertions(+), 63 deletions(-)
>>>>>
>>>>
>>>> Applied to
>>>>
>>>>      https://github.com/legoater/qemu aspeed-next
>>>
>>> Jamin,
>>>
>>> I dropped the series from aspeed-next and kept :
>>>
>>>    tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for AST2600 SDK
>>>
>>> The USB subsystem is orphan but it is still used in the virt world.
>>> This series is modifying the EHCI internals in such way that migration
>>> is impacted and the CTRLDSSEGMENT (Control Data Structure Segment
>>> Register) implementation is incomplete AFAICT. From EHCI specs :
>>>
>>>     This register allows the host software to locate all control data
>>>     structures within the *same 4 Gigabyte memory segment*.
>>>
>>> Linux driver seems buggy too.
>>>
>>> Overall, the risk of regression is too high given the time I can dedicate
>>> to this topic.
>>>
>>> Thanks for all the good work you done there, specially for migration.
>>> If someone can Ack the series and step forward to become USB maintainer,
>>> then I will reconsider.
> 
> I'm not an USB expert / maintainer but FWIW this series looked good
> enough to me when I looked at it. Maybe consider to merge after the
> 11.1 release?

Yes. I would like to too but ...

The change in size of the EHCIqh and EHCIitd descriptors is a bit
worrying since these are used for guest DMA, see ehci_flush_qh(), or
compare, see ehci_verify_qh().

This should be fine for Linux, which has support since day one. Other
older guest OSes may not allocate the extra space. This is a 20+ year
old spec so the risk is probably low but I don't have the expertise to
assess the impact tbh.

Anyhow if we want the model to be correct, we should not write beyond
spec-defined descriptor boundaries when in 32-bit mode.

More work ...

Thanks,

C.

