Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71660C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 18:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvM2o-0006BG-Tq; Fri, 12 Apr 2024 14:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvM2n-0006Ax-8s
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 14:54:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvM2l-0002CC-7J
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 14:54:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e3f6f03594so9080725ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712948073; x=1713552873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZ+kbRmFLSxXOCXEYX8U7zcQtlpILH736gSWktrXyu0=;
 b=eUjKMwRNtZmLnU3bOtU965tMmF0tq+pnESwOgd9fvxHYfSzSI1cG5M2xTu+kxaLwf2
 AFgvcC7xsgq5LUTRtYZONYIEnMkFRIGLefgP5UeDsZ8M4UJf3LVK5JbzK/xiMFmGahZ0
 eTn7G61mYwwlTor5uzJAUAG2IHLPAiD56gBf6Fm0pG/eoyMkaXFSWsW9jos7EIFW632K
 xMHlBeD+gzSDWJcyqXx7p4tbSvWHJLscmfIFYu8KseBhsIFu97TgXlshJNvNPGD1UASd
 ncS3Zz42y/ZEXsDEd16vq6GNhrOF5sTzxBXFtkNpj61jRs9SbByF0ugqXLnWY+mDJi0m
 vLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712948073; x=1713552873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZ+kbRmFLSxXOCXEYX8U7zcQtlpILH736gSWktrXyu0=;
 b=Y1NZV5a3ezTubonruYs1ZwsrF5HozAo+inO52AUq/FQxALFB5OC+hIQEV6f+kLIjED
 wa8oO7bRCW5+te3XhS6Qkg32vPqCu7FBspRIMPsHDjU/x/7NDti9Rn8BxxW+FTBhWrAO
 SmMiMAZKRtOMa5XQa9kupz3apCPAvhf2qofKGT1BGviunxVfIkXfgkPH/Qzo0CIy8hdR
 ncOHIO4+GMQTAXrv403uO3oinvh5Yl2yUA9FdMZjkTyV/jYamJQQUe/E00rwPp95JB60
 8eOvjE6dRDBLRBSaq8P1YhOVSTZBPJnsmEQqNx7yjAXptoG85wXbSgoFlsqOcjUuQ6qA
 gVeA==
X-Gm-Message-State: AOJu0Yxcu3dcm+cBLoENEpehMfqMLRdCYSbDcGGUUm5/MIAdRdkBfBmA
 k74ykN1zfyHhVIZOGuX6ovuTsYxhzWOUb1rfXS8mlA3L2MYNQqQk8FPt/QsJ9YaW3B2dJywQxha
 k
X-Google-Smtp-Source: AGHT+IEcQIlq2qEPL09YFb7vhapDHYDzkYQK4WdOouUHLIfL9jC3I5zJ/eQrNhk8LHOfVhB7Tu58gg==
X-Received: by 2002:a17:902:8e81:b0:1e4:514a:55af with SMTP id
 bg1-20020a1709028e8100b001e4514a55afmr2372427plb.68.1712948073513; 
 Fri, 12 Apr 2024 11:54:33 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a170902ce9200b001e511acfd0esm3319070plg.140.2024.04.12.11.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:54:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 1/1] target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and
 ASI_USERTXT
Date: Fri, 12 Apr 2024 11:54:31 -0700
Message-Id: <20240412185431.465942-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412185431.465942-1-richard.henderson@linaro.org>
References: <20240412185431.465942-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reads are done with execute access.  It is not clear whether writes
are legal at all -- for now, leave helper_st_asi unchanged, so that
we continue to raise an mmu fault.

This generalizes the exiting code for ASI_KERNELTXT to be usable for
ASI_USERTXT as well, by passing down the MemOpIdx to use.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2281
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2059
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1609
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1166
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/helper.h      |  3 ++
 target/sparc/ldst_helper.c | 65 ++++++++++++++++++++++++++------------
 target/sparc/translate.c   | 48 ++++++++++++++++++++++++++--
 3 files changed, 94 insertions(+), 22 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index e55fad5b8c..b8087d0d2b 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -32,6 +32,9 @@ DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_WG, i64, env, tl, tl)
 DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_WG, i64, env, tl, tl)
 DEF_HELPER_3(taddcctv, tl, env, tl, tl)
 DEF_HELPER_3(tsubcctv, tl, env, tl, tl)
+#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
+DEF_HELPER_FLAGS_3(ld_code, TCG_CALL_NO_WG, i64, env, tl, i32)
+#endif
 #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
 DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index e581bb42ac..2846a86cc4 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -585,7 +585,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
 #if defined(DEBUG_MXCC) || defined(DEBUG_ASI)
     uint32_t last_addr = addr;
 #endif
