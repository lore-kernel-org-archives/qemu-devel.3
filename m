Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD9CCA0FF7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwI7-0004Ww-2s; Tue, 26 Aug 2025 12:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHz-0004TT-1o; Tue, 26 Aug 2025 12:12:51 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwHv-00082K-W5; Tue, 26 Aug 2025 12:12:50 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-32326e202e0so5162326a91.2; 
 Tue, 26 Aug 2025 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224763; x=1756829563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nm2A0UCm82wTM1srjuuFPas3wL5mUjhCQF6/AThUYrQ=;
 b=bGcn+Rmu0+hkUVqfivaS8TBVFHOXXBNstDu6+AaEEAJgHjwbJdxAcUG7oThMM6Ympj
 ZcJIjxKAisAiOzB1MZwt/N2F3viwcBJRKP5rheo3YgLqK5ggNqlQKWU/V4rjSaf3Y8Ld
 5Ty23t9Hjkd5Lul881HM/WvQgfXfVHD+SfeBJ6aod2jiubrjY4VZioclPpulcjbOJJ/a
 kGxT0cA8vrRVA6X7wsoHfUTGn99c6cXIJFmbRbz8wJF55HoByf+EGzMXghnP40Yf6nPw
 W7ph1JP1I0ueL3GEedIiL5UaXORuds50L5bw2IfmwhA1eerPpQkkh89sQOkeMosGw7YJ
 GPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224763; x=1756829563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nm2A0UCm82wTM1srjuuFPas3wL5mUjhCQF6/AThUYrQ=;
 b=JT4LwwIu0VhNWvEh9SPA+JXwND6bIwzUDEVzm2rh4rIV5IRQ8IidAx4OOi7bZCmIuY
 pF/Sqw6Xd+Z75DXdUPiJiaPNiHehd5cyAAc4iU+vr25x8ZnrWf4Hzf1x5E7QtL3jIWxa
 Vzt54tF2soPu1CJe/ai3DfSkFjTW+OjWGhe6pfN8FvgMoHUV4QZevOAAdicjOEGpZ6Kz
 KPi1ts1BvYaSajyzhLPw6zEsLTtcocSe/tGeJqYpSZ/fV2O+e/WDRrBLP40KmXUMvRKU
 T3jP2KxN8/LNytT1oG1rpqlpAC2o7hUqqMlCdEMFsaKQQ50Jo/04fHlxtzc8bRM9jyHx
 qQiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSyOiQMY6qln08Okz8HPDIwAiKSXi5CvQY2qnM6GeA9ieFKSTC1dIWaLNiAfrTcelA+A9pxB/ozfQhjA==@nongnu.org,
 AJvYcCVZAyHtiHLtH7jp8PdlRL0oAxIivy4SkCOP0fPRKWVsg3TKGolm3MKDXwEp6B6vIRdXshpM+ZAXSw==@nongnu.org
X-Gm-Message-State: AOJu0YzOeLJRUwfxVx/q2IN894+tWL7qDW87L3Aju1AeznPVaxWmvfOz
 KC7qf5bWRx6wja9Uq1l5EpgVZZ1esrrSodwYkgtInvddnreAV1YGJdUjzZDXUQ==
X-Gm-Gg: ASbGncuoE8Bfex4Hm8oiuZAe0FBQFRxMoumVRdadu/CervV83AEZpB3TE+vo+bJT3lo
 90uIK43NUaKPmd92Q+0Pvz3eLvMlxgmis6rLpoJXYlTdCIZWDQtDLaC1x5VBbLzfR1WHZAwn88z
 19L/qx6yPYQ4I3/vb89B792uW3Ftk444kXap5tpf+Kw1Nd/80xA6TjR2+n/Vv+9sJ9MmIGhUc/p
 j4j4St70z3FhLusMJXpu+yuRY5RoAG5kWimObA9uOEvRcQPK2KEjJ+xYxCSn1D8kZfmlbuspjVa
 8+aCYtON6tXUA0odqEEOicjfhVaHevdnorb+s5k8kFLt0IQMAXmOa6Z2ZvoLnL0jrxWi5vL4ItG
 q26guE1abDQpQjU9tgOfEqgx/zr/R/lpX
