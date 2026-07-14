Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87D4C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjaCX-0001AG-QT; Tue, 14 Jul 2026 06:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wjaCP-00019O-M9
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:17:16 -0400
Received: from smtpout2.mo540.mail-out.ovh.net ([51.210.91.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wjaCK-00073T-6m
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:17:11 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4gzwG06FyDz3wjp;
 Tue, 14 Jul 2026 10:16:56 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 14 Jul 2026 10:16:56 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.145])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gzwFz6TQzz7tCD;
 Tue, 14 Jul 2026 10:16:55 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 13C76203DB1; 
 Tue, 14 Jul 2026 10:16:54 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004cf5c2e29-8935-412d-92c1-544ec81ab5be,
 14669520E5D5974EABF02A897D6C170CD5935BAD) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <b23dc1c5-d2fa-4301-b71d-5e7eec01e98f@kaod.org>
Date: Tue, 14 Jul 2026 12:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] tests/qtest/aspeed-hace: Test the crypto command
 on the AST2600
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
References: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
 <20260714072900.3023742-6-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260714072900.3023742-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 907475326756432941
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFBaJ+InUlBOKxm4xl4uUlfUrT7G4ybz2ltkjxEM/6Jsac93b01VaiB4LdAs7nq/J/vWM44Nn3GTUKaMqnhh3OLJsU7ApPOSBBdLjWj1so6uqhawQxFFVOwgwQsjPT45ajnlosEl683Bpy//NjwiVia3XLFZo8zetjDzD0rH2M2KB0Ect3ziA2d4FfIN07YdQiTx8rdSsqE81oY6WRP7UDO+jJsbKxalmx1SEuy2uMV4zemQQa+DcILkpHpx8kPBGC4wmzwuMwRLsrd3W10UGgp0ieVB9j85EJkUYztwiivsaFmGd0EubnL//MFj5FTh0lgnaQq0e+sgnzWaj4cteCOmhuBfil7YPxRN0I2YwjOuyPTAi5ltaPI7R6nv+dsSCsGIspamAEx51Wd365VukKzQejCJiQRNCE0d47AelwlBGBEOkRXa1DSSmJTcK3c3rpgBeRY8zeY53KL/ehX5FEHg7wY23rZ69oEf9QKZcy91VgxbenDYR0kwSWfy6MAY7gt+mWpmuMykJIPD8gEXcjuMc9AXcHffoZdT+FeIGeWVSXeHkIC52lIWVNY9C+43B772xjN9jHOzwHufqlm9Wa7FHwAXbKL5CrQYwMUs6OJ4axT4OXsaiQjbf+Fmr0SRXb+pxxzYh0i7G0W8kvVMXKBtvCz1+WzqzCG7rXwiZc5Ow
DKIM-Signature: a=rsa-sha256; bh=M8Dzu++CQAlVE0RyZcAY9AxzESp0wBU9kWlZYEPXlmU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784024218; v=1;
 b=KHjR7WtmHHYncfS+60n1gFX/7RUNYyYw9QGmuf2vrVx9ZvNUjwZ1Qv1Jer35GELXbDXFmr6P
 Dt+E0nicKEQogsSdfcU6zooj22dLYE+IDbuk1WbVB8HCaMQag5Loia7YjtlHaxmgDyzODCXAk34
 DiGH+xEPZsJr1raWhbKwnCXdM7cq43Hz4PRkLf+ng3HAd3qUOUHraYtN9YZ6x7Ee/xJd2kaEh07
 VHOcw3w0NXWQ+bOE7s9McJ+TOqklPDuzILGqPVUmKsKLDmITWJednpQ1hjWIehh05KoTtvend6X
 yZ5uf3G8Bynatt+o04tTjkeECZb72dNLGaMcSCdFZDJSw==
Received-SPF: pass client-ip=51.210.91.51; envelope-from=clg@kaod.org;
 helo=smtpout2.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/14/26 09:29, Jamin Lin wrote:
> Extend the crypto known-answer tests to cover the AST2600 crypto engine,
> which drives the source and destination through scatter-gather lists and
> adds CTR mode on top of the ECB/CBC modes shared with the AST2500.
> 
> Add a scatter-gather runner that describes each buffer with three
> non-adjacent fragments to exercise the gather/scatter path, add
> AES/DES/3DES CTR vectors (verifying the counter written back to the
> context buffer), and give aspeed_add_crypto_tests() a mode mask and a
> scatter-gather flag so each SoC registers exactly the modes and transfer
> method it supports. Register the AST2600 with ECB/CBC/CTR in
> scatter-gather mode.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/qtest/aspeed-hace-utils.h |   7 +-
>   tests/qtest/aspeed-hace-utils.c | 211 +++++++++++++++++++++++++++++++-
>   tests/qtest/aspeed_hace-test.c  |   8 +-
>   3 files changed, 218 insertions(+), 8 deletions(-)



