Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FB4C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZD-0000xy-Fs; Thu, 23 May 2024 19:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYn-0000B6-5g; Thu, 23 May 2024 19:09:25 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYi-0005mI-3B; Thu, 23 May 2024 19:09:20 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f8e859eb20so314569b3a.0; 
 Thu, 23 May 2024 16:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505754; x=1717110554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOBnrWHdBAkwYHxm+kILPeze6YeFGGjypHwPQOgKHiQ=;
 b=C5dYlLjkupTwOubwxFyvFmp4ABaog+J78bCobnN0xcfxvwxC7e0RmTod5izey6SNyF
 8m4eqNkvMAZAVyLCdISf3BTharI2Te54EGBZ/Fe2q4SJdqdnkwQQ5he8D8we50UIqGjq
 /XIdble8mJVwAMkiFi5aG2rG+leo2AVqF+Ju9qPFvk0oPn61hBZ+OcaWX76vmRfIdPkc
 g5V8dRBUFfn/1pDZ+GjfOz79qSxZpdFZUmAJ6Rzo23My9MFkE91GbosC4IZbipT6YfR5
 qxSkvmkLAlgQL3Nf/bWPlalYIanfmdz3QRaMbMoumQMpFCe1wTRojF5daJDCP0tdLySB
 RTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505754; x=1717110554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xOBnrWHdBAkwYHxm+kILPeze6YeFGGjypHwPQOgKHiQ=;
 b=A4eo6dw9vrSrYmzm+zvabiQi3zNlwlB60WfECxBQd4+C7kF0XPIwWzgBWS12FV5sqe
 e5OW7yiCP1hWvlgfQQc9HX6SxMvS6+6gX9Sy7DSjUdHtWLgqIeiMQz+PmavhkUYSSymZ
 wlEtRywvWQWg0QBXUhNp5VOLhOcYq8bPkjq5VF6NTlLFhMcXonzvqucUhdFgeqsVdH2t
 xQ/xbwO+V1qiUmT/CQKWuC6n7ACWs1midv+G0lsNJoyMaIaZRV5OxUbxZ9wkB5k727ys
 uD05R9ESuxJWOyfNdo2WQr5G4e16A12X99cSIRYN/3C8Qfm/1XDrmsMoMBAcMOca+koN
 kM9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVypFNJvIJnLEPKb1LRiYVhlbb/bJBoXi7Nyc8oKz3ZMJ8ZHdSWaVBD6u47ZIAse1/rzoy4/LSMbu13816+rxA+9Dfm
X-Gm-Message-State: AOJu0YwXZ5kZaGqD104VFEaE4qD7g97Bu7knV14/3Nu6eNkoIg70Cn08
 zKgzGxZ7iDA6VStKGlRuHU4p8ahKxhZSzmeOmssmE1W2hP2kbw/E+m5YZQ==
X-Google-Smtp-Source: AGHT+IE63sex7gTFu1t6jqFT3WeotUVy96qqjo5GcVuu8hA0cqhbkE0sFVNW8WhVzS/vMOdwqvzMUw==
X-Received: by 2002:a05:6a20:de14:b0:1af:ab09:c555 with SMTP id
 adf61e73a8af0-1b212f34c55mr695366637.47.1716505753967; 
 Thu, 23 May 2024 16:09:13 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 24/72] Add support for the clrbhrb and mfbhrbe instructions.
Date: Fri, 24 May 2024 09:06:57 +1000
Message-ID: <20240523230747.45703-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Since neither instruction is believed to be critical to
performance, both instructions were implemented using helper
functions.

Access to both instructions is controlled by bits in the
HFSCR (for privileged state) and MMCR0 (for problem state).
A new function, helper_mmcr0_facility_check, was added for
checking MMCR0[BHRBA] and raising a facility_unavailable exception
if required.

NOTE: For P8 and P9, due to a performance issue, branch history will
not be kept, but the instructions will be allowed to execute
as normal with the exception that the mfbhrbe instruction will
always return a zero value.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h                     |  2 ++
 target/ppc/helper.h                  |  7 ++++
 target/ppc/insn32.decode             |  8 +++++
 target/ppc/misc_helper.c             | 50 ++++++++++++++++++++++++++++
 target/ppc/translate.c               |  2 ++
 target/ppc/translate/bhrb-impl.c.inc | 43 ++++++++++++++++++++++++
 6 files changed, 112 insertions(+)
 create mode 100644 target/ppc/translate/bhrb-impl.c.inc

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2f91d7dc33..c358927211 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -535,6 +535,7 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR0_PMCjCE PPC_BIT(49)         /* MMCR0 PMCj Condition Enabled */
 #define MMCR0_FCP    PPC_BIT(34)         /* Freeze Counters/BHRB if PR=1 */
 #define MMCR0_FCPC   PPC_BIT(51)         /* Condition for FCP bit */
+#define MMCR0_BHRBA_NR PPC_BIT_NR(42)    /* BHRB Available */
 /* MMCR0 userspace r/w mask */
 #define MMCR0_UREG_MASK (MMCR0_FC | MMCR0_PMAO | MMCR0_PMAE)
 /* MMCR2 userspace r/w mask */
@@ -634,6 +635,7 @@ FIELD(MSR, LE, MSR_LE, 1)
 
 /* HFSCR bits */
 #define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send Facilities */
