Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AD1FD3760
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 14:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvGC7-0004hr-BJ; Wed, 25 Feb 2026 09:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvGC5-0004YR-17
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:48:53 -0500
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvGC0-0007Hi-NF
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:48:52 -0500
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so8362115eec.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772030922; x=1772635722; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OD2ZDOcsB7hl8E3T7PCQShOa5gey7FJkN6MvpXFqEGs=;
 b=HJ8PQVOFOhkpLRn+gxAgJM+teUPZva0bxBctnaQz3fZGtJD7CVwYceL4LBKFDPCHyr
 e3MTbFjrQmMs174FS6rERv+IkCbfnx0H1fsXNwd4SNJ2LqouIvJJ1c6hGy5yFx//GqDF
 h0zos/5PPEev+GyIH68YOEOCFiAW26XlRTV4Q9890zoDdiQHE+6lMzaq7zsBacj5xQ0+
 NOx2p96plNf/9G0MPQQ4gWgw5dY7zYsRi4hfElaNDrOItR6ESBZxhDUQsQJpSwF3j/q2
 xpYG6M5scY4tAjJ3cSi7UVPfQM5Y7yIdZYd6xRuROtxPj0g5dY0JwWgf/muX5S83MMoO
 RDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772030922; x=1772635722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OD2ZDOcsB7hl8E3T7PCQShOa5gey7FJkN6MvpXFqEGs=;
 b=UM0yJvzi6EdkluplSAeuEEyiX9QwATmJdZMPaPST6uf8nnlm67LTxvyLM0xEAOzupM
 9E1vla1RaP5INVA7ykWrQJgIsWrIqZ0tkL2rj5g6HEHZsQG/IZ0WUnp/YED4gPJSYk3S
 eRPUFb+xO97XKup+qlEn54ij0uGy1RitueKgNvv9IJwIzTTpfxbWxtdHCXBQmijMWxC+
 xzR70l5+cd3y6ogPFavNP7Gy4sqch9hnlXl4d1w5XmZYnuy/f3r5S6nSwQOI9E9NnBsY
 N6dszeb9rNQBOq07PPMRdBxb0Ign7fhiSAKu1bED5F9QlMjdVucqOWtTzpkNZ5XsC9c0
 1fVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTwpZhTxm1brqcrGYqjDoGdyp6ofAX04VZc/1qOp3nZiXGgy1AduGOCJtMydG5uPl1ID1qpUzluVBz@nongnu.org
X-Gm-Message-State: AOJu0Ywo1XAhfFrXbt/OaEb1DXtmIQCsuImRGU1zBHAH8g6LqH4my8Db
 3R3jPuMZ8kjk7KJaxnctudHZnmiQOdeKbS6TiuILXGLlxlyYP/vor6N+
X-Gm-Gg: ATEYQzyev9PuQgk4f06FxZj8e45EzL3DP20VooRm5hI1TraWvbqPWwt2LLIIfSDp4Eh
 xg6yUVh23sqM/IjHsaL7KDLHkrQoO1aeUDJ3bI75+7BkCods1VL3MxALpK5VREDnkZ0gv3joSfR
 cFgcGcHcyD2pMq0Bng2Mb7hYkQ+pfaxiW5aNMk8tUGRsQAweKucVtSx4Bn1w6sa89jFJPMTSOIr
 OQLMlCkTpBJb/gjJLamDjuA3JD9YFG1tLdZLGxW1W3/z14F4O6cLyvMQ4b7ZtK5sCjlhfsYkmXK
 UrIGwQPKtwYwvJzkCYXjNy7WYnUpedgVq+bYz1wB9+hKJt79HBdcGZisNmPUafajNaTxqezfz9Q
 jQixK3Iuf7ev394oOZHGfix+14aiBRkkglSZ1hB3n0VcSKveGVmp2dpXmYD8ZQmYXaZs5ZfuQmA
 R0egmfcuGFixFQMDA5qiyuhfg6jFUtm1132k3WTcp4ZfvBwpmvl8QkdkoFHqjzlBeBrEPKEGR1E
 WfI0VFteGSPDXXlD2rCP/6ghy0UHvg=
