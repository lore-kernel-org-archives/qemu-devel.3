Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB7EC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 15:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3GmL-0003bR-Bn; Fri, 11 Apr 2025 11:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=05Ho=W5=kaod.org=clg@ozlabs.org>)
 id 1u3GmJ-0003aR-52; Fri, 11 Apr 2025 11:58:51 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=05Ho=W5=kaod.org=clg@ozlabs.org>)
 id 1u3GmF-0006Yo-TR; Fri, 11 Apr 2025 11:58:50 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZZ1ZD1GcSz4xN1;
 Sat, 12 Apr 2025 01:58:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZZ1Z82HMbz4x3S;
 Sat, 12 Apr 2025 01:58:39 +1000 (AEST)
Message-ID: <e002b471-4250-4803-a038-17ffe63e0cca@kaod.org>
Date: Fri, 11 Apr 2025 17:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] pc-bios: Add AST27x0 vBootrom
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com
References: <20250410023856.500258-1-jamin_lin@aspeedtech.com>
 <20250410023856.500258-9-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250410023856.500258-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=05Ho=W5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 4/10/25 04:38, Jamin Lin wrote:
> The boot ROM is a minimal implementation designed to load an AST27x0 boot image.
> Its source code is available at:
> https://github.com/google/vbootrom

See commit d1cb5eda67a0 ("roms: Add virtual Boot ROM for NPCM7xx SoCs")
for an example adding a ROM file.

Also, we need to be able to rebuild from source the provided vbootrom
blob, which means we need access to the code. I don't see any support
for Aspeed under https://github.com/google/vbootrom. Is that expected ?

What does pc-bios/ast27x0_bootrom.bin contain ?

Thanks,

C.




> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   MAINTAINERS                 |   1 +
>   pc-bios/README              |   6 ++++++
>   pc-bios/ast27x0_bootrom.bin | Bin 0 -> 15464 bytes
>   pc-bios/meson.build         |   1 +
>   4 files changed, 8 insertions(+)
>   create mode 100644 pc-bios/ast27x0_bootrom.bin
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d54b5578f8..70ab0d0afa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1163,6 +1163,7 @@ F: docs/system/arm/fby35.rst
>   F: tests/*/*aspeed*
>   F: tests/*/*ast2700*
>   F: hw/arm/fby35.c
> +F: pc-bios/ast27x0_bootrom.bin
>   
>   NRF51
>   M: Joel Stanley <joel@jms.id.au>
> diff --git a/pc-bios/README b/pc-bios/README
> index f0f13e15f2..d009c37895 100644
> --- a/pc-bios/README
> +++ b/pc-bios/README
> @@ -89,6 +89,12 @@
>     more features over time as needed. The source code is available at:
>     https://github.com/google/vbootrom
>   
> +- ast27x0_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for
> +  ASPEED AST27x0 BMC SOC. It currently implements the bare minimum to
> +  load, parse, initialize and run boot images stored in SPI flash, but may grow
> +  more features over time as needed. The source code is available at:
> +  https://github.com/google/vbootrom
> +
>   - hppa-firmware.img (32-bit) and hppa-firmware64.img (64-bit) are firmware
>     files for the HP-PARISC (hppa) architecture.
>     They are built form the SeaBIOS-hppa sources, which is a fork of SeaBIOS
> diff --git a/pc-bios/ast27x0_bootrom.bin b/pc-bios/ast27x0_bootrom.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..e50f56eed9deeea65cbc1dd37897d59b1ff64ddd
> GIT binary patch
> literal 15464
> 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
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index 34d6616c32..83998f6071 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -84,6 +84,7 @@ blobs = [
>     'npcm8xx_bootrom.bin',
>     'vof.bin',
>     'vof-nvram.bin',
> +  'ast27x0_bootrom.bin',
>   ]
>   
>   dtc = find_program('dtc', required: false)


