Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FC5E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBrO-00062X-EV; Tue, 07 Jan 2025 10:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=eiJ5=T7=kaod.org=clg@ozlabs.org>)
 id 1tVBrM-00061n-UH; Tue, 07 Jan 2025 10:51:12 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=eiJ5=T7=kaod.org=clg@ozlabs.org>)
 id 1tVBrI-00077L-B4; Tue, 07 Jan 2025 10:51:12 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4YSFrY2kJ1z4wxx;
 Wed,  8 Jan 2025 02:50:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4YSFrT5fHwz4wcl;
 Wed,  8 Jan 2025 02:50:46 +1100 (AEDT)
Message-ID: <8f36b753-660d-4902-be5b-b6569c93aeb5@kaod.org>
Date: Tue, 7 Jan 2025 16:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Introduce AST27x0 multi-SoC machine
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=eiJ5=T7=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.24, RCVD_IN_DNSWL_MED=-2.3,
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

Steven,

When you resend, could you please rebase on top of :

   https://lore.kernel.org/qemu-devel/20241216075353.1308043-1-jamin_lin@aspeedtech.com/

Thanks,

C.

On 12/25/24 03:03, Steven Lee wrote:
> This patch series introduces full cores support for the AST27x0 SoC,
> along with necessary updates to the ASPEED AST27x0 SOC.
> 
> The AST27x0 SoC is a new family of ASPEED SoCs featuring 4 Cortex-A35
> cores and 2 Cortex-M4 cores. This patch set adds the following updates:
> 
> 1. Public API updates:
>     Modifies the sdhci_attach_drive and write_boot_rom functions to make them
>     accessible for broader usage.
> 
> 2. SoC memory updates:
>     Maps unimplemented devices in the AST27x0 memory space.
> 
> 3. AST27x0 CM4 SoC integration:
>     Adds basic support for the AST27x0 CM4 SoC.
> 
> 4. AST2700-FC machine:
>     Introduces a new AST2700-FC machine which supports emulating 4
>     cortex-a35 cores and 2 coretex-m4 cores.
> 
> 5. Documentation:
>     Updates the ASPEED documentation to include usage of the new
>     ast2700-fc machine.
> 
> This series has been tested using ASPEED SDK image by the following
>    IMGDIR=./
>    UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
> 
>    $ UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
>    $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/ast2700-ssp.elf
>    $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/ast2700-tsp.elf
>    $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/bl31.bin
>    $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/tee-raw.bin
>    $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/u-boot-nodtb.bin
>    $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/u-boot.dtb
>    $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/image-bmc.tar.zst
>    $ tar --zstd -xvf image-bmc.tar.zst
> 
>    $ qemu-system-aarch64 -machine ast2700fc \
>         -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin \
>         -device loader,force-raw=on,addr=$((0x400000000 + ${UBOOT_SIZE})),file=${IMGDIR}/u-boot.dtb \
>         -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
>         -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/tee-raw.bin \
>         -device loader,file=${IMGDIR}/ast2700-ssp.elf,cpu-num=4 \
>         -device loader,file=${IMGDIR}/ast2700-tsp.elf,cpu-num=5 \
>         -device loader,cpu-num=0,addr=0x430000000 \
>         -device loader,cpu-num=1,addr=0x430000000 \
>         -device loader,cpu-num=2,addr=0x430000000 \
>         -device loader,cpu-num=3,addr=0x430000000 \
>         -m 1G \
>         -drive file=image-bmc,if=mtd,format=raw \
>         -serial pty -serial pty -serial pty \
>         -S -nographic
> 
>      char device redirected to /dev/pts/51 (label serial0)
>      char device redirected to /dev/pts/52 (label serial1)
>      char device redirected to /dev/pts/53 (label serial2)
> 
>    $ tio /dev/pts/51
>    $ tio /dev/pts/52
>    $ tio /dev/pts/53
>    $ (qemu) c
> 
> Steven Lee (5):
>    aspeed: Make sdhci_attach_drive and write_boot_rom public
>    aspeed: ast27x0: Map unimplemented devices in SoC memory
>    aspeed: Introduce AST27x0 SoC with Cortex-M4 support
>    aspeed: Introduce ast2700-fc machine
>    docs: aspeed: Add ast2700-fc machine section
> 
>   docs/system/arm/aspeed.rst  |  50 ++++-
>   hw/arm/aspeed.c             |   4 +-
>   hw/arm/aspeed_ast27x0-cm4.c | 397 ++++++++++++++++++++++++++++++++++++
>   hw/arm/aspeed_ast27x0-fc.c  | 211 +++++++++++++++++++
>   hw/arm/aspeed_ast27x0.c     |  45 +++-
>   hw/arm/meson.build          |   5 +-
>   include/hw/arm/aspeed.h     |   6 +
>   include/hw/arm/aspeed_soc.h |  41 ++++
>   8 files changed, 747 insertions(+), 12 deletions(-)
>   create mode 100644 hw/arm/aspeed_ast27x0-cm4.c
>   create mode 100644 hw/arm/aspeed_ast27x0-fc.c
> 
> --
> 2.34.1
> 


