Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D92C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONt-0001n9-S1; Tue, 01 Sep 2026 09:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONm-0001Y0-Uk
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:35 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONk-0007NQ-Pz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:34 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c25b3c641fbso165521966b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268711; x=1788873511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qITKsIxtXC02USw4RCkiDe4n2mh2AEXUq7YirI4mg0A=;
 b=rhvy4Gu+6MzKX3J3D2xC0sgNveAJ9p/bahkpZIrnBdGRXSNpWadNmlh/ytzgTwHpCT
 6qm4X6DKD/U3sIo1ZOWdO6DDJIIj8//UH3zRRqNU0U/INc5B8U0Fd3DGYGVu9tVsfVJw
 F6YL1i4zJWhfvvHlysLO8oMMf8jfHwwCBnIfkXFMYWKANFowMb2lAiCVLrsS2Jzb9NZp
 uuBUuuPiqbQpL5sPs2fa0NgH8BROj89q/OP9MrRRXXX5NxC1h1PDrQ7LBv0pqP5QUgnk
 jQ4W3W4c+EZsgHEo67SH7poZFmRkyTGOwC+LG6VRIeygmAhQb76o//RJUzzF8xcXjmyv
 kW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268711; x=1788873511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qITKsIxtXC02USw4RCkiDe4n2mh2AEXUq7YirI4mg0A=;
 b=kvnx7BgCNSzACC9PDgCGZbEsJrg05QLno5b948TI4oIv46ZjKgjANaXx45oZinJ9ml
 W31CblGW6eIXI4I8DeHmSmnJnZ4qtH7op7mWKFAPVAK0i9c+FWO9e0vmgO8RARqUv/Ct
 5VcLwcqFcrVbkaHF47k9B8MKlz2qaOMQc3WeV5ig25yhltt0n65EZsZoBI550WjQ5qIO
 EMKfLZPnqGZ42cuZjZ1uUFFORMRBOdL6+NQZnAk210XdkabJ4cviE3BMJaqagAVfP8FE
 wHdggQ91b1/pkLwk7X7pAjfMmP8ylmgws2JreC7hflTxATNzTFRxf0/xF3AyO2uRB+nJ
 FfUw==
X-Gm-Message-State: AFuF++nl1Ohfv+9sbs0jolQnsm92/xBDaR3uF7fLdEbaert/zKIvdalg
 tQ53++2YzXKhow5KqcsBNAmi70vvULkUOfdfqwboWhvS1LPCtNZsWJAzu6K+SztIlUu1h8+osoD
 98hsc/hQ=
X-Gm-Gg: AR+sD10ryKzksqzZSKFroVvwGEvMhTTNyrNA9epGXEThppbUg+15nCxwRqjP8AvATcQ
 8AsdYJsyZg4rfvoYQw2eD4ccHZnkwvSV4UaXNc5wdp6nC15iKwlTB4pyFYa+GrOO+GIdchknEt2
 PqjakF+iLBuIhLwNFClviIqZcwbI+e665/3cRQtxFdmH6l3q9tZ8Zh5bckwUt24wF4fteIMHe0Z
 WvjxBu8vM1DxNiO26QidKhhYHeKWC3n9hbd6cM9zxU6XKbmZ81y4hhi8Z2pIppOZ2FSoJj+Sxb7
 l2h7C8GvNnFW1iUlMPrWyiOfHFith3kb5BpHPhj8y44EvzFn4Q7nz7gs9FU/+hrDbww0mI4ZkzI
 SxvqaAwvnInsXfJ+niuavtzGOD2xEH9O4ejizLr0sEE+SYiZeIkarYxv8sr6EZzI5FqTzl7e5H3
 PvQTzjm8tzDqZs/Ixi61CmQ2Ikepi6a6ax1EUuZaLIKt2T6YvuWwr5AYZSupRw4zN7QTfpHgN9i
 RR9zzqdIBbHwqSDX1jPefBXP095A+FGEJwBaFBYY/2agQfWlr4sVFzVPYLLbTXsIOUdWg==
X-Received: by 2002:a17:907:3d08:b0:c20:1bc5:7002 with SMTP id
 a640c23a62f3a-c25b3bb9072mr607584566b.3.1788268711301; 
 Tue, 01 Sep 2026 06:18:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/58] target/arm: Enable FEAT_SVE_AES2 for -cpu max
Date: Tue,  1 Sep 2026 14:17:32 +0100
Message-ID: <20260901131732.2263947-59-peter.maydell@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-26-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index e3ec4b6137a..34b63f9867f 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -199,6 +199,7 @@ the following architecture extensions:
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
+- FEAT_SVE_AES2 (SVE multi-vector Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
 - FEAT_SVE_BFSCALE (BFloat16 Floating-Point Adjust Exponent)
 - FEAT_SVE_BitPerm (Scalable Vector Bit Permutes instructions)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 4359312ee38..f87f22f6903 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -182,6 +182,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_sme2p2, ARM_HWCAP_A64_SME2P2);
     GET_FEATURE_ID(aa64_sve_bfscale, ARM_HWCAP_A64_SVE_BFSCALE);
     GET_FEATURE_ID(aa64_ssve_bitperm, ARM_HWCAP_A64_SME_SBITPERM);
+    GET_FEATURE_ID(aa64_sve_aes2, ARM_HWCAP_A64_SVE_AES2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4994a87afed..affd87a3ae5 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1471,7 +1471,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 3);    /* v9.4: FEAT_SVE2p2 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 3);       /* v9.5: FEAT_SVE_AES2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, ELTPERM, 1);   /* v9.4: FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 2);    /* v9.2: FEAT_SVE_BFSCALE */
-- 
2.43.0


