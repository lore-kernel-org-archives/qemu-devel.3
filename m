Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECCCC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONf-0001RL-SH; Tue, 01 Sep 2026 09:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONd-0001Pq-Nv
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:25 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONb-0007LO-Tg
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:25 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c252e703fa3so695065666b.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268702; x=1788873502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dz1l3VuVj9cJprVqo0yw94nF4DrO866Rb+MPBOk477g=;
 b=Wgt6Ime/PWY1DGMRo8s2BCAC1ce53GQBF3f3P0EfSj0r/ykfUsr649D5LE9h4SJ/w4
 1tHj5y3O78GocBeyT8lyrzWXw1dGP7UET8yptrdKwHmKXaq3+CMnT01SZ7embbJxOTdV
 JXXqDzzNYCOqbMPcAFU9B//RCdkUo6stRgCrdFlCGnjMssNHN72ucf2u5/WezbbWoO+V
 aVjoClXVkGEPScG+rXF2GGPW/lEKsCEIYFAHMp0bZ+ZYMs0ZUrAbUdIaLttDvlpYpddO
 2EXCub8oArqGfjgoeU24omomk6BscB1s9pPDPReIggqS+4YkUSbR8JJzQzYFfzGUTJwy
 75kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268702; x=1788873502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dz1l3VuVj9cJprVqo0yw94nF4DrO866Rb+MPBOk477g=;
 b=Nhv+ULOaQpxEnu17/6UpMq0dd5c2nIkL9h1WpLR1NQ4ccfGp58FsKv/B/+LC244aPn
 SJymsVqWMehqD0ETThJR7CId04UmGgdBK7diVX4KhdZFoK1AbuuEUvPFKjpW09JgeVIr
 yg/s/6jXo/9fqrNBYwOMnaCFzsp/dHV3KRq+XPlbMvvlgrApCo4HSwUgTFg+ddrIdZ6s
 56itkmpFMZG9jfU+cW9jnhpznKR0zC82DjnZelSWKOwgi7EUIxb765O+esVZ70i0hBHf
 YyNiefYZefCYipjcs+d9tChggIz69JErDzoHb4W9s94nY5pHQGOaBeFVkbG5X7jecgfo
 WO2Q==
X-Gm-Message-State: AFuF++kw7i5VW8CIVqoo2IU6cLzJ0fClXAOEsNuaoE+kJ0ghp18/Dky7
 eF4K5piLTlHNX4E0+dt9y0BUrzYwD/saILzCDxdPVR8EXosZvHzXRNd0nPYmtb2bhlV7+nn4Z4U
 KbTOv/AE=
X-Gm-Gg: AR+sD13xbopp0zHn4y6yg2dT7EN3YtPoJIBrDcjwEJLq/VIJLz0kfezp09ZMvyZ9oiV
 QPVZfiBRj90d9IEo+PyOXT3SlRhBtFJWzz1rgbesQ1NOcGvDsk6G7NX0RPMp5WZzvA471qmqclR
 CZssOJSbLj/OWtDShLnCZ/tYgySt0dx8R3B3GDiJ5+N0q2P/wCGR2atWx0HXAW9OjBq7YHcEiM3
 2x85UW+l5FJoNSBMb1LC46fSSdX+wXqruuCJ4qszfkVWAuXDAXfT0uUaWI6pcLITslJw0Ftb2gY
 3IBM/0PhSdcAMoQyzNcAsgiE8hq4zChab8jXD/8rcY3G7CVVKqfN0XEH00EF7PXi+kqb2ZO3/Yi
 j6ch8MobVDGflEmrWCPlSauN1ekL8d8C4zm0PoJyFN9qXN+6yh4LxBG120ihB4illRsJjwIcCDN
 NZxoA3RtHBEIYFOfCYMnte5zQgcJas1puxkPJ/GmMtN6OQwg3QEPSRnEWKt/cycXbdGAV5I2HKJ
 lq8jlJ4lTCldfTZElzyM+/YEX+YuCHzofQ5MYR4NaO8xzMvZUrJSMHRvEbFhb9YF1KGCg==
X-Received: by 2002:a17:906:eb54:b0:c25:23d:5295 with SMTP id
 a640c23a62f3a-c25b3cdfea1mr472927466b.17.1788268702316; 
 Tue, 01 Sep 2026 06:18:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/58] target/arm: Rename isar_feature_aa64_sve_bitperm
Date: Tue,  1 Sep 2026 14:17:23 +0100
Message-ID: <20260901131732.2263947-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

Rename from isar_feature_aa64_sve2_bitperm to match
the feature name: FEAT_SVE_BITPERM.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h | 2 +-
 linux-user/aarch64/elfload.c       | 2 +-
 target/arm/cpu-features.h          | 2 +-
 target/arm/tcg/translate-sve.c     | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index 6f9d192b4ff..818b6f690a3 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -128,7 +128,7 @@ static uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
-    GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
+    GET_FEATURE_ID(aa64_sve_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 40c5e1dbd38..0569350e376 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -194,7 +194,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
     GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
-    GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
+    GET_FEATURE_ID(aa64_sve_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 8e00b82ad18..7d7837c6851 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1544,7 +1544,7 @@ static inline bool isar_feature_aa64_sve_pmull128(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) >= 2;
 }
 
-static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sve_bitperm(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, BITPERM) != 0;
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 773e4ba4e7b..87d6b5785c4 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7430,21 +7430,21 @@ static gen_helper_gvec_3 * const bext_fns[4] = {
     gen_helper_sve2_bext_b, gen_helper_sve2_bext_h,
     gen_helper_sve2_bext_s, gen_helper_sve2_bext_d,
 };
-TRANS_FEAT_NONSTREAMING(BEXT, aa64_sve2_bitperm, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(BEXT, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
                         bext_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const bdep_fns[4] = {
     gen_helper_sve2_bdep_b, gen_helper_sve2_bdep_h,
     gen_helper_sve2_bdep_s, gen_helper_sve2_bdep_d,
 };
-TRANS_FEAT_NONSTREAMING(BDEP, aa64_sve2_bitperm, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(BDEP, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
                         bdep_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const bgrp_fns[4] = {
     gen_helper_sve2_bgrp_b, gen_helper_sve2_bgrp_h,
     gen_helper_sve2_bgrp_s, gen_helper_sve2_bgrp_d,
 };
-TRANS_FEAT_NONSTREAMING(BGRP, aa64_sve2_bitperm, gen_gvec_ool_arg_zzz,
+TRANS_FEAT_NONSTREAMING(BGRP, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
                         bgrp_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const cadd_fns[4] = {
-- 
2.43.0


