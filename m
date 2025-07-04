Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D1DC83F12
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFc-0005ur-KI; Fri, 04 Jul 2025 12:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFI-0003Z0-Eg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFG-0006tc-ER
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so9795375e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646397; x=1752251197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I5Fd8p39t6w2/eWYPfJ4v5WaLwqwXDCDNzF9FiGflus=;
 b=gSdd7haC6aFfhmXbYDZ3hmGGJvXkkNfrZDhwGj2ZosEPmezVx5+ABt9fmfA4vTWO5B
 NCXPK1GV0N52XZOlxPGm3/DESAkNlyySj+gCuvQ8+P8K2OE4/tcJA6AWvyVHTqDlQHU1
 YVvGLo5ikRJK2OO+QE8qff+f7u4vf7ZhTrA1o4tN02hYZCt7iZnz0RoL5WoMlWnzwGNv
 qGaaYhzdYIkqmAbw8Uh6JpyI+JDIyYTnY83KvE+n+AX9b3x4eMv0jq3+dHsufNiraytN
 xVqdpS9yGWBTG6tLGxrus/cWE/pA4hwfpr8QEw+0GmIfT0cw9xIRDwhDdJRJ5socKXRb
 qp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646397; x=1752251197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5Fd8p39t6w2/eWYPfJ4v5WaLwqwXDCDNzF9FiGflus=;
 b=E7ezFED9VP8CPO+LoQae4pn6cqtYgx2udOS+ZCHySNgKAypIldm+u6yAdlJSDEr54K
 umtEymxFYt0lqp073v+AC+nL50FrGSc/L143gSjBz9TNP0w49I541azmCpByM8evRk8n
 WarllIcxORs9V1NjMTNTMNnfw6irNyXJCKyEOeidkWJ8o2PNV9aXIIj7Q578ogxHfwzx
 JsRCvo66YjpWk2yF0yoIwAoeg0kFHUZifaDkpj+kw3WxTYze2QZbJmRoZKDZcZ9yGLid
 MH2NkwLUu1zHw6HFAHJZenKhz3EMeHm5mgvQet/9k2x3362Dh4cYSkcmm3iHd33m/oyK
 KfAA==
X-Gm-Message-State: AOJu0YwhzjwVoX1kGMcbiRBl/Ufy+cN5qFP5X75Az/YnNqLo1pLZ0c8S
 Gxdt/s31vkUX4D3dG3Gu4WBbXAceX5qaqW0UaYm9LzSpSAorBgE0TRKEU8cXIaYXQ549FejCjrU
 r/hY1
X-Gm-Gg: ASbGncsb7ACV2TnMms6n/GTpFyjoVTGJBi7wOftgXxQ7JNlPCSiXzI9orVIyFaF66HW
 Bs3W0QpmhScdYLdVxCTDmnqhZx0MbMwYobdD0C1SRfXBEIrurte7NXnEev57koB0+v+jEwUsLG7
 2DCpOW+LJWPzmpx0HOm6M1St2tduyHV+6BkuV6SrY4XEBgb0q5/drB+a1UEKJE3et6Tck6r41dL
 IDxlrrVua3M5OoTyhAMwEtaL4+fnsULXksBiAu8EXMVqkA+QVcdH6S/Jvv3M2bH6s7nsD+Jalq2
 M8Uju8oKvvzobfSfOmKaC2kRqPVgp9XII1/1ETWQzIzMQbtrnEN/cG0nwrB4ghbhyBtG
X-Google-Smtp-Source: AGHT+IGDAR9tZaYymSm6BLS66lJMqxDcYBiRLxOaelzG0rUYQEzxIQ0GaqqbLH9u/ChP4YZDYg+JHQ==
X-Received: by 2002:a05:600c:458a:b0:43d:160:cd97 with SMTP id
 5b1f17b1804b1-454b4eb3449mr29858985e9.25.1751646396935; 
 Fri, 04 Jul 2025 09:26:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 099/119] target/arm: Implement CNTP (predicate as counter) for
 SME2/SVE2p1
