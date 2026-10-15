Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE66C2D0A6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtL-0003os-7M; Thu, 15 Oct 2026 14:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtG-0003n6-5H
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:18 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtD-000117-B1
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:16 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso3156279f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087754; x=1792692554; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lAJlw2q+AfLYL9XhdvoTWLPFQHSKMTBhJwUcsLjGY/4=;
 b=MY/mp+rtTsnfm7R5GKq7FOZ8aksne4hUeSLL0nFbCASBUs7fRGiTbikxY9ZKoc9dtU
 rYt1++a2Aj/U7e3kk7V70N+XJJRS+L1M1foyokExP3L4P2GXUb0ItDL8cyZMP500HL8f
 su2UxIFHUW1S7q0C36bzrrgSGCvXlb8xb5UQaYapglbYhNBqEQzINpe+3XAWQSc5MNRG
 kFG+DJORw6IyreiGaMt4A1nTw3MQc7R7sRO8ywInGYu6QgRsyFJ+MoijKxp7p3kSHnfL
 ZjKSQQ08/+pE3xTkwCJ+ysIgxCBojhmeb7tBj0Sg7d1nzHJIsPjNa3+kSFGaJMtyZ5jm
 Z7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087754; x=1792692554;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lAJlw2q+AfLYL9XhdvoTWLPFQHSKMTBhJwUcsLjGY/4=;
 b=gaUIoEL5ECdPwBaXAjeDMW8XOiJ+2VaP3juug9U7mr2uOrTX3h+VeQ49SLR0nfT/0k
 zVYnS4ZGi7iHpGvSDTCcQq4c03DsenQX7nulGTpqTqnOqQ+WR3KT1JH1kCeW/GsShZ1Z
 1jYZW3ueR0ZrMWpBluOFwzBvQapdnJ8JWAsWyDooglYORVQoCXokFSHbBKbVBOAJd6kd
 JaGApvNSowFNaOSYWuK77Ow0pq29SwuNEjGqDKOqSv2L7Qx9uwycIE8wL7f7DvuypiiO
 +9vYDw0VhN68hEAr5W520xJL0umAr5KcqBu6zQ0WY8G5UKbdYYKQZ4QVw2MXy5ySOvmS
 fxLQ==
X-Gm-Message-State: AFq9FYJ7vrNxMFIeUmgyvyYQ1E6nPZAPdVITyUqQb60PJDWOyscFPgY6
 OrbjZFsh2DY22Tvxl2fIwm2+a4x4hCtFC4NYGIHqoIo5vLeiR4Yk1SmkjAOognsXB4/xCDwQUG8
 yCzHqNCE=
X-Gm-Gg: AYBFou0QSwwWLnJA1JY5uNQpO8fKGnaDfDL33hnvzi68YsV113U3+wZozNhQPlktFcx
 pvKo2CFK+sVYxYsM41y0rQsxY9oJImxgBil1jwyoQ+FxM0jWUSaP+FnSdHEZUh0BxQ3drbfVWgb
 T689DImoe+fd7iDYoMWTiTGiv1vMNX7ufqll3frpe8CTFi0pKBx/rCsPKA2amOzWth+x+ej8aK6
 CFVzcP2xkmF5nSlg/I8akFSDERf3CdlJ8SgGJYjU/eLl05UVM4cq2XzcNorZqNgFmZKm+oC2FNq
 w+ck7E6EOpw8zetpiCdGFUpFno0b0g0VXq014axp4a2E7GJzCHIlUmPIO3lLxAkjI1Ai4xcene0
 7FnYE2U0+daF/WrJ9gI+5N4THQay8tKMAe/kGJ9N9oZJpYonjjwD5bnpQo35uwc9aXwhN3X2499
 ZNkGFEGumP0+ovWNYGlQbUswQZJ1iGVgt9bOwf/oQ89ztd5b6P8GPPrsjA5334qsTq6WEqM/GyU
 +EFh9LAWY86isyAJvCuUo4iRCsXZU7xjT2n0/VT6Id3/Vgq7aC4XZrcYla+gQhkHoFXZZYTmO9T
 vFY=
X-Received: by 2002:a05:6000:440e:b0:487:13f:f612 with SMTP id
 ffacd0b85a97d-48dbacdbd23mr28269322f8f.37.1792087752902; 
 Thu, 15 Oct 2026 11:09:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] target/arm: Rename isar_feature_aa64_idst
Date: Thu, 15 Oct 2026 19:08:51 +0100
Message-ID: <20261015180858.1863407-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Rename from isar_feature_aa64_ids to match the feature name: FEAT_IDST.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261010070952.323466-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      | 2 +-
 target/arm/tcg/op_helper.c     | 2 +-
 target/arm/tcg/translate-a64.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a9eebb45564..2fc1bf02cbe 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1403,7 +1403,7 @@ static inline bool isar_feature_aa64_fwb(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, FWB) != 0;
 }
 
-static inline bool isar_feature_aa64_ids(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_idst(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, IDS) != 0;
 }
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index af56eff9f18..6a673e5ae6e 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1136,7 +1136,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         break;
     case CP_ACCESS_UNDEFINED:
         /* CP_ACCESS_UNDEFINED is never direct to a specified EL */
-        if (cpu_isar_feature(aa64_ids, cpu) && isread &&
+        if (cpu_isar_feature(aa64_idst, cpu) && isread &&
             arm_cpreg_in_idspace(ri)) {
             /*
              * FEAT_IDST says this should be reported as EC_SYSTEMREGISTERTRAP,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d5b11e2da9..0c712e7ac2e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2675,7 +2675,7 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
      */
     uint32_t syndrome;
 
-    if (isread && dc_isar_feature(aa64_ids, s) &&
+    if (isread && dc_isar_feature(aa64_idst, s) &&
         arm_cpreg_encoding_in_idspace(op0, op1, op2, crn, crm)) {
         syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
     } else {
-- 
2.43.0