On my system, the build use the gnutls crypto backend
(no CONFIG_GCRYPT or CONFIG_NETTLE) and the test fails.

I think a qcrypto_cipher_supports() call is required.

Thanks,

C.

> 
> diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-utils.h
> index 13feaa61e4..82b0b3f93d 100644
> --- a/tests/qtest/aspeed-hace-utils.h
> +++ b/tests/qtest/aspeed-hace-utils.h
> @@ -85,15 +85,18 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
>   enum {
>       CRYPT_MODE_ECB = 1 << 0,
>       CRYPT_MODE_CBC = 1 << 1,
> +    CRYPT_MODE_CTR = 1 << 2,
>   };
>   
>   /*
>    * Register the crypto known-answer tests that @modes selects (a mask of
>    * CRYPT_MODE_*) for the given machine. Each test is named
> - * "<prefix>/hace/crypto/<mode>".
> + * "<prefix>/hace/crypto/<mode>". @sg selects scatter-gather mode (used by the
> + * AST2600 and later) instead of the AST2500 direct access mode.
>    */
>   void aspeed_add_crypto_tests(const char *prefix, const char *machine,
> -                             uint32_t base, uint64_t dram, uint32_t modes);
> +                             uint32_t base, uint64_t dram, uint32_t modes,
> +                             bool sg);
>   
>   #endif /* TESTS_ASPEED_HACE_UTILS_H */
>   
> diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
> index 4deb88dbcc..0b91a4e61a 100644
> --- a/tests/qtest/aspeed-hace-utils.c
> +++ b/tests/qtest/aspeed-hace-utils.c
> @@ -664,6 +664,7 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
>   #define HACE_CMD_OP_MODE_MASK    (0x7 << 4)
>   #define HACE_CMD_ECB             (0x0 << 4)
>   #define HACE_CMD_CBC             (0x1 << 4)
> +#define HACE_CMD_CTR             (0x4 << 4)
>   #define HACE_CMD_AES128          (0x0 << 2)
>   
>   /* Context buffer layout: IV (DES at +8), key at +0x10 */
> @@ -749,6 +750,49 @@ static const uint8_t tdes_cbc_ptext[8] = {
>   static const uint8_t tdes_cbc_ctext[8] = {
>       0x0e, 0x2d, 0xb6, 0x97, 0x3c, 0x56, 0x33, 0xf4 };
>   
> +/* aes_ctr_tv_template[0] (NIST SP800-38A F.5.1), first block */
> +static const uint8_t aes128_ctr_key[16] = {
> +    0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,
> +    0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c };
> +static const uint8_t aes128_ctr_iv[16] = {
> +    0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
> +    0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff };
> +static const uint8_t aes128_ctr_ptext[16] = {
> +    0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96,
> +    0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a };
> +static const uint8_t aes128_ctr_ctext[16] = {
> +    0x87, 0x4d, 0x61, 0x91, 0xb6, 0x20, 0xe3, 0x26,
> +    0x1b, 0xef, 0x68, 0x64, 0x99, 0x0d, 0xb6, 0xce };
> +static const uint8_t aes128_ctr_ivout[16] = {
> +    0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
> +    0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xff, 0x00 };
> +
> +/* des_ctr_tv_template[0] (Crypto++), first block */
> +static const uint8_t des_ctr_key[8] = {
> +    0xc9, 0x83, 0xa6, 0xc9, 0xec, 0x0f, 0x32, 0x55 };
> +static const uint8_t des_ctr_iv[8] = {
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfd };
> +static const uint8_t des_ctr_ptext[8] = {
> +    0x50, 0xb9, 0x22, 0xae, 0x17, 0x80, 0x0c, 0x75 };
> +static const uint8_t des_ctr_ctext[8] = {
> +    0x2f, 0x96, 0x06, 0x0f, 0x50, 0xc9, 0x68, 0x03 };
> +static const uint8_t des_ctr_ivout[8] = {
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe };
> +
> +/* des3_ede_ctr_tv_template[0] (Crypto++), first block */
> +static const uint8_t tdes_ctr_key[24] = {
> +    0x9c, 0xd6, 0xf3, 0x9c, 0xb9, 0x5a, 0x67, 0x00,
> +    0x5a, 0x67, 0x00, 0x2d, 0xce, 0xeb, 0x2d, 0xce,
> +    0xeb, 0xb4, 0x51, 0x72, 0xb4, 0x51, 0x72, 0x1f };
> +static const uint8_t tdes_ctr_iv[8] = {
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
> +static const uint8_t tdes_ctr_ptext[8] = {
> +    0x05, 0xec, 0x77, 0xfb, 0x42, 0xd5, 0x59, 0x20 };
> +static const uint8_t tdes_ctr_ctext[8] = {
> +    0x07, 0xc2, 0x08, 0x20, 0x72, 0x1f, 0x49, 0xef };
> +static const uint8_t tdes_ctr_ivout[8] = {
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
> +
>   typedef struct CryptTest {
>       const uint8_t *ptext;
>       const uint8_t *ctext;
> @@ -826,12 +870,59 @@ static const CryptTest crypt_tests[] = {
>           .ctext = tdes_cbc_ctext,
>           .len = sizeof(tdes_cbc_ptext),
>       },
> +    {
> +        .name = "aes128-ctr",
> +        .cmd = HACE_CMD_AES128 | HACE_CMD_CTR,
> +        .key = aes128_ctr_key,
> +        .keylen = sizeof(aes128_ctr_key),
> +        .iv = aes128_ctr_iv,
> +        .ivlen = sizeof(aes128_ctr_iv),
> +        .ptext = aes128_ctr_ptext,
> +        .ctext = aes128_ctr_ctext,
> +        .iv_out = aes128_ctr_ivout,
> +        .len = sizeof(aes128_ctr_ptext),
> +    },
> +    {
> +        .name = "des-ctr",
> +        .cmd = HACE_CMD_DES_SELECT | HACE_CMD_CTR,
> +        .key = des_ctr_key,
> +        .keylen = sizeof(des_ctr_key),
> +        .iv = des_ctr_iv,
> +        .ivlen = sizeof(des_ctr_iv),
> +        .ptext = des_ctr_ptext,
> +        .ctext = des_ctr_ctext,
> +        .iv_out = des_ctr_ivout,
> +        .len = sizeof(des_ctr_ptext),
> +    },
> +    {
> +        .name = "des3_ede-ctr",
> +        .cmd = HACE_CMD_DES_SELECT | HACE_CMD_TRIPLE_DES | HACE_CMD_CTR,
> +        .key = tdes_ctr_key,
> +        .keylen = sizeof(tdes_ctr_key),
> +        .iv = tdes_ctr_iv,
> +        .ivlen = sizeof(tdes_ctr_iv),
> +        .ptext = tdes_ctr_ptext,
> +        .ctext = tdes_ctr_ctext,
> +        .iv_out = tdes_ctr_ivout,
> +        .len = sizeof(tdes_ctr_ptext),
> +    },
>   };
>   
>   /* DRAM offsets for the crypto test source, destination and context buffers. */
>   #define CRYPT_OFF_SRC   0x10000
>   #define CRYPT_OFF_DST   0x20000
>   #define CRYPT_OFF_CTX   0x30000
> +/* Scatter-gather list offsets (each list has CRYPT_SG_FRAGS entries). */
> +#define CRYPT_OFF_SRC_SG  0x40000
> +#define CRYPT_OFF_DST_SG  0x50000
> +/*
> + * The scatter-gather tests split each buffer into CRYPT_SG_FRAGS fragments,
> + * each placed CRYPT_SG_FRAG_STRIDE apart so the fragments never abut. The gaps
> + * make the test fail if the engine ignores the list and reads one contiguous
> + * block.
> + */
> +#define CRYPT_SG_FRAGS         3
> +#define CRYPT_SG_FRAG_STRIDE   0x1000
>   
>   /* Describes one registered crypto test (qtest_add_data_func() data pointer). */
>   typedef struct AspeedCryptoTest {
> @@ -839,6 +930,7 @@ typedef struct AspeedCryptoTest {
>       uint64_t dram;
>       uint32_t base;
>       int index;
> +    bool sg;
>   } AspeedCryptoTest;
>   
>   /* Map a command's operation mode (HACE10[6:4]) to a CRYPT_MODE_* flag. */
> @@ -849,6 +941,8 @@ static uint32_t crypt_mode_flag(uint32_t cmd)
>           return CRYPT_MODE_ECB;
>       case HACE_CMD_CBC:
>           return CRYPT_MODE_CBC;
> +    case HACE_CMD_CTR:
> +        return CRYPT_MODE_CTR;
>       default:
>           return 0;
>       }
> @@ -897,7 +991,104 @@ static void crypt_run_direct(QTestState *s, uint32_t base, uint64_t dram,
>       qtest_memread(s, dst, out, t->len);
>   }
>   
> -static void aspeed_test_crypto_direct(const void *data)
> +/*
> + * Byte range [*frag_off, *frag_off + *frag_len) of fragment @index when an
> + * @len-byte buffer is split into CRYPT_SG_FRAGS pieces; the last piece takes
> + * the remainder of an uneven split.
> + */
> +static void crypt_frag_range(uint32_t len, int index,
> +                             uint32_t *frag_off, uint32_t *frag_len)
> +{
> +    uint32_t base = len / CRYPT_SG_FRAGS;
> +
> +    *frag_off = base * index;
> +    *frag_len = (index == CRYPT_SG_FRAGS - 1) ? len - *frag_off : base;
> +}
> +
> +/*
> + * Scatter [in, len) across CRYPT_SG_FRAGS buffers based at @base_off and spaced
> + * CRYPT_SG_FRAG_STRIDE apart, then build the SG list describing them at @list.
> + * When @in is NULL only the list is built (used for the destination, which the
> + * engine fills in).
> + */
> +static void crypt_make_sg(QTestState *s, uint64_t dram, uint32_t base_off,
> +                          uint64_t list, const uint8_t *in, uint32_t len)
> +{
> +    struct AspeedSgList sg[CRYPT_SG_FRAGS];
> +    uint32_t frag_off;
> +    uint32_t frag_len;
> +    uint64_t buf;
> +    int i;
> +
> +    for (i = 0; i < CRYPT_SG_FRAGS; i++) {
> +        crypt_frag_range(len, i, &frag_off, &frag_len);
> +        buf = dram + base_off + i * CRYPT_SG_FRAG_STRIDE;
> +
> +        if (in) {
> +            qtest_memwrite(s, buf, in + frag_off, frag_len);
> +        }
> +        sg[i].len = cpu_to_le32(frag_len | (i == CRYPT_SG_FRAGS - 1 ?
> +                                            SG_LIST_LEN_LAST : 0));
> +        sg[i].addr = cpu_to_le32((uint32_t)buf);
> +    }
> +
> +    qtest_memwrite(s, list, sg, sizeof(sg));
> +}
> +
> +/* Gather a scatter-gathered result back from the CRYPT_SG_FRAGS buffers. */
> +static void crypt_gather_sg(QTestState *s, uint64_t dram, uint32_t base_off,
> +                            uint8_t *out, uint32_t len)
> +{
> +    uint32_t frag_off;
> +    uint32_t frag_len;
> +    int i;
> +
> +    for (i = 0; i < CRYPT_SG_FRAGS; i++) {
> +        crypt_frag_range(len, i, &frag_off, &frag_len);
> +        qtest_memread(s, dram + base_off + i * CRYPT_SG_FRAG_STRIDE,
> +                      out + frag_off, frag_len);
> +    }
> +}
> +
> +/*
> + * Run one block-cipher (ECB/CBC/CTR) operation in scatter-gather mode and read
> + * back the result. The source and destination are each split across
> + * CRYPT_SG_FRAGS non-adjacent DRAM buffers described by an SG list; the gaps
> + * ensure the test fails if the engine ignores the list and reads one
> + * contiguous block.
> + */
> +static void crypt_run_sg(QTestState *s, uint32_t base, uint64_t dram,
> +                         const CryptTest *t, bool encrypt, uint8_t *out)
> +{
> +    const uint8_t *in = encrypt ? t->ptext : t->ctext;
> +    uint64_t src_sg = dram + CRYPT_OFF_SRC_SG;
> +    uint64_t dst_sg = dram + CRYPT_OFF_DST_SG;
> +    uint64_t ctx = dram + CRYPT_OFF_CTX;
> +    uint32_t cmd = t->cmd | HACE_CMD_ISR_EN | HACE_CMD_SRC_SG_CTRL |
> +                   HACE_CMD_DST_SG_CTRL;
> +
> +    if (encrypt) {
> +        cmd |= HACE_CMD_ENCRYPT;
> +    }
> +
> +    crypt_write_ctx(s, ctx, t);
> +    crypt_make_sg(s, dram, CRYPT_OFF_SRC, src_sg, in, t->len);
> +    crypt_make_sg(s, dram, CRYPT_OFF_DST, dst_sg, NULL, t->len);
> +
> +    qtest_writel(s, base + HACE_CRYPTO_SRC, (uint32_t)src_sg);
> +    qtest_writel(s, base + HACE_CRYPTO_DEST, (uint32_t)dst_sg);
> +    qtest_writel(s, base + HACE_CRYPTO_CONTEXT, (uint32_t)ctx);
> +    qtest_writel(s, base + HACE_CRYPTO_DATA_LEN, t->len);
> +    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);
> +
> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR, ==,
> +                    HACE_CRYPTO_ISR);
> +    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);
> +
> +    crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);
> +}
> +
> +static void aspeed_test_crypto(const void *data)
>   {
>       const AspeedCryptoTest *c = data;
>       const CryptTest *t = &crypt_tests[c->index];
> @@ -909,7 +1100,11 @@ static void aspeed_test_crypto_direct(const void *data)
>       g_assert_cmpuint(t->len, <=, sizeof(out));
>   
>       /* Encrypt: ptext -> ctext */
> -    crypt_run_direct(s, c->base, c->dram, t, true, out);
> +    if (c->sg) {
> +        crypt_run_sg(s, c->base, c->dram, t, true, out);
> +    } else {
> +        crypt_run_direct(s, c->base, c->dram, t, true, out);
> +    }
>       g_assert_cmpmem(out, t->len, t->ctext, t->len);
>   
>       if (t->iv_out) {
> @@ -919,14 +1114,19 @@ static void aspeed_test_crypto_direct(const void *data)
>       }
>   
>       /* Decrypt: ctext -> ptext */
> -    crypt_run_direct(s, c->base, c->dram, t, false, out);
> +    if (c->sg) {
> +        crypt_run_sg(s, c->base, c->dram, t, false, out);
> +    } else {
> +        crypt_run_direct(s, c->base, c->dram, t, false, out);
> +    }
>       g_assert_cmpmem(out, t->len, t->ptext, t->len);
>   
>       qtest_quit(s);
>   }
>   
>   void aspeed_add_crypto_tests(const char *prefix, const char *machine,
> -                             uint32_t base, uint64_t dram, uint32_t modes)
> +                             uint32_t base, uint64_t dram, uint32_t modes,
> +                             bool sg)
>   {
>       int i;
>   
> @@ -945,7 +1145,8 @@ void aspeed_add_crypto_tests(const char *prefix, const char *machine,
>           t->base = base;
>           t->dram = dram;
>           t->index = i;
> -        qtest_add_data_func_full(path, t, aspeed_test_crypto_direct, g_free);
> +        t->sg = sg;
> +        qtest_add_data_func_full(path, t, aspeed_test_crypto, g_free);
>       }
>   }
>   
> diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-test.c
> index 4cb4c475e9..61a3e3feb5 100644
> --- a/tests/qtest/aspeed_hace-test.c
> +++ b/tests/qtest/aspeed_hace-test.c
> @@ -224,6 +224,12 @@ int main(int argc, char **argv)
>       qtest_add_func("ast2600/hace/sha384_accum", test_sha384_accum_ast2600);
>       qtest_add_func("ast2600/hace/sha256_accum", test_sha256_accum_ast2600);
>   
> +    /* The AST2600 crypto engine uses scatter-gather mode and adds CTR. */
> +    aspeed_add_crypto_tests("ast2600", "-machine ast2600-evb", 0x1e6d0000,
> +                            0x80000000,
> +                            CRYPT_MODE_ECB | CRYPT_MODE_CBC | CRYPT_MODE_CTR,
> +                            true);
> +
>       qtest_add_func("ast2500/hace/addresses", test_addresses_ast2500);
>       qtest_add_func("ast2500/hace/sha512", test_sha512_ast2500);
>       qtest_add_func("ast2500/hace/sha256", test_sha256_ast2500);
> @@ -233,7 +239,7 @@ int main(int argc, char **argv)
>        * The AST2500 crypto engine uses direct access mode and supports ECB/CBC.
>        */
>       aspeed_add_crypto_tests("ast2500", "-machine ast2500-evb", 0x1e6e3000,
> -                            0x80000000, CRYPT_MODE_ECB | CRYPT_MODE_CBC);
> +                            0x80000000, CRYPT_MODE_ECB | CRYPT_MODE_CBC, false);
>   
>       qtest_add_func("ast2400/hace/addresses", test_addresses_ast2400);
>       qtest_add_func("ast2400/hace/sha512", test_sha512_ast2400);


