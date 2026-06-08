Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38B1CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWW8w-0000Hk-Df; Mon, 08 Jun 2026 05:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wWW8t-0000F3-OZ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:19:35 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wWW8j-0004re-7a
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:19:27 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3965d76090bso36433661fa.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780910363; x=1781515163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5X+tw0HgT0J/AU9AHfidQJCM2gu7ryLNaTBeSDEjxqk=;
 b=mG59e4DybhqsDkuCzUi4VE7Z4OTMm/lD0flivogM/QXjMw6zMdl2G6KsauaJybumd3
 zhePQratHM5LgphxjKuajZ6mI52EaEGH8Xk07OIY7D8eofYMNr7uusSGB649PvB/OrOC
 6mbns4eiuqJXJn8Sxfylb/clVWdB/qoFc0HY7XMLN52U0Smi8Gj/de6VFZhvPZvFDXsI
 qdT+XvfWhOrcb24cZACVSC0p/43oUJATG06bea2zebwb0nXKoQdyrp1vwXiS4cwagMk7
 LaZtSqk98MgmwBk/bCYMcbbRX8/sNgCg9tepi5gshtDRTOjXT57nPuD3zza7cVu4OG0r
 xqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780910363; x=1781515163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5X+tw0HgT0J/AU9AHfidQJCM2gu7ryLNaTBeSDEjxqk=;
 b=Mn0sauId7nU7k1bKedCSFILVbF7aPKfIIMgBOdS/VYaBhbyf1fXEt2+xa2cCJoO0MP
 dZs+lICgvqcmKk8heoEr75GQzkV0/Y9SAPxjIGaRRyDlqHX45tLClo9AISzNB0HXIiyH
 Nf4EFe/ojqvJzil/fpizG+tLe0CsAQ6lDOAMv5FIEl/cr4RLIRR5MCORHgcRCbYWsG3x
 Vo0XxWnYQnpoPI3W+gwDnRqs1kQRv1pFhGuNAvsPZDP2l/yhtdjepxNqoSdDLQtodz66
 qr5Jm/hFtuUlCqi6nKXTxXIfQkZpbfcDcU3Bk5s46G9fQ4/lHkFk0hDX85Nh6DPQuw2t
 QSrA==
X-Gm-Message-State: AOJu0Yyjh1Mx6Z5DDxjAASsaGjeO48tQeLK/oHu1Z32cn+FEj7o9hEsO
 8+OaaOaZk/6R7vd6mO8SuZAftbKe5X8y4GbSv2PJR2Nj/ZN/wFZDb0MnK8+iXr5guW4=
X-Gm-Gg: Acq92OHSo0JUZ0R6n1ivQYZoCQKmXXTuwoEnny4HtezAlC7XtJXNmsxaXLBhx7k/1Wt
 eiax1KkhikfbdEYw5y9fARzAumZoRss7cf0mF9/dCUfy1oFtyuQyhUiUMR/uQsyzpxPSW/7P00K
 eSPYeINAMVvDWgftp1TH5Gn0mjq+eSTPNV43/h3IqpegQCu6R19CViAvvKg8vUozFOI2ULErUrS
 5EHvO3zzoaxcoE9GQi0/O80Yh8uYJEVahPAmdHX9qO7ddM9y5XktNu2C76FaZUdoVDngGbhsBO6
 cttXZfIS2exz/DcgaEujSafHJzgRSYYND6f2c8KYZRBGGHLVvi5TbYkdY4UgHgMvXjkKWHxw6gp
 felzk1W57XAfcc6V0gzTH7ovN13T5FDF/az4aA1UBUnRlOtJM8UZ6DpovddIN4msa88A0BTNRlr
 UDHkB8iIARy9sqnDo8EC/wVsgaS9E=
X-Received: by 2002:a2e:a915:0:b0:38b:be3e:b752 with SMTP id
 38308e7fff4ca-396d0951a68mr39087621fa.20.1780910362349; 
 Mon, 08 Jun 2026 02:19:22 -0700 (PDT)
Received: from kali ([82.162.57.219]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2be369sm44373221fa.26.2026.06.08.02.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:19:21 -0700 (PDT)
From: Andrey Polivoda <apolivodaa433@gmail.com>
To: qemu-devel@nongnu.org
Cc: Andrey Polivoda <apolivodaa433@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] target/i386: helper_sysret(): Check that RCX contains a
 canonical address when emulating an Intel CPU
Date: Mon,  8 Jun 2026 19:18:15 +1000
Message-ID: <20260608091815.31303-1-apolivodaa433@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=apolivodaa433@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Intel and AMD CPUs implement SYSRETQ instruction differently.
One of these differences is whether a canonicality check of the address that
will be loaded to RIP is performed: Intel CPUs do this check, AMD CPUs don't.

Currently, QEMU does not perform this check when emulating Intel CPUs.
This patch corrects this by implementing the canonlicality check on a new RIP
value from RCX and performing it only when emulating Intel CPUs.

Flags and segment registers' caches are updated only after checking the new RIP
value to ensure that CPU state is not modified in case the #GP(0) exception
is raised due to the check failure.

Cc: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Fixes: 14ce26e75513 ("x86_64 target support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3223
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
---
 target/i386/tcg/seg_helper.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 58aac72011..d5c174b7fd 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1096,17 +1096,22 @@ void helper_sysret(CPUX86State *env, int dflag)
     selector = (env->star >> 48) & 0xffff;
 #ifdef TARGET_X86_64
     if (env->hflags & HF_LMA_MASK) {
-        cpu_load_eflags(env, (uint32_t)(env->regs[11]), TF_MASK | AC_MASK
-                        | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK | RF_MASK |
-                        NT_MASK);
         if (dflag == 2) {
+            uint64_t new_rip = env->regs[R_ECX];
+            if (IS_INTEL_CPU(env)) {
+                int shift = (get_pg_mode(env) & PG_MODE_LA57) ? 56 : 47;
+                int64_t sext = (int64_t)new_rip >> shift;
+                if (sext != 0 && sext != -1) {
+                    raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+                }
+            }
             cpu_x86_load_seg_cache(env, R_CS, (selector + 16) | 3,
                                    0, 0xffffffff,
                                    DESC_G_MASK | DESC_P_MASK |
                                    DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
                                    DESC_CS_MASK | DESC_R_MASK | DESC_A_MASK |
                                    DESC_L_MASK);
-            env->eip = env->regs[R_ECX];
+            env->eip = new_rip;
         } else {
             cpu_x86_load_seg_cache(env, R_CS, selector | 3,
                                    0, 0xffffffff,
@@ -1120,6 +1125,10 @@ void helper_sysret(CPUX86State *env, int dflag)
                                DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
                                DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
                                DESC_W_MASK | DESC_A_MASK);
+
+        cpu_load_eflags(env, (uint32_t)(env->regs[11]), TF_MASK | AC_MASK
+                        | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK | RF_MASK |
+                        NT_MASK);
     } else
 #endif
     {
-- 
2.53.0


