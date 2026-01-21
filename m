Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B6FC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 15:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viaMH-0007aN-P7; Wed, 21 Jan 2026 10:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1viaMA-0007RD-Vk; Wed, 21 Jan 2026 10:42:55 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1viaM7-00028D-T4; Wed, 21 Jan 2026 10:42:54 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3PlL083Bp62BHAw--.11475S2;
 Wed, 21 Jan 2026 23:42:44 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.118.47])
 by mail (Coremail) with SMTP id AQAAfwCX8e7y83BpE38VAA--.44000S2;
 Wed, 21 Jan 2026 23:42:42 +0800 (CST)
Message-ID: <014d8d81-cf3f-41bf-ac0b-e7746aed520f@phytium.com.cn>
Date: Wed, 21 Jan 2026 23:42:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v9 3/8] hw/misc: Introduce iommu-testdev for bare-metal
 IOMMU testing
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20260119161112.3841386-1-tangtao1634@phytium.com.cn>
 <20260119161112.3841386-4-tangtao1634@phytium.com.cn>
 <c9308d86-889f-4ca3-8f67-eb6b253987da@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <c9308d86-889f-4ca3-8f67-eb6b253987da@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX8e7y83BpE38VAA--.44000S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQACBWlv4X8GvAABsl
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWr1rGF1xGrW7WFy5ur48JFb_yoWrWw4DpF
 ykGFWfKFW8JrWxCr1fZw18tFy5GF4kJw1jkr1xtF15Wr9xAry0qr1jgryjg348Gw4kZF10
 vw1Dta4Uuw4rZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2026/1/21 02:31, Philippe Mathieu-Daudé wrote:
> On 19/1/26 17:11, Tao Tang wrote:
>> Add a minimal PCI test device designed to exercise IOMMU translation
>> (such as ARM SMMUv3) without requiring guest firmware or OS. The device
>> provides MMIO registers to configure and trigger DMA operations with
>> controllable attributes (security state, address space), enabling
>> deterministic IOMMU testing.
>>
>> Key features:
>> - Bare-metal IOMMU testing via simple MMIO interface
>> - Configurable DMA attributes for security states and address spaces
>> - Write-then-read verification pattern with automatic result checking
>>
>> The device performs a deterministic DMA test pattern: write a known
>> value (0x12345678) to a configured GVA, read it back, and verify data
>> integrity. Results are reported through a dedicated result register,
>> eliminating the need for complex interrupt handling or driver
>> infrastructure in tests.
>>
>> This is purely a test device and not intended for production use or
>> machine realism. It complements existing test infrastructure like
>> pci-testdev but focuses specifically on IOMMU translation path
>> validation.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   MAINTAINERS                     |   7 +
>>   docs/specs/index.rst            |   1 +
>>   docs/specs/iommu-testdev.rst    | 138 ++++++++++++++
>>   hw/misc/Kconfig                 |   5 +
>>   hw/misc/iommu-testdev.c         | 318 ++++++++++++++++++++++++++++++++
>>   hw/misc/meson.build             |   1 +
>>   hw/misc/trace-events            |  10 +
>>   include/hw/misc/iommu-testdev.h |  87 +++++++++
>>   8 files changed, 567 insertions(+)
>>   create mode 100644 docs/specs/iommu-testdev.rst
>>   create mode 100644 hw/misc/iommu-testdev.c
>>   create mode 100644 include/hw/misc/iommu-testdev.h
>
>
>> diff --git a/docs/specs/iommu-testdev.rst b/docs/specs/iommu-testdev.rst
>> new file mode 100644
>> index 0000000000..e15f9a55a7
>> --- /dev/null
>> +++ b/docs/specs/iommu-testdev.rst
>> @@ -0,0 +1,138 @@
>
> Squashing 'SPDX-License-Identifier: GPL-2.0-or-later' like .c & .h.

Hi Philippe,

Thanks for catching this. I’ll pay attention to this in the future.

Regards,

Tao


>
>> +iommu-testdev — IOMMU test device for bare-metal testing
>> +=========================================================
>> +
>> +Overview
>> +--------
>> +``iommu-testdev`` is a minimal, test-only PCI device designed to 
>> exercise
>> +IOMMU translation (such as ARM SMMUv3) without requiring firmware or 
>> a guest
>> +OS. Tests can populate IOMMU translation tables with known values 
>> and trigger
>> +DMA operations that flow through the IOMMU translation path. It is 
>> **not** a
>> +faithful PCIe endpoint and must be considered a QEMU-internal test 
>> vehicle.
>   ...
>
>> diff --git a/hw/misc/iommu-testdev.c b/hw/misc/iommu-testdev.c
>> new file mode 100644
>> index 0000000000..15eb6de78a
>> --- /dev/null
>> +++ b/hw/misc/iommu-testdev.c
>> @@ -0,0 +1,318 @@
>> +/*
>> + * A test device for IOMMU
>> + *
>> + * Copyright (c) 2026 Phytium Technology
>> + *
>> + * Author:
>> + *  Tao Tang <tangtao1634@phytium.com.cn>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>
>
>> diff --git a/include/hw/misc/iommu-testdev.h 
>> b/include/hw/misc/iommu-testdev.h
>> new file mode 100644
>> index 0000000000..338365947c
>> --- /dev/null
>> +++ b/include/hw/misc/iommu-testdev.h
>> @@ -0,0 +1,87 @@
>> +/*
>> + * A test device for IOMMU
>> + *
>> + * Copyright (c) 2026 Phytium Technology
>> + *
>> + * Author:
>> + *  Tao Tang <tangtao1634@phytium.com.cn>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */


