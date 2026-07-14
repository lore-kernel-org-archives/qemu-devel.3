Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB08C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 01:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjRf8-0000Xz-6M; Mon, 13 Jul 2026 21:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjRew-0000OQ-CN
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjReu-0003j3-2j
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DNn25i2872035
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bpMJSLVbTXh1kGvXogZ1fWqLSGInuxUPC3mzcUBBCZs=; b=aXvIuBBNvu0Y2OmA
 YQS6+6Hhai+Sj72hkhTXy5+5zk4cJKalFJAi7qtmD6TTrXUnOyO5XKLWl8gddbwj
 Cg5BQO8cDUaxJcoURNw3ZuSdF34dXHDgMkQb0AhAaes+Z3GjtQbBvy8+H0FK9G2D
 tqumsRYQwuY5JE+vBy/ko456/lCWG1fhCDVoCX/wSG/fz1mm1s9HA3NL0e+pdpjU
 uIiKleOhv7pjC2GvojTKdgGokhEo+hVSU8kQrQE546yMnD0jWrETTUvSZ8QmjBQl
 T4iX/L6HrlpMnKpaecgjuYhr7I3JvB6+tVFLd4NbI6F6OX1VNPEAu4QtuRR9PvCa
 bEkkwQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44p1bm8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:10:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c891ed872ddso6530816a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783991400; x=1784596200; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bpMJSLVbTXh1kGvXogZ1fWqLSGInuxUPC3mzcUBBCZs=;
 b=jODVImmqiqZF3CcpO6rI5kuODFaxin66We4+2a5FyDEPfq/dJfiQDiuFBArBH+JFfv
 VA/GeJ6dZC5hH8/xvyjHKP5HBEZ0IjDpb9WoW3WeUJRxCq4LunYGqV4rgy0zr28JX5FE
 W5oKROSDrEfiGAa6lvMQEN+uIWK8+uJ8T1z39G2QixEXSnyw4JcGnrzaQgnJXNLuVicr
 tAynVPteTkQIzrQhTrY+8lELH0e8BA5F1xJ5K+B1TIdkg+iAaifQGsf/N+YX+4sFVaL+
 ehh5YD3FwprM055XOxSlQ2V3zSpad0aXIrupVMWdtTB6cbYE/vmxcvddbn2K/CFWntWo
 NNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783991400; x=1784596200;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bpMJSLVbTXh1kGvXogZ1fWqLSGInuxUPC3mzcUBBCZs=;
 b=reYr6BjyEjCWLFjEB3K8PRVZLPEhll60sMXJ8wzn6vaMooDpGN4GZmmQw8+WSfWC9W
 h4XrSVrSpnDKiQinehx/8ERGg4yKnqX4D4Lvauo2pjjwj1kmaUmn/RPw2dUcu9DAG9WJ
 4kkTBWQZDVnhuGrLLG1sLvv/ohIA5kTB87hah4QFa0JpnI8SM0ZZTQWJSIHwIQhXea52
 C6IEisSlLMTqlZfDFMixBcuBvIoql22RneOgCOO2W0GcrzFJ/HJaSi/O0/FP9Fcy3kQD
 QvPRceqloopk+qqUjHgW7JE9jQKPMuOGySjz83yyULd59bzjPfR1YJyaCrScwz02EXdE
 BH6Q==
X-Gm-Message-State: AOJu0YxUTvQ9BXybbun7N0uM8J9spMuwdKEmERkAGIGQ7IHkUzoQ5tHD
 rhjCZe7xSGO9rFd2N6ByxDhnF/yticlGnyxWaSkoXC8TcU6fKT1QMtSrpt1YGfYIjAnOKapztEF
 XkmiKPF7xDTOUOhf6X98h7ng69SRusxjnW9p/kuk+u8qFwhF59S0DochhowZZVH4nXw==
X-Gm-Gg: AfdE7cmA+UErlRZn1j5SlcGfIpe7e50mjHuRBbBVFPdcWSsATjqCVQrlQCNti82TknK
 Jk/30hDLPgy4klpPpzqDFgxciTD4tA5LiGJKdS1Ea2u1G+YsCAEpJl5/NnCYC6fp+IO4oy7yX3g
 t60Ed+puqLwK14enMhkP5ovYt9sWeMcDzWI1xIZzBE4UbHD89QgXllDpZkY8G9xbbTBUT9XvPs6
 Sv6394Nxbin0o5URnprM4fV4nWK8BlDbDyVscV6PjmwJO/i4Egc7HjspUvH2glJBGFx0hWlXL1f
 Pz6c6AmO+rsq3O6wPwDLjK/a8HuAU5AkcL+hldp3D0r9+kha7IZQnrPWPcvFfN9CZYYBVodgD8H
 9jNSDVyqROa0ObhCvV59vFvEX6N4Pkl3hNRR3IB711H+8GVeoBW2Hyb3uxuM=
X-Received: by 2002:a05:6a20:244f:b0:3c0:9c1a:893b with SMTP id
 adf61e73a8af0-3c34d8c0abfmr1795259637.67.1783991400312; 
 Mon, 13 Jul 2026 18:10:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:244f:b0:3c0:9c1a:893b with SMTP id
 adf61e73a8af0-3c34d8c0abfmr1795200637.67.1783991399801; 
 Mon, 13 Jul 2026 18:09:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accb0esm76826246eec.30.2026.07.13.18.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 18:09:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, Alessandro Di Federico <ale@rev.ng>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>, philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 2/5] target/hexagon: raise SIGBUS on unaligned scalar loads
Date: Mon, 13 Jul 2026 18:09:52 -0700
Message-Id: <20260714010955.2226493-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
References: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfX8ySKe89mThJu
 I+myGmWxVhtjvVany10mai/0K6pCVKvNiWtNC611iKFT4lca2evHVutU/eltVRdZIhoZhdZAlFI
 3ZukMr86heUI2HyWyefvNxwNxaUhUoQ=
X-Proofpoint-GUID: 8r0P4HcFLQG9_kf9gk7AWIRQC2NNI5zv
X-Proofpoint-ORIG-GUID: 8r0P4HcFLQG9_kf9gk7AWIRQC2NNI5zv
X-Authority-Analysis: v=2.4 cv=BZroFLt2 c=1 sm=1 tr=0 ts=6a558c68 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=f50odatAX-H4vQHS3akA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfX2F65Gzu1siie
 0/rhj0CCXMzhm1SfAidfWIaSEByj5wDQ6q6T2Uh61PGTVMAJ0PmUbMFkMm6R2rzNWEHgayDadma
 1tIq8KYRv6TAIL7EiMlfbC0PVE1YGUR6ae6WUkwGdUXyt3jbdLTdGfDSvWPhDdjOLAxzShkLr2P
 VDoMuXMj2ffOr945KIxwRwI7XAnAfc6A9K/mZ5ND7RPQnxk2sL2cNgdxA+mv09tPuGwVrW99M4K
 AF016fYE0Nm9tQOdtWvm/o7bFqPv2XfYiOUipOd9VJNgwu0LvmcXgO61HaWYTfRAfQ+UnXC5U1F
 M8Lm3JCkf1GQlzydux6SyyPy8FjiV+74XpKaL9A+fNWA+AGwIFJ3C2Jy+z3WZbs08FYH1Yi8D/x
 F/98piAZfLNachqh9sOYt7agU+bMKfGbgYxaGMYDKJmXR8KOGkEZYm2ToMi934UQjn8jLGDUtBi
 QCoFSjxxZofzbsF+Isg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140009
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
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


