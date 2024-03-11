Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23ACC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkly-00070j-54; Mon, 11 Mar 2024 14:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjkls-0006Zw-6R; Mon, 11 Mar 2024 14:53:13 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklc-000597-V0; Mon, 11 Mar 2024 14:53:11 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc29f1956cso20866595ad.0; 
 Mon, 11 Mar 2024 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183174; x=1710787974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=td6oXJfo851uVPEpS2rEFuUd6/8S85EIYHyRVGqBsi4=;
 b=hgP8h+KEiEYeRIWMRsF2QuwE0lmAZWi1s41u+J2ixcFMpWhiJ0RuehUz8FHpUp2miW
 SzOLuY2oySrRbcAp9rljhX/rz0ZvOAclqscW7IMrDs100z9zmrAyYa2+U9TcG2kWVd6m
 Scf4AmU4uBRTrruvaB7wIEuAbxt4wBxXTIvb5JcTZh/jB4SkXraNMwxf3hzJiQrgEWUt
 oXCZ8PDAWV4Pi8YaKfRW1+huAIMychVw4EC7bT6dVhDeFZT65LFooQmkbsLN4he4Bj6x
 5r0R3ba3Dg8Bg9wxlnviPNDXllEg7zpZdumbZlH0hNdY0QaPhhoshZSrR7xAYWZAeo8u
 WfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183174; x=1710787974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=td6oXJfo851uVPEpS2rEFuUd6/8S85EIYHyRVGqBsi4=;
 b=cNhWO5lt1mHJ7YN+OWD7WN/YN0BFSlX8cRGl08HEp3Ce3u+bBe+LS6ChNzkNvPryGO
 rcaoNBiKMmm96w9X4SfKZiTu7Ylya5VVeTkCNE+ERgDF1BrFPnSTJJMthMHPACCF/CHy
 fk/40AGuUhJX6etnZkHgLQZStF+dpn4eVamhSGdxGXptrmQf4RCfF9kZQ/loEItZCpO4
 r5RDq2px2S7PsB/YqpEi0tfVcnq2Nm3yjMFs+vsZTLAYgTUJCbOJFphc/1z9zxoYKn8e
 FeSu2fj7wEcUVZFJi2Ipg+ac2T+hpW32+LeKjslAuA0LK3HnlPdXvpnJftV/hbgrfKLP
 PDoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjRiVFOHdj0yqxTs9J6At3OkBjGri3CHffwxdQCQNKC/Ckvl3gv0TZdcOzwN4d25xuB8WL8Rs1gT0kCTHzdZt6mXh2Quk=
X-Gm-Message-State: AOJu0Yw+VMT2HRzweoNVt119mUvFvDz/IbQzUq6Bvp0tVKIqSck4kE7I
 TPg3fkB791jbp3ovfnkAKVUyrieB60B3AebZcZ0lZZMcXYBGYq0tFIbtBMmPzHs=
X-Google-Smtp-Source: AGHT+IHEOp87b4wwQnUav2+fBJxz9AMCQqbSk6gGNVeW3BlJqtNXpC+qnxgXDdXAUoDEi2ecy0pWZw==
X-Received: by 2002:a17:902:ea01:b0:1db:55cc:d226 with SMTP id
 s1-20020a170902ea0100b001db55ccd226mr7001538plg.66.1710183173860; 
 Mon, 11 Mar 2024 11:52:53 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 13/13] target/ppc: Implement attn instruction on BookS 64-bit
 processors
Date: Tue, 12 Mar 2024 04:51:55 +1000
Message-ID: <20240311185200.2185753-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

attn is an implementation-specific instruction that on POWER (and G5/
970) can be enabled with a HID bit (disabled = illegal), and executing
it causes the host processor to stop and the service processor to be
notified. Generally used for debugging.

