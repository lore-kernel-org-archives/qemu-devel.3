Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497B9C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 03:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN2Nd-00038o-Ls; Thu, 27 Jun 2024 23:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris.chenfeiyang@gmail.com>)
 id 1sN2Nb-00038P-NM
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 23:34:32 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chris.chenfeiyang@gmail.com>)
 id 1sN2Na-0001Pp-7t
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 23:34:31 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7082dd9bbf8so208537b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 20:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719545668; x=1720150468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=04oN8okg9xBMeB8NLnfYB5eIdRMBX4HOVW9876PMByI=;
 b=Fwyo93OfBXYMpfukoU6ojBrVVqktCr95K36mUlVwxbBZlJKQesKG/pd+XMNIjpvpr+
 4snCXJb45sWeEvBAOAfzOqEiwcW7qL238HoEDPrfUZtmsLqKJUNhlgpxH8a15V9ACopX
 9DXKomTYmnWUxE1RKHhG+fnXuM2UWxosVYsGGqLOlKWnpcgQR3tj5iDNUEqZUF7wEmUX
 NkGPbKPrrVTEwKMC1YeqLP0GR/q0IQPjnSZNybICloQKGsI7tJHby7xcMNg69sRnJXas
 AjmRrdp4PSQox58qLmKlvu7p5r14vMC5GNFymhe1AJ4vV3VF+lbtYkV8QPpjp5wQK/Qz
 cMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719545668; x=1720150468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=04oN8okg9xBMeB8NLnfYB5eIdRMBX4HOVW9876PMByI=;
 b=alcHw4GNO2TybH1HoYgQGZbWByEQ3xDv/tPOc+uXnnBjJGyQ8QY7IQ7z1PFxJKAOdX
 w25qwoIsKe3OtcwIk2zq/dRwnC0zPPrt1gHO7/tQSUsMjYFcioDtpIX6L9z7IMg5lPgq
 afLKArorP0WM+x6Hdo5yLX3EQEmXlruCMSbQs0M2eToh7dcRO3MKBFKIODEk0CdAkBvW
 SUjDcJ7/6XIQEsfbBLgZq5JHA5OH6oQBUXdnVkQDWRNlyqRu2cnGekAT4ni195yl3UaU
 kXgOs5pPSoKW3zrUSNDgnpb+YdnK3dnJJt8bRqRDWHYwDSjZX9ajtdKUdJSRioKMLHm+
 7HGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ZE4DrjYwePJ2llkfay6q6aKv3PM2mY5KB/gWIi82RgIDKEVzg5r3/JUE0H/PRN2PADjxFLxbkNAH3tAAgEkJJGIRjB0=
X-Gm-Message-State: AOJu0Yy/2yiMiurhus1pd0JERSUMHLutLEaFbRhwEaNXm/3sseHf9cj4
 Mi/SafNn7vBzW9yLVyaIl2FRu2cAcjnJbrNnCr8aD76syMRaiHw71RzTYg==
X-Google-Smtp-Source: AGHT+IGdDGOGgUuc4jW043WRngaNFCwoPV5S0plfPupLnjo/ozBCQU94aPnrOdtRUI+mZADWjSxkyg==
X-Received: by 2002:a05:6a00:a06:b0:706:9073:45ee with SMTP id
 d2e1a72fcca58-70690734663mr14392198b3a.25.1719545668378; 
 Thu, 27 Jun 2024 20:34:28 -0700 (PDT)
Received: from localhost.localdomain ([58.164.66.62])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70802664d6dsm489884b3a.80.2024.06.27.20.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 20:34:28 -0700 (PDT)
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
To: gaosong@loongson.cn,
	richard.henderson@linaro.org
Cc: Feiyang Chen <chris.chenfeiyang@gmail.com>, c@jia.je, qemu-devel@nongnu.org
Subject: [PATCH v2] target/loongarch: Remove avail_64 in trans_srai_w() and
 simplify it
Date: Fri, 28 Jun 2024 13:33:57 +1000
Message-Id: <20240628033357.50027-1-chris.chenfeiyang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=chris.chenfeiyang@gmail.com; helo=mail-pf1-x42f.google.com
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

Since srai.w is a valid instruction on la32, remove the avail_64 check
and simplify trans_srai_w().

Fixes: c0c0461e3a06 ("target/loongarch: Add avail_64 to check la64-only instructions")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Feiyang Chen <chris.chenfeiyang@gmail.com>
---
 target/loongarch/tcg/insn_trans/trans_shift.c.inc | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
index 2f4bd6ff28..377307785a 100644
--- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
@@ -67,19 +67,9 @@ static void gen_rotr_d(TCGv dest, TCGv src1, TCGv src2)
     tcg_gen_rotr_tl(dest, src1, t0);
 }
 
-static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
+static void gen_sari_w(TCGv dest, TCGv src1, target_long imm)
 {
-    TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
-    TCGv src1 = gpr_src(ctx, a->rj, EXT_ZERO);
-
-    if (!avail_64(ctx)) {
-        return false;
-    }
-
-    tcg_gen_sextract_tl(dest, src1, a->imm, 32 - a->imm);
-    gen_set_gpr(a->rd, dest, EXT_NONE);
-
-    return true;
+    tcg_gen_sextract_tl(dest, src1, imm, 32 - imm);
 }
 
 TRANS(sll_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_sll_w)
@@ -94,6 +84,7 @@ TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
 TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
 TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
 TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
+TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
 TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
 TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
 TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
-- 
2.34.1


