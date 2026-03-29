Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E863F3D605
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 16:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6sXs-00078S-TP; Sun, 29 Mar 2026 11:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w6sXl-00077c-Oa; Sun, 29 Mar 2026 11:59:19 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w6sXh-0003KT-I7; Sun, 29 Mar 2026 11:59:17 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXnqJJTMlpj0EzAA--.17437S2;
 Sun, 29 Mar 2026 23:59:05 +0800 (CST)
Received: from [192.168.31.176] (unknown [222.244.183.215])
 by mail (Coremail) with SMTP id AQAAf8DwJpRBTMlpRkgHAA--.18633S2;
 Sun, 29 Mar 2026 23:59:01 +0800 (CST)
Message-ID: <690eef53-203d-4565-a19b-f1bf3e861af6@phytium.com.cn>
Date: Sun, 29 Mar 2026 23:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 4/4] [NOT-MERGE] tests/qtest: add q35 SMM-only x86 attrs
 coverage
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260323133210.1523868-1-tangtao1634@phytium.com.cn>
 <20260323133210.1523868-5-tangtao1634@phytium.com.cn>
 <acJKzHQf1AP2iUA2@ZEVORN-PC.localdomain>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <acJKzHQf1AP2iUA2@ZEVORN-PC.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwJpRBTMlpRkgHAA--.18633S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAJBWnIKvkcBgABsk
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKFWUJw1xAr48Cr13Zr4ruFg_yoW3GF15pF
 yDAFsIkF4xtF1xZF17Xw4DWF1aqFs7Ka4UCr47Gw1rAFZ8Crn7CrWq93ZY9F9rJrWvvw1r
 Za1UXasxWFn8taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.161.220;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjeumjiw.icoremail.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/24/2026 4:29 PM, Chao Liu wrote:
