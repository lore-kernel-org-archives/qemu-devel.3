Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D027C25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ELL-0007kk-1X; Mon, 20 May 2024 21:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELA-0007h8-W1; Mon, 20 May 2024 21:30:57 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9EL5-0005JP-MI; Mon, 20 May 2024 21:30:55 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f0937479f8so90374485ad.3; 
 Mon, 20 May 2024 18:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255050; x=1716859850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Cb2K5HbBY0bvGK5PB6n1V41h45TqBZ5zktjAGXJHR8=;
 b=TuPUlz57QxqqL1GyvHSU3ZnP9BL/JnFqbM9grCM3mDArWOafoueAE2c9Vo1Qn/rZOK
 bPH79n5fjWPw9pfSFwsED+x20kQCA6Ie+6e5WeOo5M4cqzAdu4kq41qZluTpgANp0URw
 xacHEY7dq4/oRt0nT8ltV3NgUW/CYI9SDB/GgjiPsLw30UbBvB2E7PzRNKa+KSIi+HBh
 jNzP759Cf3eK8gEjhm0mVs0RIhCxcsVmrHTapOF5kZlrEGnaWqHtVCTmL07ndAB4xK3m
 2bKuq43aVTuCAsDCBqvE5RfySxfJL8vOauNPzLVC3CnfeK0zxuzH1NbN7GixiODRzY78
 pSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255050; x=1716859850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Cb2K5HbBY0bvGK5PB6n1V41h45TqBZ5zktjAGXJHR8=;
 b=hPsgFMrAwWPgdxmmSAnA1rWGEmE0fmMmXMzSu59bid/DuqIStQSFxJTpCW2O0afHOu
 HRnUEeTiH9Sxm9NeeAXbroEgbaHtRzI1SroNYXs5x9PAah8yffOTPCHakT6BdWx8pUeX
 mbuGnZ8FZYn1jzYxZdsUBfhc+ztj8YwMVGJlWKWIWpsoSiFeDHEZ0Q1wOQw3gCyDCo1H
 PMfITLeFanLWjMvxA0+VdG+p4e3uGT9sZmbiMf22W8SYAF3ACTrf1xguWTUjukp8HD3r
 5fUI0zI7Qv26a/e0y8+QD7ZHVdxrQRzNeWccJrZXFIlbzYze0HTqrOuCVaekPDOEZaSU
 dDrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiPyI2QCf9+t7Rpl3+nN8OlVNsIfi6NZgHU6Q3oAlCV4qG/P6BnA4oeAf4ZgkX7MzgtC1G99p40L9aoSzAQ/HrGFTxZYg=
X-Gm-Message-State: AOJu0YxM7UGSuP9360o2ZbKPCzKQ5JZaYwR4IGaHeBv5r4eZY9Wbjk8f
 L1txrhVqs6DyB2Av3V7oj84iy/VSrsbHNIo6SUvQNYuOZtqixtrlkYqEFg==
X-Google-Smtp-Source: AGHT+IFGgnwQcwpgVKWJplzzXWcycbHv/ryhulZBiZ9UNlTm783P3Aj6cvq0vN7RJ5zhcFrfldiy3Q==
X-Received: by 2002:a17:90a:9513:b0:2b6:2079:71a4 with SMTP id
 98e67ed59e1d1-2bd55467d1amr8032615a91.20.1716255049555; 
 Mon, 20 May 2024 18:30:49 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:30:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 03/12] target/ppc: Implement attn instruction on BookS
 64-bit processors
Date: Tue, 21 May 2024 11:30:19 +1000
Message-ID: <20240521013029.30082-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521013029.30082-1-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

attn is an implementation-specific instruction that on POWER (and G5/
970) can be enabled with a HID bit (disabled = illegal), and executing
it causes the host processor to stop and the service processor to be
notified. Generally used for debugging.

