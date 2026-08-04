Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AAFC55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 06:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr8Lu-0002m4-Fi; Tue, 04 Aug 2026 02:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wr8Lr-0002lv-Ff
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 02:10:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wr8Lo-0002Gw-Fw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 02:10:11 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axw+k1gnFqGy4KAA--.10247S3;
 Tue, 04 Aug 2026 14:09:58 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxEuQ0gnFquQ8jAA--.58388S2;
 Tue, 04 Aug 2026 14:09:56 +0800 (CST)
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Set MADT revision to 6
To: Dongyan Qian <qiandongyan@loongson.cn>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, lixianglai@loongson.cn, jiaxun.yang@flygoat.com
References: <20260804033036.2614008-1-qiandongyan@loongson.cn>
 <20260804033036.2614008-3-qiandongyan@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <658601d7-1660-3a53-7b21-9d878fdafa4f@loongson.cn>
Date: Tue, 4 Aug 2026 14:09:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260804033036.2614008-3-qiandongyan@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxEuQ0gnFquQ8jAA--.58388S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWkZr1rtr47ZFW7WF48GrX_yoW8AF1xpF
 4ruw1rtFn8XwnxZ39rJ3yF9F15ZrsxG3WI9a1jkryUCwnrKry8WF4S9FW3tFy3C3s5Gr4q
 qw4rt347WFWUZrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UNvtZU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.459,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/8/4 上午11:30, Dongyan Qian wrote:
> The LoongArch virt machine emits Core PIC, EIO PIC, MSI PIC and BIO PIC
> subtables, but advertises MADT revision 1. Revision 1 predates these
> LoongArch interrupt controller structures.
> 
> ACPI 6.5 introduced the LoongArch interrupt controller structures and
> defined MADT revision 6. ACPI 6.6 raises the MADT revision to 7 for the
> additional RISC-V interrupt controller structures, while leaving the
> LoongArch structures unchanged.
> 
> Since the virt machine emits only the LoongArch structures defined by
> ACPI 6.5, set the MADT header revision to 6, the minimum revision that
> describes the table contents.
> 
> ACPI specifications:
> https://uefi.org/specs/ACPI/6.5/
> https://uefi.org/specs/ACPI/6.6/
> 
> Fixes: 735143f10d3 ("hw/loongarch: Add acpi ged support")
> Signed-off-by: Dongyan Qian <qiandongyan@loongson.cn>
> ---
>   hw/loongarch/virt-acpi-build.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index a0b445f297..600ef60fc5 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -128,7 +128,7 @@ build_madt(GArray *table_data, BIOSLinker *linker,
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>       const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
>       int i, arch_id, flags;
> -    AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = lvms->oem_id,
> +    AcpiTable table = { .sig = "APIC", .rev = 6, .oem_id = lvms->oem_id,
>                           .oem_table_id = lvms->oem_table_id };
>   
>       acpi_table_begin(&table, table_data);
> 
For this series.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>


