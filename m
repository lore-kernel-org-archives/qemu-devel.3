Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A47C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 09:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seA4y-0000AK-K1; Wed, 14 Aug 2024 05:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seA4w-000097-R0
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:14:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seA4v-0002CR-0H
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:14:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc6ee64512so48241815ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723626839; x=1724231639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w2jpPws4/cx/uzTsc8TuuC25ohAAYzvoRWaGtRPjZXg=;
 b=Xo/XcNBWs5RuPpbkezR+ceS4bRDfkS5U27QMFkoVAPobz4UNDtEXhFhsRms5P7XaTd
 DcsgnbKCVXR1s0Q3oWHDxfN71Grf9XWfNhIQTAUREBWYWRs70DcBVwXiuvqGBv9G8cGp
 Y8t++ed47FN0PWR80muG5hXIrJHZofOuJvvy7CJLDuLpXVTS09ecrAba9OGLqf+t9ZNv
 P/WaIqItuNCBSUGS3kxKPWvuIy1I4+PAgzcqSPCcGx6/LsfueI9CEs6VcYnZaGuRpfyT
 NM1qw2aKRuBe+IzH0USFzPLebHQvtD9D//NtdtPDBWm48hwjQAYhVJzlBRkIRBfQoyKa
 JCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723626839; x=1724231639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w2jpPws4/cx/uzTsc8TuuC25ohAAYzvoRWaGtRPjZXg=;
 b=WXOjQVe+tHp1Imd1sdoQ1B+SqkNRO9YNtz9+Die4N7P/biBh9z6VIDf3Pxpd7ePfQ/
 DyfubzZMlWGFNa5t1QSFF1WxRcVF1Po7l5rGIozwGQGijTXtfnd/6WEUYw0tmXnkSRe+
 uKGVd3Wl3Btiemfjqs17+ltLIvv/11oJmv9bYQagz4bIHcycF+AmC8ui2g90HsUk204G
 TPHDOUAP7NLVMlsgfvrs/Cp+I9dlulxPtuHY3D9EBfWgZ6+EKLMxWPIDlw55VjYLqV4Y
 V/kxYQcmWYOaJTV5+iKfEHd1RvVZiTMhSgTEtkfNq/s9K94bzrHb/8TLTAZhI0BMXu3o
 S/Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUURPq/aKMzDD2DUwIdlRJs5hiXs5HcOcyzD3dyPCYP3zsz5ugS8FVt1OFofOZD2B+vTPtPWoHjG/Z//qqwubvNLCUXSQ0=
X-Gm-Message-State: AOJu0YzUpOdksKkfrn+8huz8XJqw7cnPeRwWw1ZIrwJjgjq2N5+J/a2z
 rHB1YFEKiwmBmvvveh3xXudw6a3wMxKqaXqt10d2SGuV2JaIVxALdwnrdFqFf0U=
X-Google-Smtp-Source: AGHT+IF5qliySBPSXDdd01ZZEGqtpkax6C7ody418mj7Rk/oDD6PpVl203yet9W0yU9gFYY0bn50yA==
X-Received: by 2002:a17:902:c946:b0:1fb:90e1:c8c0 with SMTP id
 d9443c01a7336-201d6541367mr21305925ad.63.1723626839022; 
 Wed, 14 Aug 2024 02:13:59 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1b8ee4sm25621185ad.195.2024.08.14.02.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 02:13:58 -0700 (PDT)
Message-ID: <ae44194c-776a-48aa-8567-c56b5e7c4167@linaro.org>
Date: Wed, 14 Aug 2024 19:13:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/15] tcg/riscv: Add support for basic vector opcodes
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-9-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813113436.831-9-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target-con-set.h |  1 +
>   tcg/riscv/tcg-target.c.inc     | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
> index d73a62b0f2..8a0de18257 100644
> --- a/tcg/riscv/tcg-target-con-set.h
> +++ b/tcg/riscv/tcg-target-con-set.h
> @@ -23,3 +23,4 @@ C_O1_I4(r, r, rI, rM, rM)
>   C_O2_I4(r, r, rZ, rZ, rM, rM)
>   C_O0_I2(v, r)
>   C_O1_I1(v, r)
> +C_O1_I2(v, v, v)
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index f60913e805..650b5eff1a 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -289,6 +289,12 @@ typedef enum {
>       OPC_VSE32_V = 0x6027 | V_SUMOP,
>       OPC_VSE64_V = 0x7027 | V_SUMOP,
>   
> +    OPC_VADD_VV = 0x57 | V_OPIVV,
> +    OPC_VSUB_VV = 0x8000057 | V_OPIVV,
> +    OPC_VAND_VV = 0x24000057 | V_OPIVV,
> +    OPC_VOR_VV = 0x28000057 | V_OPIVV,
> +    OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
> +
>       OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
>       OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
>       OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
> @@ -2158,6 +2164,21 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>       case INDEX_op_st_vec:
>           tcg_out_st(s, type, a0, a1, a2);
>           break;
> +    case INDEX_op_add_vec:
> +        tcg_out_opc_vv(s, OPC_VADD_VV, a0, a1, a2, true);
> +        break;
> +    case INDEX_op_sub_vec:
> +        tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2, true);
> +        break;
> +    case INDEX_op_and_vec:
> +        tcg_out_opc_vv(s, OPC_VAND_VV, a0, a1, a2, true);
> +        break;
> +    case INDEX_op_or_vec:
> +        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a1, a2, true);
> +        break;
> +    case INDEX_op_xor_vec:
> +        tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2, true);
> +        break;

As with load/store/move, and/or/xor can avoid changing element type.
Thus I think the vtype setup before the switch is premature.


r~

