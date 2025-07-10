Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71799C83F10
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 02:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZhOQ-0000jg-S3; Wed, 09 Jul 2025 22:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uZhM8-000829-Ns
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 22:49:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uZhM5-0002NX-Qn
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 22:49:51 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxnnNLKm9ouvolAQ--.45363S3;
 Thu, 10 Jul 2025 10:49:47 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxpeRGKm9oMfUQAA--.31944S3;
 Thu, 10 Jul 2025 10:49:44 +0800 (CST)
Subject: Re: [PATCH v4 10/11] target/loongarch:Implement csrrd CSR_MSGIR
 register
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250703092650.2598059-1-gaosong@loongson.cn>
 <20250703092650.2598059-11-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <0afd213d-65b1-dcab-78ba-1fae51e9c9b9@loongson.cn>
Date: Thu, 10 Jul 2025 10:48:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250703092650.2598059-11-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpeRGKm9oMfUQAA--.31944S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF13uF4xGr45Zryrtr47GFX_yoW5ZFWDpF
 4xCFWakF4rGrZ7Z3WSqw13tw15Zr48Kw4xXa1xt34I9a13Xr93Wr40q3sFgF4DJa45XFW0
 v3Zakry8AFW7X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.691,
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



On 2025/7/3 下午5:26, Song Gao wrote:
> implement the read-clear feature for CSR_MSGIR register.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/csr.c                        |  5 +++++
>   target/loongarch/tcg/csr_helper.c             | 22 +++++++++++++++++++
>   target/loongarch/tcg/helper.h                 |  1 +
>   .../tcg/insn_trans/trans_privileged.c.inc     |  1 +
>   4 files changed, 29 insertions(+)
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
> index 2942d7feb8..29eb2d13c8 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -68,6 +68,28 @@ target_ulong helper_csrrd_tval(CPULoongArchState *env)
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
> +        env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, MSGINT, 0);
CSR_ECFG should not be modifed here.

> +    } else {
> +        /* bit 31 set 1 for no invalid irq */
> +        irq = -1;
How about irq = BIT(31), the other bits keeps zero except bit 31?

Regards
Bibo Mao
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
> index ecbfe23b63..2619b5342b 100644
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


