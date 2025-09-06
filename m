Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6364CA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 07:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uunGW-00077l-5v; Sat, 06 Sep 2025 03:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uunGT-00077F-9y
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:23:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uunGM-0006g3-6e
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:23:12 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxM9BW4btoyVkHAA--.15797S3;
 Sat, 06 Sep 2025 15:23:02 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxT+ZU4btos6uBAA--.15747S3;
 Sat, 06 Sep 2025 15:23:02 +0800 (CST)
Subject: Re: [PATCH v6 10/11] target/loongarch:Implement csrrd CSR_MSGIR
 register
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250904121840.2023683-1-gaosong@loongson.cn>
 <20250904121840.2023683-11-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <8d4761a2-32db-eced-6f9a-d4b1e6acb397@loongson.cn>
Date: Sat, 6 Sep 2025 15:20:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250904121840.2023683-11-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxT+ZU4btos6uBAA--.15747S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF13uF4xGr45Zryrtr47GFX_yoW5CFyxpr
 W7CFW3KF48J397A3WfXw13twn8Zr48Kw4xXa1xtryI9a13J3s3Wr40q3srKF4DJ3W5XFW0
 v3ZYkr18JFW7XacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7MmhUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.794,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 2025/9/4 下午8:18, Song Gao wrote:
> implement the read-clear feature for CSR_MSGIR register.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/csr.c                        |  5 +++++
>   target/loongarch/tcg/csr_helper.c             | 21 +++++++++++++++++++
>   target/loongarch/tcg/helper.h                 |  1 +
>   .../tcg/insn_trans/trans_privileged.c.inc     |  1 +
>   4 files changed, 28 insertions(+)
> 
> diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
> index 7ea0a30450..f973780bba 100644
> --- a/target/loongarch/csr.c
> +++ b/target/loongarch/csr.c
> @@ -97,6 +97,11 @@ static CSRInfo csr_info[] = {
>       CSR_OFF(DBG),
>       CSR_OFF(DERA),
>       CSR_OFF(DSAVE),
> +    CSR_OFF_ARRAY(MSGIS, 0),
> +    CSR_OFF_ARRAY(MSGIS, 1),
> +    CSR_OFF_ARRAY(MSGIS, 2),
> +    CSR_OFF_ARRAY(MSGIS, 3),
> +    CSR_OFF(MSGIR),
>   };
>   
>   CSRInfo *get_csr(unsigned int csr_num)
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 28b1bb86bd..347dca84b8 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -72,6 +72,27 @@ target_ulong helper_csrrd_tval(CPULoongArchState *env)
>       return cpu_loongarch_get_constant_timer_ticks(cpu);
>   }
>   
> +target_ulong helper_csrrd_msgir(CPULoongArchState *env)
> +{
> +    int irq, new;
> +
> +    irq = find_first_bit(env->CSR_MSGIS, 256);
> +    if (irq < 256) {
> +        clear_bit(irq, env->CSR_MSGIS);
> +        new = find_first_bit(env->CSR_MSGIS, 256);
> +        if (new < 256) {
> +            return irq;
> +        }
> +
> +        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 0);
> +    } else {
> +        /* bit 31 set 1 for no invalid irq */
> +        irq = BIT(31);
> +    }
> +
> +    return irq;
> +}
> +
>   target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
>   {
>       int64_t old_v = env->CSR_ESTAT;
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
> index 1d5cb0198c..db57dbfc16 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -100,6 +100,7 @@ DEF_HELPER_1(rdtime_d, i64, env)
>   DEF_HELPER_1(csrrd_pgd, i64, env)
>   DEF_HELPER_1(csrrd_cpuid, i64, env)
>   DEF_HELPER_1(csrrd_tval, i64, env)
> +DEF_HELPER_1(csrrd_msgir, i64, env)
>   DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
>   DEF_HELPER_2(csrwr_estat, i64, env, tl)
>   DEF_HELPER_2(csrwr_asid, i64, env, tl)
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 34cfab8879..a407ab51b7 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -83,6 +83,7 @@ void loongarch_csr_translate_init(void)
>       SET_CSR_FUNC(TCFG,  NULL, gen_helper_csrwr_tcfg);
>       SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
>       SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
> +    SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
>   }
>   #undef SET_CSR_FUNC
>   
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


