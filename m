Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49916C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkoM-0005dq-1o; Sun, 27 Sep 2026 05:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknw-0004hz-PZ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:18 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknu-0007eh-Mr
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:16 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0b6200eb0so1602469a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499853; x=1791104653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hcssWbsWIs6yiH2SjT/QMRTst+uvnmK6W6l5MrOzAEg=;
 b=ZDhy65XE8gXq1OMC2O9uFRBsrxBaNB8K0pxQb2lfGyoQNbWi38vczZxiqfIcOhDtaO
 TZJwmqyiupbqIPOabn+a1Qcj4MHRbS8lM1LWs4vJxcRtsIAEnXK+IrcDLtZvkTEyjY6i
 kyagH4PuCeONgHJXvow0RYXiul8bNfGE8q9PRrbzUUSbWDj8OyPXJjpBu3wApPjf47ar
 G7OL3GG/UAP8I0vKT4M/s6t5QkWflVT0e1oe3ohqQ6FYNASNuW/TptexSX1IpbtdSlbN
 gJv/nGWDjOlAMPKpJR1tmfOZs86pLEvjl4TQH3C7d1WZdD2Vko4cq0TxIwuoc3aEirNe
 iieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499853; x=1791104653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hcssWbsWIs6yiH2SjT/QMRTst+uvnmK6W6l5MrOzAEg=;
 b=a95RAyDSxW2iXCht9u0YbNTCkFp/zjxPP89ni3BqJrfKYUBZyumKuKVHmQmRNK5mkp
 nBXvKBThAjLAQ1dV9AU50DRjc0aWsEC9ouU2cV6A6jFlkx9tmx1+ELQSqMywI6j88SNu
 rqu/jp8/CYWjs6EI3LW/AWGTHulZ/tnV9jUV5AUgUdijhs3XwCw4Q10jpuTLto81s5IB
 1hPfAjs1CwfXJ790W600ym4E2+qoPRn/nvOZmmo5Q1bMLiANxcvJoNQ9JlJdjyxjoDpb
 /H7CMZCuxsIZT1LdzzlUjWwk1+tltW5U2h14jYJDFzbDRFWpDp/dbH11H3jX687Il08G
 3pSg==
X-Gm-Message-State: AFq9FYJZbjqoKyPGHoMAbmMki/CXr2JAiw4Q21RDA3uA//7Wus1yWuMr
 fEAo/DU1V3NOxcEEsEYlKD/XdYYrUCgeQNRtk5LCUB1V6LPE4CsBQ44YK4lFk2vaX1p8K0BdTLM
 G0EaA
X-Gm-Gg: AYBFou0guJX9CPHDkkB7b5jICfPxHf8fcve2YsI8PlIBwpEOSFspYqjkZois54xs4Nz
 OV9Hu4DoulC4FMoCzYknehJp9o7FYiNpktWXccIomqJfMsqBql7cKwBTwWAL+b7Lzw+iWkFQ0x7
 GHTp3qowLEy2vYj2okugtYkfrtIYD1Z8Vi2ESlCnRkiVjOVkDmyt9S/JhXc+g7Uxn9Q+iBmdsKE
 g3J5dcavISvGZRj3jcK9RfiIu+kpZRAo96wZHaEyCwfX0bxfh8oDltfJuMQ1sU1n0EqXCW+qTLW
 f/JGooOdXrFy+o0S9DKr7AfTJfDc++L/jlcqOC5TDm/SppE+YQrvZ/y5BJisPLiTi0JbhobbeFa
 dSV1hkCYW43T2QxW32F9IU473S1CxlaPNBhbtIBoucoTn2E8mL7uM9KbgNo7KGCR3WUrMg2wmbf
 yde2U3QX63Vv+O2YT+PnLUk5KzMNqqDVKVoxucu0eha6XRNfqqchGEG0vd0hFq0sUD+FRISDY7Q
 zAaIvqVs28trQp2mBZHiOpyfcijXfxF2QGt2AqA
X-Received: by 2002:a17:90b:5292:b0:39e:6c6a:657e with SMTP id
 98e67ed59e1d1-3a0bb6596femr5601333a91.65.1790499853254; 
 Sun, 27 Sep 2026 02:04:13 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 058/101] tcg: Generic expansion of tcg_gen_rotl_*
Date: Sun, 27 Sep 2026 01:59:28 -0700
Message-ID: <20260927090011.10724-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 62 ++++++++++++------------------------
 3 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d19feb49cbc..1a028da36b5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -184,7 +183,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ef0ac5aece3..f832e286aba 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
+DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5ee49e2553d..37ee848f24d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -746,6 +746,26 @@ void tcg_gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_rotl, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_neg(type, tmp, src2);
+        tcg_gen_op_ttt(INDEX_op_rotr, type, dst, src1, tmp);
+    } else {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_shl(type, t0, src1, src2);
+        tcg_gen_neg(type, t1, src2);
+        tcg_gen_shr(type, t1, src1, t1);
+        tcg_gen_or(type, dst, t0, t1);
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -847,27 +867,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shl_i32(t0, arg1, arg2);
-        tcg_gen_neg_i32(t1, arg2);
-        tcg_gen_shr_i32(t1, arg1, t1);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1678,27 +1677,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shl_i64(t0, arg1, arg2);
-        tcg_gen_neg_i64(t1, arg2);
-        tcg_gen_shr_i64(t1, arg1, t1);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


