Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1122C25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQp-0006Xs-RA; Sat, 18 May 2024 05:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQk-0006Ua-6M; Sat, 18 May 2024 05:32:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQi-0005xB-Hk; Sat, 18 May 2024 05:32:41 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1eeb1a4c10aso31516385ad.3; 
 Sat, 18 May 2024 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024757; x=1716629557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9E8A9YiZzilNZc0YhxzRbKs1Y14T+BqDlAP7w9sE6MI=;
 b=hnJwgGnYmragRHaPaChaXujDQvyOYov2Pyc/czMUlYRB4/AoYR492UBo0cdkYwtqRu
 zKtOb7ielzVP+8x2gJHxQMxQanuAZkhRQaQoY6RdpN33XdbLvyvObwfpjGW63AYRH72l
 hkmZRZ4CAWMpkLfP4MXXWoXhljKh5qgdX1wCiKC5Fz3f7UV9puRIg4vs4G+DWI6yNzt/
 ndut+/1YJQ8EYrMIJZ0bXHHWk5xpREGHR7gCyDnvnnd9dvWElsPOQCnBOtF2d8/3/Zrc
 /dBjcStP1M+lbqlxZ7MCf/jo3VhM/U1Ea0g115M9fOIMNdgQ408FQIBTbj0BCWGdRoSK
 sX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024757; x=1716629557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9E8A9YiZzilNZc0YhxzRbKs1Y14T+BqDlAP7w9sE6MI=;
 b=k4ws0TdJWlf2uq9MM+22Sl9Hp9RYiCYkZA6p4JxBxtl68OAyLZOmOW+efUl/vbdC2Y
 rpyImZIyW9UdDpAh5pzFWIDoD7ZGZ4SUEytw12xnNFVUpjhdx9tKfSXBzXnXhobuYkQJ
 gbYCfUq88f8uDa+dOARjNsnqmndACDOJa9c2XQCwP5p0BxxpbGyeC0OZbgK/szGm3Dg2
 J6C//ANIZEiyqzSWsh/7sVWsKuhEm2x8vr4Qk38eYKu1PbHna7dNtoxNwrLnXVFM5cM9
 obaU1Chu+LCyXxKV5ZSd6P1QKMYFz38QQBuTybZpMCeA+RVxu/3bcpnahbVHm+8JiVAO
 2TCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6UrJQrcQubCiYllCEmcLW1bl8yLsip4iYn2oMoPr6cJU7NFfAUwEgqtIOLIma5ecvgvIoPOs6hYx6HuLxElirPzi3dC4=
X-Gm-Message-State: AOJu0YzQh/zZY3C5iAhjb6h4w3dMT9+OoOSQRaoedCB1s8NICIGpFcRE
 jQd4TaFxU+cmyEqBtkPBJEzVsmXSFezKyS4Fl3eSyg1aL+nFpqyiW/Qkjw==
X-Google-Smtp-Source: AGHT+IGcfIGHvd7z0DBzZCq8d8aQNBtkkfBI+8KoifO8iVrlmPKvax+Uu9m5h2E8s8VvF5esT8+nqg==
X-Received: by 2002:a17:90a:9503:b0:2b4:32be:3b8c with SMTP id
 98e67ed59e1d1-2b6ccd6bab8mr22322306a91.37.1716024757458; 
 Sat, 18 May 2024 02:32:37 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 09/14] target/ppc: add helper to write per-LPAR SPRs
Date: Sat, 18 May 2024 19:31:51 +1000
Message-ID: <20240518093157.407144-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518093157.407144-1-npiggin@gmail.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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
 target/ppc/translate.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

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
index c4b4f7ea62..ccd90a5feb 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -537,6 +537,32 @@ void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn)
     spr_store_dump_spr(sprn);
 }
 
+void spr_core_write_generic32(DisasContext *ctx, int sprn, int gprn)
+{
+    TCGv t0 = tcg_temp_new();
+    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
+        spr_write_generic32(ctx, sprn, gprn);
+        return;
+    }
+
+    if (!gen_serialize(ctx)) {
+        return;
+    }
+
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


