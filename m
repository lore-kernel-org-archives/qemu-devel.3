Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC34D2069E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 06:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0x5g-0002s5-6B; Wed, 16 Oct 2024 02:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t0x5c-0002rl-TF; Wed, 16 Oct 2024 02:00:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1t0x5Y-0004c7-J8; Wed, 16 Oct 2024 02:00:56 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxHLOGVg9ndIIfAA--.46995S3;
 Wed, 16 Oct 2024 14:00:38 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAx_9V7Vg9njjwsAA--.28300S3;
 Wed, 16 Oct 2024 14:00:27 +0800 (CST)
Subject: Re: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU Hotplug
 (on Archs like ARM)
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <3b0b1033-36eb-6180-1363-f76083a32ce0@loongson.cn>
 <a00e18f4324b40a0b54de4bfbc6d67c2@huawei.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <78882f54-8efe-024f-f328-43a2b3ba4d91@loongson.cn>
Date: Wed, 16 Oct 2024 14:00:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a00e18f4324b40a0b54de4bfbc6d67c2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx_9V7Vg9njjwsAA--.28300S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw48Cr45GFW5ZF1rAry3WrX_yoW7uF18pF
 WIka1YgrWDJr1fAa1Sqr13ur1Y93yrGrWUXrnxCr1xu3Z0yF1vyF18Kr45uFy3Zr97KF17
 ZF1Yv347u34rAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Pc02F40EFcxC0VAKzVAqx4xG6I80ewCIccxYrVCIc48FwI0_Gr0_XrUv
 73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOa7kC6x804xWl14x267AKxVWUJVW8Jw
 AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kI
 II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7
 xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28E
 F7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52
 x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80
 ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
 AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_
 GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI
 0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
 1VAY17CE14v26rWY6r4UJwCIccxYrVCIc48FwI0_Gr0_Xr1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jqzuXUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.7,
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



On 2024/10/15 下午10:31, Salil Mehta wrote:
> HI Bibo,
> 
>>   From: maobibo <maobibo@loongson.cn>
>>   Sent: Tuesday, October 15, 2024 4:31 AM
>>   To: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org;
>>   qemu-arm@nongnu.org; mst@redhat.com
>>   
>>   With cpu-add/cpu-del command tested on LoongArch system, no migration
>>   tested. There is no negative influence with LoongArch cpu hotplug.
> 
> Thanks for the confirmation.
> 
> Just curious are guys still using cpu-{add,del} interface for vCPU hotplug?
> I thought it was deprecated for device_{add,del}?
I use the device_add/del hmp command, such as
   # device_add 
la464-loongarch-cpu,socket-id=0,core-id=1,thread-id=0,id=cpu-1
   # device_del cpu-1

Tested-by: Bibo Mao <maobibo@loongson.cn>

