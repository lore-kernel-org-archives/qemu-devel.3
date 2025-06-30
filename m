Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA291C83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 06:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW89m-0001eQ-O6; Mon, 30 Jun 2025 02:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bKmi=ZN=kaod.org=clg@ozlabs.org>)
 id 1uW89d-0001ds-CZ; Mon, 30 Jun 2025 02:38:13 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bKmi=ZN=kaod.org=clg@ozlabs.org>)
 id 1uW89Y-0007vj-V8; Mon, 30 Jun 2025 02:38:11 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bVxLM1xnvz4xPY;
 Mon, 30 Jun 2025 16:38:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bVxLD6TBJz4w2J;
 Mon, 30 Jun 2025 16:37:56 +1000 (AEST)
Message-ID: <54aa55bf-376b-4eda-8a78-b6d20e1cf8aa@kaod.org>
Date: Mon, 30 Jun 2025 08:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Add test for ASPEED SCU
To: Tan Siewert <tan@siewert.io>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250629135405.73117-1-tan@siewert.io>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250629135405.73117-1-tan@siewert.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=bKmi=ZN=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Tan,

On 6/29/25 15:54, Tan Siewert wrote:
> This adds basic tests for the ASPEED System Control Unit (SCU) and its
> protection mechanism on the AST2500 and AST2600 platforms.
> 
> The tests verify:
>    - That SCU protection registers can be unlocked and locked again
>    - That modifying the primary protection register on AST2600 also
>      affects the secondary one
>    - That writes to protected SCU registers are blocked unless
>      protection registers are unlocked explicitly
> 
> These tests ensure proper emulation of hardware locking behaviour
> and help catch regressions in SCU access logic.
> 
> Signed-off-by: Tan Siewert <tan@siewert.io>
> ---
>   tests/qtest/aspeed-scu-utils.c |  22 ++++
>   tests/qtest/aspeed-scu-utils.h |  38 +++++++

I think adding these two files is a bit over engineered. Could resend a
v2 without them ? Unless you have plans to extend them with AST2700
support for example ?


Thanks,

C.



