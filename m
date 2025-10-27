Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136DDCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNM2-0007lW-HW; Mon, 27 Oct 2025 09:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vDNL7-0007bc-NB; Mon, 27 Oct 2025 09:32:51 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vDNKm-0006e5-FA; Mon, 27 Oct 2025 09:32:35 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCHdVxYdP9ooix2AA--.40632S2;
 Mon, 27 Oct 2025 21:32:08 +0800 (CST)
Received: from [192.168.31.222] (unknown [113.246.234.35])
 by mail (Coremail) with SMTP id AQAAfwCX+udWdP9ogApxAA--.52278S2;
 Mon, 27 Oct 2025 21:32:07 +0800 (CST)
Message-ID: <efe21350-fe9d-4bc9-acc1-8f761a875506@phytium.com.cn>
Date: Mon, 27 Oct 2025 21:32:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] hw/misc: Introduce a new SMMUv3 test framework
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
 <87v7k6lyp4.fsf@draig.linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <87v7k6lyp4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX+udWdP9ogApxAA--.52278S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAQBWj+ghAHuwAAss
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKryfXF4kAryDCFWrCF4fuFg_yoWxZrWxpF
 Z3Ka43tF4kJF17Zr1xAw48ZFyYv393Aw45Gr1rKrn29ws0kr1vqFW3KFyrAasrWrW0qF1S
 v3yjvryDuan8AFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Hi Alex,

On 2025/10/23 18:06, Alex Bennée wrote:
> tangtao1634 <tangtao1634@phytium.com.cn> writes:
>
>> From: Tao Tang <tangtao1634@phytium.com.cn>
>>
>> This patch series (V2) introduces several cleanups and improvements to the smmu-testdev device. The main goals are to refactor shared code, enhance robustness, and significantly clarify the complex page table construction used for testing.
>>
>> Motivation
>> ----------
>>
>> Currently, thoroughly testing the SMMUv3 emulation requires a significant
>> software stack. We need to boot a full guest operating system (like Linux)
>> with the appropriate drivers (e.g., IOMMUFD) and rely on firmware (e.g.,
>> ACPI with IORT tables or Hafnium) to correctly configure the SMMU and
>> orchestrate DMA from a peripheral device.
>>
>> This dependency on a complex software stack presents several challenges:
>>
>> * High Barrier to Entry: Writing targeted tests for specific SMMU
>>      features (like fault handling, specific translation regimes, etc.)
>>      becomes cumbersome.
>>
>> * Difficult to Debug: It's hard to distinguish whether a bug originates
>>      from the SMMU emulation itself, the guest driver, the firmware
>>      tables, or the guest kernel's configuration.
>>
>> * Slow Iteration: The need to boot a full guest OS slows down the
>>      development and testing cycle.
>>
>> The primary goal of this work is to create a lightweight, self-contained
>> testing environment that allows us to exercise the SMMU's core logic
>> directly at the qtest level, removing the need for any guest-side
>> software.
> I agree, an excellent motivation.
>
>> Our Approach: A Dedicated Test Device
>> -------------------------------------
>>
>> To achieve this, we introduce two main components:
>>
>> * A new, minimal hardware device: smmu-testdev.
>> * A corresponding qtest that drives this device to generate SMMU-bound
>>      traffic.
>>
>> A key question is, "Why introduce a new smmu-testdev instead of using an
>> existing PCIe or platform device?"
> I curious what the split between PCIe and platform devices that need an
> SMMU are. I suspect there is a strong split between the virtualisation
> case and the emulation case.


Thanks again for the insightful questions and for sparking this valuable 
discussion.


 From my observation of real-world, commercially available SoCs, the 
SMMU is almost exclusively designed for and used with PCIe. Of course, 
you're right that architecturally, the SMMU specification certainly 
allows for non-PCIe clients. Peter's point about using the SMMU for the 
GIC ITS in a Realm context is an excellent example. I've also personally 
seen similar setups in the TF-A-Tests+FVP software stack, where platform 
device, named SMMUv3TestEngine, was used to test the SMMU.

However, from the perspective of QEMU's current implementation, there 
are some significant limitations that guided the design of smmu-testdev. 
At the moment, the SMMU model does not really support non-PCIe devices. 
Two key issues are:

- The IOMMU MemoryRegion, used with PCIe device, cannot be used with a 
platform device, which is the primary mechanism for routing DMA traffic 
through the IOMMU.

- Internally, the SMMU code makes assumptions about its clients. For 
instance, the smmu_get_sid() function explicitly expects a PCIe device 
and has no path to acquire a StreamID for a platform device.

Given this, the decision to model smmu-testdev as a minimal, PCI-like 
device is a pragmatic one. It aligns with the most common real-world use 
case while also working within the constraints of QEMU's current SMMU 
implementation.

>> The answer lies in our goal to minimize complexity. Standard devices,
>> whether PCIe or platform, come with their own intricate initialization
>> protocols and often require a complex driver state machine to function.
>> Using them would re-introduce the very driver-level complexity we aim to
>> avoid.
>>
>> The smmu-testdev is intentionally not a conformant, general-purpose PCIe
>> or platform device. It is a purpose-built, highly simplified "DMA engine."
>> I've designed it to be analogous to a minimal PCIe Root Complex that
>> bypasses the full, realistic topology (Host Bridges, Switches, Endpoints)
>> to provide a direct, programmable path for a DMA request to reach the SMMU.
>> Its sole purpose is to trigger a DMA transaction when its registers are
>> written to, making it perfectly suited for direct control from a test
>> environment like qtest.
>>
>> The Qtest Framework
>> -------------------
>>
>> The new qtest (smmu-testdev-qtest.c) serves as the "bare-metal driver"
>> for both the SMMU and the smmu-testdev. It manually performs all the
>> setup that would typically be handled by the guest kernel and firmware,
>> but in a completely controlled and predictable manner:
>>
>> 1.  SMMU Configuration: It directly initializes the SMMU's registers to a
>>      known state.
>>
>> 2.  Translation Structure Setup: It manually constructs the necessary
>>      translation structures in memory, including Stream Table Entries
>>      (STEs), Context Descriptors (CDs), and Page Tables (PTEs).
>>
>> 3.  DMA Trigger: It programs the smmu-testdev to initiate a DMA operation
>>      targeting a specific IOVA.
>>
>> 4.  Verification: It waits for the transaction to complete and verifies
>>      that the memory was accessed correctly after address translation by
>>      the SMMU.
>>
>> This framework provides a solid and extensible foundation for validating
>> the SMMU's core translation paths. The initial test included in this
>> series covers a basic DMA completion path in the Non-Secure bank,
>> serving as a smoke test and a proof of concept.
>>
>> It is worth noting that this series currently only includes tests for the
>> Non-Secure SMMU. I am aware of the ongoing discussions and RFC patches
>> for Secure SMMU support. To avoid a dependency on unmerged work, this
>> submission does not include tests for the Secure world. However, I have
>> already implemented these tests locally, and I am prepared to submit
>> them for review as soon as the core Secure SMMU support is merged
>> upstream.
> What about other IOMMU's? Are there any other bus mediating devices
> modelled in QEMU that could also benefit from the ability to trigger DMA
> transactions?


This is a great point that I haven't fully considered. To make sure I 
understand correctly, are you referring to IOMMU implementations for 
other architectures, such as VT-d on x86 or the ongoing IOMMU work for 
RISC-V? I'll admit this is an area I haven't looked into. I'm very open 
to ideas—do you or others have suggestions on how this test-device 
pattern could be generalized or what would be needed to make it useful 
across different architectures?

Thanks again for the great feedback.

Best regards,

Tao


