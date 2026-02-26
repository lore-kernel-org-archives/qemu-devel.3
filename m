Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4E5FD8FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 16:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdwe-0000p7-IQ; Thu, 26 Feb 2026 11:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vvdwJ-0000n1-Dx; Thu, 26 Feb 2026 11:10:16 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vvdw8-0005Ke-Bq; Thu, 26 Feb 2026 11:10:07 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwD3EqlQcKBpvhuJBw--.1S2;
 Fri, 27 Feb 2026 00:09:52 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.232.133])
 by mail (Coremail) with SMTP id AQAAfwA3jutGcKBp6HsdAA--.36723S2;
 Fri, 27 Feb 2026 00:09:49 +0800 (CST)
Message-ID: <9d1a0bab-ca81-4745-86a3-7e9d39451f53@phytium.com.cn>
Date: Fri, 27 Feb 2026 00:09:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] tests/qtest: Add qtest-attrs-test to verify memory
 access with attr
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260222082529.491384-1-tangtao1634@phytium.com.cn>
 <20260222082529.491384-3-tangtao1634@phytium.com.cn>
 <aZ8Jtl8jxBqDq8Rz@ZEVORN-PC.localdomain>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aZ8Jtl8jxBqDq8Rz@ZEVORN-PC.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwA3jutGcKBp6HsdAA--.36723S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQASBWmfZugExgACsu
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfZw17Cw1UtF1fAF4fXw1xGrg_yoW8Zw1fuo
 Wftr42gw1xtr17GFy3tryvyr42g34F9rs3AF48Xw47JF18tF4jkF15JayDJrWYyFy8K3sr
 GF9rJasYyrsrtwn3n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Chao,