X-Google-Smtp-Source: AGHT+IFzjP8uctHPeUinzoOqXT802A/TZvXpdq03AsVhaTYbFklS7R8+vSh/QhvGRcrY2l2x+stAHA==
X-Received: by 2002:a17:90a:d2c8:b0:312:e8ed:758 with SMTP id
 98e67ed59e1d1-32515ede095mr20075406a91.13.1756224762853; 
 Tue, 26 Aug 2025 09:12:42 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:12:42 -0700 (PDT)
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
Subject: [PATCH v2 16/35] tcg/wasm: Add ext instructions
Date: Wed, 27 Aug 2025 01:10:21 +0900
Message-ID: <004734452e90077ea9f98ab7b093ce16fc1f5bae.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1030.google.com
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

The ext operations are implemented using the corresponding instructions in
Wasm. TCI instructions are also generated in the same way as the original
TCI backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target-has.h |  1 +
 tcg/wasm/tcg-target.c.inc | 79 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

V2:
- This commit generates both Wasm and TCI instrucitons.
- Moved tcg_wasm_out_extract to this commit for internal use to implement
  the ext instructions, although the extract operation itself is not
  generated in the Wasm backend.

diff --git a/tcg/wasm/tcg-target-has.h b/tcg/wasm/tcg-target-has.h
index cfb85388de..a29ceb2ea5 100644
--- a/tcg/wasm/tcg-target-has.h
+++ b/tcg/wasm/tcg-target-has.h
@@ -3,6 +3,7 @@
 #define TCG_TARGET_HAS_H
 
 #define TCG_TARGET_HAS_tst 0
+#define TCG_TARGET_HAS_extr_i64_i32 0
 
 #define TCG_TARGET_extract_valid(type, ofs, len) 0
 #define TCG_TARGET_sextract_valid(type, ofs, len) \
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index def1f5cd5e..e41b3a0c27 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -434,6 +434,22 @@ static void tcg_wasm_out_sextract(TCGContext *s, TCGReg dest, TCGReg arg1,
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
 }
 
+static void tcg_wasm_out_extract(TCGContext *s, TCGReg dest, TCGReg arg1,
+                                 int pos, int len)
+{
+    int64_t mask = ~0ULL >> (64 - len);
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(arg1));
+    if (pos > 0) {
+        tcg_wasm_out_op_const(s, OPC_I64_CONST, pos);
+        tcg_wasm_out_op(s, OPC_I64_SHR_U);
+    }
+    if ((pos + len) < 64) {
+        tcg_wasm_out_op_const(s, OPC_I64_CONST, mask);
+        tcg_wasm_out_op(s, OPC_I64_AND);
+    }
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(dest));
+}
+
 /*
  * The size of the offset field of Wasm's load/store instruction defers
  * depending on the "-sMEMORY64" flag value: 64bit when "-sMEMORY64=1"
@@ -991,6 +1007,69 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
+static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
+{
+    tcg_out_sextract(s, type, rd, rs, 0, 8);
+    tcg_wasm_out_sextract(s, rd, rs, 0, 8);
+}
+
+static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, 0, 8);
+    tcg_wasm_out_extract(s, rd, rs, 0, 8);
+}
+
+static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
+{
+    tcg_out_sextract(s, type, rd, rs, 0, 16);
+    tcg_wasm_out_sextract(s, rd, rs, 0, 16);
+}
+
+static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, 0, 16);
+    tcg_wasm_out_extract(s, rd, rs, 0, 16);
+}
+
+static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_sextract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+    tcg_wasm_out_sextract(s, rd, rs, 0, 32);
+}
+
+static void tcg_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, 0, 32);
+    tcg_wasm_out_extract(s, rd, rs, 0, 32);
+}
+
+static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_ext32s(s, rd, rs);
+}
+
+static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_ext32u(s, rd, rs);
+}
+
+static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_op_rr(s, INDEX_op_mov, rd, rs);
+    tcg_wasm_out_extract(s, rd, rs, 0, 32);
+}
+
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rrbb(s, INDEX_op_extract, a0, a1, 32, 32);
+    tcg_wasm_out_extract(s, a0, a1, 32, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