Implement attn and make it checkstop the system, which should be good
enough for QEMU debugging.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h                     | 12 +++++
 target/ppc/helper.h                  |  1 +
 target/ppc/insn32.decode             |  4 ++
 target/ppc/cpu_init.c                | 69 ++++++++++++++++++++++++++++
 target/ppc/excp_helper.c             | 43 +++++++++++++----
 target/ppc/translate/misc-impl.c.inc | 10 ++++
 6 files changed, 130 insertions(+), 9 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c358927211..2532408be0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1375,6 +1375,9 @@ struct CPUArchState {
     /* Power management */
     int (*check_pow)(CPUPPCState *env);
 
+    /* attn instruction enable */
+    int (*check_attn)(CPUPPCState *env);
+
 #if !defined(CONFIG_USER_ONLY)
     void *load_info;  /* holds boot loading state */
 #endif
@@ -1523,6 +1526,7 @@ struct PowerPCCPUClass {
     int n_host_threads;
     void (*init_proc)(CPUPPCState *env);
     int  (*check_pow)(CPUPPCState *env);
+    int  (*check_attn)(CPUPPCState *env);
 };
 
 ObjectClass *ppc_cpu_class_by_name(const char *name);
@@ -2320,6 +2324,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define HID0_NAP            (1 << 22)           /* pre-2.06 */
 #define HID0_HILE           PPC_BIT(19) /* POWER8 */
 #define HID0_POWER9_HILE    PPC_BIT(4)
+#define HID0_ENABLE_ATTN    PPC_BIT(31) /* POWER8 */
+#define HID0_POWER9_ENABLE_ATTN PPC_BIT(3)
 
 /*****************************************************************************/
 /* PowerPC Instructions types definitions                                    */
@@ -3025,6 +3031,12 @@ static inline int check_pow_nocheck(CPUPPCState *env)
     return 1;
 }
 
+/* attn enable check                                                         */
+static inline int check_attn_none(CPUPPCState *env)
+{
+    return 0;
+}
+
 /*****************************************************************************/
 /* PowerPC implementations definitions                                       */
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 55293e20a9..09d50f9b76 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -825,5 +825,6 @@ DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
 #if defined(TARGET_PPC64)
 DEF_HELPER_1(clrbhrb, void, env)
 DEF_HELPER_FLAGS_2(mfbhrbe, TCG_CALL_NO_WG, i64, env, i32)
+DEF_HELPER_1(attn, noreturn, env)
 #endif
 #endif
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index d4dd022df4..ee33141476 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1198,3 +1198,7 @@ EIEIO           011111 ----- ----- ----- 1101010110 -
 
 MFBHRBE         011111 ..... ..... ..... 0100101110 -   @XFX_bhrbe
 CLRBHRB         011111 ----- ----- ----- 0110101110 -
+
+## Misc POWER instructions
+
+ATTN            000000 00000 00000 00000 0100000000 0
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1ec84b5ddc..ee01415c32 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2107,6 +2107,26 @@ static int check_pow_hid0_74xx(CPUPPCState *env)
     return 0;
 }
 
