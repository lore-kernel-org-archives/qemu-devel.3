Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F04606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrCY-0004JG-I2; Thu, 05 Nov 2026 01:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1xOrCV-0004Iy-Rf; Thu, 05 Nov 2026 01:43:55 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>)
 id 1xOrCT-00087A-AD; Thu, 05 Nov 2026 01:43:55 -0500
Received: from loongson.cn (unknown [10.20.42.166])
 by gateway (Coremail) with SMTP id _____8DxD9OmJexqzo4cAA--.17294S3;
 Thu, 05 Nov 2026 14:43:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAx1cyjJexqooEyAA--.9946S2;
 Thu, 05 Nov 2026 14:43:49 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Fix memory access address with fldle
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20261029075747.73942-1-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <05beb54c-c772-dc43-a666-f417df932370@loongson.cn>
Date: Thu, 5 Nov 2026 14:42:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029075747.73942-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAx1cyjJexqooEyAA--.9946S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF47tw4rtrW8Ww1DZF4xGrX_yoW8tw45pr
 s7Ar48ta18JFZ7AaykAw4Yyry3uFZ5Ga12g3ZFya1Skr4fXrnrZw17K3ZI93W8Xay8Xw40
 vF1vyw1qqFW3GFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU84x
 RDUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.724,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>

> With instruction fldle, similar with ldle instruction, address of accessed
> memory should come from register rj rather than rj + rk,. The same with
> instruction fldgt/fstle/fstgt.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 34423c019419 ("target/loongarch: Extract make_address_x() helper")
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_fmemory.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
> index b863ba1dc2..628b33330b 100644
> --- a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
> @@ -82,7 +82,7 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
>       CHECK_FPE;
>   
>       gen_helper_asrtgt_d(tcg_env, src1, src2);
> -    addr = make_address_x(ctx, src1, src2);
> +    addr = make_address_i(ctx, src1, 0);
>       tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
>       maybe_nanbox_load(dest, mop);
>       set_fpr(a->fd, dest);
> @@ -100,7 +100,7 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
>       CHECK_FPE;
>   
>       gen_helper_asrtgt_d(tcg_env, src1, src2);
> -    addr = make_address_x(ctx, src1, src2);
> +    addr = make_address_i(ctx, src1, 0);
>       tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
>   
>       return true;
> @@ -116,7 +116,7 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
>       CHECK_FPE;
>   
>       gen_helper_asrtle_d(tcg_env, src1, src2);
> -    addr = make_address_x(ctx, src1, src2);
> +    addr = make_address_i(ctx, src1, 0);
>       tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
>       maybe_nanbox_load(dest, mop);
>       set_fpr(a->fd, dest);
> @@ -134,7 +134,7 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
>       CHECK_FPE;
>   
>       gen_helper_asrtle_d(tcg_env, src1, src2);
> -    addr = make_address_x(ctx, src1, src2);
> +    addr = make_address_i(ctx, src1, 0);
>       tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
>   
>       return true;
>
> base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b


