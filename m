Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A06AC5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wte4c-0004Me-7g; Tue, 11 Aug 2026 00:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wte4a-0004MS-Uw
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:26:44 -0400
Received: from smtpout4.mo539.mail-out.ovh.net ([51.210.91.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wte4X-0006C8-IW
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:26:44 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hJz8q6xVxz4214;
 Tue, 11 Aug 2026 04:26:35 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 11 Aug 2026 04:26:35 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.244])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hJz8q1nXtz5vMF; Tue, 11 Aug 2026 04:26:35 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 595D3941AE4; 
 Tue, 11 Aug 2026 04:26:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006c7382c94-d076-44db-a7ce-3ab2b8583d88,
 803E6BE66494CDF3CD1430A16CDAFD105E03C239) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <8c33ad0c-940c-4593-839c-fec80936784a@kaod.org>
Date: Tue, 11 Aug 2026 06:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/16] hw/misc/aspeed_hace: Support the AES-GCM mode
 for the crypto command
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
 <20260811031025.2784489-15-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260811031025.2784489-15-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 11852066844876123181
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGRS8X/CTrm7qK0OLq9q9dppHNnxMLPDc3YTwLNhaPNtsTorfmuANTrL0S0crir7x013OebS9OpyPDZRw/LxHIgC3Bn2qInJYplJgCiYUSrxILljGUAxlv6jAAo7SegBQvkvpDeHu/9RXyc9RyC6AtRzux4VTAzlpXDwCWRPHHhMsMFLXYhG/EEE/+E5180iyqGWVazwwwiV7J0OB08BbPRIUu5DoqSWMnTLSSytjdTqX1Pm5nK8MEe29BSAv1c4NgFMTKRmqDfqkQptvgJr2cZaL9YdTamWuZESJ+yItKtGDOuJ5MxoO/Ge4WsLzGE+Ej+S5su+f/lfMo6M84okmhFUazphz5vxbb++mkDEWJLtXzBEs+z0Fddd5+/t6WIEqs7c4OhJvApZWY5G48VEsLeHgmavDViMQiDhXGTaL16IvtM0P6Ae7copXDMzMIbwL8gcjLpVA/+OQLWqPFDUKotQeBlkiUWXsAsNT3aJIvk3JPG1jCr22feIiwzSa0QG2UGxVJUGFJyyM7Ye3rwFQ3TTuRG5zegjTnWo++8EAOwxteanklfrYdpQIZT96f5Xl92OouqNHimI9aQb2QztvCf1poje3x6mfnul1PoQDC5FjqdM4cEnT5z7d7XRcWPdzfZN8dvrq+3N0UUVpG/nRGYcHHxykbinlfcP8TClCv8FA
DKIM-Signature: a=rsa-sha256; bh=kgWc9aNwWhKPiFQgeoy+T4n+qEac09hqjF6fY/4O1Rc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1786422397; v=1;
 b=qhF0GNun9mSW98lbB07h03LWBa1KhiqQpOSGmYilkO+7iPSJjTqTreoZOhPeFQm01RatpXpp
 UXb2Ct56PkPnlHjW6o/aex1wwtqOA6U5dg3mx5MLzXqe0djOgdayiG+Q81EeJuFTjcTyzeIRZx+
 EqrgCtHNpHTeLBO0Qg2BUWKPeXv3kK+MGfHoyatYJwcHXPGWw7hPv18e9eSEXxOsNp/PzayeOIA
 XCk0ZiEaQcj7rcoN54WBQNgpsV/MHtd327GhEW2wG/GtnNi/B9VwOJSKjFmvyDD1bxAV2tJIMCZ
 MNHd6SfnDT0ghN3ilczhQy+MaoWiAbmy5olYczhqVOOWA==
Received-SPF: pass client-ip=51.210.91.43; envelope-from=clg@kaod.org;
 helo=smtpout4.mo539.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/11/26 05:10, Jamin Lin wrote:
