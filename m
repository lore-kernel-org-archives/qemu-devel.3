Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F550C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 00:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgwAA-0003d9-Ff; Wed, 21 Aug 2024 20:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgwA4-0003EG-J0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 20:58:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgwA2-0006cS-37
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 20:58:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20219a0fe4dso2668885ad.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 17:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724288324; x=1724893124;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FZ9mNzRXXo3H0Kel66ss5wgv4zjyYOwEZC5qpxYmQv4=;
 b=uaUmZHMIkz8npz8Ti1WWzdljry6fV7aZmvmpgCuau6bp6b4Qjb417m/kHcvkhzI8On
 44pxyrZg/3j5Ec6QFJi3dfxw5bD7jwcPsqXL2ekDZjRb4erEwrKHPBiKk/bHVLSfyJFM
 4vx/b5+l8DBM2Lfx3rMI6+yaEe+FG31U6ICoxWm8NFHwlxC4JKygPgGaMs56hcHfO25p
 jrKhzrKfo3ePevxsLwlHUUjt9Y6bPJE29XgsPNEzqgVud0Peau4pkbj8Kr9hKGSWakJ5
 yOhmYosy4QWP5C1QHaAwtfkWdezUvj1o2WqcZaQOR4DgaiQ8ELCxwJjjb64jrG8iGjmk
 5hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724288324; x=1724893124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZ9mNzRXXo3H0Kel66ss5wgv4zjyYOwEZC5qpxYmQv4=;
 b=VMe14Z+mhY+u0GbMu6GC6nyN5APWD3vn3wJ8a9XY5GyCHVElsT+jihAwhJpTtWm/Wt
 fSlnFdbFTxA+1LhSKYZBB5uC83tuCDyIE7TP1v/pyBVI2RCiMbmsMC9U0T4QrarEJymg
 0LivfkUIQC66f80qPNdqKAfvFPqxA43Bg3lbCeQc6RgeQMoQu/mgjGj8LKx1p852NkkN
 k8c5XvfW0BW2rrcdkf6k09EpuWXZaZrzdjLpodMmzA0uETS2mKQNRyDM6BpJ7+ypcQvz
 GBSXGATuI1f9mLutB+9hsGFdNTfEqp4WZHpx5I+/5FDOmsFSiOKP83XHBid+jRbPZf/u
 xLYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbziIST1kpd4q/PxeMrW+5RhMqH0Nz9OsIz7tLg6KxAG5oUsID7YUihKsQp56lPo1LuSdNXYMKhcDx@nongnu.org
X-Gm-Message-State: AOJu0Yzrvn0VbDhtPZSR0SsWtQYOiXUHYMga5/tJjchLjaBEFl6tftt4
 Qf9Ric1AZeMcJsyLuhS/fQTWJJ9MmeiHVxTqleEPB37+3qtdQ/2YTSEc0Bzg4Bs=
X-Google-Smtp-Source: AGHT+IFbdjFTIWaGURgm1m+PY9G11gjeCca3kPG+rHtvOs5Npr7yZFN6k6hlPIetgMWZAYLWzwlvww==
X-Received: by 2002:a17:902:d4c6:b0:202:4079:1c19 with SMTP id
 d9443c01a7336-20367c07defmr40878535ad.14.1724288323363; 
 Wed, 21 Aug 2024 17:58:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385fcff06sm1859455ad.308.2024.08.21.17.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 17:58:43 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:58:41 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v6 12/16] target/riscv: AMO operations always raise
 store/AMO fault
Message-ID: <ZsaNQcdSJM9lSVoX@debug.ba.rivosinc.com>
References: <20240821215014.3859190-1-debug@rivosinc.com>
 <20240821215014.3859190-13-debug@rivosinc.com>
 <fbe42e3d-0622-46b4-93eb-ddb13bd4814f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fbe42e3d-0622-46b4-93eb-ddb13bd4814f@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x633.google.com
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

