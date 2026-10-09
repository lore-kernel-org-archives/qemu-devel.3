Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516AECA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSI-0006Vi-2u; Fri, 09 Oct 2026 18:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSB-0006VP-I2
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJS7-0002cH-6U
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:37 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhiXJ2706495
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XaXb3cp9yXH
 XYOEStZFkBoux2pmuRYjjvWsUtJ4tBII=; b=gR9MN9G7HjqVPrbZ2qetsRgUP2O
 2AKb6n7BipPzFUtlPDuDXdB3l4EcCRlmdsA+9sccI2LCq2mLQLx4DgFywWLAI9Sf
 aLc4tb4DQa//zVg2fMWwBsJOQTxAZyv1hb21Rcpq2IwY2SL3J/SAqvIh3gmafS0p
 kC4PxUMQ9eVM4ksqvnXNSM9Cg4AoRdgnzDOvgA0dLM4oP/i5jm29K1aVR//shaGp
 m+ChJ49dtpmdoqjczhrxUAU3pD/MF7rUHS/NjXMNu11nLAK7AbK+qeVq/UjyTKgg
 i6/pml9Lv9XKhLTrhzOfcqkO4JuNZQWhI68nWJd5EjzmGBhBK0inPq9UJ6A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8rxuv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso292105eec.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586353; x=1792191153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XaXb3cp9yXHXYOEStZFkBoux2pmuRYjjvWsUtJ4tBII=;
 b=cDW+iajPorJmqjESCUwmxBjYzq5ZMcezVnUlc3Vy72KcEdlzJGZYu2VlFxnSTnswUx
 TXWoc2r9qgGda8e6HvASsJD/xUq90j3lYk/soEkMa2/5tmZGGgXsWRoM9lYivgpQIUhU
 RV8W7AGj4b4UDfmT+EZghJ+wub4Gf0tuPkK1TsCaBee9qXjTFMo5mSt3pU7zSbrfCRYK
 oQebmvnbTXrdtnchzvLCXFcfoEnpV9daXARoD94q5MaK5GIxgQXLjM1TudwZBtk6GH5H
 0D+j7iDlf8ju4lX8k2C+ajjicQ0V7u7gDMYNy3u1YJnIqBpZs9WzCMY5NELbCtsAZAH7
 Pgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586353; x=1792191153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XaXb3cp9yXHXYOEStZFkBoux2pmuRYjjvWsUtJ4tBII=;
 b=c0RoTZb8Nop+wJW74kG9VCY6jLQRrnS7rMetKpRYsHlIQ6FWk1qe/hVaDa6bJQuP7u
 1mjwJ+sK93V2uYPOKZSxkvwHSfxkHBp8xgABG4MPoXNKXsDSdJ0SFJPc7hKZpQa2vSZP
 9UdV1rUdHfDymhMqqSz7keQ+/wSaDt2U6Vr4Zks2pMmt4zwCnA53Fe1rlh2M2hw3Nhhi
 y2Uj9iTB89tLkBzzoSVGbmKOK1N70aB5TKUC+zBcLu/A2bP3k5n97KiWhJ2RT3TPqPsV
 y1CyxawpK9WE0oH6AVGSwV5blsETj1QA7WPiBjhTJWdait4eDaXv5NXzegRSw3W6dcK6
 Wh9Q==
X-Gm-Message-State: AFq9FYKo5hIovnU++oIVZuOeoNVoX0kpNenhjhtQyvlPNlCT+Y+iuIOZ
 Htli9glZ/9v0DBH0xthdxTTEgR4ztzQe9y5cJhmxwwioGHJgMlh0kQT2p+kR0KbN9N1wJcu78Zv
 fXJE/rFkSwq03YzL85mEbJJuEHPhNMA2Q0/J4C4MzUEo9vO/aCJ9Kj66RWtqAd/AqPw==
X-Gm-Gg: AYBFou2eqXbUfMo4VmUunYjJXh4uksarVFcIzy37IixDOaw/wZapUUyFfU7GXrkNqSP
 kIAiVabwEoxuOYcnsOH815dKbFRjnMeQq1MMxUfexKhxi0J6c/OtFr8k/s3hBrzFex0I0tbzEld
 blJSlFTWTOKPLD1K5nfFwAGNe3Fy7njaiYCwx02H+4M0Sbst6pY68ld+FOpmA/a7Ee+eDWPBFLJ
 VWxXWZQiSR8xxEt5MTgyfQvQtg+JIsZ5x7x4KuWQFdnYeFZDo57U36E/FCbDt5VBq1DoTsd0LHu
 ohgGZ2oTlXegC8ihSeQmEG3Jt6TvyMeVLhWviP6nP3RHtWmTw7F+0P0OC0RK0ZGyzyj/T9FDWzs
 74kutVx9U/patvoHxKWuA0OPJqtV1IN4Hz6nDI4EllCu6L9EHKtH5nMjJ5BKr
X-Received: by 2002:a05:701b:4183:10b0:144:e535:3ef6 with SMTP id
 a92af1059eb24-16a5ec48a2bmr3992319c88.41.1791586352636; 
 Fri, 09 Oct 2026 15:52:32 -0700 (PDT)
