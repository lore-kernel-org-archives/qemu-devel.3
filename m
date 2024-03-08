Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B67C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVay-0005zT-2K; Fri, 08 Mar 2024 03:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1riVaw-0005zB-DY
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:28:46 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1riVau-0001xA-9u
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:28:46 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8Axeeg3zOplfTkWAA--.35596S3;
 Fri, 08 Mar 2024 16:28:39 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjhM2zOplcSdRAA--.28402S3; 
 Fri, 08 Mar 2024 16:28:38 +0800 (CST)
Subject: Re: [PATCH v6 04/17] hw/loongarch: Add init_cmdline
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-5-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <ed9af686-b613-b86e-d2ea-8031ce55adf5@loongson.cn>
Date: Fri, 8 Mar 2024 16:28:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240307164835.300412-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjhM2zOplcSdRAA--.28402S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF47Cr47Zw4xCFW5Cr1kXrc_yoW5Xw4DpF
 ZrZF1rWan5JFZrWr9rXas8WrnxZrn7Kw4a9F1xKryFkF42qr1Uur10y3s29F4UJ3yrGr1F
 vrnY9w47WF4qq3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Li
 SJUUUUU==
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
> Add init_cmline and set boot_info->a0, a1
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-5-gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c         | 19 +++++++++++++++++++
>   include/hw/loongarch/virt.h |  2 ++
>   target/loongarch/cpu.h      |  2 ++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index e560ac178a..ca65dfde07 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -63,6 +63,16 @@ static const unsigned int slave_boot_code[] = {
>       0x4c000020,   /* jirl       $r0,$r1,0           */
>   };
>   
> +static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
> +{
> +    hwaddr cmdline_addr = (hwaddr)p - (hwaddr)start;
> +
> +    info->a0 = 1;
> +    info->a1 = cmdline_addr;
> +
> +    memcpy(p, info->kernel_cmdline, COMMAND_LINE_SIZE);
> +}
> +
>   static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>   {
>       return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
> @@ -122,6 +132,10 @@ static void reset_load_elf(void *opaque)
>   
>       cpu_reset(CPU(cpu));
>       if (env->load_elf) {
> +	if (cpu == LOONGARCH_CPU(first_cpu)) {
> +            env->gpr[4] = env->boot_info->a0;
> +            env->gpr[5] = env->boot_info->a1;
> +        }
>           cpu_set_pc(CPU(cpu), env->elf_address);
>       }
>   }
> @@ -161,8 +175,13 @@ static void loongarch_firmware_boot(LoongArchMachineState *lams,
>   
>   static void init_boot_rom(struct loongarch_boot_info *info, void *p)
>   {
> +    void *start = p;
> +
>       memcpy(p, &slave_boot_code, sizeof(slave_boot_code));
>       p += sizeof(slave_boot_code);
> +
> +    init_cmdline(info, p, start);
> +    p += COMMAND_LINE_SIZE;
>   }
>   
>   static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index cf2f2bfb19..d7a074d69f 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -33,6 +33,8 @@
>   #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
>   #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
>   
> +#define COMMAND_LINE_SIZE       512
> +
>   struct LoongArchMachineState {
>       /*< private >*/
>       MachineState parent_obj;
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index ec37579fd6..ce02ef3979 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -361,6 +361,8 @@ typedef struct CPUArchState {
>       uint32_t mp_state;
>       /* Store ipistate to access from this struct */
>       DeviceState *ipistate;
> +
> +    struct loongarch_boot_info *boot_info;
>   #endif
>   } CPULoongArchState;
>   
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


