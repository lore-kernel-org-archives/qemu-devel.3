Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F22C52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbVze-0003J8-6x; Tue, 06 Aug 2024 22:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbVzb-0003Hw-Fn
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:01:35 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbVzY-0007V9-PF
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:01:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc66fc35f2so3291775ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 19:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722996091; x=1723600891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JdWzPy6vp9CCxgFgNO9qMaXo0Nkyu6ka6NHNfMr/vl4=;
 b=IRzR0YpkuTwWCHrUP1Ms0PbZVG4JMGzgQJpmWYROCWLne3N97c7aeSLRSN4UJI5BYl
 GH4i9PX9AJF6RrRJk7X+kWOURPH3hWRu+67bGjzqijPlfJRGBj8hVNaJ4LH1FDx+JfFt
 4QzkIoMNFp9wkFn2FHMFpUqPjxsnXhcgu5FKofVXPH3wlXPoanqwK6enVDc3h3IwreYx
 jA6A3CmwR5fcx050UjL03b+IF6rzz6MB/+ndDkVlQ6OStqFG/unup5oNlENBvOK1xryv
 cWLZ599vQeJ9O6t98LGpT5oUOJxW8qQ2DZ/tmtLxRX9GHg8UYOAvIIbte/HeGWrfnCFt
 BnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722996091; x=1723600891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JdWzPy6vp9CCxgFgNO9qMaXo0Nkyu6ka6NHNfMr/vl4=;
 b=HQTUUcsvRgxoWSzNNF8b2Lqdgurrx79w9G5PBH/3d4eHh0oDECfKl8V9GE0aP+YlvS
 jQr7Vu5Gfun3o/qES8xacKWjHYeGNLllhbfB/nx35lL0nHdpKvaWgqv13umekDXSeYVX
 v537yw7uRLb3GK+klvihQLFlE4ECGczOKXPlwhNb7+pqCnEjO4IwlHq8Nh/vJ615KE0y
 onxr+BiV798zBoa28KLns3kRWrScnu6/mZGfpfeJ69bjvpnISHAuhwG4jX2PZ+4q6QmR
 4ymVtxRHy4916OQbt56nFuu7aFjokCbjK3Dqt0WGG5fRi+98S4q87bI4cxHmrTP4SKSN
 xsMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTyajNHTdyQ4VrTFoO3lP9yr5OcKuxpvUXezUciA30YyBdOPnlRQdB/EFTgD1r3zWrvMyveacRkNKbuOXhuOsfo2A8Z4w=
X-Gm-Message-State: AOJu0YxttXWBeZ773zQ21qUxXu7conLXUedC3+vDxGc3yeZVvaa+Tp7D
 dMZ3iSe6CBSII36FSoTRUqCKOKQJ2qB/10MSbqSraLSmDtHhUhHj0WkxOxGstvo=
X-Google-Smtp-Source: AGHT+IGVn1d8Zwfi/r+RT155yKrTGs/HCpx3cPBz43+4ro3P7PylFWKMQblryDdjWZsUcp9I9JrnNg==
X-Received: by 2002:a17:903:22c1:b0:1fd:7ff5:c673 with SMTP id
 d9443c01a7336-200853a50b2mr12240135ad.2.1722996090535; 
 Tue, 06 Aug 2024 19:01:30 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592ad853sm94050835ad.280.2024.08.06.19.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 19:01:29 -0700 (PDT)
Message-ID: <cfe784d9-6cc1-44c5-b8cf-61b61a926a6a@linaro.org>
Date: Wed, 7 Aug 2024 12:01:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/20] target/riscv: zicfilp `lpad` impl and branch
 tracking
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-8-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-8-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 8/7/24 10:06, Deepak Gupta wrote:
> diff --git a/target/riscv/cpu_user.h b/target/riscv/cpu_user.h
> index 02afad608b..e6927ff847 100644
> --- a/target/riscv/cpu_user.h
> +++ b/target/riscv/cpu_user.h
> @@ -15,5 +15,6 @@
>   #define xA6 16
>   #define xA7 17  /* syscall number for RVI ABI */
>   #define xT0 5   /* syscall number for RVE ABI */
> +#define xT2 7

