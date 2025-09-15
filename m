Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FF3CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 09:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy5K8-0008Nz-71; Mon, 15 Sep 2025 05:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uy5K5-0008MA-4D
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:16:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uy5Jy-0006LT-Rs
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:16:32 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxnr9g2cdoVngKAA--.21214S3;
 Mon, 15 Sep 2025 17:16:16 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxZORd2cdoE_eWAA--.20947S3;
 Mon, 15 Sep 2025 17:16:15 +0800 (CST)
Subject: Re: [PATCH 0/8] Add high MMIO support with GPEX host bridge
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
References: <20250915071946.315171-1-maobibo@loongson.cn>
 <20250915101109.00001833@huawei.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <b6b7e9f1-2da9-0460-9122-5fac812b71ad@loongson.cn>
Date: Mon, 15 Sep 2025 17:14:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250915101109.00001833@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxZORd2cdoE_eWAA--.20947S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4UZFykCw4fJF1fAF4DWrX_yoW8ZF4xpr
 W7ZFnYyr48JrySkwnIya45WF90yrn3Gr1IqF1aqrW8CrsxXr15ur1xA34q9FWjy348JF1v
 qr1kG34UWF1UZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
 xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.242,
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



On 2025/9/15 下午5:11, Jonathan Cameron wrote:
> On Mon, 15 Sep 2025 15:19:38 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> On LoongArch Virt Machine, MMIO region with GPEX host bridge is
>> 0x40000000 -- 0x7FFFFFFF. The total size is 1G bytes and it is enough
>> for emulated virtio devices basically.
>>
>> However on some conditions such as hostmem is added with virtio-gpu
>> device with -device virtio-gpu-gl,hostmem=4G. The PCIE MMIO region is
>> not enough, 64-bit high MMIO region is required.
>>
>> Here property highmem-mmio is added on virt machine to add 64-bit high
>> MMIO region supported. With high MMIO region added, it is not compatible
>> with old machine, so property highmem-mmio is disabled by default.
> 
> Trivial request. Please mention loongarch in the cover letter title.
> It will help people make a quick decision on whether they should be looking
> at the thread or not.
Thanks for reminder, I notice this when it is sent out.
Will be cautious about this in future.

Regards
Bibo Mao
> 
> Jonathan
> 
>>
>> Bibo Mao (8):
>>    target/loongarch: Add phys_bits in CPULoongArchState
>>    hw/loongarch/virt: Add field ram_end in LoongArchVirtMachineState
>>    hw/loongarch/virt: Add field gpx in LoongArchVirtMachineState
>>    hw/loongarch/virt: Get irq number from gpex config info
>>    hw/loongarch/virt: Get PCI info from gpex config info
>>    hw/loongarch/virt: Add property highmem_mmio with virt machine
>>    hw/loongarch/virt: Add high MMIO support with GPEX host
>>    hw/loongarch/virt: Add property highmem-mmio-size with virt machine
>>
>>   hw/loongarch/virt-acpi-build.c |  17 +---
>>   hw/loongarch/virt-fdt-build.c  |  43 +++++++---
>>   hw/loongarch/virt.c            | 152 ++++++++++++++++++++++++++++++---
>>   include/hw/loongarch/virt.h    |   5 +-
>>   target/loongarch/cpu.c         |  13 +--
>>   target/loongarch/cpu.h         |   2 +
>>   6 files changed, 186 insertions(+), 46 deletions(-)
>>
>>
>> base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d


