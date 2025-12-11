Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85831D3E79D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 08:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbhp-0007jO-6O; Thu, 11 Dec 2025 03:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vTbhm-0007iw-JB; Thu, 11 Dec 2025 03:07:18 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vTbhj-0008L0-P8; Thu, 11 Dec 2025 03:07:18 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBXXpqjezppzo1SAw--.948S2;
 Thu, 11 Dec 2025 16:06:59 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAngO2dezpp2SsLAA--.21399S2;
 Thu, 11 Dec 2025 16:06:54 +0800 (CST)
Message-ID: <e7ccf5cc-0411-4c89-871f-c1087095a1aa@phytium.com.cn>
Date: Thu, 11 Dec 2025 16:06:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 4/4] tests/qtest: Add SMMUv3 bare-metal test using
 iommu-testdev
To: eric.auger@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251126154547.1300748-1-tangtao1634@phytium.com.cn>
 <20251126154547.1300748-5-tangtao1634@phytium.com.cn>
 <629e6b11-069e-45c9-9119-b310db85a82d@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <629e6b11-069e-45c9-9119-b310db85a82d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAngO2dezpp2SsLAA--.21399S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWk4gq0InAAJsn
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxuFy8Cr43XFWUtr1Utr13Arb_yoW5ZFWfpa
 y8CayakF4kGr1fJas3Aw4xZF13KrZ3GF1jkr1fKr1Syrn0vry7tF48Kry5KF97JrWkZF18
 Za10kay5urn0qFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025/12/11 02:45, Eric Auger wrote:
>
> On 11/26/25 4:45 PM, Tao Tang wrote:
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
>>      (Non-Secure, Secure, Root, Realm)
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
>>   tests/qtest/iommu-smmuv3-test.c | 114 ++++++++++++++++++++++++++++++++
>>   tests/qtest/meson.build         |   1 +
>>   2 files changed, 115 insertions(+)
>>   create mode 100644 tests/qtest/iommu-smmuv3-test.c
>>
>> diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
>> new file mode 100644
>> index 0000000000..af438ecce0
>> --- /dev/null
>> +++ b/tests/qtest/iommu-smmuv3-test.c
>> @@ -0,0 +1,114 @@
>> +/*
>> + * QTest for SMMUv3 with iommu-testdev
>> + *
>> + * This QTest file is used to test the SMMUv3 with iommu-testdev so that we can
>> + * test SMMUv3 without any guest kernel or firmware.
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
>> +#include "libqtest.h"
>> +#include "libqos/pci.h"
>> +#include "libqos/generic-pcihost.h"
>> +#include "hw/pci/pci_regs.h"
>> +#include "hw/misc/iommu-testdev.h"
>> +#include "libqos/qos-smmuv3.h"
>> +
>> +#define DMA_LEN           4
>> +
>> +/* Test configurations for different SMMU modes and spaces */
>> +static const QSMMUTestConfig base_test_configs[] = {
>> +    {
>> +        .trans_mode = QSMMU_TM_S1_ONLY,
>> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
>> +        .dma_iova = QSMMU_IOVA_OR_IPA,
> what does this mean? QSMMU_IOVA_OR_IPA
>
> Eric


`QSMMU_IOVA_OR_IPA` was intended to represent the address that is seen 
as the *input* to the SMMU in the test. In other words:

     - for the S1-only and nested cases, this value is used as the IOVA, and
     - for the S2-only case, the same numeric value is used as the IPA.

So conceptually it is “the address fed into the IOMMU”, and the actual 
interpretation depends on `trans_mode`.

I agree the name `IOVA_OR_IPA` is confusing and does not make this model 
very clear.


Maybe we could use `QSMMU_DMA_INPUT_ADDR`  instead?


Thanks for catching this.

Tao



