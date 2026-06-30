Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7FAC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZjr-0005yA-Qk; Tue, 30 Jun 2026 10:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1weZjp-0005xl-RT
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:47:01 -0400
Received: from smtpout7.mo538.mail-out.ovh.net ([51.210.91.36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1weZjn-0006gh-QK
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:47:01 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4gqQw15RVhz5x9Z;
 Tue, 30 Jun 2026 14:46:57 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Tue, 30 Jun 2026 14:46:57 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.67])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gqQw143msz5vMf; Tue, 30 Jun 2026 14:46:57 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 1FC642403D11; Tue, 30 Jun 2026 14:46:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0025807b073-d847-4323-ad22-fd12fd4f6b59,
 C9F07EB534A46111D337A1875201B4A1724CF27E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <0964b84f-0f60-4909-9c60-ad715227a6ed@kaod.org>
Date: Tue, 30 Jun 2026 16:46:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] Revert "aspeed/smc: snoop SPI transfers to fake
 dummy cycles"
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
References: <20260630135729.466264-1-bin.meng@processmission.com>
 <20260630135729.466264-10-bin.meng@processmission.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260630135729.466264-10-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 15483656996531186902
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGgDKSxq8nrtCdtp3KJ3JdAucwsroXHWwkX8RobovTQuBBkUPE1X/a959BYlM2N202h45nX0D6TP8QYmKmRhPIASCeWvwpYyjsy9Z4Iib7MxjMEsgwYxFY0T2+RZJoctqKsqbBSq0zjjqS0+bzhg/VIOp4PVSTPKsjOoadGEi7sUSw3ppupZrfkLqhyAIQzNmaF9w4dnMZedCO8tv8POrrTUGnEwBma4LC4/q5/2HJojvBfoAtErm9+3gc72ldPOCj5Kxq8z4SIOtDAx+dDsJ51cHCC85hTCG7jFkHDUO7Ps2ZH83BNLbxNPU65RHX8FZHvEsIGUGCI+gMxr3vBi6vFTm7cEiT+YVFBEvQ3ML0IVqNusFCES1IEuuF/Y6y8OnckKgqBWkLHDuHLx9qe7cRTk+SYuKmOEysveTN6zKVEKIoH7FlwcWsZQYjPspJj/VXSE+0xeXT0iwNAZIeAMOtaBt2mhCtJfwHGSFAqRJwtYR26i3CiR82qbYfZEiAXZacOdtxUHcKPDL8UNw39ZsitU2kRNBK6JXFT+aZN3AAomXbXl93aJbArIuY1NBhKz7vKaZPCA4xMExQH2ypAzkTk9yBVV8rj1nJWQHGsjmYHUd5njwzgA7XNjOwXW/vHyUSxvY5T/+stuMO+OmKLqbA6TOrpRCRJea7Yy4Sw72MUWA
DKIM-Signature: a=rsa-sha256; bh=gSa3E6CuWV95gDaxb2Jjzne5uTE5iKaN7+MWEpSVpjo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1782830817; v=1;
 b=ATFn7S0lM03S2VpKO03BDhMy7YFvLfZZcBMa0Bpzsz5sypX/fmOm4FzHDHDSIMi5GD8QWPTY
 W32fMN9CUYwU1VzWEj/8Zc5vAF7kOUP2GFIme4IVA3r+UWMMX58pDnaBvsRjoQowR+qNVw9+oni
 ss+UYNqP5VbzO4UUGjohGS3kYgEToxMFJ5IoVPK5Wre8H2DiYKv0IzeKKspd8YL2P9fQd/0q2oC
 KbfF0PcXF6EtWnVsmcvSk0fm0nSdTuozOZe6680Vo6L4QDBdcN6HTMdvsgFUJJtP+cP2lh/CNcQ
 gpX5OrRdOANEO9jhUaLQ1jPpZaOn15DPCTX1MBY8Vzpjg==
