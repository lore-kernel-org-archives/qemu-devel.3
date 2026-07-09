Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B770C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 23:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whyGU-0004t6-6K; Thu, 09 Jul 2026 19:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whyGS-0004sE-FV
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:34:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whyGQ-0007RI-HF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:34:44 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669KZKM22917939
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 23:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2CGMyPorS3RnTbOgvFXXSiw5DC8Rps4clQw48tKsp4g=; b=eq/Awij000Q3MXrx
 bt6tHyR1k3Wgnq5B3lEK51rJM4scK+BZTtyulvCnKW0w2KW5Nhxiw5IbLTK1Jd7M
 KTPWUO/A08CmrJFwp2o8Qo9gHeARg96vPThy6kBifmyXU5bZEFPezdqri3E3tyO7
 Yx2+hJxuG2wrZLZuRc3Z1+/SVYOXhg5RL/BxW0H+ATteCaHPN01wmbc5oc1rWa3m
 Nbh2Gt5wk3kpgPoMwQI2S2Xa6JpfBqmeWrxeOlNblmxyTMWsfus98ZGFG1yEPbUD
 r8weHFiz3OCtbA9JR9NE26WEKVtKMChKzkX9ck+PJdlb/yJqm4DJcVgOOV5N5mK4
 D33Sjw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte0gkm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:34:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-383b6012ba4so609832a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783640080; x=1784244880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2CGMyPorS3RnTbOgvFXXSiw5DC8Rps4clQw48tKsp4g=;
 b=djuPfOgUPQM1PmGTZFKhJUDujCzpYGYXlflRno3gKExX/V8bHdFnsnn86e9yrFlSxD
 zNe0mkkgVY4VvKEo/tONtd1Tq1UTd5tQARAzasp2/voXId5Wvj74KRFSbC6tv7PVwmY2
 W2EALE34IuUJrbKk5lsaEhln4FdDTyKstefCHhFXMv+BMfrF2So23TqlAgBZi5XMDnP5
 DxL4ZCs9KO7O7D/JuNx9u7CfgN3RATLvqJ1ujrFPGLsQT3WEYU1Fg5Y1qGHfeOrwOUqz
 UljGXBJhSBjZZibV/DBE9CNOD+e8T2AXrYx9SSdcoqVgGzbrO6rlit+cddPapinIsSVP
 cIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783640080; x=1784244880;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2CGMyPorS3RnTbOgvFXXSiw5DC8Rps4clQw48tKsp4g=;
 b=fz9GaT7Sl5bto4CuUKAxZHAaJmcYF/+ElBAzrgyHblHansEciHsbAi67D8dVJkdxxZ
 xoDAVXIkgh7blfVprJJcKGBhHVzgsbICsFNofEagPmm2R9XzDOyUISGGBFFvefRxAUY3
 D7enfqndw3bJYlaFgkvFCPCeQaaaFmBzpuDoGD1JtWAY9Mdq6wh9FBGKvT5mHfMSCnMs
 VXa/jkNu2fkEb6z45Mrdwm07/kWZRiN1RNylUb73/nJnhRCflXYTUohrGgGEWfNdnScX
 dFT3UH2ICHc9ORFCIw2mJySdQha4+0/XvrxomJNWo0Sn3JKSBto/V+o2J4vHnCFZlpqX
 Gwag==
X-Gm-Message-State: AOJu0YyA7u6TA+NIOI78J1KHPikUSqf8+umBvHwZyyGbrgwR6jduIZVO
 u2HK55IXzJlqg0DzMCZuZPpyNdxh4zJwQSqwLX9+Lvaxo0vzMsmniofdhZIgZI6SdXwI8qQ6oid
 1JKxRigzlk1v96hXv10xLYm2kh6Jknt5640eezt0VxNfg3Wb4lIcGIYQFgrM1G9XZYQ==
