Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D9CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVxC-0004Pb-Ft; Thu, 18 Apr 2024 13:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVx6-000449-Ky
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:53:40 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVx4-0007xF-Oc
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:53:40 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c70ef25e19so582325b6e.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713462816; x=1714067616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mbcSiwrgv0MtL78cnFJJ4ARfr4Y9GjjcXT1C15oFZRM=;
 b=QVQKQvfPaqCj/5U30AnA8nW4VeOD6bInq+hnZI96Obmwe24w2KSLeQ6isuwYXi4X5W
 ZElXYhgqyzQL/mp8bCDhZmXtkGDGCEWP6qvPLZf2Kk6/9xbOo832dEc0lyju1qRFC5pL
 xaFPOPi6Q9reIC3HsB2HORnRQYyU2EGwflXdBhyDsnw2yVRLKTVx9/1PFzE2hmtj+iMx
 PuOu7J542/AvkQWEAqejZFB6XXoCdRdcYR4BmtrcLx1jiIMFiho8Fb5HvkOBJ4vz+26c
 P/rsyyC+6cpJe4eVq2Dg5BxY7HExp0bYbelVuTv63VSg5c4hqpqCBAKdE91cigfhC8ax
 t6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713462816; x=1714067616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mbcSiwrgv0MtL78cnFJJ4ARfr4Y9GjjcXT1C15oFZRM=;
 b=Gcjg/NrkqW7KzfZ28Yeu5fXly9JePrDgDpWX0wEXrKpGfonyN/hAV+g7mrmv3uXd02
 1c+/EfvI64ub/Y33MW2l0uKIs6zbD/zmrbKfRgeIsd3b6vwDPx9k1SOiGUD8+oowPMRK
 qhG06ab+N8MJAI/XNk+wAbjSoy1Nqf5DVShBMSU45b23LeQULDbz6Q9YLxZ9P9zkGnVK
 HIlpdyZEnXD9XyukYjpl+QQul4tn7otgICHYuGJY/TPaIcW8C7uRKj98NyGShl7pb4Em
 YICRMhzg21Urulgdxljv4F+F+k0HWVOGjrU8pNzkqZXuO/yBXPCSmIMyXvWEYsnsj1t8
 ZH+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj4OFnm6gvdZ80lWDDyLYo6SLkRlxt4SgagODSAB9ftY8pDHA5aZvLRfzSCJ5XgDrK20qGGAzEcO4ebbiYe3+ZTlFgzy8=
X-Gm-Message-State: AOJu0Yyp1h40DHWRPZfSMFhQ1EZwVd2e6dElT+SK6SGz1QI8OpUub27y
 QIUCx5Nn3AGCDCWEy9hdJapU9l1wDYUt7FbmAaYJYmCyZumfQ9Ga8obUOf98kKg=
X-Google-Smtp-Source: AGHT+IHV/hGfEXQpYSyenoBFq+ttVM3EWMJXtyftbuEaZNLxhSEbXAcv134GPeG6L0G+ebPkYG/osQ==
X-Received: by 2002:a05:6808:98:b0:3c6:900:17a with SMTP id
 s24-20020a056808009800b003c60900017amr3904472oic.9.1713462815027; 
 Thu, 18 Apr 2024 10:53:35 -0700 (PDT)
Received: from ?IPV6:2604:3d08:937d:c610::fc11? ([2604:3d08:937d:c610::fc11])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a63db4e000000b005f750f36968sm1703213pgi.42.2024.04.18.10.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 10:53:34 -0700 (PDT)
Message-ID: <600a8262-ecd6-4205-bdca-c858cac538a1@linaro.org>
Date: Thu, 18 Apr 2024 10:53:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tcg: Introduce INDEX_op_plugin_pc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <20240416040609.1313605-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240416040609.1313605-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oi1-x235.google.com
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

On 4/15/24 21:06, Richard Henderson wrote:
> Add an opcode to find a code address within the current insn,
> for later use with unwinding.  Generate the code generically
> using tcg_reg_alloc_do_movi.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  1 +
>   include/tcg/tcg-opc.h       |  1 +
>   tcg/tcg-op.c                |  5 +++++
>   tcg/tcg.c                   | 10 ++++++++++
>   4 files changed, 17 insertions(+)
> 
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 009e2778c5..a32c88a182 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -76,6 +76,7 @@ void tcg_gen_lookup_and_goto_ptr(void);
>   
>   void tcg_gen_plugin_cb(unsigned from);
>   void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
> +void tcg_gen_plugin_pc(TCGv_ptr);
>   
>   /* 32 bit ops */
>   
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index 546eb49c11..087d1b82da 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -199,6 +199,7 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
>   
>   DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
>   DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
> +DEF(plugin_pc, 1, 0, 0, TCG_OPF_NOT_PRESENT)
>   
>   /* Replicate ld/st ops for 32 and 64-bit guest addresses. */
>   DEF(qemu_ld_a32_i32, 1, 1, 1,
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index eff3728622..b8ca78cbe4 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -322,6 +322,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
>       tcg_gen_op2(INDEX_op_plugin_mem_cb, tcgv_i64_arg(addr), meminfo);
>   }
>   
> +void tcg_gen_plugin_pc(TCGv_ptr arg)
> +{
> +    tcg_gen_op1(INDEX_op_plugin_pc, tcgv_ptr_arg(arg));
> +}
> +
>   /* 32 bit ops */
>   
>   void tcg_gen_discard_i32(TCGv_i32 arg)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index d248c52e96..42e2b53729 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -4701,6 +4701,13 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>       }
>   }
>   
> +static void tcg_reg_alloc_plugin_pc(TCGContext *s, const TCGOp *op)
> +{
> +    tcg_reg_alloc_do_movi(s, arg_temp(op->args[0]),
> +                          (uintptr_t)tcg_splitwx_to_rx(s->code_ptr),
> +                          op->life, output_pref(op, 0));
> +}
> +
>   /*
>    * Specialized code generation for INDEX_op_dup_vec.
>    */
> @@ -6208,6 +6215,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>           case INDEX_op_mov_vec:
>               tcg_reg_alloc_mov(s, op);
>               break;
> +        case INDEX_op_plugin_pc:
> +            tcg_reg_alloc_plugin_pc(s, op);
> +            break;
>           case INDEX_op_dup_vec:
>               tcg_reg_alloc_dup(s, op);
>               break;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

