Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB51C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHeT-0000eW-AL; Wed, 26 Aug 2026 13:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHeC-0000FW-5G
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:50 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHe9-0004tQ-UC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso1087810b3a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766164; x=1788370964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WcqSBaVjhH1d7YFiqGDU0Fw0I7AmRJueXueVuRFxO2w=;
 b=OaEgHm/OOa9jSpLhqI/kETp+cP5lh0gOHrvWyQzM4bPY1qaTFV0M/92HSrAuZyTRyc
 WN6HQnP0iOQdgrHCx5E4WtnwMMSE25RNHjiyr8Gc3V/CXsVLBRbb9u4636joh+Hc7VhJ
 /B4YL1+mln5q4l2RgN5+8TbUtVlowRQNClieO7C4sbvxtzOWWjQjx2DfokdeWn8LDlWy
 lbD7/lU9Eu4yNEo4jGvhLgj7IQF0JFranvZz6yk1Gt9DV4q6DTA+AhKG8/C/5uG74PCX
 RQE/swm7WLRztmrCFmzcHaD4XTlrZH+Pw3B0V7cHEqDNLFEm4iNm/P/HgQ3aBlemzFUw
 a+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766164; x=1788370964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WcqSBaVjhH1d7YFiqGDU0Fw0I7AmRJueXueVuRFxO2w=;
 b=qcSMW+c3tYedSrOfVsEYX8YWGysHgUYfiRHHjmT9YsFVSVhaqeKbyvGoOLwnFqp6XF
 GbLyh/3cMmiPcyqhMO8aI7cW+zCjbsII+RHDOVEPOcsZARMWXVogRY7uNvu8kFqJqrFi
 QBRd2HrMw1gKcJxSVEBGWDb8zmYRZZMK7eJdSkkVPDfIBgyngfF49X2olW/s0FjwRRvQ
 9EQufna7RqbuhQxqI+g6bWBXdBFOdb2prJedtPdSTKR9Cm7ScypmxyTd52xjSqbyr6HF
 HNB8cb2HrWDFCE9aMghvG4KGdPIPMwHVCMwpoN2ryHH2jzNbpdp3kj/i5iplyPktCicp
 4d9g==
X-Gm-Message-State: AFuF++mzYuNIHTEw0RsaU9R6cOvnAnDxC3dzK2F6wBUu1UFrht3d4Hm5
 bl4Sw/YEVcVFko1ynedYbdzqsYM3KkE43Enfr1nPINABEXLPiihzevl9q/lNSKtOyFLJkH/DqYt
 AEm/CG/A=
X-Gm-Gg: AR+sD11ppz7/9vVxw/vnimv/A8SsUvEwX72lOQhceArNkYHx/oTACXqpFQZ+0wXbKFE
 5A5Sfoj8yAMVAoM+IBIxXNIunu4Uuz4T7CUvYIYFEqEHe+VopyMVw0InlKq04z9c4Pe8n3qmfIr
 wF4Tsqt1IC8ONUBPT2DOpaX/NG368vzONjcVotCWP3Zq7Ilst1CdHYvsqoXH8EQbD7iIhwFjcSH
 KLxRUxg3xpq3XD7FzgyYLlC2H0sT737sayrGrny8Ty9J8tMMTOPYd2Ho9p13ZBCpXiypBwsJJma
 7agzbEPBQ+Q4+jupEFH+Y4CssBZMJkgqZfYzL3ku9cnuqs4sHKnox31OicGNMvSauLOwIM/bHq7
 QfIVn26O1zzjLN433kw/M7PrH+VjIcDNyF+IqEnFy2WfgLVBJ8Cq+7/JbBZO6ChwJoJA+mwq5Ji
 YAwaYI9TeyoTbVV/XKabWF8ijSMmywCpbTZvhJ1F0aJJFSAXehuSxAPBZtI4P97wwWjjMGumqym
 BTbAyy8Gx52c1OJAw==
X-Received: by 2002:a05:6a00:8d86:b0:848:2eac:bfb2 with SMTP id
 d2e1a72fcca58-853748a0551mr17812185b3a.13.1787766164380; 
 Wed, 26 Aug 2026 10:42:44 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 25/25] target/arm: Enable FEAT_SVE_AES2 for -cpu max
Date: Wed, 26 Aug 2026 10:42:12 -0700
Message-ID: <20260826174213.614571-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

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
index ab32cedba46..e7e35991bb9 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1470,7 +1470,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 3);    /* v9.4: FEAT_SVE2p2 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 3);       /* v9.5: FEAT_SVE_AES2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, ELTPERM, 1);   /* v9.4: FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 2);    /* v9.2: FEAT_SVE_BFSCALE */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b9c6b8226d6..64fe0480023 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -198,6 +198,7 @@ the following architecture extensions:
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
+- FEAT_SVE_AES2 (SVE multi-vector Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
 - FEAT_SVE_BFSCALE (BFloat16 Floating-Point Adjust Exponent)
 - FEAT_SVE_BitPerm (Scalable Vector Bit Permutes instructions)
-- 
2.53.0


