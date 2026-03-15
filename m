Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00740F30271
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 17:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1oxf-0006A0-G8; Sun, 15 Mar 2026 13:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1oxa-00068K-NW
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 13:09:03 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1oxX-0007Ju-F7
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 13:09:02 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43b40fb7f95so413902f8f.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773594537; x=1774199337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HE5WeVnTKj+2oHKkyxRAxeCVsDnroECOItTYTAzlxAU=;
 b=uxqaAcGtRYlJ0i0yk2dBJWmPPTBNCawD08Ro/3S33Dh+/3yuK78CTOU6oS+HvMyL6h
 K6Dwpr40HHm4Nk/UAGRw3Gq4AZKRLEOzPKncVD1IvSNMu/+fhzjY/NhcsnWWM0bX4qAO
 ubm/mOLS96l+nRCYkpL2W4wDvmhi0jFVjuwy3Slnw+nrgPY3X9XLOPzSLrRDk6N68Afo
 9kLa0VoGIIYxNeP0LXHGwmnT4wXLRDyOYN/BBkZJkA4Iov4aVgH51tmxiLrA+gK6cj5Y
 IagpDXvvImK0EI7wlgZF+ISB6gs1Chgbg06OvUIbFSfQr7Kf56aX2pC7Do7ss4ddNVhq
 Xp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773594537; x=1774199337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HE5WeVnTKj+2oHKkyxRAxeCVsDnroECOItTYTAzlxAU=;
 b=m68tIcSMqyOQcAT3bgYjhx8/PUesFenM1QnbGZS+8ZGV7XEx6DBYP7pMVjz4Yp+o3X
 v1+LY/iMJry70h0tuDI2yMcZ6Ud9M4buHW0ArZWZ/+q0Q2Ax4gTQhhEYAm0xYhE16Uw7
 AQQehRF1X0jHA4UwPXjbG52+hDuD9VZOFzcZgOIhO9qE4Sj6E1UTAnzcjubofkuFmQmb
 sfmzUu+Ftb9nFkHclQXCrRZxEUoEUwwOb/sH+EcHlQ15FtopT4NyB6Edy+8nGd+ND/K1
 oH6WjK7FDFcAeCiv+qYyi8lcd3ktpUp6ODAVwVSs2N20h57UvYcUfih49C1fy7ygNblZ
 kxbw==
X-Gm-Message-State: AOJu0Yx+cm4vouMcQSNW8K/m0287jNDjBDfP8n324YSGmAmcjMgzBLQ/
 b2vQCvckwldtpGr3zIuPIyM6JwolIOtSdGPgxCG2zLOb13YsNtwEbrNwGt0rhyuUwKikRnMjIs8
 P9W0C5gw=
X-Gm-Gg: ATEYQzxvTevxo5F10zmbkhyRq2yJZZqQcRZNFzQoUAjP7SeixC+tVu0580h4G3oHHaw
 e8tGHa+GvpDrafwXBG3R+IsJKt+I2De7E1XVqLXqUVYIYosMYF9DJCjY5rPWJ5/QuJjAl5gOafn
 99iQoD//fxI0ANwP65vTTMSPCKPhsWoRf3/eyd41EaiDvzhuXss4ZDEL6hitT5aoKf2n/JCr7RU
 HB+jqE0wfENRX/uciIrCDbt0pX+fKsv+opDgdCrboFrzTziXVkJMz1PufAqbULj7zL9qci6/vbO
 PDaDi6npx5yw23S44mBmd/3ikrVJiwRi1s7estB1K9+iGapp575mYybbom8GkWIRnwtKUW/Jgfz
 MHN+UY2YLJ7eGbmRhL3dVSxu1rACk9lX3J/9+nGJJBfQhURLNsjXjDoqCEa+mAJGJ4AirduhboZ
 gZB6je5J3OxChND2pTfvrjFUpSPCXcy1bi16J55k9nFGWwoY7QO8hb03lP31Ab8hA/IewIB93U
X-Received: by 2002:a05:6000:2502:b0:43b:4352:1be6 with SMTP id
 ffacd0b85a97d-43b43521d97mr2429860f8f.48.1773594536776; 
 Sun, 15 Mar 2026 10:08:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm35012226f8f.21.2026.03.15.10.08.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 15 Mar 2026 10:08:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] target/ppc: Explicitly declare BHRB related register as
 64-bit
Date: Sun, 15 Mar 2026 18:08:31 +0100
Message-ID: <20260315170832.40331-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315170832.40331-1-philmd@linaro.org>
References: <20260315170832.40331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

