Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9684C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9T7-00080g-AB; Tue, 12 Mar 2024 17:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk9Sw-00080A-A1
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:15:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk9St-0007lg-Ok
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:15:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e6a9fafacdso770135b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710278112; x=1710882912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7hN+E7bIVFDzzeY8dEklh2xJ6fzhqJN325jyX8VRJxQ=;
 b=Oo8yL8s2QLxC3odJxsq57GP+hUIkz/KnpVo504l7cU5ZsHJnDQkcYxRlkScN1Y19Gq
 1zwgqHxC52sM6FZfopmXPrwvMjhq+LuiyH4b+uddBnF4UBeyMbWXgBd/lra604mIn3K0
 GFStwXu7WqkQmwwh1X3W2CsMyVmZ3r2jL0PBJ766RqE50PBf5aHaOc5cPgS9yM9qyM8p
 e0INZY8PQAcDew+aAoek0Cw6atCsEPvJI/SOSYQuORa65OFrSTYJ0M3FwgcbJ7iErUHM
 EutNp+Icdf7TCIEi7z6AYpIUzYWKLtFhNm2isxQ89sgoe/iD/U5yCH7vzha3MX1EW4LE
 0ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710278112; x=1710882912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7hN+E7bIVFDzzeY8dEklh2xJ6fzhqJN325jyX8VRJxQ=;
 b=jzf0TRg0cRN7afUlZ+g2W6ii14dTvlojNqKvSZugoIRzlq78jzRLPVitHdZ7CyGEPl
 AOsiQpY/sUgIeFf+alfZLX9BmNkvJSNTHvGSBFOjQhyRjJ0JZBEzCYOsEh85p3WMOBpF
 goP+DJLLDHIVSBdhKy2st5VixCEAOXpuVyazM/jMJflziFLoU7ixPWt+DzU1LqrX/Bkp
 5WhtyPVKi0/h46sjZp8BdBRHO/YeIw59VBz/Js32oXDPAZ5gKT7atPeipqTbmt92d1RT
 izjJnOCxn4srpd5J8HBSGYyrU2ohprjO//Tm3MeegxKdgRIAHENkycsKZkEVUnctphZY
 Db3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNEtFGZCqPkoSREHfrLZu0E+ipOlTx/1Dbh16EIIcJ3p55R92yS8WTkgOMshtnygl+91k/n2sbPjofHEqRvJszfLnmosU=
X-Gm-Message-State: AOJu0Yyh5BHGNELHPg6gnJCTWpIHwcYFVVXiRp8t+lnM7P+qP60Jx+h2
 YdWYkgXoAxYPG9NlzxLkJY/HEQ+rWcWpOO5kVqmqUPEk79hzJ3jeFFnMkMY5VnY=
X-Google-Smtp-Source: AGHT+IGDZaBS4V/WO6ViNTSIgKll97joaGEQ58yojWEz143FSmIasE90bmTYvyJChNveaIal2kjAZA==
X-Received: by 2002:a05:6a00:c90:b0:6e6:9560:f113 with SMTP id
 a16-20020a056a000c9000b006e69560f113mr689097pfv.3.1710278112366; 
 Tue, 12 Mar 2024 14:15:12 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 a2-20020aa780c2000000b006e091a254adsm6572190pfn.30.2024.03.12.14.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 14:15:11 -0700 (PDT)
Message-ID: <24e8c6ce-589b-44d3-92e1-887916aff709@linaro.org>
Date: Tue, 12 Mar 2024 11:15:08 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] plugins: add new inline op STORE_U64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240312075428.244210-1-pierrick.bouvier@linaro.org>
 <20240312075428.244210-3-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312075428.244210-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 3/11/24 21:54, Pierrick Bouvier wrote:
> +static void gen_empty_inline_cb_store_u64(void)
> +{
> +    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
> +    TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
> +    TCGv_i64 val = tcg_temp_ebb_new_i64();
> +    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
> +
> +    tcg_gen_ld_i32(cpu_index, tcg_env,
> +                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
> +    /* second operand will be replaced by immediate value */
> +    tcg_gen_mul_i32(cpu_index, cpu_index, cpu_index);
> +    tcg_gen_ext_i32_ptr(cpu_index_as_ptr, cpu_index);
> +    tcg_gen_movi_ptr(ptr, 0);
> +    tcg_gen_add_ptr(ptr, ptr, cpu_index_as_ptr);
> +
> +    tcg_gen_movi_i64(val, 0);
> +    tcg_gen_st_i64(val, ptr, 0);
> +
> +    tcg_temp_free_ptr(ptr);
> +    tcg_temp_free_i64(val);
> +    tcg_temp_free_ptr(cpu_index_as_ptr);
> +    tcg_temp_free_i32(cpu_index);
> +}

I was never fond of this full pattern generate...

> @@ -352,6 +385,20 @@ static TCGOp *copy_st_i64(TCGOp **begin_op, TCGOp *op)
>       return op;
>   }
>   
> +static TCGOp *copy_mov_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
> +{
> +    if (TCG_TARGET_REG_BITS == 32) {
> +        op = copy_op(begin_op, op, INDEX_op_mov_i32);
> +        op->args[1] = tcgv_i32_arg(TCGV_LOW(tcg_constant_i64(v)));
> +        op = copy_op(begin_op, op, INDEX_op_mov_i32);
> +        op->args[1] = tcgv_i32_arg(TCGV_HIGH(tcg_constant_i64(v)));
> +    } else {
> +        op = copy_op(begin_op, op, INDEX_op_mov_i64);
> +        op->args[1] = tcgv_i64_arg(tcg_constant_i64(v));
> +    }
> +    return op;
> +}

... followed by pattern match and modify.  I think adding more of this is fragile, and a 
mistake.

(1) This encodes knowledge of the order of the parts of a mov_i64 for 32-bit host.
(2) You shouldn't use TCG_LOW/HIGH of tcg_constant_i64, but two separate calls to 
tcg_constant_i32 with the parts of @v.

But all of this would be easier if we simply generate new code now, instead of copy.

> +static TCGOp *append_inline_cb_store_u64(const struct qemu_plugin_dyn_cb *cb,
> +                                       TCGOp *begin_op, TCGOp *op,
> +                                       int *unused)
> +{
> +    char *ptr = cb->inline_insn.entry.score->data->data;
> +    size_t elem_size = g_array_get_element_size(
> +        cb->inline_insn.entry.score->data);
> +    size_t offset = cb->inline_insn.entry.offset;
> +    op = copy_ld_i32(&begin_op, op);
> +    op = copy_mul_i32(&begin_op, op, elem_size);
> +    op = copy_ext_i32_ptr(&begin_op, op);
> +    op = copy_const_ptr(&begin_op, op, ptr + offset);
> +    op = copy_add_ptr(&begin_op, op);
> +    op = copy_mov_i64(&begin_op, op, cb->inline_insn.imm);
> +    op = copy_st_i64(&begin_op, op);

You'd also be able to fold offset into the store.  This would allow the scoreboard address 
to be entered once into the constant pool and have multiple uses.


r~

