Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1B3C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9Jh-0003gE-JJ; Wed, 14 Aug 2024 04:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se9Jf-0003fH-W1
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:25:12 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se9Je-0003Kg-3U
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:25:11 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3db51133978so4351998b6e.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 01:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723623908; x=1724228708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BdBmJ/kk0u7YMhWmnPakUFig2Q0XocWnRUJe6xpARiM=;
 b=bBxuqBtHNNMfgftrMy2gsTxiJxTvJK/C9pkmqMcRGAmqwWv1sd37+KZ5y+DHhXKCUy
 ovrm/VTiSwa4x9fnXKS0Dcrc4aBnILmeQIqJsxAunOj4CWieHjGzSgZTMvRReFczwvBH
 0H9SeGAcJaTl9+xfeGpIpuJc8jA0OtOkpWR0jn2D0dmUHPUeHwajWyXhYCGP7GlxsQJH
 wkLn78blLxKcd8mqIgyw0mhU/FirNoV9YwXd9JjUyPlXqHPPkY9r0+zTqYAFeVYXujec
 RFypSuIDIyA/udEHDpr9dChvSf2nMAuJgcapwXWovu9T0JVvKmxCTZXjOBDfWmvjXOV9
 iiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723623908; x=1724228708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BdBmJ/kk0u7YMhWmnPakUFig2Q0XocWnRUJe6xpARiM=;
 b=imoUyldzt2CGCAViOz9JJSnQI5bFQf8fLGqJ26cmYH1LBdpe9G3qOp+fChVN/V1X97
 lnpZfXPD9Pn2yDp9+cUSB93Zp9PFPr8C00AkqLH3I0Jt8k1uusmmPKl1spVySk6hd7uP
 GSwiefQNFywk64UBljak1XqV0VgcRr2KDhlj8dmI/CyZZiFcsR97VClyNAA3XGUmgXdP
 cvLX2oCozhxI+KjdK9vxeAZcbBToGLxJyvg5yLgVwDXw2J6e8xon/Lw54QZ8ZuGdHWuF
 4+W4aqLOK3lBPHCmhBmeGsG1mIZCfd8ahU8IqvcqjcjLRIKWxO6ujuXgL4X3kzgk9IPB
 C/xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVovGs4RhDdrwvWrbZJnKO5bJXkh6SFkdpCR4oZoo9EXrdDwZl7tSTVihhqrsiZoVeZSBsVg10pDHYdcQVfcadFx0OBGZc=
X-Gm-Message-State: AOJu0YzL9QKBbJD43quXuT13DvCsLccX0IJ+/Clv0O2ZAxJJfleKhcu+
 ZBBFU3R9XvI5cBJpmFfDUgr76FRuxQ30hVVOC8/UGicsWrR7+sf/IQHxAhFfgfQ=
X-Google-Smtp-Source: AGHT+IHrgtZmBLxuuNxCOVaxPpLbEb8+97H7mDbYX1GHCi7k5wNrkn/NFM1l+iVoYsyWHVkOkM6pKg==
X-Received: by 2002:a05:6808:1284:b0:3db:25f6:a62f with SMTP id
 5614622812f47-3dd29935d71mr2462235b6e.28.1723623907866; 
 Wed, 14 Aug 2024 01:25:07 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c697a54939sm2683936a12.70.2024.08.14.01.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 01:25:07 -0700 (PDT)
