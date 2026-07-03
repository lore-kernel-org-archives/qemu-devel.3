Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A71C44501
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcRM-0006Ih-HI; Fri, 03 Jul 2026 07:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phuong.lamthanhthao@gmail.com>)
 id 1wfXkq-0002lA-1h
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 02:52:04 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phuong.lamthanhthao@gmail.com>)
 id 1wfXko-0005Uf-9D
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 02:52:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2caced6038eso2773755ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 23:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783061520; x=1783666320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M8kLYSgktLJ3ie5On1W2+Zuae5nVZDma9beK+vOmmMY=;
 b=RtY89xx/qtmVb64ee6SnMrs8loagBaWW4VsgJ7gErNImUTMufF/kWk/f8qyfK0fVlg
 k2BK+JAoli2oUCtkUbAgi556CLinkiWksaHjezVfhu/cOB+mcs9Zwyag70DHLxOtYJ2B
 IxxS8r4lHqeUQwqmNSzjWBVXTkvdcZ+lEp9tCFXj+uybD1AxiA1/qqp/IMJmW6Tkwf85
 Cg09mx7tTPtM0jl+6SnG+Oor3pXMYBlRiq5WP9UHlQFV+HCaiCkIxkRKysIYe+Qoy5gb
 ERHW8UyHNTXGoNSwJ8rOjcrWC7+zklvWqSNzKrVVHuMtSVTxfA+eZcoR5lnkP5f+gkxo
 qWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783061520; x=1783666320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8kLYSgktLJ3ie5On1W2+Zuae5nVZDma9beK+vOmmMY=;
 b=QO1NsJshQ+RGTGmL29zowNuAO+f7XjquapEPvT1rZ+H4SGTThs1PyllXVmZyBDfcLD
 b+p1VvCbwDixv3xHFFfpt54dpb0KhimqmmrubN4eUQW2X5FMUAcNbkL6q8YF4CNFv6El
 PcByvAdBd1xCAOFq6g+B/HnB2I7BlBo8OGWAylrTOgP5bXDF0pDKuAE/RZ6sWH9PQJQ0
 kXBzdvY4lgKo4cbfT3QIOVVsuTLdn/GNtlXY9ke0qgrQ48F7WhCjfQUvleGXekwHSZSR
 D9dIPvqK6UhQJdUNyeQ35vF8WLJ+EMMAmY2mORcz+SYmOH987ebAB91JouLaQJQlaLB4
 4F2Q==
X-Gm-Message-State: AOJu0YyW/V/NyOMG2CfQChUiEXPSvn5hvSySusDoKFC4VW2zp9uAQoBl
 j48Mge40V2clbQ85+OAYqCN07H4Hp6dO0oC5nUWkS1XC0iBeQyNDLe9AjMMhkfSK
X-Gm-Gg: AfdE7cl3dBtX+F2i0Yk0UIBdLkNXPHIC9oSkhRCJAZOLlTVhxfw1iDZnTwOPOfFcuq0
 7ITb+SeK3egp3P+3hFx+UNGAyxFo4qrGVqix6I14083EyZREEUZ8hLi8ipkduDrrznhF7HzY6eV
 NbL9fCN66Ou9rMi6LjmrsPMNZt2hJUWafqzBrGSl0Q3Y6dxsJL0K7Yrd/em+xF1RZRSqPuUMo+s
 UWk41GCCd3VQVVyPg/lRnF/LrcWX2uk3qeMGWEzJR/Bbw0oeBFlxOUbiIpl/x7WLMElXvY8Gi3N
 Vd/Ml1askq1BEYRkpryqgXfiREU4Zx685orYU0Jg7mWKJlh3FKS3SuUa4NQ7UF+fmipLpaNstwV
 xca9MdgMSlwnImk0ZGXiZy01/PFAoSGLoXvs0oh7FtrXopcPOXZeO15on9azNJrMwuJYnt5CDYx
 W/9eo+a9P1paeHQjuUeFU1qI8Vrd4SLjmh9Rpu
X-Received: by 2002:a17:903:1b4f:b0:2c8:5de:a84e with SMTP id
 d9443c01a7336-2cacacc0634mr31964135ad.10.1783061520432; 
 Thu, 02 Jul 2026 23:52:00 -0700 (PDT)
