Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3A4C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 16:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzeLB-0007FX-Al; Tue, 01 Apr 2025 12:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ooSu=WT=kaod.org=clg@ozlabs.org>)
 id 1tzeKe-0007Ah-Uk; Tue, 01 Apr 2025 12:19:21 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ooSu=WT=kaod.org=clg@ozlabs.org>)
 id 1tzeKb-00068v-Ho; Tue, 01 Apr 2025 12:19:20 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZRtVS25rQz4xD3;
 Wed,  2 Apr 2025 03:19:12 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZRtVM5yb1z4x8W;
 Wed,  2 Apr 2025 03:19:07 +1100 (AEDT)
Message-ID: <df09b1ee-2e49-4a44-96b3-67d4a8634fcc@kaod.org>
Date: Tue, 1 Apr 2025 18:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/22] hw/misc/aspeed_hace: Add support for source,
 digest, key buffer 64 bit addresses
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-8-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250321092623.2097234-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ooSu=WT=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 3/21/25 10:26, Jamin Lin wrote:
> According to the AST2700 design, the data source address is 64-bit, with
> R_HASH_SRC_HI storing bits [63:32] and R_HASH_SRC storing bits [31:0].
> Similarly, the digest address is 64-bit, with R_HASH_DEST_HI storing bits

R_HASH_DIGEST_HIGH would be easier to understand.

> [63:32] and R_HASH_DEST storing bits [31:0]. The HMAC key buffer address is also
> 64-bit, with R_HASH_KEY_BUFF_HI storing bits [63:32] and R_HASH_KEY_BUFF storing
> bits [31:0].
> 
> The AST2700 supports a maximum DRAM size of 8 GB, with a DRAM addressable range
> from 0x0_0000_0000 to 0x1_FFFF_FFFF. Since this range fits within 34 bits, only
> bits [33:0] are needed to store the DRAM offset. To optimize address storage,
> the high physical address bits [1:0] of the source, digest and key buffer
> addresses are stored as dram_offset bits [33:32].
> 
> To achieve this, a src_hi_mask with a mask value of 0x3 is introduced, ensuring
> that src_addr_hi consists of bits [1:0]. The final src_addr is computed as
> (src_addr_hi[1:0] << 32) | src_addr[31:0], representing the DRAM offset within
> bits [33:0].
> 
> Similarly, a dest_hi_mask with a mask value of 0x3 is introduced to ensure that
> dest_addr_hi consists of bits [1:0]. The final dest_addr is calculated as
> (dest_addr_hi[1:0] << 32) | dest_addr[31:0], representing the DRAM offset within
> bits [33:0].
> 
> Additionally, a key_hi_mask with a mask value of 0x3 is introduced to ensure
> that key_buf_addr_hi consists of bits [1:0]. The final key_buf_addr is
> determined as (key_buf_addr_hi[1:0] << 32) | key_buf_addr[31:0], representing
> the DRAM offset within bits [33:0].

What does the datasheet say regarding the High Address registers ?
Are bits [1:0] RW and [31:2] RO ?

  
> This approach eliminates the need to reduce the high part of the DRAM physical
> address for DMA operations. Previously, this was calculated as
> (high physical address bits [7:0] - 4), since the DRAM start address is
> 0x4_00000000, making the high part address [7:0] - 4.

I don't understand this part. Is there a difference between AST2700
A0 and A1  ?

> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_hace.h |  5 ++++-
>   hw/misc/aspeed_hace.c         | 29 +++++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
> index b69a038d35..a4479bd383 100644
> --- a/include/hw/misc/aspeed_hace.h
> +++ b/include/hw/misc/aspeed_hace.h
> @@ -22,7 +22,7 @@
>   
>   OBJECT_DECLARE_TYPE(AspeedHACEState, AspeedHACEClass, ASPEED_HACE)
>   
> -#define ASPEED_HACE_NR_REGS (0x64 >> 2)
> +#define ASPEED_HACE_NR_REGS (0x9C >> 2)

I think we need a class attribute.

>   #define ASPEED_HACE_MAX_SG  256 /* max number of entries */
>   
>   struct AspeedHACEState {
> @@ -49,6 +49,9 @@ struct AspeedHACEClass {
>       uint32_t key_mask;
>       uint32_t hash_mask;
>       bool raise_crypt_interrupt_workaround;
> +    uint32_t src_hi_mask;
> +    uint32_t dest_hi_mask;
> +    uint32_t key_hi_mask;
>   };
>   
>   #endif /* ASPEED_HACE_H */
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
> index d06158dffd..51c6523fab 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -30,6 +30,9 @@
>   #define R_HASH_DEST     (0x24 / 4)
>   #define R_HASH_KEY_BUFF (0x28 / 4)
>   #define R_HASH_SRC_LEN  (0x2c / 4)
> +#define R_HASH_SRC_HI      (0x90 / 4)
> +#define R_HASH_DEST_HI     (0x94 / 4)
> +#define R_HASH_KEY_BUFF_HI (0x98 / 4)
>   
>   #define R_HASH_CMD      (0x30 / 4)
>   /* Hash algorithm selection */
> @@ -393,6 +396,15 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
>               }
>           }
>           break;
> +    case R_HASH_SRC_HI:
> +        data &= ahc->src_hi_mask;
> +        break;
> +    case R_HASH_DEST_HI:
> +        data &= ahc->dest_hi_mask;
> +        break;
> +    case R_HASH_KEY_BUFF_HI:
> +        data &= ahc->key_hi_mask;
> +        break;

This change exposes the high address registers to all SoCs which
is unfortunate.

I would introduce a class attribute to limit the number of registers
per SoC.

You could also size the MMIO aperture with this new attribute and
remove the "Out-of-bounds" message at the beginning of the read/write
memops.

Thanks,

C.



>       default:
>           break;
>       }
> @@ -566,6 +578,23 @@ static void aspeed_ast2700_hace_class_init(ObjectClass *klass, void *data)
>       ahc->key_mask = 0x7FFFFFF8;
>       ahc->hash_mask = 0x00147FFF;
>   
> +    /*
> +     * The AST2700 supports a maximum DRAM size of 8 GB, with a DRAM
> +     * addressable range from 0x0_0000_0000 to 0x1_FFFF_FFFF. Since this range
> +     * fits within 34 bits, only bits [33:0] are needed to store the DRAM
> +     * offset. To optimize address storage, the high physical address bits
> +     * [1:0] of the source, digest and key buffer addresses are stored as
> +     * dram_offset bits [33:32].
> +     *
> +     * This approach eliminates the need to reduce the high part of the DRAM
> +     * physical address for DMA operations. Previously, this was calculated as
> +     * (high physical address bits [7:0] - 4), since the DRAM start address is
> +     * 0x4_00000000, making the high part address [7:0] - 4.
> +     */
> +    ahc->src_hi_mask = 0x00000003;
> +    ahc->dest_hi_mask = 0x00000003;
> +    ahc->key_hi_mask = 0x00000003;
> +
>       /*
>        * Currently, it does not support the CRYPT command. Instead, it only
>        * sends an interrupt to notify the firmware that the crypt command


