Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDECCCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLY8-0001dk-Os; Wed, 10 Jun 2026 12:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXI-0007Zs-Sa
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:12 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXH-0005SI-7s
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:12 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4600ddc4017so4823349f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107930; x=1781712730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uAKA4WBXNqwBA9vfqYn5QuoOuYsnez2o8IVaq06/S40=;
 b=FKJHBkO8cNCzoxNdbeYESlxrwExRLJdplX32jpl3SHZgjGUllaTRO0x90W6T28ouuh
 5GClmlKWNMoxfXIjhUUJZ6vldW9Gjg9Bz7cO0QRKudpiAQYWmoaemAloa58TafADfH6p
 OxcIXsXP+UpwAzBH+jjHxqA4Z8VF9lOUIyjh+zVXiyQAL0jfUJLfx/Cl9JB7Dijsz8r7
 oBvYfxn+pNlMWzWi5aFlmqfk0uBd0ZC4RPS6bxDnIufnFoqlaBPNp7WMJAdr4tRQOCnK
 Lx4I2zy0nZmWyGfudlNEpQQ/6MhmM3Isqq2PDbIPFO8daFZY7SRvgFaclSGN6hnlu9ul
 qYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107930; x=1781712730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uAKA4WBXNqwBA9vfqYn5QuoOuYsnez2o8IVaq06/S40=;
 b=Sp0+w2jDSmU3ZrYlPXcEIGzAINEajrk2NtOtpaZvC6OcKbAldBIDPIkutYgVxFx96P
 zpuYPwkvVWoME3/bewPmkKvPEu3aJi0pBdSnjo5SFIGymbFZf/4a336jg9CUzLpaXOdM
 686QIsp/EH7FUKzh78qQpNeYMMBLxLXKtYmfPKzNC8fTGPwHXiNADyx4f40HijbiTbec
 ISX4DuqWRM9yJdM7vk0Njcz2kPLSbHX4gLlOD8ua8c93SegRLCg2lYbNLCHmC0H3bWsc
 TiAPa8U6cwJbnIlPoa9uz5klBsKmNngolws4Fz44SfYL43z0GdEzAxMtXX+qu6we6Jhj
 WvKA==
X-Gm-Message-State: AOJu0YzyUyXkACHR6tN8iCQkWwmL6t/swHj2tCXm4s3NSFoALoWEmTt0
 a4eWQhjo9sUfDq76ZmqxFrrEdy08m53STgXSukJVIIhWaWCZzLUvIynE7wZKokUK3AN66Y6ogI4
 R6+As
X-Gm-Gg: Acq92OEHYdbDKM6k4xnxkA+h/R8CuVzm+uHeIsNXSWWEjADitz+v09N/0g3QjI4gqUz
 autACaoXO9iOu5DYW53Dkv3UgXkjrq4UUePxIl1NpNjuNanhnDfEGweI0NR0h2m0u1AyUT/pTZf
 V1RXHJxKI+/WrrL2QK5K4NrmiTcA4uUtcnGgcdvEpVmAeecBPvoRC17wcoG+7MWYxILW2oCG4lf
 +I2em29F7pUV6xXUIIPoefB1mAB/kzNeLEhMymJvWwohSzsJyGT3Ph+K010y9x5gwppIzpkpFg3
 1dQTKQ9Wza27/NcDDZF1WxapFAH5mPzMk2gA3ZQRXpnglqlxPNasWNTycsTRQB2LhSGWj31AyAp
 xKWJkSq36ijuJvgzSuVkPXMUBU5T330hqJRA9YOLR51vFjvm54sLTOZ80hPrOFAirE6Fawnq5vx
 aAxYTiX3lfB44Tf+3OMB1XvKi/GqRwsqAo5sRA7nHfmJwWafUhEPLVsa98d1OJQ1i8pK0Xuryqa
 K2sCM63i43/OxWNkSVoGYSz3b2ues8wtvB/ZjqnbMTvV9XvDx6a2A==
