Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4161039882
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 02:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwAAB-0004hL-3T; Fri, 27 Feb 2026 21:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vwAA7-0004gr-5x
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 21:34:35 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vwAA3-00016Z-Rc
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 21:34:34 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxmsIwVKJpGggWAA--.1641S3;
 Sat, 28 Feb 2026 10:34:25 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDxD8MrVKJp3OxLAA--.13155S3;
 Sat, 28 Feb 2026 10:34:23 +0800 (CST)
Subject: Re: [PATCH v5 3/5] target/loongarch: Add generic CPU model information
To: Bibo Mao <maobibo@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260225014131.1487362-1-maobibo@loongson.cn>
 <20260225014131.1487362-4-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <12e7b842-6057-aa0a-01f0-82d4ba73fed0@loongson.cn>
Date: Sat, 28 Feb 2026 10:35:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260225014131.1487362-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxD8MrVKJp3OxLAA--.13155S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw17Xw4kAry3KF1kJryruFX_yoW5Crykpr
 W2yF4aga18tFZrC3WfAa45Xr1DZrs7GF429F4Sy3y09rZ8urykWFykta929Fy2ya45CF4I
 vF10k348XFs7XabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9N3UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.544, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ÔÚ 2026/2/25 ÉÏÎç9:41, Bibo Mao Ð´µÀ:
> On LoongArch system, CPU model name comes from IOCSR register
> LOONGARCH_IOCSR_VENDOR and LOONGARCH_IOCSR_CPUNAME. Its value
> can be initialized when CPU is created.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt.c    | 6 ++++--
>   target/loongarch/cpu.c | 4 ++++
>   target/loongarch/cpu.h | 6 ++++++
>   3 files changed, 14 insertions(+), 2 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index a75968e4c9..0ae049eaa4 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -776,7 +776,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(opaque);
>       uint64_t ret = 0;
>       int features;
> +    CPULoongArchState *env;
>   
> +    env = &LOONGARCH_CPU(first_cpu)->env;
>       switch (addr) {
>       case VERSION_REG:
>           ret = 0x11ULL;
> @@ -791,10 +793,10 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           }
>           break;
>       case VENDOR_REG:
> -        ret = 0x6e6f73676e6f6f4cULL; /* "Loongson" */
> +        ret = env->vendor_id;
>           break;
>       case CPUNAME_REG:
> -        ret = 0x303030354133ULL;     /* "3A5000" */
> +        ret = env->cpu_id;
>           break;
>       case MISC_FUNC_REG:
>           if (kvm_irqchip_in_kernel()) {
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 93980e62a3..0b4f3b06e6 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -287,6 +287,8 @@ static void loongarch_la464_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG0, SERID, PRID_SERIES_LA464);
>       data = FIELD_DP32(data, CPUCFG0, VENID, PRID_VENDOR_LOONGSON);
>       env->cpucfg[0] = data;
> +    memccpy((void *)&env->vendor_id, CPU_VENDOR_LOONGSON, 0, 8);
> +    memccpy((void *)&env->cpu_id, CPU_MODEL_3A5000, 0, 8);
>   
>       data = 0;
>       data = FIELD_DP32(data, CPUCFG1, ARCH, 2);
> @@ -413,6 +415,8 @@ static void loongarch_la132_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG0, SERID, PRID_SERIES_LA132);
>       data = FIELD_DP32(data, CPUCFG0, VENID, PRID_VENDOR_LOONGSON);
>       env->cpucfg[0] = data;
> +    memccpy((void *)&env->vendor_id, CPU_VENDOR_LOONGSON, 0, 8);
> +    memccpy((void *)&env->cpu_id, CPU_MODEL_1C101, 0, 8);
>   
>       data = 0;
>       data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index c423b741b2..fda8577a24 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -307,6 +307,10 @@ typedef struct  LoongArchBT {
>       uint32_t ftop;
>   } lbt_t;
>   
> +#define CPU_VENDOR_LOONGSON   "Loongson"
> +#define CPU_MODEL_3A5000      "3A5000"
> +#define CPU_MODEL_1C101       "1C101"
> +
>   typedef struct CPUArchState {
>       uint64_t gpr[32];
>       uint64_t pc;
> @@ -318,6 +322,8 @@ typedef struct CPUArchState {
>   
>       uint32_t cpucfg[21];
>       uint32_t pv_features;
> +    uint64_t vendor_id;
> +    uint64_t cpu_id;
>   
>       /* LoongArch CSRs */
>       uint64_t CSR_CRMD;


