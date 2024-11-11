Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7929D3ABCF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 22:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAcut-0001HR-Ot; Mon, 11 Nov 2024 17:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAcur-0001H4-SD
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:29:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAcuq-0006jl-9s
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:29:49 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so47689285e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 14:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731364186; x=1731968986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDoaWsz0HSbM34lZB8eXf+Hk5GveTxSlbFqqIAwSB2Q=;
 b=gMap+KCJ0A5ADbdXO0oa+vaOFg9V2dOd5VPj/IMg3vSU6TsEaUr7YrTb/Y91QLGcOX
 aGyICdGL0nzdSZXIAXVD5UAD85q4AR8518f543Hw4Ggtg9LYYPH8UjVvX1qJw9kd0Ai6
 K1BNth9YiFQxCrpnb5wUZnYSWjc8HI91NEgJAijTdhRr+Wl5NvikTrckBqsWc45aYqjY
 iOY6q30nco+0h4ZqW/GUHzrlTbdYwlORfBeuU5zuWcdUqqYZ/ObQAsTHuUjrM+5w7vD6
 mf9UjT/23NDs5eptuF6EyG7w0i9s/1SyfIT8ERZM2EBoeLBm2A8C1+L8iTAg38+m6H49
 4duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731364186; x=1731968986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TDoaWsz0HSbM34lZB8eXf+Hk5GveTxSlbFqqIAwSB2Q=;
 b=nA8xzViIGh3s1IqwwWNLiRziLXIsgtRDNaVCicw8Gdkuv/lYe06oA3257orODJSJ89
 OweDsi2q7G0wo5ravdevu88qIf/ycVr0NF3FPD300+BmvR9+tuqnHSaqH196SYCOlvqQ
 bK44woIfl4Zw/LdaoQv2XvQIOfLRs1fiY7HsksLzoY7Bfn9UgxLpa32RdsIQK/Sbx7Gn
 hdghtgYYyL+USa3cSlIfvNYnnVQkjaZCMKAa9zjYoHqM/rzHBtEELyDXgzq8JHqWwbXl
 FKybt3GAj2ssjaMh3oHYr2KvQB7pPAeC12mAa9BqGEkFw/JFqvKiq7E7AVYp/qqBDfxk
 IXiw==
X-Gm-Message-State: AOJu0YzhlBRkhA+SV8lmu83S22mxwDyC3MtIRbH9EidiTZbgjmVXIjlW
 DQgkkJaSTlsEf7RBWF0sGgRvfAMEln2myIJFAMa1uYGZmH8x3X7bhp7y5DmN2BFv3OSNr88ZNuz
 N
X-Google-Smtp-Source: AGHT+IGNWZKoEH5oOIR5a+4FlZebhVDK+28uM7H0C2/eWFJjtnMLm9vbEhcELQzP2f5RLtcrEjIHqw==
X-Received: by 2002:a05:600c:5124:b0:431:46fe:4cad with SMTP id
 5b1f17b1804b1-432b7501d4emr128829905e9.9.1731364186548; 
 Mon, 11 Nov 2024 14:29:46 -0800 (PST)
Received: from localhost.localdomain
 (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr. [176.184.43.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b053069fsm192795565e9.4.2024.11.11.14.29.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Nov 2024 14:29:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/3] target/mips: Extract gen_base_index_addr() helper
Date: Mon, 11 Nov 2024 23:29:34 +0100
Message-ID: <20241111222936.59869-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111222936.59869-1-philmd@linaro.org>
References: <20241111222936.59869-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Factor out gen_base_index_addr() which is used twice
but we'll use it more.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h |  1 +
 target/mips/tcg/translate.c | 27 +++++++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 1bf153d183..ed69ba15e5 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -153,6 +153,7 @@ void check_cp1_registers(DisasContext *ctx, int regs);
 void check_cop1x(DisasContext *ctx);
 
 void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset);
+void gen_base_index_addr(DisasContext *ctx, TCGv addr, int base, int index);
 void gen_move_low32(TCGv ret, TCGv_i64 arg);
 void gen_move_high32(TCGv ret, TCGv_i64 arg);
 void gen_load_gpr(TCGv t, int reg);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index de7045874d..7152f5418e 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1956,6 +1956,17 @@ void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset)
     }
 }
 
+void gen_base_index_addr(DisasContext *ctx, TCGv addr, int base, int index)
+{
+    if (base == 0) {
+        gen_load_gpr(addr, index);
+    } else if (index == 0) {
+        gen_load_gpr(addr, base);
+    } else {
+        gen_op_addr_add(ctx, addr, cpu_gpr[base], cpu_gpr[index]);
+    }
+}
+
 static target_ulong pc_relative_pc(DisasContext *ctx)
 {
     target_ulong pc = ctx->base.pc_next;
@@ -10545,13 +10556,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
 {
     TCGv t0 = tcg_temp_new();
 
-    if (base == 0) {
-        gen_load_gpr(t0, index);
-    } else if (index == 0) {
-        gen_load_gpr(t0, base);
-    } else {
-        gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[index]);
-    }
+    gen_base_index_addr(ctx, t0, base, index);
     /*
      * Don't do NOP if destination is zero: we must perform the actual
      * memory access.
@@ -11333,13 +11338,7 @@ static void gen_mips_lx(DisasContext *ctx, uint32_t opc,
     }
     t0 = tcg_temp_new();
 
-    if (base == 0) {
-        gen_load_gpr(t0, offset);
-    } else if (offset == 0) {
-        gen_load_gpr(t0, base);
-    } else {
-        gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[offset]);
-    }
+    gen_base_index_addr(ctx, t0, base, offset);
 
     switch (opc) {
     case OPC_LBUX:
-- 
2.45.2


