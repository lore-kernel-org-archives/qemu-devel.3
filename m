Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C088C8303D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 02:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWnNL-0005W6-5x; Tue, 01 Jul 2025 22:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uWnNJ-0005Vy-3K
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:39:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uWnNF-0003OG-HG
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:39:04 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxmnG8m2RolvcgAQ--.6310S3;
 Wed, 02 Jul 2025 10:38:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDx_8Oxm2RoDiQGAA--.35027S3;
 Wed, 02 Jul 2025 10:38:48 +0800 (CST)
Subject: Re: [PATCH v3 0/9] hw/loongarch: add the advanced extended interrupt
 controllers (AVECINTC) support
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250627030138.2482055-1-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <68466330-a6b7-243a-dc6b-c100945732e8@loongson.cn>
Date: Wed, 2 Jul 2025 10:37:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250627030138.2482055-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8Oxm2RoDiQGAA--.35027S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr4rCrWftr48XF1DJry3ZFc_yoWrGr47p3
 yfCF1ayF4UJr98Zrn7t3W5Xwn8Xrn3Gw42vF13Kry8ury2yr18Zr18J34kZFyUJ348Wr1j
 qFy0kw1UXa1UJrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOb18U
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.077,
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



On 2025/6/27 上午11:01, Song Gao wrote:
> ntroduce the advanced extended interrupt controllers (AVECINTC). This
> feature will allow each core to have 256 independent interrupt vectors
> and MSI interrupts can be independently routed to any vector on any CPU.
> 
> The whole topology of irqchips in LoongArch machines looks like this if
> AVECINTC is supported:
> 
>    +-----+     +-----------------------+     +-------+
>    | IPI | --> |        CPUINTC        | <-- | Timer |
>    +-----+     +-----------------------+     +-------+
>                 ^          ^          ^
>                 |          |          |
>          +---------+ +----------+ +---------+     +-------+
>          | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
>          +---------+ +----------+ +---------+     +-------+
>               ^            ^
>               |            |
>          +---------+  +---------+
>          | PCH-PIC |  | PCH-MSI |
>          +---------+  +---------+
I think this topology has a little problem, PCH-MSI is connected to 
EIOINTC always, AVECINTC is fully new MSI interrupt controller. AVECINTC 
can coexist with PCH-MSI conroller.

MSI interrupt of device can connect to PCH-MSI or AVECINTC, it depends 
on how MSI vector is allocated on VM.

Regards
Bibo Mao
>            ^     ^           ^
>            |     |           |
>    +---------+ +---------+ +---------+
>    | Devices | | PCH-LPC | | Devices |
>    +---------+ +---------+ +---------+
>                     ^
>                     |
>                +---------+
>                | Devices |
>                +---------+
> 
> We can see more about AVECINTC on linux driver code[1]
> and loongarch msg interrupts on volI 6.2 Message-Interrupts
> 
> Tested the code using the virion-net NIC the start scripts is kernel.sh at[3] and then
> run 'ifconfig eth0 192.168.122.12'
> 
> [1]: https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-loongarch-avec.c
> [2]: https://github.com/loongson/LoongArch-Documentation/releases/download/2023.04.20/LoongArch-Vol1-v1.10-EN.pdf
> [3]: https://github.com/gaosong715/qemu/releases/download/pull-loongarch-20250514/kernel.sh
> 
> 
> v3:
>    1: Implement the read-clear feature for CSR_MSGIR register
>    2: Fix some code style;
>    3: Merge patch8 and patch9 into one patch8;
>    4: Fix patch7 get wrong cpu_num and irq_num;
>    5: Add vmstate_msg for messag-interrupt registers migrate;
>    6: Update test scripts use  '-bios', because kernel use avec need acpi
> support. the bios is qemu/pc_bios/edk2-loongarch64-code.fd.bz2.
> 
> v2:
>    1: Use one irqline for avec parent_irq;
>    2; Correct avec memroy area;
>    3; Pch-msi not connecet to avec when avec is enabled and drop patch 7;
>    4: Add misc_feature and misc_status for misc features an misc
> 
> Thanks.
> Song Gao
> 
> 
> Song Gao (9):
>    hw/loongarch: move some machine define to virt.h
>    hw/loongarch: add virt feature avecintc support
>    loongarch: add a advance interrupt controller device
>    target/loongarch: add msg interrupt CSR registers
>    hw/loongarch: AVEC controller add a MemoryRegion
>    hw/loongarch: Implement avec controller imput and output pins
>    hw/loongarch: Implement avec set irq
>    target/loongarch: CPU enable msg interrupts.
>    target/loongarch:Implement csrrd CSR_MSGIR register
> 
>   hw/intc/Kconfig                               |   3 +
>   hw/intc/loongarch_avec.c                      | 153 ++++++++++++++++++
>   hw/intc/meson.build                           |   1 +
>   hw/loongarch/Kconfig                          |   1 +
>   hw/loongarch/virt.c                           |  89 +++++++++-
>   include/hw/intc/loongarch_avec.h              |  36 +++++
>   include/hw/loongarch/virt.h                   |  36 +++++
>   include/hw/pci-host/ls7a.h                    |   2 +
>   target/loongarch/cpu-csr.h                    |   9 +-
>   target/loongarch/cpu.c                        |  17 ++
>   target/loongarch/cpu.h                        |  34 ++--
>   target/loongarch/csr.c                        |   5 +
>   target/loongarch/machine.c                    |  25 ++-
>   target/loongarch/tcg/csr_helper.c             |  21 +++
>   target/loongarch/tcg/helper.h                 |   1 +
>   .../tcg/insn_trans/trans_privileged.c.inc     |   1 +
>   16 files changed, 405 insertions(+), 29 deletions(-)
>   create mode 100644 hw/intc/loongarch_avec.c
>   create mode 100644 include/hw/intc/loongarch_avec.h
> 


