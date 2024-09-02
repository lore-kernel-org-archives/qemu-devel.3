Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776BFCA101E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 00:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skuvc-0003FV-Ka; Sun, 01 Sep 2024 20:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skuva-0003CY-AN
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 20:28:18 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skuvX-000682-OP
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 20:28:18 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7148912a1ebso2002581b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725236894; x=1725841694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b7aV7A74PxVdKecPLTjCtCOD1KqCZH7fmRi3VmEY2Yw=;
 b=ZlyXXS4aRspUlV5IugkTVYsYO0LzJTCuSjWalBLd2TWUoD1h4wj4PN8yKBn2EgEvSu
 50n4bBszGrGdQddNsOcEaDSeZIYWEAnW5lTlXsktzxVYLYuk1csyAxfhXTsUVSG8ppkM
 muQ0fokFVc82dlmcWaMFCEc8C5dJzdKrJgZqGdj7Jv1SZpLyJm4AZD09HQBgCXDKHSGT
 6u8HvLVeWjboOq8zV1vonv/3fW7apl7cPnEuPfKgj26KOUuWQ01bICb98sHnhdP9P7Ey
 D0rIkmNJPmxP574nsQxbjl5CcdXfGM+mPYAIqZ7iwrRIsv368PavdD+S7RC8PwbTW27N
 kNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725236894; x=1725841694;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b7aV7A74PxVdKecPLTjCtCOD1KqCZH7fmRi3VmEY2Yw=;
 b=nWRgBglYTzrKJw6//i05z715IP03vBqqLWmtL8pOWe+fpQSDBeGt4bciQBMZfv8CZa
 2Ze2FsDltgokyyJl/87nvSzE0pbUDvDhnMrC8elkN6WqmexWG9nccZvovp/HBxS3x+Fc
 3B1mIO1Lm9Mf9UOm2GnsYSG0kgoxvQY3/XszAoa0ZnYP14pL2U2Tat6Hf9Xz8xaCvD4C
 lxrBfZUugQ1bSVP0jsAWnUEpJvUD0wMoDzQsxzKS8MdeI8o9gKr+OedMlWdg+lY8eo8j
 uKdHuvLMnh9+Vd8M0Vp3TG/YUdnPeaCzHmtEjd/WD9/AG647ZzPeNg0wd80e+v2mXhJB
 s/nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV46drKTVjlPcDjGd2KKliYjlQDCRtP5PJ4l1R11bjDbywcQBqV4bQoJFLLLVpdIhkT6pdvQsJuzOVD@nongnu.org
X-Gm-Message-State: AOJu0YxxQ46iUSs0a+HhV+ahsT2Otx5C+r0Z6l1XA/7bppwMNPZStA5p
 ddEm4VUJK2M+ipHwm5rRCyts8ji4X+ehWS5fvwW/O6QGUgY9/rhwz+aLc+pZNeA=
X-Google-Smtp-Source: AGHT+IG3zJMG6GNz615s375kiRI+ZY3XEeoiyD0LqqNCWHIzRAeWbimqdWBlZdrbzf1Nq27dnY3eZQ==
X-Received: by 2002:a05:6a00:1393:b0:710:5848:8ae1 with SMTP id
 d2e1a72fcca58-7173c1e0ed8mr4829189b3a.4.1725236893800; 
 Sun, 01 Sep 2024 17:28:13 -0700 (PDT)
Received: from ?IPV6:2001:8004:5170:1fd8:ef9d:e346:b99e:7072?
 ([2001:8004:5170:1fd8:ef9d:e346:b99e:7072])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e5763abdsm5760797b3a.210.2024.09.01.17.28.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2024 17:28:13 -0700 (PDT)
