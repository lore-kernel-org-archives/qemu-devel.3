Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75CECC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3ft-0003ua-1K; Wed, 14 Oct 2026 14:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fp-0003to-BG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:25:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fn-0001yg-AD
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:25:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EF4Eds4167050
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8tcXoF4WiLi
 P9yQdNOY2HjQmGqLfQ2lhGyu03GwuUEE=; b=i4tccuLlSTAaQ9ncOh53O+uOPMB
 P9h0rAtbX3c6CiHEwGeJNExZ9EsaQU8Gnq4WOnL295ZIqupC4pjgRiB6WBJUG6h/
 fVA9gFmpCSnr6K7Xlky7VngA/YNquIduAiiARAsVNXaJg77xxekleyBjzP8zHL12
 rIwlPsqEtLPyclPOc6ILdGoy+FtDfCmciRDt8yL/fq8uc2pd3M6eGwAXUZSB5R2h
 WhR8svSufqViWIxXTIWs8fVd8FEAM17fMRpct/xux9TUrauTDUA+iZuEni/Vi7rf
 ylJlQIsu7S78qt+0wpjjUttCoLMOzMk6A1K/t3G9cJR9aNiGi8LTc4j1TrA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac230th2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:25:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c3c370b17so4265709eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002353; x=1792607153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8tcXoF4WiLiP9yQdNOY2HjQmGqLfQ2lhGyu03GwuUEE=;
 b=ae2LAGSZWO8PgrmRlQz2lf2yoLr755n15PueYWHZ/dEoRK/9PRWFiBe2gTHwxBHEEE
 SvP8+ksgkwvkd2W/e/eG7E8XewvZs+7v7u0nzYbJRghQ5xwJveSXVj/nq3AgntxHbx17
 2RmCPF9Pzg8KRUHFiQqm8sz2u17QHhWSp3GbeTyHLBA3UDUrheRc1OW8S7Zk97sOSH+B
 1FOu4PQJMkXQrFWZILC3rZxOpon3IYZQS47NCSr6cH8yaPPiTdLBN4dItdzvKde+1upT
 4lktvYt2uTZdNHUBoV+MqBIvc3oHodK7QLaxz2VWIc88kozhBGgt0FdBKIEVMKYt2vjv
 wdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002353; x=1792607153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8tcXoF4WiLiP9yQdNOY2HjQmGqLfQ2lhGyu03GwuUEE=;
 b=xAzzY9gHNlMDTNIVEObgRjv8yJzAHuVZd9eCjld+kVQMYv6chqQdusMrX4SMdVB8cc
 YWMBF+uymfjHmFV3Aa30h0p7g2jJ5EU2D7SyEfL1+Jm3LVxgrwed+W7xnzwK2CVtIe17
 ESc2GjmyeBYsMKzOmZWIMsh40BPhffLMuNlImwnefoQ06+LOopVYCOuxe5yJKV5kS6J4
 VrffyS3AbN0oHfqU4LOIpJv/B9Kz8DXaDoOdrJDMXGeVnFwHi1+94NsfIlsDCUT3LsJO
 e5jBE+7r7X5t3kPAdq4sQfwvuoSoe0t9MvQXHgeBDDjRHPQroL5+FenN1lhHRfVlW2Uy
 dBVg==
X-Gm-Message-State: AFq9FYJ6iIMHk7ecdAlFWQa9pw+sJfjimH2qzKyqkGEvY5+1o9X6SFX0
 XoAA/JYmzVHafc57J5TtcR5YFyxLomDDm7QeRllyROd9UQ1oWI36b47p50hRRTM/49+fLczN5Yc
 3uC0luwuRu6u0igz4tTTCGGFySj0rO8ExbftDHGBk/CjOt+voMp0lP9XeLcvfG4L1UQ==
