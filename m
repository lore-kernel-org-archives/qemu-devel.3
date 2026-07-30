Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112E0C5516E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpVMV-0003u2-LW; Thu, 30 Jul 2026 14:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahshehab24@gmail.com>)
 id 1wpVMU-0003ts-6Y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 14:20:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahshehab24@gmail.com>)
 id 1wpVMS-0000Sl-EB
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 14:20:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-495590dde14so860965e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785435602; x=1786040402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZXZbQkwGxp+BHj+7kwSHsDy70ht4F/3kkqUFKGYMUBg=;
 b=U72OCXyf67t7JfRV8AbRkJXYlsdykn0zqpftJVV2BHcSWMChPtYJZ+ZtIRyuSuK1Pu
 j5c3TD06fadxvDCjlW+AsbTzC9VF5A2U8zMmrJ45crKuRWjgnhW7xTdLBltqgr2JZj7y
 udnt5Hpthc6I5vfEGPt2tvvfOLhcfb8KaW2DdeqEWgQUSd5cOfLoaUQjwejB5BkC+Net
 83JC5lRkKpd/V7UHzQYQeHyY5nAW/u5EonwbHzk2Pj8nD/Yf8xUvfa9EF929WDHHNBjp
 dmK0u+Xsxb4auAregukvkwnShSE39EmsZqOw0ICsExfnA2/7dloXyH6J17rA/Gbr6LGP
 hIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785435602; x=1786040402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZXZbQkwGxp+BHj+7kwSHsDy70ht4F/3kkqUFKGYMUBg=;
 b=Uu5nkmWsudbidLfgKWxcRVYruPBh971o9TT4Kp6wVUM28MA+GDZWP2ulET98/PN2Vi
 UzbXFIHhyOGZGVrZMMucz0ajW4AHU9NHk3jbLlqQQoKdseRxUSg/MGhgCK6X2t3bZHXJ
 8YfxdCGptZEwb6ZQjzcnDLXICGNPuTQe/UNigTx9p8aLOGHktfoCbFA66SyXl4onmsll
 DG6DsylM6c7eD4XGSiDloFYKsfqMCxpXQ1wveVuV0tpaPMSzM1YiFa9D2kuQAs4tCZ9g
 hKZKFY0xq62iY/KhGO98yYOk6P6UXM8FjyAC0rAtq9JMk99zMZwKaLwHIi296mu/d4SA
 f4Qw==
X-Gm-Message-State: AOJu0Yx0tf9v+mYVHyVtgoSkIJV3/glhzPRyRCfTwL1g0pMJ2dXUn7gw
 gwD/8TpwVlzqfp9WknwSIWZdhVc9EZHpChAzS3BzbwYXXScdIt9nlYQBzSM88NQ81wY=
X-Gm-Gg: AR+sD127poxhvjD9KnB1Yw2y+3mEbyyfqA3N+DNiDFed2u73nG/bUoxvLuvTRu68vcg
 YFU9YY3Yfiswp2QsloPTjhXuezmRbP+RxiITsFW6ilPNLDhaZztU4ygW70OS8PsseBZ+12hS2O9
 LVMqvBTIwYJVO41EFdM+27J84B7PXI9rCRuGf9GtDWQ9x7SHrQKgRwHNf4+c+S1e1q3Z3OW4bnM
 pOaXb1pyr6D+bEl3j+XPrOjK0bAfVUmTz4bqsqM0StVWvcWZj3oIjLbXErdliQqOj4tNZsLHTET
 5BfZE4nm07jtURc3DPKQ+Z2LCDrSbM8+NEw1XeaqMYnShKoVsmQcVF9AvEX4jzYYvLGpatlYHZF
 pbQP/RHmy7lDsl+YIe7BVFaYWL1NdONEfjFUSJ/dKMzXu9hU6m22UP8B+Rsmx6mvg0fVm7+tChX
 Xs2Ld0qdYKHU+UtHjkisBwZl/ejaQ8U1tM2VXiwcrfmIp4AbfISBvW/nuDyrMkHuF762k4Gcwt/
 qUuHJosQIs=
X-Received: by 2002:a05:600c:8484:b0:492:45a0:dcef with SMTP id
 5b1f17b1804b1-49804c154d7mr23109405e9.5.1785435602219; 
 Thu, 30 Jul 2026 11:20:02 -0700 (PDT)
Received: from 5520-BMRXQ93.eg.si-vision.com ([102.186.12.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980562b4c7sm4387355e9.0.2026.07.30.11.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:20:01 -0700 (PDT)
From: A-Shehab <ahshehab24@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, A-Shehab <ahshehab24@gmail.com>
Subject: [PATCH] target/riscv: Fix PC sync in trans_sspopchk for CFI exception
 handling
Date: Thu, 30 Jul 2026 21:18:52 +0300
Message-ID: <20260730181852.1622-1-ahshehab24@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=ahshehab24@gmail.com; helo=mail-wm1-x335.google.com
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

From: Max Chou <max.chou@sifive.com>

Move gen_update_pc call before conditional logic to ensure consistent
PC state regardless of execution path.

Previously, the host instructions generated to update the cpu_pc were
only executed in the failure path when shadow stack validation failed.
This created inconsistent PC synchronization.

This inconsistency caused issues in CF_PCREL mode where subsequent
instructions calculated wrong relative offsets from stale pc_save
values, and could lead to incorrect exception return addresses.

This fix ensures PC is always synchronized before any helper that
might raise an exception, maintaining consistent translator state
across all execution paths.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4118
Signed-off-by: Max Chou <max.chou@sifive.com>
[ahshehab: rebased on current master; file moved to
 target/riscv/tcg/insn_trans/ and the ssp load is now 64-bit wide]
Tested-by: A-Shehab <ahshehab24@gmail.com>
Signed-off-by: A-Shehab <ahshehab24@gmail.com>
---
This is a repost of Max Chou's patch from 2025-11-05 [1], which did not
receive any review. Rebased onto current master: the file moved to
target/riscv/tcg/insn_trans/ and the ssp load is now a 64-bit load, so
the original patch no longer applies.

I opened a GitLab issue (#4118) with a minimal, self-contained bare-metal
reproducer for this bug. It runs an sspopchk that matches the shadow stack
(the common case) followed by an auipc in the same translation block; on
current master the auipc returns an address 4 bytes too low (exit 42) and
with this patch it is correct (exit 0). The reproducer is included in the
issue.

[1] https://lore.kernel.org/qemu-devel/20251105134331.2865581-1-max.chou@sifive.com/

 target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
index a813232887..d47a9f9c7d 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
@@ -32,6 +32,7 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     TCGLabel *skip = gen_new_label();
     uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
     TCGv data = tcg_temp_new();
+    gen_update_pc(ctx, 0);
     TCGv_i64 wide_addr = tcg_temp_new_i64();
     tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
     tcg_gen_trunc_i64_tl(addr, wide_addr);
@@ -42,7 +43,6 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
     tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
                     tcg_env, offsetof(CPURISCVState, sw_check_code));
-    gen_update_pc(ctx, 0);
     gen_helper_raise_exception(tcg_env,
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
-- 
2.53.0