X-Gm-Gg: AfdE7cn9ZlPRPsW1+LnXi3GqTqzZJrpCAR1qOdQL7Kj/8w4bXk7vOSvNoskiz3Hclal
 LkzHSR2UFZfBj28QO5d039lZ0JCk5s07ehGtgsEGJNdb829lBZVKhXvfhPVGxakIfyGGdvBqLoc
 qqn2xBWxJjPhAYDJ1rE0tfqUtgwqPNGXIYjHcnI/2126RyTOv0UcUCertvBvVrC/2NJtRHwcoau
 dslMy7627sY3uNGLmzlWwqV1UltYvPnUD4WLcVijoH2eqSsLfyhuVdsz0OoaQboCr7uYYGoYHYS
 tP2QJaXNX6bo0ER8GBLafuAYlueeLFIFoOoPvB4danH0+z7s3qHKrFwI6YzJIJ5nOmO3m25V3UH
 1Ht4aUXbH9TYxcZyR6tLa0Y30ddXm+o10KO8eZb0nL6cr6Tx4oKUdS2oZlpM=
X-Received: by 2002:a17:90b:3d83:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-3893f693984mr9513420a91.4.1783640079947; 
 Thu, 09 Jul 2026 16:34:39 -0700 (PDT)
X-Received: by 2002:a17:90b:3d83:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-3893f693984mr9513395a91.4.1783640079431; 
 Thu, 09 Jul 2026 16:34:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm25447189eec.20.2026.07.09.16.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 16:34:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, matheus.bernardino@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>
Subject: [PATCH 1/4] target/hexagon: raise SIGBUS on unaligned scalar loads
Date: Thu,  9 Jul 2026 16:34:33 -0700
Message-Id: <20260709233436.3075100-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
References: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qzPDGMnoQtKm6Z4I99tIIej9V4pTQiU-
X-Proofpoint-ORIG-GUID: qzPDGMnoQtKm6Z4I99tIIej9V4pTQiU-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIzNSBTYWx0ZWRfX0Bksq7sXWURf
 ih1QbBuj4IfAFAHxMDbLjseEY8hO6M2Y3w5tm7Bxmi+SWh/xVaadwaQLcVKa7TuwHnqOkLSxnEl
 N+EbyZEzbd45KywwH1riF8755YiELWeh7p0FZ5k0P/5v8v/bi58KAADgq1YCrEf4Lm2mX359gm3
 sMDV1CO6Gg+OBDsZolfKZyi55SFSw9E8b8gVF32onPuG0CBSeoictyzYmL1GyHsE6V/ihB5vkcw
 RmTh6uGfPlvdso+9Ak4EkZdlDNG0wJtX1iH7IvFlnztDJ0g3K0nZ6wKClsgiPP0xngDnzuRNdQ6
 N5nbmVuxdj/FJVaU7X6cF2rpMbQWc/nrRc5VFKjlU6V6ncQa6K9qGq6nhkHg5tJ2LLT9yQADOEr
 htJ1do2jwvSMgZSSmhet3P4b3t5zEsS6oCbevQnPtJkeyb7/avgLXitDMfg83A5LjTXx3fkbKg6
 Uk6RjsdRH5imuQmqxjw==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a503010 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=f50odatAX-H4vQHS3akA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIzNSBTYWx0ZWRfX9xMfzgSL1rA6
 RJMLaGWSo6Xb1sJGigf2Xvsts10a/hsP4YgdEXvwQetGw/yrFAqsicl3NU5hZJOovvR8FTlJaJV
 c82wHv8nKaqa/7IbK+NmQeDOWdk8NzM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090235
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

hexagon-linux-user had no enforcement of alignment for scalar load
exceptions, and unaligned loads silently succeeded instead of raising
SIGBUS.

Add MO_ALIGN to the MEM_LOAD* macros, the locked-load and
load-frame helpers in genptr.c, and the idef-parser's fLOAD.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/genptr.c                     |  6 ++---
 target/hexagon/idef-parser/parser-helpers.c |  2 +-
 target/hexagon/macros.h                     | 26 +++++++++++++--------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 1ebc7471409..05c9aa04467 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -470,14 +470,14 @@ void gen_set_byte_i64(int N, TCGv_i64 result, TCGv src)
 
 static inline void gen_load_locked4u(TCGv dest, TCGv vaddr, int mem_index)
 {
-    tcg_gen_qemu_ld_tl(dest, vaddr, mem_index, MO_LE | MO_UL);
+    tcg_gen_qemu_ld_tl(dest, vaddr, mem_index, MO_LE | MO_UL | MO_ALIGN);
     tcg_gen_mov_tl(hex_llsc_addr, vaddr);
     tcg_gen_mov_tl(hex_llsc_val, dest);
 }
 
 static inline void gen_load_locked8u(TCGv_i64 dest, TCGv vaddr, int mem_index)
 {
-    tcg_gen_qemu_ld_i64(dest, vaddr, mem_index, MO_LE | MO_UQ);
+    tcg_gen_qemu_ld_i64(dest, vaddr, mem_index, MO_LE | MO_UQ | MO_ALIGN);
     tcg_gen_mov_tl(hex_llsc_addr, vaddr);
     tcg_gen_mov_i64(hex_llsc_val_i64, dest);
 }
