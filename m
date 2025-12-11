Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C9FD41C14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 09:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTd9M-0006qX-8v; Thu, 11 Dec 2025 04:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vTd9F-0006pQ-Dp; Thu, 11 Dec 2025 04:39:45 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vTd99-0004yx-Kz; Thu, 11 Dec 2025 04:39:43 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAH6CRSkTpp4nJcAQ--.37767S2;
 Thu, 11 Dec 2025 17:39:30 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAnge5PkTppZS8LAA--.27025S2;
 Thu, 11 Dec 2025 17:39:27 +0800 (CST)
Message-ID: <2e54cc59-1c76-482f-834d-f75e309ed7db@phytium.com.cn>
Date: Thu, 11 Dec 2025 17:39:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 3/4] tests/qtest/libqos: Add SMMUv3 helper library
To: eric.auger@redhat.com, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251126154547.1300748-1-tangtao1634@phytium.com.cn>
 <20251126154547.1300748-4-tangtao1634@phytium.com.cn>
 <9b2c0429-a8bb-4df4-ad95-492f463cf29f@linaro.org>
 <e95d82af-540f-43b0-9f0c-2e5928192049@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <e95d82af-540f-43b0-9f0c-2e5928192049@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAnge5PkTppZS8LAA--.27025S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWk51DEDpAABsW
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxuFW3ury5CryxGF4xtF1UJrb_yoWxGFyrpF
 ykGFW5trWUJFn5Jr17Gr1UGry5Ar4xJw1UJr10gF1DJrZ5Ar12gr1jgryq9r1DJr48Xr1j
 vw1jgFnxur15JrDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Eric,

On 2025/12/11 02:43, Eric Auger wrote:
>
> On 12/5/25 12:53 AM, Pierrick Bouvier wrote:
>> On 11/26/25 7:45 AM, Tao Tang wrote:
>>> Introduce qos-smmuv3, a reusable library for SMMUv3-related qtest
>>> operations. This module encapsulates common tasks like:
>>>
>>> - SMMUv3 initialization (enabling, configuring command/event queues)
>>> - Stream Table Entry (STE) and Context Descriptor (CD) setup
>>> - Multi-level page table construction (L0-L3 for 4KB granules)
>>> - Support for Stage 1, Stage 2, and nested translation modes
>>> - Could be easily extended to support multi-space testing infrastructure
>>>       (Non-Secure, Secure, Root, Realm)
>>>
>>> The library provides high-level abstractions that allow test code to
>>> focus on IOMMU behavior validation rather than low-level register
>>> manipulation and page table encoding. Key features include:
>>>
>>> - Automatic memory allocation for translation structures with proper
>>>       alignment
>>> - Helper functions to build valid STEs/CDs for different translation
>>>       scenarios
>>> - Page table walkers that handle address offset calculations per
>>>       security space
>>> - Command queue management for SMMU configuration commands
>>>
>>> This infrastructure is designed to be used by iommu-testdev-based tests
>>> and future SMMUv3 test suites, reducing code duplication and improving
>>> test maintainability.
>>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> ---
>>>    tests/qtest/libqos/meson.build  |   3 +
>>>    tests/qtest/libqos/qos-smmuv3.c | 731 ++++++++++++++++++++++++++++++++
>>>    tests/qtest/libqos/qos-smmuv3.h | 267 ++++++++++++
>>>    3 files changed, 1001 insertions(+)
>>>    create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>>>    create mode 100644 tests/qtest/libqos/qos-smmuv3.h
>>>
>> ...
>>
>>> +
>>> +void qsmmu_single_translation(QSMMUTestContext *ctx)
>>> +{
>>> +    uint32_t config_result;
>>> +    uint32_t dma_result;
>>> +    bool test_passed;
>>> +
>>> +    /* Configure SMMU translation */
>>> +    config_result = qsmmu_setup_and_enable_translation(ctx);
>>> +    if (config_result != 0) {
>>> +        g_test_message("Configuration failed: mode=%u status=0x%x",
>>> +                       ctx->config.trans_mode, config_result);
>>> +        return;
>> Is that expected to silently return if we can't configure translation?
>>
>>> +    }
>>> +
>>> +    /* Trigger DMA operation */
>>> +    dma_result = qsmmu_trigger_dma(ctx);
>>> +    if (dma_result != 0) {
>>> +        g_test_message("DMA failed: mode=%u result=0x%x",
>>> +                       ctx->config.trans_mode, dma_result);
>>> +    } else {
>>> +        g_test_message("-> DMA succeeded: mode=%u",
>>> ctx->config.trans_mode);
>>> +    }
>>> +
>>> +    /* Validate test result */
>>> +    test_passed = qsmmu_validate_test_result(ctx);
>>> +    g_assert_true(test_passed);
>>> +
>>> +    /* Clean up translation state to prepare for the next test */
>>> +    qsmmu_cleanup_translation(ctx);
>>> +}
>>> +
>>> +void qsmmu_translation_batch(const QSMMUTestConfig *configs, size_t
>>> count,
>>> +                             QTestState *qts, QPCIDevice *dev,
>>> +                             QPCIBar bar, uint64_t smmu_base)
>>> +{
>>> +    for (int i = 0; i < count; i++) {
>>> +        /* Initialize test memory */
>>> +        qtest_memset(qts, configs[i].dma_iova, 0x00,
>>> configs[i].dma_len);
>>> +        /* Execute each test configuration */
>>> +        QSMMUTestContext ctx = {
>>> +            .qts = qts,
>>> +            .dev = dev,
>>> +            .bar = bar,
>>> +            .smmu_base = smmu_base,
>>> +            .config = configs[i],
>>> +            .trans_status = 0,
>>> +            .dma_result = 0,
>>> +            .sid = dev->devfn,
>>> +            .tx_space = qsmmu_sec_sid_to_space(configs[i].sec_sid),
>>> +        };
>>> +
>>> +        qsmmu_single_translation(&ctx);
>>> +        g_test_message("--> Test %d completed: mode=%u sec_sid=%u "
>>> +                       "status=0x%x result=0x%x", i,
>>> configs[i].trans_mode,
>>> +                       configs[i].sec_sid, ctx.trans_status,
>>> ctx.dma_result);
>>> +    }
>>> +}
>> What is the reason for batching operations?
>> We are not in a performance critical scenario for running this test,
>> so it's probably better to have distinct calls to single_translation.
>>
>> ...
>>
>> For the rest of the patch, which is quite consequent, congrats. It's
>> hard to review all the setup phase here, but knowing it works with the
>> current smmuv3 implementation, that's a good proof that it's working
>> as expected.
> That's a huge amount of code indeed. I don't how much we shall review
> this test lib but if it needs std review the patch needs to be split to
> ease the review. Maybe qtest maintainers can give some guidelines here...
>
> Eric


I agree that the current qos-smmuv3 patch is too big for a single 
review. When implementing this library I actually spent quite some time 
debugging it, especially getting the page tables right, which is part of 
why it initially came as one large chunk.

I plan to split it into several smaller patches along functional boundaries:

- one for the basic structures and common helpers, then separate patches 
for
- Stage-1,
- Stage-2,
- nested translation support,
- for the more complex nested case I can further split the changes if 
that makes the review easier.

I would very much appreciate qtest maintainers' professional advices on 
the overall shape and layering of this test library before I start 
splitting it up.


Best regards,

Tao


