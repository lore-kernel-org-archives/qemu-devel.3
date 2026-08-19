Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E391C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmVT-0004Dm-RB; Wed, 19 Aug 2026 16:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwmVO-0004Au-Ty
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:03:24 -0400
Received: from smtpout2.mo536.mail-out.ovh.net ([51.210.91.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wwmVK-0003qC-WF
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:03:21 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hQHYv30b4z88xF;
 Wed, 19 Aug 2026 20:03:15 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 19 Aug 2026 20:03:15 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.58])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hQHYv2LF7z1xs5;
 Wed, 19 Aug 2026 20:03:15 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 74806203F3C; 
 Wed, 19 Aug 2026 20:03:13 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005c7d305d7-16f3-466d-aea0-588ace1ad4b0,
 C24CD8B75EED539221ACEA448CE881038350F7ED) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <5cc43599-6134-40ad-bc32-fadfbfaf9e16@kaod.org>
Date: Wed, 19 Aug 2026 22:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/8] hw/misc/aspeed_sbc: Support the ECDSA verify
 command
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
References: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
 <20260818092249.602137-6-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260818092249.602137-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 865535555285855277
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFXAj153dx4LLpy2QoDfRiZP84Bmq65AM6kb8hupGgVR/mr1Sa9jYYOblt90ULPvuRTQfiP5/Df3Mf57ePbDBj0E4gRCenilOI+xMGSNgeYVzIbQyXFEjn4ymzRVOBlC/y7x/Yu3hctVqeH0By1yC8Q9bHDwOGc2ML9KxhUK6pHh06iPCX+1o8i3ssCifizA48iaUBJTNSoLI+SxlACeX7pFpptpJzCOvRKn6RUG4nFf/uJfeWjCJ7d50uIytoATHn+RN3hlgcoA5oPEZr96cSRXgE+aRbaeEzCG+OeaZ2sGm7yQYAdfQCTNhK4SPFly8z8lJCp1k+K+tXqONePTmE8swAqma2I+z24WC5s31+vJEACL4n8DeEBPskCn5OneTkShDZcFpdEUtWULrxCBt1QVHtZWWjwUZPpRG4CjIuskWIJZReaWZK44MVI6NWWbmYH/L/KU9KAyHWMTC/8HRe160Ajp/GI40ReBH9Mh8QEonscELfiv2AK9RPP3vuVRZ7w6eYeos/9/SY4sftko2P/9jvw1M/9iGzd03N5veSfy6jD4uxpctdL22gn5XDXz4+lQ9adfD3zMTt+R6zJWkwKISnahn/jZ8WxU2G+aKUaBpaKXBJueb9a6ad7hw43b0eF2MwC+g70e9bW45GzahPeSUGff6sC3yDzQV0e2aTrhA
DKIM-Signature: a=rsa-sha256; bh=mqmJAVhzlG9UIvogdQJfIopbflEKUi0T8KV0lYiV9Tw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787169795; v=1;
 b=msvlrgrnmP3wzCEdPPTLRUdtdYEwef/5LHyBg18ZiGje+5TBWcDWr9ghP0ZHuuI/stWh7emS
 2ER0YY0DpOUogdgZcUxnRYRdsdltqVAoYPyl3gsSBFOobGKIABA61n9clnrw00w+qRW1ezDEfEK
 4ecdM4yBYjxnFlb2gzorAhiWn887YFHlOUgI65jypBgGrfDVTfnPYFITWU7KIESiuhxuY1yheFv
 dYQG+o2yF58xyESJtKNjTp15XXJJTPhh3U+txTJEfABMpkbGi/WeoC/EY3k8GyyRriEBFy1ZYWY
 TW7Syh7TBkCE560X+H3Tz71+RCUFWTVYL10R8lbezozEw==
Received-SPF: pass client-ip=51.210.91.11; envelope-from=clg@kaod.org;
 helo=smtpout2.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/18/26 11:22, Jamin Lin wrote:
