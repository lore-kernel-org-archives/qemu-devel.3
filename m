Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19578E674B5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 15:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXhVe-0007Zv-3w; Mon, 22 Dec 2025 10:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vXhVa-0007Yv-Ig; Mon, 22 Dec 2025 10:07:38 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vXhVX-0004SE-Le; Mon, 22 Dec 2025 10:07:38 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnLyewXklp6Dv1AQ--.33152S2;
 Mon, 22 Dec 2025 23:07:28 +0800 (CST)
Received: from [192.168.31.152] (unknown [222.244.182.241])
 by mail (Coremail) with SMTP id AQAAfwAXcO2pXklp7+cNAA--.26115S2;
 Mon, 22 Dec 2025 23:07:27 +0800 (CST)
Message-ID: <0a788e5b-43d2-40a3-8798-2a4755ef44a4@phytium.com.cn>
Date: Mon, 22 Dec 2025 23:07:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is there any manuals or page to show how to setup a nest
 translation environment with stage1 and stage2 page tables on intel-iommu ?
To: tugouxp <13824125580@163.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <8a97dd61-bbb5-4992-a486-5f89d7403d77@phytium.com.cn>
 <52617849.7d02.19b44b18191.Coremail.13824125580@163.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <52617849.7d02.19b44b18191.Coremail.13824125580@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAXcO2pXklp7+cNAA--.26115S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAMBWlIVJoHxQAAsl
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AF4ktr1UKF1UAryfCrWfKrg_yoW7tF1UpF
 WYyFySgr4Dtr4xCw1vvw1UZryIvr4kJ39xXrn5Wwn5Gan09ry2yFyIkr1YkFyS9Fs5Wr10
 y3yDtr9rWw15AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Hi tugouxp,

On 2025/12/22 14:14, tugouxp wrote:
> Hi Tao:
>     Thanks for your answer!
>
>      So your environment involves simulating an AARCH64 VM OS on an X86 host, and then within that simulated AARCH64 VM, you've installed another KVM aarch64 VM? Essentially, it's an environment with two nested aarch64 VMs running on an x86 host? I can hardly believe it — that's a genius idea! I'm quite concerned about its performance, though. Will it be very slow and laggy?

Yes, a virtualization-capable aarch64 TCG VM can be set up using 
-machine virt,virtualization=on regardless of the host architecture, 
including on an x86 host, thanks to QEMU’s TCG cross-architecture 
dynamic translation mechanism. TCG emulates the guest CPU and system 
well enough that the guest OS sees and can exercise ARM virtualization 
extensions (EL2 and Stage-2), so from the guest kernel’s perspective the 
machine does genuinely have virtualization support enabled. This makes 
setting up a KVM VM inside this TCG guest reasonable.

In fact, the Linux kernel and the qemu-system-* binaries running inside 
the TCG host VM are the same binaries you would run on a physical 
machine — there is no modification or special build for this TCG 
environment. Of course, performance will be slower than on real 
hardware, as TCG interprets and translates guest instructions in 
software rather than executing them directly on physical virtualization 
extensions; however, for workloads that are not heavily I/O-intensive, 
simple tests work fine. For example, I passed through a PCIe NVMe device 
to the nested VM, mounted it, and was able to read and write files on it 
just like on real hardware.


I'm sure it is doable to do this on aarch64. But I'm not sure how it is 
on x86_64/i386. I did a cursory search of the code and found it seems to 
be unsupported to setup a TCG VM with virtualization-capability enabled 
on x86_64/i386. But I'm not familiar with this so we may need an x86 
specialist to help with this.


> By the way, isn't the KVM （because you use --enale-kvm in the nested aarch64 vm) in the aarch64 VM also emulated? After all, KVM can only be used on the same ISA architecture.
>
They are all emulated and all aarch64 machine.


Regards,

Tao

>
>
> BRs
>
> zlcao.
>
>
>
>
>
>
>
>
>
>
> At 2025-12-22 11:49:33, "Tao Tang" <tangtao1634@phytium.com.cn> wrote:
>> Hi zlcao,
>>
>>> Hi guys:
>>>      I want to learn about how Intel IOMMU second-level translation
>>> works. Does anyone have any materials or pages on this topic, such as
>>> WIP repositories, operational guides, etc.? Thanks!
>>> BRs
>>> zlcao.
>>
>>  From my experience, the best approach to learn this is to setup a
>> nested virtualization environment, find the senario that can trigger
>> second-level translation, and then trace all Intel IOMMU events or use
>> gdb to trace line by line in hw/i386/intel_iommu.c. Also you may need to
>> get Intel IOMMU spec and find the related chapter which describes
>> second-level translation.
>>
>>
>> I worked in SMMU these days and had the same problem with you and found
>> that setup a nested virtualization environment then passthrough a PCIe
>> device from TCG Host VM into KVM Guest VM could be a good way to debug
>> IOMMU implementation. This link [1] show how it works in Arm SMMU.
>>
>> [1]
>> https://lore.kernel.org/qemu-devel/20250806151134.365755-1-tangtao1634@phytium.com.cn/
>>
>>
>> ......
>>
>> Non-Secure Regression: To ensure that existing functionality remains
>> intact, I ran a nested virtualization test. A TCG guest was created on
>> the host, with iommu=smmuv3 and with an emulated PCIe NVMe device assigned.
>> Command line of TCG VM is below:
>>
>> qemu-system-aarch64 \
>> -machine virt,virtualization=on,gic-version=3,iommu=smmuv3 \
>> -cpu max -smp 1 -m 4080M \
>> -accel tcg,thread=single,tb-size=512 \
>> -kernel Image \
>> -append 'nokaslr root=/dev/vda rw rootfstype=ext4 iommu.passthrough=on' \
>> -device pcie-root-port,bus=pcie.0,id=rp0,addr=0x4.0,chassis=1,port=0x10 \
>> -device pcie-root-port,bus=pcie.0,id=rp1,addr=0x5.0,chassis=2,port=0x11 \
>> -drive if=none,file=u2204fs.img.qcow2,format=qcow2,id=hd0 \
>> -device virtio-blk-device,drive=hd0 \
>> -qmp unix:/tmp/qmp-sock12,server=on,wait=off \
>> -netdev user,id=eth0,hostfwd=tcp::10022-:22,hostfwd=tcp::59922-:5922 \
>> -device virtio-net-device,netdev=eth0 \
>> -drive if=none,file=nvme.img,format=raw,id=nvme0 \
>> -device nvme,drive=nvme0,serial=deadbeef \
>> -d unimp,guest_errors -trace events=smmu-events.txt -D qemu.log -nographic
>>
>> Inside this TCG VM, a KVM guest was launched, and the same NVMe device was
>> re-assigned to it via VFIO.
>> Command line of KVM VM inside TCG VM is below:
>>
>> sudo qemu-system-aarch64  \
>> -enable-kvm  -m 1024  -cpu host  -M virt \
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
>> ......
>>
>>
>>
>> I'm not familiar with Intel IOMMU so I'm not enable to help with the
>> right options that apply PCIe passthroughing on Intel IOMMU.
>>
>>
>> BTW, I have submitted a patch series introducing iommu-testdev [2] ,
>> which allows testing IOMMU functionality purely with QTest, without
>> setting up a complex software stack. Once you have a clear understanding
>> of the second-level translation, you are very welcome to share your
>> findings and help improve the Intel IOMMU implementation in iommu-testdev.
>>
>>
>> [2]
>> https://lore.kernel.org/qemu-devel/20251206155203.3015881-1-tangtao1634@phytium.com.cn/
>>
>>
>> Regards,
>>
>> Tao


