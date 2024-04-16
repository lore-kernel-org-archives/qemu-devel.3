Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED6BC04FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 15:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwl8y-0001fQ-2I; Tue, 16 Apr 2024 11:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=29bf=LV=kaod.org=clg@ozlabs.org>)
 id 1rwl8w-0001es-0H; Tue, 16 Apr 2024 11:54:46 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=29bf=LV=kaod.org=clg@ozlabs.org>)
 id 1rwl8t-0006fN-AU; Tue, 16 Apr 2024 11:54:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VJpWc0pyvz4wyf;
 Wed, 17 Apr 2024 01:54:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJpWV5Mq6z4wyY;
 Wed, 17 Apr 2024 01:54:30 +1000 (AEST)
Message-ID: <a2c64420-2472-4ef5-b006-ced54ac52c65@kaod.org>
Date: Tue, 16 Apr 2024 17:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] docs:aspeed: Add AST2700 Evaluation board
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
 <20240416091904.935283-17-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240416091904.935283-17-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=29bf=LV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/16/24 11:19, Jamin Lin wrote:
> Add AST2700 Evaluation board and its boot command.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   docs/system/arm/aspeed.rst | 39 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index b2dea54eed..320ff2a4cd 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -1,11 +1,12 @@
> -Aspeed family boards (``*-bmc``, ``ast2500-evb``, ``ast2600-evb``)
> -==================================================================
> +Aspeed family boards (``*-bmc``, ``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``)
> +===================================================================================
>   
>   The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
>   Aspeed evaluation boards. They are based on different releases of the
>   Aspeed SoC : the AST2400 integrating an ARM926EJ-S CPU (400MHz), the
> -AST2500 with an ARM1176JZS CPU (800MHz) and more recently the AST2600
> -with dual cores ARM Cortex-A7 CPUs (1.2GHz).
> +AST2500 with an ARM1176JZS CPU (800MHz), the AST2600
> +with dual cores ARM Cortex-A7 CPUs (1.2GHz) and more recently the AST2700
> +with quad cores ARM Cortex-A35 64 bits CPUs (1.6GHz)
>   
>   The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
>   etc.
> @@ -38,6 +39,10 @@ AST2600 SoC based machines :
>   - ``qcom-dc-scm-v1-bmc``   Qualcomm DC-SCM V1 BMC
>   - ``qcom-firework-bmc``    Qualcomm Firework BMC
>   
> +AST2700 SoC based machines :
> +
> +- ``ast2700-evb``          Aspeed AST2700 Evaluation board (Cortex-A35)
> +
>   Supported devices
>   -----------------
>   
> @@ -66,6 +71,7 @@ Supported devices
>    * eMMC Boot Controller (dummy)
>    * PECI Controller (minimal)
>    * I3C Controller
> + * Internal Bridge Controller (SLI dummy)
>   
>   
>   Missing devices
> @@ -95,6 +101,10 @@ or directly from the OpenBMC GitHub release repository :
>   
>      https://github.com/openbmc/openbmc/releases
>   
> +or directly from the ASPEED Forked OpenBMC GitHub release repository :
> +
> +   https://github.com/AspeedTech-BMC/openbmc/releases
> +
>   To boot a kernel directly from a Linux build tree:
>   
>   .. code-block:: bash
> @@ -164,6 +174,27 @@ under Linux), use :
>   
>     -M ast2500-evb,bmc-console=uart3
>   
> +
> +Boot the AST2700 machine from the flash image, use an MTD drive :
> +
> +.. code-block:: bash
> +
> +  IMGDIR=ast2700-default
> +  UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
> +
> +  $ qemu-system-aarch64 -M ast2700-evb \
> +       -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin \
> +       -device loader,force-raw=on,addr=$((0x400000000 + ${UBOOT_SIZE})),file=u-boot.dtb \
> +       -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
> +       -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/optee/tee-raw.bin \
> +       -device loader,cpu-num=0,addr=0x430000000 \
> +       -device loader,cpu-num=1,addr=0x430000000 \
> +       -device loader,cpu-num=2,addr=0x430000000 \
> +       -device loader,cpu-num=3,addr=0x430000000 \
> +       -smp 4 \
> +       -drive file=${IMGDIR}/image-bmc,format=raw,if=mtd \
> +       -nographic
> +
>   Aspeed minibmc family boards (``ast1030-evb``)
>   ==================================================================
>   


