Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FCAC04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 15:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwklh-0000W8-DI; Tue, 16 Apr 2024 11:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=29bf=LV=kaod.org=clg@ozlabs.org>)
 id 1rwklP-0000UZ-4M; Tue, 16 Apr 2024 11:30:30 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=29bf=LV=kaod.org=clg@ozlabs.org>)
 id 1rwklM-0001cE-QP; Tue, 16 Apr 2024 11:30:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VJnzf1dfmz4wyl;
 Wed, 17 Apr 2024 01:30:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJnzY1GZ3z4wyY;
 Wed, 17 Apr 2024 01:30:16 +1000 (AEST)
Message-ID: <382a8ea3-a2bc-406c-9655-a1e82cd64b97@kaod.org>
Date: Tue, 16 Apr 2024 17:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/16] aspeed/sdmc: remove redundant macros
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
 <20240416091904.935283-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240416091904.935283-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=29bf=LV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
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

On 4/16/24 11:18, Jamin Lin wrote:
> These macros are no longer used for ASPEED SOCs, so removes them.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/misc/aspeed_sdmc.c | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 64cd1a81dc..74279bbe8e 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -76,10 +76,6 @@
>   #define     ASPEED_SDMC_VGA_32MB            0x2
>   #define     ASPEED_SDMC_VGA_64MB            0x3
>   #define ASPEED_SDMC_DRAM_SIZE(x)        (x & 0x3)
> -#define     ASPEED_SDMC_DRAM_64MB           0x0
> -#define     ASPEED_SDMC_DRAM_128MB          0x1
> -#define     ASPEED_SDMC_DRAM_256MB          0x2
> -#define     ASPEED_SDMC_DRAM_512MB          0x3
>   
>   #define ASPEED_SDMC_READONLY_MASK                       \
>       (ASPEED_SDMC_RESERVED | ASPEED_SDMC_VGA_COMPAT |    \
> @@ -100,17 +96,6 @@
>   #define ASPEED_SDMC_CACHE_ENABLE        (1 << 10) /* differs from AST2400 */
>   #define ASPEED_SDMC_DRAM_TYPE           (1 << 4)  /* differs from AST2400 */
>   
> -/* DRAM size definitions differs */
> -#define     ASPEED_SDMC_AST2500_128MB       0x0
> -#define     ASPEED_SDMC_AST2500_256MB       0x1
> -#define     ASPEED_SDMC_AST2500_512MB       0x2
> -#define     ASPEED_SDMC_AST2500_1024MB      0x3
> -
> -#define     ASPEED_SDMC_AST2600_256MB       0x0
> -#define     ASPEED_SDMC_AST2600_512MB       0x1
> -#define     ASPEED_SDMC_AST2600_1024MB      0x2
> -#define     ASPEED_SDMC_AST2600_2048MB      0x3
> -
>   #define ASPEED_SDMC_AST2500_READONLY_MASK                               \
>       (ASPEED_SDMC_HW_VERSION(0xf) | ASPEED_SDMC_CACHE_INITIAL_DONE |     \
>        ASPEED_SDMC_AST2500_RESERVED | ASPEED_SDMC_VGA_COMPAT |            \


