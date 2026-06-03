Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90408CD6E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfiQ-0002qf-Uh; Wed, 03 Jun 2026 03:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfiN-0002id-CL
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:35 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfiL-0000EY-OJ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780469049; bh=3L9ee2dKWYaxt0pfBtX+efH/JSKvT17EPaAHu2ACHaY=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=j84VzZozA9g2fH9kp7FQZ+T2X4TW3YEqeq/4S+Q3OfSeNN73peQcPvLe2MZJXPPSY
 4zAFepPGxvNuKiFoRv1gEMNXWtd1IzsLuJHjTtWsvQHGzBGxvbc6csjjYE58MqdnYh
 KXIb/Tkh1JA7U2saJMfovN/9BPyt+cYYqsWeyX/c=
Received: by be1-8.in.mailobj.net [192.168.91.18] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 08:43:33 +0200 (CEST)
X-EA-Auth: bLH+M3CLRZnHGis5Ht2Cry2RVDNZ+8i8NHPnCI4YUYdwPHTFhw7uasxEsvkP8mEiqRf8NYQ1Y6MJVLGO3G/Pgnv4oAaXL9/5
Message-ID: <52cc9b38-e1e8-46ef-aaaf-41b33200188f@mailo.com>
Date: Wed, 3 Jun 2026 08:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] target/loongarch: Add new structure CPUSysState
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <20260602030029.1476299-1-maobibo@loongson.cn>
 <20260602030029.1476299-14-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260602030029.1476299-14-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=213.182.54.8; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 2/6/26 05:00, Bibo Mao wrote:
> New structure CPUSysState is added here, it contains CSR registers
> now, in future TLB and timer can be moved to this structure also.
> 
> It is only code movement, no function change.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c                        |   4 +-
>   target/loongarch/cpu.h                        |  35 +++---
>   target/loongarch/csr.c                        |   4 +-
>   target/loongarch/csr.h                        |   2 +-
>   target/loongarch/machine.c                    | 118 +++++++++---------
>   .../tcg/insn_trans/trans_extra.c.inc          |   4 +-
>   6 files changed, 86 insertions(+), 81 deletions(-)


> diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
> index ed7c603a0b..ef71cdf30f 100644
> --- a/target/loongarch/csr.h
> +++ b/target/loongarch/csr.h
> @@ -29,6 +29,6 @@ CSRInfo *get_csr(unsigned int csr_num);
>   bool set_csr_flag(unsigned int csr_num, int flag);
>   static inline int get_csr_offset(const CSRInfo *csr, int vm_level)
>   {
> -    return csr->offset;
> +    return csr->offset + offsetof(CPULoongArchState, sys_states[vm_level]);
>   }
>   #endif /* TARGET_LOONGARCH_CSR_H */
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 4db53fec26..931a5ca5ba 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -58,9 +58,9 @@ static const VMStateDescription vmstate_msgint = {
>       .minimum_version_id = 1,
>       .needed = msgint_needed,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_UINT64_ARRAY(env.CSR_MSGIS, LoongArchCPU, N_MSGIS),
> -        VMSTATE_UINT64(env.CSR_MSGIR, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_MSGIE, LoongArchCPU),
> +        VMSTATE_UINT64_ARRAY(env.sys_states[0].CSR_MSGIS, LoongArchCPU, N_MSGIS),
> +        VMSTATE_UINT64(env.sys_states[0].CSR_MSGIR, LoongArchCPU),
> +        VMSTATE_UINT64(env.sys_states[0].CSR_MSGIE, LoongArchCPU),

No impact right now, but all the migration stream will be broken when
you add more sys_states.

Will sys_states number be static or dynamic?

>           VMSTATE_END_OF_LIST()
>       },
>   };


> diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> index 298a80cff5..838ac7e6b4 100644
> --- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> @@ -46,13 +46,15 @@ static bool gen_rdtime(DisasContext *ctx, arg_rr *a,
>   {
>       TCGv dst1 = gpr_dst(ctx, a->rd, EXT_NONE);
>       TCGv dst2 = gpr_dst(ctx, a->rj, EXT_NONE);
> +    tcg_target_long offset;
>   
>       translator_io_start(&ctx->base);
>       gen_helper_rdtime_d(dst1, tcg_env);
>       if (word) {
>           tcg_gen_sextract_tl(dst1, dst1, high ? 32 : 0, 32);
>       }
> -    tcg_gen_ld_i64(dst2, tcg_env, offsetof(CPULoongArchState, CSR_TID));
> +    offset = offsetof(CPUSysState, CSR_TID) + offsetof(CPULoongArchState, sys_states[0]);

This seems fragile. Could you move as a preliminary patch change?
Also write it reversed:

   offsetof(CPULoongArchState, sys_states[0]) + offsetof(CPUSysState, 
CSR_TID)

> +    tcg_gen_ld_i64(dst2, tcg_env, offset);
>   
>       return true;
>   }



