Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BF5C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbn4F-00053P-PO; Wed, 07 Aug 2024 16:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbn4E-00051p-7D
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:15:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbn4C-0005YL-Bz
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:15:29 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7104f93a20eso252690b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723061727; x=1723666527;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dv8Q8zJNufcMD0SP1Ns80xAYm2XIuILAGRpI7LbzelQ=;
 b=WdwDXZw9PGfIwKMuYwfQprAjravAnyWU0oPL7tSCHUCdtEfp3KA+A762X1HdHiUQtc
 cNfgOgjRpQHQXq6BUNh563RvejAEjy8wNemrbIi9m6W5W9cHm4hFSz7REbFwhmWBIzNq
 7thQklLWnOMqKiTZhh8ltLG0fyTblsQLdMhRRhKgdi3hEU3WfGLpz9CajjmKqf3uBSHt
 0ZGhl5ZXr78nc/kJnUTzo/N8MdSulKHUzR+oxMiR21GTYnCg+NOYjEjEtHTo96jDAWWp
 wxj91mwd44uaPi5DnN7uwnXHyDexTv2/5ODh0zRwbyyWs8rj1woUi84owuRxVGfiXpbS
 krfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723061727; x=1723666527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dv8Q8zJNufcMD0SP1Ns80xAYm2XIuILAGRpI7LbzelQ=;
 b=iaTjrYsMjxdHqcwqNCx5MFE1uFUAeWBvlzKH93ivxtrnlHbDl7qJgUf8GmG1xO2Uwl
 bD3LkFPHMCor4xqeLvueB0wX2MmqnkUNZF9hzVoHdsz5DMXqAQYOGDD8heL4s5WqzeUx
 MJX0nrpvyWJdgfzz1ahrR0UOW1ujiWlpAAFSM8W7ynnTcKyhn/IgPjq4xNCjCJA0gR2V
 L1BCwsjDCsyJOAY3i41aLfOfoSRvr7N8DjJXDaYe5MlD7IfYOqkkj0zazOHsvc9TiQWc
 BmC09mX3Wi+yPigb1cEmXmUXFRg0SUrE8KmTcA2/oiCrL7kE41BxAZmwASbAoZQVFGYn
 8F0A==
X-Gm-Message-State: AOJu0YzmEFRVGro6SmcRkSZL4PmpFYMafXvYatLVYqhTTf60E9RUsLVb
 e5KMbzyCggyEAOy01BwIGOW0xp2u3bY8SyLfcuXc2OT9892z7helRA2n8TJLdWQ=
X-Google-Smtp-Source: AGHT+IH94gUyD6cT9gTCv67nLcHO9CbCSG+WLL3Bv08qGvYg3/hUR6G1OEcyPa9kJa4XbJRBbvQpmQ==
X-Received: by 2002:a05:6a20:a106:b0:1c0:f675:ed08 with SMTP id
 adf61e73a8af0-1c699550c1bmr21596768637.6.1723061726481; 
 Wed, 07 Aug 2024 13:15:26 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b3b3f336sm1985146a91.44.2024.08.07.13.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 13:15:26 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:15:24 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Jim Shu <jim.shu@sifive.com>,
 Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v3 06/20] target/riscv: tracking indirect branches (fcfi)
 for zicfilp
Message-ID: <ZrPV3LPERjjbR7pA@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-7-debug@rivosinc.com>
 <89e5857e-fc00-46c1-b797-1fadcf463a1e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <89e5857e-fc00-46c1-b797-1fadcf463a1e@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 07, 2024 at 11:23:00AM +1000, Richard Henderson wrote:
>On 8/7/24 10:06, Deepak Gupta wrote:
>>diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>index 364f3ee212..c7af430f38 100644
>>--- a/target/riscv/cpu_helper.c
>>+++ b/target/riscv/cpu_helper.c
>>@@ -134,6 +134,19 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>>          flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
>>      }
>>+    if (cpu_get_fcfien(env)) {
>>+        /*
>>+         * For Forward CFI, only the expectation of a lpcll at
>>+         * the start of the block is tracked (which can only happen
>>+         * when FCFI is enabled for the current processor mode). A jump
>>+         * or call at the end of the previous TB will have updated
>>+         * env->elp to indicate the expectation.
>>+         */
>>+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED,
>>+                           env->elp != NO_LP_EXPECTED);
>
>A good example why it's better to store this as bool in the first place.
>
>>  static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
>>  {
>>+    DisasContext *ctx = container_of(db, DisasContext, base);
>>+
>>+    if (ctx->fcfi_lp_expected) {
>>+        /*
>>+         * Since we can't look ahead to confirm that the first
>>+         * instruction is a legal landing pad instruction, emit
>>+         * compare-and-branch sequence that will be fixed-up in
>>+         * riscv_tr_tb_stop() to either statically hit or skip an
>>+         * illegal instruction exception depending on whether the
>>+         * flag was lowered by translation of a CJLP or JLP as
>>+         * the first instruction in the block.
>>+         */
>>+        TCGv_i32 immediate;
>>+        TCGLabel *l;
>>+        l = gen_new_label();
>>+        immediate = tcg_temp_new_i32();
>>+        tcg_gen_movi_i32(immediate, 0);
>>+        cfi_lp_check = tcg_last_op();
>>+        tcg_gen_brcondi_i32(TCG_COND_EQ, immediate, 0, l);
>>+        gen_helper_raise_sw_check_excep(tcg_env,
>>+            tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
>>+            tcg_constant_tl(MISSING_LPAD), tcg_constant_tl(0));
>>+        gen_set_label(l);
>>+        /*
>>+         * Despite the use of gen_exception_illegal(), the rest of
>>+         * the TB needs to be generated. The TCG optimizer will
>>+         * clean things up depending on which path ends up being
>>+         * active.
>>+         */
>>+        ctx->base.is_jmp = DISAS_NEXT;
>>+    }
>>  }
>
>Again, don't do this here.
>There is a reason why only DISAS_NEXT is legal: plugins.
>You *must* do this in riscv_tr_translate_insn, like ARM.

Sorry missed this. I remember you gave same feedack in last version.

>
>
>r~

