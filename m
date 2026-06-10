Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D90CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXx-0008W8-L8; Wed, 10 Jun 2026 12:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXT-0007fw-Vv
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:25 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXR-0005Ul-Tu
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso3775021f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107940; x=1781712740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uaSjLoOO4/Sgg3fbIePE2QqdKW6IQ7ptA28s3E+x4i8=;
 b=WH7vAQd+z0QjD6WxHunvEGIIB7x6fQA86Lk6XQin48cilu7qNdvTtvNFHx17ToNSl/
 D9DxfJwKR8jUtgtVy+l/zsHwhyskCqpTGPx2Kb0q/YifW9TiuS7PcpHfGWC71RgnlYRQ
 OJNdhc19ND6Ploly4Cr6ZD2PK8tVHBVtyfJ6M3lmQc9Q4FyIrReZh8/912dgyrnzBwjr
 UQ/aUjk3GXPNpBSwab34XYbrY/SLdAi/6krywcUxeIfo5IfXecu+nxIrjHLu+4NvRQwh
 gc7XL9hHCpHthwMtTvvYusLC0mN7FqL2P3gZCliZT/qy3739+qZCUWMzG4eb/dj0cynC
 pEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107940; x=1781712740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uaSjLoOO4/Sgg3fbIePE2QqdKW6IQ7ptA28s3E+x4i8=;
 b=YqoYhZ9lMlD1HDXR6NPzcQ0415r17Dx35qqIb7+tZeug8LTm/6oUyTiqDZ20NJHK/g
 53DK0+h0NoeOx38+vrpsPywS3ikTaiJ6Zs4KCmLx+4MKimEHHt1zzU6/4N+WQbh4jtJC
 2A5j+NTPxxyRixGz/rRiwQsdC70iXuOJxDmNCz6L4hsFuBeLPdSDjdGW0UzFR164XqSs
 vlB9ch6EqLf6OzjYNB8ZudwszkYGi9d1deUqig7u+r9G3RUjsUm4icLPf6xEeDk4b6DQ
 PUulbbPiIMp6JFjF6fikawEiA/I62246EthXu7lo8Jw2SyYfxCqj7ha4sJBRxtHRVRWx
 +xMA==
X-Gm-Message-State: AOJu0Yw/3A89JdRyV15V4h2fqdAvJEHDQyXY0hXZ7uZ5Jw6WaHU4cyuV
 gXitpvwbVF+ZEK8gEFfOOFkIL1FeoNtk3vtwpBj/WMJX6W+8iHrYRSdn6a49WPnfSZYm5PJuz8O
 7zumy
X-Gm-Gg: Acq92OFMsXAKJwI3KwrSXT/adaXM0jEbHJQIgXOpBL/MyL+x7X/4AOISg3dD6hHojsd
 3qToUenB02cAnYVqGZUWT+YZkGi8F3OZD73sUNWGiGiUoZoST8LLohYnjoDShTc+nhb9LjZkmLD
 16NuKQRIYzn2Vl3AigL17BKsU6BDJQ6aP8cYBahMUocFcl2RGuL0HtUu6zSLdfh0hLisY5aJLL+
 Yf0eibX7elXBUCvx0mfODSjSTQzfcw79XDLIAloctPnAcLc9DY56//IIshwmsIFWNwOxOoLEz32
 YxBJewiyl0QtGCKX1K8zwgboSuE6Iael5NpehV7H/H5UkRx8arLOeif7rDYWD0KZXEYZGSf6Sq6
 iXM/zlfBtrTwooQDd8Sw91ImzeDOkMjuA1NKF/K75Y6bz8ZLK91GU9JkYrYqrQ5jm9tHCxkp+Oj
 M4gtQAt4n3rOo4jfyMzAK6WbjiLLz4muq/LdsH2UC5EOPD+15MIQgTZAFmwoFmVFjEp41YYJltj
 /BTaf/nquYBJNZjEieJYZJXJM+nmua3oHXH/EI2vrQ=
X-Received: by 2002:adf:f282:0:b0:45e:da57:be33 with SMTP id
 ffacd0b85a97d-46030502271mr29612963f8f.23.1781107940473; 
 Wed, 10 Jun 2026 09:12:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/71] target/arm: skip tag bit bounds check if MTX is on
Date: Wed, 10 Jun 2026 17:11:03 +0100
Message-ID: <20260610161202.2235298-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