+#define HFSCR_BHRB     PPC_BIT(59) /* BHRB Instructions */
 #define HFSCR_IC_MSGP  0xA
 
 #define DBCR0_ICMP (1 << 27)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 7b07cd1a49..55293e20a9 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -820,3 +820,10 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
+
+#if !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64)
+DEF_HELPER_1(clrbhrb, void, env)
+DEF_HELPER_FLAGS_2(mfbhrbe, TCG_CALL_NO_WG, i64, env, i32)
+#endif
+#endif
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 05c1d8c12d..d4dd022df4 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1190,3 +1190,11 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
 @X_sync         ...... .. l:3 ... sc:2 ..... .......... .           &X_sync
 SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
 EIEIO           011111 ----- ----- ----- 1101010110 -
+
+# Branch History Rolling Buffer (BHRB) Instructions
+
+&XFX_bhrbe      rt bhrbe
+@XFX_bhrbe      ...... rt:5 bhrbe:10 .......... -       &XFX_bhrbe
+
+MFBHRBE         011111 ..... ..... ..... 0100101110 -   @XFX_bhrbe
+CLRBHRB         011111 ----- ----- ----- 0110101110 -
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 58e808dc96..6f419c9346 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -150,6 +150,17 @@ void helper_msr_facility_check(CPUPPCState *env, uint32_t bit,
 
 #if !defined(CONFIG_USER_ONLY)
 
+#ifdef TARGET_PPC64
+static void helper_mmcr0_facility_check(CPUPPCState *env, uint32_t bit,
+                                 uint32_t sprn, uint32_t cause)
+{
+    if (FIELD_EX64(env->msr, MSR, PR) &&
+        !(env->spr[SPR_POWER_MMCR0] & (1ULL << bit))) {
+        raise_fu_exception(env, bit, sprn, cause, GETPC());
+    }
+}
+#endif
+
 void helper_store_sdr1(CPUPPCState *env, target_ulong val)
 {
     if (env->spr[SPR_SDR1] != val) {
@@ -363,3 +374,42 @@ void helper_fixup_thrm(CPUPPCState *env)
         env->spr[i] = v;
     }
 }
+
+#if !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64)
+void helper_clrbhrb(CPUPPCState *env)
+{
+    helper_hfscr_facility_check(env, HFSCR_BHRB, "clrbhrb", FSCR_IC_BHRB);
+
+    helper_mmcr0_facility_check(env, MMCR0_BHRBA_NR, 0, FSCR_IC_BHRB);
+
+    if (env->flags & POWERPC_FLAG_BHRB) {
+        memset(env->bhrb, 0, sizeof(env->bhrb));
+    }
+}
+
+uint64_t helper_mfbhrbe(CPUPPCState *env, uint32_t bhrbe)
+{
+    unsigned int index;
+
+    helper_hfscr_facility_check(env, HFSCR_BHRB, "mfbhrbe", FSCR_IC_BHRB);
+
+    helper_mmcr0_facility_check(env, MMCR0_BHRBA_NR, 0, FSCR_IC_BHRB);
+
+    if (!(env->flags & POWERPC_FLAG_BHRB) ||
+         (bhrbe >= env->bhrb_num_entries) ||
+         (env->spr[SPR_POWER_MMCR0] & MMCR0_PMAE)) {
+        return 0;
+    }
+
+    /*
+     * Note: bhrb_offset is the byte offset for writing the
+     * next entry (over the oldest entry), which is why we
+     * must offset bhrbe by 1 to get to the 0th entry.
+     */
+    index = ((env->bhrb_offset / sizeof(uint64_t)) - (bhrbe + 1)) %
+            env->bhrb_num_entries;
+    return env->bhrb[index];
+}
+#endif
+#endif
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8aa2439700..546f1754de 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5647,6 +5647,8 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
 
 #include "translate/misc-impl.c.inc"
 
+#include "translate/bhrb-impl.c.inc"
+
 /* Handles lfdp */
 static void gen_dform39(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/bhrb-impl.c.inc b/target/ppc/translate/bhrb-impl.c.inc
new file mode 100644
index 0000000000..3a19bc4555
--- /dev/null
+++ b/target/ppc/translate/bhrb-impl.c.inc
@@ -0,0 +1,43 @@
+/*
+ * Power ISA Decode For BHRB Instructions
+ *
+ *  Copyright IBM Corp. 2023
+ *
+ * Authors:
+ *  Glenn Miles      <milesg@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+
+static bool trans_MFBHRBE(DisasContext *ctx, arg_XFX_bhrbe *arg)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    TCGv_i32 bhrbe = tcg_constant_i32(arg->bhrbe);
+    gen_helper_mfbhrbe(cpu_gpr[arg->rt], tcg_env, bhrbe);
+    return true;
+}
+
+static bool trans_CLRBHRB(DisasContext *ctx, arg_CLRBHRB *arg)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    gen_helper_clrbhrb(tcg_env);
+    return true;
+}
+
+#else
+
+static bool trans_MFBHRBE(DisasContext *ctx, arg_XFX_bhrbe *arg)
+{
+    gen_invalid(ctx);
+    return true;
+}
+
+static bool trans_CLRBHRB(DisasContext *ctx, arg_CLRBHRB *arg)
+{
+    gen_invalid(ctx);
+    return true;
+}
+#endif
-- 
2.43.0


