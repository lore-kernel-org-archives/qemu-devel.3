Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DA7D1CDBF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 02:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQyeQ-0000jC-93; Wed, 03 Dec 2025 21:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1vQyeN-0000iR-0G
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 21:00:55 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1vQyeK-0001dW-7t
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 21:00:54 -0500
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8AxztJG6zBp1esqAA--.25841S3;
 Thu, 04 Dec 2025 10:00:38 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowJCxdORE6zBpzDtFAQ--.54547S3;
 Thu, 04 Dec 2025 10:00:38 +0800 (CST)
Subject: Re: [PATCH 3/3] target/loongarch: Add host CPU model in kvm mode
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20251106084043.2453749-1-maobibo@loongson.cn>
 <20251106084043.2453749-4-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <5dc53523-af38-d9da-a089-d341b098fdeb@loongson.cn>
Date: Thu, 4 Dec 2025 09:57:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251106084043.2453749-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxdORE6zBpzDtFAQ--.54547S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWryDuw1fZF43AF4fCF47KFX_yoW5WFykpF
 WYvw13KrW2qFZrC34fJa4Ygr98Zr4xWw42va4ft3s5AF4DZr17Wa18KrZrZF4fK348XF1I
 9F4FkanI9FsrtacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.398,
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

Hi Bibo Mao:
> Host CPU model is basically the same with max CPU model, except Product
> ID and CPU model name. With host CPU model, Product ID comes from
> cpucfg0 and CPU model comes from /proc/cpuinfo.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c | 94 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)
>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 8b8723a343..c7f52adeb9 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -429,6 +429,97 @@ static void loongarch_max_initfn(Object *obj)
>       }
>   }
>   
> +#if defined(CONFIG_KVM)
> +static int read_cpuinfo(const char *field, char *value, int len)
> +{
> +    FILE *f;
> +    int ret = -1;
> +    int field_len = strlen(field);
> +    char line[512];
> +
> +    f = fopen("/proc/cpuinfo", "r");
> +    if (!f) {
> +        return -1;
> +    }
> +
> +    do {
> +        if (!fgets(line, sizeof(line), f)) {
> +            break;
> +        }
> +        if (!strncmp(line, field, field_len)) {
> +            strncpy(value, line, len);
> +            ret = 0;
> +            break;
> +        }
> +    } while (*line);
> +
> +    fclose(f);
> +
> +    return ret;
> +}
> +
> +static uint64_t get_host_cpu_model(void)
> +{
> +    char line[512];
> +    char *ns;
> +    static uint64_t cpuid;
> +
> +    if (cpuid) {
> +        return cpuid;
> +    }
> +
> +    if (read_cpuinfo("Model Name", line, sizeof(line))) {
> +        return 0;
> +    }
> +
> +    ns = strchr(line, ':');
> +    if (!ns) {
> +        return 0;
> +    }
> +
> +    ns = strstr(ns, "Loongson-");
> +    if (!ns) {
> +        return 0;
> +    }
> +
> +    ns += strlen("Loongson-");
> +    memccpy((void *)&cpuid, ns, 0, 8);
> +    return cpuid;
> +}
> +
> +static uint32_t get_host_cpucfg(int number)
> +{
> +    unsigned int data = 0;
> +
> +#ifdef __loongarch__
> +    asm volatile("cpucfg %[val], %[reg]"
> +                 : [val] "=r" (data)
> +                 : [reg] "r" (number)
> +                 : "memory");
> +#endif
> +
> +    return data;
> +}
> +
> +static void loongarch_host_initfn(Object *obj)
> +{
> +    uint32_t data;
> +    uint64_t cpuid;
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +
> +    loongarch_max_initfn(obj);
> +    data = get_host_cpucfg(0);
> +    if (data) {
> +        cpu->env.cpucfg[0] = data;
> +    }
> +

Does the feature bit on cpucfg[2] also need to be consistent with the 
host feature bit?
Otherwise, some features might be lost.

Thanks!
Xianglai.


> +    cpuid = get_host_cpu_model();
> +    if (cpuid) {
> +        cpu->env.cpu_id = cpuid;
> +    }
> +}
> +#endif
> +
>   static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>   {
>       uint8_t tlb_ps;
> @@ -780,6 +871,9 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
>       DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
>       DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
>       DEFINE_LOONGARCH_CPU_TYPE(64, "max", loongarch_max_initfn),
> +#if defined(CONFIG_KVM)
> +    DEFINE_LOONGARCH_CPU_TYPE(64, "host", loongarch_host_initfn),
> +#endif
>   };
>   
>   DEFINE_TYPES(loongarch_cpu_type_infos)


