Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A52C4829F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObd-0002ij-4Q; Fri, 09 Feb 2024 05:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOba-0002WC-G2
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:38 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObY-0000JD-Ej
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:38 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-214dbe25f8aso360266fac.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476375; x=1708081175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JBUOj8h6++JZn4T6C29bkIxqoHAHIzdYcbETRGZIy4=;
 b=bNDs1aSz3oySADh2sBW7iO4f9HEFE8B1ZFzpp3JJWkLjiCmn2Uj4JFJDWMkOKAUn8E
 STvuQgMV0h6oVdqIPovcDWAXPeD0R//er0j5SwcYW2Wv0v/GZUhHKtXJvK+E5a1eBL+a
 rwH7Ortdf9FtT4lV4crpK4RPeuQRWYoiL68enrGyEpYwXg5ZuPlHDbivwEBZCDM6HPL1
 xYLIU9Ln3qjgELB0PJfSLMkbVAMHofj1IclrWgs+BofSBfWxSbiCQdVkytAEYbhfmaZz
 0njozeZNj0yHKSRU/1x1IGxFtTn8DHoOHegoEeL+dYkLDZgchvGUWJYq+ib/m6Q2o6n9
 bofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476375; x=1708081175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6JBUOj8h6++JZn4T6C29bkIxqoHAHIzdYcbETRGZIy4=;
 b=w6Ao0m2UoLWdn4m2oKBzUJqyjtqw8N4HVKY8Tjl0tvK7iytmBbtG1M9ZE+XhVfzRsg
 IRzB3yUFfr8TbTSh5xogkR5WkHEyvFKVGUc+hRnVn3aOXkkOSP+Futfqr3B6xucwJqY0
 hMP5+cjTsDu4/mvEv+h/rEVI9ToaFsKMMfogpGBrbMYNG2Y4Ay+Hk7X9NodILQfQ3g4f
 KnT8N6oD9NDtj07c73bA2ldE9A1drakISL0pdqX9HAir1Ucy5pl6sUz1gRMy6HKygVZc
 pek+tdWJ8xv4c97Vf9GJ4/rkNebnrqJ+2Uh9ef19Zshw1ET3hgqRaAUBRx+qd+WekX2U
 D2Mg==
X-Gm-Message-State: AOJu0YwbHqai8vEbeFDgoyJV34vLz2kHu0PY7YiUV5rIbfJdDFHYefDM
 2TA+1B42xI45hjDMdtzX8b3q3sl2t7N+t3gQU/PavEJS8YFSsTCXxvANcOGLDn2xoA==
X-Google-Smtp-Source: AGHT+IHJs/ZBhUmN83/1ycA6ZDykvNXjF32fZwVCDvvpJENDASlLLVGMeWbL+aSBnM/+VbnDuMfaKg==
X-Received: by 2002:a05:6870:1713:b0:21a:c53:273a with SMTP id
 h19-20020a056870171300b0021a0c53273amr1216128oae.5.1707476374779; 
 Fri, 09 Feb 2024 02:59:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWRdLt9RlAfmV/FdaZxWDjlc9wgmpqLvpCRCU3lZGKFm67R8hDAtdGMA/+8YeoCxIwrEi12YegI0N5xVixdpJSjHcVsXv7pAbLyu/fVsTNYQvRUb/wCnyiiP0VRl43dLa8wlHCULpBr/1loJgCkyTKgqbZ6+wT8NzJFUg==
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:34 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 21/61] target/riscv: Implement optional CSR mcontext of debug
 Sdtrig extension
Date: Fri,  9 Feb 2024 20:57:33 +1000
Message-ID: <20240209105813.3590056-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alvin Chang <alvinga@andestech.com>

The debug Sdtrig extension defines an CSR "mcontext". This commit
implements its predicate and read/write operations into CSR table.
Its value is reset as 0 when the trigger module is reset.

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231219123244.290935-1-alvinga@andestech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h      |  1 +
 target/riscv/cpu_bits.h |  7 +++++++
 target/riscv/csr.c      | 36 +++++++++++++++++++++++++++++++-----
 target/riscv/debug.c    |  2 ++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a744b2372b..20997b0886 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -365,6 +365,7 @@ struct CPUArchState {
     target_ulong tdata1[RV_MAX_TRIGGERS];
     target_ulong tdata2[RV_MAX_TRIGGERS];
     target_ulong tdata3[RV_MAX_TRIGGERS];
+    target_ulong mcontext;
     struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
     struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
     QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index ebd7917d49..3296648a1f 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -361,6 +361,7 @@
 #define CSR_TDATA2          0x7a2
 #define CSR_TDATA3          0x7a3
 #define CSR_TINFO           0x7a4
+#define CSR_MCONTEXT        0x7a8
 
 /* Debug Mode Registers */
 #define CSR_DCSR            0x7b0
@@ -905,4 +906,10 @@ typedef enum RISCVException {
 /* JVT CSR bits */
 #define JVT_MODE                           0x3F
 #define JVT_BASE                           (~0x3F)
+
+/* Debug Sdtrig CSR masks */
+#define MCONTEXT32                         0x0000003F
+#define MCONTEXT64                         0x0000000000001FFFULL
+#define MCONTEXT32_HCONTEXT                0x0000007F
+#define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 674ea075a4..d666620e48 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3906,6 +3906,31 @@ static RISCVException read_tinfo(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_mcontext(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val = env->mcontext;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mcontext(CPURISCVState *env, int csrno,
+                                     target_ulong val)
+{
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32 ? true : false;
+    int32_t mask;
+
+    if (riscv_has_ext(env, RVH)) {
+        /* Spec suggest 7-bit for RV32 and 14-bit for RV64 w/ H extension */
+        mask = rv32 ? MCONTEXT32_HCONTEXT : MCONTEXT64_HCONTEXT;
+    } else {
+        /* Spec suggest 6-bit for RV32 and 13-bit for RV64 w/o H extension */
+        mask = rv32 ? MCONTEXT32 : MCONTEXT64;
+    }
+
+    env->mcontext = val & mask;
+    return RISCV_EXCP_NONE;
+}
+
 /*
  * Functions to access Pointer Masking feature registers
  * We have to check if current priv lvl could modify
@@ -4800,11 +4825,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_PMPADDR15] =  { "pmpaddr15", pmp, read_pmpaddr, write_pmpaddr },
 
     /* Debug CSRs */
-    [CSR_TSELECT]   =  { "tselect", debug, read_tselect, write_tselect },
-    [CSR_TDATA1]    =  { "tdata1",  debug, read_tdata,   write_tdata   },
-    [CSR_TDATA2]    =  { "tdata2",  debug, read_tdata,   write_tdata   },
-    [CSR_TDATA3]    =  { "tdata3",  debug, read_tdata,   write_tdata   },
-    [CSR_TINFO]     =  { "tinfo",   debug, read_tinfo,   write_ignore  },
+    [CSR_TSELECT]   =  { "tselect",  debug, read_tselect,  write_tselect  },
+    [CSR_TDATA1]    =  { "tdata1",   debug, read_tdata,    write_tdata    },
+    [CSR_TDATA2]    =  { "tdata2",   debug, read_tdata,    write_tdata    },
+    [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
+    [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
+    [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
 
     /* User Pointer Masking */
     [CSR_UMTE]    =    { "umte",    pointer_masking, read_umte,  write_umte },
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 4945d1a1f2..e30d99cc2f 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -940,4 +940,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
         env->cpu_watchpoint[i] = NULL;
         timer_del(env->itrigger_timer[i]);
     }
+
+    env->mcontext = 0;
 }
-- 
2.43.0


