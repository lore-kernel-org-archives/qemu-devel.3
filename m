Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C519CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jve-0002sK-Vj; Wed, 24 Sep 2025 03:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v1Jvb-0002l2-GC
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:28:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v1JvU-0004RJ-IR
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:28:38 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxndKZndNoMfsNAA--.29619S3;
 Wed, 24 Sep 2025 15:28:25 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxQ+SVndNoXNWqAA--.21338S3;
 Wed, 24 Sep 2025 15:28:23 +0800 (CST)
Subject: Re: [PATCH 3/3] tests/data/acpi/loongarch64: Update expected DSDT.*
To: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, WANG Xuerui <git@xen0n.name>,
 qemu-devel@nongnu.org
References: <20250923143542.2391576-1-chenhuacai@kernel.org>
 <20250923143542.2391576-4-chenhuacai@kernel.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <08a40419-c56e-4944-2a8e-045f0512fe04@loongson.cn>
Date: Wed, 24 Sep 2025 15:26:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250923143542.2391576-4-chenhuacai@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+SVndNoXNWqAA--.21338S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurWxJrWkZrW3AF17Zw1UurX_yoW5KFyxp3
 y3Arsakr4xtFn3GFyDWrs8WFn5JrZF9FsFgF4xXry2kFsrGr1qvw1agr9aga45A34Yqa10
 v3WkGFy8tF1rW3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.829,
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

Add Michael

On 2025/9/23 下午10:35, Huacai Chen wrote:
> DSDT diffs from "iasl -d":
> 
> @@ -11,7 +11,7 @@
>    *     Signature        "DSDT"
>    *     Length           0x000011FB (4603)
>    *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> - *     Checksum         0x5D
> + *     Checksum         0x5B
>    *     OEM ID           "BOCHS "
>    *     OEM Table ID     "BXPC    "
>    *     OEM Revision     0x00000001 (1)
> @@ -1426,11 +1426,11 @@
>               Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>               {
>                   Memory32Fixed (ReadWrite,
> -                    0x100E001F,         // Address Base
> +                    0x100E0020,         // Address Base
>                       0x0000000C,         // Address Length
>                       )
>               })
> -            OperationRegion (PRST, SystemMemory, 0x100E001F, 0x0C)
> +            OperationRegion (PRST, SystemMemory, 0x100E0020, 0x0C)
>               Field (PRST, ByteAcc, NoLock, WriteAsZeros)
>               {
>                   Offset (0x04),
> 
> Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
> ---
>   tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4603 bytes
>   tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5824 bytes
>   tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4609 bytes
>   .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4905 bytes
>   tests/qtest/bios-tables-test-allowed-diff.h   |   4 ----
>   5 files changed, 4 deletions(-)
> 
> diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
> index b31841aec6ed296f10ea1695a67ead38f45424d5..55aa34f988d6ef69293e91c5fe45bee0a02bc5f1 100644
> GIT binary patch
> delta 44
> zcmeyZ{9BpJCD<k8w;%%pWAsL@BfP>2415AS3=9mF4ABh%LBSymJPMm1@=CD)02#3h
> APXGV_
> 
> delta 44
> zcmeyZ{9BpJCD<k8w;%%pW9&w*BfP@$415AS3=9mF4ABh%LBSymJo1|#@=CD)02$8<
> APXGV_
> 
> diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
> index e291200fc91caa3d93dcd6ec4736f7340f5e3f65..c0955eb60448cc5f4d38d410abc260ae54ea2e9a 100644
> GIT binary patch
> delta 44
> zcmX@0dq9`VCD<k8fEWV<W5PzRW+7n(20j5E1_p*ohUkWXpx_V&9)-;dgcMi+`vnS0
> 
> delta 44
> zcmX@0dq9`VCD<k8fEWV<W70;hW+7pD20j5E1_p*ohUkWXpx_V&9{J4+gcMi+`y&cU
> 
> diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
> index 07923ac39584c5a5e73c9556d251814ce10de6cc..61e47e7252155dcf9c76879c4f60f4b3eef63f86 100644
> GIT binary patch
> delta 44
> zcmZovX;k5I33dr#6k=dte72G62(PdL1D^m70|P@PLv%wxP;dwXkHY4Myb3G;-$V)Z
> 
> delta 44
> zcmZovX;k5I33dr#6k=dte6f-12(Pd_1D^m70|P@PLv%wxP;dwXkNoC`yb3G;-(m^%
> 
> diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
> index 6dfbb495f88b74b87849b58473e46717bc588a56..b2afebc938ce45d798c8aa5f45a463f1617e257e 100644
> GIT binary patch
> delta 44
> zcmZ3fwo;ADCD<iIQ<#B)@!UqPBfP>2415AS3=9mF4ABh%LBSymJPMm1@_MiW0PuGT
> Ag8%>k
> 
> delta 44
> zcmZ3fwo;ADCD<iIQ<#B)@xn%~BfP@$415AS3=9mF4ABh%LBSymJo1|#@_MiW0PvLx
> Ag8%>k
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 2ed837faee..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,5 +1 @@
>   /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/loongarch64/virt/DSDT",
> -"tests/data/acpi/loongarch64/virt/DSDT.memhp",
> -"tests/data/acpi/loongarch64/virt/DSDT.numamem",
> -"tests/data/acpi/loongarch64/virt/DSDT.topology",
> 


