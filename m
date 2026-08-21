Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD3BC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRtx-0005AH-Vz; Fri, 21 Aug 2026 12:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wxRtv-00058z-0N; Fri, 21 Aug 2026 12:15:27 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wxRts-0002hD-GP; Fri, 21 Aug 2026 12:15:26 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwBHTxuWeYhqtzYsBA--.8899S2;
 Sat, 22 Aug 2026 00:15:18 +0800 (CST)
Received: from [192.168.2.8] (unknown [113.246.117.12])
 by mail (Coremail) with SMTP id AQAAf8Dwa3SGeYhqwcdhAA--.13495S2;
 Sat, 22 Aug 2026 00:15:10 +0800 (CST)
Message-ID: <ac8f5bbb-183c-425b-9e9b-56efea99095d@phytium.com.cn>
Date: Sat, 22 Aug 2026 00:15:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 00/28] hw/arm/smmuv3: Support Secure state for SMMUv3
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <0a4c3e34-574a-484c-8617-3af587f080fa@oss.qualcomm.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <0a4c3e34-574a-484c-8617-3af587f080fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dwa3SGeYhqwcdhAA--.13495S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWqHVcgGNAAHsP
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZr1DXry8ur45Xw47GFW7urg_yoW7Jry5pF
 W3Ga13Kr4UKFyrZr1Ivw1jkF42ga93J3yayrn8Kryxur4UCrnaqFWF9F4FqFyUXryrC3WS
 q3yjvay8Xwn09FJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Pierrick,

On 8/21/2026 6:16 AM, Pierrick Bouvier wrote:
> On 8/13/2026 9:15 AM, Tao Tang wrote:
>> Hi all,
>>
>> This is v5 of the Secure SMMUv3 series.
>>
>> Many thanks to everyone who reviewed the earlier versions. This version contains
>> 28 commits in total. Only one patch touches hw/pci (patch #23); the remaining
>> patches are confined to the Arm SMMUv3 model. Also some patches in v4 have been
>> merged into the mainline QEMU tree, so the v5 series is now smaller than v4.
>>
>> Secure Stage 2 is not implemented. Secure STEs which enable Stage 2 are
>> rejected with C_BAD_STE. Realm and Root programming interfaces are outside the
>> scope of this series.
>>
>> Commits layout:
>> ---------------
>> The commits are roughly grouped as follows:
>> 1. (#23, hw/pci only) Add a PCIDevice "sec-sid" property so boards can mark a
>>    device's SEC_SID (system integration knob).
>> 2. (#1-2, #24-27) Core data-structure and plumbing refactors.
>> 3. (#3-8) Introduce SEC_SID through caches, notifiers, and helpers.
>> 4. (#9-12) Page table walk related updates (e.g. NSCFG/PTE helpers).
>> 5. (#13-15) EVTQ/CMDQ handling and invalidation paths.
>> 6. (#16-22) MMIO/register access checks and architectural corner cases.
>> 7. (#28) A temporary [NOT-MERGE] commit used with Hafnium to exercise
>>    secure-bank register access.
>>
>>
>> Main updates:
>> -------------
>> - (#23, hw/pci only) Add a "sec-sid" property to PCIDevice and consume it from
>>    the SMMU in #24 to select the security context and validate capabilities.
>>
>>    @Michael: could you please review the hw/pci change
>>    ("hw/pci: Add sec-sid property to PCIDevice") and confirm this kind of
>>    system-integration property is acceptable for the PCI subtree?
>>
>>    For context, I previously posted this as a standalone patch [1]:
>>    [1] https://lore.kernel.org/qemu-devel/20251211102729.227376-1-tangtao1634@phytium.com.cn/
>>
>>    The commit in this v5 series is an updated version based on Pierrick's
>>    feedback (notably switching sec-sid to a string property). We also discussed
>>    the need for this knob as a prerequisite for accurately modelling SMMU secure
>>    state here [2]:
>>
>>    [2] https://lore.kernel.org/qemu-devel/4870b7df-4cb3-457e-9a18-87f3558adf09@linaro.org/
>>
>>    We do need a stable way for boards to statically mark devices that may issue
>>    Secure transactions.
>>
>> other updates:
>> - Drop the CR0 and CFGI_CD fixes which are already upstream.
>> - Select MemTxAttrs and AddressSpace on demand from SEC_SID and keep the
>>    programming-interface namespace in the configuration and IOTLB keys.
>> - Route CMDQ, EventQ, IRQ and GERROR handling through the originating
>>    programming-interface bank.
>> - Tighten MMIO RAZ/WI, writability and reserved-bit handling.
>> - Reject unsupported non-NS IOMMU notifier registration.
>> - Make secure-impl an on/off/auto property, resolve auto from the Secure
>>    AddressSpace, and require Stage 1 support when enabled.
>>
>>
>> Testing notes:
>> --------------
>> - Testing MMIO accesses
>>    The branch currently contains one commit explicitly marked [NOT-MERGE]. It is
>>    only used to cooperate with Hafnium to exercise and validate secure-bank
>>    register read/write paths in a small, reproducible setup as described in [3]:
>>    [3] https://hnusdr.github.io/2025/08/09/Test-Secure-SMMU-with-Hafnium-ENG/
>>
>>    This commit is not intended for upstream and will be dropped before posting
>>    the final mergeable series.
>>
>>    For reference, the Hafnium test logs show the SMMU being initialized
>>    successfully:
>>
>>    INFO: Loading VM id 0x8001: op-tee.
>>    INFO: Loaded with 4 vCPUs, entry at 0xe300000.
>>    INFO: Hafnium initialisation completed
>>
> If anyone wants to reproduce it, you can file a precompiled archive
> (with optee + hafnium):
>
> $ wget
> https://github.com/p-b-o/qemu-linux-stack/releases/download/build/optee-secure-smmu-10674a1.tar.xz
> $ tar xvf optee-secure-smmu*
> $ ./run.sh ./build/qemu-system-aarch64
>   With current master branch:
> INFO: Initializing Hafnium (SPMC)
> ...
> ERROR: SMMUv3 does not implement secure state
> ERROR: SMMUv3: Failed to initialize driver
> Panic: Could not initialize IOMMUs.
>
> With this series applied:
> INFO: Initializing Hafnium (SPMC)
> ...
> INFO: Arm SMMUv3 initialized
> ...
> INFO: Loading VM id 0x8001: op-tee.
> INFO: Loaded with 4 vCPUs, entry at 0xe300000.
> INFO: Hafnium initialisation completed
>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


Thanks for testing and for providing the prebuilt archive.

Building Hafnium locally is still not very straightforward, as it 
requires a specific toolchain, several build dependencies, and some code 
patches. So the archive is especially helpful.


> Regards,
> Pierrick


Best regards,

Tao