When TARGET_PPC64 is set, the 'target_ulong' type expand to
the 'uint64_t' one. Use the latter which is more explicity,
similarly with the TCG and migration APIs. No logical change
intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h       | 10 +++++-----
 target/ppc/machine.c   |  2 +-
 target/ppc/translate.c | 33 +++++++++++++++++----------------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f4438982928..2332c509524 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1373,11 +1373,11 @@ struct CPUArchState {
 
 #ifdef TARGET_PPC64
     /* Branch History Rolling Buffer (BHRB) resources */
-    target_ulong bhrb_num_entries;
-    intptr_t     bhrb_base;
-    target_ulong bhrb_filter;
-    target_ulong bhrb_offset;
-    target_ulong bhrb_offset_mask;
+    uint64_t bhrb_num_entries;
+    intptr_t bhrb_base;
+    uint64_t bhrb_filter;
+    uint64_t bhrb_offset;
+    uint64_t bhrb_offset_mask;
     uint64_t bhrb[BHRB_MAX_NUM_ENTRIES];
 #endif
 
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index b44c3ccf0ae..65594f5e1a6 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -723,7 +723,7 @@ static const VMStateDescription vmstate_bhrb = {
     .minimum_version_id = 1,
     .needed = bhrb_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
+        VMSTATE_UINT64(env.bhrb_offset, PowerPCCPU),
         VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIES),
         VMSTATE_END_OF_LIST()
     }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ecf75c1376e..996e6551436 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3502,7 +3502,8 @@ static void gen_rvwinkle(DisasContext *ctx)
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 
-static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv mask, TCGv value)
+static TCGv gen_write_bhrb(TCGv_ptr base, TCGv_i64 offset,
+                           TCGv_i64 mask, TCGv_i64 value)
 {
     TCGv_ptr tmp = tcg_temp_new_ptr();
 
@@ -3513,10 +3514,10 @@ static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv mask, TCGv va
     tcg_gen_st_i64(value, tmp, 0);
 
     /* add 8 to current bhrb_offset */
-    tcg_gen_addi_tl(offset, offset, 8);
+    tcg_gen_addi_i64(offset, offset, 8);
 
     /* apply offset mask */
-    tcg_gen_and_tl(offset, offset, mask);
+    tcg_gen_and_i64(offset, offset, mask);
 
     return offset;
 }
@@ -3529,13 +3530,13 @@ static inline void gen_update_branch_history(DisasContext *ctx,
 {
 #if defined(TARGET_PPC64)
     TCGv_ptr base;
-    TCGv tmp;
-    TCGv offset;
-    TCGv mask;
+    TCGv_i64 tmp;
+    TCGv_i64 offset;
+    TCGv_i64 mask;
     TCGLabel *no_update;
 
     if (ctx->has_cfar) {
-        tcg_gen_movi_tl(cpu_cfar, nip);
+        tcg_gen_movi_i64(cpu_cfar, nip);
     }
 
     if (!ctx->has_bhrb ||
@@ -3548,22 +3549,22 @@ static inline void gen_update_branch_history(DisasContext *ctx,
     no_update = gen_new_label();
 
     /* check for bhrb filtering */
-    tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPUPPCState, bhrb_filter));
-    tcg_gen_andi_tl(tmp, tmp, inst_type);
-    tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, 0, no_update);
+    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUPPCState, bhrb_filter));
+    tcg_gen_andi_i64(tmp, tmp, inst_type);
+    tcg_gen_brcondi_i64(TCG_COND_EQ, tmp, 0, no_update);
 
     base = tcg_temp_new_ptr();
-    offset = tcg_temp_new();
-    mask = tcg_temp_new();
+    offset = tcg_temp_new_i64();
+    mask = tcg_temp_new_i64();
 
     /* load bhrb base address */
     tcg_gen_ld_ptr(base, tcg_env, offsetof(CPUPPCState, bhrb_base));
 
     /* load current bhrb_offset */
-    tcg_gen_ld_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
+    tcg_gen_ld_i64(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
 
     /* load a BHRB offset mask */
-    tcg_gen_ld_tl(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
+    tcg_gen_ld_i64(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
 
     offset = gen_write_bhrb(base, offset, mask, tcg_constant_i64(nip));
 
@@ -3571,13 +3572,13 @@ static inline void gen_update_branch_history(DisasContext *ctx,
     if (inst_type & BHRB_TYPE_XL_FORM) {
 
         /* Set the 'T' bit for target entries */
-        tcg_gen_ori_tl(tmp, target, 0x2);
+        tcg_gen_ori_i64(tmp, target, 0x2);
 
         offset = gen_write_bhrb(base, offset, mask, tmp);
     }
 
     /* save updated bhrb_offset for next time */
-    tcg_gen_st_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
+    tcg_gen_st_i64(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
 
     gen_set_label(no_update);
 #endif
-- 
2.53.0


