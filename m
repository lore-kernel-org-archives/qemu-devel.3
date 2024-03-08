Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE68AC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVlE-0004HS-CH; Fri, 08 Mar 2024 03:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1riVlC-0004H6-Tb
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:39:22 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1riVlA-0004M2-M4
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:39:22 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8BxVfG2zuplMzoWAA--.55474S3;
 Fri, 08 Mar 2024 16:39:18 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXs21zuplnitRAA--.14831S3; 
 Fri, 08 Mar 2024 16:39:17 +0800 (CST)
Subject: Re: [PATCH v6 08/17] hw/loongarch: Init efi_fdt table
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-9-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <7e41a3a0-7272-7373-fae4-6808d53227fd@loongson.cn>
Date: Fri, 8 Mar 2024 16:39:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240307164835.300412-9-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXs21zuplnitRAA--.14831S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw47Cry8JFWDXw45Jw48KrX_yoW8Zw4rpF
 9xZr95KrsYqF4qqrZ2qa4IvrnrArZ7KF12gw47t34FywnrJry5XF1fJasrAFykJw4FkFnY
 9rn2kw1UWFsrtwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 db8UUUUU=
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
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-9-gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c         | 11 +++++++++++
>   include/hw/loongarch/boot.h |  4 ++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 6126a37858..c6c6e6d194 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -112,6 +112,16 @@ static void init_efi_initrd_table(struct efi_system_table *systab,
>       initrd_table->size = initrd_size;
>   }
>   
> +static void init_efi_fdt_table(struct efi_system_table *systab)
> +{
> +    efi_guid_t tbl_guid = DEVICE_TREE_GUID;
> +
> +    /* efi_configuration_table 3 */
> +    guidcpy(&systab->tables[2].guid, &tbl_guid);
> +    systab->tables[2].table = (void *)0x100000; /* fdt_base 1MiB */
Can we use macro for 0x100000?

otherwise LGTM
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

> +    systab->nr_tables = 3;
> +}
> +
>   static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
>   {
>       void *bp_tables_start;
> @@ -137,6 +147,7 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
>                     sizeof(efi_memory_desc_t) * memmap_entries, 64);
>       init_efi_initrd_table(systab, p, start);
>       p += ROUND_UP(sizeof(struct efi_initrd), 64);
> +    init_efi_fdt_table(systab);
>   
>       systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
>   }
> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> index ddcb279874..9de673a0fd 100644
> --- a/include/hw/loongarch/boot.h
> +++ b/include/hw/loongarch/boot.h
> @@ -34,6 +34,10 @@ typedef struct {
>           EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, \
>                    0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
>   
> +#define DEVICE_TREE_GUID \
> +        EFI_GUID(0xb1b621d5, 0xf19c, 0x41a5,  0x83, 0x0b, \
> +                 0xd9, 0x15, 0x2c, 0x69, 0xaa, 0xe0)
> +
>   struct efi_config_table {
>       efi_guid_t guid;
>       uint64_t *ptr;
> 


