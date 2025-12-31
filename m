Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7EDEE57F5
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 10:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vat4N-0000Sl-4Q; Wed, 31 Dec 2025 05:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vat3y-0000OF-Jd
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 05:04:25 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vat3t-0006eJ-Fe
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 05:04:17 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxvsMW9VRpqqIEAA--.14878S3;
 Wed, 31 Dec 2025 18:04:06 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDxquAT9VRpEtAHAA--.19887S3;
 Wed, 31 Dec 2025 18:04:06 +0800 (CST)
Subject: Re: [PATCH v3 0/7] hw/loongarch/virt: Add high MMIO support with GPEX
 host bridge
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20251017064523.2065993-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3b55d1f1-884f-da68-ae23-5b1824c3a9a9@loongson.cn>
Date: Wed, 31 Dec 2025 18:04:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251017064523.2065993-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxquAT9VRpEtAHAA--.19887S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF1kXF1xKF1kWFy3ur4Utrc_yoW8uw4kpr
 9xAF1Fyw48Jr93Ca9xJa45WFn8Grs3Gw12q3W3XrWFkr1DWr1Uur4xA34FvFWjy348JFy8
 W34kG347WF15Z3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.628,
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

在 2025/10/17 下午2:45, Bibo Mao 写道:
> On LoongArch Virt Machine, MMIO region with GPEX host bridge is
> 0x40000000 -- 0x7FFFFFFF. The total size is 1G bytes and it is enough for
> emulated virtio devices basically.
>
> However on some conditions such as hostmem is added with virtio-gpu device
> with -device virtio-gpu-gl,hostmem=4G. The PCIE MMIO region is not enough,
> 64-bit high MMIO region is required.
>
> Like other architectures, here property highmem-mmio is added on virt
> machine to add 64-bit high MMIO region supported. With high MMIO region
> added, it is not compatible with old machine, so property highmem-mmio is
> disabled by default.
>
> ---
> v2 ... v3:
>    1. Fix high MMIO space access failure with UEFI BIOS on TCG mode, since
>       there is 1:1 identified mapping with UEFI bios, virtual address
>       space is 47 bit actually with PGDL root page table, where fail to
>       setup mapping table for 48 bit physical address. Here set physical
>       address width smaller than virtual address width.
>
> v1 ... v2:
>    1. Solve some code conflict and refresh the patch on the latest version.
>    2. Base address of GPEX high MMIO starts from end of max physical
>       address region rather than adjacent with DRAM, since it is fixed with
>       the previous method.
> ---
> Bibo Mao (7):
>    hw/loongarch/virt: Add field ram_end in LoongArchVirtMachineState
>    hw/loongarch/virt: Add field gpex in LoongArchVirtMachineState
>    hw/loongarch/virt: Get irq number from gpex config info
>    hw/loongarch/virt: Get PCI info from gpex config info
>    hw/loongarch/virt: Add property highmem_mmio with virt machine
>    hw/loongarch/virt: Add high MMIO support with GPEX host
>    hw/loongarch/virt: Add property highmem-mmio-size with virt machine
>
>   hw/loongarch/virt-acpi-build.c |  17 +---
>   hw/loongarch/virt-fdt-build.c  |  43 +++++---
>   hw/loongarch/virt.c            | 175 ++++++++++++++++++++++++++++++---
>   include/hw/loongarch/virt.h    |   5 +-
>   4 files changed, 200 insertions(+), 40 deletions(-)
>
>
> base-commit: 18f6f30b0089b470f3e737637a86dfb81ebd6eae
HI,  this series need  rebase .

Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


