Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164C7C25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ELP-0007nl-PY; Mon, 20 May 2024 21:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELO-0007mY-24; Mon, 20 May 2024 21:31:10 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELL-0005L7-Hu; Mon, 20 May 2024 21:31:09 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-66986f58b43so1335905a12.0; 
 Mon, 20 May 2024 18:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255065; x=1716859865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjlPsYtB8Kd+0Ny4SiPL3hIvcQ0jYiMqPq1SDRuz4OE=;
 b=kHOb56SdVvuHXo7M3VmSIWflImIwDmtaIjPs+ZD5bqU1TKQuhadTxmEfUJYQhyvKxu
 kssgDGTBIziRJ2vkn96S696OfFstT+o4b6cTypJt4dY7T6YVIT6/7zrgOY6pNCCHK9GG
 iqwHExMOW0fsnj7Rq26RuFJTZE3RdLDBg8CXlRR/5aOztX1cRZ1fZqHQywObUmeL0lNK
 ja2sKHfL3xJ/QrTr0cBOkj/4Jy786AkGhkSEgbSVxF4I3m6MLzOQTfqrqC6i77MPjMoQ
 R5nr9QLfKWl2C7uX3bwZn+zINuMs9UVM5O6SqqsThbpouoMOzf208P6ot8WeLQAcczJ+
 SkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255065; x=1716859865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjlPsYtB8Kd+0Ny4SiPL3hIvcQ0jYiMqPq1SDRuz4OE=;
 b=D40yUuayt0yOUICyhT0eOT7BkOwAyqQTCFSgyns7ofNiDeRzpcl9SoKwzH26+TY7L/
 2cIX2wGSefiMaj7Zy7IsuQ/3fwgQtlqjRwiDL4gISNhl1MjqTiwqYYnO3z7yGuwek2XE
 iZ6N5wbfb+ulsDjdndkbYJBfmIrxtw46OzpaQgxuags9dE4NT71Ot4IUmAbZs89UWyQV
 gUHH47MjEyuY29M4BK1mBjo44EqcwYNUKv3MZNEBNRw36nTPCny9oiVEe/4awqe9KQNS
 awaKRF6rl899POLfWhtwgth4IbGCXZZYoFHQdWbChyiePaq/vLUe3FTZlsbO4O5Nmk0S
 PlvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9mxXTX6j4/dVSPFb4N1my/J/iOczmJpl8AkYtYSPmMysFbAx8ZgFR1weJ01/XO3VnPSJAstUuKuEXsSSr0wdd4CZZvxE=
X-Gm-Message-State: AOJu0YxuUVLurTyO3GCMeQWX+oYTM05GKS8rIg7LVmhksoJpRDOpnjqj
 tiQ/hcaCDDK/P03YsGcgWVYPXETIfJe9HunUJL8uTQergGZ5mQKulZcjYg==
X-Google-Smtp-Source: AGHT+IF5KzDGdGUVIjp7ZnJAXcX+JuBJBSiOWFuaBb0D9cKRNZuE4kKPRenquYdP9NJBqE5NalOSww==
X-Received: by 2002:a17:90a:520b:b0:2bd:9255:91b6 with SMTP id
 98e67ed59e1d1-2bd9255b060mr918209a91.4.1716255065349; 
 Mon, 20 May 2024 18:31:05 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:31:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 07/12] target/ppc: add helper to write per-LPAR SPRs
Date: Tue, 21 May 2024 11:30:23 +1000
Message-ID: <20240521013029.30082-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521013029.30082-1-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
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

An SPR can be either per-thread, per-core, or per-LPAR. Per-LPAR means
per-thread or per-core, depending on 1LPAR mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/spr_common.h |  2 ++
 target/ppc/translate.c  | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 9e40b3b608..85f73b860b 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -83,6 +83,8 @@ void spr_read_generic(DisasContext *ctx, int gprn, int sprn);
 void spr_write_generic(DisasContext *ctx, int sprn, int gprn);
 void spr_write_generic32(DisasContext *ctx, int sprn, int gprn);
 void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn);
+void spr_core_write_generic32(DisasContext *ctx, int sprn, int gprn);
+void spr_core_lpar_write_generic(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR0(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR1(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCRA(DisasContext *ctx, int sprn, int gprn);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 137370b649..c688551434 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -535,6 +535,34 @@ void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn)
     spr_store_dump_spr(sprn);
 }
 
+void spr_core_write_generic32(DisasContext *ctx, int sprn, int gprn)
+{
+    TCGv t0;
+
+    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
+        spr_write_generic32(ctx, sprn, gprn);
+        return;
+    }
+
+    if (!gen_serialize(ctx)) {
+        return;
+    }
+
+    t0 = tcg_temp_new();
+    tcg_gen_ext32u_tl(t0, cpu_gpr[gprn]);
+    gen_helper_spr_core_write_generic(tcg_env, tcg_constant_i32(sprn), t0);
+    spr_store_dump_spr(sprn);
+}
+
+void spr_core_lpar_write_generic(DisasContext *ctx, int sprn, int gprn)
+{
+    if (ctx->flags & POWERPC_FLAG_SMT_1LPAR) {
+        spr_core_write_generic(ctx, sprn, gprn);
+    } else {
+        spr_write_generic(ctx, sprn, gprn);
+    }
+}
+
 static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
 {
     /* This does not implement >1 thread */
-- 
2.43.0


