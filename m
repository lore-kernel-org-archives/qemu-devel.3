Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBD1C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVj9-0002yU-3X; Fri, 08 Mar 2024 03:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1riVj6-0002y3-1Q
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:37:12 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1riVj2-00047K-EX
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:37:10 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8BxSOgwzuplCjoWAA--.35542S3;
 Fri, 08 Mar 2024 16:37:04 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxVMwtzupl+SpRAA--.22439S3; 
 Fri, 08 Mar 2024 16:37:04 +0800 (CST)
Subject: Re: [PATCH v6 06/17] hw/loongarch: Init efi_boot_memmap table
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-7-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <55380fac-8d89-7914-3f1d-e64e5864f719@loongson.cn>
Date: Fri, 8 Mar 2024 16:37:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240307164835.300412-7-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxVMwtzupl+SpRAA--.22439S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtryUXF1fAw45Zr1rCw1xJFc_yoW7XryDpF
 9IvFnakrs5JF17Xr93Xw1jqFn8Xws7KF12g3W7JryFyrnrJFn7WF1rJa4DZFWkJw10k3Wv
 vFnY93yUWFsrXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1
 q2_UUUUU=
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
> Message-Id: <20240301093839.663947-7-gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c         | 39 +++++++++++++++++++++++++++++++++++++
>   hw/loongarch/virt.c         | 11 ++---------
>   include/hw/loongarch/boot.h | 27 +++++++++++++++++++++++++
>   include/hw/loongarch/virt.h | 10 ++++++++++
>   4 files changed, 78 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 1e31e2a59f..2896c1ea40 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -63,8 +63,40 @@ static const unsigned int slave_boot_code[] = {
>       0x4c000020,   /* jirl       $r0,$r1,0           */
>   };
>   
> +static inline void *guidcpy(void *dst, const void *src)
> +{
> +    return memcpy(dst, src, sizeof(efi_guid_t));
> +}
> +
> +static void init_efi_boot_memmap(struct efi_system_table *systab,
> +                                 void *p, void *start)
> +{
> +    unsigned i;
> +    struct efi_boot_memmap *boot_memmap = p;
> +    efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
> +
> +    /* efi_configuration_table 1 */
> +    guidcpy(&systab->tables[0].guid, &tbl_guid);
> +    systab->tables[0].table = (struct efi_configuration_table *)(p - start);
> +    systab->nr_tables = 1;
> +
> +    boot_memmap->desc_size = sizeof(efi_memory_desc_t);
> +    boot_memmap->desc_ver = 1;
> +    boot_memmap->map_size = 0;
> +
> +    efi_memory_desc_t *map = p + sizeof(struct efi_boot_memmap);
> +    for (i = 0; i < memmap_entries; i++) {
> +        map = (void *)boot_memmap + sizeof(*map);
> +        map[i].type = memmap_table[i].type;
> +        map[i].phys_addr = memmap_table[i].address;
> +        map[i].num_pages = memmap_table[i].length >> 16; /* 64KB align*/
64KB aligned or 64KB page size? In generic page size is 4K by EFI spec IIRC.

Regards
Bibo Mao

> +        p += sizeof(efi_memory_desc_t);
> +    }
> +}
> +
>   static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
>   {
> +    void *bp_tables_start;
>       struct efi_system_table *systab = p;
>   
>       info->a2 = (uint64_t)p - (uint64_t)start;
> @@ -80,6 +112,13 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
>       p += ROUND_UP(sizeof(struct efi_system_table), 64);
>   
>       systab->tables = p;
> +    bp_tables_start = p;
> +
> +    init_efi_boot_memmap(systab, p, start);
> +    p += ROUND_UP(sizeof(struct efi_boot_memmap) +
> +                  sizeof(efi_memory_desc_t) * memmap_entries, 64);
> +
> +    systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
>   }
>   
>   static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index bbd5cc1d4d..8981b57b12 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -377,15 +377,8 @@ static void virt_powerdown_req(Notifier *notifier, void *opaque)
>       acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
>   }
>   
> -struct memmap_entry {
> -    uint64_t address;
> -    uint64_t length;
> -    uint32_t type;
> -    uint32_t reserved;
> -};
> -
> -static struct memmap_entry *memmap_table;
> -static unsigned memmap_entries;
> +struct memmap_entry *memmap_table;
> +unsigned memmap_entries;
>   
>   static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
>   {
> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> index 65ad406f02..f71c693f43 100644
> --- a/include/hw/loongarch/boot.h
> +++ b/include/hw/loongarch/boot.h
> @@ -21,6 +21,15 @@ typedef struct {
>       uint8_t b[16];
>   } efi_guid_t __attribute__((aligned(8)));
>   
> +#define EFI_GUID(a, b, c, d...) (efi_guid_t){ {                                \
> +        (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
> +        (b) & 0xff, ((b) >> 8) & 0xff,                                         \
> +        (c) & 0xff, ((c) >> 8) & 0xff, d } }
> +
> +#define LINUX_EFI_BOOT_MEMMAP_GUID \
> +        EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, \
> +                 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
> +
>   struct efi_config_table {
>       efi_guid_t guid;
>       uint64_t *ptr;
> @@ -56,6 +65,24 @@ struct efi_system_table {
>       struct efi_configuration_table *tables;
>   };
>   
> +typedef struct {
> +    uint32_t type;
> +    uint32_t pad;
> +    uint64_t phys_addr;
> +    uint64_t virt_addr;
> +    uint64_t num_pages;
> +    uint64_t attribute;
> +} efi_memory_desc_t;
> +
> +struct efi_boot_memmap {
> +    uint64_t map_size;
> +    uint64_t desc_size;
> +    uint32_t desc_ver;
> +    uint64_t map_key;
> +    uint64_t buff_size;
> +    efi_memory_desc_t map[32];
> +};
> +
>   struct loongarch_boot_info {
>       uint64_t ram_size;
>       const char *kernel_filename;
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index d7a074d69f..8a9fe4053d 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -35,6 +35,16 @@
>   
>   #define COMMAND_LINE_SIZE       512
>   
> +extern struct memmap_entry *memmap_table;
> +extern unsigned memmap_entries;
> +
> +struct memmap_entry {
> +    uint64_t address;
> +    uint64_t length;
> +    uint32_t type;
> +    uint32_t reserved;
> +};
> +
>   struct LoongArchMachineState {
>       /*< private >*/
>       MachineState parent_obj;
> 


