Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8A7E8FDB0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 05:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZMfI-00011x-W1; Sat, 27 Dec 2025 00:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vZMfH-00011P-1h; Sat, 27 Dec 2025 00:16:31 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vZMfE-0004nP-Qr; Sat, 27 Dec 2025 00:16:30 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBXOCWoa09p6kBMAg--.44401S2;
 Sat, 27 Dec 2025 13:16:24 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.232.145])
 by mail (Coremail) with SMTP id AQAAfwBXsO2ka09pzh0PAA--.13006S2;
 Sat, 27 Dec 2025 13:16:20 +0800 (CST)
Message-ID: <e77c63ea-471f-4bea-af4b-378081446e0a@phytium.com.cn>
Date: Sat, 27 Dec 2025 13:16:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 3/7] hw/misc: Introduce iommu-testdev for bare-metal
 IOMMU testing
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-4-tangtao1634@phytium.com.cn>
 <f3c919df-076c-4f19-ba28-686c713fc53f@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <f3c919df-076c-4f19-ba28-686c713fc53f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXsO2ka09pzh0PAA--.13006S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAQBWlNmrIGFAAFsP
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCw17ZryUGr48JFWrWFyfJFb_yoW5AFyfpF
 ykKay5KFy8Arn3Cr4fXw1UWFy5WF4kJw1Y9r17JF1jgryYyry0qr4Uuw1jg3ykJrsYqF17
 Z3yDK3WUuw45ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Hi Philippe,

On 2025/12/27 06:56, Philippe Mathieu-Daudé wrote:
> Hi Tao,
>
> On 24/12/25 04:46, Tao Tang wrote:
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
>>   docs/specs/iommu-testdev.rst    | 112 +++++++++++++
>>   hw/misc/Kconfig                 |   5 +
>>   hw/misc/iommu-testdev.c         | 271 ++++++++++++++++++++++++++++++++
>>   hw/misc/meson.build             |   1 +
>>   hw/misc/trace-events            |  10 ++
>>   include/hw/misc/iommu-testdev.h |  68 ++++++++
>>   8 files changed, 475 insertions(+)
>>   create mode 100644 docs/specs/iommu-testdev.rst
>>   create mode 100644 hw/misc/iommu-testdev.c
>>   create mode 100644 include/hw/misc/iommu-testdev.h
>
>
>> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>> index fccd735c24..b5f6fdbd9c 100644
>> --- a/hw/misc/Kconfig
>> +++ b/hw/misc/Kconfig
>> @@ -25,6 +25,11 @@ config PCI_TESTDEV
>>       default y if TEST_DEVICES
>>       depends on PCI
>>   +config IOMMU_TESTDEV
>> +    bool
>> +    default y if TEST_DEVICES
>> +    depends on PCI
>
>        "depends on PCI && ARM"
>
> ?


Thanks for your review.


iommu-testdev is intended to be a generic PCI test DMA engine, usable to 
exercise different IOMMU models, not ARM-specific. The current series 
uses SMMUv3 as the first backend/example, but the device itself should 
only depend on PCI and is gated by TEST_DEVICES.


Regards,

Tao


