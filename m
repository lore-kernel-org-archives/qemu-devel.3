Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E021CEE32A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNuT-0003uy-SE; Tue, 18 Nov 2025 10:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vLNu1-0003kI-8d; Tue, 18 Nov 2025 10:45:59 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vLNtv-0001L1-1Q; Tue, 18 Nov 2025 10:45:55 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCnrmKhlBxpN0RNAg--.200S2;
 Tue, 18 Nov 2025 23:45:37 +0800 (CST)
Received: from [192.168.31.184] (unknown [222.244.181.28])
 by mail (Coremail) with SMTP id AQAAfwB3z+yTlBxpi6kFAA--.11350S2;
 Tue, 18 Nov 2025 23:45:31 +0800 (CST)
Message-ID: <4e59d4ed-2bd5-4b73-a61e-5def786063f7@phytium.com.cn>
Date: Tue, 18 Nov 2025 23:45:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 2/3] tests/qtest: add libqos SMMUv3 helper library
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251112162152.447327-1-tangtao1634@phytium.com.cn>
 <20251112162152.447327-3-tangtao1634@phytium.com.cn>
 <87zf8jk244.fsf@draig.linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <87zf8jk244.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3z+yTlBxpi6kFAA--.11350S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQASBWkbgZ4HDAABsx
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtFW3uw1xCF4UKF4UGFW7urg_yoWxZw4kpF
 1fA3ZIgrW8JF1fGwn3Xa18JrWSqrs7KwnrCryxtFnayw15Zrn2qr12gF1FgFyDX3yrZry8
 Zw4qqa15Zw15A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Hi Alex,

On 2025/11/18 19:32, Alex Bennée wrote:
> Tao Tang <tangtao1634@phytium.com.cn> writes:
>
>> Introduce qos-smmuv3, a reusable library for SMMUv3-related qtest
>> operations. This module encapsulates common tasks like:
>>
>> - SMMUv3 initialization (enabling, configuring command/event queues)
>> - Stream Table Entry (STE) and Context Descriptor (CD) setup
>> - Multi-level page table construction (L0-L3 for 4KB granules)
>> - Support for Stage 1, Stage 2, and nested translation modes
>> - Could be easily extended to support multi-space testing infrastructure
>>   (Non-Secure, Secure, Root, Realm)
>>
>> The library provides high-level abstractions that allow test code to
>> focus on IOMMU behavior validation rather than low-level register
>> manipulation and page table encoding. Key features include:
>>
>> - Automatic memory allocation for translation structures with proper
>>    alignment
>> - Helper functions to build valid STEs/CDs for different translation
>>    scenarios
>> - Page table walkers that handle address offset calculations per
>>    security space
>> - Command queue management for SMMU configuration commands
>>
>> This infrastructure is designed to be used by iommu-testdev-based tests
>> and future SMMUv3 test suites, reducing code duplication and improving
>> test maintainability.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   tests/qtest/libqos/meson.build  |   3 +
>>   tests/qtest/libqos/qos-smmuv3.c | 920 ++++++++++++++++++++++++++++++++
>>   tests/qtest/libqos/qos-smmuv3.h | 291 ++++++++++
>>   3 files changed, 1214 insertions(+)
>>   create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>>   create mode 100644 tests/qtest/libqos/qos-smmuv3.h
>>
>> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
>> index 1ddaf7b095..8d6758ec2b 100644
>> --- a/tests/qtest/libqos/meson.build
>> +++ b/tests/qtest/libqos/meson.build
>> @@ -60,6 +60,9 @@ libqos_srcs = files(
>>           'x86_64_pc-machine.c',
>>           'riscv-virt-machine.c',
>>           'loongarch-virt-machine.c',
>> +
>> +        # SMMU:
>> +        'qos-smmuv3.c',
>>   )
>>   
>>   if have_virtfs
>> diff --git a/tests/qtest/libqos/qos-smmuv3.c b/tests/qtest/libqos/qos-smmuv3.c
>> new file mode 100644
>> index 0000000000..1b97b8b5e6
>> --- /dev/null
>> +++ b/tests/qtest/libqos/qos-smmuv3.c
>> @@ -0,0 +1,920 @@
>> +/*
>> + * QOS SMMUv3 Module
>> + *
>> + * This module provides SMMUv3-specific helper functions for libqos tests,
>> + * encapsulating SMMUv3 setup, assertion, and cleanup operations.
>> + *
>> + * Copyright (c) 2025 Phytium Technology
>> + *
>> + * Author:
>> + *  Tao Tang <tangtao1634@phytium.com.cn>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "tests/qtest/libqos/pci.h"
>> +#include "hw/misc/iommu-testdev.h"
>> +#include "qos-smmuv3.h"
>> +
>> +/* STE/CD field setting macros */
>> +#define QSMMU_STE_OR_CD_ENTRY_BYTES 64
>> +#define QSMMU_STE_S2T0SZ_VAL 0x14
>> +
>> +#define QSMMU_STE_SET_VALID(ste, val)                                   \
>> +    ((ste)->word[0] = ((ste)->word[0] & ~(0x1 << 0)) |                  \
>> +                      (((val) & 0x1) << 0))
>> +#define QSMMU_STE_SET_CONFIG(ste, val)                                  \
>> +    ((ste)->word[0] = ((ste)->word[0] & ~(0x7 << 1)) |                  \
>> +                      (((val) & 0x7) << 1))
>> +#define QSMMU_STE_SET_S1FMT(ste, val)                                   \
>> +    ((ste)->word[0] = ((ste)->word[0] & ~(0x3 << 4)) |                  \
>> +                      (((val) & 0x3) << 4))
>> +
>
> These macros are basically re-inventing what we have in
> include/hw/registerfields.h so instead you would have something like:
>
> REG32(STE, 0)
>      FIELD(STE, VALID, 0, 1)
>      FIELD(STE, CONFIG, 1, 7)
>      FIELD(STE, S1FMT, 4, 2)
> etc
>
> However as these are mirroring smmuv3-internal.h why aren't we using
> those?
>
> The fuller solution would be to update smmuv3-internal to used the
> REG/FIELD macros rather than doing it by hand. Although the register
> field API existed then we weren't so keen to standardise all this
> boilerplate back then.
>
>> +#define QSMMU_STE_SET_CTXPTR(ste, val) do {                             \
>> +    (ste)->word[0] = ((ste)->word[0] & 0x0000003fu) |                   \
>> +                     ((uint32_t)(val) & 0xffffffc0u);                   \
>> +    (ste)->word[1] = ((ste)->word[1] & 0xffff0000u) |                   \
>> +                     ((uint32_t)(((uint64_t)(val)) >> 32) &             \
>> +                      0x0000ffffu);                                     \
>> +} while (0)
>> +
>> +#define QSMMU_STE_SET_S1CDMAX(ste, val)                                 \
>> +    ((ste)->word[1] = ((ste)->word[1] & ~(0x1f << 27)) |                \
>> +                      (((val) & 0x1f) << 27))
>> +#define QSMMU_STE_SET_S1STALLD(ste, val)                                \
>> +    ((ste)->word[2] = ((ste)->word[2] & ~(0x1 << 27)) |                 \
>> +                      (((val) & 0x1) << 27))
>> +#define QSMMU_STE_SET_EATS(ste, val)                                    \
>> +    ((ste)->word[2] = ((ste)->word[2] & ~(0x3 << 28)) |                 \
>> +                      (((val) & 0x3) << 28))
>> ------------------------------<snip>------------------------------
>> ------------------------------<snip>------------------------------
>> +
>> +
>> +/* STE and CD image structures */
>> +typedef struct {
>> +    uint32_t word[8];
>> +} STEImg;
>> +
>> +typedef struct {
>> +    uint32_t word[8];
>> +} CDImg;
>> +
> again we are duplicating smmuv3-internal here.
>
>

Thanks for the review. You are absolutely right—I shouldn't be 
reinventing the wheel here.

I am currently refactoring the code to use include/hw/registerfields.h 
as suggested, and I also plan to reuse the existing STE/CD structure 
definitions to avoid duplication.

Here is a snippet of how the refactoring looks so far (using the STE 
S2CFG/S2TTB as an example):


REG32(STE_S2CFG, 20)
     FIELD(STE_S2CFG, S2T0SZ, 0, 6)
     FIELD(STE_S2CFG, S2SL0, 6, 2)
     FIELD(STE_S2CFG, S2TG, 14, 2)
REG32(STE_S2TTB_LO, 24)
     FIELD(STE_S2TTB_LO, S2TTB_LO, 4, 28)
REG32(STE_S2TTB_HI, 28)
     FIELD(STE_S2TTB_HI, S2TTB_HI, 0, 16)

/* Set STE.S2T0SZ/S2SL0/S2TG */
#define STE_SET_S2T0SZ(ste, v)                                  \
     ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_S2CFG, S2T0SZ, (v)))
#define STE_SET_S2SL0(ste, v)                                  \
     ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_S2CFG, S2SL0, (v)))
#define STE_SET_S2TG(ste, v)                                    \
     ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_S2CFG, S2TG, (v)))


/* Set STE.S2TTB */
#define STE_S2TTB(x)                                        \
     (((uint64_t)FIELD_EX32((x)->word[7], STE_S2TTB_HI, S2TTB_HI) << 32) 
|   \
      ((uint64_t)FIELD_EX32((x)->word[6], STE_S2TTB_LO, S2TTB_LO) << 4))


Could you please confirm if this implementation aligns with what you had 
in mind? I would really appreciate your feedback on this direction 
before I finalize the v4 patch. Also these changes woule be applied in 
another Secure SMMU patch series [1] in the next few days.

[1] 
https://lore.kernel.org/qemu-devel/20251012150701.4127034-1-tangtao1634@phytium.com.cn/


Thanks,

Tao



