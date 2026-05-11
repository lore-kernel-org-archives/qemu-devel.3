Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB52CCD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRDc-0004xT-Ml; Mon, 11 May 2026 10:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCj-00044y-0w
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:54 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCg-0006Gd-Qb
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:52 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-899a9f445cbso40887366d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508108; x=1779112908; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZautLnPHryaA/jKUrfP8mXFUci45WTSiLLQtx4NmSrY=;
 b=i/2BSyLkvud2HCRrYkhYBdTX8ojOFoLK/MLGuMkLLTU0yVqak3P+5vrj3OPNKK7O6o
 LE7VvFWAtmG6Dj6Q8w1hP+czbXgoiF6mooBxeKPf786kC/OwrFnvVNfxVQMn4M3R25bS
 V5FFpz7EKIsYx9M807PByN39TnYK5bz8UqoMMPuWABSNaRfqtlGmsNQwRg2WzRwNHgMe
 0EvpU20V+KPeqWFP+QmsVjFR19T7c5vf5JRVStO7hvRWyyHuYA1Y60n05OtZ2OmcfQm1
 WKU7sjZX9zGYUAtaMkHsQkvwgNAX2tCJY7fPgv0GgnGzhsG0vCTqaG+EhmgnSnpomp9K
 ly5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508108; x=1779112908;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZautLnPHryaA/jKUrfP8mXFUci45WTSiLLQtx4NmSrY=;
 b=RG3K75X5zxu6PPxJ0DmaewQqv4wft8al8DaSx+p5a0GVRmsLvvpikcnxCslHNqSTrz
 1/6+pawHik8lPJocPebQwqkYuFsQtzi/BrobTdJ5jN4TC8GyzFUEQhahSiDXmX8p44nc
 A7+V6ajJkGSvu/S5ivaWR1BoidB9eXPFTF7Kksbg5H9Zd1WTuE21O66jFlxcXYq/rhj5
 kip/MkDLPBo8mVcvwrXKT632eH1txFSyHhqR4z6B/30XI2itv+/E8tOiBMt0zE/NrOPc
 En8fF3KroHK4I8KAJy+hRSrWTmDT9nq2LcK0v54yJA6yo/JaBoIBFaUTmsbMnkvL4i3I
 +R0Q==
X-Gm-Message-State: AOJu0YxF2BWQ8Le1t+Bw4WfN4g2Pq1wcTifwyYfgW+3rcyEwxj4sdX3N
 V63onWGA5xJKK1EnlnSYoKOXIEiXJxbcn9sZus3KTOLBAxrgJj6DeupLYK9+8lip
X-Gm-Gg: Acq92OFTAHTAUMb9l7gBCGSrJBxSusHWSY/37Ng4fUCTg8o8ubxsocjdvBLDk/IVnpA
 CyGY3JB8F2byueNY57SfdFE+n3XpLYjngPN609mj2kX0WbJZ4LlZRgkTr5ncn3NhY3byNiCQWYq
 nlpPYnqMeU4rM0PnRLBn1/yySKfZ8CAk0dPWjR3oEiY88Fy+9K/c1gYLfNsXt6yrxa2tTVt/aVM
 8w3teBIC9PXE9elER6iX4eAYYdXZpo46Wa+0QSAWjS3SbRWk4myeMNXr88/Itg4p4MIuNydrm2k
 bV2Paz+F+JeWv9fT4hBNDotKWdtwtnbWoY9nbHwkKju5L7y6r2r2dMO+XF8rcrJxBCme3a49MLh
 umi9QtHJ6TK2nnYE7MVCW6WXDfSjyUZPojUXztjTfIclQbp3QQiEvJV2v0lcAN4qHNKEcBYjJka
 KKKCCKhcchIeZ5cj3DksY3SS/5N9UygAQG1cdHIDeG
X-Received: by 2002:a05:6214:5191:b0:8b3:fb6a:d370 with SMTP id
 6a1803df08f44-8bf439e6847mr210452656d6.37.1778508069177; 
 Mon, 11 May 2026 07:01:09 -0700 (PDT)
Received: from [192.168.1.160] ([2600:4041:54f3:a400:c013:3550:ed5f:a59a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm94773756d6.31.2026.05.11.07.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:01:08 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 11 May 2026 10:01:00 -0400
Subject: [PATCH v6 02/15] target/arm: add TCSO bitmasks to SCTLR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-feat-mte4-v6-2-8557cc1313b9@gmail.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778508062; l=3108;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=HVuaLMgdUOpxnq+2cYF0+0b5kRwVlj12trfanpWc6ok=;
 b=sdlNRhSmTlYI0QMUHF5l2yMMfpBKCLHckm+rwHukL9nNpY6DeFlsX7xoR/Bbn1vKjAfYLSpcz
 b38Xt74bLNoCEUFo4PMR7XqwpA3ahDJ9w8mjzMD3Y9K2MOyrWzMSbwT
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
index adfbdb9da5..8ec8d9a2e3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1162,6 +1162,11 @@ static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
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
index 0b9755533b..0894a050b1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1477,6 +1477,8 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_EnAS0   (1ULL << 55) /* FEAT_LS64_ACCDATA */
 #define SCTLR_EnALS   (1ULL << 56) /* FEAT_LS64 */
 #define SCTLR_EPAN    (1ULL << 57) /* FEAT_PAN3 */
+#define SCTLR_TCSO0   (1ULL << 58) /* FEAT_MTE_STORE_ONLY */
+#define SCTLR_TCSO    (1ULL << 59) /* FEAT_MTE_STORE_ONLY */
 #define SCTLR_EnTP2   (1ULL << 60) /* FEAT_SME */
 #define SCTLR_NMI     (1ULL << 61) /* FEAT_NMI */
 #define SCTLR_SPINTMASK (1ULL << 62) /* FEAT_NMI */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e7677a584..ddf44f4306 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3274,12 +3274,20 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
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


