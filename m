Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4CE606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mMYwvEvZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsVn-00065X-Am; Fri, 30 Oct 2026 15:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVe-00062c-LM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:30 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVa-00008P-Ky
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:30 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-843a4ca671eso496190a34.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793389404; x=1793994204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P85+btTqtBKqfwD1jOrC4yX/wfGNphtlJ8FsVIfPq+c=;
 b=mMYwvEvZXOnMR4fwspnqIGGroCNmolkLrlPMUZX9st8S/Khl3rkmPQSI1LGwsyCAaN
 8q8IGptuhhi5SBgSYsCIJhLVtG++oLsMULK/2GwA7N8UGof5I1lz1ATybV5mf1dHpWui
 Mmfrso7Muze6I0VFFtBloJ18h6jUely2Zg2buWlVw0xwallLVb0f5NWyUmpqkd+JqJEv
 LOZHPJqicp9TMVonxqqyoQJKeYwPD4hBGVuqyhk6Pcn/KTmFfMeXLdYQP8kdS5k/5wVj
 OOvejBVoAjCoFc/YHB16zwGpwSxqb2iZ4ePzxedO4eV6D71Q1WzSHTaeuYqiKRHV28Ew
 HJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389404; x=1793994204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P85+btTqtBKqfwD1jOrC4yX/wfGNphtlJ8FsVIfPq+c=;
 b=a2u+SYsiqOk+EvaLjhZnov55z6KNESX6OnPNy0HY4UBITAvSzr8CV8Zh8x4Uev2amY
 ub2fwkj54obToz+/y2ujjpsE3mTJ5wk03hgpS/9xtml/Dk410Hm4G9/Ue99uFqWpfU+N
 N54vXyEEo5akrvI+fDk1C3R6HGjckGfppltWcatEuud5jFiOx8Q2HSTD5UFaOZKOArmg
 1Ho/P4oyMLc70vFtn4NyZaQuL+NMGw7rBl/VwZY9RZ+2NQ/McjsK/Yzb+u9VeO2wKRgr
 jGKPeIgBatJkmrW7l5y9d0WkYfw/3+AyQx/eXcZU+kAefVGlaZxVwPlg4D2DdfXawVU9
 +WLg==
X-Gm-Message-State: AFq9FYJlOjiFT2gG53kytNI7e6RM9WZcVzrxeuibPr+Kmr7yrDFRa0r3
 U6DuuWlVam22Or6Cqq6f8XzIOk84o6tdbLl8qEPe3jy6gAE//j0t9qcRp6WhmLFhXMxkoFLTLaF
 MXg18
X-Gm-Gg: AYBFou0ZitS01coUf03md9iH6zWJi9yDyXY6AQc+0vffOjRXenhbBGxu0EFmMoq0ZhK
 ZzVlT8ZxZItDzqo+zxlXkE6Yk2ALrSdEAhwnFFSw2u4CJUKBsz8iIAPwLET5svigaV83uLasjdz
 WHQZpqrn5C4w9eJDxGjjwt+UdZ5dQVKSN6u8LqefQtM9GpjOZQPgIH6xYbIOIqchx29ZsuZN3kp
 uinNdVlZFw1t6ZgcSY7WsqnJooXynjMdcciBYAhx44M7XjiBedbZBZTc8gWufsQ//qx56wpPTsj
 rnaiNIyitIyVutqfh332i38i/PvYRGs075P2WhNZ8BO2EH3c5kU68fFfr9LTDHAS2cWYyZLoOS2
 SpoguYTbZRW8ZfhZYZf2OwW8IAEcpMPAodzrLeY2L0xTBavFiIoqq7JnsuF1CMk2QZizMM3XHiH
 ltpV4M+fWzURHdfJYpAxN3wyw8EEPrkl6jx4HKM85OsBc3aV+IMBdLx3McSTcyNgRhYENRIBsI8
 0VKzO+4dYDcuCF9X4MN8LDrjgQzhIhMnJlD+9Qr/jX/JyHZXGBYyVG0HD3f//9HJKVUwJKcY0EC
 yQHSLnOMNRQ0Z/y5wDgM/QlBukR0QdcUyaOoT85IVKMrXYh730Xkf3je
X-Received: by 2002:a05:6830:438d:b0:829:9992:2106 with SMTP id
 46e09a7af769-85d36633ee3mr2321771a34.22.1793389403954; 
 Fri, 30 Oct 2026 12:43:23 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e77c8sm2654768a34.2.2026.10.30.12.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:43:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/9] target/arm: Retain btype in DisasContext.tbflags
