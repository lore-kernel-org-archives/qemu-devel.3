Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159C9E63F2E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXl-0002d2-UJ; Sun, 15 Feb 2026 22:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXk-0002bd-0y
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:45:04 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXg-0002SR-68
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:45:03 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a9296b3926so17971705ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213499; x=1771818299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jjMqPAixxcwcEgflWsrUzbIhGAUlKCgA6kncWkqtUYA=;
 b=CoHzRVqHuLpR2/vPuNeZC8CLoBxoPAh3lPYVpHRwgCKV09lz3F12iwCPMzMp7t7fPt
 7c1j19p3GJkLi7cqCeq4rEJ4gnYfFLHyVdS+xz/fL8XGNdev6SbA+f52ykiLi+QmhnY8
 EiszOQw2A1coi5Qsi7OF5GMf1pb2RNzEn4CB0dHoTzz2nPcTAHMHBHVoGhAOTUDB9fX7
 QBVG4aklyRE+GhsIDWhxcbPEBbgiqeH17AtKjzf/411iwg7sJpCXjiU6zvjIAFxZ6dzY
 BXjZUGCgvzMhyXCmKYC1CmcyY6d+l6f7WmG2+Z6hyfIMDqysVhAlveHP0s1fSEixGrtW
 9JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213499; x=1771818299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jjMqPAixxcwcEgflWsrUzbIhGAUlKCgA6kncWkqtUYA=;
 b=KDGvL2JuomqHxGpb9f2wScDXXKfocCVg0z6MpykdrP+aeC1nPfkzroBz4XqITHujlt
 Nv837q+doKP8iXruAukrxNUhdziooZo3d4UoT/wQsbWPtMigcRs4aEMLJRT86413D/UU
 8GAvt7E3fWG8zWby5b55O8nCprFceLCuEqVBB1RfsxXdXW6iG613ifZL3FG+8KBrY6tC
 BersnV0sOlJNW+691BzeYQy+hK0fbzdr0IPprj64zMC3CO6yg0DW6TFN9wDzLL/g7mJf
 oONPD1v+4J8YFSkNW86gr+WsU4+dDWB9KEUIuTa5x0+ulLeUKdeLlYXhnV0+pItuw/5J
 73Fg==
X-Gm-Message-State: AOJu0YzmMwvC92z8Vc7ynVO3X/TWwcEiC4AcQa6wKdFZCZz86Ipb4MfB
 dyXH4klw+Asag+D8k0hqVsNTMxwCHJ4ZleIx1DDD2rXSVsR8QTqvoJRE4KA2B06xPsEob0Jvgz5
 03dvY6dA=
X-Gm-Gg: AZuq6aKuRgEl9k89MIf1LHjhoeYz+nX+xaCHjnS+MMnFVWGlxIsFqCsC/jTCQNLSCuH
 hEVXlorTKU4Nptx3OV2/L01oZOJM9YPPVoEYjC7aB5Kcurt5d+Ekhojh2/6u8mwxswwO+aaRkHx
 DyyOZmrfS202Gp65mll45FjzDVMxcU/YxrTl/8P4GqyqciehqDjvoAqTXB2yHjtzW8/1YeGCN4+
 1FyetdCidgC1GKykFrMUh2KN+VYDQUn5FrTkyNUflW6WC+3TpIFn6KAe2lRKEMaVqejlZlX6maR
 k2xq5L4N3rRfhqn29BYueMMjnf5vr1vo0um5PE/mOYlNVArJF1W+SUCbsjEu+EY/ql7HX9g+Ixr
 Wz9IMTRdTIyfesrR40yGYCdXxDF/NZKApCtZQLJEDeUg8FxP4DXEwPYJPudepQB6tihBySv9d0R
 OlqFnMUI2re6Q7RWeuoSDwz6eME80iyyjc
