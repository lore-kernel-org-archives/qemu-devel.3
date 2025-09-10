Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E216CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 02:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwAVa-00024M-Sf; Tue, 09 Sep 2025 22:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uwAVX-00023v-Mi
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:24:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uwAVO-0003bx-FB
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:24:27 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Axz79I4cBov6IIAA--.17061S3;
 Wed, 10 Sep 2025 10:24:08 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxpeRF4cBotFCLAA--.49256S3;
 Wed, 10 Sep 2025 10:24:07 +0800 (CST)
Subject: Re: [PATCH v4 2/3] hw/loongarch/virt: Remove unnecessay pre-boot
 setting with BSP
To: Bibo Mao <maobibo@loongson.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
References: <20250906070200.3749326-1-maobibo@loongson.cn>
 <20250906070200.3749326-3-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <c89c34df-9c48-0d66-7032-8b65a40157fb@loongson.cn>
Date: Wed, 10 Sep 2025 10:27:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250906070200.3749326-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxpeRF4cBotFCLAA--.49256S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWUJw4xWF4DCryDXFyfXwc_yoW8KFyxpr
 ZxAFnag395JFs5K3ZFq3s8ur1DZr4xGw4agFsrKFyrKr4qqry7Xr1jy3s29FyDZa4rKr1F
 vrn5Zw1YqF48J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwMKuUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.932, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/9/6 ÏÂÎç3:01, Bibo Mao Ð´µÀ:
> With BSP core, it boots from aux boot code and loads data into register
> A0-A2 and PC. Pre-boot setting is not unnecessary and can be removed.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/boot.c    | 22 ----------------------
>   target/loongarch/cpu.h |  4 ----
>   2 files changed, 26 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 4962668e5a..5799b4c75c 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -353,17 +353,8 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>   static void reset_load_elf(void *opaque)
>   {
>       LoongArchCPU *cpu = opaque;
> -    CPULoongArchState *env = &cpu->env;
>   
>       cpu_reset(CPU(cpu));
> -    if (env->load_elf) {
> -        if (cpu == LOONGARCH_CPU(first_cpu)) {
> -            env->gpr[4] = env->boot_info->a0;
> -            env->gpr[5] = env->boot_info->a1;
> -            env->gpr[6] = env->boot_info->a2;
> -        }
> -        cpu_set_pc(CPU(cpu), env->elf_address);
> -    }
>   }
>   
>   static void fw_cfg_add_kernel_info(struct loongarch_boot_info *info,
> @@ -415,8 +406,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
>   {
>       void *p, *bp;
>       int64_t kernel_addr = VIRT_FLASH0_BASE;
> -    LoongArchCPU *lacpu;
> -    CPUState *cs;
>       uint64_t *data;
>   
>       if (info->kernel_filename) {
> @@ -443,17 +432,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
>       *(data - 1) = cpu_to_le64(kernel_addr);
>       rom_add_blob_fixed("boot_code", boot_code, VIRT_FLASH0_SIZE, VIRT_FLASH0_BASE);
>   
> -    CPU_FOREACH(cs) {
> -        lacpu = LOONGARCH_CPU(cs);
> -        lacpu->env.load_elf = true;
> -        if (cs == first_cpu) {
> -            lacpu->env.elf_address = kernel_addr;
> -        } else {
> -            lacpu->env.elf_address = VIRT_FLASH0_BASE;
> -        }
> -        lacpu->env.boot_info = info;
> -    }
> -
>       g_free(boot_code);
>       g_free(bp);
>   }
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 7731f6acdc..c8b96f74dc 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -387,11 +387,7 @@ typedef struct CPUArchState {
>   #endif
>   
>       AddressSpace *address_space_iocsr;
> -    bool load_elf;
> -    uint64_t elf_address;
>       uint32_t mp_state;
> -
> -    struct loongarch_boot_info *boot_info;
>   #endif
>   } CPULoongArchState;
>   


