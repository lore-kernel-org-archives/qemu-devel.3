Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3E3D2F7FE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 14:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRWfL-0002Jj-QY; Fri, 05 Dec 2025 09:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRWfJ-0002IU-7k; Fri, 05 Dec 2025 09:20:09 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRWfF-0005EF-Tu; Fri, 05 Dec 2025 09:20:08 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnCSYH6jJpVz87AQ--.24902S2;
 Fri, 05 Dec 2025 22:19:51 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.235.80])
 by mail (Coremail) with SMTP id AQAAfwCX8O0F6jJpx9YJAA--.19258S2;
 Fri, 05 Dec 2025 22:19:49 +0800 (CST)
Message-ID: <7370070a-c569-4b77-bd1e-6fc749ba9c90@phytium.com.cn>
Date: Fri, 5 Dec 2025 22:19:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 4/4] tests/qtest: Add SMMUv3 bare-metal test using
 iommu-testdev
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251126154547.1300748-1-tangtao1634@phytium.com.cn>
 <20251126154547.1300748-5-tangtao1634@phytium.com.cn>
 <5d37349b-fbc4-4964-a3e8-d937a64ae232@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <5d37349b-fbc4-4964-a3e8-d937a64ae232@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX8O0F6jJpx9YJAA--.19258S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAPBWkx6ywGXwAAsN
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3GFy5uFy8tFy8WrWDJr1kZrb_yoWfKFW5pF
 1kCrWUtFWUJr1fJr17Jw1UJFyFyrnrJ3WUJr18XF15Ar4DAryjqr1jgryqgr9rJr48XF1U
 Zw10qFnxur1UJFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Pierrick,

