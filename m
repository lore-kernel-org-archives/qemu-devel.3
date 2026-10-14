Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C4DCC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6AZ-0001ME-1C; Wed, 14 Oct 2026 17:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6AX-0001LM-DC
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6AV-0000h7-Hy
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EF4I7X4167121
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8tcXoF4WiLi
 P9yQdNOY2HjQmGqLfQ2lhGyu03GwuUEE=; b=Eu3WSiy6hQxJ58WXTAhguRGh32T
 hIyim5YAED21lijbQ8Y1OdmUVG8mgK/X+KXkRaSxQwqZKLs0D4RsA1zKoSl/XdEc
 XFkw8hI3nfHb3aiWftYUD4KqdFgem4jllYVFNtzLuhvvnFwutePf8W8Eh2tXQ7iT
 zrcdTqwSkXdylKUU3mihmccDyVnfr1wTb0jgZC+Mb286O0RGaJ8WFKUsA8FNv0o3
 U8s+U393ClPDC18zTM39BIfUcGocYF3tegwiLWdU22A7CemCW8+GwgqKFEKLa/GH
 9S6wuHIKpJxj7XvBXtzyN0ZBIthWL/zvhlBvlBFrwsLVIdzpsaqwlF8JSxA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac231bfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so2087757eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011945; x=1792616745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8tcXoF4WiLiP9yQdNOY2HjQmGqLfQ2lhGyu03GwuUEE=;
 b=RU07CTu96CG8ZFe8nk6noGd2q0vHoqqqNy1vT+KPd/T0CbiP4nwCjfK9F1x3KA6EPY
 3uVJKupE6GXrxz6G5JbXKPIIB4a7im3GERp7Tn2ih3XbE4fre41BIGBN0K7ifiihZTR0
 Yhx9Ct0a98z0goSkT90S08v+tKACgAfbE0E07XKZZgZPmJg6qFiNqtNStcySZTXNLZ/b
 ElU7GSZ0XlvWcNrgaXMwXvBlfaqeRedpC4UHUhRYLKPd1U7l/mkY77u/2+m+2s/vxBx9
 movYykmCD6wwUxQ8+D1/Z9OjpDYogd1jaR44LaFCXcelNoZ6ympLXRuF8ZA9FaqzC1HD
 l5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011945; x=1792616745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8tcXoF4WiLiP9yQdNOY2HjQmGqLfQ2lhGyu03GwuUEE=;
 b=VvbOgECeYusZoCfysj80lZ9xZMSuVSuoGcwkmCsCGhwv4llxfowOoaY4aoIsIaxXlC
 15/rAL+K4ZnCma1jwapYMtYLvdfL8tDgTMOkq++ymGvZCK7VOqBT9hA69WLBifxfhEP0
 UpEpaldnFcS/K2MWXNiBiszT8GSYsGUQDKD5QeN3af90BYGfLsF3072KqUUrpjPKD62d
 /APDnWEYltcTeJh5z9fvurF/xw5AGfPPoD8qNUC5dy722efb0L9o3bVRbG9yDEu31Anp
 XLy8zed9aEREIudRwYJ4soT+R+6iilg/6+Q611tHK3QUjjceiTtU+/4qFdlgbeiCu8iF
 vTGw==
X-Gm-Message-State: AFq9FYKa8+OCD2ozPED+gjWYezQYrHBAHfnqV0YsRNvc5F8Tp81XYIii
 89CiaNJeutmlrYP570JSngta2HBh7pOzzaxqHYCcCx6zFYcBE5N4tfffInvhI5tnnfn37d1N9eE
 mwfzga2xA/KLRE4/Pm5ndxSzviZp440ZwQdUOSDeBg7Pi0fCMt8a9OTsjDcos7GJcTQ==
X-Gm-Gg: AYBFou1/jPSLjTrXfwT2XUuRFATlRk64QzBKvfvI5BuhknbmHw3Qq9nqZ5mwiP27xD3
 ZTvx1beGSYNp3XEZ/bOINSzkqgs5dB6YI1+76ilYi0LGcP4uGMKRWbTQvMHJUtrHW7uCGcvrJPu
 daUiqhi/aXDDJJBcNfXiWausey3zV2sGIsLgZC1MnGlkoMhjQ+Uiuffm0TouH2EFkIN0r9p+3xT
 t3yZCldFXWdpkP2bkru6AM+wq0iMkA89dR6s1Pefel+duRF0YgIPI+0+/sXZv8du3GcJHnS0/gG
 XMLtKyE++XFx1MUNX3mFUTDMPwa+b6TGUwDRd/kB4DOykZcVK9LECVFof90nA0gu8UePTmjxTO9
 xdaihPM8KXNCyvFFfTtTaHfEDrl+XQqZbarP17wJin1SzJ/cSpLkPEOoVaeQY
X-Received: by 2002:a05:693c:834d:b0:35c:8ce0:63dc with SMTP id
 5a478bee46e88-35c8ce065d9mr7460581eec.20.1792011944394; 
 Wed, 14 Oct 2026 14:05:44 -0700 (PDT)
X-Received: by 2002:a05:693c:834d:b0:35c:8ce0:63dc with SMTP id
 5a478bee46e88-35c8ce065d9mr7460563eec.20.1792011943736; 
 Wed, 14 Oct 2026 14:05:43 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 01/12] target/hexagon: prefix helpers conflicting with
 other arch
Date: Wed, 14 Oct 2026 21:05:15 +0000
Message-ID: <20261014210526.104215-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6acfeea9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=0Tj3Q07uUtPDLrELhAkA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX6QjnkqDH+va/
 lGCRtA1ZTZSK6Q690uGzXm0sEuU93XpndxiGbS2Kex9OG6mH+NMP1ZFPinGonUZKo+iPblf4dSx
 1+tFZYG8Eh8pkyLbICfjMYWmMmIvPmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX1QIeCwfr1Nur
 VzbsytwLqSLwKHZ2VMpUiDgd2NoU534xSs0IFob+K1GV+4b3fSq6iTD4FmCt+/G+UOJxg7TRKeH
 a34/BRv26Fvq5yx1fby6QR3jRssqD1Vr+yIycw0gNNgfnzKqNfWVpHynIryWgJVANafLox2uo9W
 AhpiM0gC9hRLlInK1rAfjqMg1t5J/1kp6A9tgLn0hvaYPFCgDrcMT2jWi62yR31KVBugVn4E/0I
 vZsL/+XHMt9foYW2zcbEsmzHDnG1YxE9dRjdnrI1iNkRMFrvne3JYxxU/VfmcFtNm5z9YfFBH3S
 z+r5yc3/CFjCyR0ibfc7IIZPwXpx6Lpd1GbN+kXvtcsnciHFiW0O9yz9nwSMvMlyNmC9fT+ohq0
 J3JhGtbDYUNtcfHyM43Y5wfH3BGYyjnFvTRcBG5o4CKpUn6Z2gt8J5S1llccfpkIVMyNA3CAu7g
 u5QH6Eh/eYED3t1gk3g==
X-Proofpoint-GUID: mqTlJXZ8ngLk07mfIrKpLETr8_NRY5bs
X-Proofpoint-ORIG-GUID: mqTlJXZ8ngLk07mfIrKpLETr8_NRY5bs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
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


