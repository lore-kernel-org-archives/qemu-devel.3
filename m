Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A29AD2594E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkchu-0002pl-UT; Tue, 27 Jan 2026 01:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkcht-0002op-0M
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:45 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchr-0006i4-JB
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:44 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a871daa98fso1204515ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495862; x=1770100662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtNhWeVMoZx4v3vlFITbXT3n9HHx54McIikf5l1fVU4=;
 b=B1MPdrKJSar40ms9SoO/k5fBiX4oYvsJJfHFfbNHMe6004wMGABgM670H5rqjrDhGM
 uRPVjrGiaIYPF1scwT7dSyZkbY3JPRpHF0ShVBYPFBuFiZYv2HnYYi/7FjOzSSaLZW/Z
 8S6pCtcQJx3OiZBpoeX2zU4fdXNMccLzMnlMgQDM7qlkQKJCQPgoCENSFlpwbgbR3SFr
 MaZFWCDuUJYjQjfTfXJ/strFCketLfVsmZnjtQHtsswc0kr1PrdTKI5ELZK5+7Ik6HVF
 sT8uAe+y/QsHDMKb2F1rYSvEObQpH0pMLcrqiF3RtUZYrZ7uc5KoN9FtZBPyEbUHizZn
 bIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495862; x=1770100662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WtNhWeVMoZx4v3vlFITbXT3n9HHx54McIikf5l1fVU4=;
 b=VO30H8aH76d3++R7sUVeFWR2YQzXpJdQVK3p1qPugqw08D5Ol/jz0tk2Os09I0x08l
 ie9CTa4vGog7Tj7Re2Vlf13E1ia1l9eos3bbaqxhLl1E6KtmvI5a1+x5amqaTGE73q+V
 5cuDQHBoLqKnf4cueH8bJhM06eD21D2yvpYTVt6KlShSbeX0SEvct5GdEFj9itnYfh2q
 wIAWc/sOWxiN8/jXVgoTWxaLlQeNvhaIdyN/YvmLQrW7pNrZNaaFvUBH4r06jF/WAZ4j
 AUI50dnkDk8qrm4cuoMknEAi42ef3twC9hPMtAI7IuNNFBVnohk2oGyW19mUoQ+S9dLf
 h0pA==
X-Gm-Message-State: AOJu0YzpLa9inR1UeNXy8qYqw+8+Xt5/p8UKiiLQOLYRxaZf2BSepJUF
 FVsQDUFihxgzWrLK4Kjoj6hOWYVv83hl8keJJm0aOR2TWuZ+DDXcHF54zKJg9jZO6gmbX1td+2a
 jFxqsZe8lcEA26cBGXTYa576KbfjnogchEa4Pb6TzSD3oTZtj/e6ivks7ioRoXwEq3WXjbyqGqG
 JPWZN3rykvakST6dZfgpQ9iVVnu8Bk9XCKSsEKJgdiBw==
X-Gm-Gg: AZuq6aJxnJJjInEmlXECxzcuqjjbXFk/WsqX9TQGaxU4Tk/VfM4DMiiVLAdj9ZF/QuJ
 MfgaJSg3dBE3kS0GsXwu0yJxKA33c7YuIomrKNg09Yk3Ng3n2DKM+UDhXeAnGPac7V4MkqNrfz/
 K9Ns1Q5TwFfdaaXrO5PAj1DGAi9YVmHsH0sJ1pzf3jlSSDEbFFq45FmiAtXqlMVSH6HfQlyQZ29
 gBiqVf3IsUxata1wfIq6SJegPHk6dhTUbuYgNYjIcI5JpIIBdnof/BG0UFcYPRImCkZllPhNjlk
 ftfDWRcY4J1uRUYgnCt7fczP4pQsDmZVkN3RmDGFpM1MHwQeBybwmhewgevD7bBgqeVQsGhqcAZ
 ax5CVjAN+F5nv+vVqA4KYFNXXDzXQ0BCC6KCOi1x8yZ7KKkZ19hA/dkBbX6FfQDxepzpmLpMzig
 gBbRLcTQBLoc9j1E9wMk0gJqZ6rrZWGboMOZlrEiCMspwqRSqGiPtZMBhg3UHqk7ooE3KIYwNe8
 f8wJFTcDF4Cq10=
X-Received: by 2002:a17:903:1a30:b0:2a0:c1f6:6bc2 with SMTP id
 d9443c01a7336-2a870e18d60mr8704915ad.59.1769495862011; 
 Mon, 26 Jan 2026 22:37:42 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:41 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 05/17] target/riscv: Add cfg properity for Zvfofp8min
 extension
Date: Tue, 27 Jan 2026 14:37:11 +0800
Message-ID: <20260127063723.442734-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

According to the ISA spec of Zvfofp8min extension,

"The Zvfofp8min extension requires on the Zve32f extension."

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 target/riscv/vector_helper.c      | 3 ++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bd17f61d7b..d6ce51ef5e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
     ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 3696f02ee0..59302894af 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfofp8min)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 378b298886..ba89436f13 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -710,6 +710,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfofp8min && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfofp8min extension depends on Zve32f extension");
+        return;
+    }
+
     if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
         error_setg(errp, "Zvfh extensions requires Zfhmin extension");
         return;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ec0ea4c143..ee5a1e595b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -38,7 +38,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     int xlen = riscv_cpu_xlen(env);
     target_ulong reserved = 0;
 
-    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
+    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
+        riscv_cpu_cfg(env)->ext_zvfofp8min) {
         reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     } else {
-- 
2.52.0


