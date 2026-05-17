Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5042ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPSn-0008TS-EE; Sat, 16 May 2026 20:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPSD-00077P-JY
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:10 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS9-0006rL-E0
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:59 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c802803ac17so396125a12.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978036; x=1779582836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgEG0/OuigOMwClChXrRoaFDD6e1qpvZV0h5+lZSYqk=;
 b=F143ZbtK8N41FeX/AFv2QiUYa1keMqblQk2X0ohapQs658zJuX7AB85sEA8em9VBxj
 5wgwKzlH7WnlcsvhfDmey97xbP8SD3cGRuV9d5IZYXB/hP7Bll+7mfB9y2YdfYBnKZJe
 UHD9WXUXhQXfesL+Ijw1Dp8Fu0uFRbdX0TQpZC2WEz+6gmz3kow1/o34uZ40Gqw4fchK
 NZBe8fvfY61WwfG2vFTaGo661sTxnsOYA72KgLW/cFdPWdopETh5BDBsVSxWgbd39Oz+
 jqT9ZVjsJJrHVb2phyvWxGuVgdhz+iJW5uPZOznN+kEyiVnSb2T70RDFPAgNeNRMHtTS
 gXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978036; x=1779582836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mgEG0/OuigOMwClChXrRoaFDD6e1qpvZV0h5+lZSYqk=;
 b=LzWKsKZx8qw+JdR6UfEucC0lXnm0ss7GNkABDpsMaxRGfvH+8guN2TfWequnJGRsAS
 jy8F6dTeUYyF1EA6Cz/NG31ottNdW72B8nhU2YFXZGrwrQqQq4ZupwoziBrLQAnVOExL
 jhMOujauSGg0BLAz4lGVtLF4KZA/+mCBP2F5+CQYItIqIyCgsvBV13Itg+WGc1W874Oy
 mOh3UugDgPBgOsDjwDayOJvMlGT3CZ4ZnziDTooySwN0K/iDuQ/mJSp5+x4ETqRbO92m
 I8b1vzeMzqJn6JkcOYOFv4eipF/qcnj5U7psvnqnwcyL37pBcI5uIKba00ERzp6xF6V0
 w0Jw==
X-Gm-Message-State: AOJu0Yx6zfdo7/cVnd5IlBPSEiCc0+qxXGi407vBjjqiQk0M7lmu/RAC
 q5jCt8NWqj2A5Mjf6blFLVYvV3Fv2SMne8Iw3meG8qysOo7/KOgwYjYygbqp7/W31p6TlutqpHy
 o0oC4
X-Gm-Gg: Acq92OG/zrqYzes0x960XVV7VFF5ABVLTPAeqiWcj02YCuuh74lyq8XYLjdiiDbPuKs
 dQ8JNkY8R6bz1ag6dz9pWjiE4g/ygMWNvWodbnjnYvJHbKbvaMvvodieES1/eg6oYY3OYMDvPUq
 iwfsPx6oOWA75wu07+oKkEQW3BwEYnZFJk/UvWp2ZPBXRIU3NBVGTcueIaEiiWlAWSnQ3QC/G+z
 T8mLHP3Zq8fkBdXtJZIzBFHHZxYs9pVxlAPepPlTu/uAe27ikVcx3QM7hSgnlUeRAqFYtsmfYIv
 zDCgNpxuHWlBR52PVOVkW8NkkA9BLxWHd0aseKVS9iY2+PgX3DkND3m39INsMdGph9JTteayyTi
 GDQUrkxe8nH/4k7pnmuNfAxahlgmZjEF0xG8QHTzao3a2ZamVZ/nYMS/oZMM3L+9cqZt6cQ1ynD
 E+8lgOwjj3GKUvXQS2UdYwBUQ7jV5b
X-Received: by 2002:a05:6a21:3291:b0:3a8:284c:fa3b with SMTP id
 adf61e73a8af0-3b22ee23dd0mr11102165637.48.1778978035740; 
 Sat, 16 May 2026 17:33:55 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 55/63] target/arm: Enable FEAT_FP8DOT2,
 FEAT_SSVE_FP8DOT2 for -cpu max
Date: Sat, 16 May 2026 17:29:54 -0700
Message-ID: <20260517003002.321430-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6dec7e045d..a43b6367a4 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1377,6 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
@@ -1397,6 +1398,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index bee4e36dc6..875716d18f 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8DOT2 (FP8 2-way dot product to half-precision instructions)
 - FEAT_FP8DOT4 (FP8 4-way dot product to single-precision instructions)
 - FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
@@ -161,6 +162,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
-- 
2.43.0


