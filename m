Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B575CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRCy-00045U-3y; Mon, 11 May 2026 10:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCA-0003xC-V7
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:35 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRC4-000621-8l
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:16 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-631a7868228so1391689137.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508070; x=1779112870; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B3SZytY5PYBqvEiH+OmJzIbvZ0fUKiNr0im7vtwJjxA=;
 b=EuUy9kJYy+uzNW8VFfRtrnzAtHUC1akEYGOBbwBQsO7eDjqjnkrGBXj+CR6bHT3ipj
 IayDSi10P1VJ64d5saWU0t7rl/sDyL04hhlHGeJ/AGL77Ed9hqRWNWOzCOh9KRPEIYyQ
 a8g348VQSM9sMdwa8fd0XoqA3UkRw4RNY7zMZ2zpu9KG01adUdkKjnzIzJEL/GBghuSR
 qKw5M/Pcw8bKRJ0IX0ASbIqoKvNpmdSc2Nia54nkWB42InjBZkV9mBBF39boUzWzVhjH
 nMe5vO+jDdh9NmsYDazgD8eyRWdxY6Jx5Xw9WbQA4B+ptihG217poeGbXn9P6avBmKND
 LBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508070; x=1779112870;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B3SZytY5PYBqvEiH+OmJzIbvZ0fUKiNr0im7vtwJjxA=;
 b=nFzrN7qpIvVSxq9RznJeV/jTITr2vc2Q4E3Ez/7IdA2fm9hJJR/dOnr+jphO1E0X3a
 QUL0p8uwszhhe/KzuH0m6+T+v8tlbddmElbks5l7yVTJ7yqURXVtM+9LfZWRi4HFQOjG
 OFM6UEFtC4fy+LniQhOB9ul94TFDzxPFBtWq5bE3IdSMULGp1eDRD8RyYuauLlgxt9b0
 b5FF6uht1v5jiUpRECnFJRlzh36JRZR4sZpsz0RO8tccEi8HlCxuy4gJ3Wy/upQxoSu+
 cI0gODt3q9YazBseTtFj1GKOfw+JO3O2OOitXKE1LTii7b6G/0yDeHsM2d5tWz/TZedp
 WoBQ==
X-Gm-Message-State: AOJu0YzYEcgBFUc6PGhldQwF1/1T3SzjqfJ9aUifY4vFmz21VpjJ1HLg
 9IQh8y2sVqEAuM7hejCpAnIsxhaOS0eRh084M7x2wbrxWJqbLeHChPNg
X-Gm-Gg: Acq92OHVmT3LxsPKLk5Alb4TF6hIifVWsEQwRWIGgHd60+9Icv9qM8Nt2/V1sw4V0Jf
 0wuP9uDrLvKItvtNFqpnYE/1i4YwHldyFGVWWvtAohg+ARZLkYrmiRR8byRh//8Y4BorQTA7l+M
 iUOzLXUQhR3C0XiNWcX3f7Y2/nwDqU3z7cjeL4NmSk6VfUISfZBRL0zVlkzkqZqIIVdUn0tYAx0
 /A5klDWOIa1HDrn776m9jG9Tl+UPumYTCRX9GYHaeXhrZnY3kzcO0TIH2K+KQHvGcIoRSN/DCTO
 igSdoRiNkHnjcMdU20y+Ja5j9/U3boLZLkNrrRs02LrpcxpXMkLP1WBr37oyN4bg9LnDZRwKZMF
 9LruBOEefZ4eDLFoNeBSUCWyRLDbs6N8nIuPrSGfOg+QNMeSq8353k6Lk9myHvyiA3Z+M3iVll5
 W2sWWQLdiRTJfnFMQzcxAdM/VskuYNZKnuaxsZPzYM
X-Received: by 2002:a05:6102:418e:b0:632:73ad:6c8 with SMTP id
 ada2fe7eead31-63273ad1419mr3576864137.7.1778508070281; 
 Mon, 11 May 2026 07:01:10 -0700 (PDT)
Received: from [192.168.1.160] ([2600:4041:54f3:a400:c013:3550:ed5f:a59a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm94773756d6.31.2026.05.11.07.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:01:09 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 11 May 2026 10:01:01 -0400
Subject: [PATCH v6 03/15] target/arm: mte_check unemitted on STORE_ONLY
 load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-feat-mte4-v6-3-8557cc1313b9@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778508062; l=4552;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=rH8vC1onC8Ly7tRYKkxqsrL8toXuandudSiZ9ut8IVY=;
 b=CRJQuU7GXeChta0scZqptI8Qg/vLNxIT7BkVl9Uc2V+Qrg5+b/K6Ssb2SFApymVjN/9UBX/S0
 3t+zA40h7EQCIYk2UnI3aOqN4c8i7HB7/Ha5p1s7Nv6UEADKxlB6PMt
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=brookmangabriel@gmail.com; helo=mail-vs1-xe2d.google.com
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

This feature disables generation of the mte check helper on loads when
STORE_ONLY tag checking mode is enabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  2 ++
 target/arm/tcg/hflags.c        | 12 ++++++++++++
 target/arm/tcg/translate-a64.c |  8 ++++++--
 target/arm/tcg/translate.h     |  2 ++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0894a050b1..fce0bde168 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2531,6 +2531,8 @@ FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
 FIELD(TBFLAG_A64, GCS_EN, 41, 1)
 FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
 FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
+FIELD(TBFLAG_A64, MTE_STORE_ONLY, 45, 1)
+FIELD(TBFLAG_A64, MTE0_STORE_ONLY, 46, 1)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 7e6f8d3647..75c55b1a6d 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -423,6 +423,15 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
@@ -432,6 +441,9 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
index 9a27c4c6ec..ce6249649a 100644
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
 
@@ -10697,6 +10699,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->ata[1] = EX_TBFLAG_A64(tb_flags, ATA0);
     dc->mte_active[0] = EX_TBFLAG_A64(tb_flags, MTE_ACTIVE);
     dc->mte_active[1] = EX_TBFLAG_A64(tb_flags, MTE0_ACTIVE);
+    dc->mte_store_only[0] = EX_TBFLAG_A64(tb_flags, MTE_STORE_ONLY);
+    dc->mte_store_only[1] = EX_TBFLAG_A64(tb_flags, MTE0_STORE_ONLY);
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 77fdc5f3a1..c74a4f6675 100644
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
2.54.0


