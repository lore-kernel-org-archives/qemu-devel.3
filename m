Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE83C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjE2-0008KF-Rr; Fri, 04 Jul 2025 12:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE0-0008Ix-HY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDy-00066q-9a
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so653461f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646316; x=1752251116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sdksj7AhuX3HdoRD316K9aYl//4+2BwqWbea6b6KLvM=;
 b=UolMWZFThgPsCsYDIae2zdWkdmFT8FPtej7dmTG9vxX49yTx3DzUCqBtFnK4cl2OIk
 wRZxKz00adx6Nbx0AmerHLsrz8suP/S0dEdZT5QheMm9mNo6ecc2EYiInbK6YmQ4OSfo
 Zmv0704OexoPq0BrsYBReD998w+KHyv1KKMnDy1vnQhy1tsUUDFr7b2LO6GY77Tz6meJ
 b74IOjlqR4DmwB2aRea0N+pgKNch6Pb8GTB+hCOaRA2n/R1N0z724ypHx1jSaSvx08J1
 xaM5Skk2/cQT8DbiMESi8b9ZrQuoJYRMT4dBtbqfC4WbmWaka1ZdOYl3BG+4rbFmfkoj
 g/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646316; x=1752251116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdksj7AhuX3HdoRD316K9aYl//4+2BwqWbea6b6KLvM=;
 b=oHWoExeUlDXjXwMpPPauDw2vgNMnuKCQBEMrRO30si4+D40vbjPbFl8Uc/wWVPuloB
 SgSabJjik40QAHz6j1RCZDfI9M2UtQRi9MyWGKd515DbXVmGIIy0w2gxKep84Y10SJ2o
 JD4nDzng/54sDIYHPWh87XxCAjYZdbRTEzlbrvfrTJGhzV3GGegMohmDfrOGuo6nlhk7
 aZOldMsupEi0iyNk7OJCUwiP5aQftQih5MHklsk+3t59Gs2KOtAIjRcj2OCSlFklmZQg
 /ieFHP0qrLRQYo3ZYNPEb8LiD4icijTzk3R6+/aH9lojpcUicXLuO6yKDSRelHoLuxhE
 3vnA==
X-Gm-Message-State: AOJu0YxhmenCVPPQCh0SA/1KuaS7sNSV45onx3b6tfpDRinkxm5t1i5m
 1LrRINJP/tIUFYh0ik77CAc8XBJcUBR41wFDlbJFfV29hPsp+QeeeN0SA7oxTrH3JTC3M2FVZx7
 66EBS
X-Gm-Gg: ASbGncuCc6VjuMU4NQB1rG7srSkvSFWJBVcB0BVL4kYsmI6HZQUDLfqrMpHwDzvWzbw
 4jNlch6ugeXFhehs4ohLXba7I/ydUyRbqLCMixLwpGo08NynquWJTuF9mLpvMTLLLDuboe5aLQI
 sIZqVKkszr9n+fztv/kIFkq5infUw2nDu7hIq7jo2LzUKpdvNUhcrj4IwDaovl9LrIfcXAiIJA4
 tLnNhC/nvSG+dPsiFcQ7itS0Vlpu50v3UENZK6qpg5Gr7waAr1PSM9jda+TZ/rYQQU15gCjuNtU
 Njqj3E2OjeyM9qRk/GfBv6X0u3R46S2ElkyV21UlnegyiKRe5I+q2ZigTFBISXwYE3sz/LHqins
 bpz4=
X-Google-Smtp-Source: AGHT+IGvC1Coz2Sx4wU3o62QTM1Uhkxp1Y4GPeHWzPFpJfud2OWwmRSUUIbF1RlrNE07TU/Zjc9S3A==
X-Received: by 2002:a05:6000:4a0a:b0:3a4:da0e:517a with SMTP id
 ffacd0b85a97d-3b495589716mr3643563f8f.23.1751646316446; 
 Fri, 04 Jul 2025 09:25:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 014/119] target/arm: Fix sve_access_check for SME
Date: Fri,  4 Jul 2025 17:23:14 +0100
Message-ID: <20250704162501.249138-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not assume SME implies SVE.  Ensure that the non-streaming
check is present along the SME path, since it is not implied
by sme_*_enabled_check.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5c44a5dece9..b0caccca46e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1381,11 +1381,8 @@ static bool fp_access_check_only(DisasContext *s)
     return true;
 }
 
-static bool fp_access_check(DisasContext *s)
+static bool nonstreaming_check(DisasContext *s)
 {
-    if (!fp_access_check_only(s)) {
-        return false;
-    }
     if (s->sme_trap_nonstreaming && s->is_nonstreaming) {
         gen_exception_insn(s, 0, EXCP_UDEF,
                            syn_smetrap(SME_ET_Streaming, false));
@@ -1394,6 +1391,11 @@ static bool fp_access_check(DisasContext *s)
     return true;
 }
 
+static bool fp_access_check(DisasContext *s)
+{
+    return fp_access_check_only(s) && nonstreaming_check(s);
+}
+
 /*
  * Return <0 for non-supported element sizes, with MO_16 controlled by
  * FEAT_FP16; return 0 for fp disabled; otherwise return >0 for success.
@@ -1444,14 +1446,24 @@ static int fp_access_check_vector_hsd(DisasContext *s, bool is_q, MemOp esz)
  */
 bool sve_access_check(DisasContext *s)
 {
-    if (s->pstate_sm || !dc_isar_feature(aa64_sve, s)) {
+    if (dc_isar_feature(aa64_sme, s)) {
         bool ret;
 
-        assert(dc_isar_feature(aa64_sme, s));
-        ret = sme_sm_enabled_check(s);
+        if (s->pstate_sm) {
+            ret = sme_enabled_check(s);
+        } else if (dc_isar_feature(aa64_sve, s)) {
+            goto continue_sve;
+        } else {
+            ret = sme_sm_enabled_check(s);
+        }
+        if (ret) {
+            ret = nonstreaming_check(s);
+        }
         s->sve_access_checked = (ret ? 1 : -1);
         return ret;
     }
+
+ continue_sve:
     if (s->sve_excp_el) {
         /* Assert that we only raise one exception per instruction. */
         assert(!s->sve_access_checked);
-- 
2.43.0


