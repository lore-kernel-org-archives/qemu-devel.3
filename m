Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F13C98321
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 13:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh630-0001MB-0O; Sat, 17 Jan 2026 08:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vh61F-0000UE-1P; Sat, 17 Jan 2026 08:07:10 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vh61C-0003wH-1V; Sat, 17 Jan 2026 08:07:08 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3GSZxiWtpTVwrAw--.16681S2;
 Sat, 17 Jan 2026 21:06:57 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.235.43])
 by mail (Coremail) with SMTP id AQAAfwAHX+xuiWtpH3MUAA--.35617S2;
 Sat, 17 Jan 2026 21:06:55 +0800 (CST)
Message-ID: <4912e000-a59e-4a33-9521-167d6db0786a@phytium.com.cn>
Date: Sat, 17 Jan 2026 21:06:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 6/7] tests/qtest/libqos: Add SMMUv3 helper library
To: eric.auger@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-7-tangtao1634@phytium.com.cn>
 <3ddf9d2b-5011-4c41-95bc-af935dc8579c@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <3ddf9d2b-5011-4c41-95bc-af935dc8579c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAHX+xuiWtpH3MUAA--.35617S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQARBWlpSgQHHAAHsH
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtFW3uw1xuw1rAw45uF4kJFb_yoW3Wr1kp3
 W3GF43tFW8JF1fJrnrtw4UCw1agrs3Kr47Ar18Kwn5A34vvr1xtr1UKrWF9FWxJrykJF48
 Zr4jg3Zxur1UAaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Hi Eric,

On 2026/1/17 18:02, Eric Auger wrote:
> Hi Tao,
>
> On 12/24/25 4:46 AM, Tao Tang wrote:
>> Introduce qos-smmuv3, a reusable library for SMMUv3-related qtest
>> operations. This module encapsulates common tasks like:
>>
>> - SMMUv3 initialization (enabling, configuring command/event queues)
>> - Stream Table Entry (STE) and Context Descriptor (CD) setup
>> - Multi-level page table construction (L0-L3 for 4KB granules)
>> - Support for Stage 1, Stage 2, and nested translation modes
>> - Could be easily extended to support multi-space testing infrastructure
>>      (Non-Secure, Secure, Root, Realm)
>>
>> The library provides high-level abstractions that allow test code to
>> focus on IOMMU behavior validation rather than low-level register
>> manipulation and page table encoding. Key features include:
>>
>> - Provide memory allocation for translation structures with proper
>>      alignment
>> - Helper functions to build valid STEs/CDs for different translation
>>      scenarios
>> - Page table walkers that handle address offset calculations per
>>      security space
>>
>> This infrastructure is designed to be used by iommu-testdev-based tests
>> and future SMMUv3 test suites, reducing code duplication and improving
>> test maintainability.
>>
>> Signed-off-by: Tao Tang<tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
>> Reviewed-by: Fabiano Rosas<farosas@suse.de>
>> ---
>>   MAINTAINERS                     |   6 +
>>   tests/qtest/libqos/meson.build  |   3 +
>>   tests/qtest/libqos/qos-smmuv3.c | 633 ++++++++++++++++++++++++++++++++
>>   tests/qtest/libqos/qos-smmuv3.h | 256 +++++++++++++
>>   4 files changed, 898 insertions(+)
>>   create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>>   create mode 100644 tests/qtest/libqos/qos-smmuv3.h
>>
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +
>> +uint32_t qsmmu_trigger_dma(QSMMUTestContext *ctx)
> qsmmu_trigger_dma and  qsmmu_single_translation  helpers which do not really relate to SMMU but rather relate to the pci
> test dev. put them in a specific section of this file or move them in a
> separate file. They could be reused by other non SMMU specific tests


Agreed — that’s a better separation. I’ll move these two helpers out of 
qos-smmuv3 into a generic libqos helper (something like 
qos-iommu-testdev.[ch]).

