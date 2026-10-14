Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0D8CC6B1C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqN-0004yg-L7; Tue, 13 Oct 2026 23:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqB-0004tA-2h
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:44 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpq8-0001Mb-Fd
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:42 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cc50ad2d650so2702178a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949179; x=1792553979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QVMBiGCXBl16d9HL8Unik9lFRKj8974JHMX15++voLg=;
 b=CSHGVW3yGMA8/Mjr/7rxOPuQDKXg9Rl1MVUPfb64Re7qwWHvjKQaLwLvvupyWDOBf3
 XsSioh4m5VGxn691vSr3pqQZDmI1HMh873uEYNFTg3IotVPgpOZgz7UlJrNFATUjVace
 moT2im4cr1LTlKQIaIGlH5HyECfnH05VAXeT6yZ4zpAv40NobNlYpdVnBv1FmMTx33fx
 +URbOm5Hm2eLpLFZiD9o/aa8NwlfaIs36QLulFrWjc2G6Jnw/teRZTmOMv6O01foZQlR
 GBtgkXk4MLRELG//wyhSdoWu6vBXn3ctlHFvv+sciSl8ijrEfniMtSchGZHRKz+CmQz8
 wpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949179; x=1792553979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QVMBiGCXBl16d9HL8Unik9lFRKj8974JHMX15++voLg=;
 b=1PYlBSClBOZYVwrbgbH3CxHrDhth22Y/7fsozzMFKS5Pi7CFMALe0qrpfZTomtUrjk
 osNtqGfGIxcJ7doyL1HwD643Zg1//ZurS6qRRQXqF8vWx1/ycmdkAhtPX/FCeADY/mGk
 GhhYj7IsDFtLLbNRnXCW3sMMaFZoeqaDHXvmwCfmeabPPsSKBVm2KSALKvD9mH4R9cIJ
 I+22JH9eNI8LUOxFr2yXtWR6BYgItc/s3RZPNzU5J72VhAp+6SdH4PQINyJqDfb5aeu+
 MX2nVmltJjOqLvdwXsDPgTxSTstYbLWWFIplUKFWUYkbFLdiPCPWtAgqxOkv3Zs9Cy7l
 KvNQ==
X-Gm-Message-State: AFq9FYJng/qLEg4KinWd7+HvI6ZFPLukdZ41hgRAYqirzs1SnOmwIPe+
 bjSXr0cxaWgn1U48npWcI8NvWLSFC/cBY1J0jbEfe//KG5uWURsN8K4bbovrRg==
X-Gm-Gg: AYBFou3UHwIYWYjuDOPjbHChT5MMc+nPTjIWp20/54cvtfPivYOI1bziUngl66TZr2v
 Lx748pYnZaUQl6fSSTdWuQ7B/IakW0hyiQAJ8RrVJo4/hQB8c74RAZ9msZWDHmf45D2TWBzzhi8
 fSVfWi8RgnRsOVOVkc8cYL4gjbNQj4PMvra9AykjscXusOsJVZ1Rws/FBDhoUwWkiRGxGZJyu3J
 LlgDmj67v899fEdJ+Kj2FVDXST/T2jlosyMNw9h39DdLTUxaKiTQXXYsUkLaaxNfS3cweLwvko+
 7Z+jC5pIX5m0puUOGmeh2RRNjLvh2wagrsv6m7Yc7O+qWsxx7g2wpIfg4FhmGf8HCRg56pOTMtC
 LbKXzRT8nzj0Gu4bqwXAXkgW/zdAOXZg4BIQxQqeiSEhusg1muDg9q8UjnGoevAX8+rD2Nqkfj2
 MvSojMGJqkJQbDjIQEsPyMl88vx5C+AHvWSPRkCbuKawyVM2HJvOz2Z4JhmZXlJ+q53KznNLg1F
 9w+0d3mpdRqkpO/
X-Received: by 2002:a17:90b:2688:b0:3a4:adea:50ad with SMTP id
 98e67ed59e1d1-3ab3a775938mr12289888a91.27.1791949178550; 
 Tue, 13 Oct 2026 20:39:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:39:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: "Christian S. Lima" <christianslima@proton.me>, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/52] targetriscv: svinval instructions raise virtual
 instruction exception
Date: Wed, 14 Oct 2026 13:38:20 +1000
Message-ID: <20261014033907.3332383-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

From: "Christian S. Lima" <christianslima@proton.me>

The risc v privileged specification requires hinval.vvma, hinval.gvma,
sfence.w.inval and sfence.inval.ir should raise a virtual instruction
exception when executed in the vu-mode. This patch add the check to
raise the virtual instruction exception when is in the vu-mode.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3621
Signed-off-by: Christian S. Lima <christianslima@proton.me>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260911201323.37757-1-christianslima@proton.me>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_svinval.c.inc |  3 +++
 target/riscv/tcg/insn_trans/trans_xthead.c.inc  | 12 +++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_svinval.c.inc b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
index 4614c1489c..1341beba2f 100644
--- a/target/riscv/tcg/insn_trans/trans_svinval.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
@@ -25,6 +25,9 @@
 /* Test if priv level is M or S. */
 #define REQUIRE_PRIV_MS(ctx) do {          \
     if (ctx->priv == PRV_U) {              \
+        if (ctx->virt_enabled) {           \
+            ctx->virt_inst_excp = true;    \
+        }                                  \
         return false;                      \
     }                                      \
 } while (0)
diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
index f4e3051000..ea4b169422 100644
--- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
@@ -267,11 +267,13 @@ static bool trans_th_tst(DisasContext *ctx, arg_th_tst *a)
 #define REQUIRE_PRIV_MSU(ctx)
 
 /* Test if priv level is M or S. */
-#define REQUIRE_PRIV_MS(ctx)                                    \
-do {                                                            \
-    if (ctx->priv == PRV_U) {                                   \
-        return false;                                           \
-    }                                                           \
+#define REQUIRE_PRIV_MS(ctx) do {          \
+    if (ctx->priv == PRV_U) {              \
+        if (ctx->virt_enabled) {           \
+            ctx->virt_inst_excp = true;    \
+        }                                  \
+        return false;                      \
+    }                                      \
 } while (0)
 
 #define NOP_PRIVCHECK(insn, extcheck, privcheck)                \
-- 
2.55.0


