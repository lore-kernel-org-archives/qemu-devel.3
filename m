Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129F9C27C79
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 03:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJPCE-0001zp-52; Mon, 17 Jun 2024 23:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sJPCB-0001zg-Ub
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 23:07:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sJPC8-0001r5-E0
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 23:07:43 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dx2On1+XBmG8sHAA--.18648S3;
 Tue, 18 Jun 2024 11:07:33 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxVcXz+XBmqMAmAA--.17106S3; 
 Tue, 18 Jun 2024 11:07:33 +0800 (CST)
Subject: Re: [PATCH 16/18] tcg/loongarch64: Split out vdvjukN in tcg_out_vec_op
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-17-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <a8a38634-1cc3-ad0d-2976-2323ccaa1a5d@loongson.cn>
Date: Tue, 18 Jun 2024 11:07:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240527211912.14060-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxVcXz+XBmqMAmAA--.17106S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw43GF4fCrWDtF1DtF1xtFc_yoW5urW8pr
 1qqr47trZ5J3WSyFWak3WUGr409r48Xr9Yv390kw4xursFv3Z0yr1fKwnIyFy5A34fCw1r
 Xas0vr1UuF4UA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5
 r7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.388, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2024/5/28 ÉÏÎç5:19, Richard Henderson Ð´µÀ:
> Fixes a bug in the immediate shifts, because the exact
> encoding depends on the element size.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 58 ++++++++++++++++++--------------
>   1 file changed, 32 insertions(+), 26 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 54f7bc9d14..5d2a6b2ca2 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1901,6 +1901,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>       static const LoongArchInsn rotrv_vec_insn[4] = {
>           OPC_VROTR_B, OPC_VROTR_H, OPC_VROTR_W, OPC_VROTR_D
>       };
> +    static const LoongArchInsn rotri_vec_insn[4] = {
> +        OPC_VROTRI_B, OPC_VROTRI_H, OPC_VROTRI_W, OPC_VROTRI_D
> +    };
>   
>       a0 = args[0];
>       a1 = args[1];
> @@ -2034,15 +2037,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>       case INDEX_op_sarv_vec:
>           insn = sarv_vec_insn[vece];
>           goto vdvjvk;
> -    case INDEX_op_shli_vec:
> -        tcg_out32(s, encode_vdvjuk3_insn(shli_vec_insn[vece], a0, a1, a2));
> -        break;
> -    case INDEX_op_shri_vec:
> -        tcg_out32(s, encode_vdvjuk3_insn(shri_vec_insn[vece], a0, a1, a2));
> -        break;
> -    case INDEX_op_sari_vec:
> -        tcg_out32(s, encode_vdvjuk3_insn(sari_vec_insn[vece], a0, a1, a2));
> -        break;
>       case INDEX_op_rotlv_vec:
>           /* rotlv_vec a1, a2 = rotrv_vec a1, -a2 */
>           tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], TCG_VEC_TMP0, a2));
> @@ -2051,26 +2045,20 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>       case INDEX_op_rotrv_vec:
>           insn = rotrv_vec_insn[vece];
>           goto vdvjvk;
> +    case INDEX_op_shli_vec:
> +        insn = shli_vec_insn[vece];
> +        goto vdvjukN;
> +    case INDEX_op_shri_vec:
> +        insn = shri_vec_insn[vece];
> +        goto vdvjukN;
> +    case INDEX_op_sari_vec:
> +        insn = sari_vec_insn[vece];
> +        goto vdvjukN;
>       case INDEX_op_rotli_vec:
>           /* rotli_vec a1, a2 = rotri_vec a1, -a2 */
>           a2 = extract32(-a2, 0, 3 + vece);
> -        switch (vece) {
> -        case MO_8:
> -            tcg_out_opc_vrotri_b(s, a0, a1, a2);
> -            break;
> -        case MO_16:
> -            tcg_out_opc_vrotri_h(s, a0, a1, a2);
> -            break;
> -        case MO_32:
> -            tcg_out_opc_vrotri_w(s, a0, a1, a2);
> -            break;
> -        case MO_64:
> -            tcg_out_opc_vrotri_d(s, a0, a1, a2);
> -            break;
> -        default:
> -            g_assert_not_reached();
> -        }
> -        break;
> +        insn = rotri_vec_insn[vece];
> +        goto vdvjukN;
>       case INDEX_op_bitsel_vec:
>           /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
>           tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
> @@ -2083,6 +2071,24 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>       vdvjvk:
>           tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
>           break;
> +    vdvjukN:
> +        switch (vece) {
> +        case MO_8:
> +            tcg_out32(s, encode_vdvjuk3_insn(insn, a0, a1, a2));
> +            break;
> +        case MO_16:
> +            tcg_out32(s, encode_vdvjuk4_insn(insn, a0, a1, a2));
> +            break;
> +        case MO_32:
> +            tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, a2));
> +            break;
> +        case MO_64:
> +            tcg_out32(s, encode_vdvjuk6_insn(insn, a0, a1, a2));
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        break;
>       }
>   }
>   