Regards
Bibo Mao
> 
> https://wiki.qemu.org/Features/CPUHotplug
> https://www.qemu.org/docs/master/system/cpu-hotplug.html
> 
> 
> Thanks
> Salil.
> 
>>   
>>   Regards
>>   Bibo Mao
>>   
>>   On 2024/10/15 上午3:22, Salil Mehta via wrote:
>>   > Certain CPU architecture specifications [1][2][3] prohibit changes to
>>   > the CPUs
>>   > *presence* after the kernel has booted. This is because many system
>>   > initializations depend on the exact CPU count at boot time and do not
>>   > expect it to change afterward. For example, components like interrupt
>>   > controllers that are closely coupled with CPUs, or various per-CPU
>>   > features, may not support configuration changes once the kernel has
>>   been initialized.
>>   >
>>   > This requirement poses a challenge for virtualization features like
>>   > vCPU hotplug. To address this, changes to the ACPI AML are necessary
>>   > to update the `_STA.PRES` (presence) and `_STA.ENA` (enabled) bits
>>   > accordingly during guest initialization, as well as when vCPUs are
>>   > hot-plugged or hot-unplugged. The presence of unplugged vCPUs may
>>   need
>>   > to be deliberately *simulated* at the ACPI level to maintain a *persistent*
>>   view of vCPUs for the guest kernel.
>>   >
>>   > This patch set introduces the following features:
>>   >
>>   > 1. ACPI Interface with Explicit PRESENT and ENABLED CPU States: It allows
>>   the
>>   >     guest kernel to evaluate these states using the `_STA` ACPI method.
>>   >
>>   > 2. Initialization of ACPI CPU States: These states are initialized during
>>   >     `machvirt_init` and when vCPUs are hot-(un)plugged. This enables
>>   hotpluggable
>>   >     vCPUs to be exposed to the guest kernel via ACPI.
>>   >
>>   > 3. Support for Migrating ACPI CPU States: The patch set ensures the
>>   migration of
>>   >     the newly introduced `is_{present,enabled}` ACPI CPU states to the
>>   >     destination VM.
>>   >
>>   > The approach is flexible enough to accommodate ARM-like architectures
>>   > that intend to implement vCPU hotplug functionality. It is suitable
>>   > for architectures facing similar constraints to ARM or those that plan
>>   > to implement vCPU hotplugging independently of hardware support (if
>>   available).
>>   >
>>   > This patch set is derived from the ARM-specific vCPU hotplug
>>   > implementation [4] and includes migration components adaptable to
>>   > other architectures, following suggestions [5] made by Igor Mammedov
>>   <imammedo@redhat.com>.
>>   >
>>   > It can be applied independently, ensuring compatibility with existing
>>   > hotplug support in other architectures. I have tested this patch set
>>   > in conjunction with the ARM-specific vCPU hotplug changes (included in
>>   > the upcoming RFC V5 [6]), and everything worked as expected. I kindly
>>   > request maintainers of other architectures to provide a "Tested-by"
>>   > after running their respective regression tests.
>>   >
>>   > Many thanks!
>>   >
>>   >
>>   > References:
>>   > [1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt
>>   CPU Hotplug on
>>   >      architectures that don’t Support CPU Hotplug (like ARM64)
>>   >      a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-
>>   hotplug_7OJ1YyJ.pdf
>>   >      b. Qemu Link:
>>   > https://kvm-
>>   forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Vir
>>   > t_CPU_Hotplug_-__ii0iNb3.pdf [2] KVMForum 2020 Presentation:
>>   > Challenges in Supporting Virtual CPU Hotplug on
>>   >      SoC Based Systems (like ARM64)
>>   >      Link: https://kvmforum2020.sched.com/event/eE4m
>>   > [3] Check comment 5 in the bugzilla entry
>>   >      Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
>>   > [4] [PATCH RFC V4 00/33] Support of Virtual CPU Hotplug for ARMv8 Arch
>>   >      Link:
>>   > https://lore.kernel.org/qemu-devel/20241009031815.250096-1-salil.mehta
>>   > @huawei.com/T/#mf32be203baa568a871dc625b732f666a4c4f1e68
>>   > [5] Architecture agnostic ACPI VMSD state migration (Discussion)
>>   >      Link:
>>   > https://lore.kernel.org/qemu-
>>   devel/20240715155436.577d34c5@imammedo.us
>>   > ers.ipa.redhat.com/ [6] Upcoming RFC V5, Support of Virtual CPU
>>   > Hotplug for ARMv8 Arch
>>   >      Link:
>>   > https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v5
>>   >
>>   > Salil Mehta (4):
>>   >    hw/acpi: Initialize ACPI Hotplug CPU Status with Support for vCPU
>>   >      `Persistence`
>>   >    hw/acpi: Update ACPI CPU Status `is_{present, enabled}` during vCPU
>>   >      hot(un)plug
>>   >    hw/acpi: Reflect ACPI vCPU {present,enabled} states in ACPI
>>   >      _STA.{PRES,ENA} Bits
>>   >    hw/acpi: Populate vCPU Hotplug VMSD to migrate
>>   `is_{present,enabled}`
>>   >      states
>>   >
>>   >   cpu-target.c         patches.vcpuhp.rfc-v5.arch.agnostic.acpi          |  1 +
>>   >   hw/acpi/cpu.c                  | 70 +++++++++++++++++++++++++++++++---
>>   >   hw/acpi/generic_event_device.c | 11 ++++++
>>   >   include/hw/acpi/cpu.h          | 21 ++++++++++
>>   >   include/hw/core/cpu.h          | 21 ++++++++++
>>   >   5 files changed, 119 insertions(+), 5 deletions(-)
>>   >
> 


