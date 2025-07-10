Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F480C83F10
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 01:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZgQR-0003Ro-FK; Wed, 09 Jul 2025 21:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uZgQP-0003RM-5I
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 21:50:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uZgQL-0003hP-TM
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 21:50:12 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxjXJHHG9oru0lAQ--.15268S3;
 Thu, 10 Jul 2025 09:49:59 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxpeRFHG9oDOMQAA--.31575S3;
 Thu, 10 Jul 2025 09:49:59 +0800 (CST)
Subject: Re: [PATCH v4 01/11] target/loongarch: move some machine dfine to
 virt.h
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250703092650.2598059-1-gaosong@loongson.cn>
 <20250703092650.2598059-2-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <81576ca8-26ef-92d9-a7b3-15460044c1ea@loongson.cn>
Date: Thu, 10 Jul 2025 09:48:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250703092650.2598059-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpeRFHG9oDOMQAA--.31575S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWftw4fXryDAr18JF1xCrX_yoW8Kr4UpF
 1ayF98Kr4jyFW7G34vg3ZxXr13Xws7Gr1jkF47W3ykCFsrXw18ur1jgwsIqFW5ZrZ3GryI
 qrnYvw1Uua9rWrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.691,
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



On 2025/7/3 下午5:26, Song Gao wrote:
> move some machine define to virt.h
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   include/hw/loongarch/virt.h | 19 +++++++++++++++++++
>   target/loongarch/cpu.h      | 21 ---------------------
>   2 files changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 602feab0f0..7120b46714 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -13,6 +13,25 @@
>   #include "hw/block/flash.h"
>   #include "hw/loongarch/boot.h"
>   
> +#define IOCSRF_TEMP             0
> +#define IOCSRF_NODECNT          1
> +#define IOCSRF_MSI              2
> +#define IOCSRF_EXTIOI           3
> +#define IOCSRF_CSRIPI           4
> +#define IOCSRF_FREQCSR          5
> +#define IOCSRF_FREQSCALE        6
> +#define IOCSRF_DVFSV1           7
> +#define IOCSRF_GMOD             9
> +#define IOCSRF_VM               11
> +
> +#define VERSION_REG             0x0
> +#define FEATURE_REG             0x8
> +#define VENDOR_REG              0x10
> +#define CPUNAME_REG             0x20
> +#define MISC_FUNC_REG           0x420
> +#define IOCSRM_EXTIOI_EN        48
> +#define IOCSRM_EXTIOI_INT_ENCODE 49
> +
>   #define LOONGARCH_MAX_CPUS      256
>   
>   #define VIRT_FWCFG_BASE         0x1e020000UL
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 9538e8d61d..56fc4a1459 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -21,27 +21,6 @@
>   #include "cpu-csr.h"
>   #include "cpu-qom.h"
>   
> -#define IOCSRF_TEMP             0
> -#define IOCSRF_NODECNT          1
> -#define IOCSRF_MSI              2
> -#define IOCSRF_EXTIOI           3
> -#define IOCSRF_CSRIPI           4
> -#define IOCSRF_FREQCSR          5
> -#define IOCSRF_FREQSCALE        6
> -#define IOCSRF_DVFSV1           7
> -#define IOCSRF_GMOD             9
> -#define IOCSRF_VM               11
> -
> -#define VERSION_REG             0x0
> -#define FEATURE_REG             0x8
> -#define VENDOR_REG              0x10
> -#define CPUNAME_REG             0x20
> -#define MISC_FUNC_REG           0x420
> -#define IOCSRM_EXTIOI_EN        48
> -#define IOCSRM_EXTIOI_INT_ENCODE 49
> -
> -#define IOCSR_MEM_SIZE          0x428
> -
>   #define FCSR0_M1    0x1f         /* FCSR1 mask, Enables */
>   #define FCSR0_M2    0x1f1f0000   /* FCSR2 mask, Cause and Flags */
>   #define FCSR0_M3    0x300        /* FCSR3 mask, Round Mode */
> 

one small nit with mail title spell issue, %s/dfine/define/
   "move some machine dfine to virt.h"

otherwise look good to me.
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


