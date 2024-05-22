Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2D1C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9dDa-0005bA-MZ; Wed, 22 May 2024 00:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9dDW-0005Zy-Lo; Wed, 22 May 2024 00:04:43 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9dDI-0007xg-NS; Wed, 22 May 2024 00:04:42 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so373783b3a.0; 
 Tue, 21 May 2024 21:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716350666; x=1716955466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0b2GXCJ22WFvTHgVXjNvK42VHOxSdD4f2sQ0k5SMWIQ=;
 b=H08e7ePvWDRGTQ4Rouqb6coQulaXqIqZFiWD6wSYPTyW67ykVdxHsllvCT5L/CrPeS
 nn9Fxm4UewfuAaOYu0PO+pPx/QUXswOhuBwutWCtYFVWRKVzLf2ZnHwaQHViGtBovYvW
 fL0lyrOupaPo5LzZRa5+KZg7J339DdaSHJWROjxfuZ0tHFb3Xb3rOrCJ8lxFHiTFKScH
 qRskUBVWPR+wL3AS/iNoUPjXQdmCxMkJkPI0mO17+atipjdQIFE0WTv1vD0QjWUuR4RN
 WkjiaiXPsqY93Lu14Qrm7UEUuX8ZravkFVR2FhmVSC3YtZcTq2zJt2kwuSrXD2R6czHZ
 WOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716350666; x=1716955466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0b2GXCJ22WFvTHgVXjNvK42VHOxSdD4f2sQ0k5SMWIQ=;
 b=RZrMens1zn2bqQJfmhiB9VmADQEmZ4XMfc/M+git9uLB2Hf2s+1eiquI14ogBcQl9s
 74YPqpHrLpPih48fmqxOBRYjjjaI77/RSx3yesDW73RcAN+FK8j+zzIRfzhk3iY5ojk8
 lUZWjSCuJ10JgoxW3jR2BMIatx4G9S0zQM0M+OBe68MEDTKe/eqgMVEWrscRM1xwVAJQ
 2R+KVkJzNIXqDA1o4lY6haysyDLV79C2Z02+H3WBh/CvqWPzGfeY5ypezyMd+JXHbvd2
 UH22pcmoRepHyMcN5V9+Z2DJoGH820UVnZIoRFyKbdhMm3HQWYNs5sdFkYw6KCIxaFyo
 m0qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYGqwFIdajR4EsKPhwaIGVlZLdekZ8MFjPMsd/JqWCuR2BUQhK78aGfCBNtvYV0RFkDlJNso1ausxXDmR8hPzY2TZP1fY=
X-Gm-Message-State: AOJu0Yx2s1Mq+mV9q85mriiqa71iGG21nuWz8cgFxUHNrhuLOsKhQk7R
 o4pXF3CLA8UF2zesFnJ7hoAlNJgUV144v02XEu+uV18nh/BKMZv4qOj+gQ==
X-Google-Smtp-Source: AGHT+IFaFWPWJB2d2OMW0uhWNDaqI8vewArE69LE6f5+mNQBgQspjuFSSoOPRWbp3udUMExxnwgSUw==
X-Received: by 2002:a05:6a20:432a:b0:1af:86e4:bc99 with SMTP id
 adf61e73a8af0-1b1f8045e52mr1361472637.10.1716350666332; 
 Tue, 21 May 2024 21:04:26 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6589645bbefsm10197158a12.55.2024.05.21.21.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 21:04:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/2] target/ppc: Tidy pmu_count_insns implementation
Date: Wed, 22 May 2024 14:04:11 +1000
Message-ID: <20240522040411.90655-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240522040411.90655-1-npiggin@gmail.com>
References: <20240522040411.90655-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Merge the user-only and full implementations together, and only
call translator_io_start() and only create and set the label
when necessary.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 55 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 344e78843c..9ce823b018 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -298,6 +298,8 @@ static inline void gen_update_nip(DisasContext *ctx, target_ulong nip)
 #if defined(TARGET_PPC64)
 static void pmu_count_insns(DisasContext *ctx)
 {
+    bool pmc_other, pmc_check_overflow;
+
     /*
      * Do not bother calling the helper if the PMU isn't counting
      * instructions.
@@ -306,48 +308,47 @@ static void pmu_count_insns(DisasContext *ctx)
         return;
     }
 
- #if !defined(CONFIG_USER_ONLY)
-    TCGLabel *l;
-    TCGv t0;
+    /*
+     * The PMU insns_inc() and handle_pmc5_overflow() helpers stop the internal
+     * PMU timer if a counter overflow happens. In that case, if the guest is
+     * running with icount and we do not handle it beforehand, the helper can
+     * trigger a 'bad icount read'. So call translator_io_start() for cases
+     * where that might trigger.
+     */
 
+ #if defined(CONFIG_USER_ONLY)
     /*
-     * The PMU insns_inc() helper stops the internal PMU timer if a
-     * counter overflows happens. In that case, if the guest is
-     * running with icount and we do not handle it beforehand,
-     * the helper can trigger a 'bad icount read'.
+     * User mode can read (but not write) PMC5 and start/stop
+     * the PMU via MMCR0_FC. In this case just increment
+     * PMC5 with base.num_insns.
      */
-    translator_io_start(&ctx->base);
+    pmc_other = false;
+    pmc_check_overflow = false;
+ #else
+    pmc_other = ctx->pmc_other;
+    pmc_check_overflow = ctx->mmcr0_pmcjce;
+ #endif
 
     /* Avoid helper calls when only PMC5-6 are enabled. */
-    if (!ctx->pmc_other) {
-        l = gen_new_label();
-        t0 = tcg_temp_new();
+    if (!pmc_other) {
+        TCGv t0 = tcg_temp_new();
 
         gen_load_spr(t0, SPR_POWER_PMC5);
         tcg_gen_addi_tl(t0, t0, ctx->base.num_insns);
         gen_store_spr(SPR_POWER_PMC5, t0);
-        /* Check for overflow, if it's enabled */
-        if (ctx->mmcr0_pmcjce) {
+
+        if (pmc_check_overflow) {
+            TCGLabel *l = gen_new_label();
+
+            translator_io_start(&ctx->base);
             tcg_gen_brcondi_tl(TCG_COND_LT, t0, PMC_COUNTER_NEGATIVE_VAL, l);
             gen_helper_handle_pmc5_overflow(tcg_env);
+            gen_set_label(l);
         }
-
-        gen_set_label(l);
     } else {
+        translator_io_start(&ctx->base);
         gen_helper_insns_inc(tcg_env, tcg_constant_i32(ctx->base.num_insns));
     }
-  #else
-    /*
-     * User mode can read (but not write) PMC5 and start/stop
-     * the PMU via MMCR0_FC. In this case just increment
-     * PMC5 with base.num_insns.
-     */
-    TCGv t0 = tcg_temp_new();
-
-    gen_load_spr(t0, SPR_POWER_PMC5);
-    tcg_gen_addi_tl(t0, t0, ctx->base.num_insns);
-    gen_store_spr(SPR_POWER_PMC5, t0);
-  #endif /* #if !defined(CONFIG_USER_ONLY) */
 }
 #else
 static void pmu_count_insns(DisasContext *ctx)
-- 
2.43.0


