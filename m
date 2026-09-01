Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BD4C624D2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Nfc-0000n8-JA; Tue, 01 Sep 2026 08:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1Nfa-0000eD-9k
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:32:54 -0400
Received: from smtpout3.mo538.mail-out.ovh.net ([51.210.91.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1NfX-0005bt-Fc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:32:54 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hZ4y84bFgz6DQN;
 Tue,  1 Sep 2026 12:32:48 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 12:32:48 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.245])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hZ4y83MRqz46ZM;
 Tue,  1 Sep 2026 12:32:48 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 CFAEF1923FA3; Tue,  1 Sep 2026 12:32:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006dab022e5-d2a6-4d0b-b08c-ebcc6f79ebcd,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <04335738-1d52-42b3-9bbb-2df469ea66b2@kaod.org>
Date: Tue, 1 Sep 2026 14:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] tests/qtest: Add ASPEED SBC ECDSA engine test
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
References: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
 <20260901085238.995968-10-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260901085238.995968-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 14262900022390139949
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGB/IrH+qltSxhDPeYlN52gVqSph5S98N4LeUns9H/1MdUzBV9Q12bHuF6JdWZRAkuqBwCZFQDvEduqtSBQ3asgqasOPkNsGJUA46/0e7/1RJZ11IQHio7oOyC1QPJ33rzBn3B0VbHejcmHeOWQ+CtGFA4KUu4WSzzYx3cA9ABBR0/3B48QfZXc5BJfiM9ezDqlGvIj5rvHBzz4La9WKdb2nli1P1wdktF0/mI50EU3/SamsWZhH3+q3+XAZhDq00pIJItZVNyCjgLa9jSnJwfQAc4bKwdYeOhcW21BeTox381vUQTXNTB/dySc9Fy0o7nawZ6o2cOEL4jJsAZkLYcXbxvOVgVwm6JTOuFiJi7nK4UPaDwA78SSDuY/IXvOite2aiFBscwrmloK19SmwP3Zxfp1mOUZc+JtjRUbBk15ja0oF00qadkQfgZArz+ScWbqkSPnMjXqe1u5ine81nILNIh67L37eYF0k1FENAX9SBC/Kcs/z1PBbp0FNZuyL8tHK5eavLuUArchOyeLz9qGju3H/CeJp1p2rxmTgOJFZnU+TDVY4jqkJ01uN6adLjBIZLvyEqbqin6jK9HniMz4dbGfgNG3n5oWdHqgXu7hkCHpmgAwJa95sKJuRhIvBUFy06EvPpPTIeKzMBLDJ4K/ROcCL+Dz+Zf/h3P0S04CPQ
DKIM-Signature: a=rsa-sha256; bh=MEDXPauvYv/BE68m8LFQ8439/0+3DKiFollnrSmhO+Y=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788265968; v=1;
 b=NRXkHxfRAS00Aal/R2iwFGx3v91mv/f/ayP+dYXZ+3dXEAvFuq5OLm8fhMkhPWEfOsgJjveK
 oTCFPG6tEd8xg78De7U+PhyVRWtCpDfqBj7Pd5PPcEFjEa+g/tIRaIykA1FWXw09inhLA7Qq4GC
 itXsyMuGDHs11H9SzzrzwMp4gqoljk66I5tj7qwFW2Cpw9RkyIqzkkD5zy3JaqSdvg2PdbJdBdt
 sVyLl+AZcfYJGmcBQug4PBd2JTlgyG9mK3ZvCSdneZPJE1Xiigkww7Gi/GKzF3pjEY2CHl5tLxZ
 z1cxcIDtwo0A/P2s46J9PT1mtviaVIeQiLxV7gJs8l4KQ==
Received-SPF: pass client-ip=51.210.91.32; envelope-from=clg@kaod.org;
 helo=smtpout3.mo538.mail-out.ovh.net
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

