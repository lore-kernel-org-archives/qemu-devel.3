Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A933C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVSS-0008KM-0C; Fri, 08 Mar 2024 03:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1riVSO-0008JT-SH
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:19:57 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1riVSL-0007ko-VC
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:19:56 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8Dxqeggyupl7DgWAA--.35352S3;
 Fri, 08 Mar 2024 16:19:44 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxHBMfyuplnyNRAA--.19269S3; 
 Fri, 08 Mar 2024 16:19:43 +0800 (CST)
Subject: Re: [PATCH v6 02/17] hw/loongarch: Add load initrd
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-3-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <7b23ff58-fe28-48ca-e8e4-dadf7c3b7451@loongson.cn>
Date: Fri, 8 Mar 2024 16:19:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240307164835.300412-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHBMfyuplnyNRAA--.19269S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4rXw1ktw47AFW7Xw4fWFX_yoW8CrWkpF
 ZxAF98CrySyFWxAwnxAa48uF93Aw18Kr15WF9xKryFvrZIgr1DZF18Zr97urWvva1fKFn0
 qFn8Cw4j9a4DtrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.08,
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



On 2024/3/8 上午12:48, Song Gao wrote:
> we load initrd ramdisk after kernel_high address
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-3-gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index a8a725a0a8..149deb2e01 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -22,7 +22,8 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>   
>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>   {
> -    uint64_t kernel_entry, kernel_low, kernel_high;
> +    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
> +    ram_addr_t initrd_offset;
>       ssize_t kernel_size;
>   
>       kernel_size = load_elf(info->kernel_filename, NULL,
> @@ -37,6 +38,32 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>                        load_elf_strerror(kernel_size));
>           exit(1);
>       }
> +
> +    if (info->initrd_filename) {
> +        initrd_size = get_image_size(info->initrd_filename);
> +        if (initrd_size > 0) {
> +            initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
> +
> +            if (initrd_offset + initrd_size > info->ram_size) {
> +                error_report("memory too small for initial ram disk '%s'",
> +                             info->initrd_filename);
> +                exit(1);
> +            }
> +
> +            initrd_size = load_image_targphys(info->initrd_filename, initrd_offset,
> +                                              info->ram_size - initrd_offset);
> +        }
> +
> +        if (initrd_size == (target_ulong)-1) {
> +            error_report("could not load initial ram disk '%s'",
> +                         info->initrd_filename);
> +            exit(1);
> +        }
> +    } else {
> +        error_report("Need initrd!");
> +        exit(1);
> +    }
> +
>       return kernel_entry;
>   }
>   
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


