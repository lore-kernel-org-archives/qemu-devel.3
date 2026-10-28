Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26181606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 01:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLsNj-00040C-4k; Tue, 27 Oct 2026 21:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xLsNe-0003zd-U7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 21:23:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xLsNb-0001go-V9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 21:23:06 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxLtNuTuFqUPwZAA--.9735S3;
 Wed, 28 Oct 2026 09:22:54 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBxpMxtTuFqKM8wAA--.9593S2;
 Wed, 28 Oct 2026 09:22:53 +0800 (CST)
Subject: Re: [PATCH v5 0/5] hw/loogarch: Fix UART ACPI properties and FDT
To: pillow <waysorrypub@gmail.com>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, lixianglai@loongson.cn, jiaxun.yang@flygoat.com,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com
References: <20261025135559.236356-1-waysorrypub@gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <a561f9d1-c83c-b2cf-ebde-5f37fe0bf69f@loongson.cn>
Date: Wed, 28 Oct 2026 09:24:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261025135559.236356-1-waysorrypub@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpMxtTuFqKM8wAA--.9593S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF45Cw1kKr4kAF17Kw4DGFX_yoW8AF4Upr
 W3CFs3tr97tF97WFyj9w1kX3WDJrsrCw12gF12gryxCan8Cr4jvr1fZr97ta47Aa4Fvw10
 vw18W348XFyDuFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.209,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/10/25 下午9:55, pillow wrote:
> This series fixes the UART description for LoongArch virt.
> 
> The ACPI _DSD property built for the UART has three problems: the
> property name is misspelled, the key and value order is reversed, and
> it describes a 100 MHz clock that does not match the device model.
> The property can be dropped directly because the UART model's input
> clock matches the Linux 8250 PnP driver default of 1,843,200 Hz, so no
> _DSD override is needed.
> 
> The _CCA property is also unnecessary.  _CCA describes a device's DMA
> cache coherency attribute, and this UART does not support DMA, so there
> is no reason to declare it.
> 
> The UART clock frequency in the FDT is corrected to 1,843,200 Hz, and
> the expected ACPI tables are updated accordingly.
> 
> pillow (5):
>    bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
>    hw/loongarch/virt-acpi-build: Drop invalid _DSD UART clock property
>    hw/loongarch/virt-acpi-build: Drop UART _CCA declaration
>    hw/loongarch/virt: Fix UART clock frequency in FDT
>    tests/data/acpi/loongarch64: Update expected DSDT.*
> 
>   hw/loongarch/virt-acpi-build.c                |  11 -----------
>   hw/loongarch/virt-fdt-build.c                 |   2 +-
>   tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4351 bytes
>   tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5572 bytes
>   tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4357 bytes
>   .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4653 bytes
>   6 files changed, 1 insertion(+), 12 deletions(-)
> 

Removing _STA works on some x86 windows and linux guest OSs by testing, 
with LoongArch it works well on Linux guest OS.

For this series:
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