On 2025/12/5 02:42, Pierrick Bouvier wrote:
> On 11/26/25 7:45 AM, Tao Tang wrote:
>> Add a qtest suite that validates ARM SMMUv3 translation without guest
>> firmware or OS. The tests leverage iommu-testdev to trigger DMA
>> operations and the qos-smmuv3 library to configure IOMMU translation
>> structures.
>>
>> This test suite targets the virt machine and covers:
>> - Stage 1 only translation (VA -> PA via CD page tables)
>> - Stage 2 only translation (IPA -> PA via STE S2 tables)
>> - Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)
>> - Design to extended to support multiple security spaces
>>      (Non-Secure, Secure, Root, Realm)
>>
>> Each test case follows this sequence:
>> 1. Initialize SMMUv3 with appropriate command/event queues
>> 2. Build translation tables (STE/CD/PTE) for the target scenario
>> 3. Configure iommu-testdev with IOVA and DMA attributes via MMIO
>> 4. Trigger DMA and validate successful translation
>> 5. Verify data integrity through a deterministic write-read pattern
>>
>> This bare-metal approach provides deterministic IOMMU testing with
>> minimal dependencies, making failures directly attributable to the SMMU
>> translation path.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   tests/qtest/iommu-smmuv3-test.c | 114 ++++++++++++++++++++++++++++++++
>>   tests/qtest/meson.build         |   1 +
>>   2 files changed, 115 insertions(+)
>>   create mode 100644 tests/qtest/iommu-smmuv3-test.c
>>
>> diff --git a/tests/qtest/iommu-smmuv3-test.c 
>> b/tests/qtest/iommu-smmuv3-test.c
>> new file mode 100644
>> index 0000000000..af438ecce0
>> --- /dev/null
>> +++ b/tests/qtest/iommu-smmuv3-test.c
>> @@ -0,0 +1,114 @@
>> +/*
>> + * QTest for SMMUv3 with iommu-testdev
>> + *
>> + * This QTest file is used to test the SMMUv3 with iommu-testdev so 
>> that we can
>> + * test SMMUv3 without any guest kernel or firmware.
>> + *
>> + * Copyright (c) 2025 Phytium Technology
>> + *
>> + * Author:
>> + *  Tao Tang <tangtao1634@phytium.com.cn>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +#include "libqos/pci.h"
>> +#include "libqos/generic-pcihost.h"
>> +#include "hw/pci/pci_regs.h"
>> +#include "hw/misc/iommu-testdev.h"
>> +#include "libqos/qos-smmuv3.h"
>> +
>> +#define DMA_LEN           4
>> +
>> +/* Test configurations for different SMMU modes and spaces */
>> +static const QSMMUTestConfig base_test_configs[] = {
>> +    {
>> +        .trans_mode = QSMMU_TM_S1_ONLY,
>> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
>> +        .dma_iova = QSMMU_IOVA_OR_IPA,
>> +        .dma_len = DMA_LEN,
>> +        .expected_result = 0
>> +    },
>> +    {
>> +        .trans_mode = QSMMU_TM_S2_ONLY,
>> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
>> +        .dma_iova = QSMMU_IOVA_OR_IPA,
>> +        .dma_len = DMA_LEN,
>> +        .expected_result = 0
>> +    },
>> +    {
>> +        .trans_mode = QSMMU_TM_NESTED,
>> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
>> +        .dma_iova = QSMMU_IOVA_OR_IPA,
>> +        .dma_len = DMA_LEN,
>> +        .expected_result = 0
>> +    }
>> +};
>> +
>> +static QPCIDevice *setup_qtest_pci_device(QTestState *qts, 
>> QGenericPCIBus *gbus,
>> +                                          QPCIBar *bar)
>> +{
>> +    uint16_t vid, did;
>> +    QPCIDevice *dev = NULL;
>> +
>> +    qpci_init_generic(gbus, qts, NULL, false);
>> +
>> +    /* Find device by vendor/device ID to avoid slot surprises. */
>> +    for (int s = 0; s < 32 && !dev; s++) {
>> +        for (int fn = 0; fn < 8 && !dev; fn++) {
>> +            QPCIDevice *cand = qpci_device_find(&gbus->bus, 
>> QPCI_DEVFN(s, fn));
>> +            if (!cand) {
>> +                continue;
>> +            }
>> +            vid = qpci_config_readw(cand, PCI_VENDOR_ID);
>> +            did = qpci_config_readw(cand, PCI_DEVICE_ID);
>> +            if (vid == IOMMU_TESTDEV_VENDOR_ID &&
>> +                did == IOMMU_TESTDEV_DEVICE_ID) {
>> +                dev = cand;
>> +                g_test_message("Found iommu-testdev! devfn: 0x%x", 
>> cand->devfn);
>> +            } else {
>> +                g_free(cand);
>> +            }
>> +        }
>> +    }
>> +    g_assert(dev);
>> +
>> +    qpci_device_enable(dev);
>> +    *bar = qpci_iomap(dev, 0, NULL);
>> +    g_assert_false(bar->is_io);
>> +
>> +    return dev;
>> +}
>> +
>> +static void test_smmuv3_translation(void)
>> +{
>> +    QTestState *qts;
>> +    QGenericPCIBus gbus;
>> +    QPCIDevice *dev;
>> +    QPCIBar bar;
>> +
>> +    /* Initialize QEMU environment for SMMU testing */
>> +    qts = qtest_init("-machine 
>> virt,acpi=off,gic-version=3,iommu=smmuv3 "
>> +                     "-smp 1 -m 512 -cpu max -net none "
>> +                     "-device iommu-testdev");
>> +
>> +    /* Setup and configure PCI device */
>> +    dev = setup_qtest_pci_device(qts, &gbus, &bar);
>> +    g_assert(dev);
>> +
>> +    /* Run the enhanced translation tests */
>> +    g_test_message("### Starting SMMUv3 translation tests...###");
>> +    qsmmu_translation_batch(base_test_configs, 
>> ARRAY_SIZE(base_test_configs),
>> +                            qts, dev, bar, VIRT_SMMU_BASE);
>> +    g_test_message("### SMMUv3 translation tests completed 
>> successfully! ###");
>> +    qtest_quit(qts);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +    qtest_add_func("/iommu-testdev/translation", 
>> test_smmuv3_translation);
>
> Just a simple organization remark, maybe it would be better to have 
> separate tests for each translation setup. It's easier to review in 
> case a failure is found.
> test_smmuv3_translation could be modified to add a QSMMUTestConfig 
> parameter, and new entry points could be used to define the three setup.
> What do you think?
>
>> +    return g_test_run();
>> +}
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 669d07c06b..e2d2e68092 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -263,6 +263,7 @@ qtests_aarch64 = \
>>      config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? 
>> ['tpm-tis-i2c-test'] : []) + \
>>     (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? 
>> qtests_aspeed64 : []) + \
>>     (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : 
>> []) + \
>> +  (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? 
>> ['iommu-smmuv3-test'] : []) + \
>>     qtests_cxl + \
>>     ['arm-cpu-features',
>>      'numa-test',
>
> I ran this qtest, and checked with a coverage enabled build that it 
> was triggering associated code in smmuv3 implementation.
>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>
> For a first version that's great. Later, we might want to generate 
> faults as well, to see that SMMU is correctly reporting an error on 
> incorrect transactions.
>
> I don't mind having a complex qos-smmuv3.c with gory details, since we 
> have a clear test here, that is easy to understand and modify.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


Thanks a lot for the review, the test, and the suggestion.


To be honest, when I wrote the initial version I didn’t really think 
about splitting the tests per mode. I was instead worrying about how to 
correctly call `qsmmu_cleanup_translation` after each translation mode 
to flush all SMMU caches so that the next mode wouldn’t be affected by 
leftover state. Your suggestion of separate test functions actually 
makes this a lot cleaner: each test starts from a fresh QEMU/SMMU state, 
and I don’t need to overthink the cleanup between different modes.


I'll refactor test_smmuv3_translation code a bit, but leave everything 
else the same. The refactoring code will be like:


static void test_smmuv3_ns_s1_only(void)
{
     run_smmuv3_translation(&base_test_configs[0]);
}

static void test_smmuv3_ns_s2_only(void)
{
     run_smmuv3_translation(&base_test_configs[1]);
}

static void test_smmuv3_ns_nested(void)
{
     run_smmuv3_translation(&base_test_configs[2]);
}

int main(int argc, char **argv)
{
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/iommu-testdev/translation/ns-s1-only",
                    test_smmuv3_ns_s1_only);
     qtest_add_func("/iommu-testdev/translation/ns-s2-only",
                    test_smmuv3_ns_s2_only);
     qtest_add_func("/iommu-testdev/translation/ns-nested",
                    test_smmuv3_ns_nested);
     return g_test_run();
}


Thanks again for running the coverage build and for the hint about 
adding fault-oriented tests; I’ll look into extending qos-smmuv3 in that 
direction as a follow-up.

Best regards,
Tao


