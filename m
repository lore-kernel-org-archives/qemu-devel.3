Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A521C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 08:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIO7T-0002uz-Rp; Fri, 23 May 2025 04:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uIO7Q-0002um-RO
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:51:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uIO7N-0007js-49
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:51:08 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxLGvrNjBoNVX4AA--.8135S3;
 Fri, 23 May 2025 16:50:52 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxzxvoNjBovbTqAA--.25989S3;
 Fri, 23 May 2025 16:50:50 +0800 (CST)
Subject: Re: [PATCH 2/2] hw/loongarch/virt: Remove global variables about
 memmap tables
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250430094738.1556670-1-maobibo@loongson.cn>
 <20250430094738.1556670-3-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <4cc499f4-3a0a-d214-29d3-772e3c14fa20@loongson.cn>
Date: Fri, 23 May 2025 16:53:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250430094738.1556670-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxzxvoNjBovbTqAA--.25989S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw1UGw47Jr15Jw15ZrWftFc_yoW3uF1UpF
 Wav395KFs5Jr4DJr97J34UXrsxXrs7KF1ag3W7GryFkrnrKF17XF4rJa9FyFyDAw18Ca40
 vFnY9aySvFsrJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.75, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/4/30 ÏÂÎç5:47, Bibo Mao Ð´µÀ:
