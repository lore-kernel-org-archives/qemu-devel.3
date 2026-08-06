Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0940BC56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrzSY-0003Bs-W7; Thu, 06 Aug 2026 10:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wrzST-0003Ax-J2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:52:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wrzSR-0000qF-US
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 10:52:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so22689955e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786027950; x=1786632750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+wv/3gzzV0HrYttysmip7ruezdJHnFqLu5ugjhElxu0=;
 b=mnfpGJLAOUIsnihQ85yJvMc+/J+xElsubwFcnH0SqVSrqVs6jsSIP3yuCYrzyjqHd2
 tDg7n2Mw9sHVvtbQ6bZlxxUaERb/oljAdMHISjggf9hkIgQA2LYDnKcWY+d/C6lZTyg3
 6FrJODFM4G3QiLqZu719RtsK1H5WIlzIIs7Ir7LxTANxyx72rdOLBI+6VHOJCvgmJRis
 /rlQmkYkbCLWp4ORK0OnRjD+GqmVvvtYuQVyrYR3+qILh2XBRfdqlCzyg/QDqmu71lH7
 OPlLA26ERIGJlaHG8ufXCXVk2q29nuIL7GSYEaeRlYxkNNIkLL1xJ7StFR2KcXtyi+Qj
 JsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786027950; x=1786632750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+wv/3gzzV0HrYttysmip7ruezdJHnFqLu5ugjhElxu0=;
 b=nwj4CDlgCi3VRwCe5jT//Y6Qx1wynbHeM8p/dS+E2WHRJlQCp+5yziHm9ca12E9wrb
 XBG+J8VO0/er6WLq1lmoLCKVdAOr5VtH4f6jbQiSzP3PgvxwZIQPYpAMNCXtHaW2aMcN
 /zr3jx5iBjj8EmOiEa3qsG1zLUwrtmawAf5gDI6X0POsiiWDov2HmO5udY0U0+dm0ixG
 MPAA6DZ0SnXvjRfMmuxy/N9rMUsjg4j6aSoNNWdOm46z30Cb09kXqeyMdT8/aATNiQjr
 NPzKGzjmlFiaqQnjDipp0NUvrUJBqCscFlcMU5hpVkygiKqkDR4YTocar55I1Wr+xaw0
 5Amw==
X-Gm-Message-State: AOJu0YxRadptwNXv8odq6qgKWzN7nDfjXRLMPzZBXBZG4/CesdzcrRSN
 1tPLD/jgI7Z1I5BGoYbNrWgYjDrmCY3O56pPMHocF28bjnDY5kAN++fZ7Sswo0xq/As=
X-Gm-Gg: AR+sD10su62ap1CsTlA1QepWUcPF3aYXVdSVn1lBcVnI3aDRlOlznlbh0Uf/M7URh8f
 TrWi+L0OoGsy6fG1s4IbEg0NP+hof+qxIM3Y2mK29N1XVM7etIwD6JxlGBtOeUPrTPGoLj423TR
 wgY88fSVez8s31NXjKtKMYfvCePIz9ywcAG9fGX2tBHSgzPAHZmNBztIRDseWtO1MIqxfFpRWVr
 xtyIhUWGXB1MMH2omILpeW26J/h0K4IUNQ5UcpM7wKFsNeggqNHUdlRo2rpOoLGsZp9xXRQP0Ss
 bDvQpUN8wU8Wa6e/lzdwP91eyuPuFEMCtfecKlCa8yeFioCRDUOC/b0yhSPZ9qeYbIgczP4pcpb
 XO8eXfBP6dVJ676vuPFNr2ISH38dzcBjWdJR23O76aGag13ikP54gVEpXPKSX9B+sDq2VSe9aw2
 ekTgP6sAY4Er6Db96IjDxcoVXofY0W+IHFVqzSMHu/7nZb/Gxpm1Tg4zML6URVu9PrdHnTRWcRY
 QMpD4/r5QTzQBqma7UXemkH2aw/qrWlqLR5qs8u8OIH82XX0M1zTbEnN3oCwp4fkSFhMoB4fdB+
 MsuV7b8VEk3NZw/uTbn1XH0661Gvs5uCD8pFNA==
X-Received: by 2002:a7b:ca4d:0:b0:495:6134:6d61 with SMTP id
 5b1f17b1804b1-4994e7eb2d2mr162473425e9.19.1786027949735; 
 Thu, 06 Aug 2026 07:52:29 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-c122.tugraz.at.
 [129.27.234.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b26809sm6562951f8f.25.2026.08.06.07.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 07:52:28 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH] target/i386: Clear OF, SF, and AF for fcomi/fucomi
Date: Thu,  6 Aug 2026 16:52:24 +0200
Message-ID: <20260806145224.184019-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wm1-x32c.google.com
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

helper_fcomi_ST0_FT0() and helper_fucomi_ST0_FT0() only cleared
CC_Z, CC_P, and CC_C before merging in the comparison result,
leaving CC_O, CC_S, and CC_A untouched from whatever they were
set to beforehand.

The Intel SDM documents FCOMI/FCOMIP/FUCOMI/FUCOMIP as setting OF,
SF, and AF to 0 unconditionally. The AMD manual doesn't mention them
at all. However, testing on multiple real Intel and AMD systems confirms
all three are unconditionally cleared regardless of the comparison
result or their prior value. Widen the mask so OF/SF/AF are cleared along
with CF/ZF/PF instead of being carried over from before the instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4133
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 target/i386/tcg/fpu_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 978eb1411b..215547110a 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -554,7 +554,9 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
-    eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
+    /* OF, SF, and AF are unconditionally cleared to 0 */
+    eflags = cpu_cc_compute_all(env) &
+                 ~(CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
     CC_SRC = eflags | fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
     merge_exception_flags(env, old_flags);
@@ -567,7 +569,9 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
-    eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
+    /* OF, SF, and AF are unconditionally cleared to 0 */
+    eflags = cpu_cc_compute_all(env) &
+                 ~(CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
     CC_SRC = eflags | fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
     merge_exception_flags(env, old_flags);
-- 
2.53.0


