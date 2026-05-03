Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D73FF886F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 20:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJdLt-0003T6-Ed; Sun, 03 May 2026 16:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wJdLq-0003Sd-JP; Sun, 03 May 2026 16:23:42 -0400
Received: from 11.mo533.mail-out.ovh.net ([87.98.181.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wJdLo-0004vW-DT; Sun, 03 May 2026 16:23:42 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4g7x7F4mBpz5vgZ;
 Sun,  3 May 2026 20:23:37 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun,  3 May 2026 20:23:37 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.140])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4g7x7F3Kp4z1xs4;
 Sun,  3 May 2026 20:23:37 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 F239A19234C3; Sun,  3 May 2026 20:23:32 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00583b01ca1-01c6-4778-9094-cd56b4bebf8b,
 15A2E2FDD32F27586AD59E6AF3E683E8C1C94C55) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4b644601-f4b1-4c93-b75a-bed1a2691604@kaod.org>
Date: Sun, 3 May 2026 22:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/18] hw/usb/ehci: Add 64-bit descriptor addressing
 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 12594597835776371919
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFR7GD1rnl4AjALoHdZKIbg0q3maJKXoXEwJkOreN/mcV4nwJNZYjMFjbFbI1DuE5BoSagG/r79gm6pbuo0AteVCo2tHAPE1OlRPDRP/7eD4S78WJu3BTv0OX2g5barIfV2Zfc53xlxyoXljD3EONYK9t7uVKkpeMUnUgfZkHQl3g2uGa2Q6dXTSeKRRZ/ubicCrX5S9P1m8dD7dUAlgVhzT8fQ1ijB2LZ2By6vwLCgdOr0AkdiAbaDLP8Tovg4EgmrCBBxGw0tmBA/I2xMz1rilB7YMV50tg5BPRHgZzpTMQ1plCFrD3zXQZ0ubXXdsVov7fk0ckjpa4zDPhPUOoBynmKz+L2rar84FYX93mfyvyYN5zr78HOiIeWA1VZPWKb1TChQmdzDKzyQfwWJ3IE52U6ogMcLwDxEvVLzPAXisg71IgmlVaPLUj7r3XZYnTNGoAt7J/HUIUlERAuwqBiWTRclh2PBiOZXwX2POgfByofCcBvXtXpf6d49POIcJCf7KXTJAlRkpbn5DoLgHL3cjsamteBbjBNl48II3n/fPh93pX07Tnl0tAhJM0reFkdk9Nrxz3T6aQr4xFqL16utP0Tc2O3jEol7vyFvshDMCQYfJD2cYL0E/IIsseoGpkVX4ZoJeQa7vlwC5LHyEw+eitBSgveGPbPzR5VB+RnJwQ
DKIM-Signature: a=rsa-sha256; bh=nf6awHQz0kZVnIz0yOs2540Yb3a8Fsm5zzCMlCddVFM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1777839818; v=1;
 b=wWE5uS5OOE4JbVD9bhceOOOoSDBXcQ/cHVD5mTnYuFpnMowITvsao9zsjX7+ZIBKFpBw6nDQ
 RXc87l+7oUAilhSySVOfIsRZuzoowSEGtu3ESM/nQxePDmBjT1HeWGLPQODDEGnpxLqLwC9Kk3c
 RQDPBpULky1DwzjGP6PiN+TPYpRjMGoXtzNAPThVe6t8TPv1Jl63sqx3ZQZjXez1NKGy19lvbpr
 BTYqZESDI3P2/STojcJE3FEudTaqxvIZ+uOU200mL9oI5ZUXGvFnMG16q3Lz5oD1yEO4Zrf13LQ
 jK9H7sgZ6eRRC4jOKm0KtJezMZCGD4lJdgGxw+zZec+2w==
Received-SPF: pass client-ip=87.98.181.139; envelope-from=clg@kaod.org;
 helo=11.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Jamin,

