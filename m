Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61783CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwHV-0004Ba-Uj; Tue, 26 Aug 2025 12:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHR-00046s-RI; Tue, 26 Aug 2025 12:12:17 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHN-0007tF-Sa; Tue, 26 Aug 2025 12:12:17 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b49c1c130c9so3169240a12.0; 
 Tue, 26 Aug 2025 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224728; x=1756829528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOVUh0D46rHhwT3Zfqon+1PR3g6RR06iG4YH+XQvtNs=;
 b=NrgIfaeQzQF5v/mp79YY47LOFlllqh1eJK6TldMPhSlpq5ouSvVx132R3+Kv3pfCwS
 quoCQUFl5qkHwAsqUkaW5Wfm6e+IK9rN9LZw+w+Sd1MgZieIdeNJoxqo5fsJIN1zbhM9
 v6eOhgT2jpvxwCPvTpWxI6TYTf0+FmNJio9ewUSsAZCPZw/BmN6H/PPf9I83ITZp8q5V
 CBP1M6lZXtN5pHwqNy2ToeCX3aSwvvOWExE9R12fSGur9YAw46X0wC2NPmoIQzUVIxAh
 dcxADmxfNO2JRjvEuuT68LKpDKsx0Ts2bZK8ZDbBT6hZ6uLNKLWoNFCV6BqpKFDdkdUc
 EoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224728; x=1756829528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lOVUh0D46rHhwT3Zfqon+1PR3g6RR06iG4YH+XQvtNs=;
 b=fJEkkZY18mnHMQJMLprv9mPBao3ZxGOvIy2dbslZpKOjWkN0t1CgWpJIfXIhRxHUSc
 9VqT86v0OpjMutM/ijrEc0gwJWvRvp/NfNZQ+YVE+3+3qK+33n7IM9aWlz8PQJijzOLj
 hE1HgCDkXP4Zxqa2wCdFECregREQyv+9eZg1cV46fcXRKV+9M1oDwZJ18YjnfIe63K8Z
 UVw6uLTFo8Xq/oVRz5poHcGJ9BM9c51Sp5NS9GMX3DFGvJ/2qkyYdTJ8R/uwFN2hVsfV
 baNU1+NwtcwD/pJ0WACsXhvULDS1PfSR6SIz0/jqCuwlMKqZmzjNZdm1CHr4TDwTpPi4
 M8AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL85cZhXtCrOCVzKrV9d5JWsvFPZ2eOzrYppBdEjAaiKR776n7FmsaC9p3EiWaUSMd/IMnqIeH5g==@nongnu.org,
 AJvYcCXdo6VCu3uEJz4HsyVGGURKPOz/KO2x2eHlWnx2nkScs31dpC4nPR8CuWOtiywlLVLdYWJhWxRkq45qgg==@nongnu.org
X-Gm-Message-State: AOJu0YzXGubiPaRcdB8BRqY+bXVxWrd1ETp0Qwm8mfj8mvR9QOSL01ob
 Zy/eD8vvM07HO6JWhKxoVOt96P6x0/J2V0RGr3FYjcapIm6RJ95ZrRpBQWUs/w==
X-Gm-Gg: ASbGncv/0+UoNycnLDro95uAG/9I0EPIYc6mhVKK3gaQhj0a1w3FGHhNwKf2cWn61+h
 8g5x8AztPuYjgdmOZRg92kvLXGTOVbXGvwoEJztKvtRvnSUChFT9h4CHtHWAODe7GuBmg4tLVWN
 6KyviYnz2A0w2sCVLE1Shkyt08eOaHeHaa1eCgkv13J0ExeSjunnhSXhlZY6TBG0IU8m3HFvXQC
 grQ3T6Lg3MvXLmJokSaUszjXfoDF4iZzWu1ZaxLzfuETedkcvYMqD3GFThgejezZrWt6jB+3Iip
 LGt2xhK2zCgDNJaERuG5yt51PyrFrRG1C3MSZ637ldYaqrE589DDCwq5UcGsdUg+QvExSqtbyQq
 HlwFUAFbOsb6gNweq3PK4Yg==
X-Google-Smtp-Source: AGHT+IG30VQ2Iypjlbl5VB3S+KLlzOxk9K0jAxkoNFREO0T2kat02uO9GxBzLdQGijbvhmPHg8z12A==
X-Received: by 2002:a17:90b:4a81:b0:31f:2fed:7867 with SMTP id
 98e67ed59e1d1-32518998362mr19777247a91.34.1756224727812; 
 Tue, 26 Aug 2025 09:12:07 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:12:07 -0700 (PDT)
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
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 10/35] tcg/wasm: Add add/sub/mul instructions
Date: Wed, 27 Aug 2025 01:10:15 +0900
Message-ID: <172f143f9806e41742137d975b2b80eb20f98a53.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52c.google.com
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

The add, sub and mul operations are implemented using the corresponding
instructions in Wasm. TCI instructions are also generated in the same way as
the original TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                | 12 ++++++++++++
 tcg/wasm/tcg-target.c.inc | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

V2:
- This commit generates both Wasm and TCI instrucitons.

diff --git a/tcg/wasm.c b/tcg/wasm.c
index 9f3b1344d6..ba8a89d920 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
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
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index a1757b4db7..d5cf324e7b 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
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