X-Gm-Gg: AYBFou2ywD3+U4ExkZNyQmJSK5DoSQKNQIdGd4sf3Su6A4XsWjEeM3H3Ny/qXDYHglf
 nbwc8weliXvXzkdlzjCK9KAzjpV6n7QjXUinU/O4InKVb9mtzSslkpIGdJN+cb2NRZef1oAluNI
 RPFpORi2QOIno7N/PlHveqJtHIxPecT+6RuyDaCUFA0cYq+/Ij2uc91XQ8bLMMJRyGqBfOCvwqw
 9rflMc2YSssU15eOiRqVlHiANTRSjGcDxv+9UcMKXfR3ZY99/lgrjxQLD/jtYviK9c0uaB2AmPh
 Dnnq7ZjkrrQRePQ7UzSGeh7a5iqeN2RVZU80484ACmmkQsBHfyFjKFOaRO9Rq5oGP3F7qconS4c
 T5+nQ4A6aogzqJKxshzkFOE3RwNkwWPQFX2X+Wr1pToeFur9r+nKjdNFhzKFs
X-Received: by 2002:a05:7022:ea8a:b0:13e:6efa:78f7 with SMTP id
 a92af1059eb24-16a5dc00e99mr20614549c88.15.1792002352490; 
 Wed, 14 Oct 2026 11:25:52 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8a:b0:13e:6efa:78f7 with SMTP id
 a92af1059eb24-16a5dc00e99mr20614508c88.15.1792002351790; 
 Wed, 14 Oct 2026 11:25:51 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:25:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 01/11] target/hexagon: prefix helpers conflicting with
 other arch
Date: Wed, 14 Oct 2026 18:25:33 +0000
Message-ID: <20261014182543.135965-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6acfc931 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=0Tj3Q07uUtPDLrELhAkA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX/oTyiIyuR++q
 osgZ05ZS1Py/rSdkpRIWJ1WJIPZ2FQBvNXel0QfAR71FDlYKuWPAFmBdKdKB2rmSkPFcVToOubg
 uEITKEczpu/7/N/nzbJmi90GY3nm1CU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX0RKv9xCw0om6
 udlwUulD8FyNESmaB3dEA99npBvKT0sQSOb/TH7QHNjJJ/y+dJ5mQhfqpniCEoJOJPZCa/H9Vzo
 18oOcdB+XZrjMoxFcv1Fq69DRtctxZmYVuk7Cav4TaNgahcUpq2h1oK7nFW5+2G0dbOu4cEiuHm
 s9Dmxa29rGjP3PK2JW45ZC1DBfcZdftfGx/M+RmR3FgmeNI830papBDeTkYNZDu/GGsF7LKR+12
 tMZRoFxeji6KJukQhiYfIxMC7eHg/U3gi9PlvRt6LYd4cZI//zd3kRgDjHGoNWMVnlcXhvbqzle
 eOmwUi3oMZGEJ1222ECU5w+m0qO46HiubVrmA0aYUw7OEAbDOO3jG9k36381XT+GialG8BoIPx7
 5VaX1t77BI0rx4+3lha22fyuioyhOY34CqfB3PJRbcX3HR0uNFQ1pjlzEdYUR7Z22D+aKDpnoDw
 Zfr4wo+VBzCnPOhsDnA==