+#if defined(TARGET_PPC64)
+static int check_attn_hid0(CPUPPCState *env)
+{
+    if (env->spr[SPR_HID0] & HID0_ENABLE_ATTN) {
+        return 1;
+    }
+
+    return 0;
+}
+
+static int check_attn_hid0_power9(CPUPPCState *env)
+{
+    if (env->spr[SPR_HID0] & HID0_POWER9_ENABLE_ATTN) {
+        return 1;
+    }
+
+    return 0;
+}
+#endif
+
 static void init_proc_405(CPUPPCState *env)
 {
     register_40x_sprs(env);
@@ -2138,6 +2158,7 @@ POWERPC_FAMILY(405)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 405";
     pcc->init_proc = init_proc_405;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_DCR | PPC_WRTEE |
                        PPC_CACHE | PPC_CACHE_ICBI | PPC_40x_ICBT |
@@ -2210,6 +2231,7 @@ POWERPC_FAMILY(440EP)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 440 EP";
     pcc->init_proc = init_proc_440EP;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING |
                        PPC_FLOAT | PPC_FLOAT_FRES | PPC_FLOAT_FSEL |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -2248,6 +2270,7 @@ POWERPC_FAMILY(460EX)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 460 EX";
     pcc->init_proc = init_proc_440EP;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING |
                        PPC_FLOAT | PPC_FLOAT_FRES | PPC_FLOAT_FSEL |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -2308,6 +2331,7 @@ POWERPC_FAMILY(440GP)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 440 GP";
     pcc->init_proc = init_proc_440GP;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING |
                        PPC_DCR | PPC_DCRX | PPC_WRTEE | PPC_MFAPIDI |
                        PPC_CACHE | PPC_CACHE_ICBI |
@@ -2382,6 +2406,7 @@ POWERPC_FAMILY(440x5)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 440x5";
     pcc->init_proc = init_proc_440x5;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING |
                        PPC_DCR | PPC_WRTEE | PPC_RFMCI |
                        PPC_CACHE | PPC_CACHE_ICBI |
@@ -2417,6 +2442,7 @@ POWERPC_FAMILY(440x5wDFPU)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 440x5 with double precision FPU";
     pcc->init_proc = init_proc_440x5;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING |
                        PPC_FLOAT | PPC_FLOAT_FSQRT |
                        PPC_FLOAT_STFIWX |
@@ -2465,6 +2491,7 @@ POWERPC_FAMILY(MPC5xx)(ObjectClass *oc, void *data)
     dc->desc = "Freescale 5xx cores (aka RCPU)";
     pcc->init_proc = init_proc_MPC5xx;
     pcc->check_pow = check_pow_none;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING |
                        PPC_MEM_EIEIO | PPC_MEM_SYNC |
                        PPC_CACHE_ICBI | PPC_FLOAT | PPC_FLOAT_STFIWX |
@@ -2507,6 +2534,7 @@ POWERPC_FAMILY(MPC8xx)(ObjectClass *oc, void *data)
     dc->desc = "Freescale 8xx cores (aka PowerQUICC)";
     pcc->init_proc = init_proc_MPC8xx;
     pcc->check_pow = check_pow_none;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING  |
                        PPC_MEM_EIEIO | PPC_MEM_SYNC |
                        PPC_CACHE_ICBI | PPC_MFTB;
@@ -2557,6 +2585,7 @@ POWERPC_FAMILY(G2)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC G2";
     pcc->init_proc = init_proc_G2;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_STFIWX |
@@ -2595,6 +2624,7 @@ POWERPC_FAMILY(G2LE)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC G2LE";
     pcc->init_proc = init_proc_G2;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_STFIWX |
@@ -2741,6 +2771,7 @@ POWERPC_FAMILY(e200)(ObjectClass *oc, void *data)
     dc->desc = "e200 core";
     pcc->init_proc = init_proc_e200;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     /*
      * XXX: unimplemented instructions:
      * dcblc
@@ -3029,6 +3060,7 @@ POWERPC_FAMILY(e500v1)(ObjectClass *oc, void *data)
     dc->desc = "e500v1 core";
     pcc->init_proc = init_proc_e500v1;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL |
                        PPC_SPE | PPC_SPE_SINGLE |
                        PPC_WRTEE | PPC_RFDI |
@@ -3072,6 +3104,7 @@ POWERPC_FAMILY(e500v2)(ObjectClass *oc, void *data)
     dc->desc = "e500v2 core";
     pcc->init_proc = init_proc_e500v2;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL |
                        PPC_SPE | PPC_SPE_SINGLE | PPC_SPE_DOUBLE |
                        PPC_WRTEE | PPC_RFDI |
@@ -3115,6 +3148,7 @@ POWERPC_FAMILY(e500mc)(ObjectClass *oc, void *data)
     dc->desc = "e500mc core";
     pcc->init_proc = init_proc_e500mc;
     pcc->check_pow = check_pow_none;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_MFTB |
                        PPC_WRTEE | PPC_RFDI | PPC_RFMCI |
                        PPC_CACHE | PPC_CACHE_LOCK | PPC_CACHE_ICBI |
@@ -3161,6 +3195,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, void *data)
     dc->desc = "e5500 core";
     pcc->init_proc = init_proc_e5500;
     pcc->check_pow = check_pow_none;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_MFTB |
                        PPC_WRTEE | PPC_RFDI | PPC_RFMCI |
                        PPC_CACHE | PPC_CACHE_LOCK | PPC_CACHE_ICBI |
@@ -3209,6 +3244,7 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, void *data)
     dc->desc = "e6500 core";
     pcc->init_proc = init_proc_e6500;
     pcc->check_pow = check_pow_none;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_MFTB |
                        PPC_WRTEE | PPC_RFDI | PPC_RFMCI |
                        PPC_CACHE | PPC_CACHE_LOCK | PPC_CACHE_ICBI |
@@ -3271,6 +3307,7 @@ POWERPC_FAMILY(603)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 603";
     pcc->init_proc = init_proc_603;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FRSQRTE | PPC_FLOAT_STFIWX |
@@ -3310,6 +3347,7 @@ POWERPC_FAMILY(603E)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 603e";
     pcc->init_proc = init_proc_603;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FRSQRTE | PPC_FLOAT_STFIWX |
@@ -3355,6 +3393,7 @@ POWERPC_FAMILY(e300)(ObjectClass *oc, void *data)
     dc->desc = "e300 core";
     pcc->init_proc = init_proc_e300;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_STFIWX |
@@ -3410,6 +3449,7 @@ POWERPC_FAMILY(604)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 604";
     pcc->init_proc = init_proc_604;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FRSQRTE | PPC_FLOAT_STFIWX |
@@ -3455,6 +3495,7 @@ POWERPC_FAMILY(604E)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 604E";
     pcc->init_proc = init_proc_604E;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FRSQRTE | PPC_FLOAT_STFIWX |
@@ -3511,6 +3552,7 @@ POWERPC_FAMILY(740)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 740";
     pcc->init_proc = init_proc_740;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FRSQRTE | PPC_FLOAT_STFIWX |
@@ -3576,6 +3618,7 @@ POWERPC_FAMILY(750)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 750";
     pcc->init_proc = init_proc_750;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FRSQRTE | PPC_FLOAT_STFIWX |
@@ -3722,6 +3765,7 @@ POWERPC_FAMILY(750cl)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 750 CL";
     pcc->init_proc = init_proc_750cl;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     /*
      * XXX: not implemented:
      * cache lock instructions:
@@ -3829,6 +3873,7 @@ POWERPC_FAMILY(750cx)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 750CX";
     pcc->init_proc = init_proc_750cx;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FRSQRTE | PPC_FLOAT_STFIWX |
@@ -3901,6 +3946,7 @@ POWERPC_FAMILY(750fx)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 750FX";
     pcc->init_proc = init_proc_750fx;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FRSQRTE | PPC_FLOAT_STFIWX |
@@ -3973,6 +4019,7 @@ POWERPC_FAMILY(750gx)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 750GX";
     pcc->init_proc = init_proc_750gx;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FRSQRTE | PPC_FLOAT_STFIWX |
@@ -4032,6 +4079,7 @@ POWERPC_FAMILY(745)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 745";
     pcc->init_proc = init_proc_745;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FRSQRTE | PPC_FLOAT_STFIWX |
@@ -4077,6 +4125,7 @@ POWERPC_FAMILY(755)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 755";
     pcc->init_proc = init_proc_755;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FRSQRTE | PPC_FLOAT_STFIWX |
@@ -4143,6 +4192,7 @@ POWERPC_FAMILY(7400)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 7400 (aka G4)";
     pcc->init_proc = init_proc_7400;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -4222,6 +4272,7 @@ POWERPC_FAMILY(7410)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 7410 (aka G4)";
     pcc->init_proc = init_proc_7410;
     pcc->check_pow = check_pow_hid0;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -4322,6 +4373,7 @@ POWERPC_FAMILY(7440)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 7440 (aka G4)";
     pcc->init_proc = init_proc_7440;
     pcc->check_pow = check_pow_hid0_74xx;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -4444,6 +4496,7 @@ POWERPC_FAMILY(7450)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 7450 (aka G4)";
     pcc->init_proc = init_proc_7450;
     pcc->check_pow = check_pow_hid0_74xx;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -4573,6 +4626,7 @@ POWERPC_FAMILY(7445)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 7445 (aka G4)";
     pcc->init_proc = init_proc_7445;
     pcc->check_pow = check_pow_hid0_74xx;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -4704,6 +4758,7 @@ POWERPC_FAMILY(7455)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 7455 (aka G4)";
     pcc->init_proc = init_proc_7455;
     pcc->check_pow = check_pow_hid0_74xx;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -4855,6 +4910,7 @@ POWERPC_FAMILY(7457)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 7457 (aka G4)";
     pcc->init_proc = init_proc_7457;
     pcc->check_pow = check_pow_hid0_74xx;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -4989,6 +5045,7 @@ POWERPC_FAMILY(e600)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC e600";
     pcc->init_proc = init_proc_e600;
     pcc->check_pow = check_pow_hid0_74xx;
+    pcc->check_attn = check_attn_none;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -5904,6 +5961,7 @@ POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 970";
     pcc->init_proc = init_proc_970;
     pcc->check_pow = check_pow_970;
+    pcc->check_attn = check_attn_hid0;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -5979,6 +6037,7 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
     dc->desc = "POWER5+";
     pcc->init_proc = init_proc_power5plus;
     pcc->check_pow = check_pow_970;
+    pcc->check_attn = check_attn_hid0;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -6086,6 +6145,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
     pcc->pcr_supported = PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER7;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_hid0;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -6247,6 +6307,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->pcr_supported = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER8;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_hid0;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -6439,6 +6500,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                          PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER9;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_hid0_power9;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -6618,6 +6680,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
                          PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER10;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_hid0_power9;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -6856,6 +6919,11 @@ static void init_ppc_proc(PowerPCCPU *cpu)
         warn_report("no power management check handler registered."
                     " Attempt QEMU to crash very soon !");
     }
+
+    if (env->check_attn == NULL) {
+        warn_report("no attn check handler registered."
+                    " Attempt QEMU to crash very soon !");
+    }
 }
 
 
@@ -7317,6 +7385,7 @@ static void ppc_cpu_instance_init(Object *obj)
     env->flags = pcc->flags;
     env->bfd_mach = pcc->bfd_mach;
     env->check_pow = pcc->check_pow;
+    env->check_attn = pcc->check_attn;
 
     /*
      * Mark HV mode as supported if the CPU has an MSR_HV bit in the
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 17bf8df9d7..e786a9044b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -154,6 +154,7 @@ static uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 
     return insn;
 }
+
 #endif
 
 static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
@@ -425,21 +426,20 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
     env->reserve_addr = -1;
 }
 
-static void powerpc_mcheck_checkstop(CPUPPCState *env)
-{
-    /* KVM guests always have MSR[ME] enabled */
 #ifdef CONFIG_TCG
+/*
+ * This stops the machine and logs CPU state without killing QEMU (like
+ * cpu_abort()) because it is often a guest error as opposed to a QEMU error,
+ * so the machine can still be debugged.
+ */
+static G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
+{
     CPUState *cs = env_cpu(env);
     FILE *f;
 
-    if (FIELD_EX64(env->msr, MSR, ME)) {
-        return;
-    }
-
     f = qemu_log_trylock();
     if (f) {
-        fprintf(f, "Entering checkstop state: "
-                   "machine check with MSR[ME]=0\n");
+        fprintf(f, "Entering checkstop state: %s\n", reason);
         cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
         qemu_log_unlock(f);
     }
@@ -451,6 +451,31 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
      */
     qemu_system_guest_panicked(NULL);
     cpu_loop_exit_noexc(cs);
+}
+
+#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+void helper_attn(CPUPPCState *env)
+{
+    /* POWER attn is unprivileged when enabled by HID, otherwise illegal */
+    if ((*env->check_attn)(env)) {
+        powerpc_checkstop(env, "host executed attn");
+    } else {
+        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
+                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
+    }
+}
+#endif
+#endif /* CONFIG_TCG */
+
+static void powerpc_mcheck_checkstop(CPUPPCState *env)
+{
+    /* KVM guests always have MSR[ME] enabled */
+#ifdef CONFIG_TCG
+    if (FIELD_EX64(env->msr, MSR, ME)) {
+        return;
+    }
+
+    powerpc_checkstop(env, "machine check with MSR[ME]=0");
 #endif
 }
 
diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
index c1661d2f43..cbf82b1ea0 100644
--- a/target/ppc/translate/misc-impl.c.inc
+++ b/target/ppc/translate/misc-impl.c.inc
@@ -145,3 +145,13 @@ static bool trans_EIEIO(DisasContext *ctx, arg_EIEIO *a)
 
     return true;
 }
+
+static bool trans_ATTN(DisasContext *ctx, arg_ATTN *a)
+{
+#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+    gen_helper_attn(tcg_env);
+    return true;
+#else
+    return false;
+#endif
+}
-- 
2.43.0