Received: from localhost.localdomain ([171.243.49.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3ececfe4sm17238693c88.8.2026.07.02.23.51.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jul 2026 23:52:00 -0700 (PDT)
From: Danielle Lam <phuong.lamthanhthao@gmail.com>
X-Google-Original-From: Danielle Lam <danlam@g.hmc.edu>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, Danielle Lam <danlam@g.hmc.edu>
Subject: [PATCH] target/riscv: fix amocas with rd = x0 followed by beq
 involving x0 is not taken when it should be
Date: Fri,  3 Jul 2026 13:51:52 +0700
Message-ID: <20260703065152.23024-1-danlam@g.hmc.edu>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=phuong.lamthanhthao@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:52:12 -0400
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

amocas.{w,d,q,b,h} implement compare and swap by reusing rd current value as both comparator input and as the output that tcg_gen_atomic_cmpxchg_* writes the old memory into. Before the fix, ret == cmpv and we name that variable dest. When rd = x0, dest was ctx->zero. Then since ret == cmpv in the first place, the atomic op overwrites ret with ctx->zero which is not the same zero value. Any later instructions that refer back to ret for the initial zero value which is now changed, resulting in 0xbaaaaaad00000000.

The fix is to use different variables for ret and cmpv and assign that to atomic op to run.

**TESTING**
gen_cmpxchg
.d was tested and it passed. .w/.b/.h use the same logic so the fix was similar.

gen_cmpxchg64
.d was not tested

trans_amocas_q
.q had its own custom test: test_amocasq.S

.section .text
.globl _start
_start:
    la      t0, scratch
    li      t1, 0x1111
    li      t2, 0x2222
    sd      t1, 0(t0)
    sd      t2, 8(t0)

    li      a0, 0x3333
    li      a1, 0x4444
    amocas.q x0, a0, (t0)

    addi    a2, x0, 0

spin:
    j       spin

.section .bss
.align 4
scratch:
    .space 16

Then searching the trace log:
grep -n "x12/a2" amocasq-test.trace.log

I found that all matches read zero.
10612696: x12/a2   0 x13/a3   0 x14/a4   0 x15/a5   0
...
10613892: x12/a2   0 x13/a3   0 x14/a4   0 x15/a5   0

Run against the unpatched code, a2 read back as 0x2222. This confirms the test run as intended and the fix works.

Signed-off-by: Danielle Lam <danlam@g.hmc.edu>
---
 target/riscv/insn_trans/trans_rvzacas.c.inc | 13 ++++++++-----
 target/riscv/translate.c                    |  5 +++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
index 79bca1e957..867f5e5ade 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -72,13 +72,14 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
         return false;
     }
 
-    TCGv_i64 dest = get_gpr_pair(ctx, a->rd);
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
+    TCGv_i64 cmpv = get_gpr_pair(ctx, a->rd);
+    TCGv_i64 dest = tcg_temp_new_i64();
 
     mop |= ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
+    tcg_gen_atomic_cmpxchg_i64(dest, src1, cmpv, src2, ctx->mem_idx, mop);
 
     gen_set_gpr_pair(ctx, a->rd, dest);
     return true;
@@ -117,13 +118,15 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
     TCGv_i128 src2 = tcg_temp_new_i128();
     TCGv_i64 src2l = get_gpr(ctx, a->rs2, EXT_NONE);
     TCGv_i64 src2h = get_gpr(ctx, a->rs2 == 0 ? 0 : a->rs2 + 1, EXT_NONE);
-    TCGv_i64 destl = get_gpr(ctx, a->rd, EXT_NONE);
-    TCGv_i64 desth = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
+    TCGv_i64 cmpl = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGv_i64 cmph = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
+    TCGv_i64 destl = tcg_temp_new_i64();
+    TCGv_i64 desth = tcg_temp_new_i64();
     MemOp memop = MO_ALIGN | MO_UO;
 
     memop |= ctx->mo_endianness;
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
-    tcg_gen_concat_i64_i128(dest, destl, desth);
+    tcg_gen_concat_i64_i128(dest, cmpl, cmph);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx, memop);
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9684dbe752..62a9af9b56 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1166,13 +1166,14 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
 
 static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
-    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv cmpv = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGv dest = dest_gpr(ctx, a->rd);
 
     mop |= ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
+    tcg_gen_atomic_cmpxchg_tl(dest, src1, cmpv, src2, ctx->mem_idx, mop);
 
     gen_set_gpr(ctx, a->rd, dest);
     return true;
-- 
2.47.3


