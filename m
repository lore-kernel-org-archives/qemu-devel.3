Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FC2F531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCS2f-0000JI-7H; Mon, 13 Apr 2026 20:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCS2d-0000I5-AG
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:54:11 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCS2b-0000KM-4Y
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:54:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso61440365e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776128046; x=1776732846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/yLbW8T6BNRYKjmU+uWYDJjrta2vpr+KNxlI+OGhqE=;
 b=EhsXdvYUfTiatnNCHJtFPiRtYV+zn6cjQng4s18T7LnDoGlsB3/nzQ84sSYfPChR6y
 PutzRH7NRPRXQhCSaZ3CeY7tyw+Rk1UV+YAjH416drubHyvE2uzeHRMsHitPiHg7NFLe
 IKEPFgvmQ1Lve/52HKOFTJMtXEpVXwjxueMZnBNyJpdBYQb/gZ4adu1uKwncwpVn2wIP
 mKAPJykNHFjthm0vbKMFtTgRPaKwZAdI1PTs3dsRhZwhNfP4ZR80eSm5LcAPkkMj270O
 m6OnS9WfRfzBci76Z4xzhpVWYnpjSVMbyvks/sw/nSStk93xj2SIpr3nv3b2KEKt9io9
 +ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776128046; x=1776732846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n/yLbW8T6BNRYKjmU+uWYDJjrta2vpr+KNxlI+OGhqE=;
 b=fNShZIw3T4XSMIWERaJXt8UK9/llZNxUmFf0M/H0/xa5aNtQ8009VRcgZu5XD1p9/l
 Y9rdgJkN8XDMcXOgPeJ+ODjQ8vot4wzKRRCItoIKmltMi5Mbphl0wZsDI2UoZTGoYMS2
 JnicUFtGuwTN4M509dt1qmsktGfROyG87pgf8iIqLPX3zs9FB6D7GnVINMDdtPEDVXYW
 hP9V2v5HPK1ySXUWsuOBraB/h8V88teMhnv0u4wFVBVQk6tyCFs+Vag00uwAYqfVCw+7
 wSt+aEEbQP6Vv/ZQo78mqJApmnP01qNGCJJeOqELYt9bFFwF+tRNNFFTXB7zW5syjGcT
 ZRQA==
X-Gm-Message-State: AOJu0Yz00j78LMTkw9wyN70IQGxf3/BxV2B6mMXxRzILpydf6Rh7yj2Q
 7Mm20SQRzdwUsvOrmui8jmlhs77mMNznqtwoXWv9S1AKmVMPH92n6NzYOkTPR5h5RLmJasqt+PX
 Jm2lCC5o=
X-Gm-Gg: AeBDievtkQNjAVpB3+B6vNrQclEtIX3K1qnKQz3ZYGZhsgKwxc48IQYo1tLjJi7lvbg
 sYo159KCN9D5UdZBFHKS967VbJ6mS2oJmiWbEO0U3t+lECyOIM8RWnh5hyDhQmA7l0aCoELsOzQ
 oo8Pf2o7O74q63QiA94hTpxL0FEPzy+eok48Ebuk2LimRRftcYgsXo0VLz2/ek2jaQYqcYYzwzb
 7tprToG+k5JqhixqP50e15byKXQCaVIDbGtDZcZapNEobbqlZhIIH8QzKSS2eng5OSSAunM31/z
 NHR217f7JcOtomVhuLfVrlIFdZMSTUPwBGU2KN+8r9I+FjGzY0f/QFx2tg1w5NJmoOw1FJl24dk
 m7sjjn81GfaXO+6/Do6aKYzn+bprw7I2dkPoa8IWgYs6wGfzkGH+klcw1OUQXk1PHcKfUOzpfmG
 v5KDLoK2/Ws+/Zhon2LytCAEPnQYYAOoDLX2g3XfWNYUvOLacWnUhXW/+zvSjR+6OfYSbATZDl
X-Received: by 2002:a05:600c:8b30:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-488d6657928mr208367225e9.0.1776128046352; 
 Mon, 13 Apr 2026 17:54:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67ce3e4sm240833315e9.5.2026.04.13.17.54.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:54:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/9] target/arm: Explode MO_TExx -> MO_TE | MO_xx
Date: Tue, 14 Apr 2026 02:53:41 +0200
Message-ID: <20260414005348.4767-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414005348.4767-1-philmd@linaro.org>
References: <20260414005348.4767-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Extract the implicit MO_TE definition in order to replace
it in the next commit.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/arm); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/m_helper.c   |  6 +--
 target/arm/tcg/mve_helper.c | 79 ++++++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index a0cb8cb021e..f5954ce9bf9 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -634,7 +634,7 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
 
     /* Note that these stores can throw exceptions on MPU faults */
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
     cpu_stl_mmu(env, sp, nextinst, oi, GETPC());
     cpu_stl_mmu(env, sp + 4, saved_psr, oi, GETPC());
@@ -1055,7 +1055,7 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
     uintptr_t ra = GETPC();
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
 
     assert(env->v7m.secure);