Received-SPF: pass client-ip=51.210.91.36; envelope-from=clg@kaod.org;
 helo=smtpout7.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/30/26 15:57, Bin Meng wrote:
> This reverts commit f95c4bffdc4c53b29f89762cab4adc5a43f95daf.
> 
> The m25p80 model now accounts for fast-read dummy bytes in its
> command decoder. In ASPEED SMC model user mode, guest software
> already sends the complete byte stream, including any dummy
> bytes needed by the flash. Hence the model should just forward
> exactly the bytes supplied by the guest without the need of
> decoding guest-supplied flash op codes to inject extra dummy
> transfers.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   include/hw/ssi/aspeed_smc.h |   2 -
>   hw/ssi/aspeed_smc.c         | 114 +-----------------------------------
>   hw/ssi/trace-events         |   1 -
>   3 files changed, 2 insertions(+), 115 deletions(-)
> 
> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
> index 76831422c6..a273365689 100644
> --- a/include/hw/ssi/aspeed_smc.h
> +++ b/include/hw/ssi/aspeed_smc.h
> @@ -80,8 +80,6 @@ struct AspeedSMCState {
>   
>       AspeedSMCFlash flashes[ASPEED_SMC_CS_MAX];
>   
> -    uint8_t snoop_index;
> -    uint8_t snoop_dummies;
>       bool unselect;
>   };
>   
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index c2a732664b..287a46eef3 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -197,9 +197,6 @@
>   /* Flash opcodes. */
>   #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
>   
> -#define SNOOP_OFF         0xFF
> -#define SNOOP_START       0x0
> -
>   /*
>    * Default segments mapping addresses and size for each peripheral per
>    * controller. These can be changed when board is initialized with the
> @@ -537,104 +534,6 @@ static MemTxResult aspeed_smc_flash_read(void *opaque, hwaddr addr,
>       return MEMTX_OK;
>   }
>   
> -/*
> - * TODO (clg@kaod.org): stolen from xilinx_spips.c. Should move to a
> - * common include header.
> - */
> -typedef enum {
> -    READ = 0x3,         READ_4 = 0x13,
> -    FAST_READ = 0xb,    FAST_READ_4 = 0x0c,
> -    DOR = 0x3b,         DOR_4 = 0x3c,
> -    QOR = 0x6b,         QOR_4 = 0x6c,
> -    DIOR = 0xbb,        DIOR_4 = 0xbc,
> -    QIOR = 0xeb,        QIOR_4 = 0xec,
> -
> -    PP = 0x2,           PP_4 = 0x12,
> -    DPP = 0xa2,
> -    QPP = 0x32,         QPP_4 = 0x34,
> -} FlashCMD;
> -
> -static int aspeed_smc_num_dummies(uint8_t command)
> -{
> -    switch (command) { /* check for dummies */
> -    case READ: /* no dummy bytes/cycles */
> -    case PP:
> -    case DPP:
> -    case QPP:
> -    case READ_4:
> -    case PP_4:
> -    case QPP_4:
> -        return 0;
> -    case FAST_READ:
> -    case DOR:
> -    case QOR:
> -    case DOR_4:
> -    case QOR_4:
> -        return 1;
> -    case DIOR:
> -    case FAST_READ_4:
> -    case DIOR_4:
> -        return 2;
> -    case QIOR:
> -    case QIOR_4:
> -        return 4;
> -    default:
> -        return -1;
> -    }
> -}
> -
> -static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
> -                                unsigned size)
> -{
> -    AspeedSMCState *s = fl->controller;
> -    uint8_t addr_width = aspeed_smc_flash_addr_width(fl);
> -
> -    trace_aspeed_smc_do_snoop(fl->cs, s->snoop_index, s->snoop_dummies,
> -                              (uint8_t) data & 0xff);
> -
> -    if (s->snoop_index == SNOOP_OFF) {
> -        return false; /* Do nothing */
> -
> -    } else if (s->snoop_index == SNOOP_START) {
> -        uint8_t cmd = data & 0xff;
> -        int ndummies = aspeed_smc_num_dummies(cmd);
> -
> -        /*
> -         * No dummy cycles are expected with the current command. Turn
> -         * off snooping and let the transfer proceed normally.
> -         */
> -        if (ndummies <= 0) {
> -            s->snoop_index = SNOOP_OFF;
> -            return false;
> -        }
> -
> -        s->snoop_dummies = ndummies * 8;
> -
> -    } else if (s->snoop_index >= addr_width + 1) {
> -
> -        /* The SPI transfer has reached the dummy cycles sequence */
> -        for (; s->snoop_dummies; s->snoop_dummies--) {
> -            ssi_transfer(s->spi, s->regs[R_DUMMY_DATA] & 0xff);
> -        }
> -
> -        /* If no more dummy cycles are expected, turn off snooping */
> -        if (!s->snoop_dummies) {
> -            s->snoop_index = SNOOP_OFF;
> -        } else {
> -            s->snoop_index += size;
> -        }
> -
> -        /*
> -         * Dummy cycles have been faked already. Ignore the current
> -         * SPI transfer
> -         */
> -        return true;
> -    }
> -
> -    s->snoop_index += size;
> -    return false;
> -}
> -
>   static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
>                                      uint64_t data, unsigned size, MemTxAttrs attrs)
>   {
> @@ -652,10 +551,6 @@ static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
>   
>       switch (aspeed_smc_flash_mode(fl)) {
>       case CTRL_USERMODE:
> -        if (aspeed_smc_do_snoop(fl, data, size)) {
> -            break;
> -        }
> -
>           for (i = 0; i < size; i++) {
>               ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
>           }
> @@ -717,7 +612,6 @@ static void aspeed_smc_flash_update_ctrl(AspeedSMCFlash *fl, uint32_t value)
>       s->regs[s->r_ctrl0 + fl->cs] = value;
>   
>       if (unselect != s->unselect) {
> -        s->snoop_index = unselect ? SNOOP_OFF : SNOOP_START;
>           aspeed_smc_flash_do_select(fl, unselect);
>       }
>   }
> @@ -763,9 +657,6 @@ static void aspeed_smc_reset_hold(Object *obj, ResetType type)
>           aspeed_smc_flash_set_segment_region(s, i,
>                       asc->segment_to_reg(s, &asc->segments[i]));
>       }
> -
> -    s->snoop_index = SNOOP_OFF;
> -    s->snoop_dummies = 0;
>   }
>   
>   static MemTxResult aspeed_smc_read(void *opaque, hwaddr addr, uint64_t *data,
> @@ -1293,11 +1184,10 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>   static const VMStateDescription vmstate_aspeed_smc = {
>       .name = "aspeed.smc",
>       .version_id = 3,
> -    .minimum_version_id = 2,
> +    .minimum_version_id = 1,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
> -        VMSTATE_UINT8(snoop_index, AspeedSMCState),
> -        VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
> +        VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */
>           VMSTATE_BOOL_V(unselect, AspeedSMCState, 3),
>           VMSTATE_END_OF_LIST()
>       }
> diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
> index 2f36cf96b8..b9d8648297 100644
> --- a/hw/ssi/trace-events
> +++ b/hw/ssi/trace-events
> @@ -2,7 +2,6 @@
>   
>   aspeed_smc_flash_set_segment(int cs, uint64_t reg, uint64_t start, uint64_t end) "CS%d segreg=0x%"PRIx64" [ 0x%"PRIx64" - 0x%"PRIx64" ]"
>   aspeed_smc_flash_read(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
> -aspeed_smc_do_snoop(int cs, int index, int dummies, int data) "CS%d index:0x%x dummies:%d data:0x%x"
>   aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
>   aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
>   aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



