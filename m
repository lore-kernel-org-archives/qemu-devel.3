Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8BBE7490A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 03:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYFiX-0004T1-8u; Tue, 23 Dec 2025 22:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vYFiT-0004Re-Fj; Tue, 23 Dec 2025 22:39:14 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vYFiR-00052V-1P; Tue, 23 Dec 2025 22:39:13 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn7JhTYEtp0pNUBA--.498S2;
 Wed, 24 Dec 2025 11:38:59 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwC3D+1PYEtpdEwOAA--.11838S2;
 Wed, 24 Dec 2025 11:38:56 +0800 (CST)
Message-ID: <8e6451a1-cb89-4e2a-b872-309fbf2789fa@phytium.com.cn>
Date: Wed, 24 Dec 2025 11:38:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v7 6/7] tests/qtest/libqos: Add SMMUv3 helper library
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
References: <20251222124517.3948679-1-tangtao1634@phytium.com.cn>
 <20251222124517.3948679-7-tangtao1634@phytium.com.cn>
 <636d7352-794e-49e3-9e3a-6e32c1e8472d@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <636d7352-794e-49e3-9e3a-6e32c1e8472d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwC3D+1PYEtpdEwOAA--.11838S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWlK96sBiwAAs-
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF4rtF4xtFW5tFyUKFy8Xwb_yoWrurW8pF
 18Jw15JryUJr1xJr1UJr1UJry5Jr48Jw1UJr17JF1UJr1UJr1jqr1UXr1jgr1UJr48Jr1U
 Xw1UJr1UZr1UJrUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/12/23 06:29, Pierrick Bouvier wrote:
> On 12/22/25 4:45 AM, Tao Tang wrote:
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
>> - Provide memory allocation for translation structures with proper
>>      alignment
>> - Helper functions to build valid STEs/CDs for different translation
>>      scenarios
>> - Page table walkers that handle address offset calculations per
>>      security space
>>
>> This infrastructure is designed to be used by iommu-testdev-based tests
>> and future SMMUv3 test suites, reducing code duplication and improving
>> test maintainability.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   MAINTAINERS                     |   6 +
>>   tests/qtest/libqos/meson.build  |   3 +
>>   tests/qtest/libqos/qos-smmuv3.c | 632 ++++++++++++++++++++++++++++++++
>>   tests/qtest/libqos/qos-smmuv3.h | 256 +++++++++++++
>>   4 files changed, 897 insertions(+)
>>   create mode 100644 tests/qtest/libqos/qos-smmuv3.c
>>   create mode 100644 tests/qtest/libqos/qos-smmuv3.h
>>
>
> ...
>
>> +void qsmmu_setup_translation_tables(QTestState *qts,
>> +                                    uint64_t iova,
>> +                                    QSMMUSpace space,
>> +                                    bool is_cd,
>> +                                    QSMMUTransMode mode)
>> +{
>> +    uint64_t all_s2_l0_pte_val, all_s2_l1_pte_val, all_s2_l2_pte_val;
>> +    uint64_t s1_vttb, s2_vttb, s1_leaf_pte_val;
>> +    uint64_t l0_addr, l1_addr, l2_addr, l3_addr;
>> +
>> +    g_test_message("Begin of construction: IOVA=0x%lx mode=%d 
>> is_building_CD=%s"
>> +                   " ===", iova, mode, is_cd ? "yes" : "no");
>> +
>
> Format error when building on host where long != long long (32 bits 
> and windows).
>
> ../home/runner/work/qemu-ci/qemu-ci/tests/qtest/libqos/qos-smmuv3.c: 
> In function ‘qsmmu_setup_translation_tables’:
> ../home/runner/work/qemu-ci/qemu-ci/tests/qtest/libqos/qos-smmuv3.c:560:53: 
> error: format ‘%lx’ expects argument of type ‘long unsigned int’, but 
> argument 2 has type ‘uint64_t’ {aka ‘long long unsigned int’} 
> [-Werror=format=]
>   560 |     g_test_message("Begin of construction: IOVA=0x%lx mode=%d 
> is_building_CD=%s"
>       |                                                   ~~^
>       |                                                     |
>       |                                                     long 
> unsigned int
>       |                                                   %llx
>   561 |                    " ===", iova, mode, is_cd ? "yes" : "no");
>       |                            ~~~~
>       |                            |
>       |                            uint64_t {aka long long unsigned int}
>
> You can use PRIx64 which is portable.


Thanks for you guidance! I'll fix it in V8.


Regards,

Tao


