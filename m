Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3746ED32D9B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXM7-0008Ah-RK; Fri, 05 Dec 2025 10:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRXM4-0008AL-Oq; Fri, 05 Dec 2025 10:04:20 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRXM1-0006Ed-J3; Fri, 05 Dec 2025 10:04:20 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHiJRo9DJpzusVAw--.2308S2;
 Fri, 05 Dec 2025 23:04:08 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.235.80])
 by mail (Coremail) with SMTP id AQAAfwAnge5c9DJp_9cJAA--.24971S2;
 Fri, 05 Dec 2025 23:04:04 +0800 (CST)
Message-ID: <b184c907-e073-43d0-87b9-cf8c6c23dbed@phytium.com.cn>
Date: Fri, 5 Dec 2025 23:03:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 3/4] tests/qtest/libqos: Add SMMUv3 helper library
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
 <20251126154547.1300748-4-tangtao1634@phytium.com.cn>
 <9b2c0429-a8bb-4df4-ad95-492f463cf29f@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <9b2c0429-a8bb-4df4-ad95-492f463cf29f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAnge5c9DJp_9cJAA--.24971S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAPBWkx6ywGXwABsM
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw1UXw4fZw45WFW8ur47CFg_yoWxGr18pF
 ykGrW5tFWUJFn3JF17Jw4UGry5Zr4xJw1DJr1IgFn8Jr4UCryjqr1jgryq9F1UJr4kXr1j
 vw1jgrnrZr1UJrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025/12/5 07:53, Pierrick Bouvier wrote:
> On 11/26/25 7:45 AM, Tao Tang wrote:
>> Introduce qos-smmuv3, a reusable library for SMMUv3-related qtest
>> operations. This module encapsulates common tasks like:
>>
>> - SMMUv3 initialization (enabling, configuring command/event queues)
>> - Stream Table Entry (STE) and Context Descriptor (CD) setup
>> - Multi-level page table construction (L0-L3 for 4KB granules)
>> - Support for Stage 1, Stage 2, and nested translation modes
>> - Could be easily extended to support multi-space testing infrastructure
>>      (Non-Secure, Secure, Root, Realm)
>>
>> The library provides high-level abstractions that allow test code to
>> focus on IOMMU behavior validation rather than low-level register
>> manipulation and page table encoding. Key features include:
>>
>> - Automatic memory allocation for translation structures with proper
>>      alignment
>> - Helper functions to build valid STEs/CDs for different translation
>>      scenarios
>> - Page table walkers that handle address offset calculations per
>>      security space
>> - Command queue management for SMMU configuration commands
>>
>> This infrastructure is designed to be used by iommu-testdev-based tests
>> and future SMMUv3 test suites, reducing code duplication and improving
>> test maintainability.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   tests/qtest/libqos/meson.build  |   3 +
>>   tests/qtest/libqos/qos-smmuv3.c | 731 ++++++++++++++++++++++++++++++++
>>   tests/qtest/libqos/qos-smmuv3.h | 267 ++++++++++++
>>   3 files changed, 1001 insertions(+)
>>   create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>>   create mode 100644 tests/qtest/libqos/qos-smmuv3.h
>>
>
> ...
>
>> +
>> +void qsmmu_single_translation(QSMMUTestContext *ctx)
>> +{
>> +    uint32_t config_result;
>> +    uint32_t dma_result;
>> +    bool test_passed;
>> +
>> +    /* Configure SMMU translation */
>> +    config_result = qsmmu_setup_and_enable_translation(ctx);
>> +    if (config_result != 0) {
>> +        g_test_message("Configuration failed: mode=%u status=0x%x",
>> +                       ctx->config.trans_mode, config_result);
>> +        return;
>
> Is that expected to silently return if we can't configure translation?


No, it is not intended to silently return on a failed configuration. 
Maybe an assertion is a better choice:


config_result = qsmmu_setup_and_enable_translation(ctx);

g_assert_cmpuint(config_result, ==, 0);

>
>> +    }
>> +
>> +    /* Trigger DMA operation */
>> +    dma_result = qsmmu_trigger_dma(ctx);
>> +    if (dma_result != 0) {
>> +        g_test_message("DMA failed: mode=%u result=0x%x",
>> +                       ctx->config.trans_mode, dma_result);
>> +    } else {
>> +        g_test_message("-> DMA succeeded: mode=%u", 
>> ctx->config.trans_mode);
>> +    }
>> +
>> +    /* Validate test result */
>> +    test_passed = qsmmu_validate_test_result(ctx);
>> +    g_assert_true(test_passed);
>> +
>> +    /* Clean up translation state to prepare for the next test */
>> +    qsmmu_cleanup_translation(ctx);
>> +}
>> +
>> +void qsmmu_translation_batch(const QSMMUTestConfig *configs, size_t 
>> count,
>> +                             QTestState *qts, QPCIDevice *dev,
>> +                             QPCIBar bar, uint64_t smmu_base)
>> +{
>> +    for (int i = 0; i < count; i++) {
>> +        /* Initialize test memory */
>> +        qtest_memset(qts, configs[i].dma_iova, 0x00, 
>> configs[i].dma_len);
>> +        /* Execute each test configuration */
>> +        QSMMUTestContext ctx = {
>> +            .qts = qts,
>> +            .dev = dev,
>> +            .bar = bar,
>> +            .smmu_base = smmu_base,
>> +            .config = configs[i],
>> +            .trans_status = 0,
>> +            .dma_result = 0,
>> +            .sid = dev->devfn,
>> +            .tx_space = qsmmu_sec_sid_to_space(configs[i].sec_sid),
>> +        };
>> +
>> +        qsmmu_single_translation(&ctx);
>> +        g_test_message("--> Test %d completed: mode=%u sec_sid=%u "
>> +                       "status=0x%x result=0x%x", i, 
>> configs[i].trans_mode,
>> +                       configs[i].sec_sid, ctx.trans_status, 
>> ctx.dma_result);
>> +    }
>> +}
>
> What is the reason for batching operations?
> We are not in a performance critical scenario for running this test, 
> so it's probably better to have distinct calls to single_translation.


As described in the previous thread [1] , I plan to split the tests so 
that each translation mode is exercised by its own qtest. With that 
split in place, there is no real need for a qsmmu_translation_batch() 
helper anymore, so I refactor it into a qsmmu_run_translation_case 
function and drop the inside for-loop.


[1] 
https://lore.kernel.org/qemu-devel/7370070a-c569-4b77-bd1e-6fc749ba9c90@phytium.com.cn/

>
> ...
>
> For the rest of the patch, which is quite consequent, congrats. It's 
> hard to review all the setup phase here, but knowing it works with the 
> current smmuv3 implementation, that's a good proof that it's working 
> as expected.


Yes, setting up all this infrastructure did take some time, especially 
getting the nested mode page tables right (and Secure state-related 
configuration which is still in my local repo).

I really appreciate that you ran the tests yourself and even checked 
with a coverage-enabled build to confirm that it exercises the smmuv3 
implementation. Thanks again for the thorough review.


Best regards,

Tao


