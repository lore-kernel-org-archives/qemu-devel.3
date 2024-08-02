Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A523C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZlDl-0005ic-FA; Fri, 02 Aug 2024 01:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZlDj-0005he-Vp
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:52:55 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZlDi-0004zO-9B
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:52:55 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc65329979so66821605ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 22:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722577973; x=1723182773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bY7BVRfBqy6iYMMzmN5KLGNncvw44+7/dKhAArB4df0=;
 b=LSl2scN1RQEaSQvo9yUm5pKLQtBJXFUEWQ4/z5jBXrhY0setBp5J95K0LEgn4Gp3Bu
 V0UgnAOkz6RFA2i269aLJAoQWtDqyQgaFvkqeqemffnIj8WFw4wwIGiIZvyoFpx1LqOZ
 gNfL9VWVlJQecW5VrGh5vNQDxRJHvB/LOenwjDS6BkYMVbbpFKTIWkB4F2NjmVvRmTyY
 FiKSi6SMn/dAwaJQfq/wV8wx6H2GdeLUxIQ3LDuX7lDhQOT93hzSqD3dviGf/tdauiIa
 PiEvIpK8zRguRttlOjewM+3vouy8hd56MyAFAe68ZRcIDKeV3PLnS8k/4Ye0sqFnxKM+
 vhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722577973; x=1723182773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bY7BVRfBqy6iYMMzmN5KLGNncvw44+7/dKhAArB4df0=;
 b=arifbh9Kg5PnZ3lH37FV9JfbWa2ovbCVcWbJPhKKS8LwHICvP6ZB4VTlp2FNcXmBOp
 TeZI2G5PPWGUGCCrD3NejEGp9FsYiNK1p4rKXUNT3NQ+qin1mGhCcy4/sXEsLiQgW9UF
 oWsBKTQkJ6nw6F8sQZ1qJqcXlcFsdJX5Njoc3qVcD43baib6Zam1jH9+bAL8poQQjWiU
 Q7n+gfpe2jdBvGZSB4nsYkyn/YokgxKZXyzlVQRJfwx0XLhBvTIaew8D5dbeBYGpUeIG
 N0q50AVINRC7RIDYI4N1JNVEt38Vhign8bG9vkcMBwyo/1s8k+hLBNX4F6PCws77NrI7
 uN3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU326doPDlxcO6I2bhp+Sgsjyd59jOTDjn6rDfBVpyCkD4BAlqVtNvP1z6EeddKEpNmtRh88l3Ebo1pAHq805ezSWNx95s=
X-Gm-Message-State: AOJu0YxRneh4XTz4BLrZW4xvsLTfKf/x6p97qQ8EG09Jb3nRMMYSExkT
 3+B6fMSXsRenhfqi5dM8BBYWPbAKMDhWdr3X6jxUH/MmIBfyo8YlQcKIbQMZ0l8=
X-Google-Smtp-Source: AGHT+IGENa6GmRyUU9QT6ZvD2PgZXOke1fAUS8usczqiNS/q43dZDJ2L/KAHNJtd/XB7ecmoPbPszA==
X-Received: by 2002:a17:902:da82:b0:1fd:791d:1437 with SMTP id
 d9443c01a7336-1ff5722da46mr34681355ad.6.1722577972572; 
 Thu, 01 Aug 2024 22:52:52 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592b659asm8509315ad.301.2024.08.01.22.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 22:52:52 -0700 (PDT)
Message-ID: <05d5a772-a7b9-4bfd-8ca0-f85dcf2d1505@linaro.org>
Date: Fri, 2 Aug 2024 15:52:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/riscv: Relax fld alignment requirement
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
 <20240802031612.604-4-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802031612.604-4-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/2/24 13:16, LIU Zhiwei wrote:
> According to the risc-v specification:
> "FLD and FSD are only guaranteed to execute atomically if the effective
> address is naturally aligned and XLEN≥64."
> 
> We currently implement fld as MO_ATOM_IFALIGN when XLEN < 64, which does
> not violate the rules. But it will hide some problems. So relax it to
> MO_ATOM_NONE.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/insn_trans/trans_rvd.c.inc | 26 ++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
> index dbe508c7e0..458d7db745 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -48,12 +48,20 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>       REQUIRE_EXT(ctx, RVD);
>   
>       /*
> -     * Zama16b applies to loads and stores of no more than MXLEN bits defined
> -     * in the F, D, and Q extensions. Otherwise, it falls through to default
> -     * MO_ATOM_IFALIGN.
> +     * FLD and FSD are only guaranteed to execute atomically if the effective
> +     * address is naturally aligned and XLEN≥64.
>        */
> -    if ((ctx->misa_mxl_max >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
> -        memop |= MO_ATOM_WITHIN16;
> +    if (ctx->misa_mxl_max >= MXL_RV64) {
> +        /*
> +         * Zama16b applies to loads and stores of no more than MXLEN bits
> +         * defined in the F, D, and Q extensions. Otherwise, it falls through
> +         * to default MO_ATOM_IFALIGN.
> +         */
> +        if (ctx->cfg_ptr->ext_zama16b) {
> +            memop |= MO_ATOM_WITHIN16;
> +        }
> +    } else {
> +        memop |= MO_ATOM_NONE;
>       }

Does this really have byte atomicity, not atomic on two aligned 32-bit loads (which would 
be MO_ATOM_IFALIGN_PAIR).

It's probably clearer to fill out the if-tree completely,
rather than explain about defaults.

     if (get_mxl(ctx) == MXL_RV32) {
         memop |= MO_ATOM_NONE;
     } else if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     } else {
         memop |= MO_ATOM_IFALIGN;
     }


r~

