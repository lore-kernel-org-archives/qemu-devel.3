Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3190DCFC262
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 03:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0YHD-0007lk-GS; Mon, 14 Oct 2024 23:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t0YHA-0007lX-DY; Mon, 14 Oct 2024 23:31:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1t0YH7-0000A9-Ma; Mon, 14 Oct 2024 23:31:12 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx34v14Q1nLJscAA--.41041S3;
 Tue, 15 Oct 2024 11:31:01 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxXuTs4Q1nYVwqAA--.8786S3;
 Tue, 15 Oct 2024 11:30:53 +0800 (CST)
Subject: Re: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU Hotplug
 (on Archs like ARM)
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 gshan@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com, gustavo.romero@linaro.org
References: <20241014192205.253479-1-salil.mehta@huawei.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <3b0b1033-36eb-6180-1363-f76083a32ce0@loongson.cn>
Date: Tue, 15 Oct 2024 11:30:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241014192205.253479-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXuTs4Q1nYVwqAA--.8786S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWryxur1DWrW3ZF43WF48uFX_yoWrtFyrpF
 WIka1FqrWDtr1xGw4ftwnxWw1Y9a4rGF43Grn3ur18u3Z8tF1vyF1Skr4UXF13AF9a9F1x
 ZFn0vr1Uu34DZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
 6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUaTa0DU
 UUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.396,
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

With cpu-add/cpu-del command tested on LoongArch system, no migration 
tested. There is no negative influence with LoongArch cpu hotplug.

Regards
Bibo Mao

On 2024/10/15 上午3:22, Salil Mehta via wrote:
> Certain CPU architecture specifications [1][2][3] prohibit changes to the CPUs
> *presence* after the kernel has booted. This is because many system
> initializations depend on the exact CPU count at boot time and do not expect it
> to change afterward. For example, components like interrupt controllers that are
> closely coupled with CPUs, or various per-CPU features, may not support
> configuration changes once the kernel has been initialized.
> 
> This requirement poses a challenge for virtualization features like vCPU
> hotplug. To address this, changes to the ACPI AML are necessary to update the
> `_STA.PRES` (presence) and `_STA.ENA` (enabled) bits accordingly during guest
> initialization, as well as when vCPUs are hot-plugged or hot-unplugged. The
> presence of unplugged vCPUs may need to be deliberately *simulated* at the ACPI
> level to maintain a *persistent* view of vCPUs for the guest kernel.
> 
> This patch set introduces the following features:
> 
> 1. ACPI Interface with Explicit PRESENT and ENABLED CPU States: It allows the
>     guest kernel to evaluate these states using the `_STA` ACPI method.
>     
> 2. Initialization of ACPI CPU States: These states are initialized during
>     `machvirt_init` and when vCPUs are hot-(un)plugged. This enables hotpluggable
>     vCPUs to be exposed to the guest kernel via ACPI.
> 
> 3. Support for Migrating ACPI CPU States: The patch set ensures the migration of
>     the newly introduced `is_{present,enabled}` ACPI CPU states to the
>     destination VM.
> 
> The approach is flexible enough to accommodate ARM-like architectures that
> intend to implement vCPU hotplug functionality. It is suitable for architectures
> facing similar constraints to ARM or those that plan to implement vCPU
> hotplugging independently of hardware support (if available).
> 
> This patch set is derived from the ARM-specific vCPU hotplug implementation [4]
> and includes migration components adaptable to other architectures, following
> suggestions [5] made by Igor Mammedov <imammedo@redhat.com>.
> 
> It can be applied independently, ensuring compatibility with existing hotplug
> support in other architectures. I have tested this patch set in conjunction with
> the ARM-specific vCPU hotplug changes (included in the upcoming RFC V5 [6]), and
> everything worked as expected. I kindly request maintainers of other
> architectures to provide a "Tested-by" after running their respective regression
> tests.
> 
> Many thanks!
> 
> 
> References:
> [1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
>      architectures that don’t Support CPU Hotplug (like ARM64)
>      a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
>      b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
> [2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
>      SoC Based Systems (like ARM64)
>      Link: https://kvmforum2020.sched.com/event/eE4m
> [3] Check comment 5 in the bugzilla entry
>      Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
> [4] [PATCH RFC V4 00/33] Support of Virtual CPU Hotplug for ARMv8 Arch
>      Link: https://lore.kernel.org/qemu-devel/20241009031815.250096-1-salil.mehta@huawei.com/T/#mf32be203baa568a871dc625b732f666a4c4f1e68
> [5] Architecture agnostic ACPI VMSD state migration (Discussion)
>      Link: https://lore.kernel.org/qemu-devel/20240715155436.577d34c5@imammedo.users.ipa.redhat.com/
> [6] Upcoming RFC V5, Support of Virtual CPU Hotplug for ARMv8 Arch
>      Link: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v5
> 
> Salil Mehta (4):
>    hw/acpi: Initialize ACPI Hotplug CPU Status with Support for vCPU
>      `Persistence`
>    hw/acpi: Update ACPI CPU Status `is_{present, enabled}` during vCPU
>      hot(un)plug
>    hw/acpi: Reflect ACPI vCPU {present,enabled} states in ACPI
>      _STA.{PRES,ENA} Bits
>    hw/acpi: Populate vCPU Hotplug VMSD to migrate `is_{present,enabled}`
>      states
> 
>   cpu-target.c         patches.vcpuhp.rfc-v5.arch.agnostic.acpi          |  1 +
>   hw/acpi/cpu.c                  | 70 +++++++++++++++++++++++++++++++---
>   hw/acpi/generic_event_device.c | 11 ++++++
>   include/hw/acpi/cpu.h          | 21 ++++++++++
>   include/hw/core/cpu.h          | 21 ++++++++++
>   5 files changed, 119 insertions(+), 5 deletions(-)
> 