X-Received: by 2002:a05:701b:4183:10b0:144:e535:3ef6 with SMTP id
 a92af1059eb24-16a5ec48a2bmr3992296c88.41.1791586352050; 
 Fri, 09 Oct 2026 15:52:32 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 01/11] target/hexagon: prefix helpers conflicting with other
 arch
Date: Fri,  9 Oct 2026 22:52:16 +0000
Message-ID: <20261009225226.10657-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dZcVTnXe c=1 sm=1 tr=0 ts=6ac97031 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=dhR9sdSYIxQGWSG44fsA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 4DdtJXcvEhU9zntFgqdBF2p1fax8v0yh
X-Proofpoint-ORIG-GUID: 4DdtJXcvEhU9zntFgqdBF2p1fax8v0yh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfXxz4u870J2/Nl
 /WMI/V8fbLWg9BKKRpU4D5Ay9teBtI3o8eDK3qV8QS9n9ELsIKJU8jJ33zn+YuNynWXwQTEL1eo
 qtfD5Pg9Ii/nbphag+2dU5rqeny0Cd8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX9WR450rIKfU8
 p79rgm2PZj8tQSzD7cwt8ykiOgTrnovJ+fOSD6Qy1xMHzqPBd70pI+BzTgPA+y9UYVeXiGlVA2W
 vFPx+iiZnpGyqrJgu77O+cgCpqajg/iQFqg2P6xa2g+QA+I/GV9hI88zGO0K4iwDzHinhSdsbQp
 +QeIowArWkEJ7NroGlKaPZQ0g5SMVNxjF7ovFvdWk20sV9GFIDbMaEUS2Eppo9RKflgDSD4XRJi
 bTEidwEPUv4Ib32xb/Jii+Lq3ducqfqiuZmjp+njeegpm5/SslEmoXNLZTvDEW6aTt4T/D9ZHbw
 Gbu7T+OKnA2kx9NhM/mP4zi+cHQb0HLrvA9qu9bywfNOTuzfUmrHX5dNHasWggDKg5npWQc/PVo
 Gob+quZmNIPbz/57hcCP8ITDyjIJeIy6Lpa1/Nu8dqNHpEt4jAY05911NgL396PwgjBezvdLM01
 xZSnzJfT6O/0D1p9Irw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090091
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hexagon/gen_tcg_sys.h | 2 +-
 target/hexagon/helper.h      | 4 ++--
 target/hexagon/hex_mmu.c     | 2 +-
 target/hexagon/hex_mmu.h     | 2 +-
 target/hexagon/op_helper.c   | 4 ++--
 target/hexagon/translate.c   | 4 ++--
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index af5032214c4..5163da2f6b3 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -80,7 +80,7 @@
 #define fGEN_TCG_Y2_wait(SHORTCODE) \
     do { \
         RsV = RsV; \
-        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
+        gen_helper_hexagon_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
     } while (0)
 
 #define fGEN_TCG_Y2_resume(SHORTCODE) \
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 71c8da4c46d..a2b3d8950f4 100644
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
-DEF_HELPER_2(wait, void, env, i32)
+DEF_HELPER_2(hexagon_wait, void, env, i32)
 DEF_HELPER_2(resume, void, env, i32)
 DEF_HELPER_1(resched, void, env)
 DEF_HELPER_3(modify_ssr, void, env, i32, i32)
diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
index d6ee7c40798..0c341f04936 100644
--- a/target/hexagon/hex_mmu.c
+++ b/target/hexagon/hex_mmu.c
@@ -117,7 +117,7 @@ int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t index)
 }
 
 #ifdef CONFIG_HMP
-void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
+void hexagon_dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
 {
     HexagonCPU *cpu = env_archcpu(env);
     hexagon_tlb_dump(hmp, cpu->tlb);
diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
index 56b2c4a89d0..b477bfcc0ad 100644
--- a/target/hexagon/hex_mmu.h
+++ b/target/hexagon/hex_mmu.h
@@ -24,5 +24,5 @@ extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
                                  uint64_t index);
 extern void hex_tlb_lock(CPUHexagonState *env);
 extern void hex_tlb_unlock(CPUHexagonState *env);
-void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
+void hexagon_dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 4f00ca773f3..3d55e5674d2 100644
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
@@ -1836,7 +1836,7 @@ void HELPER(resched)(CPUHexagonState *env)
     resched(env);
 }
 
-void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
+void HELPER(hexagon_wait)(CPUHexagonState *env, uint32_t PC)
 {
     BQL_LOCK_GUARD();
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 827859e052c..e58a12dbc5b 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -141,7 +141,7 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
 static void gen_precise_exception(int cause, uint32_t PC)
 {
     tcg_gen_movi_i32(hex_cause_code, cause);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
+    gen_helper_hexagon_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
                                tcg_constant_i32(PC));
 }
 
@@ -1143,7 +1143,7 @@ static void check_imprecise_exception(DisasContext *ctx)
     TCGLabel *label = gen_new_label();
 
     tcg_gen_brcondi_tl(TCG_COND_EQ, hex_imprecise_exception, 0, label);
-    gen_helper_raise_exception(tcg_env, hex_imprecise_exception, PC);
+    gen_helper_hexagon_raise_exception(tcg_env, hex_imprecise_exception, PC);
     gen_set_label(label);
 }
 #endif
-- 
2.43.0