Message-ID: <37e67a28-dd86-435d-a072-95f6a85cc2a7@linaro.org>
Date: Wed, 14 Aug 2024 18:24:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] tcg/riscv: Add riscv vset{i}vli support
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-6-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813113436.831-6-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/13/24 21:34, LIU Zhiwei wrote:
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> 
> In RISC-V, vector operations require initial configuration using
> the vset{i}vl{i} instruction.
> 
> This instruction:
>    1. Sets the vector length (vl) in bytes
>    2. Configures the vtype register, which includes:
>      SEW (Single Element Width)
>      LMUL (vector register group multiplier)
>      Other vector operation parameters
> 
> This configuration is crucial for defining subsequent vector
> operation behavior. To optimize performance, the configuration
> process is managed dynamically:
>    1. Reconfiguration using vset{i}vl{i} is necessary when SEW
>       or vector register group width changes.
>    2. The vset instruction can be omitted when configuration
>       remains unchanged.
> 
> This optimization is only effective within a single TB.
> Each TB requires reconfiguration at its start, as the current
> state cannot be obtained from hardware.
> 
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Signed-off-by: Weiwei Li <liwei1518@gmail.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target.c.inc | 121 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 121 insertions(+)
> 
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index ca9bafcb3c..d17f523187 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -167,6 +167,18 @@ static bool tcg_target_const_match(int64_t val, int ct,
>    * RISC-V Base ISA opcodes (IM)
>    */
>   
> +#define V_OPIVV (0x0 << 12)
> +#define V_OPFVV (0x1 << 12)
> +#define V_OPMVV (0x2 << 12)
> +#define V_OPIVI (0x3 << 12)
> +#define V_OPIVX (0x4 << 12)
> +#define V_OPFVF (0x5 << 12)
> +#define V_OPMVX (0x6 << 12)
> +#define V_OPCFG (0x7 << 12)
> +
> +#define V_SUMOP (0x0 << 20)
> +#define V_LUMOP (0x0 << 20)
> +
>   typedef enum {
>       OPC_ADD = 0x33,
>       OPC_ADDI = 0x13,
> @@ -262,6 +274,11 @@ typedef enum {
>       /* Zicond: integer conditional operations */
>       OPC_CZERO_EQZ = 0x0e005033,
>       OPC_CZERO_NEZ = 0x0e007033,
> +
> +    /* V: Vector extension 1.0 */
> +    OPC_VSETVLI  = 0x57 | V_OPCFG,
> +    OPC_VSETIVLI = 0xc0000057 | V_OPCFG,
> +    OPC_VSETVL   = 0x80000057 | V_OPCFG,
>   } RISCVInsn;
>   
>   /*
> @@ -354,6 +371,42 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
>       return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
>   }
>   
> +typedef enum {
> +    VTA_TU = 0,
> +    VTA_TA,
> +} RISCVVta;
> +
> +typedef enum {
> +    VMA_MU = 0,
> +    VMA_MA,
> +} RISCVVma;
> +
> +typedef enum {
> +    VSEW_E8 = 0, /* EW=8b */
> +    VSEW_E16,    /* EW=16b */
> +    VSEW_E32,    /* EW=32b */
> +    VSEW_E64,    /* EW=64b */
> +} RISCVVsew;

This exactly aligns with MemOp and vece.  Do we really need an enum for this?

> +
> +typedef enum {
> +    VLMUL_M1 = 0, /* LMUL=1 */
> +    VLMUL_M2,     /* LMUL=2 */
> +    VLMUL_M4,     /* LMUL=4 */
> +    VLMUL_M8,     /* LMUL=8 */
> +    VLMUL_RESERVED,
> +    VLMUL_MF8,    /* LMUL=1/8 */
> +    VLMUL_MF4,    /* LMUL=1/4 */
> +    VLMUL_MF2,    /* LMUL=1/2 */
> +} RISCVVlmul;
> +#define LMUL_MAX 8
> +
> +static int32_t encode_vtype(RISCVVta vta, RISCVVma vma,
> +                            RISCVVsew vsew, RISCVVlmul vlmul)
> +{
> +    return (vma & 0x1) << 7 | (vta & 0x1) << 6 | (vsew & 0x7) << 3 |
> +           (vlmul & 0x7);
> +}

> +static void tcg_out_vsetvl(TCGContext *s, uint32_t avl, RISCVVta vta,
> +                           RISCVVma vma, RISCVVsew vsew,
> +                           RISCVVlmul vlmul)
> +{
> +    int32_t vtypei = encode_vtype(vta, vma, vsew, vlmul);
> +
> +    if (avl < 32) {
> +        tcg_out_opc_vconfig(s, OPC_VSETIVLI, TCG_REG_ZERO, avl, vtypei);
> +    } else {
> +        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, avl);
> +        tcg_out_opc_vconfig(s, OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP0, vtypei);
> +    }
> +}
> +
> +/*
> + * TODO: If the vtype value is not supported by the implementation,
> + * then the vill bit is set in vtype, the remaining bits in
> + * vtype are set to zero, and the vl register is also set to zero
> + */
> +
> +static __thread unsigned prev_size;
> +static __thread unsigned prev_vece = MO_8;
> +static __thread bool vec_vtpye_init = true;

Typo in vtpye.

That said, init should be redundant.  I think you only need one variable here:

   static __thread int prev_vtype;

Since any vtype < 0 is vill, the "uninitialized" value is easily -1.

> +static inline void tcg_target_set_vec_config(TCGContext *s, TCGType type,
> +                                      unsigned vece)
> +{
> +    unsigned oprsz = get_vec_type_bytes(type);
> +
> +    if (!vec_vtpye_init && (prev_size == oprsz && prev_vece == vece)) {
> +        return ;
> +    }

     int vtype = encode_vtype(...);
     if (vtype != prev_vtype) {
         prev_vtype = vtype;
         tcg_out_vsetvl(s, vtype);
     }

> @@ -1914,6 +2029,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>                              const TCGArg args[TCG_MAX_OP_ARGS],
>                              const int const_args[TCG_MAX_OP_ARGS])
>   {
> +    TCGType type = vecl + TCG_TYPE_V64;
> +
> +    if (vec_vtpye_init) {
> +        tcg_target_set_vec_config(s, type, vece);
> +    }

Here is perhaps too early... see patch 8 re logicals.


r~

