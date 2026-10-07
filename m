Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AD2CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOK0-0005QA-Er; Wed, 07 Oct 2026 05:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFJ-0000Dx-H8
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFH-0000oq-KE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jbde2481467
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZSNVSgiwpyuG0z7pyJGhG9Xb9Z6PObBYkDddk6aa2W0=; b=NIZQchmbkxpLxkuc
 7Fz1vN9fBh7e8JZeEkk22OSUt+H1GUUDqyfeET5JKKnKR5qJh1bzAhzQd7VkQj+L
 2YVSqI25ooInPnKO0Gj3LSjGZtLioBNGE2X7Kwhry8i4tvqC0TtgLLyq3gklrLO9
 BA8Uos0p8nPOkO6fynAtZnt3EMEBc9Hwtvlml2JH+gUhN7BoNPTbJjFfhtfYp7iP
 7ttZAtyNqN7tJfhdH3vjdk82UauO9exvzQyJG1r3o0q/ceXWPkg6un+vCGZOVbgb
 4JwyamKL+OmiFyLu5UnlSfgaiM6a2X+OfHbtoFQzeYWq/+3lTChuuCUCe8wJV29a
 lNdM+w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c6u1hd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:47:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so863862185a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366449; x=1791971249; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZSNVSgiwpyuG0z7pyJGhG9Xb9Z6PObBYkDddk6aa2W0=;
 b=jnjh69b2BRDlZ3C3Wwcb1gL7A4gG0dSBcgkDdisHoFiGqvxQrrhICjLsziy2ZKFJIr
 o8d5IXPBwDf98wvrHOc4OZBKAAsUQZ+6vdwG6dNgDHMNKFOSWdoBLUt70uAcCVx5k5EQ
 QJdaqvU4xECPFkMCBh1a9rAQoIyxEAhjmgmXLqZYw7SHclrGIWdexNTIXrbsg9gZPEIK
 OGGVBRk1E2Z/FAvCWR3n8Vm0/JXUGsdqbI4epEelxX63i6R6+Fgq68Cv3E12t9YnWPcE
 op0sdq1HB4txNjU3ZtJXRwUQ7b03xE3+P1X/Rek8SeObKVKMWi86cpYIIUhsAW6t7Pnl
 qQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366449; x=1791971249;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZSNVSgiwpyuG0z7pyJGhG9Xb9Z6PObBYkDddk6aa2W0=;
 b=WcxZDjP0PGzjQGwAtC0GcZcWFYBDPg6D0D4zhP0LwTlBHUaddduN6E7afc+GNk1Yvb
 UjdgPclqQVu8wKnI/ksV98X5mHX48w4T7fc7E53cEzENuDHZL+WoduOYwXDZCwdID+lw
 WTEXJn6A1+0u1V15yan0SjLOHC1j5x/WVvczF7ADl1F1HLxe0QSdnYHgqk4XtBmSswix
 h21tWuq9ndPzvjoHmDRjGppib6bmyTwEzJzTlUGD5DYmZ8z9Pc8zIy8Rf2bfTqeUfAzk
 AbUuP9gLJzZiP57t6bhiqEzZbdC1d4IWClOLNH1+MX1ZCYIPtCsLk3NEQT2zh76fXfi3
 EDvg==
X-Gm-Message-State: AFuF++n7/lz/SjKQlncxRT+KfxhWZpFFJnXZdNrvmO8KbzpCtw1mP6js
 Tz7Y3BEiNCWQ7qle827jp2cahCHsKHjln5L5prkm0VV1rTs/fTEjAXau3zeFVHbTW0C/eCI2gIa
 /G66XiLzT2l1j+5kfeHgqxZEum9prTH+wS1uyKuF4duT81bon8dVDZWWk5eDTKvM/0HHK
X-Gm-Gg: AYBFou03jEbzepLfIzwXl3LOBDyOTsQ7btd7IigoUJWZs/FuWB7V0lFw/8YkWkf2VqW
 zo4HAHaT0kIHcIupoOLe+eM3q7/r+cv5h7hA9WvC1mvG0vp8/EdPY7P1iqNpo4L2GvjVe8jRYkk
 T6CF0dbdH4gOF2X6Y60YDiuCY9tXChzgIktlXREuCAxZaTMaxMaSsz+pWYuakOImtlx39Yq8eYp
 fUsL/dGDIKrWzqN11sSa8nN1jhWFWh7qqpPc7ktaKTKbNxh58kTMX4EtoJ97XxFmEXl6w8cYGKR
 WmaqLxyTHVI2JhUvtbLysutBysYuO4ipLs+umevWH5AF+71+vQhUvz4zlrv/9OhqL0XGOBeApWK
 ogV8uoEVsMhFJZ/1ib5Oe10ho3fcFEHt+N+09e7Bk
X-Received: by 2002:a05:620a:371a:b0:93b:fde4:4923 with SMTP id
 af79cd13be357-93e9b8403d1mr318472985a.63.1791366448961; 
 Wed, 07 Oct 2026 02:47:28 -0700 (PDT)
