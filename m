Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561E8C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutjl-0002wt-LT; Wed, 19 Mar 2025 09:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutji-0002tX-US
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjh-00042v-4a
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso48330345e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391930; x=1742996730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Lkvodc73kqPvvWCS6V/G40kuyzwCLOWEJP7L4a0kMI=;
 b=ugvzKWMTCQ8Er9xmw7/jgW4kDRCYYjnEyT5JV1UJRigy9c5qi2TcmrHXyVp2Ws3R/l
 1XhixhcozlY2RHBk1ndTV6Neyfe/t8JOJ3FmnFhmCcor4rRt2rRrEhhZk8ZKf41no2gk
 dGg7Mw3zhQnaT02v4jsggBwaKp68qIzcGivir7fA4p/FQWytsFVhTxKW4C6/QUJssIGn
 cSjd56kXGxUFUkJhDOynWO4f7P3FzdkvkSmj6Vp/QCQxWK4uG//Lm8fb5qTgTSVQBzII
 HNRW/NcrFsJH+1fiXWXHNks1RzCQWGzIqquQD7sjBLCtJg1OBj1p1zJUtgg8/qq7wLHU
 8Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391930; x=1742996730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Lkvodc73kqPvvWCS6V/G40kuyzwCLOWEJP7L4a0kMI=;
 b=vQlEP41F9fzfrzElrwh392pky+tyegjsSogLCie4m2DOi8bUXhfdV+dnXrgldX9ysc
 ocx3FrnEG1ZSp+fnQoXiFnSzZOOUgeRBTTSKPTPdwnuuOnJvAKtcyhgOwVBo835w4W+z
 w3GIz/ORMwidbIb9MKaZ7t7IBdw9NkWGZaFIu2up/1AVMO3OXgYksw5c5sS47+XkDklV
 xithR/OXvDrT/X9NKllSZ0QW1Xl6eN3YjQmeSj9VTRiB+LMB1IH9GwntQZyhlWcMA8Ha
 /NCFU8R7JZuSTt4kE1UIYh07pNRAgy0PnSCGdfCPYlN4LEyhtngHOK/Qxc5dnFFiA4tW
 zAaQ==
X-Gm-Message-State: AOJu0YwIA06zLLImh5RDYgLxxRYf+gHseJpnlVkWG7d+RB0WmYsQ3pyI
 Kr4tCgi1KSi+57G7lPAGnxL23CfWgswbwRX2hHWu2wtusF0L8c/VBdk7nDwoWI8bbopjnPd8ToH
 T
X-Gm-Gg: ASbGncsdb9WU57ym3sZ1IsP5fSVszDOnYbW4S/2cnJvZ2jF7ZcyYFKcG6LAutwm1tEB
 w1kTz/vX2op3VvEMmvBEieleAlqWScnlb8bf3i69BAoNDRuqbSHXkqcCJF4rnCctORwd5p1B3Os
 Mlf0flVukU14aJPVLArWKQbZEIRMbQvdIeOoRVdRHSgoVgwTPtK5f7+cfmMHDcKgdzwXH+ExQlp
 sjXkFPSzaliUcqk9nQQByTkuDOFcX3QmKQTRryS+VZnfCX0r508bwBkflpVj8cA2jpku6YYdf+B
 UL6ILhGQAXheqBtF6Rcl8TUiYN4xp066Tj1OeNAE/5Orgzd3zcnnQsM+jtcgsLPmtcX2azYxdQg
 1IK4l3o90OY5aLMjruaA=
X-Google-Smtp-Source: AGHT+IG15GI4sRoa+mM6KO/21sJQu5AvbMNEtxjcyfFR5LiV3CPxQ/q2n5+Nje9dNOyPk62WkUibDQ==
X-Received: by 2002:a05:6000:184d:b0:390:de58:d7fe with SMTP id
 ffacd0b85a97d-39973b0609cmr2662448f8f.51.1742391930175; 
 Wed, 19 Mar 2025 06:45:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318af0sm21134199f8f.73.2025.03.19.06.45.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:45:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 04/12] tcg: Declare local 'insn_start_words' variable
 in tcg_gen_insn_start()
Date: Wed, 19 Mar 2025 14:44:58 +0100
Message-ID: <20250319134507.45045-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

In order to keep following commits simple, introduce the
'insn_start_words' local variable in tcg_gen_insn_start().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg-op.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 8938f386599..e0038e70a8d 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -25,20 +25,29 @@
 #if TARGET_INSN_START_EXTRA_WORDS == 0
 static inline void tcg_gen_insn_start(uint64_t pc)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 64 / TCG_TARGET_REG_BITS);
+    unsigned insn_start_words = 1;
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
+                            insn_start_words * 64 / TCG_TARGET_REG_BITS);
+
     tcg_set_insn_start_param(op, 0, pc);
 }
 #elif TARGET_INSN_START_EXTRA_WORDS == 1
 static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 2 * 64 / TCG_TARGET_REG_BITS);
+    unsigned insn_start_words = 1 + TARGET_INSN_START_EXTRA_WORDS;
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
+                            insn_start_words * 64 / TCG_TARGET_REG_BITS);
+
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
 }
 #elif TARGET_INSN_START_EXTRA_WORDS == 2
 static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 3 * 64 / TCG_TARGET_REG_BITS);
+    unsigned insn_start_words = 1 + TARGET_INSN_START_EXTRA_WORDS;
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
+                            insn_start_words * 64 / TCG_TARGET_REG_BITS);
+
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
     tcg_set_insn_start_param(op, 2, a2);
-- 
2.47.1


