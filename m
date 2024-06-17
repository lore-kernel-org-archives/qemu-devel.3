Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D11C27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 09:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ8TY-0007tK-Te; Mon, 17 Jun 2024 05:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sJ8TU-0007sm-0x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 05:16:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sJ8TR-0006Cf-Iw
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 05:16:27 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx3+vj_m9mj4YHAA--.14309S3;
 Mon, 17 Jun 2024 17:16:19 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxnsfg_m9mF1MlAA--.25346S3; 
 Mon, 17 Jun 2024 17:16:18 +0800 (CST)
Subject: Re: [PATCH 04/18] tcg/loongarch64: Support TCG_TYPE_V64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-5-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <a282d3d3-990e-e6ba-6580-bb2722ca08e0@loongson.cn>
Date: Mon, 17 Jun 2024 17:16:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240527211912.14060-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxnsfg_m9mF1MlAA--.25346S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryUWFyrKw48JF4rZr4xGrX_yoW5XF17pr
 yxZan8JF4rtFZ7C3y3C3WUXw1kXr43Zry29F1rGw4xJrsxKryDXr1rta12qFyjva40vrWa
 vas09r1fXFWqkagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8oG
 QDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.677, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2024/5/28 ÉÏÎç5:18, Richard Henderson Ð´µÀ:
> We can implement this with fld_d, fst_d for load and store,
> and then use the normal v128 operations in registers.
> This will improve support for guests which use v64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.h     | 2 +-
>   tcg/loongarch64/tcg-target.c.inc | 8 ++++++--
>   2 files changed, 7 insertions(+), 3 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
> index 29e4860d20..990bad1d51 100644
> --- a/tcg/loongarch64/tcg-target.h
> +++ b/tcg/loongarch64/tcg-target.h
> @@ -171,7 +171,7 @@ typedef enum {
>   
>   #define TCG_TARGET_HAS_tst              0
>   
> -#define TCG_TARGET_HAS_v64              0
> +#define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_LSX)
>   #define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
>   #define TCG_TARGET_HAS_v256             0
>   
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index de5369536e..980ea10211 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -321,6 +321,7 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>               }
>           }
>           break;
> +    case TCG_TYPE_V64:
>       case TCG_TYPE_V128:
>           tcg_out_opc_vori_b(s, ret, arg, 0);
>           break;
> @@ -838,6 +839,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
>           }
>           break;
>       case TCG_TYPE_I64:
> +    case TCG_TYPE_V64:
>           if (dest < TCG_REG_V0) {
>               tcg_out_ldst(s, OPC_LD_D, dest, base, offset);
>           } else {
> @@ -869,6 +871,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
>           }
>           break;
>       case TCG_TYPE_I64:
> +    case TCG_TYPE_V64:
>           if (src < TCG_REG_V0) {
>               tcg_out_ldst(s, OPC_ST_D, src, base, offset);
>           } else {
> @@ -1880,8 +1883,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>       a2 = args[2];
>       a3 = args[3];
>   
> -    /* Currently only supports V128 */
> -    tcg_debug_assert(type == TCG_TYPE_V128);
> +    /* Currently only supports V64 & V128 */
> +    tcg_debug_assert(type == TCG_TYPE_V64 || type == TCG_TYPE_V128);
>   
>       switch (opc) {
>       case INDEX_op_st_vec:
> @@ -2394,6 +2397,7 @@ static void tcg_target_init(TCGContext *s)
>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
>   
>       if (cpuinfo & CPUINFO_LSX) {
> +        tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
>           tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
>           tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V24);
>           tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V25);


