Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52537CD4F59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 07:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm6fT-0004eh-Gl; Thu, 05 Sep 2024 03:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm6fS-0004dj-24
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 03:12:34 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm6fQ-0004YD-Eu
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 03:12:33 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d89229ac81so327457a91.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 00:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725520351; x=1726125151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gOoqPJ1a4zZI7BzNUw33JsARdorD+42DRWxVBZI+SFc=;
 b=FBxFWQtMTxm8n4Q7wQYzMJQF0flr0ykiHroL4CHAeBDrFifIUVH8NAOi0HESKZcqzK
 G6paLGQL+2pAjMPR6TQU7gubDULKf/yF07zE5+lEJMIUJVOmEnWwAwT+OhqlX6WnR4Dz
 FN9fFiEx+wA95wgPOcPJ+GtqPIF+Nm1+lJTZCntwvHn4T3w1Oj2v5PMOOvH6KMmi668Q
 czEX2MR6BeRV4bQ3OdN8H3UjKrE/Vriu6ATZYSwl54g5k9l5UrSy+gee5+KRwz9O84Ig
 ubkI4zn8T6nAouj43S/uqzmsEthHbPTczXAfuVN+mhv6H4UE3QDGqgGN8AWkoTlKW4dZ
 0ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725520351; x=1726125151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gOoqPJ1a4zZI7BzNUw33JsARdorD+42DRWxVBZI+SFc=;
 b=TXLN+lhNCvBqdB/MJMuIzVAFQuEuIfHJUpiBBCV68tKNnitSj4FUZSiJ2UBsGXhK6Y
 nHDaLEx+pywc+AUGAnH4g1HL6AXYgw30Xb9MteGv/ITASxBuWbUYH32U+CzRHWzOXGgT
 DhLLM+kzKMZWvBZif8d/XGByuNPUz1hrJefPBqvH/q0IvjUDlC20Sk6RnE9Q3SMXItEe
 bPduYulfQRzUOwqtZGRcxFtHzWn1yM22HrOG7nb7qgbgthZHYht2QvuJfMzcZfBPaYVw
 x/2YlKj64nxSgPAji7ME2YBO1QPDi1jiOuecEV0bpBjnrBfF23ROctobbg7m1G/tybZJ
 ub1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMIE34dSWu1ZQNIoRqt57jS0gH5P2iakKRmHj+G8CESnty4IrKdDxf1m1WNNi3oN4LVfEFJhedcNlf@nongnu.org
X-Gm-Message-State: AOJu0YzIGZivbx7BledIaULbHpCqimc8nlKxgghCp1RxzlkqjgvhtGMP
 aDi3d22b+h/CBozdMW+I7wF1LCTxsBPwoYnP75YnEAaw25h1BiJmmMflETB47do=
X-Google-Smtp-Source: AGHT+IG+d4pz0kS7bfVku0/TWRhOM0wdN9c3LLaCni1ZfWPhPZFPdlmgU1ajKgRey5G8wuaViifCcA==
X-Received: by 2002:a17:90b:1802:b0:2d3:cc31:5fdc with SMTP id
 98e67ed59e1d1-2da7482c200mr8238174a91.5.1725520350495; 
 Thu, 05 Sep 2024 00:12:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2da509e97e3sm6099854a91.19.2024.09.05.00.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 00:12:29 -0700 (PDT)
Message-ID: <9d40d3f4-731d-478f-81ba-1c380ef9d0ae@linaro.org>
Date: Thu, 5 Sep 2024 00:12:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] tcg/riscv: Implement vector cmp ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-9-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240904142739.854-9-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 9/4/24 07:27, LIU Zhiwei wrote:
> @@ -2322,6 +2411,51 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>           riscv_set_vec_config_vl(s, type);
>           tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1, true);
>           break;
> +    case INDEX_op_cmpsel_vec:
> +        TCGArg a3, a4;
> +        int c3, c4;
> +        TCGCond cond;

While I suppose this compiles, it's not great to have new variables added randomly within 
a switch.  At minimum, add { } around the block, but consider breaking out a separate 
tcg_out_cmpsel function, akin to tcg_out_movcond et al.

> @@ -2332,10 +2466,27 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>   void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
>                          TCGArg a0, ...)
>   {
> +    va_list va;
> +    TCGv_vec v0, v1;
> +    TCGArg a2, a3;
> +
> +    va_start(va, a0);
> +    v0 = temp_tcgv_vec(arg_temp(a0));
> +    v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
> +    a2 = va_arg(va, TCGArg);
> +
>       switch (opc) {
> +    case INDEX_op_cmp_vec:
> +        a3 = va_arg(va, TCGArg);
> +        vec_gen_6(INDEX_op_cmpsel_vec, type, vece, tcgv_vec_arg(v0),
> +                    tcgv_vec_arg(v1), a2,
> +                    tcgv_i64_arg(tcg_constant_i64(-1)),
> +                    tcgv_i64_arg(tcg_constant_i64(0)), a3);
> +        break;
>       default:
>           g_assert_not_reached();
>       }
> +    va_end(va);
>   }

Better to use "TCGArg a0, a1".  Converting through arg_tmp + temp_tcgv_vec to v0/v1 and 
then undoing that with tcgv_vec_arg is confusing.


r~

