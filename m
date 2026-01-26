Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26395C88E58
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGtF-0005BE-ML; Mon, 26 Jan 2026 02:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGg2-00038P-9s
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:30 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfr-0004Kq-Hc
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:16 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-823210d1d8eso1136940b3a.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411110; x=1770015910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wyAR69Bcdaoiwt/QbVg4P4PwKbHvN8hOTaOTvBaaj0=;
 b=m/rktlBuYrMjqwiZ2xdutqSryeLsY2RCQVBWSfO9UtsZCu+CHl6+z+yrfKiO2RN6HN
 /2s9GXp+IzFzSe7pQhmnRPoj1Wb8SYnKRv6EOQ58kSiFG8Q1S/rfQqAAeMLkwfflrKS2
 aN4QCJB5BHUs+WkXyAOnzwIx5E7kj9r8zaqxjXO88pnG2pPWMWVIvgR3xi0qPyMGvTnP
 9+EnBnT3CSR4L4BQZO/eBcbSAzFMegGafHvD2ek0QRVKObGPQq3BHWd8bG+ddoBFkC05
 aMgsx6lNcAwVaHVtRjr1q6xpKB09DdboRr8i4WoABRdKa91mCujg7Rv5AkhpTKfo3SFq
 bnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411110; x=1770015910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4wyAR69Bcdaoiwt/QbVg4P4PwKbHvN8hOTaOTvBaaj0=;
 b=Iqm9pXI3owafuGyMrBhEFutgOioSfBzLs4JbJTAPv+YfH4YICPkz2VFL9tgQ2TVZWR
 05AvBbvW93S8QZScnsx39C/JCXXJkNEzHvSn6lFkZNWbBoRE9dpkib/yFeQOFmGwZ88Q
 a/2vghExOyPqmG5gfWyK8IahZjhqdDlGY0elPiQS0CQQ6nSq/euMLGyqtyKkJcI2owA+
 BawUoKpL+mA1QW706Ff0SdM2b1PvmW6i5vBmrudIk8I7d9enUncEupoGxGHyL+mRyrgw
 nTat4d9zf/IDwVLosix1PPJUKQaLhfNg5/FmLOth2tHy52d1QW14E569qev+g/pfxKXp
 wEtQ==
X-Gm-Message-State: AOJu0YxDgm3J/wqt3NmQr0GEQF3xP5nD1aCt57tyg3ZUYTSnsvrGrBTC
 uibyMsP6JlVSXeYreOWonl7xzxrAajgmXyfirUYwWGwMBh+igP8f+k02ONItcwfS
X-Gm-Gg: AZuq6aIfHs4oY5euOKLccqhYmHncwQAVXzfH7Fig7Ax/xXB/8wSvV3xbXaG88+Smu3T
 vlfwHFI4GAytB87IqrTVk+NimE7afV9EC3wf6oyxJ+SMYfPdeVAzoSjKJ0pf2fkquyCGkpyRv+W
 eqiv7k+00OH9+uWnG8bYfgABjzH+r9ylCQsr24OGTfj00CyndgHob2BWeJu1Ekso0hlaCE6YNcx
 B4jMaBdc2KjhTszVXnNY2Y0QAOBVgMYD3YZq0i1ecOzxQdtaXoguAGJC47B58Q2n823Ce72bi7x
 9jfrmQQHDBil4AHylVoo0xK/1JT8qpLrrQrTK6ZWb4PhUHj1eYHT/0ly2Ta06DyAOJ5JiTQYqvz
 DRa/GZlLu4xDPP/imOH5p3bVW7RBcceL7rzy8UDqzS5zV7+rdz7JlLzqHm06tRC3G162Hv4NKLY
 yjtXSpU9Q1JL5tszusjjl3jl1/FhfnK0EXMDQuC6GquwBwQ2Mp6sDP
X-Received: by 2002:a05:6a00:3cce:b0:823:1406:8797 with SMTP id
 d2e1a72fcca58-8234121c8cemr2920028b3a.31.1769411110265; 
 Sun, 25 Jan 2026 23:05:10 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:05:09 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 14/33] tcg/wasm64: Add neg/ctpop instructions
Date: Mon, 26 Jan 2026 07:03:27 +0000
Message-ID: <5011a6543e5e20630673e27b681e6de31e9d28eb.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The neg/ctpop operations are implemented using the corresponding
instructions in Wasm. TCI instructions are also generated in the same way as
the original TCI backend.

The Wasm backend implements only TCG_TARGET_REG_BITS=64 so the ctpop
instruction is generated only for 64bit operations, as declared in
cset_ctpop. Therefore, this commit adds only the 64bit version of ctpop
implementation.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64.c                |  4 ++++
 tcg/wasm64/tcg-target.c.inc | 44 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tcg/wasm64.c b/tcg/wasm64.c
index 8c8dcb81c7..a5e72d8fe5 100644
--- a/tcg/wasm64.c
+++ b/tcg/wasm64.c
@@ -359,6 +359,10 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint32_t)regs[r1] % (uint32_t)regs[r2];
             break;
+        case INDEX_op_ctpop:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = ctpop64(regs[r1]);
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index d4db2528f8..8932330e3a 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -188,6 +188,7 @@ typedef enum {
     OPC_I32_SHR_S = 0x75,
     OPC_I32_SHR_U = 0x76,
 
+    OPC_I64_POPCNT = 0x7b,
     OPC_I64_ADD = 0x7c,
     OPC_I64_SUB = 0x7d,
     OPC_I64_MUL = 0x7e,
@@ -547,6 +548,21 @@ static void tcg_wasm_out_movi(TCGContext *s, TCGType type,
    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
 }
 
+static void tcg_wasm_out_neg(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, 0);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op(s, OPC_I64_SUB);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
+static void tcg_wasm_out_ctpop64(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg));
+    tcg_wasm_out_op(s, OPC_I64_POPCNT);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(ret));
+}
+
 static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1138,6 +1154,34 @@ static const TCGOutOpBinary outop_remu = {
     .out_rrr = tgen_remu,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
+    tcg_wasm_out_neg(s, a0, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, INDEX_op_ctpop, a0, a1);
+    tcg_wasm_out_ctpop64(s, a0, a1);
+}
+
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