>
>> +{
>> +    uint32_t result, attrs_val;
>> +
>> +    /* Program DMA parameters */
>> +    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_GVA_LO,
>> +                   (uint32_t)ctx->config.dma_iova);
>> +    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_GVA_HI,
>> +                   (uint32_t)(ctx->config.dma_iova >> 32));
>> +    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_LEN,
>> +                   ctx->config.dma_len);
>> +
>> +    /* Build and write DMA attributes based on device security state. */
>> +    attrs_val = qsmmu_build_dma_attrs(QSMMU_SPACE_NONSECURE);
>> +    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_ATTRS, attrs_val);
>> +
>> +    /* Flip status */
>> +    /* Arm iommu-testdev so the next read triggers DMA */
>> +    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_DBELL, ITD_DMA_DBELL_ARM);
>> +
>> +    /* Trigger DMA */
>> +    qpci_io_readl(ctx->dev, ctx->bar, ITD_REG_DMA_TRIGGERING);
>> +
>> +    /* Poll for DMA completion */
>> +    for (int i = 0; i < 1000; i++) {
>> +        result = qpci_io_readl(ctx->dev, ctx->bar, ITD_REG_DMA_RESULT);
>> +        if (result != ITD_DMA_RESULT_BUSY) {
>> +            ctx->dma_result = result;
>> +            break;
>> +        }
>> +        g_usleep(1000);
>> +    }
>> +
>> +    /* Fallback for timeout */
>> +    if (ctx->dma_result == ITD_DMA_RESULT_BUSY) {
>> +        ctx->dma_result = ITD_DMA_ERR_TX_FAIL;
>> +    }
>> +
>> +    return ctx->dma_result;
>> +}
>> +
>> +bool qsmmu_validate_test_result(QSMMUTestContext *ctx)
>> +{
>> +    uint32_t expected = qsmmu_expected_dma_result(ctx);
>> +    g_test_message("-> Validating result: expected=0x%x actual=0x%x",
>> +                   expected, ctx->dma_result);
>> +    return (ctx->dma_result == expected);
>> +}
>> +
>> +QSMMUSpace qsmmu_sec_sid_to_space(QSMMUSecSID sec_sid)
>> +{
>> +    switch (sec_sid) {
>> +    case QSMMU_SEC_SID_NONSECURE:
>> +        return QSMMU_SPACE_NONSECURE;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +uint64_t qsmmu_space_offset(QSMMUSpace sp)
>> +{
>> +    switch (sp) {
>> +    case QSMMU_SPACE_NONSECURE:
>> +        return QSMMU_SPACE_OFFS_NS;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +void qsmmu_single_translation(QSMMUTestContext *ctx)
>> +{
>> +    uint32_t config_result;
>> +    uint32_t dma_result;
>> +
>> +    /* Configure SMMU translation */
>> +    config_result = qsmmu_setup_and_enable_translation(ctx);
>> +    g_assert_cmpuint(config_result, ==, 0);
>> +
>> +    /* Trigger DMA operation */
>> +    dma_result = qsmmu_trigger_dma(ctx);
>> +    if (dma_result != 0) {
>> +        g_test_message("DMA failed: mode=%u result=0x%x",
>> +                       ctx->config.trans_mode, dma_result);
>> +    } else {
>> +        g_test_message("-> DMA succeeded: mode=%u", ctx->config.trans_mode);
>> +    }
>> +
>> +    /* Validate test result */
>> +    g_assert_true(qsmmu_validate_test_result(ctx));
>> +}
>> +
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> diff --git a/tests/qtest/libqos/qos-smmuv3.h b/tests/qtest/libqos/qos-smmuv3.h
>> new file mode 100644
>> index 0000000000..375778517f
>> --- /dev/null
>> +++ b/tests/qtest/libqos/qos-smmuv3.h
>> @@ -0,0 +1,256 @@
>> +/*
>> + * QOS SMMUv3 Module
>> + *
>> + * This module provides SMMUv3-specific helper functions for libqos tests,
>> + * encapsulating SMMUv3 setup, and assertions.
>> + *
>> + * Copyright (c) 2025 Phytium Technology
>> + *
>> + * Author:
>> + *  Tao Tang<tangtao1634@phytium.com.cn>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef QTEST_LIBQOS_SMMUV3_H
>> +#define QTEST_LIBQOS_SMMUV3_H
>> +
>> +#include "hw/misc/iommu-testdev.h"
>> +
>> +/*
>> + * SMMU MMIO register base. We hardcode this as base_memmap is 'static const'
>> + * in hw/arm/virt.c and not directly accessible here.
>> + */
>> +#define VIRT_SMMU_BASE            0x0000000009050000ull
>> +
>> +/* SMMU queue and table base addresses */
>> +#define QSMMU_CMDQ_BASE_ADDR      0x000000000e16b000ull
>> +#define QSMMU_EVENTQ_BASE_ADDR    0x000000000e170000ull
>> +
>> +/*
>> + * Translation tables and descriptors for a mapping of
>> + *   - IOVA(Stage 1 only)
> you mentionned you also support S1 + S2

Yes there should be `- IOVA(Stage 1 and nested translation stage)`.


>> + *   - IPA (Stage 2 only)
>> + * to GPA.
>> + *
>> + * The translation is based on the Arm architecture with the following
>> + * prerequisites:
>> + * - Granule size: 4KB pages.
> would be nice to support 64kB as well in the future. Can be done later
> though.
>> + * - Page table levels: 4 levels (L0, L1, L2, L3), starting at level 0.
>> + * - IOVA size: The walk resolves a IOVA: 0x8080604567
> well this is passed as a test config parameter and this is does not
> sound relevant to hardcode it.


I initially wanted dma_iova to be configurable and have the page-table 
builder follow it, but I didn’t find a clean way to keep the table 
construction in sync.

So for now I’ll likely drop QSMMUTestConfig.dma_iova and consistently 
use the fixed QSMMU_IOVA for both table setup and DMA, to avoid a 
misleading knob. We can revisit later to make IOVA + tables 
configurable, and potentially add 64KB granule support as well.


Thanks,
Tao