Virtual address canonicity checks should ignore mismatch in tag bits
during translation step if MTX is set. This mismatch is checked during
the tag check instead, in that case.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-11-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c    |  6 +++++-
 target/arm/internals.h |  1 +
 target/arm/ptw.c       | 35 ++++++++++++++++++++++++++++++-----
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b989acd0f5..c9536d2d10 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9795,7 +9795,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
 {
     uint64_t tcr = regime_tcr(env, mmu_idx);
     bool epd, hpd, tsz_oob, ds, ha, hd, pie = false;
-    bool aie = false;
+    bool mtx, aie = false;
     int select, tsz, tbi, max_tsz, min_tsz, ps, sh;
     ARMGranuleSize gran;
     ARMCPU *cpu = env_archcpu(env);
@@ -9832,6 +9832,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         ha = extract32(tcr, 21, 1) && cpu_isar_feature(aa64_hafs, cpu);
         hd = extract32(tcr, 22, 1) && cpu_isar_feature(aa64_hdbs, cpu);
         ds = extract64(tcr, 32, 1);
+        mtx = extract64(tcr, 33, 1) && cpu_isar_feature(aa64_mte_mtx, cpu);
     } else {
         bool e0pd;
 
@@ -9847,6 +9848,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             sh = extract32(tcr, 12, 2);
             hpd = extract64(tcr, 41, 1);
             e0pd = extract64(tcr, 55, 1);
+            mtx = extract64(tcr, 60, 1) && cpu_isar_feature(aa64_mte_mtx, cpu);
         } else {
             tsz = extract32(tcr, 16, 6);
             gran = tg1_to_gran_size(extract32(tcr, 30, 2));
@@ -9854,6 +9856,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             sh = extract32(tcr, 28, 2);
             hpd = extract64(tcr, 42, 1);
             e0pd = extract64(tcr, 56, 1);
+            mtx = extract64(tcr, 61, 1) && cpu_isar_feature(aa64_mte_mtx, cpu);
         }
         ps = extract64(tcr, 32, 3);
         ha = extract64(tcr, 39, 1) && cpu_isar_feature(aa64_hafs, cpu);
@@ -9953,6 +9956,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         .gran = gran,
         .pie = pie,
         .aie = aie,
+        .mtx = mtx,
     };
 }
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f8cbefec7a..cd93499307 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1430,6 +1430,7 @@ typedef struct ARMVAParameters {
     ARMGranuleSize gran : 2;
     bool pie        : 1;
     bool aie        : 1;
+    bool mtx        : 1;
 } ARMVAParameters;
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6cb0fe5645..8b54018c98 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1951,9 +1951,18 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * validation to do here.
      */
     if (inputsize < addrsize) {
-        uint64_t top_bits = sextract64(address, inputsize,
-                                           addrsize - inputsize);
-        if (-top_bits != param.select) {
+        /*
+         * If MTX is enabled, bits 56-59 aren't checked for canonicity
+         * during translation, since they will later be checked during
+         * the tag check step.
+         */
+
+        uint64_t cmp_mask = MAKE_64BIT_MASK(inputsize, addrsize - inputsize);
+
+        if (param.mtx) {
+            cmp_mask &= ~MAKE_64BIT_MASK(56, 4);
+        }
+        if ((address ^ -param.select) & cmp_mask) {
             /* The gap between the two regions is a Translation fault */
             goto do_translation_fault;
         }
@@ -3514,15 +3523,31 @@ static bool get_phys_addr_disabled(CPUARMState *env,
             int pamax = arm_pamax(env_archcpu(env));
             uint64_t tcr = env->cp15.tcr_el[r_el];
             int addrtop, tbi;
+            bool bit55;
 
             tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
             if (access_type == MMU_INST_FETCH) {
                 tbi &= ~aa64_va_parameter_tbid(tcr, mmu_idx);
             }
-            tbi = (tbi >> extract64(address, 55, 1)) & 1;
+            bit55 = extract64(address, 55, 1);
+            tbi = (tbi >> bit55) & 1;
             addrtop = (tbi ? 55 : 63);
 
-            if (extract64(address, pamax, addrtop - pamax + 1) != 0) {
+            /*
+             * With MTX enabled, bits 56-59 are not checked according to
+             * AArch64.S1DisabledOutput.
+             */
+            uint64_t cmp_mask = MAKE_64BIT_MASK(pamax, addrtop - pamax + 1);
+
+            if (access_type != MMU_INST_FETCH &&
+                cpu_isar_feature(aa64_mte_mtx, env_archcpu(env))) {
+                int mtx = aa64_va_parameter_mtx(tcr, mmu_idx);
+                if (mtx & (1 << bit55)) {
+                    cmp_mask &= ~MAKE_64BIT_MASK(56, 4);
+                }
+            }
+
+            if (address & cmp_mask) {
                 fi->type = ARMFault_AddressSize;
                 fi->level = 0;
                 fi->stage2 = false;
-- 
2.43.0