@@ -1131,7 +1131,7 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
     ARMCPU *cpu = env_archcpu(env);
     uintptr_t ra = GETPC();
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN,
                                  arm_to_core_mmu_idx(mmu_idx));
 
     /* fptr is the value of Rn, the frame pointer we load the FP regs from */
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index a67d90d6c75..cc58e0502f5 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -194,23 +194,23 @@ static void mve_advance_vpt(CPUARMState *env)
     }
 
 DO_VLDR(vldrb, MO_UB, 1, uint8_t, ldb, 1, uint8_t)
-DO_VLDR(vldrh, MO_TEUW, 2, uint16_t, ldw, 2, uint16_t)
-DO_VLDR(vldrw, MO_TEUL, 4, uint32_t, ldl, 4, uint32_t)
+DO_VLDR(vldrh, MO_TE | MO_UW, 2, uint16_t, ldw, 2, uint16_t)
+DO_VLDR(vldrw, MO_TE | MO_UL, 4, uint32_t, ldl, 4, uint32_t)
 
 DO_VSTR(vstrb, MO_UB, 1, stb, 1, uint8_t)
-DO_VSTR(vstrh, MO_TEUW, 2, stw, 2, uint16_t)
-DO_VSTR(vstrw, MO_TEUL, 4, stl, 4, uint32_t)
+DO_VSTR(vstrh, MO_TE | MO_UW, 2, stw, 2, uint16_t)
+DO_VSTR(vstrw, MO_TE | MO_UL, 4, stl, 4, uint32_t)
 
 DO_VLDR(vldrb_sh, MO_SB, 1, int8_t, ldb, 2, int16_t)
 DO_VLDR(vldrb_sw, MO_SB, 1, int8_t, ldb, 4, int32_t)
 DO_VLDR(vldrb_uh, MO_UB, 1, uint8_t, ldb, 2, uint16_t)
 DO_VLDR(vldrb_uw, MO_UB, 1, uint8_t, ldb, 4, uint32_t)
-DO_VLDR(vldrh_sw, MO_TESW, 2, int16_t, ldw, 4, int32_t)
-DO_VLDR(vldrh_uw, MO_TEUW, 2, uint16_t, ldw, 4, uint32_t)
+DO_VLDR(vldrh_sw, MO_TE | MO_SW, 2, int16_t, ldw, 4, int32_t)
+DO_VLDR(vldrh_uw, MO_TE | MO_UW, 2, uint16_t, ldw, 4, uint32_t)
 
 DO_VSTR(vstrb_h, MO_UB, 1, stb, 2, int16_t)
 DO_VSTR(vstrb_w, MO_UB, 1, stb, 4, int32_t)
-DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
+DO_VSTR(vstrh_w, MO_TE | MO_UW, 2, stw, 4, int32_t)
 
 #undef DO_VLDR
 #undef DO_VSTR
@@ -295,7 +295,7 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
         unsigned e;                                                     \
         uint32_t addr;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
@@ -321,7 +321,7 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
         unsigned e;                                                     \
         uint32_t addr;                                                  \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
@@ -345,42 +345,47 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
 
 DO_VLDR_SG(vldrb_sg_sh, MO_SB, int8_t, ldb, 2, int16_t, uint16_t, ADDR_ADD, false)
 DO_VLDR_SG(vldrb_sg_sw, MO_SB, int8_t, ldb, 4, int32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_sw, MO_TESW, int16_t, ldw, 4, int32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_sw, MO_TE | MO_SW, int16_t, ldw, 4,
+           int32_t, uint32_t, ADDR_ADD, false)
 
 DO_VLDR_SG(vldrb_sg_ub, MO_UB, uint8_t, ldb, 1, uint8_t, uint8_t, ADDR_ADD, false)
 DO_VLDR_SG(vldrb_sg_uh, MO_UB, uint8_t, ldb, 2, uint16_t, uint16_t, ADDR_ADD, false)
 DO_VLDR_SG(vldrb_sg_uw, MO_UB, uint8_t, ldb, 4, uint32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_uh, MO_TEUW, uint16_t, ldw, 2, uint16_t, uint16_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_uw, MO_TEUW, uint16_t, ldw, 4, uint32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrw_sg_uw, MO_TEUL, uint32_t, ldl, 4, uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_uh, MO_TE | MO_UW, uint16_t, ldw, 2,
+           uint16_t, uint16_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_uw, MO_TE | MO_UW, uint16_t, ldw, 4,
+           uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrw_sg_uw, MO_TE | MO_UL, uint32_t, ldl, 4,
+           uint32_t, uint32_t, ADDR_ADD, false)
 DO_VLDR64_SG(vldrd_sg_ud, ADDR_ADD, false)
 
