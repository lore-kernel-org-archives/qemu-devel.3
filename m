Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADB4CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI20-0005tT-Mk; Mon, 01 Sep 2025 23:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1n-0004mC-Eu
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1j-0004gS-QW
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rm9o012351
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /XtkofbAZfBFOGB7EfpPi54q1WneJlNbiChUs0mvYsc=; b=lFY0euds75ntjVJ/
 Gfnxxw3EGIvCaeqydCJN3x6e+Vm+UUWLPCau7Ia58HKKH6nJ51WHQfCZgR/MEKPO
 hLZkGVwBT5N7o34+lmdAUb6TUixZeG2z4b1DzutWta3FJzq9uq+xjdhMkjAaEmUf
 FDUgiDgdInk17DdaLV0kCwzg+vsdeNZBwtOib7S50BUTmmoIYZNXPRmJ/82BSz/r
 q71acnvxyUhLyX/RneC9uEgb67zWkGGHrOizTjijAUZ93rbEIJGIyvjXy2OjDS8g
 c5rSw590ruJ6eX0y/7JEPSscPZ5EtZQSBUEVeGgiqbLALDDR1gU4MLOwMToF57wg
 7No6LA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-329e3db861eso234173a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784975; x=1757389775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/XtkofbAZfBFOGB7EfpPi54q1WneJlNbiChUs0mvYsc=;
 b=dgdXSZnMTvU7vVS9L1rNaoyrMgcEOFqxMbvm4+37oPAQ3vB8sSyxGHG97EyLOzgGwf
 LyfrIZl5hKohjV7Jk4gHKzkHjmYmbN8+1s2ngPZPD6gTnmd11Z+kHgFafaRr+kg/XyhV
 XwggiDRQPCA3t+N4fj3tVMI9b0RYPXwwMli6OqFN+1m3w/tsRIUS5y2COEtgEF94DvDE
 Sqh4Nu+q8PwczW6C2cWYLbP/cndDR/sKQZ/ea+DWFqyZhb5pLe471U9SmPSpFBatdY/9
 L0sA7RuN517X0HbGBAzYSV3niP0MhcGqqMHjy0dLD3c9FKaFa3NdD3xEsxIjNAbPjDmq
 Q7UQ==
X-Gm-Message-State: AOJu0YxX4ppl2Xld8tm2USseAn9Thr6MQhBisWe36wkX9i0A+Epop2gT
 6l6P4uIsm8/IiD2Ufld7of9qLj5IZz5L2ENTXgoqWVTFxkLajADB7VCGPg8R9wv1bFxKqXOXQp5
 vwPOE5Ce6noUo7bYPtPQP3e5KKRsa0di6K0vsdwV1aZrLXKiEVpSL8Xt4z070WiDurAoj
X-Gm-Gg: ASbGncu4C32wKMKtD8FEiQsj/JwzB+s6OeVD0n7jebOSdujcJNxYR1b5dLJF37J1zrr
 XKquBOuDRVPJzC+lz8QLwk2CSW0rWhpvGo1+BUa1AABz+uJQ+/dvQ+Kj1Bb+KZbAGvtYJbMslA/
 yZhL5Dz9QNXD4Fg9gVlEFFhLzh3XnGCJbyhhXgTGEGHqhHfGNpYV4FAl73mjq7E+/XeKJCbfLop
 +mYg6zsM8hqIJKM+KiD+gXx6U6vKYwo/99ftjI5bq+n1vB+eDF6sCtTsXFrUEj3WnJJ3N0LCGDf
 /iVnTrqctFcS1tBH1LCYJBTejyQJLKXn7PycPRgD3UASIEUkankv8jfIoJGETKyUT94I/8bmoIb
 Yb3GotST7woDv
X-Received: by 2002:a17:90b:3d8f:b0:327:8c05:f8b0 with SMTP id
 98e67ed59e1d1-3281531d6e0mr13485550a91.0.1756784975000; 
 Mon, 01 Sep 2025 20:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Nil/yjE/x9qgOOxIJSMtOMx0OErqJ5KVVRKgBCPLxyhdB4yJn9xGAgjRaf71yrulq2NyAA==