Message-ID: <0b1df6e8-5fa3-469e-b1e0-1b0ac7d4dfd2@linaro.org>
Date: Mon, 2 Sep 2024 10:28:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] tcg/riscv: Add basic support for vector
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 Swung0x48 <swung0x48@outlook.com>,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-4-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240830061607.1940-4-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> From: Swung0x48 <swung0x48@outlook.com>
> 
> The RISC-V vector instruction set utilizes the LMUL field to group
> multiple registers, enabling variable-length vector registers. This
> implementation uses only the first register number of each group while
> reserving the other register numbers within the group.
> 
> In TCG, each VEC_IR can have 3 types (TCG_TYPE_V64/128/256), and the
> host runtime needs to adjust LMUL based on the type to use different
> register groups.
> 
> This presents challenges for TCG's register allocation. Currently, we
> avoid modifying the register allocation part of TCG and only expose the
> minimum number of vector registers.
> 
> For example, when the host vlen is 64 bits and type is TCG_TYPE_V256, with
> LMUL equal to 4, we use 4 vector registers as one register group. We can
> use a maximum of 8 register groups, but the V0 register number is reserved
> as a mask register, so we can effectively use at most 7 register groups.
> Moreover, when type is smaller than TCG_TYPE_V256, only 7 registers are
> forced to be used. This is because TCG cannot yet dynamically constrain
> registers with type; likewise, when the host vlen is 128 bits and
> TCG_TYPE_V256, we can use at most 15 registers.
> 
> There is not much pressure on vector register allocation in TCG now, so
> using 7 registers is feasible and will not have a major impact on code
> generation.
> 
> This patch:
> 1. Reserves vector register 0 for use as a mask register.
> 2. When using register groups, reserves the additional registers within
>     each group.
> 
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target-con-str.h |   1 +
>   tcg/riscv/tcg-target.c.inc     | 131 +++++++++++++++++++++++++--------
>   tcg/riscv/tcg-target.h         |  78 +++++++++++---------
>   tcg/riscv/tcg-target.opc.h     |  12 +++
>   4 files changed, 157 insertions(+), 65 deletions(-)
>   create mode 100644 tcg/riscv/tcg-target.opc.h
> 
> diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
> index d5c419dff1..21c4a0a0e0 100644
> --- a/tcg/riscv/tcg-target-con-str.h
> +++ b/tcg/riscv/tcg-target-con-str.h
> @@ -9,6 +9,7 @@
>    * REGS(letter, register_mask)
>    */
>   REGS('r', ALL_GENERAL_REGS)
> +REGS('v', GET_VREG_SET(riscv_vlen))

Perhaps too complicated. Make this MAKE_64BIT_MASK(32, 32); everything else will be 
handled by tcg_target_available_regs[] and reserved_regs.

> @@ -127,6 +113,12 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   #define TCG_CT_CONST_J12  0x1000
>   
>   #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
> +#define ALL_VECTOR_REGS    MAKE_64BIT_MASK(33, 31)
> +#define ALL_DVECTOR_REG_GROUPS 0x5555555400000000
> +#define ALL_QVECTOR_REG_GROUPS 0x1111111000000000

V0 is still a vector register, even if it is reserved.
I think you should include it in these masks.

> +#define GET_VREG_SET(vlen) (vlen == 64 ? ALL_QVECTOR_REG_GROUPS : \
> +                             (vlen == 128 ? ALL_DVECTOR_REG_GROUPS : \
> +                              ALL_VECTOR_REGS))

I think you will not need this macro.

> +/*
> + * RISC-V vector instruction emitters
> + */
> +
> +/* Vector registers uses the same 5 lower bits as GPR registers. */
> +static void tcg_out_opc_reg_vec(TCGContext *s, RISCVInsn opc,
> +                                TCGReg d, TCGReg s1, TCGReg s2, bool vm)
> +{
> +    tcg_out32(s, encode_r(opc, d, s1, s2) | (vm << 25));
> +}
> +
> +static void tcg_out_opc_reg_vec_i(TCGContext *s, RISCVInsn opc,
> +                                  TCGReg rd, TCGArg imm, TCGReg vs2, bool vm)
> +{
> +    tcg_out32(s, encode_r(opc, rd, (imm & 0x1f), vs2) | (vm << 25));

I think you want to create new encode_* functions, not abuse the integer ones.

> +}
> +
> +/* vm=0 (vm = false) means vector masking ENABLED. */
> +#define tcg_out_opc_vv(s, opc, vd, vs2, vs1, vm) \
> +    tcg_out_opc_reg_vec(s, opc, vd, vs1, vs2, vm);
> +
> +/*
> + * In RISC-V, vs2 is the first operand, while rs1/imm is the
> + * second operand.
> + */
> +#define tcg_out_opc_vx(s, opc, vd, vs2, rs1, vm) \
> +    tcg_out_opc_reg_vec(s, opc, vd, rs1, vs2, vm);
> +
> +#define tcg_out_opc_vi(s, opc, vd, vs2, imm, vm) \
> +    tcg_out_opc_reg_vec_i(s, opc, vd, imm, vs2, vm);
> +
> +/*
> + * Only unit-stride addressing implemented; may extend in future.
> + */
> +#define tcg_out_opc_ldst_vec(s, opc, vs3_vd, rs1, vm) \
> +    tcg_out_opc_reg_vec(s, opc, vs3_vd, rs1, 0, vm);

I don't understand the need for any of these #defines.
Why are we not simply creating functions of the correct name?

> @@ -2101,6 +2160,13 @@ static void tcg_target_init(TCGContext *s)
>       tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
>       tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
>   
> +    if (cpuinfo & CPUINFO_ZVE64X) {
> +        TCGRegSet vector_regs = GET_VREG_SET(riscv_vlen);

This ought to be the only usage of GET_VREG_SET, so I think you should inline that code 
with a switch on riscv_vlen/vlenb.


r~

