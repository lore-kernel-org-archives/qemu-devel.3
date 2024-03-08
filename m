Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B10C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAX-000132-Kj; Fri, 08 Mar 2024 06:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAV-0000XT-0T
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:39 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAR-0001js-UG
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:38 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dcab44747bso15209115ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896414; x=1710501214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NDTWrAd/QJQc24B/fwtUDVrM0y2WqUgaTFtOEdVeHs=;
 b=MLer2seKcEtcY3wkmuw9aUGaHCyPMmw4LTlfRzkPElX3RFB2YV1BhpAZQAvqM65xTS
 neWuTrP8bBLXgv3gq4tJfC7NsBPmcPsqBPA7ln7KQTZm8f0q+qDTegcqvu+afkqHzido
 q6+yzro+d34EPi6tAeezDP4G1Ykxff14LWxjgzwylCV8ohM8IGHehFb6Yy2W6t7BHkvS
 9zogLpMgIZlS2vdufCZ5n/GbUNw+Stk/L9JtkOHDPaHzhL3NzNKBdDKwgmV7zLA4AhIe
 U4We8Ffmp4Lhw0AtHPGU0wonCxEmL9eHVvqywU2cDgqAXicFJco+4qILK6n3Zpo63JH3
 HIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896414; x=1710501214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NDTWrAd/QJQc24B/fwtUDVrM0y2WqUgaTFtOEdVeHs=;
 b=Z5yIj5GwmL3gtunxL86Tld8/cmgFv1PnJCZX/adhbr7gQd3+Klac1JcWo5jVcG2JXH
 S0iIfQhZATps6YPItJsuGj39fuZCLZy/J74xSLmcoQkdUUbdrQdncVRfUYsOsmw9Gg7q
 vl4VYO2i6NskeH2nHTge901j2E03T+dlLpqIaAIMdVU/aBilnJlfWYIdVPss09KPq5JF
 hotunXkDDUYYUBSON/4xkR8AlkK8MbkUaGps6hfNZsQG8GMX4Dk6thPtX6HY5/uMRJ54
 tx6CFDnKPr+yZW9zfrPh7YlC41gPoSGfwHN0fPg3uvFYa8b48uEluD0YFvRRKkKya8UM
 OSNA==
X-Gm-Message-State: AOJu0YzZPUIyEpKSAdptGomcF0Y3q6fsriWg+LyxpXEkSBEtNDDlBOV0
 NqgcF1i0cJ3HdvoXm2c+syxTxeh7Tag9cbxmkheD753kogI5qWtD6WjS1HPT9QPJvg==
X-Google-Smtp-Source: AGHT+IFSmIMVmsqeeuaXOPKR8ie55F8VQZhWPbYW2bzqDrL1ZKlFW06fdvcmT5RZuMZeFmzx4tVNLQ==
X-Received: by 2002:a17:902:dac1:b0:1dc:4a8b:2e21 with SMTP id
 q1-20020a170902dac100b001dc4a8b2e21mr13842515plx.19.1709896414349; 
 Fri, 08 Mar 2024 03:13:34 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:33 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/34] trans_rvv.c.inc: mark_vs_dirty() before loads and stores
Date: Fri,  8 Mar 2024 21:11:46 +1000
Message-ID: <20240308111152.2856137-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

While discussing a problem with how we're (not) setting vstart_eq_zero
Richard had the following to say w.r.t the conditional mark_vs_dirty()
calls on load/store functions [1]:

"I think it's required to have stores set dirty unconditionally, before
the operation.

Consider a store that traps on the 2nd element, leaving vstart = 2, and
exiting to the main loop via exception. The exception enters the kernel
page fault handler. The kernel may need to fault in the page for the
process, and in the meantime task switch.

If vs dirty is not already set, the kernel won't know to save vector
state on task switch."

Do a mark_vs_dirty() before both loads and stores.

[1] https://lore.kernel.org/qemu-riscv/72c7503b-0f43-44b8-aa82-fbafed2aac0c@linaro.org/

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240306171932.549549-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 742008f58b..b838b8ea5b 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -652,16 +652,14 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     }
 
+    mark_vs_dirty(s);
+
     fn(dest, mask, base, tcg_env, desc);
 
     if (!is_store && s->ztso) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     }
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
-
     gen_set_label(over);
     return true;
 }
@@ -817,11 +815,9 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, base, stride, tcg_env, desc);
+    mark_vs_dirty(s);
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
+    fn(dest, mask, base, stride, tcg_env, desc);
 
     gen_set_label(over);
     return true;
@@ -924,11 +920,9 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     tcg_gen_addi_ptr(index, tcg_env, vreg_ofs(s, vs2));
     tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, base, index, tcg_env, desc);
+    mark_vs_dirty(s);
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
+    fn(dest, mask, base, index, tcg_env, desc);
 
     gen_set_label(over);
     return true;
@@ -1122,11 +1116,10 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
     base = get_gpr(s, rs1, EXT_NONE);
     tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
 
+    mark_vs_dirty(s);
+
     fn(dest, base, tcg_env, desc);
 
-    if (!is_store) {
-        mark_vs_dirty(s);
-    }
     gen_set_label(over);
 
     return true;
-- 
2.44.0