X-Received: by 2002:a05:620a:371a:b0:93b:fde4:4923 with SMTP id
 af79cd13be357-93e9b8403d1mr318470985a.63.1791366448514; 
 Wed, 07 Oct 2026 02:47:28 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d2ef79sm4403994f8f.47.2026.10.07.02.47.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:47:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH 18/27] target/rx: Unify BRK and INT trap handling
Date: Wed,  7 Oct 2026 11:45:06 +0200
Message-ID: <20261007094516.75732-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX4lKuOSzjI+oz
 b/TY2S1Vv7oRuyxjH9Kak8s/IT3P7ogJqDib8PtrFfhOejpYEkrmrzA3SV6h8Qd+uYmVhvSClvX
 vzZt2Fps0WHyziA/bsuPQWQzIogZme0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXwKhWhh8Wp9CT
 2sVB7/69SIsoWyZR4iHNrh6KTqndCAZQimBJI9qO47ll9KGaTyqA8C2hYSvFF8D1/u2WDzPOH8Q
 +qQRwLt7t343RI1y5gvJxeRkT9OvEDy6VzMEvPMCreLmIRPVoLkVdDRKSwdDu76uy8sB59QzO+M
 dgdM9NsBTd5o5wbFtxb5o3AbNtdvlpb9HvQnBYHpGwYFBY5Y+o6tum7rwdrL5eM4GcKRPMX3siN
 zGLmrlX758CPIbdvlJB/baA7LdBjJW25hrelejEG7y/t0sSbcRKkvwjpX+hUP6PV7P3eXOJdnK0
 Kn3pR6LAFQ+vNOhfnSvEg2zP9eEOY/qARACWEuJ9JMHX20qIbi5FD6GZxjAPNpM3GVCDP8WMs3p
 XKurMYUpjpJv+p8nN44TDaO99LhHdFr1nJb+RwkZ/JhCoB5mAw4qUDqqvcuf1exnEttMMw2DPOy
 w69WvB5wEMmp7VRRTFg==
X-Proofpoint-ORIG-GUID: ewpdgw9fxM5Dx-EjcGNKnmOY6kCwj3ou
X-Authority-Analysis: v=2.4 cv=T5EZ3PKQ c=1 sm=1 tr=0 ts=6ac61532 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=YEB5RgzmAAAA:8 a=jDMzgGwzCE0q-kHIl9cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ewpdgw9fxM5Dx-EjcGNKnmOY6kCwj3ou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

BRK is equivalent to INT #0, so route both instructions
through the same trap helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
---
 target/rx/helper.h    |  3 +--
 target/rx/op_helper.c |  7 +------
 target/rx/translate.c | 21 ++++++++++-----------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index 8cc38b0cb71..f3897ce7619 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -2,8 +2,7 @@ DEF_HELPER_1(raise_illegal_instruction, noreturn, env)
 DEF_HELPER_1(raise_access_fault, noreturn, env)
 DEF_HELPER_1(raise_privilege_violation, noreturn, env)
 DEF_HELPER_1(wait, noreturn, env)
-DEF_HELPER_2(rxint, noreturn, env, i32)
-DEF_HELPER_1(rxbrk, noreturn, env)
+DEF_HELPER_2(trap, noreturn, env, i32)
 DEF_HELPER_3(fadd, f32, env, f32, f32)
 DEF_HELPER_3(fsub, f32, env, f32, f32)
 DEF_HELPER_3(fmul, f32, env, f32, f32)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 36df7d377e5..6782912247e 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -455,12 +455,7 @@ G_NORETURN void helper_wait(CPURXState *env)
     raise_exception(env, EXCP_HLT, 0);
 }
 
-G_NORETURN void helper_rxint(CPURXState *env, uint32_t vec)
+G_NORETURN void helper_trap(CPURXState *env, uint32_t vec)
 {
     raise_exception(env, 0x100 + vec, 0);
 }
-
-G_NORETURN void helper_rxbrk(CPURXState *env)
-{
-    raise_exception(env, 0x100, 0);
-}
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 132d495710c..d0910fbf8e7 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2170,26 +2170,25 @@ static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
     return true;
 }
 
+static bool do_trap(DisasContext *ctx, uint8_t vec)
+{
+    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
+    gen_helper_trap(tcg_env, tcg_constant_i32(vec));
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
 /* brk */
 static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
 {
-    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-    gen_helper_rxbrk(tcg_env);
-    ctx->base.is_jmp = DISAS_NORETURN;
-    return true;
+    return do_trap(ctx, 0);
 }
 
 /* int #imm */
 static bool trans_INT(DisasContext *ctx, arg_INT *a)
 {
-    TCGv_i32 vec;
-
     tcg_debug_assert(a->imm < 0x100);
-    vec = tcg_constant_i32(a->imm);
-    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-    gen_helper_rxint(tcg_env, vec);
-    ctx->base.is_jmp = DISAS_NORETURN;
-    return true;
+    return do_trap(ctx, a->imm);
 }
 
 /* wait */
-- 
2.55.0


