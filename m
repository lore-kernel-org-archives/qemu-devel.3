Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE02CA101E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 01:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skvXF-0002NB-Gj; Sun, 01 Sep 2024 21:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skvXE-0002LG-0R
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 21:07:12 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skvXC-0001QK-2n
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 21:07:11 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2021a99af5eso30351385ad.1
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 18:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725239228; x=1725844028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KJxcyM8lp90O+B1hA10NmGry8tv6/fGPqs5HZWJBRJk=;
 b=LVEcIbQ2M2O1qnifnOcMPh4Au4sH2jVgrzkY6C07k9p7KtKXu3NXoforPk7x27Y6bQ
 WW+OHNqOtMBd6AQD+EhPA3RWDaWmumB7LDhuLeMoImq2ZH+BPId9jpTdgcm6vva/Y/d6
 dWXsUIceZy0up0zgbAHKy7uJC0fbLwcSvDMX9/4uIbeUrjoliDb2h5MvwAwG171Y/dJz
 CPudUOSpvPWHEDceGz4UU730hN+fL9MYum7YVlw+gpdbavb0NTweIJ4YNXYCHYmKciy6
 HRbs33FHVHMu9ody1b8IAue1LOArJOTaoGvuULeEFBs7OzS19LDD2fOrh2aLVlzK7yfy
 AtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239228; x=1725844028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KJxcyM8lp90O+B1hA10NmGry8tv6/fGPqs5HZWJBRJk=;
 b=TmK8yWhGIJD59UAzwtMtbR7czkdcFy3UN4ASqBBTFEYDTUo2Q2WlUsdHrCeF9M3fnh
 k4ffmS1KVL0okpR0PSUg0hHRRNB3DmxitI6USu/PvoWzkeNWio4ekYYdr6m/dwFARbYg
 NjL3MAXpnGgOR4ECt0/LCf5mzRiYHnVs9EoR+jbvU1bJZ2mvKYwfeRc/IIeM38ng7FSX
 qkH4vxAjhR6pKv+AYgScbGlUudJh7oNsXNcPL88u4WH+W5DObcFhiKzXf+tvArGQ8hkj
 Ma+YY4jGuxMYas53IwVlOYKJyrnaqrHvU1/tUyI5VdUHiS2C8HtblHh8pk6bcgRVyiKm
 NBdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMb/JWS0MSdwHC66sW3Pz2skARVkNi9AoMoJBoLPKLAyAE1RG9Et+FdhthS8YgHv7mktzABe2v9rMx@nongnu.org
X-Gm-Message-State: AOJu0YyhqATbYZU+AvBMr5meorsn/GdlH/zlk2N6v0T/8YqEGgdbz4hk
 6NoRzpDCk1fEKj1/GlP9v2GVlhUPxnfGiP9njG1bc9/xfDVg1s4KoWvwgNEGXy0=
X-Google-Smtp-Source: AGHT+IFnvamdJGSnGNtA/Y9yQUkbMENE3YT5Sg3VI5m69IKMjIuWpnDzpYamieCawuPrf/dFju5QAw==
X-Received: by 2002:a17:903:41c8:b0:202:54a5:deaf with SMTP id
 d9443c01a7336-20584230da6mr6181845ad.57.1725239227562; 
 Sun, 01 Sep 2024 18:07:07 -0700 (PDT)
