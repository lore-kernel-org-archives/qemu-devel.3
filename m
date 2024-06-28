Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156ECC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 18:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFvQ-0004D9-TX; Fri, 28 Jun 2024 14:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sNFvN-0004A9-CC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:02:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sNFvG-0001yN-Ss
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:02:16 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7067a2e9607so774114b3a.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719597729; x=1720202529;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6sXjClItUxAXVfz2ZiNHNCRQGNFtkjV4JIRz09fn8z8=;
 b=fNxJkTY9hVOAxFKAxAkhzojTjmJ6p7wJp8uMu/1uuKPzumYF4B8u4y4emu89pNozQE
 XHsOkupF8CmaSTfHCl/9Zhg9F66msAwd4ghXBCLlpv1TmcwQIjEYQqxXTwWusZJEyuI4
 bwI5zJ4dBWefWyvtFMDcrBE8+kzqG49ZdJMmF9tcxuPfK0hCiSI4Gw+PZvMEyGzV++jU
 7L4Xhr6uBULwFLBwsUO6f7glXEftF8VtbHJ/gsBCaNJJacS78VUj3FJjLPP7k681zv/y
 WM7LHihYzq4B6NdkuM1d8XqL4mB+Yy2qFauBRAeny58Ed78wSdGV77GqBrfwmmeW4EAM
 gugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719597729; x=1720202529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6sXjClItUxAXVfz2ZiNHNCRQGNFtkjV4JIRz09fn8z8=;
 b=HzPXvottVshT3wjf/MWG3JPXL9rXPn9lpWraUYt3Do4s0/bmjOF4uDOHlb5w5tLc+l
 CBUoiuRZBvk4I+UmR9BVhTTkGuEkUEqjEWWb+D4cre+4dVNboTqG29AxnCv2nYVeaUgX
 tc7p/IRHs+hysQJffdbItyW2+8PNpnsci+wbV8XhVWvIDv7ZbSd2spRj82MfrBzxu7/f
 42ry1IxIKtiPGMo6dmMAAOiGYR1hNY3alod7vLYX0wyVXNzg7yghJhdbUrz7kxZ0cd+t
 99ICfC2mz8qFTAUXJYz1x8+mQtxb5uZSBF6CXlPCUYuzi2VRq9r/8UEQ/qcc3Zcc9oAn
 zYVg==
X-Gm-Message-State: AOJu0YxhNVX3DDL8rs6Pz5WdrThzDfS01MNoq+zI7EgY3D6LO2Ym0bRx
 jwv7L5fYOuUMbLiiXbI4ZcgNQU6KAKZxaGZhWs/pPtroEX19vFvgKFYAMyPpbsH2HTwOzydS8nA
 q
X-Google-Smtp-Source: AGHT+IF86C6t2Acs/PeklWQKlCcbrI50nIgtbtfojCPJ0sBO2z96TZ+bHKZRZXjAGIlajMCPhET2eg==
X-Received: by 2002:a05:6a00:1750:b0:704:3aca:7845 with SMTP id
 d2e1a72fcca58-70670ffabb7mr16897133b3a.22.1719597729259; 
 Fri, 28 Jun 2024 11:02:09 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70842036d13sm1752053b3a.98.2024.06.28.11.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 11:02:08 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Deepak Gupta <debug@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH 3/3] target/riscv: Introduce `compressed zimop` aka `zcmop`
Date: Fri, 28 Jun 2024 11:01:54 -0700
Message-Id: <20240628180154.597919-3-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628180154.597919-1-debug@rivosinc.com>
References: <qemu-riscv@nongnu.org>
 <20240628180154.597919-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Analogous to zimop, there are 8 encodings carved out of illegal space
encodings (c.lui xn, 0) in compressed instructions which are defined
to be zcmops short for compressed may be operations.

Unlike zimops (which write 0 to rd), zcmops don't actually write anything
to any register. Their encodings allow future extensions to define them to
read register x[n].

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/insn16.decode                 |  6 ++++++
 target/riscv/insn_trans/trans_zimops.c.inc | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index b96c534e73..d24b54d319 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -32,6 +32,7 @@
 %uimm_cl_w     5:1 10:3 6:1       !function=ex_shift_2
 %imm_cb        12:s1 5:2 2:1 10:2 3:2 !function=ex_shift_1
 %imm_cj        12:s1 8:1 9:2 6:1 7:1 2:1 11:1 3:3 !function=ex_shift_1
+%zcmop_n       8:3
 
 %shlimm_6bit  12:1 2:5               !function=ex_rvc_shiftli
 %shrimm_6bit  12:1 2:5               !function=ex_rvc_shiftri
@@ -66,6 +67,8 @@
 &cmpp      urlist spimm
 &cmjt      index
 
+&cmop      zcmop_n
+
 # Formats 16:
 @cr        ....  ..... .....  .. &r      rs2=%rs2_5       rs1=%rd     %rd
 @ci        ... . ..... .....  .. &i      imm=%imm_ci      rs1=%rd     %rd
@@ -109,6 +112,8 @@
 @cm_mv        ... ...  ... .. ... ..  &r2_s  rs2=%r2s     rs1=%r1s
 @cm_jt        ... ...  ........   ..  &cmjt  %index
 
+@c_mop        ... . .....  ..... ..  &cmop %zcmop_n
+
 # *** RV32/64C Standard Extension (Quadrant 0) ***
 {
   # Opcode of all zeros is illegal; rd != 0, nzuimm == 0 is reserved.
@@ -140,6 +145,7 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  zcmops          011 0  0...1  00000 01 @c_mop # zcmop carving out of illegal c.lui xn,0 space
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
   lui             011 .  .....  ..... 01 @c_lui
diff --git a/target/riscv/insn_trans/trans_zimops.c.inc b/target/riscv/insn_trans/trans_zimops.c.inc
index b5ad7bded8..99f25bd9ea 100644
--- a/target/riscv/insn_trans/trans_zimops.c.inc
+++ b/target/riscv/insn_trans/trans_zimops.c.inc
@@ -48,3 +48,14 @@ static bool trans_zimops_rr(DisasContext *ctx, arg_zimops_r * a)
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
+
+static bool trans_zcmops(DisasContext *ctx, arg_zcmops * a)
+{
+    /* zimops not implemented, return false */
+    if (!ctx->cfg_ptr->ext_zimops) {
+        gen_exception_illegal(ctx);
+        return false;
+    }
+
+    return true;
+}
-- 
2.34.1


