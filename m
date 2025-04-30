Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CEAC3ABA5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 01:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9w4f-0002nB-HX; Tue, 29 Apr 2025 21:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u9w4c-0002mj-Uh
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 21:17:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u9w4a-0001jN-1w
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 21:17:18 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxjawRehFoNqHKAA--.40385S3;
 Wed, 30 Apr 2025 09:17:05 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxj8UOehFoJDWfAA--.8923S3;
 Wed, 30 Apr 2025 09:17:04 +0800 (CST)
Subject: Re: [PATCH V2] hw/loongarch/boot: Adjust the loading position of the
 initrd
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <20250326114035.712130-1-lixianglai@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <29e72c42-b6d1-7204-dd3e-161d101aaa59@loongson.cn>
Date: Wed, 30 Apr 2025 09:15:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250326114035.712130-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8UOehFoJDWfAA--.8923S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw4fuF1xGr4fXF1DurWrXrc_yoWrWFWUpF
 ZrCrnxWr1vyFZ7JwnxJFy8ur9ayw4rKF13XF9xKryvkrsFgr1DZF1rJry8ZrWkAw4fCFn0
 qF1DCr1j9a4UJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.12,
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



On 2025/3/26 下午7:40, Xianglai Li wrote:
> When only the -kernel parameter is used to load the elf kernel,
> the initrd is loaded in the ram. If the initrd size is too large,
> the loading fails, resulting in a VM startup failure.
> This patch first loads initrd near the kernel.
> When the nearby memory space of the kernel is insufficient,
> it tries to load it to the starting position of high memory.
> If there is still not enough, qemu will report an error
> and ask the user to increase the memory space for the
> virtual machine to boot.
With the changelog, the maximum characters are 75 in a line. It seems 
that most is 50-65, it is too short :)

Also there should be an empty line for two paragraphs.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
> ChangeLog:
> V1->V2:
> If the low memory is insufficient, the initrd is directly loaded
> from the start address of the high memory, and the node0 memory space is not counted.
> 
>   hw/loongarch/boot.c | 53 +++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 354cf458c8..c24edfeb59 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -235,6 +235,48 @@ static int64_t load_loongarch_linux_image(const char *filename,
>       return size;
>   }
>   
> +static void find_initrd_loadoffset(struct loongarch_boot_info *info,
The function find_initrd_loadoffset() is a little strange, how about
get_initrd_memory() or alloc_initrd_memory()?

> +                uint64_t kernel_high, ssize_t kernel_size)
> +{
> +    hwaddr base, size, gap, low_end;
> +    ram_addr_t initrd_end, initrd_start;
> +
> +    base = VIRT_LOWMEM_BASE;
> +    gap = VIRT_LOWMEM_SIZE;
> +    initrd_start = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
I think it should move out of this function, it is irrelative with 
initrd memory allocation.
> +    initrd_end = initrd_start + initrd_size;
Had better not use global variable initrd_size, I will submit one patch 
to remove global variables about initrd.
> +
> +    size = info->ram_size;
> +    low_end = base + MIN(size, gap);
> +    if (initrd_end <= low_end) {
> +        initrd_offset = initrd_start;
> +        return ;

> +    }
> +
> +    if (size <= gap) {
> +        error_report("The low memory too small for initial ram disk '%s',"
> +             "You need to expand the memory space",
> +             info->initrd_filename);
> +        exit(1);
> +    }
> +
> +    /*
> +     * Try to load initrd in the high memory
> +     */
> +    size -= gap;
> +    base = VIRT_HIGHMEM_BASE;
> +    initrd_start = ROUND_UP(base, 64 * KiB);
this line is unnecessary, how about
        initrd_start = VIRT_HIGHMEM_BASE;
> +    if (initrd_size <= size) {
> +        initrd_offset = initrd_start;
> +        return ;
> +    }
> +
> +    error_report("The high memory too small for initial ram disk '%s',"
> +         "You need to expand the memory space",
> +         info->initrd_filename);
> +    exit(1);
> +}
> +
>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>   {
>       uint64_t kernel_entry, kernel_low, kernel_high;
> @@ -261,16 +303,9 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>       if (info->initrd_filename) {
>           initrd_size = get_image_size(info->initrd_filename);
>           if (initrd_size > 0) {
> -            initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
> -
> -            if (initrd_offset + initrd_size > info->ram_size) {
> -                error_report("memory too small for initial ram disk '%s'",
> -                             info->initrd_filename);
> -                exit(1);
> -            }
> -
I think these line can keep unchanged.
> +            find_initrd_loadoffset(info, kernel_high, kernel_size);
how about add return and input parameter for this function.
initrd_offset = alloc_initrd_memory(info, initrd_offset, initrd_size);

Regards
Bibo Mao
>               initrd_size = load_image_targphys(info->initrd_filename, initrd_offset,
> -                                              info->ram_size - initrd_offset);
> +                                              initrd_size);
>           }
>   
>           if (initrd_size == (target_ulong)-1) {
> 


