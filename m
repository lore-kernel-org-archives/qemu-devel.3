Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A642EC982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 20:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7euV-0006mp-Bb; Fri, 18 Sep 2026 16:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7euT-0006mX-Eq
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 16:10:13 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7euR-0007JM-Ol
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 16:10:13 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2dd58e1e2c7so10433745ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789762210; x=1790367010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e34xaj9M9bKrMNG5pO6cR3sSpfMyEJVx/pIpCNss6As=;
 b=jGwYN19cs8ATzS8Q629RX8A0owoSC1GLKZ96fbzNNt38XvicxP8naLpmNgNW/gsHuU
 xVZvtIVOH2Psm0Spaqrjtrh2Ia0tl9Xl1Pvao7BiUxCZAlFE3/XoZ12C0kHYTnR+pkCC
 EwcRMD8a3TWVGHGcOSA12XPOC3zqVZcx0Rv2rLQdqASgIgxc4/RWPFD+6KyxscE7kpyI
 hWMXoNbjEvTonpHHywiCQ/q5MFwwgD++tMVEGPqDXwOH8EiPDAslgIFB4AoHGUekzai/
 ehoAut8by7PIbdQZ/T9xhRB0/nbHEZ3ZyUqPfL0E8KwoUTsT1hLZyRxUdEq9I9mU9Yw1
 NZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789762210; x=1790367010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e34xaj9M9bKrMNG5pO6cR3sSpfMyEJVx/pIpCNss6As=;
 b=soOXx+FQiLYJE53m/cotMgEKU8p8uq2htBFtlrnH6jSkDZiNpx9E1/01pVHTRBQO1g
 JV72MfWEBD9aaDewQqznF7XGqgUoUB9JuLFXFnV0Dzv6J61DSR4Khdr/XOcsQ3Mrc/sv
 n7wCHAWUEwpV5rz9f066NB/u35+oY2gsBonUEEN17HEluVcT4cwzNSn0KdwzAMXV0K3N
 mcaffsSv/G2FyhwCuvOxL9UlQTDxnyi3vzUxPzIy02msKvmdey41wjQAquCx22vHkEks
 MrWiOhJm1JnNiijWgNlnlSeTJ8TsAH2sEk4ls2ZxBkXEPKorL9v+XyWF/cXVjmDuLzjL
 w48A==
X-Gm-Message-State: AFuF++n/uVdd9nv41jRE+7Cq/Jik8DHVEsOBqh0ufLBhjtWaRd2VosaF
 Gg+G5lhhOcsnFVgWEV9xwN8U2cRrq0tt65xtuA/d4uXrKXjd2eQaOKLn4BlvyUrgRkXNllf7ENx
 opn8Be24=
X-Gm-Gg: AYBFou1l3MjfJqfSTbpbJU3rsLfUVbITuF//EezEI72oXMHUW8FbG1iWjPppr18YVV1
 L1MpNEuP8SN7Qv8I58mXsZwfcnASoafMlAYbUB2vF8YZ4sZ51VtQQ1wYuEIKFg7lE2Adk6uWzkV
 6+oOVH+DBgUliR/J/4AMlkJTScfTU4vmbYxZnTXSeYhka7bzgBQjbWwXe7rSkE13YJVsLun1GYK
 wFjPxiHQYkiwpI1y1s4F1cWbL25pSgHC31ev9IBqgrpK1kr7H0rOmZ8LtzcWMWkKCiCmh6RWHI4
 lFNhKNRnOT5MvekjEmGA1J00UC+cS8cIFRgW6ahyMpV0HDUnt9TaYfX/5zZYjGgWsJF3ogErXXT
 VTHOFMGy1FgLBLJN6gu91Lx6I4R7vD1TtVXNIX1eOv9hfhgkYtda2Cfd+/ji/8WcvQ/cCuuhVc3
 mhL3j1VgvlO6q+gXqJMw1KEEGpxENLRtjZb5N9qpvY15B5BqFVMu/A6BNfVuRMFDXY/LMHj4JTE
 LsEgGY=
X-Received: by 2002:a17:90b:3fcc:b0:39b:92bb:9eef with SMTP id
 98e67ed59e1d1-39e54c9c4f0mr8185339a91.22.1789762209792; 
 Fri, 18 Sep 2026 13:10:09 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:317e:3514:d7db:974c])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c32da4960sm1094723eec.0.2026.09.18.13.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 13:10:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Max Chou <max.chou@sifive.com>
Subject: [PATCH] tcg/riscv64: Set vtype before whole-register vector loads
Date: Fri, 18 Sep 2026 10:10:07 -1000
Message-ID: <20260918201007.153384-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

With vtype uninitialized, VILL might be set, leading to SIGILL.
Also, assert vtype initialized for whole-register stores and moves.

Cc: Palmer Dabbelt <palmer@dabbelt.com>
Reported-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 2ce9d47a633..de9a3570b23 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -775,6 +775,7 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
+        tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
         {
             int lmul = type - riscv_lg2_vlenb;
             int nf = 1 << MAX(lmul, 0);
@@ -1014,6 +1015,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
             unsigned idx = type - riscv_lg2_vlenb;
 
             tcg_debug_assert(idx < ARRAY_SIZE(whole_reg_ld));
+            /* We must initialize vtype to something to avoid VILL. */
+            if (s->riscv_cur_type == TCG_TYPE_COUNT) {
+                set_vtype(s, type, MO_8);
+            }
             insn = whole_reg_ld[idx];
         } else {
             static const RISCVInsn unit_stride_ld[] = {
@@ -1046,6 +1051,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
+        tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
         if (type >= riscv_lg2_vlenb) {
             static const RISCVInsn whole_reg_st[] = {
                 OPC_VS1R_V, OPC_VS2R_V, OPC_VS4R_V, OPC_VS8R_V
-- 
2.53.0


