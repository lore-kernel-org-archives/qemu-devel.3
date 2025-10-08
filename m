Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2807DCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6P2R-0002XQ-JP; Wed, 08 Oct 2025 03:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P2P-0002Wd-BO
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P2N-0004rA-Nr
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so3558615e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759910197; x=1760514997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWJ4dGJwe3H/7r0SvaICNlYI4p5kQpsKZM2/kR5OlX4=;
 b=J5XDAZjipCLKdpmpMx13L1P2p731GfxZ38ZpmvoAERZ9C2niCDGnwqT8lbfPn7YF7l
 c6xCIM4fHyDPvJaTHsxqPmRRW43No2wjQFqDrNOe0J3AEKaUZ5+ehgUbMDzDeIvzuxLI
 5BSULFhi8Gnf2AXYTVUOsqQMHuw+vgtvQnB7CaUiKmuo62PUq7X9we7L5JjNVeEH53O4
 WaLG7I+h8l++EtV7GLwMHiZQBvKUNStZM3i7SX7bwY3eLMaT4rZcIn/vkH6JdrnuOc+d
 Ou0qWaDWvbwsOCptB6Jq9btGCvPbxYuPFIevZ7hoqKogrUrIO9OAgB57ZdBWeqEJ98Sf
 Pmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759910197; x=1760514997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWJ4dGJwe3H/7r0SvaICNlYI4p5kQpsKZM2/kR5OlX4=;
 b=OCjzSoLQ44tQ+euBW1bQh+r7XWTNfcaHYxuS4miD3MEBdhLy3NcQDRlhCwmOrpT2Qr
 jJtvrC2LF7bjYxwKhVy5isbVXPUBgUOqQNPf/mhWvA2q4iLOQdWsXzyDK9aHdo5D5KNz
 6I1MWw0GhvD3cuJCys7p4HAnPvGep/hP0Mr0x9/24oGGnanvUOREwcx6jzmTUqiv6yTv
 UfnjaR1mahgsqAory0n7nC3AjhG3/iql4GgsGWc1T3fYqMkJgNwIOuIi/5c1GKINBblv
 XsV0n2sDq/uEo/lpI6Zey/bvVOJjBHfI0pLX7Fiqd3ZRLhciLDVvDTrzefUgNwM+6CK8
 2RiA==
X-Gm-Message-State: AOJu0Yxblkjib2BtkTL4vmvgnyd1jkzWlL/EUz6l8FzWRV/i6MtUw4W1
 qjfFzDmGt5BMMBsd9gHZvJpeggg25zl+Lu7hz+/eO/fEB45IUMwI5Mtbhm4DMYc6ag/4FmSONy6
 d1Hnkzj0tJfLi
X-Gm-Gg: ASbGncvzjXJudKQFF60n6LWFf5NX44W8SU1NZx2AKRIP1xBP1T4vSUxtVHhYkYcg9pv
 gvcL7eqToKbHMKHhXBLhUeXWVA9XGE/aidyQ3qCMLPcn/JyqGqI9mv44OrDCP6kyrnpPt9X/qLn
 9+zFRen2NkIW8xMTmi+gxB0GsvGZQNhjXdbrC1BrTEPiL1H+O2ammFx9RY0U84xTFmNhXHb9InQ
 q95gw6ONUZVbM1fi9So74e6j5yY15bIbPF6aId5TbuJz2MgoTV8boktrC0zHaJ4j5dq7QVagNkj
 DZUM41JY3oKnQR8T6QO9cYjN7mp3Gti4hMzVKDTFijt1ZIQJRGl5F9/25lg0bxYUBgIU8WGP0sh
 6/HU3yu1nZ/mM9EublcjrUIYS/Zj3QQhAOdGAbhsIEG7KTJYILiLUEIRTeLfZMH3lx2PlopMHSD
 o0Vq9KqU7EbSky/4VTjqGYJs+d
X-Google-Smtp-Source: AGHT+IEoZQmZ28vUC4EmvvCTTf0f56c1BwxzysSBHDS+NpRsP/Sbbs6aOxtwkBChDl/Vv8XajWLsKA==
X-Received: by 2002:a5d:5f96:0:b0:3ec:42f9:952b with SMTP id
 ffacd0b85a97d-42666a9e191mr1554908f8f.4.1759910197502; 
 Wed, 08 Oct 2025 00:56:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b77sm28640118f8f.6.2025.10.08.00.56.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Oct 2025 00:56:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] target/openrisc: Use vaddr type for $pc jumps
Date: Wed,  8 Oct 2025 09:56:09 +0200
Message-ID: <20251008075612.94193-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008075612.94193-1-philmd@linaro.org>
References: <20251008075612.94193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/translate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 5ab3bc7021d..9f61f917b3b 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -51,7 +51,7 @@ typedef struct DisasContext {
     uint32_t avr;
 
     /* If not -1, jmp_pc contains this value and so is a direct jump.  */
-    target_ulong jmp_pc_imm;
+    vaddr jmp_pc_imm;
 
     /* The temporary corresponding to register 0 for this compilation.  */
     TCGv R0;
@@ -580,7 +580,7 @@ static bool trans_l_muldu(DisasContext *dc, arg_ab *a)
 
 static bool trans_l_j(DisasContext *dc, arg_l_j *a)
 {
-    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
+    vaddr tmp_pc = dc->base.pc_next + a->n * 4;
 
     tcg_gen_movi_tl(jmp_pc, tmp_pc);
     dc->jmp_pc_imm = tmp_pc;
@@ -590,8 +590,8 @@ static bool trans_l_j(DisasContext *dc, arg_l_j *a)
 
 static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
 {
-    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
-    target_ulong ret_pc = dc->base.pc_next + 8;
+    vaddr tmp_pc = dc->base.pc_next + a->n * 4;
+    vaddr ret_pc = dc->base.pc_next + 8;
 
     tcg_gen_movi_tl(cpu_regs[9], ret_pc);
     /* Optimize jal being used to load the PC for PIC.  */
@@ -605,7 +605,7 @@ static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
 
 static void do_bf(DisasContext *dc, arg_l_bf *a, TCGCond cond)
 {
-    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
+    vaddr tmp_pc = dc->base.pc_next + a->n * 4;
     TCGv t_next = tcg_constant_tl(dc->base.pc_next + 8);
     TCGv t_true = tcg_constant_tl(tmp_pc);
 
@@ -1586,7 +1586,7 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    target_ulong jmp_dest;
+    vaddr jmp_dest;
 
     /* If we have already exited the TB, nothing following has effect.  */
     if (dc->base.is_jmp == DISAS_NORETURN) {
-- 
2.51.0


