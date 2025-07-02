Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B75C8303D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 01:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWmWC-0001bE-ET; Tue, 01 Jul 2025 21:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uWmW9-0001ao-7Y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 21:44:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uWmW5-0007Qo-9W
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 21:44:09 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxWXHZjmRo6_IgAQ--.6862S3;
 Wed, 02 Jul 2025 09:43:53 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxocLTjmRolRcGAA--.34412S3;
 Wed, 02 Jul 2025 09:43:52 +0800 (CST)
Subject: Re: [PATCH v3 1/9] hw/loongarch: move some machine define to virt.h
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250627030138.2482055-1-gaosong@loongson.cn>
 <20250627030138.2482055-2-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <85faff6d-f077-413c-76b0-abbb2abd2d7c@loongson.cn>
Date: Wed, 2 Jul 2025 09:42:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250627030138.2482055-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocLTjmRolRcGAA--.34412S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF47GFWDCryDCF4ftw43urX_yoWrJw4fpF
 WayF98tr1UKF47Kwn2gwnxXrnxXws7Gr12kr47u3y8CF47Xw1kur10gwsxXFy5Z3s3GrWI
 qrn5Xw1UuayDWwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXU
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
> move som machine define to virt.h and define avec feature and status bit.
> Use the IOCSRF_AVEC bit for avdance interrupt controller drivers
> avecintc_enable[1] and set the default value of the MISC_FUNC_REG bit IOCSRM_AVEC_EN.
> and set the default value of the MISC_FUNC_REG bit IOCSRM_AVEC_EN.
> 
> [1]:https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-loongarch-avec.c
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c         |  4 ++++
>   include/hw/loongarch/virt.h | 20 ++++++++++++++++++++
>   target/loongarch/cpu.h      | 21 ---------------------
>   3 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index b15ada2078..6a169d4824 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -574,6 +574,8 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           break;
>       case FEATURE_REG:
>           ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
> +        /*TODO: check bit IOCSRF_AVEC with virt_is_avec_enabled */
Space needed with /*TODO.
Does this patch pass with command scripts/checkpatch.pl?

> +        ret |= BIT(IOCSRF_AVEC);
Why is AVEC capability enabled always? If there is TODO, this patch 
should not be the first one.

>           if (kvm_enabled()) {
>               ret |= BIT(IOCSRF_VM);
>           }
> @@ -603,6 +605,8 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
>               ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
>           }
> +        /* enable avec default */
> +        ret |= BIT_ULL(IOCSRM_AVEC_EN);
>           break;
>       default:
>           g_assert_not_reached();
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 602feab0f0..cc6656619d 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -13,6 +13,26 @@
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
> +#define IOCSRF_AVEC             15
> +
> +#define VERSION_REG             0x0
> +#define FEATURE_REG             0x8
> +#define VENDOR_REG              0x10
> +#define CPUNAME_REG             0x20
> +#define MISC_FUNC_REG           0x420
> +#define IOCSRM_EXTIOI_EN        48
> +#define IOCSRM_EXTIOI_INT_ENCODE 49
> +#define IOCSRM_AVEC_EN           51
I suggest to split it into two patches, one is purely code moving 
between header files, the other is actual code modification.

Regards
Bibo Mao

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


