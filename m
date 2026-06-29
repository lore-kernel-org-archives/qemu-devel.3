Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691E0C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgI-0007MR-ME; Mon, 29 Jun 2026 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfc-0006uJ-Q3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:03 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfW-0007NT-LJ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-461edb387ddso3087460f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734451; x=1783339251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EgCSUfF3fVYqj1i+7Q5vqzIEq5SCrDOg8aKzKrq3nhY=;
 b=HnDx+fPkkBsmHy02cc6Xl2adDUVDNTgOP8B9vQuHx0lYrtmH4ophtFUWJViaYoVgyY
 P2fMRSNYagiZW5o9NkPSr7nA8rJJvAK5O+oP8t0pEAz1twl1VWIyp359TvBGEg230HPt
 9K6/VkIFl3g7mTxBoAPBPya9XXCSZkJvSPEmorIG/LAkDQ1ENdQMt4wJmGEySCrckatC
 3QBs4JMwo1bBKk+Asn/0fOV5SBKm/3mrNLbkgB3+VqMdtcjVvPiyNeGyHHTKDpJNfW7i
 WPwjbofo+qcp78cqoKnsgFpB3PjR5+PacH/fUGMAadtAucPVjCIN/Z/zX9Rfpu3Z/Cze
 fiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734451; x=1783339251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EgCSUfF3fVYqj1i+7Q5vqzIEq5SCrDOg8aKzKrq3nhY=;
 b=PhBxgkzu4ZRE1YA2+7ezWbHDhVL45Y3RDZaSzf8vpHR07FqUFj4BBkFgBN5dZfafYg
 3KwZPOU0tWpw2hm2jGx27isX7aLqKOtlamvt1DJyPVFE9kpzmqzSwlcl/yUQV8uMiT6x
 npAv+LnhIf6G9fb5u+Bo41nf9JW8TR0fM9Suz3MoWLWcWs0NhLEKosMs4RTLz1OYMFHl
 t0190W8a1+nplDthTsAF53KDzu1BfMf++91FedqaKtqWTAoQngdD/j9gDO1t5Ycg3Bw8
 60jsCKQlrECw4DnxwrTgVrRQwk0KHwiqXx1XP7JNFpeoUaD8f+n5+Nla0/8G6D4GR/KX
 I84g==
X-Gm-Message-State: AOJu0YwAAyafFOsu8GyduAndHfGc+075MKpOMp3OhRN4qNBlWii4D4Ts
 fV2eVdqXJHgSb5fd/DO+pmblyax0lvv5m3IcYvicKH25X2moifwCX5NApZB0ytZxzzfyGIYe7DH
 iYW43
X-Gm-Gg: AfdE7ckODRQbT5RxXgNmF2nBl1EhsJ8PRqufmOz9QxvYfNxBidBl49TsYyBTg5HV+OM
 G4SBQaXEkS8Z54W1/MBQC56em4D+oMgT3N7YLR1AndZnwEeQf1yLUgIxdPmPR7fc+Jc86EpSrw+
 ELxq3Z49Gyw2PwPfzlV3qfOliF9y/d379C1uKvbfYhjaUGFfqFANcvROst5NeqcK8Jxmfhtqoso
 ntW5CHqmORXE5rh9w5Fp+B7HGYrHuBzmEgXLtDRaia0l3XXmYhYCE+JAS+GV+4nFqecI1W4ASB+
 CirWrwXhWVD5kA8LV2iahxI6V24F3ZBRlnKBjCVqFTyDVjCYamgY0LUKZRbS88dEIbSiLKkV9Kq
 djePrAMufTDvmQuzl3fJO4B1XK6+SwUMoXyZCQf9+QTNLYyMBtPodX6Jn7LQgY1ybFHww88oG+o
 6ZPRlFMv6aRW+bR7yk2EH9rTtD3rDo2KyfFpG2sq8Nv/Yt8+3MToR33Drw/nzSiwbTXDDlIhAaF
 TvOq9Ivm0OWgi737LlPaA==
