Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A04E67802
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 15:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Fdy-0008Mw-SK; Sat, 02 Nov 2024 11:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uVOK=R5=kaod.org=clg@ozlabs.org>)
 id 1t7Fdx-0008Md-W5; Sat, 02 Nov 2024 11:02:26 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uVOK=R5=kaod.org=clg@ozlabs.org>)
 id 1t7Fdw-0004Y3-0J; Sat, 02 Nov 2024 11:02:25 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Xggtz1F1pz4x8g;
 Sun,  3 Nov 2024 02:02:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xggtt65g2z4x7H;
 Sun,  3 Nov 2024 02:02:14 +1100 (AEDT)
Message-ID: <1c9a6356-4164-4c44-bea6-5c6a789f4673@kaod.org>
Date: Sat, 2 Nov 2024 16:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 6/8] hw/sd/aspeed_sdhci: Introduce Capabilities
 Register 2 for SD slot 0 and 1
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
 <20241029091729.3317512-7-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241029091729.3317512-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=uVOK=R5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/29/24 10:17, Jamin Lin wrote:
> The size of SDHCI capabilities register is 64bits, so introduces new
> Capabilities Register 2 for SD slot 0 (0x144) and SD slot1 (0x244).
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

I will fix the code alignment issues.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   hw/sd/aspeed_sdhci.c | 40 +++++++++++++++++++++++++++++-----------
>   1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
> index 427e5336a8..b73c18fbff 100644
> --- a/hw/sd/aspeed_sdhci.c
> +++ b/hw/sd/aspeed_sdhci.c
> @@ -24,8 +24,10 @@
>   #define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
>   #define ASPEED_SDHCI_BUS             0x08
>   #define ASPEED_SDHCI_SDIO_140        0x10
> +#define ASPEED_SDHCI_SDIO_144        0x14
>   #define ASPEED_SDHCI_SDIO_148        0x18
>   #define ASPEED_SDHCI_SDIO_240        0x20
> +#define ASPEED_SDHCI_SDIO_244        0x24
>   #define ASPEED_SDHCI_SDIO_248        0x28
>   #define ASPEED_SDHCI_WP_POL          0xec
>   #define ASPEED_SDHCI_CARD_DET        0xf0
> @@ -35,21 +37,27 @@
>   
>   static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
>   {
> -    uint32_t val = 0;
> +    uint64_t val = 0;
>       AspeedSDHCIState *sdhci = opaque;
>   
>       switch (addr) {
>       case ASPEED_SDHCI_SDIO_140:
> -        val = (uint32_t)sdhci->slots[0].capareg;
> +        val = extract64(sdhci->slots[0].capareg, 0, 32);
> +        break;
> +    case ASPEED_SDHCI_SDIO_144:
> +        val = extract64(sdhci->slots[0].capareg, 32, 32);
>           break;
>       case ASPEED_SDHCI_SDIO_148:
> -        val = (uint32_t)sdhci->slots[0].maxcurr;
> +        val = extract64(sdhci->slots[0].maxcurr, 0, 32);
>           break;
>       case ASPEED_SDHCI_SDIO_240:
> -        val = (uint32_t)sdhci->slots[1].capareg;
> +        val = extract64(sdhci->slots[1].capareg, 0, 32);
> +        break;
> +    case ASPEED_SDHCI_SDIO_244:
> +        val = extract64(sdhci->slots[1].capareg, 32, 32);
>           break;
>       case ASPEED_SDHCI_SDIO_248:
> -        val = (uint32_t)sdhci->slots[1].maxcurr;
> +         val = extract64(sdhci->slots[1].maxcurr, 0, 32);
>           break;
>       default:
>           if (addr < ASPEED_SDHCI_REG_SIZE) {
> @@ -61,9 +69,9 @@ static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
>           }
>       }
>   
> -    trace_aspeed_sdhci_read(addr, size, (uint64_t) val);
> +    trace_aspeed_sdhci_read(addr, size, val);
>   
> -    return (uint64_t)val;
> +    return val;
>   }
>   
>   static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
> @@ -79,16 +87,26 @@ static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
>           sdhci->regs[TO_REG(addr)] = (uint32_t)val & ~ASPEED_SDHCI_INFO_RESET;
>           break;
>       case ASPEED_SDHCI_SDIO_140:
> -        sdhci->slots[0].capareg = (uint64_t)(uint32_t)val;
> +    sdhci->slots[0].capareg = deposit64(sdhci->slots[0].capareg, 0, 32, val);
> +    break;
> +    case ASPEED_SDHCI_SDIO_144:
> +    sdhci->slots[0].capareg = deposit64(sdhci->slots[0].capareg, 32, 32, val);
>           break;
>       case ASPEED_SDHCI_SDIO_148:
> -        sdhci->slots[0].maxcurr = (uint64_t)(uint32_t)val;
> +        sdhci->slots[0].maxcurr = deposit64(sdhci->slots[0].maxcurr,
> +                                            0, 32, val);
>           break;
>       case ASPEED_SDHCI_SDIO_240:
> -        sdhci->slots[1].capareg = (uint64_t)(uint32_t)val;
> +        sdhci->slots[1].capareg = deposit64(sdhci->slots[1].capareg,
> +                                            0, 32, val);
> +        break;
> +    case ASPEED_SDHCI_SDIO_244:
> +        sdhci->slots[1].capareg = deposit64(sdhci->slots[1].capareg,
> +                                            32, 32, val);
>           break;
>       case ASPEED_SDHCI_SDIO_248:
> -        sdhci->slots[1].maxcurr = (uint64_t)(uint32_t)val;
> +        sdhci->slots[1].maxcurr = deposit64(sdhci->slots[0].maxcurr,
> +                                            0, 32, val);
>           break;
>       default:
>           if (addr < ASPEED_SDHCI_REG_SIZE) {