On 4/24/26 10:05, Jamin Lin wrote:
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
> Add a ctrldssegment-default property so platforms can provide a
> descriptor address offset when constructing descriptor addresses.
> This allows systems where DRAM resides above 4GB to access EHCI
> descriptors correctly.
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
> v1
>   1. Fix checkpatch coding style issues
>   2. Implement 64-bit addressing for QH/qTD/iTD/siTD descriptors
>   3. Add descriptor address offset property
>   4. Enable 64-bit EHCI DMA addressing on AST2700
>   5. Configure descriptor address offset for AST2700
> 
> v2
>   1. Remove unused EHCIfstn structure and dead code
>   2. Replace fprintf(stderr, ...) with qemu_log_mask(LOG_GUEST_ERROR)
>   3. Replace DPRINTF debug logs with trace events
>   4. Add functional tests for USB EHCI on AST2600 and AST2700 A1/A2
>   5. Fix review issue
> 
> v3:
>   1. Add Migration version test function
>   2. Add EHCI 64-bit buffer pointer fields description in commit log
> 
> v4:
>   1. Reorder patches in the series
>   2. Fix EHCI migration issues
>   3. Introduce a common properties macro for both sysbus and PCI
>   4. Drop the descriptor address offset property
>   5. Add ctrldssegment-default property
>   6. Address review comments
> 
> v5:
>   1. Add 11.0 machine compatibility properties
> 
> Jamin Lin (18):
>    tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for
>      AST2600 SDK
>    hw/usb/hcd-ehci: Remove unused EHCIfstn structure and dead code
>    hw/usb/hcd-ehci.h: Fix coding style issues reported by checkpatch
>    hw/usb/hcd-ehci.c: Fix coding style issues reported by checkpatch
>    hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...) with
>      qemu_log_mask(LOG_GUEST_ERROR)
>    hw/usb/hcd-ehci: Replace DPRINTF debug logs with trace events
>    hw/usb/hcd-ehci: Introduce common properties macro for sysbus and pci
>    hw/core: Add 11.0 machine compatibility properties
>    hw/usb/hcd-ehci: Change descriptor addresses to 64-bit with migration
>      compatibility
>    hw/usb/hcd-ehci: Add property to advertise 64-bit addressing
>      capability
>    hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing
>    hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing
>    hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing
>    hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing
>    hw/usb/hcd-ehci: Add ctrldssegment-default property
>    hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default
>    hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing
>    tests/functional/aarch64/test_aspeed_ast2700: Add USB EHCI test for
>      AST2700 A1/A2
> 
>   hw/usb/hcd-ehci.h                             |  64 +--
>   include/hw/core/boards.h                      |   3 +
>   include/hw/i386/pc.h                          |   3 +
>   hw/arm/aspeed_ast27x0.c                       |   4 +
>   hw/arm/virt.c                                 |   8 +
>   hw/core/machine.c                             |   6 +
>   hw/i386/pc.c                                  |   3 +
>   hw/i386/pc_piix.c                             |  11 +-
>   hw/i386/pc_q35.c                              |  11 +-
>   hw/m68k/virt.c                                |   7 +
>   hw/ppc/spapr.c                                |  13 +-
>   hw/s390x/s390-virtio-ccw.c                    |  11 +
>   hw/usb/hcd-ehci-pci.c                         |   2 +-
>   hw/usb/hcd-ehci-sysbus.c                      |   2 +-
>   hw/usb/hcd-ehci.c                             | 382 +++++++++++-------
>   hw/usb/trace-events                           |  25 +-
>   .../aarch64/test_aspeed_ast2700a1.py          |   7 +
>   .../aarch64/test_aspeed_ast2700a2.py          |   7 +
>   .../functional/arm/test_aspeed_ast2600_sdk.py |   7 +
>   19 files changed, 384 insertions(+), 192 deletions(-)
> 

Patches 1-9 are merged. Could you please resend the remaining patches
in a v6 with the with suggested improvements ? I will queue the
series in aspeed-next.


Thanks,

C.