Implement attn and make it checkstop the system, which should be good
enough for QEMU debugging.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         | 16 +++++++-
 target/ppc/helper.h      |  4 ++
 target/ppc/cpu_init.c    | 82 +++++++++++++++++++++++++++++++++++++---
 target/ppc/excp_helper.c | 59 +++++++++++++++++++----------
 target/ppc/translate.c   | 11 ++++++
 5 files changed, 145 insertions(+), 27 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0133da4e07..4fb5bd2e6e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1353,6 +1353,9 @@ struct CPUArchState {
     /* Power management */
     int (*check_pow)(CPUPPCState *env);
 
+    /* attn instruction enable */
+    int (*check_attn)(CPUPPCState *env);
+
 #if !defined(CONFIG_USER_ONLY)
     void *load_info;  /* holds boot loading state */
 #endif
@@ -1500,6 +1503,7 @@ struct PowerPCCPUClass {
     int n_host_threads;
     void (*init_proc)(CPUPPCState *env);
     int  (*check_pow)(CPUPPCState *env);
+    int  (*check_attn)(CPUPPCState *env);
 };
 
 ObjectClass *ppc_cpu_class_by_name(const char *name);
@@ -2287,6 +2291,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define HID0_NAP            (1 << 22)           /* pre-2.06 */
 #define HID0_HILE           PPC_BIT(19) /* POWER8 */
 #define HID0_POWER9_HILE    PPC_BIT(4)
+#define HID0_ENABLE_ATTN    PPC_BIT(31) /* POWER8 */
+#define HID0_POWER9_ENABLE_ATTN PPC_BIT(3)
 
 /*****************************************************************************/
 /* PowerPC Instructions types definitions                                    */
@@ -2483,6 +2489,8 @@ enum {
     PPC2_MEM_LWSYNC    = 0x0000000000200000ULL,
     /* ISA 2.06 BCD assist instructions                                      */
     PPC2_BCDA_ISA206   = 0x0000000000400000ULL,
+    /* attn instruction found in IBM POWER (including 970)                   */
+    PPC2_ATTN          = 0x0000000000800000ULL,
 
 #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
                         PPC2_ISA205 | PPC2_VSX207 | PPC2_PERM_ISA206 | \
@@ -2492,7 +2500,7 @@ enum {
                         PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
                         PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
-                        PPC2_BCDA_ISA206)
+                        PPC2_BCDA_ISA206 | PPC2_ATTN)
 };
 
 /*****************************************************************************/
@@ -2991,6 +2999,12 @@ static inline int check_pow_nocheck(CPUPPCState *env)
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
index 86f97ee1e7..5a66b35f26 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -819,3 +819,7 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
+
+#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+DEF_HELPER_1(attn, noreturn, env)
+#endif
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index d7e84a2f40..aac095e5fd 100644
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
@@ -5872,6 +5929,7 @@ POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
     dc->desc = "PowerPC 970";
     pcc->init_proc = init_proc_970;
     pcc->check_pow = check_pow_970;
+    pcc->check_attn = check_attn_hid0;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -5881,7 +5939,7 @@ POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
                        PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
                        PPC_64B | PPC_ALTIVEC |
                        PPC_SEGMENT_64B | PPC_SLBI;
-    pcc->insns_flags2 = PPC2_FP_CVT_S64 | PPC2_MEM_LWSYNC;
+    pcc->insns_flags2 = PPC2_FP_CVT_S64 | PPC2_MEM_LWSYNC | PPC2_ATTN;
     pcc->msr_mask = (1ull << MSR_SF) |
                     (1ull << MSR_VR) |
                     (1ull << MSR_POW) |
@@ -5947,6 +6005,7 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
     dc->desc = "POWER5+";
     pcc->init_proc = init_proc_power5plus;
     pcc->check_pow = check_pow_970;
+    pcc->check_attn = check_attn_hid0;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -5958,7 +6017,7 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
                        PPC_64B |
                        PPC_POPCNTB |
                        PPC_SEGMENT_64B | PPC_SLBI;
-    pcc->insns_flags2 = PPC2_FP_CVT_S64 | PPC2_MEM_LWSYNC;
+    pcc->insns_flags2 = PPC2_FP_CVT_S64 | PPC2_MEM_LWSYNC | PPC2_ATTN;
     pcc->msr_mask = (1ull << MSR_SF) |
                     (1ull << MSR_VR) |
                     (1ull << MSR_POW) |
@@ -6054,6 +6113,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
     pcc->pcr_supported = PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER7;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_hid0;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -6071,7 +6131,8 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
                         PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
                         PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
                         PPC2_FP_TST_ISA206 | PPC2_FP_CVT_S64 |
-                        PPC2_PM_ISA206 | PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
+                        PPC2_PM_ISA206 | PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206 |
+                        PPC2_ATTN;
     pcc->msr_mask = (1ull << MSR_SF) |
                     (1ull << MSR_VR) |
                     (1ull << MSR_VSX) |
@@ -6191,6 +6252,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->pcr_supported = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER8;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_hid0;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -6211,7 +6273,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
                         PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
-                        PPC2_BCDA_ISA206;
+                        PPC2_BCDA_ISA206 | PPC2_ATTN;
     pcc->msr_mask = (1ull << MSR_SF) |
                     (1ull << MSR_HV) |
                     (1ull << MSR_TM) |
