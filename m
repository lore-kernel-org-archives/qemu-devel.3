Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BDCC624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wws-0001YX-UE; Mon, 31 Aug 2026 04:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x0wwr-0001Y7-1X; Mon, 31 Aug 2026 04:00:57 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1x0wwo-00021L-Pl; Mon, 31 Aug 2026 04:00:56 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4hYLyq2nczz66YM;
 Mon, 31 Aug 2026 08:00:51 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 31 Aug 2026 08:00:51 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.214])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYLyq1lwrz1yST; Mon, 31 Aug 2026 08:00:51 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 4929212E3FD4;
 Mon, 31 Aug 2026 08:00:49 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S0063173ee2b-73de-40d1-b78b-276ede811474,
 20713A92955D5A277E4AF24F7FE8A47CC1774BFC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ab66fcc9-adcc-4208-91a5-6e405ef82f05@kaod.org>
Date: Mon, 31 Aug 2026 10:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] hw/misc/aspeed_sbc: Support the ECDSA verify
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
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
 <20260831034153.192916-7-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260831034153.192916-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 3797378912116452397
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEurJxCPxNQlHL3Z7sOji2Ir/A/HWKMp1vQzN1iopglhiM/K+5CcIcaIRW6mRtnAIsMhHph+mb5TB2OzJG/a4+eMU64NaSsc1W7Sgzx+QQB4A+w836mH/C3GxAcMi4VfrxEFE+dRAN0sBkzGJGUnAvVhekxvmW8zpHgWxZb1WE50tvl/+21Ks1P90zoFjlS90KGEmE2+849z8/JkK4uCINujUJA5oGmJUH6U/FjMpkqcWEa5gEsnsuuOTfAP+nHu8o2h7oTjVeRgNe2QIl9308WG0J4i0zQo5VkKQ9SVr8lJXITEF4UsbPSEIL9JLF5aEQj2N0YC563jd9vfNh93Mc2L9z3eDnupsBHBUrqwd3W//8pluvxykwpSA86XIPgFgE94Vwof79fVk/O8lWX1c1+jU0L1PgtbgfS7bwVWtuTSJXtnBzfX3mqwe6YayB0lKXWKR/BZ8F2j3wi7e6jriTsWx1XwV3jX/x6PCgFhj86y4CYI6RH6/GcRoouq4vrIzWFm9Qo3ObcpUdB9OTEG4YU2mG+5bkcFhpswYUJkJvBTtrhUrPu+NsHwBPKuwWoboamVQt9mA8mSzFEf3gE3FDemyblQaYQ+2bInjdep4ttiOKnVdxlpZdV0eqNaeqtmYQadm5egsJfoM8xAC+Rh/ahICAhnSMlAwXZhJvM5OpyyQ
DKIM-Signature: a=rsa-sha256; bh=lcSZvioUrETuIEfXmSb5Y4cpQMTqfEQWp+abnGFqvdY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788163251; v=1;
 b=Zzq03QHcceQWJbw18YO2PhlaK0rKN/KPT26wpTdupeEeJrD1N/72Wbx/dK0xYaxGGiWTTgJ3
 V7gWdo1gjg9QQbiMa+9LrHMp8Ra+8lEDrChLlhJrOJnv8dGDXAKvpVrq6LvaEItrqA4cQlAdogn
 lYb4/BEXRsYn0dhFhr8ppKQ3cXpDdNdavV0mNYVmcaxGPWVb+WpOAO9WG5JWZRBfxKtfiFcUVCQ
 lhS0tWwHeyeZsD1Ll3QcXHW1V0v//YQ3pwdi8Xf/Vrcvbh4Nb+wmB4sgaBoh0Hxg0L6/8AURBB+
 Jxx4+hee2GFfXIHaqS8jw2A/0FIeXDumzOfMkkXQ2zfVw==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/31/26 05:42, Jamin Lin wrote:
