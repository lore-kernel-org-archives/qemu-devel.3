Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB06C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 05:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8w28-0005fS-Jw; Mon, 20 May 2024 01:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3Db1=MX=kaod.org=clg@ozlabs.org>)
 id 1s8w1E-0005am-8r; Mon, 20 May 2024 01:57:08 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3Db1=MX=kaod.org=clg@ozlabs.org>)
 id 1s8w1C-0007l0-K5; Mon, 20 May 2024 01:57:08 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VjRfN2Kxkz4wjF;
 Mon, 20 May 2024 15:57:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VjRfJ2J2jz4wbp;
 Mon, 20 May 2024 15:56:55 +1000 (AEST)
Message-ID: <eaeb9158-ec65-4772-9143-39c48f404766@kaod.org>
Date: Mon, 20 May 2024 07:56:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] hw/block: Add Microchip's 25CSM04 to m25p80
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com, milesg@linux.vnet.ibm.com
References: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
 <20240515174149.17713-4-chalapathi.v@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240515174149.17713-4-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=3Db1=MX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 5/15/24 19:41, Chalapathi V wrote:
> Add Microchip's 25CSM04 Serial EEPROM to m25p80.  25CSM04 provides 4 Mbits
> of Serial EEPROM utilizing the Serial Peripheral Interface (SPI) compatible
> bus. The device is organized as 524288 bytes of 8 bits each (512Kbyte) and
> is optimized for use in consumer and industrial applications where reliable
> and dependable nonvolatile memory storage is essential.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/block/m25p80.c | 3 +++
>   hw/ppc/Kconfig    | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 8dec134832..824a6c5c60 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -357,6 +357,9 @@ static const FlashPartInfo known_devices[] = {
>         .sfdp_read = m25p80_sfdp_w25q512jv },
>       { INFO("w25q01jvq",   0xef4021,      0,  64 << 10, 2048, ER_4K),
>         .sfdp_read = m25p80_sfdp_w25q01jvq },
> +
> +    /* Microchip */
> +    { INFO("25csm04",      0x29cc00,      0x100,  64 << 10,  8, 0) },
>   };
>   
>   typedef enum {
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 6f9670b377..a93430b734 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -40,6 +40,7 @@ config POWERNV
>       select PCA9552
>       select PCA9554
>       select SSI
> +    select SSI_M25P80
>   
>   config PPC405
>       bool