On Thu, Aug 22, 2024 at 10:43:05AM +1000, Richard Henderson wrote:
>On 8/22/24 07:50, Deepak Gupta wrote:
>>@@ -1779,13 +1780,25 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>              env->pc += 4;
>>              return;
>>          case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
>>+            if (always_storeamo) {
>>+                cause = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
>>+            }
>>+            goto load_store_fault;
>>          case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
>>          case RISCV_EXCP_LOAD_ADDR_MIS:
>>          case RISCV_EXCP_STORE_AMO_ADDR_MIS:
>>          case RISCV_EXCP_LOAD_ACCESS_FAULT:
>>+            if (always_storeamo) {
>>+                cause = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
>>+            }
>>+            goto load_store_fault;
>>          case RISCV_EXCP_STORE_AMO_ACCESS_FAULT:
>>          case RISCV_EXCP_LOAD_PAGE_FAULT:
>>          case RISCV_EXCP_STORE_PAGE_FAULT:
>>+            if (always_storeamo) {
>>+                cause = RISCV_EXCP_STORE_PAGE_FAULT;
>>+            }
>>+        load_store_fault:
>
>These case labels need to be re-sorted;

Yeah it looks ugly but I didn't know what's expected. I'll sort cases.

>you're mising load/store when you're intending to check for load alone.  

I didn't get this.

>I expect LOAD_ADDR_MIS  needs adjustment as well?

Hmm atleast for shadow stack, spec says never raise misaligned and raise
access fault. Not sure what's the behavior for Atomic memory operations.

>
>>diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>>index d44103a273..8961dda244 100644
>>--- a/target/riscv/translate.c
>>+++ b/target/riscv/translate.c
>>@@ -121,6 +121,7 @@ typedef struct DisasContext {
>>      bool fcfi_lp_expected;
>>      /* zicfiss extension, if shadow stack was enabled during TB gen */
>>      bool bcfi_enabled;
>>+    target_ulong excp_uw2;
>>  } DisasContext;
>>  static inline bool has_ext(DisasContext *ctx, uint32_t ext)
>>@@ -144,6 +145,9 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
>>  #define get_address_xl(ctx)    ((ctx)->address_xl)
>>  #endif
>>+#define SET_INSTR_ALWAYS_STORE_AMO(ctx) \
>>+    (ctx->excp_uw2 |= RISCV_UW2_ALWAYS_STORE_AMO)
>>+
>>  /* The word size for this machine mode. */
>>  static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
>>  {
>>@@ -214,6 +218,12 @@ static void decode_save_opc(DisasContext *ctx)
>>      assert(!ctx->insn_start_updated);
>>      ctx->insn_start_updated = true;
>>      tcg_set_insn_start_param(ctx->base.insn_start, 1, ctx->opcode);
>>+
>>+    if (ctx->excp_uw2) {
>>+        tcg_set_insn_start_param(ctx->base.insn_start, 2,
>>+                                 ctx->excp_uw2);
>>+        ctx->excp_uw2 = 0;
>>+    }
>
>I really don't think having data on the side like this...

Ok.

>
>>  }
>>  static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
>>@@ -1096,6 +1106,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
>>          mop |= MO_ALIGN;
>>      }
>>+    SET_INSTR_ALWAYS_STORE_AMO(ctx);
>>      decode_save_opc(ctx);
>
>... or the requirement for ordering of two function calls is a good interface.
>
>I did say perhaps add another helper, but what I expected was
>
>    decode_save_opc_set_amo_store(ctx);
>
>where decode_save_opc and decode_save_opc_set_amo_store call into a common helper.
>But perhaps in the end maybe just decode_save_opc(ctx, uw2) is better.
>
>I expect gen_cmpxchg also needs updating, though I don't have Zacas to hand.

I prefer decode_save_opc(ctx, uw2) but then

$git grep decode_save_opc | wc -l       
38

I can update all these locations but it'll be handful.
>
>
>r~