-DO_VLDR_SG(vldrh_sg_os_sw, MO_TESW, int16_t, ldw, 4,
+DO_VLDR_SG(vldrh_sg_os_sw, MO_TE | MO_SW, int16_t, ldw, 4,
            int32_t, uint32_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrh_sg_os_uh, MO_TEUW, uint16_t, ldw, 2,
+DO_VLDR_SG(vldrh_sg_os_uh, MO_TE | MO_UW, uint16_t, ldw, 2,
            uint16_t, uint16_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrh_sg_os_uw, MO_TEUW, uint16_t, ldw, 4,
+DO_VLDR_SG(vldrh_sg_os_uw, MO_TE | MO_UW, uint16_t, ldw, 4,
            uint32_t, uint32_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrw_sg_os_uw, MO_TEUL, uint32_t, ldl, 4,
+DO_VLDR_SG(vldrw_sg_os_uw, MO_TE | MO_UL, uint32_t, ldl, 4,
            uint32_t, uint32_t, ADDR_ADD_OSW, false)
 DO_VLDR64_SG(vldrd_sg_os_ud, ADDR_ADD_OSD, false)
 
 DO_VSTR_SG(vstrb_sg_ub, MO_UB, stb, 1, uint8_t, ADDR_ADD, false)
 DO_VSTR_SG(vstrb_sg_uh, MO_UB, stb, 2, uint16_t, ADDR_ADD, false)
 DO_VSTR_SG(vstrb_sg_uw, MO_UB, stb, 4, uint32_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrh_sg_uh, MO_TEUW, stw, 2, uint16_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrh_sg_uw, MO_TEUW, stw, 4, uint32_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrw_sg_uw, MO_TEUL, stl, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrh_sg_uh, MO_TE | MO_UW, stw, 2, uint16_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrh_sg_uw, MO_TE | MO_UW, stw, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrw_sg_uw, MO_TE | MO_UL, stl, 4, uint32_t, ADDR_ADD, false)
 DO_VSTR64_SG(vstrd_sg_ud, ADDR_ADD, false)
 
-DO_VSTR_SG(vstrh_sg_os_uh, MO_TEUW, stw, 2, uint16_t, ADDR_ADD_OSH, false)
-DO_VSTR_SG(vstrh_sg_os_uw, MO_TEUW, stw, 4, uint32_t, ADDR_ADD_OSH, false)
-DO_VSTR_SG(vstrw_sg_os_uw, MO_TEUL, stl, 4, uint32_t, ADDR_ADD_OSW, false)
+DO_VSTR_SG(vstrh_sg_os_uh, MO_TE | MO_UW, stw, 2, uint16_t, ADDR_ADD_OSH, false)
+DO_VSTR_SG(vstrh_sg_os_uw, MO_TE | MO_UW, stw, 4, uint32_t, ADDR_ADD_OSH, false)
+DO_VSTR_SG(vstrw_sg_os_uw, MO_TE | MO_UL, stl, 4, uint32_t, ADDR_ADD_OSW, false)
 DO_VSTR64_SG(vstrd_sg_os_ud, ADDR_ADD_OSD, false)
 
-DO_VLDR_SG(vldrw_sg_wb_uw, MO_TEUL, uint32_t, ldl, 4, uint32_t, uint32_t, ADDR_ADD, true)
+DO_VLDR_SG(vldrw_sg_wb_uw, MO_TE | MO_UL, uint32_t, ldl, 4,
+           uint32_t, uint32_t, ADDR_ADD, true)
 DO_VLDR64_SG(vldrd_sg_wb_ud, ADDR_ADD, true)
-DO_VSTR_SG(vstrw_sg_wb_uw, MO_TEUL, stl, 4, uint32_t, ADDR_ADD, true)
+DO_VSTR_SG(vstrw_sg_wb_uw, MO_TE | MO_UL, stl, 4, uint32_t, ADDR_ADD, true)
 DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
 
 /*
@@ -408,7 +413,7 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -434,7 +439,7 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         int y; /* y counts 0 2 0 2 */                                   \
         uint16_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0, y = 0; beat < 4; beat++, mask >>= 4, y ^= 2) {   \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -461,7 +466,7 @@ DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
         uint32_t *qd;                                                   \
         int y;                                                          \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -500,7 +505,7 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         uint8_t *qd;                                                    \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -526,7 +531,7 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         int e;                                                          \
         uint16_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -551,7 +556,7 @@ DO_VLD4W(vld43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -582,7 +587,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         static const uint8_t off[4] = { O1, O2, O3, O4 };               \
         uint32_t addr, data;                                            \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -609,7 +614,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         int y; /* y counts 0 2 0 2 */                                   \
         uint16_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0, y = 0; beat < 4; beat++, mask >>= 4, y ^= 2) {   \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -635,7 +640,7 @@ DO_VLD2W(vld21w, 8, 12, 16, 20)
         uint32_t *qd;                                                   \
         int y;                                                          \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -674,7 +679,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         uint8_t *qd;                                                    \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -701,7 +706,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         int e;                                                          \
         uint16_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
@@ -727,7 +732,7 @@ DO_VST4W(vst43w, 6, 7, 8, 9)
         uint32_t addr, data;                                            \
         uint32_t *qd;                                                   \
         int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
+        MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_ALIGN, mmu_idx);\
         for (beat = 0; beat < 4; beat++, mask >>= 4) {                  \
             if ((mask & 1) == 0) {                                      \
                 /* ECI says skip this beat */                           \
-- 
2.53.0