> The AST10x0 secure boot controller register block also hosts an ECDSA
> engine. Emulate its secp384r1 "verify" command: on a trigger write to
> the command register, read the public key, signature and SHA-384 digest
> that the guest staged in the SEC SRAM and defer the verification to the
> crypto akcipher backend, reporting the result through the status
> register.
> 
> The engine reads its operands from the SEC SRAM through a dedicated
> address space over the SoC memory, using a 'sram' link and a 'sram-base'
> property.
> 
> The absolute address is sram_base + the SRAM-relative offset.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/misc/aspeed_sbc.c         | 154 +++++++++++++++++++++++++++++++++++
>   hw/misc/trace-events         |   2 +
>   include/hw/misc/aspeed_sbc.h |   5 ++
>   3 files changed, 161 insertions(+)
> 
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> index 1dfcf14e5b..724f4cb06c 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -10,11 +10,13 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
> +#include "qemu/cutils.h"
>   #include "qemu/error-report.h"
>   #include "hw/core/qdev-properties.h"
>   #include "hw/misc/aspeed_sbc.h"
>   #include "qapi/error.h"
>   #include "migration/vmstate.h"
> +#include "crypto/akcipher.h"
>   #include "trace.h"
>   
>   #define R_PROT          (0x000 / 4)
> @@ -24,8 +26,22 @@
>   #define R_CAMP1         (0x020 / 4)
>   #define R_CAMP2         (0x024 / 4)
>   #define R_QSR           (0x040 / 4)
> +#define R_ECDSA_CMD     (0x0bc / 4)
> +
> +/*
> + * SEC SRAM layout for a secp384r1 ECDSA verify operation. All operands are
> + * 48-byte big-endian integers.
> + */
> +#define ECDSA_SRAM_QX   0x2080
> +#define ECDSA_SRAM_QY   0x20c0
> +#define ECDSA_SRAM_R    0x21c0
> +#define ECDSA_SRAM_S    0x2200
> +#define ECDSA_SRAM_M    0x2240
> +#define ECDSA_P384_COORD_LEN    48
>   
>   /* R_STATUS */
> +#define ECDSA_VERIFY_PASS       BIT(21)
> +#define ECDSA_VERIFY_DONE       BIT(20)
>   #define ABR_EN                  BIT(14) /* Mirrors SCU510[11] */
>   #define ABR_IMAGE_SOURCE        BIT(13)
>   #define SPI_ABR_IMAGE_SOURCE    BIT(12)
> @@ -42,6 +58,9 @@
>   #define OTP_MEM_IDLE            BIT(1)
>   #define OTP_COMPARE_STATUS      BIT(0)
>   
> +/* R_ECDSA_CMD */
> +#define ECDSA_CMD_TRIGGER BIT(1)
> +
>   /* QSR */
>   #define QSR_RSA_MASK           (0x3 << 12)
>   #define QSR_HASH_MASK          (0x3 << 10)
> @@ -220,10 +239,121 @@ static void aspeed_sbc_handle_command(void *opaque, uint32_t cmd)
>       s->regs[R_STATUS] |= (OTP_MEM_IDLE | OTP_IDLE);
>   }
>   
> +static void sbc_ecdsa_hexdump(const char *desc, const char *buf, size_t size)
> +{
> +    g_autoptr(GString) str = g_string_sized_new(64);
> +    size_t len;
> +    size_t i;
> +
> +    for (i = 0; i < size; i += len) {
> +        len = MIN(16, size - i);
> +        g_string_truncate(str, 0);
> +        qemu_hexdump_line(str, buf + i, len, 1, 4);
> +        trace_aspeed_sbc_ecdsa_hexdump(desc, i, str->str);
> +    }
> +}
> +
> +/*
> + * The hardware only supports ECDSA secp384r1 (NIST P-384).
> + * The guest has already staged the public key,
> + * signature and digest in the SEC SRAM; read them out and defer the actual
> + * verification to the crypto backend.
> + *
> + * Returns true if the signature verifies. The caller is responsible for
> + * updating the status register.
> + */
> +static bool aspeed_sbc_ecdsa_verify(AspeedSBCState *s)
> +{
> +    /* Only ECDSA secp384r1 is supported by this engine. */
> +    QCryptoAkCipherOptions opts = {
> +        .alg = QCRYPTO_AK_CIPHER_ALGO_ECDSA,
> +        .u.ecdsa.curve_id = QCRYPTO_CURVE_ID_SECP384R1,
> +    };
> +    g_autoptr(QCryptoAkCipher) akcipher = NULL;
> +    uint8_t pubkey[ECDSA_P384_COORD_LEN * 2];
> +    uint8_t sig[ECDSA_P384_COORD_LEN * 2];
> +    uint8_t dgst[ECDSA_P384_COORD_LEN];
> +    Error *err = NULL;
> +
> +    if (!qcrypto_akcipher_supports(&opts)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: ECDSA secp384r1 is not supported by the crypto "
> +                      "backend\n", __func__);
> +        return false;
> +    }
> +
> +    /*
> +     * ECDSA_SRAM_* are SRAM-relative offsets, but sram_as is an AddressSpace
> +     * over the SoC memory, where the SEC SRAM is mapped at sram_base - so the
> +     * absolute address is sram_base + ECDSA_SRAM_*.
> +     */
> +    if (address_space_read(&s->sram_as, s->sram_base + ECDSA_SRAM_QX,
> +                           MEMTXATTRS_UNSPECIFIED, pubkey,
> +                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to read ECDSA Qx from SEC SRAM\n", __func__);
> +        return false;
> +    }
> +    if (address_space_read(&s->sram_as, s->sram_base + ECDSA_SRAM_QY,
> +                           MEMTXATTRS_UNSPECIFIED,
> +                           pubkey + ECDSA_P384_COORD_LEN,
> +                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to read ECDSA Qy from SEC SRAM\n", __func__);
> +        return false;
> +    }
> +    if (address_space_read(&s->sram_as, s->sram_base + ECDSA_SRAM_R,
> +                           MEMTXATTRS_UNSPECIFIED, sig,
> +                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to read ECDSA r from SEC SRAM\n", __func__);
> +        return false;
> +    }
> +    if (address_space_read(&s->sram_as, s->sram_base + ECDSA_SRAM_S,
> +                           MEMTXATTRS_UNSPECIFIED, sig + ECDSA_P384_COORD_LEN,
> +                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to read ECDSA s from SEC SRAM\n", __func__);
> +        return false;
> +    }
> +    if (address_space_read(&s->sram_as, s->sram_base + ECDSA_SRAM_M,
> +                           MEMTXATTRS_UNSPECIFIED, dgst,
> +                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to read ECDSA digest from SEC SRAM\n",
> +                      __func__);
> +        return false;
> +    }
> +
> +    if (trace_event_get_state_backends(TRACE_ASPEED_SBC_ECDSA_HEXDUMP)) {
> +        sbc_ecdsa_hexdump("pubkey", (char *)pubkey, sizeof(pubkey));
> +        sbc_ecdsa_hexdump("signature", (char *)sig, sizeof(sig));
> +        sbc_ecdsa_hexdump("digest", (char *)dgst, sizeof(dgst));
> +    }
> +
> +    akcipher = qcrypto_akcipher_new(&opts, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
> +                                    pubkey, sizeof(pubkey), &err);
> +    if (!akcipher) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s\n", __func__,
> +                      error_get_pretty(err));
> +        error_free(err);
> +        return false;
> +    }
> +
> +    if (qcrypto_akcipher_verify(akcipher, sig, sizeof(sig),
> +                                dgst, sizeof(dgst), &err) != 0) {
> +        error_free(err);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
>                                 unsigned int size)
>   {
>       AspeedSBCState *s = ASPEED_SBC(opaque);
> +    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(s);
>   
>       addr >>= 2;
>   
> @@ -244,6 +374,18 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
>       case R_CMD:
>           aspeed_sbc_handle_command(opaque, data);
>           return;
> +    case R_ECDSA_CMD:
> +        if (sc->has_ecdsa && data == ECDSA_CMD_TRIGGER) {
> +            s->regs[R_STATUS] &= ~(ECDSA_VERIFY_DONE | ECDSA_VERIFY_PASS);
> +            if (aspeed_sbc_ecdsa_verify(s)) {
> +                s->regs[R_STATUS] |= ECDSA_VERIFY_PASS;
> +            }
> +            s->regs[R_STATUS] |= ECDSA_VERIFY_DONE;
> +            trace_aspeed_sbc_ecdsa_verify(
> +                (s->regs[R_STATUS] & ECDSA_VERIFY_PASS) ? "pass" : "fail");
> +        }
> +        s->regs[addr] = data;
> +        return;
>       default:
>           break;
>       }
> @@ -306,6 +448,14 @@ static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> +    if (sc->has_ecdsa) {
> +        if (!s->sram) {
> +            error_setg(errp, TYPE_ASPEED_SBC ": 'sram' link not set");
> +            return;
> +        }
> +        address_space_init(&s->sram_as, s->sram, TYPE_ASPEED_SBC ".sram");
> +    }
> +
>       memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,
>               TYPE_ASPEED_SBC, 0x1000);
>   
> @@ -325,6 +475,9 @@ static const VMStateDescription vmstate_aspeed_sbc = {
>   static const Property aspeed_sbc_properties[] = {
>       DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),
>       DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
> +    DEFINE_PROP_LINK("sram", AspeedSBCState, sram,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_UINT64("sram-base", AspeedSBCState, sram_base, 0),
>   };
>   
>   static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)
> @@ -355,6 +508,7 @@ static void aspeed_ast10x0_sbc_class_init(ObjectClass *klass, const void *data)
>   
>       dc->desc = "AST10X0 Secure Boot Controller";
>       sc->has_otp = true;
> +    sc->has_ecdsa = true;
>   }
>   
>   static const TypeInfo aspeed_sbc_types[] = {
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c9a868b3ef..1cd2ef8acc 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -95,6 +95,8 @@ aspeed_sbc_ignore_cmd(uint32_t cmd) "Ignoring command 0x%" PRIx32
>   aspeed_sbc_handle_cmd(uint32_t cmd, uint32_t addr, bool ret) "Handling command 0x%" PRIx32 " for OTP addr 0x%" PRIx32 " Result: %d"
>   aspeed_sbc_otp_read(uint32_t addr, uint32_t value) "OTP Memory read: addr 0x%" PRIx32 " value 0x%" PRIx32
>   aspeed_sbc_otp_prog(uint32_t addr, uint32_t value) "OTP Memory write: addr 0x%" PRIx32 " value 0x%" PRIx32
> +aspeed_sbc_ecdsa_verify(const char *result) "ECDSA verify done: %s"
> +aspeed_sbc_ecdsa_hexdump(const char *desc, uint32_t offset, const char *s) "%s: 0x%08x: %s"
>   
>   # aspeed_scu.c
>   aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
> index 07c7c22a86..9b04a10aed 100644
> --- a/include/hw/misc/aspeed_sbc.h
> +++ b/include/hw/misc/aspeed_sbc.h

Please add to your .git/config :

   [diff]
	  orderFile = /path/to/qemu/scripts/git.orderfile



> @@ -40,12 +40,17 @@ struct AspeedSBCState {
>       uint32_t regs[ASPEED_SBC_NR_REGS];
>   
>       AspeedOTPState otp;
> +
> +    MemoryRegion *sram;
> +    AddressSpace sram_as;
> +    uint64_t sram_base;

See comment on

https://lore.kernel.org/qemu-devel/20260813062359.425268-2-jamin_lin@aspeedtech.com/#t

Thanks,

C.


>   };
>   
>   struct AspeedSBCClass {
>       SysBusDeviceClass parent_class;
>   
>       bool has_otp;
> +    bool has_ecdsa;
>   };
>   
>   #endif /* ASPEED_SBC_H */


