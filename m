Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF41EC01C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cL4-0007bW-NC; Mon, 23 Mar 2026 06:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w4cKl-0007Wn-Af
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:16:34 -0400
Received: from 12.mo534.mail-out.ovh.net ([46.105.38.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w4cKi-0005v2-By
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:16:31 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4ffTbP1LVyz69K2;
 Mon, 23 Mar 2026 10:16:16 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 23 Mar 2026 10:16:16 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.250])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4ffTbN2qNKz5xQn; Mon, 23 Mar 2026 10:16:16 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 860A62403963; Mon, 23 Mar 2026 10:16:15 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00174223439-28c0-4eaa-8764-ced36b6c67ba,
 8B0D7F005F29B12F9D17609CFFF4A06A7A5C7DDA) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2450bd0e-39d8-4cc8-abe5-72dba52e1901@kaod.org>
Date: Mon, 23 Mar 2026 11:16:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/ssi/aspeed_smc: Convert mem ops to
 read/write_with_attrs for error handling
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260322215732.387383-1-clg@redhat.com>
 <20260322215732.387383-2-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260322215732.387383-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 1364590689189473304
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEFrTKFvtQ3B8HUXCppYnrV84LxQRhLhoKe0eG4a+rucYrF2TDfaxcqazTgYNxoydZpbAQSsGKRe/L4/UzXqe08qLQoY2Pdn8x+5CDrOIdq9ef76ErtiLGvsd+hSMvMihHSoBQ1jQ70MpJedw1WvzrsPLtOdcTkwwb3OEQ6syuRZ67EgGBEmmpYut+THyeO0uB3AbSjYq7r2LB6laq765xWo1rg+sj1fKXPkJmveKuBJqT0ehLA1Ni90LwFAmbcC+/1FtXRyuZ+1OjMtLRwHK5vbg00HM2BEjcY8Yh8RuzuqtXYEks/zqKHyatid07xXZNHx+Hs87hyrl/YV9b0WCotEhayu+3D2uulUQBLyJSrlql3N3opPzYHyi+uSE0XYjcJB5QLTRkNoMAAwhhvIW7VuMvvAdUASQDCm1T0lAkDvN/8QW6RNsZ+9pmJ7hJj5dKX1I6bPQaoardhtrVbDASWvf00OUwfPsTqjQh9QK42g8R1JGSIULY8YQG/8fkCVfKjaUP+7Z4gmzXsBw8rSuomyIoO+fHI0UuEIWUNls5y/2kRlILh/e6MrxN8RdUXAxCR2k3V4NJwEJKciN4y0lZQ1KKvZiQxuBMwKYuDkXllTpiUqdaqbiSDmQbvvmiJ28OAoFlKJeeqoQCEIuVbD3N/W4mD8bieyj7DcDkhTm7nRw
DKIM-Signature: a=rsa-sha256; bh=UkQubIDKOTTwQyqttLPPMTrWcQCyh3frSsriPdomQKA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1774260977; v=1;
 b=bQGR0nAxxYX1+5YgcHaJun0xMRojYm2XjMSG0TfJMW25L14+Qf4L5/gIbbGxCS+JsqlVB22d
 dN8z/ZT2hUUJTlyKENKg4tgNq/Wi2SYuAEMc50G35jF5L9fgDGsijG50JQzl0Z9SU59GYA/l1jf
 Rf8cGdWXenDU4MfsXouurAfowlZ4cVT9s6i8e0bYEvJseDd7iM11XeDzwr9VOoHc2P9fRJQFyLb
 TSCJxtHmIkBsyQYLNCWmW3e9k9q+XU+jc/RWWuabe/arC+kf1S0RW8cYJhpKgTf/2AYNrMv6aze
 sbdTID4xy5zsms26ndAcZFM5yNgpOCS/j0auY2diE5aGQ==
Received-SPF: pass client-ip=46.105.38.145; envelope-from=clg@kaod.org;
 helo=12.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/22/26 22:57, Cédric Le Goater wrote:
> Error conditions (invalid flash mode, unwritable flash, invalid data
> FIFO offset) now return MEMTX_ERROR instead of silently succeeding or
> returning undefined values.

The invalid FIFO offset is not upstream yet, only in my aspeed-11.0
branch including :

   https://lore.kernel.org/all/20260224065556.3847942-14-jamin_lin@aspeedtech.com/

I will resend a v2 with the updated patch.

Thanks,

C.

