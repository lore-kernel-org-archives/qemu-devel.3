Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E141AC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 14:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0jTy-0004JH-F9; Sat, 27 Apr 2024 10:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s0jTx-0004In-AA
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 10:56:53 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s0jTv-0001Oj-FU
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 10:56:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e9451d8b71so27182825ad.0
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714229810; x=1714834610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P7i+j8sQZ7Tw/riqXNghKg1JnYab/QQ1Zk9cKxeYIOo=;
 b=rlMaZ1PMBhQWEdIoDgSigtP++AqOtgpxIEhTwX+B2l4dA79WbO9nB7D7ot1GVrKVTl
 l2LT+3jwIbUvN9k3k9QEsXN6mCFZYmNotmY6+IITzfD2va8krMUfuL81jaGAK9eHWU1K
 +IDYc+/1fpxqpiGkgpp5ksyVQJJPFlX0SncaDEiniQBpLVAlwuBGgoLrddrRe1VQUFFL
 x4UOpz8ML/zV1EwhMcKoDSX/9upVgvU2Prol7ulLYiIYh1Fv3wErZSif0NUmDkbBa6H7
 8N6RLBUQ7JMfIMwSbJ2V+Uf7a8WClegpdwfO/ZhQrbLaKr22jmrQXFHURLepgxwputPm
 ZZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714229810; x=1714834610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P7i+j8sQZ7Tw/riqXNghKg1JnYab/QQ1Zk9cKxeYIOo=;
 b=nU+wCwu6woCGAPgGnLRFYQk38xQdcTIPaSLPbSpK/r8kNUeN6JLiGpUWmYpcgill4C
 bk/igd8RrkiK3G2D2SfhbGLQ0/pHV0IfuYaWE6pNf9sW+CzT5tSA5zhjVlAiqmia+Uvi
 lXrxRt1sFgD6cgysT1QwM/HivRVwlc0IZlNbEX5eFqtsKZpaykU1DeRG/QfjfnpTmzI/
 e3U4cLLPyvZcMtKA1F+Yf9xMoUoefZF9093tfrVuiDkk3Qgaw/ZWJc073VWA1Xt6do+9
 YcfIBQ+BRD/A9kEGqa2MZWOrVp3751DVvnSiUTvXUEx0uxwmz6+3F/YiYxST8EoP3HD8
 yEyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8Fuff5kecKshxY7RXmYBy+nxaith+34tlFUXzsQEO2k4x8AuJrPAsrSz3kELfULmaRs6oexQULAdXO/ujx0o8BfC23KA=
X-Gm-Message-State: AOJu0YysrCB3u/Dw+byhrpQwld1JUkyzzkaw7ai1jHTRdq0nIIyK4z9M
 FTk+nvsBO7u8bfxcQNvqVh4lmg73Vr/bXsC7S4BX0fH7C0sujm05uQXy84xj0yA=
X-Google-Smtp-Source: AGHT+IGOmgmWHzbf7WpDYBjJ2fbHj4EdF0xHqallk52yBekp8Mas68CJ45cvcvAqKRiR70ucPClQ1w==
X-Received: by 2002:a17:902:ecc4:b0:1e4:2879:3a38 with SMTP id
 a4-20020a170902ecc400b001e428793a38mr7130310plh.47.1714229809679; 
 Sat, 27 Apr 2024 07:56:49 -0700 (PDT)
