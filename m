Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7C2C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7su-00042k-IX; Wed, 12 Aug 2026 08:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sq-00041J-9X
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sm-0008TX-So
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso9460875e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786536991; x=1787141791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7sEEgIbRAUTMgSc3I3kXrmftvB4wI6OE/YhjUnE5Qek=;
 b=syD4eHp5w6GaAVtckYoMIDvv2cCfWbmdrDOj3m3mFrll8Z2YG/QKH/tGUip6LSX4hl
 wNY+EId9l2h+uf/1lnKcv03BYVDqa3Wu3m2mg+oDmxjyQOv5yC9/njJAdhzit4bKKILq
 lGvrNlJbqiRU5RkqFk+gxfLSaAjl1X8bYarBY4T8aOjnzrQyEzADVZCUuqr3FzOFrauY
 77nmK4NIDiY3ip0eS/6XjpiipL7YPsPoDG9uUZPoGK25g8Zy06J9qjbbtIHg68DvIIhS
 uLsG6FH8KZFLiaVBkdNJ0AoKY2zs0FZ3rBzQmV+ZVZimf5MVxwuvrvGmEZcPL3w9nEfg
 D3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536991; x=1787141791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7sEEgIbRAUTMgSc3I3kXrmftvB4wI6OE/YhjUnE5Qek=;
 b=seAA0O7mwBRnHGmmLNGqapOc3IPsDbZ2Ad1K6vaYU1Vw77kYGI07eGyjq19r3/P/C+
 O5meY4o7f51g5l/naLKPthrrJgSHoSbl2SK9mu8r/VyrCqDetITq9MSMds0hSCxTNnsG
 Xv+9XHUwhFOoQqBDDmVdOspmdkUjrPMreeGmjYsQjZbHZORuVB7YbZJykmf+HxJVUtC8
 vXv85o9jwkV0rNsUg1S/A/vhiFFlTS7++/EKTtYSE8dJP+4OQYrMlGIrst9FO2XzF1er
 qhCjoFW0ihQXEWZFPI0lkgaRheCldJjrtDSAbIw//44QLlr2JdVTaqprD6/JE3X7gRck
 3hlg==
X-Gm-Message-State: AOJu0YzLHzEU6xTwr6ShYHFBS/+vJ68QZ6gg4oRj+4OAF2FPVQ8pl5X+
 +XkYJRGek4Ko9nOOPUUuBbYyRM79G6AV0CKZXPoDD0kRQkU+NlKu2m1Wx6Hr0o8KHQmX8Mpc/vC
 4ihbD
X-Gm-Gg: AR+sD12dF/4qqHrmtu12s3shxsbbROqOFxNjze+LoYHMyrQ8oS090AKL5umd4g792jO
 YKPku8cQCXQdSGXICgMgyb454cItITi/NmAJmiUxFvYpf5mIzHiRdt29mLi7XYkadfEyJWB1HJy
 O5W9jwhvz6yerm0FHv9af1JQO6Rjy25dedwU2TcQKqT9G0h4fH0WpQQ+jM432VQka9hy++iQ80g
 2qXVDjbWtGuJ7JOo3dxDnWAbJ7BthEBTkB/QxKraa0hJjVU6bFcRva2bNyE8z3JLWyZVc7Mv8mi
 XJtgBwc95ZHb1cg5z8xU+KtBUVPFLYNr3JUVKddIY25AkbbW+LnC8Xbyfm2qzh6uvGayhpFbeui
 T24ZcYJniHo834+QU1hMCYpuhp7nVZVjrqT2psKCnlDrBjjlqlyOby5G5A7/nnMTsJ6tcFCoDhB
 dmL+MProb2NBgZF0V/IIyZ7VgM2PgWP1jYTZe7Lc3mthcKXxdsEPuLqCsLIY8nNeAPBLfx/6/g9
 N7CfQFTwVFXpcBuma9BYvErqvXYxM5M523QkWS3sPbkBlZDzYXrcaRNbWByZKea53g/Dw==
X-Received: by 2002:a05:600c:4690:b0:499:728c:4704 with SMTP id
 5b1f17b1804b1-4997c0fe705mr50145075e9.12.1786536991071; 
 Wed, 12 Aug 2026 05:16:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/26] target/arm: Implement BFTMOPA (non-widening)
Date: Wed, 12 Aug 2026 13:15:59 +0100
Message-ID: <20260812121622.649730-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713230244.70174-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        | 5 +++++
 target/arm/tcg/helper-sme-defs.h | 1 +
 target/arm/tcg/sme.decode        | 1 +
 target/arm/tcg/sme_helper.c      | 6 ++++++
 target/arm/tcg/translate-sme.c   | 2 ++
 5 files changed, 15 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4190398a1d..d3bf0746cb 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1842,6 +1842,11 @@ static inline bool isar_feature_aa64_sme_mop4_i16i64(const ARMISARegisters *id)
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_i16i64(id);
 }
 
+static inline bool isar_feature_aa64_sme_tmop_b16b16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_b16b16(id);
+}
+
 static inline bool isar_feature_aa64_sme_tmop_f16f16(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f16f16(id);
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 84707e6c71..224de45294 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -405,5 +405,6 @@ DEF_HELPER_FLAGS_4(sme_usmop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_usmop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_usmop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_6(sme_bftmopa_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sme_ftmopa_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sme_ftmopa_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 16ed3ca391..f0f9b3f61d 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1142,5 +1142,6 @@ USMOP4_dh       1010 0001 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 @tmop_o2        .... .... ... zm:5 ... ... .... idx:2 .. zad:2 \
                 &tmop zn=%zn_ax2 zk=%tmop_zk
 
+BFTMOPA_hh      1000 0001 011 ..... 000 ... .... .. 100 .       @tmop_o1
 FTMOPA_hh       1000 0001 010 ..... 000 ... .... .. 100 .       @tmop_o1
 FTMOPA_ss       1000 0000 010 ..... 000 ... .... .. 00 ..       @tmop_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 49fd3d07e4..e57c56d5f2 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2831,6 +2831,12 @@ void HELPER(sme_bfmop4a_hh)(void *vza, void *vzn, void *vzm,
     sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(bfloat16), inner_bfmop4a_hh);
 }
 
+void HELPER(sme_bftmopa_hh)(void *vza, void *vzn, void *vzm, void *vzk,
+                            float_status *fpst, uint32_t desc)
+{
+    sme_tmop(vza, vzn, vzm, vzk, fpst, desc, MO_16, inner_bfmop4a_hh);
+}
+
 static void inner_bfmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
 {
     bfloat16 *d = vd, *n = vn, *m = vm;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 5ad59ab99b..04e1550c05 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2156,6 +2156,8 @@ static bool do_tmop_fp(DisasContext *s, arg_tmop *a, MemOp esz,
     return true;
 }
 
+TRANS_FEAT(BFTMOPA_hh, aa64_sme_tmop_b16b16, do_tmop_fp,
+           a, MO_16, FPST_ZA, gen_helper_sme_bftmopa_hh)
 TRANS_FEAT(FTMOPA_hh, aa64_sme_tmop_f16f16, do_tmop_fp,
            a, MO_16, FPST_ZA_F16, gen_helper_sme_ftmopa_hh)
 TRANS_FEAT(FTMOPA_ss, aa64_sme_tmop, do_tmop_fp,
-- 
2.43.0