> On Mon, Mar 23, 2026 at 09:32:10PM +0800, Tao Tang wrote:
>> Add a q35-only test path for x86 secure attrs by introducing an optional
>> test-only RAM region that is mapped only into the SMM address space.
>>
>> The new qtest-x86-attrs-test enables this region with
>> `-global mch.x-smm-test-ram=on` and verifies that accesses with the
>> `secure` attribute reach the SMM-only region, while default accesses do
>> not. This provides the x86 cross-verification that qtest-attrs-test does
>> not cover, where normal RAM is visible from both the default and SMM
>> address spaces.
>>
>> This is a NOT-MERGE commit.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/pci-host/q35.c                  |  24 +++++++
>>   include/hw/pci-host/q35.h          |   8 +++
>>   tests/qtest/meson.build            |   1 +
>>   tests/qtest/qtest-x86-attrs-test.c | 109 +++++++++++++++++++++++++++++
>>   4 files changed, 142 insertions(+)
>>   create mode 100644 tests/qtest/qtest-x86-attrs-test.c
>>
>> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>> index e85e4227b3..5c23375dd6 100644
>> --- a/hw/pci-host/q35.c
>> +++ b/hw/pci-host/q35.c
>> @@ -572,6 +572,11 @@ static void mch_realize(PCIDevice *d, Error **errp)
>>           return;
>>       }
>>   
>> +    if (mch->enable_smm_test_ram && !mch->has_smm_ranges) {
>> +        error_setg(errp, "x-smm-test-ram requires SMM support");
>> +        return;
>> +    }
>> +
>>       /* setup pci memory mapping */
>>       pc_pci_as_mapping_init(mch->system_memory, mch->pci_address_space);
>>   
>> @@ -653,6 +658,23 @@ static void mch_realize(PCIDevice *d, Error **errp)
>>       memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMBASE_ADDR,
>>                                   &mch->smbase_window);
>>   
>> +    if (mch->enable_smm_test_ram) {
>> +        /*
>> +         * This is a QEMU-specific, test-only region. It is mapped only into
>> +         * mch->smram so qtest can verify that x86 secure attrs select the SMM
>> +         * address space rather than the default one.
>> +         */
>> +        memory_region_init_ram(&mch->smm_test_ram, OBJECT(mch),
>> +                               "smm-test-ram",
>> +                               MCH_HOST_BRIDGE_SMM_TEST_RAM_SIZE, errp);
>> +        if (*errp) {
>> +            return;
>> +        }
> if errp is ever NULL this will crash.
>
> The safer pattern is ERRP_GUARD() at the top of mch_realize(),
> or a local Error * with error_propagate(). Even for NOT-MERGE
> code it is worth getting right since copy-paste propagates
> patterns.


Yes you are right. I checked include/qapi/error.h and found the 
reference usage.

https://gitlab.com/qemu-project/qemu/-/blob/master/include/qapi/error.h#L140


>
>> +        memory_region_add_subregion(&mch->smram,
>> +                                    MCH_HOST_BRIDGE_SMM_TEST_RAM_BASE,
>> +                                    &mch->smm_test_ram);
>> +    }
>> +
>>       object_property_add_const_link(qdev_get_machine(), "smram",
>>                                      OBJECT(&mch->smram));
>>   }
>> @@ -661,6 +683,8 @@ static const Property mch_props[] = {
>>       DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
>>                          64),
>>       DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
>> +    DEFINE_PROP_BOOL("x-smm-test-ram", MCHPCIState, enable_smm_test_ram,
>> +                     false),
>>   };
>>   
>>   static void mch_class_init(ObjectClass *klass, const void *data)
>> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
>> index ddafc3f2e3..1ca26f0e63 100644
>> --- a/include/hw/pci-host/q35.h
>> +++ b/include/hw/pci-host/q35.h
>> @@ -49,8 +49,10 @@ struct MCHPCIState {
>>       MemoryRegion smram, low_smram, high_smram;
>>       MemoryRegion tseg_blackhole, tseg_window;
>>       MemoryRegion smbase_blackhole, smbase_window;
>> +    MemoryRegion smm_test_ram;
>>       bool has_smram_at_smbase;
>>       bool has_smm_ranges;
>> +    bool enable_smm_test_ram;
>>       Range pci_hole;
>>       uint64_t below_4g_mem_size;
>>       uint64_t above_4g_mem_size;
>> @@ -99,6 +101,12 @@ struct Q35PCIHost {
>>   #define MCH_HOST_BRIDGE_PCIEXBAR_SIZE          8       /* 64bit register */
>>   #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
>>   #define MCH_HOST_BRIDGE_PCIEXBAR_MAX           (0x10000000) /* 256M */
>> +/*
>> + * Optional qtest-only RAM window used to expose an address that exists only
>> + * in the SMM address space, so x86 secure attrs can be cross-checked.
>> + */
>> +#define MCH_HOST_BRIDGE_SMM_TEST_RAM_BASE      0xfef00000
>> +#define MCH_HOST_BRIDGE_SMM_TEST_RAM_SIZE      (64 * KiB)
>>   #define MCH_HOST_BRIDGE_PCIEXBAR_ADMSK         Q35_MASK(64, 35, 28)
>>   #define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 26))
>>   #define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 25))
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 87aa104d23..fcdd95bf7f 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -116,6 +116,7 @@ qtests_i386 = \
>>      'cpu-plug-test',
>>      'migration-test',
>>      'qtest-attrs-test',
>> +   'qtest-x86-attrs-test',
>>     ]
>>   
>>   if dbus_display and config_all_devices.has_key('CONFIG_VGA')
>> diff --git a/tests/qtest/qtest-x86-attrs-test.c b/tests/qtest/qtest-x86-attrs-test.c
>> new file mode 100644
>> index 0000000000..d9a67d5309
>> --- /dev/null
>> +++ b/tests/qtest/qtest-x86-attrs-test.c
>> @@ -0,0 +1,109 @@
>> +/*
>> + * QTest for x86 memory access with transaction attributes
>> + *
>> + * Verify q35 SMM address-space access with the secure attribute.
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
>> +
>> +#define TEST_ADDR_OFFSET_NS     0x1000ULL
>> +#define TEST_X86_BASE           0x0ULL
>> +#define TEST_X86_SMM_BASE       0xfef00000ULL
>> +
>> +#define TEST_ADDR_X86           (TEST_X86_BASE + TEST_ADDR_OFFSET_NS)
>> +
>> +#define X86_MACHINE_ARGS        "-machine q35,smm=on -m 1G -accel tcg " \
>> +                                "-global mch.x-smm-test-ram=on"
>> +
>> +static void test_x86_scalar_attrs(void)
>> +{
>> +    QTestState *qts;
>> +    uint8_t val;
>> +
>> +    if (!qtest_has_machine("q35")) {
>> +        g_test_skip("q35 machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(X86_MACHINE_ARGS);
>> +
>> +    qtest_writeb_attrs(qts, TEST_ADDR_X86, 0x11, NULL);
>> +    val = qtest_readb_attrs(qts, TEST_ADDR_X86, NULL);
>> +    g_assert_cmpuint(val, ==, 0x11);
>> +
>> +    qtest_writeb_attrs(qts, TEST_ADDR_X86 + 0x1, 0x22, "secure");
>> +    val = qtest_readb_attrs(qts, TEST_ADDR_X86 + 0x1, "secure");
>> +    g_assert_cmpuint(val, ==, 0x22);
>> +
>> +
> nit: extra blank line.
>
>> +    qtest_writeb_attrs(qts, TEST_X86_SMM_BASE + 0x2, 0x33, "secure");
>> +    val = qtest_readb_attrs(qts, TEST_X86_SMM_BASE + 0x2, "secure");
>> +    g_assert_cmpuint(val, ==, 0x33);
> The commit message says "secure accesses reach the
> SMM-only region, while default accesses do not", but
> the test only checks the secure-can-access half. It
> would strengthen the coverage to also verify that a
> default (non-secure) read of TEST_X86_SMM_BASE returns
> different data or an ERR, confirming the address-space
> isolation actually works. Without that, a bug where
> both address spaces map the region would pass silently.
>
> Thanks,
> Chao


Good point, thanks. I will add a negative test for a default access to 
TEST_X86_SMM_BASE as well.


Thanks again for your time on this series. I'll push v4 in the next few 
days.


Best regards,

Tao


