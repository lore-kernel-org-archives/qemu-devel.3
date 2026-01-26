Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D234BC88E5A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGma-00061g-HP; Mon, 26 Jan 2026 02:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeM-0002kw-Sf
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:05 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeL-00046i-5D
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:04:38 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-81db1530173so2136075b3a.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411075; x=1770015875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2iLebfIJhQmyKZPxD/7vvE0TY7hMO11zANvgz7Zbqg=;
 b=JmemzOPjEZKlW/JDaC+SjnSpSwwma4vfo0PrAuStAPCAO6trB2l8Gh3NzZuvqnp7MK
 aBCtEHSLQaUSUQ4lCYn52pnv9GWRKrKKOJL2I1uZYgUAGpIzaONppek7ukUn7jvWEz+4
 ao5O1jZYxlRDD7Vw78qRmmlkmbW4qF8blwpPZlhogI+gGJswfKFqYsn/H3JvLKPFD8E6
 mO44JKWSpEpDIYTSG7d0IPZQhKtsUxWx/IKuftr/VuID/cjOVK72hCKoJ5WDinn1LcNt
 bZrS/KqIKmNXrjTKniJ42m0kgHsZM6xwwd7Kzaq0rUDn6QnLb9LDx8Awij5J4NuMSRRk
 gPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411075; x=1770015875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V2iLebfIJhQmyKZPxD/7vvE0TY7hMO11zANvgz7Zbqg=;
 b=wGAJ5h+5PdxHw1cCP9XJHZXzy+9WWn8+N6C+dBHfUbHHhjbnyOENvtSdpjjHhldx/Z
 mFSE7+rQ2KBwZQZjaC2ypv50+l6zWNMVEHOTUWd+YbW9Qoeu68hdUvgVyPjzq2Y52WW6
 DIQRME0F3V4JNksCi8GaXu8l9pxtMcRmVCg6JXD22krASFYDaq1mG7k+pFt62xnYy6SC
 XppHaicmvrw1/gdkeEUMbZVSNA61IlTfxTopDmdswoGHtclwtULGth0TxDuBNL2iNX9J
 Ad9V/mSs7XeIIgLWULQnDNZgZ019BKYvsRN7tsYcmO7R7JvoAoElo47+/EtFWU9LG5Ge
 X07Q==
X-Gm-Message-State: AOJu0YytoE77bqUCHah2CDneai650zrIOXe0qB2XrFgOwd/0UiQi4ge5
 sZlAkKlPoI/SD5eGqLogsEJWZ1oFBiQxXHfSAnCdIPuScXtC/LG4OwXOpVIGctKx
X-Gm-Gg: AZuq6aIPISap0J44ic3wLywm1Wd8YyBo16bAOYsUo80yA9IjVMrQwWrAdi0iRWcIW+W
 qhlLNq4m2zVYgkJsOCBVD3QuPl3BtcGlrXPve7yg/Qp3j7SStDaTXEaLRXXh0SgFcPH+tNz6M/Y
 YAtytT9uGJwKOeIwKN9YvBQSo3AMisc1XN/4KyswH6z7hvgIZb+2yGzvd3MQY3ONlZTcC5t8UcT
 sWXg/0ZvnVSahIeac98loblniMWQTsM/6vPIxcfKSEVzagch226ol8M0m0XHopqWPbQbt49vN1k
 xWAYo678OXBo2ZC0gWxE6J9HTl4HIC6c+/Khxm6J1bHGnYtpsPM68k6+QZ87SdO3GxaLVCg28mA
 lhpfPR9q2xwiYrBUDYIc2znOvaJsSCSWGHDQuLkaDnGJHcogNBeph6rmbTXhOoLXITy7G4hosEt
 QcNJYELkM3T+Wc8JO3sv8T7/XoIZgp9fIQZjQ4j6I/1g==
X-Received: by 2002:a05:6a00:1813:b0:81f:3cd5:2069 with SMTP id
 d2e1a72fcca58-8234119f8edmr3207365b3a.4.1769411074579; 
 Sun, 25 Jan 2026 23:04:34 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:04:34 -0800 (PST)
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
Subject: [PATCH v4 06/33] tcg/wasm64: Add add/sub/mul instructions
Date: Mon, 26 Jan 2026 07:03:19 +0000
Message-ID: <96df2d2b5ca095dfbc280ee73bf8f82f5ae4c770.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42a.google.com
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

The add, sub and mul operations are implemented using the corresponding
instructions in Wasm. TCI instructions are also generated in the same way as
the original TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64.c                | 12 ++++++++++++
 tcg/wasm64/tcg-target.c.inc | 39 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tcg/wasm64.c b/tcg/wasm64.c
index 9f3b1344d6..ba8a89d920 100644
--- a/tcg/wasm64.c
+++ b/tcg/wasm64.c
@@ -59,6 +59,18 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ^ regs[r2];
             break;
+        case INDEX_op_add:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] + regs[r2];
+            break;
+        case INDEX_op_sub:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] - regs[r2];
+            break;
+        case INDEX_op_mul:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] * regs[r2];
+            break;
         default:
             g_assert_not_reached();
         }
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index a1757b4db7..d5cf324e7b 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -140,6 +140,9 @@ typedef enum {
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
 
+    OPC_I64_ADD = 0x7c,
+    OPC_I64_SUB = 0x7d,
+    OPC_I64_MUL = 0x7e,
     OPC_I64_AND = 0x83,
     OPC_I64_OR = 0x84,
     OPC_I64_XOR = 0x85,
@@ -265,6 +268,42 @@ static const TCGOutOpBinary outop_xor = {
     .out_rrr = tgen_xor,
 };
 
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_add, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_ADD, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_add,
+};
+
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_sub, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_SUB, a0, a1, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_mul, a0, a1, a2);
+    tcg_wasm_out_o1_i2(s, OPC_I64_MUL, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mul,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


