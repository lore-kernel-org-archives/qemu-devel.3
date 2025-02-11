Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED57C021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7E-0001dn-7i; Tue, 11 Feb 2025 11:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht64-0006mo-IY
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:55 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht62-0003UB-LR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43618283d48so40482875e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291209; x=1739896009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OWU/PlXSyEzT9phV28MmmzHlFyTyrUZHww5V+yN3G6E=;
 b=Fm/u8KQeSJpc9TWXwFrWk6bUGqmCquQF5jDeFGygPJ7wrTuTyZ0rluPgh3DvjnX5Il
 MHdxLL4+FLJvfI7vQOqODZHikXdm5FosPKsYRF5vYfHnX1w6GJtSlSkdMak0ElNIjc3t
 zK2Gsa+UqVwEsal6GfhPPLqopB+TyC4bJU0wgwoOkHHKTPFG9JPyje3rnxEzohS+UfyY
 w7R97VR36ROeDUZt5qBeyZUqJb0RH5EiAcOx2Jon8A16AKshM3Y9qIs4eceaCmJgcz1R
 20AG7rzB5E//YRISuiwzJ1809u/yxV02TUYWu4Zwgn5EOHC2zeTr2JogGvfhww+RpAGu
 7GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291209; x=1739896009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWU/PlXSyEzT9phV28MmmzHlFyTyrUZHww5V+yN3G6E=;
 b=O+5eDh2op3yznNG/sRiJOCqpf57uye/sEuQJz12wqx1TY+zFV941JYXQ4eJr4geflZ
 jEdi63RbSSngezYqMJH3lmgkxXJyUJKiEnrVSWiwEDl5LjFPMS743cwE+DC855v6cLzT
 g8Atx8YaB5wIvO7c/wgHjzWiYBP8PUhU0vG8sC+gHancmcDWPAb2bji5TpN2Cy/OGCo/
 obJmARe8FYYYcLBUyrBZJXx21b53A8YTaA6N0igqJWQceqnTodZyv/rFn2DQK0HuYrYZ
 uAdVUT4BMdOaXjW3njXj7eMESTF6wHjgTLTrXA5AhdbqGcE5kVjHMkWpl41sA8dJDEup
 mbVg==
X-Gm-Message-State: AOJu0YwUzvMoMeyT0kBOCQl3XoBhrocbNn4SX3tWmLS3WDxse5FhPLDa
 TW9iDUceRH2BVyzZ8TEJidPsdKPXHEqhu2UHbEZr5dy5LeA3V7QXqC9QDuEr09vyvQdtPoziEdf
 d
X-Gm-Gg: ASbGncuJak/W8n2CzW8ZI+jhvdlRuGkSlVNcOOFVKEUipRbQSdC5fvzqIdUGp4D5dH9
 70F1I2poVk9m3OyWKpvtZIYQMnOU/hmw30FV2l2uzci/PknYtRofFJHPek1TJSreMO7x24aFHHm
 gpp2zwxOHvtxVaEiDWeZ482K4JaQh+XEaZ58XimQn0Qt/o4pJETJMc7HO5v32SUrks4j5/jhMWE
 mK/Ln/Rnbz7Umd7tzP6Viz2yHx0bfrbjZhLtPiYoNCxAf5NcESh49YAtPtU8dRJ/vPdD0m6hvbs
 tDtn0ecXQmvh0zV9LaCd
X-Google-Smtp-Source: AGHT+IGdC8QgAqRueYnBM5SWJ9rWQy0TrxXVNHDf7szMd5MuD8sFMB5rcrZdbXNPjCrDvQgK0qIThw==
X-Received: by 2002:a05:600c:3843:b0:434:9934:575 with SMTP id
 5b1f17b1804b1-4394c821249mr51904505e9.16.1739291209039; 
 Tue, 11 Feb 2025 08:26:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/68] target/arm: Handle FPCR.AH in SVE FMLSL (indexed)
Date: Tue, 11 Feb 2025 16:25:35 +0000
Message-Id: <20250211162554.4135349-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Handle FPCR.AH's requirement to not negate the sign of a NaN in SVE
FMLSL (indexed), using the usual trick of negating by XOR when AH=0
and by muladd flags when AH=1.

Since we have the CPUARMState* in the helper anyway, we can
look directly at env->vfp.fpcr and don't need toa pass in the
FPCR.AH value via the SIMD data word.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-32-richard.henderson@linaro.org
[PMM: commit message tweaked]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 5f0656f34ca..42bb43acd78 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2250,23 +2250,32 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
                                CPUARMState *env, uint32_t desc)
 {
     intptr_t i, j, oprsz = simd_oprsz(desc);
-    uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
+    bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
     float_status *status = &env->vfp.fp_status_a64;
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a64);
+    int negx = 0, negf = 0;
+
+    if (is_s) {
+        if (env->vfp.fpcr & FPCR_AH) {
+            negf = float_muladd_negate_product;
+        } else {
+            negx = 0x8000;
+        }
+    }
 
     for (i = 0; i < oprsz; i += 16) {
         float16 mm_16 = *(float16 *)(vm + i + idx);
         float32 mm = float16_to_float32_by_bits(mm_16, fz16);
 
         for (j = 0; j < 16; j += sizeof(float32)) {
-            float16 nn_16 = *(float16 *)(vn + H1_2(i + j + sel)) ^ negn;
+            float16 nn_16 = *(float16 *)(vn + H1_2(i + j + sel)) ^ negx;
             float32 nn = float16_to_float32_by_bits(nn_16, fz16);
             float32 aa = *(float32 *)(va + H1_4(i + j));
 
             *(float32 *)(vd + H1_4(i + j)) =
-                float32_muladd(nn, mm, aa, 0, status);
+                float32_muladd(nn, mm, aa, negf, status);
         }
     }
 }
-- 
2.34.1