On 9/1/26 10:52, Jamin Lin wrote:
> Add a qtest for the ASPEED secure boot controller ECDSA engine. It stages
> the public key, signature and SHA-384 digest of a secp384r1 known-answer
> vector (from the Linux kernel crypto self-test manager,
> ecdsa_nist_p384_tv_template) into the SEC SRAM, triggers the engine's
> verify command and checks the status register: a valid signature reports
> done + pass, and a tampered signature reports done without pass.
> 
> The test is skipped when the crypto backend does not support ECDSA, via
> qcrypto_akcipher_supports().
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/qtest/aspeed-sbc-test.c | 194 ++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build       |   2 +
>   2 files changed, 196 insertions(+)
>   create mode 100644 tests/qtest/aspeed-sbc-test.c
> 
> diff --git a/tests/qtest/aspeed-sbc-test.c b/tests/qtest/aspeed-sbc-test.c
> new file mode 100644
> index 0000000000..c445dac47a
> --- /dev/null
> +++ b/tests/qtest/aspeed-sbc-test.c
> @@ -0,0 +1,194 @@
> +/*
> + * QTest testcase for the ASPEED Secure Boot Controller (SBC)
> + *
> + * Copyright (C) 2026 ASPEED Technology Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qemu/bitops.h"
> +#include "crypto/akcipher.h"
> +
> +/* SBC register block */
> +#define SBC_STATUS              0x014
> +#define  SBC_ECDSA_VERIFY_PASS  BIT(21)
> +#define  SBC_ECDSA_VERIFY_DONE  BIT(20)
> +#define SBC_SEC_TRIGGER         0x0bc
> +#define  SBC_ECDSA_CMD_TRIGGER  BIT(1)
> +
> +/*
> + * SEC SRAM operand offsets for a secp384r1 ECDSA verify. Every operand is a
> + * 48-byte big-endian integer.
> + */
> +#define ECDSA_SRAM_QX   0x2080
> +#define ECDSA_SRAM_QY   0x20c0
> +#define ECDSA_SRAM_R    0x21c0
> +#define ECDSA_SRAM_S    0x2200
> +#define ECDSA_SRAM_M    0x2240
> +
> +/*
> + * ECDSA secp384r1 / SHA-384 known-answer vector from the Linux kernel crypto
> + * self-test manager (ecdsa_nist_p384_tv_template, sha384 entry in
> + * crypto/testmgr.h, v6.18), decoded into raw big-endian form: public key
> + * Qx || Qy, signature r || s and the SHA-384 message digest.
> + *
> + *   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/crypto/testmgr.h?h=v6.18
> + */
> +static const uint8_t ecdsa_p384_pubkey[96] = {
> +    /* Qx */
> +    0x3a, 0x2f, 0x62, 0xe7, 0x1a, 0xcf, 0x24, 0xd0,
> +    0x0b, 0x7c, 0xe0, 0xed, 0x46, 0x0a, 0x4f, 0x74,
> +    0x16, 0x43, 0xe9, 0x1a, 0x25, 0x7c, 0x55, 0xff,
> +    0xf0, 0x29, 0x68, 0x66, 0x20, 0x91, 0xf9, 0xdb,
> +    0x2b, 0xf6, 0xb3, 0x6c, 0x54, 0x01, 0xca, 0xc7,
> +    0x6a, 0x5c, 0x0d, 0xeb, 0x68, 0xd9, 0x3c, 0xf1,
> +    /* Qy */
> +    0x01, 0x74, 0x1f, 0xf9, 0x6c, 0xe5, 0x5b, 0x60,
> +    0xe9, 0x7f, 0x5d, 0xb3, 0x12, 0x80, 0x2a, 0xd8,
> +    0x67, 0x92, 0xc9, 0x0e, 0x4c, 0x4c, 0x6b, 0xa1,
> +    0xb2, 0xa8, 0x1e, 0xac, 0x1c, 0x97, 0xd9, 0x21,
> +    0x67, 0xe5, 0x1b, 0x5a, 0x52, 0x31, 0x68, 0xd6,
> +    0xee, 0xf0, 0x19, 0xb0, 0x55, 0xed, 0x89, 0x9e,
> +};
> +
> +static const uint8_t ecdsa_p384_signature[96] = {
> +    /* r */
> +    0x9b, 0x28, 0x68, 0xc0, 0xa1, 0xea, 0x8c, 0x50,
> +    0xee, 0x2e, 0x62, 0x35, 0x46, 0xfa, 0x00, 0xd8,
> +    0x2d, 0x7a, 0x91, 0x5f, 0x49, 0x2d, 0x22, 0x08,
> +    0x29, 0xe6, 0xfb, 0xca, 0x8c, 0xd6, 0xb6, 0xb4,
> +    0x3b, 0x1f, 0x07, 0x8f, 0x15, 0x02, 0xfe, 0x1d,
> +    0xa2, 0xa4, 0xc8, 0xf2, 0xea, 0x9d, 0x11, 0x1f,
> +    /* s */
> +    0xfc, 0x50, 0xf6, 0x43, 0xbd, 0x50, 0x82, 0x0e,
> +    0xbf, 0xe3, 0x75, 0x24, 0x49, 0xac, 0xfb, 0xc8,
> +    0x71, 0xcd, 0x8f, 0x18, 0x99, 0xf0, 0x0f, 0x13,
> +    0x44, 0x92, 0x8c, 0x86, 0x99, 0x65, 0xb3, 0x97,
> +    0x96, 0x17, 0x04, 0xc9, 0x05, 0x77, 0xf1, 0x8e,
> +    0xab, 0x8d, 0x4e, 0xde, 0xe6, 0x6d, 0x9b, 0x66,
> +};
> +
> +static const uint8_t ecdsa_p384_dgst[48] = {
> +    0x8d, 0xf2, 0xc0, 0xe9, 0xa8, 0xf3, 0x8e, 0x44,
> +    0xc4, 0x8c, 0x1a, 0xa0, 0xb8, 0xd7, 0x17, 0xdf,
> +    0xf2, 0x37, 0x1b, 0xc6, 0xe3, 0xf5, 0x62, 0xcc,
> +    0x68, 0xf5, 0xd5, 0x0b, 0xbf, 0x73, 0x2b, 0xb1,
> +    0xb0, 0x4c, 0x04, 0x00, 0x31, 0xab, 0xfe, 0xc8,
> +    0xd6, 0x09, 0xc8, 0xf2, 0xea, 0xd3, 0x28, 0xff,
> +};
> +
> +typedef struct AspeedSBCECDSA {
> +    const char *name;
> +    QCryptoCurveID curve_id;
> +    const uint8_t *pubkey;
> +    const uint8_t *signature;
> +    const uint8_t *dgst;
> +    size_t coord_len;
> +} AspeedSBCECDSA;
> +
> +static const AspeedSBCECDSA sbc_ecdsa_tests[] = {
> +    {
> +        .name = "secp384r1",
> +        .curve_id = QCRYPTO_CURVE_ID_SECP384R1,
> +        .pubkey = ecdsa_p384_pubkey,
> +        .signature = ecdsa_p384_signature,
> +        .dgst = ecdsa_p384_dgst,
> +        .coord_len = 48,
> +    },
> +};
> +
> +typedef struct AspeedSBCTest {
> +    const char *machine;
> +    uint32_t sec_addr;
> +    uint64_t sram_addr;
> +    int index;
> +} AspeedSBCTest;
> +
> +static void sbc_ecdsa_stage(QTestState *qts, const AspeedSBCTest *c,
> +                            const AspeedSBCECDSA *t)
> +{
> +    uint32_t len = t->coord_len;
> +
> +    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_QX, t->pubkey, len);
> +    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_QY, t->pubkey + len, len);
> +    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_R, t->signature, len);
> +    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_S, t->signature + len, len);
> +    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_M, t->dgst, len);
> +}
> +
> +/*
> + * Drive one ECDSA verify through the engine the way the firmware does:
> + * stage the operands in the SEC SRAM, trigger the command register and read
> + * back the done/pass bits in the status register.
> + */
> +static void test_ecdsa_verify(const void *opaque)
> +{
> +    const AspeedSBCTest *c = opaque;
> +    const AspeedSBCECDSA *t = &sbc_ecdsa_tests[c->index];
> +    QCryptoAkCipherOptions opts = {
> +        .alg = QCRYPTO_AK_CIPHER_ALGO_ECDSA,
> +        .u.ecdsa.curve_id = t->curve_id,
> +    };
> +    QTestState *qts;
> +    uint32_t status;
> +    uint8_t bad;
> +
> +    if (!qcrypto_akcipher_supports(&opts)) {
> +        g_test_skip("ECDSA is not supported by the crypto backend");
> +        return;
> +    }
> +
> +    qts = qtest_init(c->machine);
> +
> +    /* A valid signature verifies */
> +    sbc_ecdsa_stage(qts, c, t);
> +    qtest_writel(qts, c->sec_addr + SBC_SEC_TRIGGER, SBC_ECDSA_CMD_TRIGGER);
> +    status = qtest_readl(qts, c->sec_addr + SBC_STATUS);
> +    g_assert_cmphex(status & (SBC_ECDSA_VERIFY_DONE | SBC_ECDSA_VERIFY_PASS),
> +                    ==, SBC_ECDSA_VERIFY_DONE | SBC_ECDSA_VERIFY_PASS);
> +
> +    /* A tampered signature must fail */
> +    bad = t->signature[0] ^ 0xff;
> +    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_R, &bad, 1);
> +    qtest_writel(qts, c->sec_addr + SBC_SEC_TRIGGER, SBC_ECDSA_CMD_TRIGGER);
> +    status = qtest_readl(qts, c->sec_addr + SBC_STATUS);
> +    g_assert_cmphex(status & SBC_ECDSA_VERIFY_DONE, ==, SBC_ECDSA_VERIFY_DONE);
> +    g_assert_cmphex(status & SBC_ECDSA_VERIFY_PASS, ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void aspeed_add_sbc_ecdsa_tests(const char *prefix, const char *machine,
> +                                       uint32_t sec_addr, uint64_t sram_addr)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(sbc_ecdsa_tests); i++) {
> +        g_autofree char *path = NULL;
> +        AspeedSBCTest *t;
> +
> +        path = g_strdup_printf("%s/sbc/ecdsa/%s", prefix,
> +                               sbc_ecdsa_tests[i].name);
> +        t = g_new0(AspeedSBCTest, 1);
> +        t->machine = machine;
> +        t->sec_addr = sec_addr;
> +        t->sram_addr = sram_addr;
> +        t->index = i;
> +        qtest_add_data_func_full(path, t, test_ecdsa_verify, g_free);
> +    }
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    aspeed_add_sbc_ecdsa_tests("ast1030", "-machine ast1030-evb",
> +                               0x7e6f2000, 0x79000000);
> +
> +    aspeed_add_sbc_ecdsa_tests("ast1060", "-machine ast1060-evb",
> +                               0x7e6f2000, 0x79000000);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index c58be94c25..13de12da02 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -223,6 +223,7 @@ qtests_aspeed = \
>     ['aspeed-acry-test',
>      'aspeed_gpio-test',
>      'aspeed_hace-test',
> +   'aspeed-sbc-test',
>      'aspeed_scu-test',
>      'aspeed_smc-test']
>   qtests_aspeed64 = \
> @@ -397,6 +398,7 @@ qtests = {
>                          crypto],
>     'aspeed_hace-test': [files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
>                          crypto],
> +  'aspeed-sbc-test': [files('aspeed-sbc-test.c'), crypto],
>     'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
>     'ast2700-hace-test': [files('aspeed-hace-utils.c', 'ast2700-hace-test.c'),
>                           crypto],

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