Date: Fri, 30 Oct 2026 14:43:11 -0500
Message-ID: <20261030194318.319310-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030194318.319310-1-richard.henderson@linaro.org>
References: <20261030194318.319310-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace btype = -1 with btype_set = true.  This is both
less confusing and keeps the state separate from the
per-insn iteration.  Set tbflags_invalid when we need
to read the btype from the page tables and therefore
we cannot keep DisasContext.tbflags up to date.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     |  7 ++-----
 target/arm/tcg/translate-a64.c | 28 ++++++++++++----------------
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b9254d5524..029107f4c0 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -206,11 +206,8 @@ typedef struct DisasContext {
     bool gcs_rvcen;
     /* GCSSTR exception EL or 0 if enabled */
     uint8_t gcsstr_el;
-    /*
-     * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
-     *  < 0, set by the current instruction.
-     */
-    int8_t btype;
+    /* True if the current insn set PSTATE.BTYPE. */
+    bool btype_set;
     /* A copy of DCZID_EL0.BS. */
     uint8_t dcz_blocksize;
     /* A copy of cpu->gm_blocksize. */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d8b6c1df41..64e28a089a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -173,14 +173,15 @@ static void set_btype(DisasContext *s, int val)
     /* BTYPE is a 2-bit field, and 0 should be done with reset_btype.  */
     tcg_debug_assert(val >= 1 && val <= 3);
     set_btype_raw(val);
-    s->btype = -1;
+    DP_TBFLAG_A64(s->tbflags, BTYPE, val);
+    s->btype_set = true;
 }
 
 static void reset_btype(DisasContext *s)
 {
-    if (s->btype != 0) {
+    if (EX_TBFLAG_A64(s->tbflags, BTYPE) != 0) {
         set_btype_raw(0);
-        s->btype = 0;
+        DP_TBFLAG_A64(s->tbflags, BTYPE, 0);
     }
 }
 
@@ -1894,7 +1895,8 @@ static void set_btype_for_br(DisasContext *s, int rn)
             TCGv_i64 pc = tcg_temp_new_i64();
             gen_pc_plus_diff(s, pc, 0);
             gen_helper_guarded_page_br(tcg_env, pc);
-            s->btype = -1;
+            s->btype_set = true;
+            s->tbflags_invalid = true;
         }
     }
 }
@@ -11044,7 +11046,6 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->max_any_vl = MAX(dc->max_svl, arm_cpu->sve_max_vq * 16);
     dc->pauth_active = EX_TBFLAG_A64(dc->tbflags, PAUTH_ACTIVE);
     dc->bt = EX_TBFLAG_A64(dc->tbflags, BT);
-    dc->btype = EX_TBFLAG_A64(dc->tbflags, BTYPE);
     dc->unpriv = EX_TBFLAG_A64(dc->tbflags, UNPRIV);
     dc->ata[0] = EX_TBFLAG_A64(dc->tbflags, ATA);
     dc->ata[1] = EX_TBFLAG_A64(dc->tbflags, ATA0);
@@ -11182,10 +11183,9 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     if (dc_isar_feature(aa64_bti, s)) {
+        int btype = EX_TBFLAG_A64(s->tbflags, BTYPE);
+        tcg_debug_assert(!s->btype_set);
         if (s->base.num_insns == 1) {
-            /* First insn can have btype set to non-zero.  */
-            tcg_debug_assert(s->btype >= 0);
-
             /*
              * Note that the Branch Target Exception has fairly high
              * priority -- below debugging exceptions but above most
@@ -11195,13 +11195,12 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
              * We can check all but the guarded page check here;
              * defer the latter to a helper.
              */
-            if (s->btype != 0
-                && !btype_destination_ok(insn, s->bt, s->btype)) {
+            if (btype && !btype_destination_ok(insn, s->bt, btype)) {
                 gen_helper_guarded_page_check(tcg_env);
             }
         } else {
             /* Not the first insn: btype must be 0.  */
-            tcg_debug_assert(s->btype == 0);
+            tcg_debug_assert(btype == 0);
         }
     }
 
@@ -11216,11 +11215,8 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         unallocated_encoding(s);
     }
 
-    /*
-     * After execution of most insns, btype is reset to 0.
-     * Note that we set btype == -1 when the insn sets btype.
-     */
-    if (s->btype > 0 && s->base.is_jmp != DISAS_NORETURN) {
+    /* After execution of most insns, btype is reset to 0. */
+    if (!s->btype_set && s->base.is_jmp != DISAS_NORETURN) {
         reset_btype(s);
     }
 }
-- 
2.53.0


