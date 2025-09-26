Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB3FCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29qs-0002iT-LD; Fri, 26 Sep 2025 10:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v29qn-0002i9-H3; Fri, 26 Sep 2025 10:55:09 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v29qh-0006eK-Ry; Fri, 26 Sep 2025 10:55:09 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAnLdUxqdZonWVGCQ--.88S2;
 Fri, 26 Sep 2025 22:54:41 +0800 (CST)
Received: from [192.168.31.224] (unknown [113.246.118.76])
 by mail (Coremail) with SMTP id AQAAfwA3mucjqdZopmsjAA--.13130S2;
 Fri, 26 Sep 2025 22:54:38 +0800 (CST)
Message-ID: <ce02db47-f9b2-4e48-afe5-3d29a5172f7e@phytium.com.cn>
Date: Fri, 26 Sep 2025 22:54:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] hw/arm/smmuv3: Add initial support for Secure
 State
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <e439e75e-6d1c-4209-aa41-f3e9d5051462@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <e439e75e-6d1c-4209-aa41-f3e9d5051462@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwA3mucjqdZopmsjAA--.13130S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAFBWjVmkcGXQADs5
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3JryUCrWrAF47tFWxtFWrXwb_yoW7ArWrpa
 yrKan0gr4DGF4fZryIqr4xuayrtFZ5Ja4UJrsrGry3Gwn8uF93tr4IyF1YkFykKr1kCFyI
 9ryIvw4kur1jvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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


On 2025/9/26 20:24, Eric Auger wrote:
> Hi,
>
> On 9/25/25 6:26 PM, Tao Tang wrote:
>> Hi all,
>>
>> This is the second version of the patch series to introduce initial
>> support for Secure SMMUv3 emulation in QEMU.
>>
>> This version has been significantly restructured based on the excellent
>> feedback received on the RFC.
>>
>> This version addresses the major points raised during the RFC review.
>> Nearly all issues identified in v1 have been resolved. The most
>> significant changes include:
>>
>>    - The entire series has been refactored to use a "banked register"
>>    architecture. This new design serves as a solid base for all secure
>>    functionality and significantly reduces code duplication.
>>
>>    - The large refactoring patch from v1 has been split into smaller, more
>>    focused commits (e.g., STE parsing, page table handling, and TLB
>>    management) to make the review process easier.
>>
>>    - Support for the complex SEL2 feature (Secure Stage 2) has been
>>    deferred to a future series to reduce the scope of this RFC.
>>
>>    - The mechanism for propagating the security context now correctly uses
>>    the ARMSecuritySpace attribute from the incoming transaction. This
>>    ensures the SMMU's handling of security is aligned with the rest of the
>>    QEMU ARM architecture.
>>
>>
>> The series now begins with two preparatory patches that fix pre-existing
>> bugs in the SMMUv3 model. The first of these, which corrects the CR0
>> reserved mask, has already been reviewed by Eric.
>>
>>    - hw/arm/smmuv3: Fix incorrect reserved mask for SMMU CR0 register
>>    - hw/arm/smmuv3: Correct SMMUEN field name in CR0
>>
>> The subsequent patches implement the Secure SMMUv3 feature, refactored
>> to address the feedback from the v1 RFC.
> could you shared a branch? It does not seem to apply on master.
>
> Thanks
>
> Eric


Hi Eric,

Thanks for the feedback. I've rebased the patch series onto the latest 
master and pushed it to a branch as you requested.

Interestingly, the rebase completed cleanly without any conflicts on my 
end, so I'm not sure what the initial issue might have been. In any 
case, this branch should be up-to-date.


You can find the updated branch here for review:

- [v1-rebased] 
https://github.com/hnusdr/qemu/tree/secure-smmu-v1-community-newer


For historical reference, the original branch is here.

- 
[v1-original]  https://github.com/hnusdr/qemu/tree/secure-smmu-v1-community


Thanks,

Tao


>>
>> Changes from v1 RFC:
>>
>>    - The entire feature implementation has been refactored to use a "banked
>>    register" approach. This significantly reduces code duplication.
>>
>>    - Support for the SEL2 feature (Secure Stage 2) has been deferred. As
>>    Mostafa pointed out, a correct implementation is complex and depends on
>>    FEAT_TTST. This will be addressed in a separate, future patch series.
>>    As a result, this series now supports the following flows:
>>
>>      - Non-secure Stage 1, Stage 2, and nested translations.
>>
>>      - Secure Stage 1-only translations.
>>
>>      - Nested translations (Secure Stage 1 + Non-secure Stage 2), with a
>>    fault generated if a Secure Stage 2 translation is required.
>>
>>    - Writability checks for various registers (both secure and non-secure)
>>    have been hardened to ensure that enable bits are correctly checked.
>>
>> The series has been successfully validated with several test setups:
>>
>>    - An environment using OP-TEE, Hafnium, and a custom platform
>>    device as V1 series described.
>>
>>    - A new, self-contained test device (smmu-testdev) built upon the
>>    QTest framework, which will be submitted as a separate series as
>>    discussed here:
>>      https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg05365.html
>>
>>    - The existing non-secure functionality was regression-tested using
>>    PCIe passthrough to a KVM guest running inside a TCG guest.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>
>> Tao Tang (14):
>>    hw/arm/smmuv3: Fix incorrect reserved mask for SMMU CR0 register
>>    hw/arm/smmuv3: Correct SMMUEN field name in CR0
>>    hw/arm/smmuv3: Introduce secure registers and commands
>>    refactor: Move ARMSecuritySpace to a common header
>>    hw/arm/smmuv3: Introduce banked registers for SMMUv3 state
>>    hw/arm/smmuv3: Add separate address space for secure SMMU accesses
>>    hw/arm/smmuv3: Make Configuration Cache security-state aware
>>    hw/arm/smmuv3: Add security-state handling for page table walks
>>    hw/arm/smmuv3: Add secure TLB entry management
>>    hw/arm/smmuv3: Add banked support for queues and error handling
>>    hw/arm/smmuv3: Harden security checks in MMIO handlers
>>    hw/arm/smmuv3: Use iommu_index to represent the security context
>>    hw/arm/smmuv3: Add property to enable Secure SMMU support
>>    hw/arm/smmuv3: Optional Secure bank migration via subsections
>>
>>   hw/arm/smmu-common.c          |  151 ++++-
>>   hw/arm/smmu-internal.h        |    7 +
>>   hw/arm/smmuv3-internal.h      |  114 +++-
>>   hw/arm/smmuv3.c               | 1130 +++++++++++++++++++++++++--------
>>   hw/arm/trace-events           |    9 +-
>>   hw/arm/virt.c                 |    5 +
>>   include/hw/arm/arm-security.h |   54 ++
>>   include/hw/arm/smmu-common.h  |   60 +-
>>   include/hw/arm/smmuv3.h       |   35 +-
>>   target/arm/cpu.h              |   25 +-
>>   10 files changed, 1257 insertions(+), 333 deletions(-)
>>   create mode 100644 include/hw/arm/arm-security.h
>>
>> --
>> 2.34.1
>>


