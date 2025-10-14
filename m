Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799A1CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8b57-0002xf-3X; Tue, 14 Oct 2025 05:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v8b50-0002tt-NJ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:12:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v8b4w-0001Az-5I
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:12:26 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxL9P0E+5oj_MVAA--.46419S3;
 Tue, 14 Oct 2025 17:12:20 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxzsHyE+5ol1DhAA--.10979S3;
 Tue, 14 Oct 2025 17:12:19 +0800 (CST)
Subject: Re: [PATCH 1/4] hw/loongarch/boot: Remove unnecessary cast to
 target_ulong
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20251009201947.34643-1-philmd@linaro.org>
 <20251009201947.34643-2-philmd@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <11061e2b-41c7-1a37-7c7e-cbad3df7b648@loongson.cn>
Date: Tue, 14 Oct 2025 17:12:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251009201947.34643-2-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxzsHyE+5ol1DhAA--.10979S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF1UWr47JFy5Aw4xCr1kCrX_yoW8ArWUpr
 srAw15tr1FyrWru3y2yFy8ur97tw1rGr4agF9xKFyFyrZFgr1UZFy8Zry7ZFWDXw4rKFn0
 qFn5Aw1jq3WUtwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vD73UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.658,
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

在 2025/10/10 上午4:19, Philippe Mathieu-Daudé 写道:
> Reduce initrd_size scope. It is already of signed type (ssize_t),
> no need to cast to unsigned for the comparison.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/loongarch/boot.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
Signed-off-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index a516415822d..3dd48cb8aab 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -306,7 +306,7 @@ static ram_addr_t alloc_initrd_memory(struct loongarch_boot_info *info,
>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>   {
>       uint64_t kernel_entry, kernel_low, kernel_high, initrd_offset = 0;
> -    ssize_t kernel_size, initrd_size;
> +    ssize_t kernel_size;
>   
>       kernel_size = load_elf(info->kernel_filename, NULL,
>                              cpu_loongarch_virt_to_phys, NULL,
> @@ -328,7 +328,8 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>       }
>   
>       if (info->initrd_filename) {
> -        initrd_size = get_image_size(info->initrd_filename);
> +        ssize_t initrd_size = get_image_size(info->initrd_filename);
> +
>           if (initrd_size > 0) {
>               initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
>               initrd_offset = alloc_initrd_memory(info, initrd_offset,
> @@ -337,7 +338,7 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>                                                 initrd_offset, initrd_size);
>           }
>   
> -        if (initrd_size == (target_ulong)-1) {
> +        if (initrd_size == -1) {
>               error_report("could not load initial ram disk '%s'",
>                            info->initrd_filename);
>               exit(1);