On 2026/2/25 22:48, Chao Liu wrote:
> On Sun, Feb 22, 2026 at 04:25:29PM +0800, Tao Tang wrote:
>> Add a new test case `qtest-attrs-test` to validate the newly introduced
>> `*_secure` and `*_space` qtest commands.
>>
>> The test covers:
>> - ARM (virt machine): Verifies access to all four ARM security spaces
>>    (Secure, NonSecure, Root, Realm).
>> - x86 (pc machine): Verifies access to the SMM AddressSpace.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   tests/qtest/meson.build        |   4 +-
>>   tests/qtest/qtest-attrs-test.c | 669 +++++++++++++++++++++++++++++++++
>>   2 files changed, 672 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/qtest/qtest-attrs-test.c
>>
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 25fdbc7980..a53c90474a 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -115,6 +115,7 @@ qtests_i386 = \
>>      'drive_del-test',
>>      'cpu-plug-test',
>>      'migration-test',
>> +   'qtest-attrs-test',
>>     ]
>>   
>>   if dbus_display and config_all_devices.has_key('CONFIG_VGA')
>> @@ -272,7 +273,8 @@ qtests_aarch64 = \
>>     ['arm-cpu-features',
>>      'numa-test',
>>      'boot-serial-test',
>> -   'migration-test']
>> +   'migration-test',
>> +   'qtest-attrs-test']
>>   
>>   qtests_s390x = \
>>     qtests_filter + \
>> diff --git a/tests/qtest/qtest-attrs-test.c b/tests/qtest/qtest-attrs-test.c
>> new file mode 100644
>> index 0000000000..69daced706
>> --- /dev/null
>> +++ b/tests/qtest/qtest-attrs-test.c
>> @@ -0,0 +1,669 @@
>> +/*
>> + * QTest for memory access with transaction attributes
>> + *
>> + * This test verifies if the qtest *_secure and *_space commands work correctly.
>> + *
>> + * Two architectures are covered:
>> + *
>> + * - ARM (virt machine, cortex-a57, secure=on):
>> + *     *_secure uses the ARM Secure AddressSpace (ARMASIdx_S = 1).
>> + *     *_space uses all four ARM security spaces (Secure/NonSecure/Root/Realm).
>> + *     secure=on is required so that the ARM Secure address space is initialised;
>> + *
>> + * - x86 (pc machine, TCG):
>> + *     *_secure uses the SMM AddressSpace (X86ASIdx_SMM = 1).
>> + *     On TCG, cpu_address_space_init() always creates X86ASIdx_SMM as a
>> + *     container that is an alias of all system memory, so no special machine
>> + *     flags are needed -- the SMM AS exists unconditionally under TCG.
>> + *     *_space commands are ARM-specific and have no x86 equivalents.
>> + *
>> + * Copyright (c) 2026 Phytium Technology
>> + *
>> + * Author:
>> + *  Tao Tang <tangtao1634@phytium.com.cn>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +#include "libqtest-single.h"
>> +#include "hw/arm/arm-security.h"
>> +
> This header is included unconditionally, but the test is compiled
> for both i386 and aarch64 targets.
>
> While it works (the header only defines an enum and inline functions),
> it's a bit odd to pull in ARM-specific definitions for x86 test code.


Yes it's a bit odd but I think it'll have no side effect as 
hw/arm/arm-security.h is so pure and simplified after this commit:

a145038 "target/arm: Move ARMSecuritySpace to a common header"


>
> Not a blocker, but worth noting. :)
>
>> +
>> +/*
>> + * Define test addresses for ARM and x86.
>> + *
>> + * Default RAM size is 128 MiB for all architectures including "virt" machine in
>> + * ARM and "pc" machine in x86.
>> + * We define a 4 KiB size offset above the RAM base, both in ARM and x86, as the
>> + * test address.
>> + */
>> +#define TEST_ADDR_OFFSET    0x1000ULL
>> +#define TEST_ARM_BASE       0x40000000ULL
>> +#define TEST_X86_BASE       0x0ULL
>> +
>> +#define TEST_ADDR_ARM       (TEST_ARM_BASE + TEST_ADDR_OFFSET)
>> +#define TEST_ADDR_X86       (TEST_X86_BASE + TEST_ADDR_OFFSET)
>> +
>> +#define ARM_MACHINE_ARGS "-machine virt,secure=on -cpu cortex-a57"
>> +
>> +/* ARM *_secure tests */
>> +
>> +static void test_arm_writeb_readb_secure(void)
>> +{
>> +    QTestState *qts;
>> +    uint8_t val;
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
>> +    /* secure=0: NonSecure access */
>> +    qtest_writeb_secure(qts, TEST_ADDR_ARM, 0x55, 0);
>> +    val = qtest_readb_secure(qts, TEST_ADDR_ARM, 0);
>> +    g_assert_cmpuint(val, ==, 0x55);
>> +
>> +    /* secure=1: Secure access (ARM Secure AS) */
>> +    qtest_writeb_secure(qts, TEST_ADDR_ARM, 0xAA, 1);
>> +    val = qtest_readb_secure(qts, TEST_ADDR_ARM, 1);
>> +    g_assert_cmpuint(val, ==, 0xAA);
>> +
> The test pattern here (and in all other test functions) is:
> write value -> read back -> assert equal. This only verifies that
> the round-trip works, but does NOT verify that different security
> spaces are actually isolated from each other.
>
> A meaningful test would be something like:
>
> ```
>      /* Write different values to the same address in different spaces */
>      qtest_writeb_secure(qts, TEST_ADDR_ARM, 0xAA, 1);  /* Secure */
>      qtest_writeb_secure(qts, TEST_ADDR_ARM, 0x55, 0);  /* NonSecure */
>
>      /* Verify Secure space was not clobbered by the NonSecure write */
>      val = qtest_readb_secure(qts, TEST_ADDR_ARM, 1);
>      g_assert_cmpuint(val, ==, 0xAA);
> ```
>
> Without this kind of cross-space verification, the tests would
> pass even if the attrs parameter were completely ignored and all
> accesses went to the same address space.


Thanks for the advice. I'll give a try with this cross-space verification.

>
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_arm_writew_readw_secure(void)
>> +{
>> +    QTestState *qts;
>> +    uint16_t val;
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
>> +    qtest_writew_secure(qts, TEST_ADDR_ARM, 0x1234, 0);
>> +    val = qtest_readw_secure(qts, TEST_ADDR_ARM, 0);
>> +    g_assert_cmpuint(val, ==, 0x1234);
>> +
>> +    qtest_writew_secure(qts, TEST_ADDR_ARM, 0x1234, 1);
>> +    val = qtest_readw_secure(qts, TEST_ADDR_ARM, 1);
>> +    g_assert_cmpuint(val, ==, 0x1234);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_arm_writel_readl_secure(void)
>> +{
>> +    QTestState *qts;
>> +    uint32_t val;
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
>> +    qtest_writel_secure(qts, TEST_ADDR_ARM, 0xDEADBEEF, 0);
>> +    val = qtest_readl_secure(qts, TEST_ADDR_ARM, 0);
>> +    g_assert_cmpuint(val, ==, 0xDEADBEEF);
>> +
>> +    qtest_writel_secure(qts, TEST_ADDR_ARM, 0xDEADBEEF, 1);
>> +    val = qtest_readl_secure(qts, TEST_ADDR_ARM, 1);
>> +    g_assert_cmpuint(val, ==, 0xDEADBEEF);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_arm_writeq_readq_secure(void)
>> +{
>> +    QTestState *qts;
>> +    uint64_t val;
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
>> +    qtest_writeq_secure(qts, TEST_ADDR_ARM, 0x123456789ABCDEF0ULL, 0);
>> +    val = qtest_readq_secure(qts, TEST_ADDR_ARM, 0);
>> +    g_assert_cmpuint(val, ==, 0x123456789ABCDEF0ULL);
>> +
>> +    qtest_writeq_secure(qts, TEST_ADDR_ARM, 0x123456789ABCDEF0ULL, 1);
>> +    val = qtest_readq_secure(qts, TEST_ADDR_ARM, 1);
>> +    g_assert_cmpuint(val, ==, 0x123456789ABCDEF0ULL);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
> These four functions (writeb/writew/writel/writeq) have identical
> logic, differing only in data width. Same for the *_space and x86
> variants. The 669-line test file could be reduced to ~200 lines
> using parameterized tests with g_test_add_data_func, e.g.:
>
> ```
>      typedef struct {
>          const char *name;
>          int width;  /* 1, 2, 4, 8 */
>          ...
>      } TestParam; /* this is a demo name */
>
>      static void test_arm_read_write_secure(const void *data)
>      {
>          const TestParam *p = data;
>          /* single function handling all widths */
>      }
> ```


I'll refactor it in V2.

>> +static void test_arm_memwrite_memread_secure(void)
>> +{
>> +    QTestState *qts;
>> +    uint8_t wbuf[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
>> +                         0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF };
>> +    uint8_t rbuf[16];
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
> Every single test function calls qtest_init/qtest_quit, which
> means starting and stopping a full QEMU instance for each test.
> For the ARM tests alone that's 14 QEMU startups. This will be
> very slow. Consider using a test fixture (g_test_add) to share
> the QTestState across tests of the same architecture.


As Pierrick said in another mail:

> Tao initially implemented something like this. However, it means that 
> you now need to cleanup/reset SMMU state between state, which is 
> fragile and requires even more code. Thus, at the time, I suggested to 
> simply spawn a new machine for every test. 
I indeed tested all cases in one call. The related discussion is here:

https://lore.kernel.org/qemu-devel/7370070a-c569-4b77-bd1e-6fc749ba9c90@phytium.com.cn/
https://lore.kernel.org/qemu-devel/b184c907-e073-43d0-87b9-cf8c6c23dbed@phytium.com.cn/


As Pierrick suggested, maybe it's time to refactor this when it reach 30 
seconds in debug build.


How do you think about it?


>
>> +    qtest_memwrite_secure(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), 0);
>> +    qtest_memread_secure(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), 0);
>> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
>> +
>> +    qtest_memwrite_secure(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), 1);
>> +    qtest_memread_secure(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), 1);
>> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_arm_memset_secure(void)
>> +{
>> +    QTestState *qts;
>> +    uint8_t rbuf[16];
>> +    size_t i;
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
>> +    qtest_memset_secure(qts, TEST_ADDR_ARM, 0x42, sizeof(rbuf), 0);
>> +    qtest_memread_secure(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), 0);
>> +
>> +    for (i = 0; i < sizeof(rbuf); i++) {
>> +        g_assert_cmpuint(rbuf[i], ==, 0x42);
>> +    }
>> +
>> +    qtest_memset_secure(qts, TEST_ADDR_ARM, 0x42, sizeof(rbuf), 1);
>> +    qtest_memread_secure(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), 1);
>> +
>> +    for (i = 0; i < sizeof(rbuf); i++) {
>> +        g_assert_cmpuint(rbuf[i], ==, 0x42);
>> +    }
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +/* ARM *_space tests (ARM-specific: Secure/NonSecure/Root/Realm) */
>> +
>> +static void test_arm_writeb_readb_space(void)
>> +{
>> +    QTestState *qts;
>> +    uint8_t val;
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
>> +    /* NonSecure space (secure=0) */
>> +    qtest_writeb_space(qts, TEST_ADDR_ARM, 0x11, ARMSS_NonSecure);
>> +    val = qtest_readb_space(qts, TEST_ADDR_ARM, ARMSS_NonSecure);
>> +    g_assert_cmpuint(val, ==, 0x11);
>> +
>> +    /* Realm space (secure=0) */
>> +    qtest_writeb_space(qts, TEST_ADDR_ARM, 0x33, ARMSS_Realm);
>> +    val = qtest_readb_space(qts, TEST_ADDR_ARM, ARMSS_Realm);
>> +    g_assert_cmpuint(val, ==, 0x33);
>> +
>> +    /* Secure space (secure=1) */
>> +    qtest_writeb_space(qts, TEST_ADDR_ARM, 0x22, ARMSS_Secure);
>> +    val = qtest_readb_space(qts, TEST_ADDR_ARM, ARMSS_Secure);
>> +    g_assert_cmpuint(val, ==, 0x22);
>> +
>> +    /* Root space (secure=1) */
>> +    qtest_writeb_space(qts, TEST_ADDR_ARM, 0x44, ARMSS_Root);
>> +    val = qtest_readb_space(qts, TEST_ADDR_ARM, ARMSS_Root);
>> +    g_assert_cmpuint(val, ==, 0x44);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_arm_writew_readw_space(void)
>> +{
>> +    QTestState *qts;
>> +    uint16_t val;
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
>> +    qtest_writew_space(qts, TEST_ADDR_ARM + 0x10, 0x1122, ARMSS_NonSecure);
>> +    val = qtest_readw_space(qts, TEST_ADDR_ARM + 0x10, ARMSS_NonSecure);
>> +    g_assert_cmpuint(val, ==, 0x1122);
>> +
>> +    qtest_writew_space(qts, TEST_ADDR_ARM + 0x20, 0x3344, ARMSS_Realm);
>> +    val = qtest_readw_space(qts, TEST_ADDR_ARM + 0x20, ARMSS_Realm);
>> +    g_assert_cmpuint(val, ==, 0x3344);
>> +
>> +    qtest_writew_space(qts, TEST_ADDR_ARM + 0x30, 0x5566, ARMSS_Secure);
>> +    val = qtest_readw_space(qts, TEST_ADDR_ARM + 0x30, ARMSS_Secure);
>> +    g_assert_cmpuint(val, ==, 0x5566);
>> +
>> +    qtest_writew_space(qts, TEST_ADDR_ARM + 0x40, 0x7788, ARMSS_Root);
>> +    val = qtest_readw_space(qts, TEST_ADDR_ARM + 0x40, ARMSS_Root);
>> +    g_assert_cmpuint(val, ==, 0x7788);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_arm_writel_readl_space(void)
>> +{
>> +    QTestState *qts;
>> +    uint32_t val;
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
>> +    qtest_writel_space(qts, TEST_ADDR_ARM + 0x50, 0x11223344, ARMSS_NonSecure);
>> +    val = qtest_readl_space(qts, TEST_ADDR_ARM + 0x50, ARMSS_NonSecure);
>> +    g_assert_cmpuint(val, ==, 0x11223344);
>> +
>> +    qtest_writel_space(qts, TEST_ADDR_ARM + 0x60, 0x55667788, ARMSS_Realm);
>> +    val = qtest_readl_space(qts, TEST_ADDR_ARM + 0x60, ARMSS_Realm);
>> +    g_assert_cmpuint(val, ==, 0x55667788);
>> +
>> +    qtest_writel_space(qts, TEST_ADDR_ARM + 0x70, 0x99AABBCC, ARMSS_Secure);
>> +    val = qtest_readl_space(qts, TEST_ADDR_ARM + 0x70, ARMSS_Secure);
>> +    g_assert_cmpuint(val, ==, 0x99AABBCC);
>> +
>> +    qtest_writel_space(qts, TEST_ADDR_ARM + 0x80, 0xDDEEFF00, ARMSS_Root);
>> +    val = qtest_readl_space(qts, TEST_ADDR_ARM + 0x80, ARMSS_Root);
>> +    g_assert_cmpuint(val, ==, 0xDDEEFF00);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_arm_writeq_readq_space(void)
>> +{
>> +    QTestState *qts;
>> +    uint64_t val;
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
>> +    qtest_writeq_space(qts, TEST_ADDR_ARM + 0x90, 0x1122334455667788ULL,
>> +                       ARMSS_NonSecure);
>> +    val = qtest_readq_space(qts, TEST_ADDR_ARM + 0x90, ARMSS_NonSecure);
>> +    g_assert_cmpuint(val, ==, 0x1122334455667788ULL);
>> +
>> +    qtest_writeq_space(qts, TEST_ADDR_ARM + 0xA0, 0x99AABBCCDDEEFF00ULL,
>> +                       ARMSS_Realm);
>> +    val = qtest_readq_space(qts, TEST_ADDR_ARM + 0xA0, ARMSS_Realm);
>> +    g_assert_cmpuint(val, ==, 0x99AABBCCDDEEFF00ULL);
>> +
>> +    qtest_writeq_space(qts, TEST_ADDR_ARM + 0xB0, 0x0123456789ABCDEFULL,
>> +                       ARMSS_Secure);
>> +    val = qtest_readq_space(qts, TEST_ADDR_ARM + 0xB0, ARMSS_Secure);
>> +    g_assert_cmpuint(val, ==, 0x0123456789ABCDEFULL);
>> +
>> +    qtest_writeq_space(qts, TEST_ADDR_ARM + 0xC0, 0xFEDCBA9876543210ULL,
>> +                       ARMSS_Root);
>> +    val = qtest_readq_space(qts, TEST_ADDR_ARM + 0xC0, ARMSS_Root);
>> +    g_assert_cmpuint(val, ==, 0xFEDCBA9876543210ULL);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_arm_memwrite_memread_space(void)
>> +{
>> +    QTestState *qts;
>> +    uint8_t wbuf[8] = { 0xA1, 0xB2, 0xC3, 0xD4, 0xE5, 0xF6, 0x07, 0x18 };
>> +    uint8_t rbuf[8];
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
>> +    qtest_memwrite_space(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), ARMSS_NonSecure);
>> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_NonSecure);
>> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
>> +
>> +    qtest_memwrite_space(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), ARMSS_Realm);
>> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Realm);
>> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
>> +
>> +
>> +    qtest_memwrite_space(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), ARMSS_Secure);
>> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Secure);
>> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
>> +
>> +    qtest_memwrite_space(qts, TEST_ADDR_ARM, wbuf, sizeof(wbuf), ARMSS_Root);
>> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Root);
>> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +static void test_arm_memset_space(void)
>> +{
>> +    QTestState *qts;
>> +    uint8_t rbuf[8];
>> +    size_t i;
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
>> +    qtest_memset_space(qts, TEST_ADDR_ARM, 0x99, sizeof(rbuf), ARMSS_NonSecure);
>> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_NonSecure);
>> +
>> +    for (i = 0; i < sizeof(rbuf); i++) {
>> +        g_assert_cmpuint(rbuf[i], ==, 0x99);
>> +    }
>> +
>> +    qtest_memset_space(qts, TEST_ADDR_ARM, 0x99, sizeof(rbuf), ARMSS_Realm);
>> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Realm);
>> +
>> +    for (i = 0; i < sizeof(rbuf); i++) {
>> +        g_assert_cmpuint(rbuf[i], ==, 0x99);
>> +    }
>> +
>> +    qtest_memset_space(qts, TEST_ADDR_ARM, 0x99, sizeof(rbuf), ARMSS_Secure);
>> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Secure);
>> +
>> +    for (i = 0; i < sizeof(rbuf); i++) {
>> +        g_assert_cmpuint(rbuf[i], ==, 0x99);
>> +    }
>> +
>> +    qtest_memset_space(qts, TEST_ADDR_ARM, 0x99, sizeof(rbuf), ARMSS_Root);
>> +    qtest_memread_space(qts, TEST_ADDR_ARM, rbuf, sizeof(rbuf), ARMSS_Root);
>> +
>> +    for (i = 0; i < sizeof(rbuf); i++) {
>> +        g_assert_cmpuint(rbuf[i], ==, 0x99);
>> +    }
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +/* Test new *_secure / *_space API in libqtest-single.h */
>> +static void test_arm_single_secure(void)
>> +{
>> +    uint8_t val;
>> +    uint8_t wbuf[4] = { 0x10, 0x20, 0x30, 0x40 };
>> +    uint8_t rbuf[4];
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qtest_start(ARM_MACHINE_ARGS);
>> +
>> +    writeb_secure(TEST_ADDR_ARM, 0x5A, 0);
>> +    val = readb_secure(TEST_ADDR_ARM, 0);
>> +    g_assert_cmpuint(val, ==, 0x5A);
>> +
>> +    memwrite_secure(TEST_ADDR_ARM + 0x80, wbuf, sizeof(wbuf), 0);
>> +    memread_secure(TEST_ADDR_ARM + 0x80, rbuf, sizeof(rbuf), 0);
>> +    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
>> +
>> +    qtest_end();
>> +}
>> +
>> +static void test_arm_single_space(void)
>> +{
>> +    uint32_t val;
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qtest_start(ARM_MACHINE_ARGS);
>> +
>> +    writel_space(TEST_ADDR_ARM + 0x400, 0xA5A5A5A5, ARMSS_NonSecure);
>> +    val = readl_space(TEST_ADDR_ARM + 0x400, ARMSS_NonSecure);
>> +    g_assert_cmpuint(val, ==, 0xA5A5A5A5);
>> +
>> +    writel_space(TEST_ADDR_ARM + 0x404, 0x1A2B3C4D, ARMSS_Realm);
>> +    val = readl_space(TEST_ADDR_ARM + 0x404, ARMSS_Realm);
>> +    g_assert_cmpuint(val, ==, 0x1A2B3C4D);
>> +
>> +    writel_space(TEST_ADDR_ARM + 0x408, 0x55667788, ARMSS_Secure);
>> +    val = readl_space(TEST_ADDR_ARM + 0x408, ARMSS_Secure);
>> +    g_assert_cmpuint(val, ==, 0x55667788);
>> +
>> +    writel_space(TEST_ADDR_ARM + 0x40C, 0xCCDDEEFF, ARMSS_Root);
>> +    val = readl_space(TEST_ADDR_ARM + 0x40C, ARMSS_Root);
>> +    g_assert_cmpuint(val, ==, 0xCCDDEEFF);
>> +
>> +    qtest_end();
>> +}
>> +
>> +#define X86_MACHINE_ARGS  "-machine pc -accel tcg"
> The x86 tests hardcode `-accel tcg` but only check for machine
> availability, not accelerator availability. If the build doesn't
> include TCG, qtest_init() will fail instead of gracefully
> skipping. You should add a `qtest_has_accel("tcg")` check.
>
> Similarly, the ARM tests don't verify that `-cpu cortex-a57` is
> available or that `secure=on` is supported for the virt machine.


I'll add it in V2.


Thanks for the review!

Tao


