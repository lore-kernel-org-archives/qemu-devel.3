Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611F7C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 21:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7heC-0007qv-8q; Wed, 23 Apr 2025 17:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wlG+=XJ=kaod.org=clg@ozlabs.org>)
 id 1u7he5-0007me-Ga; Wed, 23 Apr 2025 17:28:42 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wlG+=XJ=kaod.org=clg@ozlabs.org>)
 id 1u7hdy-0000Pk-8A; Wed, 23 Apr 2025 17:28:41 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZjXK948Ynz4xMG;
 Thu, 24 Apr 2025 07:28:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZjXK55b52z4xM3;
 Thu, 24 Apr 2025 07:28:25 +1000 (AEST)
Message-ID: <ec54cd99-63af-4dce-8bd0-e1a0c3e0a2b3@kaod.org>
Date: Wed, 23 Apr 2025 23:28:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] pc-bios: Add AST27x0 vBootrom
To: Nabih Estefan <nabihestefan@google.com>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, troy_lee@aspeedtech.com
References: <20250423072350.541742-1-jamin_lin@aspeedtech.com>
 <20250423072350.541742-6-jamin_lin@aspeedtech.com>
 <fdd1e0dd-d207-4ca8-8a07-abe92d937c40@kaod.org>
 <CA+QoejXSrPy2SWCtWpw4WXCx6W5vTOZpYBCE=PzSfnQTnWqekg@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CA+QoejXSrPy2SWCtWpw4WXCx6W5vTOZpYBCE=PzSfnQTnWqekg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=wlG+=XJ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/23/25 22:29, Nabih Estefan wrote:
> Just got merged into https://github.com/google/vbootrom
> 
> Commit id: 82bed5ca62295228ea7bcdc721b63db178f686e8

Thanks Nabih.

v6 should be ready for merge then.

C.


> 
> Thanks,
> 
> Nabih
> 
> On Wed, Apr 23, 2025 at 2:28 AM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 4/23/25 09:23, Jamin Lin wrote:
>>> The boot ROM is a minimal implementation designed to load an AST27x0 boot image.
>>> Its source code is available at:
>>> https://github.com/google/vbootrom
>>
>> It is not merged yet. Please resend when done and mention the commit id.
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> Reviewed-by: Nabih Estefan <nabihestefan@google.com>
>>> Tested-by: Nabih Estefan <nabihestefan@google.com>
>>> ---
>>>    MAINTAINERS                 |   1 +
>>>    pc-bios/README              |   6 ++++++
>>>    pc-bios/ast27x0_bootrom.bin | Bin 0 -> 15424 bytes
>>>    pc-bios/meson.build         |   1 +
>>>    4 files changed, 8 insertions(+)
>>>    create mode 100644 pc-bios/ast27x0_bootrom.bin
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index d54b5578f8..70ab0d0afa 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1163,6 +1163,7 @@ F: docs/system/arm/fby35.rst
>>>    F: tests/*/*aspeed*
>>>    F: tests/*/*ast2700*
>>>    F: hw/arm/fby35.c
>>> +F: pc-bios/ast27x0_bootrom.bin
>>>
>>>    NRF51
>>>    M: Joel Stanley <joel@jms.id.au>
>>> diff --git a/pc-bios/README b/pc-bios/README
>>> index f0f13e15f2..d009c37895 100644
>>> --- a/pc-bios/README
>>> +++ b/pc-bios/README
>>> @@ -89,6 +89,12 @@
>>>      more features over time as needed. The source code is available at:
>>>      https://github.com/google/vbootrom
>>>
>>> +- ast27x0_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for
>>> +  ASPEED AST27x0 BMC SOC. It currently implements the bare minimum to
>>> +  load, parse, initialize and run boot images stored in SPI flash, but may grow
>>> +  more features over time as needed. The source code is available at:
>>> +  https://github.com/google/vbootrom
>>> +
>>>    - hppa-firmware.img (32-bit) and hppa-firmware64.img (64-bit) are firmware
>>>      files for the HP-PARISC (hppa) architecture.
>>>      They are built form the SeaBIOS-hppa sources, which is a fork of SeaBIOS
>>> diff --git a/pc-bios/ast27x0_bootrom.bin b/pc-bios/ast27x0_bootrom.bin
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..d46403b023c00f989b6facb397d57bea7e5c583a
>>> GIT binary patch
>>> literal 15424
>>> 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
>>> TJDH<UkE#+fTtE*0xX=Fr0X;+;
>>>
>>> literal 0
>>> HcmV?d00001
>>>
>>> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
>>> index 34d6616c32..83998f6071 100644
>>> --- a/pc-bios/meson.build
>>> +++ b/pc-bios/meson.build
>>> @@ -84,6 +84,7 @@ blobs = [
>>>      'npcm8xx_bootrom.bin',
>>>      'vof.bin',
>>>      'vof-nvram.bin',
>>> +  'ast27x0_bootrom.bin',
>>>    ]
>>>
>>>    dtc = find_program('dtc', required: false)
>>


