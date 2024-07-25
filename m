Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC1BC49EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Lp-0007vB-Lf; Thu, 25 Jul 2024 19:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Lh-0006wf-0c; Thu, 25 Jul 2024 19:58:17 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Le-0001Wv-70; Thu, 25 Jul 2024 19:58:15 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cd2f89825fso307512a91.1; 
 Thu, 25 Jul 2024 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951892; x=1722556692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xofwgmchgHg4iVxxPZB6XuDChcCB1KfzBxNDh96dsVI=;
 b=il++1xvCS8aTXbttUp3GNFCDZ4xpg0iOuBTbUhYn9QULgga17N4vqN9tof8wR6oWF7
 tmchcjiyUzPb0tznl+h+CmkdiehuvaPL2TqpcXxS9kYC9lrA3h4V2PVgPeeDVwlfTRkI
 LFKjGOtVM0Ua5ETJ9K3tOWs+OfDf0RNDyIP1G8tA4L/mS/1c3/aHlziSwXKXsHHUrQu5
 rABN2EjO/r/bksalnHL/YNUt+ji8DtSHswS/X4fTBZ+cmKOwgr3pjgGskMQ54ynblQXm
 OeEjFGuzRVVWOjJeFZOpGgILYQe/mvIugmMiyzfOKK/lyrqnvx4LPPCWJmkiHZYxM3iN
 9a3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951892; x=1722556692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xofwgmchgHg4iVxxPZB6XuDChcCB1KfzBxNDh96dsVI=;
 b=MtARlZHvo75OWCPrpb9Ct16wcnbAdESulJqj+tur1xG7Cuk2zg1HtnhRrusCH3iorI
 t+vcce8bP86lS2YGN93JI2BlRkzU7VhqmkFJf2dGexOp+aljsLc7qEbwn0Z6A2q7oNuJ
 /jzfRe8iwE9PS+10KY4gKEAcOFXoGnDnoGrDHVe0CY1ztHbfqIUXS3t8DhWd87GsFhWT
 TxU09pKaGl1WaV0DOxcebxSmxUd3i6S1o3kFnVrah+6hOyuL006nfJyMx/egRq3UyRug
 L8EpvoyVP72YV+3/xFhVZt0F+vG6smMAnFzjZ/C6jhDMyPS68uyWjbrt34mRrO5AB12h
 wDWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiq/5ZqguwexAhGARcVww9UzY6XU4/ex/jQZax0x2lCBurnPaNpQCRvTlt5TNcUwjn6fO5NeKB47VoFgFO2ytRg2WH
X-Gm-Message-State: AOJu0YxIE426Ulrkqyc3F4rdWLgtYaVNqcI77KYnPSVb6j2282eTJpOC
 8mK6g2zqek3OmzDUtdE92SIBaI5mY4i1+2oN5HQv0L6U4hHirdaNqQxS+w==
X-Google-Smtp-Source: AGHT+IHGeoPKmDBsT8dUQTtLZGx7Cd7Tgo7dIoZoN3GbuXwqf25uQ0ghvMmZHusVL7x1O6y4UQ0QCA==
X-Received: by 2002:a17:90a:a515:b0:2c8:6eea:7ad8 with SMTP id
 98e67ed59e1d1-2cf2eb39056mr3822179a91.26.1721951891916; 
 Thu, 25 Jul 2024 16:58:11 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 63/96] target/ppc: Update VMX storage access insns to use
 tcg_gen_qemu_ld/st_i128.
Date: Fri, 26 Jul 2024 09:53:36 +1000
Message-ID: <20240725235410.451624-64-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Chinmay Rath <rathc@linux.ibm.com>

Updated instructions {l, st}vx to use tcg_gen_qemu_ld/st_i128,
instead of using 64 bits loads/stores in succession.
Introduced functions {get, set}_avr_full in vmx-impl.c.inc to
facilitate the above, and potential future usage.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate/vmx-impl.c.inc | 42 ++++++++++++++---------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index a182d2cf81..70d0ad2e71 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -24,25 +24,29 @@ static inline void set_avr64(int regno, TCGv_i64 src, bool high)
     tcg_gen_st_i64(src, tcg_env, avr64_offset(regno, high));
 }
 
+static inline void get_avr_full(TCGv_i128 dst, int regno)
+{
+    tcg_gen_ld_i128(dst, tcg_env, avr_full_offset(regno));
+}
+
+static inline void set_avr_full(int regno, TCGv_i128 src)
+{
+    tcg_gen_st_i128(src, tcg_env, avr_full_offset(regno));
+}
+
 static bool trans_LVX(DisasContext *ctx, arg_X *a)
 {
     TCGv EA;
-    TCGv_i64 avr;
+    TCGv_i128 avr;
     REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
     REQUIRE_VECTOR(ctx);
     gen_set_access_type(ctx, ACCESS_INT);
-    avr = tcg_temp_new_i64();
+    avr = tcg_temp_new_i128();
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_andi_tl(EA, EA, ~0xf);
-    /*
-     * We only need to swap high and low halves. gen_qemu_ld64_i64
-     * does necessary 64-bit byteswap already.
-     */
-    gen_qemu_ld64_i64(ctx, avr, EA);
-    set_avr64(a->rt, avr, !ctx->le_mode);
-    tcg_gen_addi_tl(EA, EA, 8);
-    gen_qemu_ld64_i64(ctx, avr, EA);
-    set_avr64(a->rt, avr, ctx->le_mode);
+    tcg_gen_qemu_ld_i128(avr, EA, ctx->mem_idx,
+                         DEF_MEMOP(MO_128 | MO_ATOM_IFALIGN_PAIR));
+    set_avr_full(a->rt, avr);
     return true;
 }
 
@@ -56,22 +60,16 @@ static bool trans_LVXL(DisasContext *ctx, arg_LVXL *a)
 static bool trans_STVX(DisasContext *ctx, arg_STVX *a)
 {
     TCGv EA;
-    TCGv_i64 avr;
+    TCGv_i128 avr;
     REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
     REQUIRE_VECTOR(ctx);
     gen_set_access_type(ctx, ACCESS_INT);
-    avr = tcg_temp_new_i64();
+    avr = tcg_temp_new_i128();
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_andi_tl(EA, EA, ~0xf);
-    /*
-     * We only need to swap high and low halves. gen_qemu_st64_i64
-     * does necessary 64-bit byteswap already.
-     */
-    get_avr64(avr, a->rt, !ctx->le_mode);
-    gen_qemu_st64_i64(ctx, avr, EA);
-    tcg_gen_addi_tl(EA, EA, 8);
-    get_avr64(avr, a->rt, ctx->le_mode);
-    gen_qemu_st64_i64(ctx, avr, EA);
+    get_avr_full(avr, a->rt);
+    tcg_gen_qemu_st_i128(avr, EA, ctx->mem_idx,
+                         DEF_MEMOP(MO_128 | MO_ATOM_IFALIGN_PAIR));
     return true;
 }
 
-- 
2.45.2