-    MemOpIdx oi;
 
     do_check_align(env, addr, size - 1, GETPC());
     switch (asi) {
@@ -684,24 +683,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_M_DIAGS:   /* Turbosparc DTLB Diagnostic */
     case ASI_M_IODIAG:  /* Turbosparc IOTLB Diagnostic */
         break;
-    case ASI_KERNELTXT: /* Supervisor code access */
-        oi = make_memop_idx(memop, cpu_mmu_index(env_cpu(env), true));
-        switch (size) {
-        case 1:
-            ret = cpu_ldb_code_mmu(env, addr, oi, GETPC());
-            break;
-        case 2:
-            ret = cpu_ldw_code_mmu(env, addr, oi, GETPC());
-            break;
-        default:
-        case 4:
-            ret = cpu_ldl_code_mmu(env, addr, oi, GETPC());
-            break;
-        case 8:
-            ret = cpu_ldq_code_mmu(env, addr, oi, GETPC());
-            break;
-        }
-        break;
     case ASI_M_TXTC_TAG:   /* SparcStation 5 I-cache tag */
     case ASI_M_TXTC_DATA:  /* SparcStation 5 I-cache data */
     case ASI_M_DATAC_TAG:  /* SparcStation 5 D-cache tag */
@@ -779,7 +760,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case 0x4c: /* SuperSPARC MMU Breakpoint Action */
         ret = env->mmubpaction;
         break;
-    case ASI_USERTXT: /* User code access, XXX */
     default:
         sparc_raise_mmu_fault(cs, addr, false, false, asi, size, GETPC());
         ret = 0;
@@ -787,6 +767,8 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
 
     case ASI_USERDATA: /* User data access */
     case ASI_KERNELDATA: /* Supervisor data access */
+    case ASI_USERTXT: /* User code access */
+    case ASI_KERNELTXT: /* Supervisor code access */
     case ASI_P: /* Implicit primary context data access (v9 only?) */
     case ASI_M_BYPASS:    /* MMU passthrough */
     case ASI_LEON_BYPASS: /* LEON MMU passthrough */
@@ -1161,6 +1143,49 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
 #endif
 }
 
+uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+    uintptr_t ra = GETPC();
+    uint64_t ret;
+
+    switch (mop & MO_SIZE) {
+    case MO_8:
+        ret = cpu_ldb_code_mmu(env, addr, oi, ra);
+        if (mop & MO_SIGN) {
+            ret = (int8_t)ret;
+        }
+        break;
+    case MO_16:
+        ret = cpu_ldw_code_mmu(env, addr, oi, ra);
+        if ((mop & MO_BSWAP) != MO_TE) {
+            ret = bswap16(ret);
+        }
+        if (mop & MO_SIGN) {
+            ret = (int16_t)ret;
+        }
+        break;
+    case MO_32:
+        ret = cpu_ldl_code_mmu(env, addr, oi, ra);
+        if ((mop & MO_BSWAP) != MO_TE) {
+            ret = bswap32(ret);
+        }
+        if (mop & MO_SIGN) {
+            ret = (int32_t)ret;
+        }
+        break;
+    case MO_64:
+        ret = cpu_ldq_code_mmu(env, addr, oi, ra);
+        if ((mop & MO_BSWAP) != MO_TE) {
+            ret = bswap64(ret);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return ret;
+}
+
 #endif /* CONFIG_USER_ONLY */
 #else /* TARGET_SPARC64 */
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 319934d9bd..571b3e3f03 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1117,6 +1117,7 @@ typedef enum {
     GET_ASI_EXCP,
     GET_ASI_DIRECT,
     GET_ASI_DTWINX,
+    GET_ASI_CODE,
     GET_ASI_BLOCK,
     GET_ASI_SHORT,
     GET_ASI_BCOPY,
@@ -1159,14 +1160,22 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
                || (asi == ASI_USERDATA
                    && (dc->def->features & CPU_FEATURE_CASA))) {
         switch (asi) {
-        case ASI_USERDATA:   /* User data access */
+        case ASI_USERDATA:    /* User data access */
             mem_idx = MMU_USER_IDX;
             type = GET_ASI_DIRECT;
             break;
-        case ASI_KERNELDATA: /* Supervisor data access */
+        case ASI_KERNELDATA:  /* Supervisor data access */
             mem_idx = MMU_KERNEL_IDX;
             type = GET_ASI_DIRECT;
             break;
+        case ASI_USERTXT:     /* User text access */
+            mem_idx = MMU_USER_IDX;
+            type = GET_ASI_CODE;
+            break;
+        case ASI_KERNELTXT:   /* Supervisor text access */
+            mem_idx = MMU_KERNEL_IDX;
+            type = GET_ASI_CODE;
+            break;
         case ASI_M_BYPASS:    /* MMU passthrough */
         case ASI_LEON_BYPASS: /* LEON MMU passthrough */
             mem_idx = MMU_PHYS_IDX;
@@ -1379,6 +1388,21 @@ static void gen_ld_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
     case GET_ASI_DIRECT:
         tcg_gen_qemu_ld_tl(dst, addr, da->mem_idx, da->memop | MO_ALIGN);
         break;
+
+    case GET_ASI_CODE:
+#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
+        {
+            MemOpIdx oi = make_memop_idx(da->memop, da->mem_idx);
+            TCGv_i64 t64 = tcg_temp_new_i64();
+
+            gen_helper_ld_code(t64, tcg_env, addr, tcg_constant_i32(oi));
+            tcg_gen_trunc_i64_tl(dst, t64);
+        }
+        break;
+#else
+        g_assert_not_reached();
+#endif
+
     default:
         {
             TCGv_i32 r_asi = tcg_constant_i32(da->asi);
@@ -1791,6 +1815,26 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
         }
         break;
 
+    case GET_ASI_CODE:
+#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
+        {
+            MemOpIdx oi = make_memop_idx(da->memop, da->mem_idx);
+            TCGv_i64 tmp = tcg_temp_new_i64();
+
+            gen_helper_ld_code(tmp, tcg_env, addr, tcg_constant_i32(oi));
+
+            /* See above.  */
+            if ((da->memop & MO_BSWAP) == MO_TE) {
+                tcg_gen_extr_i64_tl(lo, hi, tmp);
+            } else {
+                tcg_gen_extr_i64_tl(hi, lo, tmp);
+            }
+        }
+        break;
+#else
+        g_assert_not_reached();
+#endif
+
     default:
         /* ??? In theory we've handled all of the ASIs that are valid
            for ldda, and this should raise DAE_invalid_asi.  However,
-- 
2.34.1