Received: from [192.168.91.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 w1-20020a1709026f0100b001eb09053245sm3026844plk.131.2024.04.27.07.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Apr 2024 07:56:49 -0700 (PDT)
Message-ID: <121029ce-d106-4eb2-bbcb-6b65bd595813@linaro.org>
Date: Sat, 27 Apr 2024 07:56:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon: add PC alignment check and exception
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org
Cc: bcain@quicinc.com, sidneym@quicinc.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
References: <c7af62451b02ffdc1d68bc00093b40a8080bc3ff.1714155331.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c7af62451b02ffdc1d68bc00093b40a8080bc3ff.1714155331.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/26/24 11:15, Matheus Tavares Bernardino wrote:
> The Hexagon Programmer's Reference Manual says that the exception 0x1e
> should be raised upon an unaligned program counter. Let's implement that
> and also add tests for both the most common case as well as packets with
> multiple change-of-flow instructions.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>   target/hexagon/cpu_bits.h                  |  1 +
>   target/hexagon/translate.h                 |  2 ++
>   target/hexagon/genptr.c                    | 21 ++++++++++++++++-----
>   target/hexagon/translate.c                 |  2 +-
>   tests/tcg/hexagon/Makefile.target          | 13 +++++++++++++
>   tests/tcg/hexagon/unaligned_pc.S           | 10 ++++++++++
>   tests/tcg/hexagon/unaligned_pc_multi_cof.S | 13 +++++++++++++
>   7 files changed, 56 insertions(+), 6 deletions(-)
>   create mode 100644 tests/tcg/hexagon/unaligned_pc.S
>   create mode 100644 tests/tcg/hexagon/unaligned_pc_multi_cof.S
> 
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
> index 96fef71729..d6900c8bda 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -23,6 +23,7 @@
>   #define HEX_EXCP_FETCH_NO_UPAGE  0x012
>   #define HEX_EXCP_INVALID_PACKET  0x015
>   #define HEX_EXCP_INVALID_OPCODE  0x015
> +#define HEX_EXCP_PC_NOT_ALIGNED  0x01e
>   #define HEX_EXCP_PRIV_NO_UREAD   0x024
>   #define HEX_EXCP_PRIV_NO_UWRITE  0x025
>   
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index 4dd59c6726..daf11eb584 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -75,6 +75,8 @@ typedef struct DisasContext {
>       TCGv dczero_addr;
>   } DisasContext;
>   
> +void gen_exception_end_tb(DisasContext *ctx, int excp);
> +
>   static inline void ctx_log_pred_write(DisasContext *ctx, int pnum)
>   {
>       if (!test_bit(pnum, ctx->pregs_written)) {
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index dbae6c570a..c96edd9379 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -473,6 +473,7 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TCGv addr,
>                                     TCGCond cond, TCGv pred)
>   {
>       TCGLabel *pred_false = NULL;
> +    TCGLabel *branch_taken = NULL;
>       if (cond != TCG_COND_ALWAYS) {
>           pred_false = gen_new_label();
>           tcg_gen_brcondi_tl(cond, pred, 0, pred_false);
> @@ -480,12 +481,22 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TCGv addr,
>   
>       if (ctx->pkt->pkt_has_multi_cof) {
>           /* If there are multiple branches in a packet, ignore the second one */
> -        tcg_gen_movcond_tl(TCG_COND_NE, hex_gpr[HEX_REG_PC],
> -                           ctx->branch_taken, tcg_constant_tl(0),
> -                           hex_gpr[HEX_REG_PC], addr);
> +        branch_taken = gen_new_label();
> +        tcg_gen_brcondi_tl(TCG_COND_NE, ctx->branch_taken, 0, branch_taken);
>           tcg_gen_movi_tl(ctx->branch_taken, 1);
> -    } else {
> -        tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], addr);
> +    }
> +
> +    TCGLabel *pc_aligned = gen_new_label();
> +    TCGv pc_remainder = tcg_temp_new();
> +    tcg_gen_andi_tl(pc_remainder, addr, PCALIGN_MASK);
> +    tcg_gen_brcondi_tl(TCG_COND_EQ, pc_remainder, 0, pc_aligned);
> +    gen_exception_end_tb(ctx, HEX_EXCP_PC_NOT_ALIGNED);
> +    gen_set_label(pc_aligned);
> +
> +    tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], addr);

I am suspicious that the exception is raised without the pc being assigned.
How does the exception handler see the incorrect value?

Also, this is a perfect place to use the new TCG_COND_TSTEQ condition, eliminating the 
separate andi step and the variable.


r~

