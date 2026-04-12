Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4045E937EF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 17:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wByiz-0008Sk-Ib; Sun, 12 Apr 2026 13:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wByiq-0008RS-Qn; Sun, 12 Apr 2026 13:35:50 -0400
Received: from smtpout1.mo533.mail-out.ovh.net ([51.210.94.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wByin-0002Ju-Sp; Sun, 12 Apr 2026 13:35:47 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4ftyP81gz8z61XK;
 Sun, 12 Apr 2026 17:35:40 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun, 12 Apr 2026 17:35:40 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.133])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4ftyP80c2Mz7tn8; Sun, 12 Apr 2026 17:35:40 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 7D393941618; 
 Sun, 12 Apr 2026 17:35:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005326bc5a1-63d8-40e3-ae42-17650902ebc3,
 24D929EF98A9C54707A36CFD348010E9E2578269) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <cc63ecb7-c9d3-4d79-b13c-156efaf76dfd@kaod.org>
Date: Sun, 12 Apr 2026 19:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/13] hw/usb/ehci: Add 64-bit descriptor addressing
 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 15558810813333744651
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGnfn9ZWhuCnXCPhDZh2mE6W8MpVONShPwSW1FHFx/N7dAwqcuP33DpfkyEm+LXa1wcVe5M1QHMUDRF9c8WBmc5LGxz4SzkX+inOHTCuA2mWkSkL0zfDjneDNtWNh7tpK+9gIyRjCTiipqklmAnnMA1GxenHgsqAVfPk/+/KVO3XwkNmvHFVEDwX/+fvuIREWCiRkkZwBF2C6ovA0HD105cl82RkYP2TqO9iZd8ycazC+d0BG7/JTnX+rLDhKAUvrVxK9x6efE4nU683IgmGTSI7fo4DJhSTjtEs4PguG/wgPbE0EWXDWrVmUJk4MzqoZzLMw7azq0gme/dqEJpbE+RfSkz6x+8EBGgF9woM0htiy12jTejP2k/COADvsHTGNL15wwhM0+DriFx2vn2XSk5FaLzn+QbTH1lYqE31sf3FN57X+ewgN9WrV0hCmOOsli0OvNcEdgMA8BMcHgqdkPGu8Zay3YUCSjbGbRHlRHBVEmUWE29pSXgu/xKbzzeqFEVjL59mPpIN0tCvdhVK7WzN5LF5GXXcQxL/ICE4ZivgFMwEpE6xjrKgt76vaOAT/D/9z5LMW8vK0T6sUYc5dAGiAqX5qrJjp6PAz+jbROcLwskXM2rSE3k1L+mwhq5GCr4R5j5OlFOKEEV8x3TV7uIVfW+jx1mEycIGkM93Ay/ew
DKIM-Signature: a=rsa-sha256; bh=W+7JSMVWz/6T3ganRUgISG+f/OudQCe30ogGUEqWX8s=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776015340; v=1;
 b=UoYaELP4z6d5tExrr0XU8wWyQsCzlHFtlETjZoQhbbLObGxDgYH8JDnll7laeLpZk136kd2N
 UKneKke81gI6j44X9dnPKrmDS4SXe1aFF/uquktH5jPA82yy+aCGBwSMcsEW5ZQm4pSTPq4wHP8
 shPwOw1df3krMQh1GE+SLvGn93NgVLFwA+E6zr/QaV9DSnNwLCFEUgKKIfez3ijpy+CWwmpic8P
 VBPuHc2Puiwlp2vRdx9xEGJW4/3AoYg1UrVNrr//sLUngGdga2cmG9rqThbHYTkaWwLZpSkwA2v
 j+VVps/oIlV0rNZ9rqMzg3CrdM2QXDm2lqOY5aGW378VA==
Received-SPF: pass client-ip=51.210.94.138; envelope-from=clg@kaod.org;
 helo=smtpout1.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Jamin,


