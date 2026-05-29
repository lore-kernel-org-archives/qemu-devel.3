Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6DECD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Gj-0005IB-45; Fri, 29 May 2026 15:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GU-0004zO-AW
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:07 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GQ-0005XK-Gl
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:05 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e36bb16a92so7246757a34.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780084379; x=1780689179; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oDpWaDAEPKN3RkVcJKACHpjqaDngYGGItVQvZeumSHU=;
 b=nZMUy+NegTwL5JbhcP7XYOB/k+wt2d8s2dDV7HQpy23u2MUPXqQOc/YLeJ29yjccI0
 /X+e5EaRhi8Qc60aawHRfs/ggHxKRO4w/JWOWLtdt2p1/h5RVVpZJIdgh0sMrPCwM0uU
 Ti1mKX4BMaSKVRv5pI+6OLqIsSRXndhvgwErdeWAgK9hrXDq0aQ8QLu6rD0AWD9hBvnD
 83piKQ2+IoH5Cl8l5mwoWdj0a5AvN2cHIc6DKByKIvSpnxDG8Brck84jEVULyVXiJJDN
 PI5N1BAEi2vLMLw47DBruyR9qZ5cXVg/N+SEPBCRUzRkPUvtykUeqfWMo030YveKIzWB
 oCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084379; x=1780689179;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oDpWaDAEPKN3RkVcJKACHpjqaDngYGGItVQvZeumSHU=;
 b=SBT5v0JOhhs6PwBTpqlmpPEYua7F1RzYgV9dNnxf/cknRoC+BzpktjRgdaU7hqMHZr
 wUKQJciqFNo0DJqQa2uFZi13oP31aeQm3CmhSipOPBNYTwLWWD9CUMpzGp2CQt/a65zp
 aj5vIC1xzRhNI8OEQ4pkqRNtWosWo9WEY3dqRGADe8SHe2k5YiTN/NZ9IierGkn20Sn2
 8nTS3XZ7b7gcL/BXPQQLtX/TcKwPBPnV2G65QGYm8TZ30WO4Y62n9ieieDLgXmWWj/cp
 bKrwCIdMpjxVzgr/HSe6oTvT9BaqCqmHiyvTZMUn9JVFgpjVn7k9oZwrtrUb9VQXe6ri
 oB+g==
X-Gm-Message-State: AOJu0Yww0kOWK4PVbyiowtZkqpd8vCMDJyQls5qw6BEOHzNwUlwXGWkW
 2ONMQc5g2b7Y2p2ecUenETUjDK6VSaRiZ99ZebEHWt5NWqe9cEw4BhBG
X-Gm-Gg: Acq92OFa+IEhTyQEHTf7t9A9D/fjAF0j8IVEVYieEmS+qhZloOFz8vix+YBDFEHBJUA
 qHdiEl9gxCmDMnfeAojNQwsSLvKHARxM4stzUKui7r+KgQ8g0DcCgoi9D9fgdzFS8ieeArK0N6c
 nu3JM6DPvSFgvrrRjf5OsYQLNIXTFEhwGqXqePQZLIjHBeehyezVUKhjTyUcByHjVBpOQAzRwvJ
 dGkGHRxtSzg0kFbRtpsYOUmNFqdJiSuWcTeUeKfXlvCe7ju7gOnXB49CMNjdgMeaBtYcCzGNxN1
 UFe/dex+ZMQ6O4tc3vxLRSWDGzKJN2eusLtPvOPnQbT8PgEV1G0hKa1TvtkK6NsdUVZnk6GF4dW
 3N9PWmP8VdpInok2xXvcGPuorAxdNk4cnI3BOheP2LJjTeddRYmvwWiVtHdaE6cDNYuSi7se3Jz
 vyAM/Iv0mHFc1ckytPDmM+/wSUAR/F5CtrpQlMt6wiBdHYvw0DL0Y1dA==
X-Received: by 2002:a05:6820:8c8:b0:69d:fa9f:87c2 with SMTP id
 006d021491bc7-69e104a732bmr416915eaf.24.1780084378974; 
 Fri, 29 May 2026 12:52:58 -0700 (PDT)
Received: from [10.21.163.79] ([146.74.94.63])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e06587eecsm1626692eaf.0.2026.05.29.12.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:52:58 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Fri, 29 May 2026 12:52:42 -0700
Subject: [PATCH v7 02/15] target/arm: add TCSO bitmasks to SCTLR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-feat-mte4-v7-2-ccbd3c14eb3c@gmail.com>
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
In-Reply-To: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780084373; l=3108;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=huILfrJwVD2l0b9pcRxdCcvWAGfLEbWnfZgOCDiNqEs=;
 b=P43E8/9nhKW2MQT+J5O7l8vSD1Y3GoPDA9ZMxhg968EpzQ3eLoAqvdZ3QgHRaKo8+Kr9L4Fcl
 WTIHYHUQsTrC+Rw7kLQDVf3xjjIJUn9U11m/dvYwB6cbLCDNLbnzosI
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=brookmangabriel@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

These are the bitmasks used to control the FEAT_MTE_STORE_ONLY feature.
They are now named and setting these fields of SCTLR is ignored if MTE
or MTE4 is disabled, as per convention.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.h          |  2 ++
 target/arm/helper.c       | 20 ++++++++++++++------
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 9451df3813..0708e4c7d6 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1186,6 +1186,11 @@ static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
 }
 
+static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 85552b573c..d9c03c9c2e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1468,6 +1468,8 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_EnAS0   (1ULL << 55) /* FEAT_LS64_ACCDATA */
 #define SCTLR_EnALS   (1ULL << 56) /* FEAT_LS64 */
 #define SCTLR_EPAN    (1ULL << 57) /* FEAT_PAN3 */
+#define SCTLR_TCSO0   (1ULL << 58) /* FEAT_MTE_STORE_ONLY */
+#define SCTLR_TCSO    (1ULL << 59) /* FEAT_MTE_STORE_ONLY */
 #define SCTLR_EnTP2   (1ULL << 60) /* FEAT_SME */
 #define SCTLR_NMI     (1ULL << 61) /* FEAT_NMI */
 #define SCTLR_SPINTMASK (1ULL << 62) /* FEAT_NMI */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 34487eeaa3..6210e3abec 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3297,12 +3297,20 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     /* ??? Lots of these bits are not implemented.  */
 
-    if (ri->state == ARM_CP_STATE_AA64 && !cpu_isar_feature(aa64_mte, cpu)) {
-        if (ri->opc1 == 6) { /* SCTLR_EL3 */
-            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
-        } else {
-            value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
-                       SCTLR_ATA0 | SCTLR_ATA);
+    if (ri->state == ARM_CP_STATE_AA64) {
+        if (!cpu_isar_feature(aa64_mte, cpu)) {
+            if (ri->opc1 == 6) { /* SCTLR_EL3 */
+                value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA | SCTLR_TCSO);
+            } else {
+                value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
+                           SCTLR_ATA0 | SCTLR_ATA | SCTLR_TCSO | SCTLR_TCSO0);
+            }
+        } else if (!cpu_isar_feature(aa64_mte_store_only, cpu)) { /* not mte4 */
+            if (ri->opc1 == 6) { /* SCTLR_EL3 */
+                value &= ~SCTLR_TCSO;
+            } else {
+                value &= ~(SCTLR_TCSO | SCTLR_TCSO0);
+            }
         }
     }
 

-- 
2.54.0


