Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB299C531DE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ser2t-0000eF-Ko; Fri, 16 Aug 2024 03:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1ser2m-0000Su-3S
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:06:40 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1ser2j-00022d-CD
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:06:39 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-201fae21398so8110215ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723791995; x=1724396795;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xRU+5Nf9Pu4LJArUVSD6RBlibUDf6dTZ4t+zd9+TE6I=;
 b=InhzHso49vwutlknz9h7/ghxQ5eegsPs02PfVmC3k+2BCoM7JZUtklUGXZKzhPA8Fb
 dkBGLsFgHF49HZ1yxnbL7R0su3gzHh3CLoDlWvhCgAVc86dgehay7R2FEwNGSRVxmYW7
 R2DOYuFxv004hBDdjhrqENyuyeAJP9zB5WLJvJXnm0t5wO/Lasp0yI5w679icdkLCKd9
 UT5M1SCe+6P81RBQbS5bmTS6ftodin7rS92r01O8cogkviQ4DgxMM9LetLFaIoRXithd
 d9HQKRspsIxXkAQogOhqDu6Glyf3nzGo7Fsj+G5UtCGJcXhf2+bsd865ZO8wLaJ7GKxD
 Ai0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723791995; x=1724396795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRU+5Nf9Pu4LJArUVSD6RBlibUDf6dTZ4t+zd9+TE6I=;
 b=sUxWRj6Cz7HohtB97ru4aG4O8/Y/ORhA4xPo42AO83NX/w/C3KAuIY/I11c+mtN+cM
 RHKWdNZZbjHvJljXa74akkgdGZFGpvmCNqWI6d91mz97k2iisMRcOnZN5J9ssH7wuTT+
 wTBNJ+KGreFk2aNRoclPRUoujlf2r1CM4SGlUNghSi+PkeNvyOM8dYKpgTmb5Mc47kQv
 asWrIsZP+aLxriyUI6wz/N5jBHfhrWfbF/RRKdkFZlYj77g3rg0SGsxvzLh6P/8xr1JM
 FJKwMgvIMZPCBuvEvuRfG5QcbKqUxdUmM6TqJcevW/wbHFEFIw6ZlJ+fQKxMcKICfxiq
 kKUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp1x0pU/X3aH2G1CvyhQRNXxMwYMGpbdHHbe/C0C5AI47C4Lf2nv+is+yakiUpCV8vaTtDCdreWDNy/Hu8qlD1KaX3nDo=
X-Gm-Message-State: AOJu0Yxiwn0isILx0gzXE2qbxnGN6MxPaZC3j+obi+AJ4t8ruogRtAQm
 xr8jaJn5XgMLWtWruPd5nY9QkTr7zEvVKykWqTW+fnONY585rIKbK6KpXYgfFVc=
X-Google-Smtp-Source: AGHT+IG2/j9sEh16l66MuZVe+bS6ByutthICRsPOZ+dO6D1onL+d/LyTr5APKFYa4ggr9u8qP852RA==
X-Received: by 2002:a17:903:247:b0:1fd:92a7:6ccc with SMTP id
 d9443c01a7336-20203ec1b8cmr26825795ad.30.1723791995186; 
 Fri, 16 Aug 2024 00:06:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f0319755sm19860105ad.65.2024.08.16.00.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 00:06:34 -0700 (PDT)
Date: Fri, 16 Aug 2024 00:06:32 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
Subject: Re: [PATCH v4 16/16] target/riscv: add trace-hooks for each case of
 sw-check exception
Message-ID: <Zr76eGu0ELFGx8Pi@debug.ba.rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
 <20240816010711.3055425-17-debug@rivosinc.com>
 <70e86ba9-1764-4a2d-bee5-89a0b16ba385@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <70e86ba9-1764-4a2d-bee5-89a0b16ba385@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 16, 2024 at 03:52:34PM +1000, Richard Henderson wrote:
>On 8/16/24 11:07, Deepak Gupta wrote:
>>Violations to control flow rules setup by zicfilp and zicfiss lead to
>>software check exceptions. To debug and fix such sw check issues in guest
>>, add trace-hooks for each case.
>>
>>Signed-off-by: Jim Shu <jim.shu@sifive.com>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  target/riscv/helper.h                         |  3 +++
>>  target/riscv/insn_trans/trans_rvi.c.inc       |  3 +++
>>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  1 +
>>  target/riscv/op_helper.c                      | 13 +++++++++++++
>>  target/riscv/trace-events                     |  6 ++++++
>>  target/riscv/translate.c                      |  2 ++
>>  6 files changed, 28 insertions(+)
>>
>>diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>>index e946ba61fd..6e90fbd225 100644
>>--- a/target/riscv/helper.h
>>+++ b/target/riscv/helper.h
>>@@ -123,6 +123,9 @@ DEF_HELPER_2(cbo_zero, void, env, tl)
>>  /* helper to raise sw check exception */
>>  DEF_HELPER_2(raise_sw_check_excep, void, env, tl)
>>+/* helper functions to trace riscv cfi violations */
>>+DEF_HELPER_3(zicfilp_label_mismatch, void, env, tl, tl)
>>+DEF_HELPER_3(zicfiss_ra_mismatch, void, env, tl, tl)
>>  /* Special functions */
>>  DEF_HELPER_2(csrr, tl, env, int)
>>diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
>>index 936b430282..7021f8d3da 100644
>>--- a/target/riscv/insn_trans/trans_rvi.c.inc
>>+++ b/target/riscv/insn_trans/trans_rvi.c.inc
>>@@ -54,6 +54,7 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
>>              /*
>>               * misaligned, according to spec we should raise sw check exception
>>               */
>>+            trace_zicfilp_unaligned_lpad_instr(ctx->base.pc_first);
>>              gen_helper_raise_sw_check_excep(tcg_env,
>>                  tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL));
>
>Ah, no.
>
>This performs the trace at translation time.
>You want the trace at execution time.
>
>    gen_update_pc(ctx, 0);
>    gen_helper_zicfilp_unaligned_lpad(tcg_env);
>    ctx->base.is_jmp = DISAS_NORETURN;
>
>
>void HELPER(zicfilp_unaligned_lpad)(CPURISCVState *env)
>{
>    trace_zicfilp_unaligned_lpad(env->pc);
>    env->sw_check_code = RISCV_EXCP_SW_CHECK_FCFI_TVAL;
>    riscv_raise_exception(RISCV_EXCP_SW_CHECK, 0);
>}
>

facepalm on me. sorry.

>etc.
>
>Nevermind the previous advice vs patch 5 saying you could inline 
>everything; I had forgotten the desire for tracepoints.

It helps locate finding control flow violations faster and fix such
issues in libc, libraries, and other pieces of software faster.

So desire is basically fixing guest software faster.

>
>You should probably add these helpers and tracepoints as you add the 
>code.  Anything else is going to be a bit confusing.

Or I can just drop this for now for upstreaming purpose. I'll think about it.
>
>
>r~

