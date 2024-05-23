Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEEBC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZJ-0001X2-Ry; Thu, 23 May 2024 19:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZA-0000gp-RD; Thu, 23 May 2024 19:09:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZ9-0005pg-2j; Thu, 23 May 2024 19:09:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f8eaa14512so304733b3a.3; 
 Thu, 23 May 2024 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505781; x=1717110581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWzh7/uIbqiRnYwtSG879e4ZSk4zptredpC/AFExnTY=;
 b=ASK1LQ9ZTytTC4RIkoT/huxQh6++yMpvLuR5EtjSYfnVpgBsqp17KQhxrMX+xwya0J
 Ezz3n8M3d3PjI/92yLwhiLwg/migtwHRYsVKDdgxyNUA1cuH1u9zOtvgX0MyyVRzGWhL
 i//L2bRhSFbHnfyInY+H7Fnp1U9MxzjKwlBvRnNxVMedpYqYVzUW7Zj6xkeXlwn1OUwx
 uFBLNngGsoTpQlKs1gq7iOzmLD9PWknG/uIihZ+nLM9r7nF7NdChsoYJy9QBElvvB78T
 /x+83eBgiXDI5l6/vIWnaXWnBnnJdm8CONGDqd2DmFVJ/Eehu+eNWoW+ryhptDFLsG9j
 dRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505781; x=1717110581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWzh7/uIbqiRnYwtSG879e4ZSk4zptredpC/AFExnTY=;
 b=uJgm7NI3mHa9g6UO9cajZHW1OTDeGTZ+KPbuIOXV5p9sw0vTW9n9qsK87+SYmV7Y6K
 fFHKcjKx2bAdZmAYSQB6zjiHfVSP2Ks/E6enIXeXr5Ha0ramZ534iMKj2p+/tLHBkf/z
 JzVvikjhSg0m/k3HoBjljQjrr3d7g0uI3qPtldP4Hq8nBoJT86qm6wU9IsHZoEa+vCrJ
 DVAbXtp/mCNPRFuRMawNi/fwo8FXOCG5DceFf/BsrL+hoORP+OZxNjbh6WsSzOhFCOsB
 0Dtdc5n2k0W7kCBvVmm+Ovgev+IexGxFuGLcd4ze4EGuB30LWsC3XM19trKIcymFIW5c
 CyzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8J8+YJFJcVIgNw6lrDNtOxYvVqzTCXvYlXgdVdevJuMBE/0J0OhNrOHs+AFAC02Kdv0ZPUXk+h8C/EyrKfI2Qm8Gx
X-Gm-Message-State: AOJu0YxxUjiq0DQRJ3YDI/FaEnYBnCnNPpGuQmeZspt+/TXQaO4S6z3I
 dmTzfhPfMKrbBAHNh4hDN8NXv3qCwiF7bzuzUJgSvzDsqJwo79fntjrgrg==
X-Google-Smtp-Source: AGHT+IFRqtnvw17u6TG1EgsOv0D0lOFNbxByqp3UOga7nyMfOw9WLYjNweTolApBZKQ4Y2d4/SJqAQ==
X-Received: by 2002:a05:6a21:7795:b0:1af:ccfe:da93 with SMTP id
 adf61e73a8af0-1b212df1467mr932033637.43.1716505781035; 
 Thu, 23 May 2024 16:09:41 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 33/72] target/ppc: add helper to write per-LPAR SPRs
Date: Fri, 24 May 2024 09:07:06 +1000
Message-ID: <20240523230747.45703-34-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
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
index fb05047d95..7b525020ef 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -473,6 +473,34 @@ void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn)
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