X-Received: by 2002:a05:7300:b10b:b0:2b0:52cc:fe69 with SMTP id
 5a478bee46e88-2bd7b9d392fmr6425927eec.5.1772030922041; 
 Wed, 25 Feb 2026 06:48:42 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdc412c8aasm1445183eec.25.2026.02.25.06.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 06:48:41 -0800 (PST)
Date: Wed, 25 Feb 2026 22:48:45 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC 2/2] tests/qtest: Add qtest-attrs-test to verify memory
 access with attr
Message-ID: <aZ8Jtl8jxBqDq8Rz@ZEVORN-PC.localdomain>
References: <20260222082529.491384-1-tangtao1634@phytium.com.cn>
 <20260222082529.491384-3-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222082529.491384-3-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_SUBJ_META=2.499 autolearn=no autolearn_force=no
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

On Sun, Feb 22, 2026 at 04:25:29PM +0800, Tao Tang wrote:
> Add a new test case `qtest-attrs-test` to validate the newly introduced
> `*_secure` and `*_space` qtest commands.
> 
> The test covers:
> - ARM (virt machine): Verifies access to all four ARM security spaces
>   (Secure, NonSecure, Root, Realm).
> - x86 (pc machine): Verifies access to the SMM AddressSpace.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  tests/qtest/meson.build        |   4 +-
>  tests/qtest/qtest-attrs-test.c | 669 +++++++++++++++++++++++++++++++++
>  2 files changed, 672 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/qtest-attrs-test.c
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 25fdbc7980..a53c90474a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -115,6 +115,7 @@ qtests_i386 = \
>     'drive_del-test',
>     'cpu-plug-test',
>     'migration-test',
> +   'qtest-attrs-test',
>    ]
>  
>  if dbus_display and config_all_devices.has_key('CONFIG_VGA')
> @@ -272,7 +273,8 @@ qtests_aarch64 = \
>    ['arm-cpu-features',
>     'numa-test',
>     'boot-serial-test',
> -   'migration-test']
> +   'migration-test',
> +   'qtest-attrs-test']
>  
>  qtests_s390x = \
>    qtests_filter + \
> diff --git a/tests/qtest/qtest-attrs-test.c b/tests/qtest/qtest-attrs-test.c
> new file mode 100644
> index 0000000000..69daced706
> --- /dev/null
> +++ b/tests/qtest/qtest-attrs-test.c
> @@ -0,0 +1,669 @@
> +/*
> + * QTest for memory access with transaction attributes
> + *
> + * This test verifies if the qtest *_secure and *_space commands work correctly.
> + *
> + * Two architectures are covered:
> + *
> + * - ARM (virt machine, cortex-a57, secure=on):
> + *     *_secure uses the ARM Secure AddressSpace (ARMASIdx_S = 1).
> + *     *_space uses all four ARM security spaces (Secure/NonSecure/Root/Realm).
> + *     secure=on is required so that the ARM Secure address space is initialised;
> + *
> + * - x86 (pc machine, TCG):
> + *     *_secure uses the SMM AddressSpace (X86ASIdx_SMM = 1).
> + *     On TCG, cpu_address_space_init() always creates X86ASIdx_SMM as a
> + *     container that is an alias of all system memory, so no special machine
> + *     flags are needed -- the SMM AS exists unconditionally under TCG.
> + *     *_space commands are ARM-specific and have no x86 equivalents.
> + *
> + * Copyright (c) 2026 Phytium Technology
> + *
> + * Author:
> + *  Tao Tang <tangtao1634@phytium.com.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqtest-single.h"
> +#include "hw/arm/arm-security.h"
> +
This header is included unconditionally, but the test is compiled
for both i386 and aarch64 targets.

While it works (the header only defines an enum and inline functions),
it's a bit odd to pull in ARM-specific definitions for x86 test code.

Not a blocker, but worth noting. :)

> +
> +/*
> + * Define test addresses for ARM and x86.
> + *
> + * Default RAM size is 128 MiB for all architectures including "virt" machine in
> + * ARM and "pc" machine in x86.
> + * We define a 4 KiB size offset above the RAM base, both in ARM and x86, as the
> + * test address.
> + */
> +#define TEST_ADDR_OFFSET    0x1000ULL
> +#define TEST_ARM_BASE       0x40000000ULL
> +#define TEST_X86_BASE       0x0ULL
> +
> +#define TEST_ADDR_ARM       (TEST_ARM_BASE + TEST_ADDR_OFFSET)
> +#define TEST_ADDR_X86       (TEST_X86_BASE + TEST_ADDR_OFFSET)
> +
> +#define ARM_MACHINE_ARGS "-machine virt,secure=on -cpu cortex-a57"
> +
> +/* ARM *_secure tests */
> +
> +static void test_arm_writeb_readb_secure(void)
> +{
> +    QTestState *qts;
> +    uint8_t val;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
> +    /* secure=0: NonSecure access */
> +    qtest_writeb_secure(qts, TEST_ADDR_ARM, 0x55, 0);
> +    val = qtest_readb_secure(qts, TEST_ADDR_ARM, 0);
> +    g_assert_cmpuint(val, ==, 0x55);
> +
> +    /* secure=1: Secure access (ARM Secure AS) */
> +    qtest_writeb_secure(qts, TEST_ADDR_ARM, 0xAA, 1);
> +    val = qtest_readb_secure(qts, TEST_ADDR_ARM, 1);
> +    g_assert_cmpuint(val, ==, 0xAA);
> +
The test pattern here (and in all other test functions) is:
write value -> read back -> assert equal. This only verifies that
the round-trip works, but does NOT verify that different security
spaces are actually isolated from each other.

A meaningful test would be something like:

```
    /* Write different values to the same address in different spaces */
    qtest_writeb_secure(qts, TEST_ADDR_ARM, 0xAA, 1);  /* Secure */
    qtest_writeb_secure(qts, TEST_ADDR_ARM, 0x55, 0);  /* NonSecure */

    /* Verify Secure space was not clobbered by the NonSecure write */
    val = qtest_readb_secure(qts, TEST_ADDR_ARM, 1);
    g_assert_cmpuint(val, ==, 0xAA);
```

Without this kind of cross-space verification, the tests would
pass even if the attrs parameter were completely ignored and all
accesses went to the same address space.

> +    qtest_quit(qts);
> +}
> +
> +static void test_arm_writew_readw_secure(void)
> +{
> +    QTestState *qts;
> +    uint16_t val;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
> +    qtest_writew_secure(qts, TEST_ADDR_ARM, 0x1234, 0);
> +    val = qtest_readw_secure(qts, TEST_ADDR_ARM, 0);
> +    g_assert_cmpuint(val, ==, 0x1234);
> +
> +    qtest_writew_secure(qts, TEST_ADDR_ARM, 0x1234, 1);
> +    val = qtest_readw_secure(qts, TEST_ADDR_ARM, 1);
> +    g_assert_cmpuint(val, ==, 0x1234);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_arm_writel_readl_secure(void)
> +{
> +    QTestState *qts;
> +    uint32_t val;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
> +    qtest_writel_secure(qts, TEST_ADDR_ARM, 0xDEADBEEF, 0);
> +    val = qtest_readl_secure(qts, TEST_ADDR_ARM, 0);
> +    g_assert_cmpuint(val, ==, 0xDEADBEEF);
> +
> +    qtest_writel_secure(qts, TEST_ADDR_ARM, 0xDEADBEEF, 1);
> +    val = qtest_readl_secure(qts, TEST_ADDR_ARM, 1);
> +    g_assert_cmpuint(val, ==, 0xDEADBEEF);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_arm_writeq_readq_secure(void)
> +{
> +    QTestState *qts;
> +    uint64_t val;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
> +    qtest_writeq_secure(qts, TEST_ADDR_ARM, 0x123456789ABCDEF0ULL, 0);
> +    val = qtest_readq_secure(qts, TEST_ADDR_ARM, 0);
> +    g_assert_cmpuint(val, ==, 0x123456789ABCDEF0ULL);
> +
> +    qtest_writeq_secure(qts, TEST_ADDR_ARM, 0x123456789ABCDEF0ULL, 1);
> +    val = qtest_readq_secure(qts, TEST_ADDR_ARM, 1);
> +    g_assert_cmpuint(val, ==, 0x123456789ABCDEF0ULL);
> +
> +    qtest_quit(qts);
> +}
> +
These four functions (writeb/writew/writel/writeq) have identical
logic, differing only in data width. Same for the *_space and x86
variants. The 669-line test file could be reduced to ~200 lines
using parameterized tests with g_test_add_data_func, e.g.:

```
    typedef struct {
        const char *name;
        int width;  /* 1, 2, 4, 8 */
        ...
    } TestParam; /* this is a demo name */

    static void test_arm_read_write_secure(const void *data)
    {
        const TestParam *p = data;
        /* single function handling all widths */
    }
```

> +static void test_arm_memwrite_memread_secure(void)
> +{
> +    QTestState *qts;
> +    uint8_t wbuf[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
> +                         0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF };
> +    uint8_t rbuf[16];
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
Every single test function calls qtest_init/qtest_quit, which
means starting and stopping a full QEMU instance for each test.
For the ARM tests alone that's 14 QEMU startups. This will be
very slow. Consider using a test fixture (g_test_add) to share
the QTestState across tests of the same architecture.

> +    qtest_memwrite_secure(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), 0);
> +    qtest_memread_secure(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), 0);
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_memwrite_secure(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), 1);
> +    qtest_memread_secure(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), 1);
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_arm_memset_secure(void)
> +{
> +    QTestState *qts;
> +    uint8_t rbuf[16];
> +    size_t i;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
> +    qtest_memset_secure(qts, TEST_ADDR_ARM, 0x42, sizeof(rbuf), 0);
> +    qtest_memread_secure(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), 0);
> +
> +    for (i = 0; i < sizeof(rbuf); i++) {
> +        g_assert_cmpuint(rbuf[i], ==, 0x42);
> +    }
> +
> +    qtest_memset_secure(qts, TEST_ADDR_ARM, 0x42, sizeof(rbuf), 1);
> +    qtest_memread_secure(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), 1);
> +
> +    for (i = 0; i < sizeof(rbuf); i++) {
> +        g_assert_cmpuint(rbuf[i], ==, 0x42);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +/* ARM *_space tests (ARM-specific: Secure/NonSecure/Root/Realm) */
> +
> +static void test_arm_writeb_readb_space(void)
> +{
> +    QTestState *qts;
> +    uint8_t val;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
> +    /* NonSecure space (secure=0) */
> +    qtest_writeb_space(qts, TEST_ADDR_ARM, 0x11, ARMSS_NonSecure);
> +    val = qtest_readb_space(qts, TEST_ADDR_ARM, ARMSS_NonSecure);
> +    g_assert_cmpuint(val, ==, 0x11);
> +
> +    /* Realm space (secure=0) */
> +    qtest_writeb_space(qts, TEST_ADDR_ARM, 0x33, ARMSS_Realm);
> +    val = qtest_readb_space(qts, TEST_ADDR_ARM, ARMSS_Realm);
> +    g_assert_cmpuint(val, ==, 0x33);
> +
> +    /* Secure space (secure=1) */
> +    qtest_writeb_space(qts, TEST_ADDR_ARM, 0x22, ARMSS_Secure);
> +    val = qtest_readb_space(qts, TEST_ADDR_ARM, ARMSS_Secure);
> +    g_assert_cmpuint(val, ==, 0x22);
> +
> +    /* Root space (secure=1) */
> +    qtest_writeb_space(qts, TEST_ADDR_ARM, 0x44, ARMSS_Root);
> +    val = qtest_readb_space(qts, TEST_ADDR_ARM, ARMSS_Root);
> +    g_assert_cmpuint(val, ==, 0x44);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_arm_writew_readw_space(void)
> +{
> +    QTestState *qts;
> +    uint16_t val;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
> +    qtest_writew_space(qts, TEST_ADDR_ARM + 0x10, 0x1122, ARMSS_NonSecure);
> +    val = qtest_readw_space(qts, TEST_ADDR_ARM + 0x10, ARMSS_NonSecure);
> +    g_assert_cmpuint(val, ==, 0x1122);
> +
> +    qtest_writew_space(qts, TEST_ADDR_ARM + 0x20, 0x3344, ARMSS_Realm);
> +    val = qtest_readw_space(qts, TEST_ADDR_ARM + 0x20, ARMSS_Realm);
> +    g_assert_cmpuint(val, ==, 0x3344);
> +
> +    qtest_writew_space(qts, TEST_ADDR_ARM + 0x30, 0x5566, ARMSS_Secure);
> +    val = qtest_readw_space(qts, TEST_ADDR_ARM + 0x30, ARMSS_Secure);
> +    g_assert_cmpuint(val, ==, 0x5566);
> +
> +    qtest_writew_space(qts, TEST_ADDR_ARM + 0x40, 0x7788, ARMSS_Root);
> +    val = qtest_readw_space(qts, TEST_ADDR_ARM + 0x40, ARMSS_Root);
> +    g_assert_cmpuint(val, ==, 0x7788);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_arm_writel_readl_space(void)
> +{
> +    QTestState *qts;
> +    uint32_t val;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
> +    qtest_writel_space(qts, TEST_ADDR_ARM + 0x50, 0x11223344, ARMSS_NonSecure);
> +    val = qtest_readl_space(qts, TEST_ADDR_ARM + 0x50, ARMSS_NonSecure);
> +    g_assert_cmpuint(val, ==, 0x11223344);
> +
> +    qtest_writel_space(qts, TEST_ADDR_ARM + 0x60, 0x55667788, ARMSS_Realm);
> +    val = qtest_readl_space(qts, TEST_ADDR_ARM + 0x60, ARMSS_Realm);
> +    g_assert_cmpuint(val, ==, 0x55667788);
> +
> +    qtest_writel_space(qts, TEST_ADDR_ARM + 0x70, 0x99AABBCC, ARMSS_Secure);
> +    val = qtest_readl_space(qts, TEST_ADDR_ARM + 0x70, ARMSS_Secure);
> +    g_assert_cmpuint(val, ==, 0x99AABBCC);
> +
> +    qtest_writel_space(qts, TEST_ADDR_ARM + 0x80, 0xDDEEFF00, ARMSS_Root);
> +    val = qtest_readl_space(qts, TEST_ADDR_ARM + 0x80, ARMSS_Root);
> +    g_assert_cmpuint(val, ==, 0xDDEEFF00);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_arm_writeq_readq_space(void)
> +{
> +    QTestState *qts;
> +    uint64_t val;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
> +    qtest_writeq_space(qts, TEST_ADDR_ARM + 0x90, 0x1122334455667788ULL,
> +                       ARMSS_NonSecure);
> +    val = qtest_readq_space(qts, TEST_ADDR_ARM + 0x90, ARMSS_NonSecure);
> +    g_assert_cmpuint(val, ==, 0x1122334455667788ULL);
> +
> +    qtest_writeq_space(qts, TEST_ADDR_ARM + 0xA0, 0x99AABBCCDDEEFF00ULL,
> +                       ARMSS_Realm);
> +    val = qtest_readq_space(qts, TEST_ADDR_ARM + 0xA0, ARMSS_Realm);
> +    g_assert_cmpuint(val, ==, 0x99AABBCCDDEEFF00ULL);
> +
> +    qtest_writeq_space(qts, TEST_ADDR_ARM + 0xB0, 0x0123456789ABCDEFULL,
> +                       ARMSS_Secure);
> +    val = qtest_readq_space(qts, TEST_ADDR_ARM + 0xB0, ARMSS_Secure);
> +    g_assert_cmpuint(val, ==, 0x0123456789ABCDEFULL);
> +
> +    qtest_writeq_space(qts, TEST_ADDR_ARM + 0xC0, 0xFEDCBA9876543210ULL,
> +                       ARMSS_Root);
> +    val = qtest_readq_space(qts, TEST_ADDR_ARM + 0xC0, ARMSS_Root);
> +    g_assert_cmpuint(val, ==, 0xFEDCBA9876543210ULL);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_arm_memwrite_memread_space(void)
> +{
> +    QTestState *qts;
> +    uint8_t wbuf[8] = { 0xA1, 0xB2, 0xC3, 0xD4, 0xE5, 0xF6, 0x07, 0x18 };
> +    uint8_t rbuf[8];
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
> +    qtest_memwrite_space(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), ARMSS_NonSecure);
> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_NonSecure);
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_memwrite_space(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), ARMSS_Realm);
> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Realm);
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +
> +    qtest_memwrite_space(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), ARMSS_Secure);
> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Secure);
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_memwrite_space(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), ARMSS_Root);
> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Root);
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_arm_memset_space(void)
> +{
> +    QTestState *qts;
> +    uint8_t rbuf[8];
> +    size_t i;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(ARM_MACHINE_ARGS);
> +
> +    qtest_memset_space(qts, TEST_ADDR_ARM, 0x99, sizeof(rbuf), ARMSS_NonSecure);
> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_NonSecure);
> +
> +    for (i = 0; i < sizeof(rbuf); i++) {
> +        g_assert_cmpuint(rbuf[i], ==, 0x99);
> +    }
> +
> +    qtest_memset_space(qts, TEST_ADDR_ARM, 0x99, sizeof(rbuf), ARMSS_Realm);
> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Realm);
> +
> +    for (i = 0; i < sizeof(rbuf); i++) {
> +        g_assert_cmpuint(rbuf[i], ==, 0x99);
> +    }
> +
> +    qtest_memset_space(qts, TEST_ADDR_ARM, 0x99, sizeof(rbuf), ARMSS_Secure);
> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Secure);
> +
> +    for (i = 0; i < sizeof(rbuf); i++) {
> +        g_assert_cmpuint(rbuf[i], ==, 0x99);
> +    }
> +
> +    qtest_memset_space(qts, TEST_ADDR_ARM, 0x99, sizeof(rbuf), ARMSS_Root);
> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Root);
> +
> +    for (i = 0; i < sizeof(rbuf); i++) {
> +        g_assert_cmpuint(rbuf[i], ==, 0x99);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +/* Test new *_secure / *_space API in libqtest-single.h */
> +static void test_arm_single_secure(void)
> +{
> +    uint8_t val;
> +    uint8_t wbuf[4] = { 0x10, 0x20, 0x30, 0x40 };
> +    uint8_t rbuf[4];
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qtest_start(ARM_MACHINE_ARGS);
> +
> +    writeb_secure(TEST_ADDR_ARM, 0x5A, 0);
> +    val = readb_secure(TEST_ADDR_ARM, 0);
> +    g_assert_cmpuint(val, ==, 0x5A);
> +
> +    memwrite_secure(TEST_ADDR_ARM + 0x80, wbuf, sizeof(wbuf), 0);
> +    memread_secure(TEST_ADDR_ARM + 0x80, rbuf, sizeof(rbuf), 0);
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_end();
> +}
> +
> +static void test_arm_single_space(void)
> +{
> +    uint32_t val;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return;
> +    }
> +
> +    qtest_start(ARM_MACHINE_ARGS);
> +
> +    writel_space(TEST_ADDR_ARM + 0x400, 0xA5A5A5A5, ARMSS_NonSecure);
> +    val = readl_space(TEST_ADDR_ARM + 0x400, ARMSS_NonSecure);
> +    g_assert_cmpuint(val, ==, 0xA5A5A5A5);
> +
> +    writel_space(TEST_ADDR_ARM + 0x404, 0x1A2B3C4D, ARMSS_Realm);
> +    val = readl_space(TEST_ADDR_ARM + 0x404, ARMSS_Realm);
> +    g_assert_cmpuint(val, ==, 0x1A2B3C4D);
> +
> +    writel_space(TEST_ADDR_ARM + 0x408, 0x55667788, ARMSS_Secure);
> +    val = readl_space(TEST_ADDR_ARM + 0x408, ARMSS_Secure);
> +    g_assert_cmpuint(val, ==, 0x55667788);
> +
> +    writel_space(TEST_ADDR_ARM + 0x40C, 0xCCDDEEFF, ARMSS_Root);
> +    val = readl_space(TEST_ADDR_ARM + 0x40C, ARMSS_Root);
> +    g_assert_cmpuint(val, ==, 0xCCDDEEFF);
> +
> +    qtest_end();
> +}
> +
> +#define X86_MACHINE_ARGS  "-machine pc -accel tcg"
The x86 tests hardcode `-accel tcg` but only check for machine
availability, not accelerator availability. If the build doesn't
include TCG, qtest_init() will fail instead of gracefully
skipping. You should add a `qtest_has_accel("tcg")` check.