X-Received: by 2002:a17:90b:3d8f:b0:327:8c05:f8b0 with SMTP id
 98e67ed59e1d1-3281531d6e0mr13485528a91.0.1756784974502; 
 Mon, 01 Sep 2025 20:49:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 35/39] target/hexagon: Define gen_precise_exception()
Date: Mon,  1 Sep 2025 20:48:43 -0700
Message-Id: <20250902034847.1948010-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXzOVYpvxn1Wtf
 gwRhyHALLNKuDfed4ynJL1V17uyFE+O/0HACYPHgjhZoyflbhOTH1TzmqyDYAvefPxKhlVaY8G7
 ivblKyLh+oqTsRqgyVrtVtVr1RGxFz57T8STiSZ6wDpQF0Kt8kBCUnwEQxOksi+wmHUk+1Xe46r
 /KCbCpPAPCSBRUhc4+FRdune93+dRXU8RSPrrJqbVsZ3FKxkUXgx08z3u4Izj9dh2CZRog09tk3
 PPUQFlnP6Y6DLbRA9ANNiGpdwq/1Mm4xUR9zpD7VmMuBjZGr6BpvP9yrg6Oj9IJdk/GcKq45aGa
 OmEp/Q6yClAe1NQeR0TlPH38MEfig9MLhRPpchn8e6kwlKbVqPWM636uhJplLEGAzgGcXlz2Ba2
 VxQngfd3
X-Proofpoint-ORIG-GUID: gIF6PZep3N9DCx0jU5ImRMkOaNhE34Zn
X-Proofpoint-GUID: gIF6PZep3N9DCx0jU5ImRMkOaNhE34Zn
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b66950 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=nvr5Al9PzyP1cg5pS9MA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Add PC to raise_exception helper

Replace the fGEN_TCG_J2_trap0 macro override with the fTRAP()-generated
system helper instead.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h   |  7 -------
 target/hexagon/helper.h    |  2 +-
 target/hexagon/op_helper.c | 10 ++++------
 target/hexagon/translate.c | 13 ++++++++-----
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 71f8a0e2d0..146aadc737 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1370,13 +1370,6 @@
 #define fGEN_TCG_S2_storew_rl_st_vi(SHORTCODE)          SHORTCODE
 #define fGEN_TCG_S4_stored_rl_st_vi(SHORTCODE)          SHORTCODE
 
-#define fGEN_TCG_J2_trap0(SHORTCODE) \
-    do { \
-        uiV = uiV; \
-        tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->pkt->pc); \
-        TCGv excp = tcg_constant_tl(HEX_EVENT_TRAP0); \
-        gen_helper_raise_exception(tcg_env, excp); \
-    } while (0)
 #endif
 
 #define fGEN_TCG_A2_nop(SHORTCODE) do { } while (0)
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index e107d74609..bd75c72abd 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -18,7 +18,7 @@
 #include "internal.h"
 #include "helper_protos_generated.h.inc"
 
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32)
+DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 5efd644fa7..6783e1e7d1 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -71,15 +71,13 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uint32_t exception,
                                             uintptr_t pc)
 {
-    CPUState *cs = env_cpu(env);
-    qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
-    cs->exception_index = exception;
-    cpu_loop_exit_restore(cs, pc);
+    do_raise_exception(env, exception, pc, 0);
 }
 
-G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp)
+G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp,
+                                        target_ulong PC)
 {
-    hexagon_raise_exception_err(env, excp, 0);
+    hexagon_raise_exception_err(env, excp, PC);
 }
 
 void log_store32(CPUHexagonState *env, target_ulong addr,
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 01a236d108..38c2037c47 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -122,9 +122,10 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
     return offset;
 }
 
-static void gen_exception_raw(int excp)
+static void gen_exception(int excp, target_ulong PC)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
+    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp),
+                               tcg_constant_tl(PC));
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -219,9 +220,11 @@ static void gen_end_tb(DisasContext *ctx)
 
 void hex_gen_exception_end_tb(DisasContext *ctx, int excp)
 {
-    gen_exec_counters(ctx);
-    tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->next_PC);
-    gen_exception_raw(excp);
+#ifdef CONFIG_USER_ONLY
+    gen_exception(excp, ctx->pkt->pc);
+#else
+    gen_precise_exception(excp, ctx->pkt->pc);
+#endif
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-- 
2.34.1


