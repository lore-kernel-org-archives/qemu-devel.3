Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549EA1048927
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 02:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwACD-0005Q1-La; Fri, 27 Feb 2026 21:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vwACB-0005PP-L3
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 21:36:43 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vwAC9-0001PP-NS
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 21:36:43 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Axy8K3VKJpRwgWAA--.927S3;
 Sat, 28 Feb 2026 10:36:39 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDxTMK2VKJpQ+1LAA--.10078S3;
 Sat, 28 Feb 2026 10:36:38 +0800 (CST)
Subject: Re: [PATCH v5 5/5] target/loongarch: Add some CPUCFG bits with host
 CPU model
To: Bibo Mao <maobibo@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260225014131.1487362-1-maobibo@loongson.cn>
 <20260225014131.1487362-6-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <756e18c8-5c22-9dad-3ee6-ab5f41654460@loongson.cn>
Date: Sat, 28 Feb 2026 10:37:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260225014131.1487362-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxTMK2VKJpQ+1LAA--.10078S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF4fJw17AFyxKF1fZF48Zrc_yoWrJF45pr
 4UCrsIgry8tFyIkwn3tayYqwn8Zr48Gr4a9Fn7Jr1vvF4DXwnrXFW8tan7AF1UJwn5Ar45
 uFZ8A393G3ZxJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.544,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

在 2026/2/25 上午9:41, Bibo Mao 写道:
> Some CPUCFG capability bits depend on KVM host hypervsior and they
> are detected on QEMU. However some CPUCFG bits are irrelative with
> hypervsior, here these bits are checked from host machine and set
> for VM with host CPU model.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c | 36 +++++++++++++++++++++++++++++++++++-
>   target/loongarch/cpu.h |  8 ++++++++
>   2 files changed, 43 insertions(+), 1 deletion(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song  Gao
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 37950456b4..8e8b10505d 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -532,7 +532,7 @@ static uint32_t get_host_cpucfg(int number)
>   
>   static void loongarch_host_initfn(Object *obj)
>   {
> -    uint32_t data;
> +    uint32_t data, cpucfg, field;
>       uint64_t cpuid;
>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>   
> @@ -542,6 +542,40 @@ static void loongarch_host_initfn(Object *obj)
>           cpu->env.cpucfg[0] = data;
>       }
>   
> +   /*
> +    * There is no exception in KVM hypervisor when these intructions are
> +    * executed if HW support, KVM hypervisor cannot control this.
> +    *
> +    * Set cpucfg bits which cannot be controlled by KVM hypervisor.
> +    */
> +    data = get_host_cpucfg(2);
> +    cpucfg = cpu->env.cpucfg[2];
> +    field = FIELD_EX32(data, CPUCFG2, FRECIPE);
> +    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, FRECIPE, field);
> +    field = FIELD_EX32(data, CPUCFG2, DIV32);
> +    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, DIV32, field);
> +    field = FIELD_EX32(data, CPUCFG2, LAM_BH);
> +    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, LAM_BH, field);
> +    field = FIELD_EX32(data, CPUCFG2, LAMCAS);
> +    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, LAMCAS, field);
> +    field = FIELD_EX32(data, CPUCFG2, LLACQ_SCREL);
> +    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, LLACQ_SCREL, field);
> +    field = FIELD_EX32(data, CPUCFG2, SCQ);
> +    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, SCQ, field);
> +    cpu->env.cpucfg[2] = cpucfg;
> +
> +    data = get_host_cpucfg(3);
> +    cpucfg = cpu->env.cpucfg[3];
> +    field = FIELD_EX32(data, CPUCFG3, DBAR_HINTS);
> +    cpucfg = FIELD_DP32(cpucfg, CPUCFG3, DBAR_HINTS, field);
> +    field = FIELD_EX32(data, CPUCFG3, ALDORDER_STA);
> +    cpucfg = FIELD_DP32(cpucfg, CPUCFG3, ALDORDER_STA, field);
> +    field = FIELD_EX32(data, CPUCFG3, ASTORDER_STA);
> +    cpucfg = FIELD_DP32(cpucfg, CPUCFG3, ASTORDER_STA, field);
> +    field = FIELD_EX32(data, CPUCFG3, SLDORDER_STA);
> +    cpucfg = FIELD_DP32(cpucfg, CPUCFG3, SLDORDER_STA, field);
> +    cpu->env.cpucfg[3] = cpucfg;
> +
>       cpuid = get_host_cpu_model();
>       if (cpuid) {
>           cpu->env.cpu_id = cpuid;
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index fda8577a24..d2dfdc8520 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -147,6 +147,7 @@ FIELD(CPUCFG2, LSPW, 21, 1)
>   FIELD(CPUCFG2, LAM, 22, 1)
>   FIELD(CPUCFG2, HPTW, 24, 1)
>   FIELD(CPUCFG2, FRECIPE, 25, 1)
> +FIELD(CPUCFG2, DIV32, 26, 1)
>   FIELD(CPUCFG2, LAM_BH, 27, 1)
>   FIELD(CPUCFG2, LAMCAS, 28, 1)
>   FIELD(CPUCFG2, LLACQ_SCREL, 29, 1)
> @@ -165,6 +166,13 @@ FIELD(CPUCFG3, SPW_LVL, 8, 3)
>   FIELD(CPUCFG3, SPW_HP_HF, 11, 1)
>   FIELD(CPUCFG3, RVA, 12, 1)
>   FIELD(CPUCFG3, RVAMAX, 13, 4)
> +FIELD(CPUCFG3, DBAR_HINTS, 17, 1)
> +FIELD(CPUCFG3, ALDORDER_CAP, 18, 1)
> +FIELD(CPUCFG3, ASTORDER_CAP, 19, 1)
> +FIELD(CPUCFG3, ALDORDER_STA, 20, 1)
> +FIELD(CPUCFG3, ASTORDER_STA, 21, 1)
> +FIELD(CPUCFG3, SLDORDER_CAP, 22, 1)
> +FIELD(CPUCFG3, SLDORDER_STA, 23, 1)
>   
>   /* cpucfg[4] bits */
>   FIELD(CPUCFG4, CC_FREQ, 0, 32)