> This allows the memory subsystem to properly propagate transaction
> errors to the guest, improving QEMU reliability.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/ssi/aspeed_smc.c | 58 ++++++++++++++++++++++++++-------------------
>   1 file changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index ed6cedabcb3b..b14b1cbddfc3 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -502,17 +502,18 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
>       }
>   }
>   
> -static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
> +static MemTxResult aspeed_smc_flash_read(void *opaque, hwaddr addr,
> +                                 uint64_t *data, unsigned size, MemTxAttrs attrs)
>   {
>       AspeedSMCFlash *fl = opaque;
>       AspeedSMCState *s = fl->controller;
> -    uint64_t ret = 0;
>       int i;
>   
> +    *data = 0;
>       switch (aspeed_smc_flash_mode(fl)) {
>       case CTRL_USERMODE:
>           for (i = 0; i < size; i++) {
> -            ret |= (uint64_t) ssi_transfer(s->spi, 0x0) << (8 * i);
> +            *data |= (uint64_t) ssi_transfer(s->spi, 0x0) << (8 * i);
>           }
>           break;
>       case CTRL_READMODE:
> @@ -521,18 +522,19 @@ static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
>           aspeed_smc_flash_setup(fl, addr);
>   
>           for (i = 0; i < size; i++) {
> -            ret |= (uint64_t) ssi_transfer(s->spi, 0x0) << (8 * i);
> +            *data |= (uint64_t) ssi_transfer(s->spi, 0x0) << (8 * i);
>           }
>   
>           aspeed_smc_flash_unselect(fl);
>           break;
>       default:
>           aspeed_smc_error("invalid flash mode %d", aspeed_smc_flash_mode(fl));
> +        return MEMTX_ERROR;
>       }
>   
> -    trace_aspeed_smc_flash_read(fl->cs, addr, size, ret,
> +    trace_aspeed_smc_flash_read(fl->cs, addr, size, *data,
>                                   aspeed_smc_flash_mode(fl));
> -    return ret;
> +    return MEMTX_OK;
>   }
>   
>   /*
> @@ -633,8 +635,8 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
>       return false;
>   }
>   
> -static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
> -                                   unsigned size)
> +static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
> +                                   uint64_t data, unsigned size, MemTxAttrs attrs)
>   {
>       AspeedSMCFlash *fl = opaque;
>       AspeedSMCState *s = fl->controller;
> @@ -645,7 +647,7 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
>   
>       if (!aspeed_smc_is_writable(fl)) {
>           aspeed_smc_error("flash is not writable at 0x%" HWADDR_PRIx, addr);
> -        return;
> +        return MEMTX_ERROR;
>       }
>   
>       switch (aspeed_smc_flash_mode(fl)) {
> @@ -670,12 +672,15 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
>           break;
>       default:
>           aspeed_smc_error("invalid flash mode %d", aspeed_smc_flash_mode(fl));
> +        return MEMTX_ERROR;
>       }
> +
> +    return MEMTX_OK;
>   }
>   
>   static const MemoryRegionOps aspeed_smc_flash_ops = {
> -    .read = aspeed_smc_flash_read,
> -    .write = aspeed_smc_flash_write,
> +    .read_with_attrs = aspeed_smc_flash_read,
> +    .write_with_attrs = aspeed_smc_flash_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid = {
>           .min_access_size = 1,
> @@ -763,7 +768,8 @@ static void aspeed_smc_reset(DeviceState *d)
>       s->snoop_dummies = 0;
>   }
>   
> -static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
> +static MemTxResult aspeed_smc_read(void *opaque, hwaddr addr, uint64_t *data,
> +                                   unsigned int size, MemTxAttrs attrs)
>   {
>       AspeedSMCState *s = ASPEED_SMC(opaque);
>       AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(opaque);
> @@ -792,7 +798,7 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
>   
>           trace_aspeed_smc_read(addr << 2, size, s->regs[addr]);
>   
> -        return s->regs[addr];
> +        *data = s->regs[addr];
>       } else if (aspeed_smc_has_data_fifo(asc) && addr >= R_DATA_FIFO) {
>           cs = asc->data_fifo_offset_to_cs(s, addr << 2);
>           if (cs >= 0) {
> @@ -801,15 +807,17 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
>                * The flash address is provided by the SPI command/address cycles,
>                * the MMIO addr parameter is ignored.
>                */
> -            return aspeed_smc_flash_read(&s->flashes[cs], 0, size);
> +            return aspeed_smc_flash_read(&s->flashes[cs], 0, data, size, attrs);
>           }
>           aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr << 2);
> -        return -1;
> +        *data = -1;
> +        return MEMTX_ERROR;
>       } else {
>           qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
>                         __func__, addr);
> -        return -1;
> +        *data = -1;
>       }
> +    return MEMTX_OK;
>   }
>   
>   static uint8_t aspeed_smc_hclk_divisor(uint8_t hclk_mask)
> @@ -1130,8 +1138,8 @@ static void aspeed_2600_smc_dma_ctrl(AspeedSMCState *s, uint32_t dma_ctrl)
>       s->regs[R_DMA_CTRL] &= ~(DMA_CTRL_REQUEST | DMA_CTRL_GRANT);
>   }
>   
> -static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
> -                             unsigned int size)
> +static MemTxResult aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
> +                                    unsigned int size, MemTxAttrs attrs)
>   {
>       AspeedSMCState *s = ASPEED_SMC(opaque);
>       AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
> @@ -1186,19 +1194,21 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
>                * The flash address is provided by the SPI command/address cycles,
>                * the MMIO addr parameter is ignored.
>                */
> -            return aspeed_smc_flash_write(&s->flashes[cs], 0, data, size);
> +            return aspeed_smc_flash_write(&s->flashes[cs], 0, data, size,
> +                                          attrs);
>           }
>           aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr << 2);
> +        return MEMTX_ERROR;
>       } else {
>           qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
>                         __func__, addr);
> -        return;
>       }
> +    return MEMTX_OK;
>   }
>   
>   static const MemoryRegionOps aspeed_smc_ops = {
> -    .read = aspeed_smc_read,
> -    .write = aspeed_smc_write,
> +    .read_with_attrs = aspeed_smc_read,
> +    .write_with_attrs = aspeed_smc_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
> @@ -2073,8 +2083,8 @@ static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] = {
>   };
>   
>   static const MemoryRegionOps aspeed_2700_smc_flash_ops = {
> -    .read = aspeed_smc_flash_read,
> -    .write = aspeed_smc_flash_write,
> +    .read_with_attrs = aspeed_smc_flash_read,
> +    .write_with_attrs = aspeed_smc_flash_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid = {
>           .min_access_size = 1,