X-Received: by 2002:a17:902:f791:b0:299:e031:173 with SMTP id
 d9443c01a7336-2ab505bafd4mr89282245ad.35.1771213498692; 
 Sun, 15 Feb 2026 19:44:58 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:44:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 10/13] target/arm: Add vq argument to kvm_arch_{get,
 put}_sve
Date: Mon, 16 Feb 2026 13:44:29 +1000
Message-ID: <20260216034432.23912-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 979265a810..f6bab562a0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2122,16 +2122,15 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
  * code the slice index to zero for now as it's unlikely we'll need more than
  * one slice for quite some time.
  */
-static int kvm_arch_put_sve(CPUState *cs)
+static int kvm_arch_put_sve(CPUState *cs, uint32_t vq)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
     uint64_t tmp[ARM_MAX_VQ * 2];
     uint64_t *r;
     int n, ret;
 
     for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; ++n) {
-        r = sve_bswap64(tmp, &env->vfp.zregs[n].d[0], cpu->sve_max_vq * 2);
+        r = sve_bswap64(tmp, &env->vfp.zregs[n].d[0], vq * 2);
         ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_ZREG(n, 0), r);
         if (ret) {
             return ret;
@@ -2139,8 +2138,7 @@ static int kvm_arch_put_sve(CPUState *cs)
     }
 
     for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
-        r = sve_bswap64(tmp, r = &env->vfp.pregs[n].p[0],
-                        DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
+        r = sve_bswap64(tmp, &env->vfp.pregs[n].p[0], DIV_ROUND_UP(vq * 2, 8));
         ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_PREG(n, 0), r);
         if (ret) {
             return ret;
@@ -2148,7 +2146,7 @@ static int kvm_arch_put_sve(CPUState *cs)
     }
 
     r = sve_bswap64(tmp, &env->vfp.pregs[FFR_PRED_NUM].p[0],
-                    DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
+                    DIV_ROUND_UP(vq * 2, 8));
     ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_FFR(0), r);
     if (ret) {
         return ret;
@@ -2240,7 +2238,7 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
     }
 
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        ret = kvm_arch_put_sve(cs);
+        ret = kvm_arch_put_sve(cs, cpu->sve_max_vq);
     } else {
         ret = kvm_arch_put_fpsimd(cs);
     }
@@ -2306,10 +2304,9 @@ static int kvm_arch_get_fpsimd(CPUState *cs)
  * code the slice index to zero for now as it's unlikely we'll need more than
  * one slice for quite some time.
  */
-static int kvm_arch_get_sve(CPUState *cs)
+static int kvm_arch_get_sve(CPUState *cs, uint32_t vq)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
     uint64_t *r;
     int n, ret;
 
@@ -2319,7 +2316,7 @@ static int kvm_arch_get_sve(CPUState *cs)
         if (ret) {
             return ret;
         }
-        sve_bswap64(r, r, cpu->sve_max_vq * 2);
+        sve_bswap64(r, r, vq * 2);
     }
 
     for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
@@ -2328,7 +2325,7 @@ static int kvm_arch_get_sve(CPUState *cs)
         if (ret) {
             return ret;
         }
-        sve_bswap64(r, r, DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
+        sve_bswap64(r, r, DIV_ROUND_UP(vq * 2, 8));
     }
 
     r = &env->vfp.pregs[FFR_PRED_NUM].p[0];
@@ -2336,7 +2333,7 @@ static int kvm_arch_get_sve(CPUState *cs)
     if (ret) {
         return ret;
     }
-    sve_bswap64(r, r, DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
+    sve_bswap64(r, r, DIV_ROUND_UP(vq * 2, 8));
 
     return 0;
 }
@@ -2424,7 +2421,7 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
 
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        ret = kvm_arch_get_sve(cs);
+        ret = kvm_arch_get_sve(cs, cpu->sve_max_vq);
     } else {
         ret = kvm_arch_get_fpsimd(cs);
     }
-- 
2.43.0