On 3/11/26 08:26, Jamin Lin wrote:
> EHCI supports 64-bit addressing through the CTRLDSSEGMENT register,
> which provides the upper 32 bits of descriptor addresses when the
> controller advertises 64-bit capability.
> 
> Currently QEMU EHCI model only partially supports this functionality and
> descriptor addresses are effectively treated as 32-bit. This becomes
> problematic on systems where system memory is located above the 4GB
> boundary.
> 
> The Linux EHCI driver enables 64-bit addressing if the controller
> advertises the capability. During initialization it programs the
> segment register to zero:
> 
>    https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c#L600
> 
> The driver also notes that descriptor structures allocated from the
> DMA pool use segment zero semantics. Descriptor memory is allocated
> using the DMA API and platforms may configure a 64-bit DMA mask,
> allowing descriptor memory to be placed above 4GB.
> 
> On AST2700 platforms, system DRAM is mapped at 0x400000000. As a
> result, descriptor addresses constructed directly from the EHCI
> registers do not match the actual system addresses used by the
> controller when accessing queue heads (QH) and queue element transfer
> descriptors (qTD).
> 
> This patch series implements full 64-bit descriptor addressing support
> in the EHCI emulation. Descriptor address handling is updated to use
> 64-bit values and the descriptor structures (QH, qTD, iTD and siTD)
> are extended to support the upper address bits provided by the segment
> register.
> 
> In addition, a descriptor-addr-offset property is introduced so
> platforms can apply an address translation when descriptor memory
> resides above the 4GB boundary.
> 
> The AST2700 machine uses this property to account for its DRAM mapping
> at 0x400000000 and enables 64-bit EHCI DMA addressing.
> 
> Test Result:
> 1. EHCI 32bits with ast2600-evb machine
> Command line:
> ./build/qemu-system-arm \
>    -machine ast2600-evb \
>    -m 1G \
>    -drive file=image-bmc,if=mtd,format=raw \
>    -nographic \
>    -device usb-kbd,bus=usb-bus.1,id=mykbd \
>    -drive id=usbdisk,if=none,file=image0.ext4,format=raw \
>    -device usb-storage,bus=usb-bus.1,id=mystorage,drive=usbdisk
>    -snapshot \
>    -nographic
> Result:
> unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.3-v00.08.01-g172b7e27a30d ehci_hcd EHCI Host Controller
> Bus 001 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard
> Bus 001 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
> Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.3-v00.08.01-g172b7e27a30d uhci_hcd Generic UHCI Host Controller
> 
> 2. EHCI 64bits with ast2700a2-evb machine
> Command line:
> ./build/qemu-system-aarch64 -M ast2700a2-evb -nographic\
>   -bios ast27x0_bootrom.bin \
>   -drive file=image-bmc,format=raw,if=mtd \
>   -snapshot \
>   -device usb-kbd,bus=usb-bus.3,id=mykbd \
>   -drive id=usbdisk,if=none,file=image0.ext4,format=raw \
>   -device usb-storage,bus=usb-bus.3,id=mystorage,drive=usbdisk
> Result:
> root@ast2700-default:~# lsusb
> unable to initialize usb specBus 001 Device 001: ID 1d6b:0001 Linux 6.18.3-v00.08.01-g172b7e27a30d uhci_hcd Generic UHCI Host Controller
> Bus 002 Device 001: ID 1d6b:0002 Linux 6.18.3-v00.08.01-g172b7e27a30d ehci_hcd EHCI Host Controller
> Bus 002 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard
> Bus 002 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
>


Would you have time to propose a functional test ?

Thanks

C.


> v1
>   1. Fix checkpatch coding style issues
>   2. Implement 64-bit addressing for QH/qTD/iTD/siTD descriptors
>   3. Add descriptor address offset property
>   4. Enable 64-bit EHCI DMA addressing on AST2700
>   5. Configure descriptor address offset for AST2700
> 
> Jamin Lin (13):
>    hw/usb/hcd-ehci.h: Fix coding style issues reported by checkpatch
>    hw/usb/hcd-ehci.c: Fix coding style issues reported by checkpatch
>    hw/usb/hcd-ehci: Change descriptor addresses to 64-bit
>    hw/usb/trace-events: Print EHCI queue and transfer addresses as 64-bit
>    hw/usb/hcd-ehci: Add property to advertise 64-bit addressing
>      capability
>    hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes without 64-bit capability
>    hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing
>    hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing
>    hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing
>    hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing
>    hw/usb/hcd-ehci: Add descriptor address offset property
>    hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing
>    hw/arm/aspeed_ast27x0: Set EHCI descriptor address offset
> 
>   hw/usb/hcd-ehci.h        |  36 +++--
>   hw/arm/aspeed_ast27x0.c  |   5 +
>   hw/usb/hcd-ehci-pci.c    |   4 +
>   hw/usb/hcd-ehci-sysbus.c |   4 +
>   hw/usb/hcd-ehci.c        | 293 ++++++++++++++++++++++++---------------
>   hw/usb/trace-events      |  16 +--
>   6 files changed, 226 insertions(+), 132 deletions(-)
> 