Maybe just add them all?

> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index 98e3806d5e..cbd7d5c395 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -36,6 +36,58 @@ static bool trans_lui(DisasContext *ctx, arg_lui *a)
>       return true;
>   }
>   
> +static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
> +{
> +    bool lp_expected;
> +    /* zicfilp only supported on 32bit and 64bit */
> +    if (get_xl(ctx) != MXL_RV32 && get_xl(ctx) != MXL_RV64) {
> +        return false;
> +    }

Where does it say that?
There doesn't seem to be anything in the spec that excludes rv128.

> +    lp_expected = ctx->fcfi_lp_expected;
> +    /* forward cfi not enabled or lp not expected, return false */
> +    if (!ctx->fcfi_enabled) {
> +        return false;
> +    }

Comments should explain why, not exactly mirror the code.
In any case, better as:

   /*
    * If zicfilp not present, the encoding is a nop.
    * If forward cfi not enabled, the implementation is a nop.
    */
   if (!ctx->fcfi_enabled) {
       return true;
   }

No need to fall through into AUIPC to re-discover nop-ness.

> +
> +    /*
> +     * If this is the first instruction of the TB, let the translator
> +     * know the landing pad requirement was satisfied. No need to bother
> +     * checking for CFI feature or enablement.
> +     */

Comment is strange, because you have just checked enablement.

> +    /* if lp was expected, do label check */
> +    if (lp_expected) {
> +        TCGLabel *skip = gen_new_label();
> +        TCGv tmp = tcg_temp_new();
> +        tcg_gen_st_tl(tcg_constant_tl(NO_LP_EXPECTED),
> +                      tcg_env, offsetof(CPURISCVState, elp));

This placement is wrong, according to the LPAD pseudocode.
It must go last.

> +        tcg_gen_extract_tl(tmp, get_gpr(ctx, xT2, EXT_NONE), 12, 20);
> +        tcg_gen_brcondi_tl(TCG_COND_EQ, tcg_constant_tl(a->imm_cfi20), 0, skip);

This one you check at translation time:

   if (a->imm_cfi20 != 0)


> +        tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->imm_cfi20, skip);
> +        gen_helper_raise_sw_check_excep(tcg_env,
> +            tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> +            tcg_constant_tl(LABEL_MISMATCH_LPAD), tcg_constant_tl(0));
> +        gen_set_label(skip);
> +    }
> +
> +    return true;
> +}
> +
>   static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
>   {
>       TCGv target_pc = dest_gpr(ctx, a->rd);
> @@ -75,6 +127,20 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
>       gen_set_gpr(ctx, a->rd, succ_pc);
>   
>       tcg_gen_mov_tl(cpu_pc, target_pc);
> +    if (ctx->cfg_ptr->ext_zicfilp && ctx->fcfi_enabled) {

No need to check ext_zicfilp, as fcfi_enabled includes that already.

> +        /*
> +         * Rely on a helper to check the forward CFI enable for the
> +         * current process mode. The alternatives would be (1) include
> +         * "fcfi enabled" in the cflags or (2) maintain a "fcfi
> +         * currently enabled" in tcg_env and emit TCG code to access
> +         * and test it.
> +         */

Comment is out of date.

> +        if (a->rs1 != xRA && a->rs1 != xT0 && a->rs1 != xT2) {
> +            tcg_gen_st_tl(tcg_constant_tl(LP_EXPECTED),
> +                          tcg_env, offsetof(CPURISCVState, elp));
> +        }
> +    }
> +
>       lookup_and_goto_ptr(ctx);
>   
>       if (misaligned) {


r~