> The AST10x0 secure boot controller register block also hosts an ECDSA
> engine. Emulate its secp384r1 "verify" command: on a trigger write to
> the command register, read the public key, signature and SHA-384 digest
> that the firmware staged in the SEC SRAM and defer the verification to the
> crypto akcipher backend, reporting the result through the status
> register.
> 
> The model reads its operands from the SEC SRAM through a dedicated
> address space, using a 'sram' link. The SEC SRAM is mapped at offset 0
> of that address space, so the engine addresses each operand directly
> with its SRAM-relative offset.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_sbc.h |   4 +
>   hw/misc/aspeed_sbc.c         | 152 +++++++++++++++++++++++++++++++++++
>   hw/misc/trace-events         |   2 +
>   3 files changed, 158 insertions(+)
> 
> diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
> index 07c7c22a86..8d3f9207fc 100644
> --- a/include/hw/misc/aspeed_sbc.h
> +++ b/include/hw/misc/aspeed_sbc.h
> @@ -40,12 +40,16 @@ struct AspeedSBCState {
>       uint32_t regs[ASPEED_SBC_NR_REGS];
>   
>       AspeedOTPState otp;
> +
> +    MemoryRegion *sram;
> +    AddressSpace sram_as;
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
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
> index 1dfcf14e5b..aa167be4c0 100644
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
> +#define R_SEC_TRIGGER   (0x0bc / 4)
> +
> +/*
> + * SEC SRAM layout for a secp384r1 ECDSA verify operation. All operands are
> + * 48-byte big-endian values.
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
> @@ -42,6 +58,10 @@
>   #define OTP_MEM_IDLE            BIT(1)
>   #define OTP_COMPARE_STATUS      BIT(0)
>   
> +/* R_SEC_TRIGGER */
> +#define ECDSA_CMD_TRIGGER BIT(1)
> +#define RSA_CMD_TRIGGER   BIT(0)
> +
>   /* QSR */
>   #define QSR_RSA_MASK           (0x3 << 12)
>   #define QSR_HASH_MASK          (0x3 << 10)
> @@ -220,10 +240,111 @@ static void aspeed_sbc_handle_command(void *opaque, uint32_t cmd)
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
> + * The hardware only supports ECDSA secp384r1 (NIST P-384). The firmware has
> + * already staged the public key, signature and digest in the SEC SRAM; read
> + * them out and defer the actual verification to the crypto backend.
> + */
> +static bool aspeed_sbc_ecdsa_verify(AspeedSBCState *s)
> +{
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
> +    if (address_space_read(&s->sram_as, ECDSA_SRAM_QX,
> +                           MEMTXATTRS_UNSPECIFIED, pubkey,
> +                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to read ECDSA QX from SEC SRAM\n", __func__);
> +        return false;
> +    }
> +    if (address_space_read(&s->sram_as, ECDSA_SRAM_QY,
> +                           MEMTXATTRS_UNSPECIFIED,
> +                           pubkey + ECDSA_P384_COORD_LEN,
> +                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to read ECDSA QY from SEC SRAM\n", __func__);
> +        return false;
> +    }
> +    if (address_space_read(&s->sram_as, ECDSA_SRAM_R,
> +                           MEMTXATTRS_UNSPECIFIED, sig,
> +                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to read ECDSA R from SEC SRAM\n", __func__);
> +        return false;
> +    }
> +    if (address_space_read(&s->sram_as, ECDSA_SRAM_S,
> +                           MEMTXATTRS_UNSPECIFIED, sig + ECDSA_P384_COORD_LEN,
> +                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to read ECDSA S from SEC SRAM\n", __func__);
> +        return false;
> +    }
> +    if (address_space_read(&s->sram_as, ECDSA_SRAM_M,
> +                           MEMTXATTRS_UNSPECIFIED, dgst,
> +                           ECDSA_P384_COORD_LEN) != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to read ECDSA M from SEC SRAM\n",
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
> @@ -244,6 +365,26 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
>       case R_CMD:
>           aspeed_sbc_handle_command(opaque, data);
>           return;
> +    case R_SEC_TRIGGER:
> +        if (data & RSA_CMD_TRIGGER) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: RSA is not supported\n", __func__);
> +        }
> +        if (data & ECDSA_CMD_TRIGGER) {
> +            if (!sc->has_ecdsa) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: ECDSA is not supported\n", __func__);
> +                return;
> +            }
> +            s->regs[R_STATUS] &= ~(ECDSA_VERIFY_DONE | ECDSA_VERIFY_PASS);
> +            if (aspeed_sbc_ecdsa_verify(s)) {
> +                s->regs[R_STATUS] |= ECDSA_VERIFY_PASS;
> +            }
> +            s->regs[R_STATUS] |= ECDSA_VERIFY_DONE;
> +            trace_aspeed_sbc_ecdsa_verify(
> +                (s->regs[R_STATUS] & ECDSA_VERIFY_PASS) ? "pass" : "fail");
> +        }
> +        return;
>       default:
>           break;
>       }
> @@ -306,6 +447,14 @@ static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> +    if (sc->has_ecdsa) {
> +        if (!s->sram) {

Bisectability is broken because the link is only set in patch 8.


> +            error_setg(errp, TYPE_ASPEED_SBC ": 'sram' link not set");
> +            return;
> +        }
> +        address_space_init(&s->sram_as, s->sram, TYPE_ASPEED_SBC ".sram");
> +    }
> +
>       memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,
>               TYPE_ASPEED_SBC, 0x1000);
>   
> @@ -325,6 +474,8 @@ static const VMStateDescription vmstate_aspeed_sbc = {
>   static const Property aspeed_sbc_properties[] = {
>       DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),
>       DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_settings, 0),
> +    DEFINE_PROP_LINK("sram", AspeedSBCState, sram,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>   };
>   
>   static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)
> @@ -355,6 +506,7 @@ static void aspeed_ast10x0_sbc_class_init(ObjectClass *klass, const void *data)
>   
>       dc->desc = "AST10X0 Secure Boot Controller";
>       sc->has_otp = true;
> +    sc->has_ecdsa = true;
>   }
>   
>   static const TypeInfo aspeed_sbc_types[] = {
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index bbec0d2178..735d11d447 100644
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


