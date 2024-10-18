Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD0FD3000A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1n50-0002s9-8i; Fri, 18 Oct 2024 09:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=LF+j=RO=kaod.org=clg@ozlabs.org>)
 id 1t1n4g-0002XY-Sm; Fri, 18 Oct 2024 09:31:32 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=LF+j=RO=kaod.org=clg@ozlabs.org>)
 id 1t1n4e-00087y-C6; Fri, 18 Oct 2024 09:31:26 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XVQZp4pTnz4wnp;
 Sat, 19 Oct 2024 00:31:14 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XVQZh5ybFz4wcl;
 Sat, 19 Oct 2024 00:31:05 +1100 (AEDT)
Message-ID: <b3970e21-cbd0-4bca-a857-df55d48c8468@kaod.org>
Date: Fri, 18 Oct 2024 15:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 02/16] hw/block:m25p80: Fix coding style
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
 <20241018053112.1886173-3-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241018053112.1886173-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=LF+j=RO=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/18/24 07:30, Jamin Lin wrote:
> Fix coding style issues from checkpatch.pl
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/block/m25p80.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index f7123f9e68..3f55b8f385 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -61,7 +61,8 @@ typedef struct FlashPartInfo {
>        */
>       uint8_t id[SPI_NOR_MAX_ID_LEN];
>       uint8_t id_len;
> -    /* there is confusion between manufacturers as to what a sector is. In this
> +    /*
> +     * there is confusion between manufacturers as to what a sector is. In this
>        * device model, a "sector" is the size that is erased by the ERASE_SECTOR
>        * command (opcode 0xd8).
>        */
> @@ -168,7 +169,7 @@ typedef struct FlashPartInfo {
>   /*
>    * Spansion read mode command length in bytes,
>    * the mode is currently not supported.
> -*/
> + */
>   
>   #define SPANSION_CONTINUOUS_READ_MODE_CMD_LEN 1
>   #define WINBOND_CONTINUOUS_READ_MODE_CMD_LEN 1
> @@ -189,7 +190,8 @@ static const FlashPartInfo known_devices[] = {
>   
>       { INFO("at45db081d",  0x1f2500,      0,  64 << 10,  16, ER_4K) },
>   
> -    /* Atmel EEPROMS - it is assumed, that don't care bit in command
> +    /*
> +     * Atmel EEPROMS - it is assumed, that don't care bit in command
>        * is set to 0. Block protection is not supported.
>        */
>       { INFO("at25128a-nonjedec", 0x0,     0,         1, 131072, EEPROM) },
> @@ -275,10 +277,13 @@ static const FlashPartInfo known_devices[] = {
>       { INFO_STACKED("n25q00a",   0x20bb21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
>       { INFO_STACKED("mt25ql01g", 0x20ba21, 0x1040, 64 << 10, 2048, ER_4K, 2) },
>       { INFO_STACKED("mt25qu01g", 0x20bb21, 0x1040, 64 << 10, 2048, ER_4K, 2) },
> -    { INFO_STACKED("mt25ql02g", 0x20ba22, 0x1040, 64 << 10, 4096, ER_4K | ER_32K, 2) },
> -    { INFO_STACKED("mt25qu02g", 0x20bb22, 0x1040, 64 << 10, 4096, ER_4K | ER_32K, 2) },
> +    { INFO_STACKED("mt25ql02g", 0x20ba22, 0x1040, 64 << 10, 4096,
> +                   ER_4K | ER_32K, 2) },
> +    { INFO_STACKED("mt25qu02g", 0x20bb22, 0x1040, 64 << 10, 4096,
> +                   ER_4K | ER_32K, 2) },
>   
> -    /* Spansion -- single (large) sector size only, at least
> +    /*
> +     * Spansion -- single (large) sector size only, at least
>        * for the chips listed here (without boot sectors).
>        */
>       { INFO("s25sl032p",   0x010215, 0x4d00,  64 << 10,  64, ER_4K) },
> @@ -549,7 +554,8 @@ static void blk_sync_complete(void *opaque, int ret)
>       qemu_iovec_destroy(iov);
>       g_free(iov);
>   
> -    /* do nothing. Masters do not directly interact with the backing store,
> +    /*
> +     * do nothing. Masters do not directly interact with the backing store,
>        * only the working copy so no mutexing required.
>        */
>   }
> @@ -1843,7 +1849,7 @@ static void m25p80_register_types(void)
>   
>       type_register_static(&m25p80_info);
>       for (i = 0; i < ARRAY_SIZE(known_devices); ++i) {
> -        TypeInfo ti = {
> +        const TypeInfo ti = {
>               .name       = known_devices[i].part_name,
>               .parent     = TYPE_M25P80,
>               .class_init = m25p80_class_init,