@@ -890,7 +890,7 @@ static void gen_load_frame(DisasContext *ctx, TCGv_i64 frame, TCGv EA)
 {
     Insn *insn = ctx->insn;  /* Needed for CHECK_NOSHUF */
     CHECK_NOSHUF(EA, 8);
-    tcg_gen_qemu_ld_i64(frame, EA, ctx->mem_idx, MO_LE | MO_UQ);
+    tcg_gen_qemu_ld_i64(frame, EA, ctx->mem_idx, MO_LE | MO_UQ | MO_ALIGN);
 }
 
 /* Stack overflow check */
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index b942d9ea16b..49cc11fddd8 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -1770,7 +1770,7 @@ void gen_load(Context *c, YYLTYPE *locp, HexValue *width,
     if (signedness == SIGNED) {
         OUT(c, locp, " | MO_SIGN");
     }
-    OUT(c, locp, " | MO_LE);\n");
+    OUT(c, locp, " | MO_LE | MO_ALIGN);\n");
 }
 
 void gen_store(Context *c, YYLTYPE *locp, HexValue *width, HexValue *ea,
diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 21ab8ae5bbf..b439e31974c 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -106,37 +106,37 @@
 #define MEM_LOAD1s(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 1); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_SB); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_SB | MO_ALIGN); \
     } while (0)
 #define MEM_LOAD1u(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 1); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_UB); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_UB | MO_ALIGN); \
     } while (0)
 #define MEM_LOAD2s(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 2); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_SW); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_SW | MO_ALIGN); \
     } while (0)
 #define MEM_LOAD2u(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 2); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_UW); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_UW | MO_ALIGN); \
     } while (0)
 #define MEM_LOAD4s(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 4); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_SL); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_SL | MO_ALIGN); \
     } while (0)
 #define MEM_LOAD4u(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 4); \
-        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_UL); \
+        tcg_gen_qemu_ld_tl(DST, VA, ctx->mem_idx, MO_LE | MO_UL | MO_ALIGN); \
     } while (0)
 #define MEM_LOAD8u(DST, VA) \
     do { \
         CHECK_NOSHUF(VA, 8); \
-        tcg_gen_qemu_ld_i64(DST, VA, ctx->mem_idx, MO_LE | MO_UQ); \
+        tcg_gen_qemu_ld_i64(DST, VA, ctx->mem_idx, MO_LE | MO_UQ | MO_ALIGN); \
     } while (0)
 
 #define MEM_STORE1_FUNC(X) \
@@ -519,9 +519,15 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #define fLOAD(NUM, SIZE, SIGN, EA, DST) MEM_LOAD##SIZE##SIGN(DST, EA)
 #else
 #define MEM_LOAD1 cpu_ldub_data_ra
-#define MEM_LOAD2 cpu_lduw_le_data_ra
-#define MEM_LOAD4 cpu_ldl_le_data_ra
-#define MEM_LOAD8 cpu_ldq_le_data_ra
+#define MEM_LOAD2(ENV, EA, RA) \
+    cpu_ldw_mmu(ENV, EA, make_memop_idx(MO_LEUW | MO_ALIGN, \
+                                        cpu_mmu_index(env_cpu(ENV), false)), RA)
+#define MEM_LOAD4(ENV, EA, RA) \
+    cpu_ldl_mmu(ENV, EA, make_memop_idx(MO_LEUL | MO_ALIGN, \
+                                        cpu_mmu_index(env_cpu(ENV), false)), RA)
+#define MEM_LOAD8(ENV, EA, RA) \
+    cpu_ldq_mmu(ENV, EA, make_memop_idx(MO_LEUQ | MO_ALIGN, \
+                                        cpu_mmu_index(env_cpu(ENV), false)), RA)
 
 #define fLOAD(NUM, SIZE, SIGN, EA, DST) \
     do { \
-- 
2.34.1