Received: from ?IPV6:2001:8004:5170:1fd8:ef9d:e346:b99e:7072?
 ([2001:8004:5170:1fd8:ef9d:e346:b99e:7072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20560cfc878sm14452225ad.259.2024.09.01.18.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2024 18:07:06 -0700 (PDT)
Message-ID: <5da4214a-0ee8-4b37-9d95-b92c511d7386@linaro.org>
Date: Mon, 2 Sep 2024 11:06:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] tcg/riscv: Add riscv vset{i}vli support
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-5-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240830061607.1940-5-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/30/24 16:15, LIU Zhiwei wrote:
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
>   tcg/riscv/tcg-target.c.inc | 104 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 104 insertions(+)
> 
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 5ef1538aed..49d01b8775 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -119,6 +119,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   #define GET_VREG_SET(vlen) (vlen == 64 ? ALL_QVECTOR_REG_GROUPS : \
>                                (vlen == 128 ? ALL_DVECTOR_REG_GROUPS : \
>                                 ALL_VECTOR_REGS))
> +#define riscv_vlenb (riscv_vlen / 8)
>   
>   #define sextreg  sextract64
>   
> @@ -168,6 +169,18 @@ static bool tcg_target_const_match(int64_t val, int ct,
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
> @@ -263,6 +276,11 @@ typedef enum {
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
> @@ -355,6 +373,35 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
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

Do these really need enumerators, or would 'bool' be sufficient?

> +static int32_t encode_vtypei(RISCVVta vta, RISCVVma vma,
> +                            unsigned vsew, RISCVVlmul vlmul)
> +{
> +    return (vma & 0x1) << 7 | (vta & 0x1) << 6 | (vsew & 0x7) << 3 |
> +           (vlmul & 0x7);
> +}

s/vtypei/vtype/g?  vtype is only immediate in specific contexts, and you'll match the 
manual better if you talk about vtype the CSR rather than the vset*vli argument.

Assert values in range rather than masking.

Use MemOp vsew, since you're using MO_64, etc.

> @@ -498,12 +551,62 @@ static void tcg_out_opc_reg_vec_i(TCGContext *s, RISCVInsn opc,
>   #define tcg_out_opc_vi(s, opc, vd, vs2, imm, vm) \
>       tcg_out_opc_reg_vec_i(s, opc, vd, imm, vs2, vm);
>   
> +#define tcg_out_opc_vconfig(s, opc, rd, avl, vtypei) \
> +    tcg_out_opc_vec_config(s, opc, rd, avl, vtypei);

Why the extra define?

> +
> +/*
> + * TODO: If the vtype value is not supported by the implementation,
> + * then the vill bit is set in vtype, the remaining bits in
> + * vtype are set to zero, and the vl register is also set to zero
> + */

Why is this a TODO?
Are you suggesting that we might need to probe *all* of the cases at startup?

> +static __thread int prev_vtypei;

I think we should put this into TCGContext.
We don't currently have any host-specific values there, but there's no reason we can't 
have any.

> +#define get_vlmax(vsew) (riscv_vlen / (8 << vsew) * (LMUL_MAX))

Given that we know that LMUL_MAX is 8, doesn't this cancel out?


> +#define get_vec_type_bytes(type)    (type >= TCG_TYPE_V64 ? \
> +                                    (8 << (type - TCG_TYPE_V64)) : 0)

Again, assert not produce nonsense results.  And this doesn't need hiding in a macro.

> +#define calc_vlmul(oprsz)    (ctzl(oprsz / riscv_vlenb))

I think it's clearer to do this inline, where we can see that oprsz > vlenb.

> +
> +static void tcg_target_set_vec_config(TCGContext *s, TCGType type,
> +                                      unsigned vece)
> +{
> +    unsigned vsew, oprsz, avl;
> +    int vtypei;
> +    RISCVVlmul vlmul;
> +
> +    vsew = vece;

You can just name the argument vsew...

> +    oprsz = get_vec_type_bytes(type);
> +    avl = oprsz / (1 << vece);
> +    vlmul = oprsz > riscv_vlenb ?
> +                      calc_vlmul(oprsz) : VLMUL_M1;

I guess it is always the case that full register operations are preferred over fractional?

> +    vtypei = encode_vtypei(VTA_TA, VMA_MA, vsew, vlmul);
> +
> +    tcg_debug_assert(avl <= get_vlmax(vsew));
> +    tcg_debug_assert(vlmul <= VLMUL_RESERVED);
> +    tcg_debug_assert(vsew <= MO_64);

These asserts should be moved higher, above their first uses.


r~