> Global variables memmap_table and memmap_entries stores UEFI memory
> map table informations. It can be moved into structure
> LoongArchVirtMachineState.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/boot.c         | 31 +++++++++++++++++++------------
>   hw/loongarch/virt.c         | 23 ++++++++++++++++-------
>   include/hw/loongarch/boot.h |  3 ---
>   include/hw/loongarch/virt.h |  2 ++
>   4 files changed, 37 insertions(+), 22 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 44d537d987..86435caa5e 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -35,9 +35,6 @@ struct loongarch_linux_hdr {
>       uint32_t pe_header_offset;
>   } QEMU_PACKED;
>   
> -struct memmap_entry *memmap_table;
> -unsigned memmap_entries;
> -
>   static const unsigned int slave_boot_code[] = {
>                     /* Configure reset ebase.                    */
>       0x0400302c,   /* csrwr      $t0, LOONGARCH_CSR_EENTRY      */
> @@ -91,12 +88,16 @@ static inline void *guidcpy(void *dst, const void *src)
>       return memcpy(dst, src, sizeof(efi_guid_t));
>   }
>   
> -static void init_efi_boot_memmap(struct efi_system_table *systab,
> +static void init_efi_boot_memmap(MachineState *ms,
> +                                 struct efi_system_table *systab,
>                                    void *p, void *start)
>   {
>       unsigned i;
>       struct efi_boot_memmap *boot_memmap = p;
>       efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
> +    struct memmap_entry *memmap_table;
> +    unsigned int memmap_entries;
>   
>       /* efi_configuration_table 1 */
>       guidcpy(&systab->tables[0].guid, &tbl_guid);
> @@ -108,6 +109,8 @@ static void init_efi_boot_memmap(struct efi_system_table *systab,
>       boot_memmap->map_size = 0;
>   
>       efi_memory_desc_t *map = p + sizeof(struct efi_boot_memmap);
> +    memmap_table = lvms->memmap_table;
> +    memmap_entries = lvms->memmap_entries;
>       for (i = 0; i < memmap_entries; i++) {
>           map = (void *)boot_memmap + sizeof(*map);
>           map[i].type = memmap_table[i].type;
> @@ -144,10 +147,12 @@ static void init_efi_fdt_table(struct efi_system_table *systab)
>       systab->nr_tables = 3;
>   }
>   
> -static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
> +static void init_systab(MachineState *ms,
> +                        struct loongarch_boot_info *info, void *p, void *start)
>   {
>       void *bp_tables_start;
>       struct efi_system_table *systab = p;
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
>   
>       info->a2 = p - start;
>   
> @@ -164,9 +169,9 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
>       systab->tables = p;
>       bp_tables_start = p;
>   
> -    init_efi_boot_memmap(systab, p, start);
> +    init_efi_boot_memmap(ms, systab, p, start);
>       p += ROUND_UP(sizeof(struct efi_boot_memmap) +
> -                  sizeof(efi_memory_desc_t) * memmap_entries, 64 * KiB);
> +                  sizeof(efi_memory_desc_t) * lvms->memmap_entries, 64 * KiB);
>       init_efi_initrd_table(info, systab, p, start);
>       p += ROUND_UP(sizeof(struct efi_initrd), 64 * KiB);
>       init_efi_fdt_table(systab);
> @@ -333,17 +338,19 @@ static void loongarch_firmware_boot(LoongArchVirtMachineState *lvms,
>       fw_cfg_add_kernel_info(info, lvms->fw_cfg);
>   }
>   
> -static void init_boot_rom(struct loongarch_boot_info *info, void *p)
> +static void init_boot_rom(MachineState *ms,
> +                          struct loongarch_boot_info *info, void *p)
>   {
>       void *start = p;
>   
>       init_cmdline(info, p, start);
>       p += COMMAND_LINE_SIZE;
>   
> -    init_systab(info, p, start);
> +    init_systab(ms, info, p, start);
>   }
>   
> -static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
> +static void loongarch_direct_kernel_boot(MachineState *ms,
> +                                         struct loongarch_boot_info *info)
>   {
>       void *p, *bp;
>       int64_t kernel_addr = VIRT_FLASH0_BASE;
> @@ -361,7 +368,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
>       /* Load cmdline and system tables at [0 - 1 MiB] */
>       p = g_malloc0(1 * MiB);
>       bp = p;
> -    init_boot_rom(info, p);
> +    init_boot_rom(ms, info, p);
>       rom_add_blob_fixed_as("boot_info", bp, 1 * MiB, 0, &address_space_memory);
>   
>       /* Load slave boot code at pflash0 . */
> @@ -401,6 +408,6 @@ void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
>       if (lvms->bios_loaded) {
>           loongarch_firmware_boot(lvms, info);
>       } else {
> -        loongarch_direct_kernel_boot(info);
> +        loongarch_direct_kernel_boot(ms, info);
>       }
>   }
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 779544fada..601e7c6bd3 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -168,8 +168,15 @@ static void virt_powerdown_req(Notifier *notifier, void *opaque)
>       acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
>   }
>   
> -static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
> +static void memmap_add_entry(MachineState *ms, uint64_t address,
> +                             uint64_t length, uint32_t type)
>   {
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
> +    struct memmap_entry *memmap_table;
> +    unsigned int memmap_entries;
> +
> +    memmap_table = lvms->memmap_table;
> +    memmap_entries = lvms->memmap_entries;
>       /* Ensure there are no duplicate entries. */
>       for (unsigned i = 0; i < memmap_entries; i++) {
>           assert(memmap_table[i].address != address);
> @@ -182,6 +189,8 @@ static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
>       memmap_table[memmap_entries].type = cpu_to_le32(type);
>       memmap_table[memmap_entries].reserved = 0;
>       memmap_entries++;
> +    lvms->memmap_table = memmap_table;
> +    lvms->memmap_entries = memmap_entries;
>   }
>   
>   static DeviceState *create_acpi_ged(DeviceState *pch_pic,
> @@ -625,13 +634,13 @@ static void fw_cfg_add_memory(MachineState *ms)
>       }
>   
>       if (size >= gap) {
> -        memmap_add_entry(base, gap, 1);
> +        memmap_add_entry(ms, base, gap, 1);
>           size -= gap;
>           base = VIRT_HIGHMEM_BASE;
>       }
>   
>       if (size) {
> -        memmap_add_entry(base, size, 1);
> +        memmap_add_entry(ms, base, size, 1);
>           base += size;
>       }
>   
> @@ -646,7 +655,7 @@ static void fw_cfg_add_memory(MachineState *ms)
>            * lowram:  [base, +(gap - numa_info[0].node_mem))
>            * highram: [VIRT_HIGHMEM_BASE, +(ram_size - gap))
>            */
> -        memmap_add_entry(base, gap - numa_info[0].node_mem, 1);
> +        memmap_add_entry(ms, base, gap - numa_info[0].node_mem, 1);
>           size = ram_size - gap;
>           base = VIRT_HIGHMEM_BASE;
>       } else {
> @@ -654,7 +663,7 @@ static void fw_cfg_add_memory(MachineState *ms)
>       }
>   
>       if (size) {
> -        memmap_add_entry(base, size, 1);
> +        memmap_add_entry(ms, base, size, 1);
>       }
>   }
>   
> @@ -740,8 +749,8 @@ static void virt_init(MachineState *machine)
>       rom_set_fw(lvms->fw_cfg);
>       if (lvms->fw_cfg != NULL) {
>           fw_cfg_add_file(lvms->fw_cfg, "etc/memmap",
> -                        memmap_table,
> -                        sizeof(struct memmap_entry) * (memmap_entries));
> +                        lvms->memmap_table,
> +                        sizeof(struct memmap_entry) * lvms->memmap_entries);
>       }
>   
>       /* Initialize the IO interrupt subsystem */
> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> index 27399de99c..9819f7fbe3 100644
> --- a/include/hw/loongarch/boot.h
> +++ b/include/hw/loongarch/boot.h
> @@ -106,9 +106,6 @@ struct loongarch_boot_info {
>       uint64_t initrd_size;
>   };
>   
> -extern struct memmap_entry *memmap_table;
> -extern unsigned memmap_entries;
> -
>   struct memmap_entry {
>       uint64_t address;
>       uint64_t length;
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 2b7d19953f..602feab0f0 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -63,6 +63,8 @@ struct LoongArchVirtMachineState {
>       struct loongarch_boot_info bootinfo;
>       DeviceState *ipi;
>       DeviceState *extioi;
> +    struct memmap_entry *memmap_table;
> +    unsigned int memmap_entries;
>   };
>   
>   #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")


