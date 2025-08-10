Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FE7C87FCA
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 16:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ul8ew-0008Ln-SZ; Sun, 10 Aug 2025 12:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ul8ed-0008Bt-3d; Sun, 10 Aug 2025 12:12:20 -0400
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net ([159.65.134.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ul8eX-00015j-Rx; Sun, 10 Aug 2025 12:12:14 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnblLJxJhoCqeLBQ--.33909S2;
 Mon, 11 Aug 2025 00:11:53 +0800 (CST)
Received: from [192.168.31.34] (unknown [113.246.234.235])
 by mail (Coremail) with SMTP id AQAAfwDXYgqqxJhoMVcPAA--.22903S2;
 Mon, 11 Aug 2025 00:11:52 +0800 (CST)
Message-ID: <2169e4b1-97d1-43c9-a512-5e6e25a562ad@phytium.com.cn>
Date: Mon, 11 Aug 2025 00:11:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/11] hw/arm/smmuv3: Add initial support for Secure State
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, smostafa@google.com,
 jean-philippe@linaro.org
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <d4fcf3a2-6789-4926-882e-1abac4c07843@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <d4fcf3a2-6789-4926-882e-1abac4c07843@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXYgqqxJhoMVcPAA--.22903S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQASBWiXooAA6wACsi
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XF47CF48XrWxuFW7Aw45GFg_yoWDJw1Upa
 95Ka45KrWDGF1fAw17Xw48ZFy3K395Aw47Grn8Gry5A3s8CFyvqF409ryYgasrWr4kA3WI
 vayvvrs7ur1DZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=159.65.134.6;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtu5ljy1ljeznc42.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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


On 2025/8/7 05:28, Pierrick Bouvier wrote:
> On 8/6/25 8:11 AM, Tao Tang wrote:
>> Hi all,
>>
>> This patch series introduces initial support for emulating the Arm 
>> SMMUv3
>> Secure State.
>>
>> As Pierrick pointed out in a previous discussion [1], full Secure SMMUv3
>> emulation is a notable missing piece in QEMU. While the FVP model has
>> some support, its limited PCIe capabilities make it challenging for
>> complex use cases. The ability to properly manage device DMA from a
>> secure context is a critical prerequisite for enabling device assignment
>> (passthrough) for confidential computing solutions like Arm CCA and
>> related research such as virtCCA [2]. This series aims to build that
>> foundational support in QEMU.
>>
>
> Thanks for posting this series, it's definitely an important piece 
> missing for emulating newer SMMU versions.
>
>> This work is being proposed as an RFC. It introduces a significant 
>> amount
>> of new logic, including the core concept of modeling parallel secure and
>> non-secure contexts within a single SMMUv3 device. I am seeking feedback
>> on the overall approach, the core refactoring, and the implementation
>> details before proceeding further.
>>
>> The series begins by implementing the components of the secure 
>> programming
>> interface, then progressively refactors the core SMMU logic to handle
>> secure and non-secure contexts in parallel.
>>
>> Secure Interface Implementation: The initial patches add the
>> secure-side registers, implement their read/write logic, and enable
>> the secure command and event queues. This includes the S_INIT
>> mechanism and the new secure TLB invalidation commands.
>>
>> Core Logic Refactoring: The next set of patches makes the core SMMU
>> functions security-state aware. This involves plumbing an is_secure
>> context flag through the main code paths and adding logic to route
>> SMMU-originated memory accesses to the correct (Secure or Non-secure)
>> address space.
>>
>> Cache Isolation: With the core logic now aware of security states,
>> the following patches refactor the configuration and translation
>> lookup caches. The cache keys are modified to include the security
>> context, ensuring that secure and non-secure entries for the same
>> device or address are properly isolated and preventing aliasing.
>>
>> Framework Integration: The final patch connects the SMMU's internal
>> security context to the generic QEMU IOMMU framework by using the
>> iommu_index to represent the architectural SEC_SID.
>>
>> To validate this work, I performed the following tests:
>>
>> Non-Secure Regression: To ensure that existing functionality remains
>> intact, I ran a nested virtualization test. A TCG guest was created on
>> the host, with iommu=smmuv3 and with an emulated PCIe NVMe device 
>> assigned.
>> Command line of TCG VM is below:
>>
>> qemu-system-aarch64 \
>> -machine virt,virtualization=on,gic-version=3,iommu=smmuv3 \
>> -cpu max -smp 1 -m 4080M \
>> -accel tcg,thread=single,tb-size=512 \
>> -kernel Image \
>> -append 'nokaslr root=/dev/vda rw rootfstype=ext4 
>> iommu.passthrough=on' \
>> -device 
>> pcie-root-port,bus=pcie.0,id=rp0,addr=0x4.0,chassis=1,port=0x10 \
>> -device 
>> pcie-root-port,bus=pcie.0,id=rp1,addr=0x5.0,chassis=2,port=0x11 \
>> -drive if=none,file=u2204fs.img.qcow2,format=qcow2,id=hd0 \
>> -device virtio-blk-device,drive=hd0 \
>> -qmp unix:/tmp/qmp-sock12,server=on,wait=off \
>> -netdev user,id=eth0,hostfwd=tcp::10022-:22,hostfwd=tcp::59922-:5922 \
>> -device virtio-net-device,netdev=eth0 \
>> -drive if=none,file=nvme.img,format=raw,id=nvme0 \
>> -device nvme,drive=nvme0,serial=deadbeef \
>> -d unimp,guest_errors -trace events=smmu-events.txt -D qemu.log 
>> -nographic
>>
>> Inside this TCG VM, a KVM guest was launched, and the same NVMe 
>> device was
>> re-assigned to it via VFIO.
>> Command line of KVM VM inside TCG VM is below:
>>
>> sudo qemu-system-aarch64  \
>> -enable-kvm  -m 1024  -cpu host  -M virt \
>> -machine virt,gic-version=3 \
>> -cpu max -append "nokaslr" -smp 1 \
>> -monitor stdio \
>> -kernel 5.15.Image \
>> -initrd rootfs.cpio.gz \
>> -display vnc=:22,id=primary \
>> -device vfio-pci,host=00:01.0
>>
>> The KVM guest was able to perform I/O on the device
>> correctly, confirming that the non-secure path is not broken.
>>
>> Secure Register/Command Interface: I set up an OP-TEE + Hafnium
>> environment. Hafnium's smmuv3_driver_init function was used to test
>> the secure register I/O and command queue functionality (excluding
>> translation). As Hafnium assumes larger queue and StreamID sizes than
>> are practical without TTST support, I temporarily patched Hafnium to
>> use smaller values, allowing its driver to initialize the emulated
>> secure SMMU successfully.
>>
>
> Would that be possible to share your changes, and build instructions 
> for this? While working on SMMU emulation, we finally left this on the 
> side due to lack of a software stack being able to use secure SMMU, as 
> we were not aware that Hafnium + op-tee could make use of it.
>
Hi Pierrick,

Thanks for your interest! I'm very happy to share my work on this. I've 
documented the setup process, including our code modifications and the 
step-by-step build instructions in  this link:

https://hnusdr.github.io/2025/08/09/Test-Secure-SMMU-with-Hafnium-ENG


The core point of these changes is to enable the SMMUv3 feature in 
Hafnium. This leads to numerous read/write operations on SMMUv3 secure 
registers and various queue manipulations within the smmuv3_driver_init 
function in Hafnium.

However, it's important to note that this initialization process itself 
does not initiate any DMA memory access that would trigger the 
smmuv3_translate flow.

Even so, we've devised a method to test the subsequent Secure 
Translation Path by leveraging the smmuv3-test platform device. This 
approach allows us to verify the entire SMMUv3 flow, from initialization 
to translation.


>> Secure Translation Path: Since the TF-A SMMUv3 Test Engine does not
>> support QEMU, and no secure device assignment feature exists yet, I
>> created a custom platform device to test the secure translation flow.
>> To trigger the translation logic, I initiated MMIO writes to this
>> device from within Hafnium. The device's MMIO callback handler then
>> performed DMA accesses via its IOMMU region, exercising the secure
>> translation path. While SMMUv3 is typically used for PCIe on
>> physical SoCs, the architecture allows its use with platform devices
>> via a stream-id binding in the device tree. The test harness
>> required some non-standard modifications to decouple the SMMU from
>> its tight integration with PCIe. The code for this test device is
>> available for review at [3]. README.md with detailed instructions is
>> also provided.
>>
>
> I am not sure about the current policy in QEMU for test oriented 
> devices, but it would be really useful to have something similar 
> upstream (Note: it's out of the scope of this series).
> One challenge working with SMMU emulation is that reproducing setups 
> and triggering specific code paths is hard to achieve, due to the 
> indirect use of SMMU feature (through DMA) and the complex software 
> stack usually involved.
> Having something upstream available to work on SMMU emulation, at 
> least on device side, would be a great addition.
>
> Eric, Peter, is this something that would be acceptable to merge?
>

Looking ahead, my plan is to refactor the smmuv3-test platform device. 
The goal is to make it self-contained within QEMU, removing the current 
dependency on Hafnium to trigger its operations. I plan to submit this 
as a separate RFC patch series in the next few days.

However, the current version at [3] is already sufficient to test the 
code logic introduced in this RFC.


>> I've attempted to follow all of the guidance in the "Submitting a Patch"
>> guide, but as this is my first series of this scale, I apologize if I
>> missed anything and welcome all feedback.
>>
>> Thanks,
>> Tang
>>
>> [1] 
>> https://lists.nongnu.org/archive/html/qemu-devel/2025-06/msg02940.html
>> [2] https://arxiv.org/abs/2306.11011
>
> I was not aware of it, thanks for sharing this excellent paper.
>
>> [3] https://github.com/hnusdr/qemu
>>
>> Tao Tang (11):
>>    hw/arm/smmuv3: Introduce secure registers and commands
>>    hw/arm/smmuv3: Implement read/write logic for secure registers
>>    hw/arm/smmuv3: Implement S_INIT for secure initialization
>>    hw/arm/smmuv3: Enable command processing for the Secure state
>>    hw/arm/smmuv3: Support secure event queue and error handling
>>    hw/arm/smmuv3: Plumb security state through core functions
>>    hw/arm/smmuv3: Add separate address space for secure SMMU accesses
>>    hw/arm/smmuv3: Enable secure-side stage 2 TLB invalidations
>>    hw/arm/smmuv3: Make the configuration cache security-state aware
>>    hw/arm/smmuv3: Differentiate secure TLB entries via keying
>>    hw/arm/smmuv3: Use iommu_index to represent SEC_SID
>>
>>   hw/arm/smmu-common.c         |  74 ++-
>>   hw/arm/smmuv3-internal.h     | 128 +++++-
>>   hw/arm/smmuv3.c              | 844 ++++++++++++++++++++++++++++++-----
>>   hw/arm/trace-events          |   7 +-
>>   hw/arm/virt.c                |   5 +
>>   include/hw/arm/smmu-common.h |  23 +-
>>   include/hw/arm/smmuv3.h      |  27 ++
>>   7 files changed, 968 insertions(+), 140 deletions(-)
>>
>> -- 
>> 2.34.1
>>
>>
>
> Regards,
> Pierrick


-- 

Best,

Tang


