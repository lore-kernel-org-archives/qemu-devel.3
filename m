Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAACC3DA42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 02:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRjuz-0003Z1-Dn; Wed, 10 Jul 2024 22:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sRjuw-0003YS-7K
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 22:52:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sRjut-0007o5-IZ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 22:52:21 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cx_vDcSI9m6xgDAA--.9518S3;
 Thu, 11 Jul 2024 10:52:13 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxlsXaSI9mkHZDAA--.12884S3; 
 Thu, 11 Jul 2024 10:52:12 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/virt: Remove unused assignment
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240612033637.167787-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <43600b15-2654-c9e6-e78a-ed1ad1422898@loongson.cn>
Date: Thu, 11 Jul 2024 10:52:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240612033637.167787-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxlsXaSI9mkHZDAA--.12884S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww47tF1rXrWDWF4rKrW3Arc_yoW8AFyUpr
 4S9Fs7Xw48AFyDGw1Ska4UX3s2vrnxKr1IqFy7u340krnIyr1rKr4rJ34vgFy29ryxJFW8
 ZFWDAFy3Z3ZI9rXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU82-
 e7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.148, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2024/6/12 ÉÏÎç11:36, Bibo Mao Ð´µÀ:
> There is abuse usage about local variable gap. Remove
> duplicated assignment and solve Coverity reported error.
>
> Resolves: Coverity CID 1546441
> Fixes: 3cc451cbce ("hw/loongarch: Refine fwcfg memory map")
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
>   hw/loongarch/virt.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 66cef201ab..2fe08583b8 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1054,7 +1054,6 @@ static void fw_cfg_add_memory(MachineState *ms)
>           memmap_add_entry(base, gap, 1);
>           size -= gap;
>           base = VIRT_HIGHMEM_BASE;
> -        gap = ram_size - VIRT_LOWMEM_SIZE;
>       }
>   
>       if (size) {
> @@ -1067,17 +1066,17 @@ static void fw_cfg_add_memory(MachineState *ms)
>       }
>   
>       /* add fw_cfg memory map of other nodes */
> -    size = ram_size - numa_info[0].node_mem;
> -    gap  = VIRT_LOWMEM_BASE + VIRT_LOWMEM_SIZE;
> -    if (base < gap && (base + size) > gap) {
> +    if (numa_info[0].node_mem < gap && ram_size > gap) {
>           /*
>            * memory map for the maining nodes splited into two part
> -         *   lowram:  [base, +(gap - base))
> -         *   highram: [VIRT_HIGHMEM_BASE, +(size - (gap - base)))
> +         * lowram:  [base, +(gap - numa_info[0].node_mem))
> +         * highram: [VIRT_HIGHMEM_BASE, +(ram_size - gap))
>            */
> -        memmap_add_entry(base, gap - base, 1);
> -        size -= gap - base;
> +        memmap_add_entry(base, gap - numa_info[0].node_mem, 1);
> +        size = ram_size - gap;
>           base = VIRT_HIGHMEM_BASE;
> +    } else {
> +        size = ram_size - numa_info[0].node_mem;
>       }
>   
>      if (size)
>
> base-commit: 80e8f0602168f451a93e71cbb1d59e93d745e62e