@@ -6380,6 +6442,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                          PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER9;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_hid0_power9;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -6400,7 +6463,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
                         PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_MEM_LWSYNC |
-                        PPC2_BCDA_ISA206;
+                        PPC2_BCDA_ISA206 | PPC2_ATTN;
     pcc->msr_mask = (1ull << MSR_SF) |
                     (1ull << MSR_HV) |
                     (1ull << MSR_TM) |
@@ -6554,6 +6617,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
                          PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER10;
     pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_hid0_power9;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
                        PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
                        PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
@@ -6574,7 +6638,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
                         PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
-                        PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
+                        PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206 | PPC2_ATTN;
     pcc->msr_mask = (1ull << MSR_SF) |
                     (1ull << MSR_HV) |
                     (1ull << MSR_TM) |
@@ -6791,6 +6855,11 @@ static void init_ppc_proc(PowerPCCPU *cpu)
         warn_report("no power management check handler registered."
                     " Attempt QEMU to crash very soon !");
     }
+
+    if (env->check_attn == NULL) {
+        warn_report("no attn check handler registered."
+                    " Attempt QEMU to crash very soon !");
+    }
 }
 
 
@@ -7254,6 +7323,7 @@ static void ppc_cpu_instance_init(Object *obj)
     env->flags = pcc->flags;
     env->bfd_mach = pcc->bfd_mach;
     env->check_pow = pcc->check_pow;
+    env->check_attn = pcc->check_attn;
 
     /*
      * Mark HV mode as supported if the CPU has an MSR_HV bit in the
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index ad78d027e9..e4e760449b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -188,7 +188,45 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
              env->error_code);
 }
 
+/*
+ * This stops the machine and logs CPU state without killing QEMU (like
+ * cpu_abort()) because it is often a guest error as opposed to a QEMU error,
+ * so the machine can still be debugged.
+ */
+static G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
+{
+    CPUState *cs = env_cpu(env);
+    FILE *f;
+
+    /*
+     * This stops the machine and logs CPU state without killing QEMU
+     * (like cpu_abort()) so the machine can still be debugged (because
+     * it is often a guest error).
+     */
+
+    f = qemu_log_trylock();
+    if (f) {
+        fprintf(f, "Entering checkstop state: %s\n", reason);
+        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+        qemu_log_unlock(f);
+    }
+
+    qemu_system_guest_panicked(NULL);
+
+    cpu_loop_exit_noexc(cs);
+}
+
 #if defined(TARGET_PPC64)
+void helper_attn(CPUPPCState *env)
+{
+    if ((*env->check_attn)(env)) {
+        powerpc_checkstop(env, "host executed attn");
+    } else {
+        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
+                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
+    }
+}
+
 static int powerpc_reset_wakeup(CPUPPCState *env, int excp, target_ulong *msr)
 {
     /* We no longer are in a PM state */
@@ -428,30 +466,11 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
 
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
-    CPUState *cs = env_cpu(env);
-    FILE *f;
-
     if (FIELD_EX64(env->msr, MSR, ME)) {
         return;
     }
 
-    /*
-     * This stops the machine and logs CPU state without killing QEMU
-     * (like cpu_abort()) so the machine can still be debugged (because
-     * it is often a guest error).
-     */
-
-    f = qemu_log_trylock();
-    if (f) {
-        fprintf(f, "Entering checkstop state: "
-                   "machine check with MSR[ME]=0\n");
-        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
-        qemu_log_unlock(f);
-    }
-
-    qemu_system_guest_panicked(NULL);
-
-    cpu_loop_exit_noexc(cs);
+    powerpc_checkstop(env, "machine check with MSR[ME]=0");
 }
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 28fc7791af..c2a3bdc3e6 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6482,6 +6482,16 @@ static void gen_dform3D(DisasContext *ctx)
 }
 
 #if defined(TARGET_PPC64)
+/* attn */
+static void gen_attn(DisasContext *ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV(ctx);
+#else
+    gen_helper_attn(tcg_env);
+#endif
+}
+
 /* brd */
 static void gen_brd(DisasContext *ctx)
 {
@@ -6513,6 +6523,7 @@ static void gen_brh(DisasContext *ctx)
 
 static opcode_t opcodes[] = {
 #if defined(TARGET_PPC64)
+GEN_HANDLER_E(attn, 0x00, 0x00, 0x08, 0xFFFFFDFF, PPC_NONE, PPC2_ATTN),
 GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA310),
 GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
 GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
-- 
2.42.0


