Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95371CCF9E9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 02:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDDL3-0000y5-Up; Sun, 26 Oct 2025 22:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vDDL1-0000wu-Su; Sun, 26 Oct 2025 22:52:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1vDDKz-0004cJ-FA; Sun, 26 Oct 2025 22:52:03 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxnr9L3v5or+gaAA--.56573S3;
 Mon, 27 Oct 2025 10:51:55 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxvsFA3v5oOKYPAQ--.25786S3;
 Mon, 27 Oct 2025 10:51:46 +0800 (CST)
Subject: Re: [PATCH 20/27] hw/int/loongarch: Include missing 'system/memory.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20251024190416.8803-1-philmd@linaro.org>
 <20251024190416.8803-21-philmd@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <f37161a7-875d-ed91-51a0-a056579ccff2@loongson.cn>
Date: Mon, 27 Oct 2025 10:49:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251024190416.8803-21-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxvsFA3v5oOKYPAQ--.25786S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFWrJrW8Wr48Zr15ZF4DWrX_yoW5Zw15pF
 nrCr1agr4DGryUWa4v93WaqFWUJan7ur129Fya9Fy8Ar43tr10vw4ktwnruFy8G390qryq
 9ryfKr4rXa1UXrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
 Z7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.188,
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



On 2025/10/25 上午3:04, Philippe Mathieu-Daudé wrote:
> "system/memory.h" header is indirectly pulled by "hw/sysbus.h".
> Include it explicitly to avoid when refactoring the latter:
> 
>    In file included from ../../hw/intc/loongson_ipi.c:9:
>    In file included from /Users/philmd/source/qemu/include/hw/intc/loongson_ipi.h:12:
>    include/hw/intc/loongson_ipi_common.h:37:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
>       37 |     MemoryRegion ipi_iocsr_mem;
>          |                  ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/intc/loongarch_dintc.h         | 2 +-
>   include/hw/intc/loongarch_extioi_common.h | 1 +
>   include/hw/intc/loongarch_pch_msi.h       | 1 +
>   include/hw/intc/loongarch_pic_common.h    | 1 +
>   include/hw/intc/loongson_ipi_common.h     | 2 ++
>   5 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/intc/loongarch_dintc.h b/include/hw/intc/loongarch_dintc.h
> index 0b0b5347b2c..01bb1e465cb 100644
> --- a/include/hw/intc/loongarch_dintc.h
> +++ b/include/hw/intc/loongarch_dintc.h
> @@ -8,7 +8,7 @@
>   #include "qom/object.h"
>   #include "hw/sysbus.h"
>   #include "hw/loongarch/virt.h"
> -
> +#include "system/memory.h"
>   
>   #define NR_VECTORS     256
>   
> diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
> index c021ccee0fa..1bd2bfa07fc 100644
> --- a/include/hw/intc/loongarch_extioi_common.h
> +++ b/include/hw/intc/loongarch_extioi_common.h
> @@ -10,6 +10,7 @@
>   #include "qom/object.h"
>   #include "hw/sysbus.h"
>   #include "hw/loongarch/virt.h"
> +#include "system/memory.h"
>   
>   #define LS3A_INTC_IP                 8
>   #define EXTIOI_IRQS                  (256)
> diff --git a/include/hw/intc/loongarch_pch_msi.h b/include/hw/intc/loongarch_pch_msi.h
> index b8586fb3b6f..ef4ec4fdeb8 100644
> --- a/include/hw/intc/loongarch_pch_msi.h
> +++ b/include/hw/intc/loongarch_pch_msi.h
> @@ -6,6 +6,7 @@
>    */
>   
>   #include "hw/sysbus.h"
> +#include "system/memory.h"
>   
>   #define TYPE_LOONGARCH_PCH_MSI "loongarch_pch_msi"
>   OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHMSI, LOONGARCH_PCH_MSI)
> diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
> index 675ba96e64e..179361eb567 100644
> --- a/include/hw/intc/loongarch_pic_common.h
> +++ b/include/hw/intc/loongarch_pic_common.h
> @@ -9,6 +9,7 @@
>   
>   #include "hw/loongarch/virt.h"
>   #include "hw/sysbus.h"
> +#include "system/memory.h"
>   
>   #define PCH_PIC_INT_ID                  0x00
>   #define  PCH_PIC_INT_ID_VAL             0x7
> diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
> index e58ce2aa1c4..8b51af83e8b 100644
> --- a/include/hw/intc/loongson_ipi_common.h
> +++ b/include/hw/intc/loongson_ipi_common.h
> @@ -11,6 +11,8 @@
>   #include "qom/object.h"
>   #include "hw/sysbus.h"
>   #include "exec/memattrs.h"
> +#include "system/memory.h"
> +#include "system/memory.h"
one small nit for duplicated including here :)

Otherwise
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>   
>   #define IPI_MBX_NUM           4
>   
> 


