Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450C7C79FB7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcp7V-00016w-3p; Mon, 05 Jan 2026 13:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7I-00014q-MC
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:46 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp76-00034b-0U
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:35 -0500
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-88a2b99d8c5so1330816d6.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767636929; x=1768241729; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LWCpE05OCyK9rjkWEbDU6wH4iFFezXLpSY4SvfoXKxo=;
 b=KFLGAxLeBVKxzYVjbK1kqDQXbfrOxMmBL7aE3bqF75CXaQVTXdG6Kf+RYPnNBDdqI5
 jziYI8pWjfrw6JSpGoI0eBal3jld6XYf/8ERmNFBUyfsIOQ2V1mSaKhNbR4vz0P9mTHG
 Kj7Glti2y+CrtajdrE7LZ823mgyFwbGrZL9ULvxqAzADnHCdIpFFmJXknSBh2d4+QHEW
 qmqYVRfDzO5mB1fvC/QrDw0PQqwiJGAzNS+1p/p1/Bv1w3TMnRNjEJMmZwxFTwwQ098t
 DVbXZBlDnM9BEV9Cz36uKjL4KmNakL0a8mxjRd0k7+kZefnOkvL3HW/WXZR+W1L+meke
 qV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767636929; x=1768241729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LWCpE05OCyK9rjkWEbDU6wH4iFFezXLpSY4SvfoXKxo=;
 b=MzZeAIJ4KNQbFlJN/glkqccZ2eDP+p+HA8E6SXbDuj5OXWktR/SfX0QKo613BrV1L9
 gWguBwopO9WC/Nf6SxaBoMnyDVgy4yw8VkNdzS3clMK22w6FtXnuj+J1/wiBpbn7IkSm
 NKgvVtmRaidojzngCjb34kadmQ9WCETzyKgbdLz52X6tiazwbfeF9+3s+Hnc0vslmaF4
 fzErQjaIOsHM9BcPsAgn98D8t18o5dp+IpeNiwp6d8cGQT7KyqZsM+f4AD3sFwRc2kNc
 ut3kM9uLaNGC72wuApDIeY2V7fCwsGnCKThci560I021dRahY3cNwBTeZKcKRcZ05OTn
 V0HA==
X-Gm-Message-State: AOJu0YxE1iLCu5jByVCSaEJnO/tPhIXH8iPn1k5xu8I57tH5r+tTGBI0
 n6Ppt9KVveolkxyf8gDQtXkYDlK+UayASsFfwwHd7FfElCfDLCsD9NR0
X-Gm-Gg: AY/fxX7NgFdcknOcyt1au0wq+RKbmAiGiO2WFrhe2Is3rva7v247FoXn8rHMLrBI/h0
 jsbRt0g8hMnZjrVUYRFWieVHFqXTAg9Uzs+3O2AA0dTr+8mtHhhI1mHLNrYdD0dP3Ej0jy1J6J8
 DHWhqCqOKS9gdTOFJPlsZSG0flZVB3UfZ1kzFjA4cVu/PgKKVCl1AQWpJygrc3h05nt9XSGgnR6
 MtX4O27dY+Qt+xiL64DN/2+AGlWMg68ksR3++30/wwMoi9igmivgm4JJYgUJ5f+UngFczepvLxL
 D0GS0ts7DQaoN349Ln2aCtR7Pj4RvJgn4oL9zB9B9KtlOogJgTmdjvUBE4d1gO0hyzua6BqZotC
 +V1WUAmMZlaU0WnOQ3OTUOFr4o10Gi9vUtFIGYREmJh2rc83M7esGafy9Ne6xAcTKM9DLlc3dVv
 7ro6hD7yIC1ZX07eOs6llyx10c
X-Google-Smtp-Source: AGHT+IEh+on4dgKiJHXBp25QPS2Hce84+sLR8W5yWTCQ2L2YBe0dnohkPXb9Ocx3XHBI33dWkv8KJg==
X-Received: by 2002:a05:6214:202d:b0:87d:fbe9:9566 with SMTP id
 6a1803df08f44-89075e28819mr6831526d6.26.1767636928726; 
 Mon, 05 Jan 2026 10:15:28 -0800 (PST)
Received: from [192.168.1.204] ([185.213.193.254])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907540e24csm3855706d6.25.2026.01.05.10.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 10:15:28 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 05 Jan 2026 11:14:51 -0700
Subject: [PATCH RFC v3 02/12] target/arm: add TCSO bitmasks to SCTLR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-feat-mte4-v3-2-86a0d99ef2e4@gmail.com>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
In-Reply-To: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767636923; l=2722;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=Us4U7asgtOyjNGX+6WrRHwqGtfDdMl8/TKs5M/sdrmU=;
 b=FJwkdrVcUsLSLtQD9816e+sUA13U2L5lwo/uXXYuWLWwfHLMlyjKLGBZttMHDPtUYap9Lz5SF
 cgI1QwV/AaGBWpm5Uu0afmsLbgWub27K6Is+S8We9LpzONoPGip1h/N
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf32.google.com
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

These are the bitmasks used to control the FEAT_MTE_STORE_ONLY feature.
They are now named and setting these fields of SCTLR is ignored if MTE
or MTE4 is disabled, as per convention.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/cpu-features.h |  5 +++++
 target/arm/cpu.h          |  2 ++
 target/arm/helper.c       | 11 +++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 48009b5a66..3473787ab8 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1144,6 +1144,11 @@ static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) == 1;
 }
 
+static inline bool isar_feature_aa64_mte4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEFAR) == 1;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9579d43ba3..393bfc0dc9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1424,6 +1424,8 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_EnAS0   (1ULL << 55) /* FEAT_LS64_ACCDATA */
 #define SCTLR_EnALS   (1ULL << 56) /* FEAT_LS64 */
 #define SCTLR_EPAN    (1ULL << 57) /* FEAT_PAN3 */
+#define SCTLR_TCSO0   (1ULL << 58) /* FEAT_MTE_STORE_ONLY */
+#define SCTLR_TCSO    (1ULL << 59) /* FEAT_MTE_STORE_ONLY */
 #define SCTLR_EnTP2   (1ULL << 60) /* FEAT_SME */
 #define SCTLR_NMI     (1ULL << 61) /* FEAT_NMI */
 #define SCTLR_SPINTMASK (1ULL << 62) /* FEAT_NMI */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 263ca29d92..4086423b6f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3364,10 +3364,17 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     if (ri->state == ARM_CP_STATE_AA64 && !cpu_isar_feature(aa64_mte, cpu)) {
         if (ri->opc1 == 6) { /* SCTLR_EL3 */
-            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
+            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA | SCTLR_TCSO);
         } else {
             value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
-                       SCTLR_ATA0 | SCTLR_ATA);
+                       SCTLR_ATA0 | SCTLR_ATA | SCTLR_TCSO | SCTLR_TCSO0);
+        }
+    } else if (ri->state == ARM_CP_STATE_AA64
+            && !cpu_isar_feature(aa64_mte4, cpu)) { /* mte but not mte4 */
+        if (ri->opc1 == 6) { /* SCTLR_EL3 */
+            value &= ~SCTLR_TCSO;
+        } else {
+            value &= ~(SCTLR_TCSO | SCTLR_TCSO0);
         }
     }
 

-- 
2.52.0