X-Received: by 2002:a05:6000:2087:b0:474:3b78:b229 with SMTP id
 ffacd0b85a97d-4743b78b4cbmr3086287f8f.11.1782734446343; 
 Mon, 29 Jun 2026 05:00:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/54] target/arm: Implement FMOPA (widening, 4-way fp8 to fp32)
Date: Mon, 29 Jun 2026 12:59:49 +0100
Message-ID: <20260629120032.1645265-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Message-id: 20260618041517.573469-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/fp8_helper.c      | 35 ++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/sme.decode        |  2 ++
 target/arm/tcg/translate-sme.c   | 19 +++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c07bcb0a73..45213f71ab 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1600,6 +1600,11 @@ static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_sme_f8f32(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F8F32);
+}
+
 static inline bool isar_feature_aa64_sme_f16f16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F16F16);
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index bd0877071b..08e04364fa 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -857,3 +857,38 @@ void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(sme_fmopa_sb)(void *vza, void *vzn, void *vzm, void *vpn,
+                          void *vpm, CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    intptr_t oprsz = simd_maxsz(desc);
+    uint16_t *pn = vpn, *pm = vpm;
+
+    for (intptr_t row = 0; row < oprsz; ) {
+        uint16_t prow = pn[H2(row >> 4)];
+        do {
+            void *vza_row = vza + tile_vslice_offset(row);
+            uint32_t n = *(uint32_t *)(vzn + H1_4(row));
+
+            n &= expand_pred_b(prow & 0xf);
+
+            for (intptr_t col = 0; col < oprsz; ) {
+                uint16_t pcol = pm[H2(col >> 4)];
+                do {
+                    if (prow & pcol & 0xf) {
+                        uint32_t *a = vza_row + H1_4(col);
+                        uint32_t m = *(uint32_t *)(vzm + H1_4(col));
+
+                        m &= expand_pred_b(pcol & 0xf);
+                        *a = f8dotadd_s(n, m, 4, *a, &ctx);
+                    }
+                    col += 4;
+                    pcol >>= 4;
+                } while (col & 15);
+            }
+            row += 4;
+            prow >>= 4;
+        } while (row & 15);
+    }
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index e942308af4..7c090ccad6 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -38,3 +38,5 @@ DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_7(sme_fmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 495330aed7..e668293efd 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -198,6 +198,8 @@ BFMOPA          10000001 101 ..... ... ... ..... . 100 .        @op_16
 BFMOPA_w        10000001 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_w_h       10000001 101 ..... ... ... ..... . 00 ..        @op_32
 
+FMOPA_sb        10000000 101 zm:5 pm:3 pn:3 zn:5 0 00 zad:2     &op sub=0
+
 SMOPA_s         1010000 0 10 0 ..... ... ... ..... . 00 ..      @op_32
 SUMOPA_s        1010000 0 10 1 ..... ... ... ..... . 00 ..      @op_32
 USMOPA_s        1010000 1 10 0 ..... ... ... ..... . 00 ..      @op_32
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 98d3d18791..63c6e2c9b1 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -616,6 +616,25 @@ TRANS_FEAT(BFMOPA_w, aa64_sme, do_outprod_env, a, MO_32,
            : !s->fpcr_ah ? gen_helper_sme_bfmops_w
            : gen_helper_sme_ah_bfmops_w)
 
+static bool trans_FMOPA_sb(DisasContext *s, arg_op *a)
+{
+    if (!dc_isar_feature(aa64_sme_f8f32, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, 0);
+
+        gen_helper_sme_fmopa_sb(get_tile(s, MO_32, a->zad),
+                                vec_full_reg_ptr(s, a->zn),
+                                vec_full_reg_ptr(s, a->zm),
+                                pred_full_reg_ptr(s, a->pn),
+                                pred_full_reg_ptr(s, a->pm),
+                                tcg_env, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
 TRANS_FEAT(UMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_umopa_s)
 TRANS_FEAT(SUMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_sumopa_s)
-- 
2.43.0


