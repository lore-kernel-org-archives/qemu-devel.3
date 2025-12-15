Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03619D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 03:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUzQI-0001vu-6x; Sun, 14 Dec 2025 22:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vUzQF-0001vS-JR; Sun, 14 Dec 2025 22:38:55 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vUzQB-0008AZ-Na; Sun, 14 Dec 2025 22:38:55 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAH6CTHgj9pjXV_AQ--.44228S2;
 Mon, 15 Dec 2025 11:38:47 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwC3DevCgj9pmAkMAA--.7881S2;
 Mon, 15 Dec 2025 11:38:43 +0800 (CST)
Message-ID: <97afc636-d7b3-4146-acb5-3f4c292f792d@phytium.com.cn>
Date: Mon, 15 Dec 2025 11:38:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v6 4/4] tests/qtest: Add SMMUv3 bare-metal test using
 iommu-testdev
To: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251206155203.3015881-1-tangtao1634@phytium.com.cn>
 <20251206155203.3015881-5-tangtao1634@phytium.com.cn>
 <87ms3nvae3.fsf@suse.de>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <87ms3nvae3.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwC3DevCgj9pmAkMAA--.7881S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAFBWk-GiAB6wABsG
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZFyrJr1UJryDKF45JFW3trb_yoWrGw4xpF
 yUCFyYkF4xJr1xC3ZxXws7AF1Sgrs7Jr1UCr1fKF1akwn0yryxtryxKrW5KrZ7JaykXF1r
 Z3Wvka4rWrn5XaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Fabiano,

On 2025/12/13 02:10, Fabiano Rosas wrote:
> Tao Tang <tangtao1634@phytium.com.cn> writes:
>
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
>> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   tests/qtest/iommu-smmuv3-test.c | 131 ++++++++++++++++++++++++++++++++
>>   tests/qtest/meson.build         |   1 +
>>   2 files changed, 132 insertions(+)
>>   create mode 100644 tests/qtest/iommu-smmuv3-test.c
>>
>> diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
>> new file mode 100644
>> index 0000000000..96f66ee325
>> --- /dev/null
>> +++ b/tests/qtest/iommu-smmuv3-test.c
>> @@ -0,0 +1,131 @@
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
>> +static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QGenericPCIBus *gbus,
>> +                                          QPCIBar *bar)
>> +{
>> +    uint16_t vid, did;
>> +    QPCIDevice *dev = NULL;
>> +
>> +    qpci_init_generic(gbus, qts, NULL, false);
>> +
>> +    /* Find device by vendor/device ID to avoid slot surprises. */
>> +    for (int s = 0; s < 32 && !dev; s++) {
>> +        for (int fn = 0; fn < 8 && !dev; fn++) {
>> +            QPCIDevice *cand = qpci_device_find(&gbus->bus, QPCI_DEVFN(s, fn));
>> +            if (!cand) {
>> +                continue;
>> +            }
>> +            vid = qpci_config_readw(cand, PCI_VENDOR_ID);
>> +            did = qpci_config_readw(cand, PCI_DEVICE_ID);
>> +            if (vid == IOMMU_TESTDEV_VENDOR_ID &&
>> +                did == IOMMU_TESTDEV_DEVICE_ID) {
>> +                dev = cand;
>> +                g_test_message("Found iommu-testdev! devfn: 0x%x", cand->devfn);
>> +            } else {
>> +                g_free(cand);
>> +            }
>> +        }
>> +    }
> This loop could be replaced with something simpler:
>
>    static void save_fn(QPCIDevice *dev, int devfn, void *data)
>    {
>        QPCIDevice **pdev = (QPCIDevice **) data;
>        *pdev = dev;
>    }
>
>    qpci_device_foreach(&gbus->bus, IOMMU_TESTDEV_VENDOR_ID,
>                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);


Thanks for the suggestion.

I looked into this pattern and it does seem to be the standard approach 
in QEMU qtests (e.g. tests/qtest/ivshmem-test.c). I will update the code 
accordingly in the next revision.


Regards,

Tao


