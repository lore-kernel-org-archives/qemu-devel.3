Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304B5CCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cAv-0004pr-Eo; Wed, 08 Oct 2025 17:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cAI-0004Nh-PV
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:47 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9D-0006iF-Px
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso269510b3a.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960591; x=1760565391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKF95GX8K6UQPc+7dLjJ/vwGmksDSxb1988rF41Urv8=;
 b=tolqMSiLqv6vLWknTsOVzO9d492riIqCBSsLln8nfTTd6VAE5Q64ziGVANVgnngeph
 IhgL1L0nmUOj93p1PDO3GHJGpFCilbroA0fYs56CpZX6W12VTw4cnmcfhUHoCJ/10I6x
 OOfUfJ9p1jT/sQ7pdPzpK5cXC/zyBbgYxRrxZPcly8inGpkSc/+xop7247C9brh3SjYh
 4xzmguTy87vI0rJFibTgUtP9RgZX/wobg7uDcXUBamI59zEdLEx8m4lpMniqCBCDDk8S
 325J45gxs+wgUyB6pf3JWghTsSeZDrP9cUXIcDMdil7KtY2ZiC7VZgqX6yYtHjamZ1t0
 MecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960591; x=1760565391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NKF95GX8K6UQPc+7dLjJ/vwGmksDSxb1988rF41Urv8=;
 b=WMkllNOfQJ3WLk7qmEZXaLTVlZQ+Fw2v6mRR9QfHwhiS7cKS/GaYAN6mP8k4r6paE7
 jOg6mMMDZx0/wK61UJx/Hxx9y5vmrRvjkptmO+VWFB3KvzDHXn4ZIPkB8/Xzi84W6XQW
 ieZz7LxRJvy/f83hf3qcQCH+yHveya1qrTp2slnXxhf96nfqxRD68tdYAx2QgHOtNaYC
 ILCJuV50XK+5MEmBq/fb4WrCpPZrR5BmysmncNRC/PfmoRpNEN2HdLXTvYQiLaEC3NgT
 1wRwgdEBXSIM+kWWTwPaLvxnCyKykcnthQD9IkNRgTnDOlMxoCLPzC+l9oCbPMUfdWHQ
 F7KA==
X-Gm-Message-State: AOJu0Yzg7YwZOLyH7xJtpfWcqBRFSbDC15JAQ2b0JVh+xSkRW8TBZbD+
 48Fq+oOxw2LRS9SG6AQQolY4IMqY9vHSrZtt9wspnSO3jhn8pB4VlTwp+Zz4Ok/R2oXuDmpQikd
 N7BQh0/Q=
X-Gm-Gg: ASbGncvYteBt/RAYsQDbDH8kY6qoxBjmeWo1a6HOE4n8142yuMWrRvRUd+IS/ZPfcmf
 7JYAVyGbwvciqCbPxEfgVJlt/7uzRb3ml3WmnyRxLsn2uca0ZNyFft00LScMHPqNaGo2KsV/CFJ
 y15mRDP+YI9Nq5fHzdFDrZwRHnY3SqTGVGw5JaMpq1QgaexeoH4vQAFAbncUbZH8vLi8Kdk+1Ev
 kaTX508h0XwJd95SUxB4lozxlGWWZ2UV5qnId4l0GCovGc0RlZQ8QYXyRDq65pyr9nv+H5Av9d+
 HxkD7OpuF7UuYR8HKTrf7aysLlFU/OBeK0bdq+5N3nBjgzTXD8bR7bTrLY1SxZBXsESMWfiWVm1
 ayoSYM1RCuM9AqICygvJLb4Czbqj+K9dELFVfpQeu+Rc8Dn5VHwJFQ73C
X-Google-Smtp-Source: AGHT+IF4fAyhjfc92SbDAqQE8B2sCI0bKKDuBmxUt9o1gRNvjc1rDBwTNz82G91PNQHMc8OKjJRQMg==
X-Received: by 2002:a17:903:2d0:b0:25e:78db:4a0d with SMTP id
 d9443c01a7336-290273eddd5mr63870355ad.36.1759960591563; 
 Wed, 08 Oct 2025 14:56:31 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 26/73] target/arm: Convert regime_is_stage2 to table
Date: Wed,  8 Oct 2025 14:55:26 -0700
Message-ID: <20251008215613.300150-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This wasn't using a switch, but two comparisons.
Convert it to arm_mmuidx_table for consistency.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 5 -----
 target/arm/mmuidx-internal.h | 8 ++++++++
 target/arm/mmuidx.c          | 5 +++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 92883b6c0e..591b509e68 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1027,11 +1027,6 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
-{
-    return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
-}
-
 /* Return the SCTLR value which controls this address translation regime */
 static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 55fba4aae2..1d948aa6f4 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -19,6 +19,7 @@ FIELD(MMUIDXINFO, 2RANGES, 6, 1)
 FIELD(MMUIDXINFO, PAN, 7, 1)
 FIELD(MMUIDXINFO, USER, 8, 1)
 FIELD(MMUIDXINFO, STAGE1, 9, 1)
+FIELD(MMUIDXINFO, STAGE2, 10, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -84,4 +85,11 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, STAGE1);
 }
 
+/* Return true if this mmu index is stage 2 of a 2-stage translation. */
+static inline bool regime_is_stage2(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, STAGE2);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index c5b43a5932..61a682e655 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -14,6 +14,7 @@
 #define PAN    R_MMUIDXINFO_PAN_MASK
 #define USER   R_MMUIDXINFO_USER_MASK
 #define S1     R_MMUIDXINFO_STAGE1_MASK
+#define S2     R_MMUIDXINFO_STAGE2_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
@@ -33,8 +34,8 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
     [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3) | PAN,
 
-    [ARMMMUIdx_Stage2_S]        = REL(2),
-    [ARMMMUIdx_Stage2]          = REL(2),
+    [ARMMMUIdx_Stage2_S]        = REL(2) | S2,
+    [ARMMMUIdx_Stage2]          = REL(2) | S2,
 
     [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | S1 | USER,
     [ARMMMUIdx_Stage1_E1]       = REL(1) | R2 | S1,
-- 
2.43.0