> Implement the AES-GCM mode (HACE10[6:4] = 0b101) used by the AST2700
> crypto engine: decode the GCM selection, read the 96-bit IV from the
> context buffer, operate on the exact data length (GCM handles a partial
> final block itself), and write the 128-bit authentication tag to the tag
> buffer (HACE18/HACE8C). The hardware GCM path is only used without
> associated data (the driver falls back to software otherwise), so AAD is
> not modelled and a non-zero HACE14 is reported as unimplemented.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
> ---
>   hw/misc/aspeed_hace.c | 70 ++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 62 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
> index 0a6e2fa829..e455216dd4 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -31,6 +31,9 @@
>   /* HACE0C[27:0] holds the crypto data length */
>   #define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF
>   #define R_CRYPT_CMD         (0x10 / 4)
> +/* AES-GCM associated data length (HACE14) and tag write buffer (HACE18) */
> +#define R_CRYPT_GCM_ADD_LEN (0x14 / 4)
> +#define R_CRYPT_GCM_TAG     (0x18 / 4)
>   /* Crypto engine command register (HACE10) bits */
>   #define  CRYPT_CMD_ENCRYPT          BIT(7)
>   #define  CRYPT_CMD_ISR_EN           BIT(12)
> @@ -42,6 +45,7 @@
>   #define  CRYPT_CMD_ECB              (0x0 << 4)
>   #define  CRYPT_CMD_CBC              (0x1 << 4)
>   #define  CRYPT_CMD_CTR              (0x4 << 4)
> +#define  CRYPT_CMD_GCM              (0x5 << 4)
>   /* AES key length HACE10[3:2] */
>   #define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)
>   #define  CRYPT_CMD_AES256           (0x2 << 2)
> @@ -57,10 +61,15 @@
>   #define CRYPT_CTX_KEY_OFFSET        0x10
>   #define CRYPT_CTX_SIZE              0x30
>   
> +/* AES-GCM uses a 96-bit IV and a 128-bit authentication tag */
> +#define CRYPT_GCM_IV_LEN            12
> +#define CRYPT_GCM_TAG_LEN          16
> +
>   /* AST2700 64-bit DMA high address registers for the crypto command */
>   #define R_CRYPT_SRC_HI      (0x80 / 4)
>   #define R_CRYPT_DEST_HI     (0x84 / 4)
>   #define R_CRYPT_CONTEXT_HI  (0x88 / 4)
> +#define R_CRYPT_GCM_TAG_HI  (0x8c / 4)
>   
>   #define R_STATUS        (0x1c / 4)
>   #define HASH_IRQ        BIT(9)
> @@ -596,6 +605,9 @@ static bool crypt_decode_cmd(uint32_t cmd, QCryptoCipherAlgo *alg,
>       case CRYPT_CMD_CTR:
>           *mode = QCRYPTO_CIPHER_MODE_CTR;
>           break;
> +    case CRYPT_CMD_GCM:
> +        *mode = QCRYPTO_CIPHER_MODE_GCM;
> +        break;
>       default:
>           return false;
>       }
> @@ -689,11 +701,12 @@ static uint64_t crypt_get_addr(AspeedHACEState *s, int reg, int reg_hi)
>   }
>   
>   /*
> - * Perform an AES/DES/3DES ECB/CBC operation. The source and destination are
> - * either single contiguous buffers (direct access mode) or scatter-gather
> - * lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the IV/key come from
> - * the context buffer (HACE08). For CBC the resulting chaining IV is written
> - * back to the context buffer so the driver can continue the chain.
> + * Perform an AES/DES/3DES ECB/CBC/CTR or AES-GCM operation. The source and
> + * destination are either single contiguous buffers (direct access mode) or
> + * scatter-gather lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the
> + * IV/key come from the context buffer (HACE08). For CBC and CTR the resulting
> + * chaining state is written back to the context buffer so the driver can
> + * continue; for GCM the authentication tag is written to the tag buffer.
>    */
>   static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
>   {
> @@ -703,6 +716,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
>       g_autoptr(QCryptoCipher) cipher = NULL;
>       g_autofree uint8_t *src_buf = NULL;
>       g_autofree uint8_t *dst_buf = NULL;
> +    uint8_t tag[CRYPT_GCM_TAG_LEN];
>       uint8_t ctx[CRYPT_CTX_SIZE];
>       Error *local_err = NULL;
>       QCryptoCipherMode mode;
> @@ -711,10 +725,13 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
>       uint64_t ctx_addr;
>       uint64_t src_addr;
>       uint64_t dst_addr;
> +    uint64_t tag_addr;
> +    uint32_t aad_len;
>       size_t iv_offset;
>       size_t blocklen;
>       size_t buf_len;
>       size_t keylen;
> +    size_t ivlen;
>       bool status;
>   
>       if (len == 0) {
> @@ -734,6 +751,20 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
>           return;
>       }
>   
> +    /* GCM uses a 96-bit IV; the block modes use a full-block IV. */
> +    ivlen = (mode == QCRYPTO_CIPHER_MODE_GCM) ? CRYPT_GCM_IV_LEN : blocklen;
> +
> +    /*
> +     * The hardware GCM path is only exercised without associated data (the
> +     * driver falls back to software when there is any), so AAD is not modelled.
> +     */
> +    aad_len = s->regs[R_CRYPT_GCM_ADD_LEN] & CRYPT_DATA_LEN_MASK;

should R_CRYPT_GCM_ADD_LEN be masked at write time like R_CRYPT_DATA_LEN is ?

> +    if (mode == QCRYPTO_CIPHER_MODE_GCM && aad_len != 0) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: GCM associated data is not implemented\n", __func__);
> +        return;
> +    }
> +
>       /* Fetch the IV and key from the context buffer in DRAM. */
>       ctx_addr = crypt_get_addr(s, R_CRYPT_CONTEXT, R_CRYPT_CONTEXT_HI);
>       if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,
> @@ -758,7 +789,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
>       }
>   
>       if (mode != QCRYPTO_CIPHER_MODE_ECB &&
> -        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,
> +        qcrypto_cipher_setiv(cipher, ctx + iv_offset, ivlen,
>                                &local_err) < 0) {
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv failed: %s\n",
>                         __func__, error_get_pretty(local_err));
> @@ -769,9 +800,11 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
>       /*
>        * Round the working buffers up to a whole block. Block modes are already
>        * block-aligned; the stream-like CTR mode may leave a partial final block
> -     * that the engine still processes a full block at a time.
> +     * that the engine still processes a full block at a time. GCM handles a
> +     * partial final block itself, so it operates on the exact length.
>        */
> -    buf_len = QEMU_ALIGN_UP(len, blocklen);
> +    buf_len = (mode == QCRYPTO_CIPHER_MODE_GCM) ?
> +              len : QEMU_ALIGN_UP(len, blocklen);
>       src_buf = g_malloc0(buf_len);
>       dst_buf = g_malloc0(buf_len);
>   
> @@ -855,6 +888,24 @@ static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)
>                             "%s: Failed to write IV, addr=0x%" HWADDR_PRIx "\n",
>                             __func__, ctx_addr + iv_offset);
>           }
> +    } else if (mode == QCRYPTO_CIPHER_MODE_GCM) {
> +        /*
> +         * GCM authenticates the message and writes the resulting tag to the
> +         * dedicated tag buffer (HACE18/HACE8C).
> +         */
> +        if (qcrypto_cipher_gettag(cipher, tag, sizeof(tag), &local_err) < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher gettag failed: "
> +                          "%s\n", __func__, error_get_pretty(local_err));
> +            error_free(local_err);
> +            return;
> +        }
> +        tag_addr = crypt_get_addr(s, R_CRYPT_GCM_TAG, R_CRYPT_GCM_TAG_HI);
> +        if (address_space_write(&s->dram_as, tag_addr, MEMTXATTRS_UNSPECIFIED,
> +                                tag, sizeof(tag))) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Failed to write tag, addr=0x%" HWADDR_PRIx "\n",
> +                          __func__, tag_addr);
> +        }
>       }
>   }
>   
> @@ -985,6 +1036,9 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
>       case R_CRYPT_CONTEXT_HI:
>           data &= ahc->key_hi_mask;
>           break;

R_CRYPT_GCM_TAG writes are not masked like the other registers :

     case R_CRYPT_SRC:
     case R_CRYPT_DEST:
     case R_CRYPT_CONTEXT:
         data &= ahc->src_mask;
         break;

Thanks,

C.


> +    case R_CRYPT_GCM_TAG_HI:
> +        data &= ahc->dest_hi_mask;
> +        break;
>       default:
>           break;
>       }