Similarly, the ARM tests don't verify that `-cpu cortex-a57` is
available or that `secure=on` is supported for the virt machine.

Thanks,
Chao
> +
> +/* x86 *_secure tests */
> +static void test_x86_writeb_readb_secure(void)
> +{
> +    QTestState *qts;
> +    uint8_t val;
> +
> +    if (!qtest_has_machine("pc")) {
> +        g_test_skip("pc machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(X86_MACHINE_ARGS);
> +
> +    /* secure=0: normal memory access (X86ASIdx_MEM) */
> +    qtest_writeb_secure(qts, TEST_ADDR_X86, 0x55, 0);
> +    val = qtest_readb_secure(qts, TEST_ADDR_X86, 0);
> +    g_assert_cmpuint(val, ==, 0x55);
> +
> +    /* secure=1: SMM address space (X86ASIdx_SMM) */
> +    qtest_writeb_secure(qts, TEST_ADDR_X86, 0xAA, 1);
> +    val = qtest_readb_secure(qts, TEST_ADDR_X86, 1);
> +    g_assert_cmpuint(val, ==, 0xAA);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_x86_writew_readw_secure(void)
> +{
> +    QTestState *qts;
> +    uint16_t val;
> +
> +    if (!qtest_has_machine("pc")) {
> +        g_test_skip("pc machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(X86_MACHINE_ARGS);
> +
> +    qtest_writew_secure(qts, TEST_ADDR_X86, 0x1234, 0);
> +    val = qtest_readw_secure(qts, TEST_ADDR_X86, 0);
> +    g_assert_cmpuint(val, ==, 0x1234);
> +
> +    qtest_writew_secure(qts, TEST_ADDR_X86, 0x5678, 1);
> +    val = qtest_readw_secure(qts, TEST_ADDR_X86, 1);
> +    g_assert_cmpuint(val, ==, 0x5678);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_x86_writel_readl_secure(void)
> +{
> +    QTestState *qts;
> +    uint32_t val;
> +
> +    if (!qtest_has_machine("pc")) {
> +        g_test_skip("pc machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(X86_MACHINE_ARGS);
> +
> +    qtest_writel_secure(qts, TEST_ADDR_X86, 0xDEADBEEF, 0);
> +    val = qtest_readl_secure(qts, TEST_ADDR_X86, 0);
> +    g_assert_cmpuint(val, ==, 0xDEADBEEF);
> +
> +    qtest_writel_secure(qts, TEST_ADDR_X86, 0xCAFEBABE, 1);
> +    val = qtest_readl_secure(qts, TEST_ADDR_X86, 1);
> +    g_assert_cmpuint(val, ==, 0xCAFEBABE);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_x86_writeq_readq_secure(void)
> +{
> +    QTestState *qts;
> +    uint64_t val;
> +
> +    if (!qtest_has_machine("pc")) {
> +        g_test_skip("pc machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(X86_MACHINE_ARGS);
> +
> +    qtest_writeq_secure(qts, TEST_ADDR_X86, 0x123456789ABCDEF0ULL, 0);
> +    val = qtest_readq_secure(qts, TEST_ADDR_X86, 0);
> +    g_assert_cmpuint(val, ==, 0x123456789ABCDEF0ULL);
> +
> +    qtest_writeq_secure(qts, TEST_ADDR_X86, 0xFEDCBA9876543210ULL, 1);
> +    val = qtest_readq_secure(qts, TEST_ADDR_X86, 1);
> +    g_assert_cmpuint(val, ==, 0xFEDCBA9876543210ULL);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_x86_memwrite_memread_secure(void)
> +{
> +    QTestState *qts;
> +    uint8_t wbuf[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
> +                         0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF };
> +    uint8_t rbuf[16];
> +
> +    if (!qtest_has_machine("pc")) {
> +        g_test_skip("pc machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(X86_MACHINE_ARGS);
> +
> +    qtest_memwrite_secure(qts, TEST_ADDR_X86, wbuf, sizeof(wbuf), 0);
> +    qtest_memread_secure(qts, TEST_ADDR_X86, rbuf, sizeof(rbuf), 0);
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_memwrite_secure(qts, TEST_ADDR_X86 + 0x100, wbuf, sizeof(wbuf), 1);
> +    qtest_memread_secure(qts, TEST_ADDR_X86 + 0x100, rbuf, sizeof(rbuf), 1);
> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_x86_memset_secure(void)
> +{
> +    QTestState *qts;
> +    uint8_t rbuf[16];
> +    size_t i;
> +
> +    if (!qtest_has_machine("pc")) {
> +        g_test_skip("pc machine not available");
> +        return;
> +    }
> +
> +    qts = qtest_init(X86_MACHINE_ARGS);
> +
> +    qtest_memset_secure(qts, TEST_ADDR_X86, 0x42, sizeof(rbuf), 0);
> +    qtest_memread_secure(qts, TEST_ADDR_X86, rbuf, sizeof(rbuf), 0);
> +    for (i = 0; i < sizeof(rbuf); i++) {
> +        g_assert_cmpuint(rbuf[i], ==, 0x42);
> +    }
> +
> +    qtest_memset_secure(qts, TEST_ADDR_X86 + 0x100, 0xBE, sizeof(rbuf), 1);
> +    qtest_memread_secure(qts, TEST_ADDR_X86 + 0x100, rbuf, sizeof(rbuf), 1);
> +    for (i = 0; i < sizeof(rbuf); i++) {
> +        g_assert_cmpuint(rbuf[i], ==, 0xBE);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    /* ARM *_secure tests (secure/non-secure, requires secure=on) */
> +    qtest_add_func("/qtest/arm/secure/writeb_readb",
> +                   test_arm_writeb_readb_secure);
> +    qtest_add_func("/qtest/arm/secure/writew_readw",
> +                   test_arm_writew_readw_secure);
> +    qtest_add_func("/qtest/arm/secure/writel_readl",
> +                   test_arm_writel_readl_secure);
> +    qtest_add_func("/qtest/arm/secure/writeq_readq",
> +                   test_arm_writeq_readq_secure);
> +    qtest_add_func("/qtest/arm/secure/memwrite_memread",
> +                   test_arm_memwrite_memread_secure);
> +    qtest_add_func("/qtest/arm/secure/memset",
> +                   test_arm_memset_secure);
> +
> +    /* ARM *_space tests (Secure/NonSecure/Root/Realm, requires secure=on) */
> +    qtest_add_func("/qtest/arm/space/writeb_readb",
> +                   test_arm_writeb_readb_space);
> +    qtest_add_func("/qtest/arm/space/writew_readw",
> +                   test_arm_writew_readw_space);
> +    qtest_add_func("/qtest/arm/space/writel_readl",
> +                   test_arm_writel_readl_space);
> +    qtest_add_func("/qtest/arm/space/writeq_readq",
> +                   test_arm_writeq_readq_space);
> +    qtest_add_func("/qtest/arm/space/memwrite_memread",
> +                   test_arm_memwrite_memread_space);
> +    qtest_add_func("/qtest/arm/space/memset",
> +                   test_arm_memset_space);
> +    qtest_add_func("/qtest/arm/secure/single_shortcuts",
> +                   test_arm_single_secure);
> +    qtest_add_func("/qtest/arm/space/single_shortcuts",
> +                   test_arm_single_space);
> +
> +    /* x86 *_secure tests (SMM address space, X86ASIdx_SMM = 1) */
> +    qtest_add_func("/qtest/x86/secure/writeb_readb",
> +                   test_x86_writeb_readb_secure);
> +    qtest_add_func("/qtest/x86/secure/writew_readw",
> +                   test_x86_writew_readw_secure);
> +    qtest_add_func("/qtest/x86/secure/writel_readl",
> +                   test_x86_writel_readl_secure);
> +    qtest_add_func("/qtest/x86/secure/writeq_readq",
> +                   test_x86_writeq_readq_secure);
> +    qtest_add_func("/qtest/x86/secure/memwrite_memread",
> +                   test_x86_memwrite_memread_secure);
> +    qtest_add_func("/qtest/x86/secure/memset",
> +                   test_x86_memset_secure);
> +
> +    return g_test_run();
> +}
> -- 
> 2.34.1
> 

