Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E8EC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 09:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riWPf-0008US-OK; Fri, 08 Mar 2024 04:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riWPD-0008Q2-DX
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 04:20:44 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riWP6-00067z-Ad
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 04:20:43 -0500
Received: from loongson.cn (unknown [117.67.153.132])
 by gateway (Coremail) with SMTP id _____8CxSPBb2OplQj0WAA--.55760S3;
 Fri, 08 Mar 2024 17:20:27 +0800 (CST)
Received: from [192.168.2.12] (unknown [117.67.153.132])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxnhNa2OplaTxRAA--.29620S3; 
 Fri, 08 Mar 2024 17:20:26 +0800 (CST)
Message-ID: <011048eb-e8db-d086-d473-7cd627dcb658@loongson.cn>
Date: Fri, 8 Mar 2024 17:20:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 07/17] hw/loongarch: Init efi_initrd table
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, maobibo@loongson.cn
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-8-gaosong@loongson.cn>
 <1df3c991-ff91-47dd-a86e-3b2cf6918460@linaro.org>
From: gaosong <gaosong@loongson.cn>
In-Reply-To: <1df3c991-ff91-47dd-a86e-3b2cf6918460@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnhNa2OplaTxRAA--.29620S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr4UXF13tFWUCw1fXFyxJFc_yoWrWFykpF
 1kJry5JrWrAr1kJr1xJryUCFyDJr48G3ZrWw1xXFy0yrsrJr1jqF4UXr9F9FyDJr4rGr1j
 yr1Yqr17ZFsrJrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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



在 2024/3/8 16:36, Philippe Mathieu-Daudé 写道:
> Hi Song,
> 
> On 7/3/24 17:48, Song Gao wrote:
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Message-Id: <20240301093839.663947-8-gaosong@loongson.cn>
>> ---
>>   hw/loongarch/boot.c         | 23 +++++++++++++++++++++--
>>   include/hw/loongarch/boot.h |  9 +++++++++
>>   2 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index 2896c1ea40..6126a37858 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -15,6 +15,9 @@
>>   #include "sysemu/reset.h"
>>   #include "sysemu/qtest.h"
>> +ram_addr_t initrd_offset;
>> +uint64_t initrd_size;
> 
> Where is that used?
>
patch1 load_kernel_info() and patch7 init_efi_initrd_table()

Thanks.
Song Gao

>>   static const unsigned int slave_boot_code[] = {
>>                     /* Configure reset ebase.         */
>>       0x0400302c,   /* csrwr      $r12,0xc            */
>> @@ -94,6 +97,21 @@ static void init_efi_boot_memmap(struct 
>> efi_system_table *systab,
>>       }
>>   }
>> +static void init_efi_initrd_table(struct efi_system_table *systab,
>> +                                  void *p, void *start)
>> +{
>> +    efi_guid_t tbl_guid = LINUX_EFI_INITRD_MEDIA_GUID;
>> +    struct efi_initrd *initrd_table  = p;
>> +
>> +    /* efi_configuration_table 2 */
>> +    guidcpy(&systab->tables[1].guid, &tbl_guid);
>> +    systab->tables[1].table = (struct efi_configuration_table *)(p - 
>> start);
>> +    systab->nr_tables = 2;
>> +
>> +    initrd_table->base = initrd_offset;
>> +    initrd_table->size = initrd_size;
>> +}
>> +
>>   static void init_systab(struct loongarch_boot_info *info, void *p, 
>> void *start)
>>   {
>>       void *bp_tables_start;
>> @@ -117,6 +135,8 @@ static void init_systab(struct loongarch_boot_info 
>> *info, void *p, void *start)
>>       init_efi_boot_memmap(systab, p, start);
>>       p += ROUND_UP(sizeof(struct efi_boot_memmap) +
>>                     sizeof(efi_memory_desc_t) * memmap_entries, 64);
>> +    init_efi_initrd_table(systab, p, start);
>> +    p += ROUND_UP(sizeof(struct efi_initrd), 64);
>>       systab->tables = (struct efi_configuration_table 
>> *)(bp_tables_start - start);
>>   }
>> @@ -138,8 +158,7 @@ static uint64_t cpu_loongarch_virt_to_phys(void 
>> *opaque, uint64_t addr)
>>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>>   {
>> -    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
>> -    ram_addr_t initrd_offset;
>> +    uint64_t kernel_entry, kernel_low, kernel_high;
>>       ssize_t kernel_size;
>>       kernel_size = load_elf(info->kernel_filename, NULL,
>> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
>> index f71c693f43..ddcb279874 100644
>> --- a/include/hw/loongarch/boot.h
>> +++ b/include/hw/loongarch/boot.h
>> @@ -30,6 +30,10 @@ typedef struct {
>>           EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, \
>>                    0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
>> +#define LINUX_EFI_INITRD_MEDIA_GUID \
>> +        EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, \
>> +                 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
>> +
>>   struct efi_config_table {
>>       efi_guid_t guid;
>>       uint64_t *ptr;
>> @@ -83,6 +87,11 @@ struct efi_boot_memmap {
>>       efi_memory_desc_t map[32];
>>   };
>> +struct efi_initrd {
>> +    uint64_t base;
>> +    uint64_t size;
>> +};
>> +
>>   struct loongarch_boot_info {
>>       uint64_t ram_size;
>>       const char *kernel_filename;