>   tests/qtest/aspeed_scu-test.c  | 197 +++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build        |   4 +-
>   4 files changed, 260 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/aspeed-scu-utils.c
>   create mode 100644 tests/qtest/aspeed-scu-utils.h
>   create mode 100644 tests/qtest/aspeed_scu-test.c
> 
> diff --git a/tests/qtest/aspeed-scu-utils.c b/tests/qtest/aspeed-scu-utils.c
> new file mode 100644
> index 0000000000..9083827b98
> --- /dev/null
> +++ b/tests/qtest/aspeed-scu-utils.c
> @@ -0,0 +1,22 @@
> +/*
> + * QTest testcase for the ASPEED AST2500 and AST2600 SCU.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2025 Tan Siewert
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +#include "aspeed-scu-utils.h"
> +
> +void assert_register_eq(QTestState *s, uint32_t reg, uint32_t expected)
> +{
> +    uint32_t value = qtest_readl(s, reg);
> +    g_assert_cmphex(value, ==, expected);
> +}
> +
> +void assert_register_neq(QTestState *s, uint32_t reg, uint32_t not_expected)
> +{
> +    uint32_t value = qtest_readl(s, reg);
> +    g_assert_cmphex(value, !=, not_expected);
> +}
> diff --git a/tests/qtest/aspeed-scu-utils.h b/tests/qtest/aspeed-scu-utils.h
> new file mode 100644
> index 0000000000..9cc7e3e113
> --- /dev/null
> +++ b/tests/qtest/aspeed-scu-utils.h
> @@ -0,0 +1,38 @@
> +/*
> + * QTest testcase for the ASPEED AST2500 and AST2600 SCU.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2025 Tan Siewert
> + */
> +
> +#ifndef TESTS_ASPEED_SCU_UTILS_H
> +#define TESTS_ASPEED_SCU_UTILS_H
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +
> +/**
> + * Assert that a given register matches an expected value.
> + *
> + * Reads the register and checks if its value equals the expected value,
> + * without requiring a temporary variable in the caller.
> + *
> + * @param *s - QTest machine state
> + * @param reg - Address of the register to be checked
> + * @param expected - Expected register value
> + */
> +void assert_register_eq(QTestState *s, uint32_t reg, uint32_t expected);
> +
> +/**
> + * Assert that a given register does not match a specific value.
> + *
> + * Reads the register and checks that its value is not equal to the
> + * provided value.
> + *
> + * @param *s - QTest machine state
> + * @param reg - Address of the register to be checked
> + * @param not_expected - Value the register must not contain
> + */
> +void assert_register_neq(QTestState *s, uint32_t reg, uint32_t not_expected);
> +
> +#endif /* TESTS_ASPEED_SCU_UTILS_H */
> diff --git a/tests/qtest/aspeed_scu-test.c b/tests/qtest/aspeed_scu-test.c
> new file mode 100644
> index 0000000000..75d6a800a6
> --- /dev/null
> +++ b/tests/qtest/aspeed_scu-test.c
> @@ -0,0 +1,197 @@
> +/*
> + * QTest testcase for the ASPEED AST2500 and AST2600 SCU.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2025 Tan Siewert
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +#include "aspeed-scu-utils.h"
> +
> +/*
> + * SCU base, as well as protection key are
> + * the same on AST2500 and 2600.
> + */
> +#define AST_SCU_BASE                    0x1E6E2000
> +#define AST_SCU_PROT_LOCK_STATE         0x0
> +#define AST_SCU_PROT_LOCK_VALUE         0x2
> +#define AST_SCU_PROT_UNLOCK_STATE       0x1
> +#define AST_SCU_PROT_UNLOCK_VALUE       0x1688A8A8
> +
> +#define AST2500_MACHINE                 "-machine ast2500-evb"
> +#define AST2500_SCU_PROT_REG            0x00
> +#define AST2500_SCU_MISC_2_CONTROL_REG  0x4C
> +
> +#define AST2600_MACHINE                 "-machine ast2600-evb"
> +/* AST2600 has two protection registers */
> +#define AST2600_SCU_PROT_REG            0x000
> +#define AST2600_SCU_PROT_REG2           0x010
> +#define AST2600_SCU_MISC_2_CONTROL_REG  0x0C4
> +
> +#define TEST_LOCK_ARBITRARY_VALUE       0xABCDEFAB
> +
> +/**
> + * Test whether the SCU can be locked and unlocked correctly.
> + *
> + * When testing multiple registers, this function assumes that writing
> + * to the first register also affects the others. However, writing to
> + * any other register only affects itself.
> + *
> + * @param *machine - input machine configuration, passed directly
> + *                   to QTest
> + * @param regs[] - List of registers to be checked
> + * @param regc - amount of arguments for registers to be checked
> + */
> +static void test_protection_register(const char *machine,
> +                                     const uint32_t regs[],
> +                                     const int regc)
> +{
> +    QTestState *s = qtest_init(machine);
> +
> +    for (int i = 0; i < regc; i++) {
> +        uint32_t reg = regs[i];
> +
> +        qtest_writel(s, reg, AST_SCU_PROT_UNLOCK_VALUE);
> +        assert_register_eq(s, reg, AST_SCU_PROT_UNLOCK_STATE);
> +
> +        /**
> +         * Check that other registers are unlocked too, if more
> +         * than one is available.
> +         */
> +        if (regc > 1 && i == 0) {
> +            /* Initialise at 1 instead of 0 to skip first */
> +            for (int j = 1; j < regc; j++) {
> +                uint32_t add_reg = regs[j];
> +                assert_register_eq(s, add_reg, AST_SCU_PROT_UNLOCK_STATE);
> +            }
> +        }
> +
> +        /* Lock the register again */
> +        qtest_writel(s, reg, AST_SCU_PROT_LOCK_VALUE);
> +        assert_register_eq(s, reg, AST_SCU_PROT_LOCK_STATE);
> +
> +        /* And the same for locked state */
> +        if (regc > 1 && i == 0) {
> +            /* Initialise at 1 instead of 0 to skip first */
> +            for (int j = 1; j < regc; j++) {
> +                uint32_t add_reg = regs[j];
> +                assert_register_eq(s, add_reg, AST_SCU_PROT_LOCK_STATE);
> +            }
> +        }
> +    }
> +
> +    qtest_quit(s);
> +}
> +
> +static void test_2500_protection_register(void)
> +{
> +    uint32_t regs[] = { AST_SCU_BASE + AST2500_SCU_PROT_REG };
> +
> +    test_protection_register(AST2500_MACHINE,
> +                             regs,
> +                             ARRAY_SIZE(regs));
> +}
> +
> +static void test_2600_protection_register(void)
> +{
> +    /**
> +     * The AST2600 has two protection registers, both
> +     * being required to be unlocked to do any operation.
> +     *
> +     * Modifying SCU000 also modifies SCU010, but modifying
> +     * SCU010 only will keep SCU000 untouched.
> +     */
> +    uint32_t regs[] = { AST_SCU_BASE + AST2600_SCU_PROT_REG,
> +                        AST_SCU_BASE + AST2600_SCU_PROT_REG2 };
> +
> +    test_protection_register(AST2600_MACHINE,
> +                             regs,
> +                             ARRAY_SIZE(regs));
> +}
> +
> +/**
> + * Test if SCU register writes are correctly allowed or blocked
> + * depending on the protection register state.
> + *
> + * The test first locks the protection register and verifies that
> + * writes to the target SCU register are rejected. It then unlocks
> + * the protection register and confirms that the written value is
> + * retained when unlocked.
> + *
> + * @param *machine - input machine configuration, passed directly
> + *                   to QTest
> + * @param protection_register - first SCU protection key register
> + *                              (only one for keeping it simple)
> + * @param test_register - Register to be used for writing arbitrary
> + *                        values
> + */
> +static void test_write_permission_lock_state(const char *machine,
> +                                             const uint32_t protection_register,
> +                                             const uint32_t test_register)
> +{
> +    QTestState *s = qtest_init(machine);
> +
> +    /* Arbitrary value to lock provided SCU protection register */
> +    qtest_writel(s, protection_register, AST_SCU_PROT_LOCK_VALUE);
> +
> +    /* Ensure that the SCU is really locked */
> +    assert_register_eq(s, protection_register, AST_SCU_PROT_LOCK_STATE);
> +
> +    /* Write a known arbitrary value to test that the write is blocked */
> +    qtest_writel(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
> +
> +    /* We do not want to have the written value to be saved */
> +    assert_register_neq(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
> +
> +    /**
> +     * Unlock the SCU and verify that it can be written to.
> +     * Assumes that the first SCU protection register is sufficient to
> +     * unlock all protection registers, if multiple are present.
> +     */
> +    qtest_writel(s, protection_register, AST_SCU_PROT_UNLOCK_VALUE);
> +    assert_register_eq(s, protection_register, AST_SCU_PROT_UNLOCK_STATE);
> +
> +    /* Write a known arbitrary value to test that the write works */
> +    qtest_writel(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
> +
> +    /* Ensure that the written value is retained */
> +    assert_register_eq(s, test_register, TEST_LOCK_ARBITRARY_VALUE);
> +
> +    qtest_quit(s);
> +}
> +
> +static void test_2500_write_permission_lock_state(void)
> +{
> +    test_write_permission_lock_state(
> +            AST2500_MACHINE,
> +            AST_SCU_BASE + AST2500_SCU_PROT_REG,
> +            AST_SCU_BASE + AST2500_SCU_MISC_2_CONTROL_REG
> +    );
> +}
> +
> +static void test_2600_write_permission_lock_state(void)
> +{
> +    test_write_permission_lock_state(
> +            AST2600_MACHINE,
> +            AST_SCU_BASE + AST2600_SCU_PROT_REG,
> +            AST_SCU_BASE + AST2600_SCU_MISC_2_CONTROL_REG
> +    );
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/ast2500/scu/protection_register",
> +                   test_2500_protection_register);
> +    qtest_add_func("/ast2600/scu/protection_register",
> +                   test_2600_protection_register);
> +
> +    qtest_add_func("/ast2500/scu/write_permission_lock_state",
> +                   test_2500_write_permission_lock_state);
> +    qtest_add_func("/ast2600/scu/write_permission_lock_state",
> +                   test_2600_write_permission_lock_state);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 8ad849054f..7713fae885 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -215,7 +215,8 @@ qtests_npcm8xx = \
>   qtests_aspeed = \
>     ['aspeed_gpio-test',
>      'aspeed_hace-test',
> -   'aspeed_smc-test']
> +   'aspeed_smc-test',
> +   'aspeed_scu-test']
>   qtests_aspeed64 = \
>     ['ast2700-gpio-test',
>      'ast2700-hace-test',
> @@ -366,6 +367,7 @@ endif
>   qtests = {
>     'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
>     'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
> +  'aspeed_scu-test': files('aspeed-scu-utils.c', 'aspeed_scu-test.c'),
>     'ast2700-hace-test': files('aspeed-hace-utils.c', 'ast2700-hace-test.c'),
>     'ast2700-smc-test': files('aspeed-smc-utils.c', 'ast2700-smc-test.c'),
>     'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],


