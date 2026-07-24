Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B76C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 20:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnM5t-0001wQ-V2; Fri, 24 Jul 2026 16:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wnM5q-0001ux-GY
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 16:02:02 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wnM5o-0005lp-Ci
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 16:02:02 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso777431a91.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 13:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784923318; x=1785528118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rWnTAiXSmPWa5RxmfVberE8PVE3I2Vb9TfspGKFpiJ8=;
 b=RqvYNA839UmimtcEKW8Qm4w1vAhLd3Tsh3e+GOEJg52s1/N9NGMTZfxDeTJUMql/Pm
 /YXLVjJ52fbI72saGgdLC7XMM0kT0HJRLhT7HfJ2a0d7ytw+UJRsoA8auC+nMo2PGK59
 rLzK0QFFS7JVBRsRKTTJHimYdRLSmFeFioL5ZFDKBIQByluUNIa07Ui6OhasTt3azvtl
 OCTiCZqP8AmQIMef7dR4Orc62JiqPDpeoMwnb8eHvjHr6QeQ/7o1iFxUxqxxreEyP+eD
 dKVSHm4JDLW4rKb8++x7jZpfzw0aLutxhTiTSlRjB5UEsBN/v+3i/Xrb5jl1B/9RB/Z0
 sU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784923318; x=1785528118;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rWnTAiXSmPWa5RxmfVberE8PVE3I2Vb9TfspGKFpiJ8=;
 b=qM7KBqrIPJCzroxaujYs43nRnBm9H5siCz8+7xkBdLT7FMnI8MDYS10qym9RAuBjk2
 IayXYsm8aaEoTWa4j5EdGByNi9v3Nd6EcL84h4oNYv0/7OALQCzxHlEIlsdTbxHfGP/Z
 RioxuhicFckzigdsbji8OTW1lfZ0m+vW5Kxbii6M3OTfGfMRnR/pG+L40SC1ZTu1vlDF
 d07vSiGj/1Fr8r5vgql+CfLeV1efqIrIrb0eAYzYdJLnplQ3dF6/LtdWkme097Oxsfgo
 86tjaOuzfxVq+iJ6vZBq2uGV0ClDmvFFKWUHQ6hlSKP4ccUqRdcBPciBL9pLEHk1T+cr
 4D3w==
X-Gm-Message-State: AOJu0Ywxwkae7lOCQVV7fLaMOcqyhBjeNzFI5VSiJH/tbw1XhP7SU6Jf
 //0Dr6hq4nqscfkN15uN3CiAS6IAN55vUrSvD+uGGNJrUBvdmE469+J3tk4awqw6qRy6NiC8dZG
 7eIhc
X-Gm-Gg: AR+sD116mLOROgnKYGehotjrnnWFPaW3I+L8UjLpj7ksaLeE7yu/GYUziZmN8S1Z1z5
 /5qVeWTMgTqrmWfjfOaUltK/CrzvrDxcqSbZ2TpZKFkmpl6N4HFAtwmKta5EqZo95xld8L+lrCU
 TgwiTzY4jTmCdG1orbxYKT67IVQgnadUMDaZ988qctNGuKbJAaXoB3pzMweUPlULSnkvxAv2Uxr
 K6Qq4eUPi8dguXMBLqZDZLnplPCpBrGqWavhHEWlCrRxdS1zapNe5/nfI0cYbNQAD1c2hKDv9gT
 eF236WYKgA7W62WrtP+7A9DEv2Sl4MGJ9nvuYh0Ms+dYCMEYhCaCNPeEW2C3Ijjn9XhR1Pyq9Iz
 Dd32mMxFdhdm/FoM02drRwtntLW19ym8qN6oFdQo4HdNxnvnen9CeKL/Dfgq7Qy43DeBOjLNRVF
 xGNZdSupF0aBst70FzuNs55JnGc/yZD6oY9C9DPLgrcqkA
X-Received: by 2002:a17:90b:48c2:b0:38e:a205:c84b with SMTP id
 98e67ed59e1d1-38ec6660452mr9257544a91.28.1784923317927; 
 Fri, 24 Jul 2026 13:01:57 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f05665ff9sm1260049a91.0.2026.07.24.13.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 13:01:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: yujun <yujun@kylinos.cn>
Subject: [PATCH] tcg/aarch64: Use tgen_brcondi in tcg_out_qemu_ldst_i128
Date: Fri, 24 Jul 2026 13:01:56 -0700
Message-ID: <20260724200156.88695-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Allow tgen_brcondi to choose between TBNZ and TST+B.cond for
implementing a particular mask.

Suggested-by: yujun <yujun@kylinos.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Supercedes: 20260629111602.282742-1-yujun@kylinos.cn
("[PATCH] tcg/aarch64: Use TBNZ for 16-byte alignment check on i128 ld/st")

Let tgen_brcondi do the heavy lifting, rather than open-coding it all.

r~
---
 tcg/aarch64/tcg-target.c.inc | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index cc9c2a5158..1f9678438d 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1889,23 +1889,18 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
     use_pair = h.aa.atom < MO_128 || have_lse2;
 
     if (!use_pair) {
-        tcg_insn_unit *branch = NULL;
+        TCGLabel *label = NULL;
         TCGReg ll, lh, sl, sh;
-
         /*
-         * If we have already checked for 16-byte alignment, that's all
-         * we need. Otherwise we have determined that misaligned atomicity
-         * may be handled with two 8-byte loads.
+         * Check for 16-byte alignment, taking into consideration the
+         * alignment that has already been checked.
          */
-        if (h.aa.align < MO_128) {
-            /*
-             * TODO: align should be MO_64, so we only need test bit 3,
-             * which means we could use TBNZ instead of ANDS+B_C.
-             */
-            tcg_out_logicali(s, Ilogic_imm_ANDSI, 0, TCG_REG_XZR, addr_reg,
-                             15);
-            branch = s->code_ptr;
-            tcg_out_insn(s, bcond_imm, B_C, TCG_COND_NE, 0);
+        int a_mask = 16 - (1 << h.aa.align);
+
+        if (a_mask > 0) {
+            label = gen_new_label();
+            tgen_brcondi(s, TCG_TYPE_I32, TCG_COND_TSTNE,
+                         addr_reg, a_mask, label);
             use_pair = true;
         }
 
@@ -1944,7 +1939,7 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
         if (use_pair) {
             /* "b .+8", branching across the one insn of use_pair. */
             tcg_out_insn(s, branch, B, 2);
-            reloc_pc19(branch, tcg_splitwx_to_rx(s->code_ptr));
+            tcg_out_label(s, label);
         }
     }
 
-- 
2.43.0


