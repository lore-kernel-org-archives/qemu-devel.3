Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCDDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 02:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgapH-0007Mt-Ft; Tue, 20 Aug 2024 22:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sgapE-0007Lb-6s
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:11:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sgapB-000416-Cp
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:11:51 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxuOnTTMVmucMaAA--.58371S3;
 Wed, 21 Aug 2024 10:11:32 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAx4+HRTMVm5ygcAA--.59923S3;
 Wed, 21 Aug 2024 10:11:31 +0800 (CST)
Subject: Re: [PATCH for-9.1] hw/loongarch: Fix length for lowram in ACPI SRAT
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20240820-fix-numa-range-v1-1-c5d6b889996f@flygoat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <88e7e62d-2b38-8b0b-0f5b-1b8115b920e4@loongson.cn>
Date: Wed, 21 Aug 2024 10:11:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240820-fix-numa-range-v1-1-c5d6b889996f@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx4+HRTMVm5ygcAA--.59923S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4fGw4DAF1rZr1fXryUXFc_yoW8Xw17pr
 43Zr4v9r48JF17ZFW8Gr13GF1UXrWkCa17W3W7tryUJwnrKr1rXr4kG3sF9F9rZw18Jrsx
 ZFyDtrWj9FWUZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.03,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2024/8/21 上午2:42, Jiaxun Yang wrote:
> The size of lowram should be "gap" instead of the whole node.
> 
> This is failing kernel's sanity check:
> 
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xffffffff]
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x16fffffff]
> [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x170000000-0x26fffffff]
> [    0.000000] Warning: node 0 [mem 0x00000000-0xffffffff] overlaps with itself [mem 0x80000000-0x16fffffff]
> 
> Fixes: fc100011f38d ("hw/loongarch: Refine acpi srat table for numa memory")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/loongarch/acpi-build.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 72bfc35ae6c2..2638f8743463 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -218,7 +218,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>            *   highram: [VIRT_HIGHMEM_BASE, +(len - gap))
>            */
>           if (len >= gap) {
> -            build_srat_memory(table_data, base, len, i, MEM_AFFINITY_ENABLED);
> +            build_srat_memory(table_data, base, gap, i, MEM_AFFINITY_ENABLED);
>               len -= gap;
>               base = VIRT_HIGHMEM_BASE;
>               gap = machine->ram_size - VIRT_LOWMEM_SIZE;
> 
> ---
> base-commit: 075fd020afe3150a0e6c4b049705b358b597b65a
> change-id: 20240820-fix-numa-range-f1f0302e138d
> 
> Best regards,
> 
Thanks for catching this.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>


