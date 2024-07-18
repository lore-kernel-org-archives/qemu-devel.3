Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4B5C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMNF-0000PZ-3D; Thu, 18 Jul 2024 04:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sUMND-0000MB-7c
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sUMN9-0008Ut-KL
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:22 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxTeg40Jhm6YEAAA--.1961S3;
 Thu, 18 Jul 2024 16:20:09 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxWcY10JhmK49NAA--.42795S3; 
 Thu, 18 Jul 2024 16:20:08 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch: Remove unimplemented extioi INT_encode mode
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20240718072557.724242-1-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <43ab5a4e-32b6-9068-7be7-0de3ca6d0dfe@loongson.cn>
Date: Thu, 18 Jul 2024 16:20:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240718072557.724242-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxWcY10JhmK49NAA--.42795S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrW7JrWUAw4rCw1ktF1DJwc_yoW8CF1kpF
 nrCa4rGa1UKrWUCw4vg3sxXrnrGr93Wry2gF42gFy8JFn3Z34UZw15tas3JFWDA3ykK39a
 qFyfua45Xa1qvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.124,
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



On 2024/7/18 下午3:25, Song Gao wrote:
> Remove extioi INT_encode encode mode, because we don't emulate it.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c                | 6 ------
>   include/hw/intc/loongarch_extioi.h | 1 -
>   2 files changed, 7 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index e592b1b6b7..2103a1069f 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -951,9 +951,6 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
>           if (val & BIT_ULL(IOCSRM_EXTIOI_EN)) {
>               features |= BIT(EXTIOI_ENABLE);
>           }
> -        if (val & BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE)) {
> -            features |= BIT(EXTIOI_ENABLE_INT_ENCODE);
> -        }
I do not think this modification is necessary.

>   
>           address_space_stl(&lvms->as_iocsr,
>                             EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
> @@ -1002,9 +999,6 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           if (features & BIT(EXTIOI_ENABLE)) {
>               ret |= BIT_ULL(IOCSRM_EXTIOI_EN);
>           }
> -        if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
> -            ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
> -        }
Ditto, I do not think this modification is necessary also.
>           break;
>       default:
>           g_assert_not_reached();
> diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
> index eccc2e0d18..626a37dfa1 100644
> --- a/include/hw/intc/loongarch_extioi.h
> +++ b/include/hw/intc/loongarch_extioi.h
> @@ -50,7 +50,6 @@
>   #define  EXTIOI_HAS_CPU_ENCODE       (3)
>   #define  EXTIOI_VIRT_HAS_FEATURES    (BIT(EXTIOI_HAS_VIRT_EXTENSION)  \
>                                         | BIT(EXTIOI_HAS_ENABLE_OPTION) \
> -                                      | BIT(EXTIOI_HAS_INT_ENCODE)    \
>                                         | BIT(EXTIOI_HAS_CPU_ENCODE))
Only this modification will be ok.

Regards
Bibo Mao
>   #define EXTIOI_VIRT_CONFIG           (0x4)
>   #define  EXTIOI_ENABLE               (1)
> 


