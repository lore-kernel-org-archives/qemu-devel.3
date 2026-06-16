Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF39CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgk-0006K9-Q6; Tue, 16 Jun 2026 06:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgj-0006Em-V5
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:33 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgi-0003BF-0z
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:33 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c8588f8fef3so1564749a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604391; x=1782209191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKjw3Caa8EWbAlus8Dj+hIcL/xWzcqCPd2ngBCbDbuE=;
 b=ohxD/qEExUk97cMN72sCou9nSL6ThdoMNhX8ntJBvLbneP+/cgEhnZ9yo587Z4DcPu
 WkWyao+I2F/kow+fVLaqmISCfA10tvE/KxBbIFmRZ9h8e5m22mUKddcBrTmm6blUM/YQ
 wTZIeC9a9XLCWXboPxpBH+JTxr3oSQ3DVBE02ugpvqxa3nXSvhb42ubvHTZYLDKp1WBS
 imGl56yPCy/8FqhLjjltCP8aCBaGCR2XnnoHaVFSXqi3udaRy6kEYlr/91I6iKB41MRD
 WFqPOkyH+ffBTuvMJGlX+GbflKiOfqxaW7QMYzgJZ/uDg2yBRPkjEo+yMxOdoYgya+n0
 HDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604391; x=1782209191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mKjw3Caa8EWbAlus8Dj+hIcL/xWzcqCPd2ngBCbDbuE=;
 b=c1ucwO4DfM8tdRJLNxhgMvN10w7PyIZXQkTzq4jKThXIeWa/nISrndNRNg1/nVpH4o
 jeWjNdd7phl3eNWdmb4T6p2FECutDCMjKHFSnHHmrbg/3EGsRCaMnBTbd9lgsdpZaWBA
 nNexpf0XkNFb4yW69rxryXact9JzfYrPVNaMNXh2bbJvN6wm7D169R0/l1ZNIXI1Dnsr
 LVn6vzaT5WgAz80WSLjURiI8s16C6OBVIyBEzRh+swCuiPefAueMuiwtSpiB0cZ21JOJ
 UL7J2SnmWN+8LSNEo+dBaVeV2uIULyesSNPTg7CrK4IrKM2/WZoFLEFgeHJoH6ARUiRP
 N+xg==
X-Gm-Message-State: AOJu0YwnlcEN8t1nyNrWhKPhktpUlZ+FDCUrJb3xkLOOZQnuLE7McoZw
 hGiMri7HbDVcbzMj4rPrHec9Od/Y2I83lMVbyMsFNBrX0EemW86x+d0iNH4BJE4h
X-Gm-Gg: Acq92OFzL5pCLzjR4nEcxF5r2hLQnffXdqVqyTm1JWbDxpC7b5a4wtAAaaEItIT6YHz
 OMW5O50IAXvFDoazT+Nuz6Fldhwc9jWtd0IQyUkgHgopFTlmeGmv59fiOs2hRrXfDE37xiknHTo
 2ZjwJbk1Fx3od1DRIBfkoJG9N23ZQv3aXqEvOPqNllvQyFJrZGKAoqQfm4U1X/aycmXndKNrK9z
 B3ktQk1cTc+bsoRb99nokDsDI8K0Dx1UDKJCo4dr9XHMB0py4DiIHgpET3lY0IiyvIW7cVHp+5b
 61CExHCw13mSepR41dOAIXR6TmjTmoUvcnm8ap95p5S5sPaIPcuP5zCmYNi+eANY2StjY0oKUNV
 RvOInFpIMfomOMoM5ZdhM71TE+ypi6OQCiPfnrh2M4A7LZGxZuYPuChdCxF3QXF//FVxGQU1S53
 xxKx+Cq5uuCHs/ydRmi+yemD06uZH8My/aK2mubKM3
X-Received: by 2002:a05:6a20:ce46:b0:3b4:8aad:6337 with SMTP id
 adf61e73a8af0-3b7e49b8c55mr3424674637.15.1781604390684; 
 Tue, 16 Jun 2026 03:06:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/83] target/riscv: Fix size of badaddr and bins
Date: Tue, 16 Jun 2026 20:04:19 +1000
Message-ID: <20260616100527.1939565-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anton Johansson <anjo@rev.ng>

Fix these fields to 64 bits as they cannot be made smaller. Also make
sure stores to these fields from TCG are 64 bits in size to avoid
incorrect values on big endian hosts.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-6-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                             | 4 ++--
 target/riscv/machine.c                         | 2 +-
 target/riscv/translate.c                       | 6 ++++--
 target/riscv/insn_trans/trans_privileged.c.inc | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6692bff456..2cc1b68f34 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -235,8 +235,8 @@ struct CPUArchState {
     uint8_t frm;
     float_status fp_status;
 
-    target_ulong badaddr;
-    target_ulong bins;
+    uint64_t badaddr;
+    uint64_t bins;
 
     target_ulong guest_phys_fault_addr;
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 5c692e0fe6..b7790c14d0 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -457,7 +457,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.load_res, RISCVCPU),
         VMSTATE_UINT64(env.load_val, RISCVCPU),
         VMSTATE_UINT8(env.frm, RISCVCPU),
-        VMSTATE_UINTTL(env.badaddr, RISCVCPU),
+        VMSTATE_UINT64(env.badaddr, RISCVCPU),
         VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
         VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
         VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 7c23996271..1ea7faea4c 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -273,7 +273,7 @@ static void generate_exception(DisasContext *ctx, RISCVException excp)
 
 static void gen_exception_illegal(DisasContext *ctx)
 {
-    tcg_gen_st_i32(tcg_constant_i32(ctx->opcode), tcg_env,
+    tcg_gen_st_i64(tcg_constant_i64(ctx->opcode), tcg_env,
                    offsetof(CPURISCVState, bins));
     if (ctx->virt_inst_excp) {
         generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
@@ -284,7 +284,9 @@ static void gen_exception_illegal(DisasContext *ctx)
 
 static void gen_exception_inst_addr_mis(DisasContext *ctx, TCGv target)
 {
-    tcg_gen_st_tl(target, tcg_env, offsetof(CPURISCVState, badaddr));
+    TCGv_i64 ext = tcg_temp_new_i64();
+    tcg_gen_extu_tl_i64(ext, target);
+    tcg_gen_st_i64(ext, tcg_env, offsetof(CPURISCVState, badaddr));
     generate_exception(ctx, RISCV_EXCP_INST_ADDR_MIS);
 }
 
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..a8eaccef67 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -68,7 +68,7 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
-        tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
+        tcg_gen_st_i64(tcg_constant_i64(ebreak_addr), tcg_env,
                       offsetof(CPURISCVState, badaddr));
         generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
     }
-- 
2.54.0