Date: Fri,  4 Jul 2025 17:24:39 +0100
Message-ID: <20250704162501.249138-100-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-88-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  1 +
 target/arm/tcg/sve.decode      |  3 ++-
 target/arm/tcg/sve_helper.c    | 21 +++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 906da384dc4..733828a8806 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -937,6 +937,7 @@ DEF_HELPER_FLAGS_4(sve_brkn, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_brkns, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_2(sve2p1_cntp_c, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 
 DEF_HELPER_FLAGS_3(sve_whilel, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(sve_whileg, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 0df33127395..db16849731d 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -784,7 +784,8 @@ BRKN            00100101 0. 01100001 .... 0 .... 0 ....         @pd_pg_pn_s
 ### SVE Predicate Count Group
 
 # SVE predicate count
-CNTP            00100101 .. 100 000 10 .... 0 .... .....        @rd_pg4_pn
+CNTP            00100101 ..    100 000 10 ....     0 .... ..... @rd_pg4_pn
+CNTP_c          00100101 esz:2 100 000 10 000 vl:1 1 rn:4 rd:5
 
 # SVE inc/dec register by predicate count
 INCDECP_r       00100101 .. 10110 d:1 10001 00 .... .....     @incdec_pred u=1
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 6512df54e60..def841fd52f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4178,6 +4178,27 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
     return sum;
 }
 
+uint64_t HELPER(sve2p1_cntp_c)(uint32_t png, uint32_t desc)
+{
+    int pl = FIELD_EX32(desc, PREDDESC, OPRSZ);
+    int vl = pl * 8;
+    unsigned v_esz = FIELD_EX32(desc, PREDDESC, ESZ);
+    int lg2_width = FIELD_EX32(desc, PREDDESC, DATA) + 1;
+    DecodeCounter p = decode_counter(png, vl, v_esz);
+    unsigned maxelem = (vl << lg2_width) >> v_esz;
+    unsigned count = p.count;
+
+    if (p.invert) {
+        if (count >= maxelem) {
+            return 0;
+        }
+        count = maxelem - count;
+    } else {
+        count = MIN(count, maxelem);
+    }
+    return count >> p.lg2_stride;
+}
+
 /* C.f. Arm pseudocode EncodePredCount */
 static uint64_t encode_pred_count(uint32_t elements, uint32_t count,
                                   uint32_t esz, bool invert)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 079d3109607..53db8851bf4 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3052,6 +3052,36 @@ static bool trans_CNTP(DisasContext *s, arg_CNTP *a)
     return true;
 }
 
+static bool trans_CNTP_c(DisasContext *s, arg_CNTP_c *a)
+{
+    TCGv_i32 t_png;
+    uint32_t desc = 0;
+
+    if (dc_isar_feature(aa64_sve2p1, s)) {
+        if (!sve_access_check(s)) {
+            return true;
+        }
+    } else if (dc_isar_feature(aa64_sme2, s)) {
+        if (!sme_sm_enabled_check(s)) {
+            return true;
+        }
+    } else {
+        return false;
+    }
+
+    t_png = tcg_temp_new_i32();
+    tcg_gen_ld16u_i32(t_png, tcg_env,
+                      pred_full_reg_offset(s, a->rn) ^
+                      (HOST_BIG_ENDIAN ? 6 : 0));
+
+    desc = FIELD_DP32(desc, PREDDESC, OPRSZ, pred_full_reg_size(s));
+    desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
+    desc = FIELD_DP32(desc, PREDDESC, DATA, a->vl);
+
+    gen_helper_sve2p1_cntp_c(cpu_reg(s, a->rd), t_png, tcg_constant_i32(desc));
+    return true;
+}
+
 static bool trans_INCDECP_r(DisasContext *s, arg_incdec_pred *a)
 {
     if (!dc_isar_feature(aa64_sve, s)) {
-- 
2.43.0