X-Received: by 2002:a5d:4d8b:0:b0:439:b8b2:fad0 with SMTP id
 ffacd0b85a97d-460302dcc97mr28830766f8f.5.1781107929500; 
 Wed, 10 Jun 2026 09:12:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/71] target/arm: mte_check unemitted on STORE_ONLY load
Date: Wed, 10 Jun 2026 17:10:55 +0100
Message-ID: <20260610161202.2235298-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

This feature disables generation of the mte check helper on loads when
STORE_ONLY tag checking mode is enabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-3-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  2 ++
 target/arm/tcg/hflags.c        | 12 ++++++++++++
 target/arm/tcg/translate-a64.c |  8 ++++++--
 target/arm/tcg/translate.h     |  2 ++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d9c03c9c2e..08f04a57af 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2534,6 +2534,8 @@ FIELD(TBFLAG_A64, GCS_EN, 41, 1)
 FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
 FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
 FIELD(TBFLAG_A64, FPMR_EL, 45, 2)
+FIELD(TBFLAG_A64, MTE_STORE_ONLY, 47, 1)
+FIELD(TBFLAG_A64, MTE0_STORE_ONLY, 48, 1)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 794cdf00b2..6be84b68ab 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -461,6 +461,15 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                      */
                     DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
                 }
+                /*
+                 * Repeat for MTE_STORE_ONLY
+                 */
+                if ((el == 0 ? SCTLR_TCSO0 : SCTLR_TCSO) & sctlr) {
+                    DP_TBFLAG_A64(flags, MTE_STORE_ONLY, 1);
+                    if (!EX_TBFLAG_A64(flags, UNPRIV)) {
+                        DP_TBFLAG_A64(flags, MTE0_STORE_ONLY, 1);
+                    }
+                }
             }
         }
         /* And again for unprivileged accesses, if required.  */
@@ -470,6 +479,9 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
             && (sctlr & SCTLR_TCF0)
             && allocation_tag_access_enabled(env, 0, sctlr)) {
             DP_TBFLAG_A64(flags, MTE0_ACTIVE, 1);
+            if (SCTLR_TCSO0 & sctlr) {
+                DP_TBFLAG_A64(flags, MTE0_STORE_ONLY, 1);
+            }
         }
         /*
          * For unpriv tag-setting accesses we also need ATA0. Again, in
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3c091ccc56..5165d964ab 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -302,7 +302,8 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
                                       MemOp memop, bool is_unpriv,
                                       int core_idx)
 {
-    if (tag_checked && s->mte_active[is_unpriv]) {
+    if (tag_checked && s->mte_active[is_unpriv] &&
+        (is_write || !s->mte_store_only[is_unpriv])) {
         TCGv_i64 ret;
         int desc = 0;
 
@@ -334,7 +335,8 @@ TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
 TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
                         bool tag_checked, int total_size, MemOp single_mop)
 {
-    if (tag_checked && s->mte_active[0]) {
+    if (tag_checked && s->mte_active[0] &&
+        (is_write || !s->mte_store_only[0])) {
         TCGv_i64 ret;
         int desc = 0;
 
@@ -10805,6 +10807,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->ata[1] = EX_TBFLAG_A64(tb_flags, ATA0);
     dc->mte_active[0] = EX_TBFLAG_A64(tb_flags, MTE_ACTIVE);
     dc->mte_active[1] = EX_TBFLAG_A64(tb_flags, MTE0_ACTIVE);
+    dc->mte_store_only[0] = EX_TBFLAG_A64(tb_flags, MTE_STORE_ONLY);
+    dc->mte_store_only[1] = EX_TBFLAG_A64(tb_flags, MTE0_STORE_ONLY);
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index d4bcc5bad4..551c6ff347 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -140,6 +140,8 @@ typedef struct DisasContext {
     bool ata[2];
     /* True if v8.5-MTE tag checks affect the PE; index with is_unpriv.  */
     bool mte_active[2];
+    /* True if v8.5-MTE tag checks disabled for reads; index with is_unpriv. */
+    bool mte_store_only[2];
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
     bool bt;
     /* True if any CP15 access is trapped by HSTR_EL2 */
-- 
2.43.0