X-Proofpoint-GUID: yBTqFiSHZMVnx6U28DvXoK9BS1NF1q4h
X-Proofpoint-ORIG-GUID: yBTqFiSHZMVnx6U28DvXoK9BS1NF1q4h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h     | 2 +-
 target/hexagon/gen_tcg_sys.h | 2 +-
 target/hexagon/helper.h      | 4 ++--
 target/hexagon/hex_mmu.c     | 2 +-
 target/hexagon/hex_mmu.h     | 2 +-
 target/hexagon/op_helper.c   | 4 ++--
 target/hexagon/translate.c   | 4 ++--
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 80d8a7b6bac..ed05f97efed 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1135,7 +1135,7 @@
 #define fGEN_TCG_J2_pause(SHORTCODE) \
     do { \
         uiV = uiV; \
-        gen_helper_raise_exception(tcg_env, \
+        gen_helper_hexagon_raise_exception(tcg_env, \
             tcg_constant_i32(EXCP_YIELD), \
             tcg_constant_i32(ctx->next_PC)); \
     } while (0)
diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index c9f6b41a877..91ae3421f64 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -80,7 +80,7 @@
 #define fGEN_TCG_Y2_wait(SHORTCODE) \
     do { \
         RsV = RsV; \
-        gen_helper_wait(tcg_env); \
+        gen_helper_hexagon_wait(tcg_env); \
     } while (0)
 
 #define fGEN_TCG_Y2_resume(SHORTCODE) \
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 997d87e38e6..b97295f243a 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -18,7 +18,7 @@
 #include "internal.h"
 #include "helper_protos_generated.h.inc"
 
-DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
+DEF_HELPER_FLAGS_3(hexagon_raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
@@ -136,7 +136,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
 DEF_HELPER_3(setprio, void, env, i32, i32)
 DEF_HELPER_2(start, void, env, i32)
 DEF_HELPER_1(stop, void, env)
-DEF_HELPER_1(wait, void, env)
+DEF_HELPER_1(hexagon_wait, void, env)
 DEF_HELPER_2(resume, void, env, i32)
 DEF_HELPER_1(resched, void, env)
 DEF_HELPER_3(modify_ssr, void, env, i32, i32)
diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
index 0ca52ed666d..f98585a1d24 100644
--- a/target/hexagon/hex_mmu.c
+++ b/target/hexagon/hex_mmu.c
@@ -115,7 +115,7 @@ int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t index)
 }
 
 #ifdef CONFIG_HMP
-void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
+void hexagon_dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
 {
     HexagonCPU *cpu = env_archcpu(env);
     hexagon_tlb_dump(hmp, cpu->tlb);
diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
index 977a97da31a..2cfcd10949a 100644
--- a/target/hexagon/hex_mmu.h
+++ b/target/hexagon/hex_mmu.h
@@ -24,5 +24,5 @@ extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
                                  uint64_t index);
 extern void hex_tlb_lock(CPUHexagonState *env, uint32_t PC);
 extern void hex_tlb_unlock(CPUHexagonState *env);
-void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
+void hexagon_dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index accadd7927a..199a2827f96 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -93,7 +93,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
     do_raise_exception(env, exception, pc, 0);
 }
 
-G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp,
+G_NORETURN void HELPER(hexagon_raise_exception)(CPUHexagonState *env, uint32_t excp,
                                         uint32_t PC)
 {
     hexagon_raise_exception_err(env, excp, PC);
@@ -1837,7 +1837,7 @@ void HELPER(resched)(CPUHexagonState *env)
     resched(env);
 }
 
-void HELPER(wait)(CPUHexagonState *env)
+void HELPER(hexagon_wait)(CPUHexagonState *env)
 {
     BQL_LOCK_GUARD();
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index cd1abdf1461..ee8588e0677 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -140,7 +140,7 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
 static void gen_precise_exception(int cause, uint32_t PC)
 {
     tcg_gen_movi_i32(hex_cause_code, cause);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
+    gen_helper_hexagon_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
                                tcg_constant_i32(PC));
 }
 
@@ -1163,7 +1163,7 @@ static void check_imprecise_exception(DisasContext *ctx)
     TCGLabel *label = gen_new_label();
 
     tcg_gen_brcondi_tl(TCG_COND_EQ, hex_imprecise_exception, 0, label);
-    gen_helper_raise_exception(tcg_env, hex_imprecise_exception, PC);
+    gen_helper_hexagon_raise_exception(tcg_env, hex_imprecise_exception, PC);
     gen_set_label(label);
 }
 #endif
-- 
2.43.0


