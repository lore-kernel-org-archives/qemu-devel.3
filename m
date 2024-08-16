Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837C7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 05:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1septP-0000g7-Dw; Fri, 16 Aug 2024 01:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1septM-0000eU-FT
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:52:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1septK-0000dw-Oa
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:52:52 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7104f93a20eso1422093b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 22:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723787568; x=1724392368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+MJYb0BHKbI5OTy07NhKpPLkqDGKZ9jPE3JMfyRl1LQ=;
 b=WBk0CQGGDWznhHQHscOaVvrlxy2L6eE9+8Nrd4u01QLHgWLwRCs9xg8EWH2vSd9zS9
 I1yO1WuHxnU0nsul7k3cTWqh8erCin1p6b9BfBP5FMmSJKWSdR8g5Rb7NJ6wW+WXqtmA
 rfFUBNez6u0U0lDziw27I5/Is1j1lO3xmGvm2McN74XXKQE7CQ8J6qyLoBk+BY3z2DEI
 tbaA7rW03jX4lD11RcQTqFdYfr4Tl6o5rFl+CyLRXBjtkZUrsl11/FiGYK3cuozOpw5Y
 D07cbHIW339qLmb2Wo9KvLtFhs4i0q9g30VfYnQ2E8kjb0S6VR6+6tT2FosoNI1G9hEf
 YT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723787568; x=1724392368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+MJYb0BHKbI5OTy07NhKpPLkqDGKZ9jPE3JMfyRl1LQ=;
 b=QEkhO8xoGIOJUHvzMJssTKHf7BtJPT27FznpjEXz2Ql8G7FlEn75n6BtPyg3Ml0Wr6
 b2EIOiF/9E+TJZKAq64PC/HcWBA7XKTLU2HBaeCD1OZ/r1ZpchFy/q33THQBXrD+/8ND
 g/Q5TQWubbDWT9v60FtaSBqmj8yMgWzd4LnYKcs9dyPyWuyDbOdF3doqqjFzS0IpWNoG
 vVHVRgifY7KMyxWSTBhDwwCohN/VjtwkcYNWrsyqreaW+tjhlUyQDFc0zKhe6+20qr4p
 pdkIpw96UG7MRdkmUyEXh0ewyJ78SFVYHWksyCsE7+NVEck69Xp1xuUOwy43fD0egKrU
 N1vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTjys1sTOkkEWq0hVdG2ZR2T6eiXGkU2ZAX3SY3gscwUfe+uJrgVLtEVP4fwhHGf2ZyTOPUe0jN/U1/hgk63khwRWNiHo=
X-Gm-Message-State: AOJu0Yx4VATz2qtcmoDERmwRzhHdjIYehcdzqLYIKhtDOdKt4SrEF+XG
 KAG8hghULCifF5wWQY6l+oYTLmt4qxzodL8P6iBt7OGmYG0jJ4DDkcxw1hNPViU=
X-Google-Smtp-Source: AGHT+IEyC8v7ZjaMcFLtWbPxvrIhXxV2bcSaW2GRrTPtIDbddyLot+njBx/nrbhRuJONUKpztSlvug==
X-Received: by 2002:a05:6a20:438e:b0:1c0:e9dd:1197 with SMTP id
 adf61e73a8af0-1c904faa25bmr2539832637.22.1723787568251; 
 Thu, 15 Aug 2024 22:52:48 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:1b6b:8c7b:90f9:144f?
 (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae07562sm1916026b3a.56.2024.08.15.22.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 22:52:47 -0700 (PDT)
Message-ID: <70e86ba9-1764-4a2d-bee5-89a0b16ba385@linaro.org>
Date: Fri, 16 Aug 2024 15:52:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/16] target/riscv: add trace-hooks for each case of
 sw-check exception
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
References: <20240816010711.3055425-1-debug@rivosinc.com>
 <20240816010711.3055425-17-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816010711.3055425-17-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 8/16/24 11:07, Deepak Gupta wrote:
> Violations to control flow rules setup by zicfilp and zicfiss lead to
> software check exceptions. To debug and fix such sw check issues in guest
> , add trace-hooks for each case.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   target/riscv/helper.h                         |  3 +++
>   target/riscv/insn_trans/trans_rvi.c.inc       |  3 +++
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc |  1 +
>   target/riscv/op_helper.c                      | 13 +++++++++++++
>   target/riscv/trace-events                     |  6 ++++++
>   target/riscv/translate.c                      |  2 ++
>   6 files changed, 28 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index e946ba61fd..6e90fbd225 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -123,6 +123,9 @@ DEF_HELPER_2(cbo_zero, void, env, tl)
>   
>   /* helper to raise sw check exception */
>   DEF_HELPER_2(raise_sw_check_excep, void, env, tl)
> +/* helper functions to trace riscv cfi violations */
> +DEF_HELPER_3(zicfilp_label_mismatch, void, env, tl, tl)
> +DEF_HELPER_3(zicfiss_ra_mismatch, void, env, tl, tl)
>   
>   /* Special functions */
>   DEF_HELPER_2(csrr, tl, env, int)
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index 936b430282..7021f8d3da 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -54,6 +54,7 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
>               /*
>                * misaligned, according to spec we should raise sw check exception
>                */
> +            trace_zicfilp_unaligned_lpad_instr(ctx->base.pc_first);
>               gen_helper_raise_sw_check_excep(tcg_env,
>                   tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL));

Ah, no.

This performs the trace at translation time.
You want the trace at execution time.

     gen_update_pc(ctx, 0);
     gen_helper_zicfilp_unaligned_lpad(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;


void HELPER(zicfilp_unaligned_lpad)(CPURISCVState *env)
{
     trace_zicfilp_unaligned_lpad(env->pc);
     env->sw_check_code = RISCV_EXCP_SW_CHECK_FCFI_TVAL;
     riscv_raise_exception(RISCV_EXCP_SW_CHECK, 0);
}

etc.

Nevermind the previous advice vs patch 5 saying you could inline everything; I had 
forgotten the desire for tracepoints.

You should probably add these helpers and tracepoints as you add the code.  Anything else 
is going to be a bit confusing.


r~

