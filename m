Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC64DC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHeM-0000WB-Fu; Wed, 26 Aug 2026 13:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdz-00008i-0E
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:36 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdx-0004pX-Ah
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:34 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cbedf318752so1031502a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766152; x=1788370952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ERfDSnUduaOm6qJDiddHmbIk6DHXCcmbBBMAXkOdJE=;
 b=oZH0gnjwkRMAgX1HHWxofRn/CcI/DI0tkhlpOi5nRXogEquD/+CBEPGZ7Y2aVo7+G5
 LCvt2Izg7+Ltd7OE0AI0KvIH+tQMkFkNSA/PXzcZSXDlbByLj6ATkwte6Kb2FXazbzlW
 BaB8cnGyAasamsYliNZW5Sm57nNjGoXQcKXpyc31+SBhPVVZzeLnHMwOaKfTMQCpi9ZC
 xAr07tb8H07IkpnmFYOwmMt3XTXoQGFObkej0HCRlorKtHGuWoda2a4kuFyKUDhtZcgP
 JlgHNzGFhBuNpJAhkTB3ac7Ueef3SQHrBJ6sWtmnOIQCf+GCXaADpAhvpGbqi7vTPfQ+
 w0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766152; x=1788370952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1ERfDSnUduaOm6qJDiddHmbIk6DHXCcmbBBMAXkOdJE=;
 b=k1yeoJrYvtcljIvqM/Wrlv4GWDv1sdcznfq0q6QdH0lEdmQ/aNyBX0kPmo8WngsrFL
 +zIsgc8LtneUpfGQLI4StQE0rU8PZA02762BjN72gn4f2xNeTMdBp7Q3T7AO3y+36fTm
 pK/ufA+syXmLZ1DU6fhHh9aoPast0ifnBILQ46KiQ9aqQWqNuY2aQG5vRBHyUha+jiB2
 Rv9ZaG/Iq1D2UPoGf4eUPm6Wm6keysxvSJI4wH7q7Ql1ZMZq61Gg6icuUY3RBY9OqnmB
 NSSGIziT248LO6XXVKzhLYNzqeFt8hqQP7pNg7lK6UjTL41jgW60lOUTloLyt+C1LAhr
 40CA==
X-Gm-Message-State: AFuF++nkvc34ZlgqgGX9yTlYosz8/vVRN36eJ+VFL1FY6KOqFcl5mJHS
 A+ZYNn5nTR8MUDbAFy15s0x5fEJbdrHWF+CBUnDy/qOVcpuY09Cn5Pw3rVT0ybJqS93SQ5UE6Ob
 3pzLzlLM=
X-Gm-Gg: AR+sD13rbzM2y0VdR9V/+bu4uhlzQMUu6rTyq6YXv9Xa3vnsfyi+MINxlyKMUPq8O4Y
 DPeKamKlLYBzx/8zpEOlIlS8HbBpdhZr4x5BFqZslQGuRamO4kyScm/wN0ClkTtno/VDyC5voC3
 jaqQCHBI+cIVA+TSufdqLb9XCtiEIPCZk8yi+9/1dw4sisOGni3eOox09pEVhGp2lPBuCqr2+Zi
 x7hxvE77PjVVbHxphimUlUrOCKxP8G0cW90NDbFNttDAjl1LQ1jRy0EBSzW6zHl+Lpo+q81Sq8e
 NUpiVoeYuQIq71mG4lI+i8rAKTco7NRHlZyVHSLqPH6CXZCjbhc/Sy5PiIYdhhnhb9xuUmA4VLJ
 /yejhox3j6DCKLzwQgBxVlFuV6BLRoxL3PVIqmVo5QNmALU7P6RlWm6c8aqbpOzDkvpw10wX++E
 4FAZcdjYpXt26OFwY8ldezN6FVjnPO7oyXASbaN0Iz19ttmkRkuqW5gElbVQqzT7LBzfyOsE5KI
 rm29pneJ5fKAi3DZA==
X-Received: by 2002:a05:6a20:6a08:b0:3b4:5ff3:45cb with SMTP id
 adf61e73a8af0-3cf8281fc20mr15273315637.8.1787766152017; 
 Wed, 26 Aug 2026 10:42:32 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 15/25] target/arm: Rename isar_feature_aa64_sve_pmull128
Date: Wed, 26 Aug 2026 10:42:02 -0700
Message-ID: <20260826174213.614571-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Rename from isar_feature_aa64_sve2_pmull128 to match
the feature name: FEAT_SVE_PMULL128.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h | 2 +-
 target/arm/cpu-features.h          | 2 +-
 linux-user/aarch64/elfload.c       | 2 +-
 target/arm/tcg/translate-sve.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index 2fb7dcd778b..6f9d192b4ff 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -127,7 +127,7 @@ static uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
-    GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
+    GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b29cd490200..750be9b1b1a 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1534,7 +1534,7 @@ static inline bool isar_feature_aa64_sve_aes(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) != 0;
 }
 
-static inline bool isar_feature_aa64_sve2_pmull128(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sve_pmull128(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) >= 2;
 }
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index bcf2e6b9c18..40c5e1dbd38 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -193,7 +193,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
-    GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
+    GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 37875b6b366..773e4ba4e7b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7243,7 +7243,7 @@ static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
     };
 
     if (a->esz == 0) {
-        if (!dc_isar_feature(aa64_sve2_pmull128, s)) {
+        if (!dc_isar_feature(aa64_sve_pmull128, s)) {
             return false;
         }
         s->is_nonstreaming = !dc_isar_feature(aa64_ssve_aes, s);
-- 
2.53.0


