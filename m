Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9245EC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklG-00038A-1q; Sun, 27 Sep 2026 05:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkF-0002QE-T5
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkE-0007Pi-1l
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:27 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0bcdf41a3so1024478a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499625; x=1791104425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j5SErqkyagdaz++WIy5HouZyxpvggeh5TiOu8wTGHXI=;
 b=et+vtHxMUjAn9vnP6dpKUId6i72a3COVJRJSBImCJEs7OOZDqQyOZr/Oul4dQQJSij
 Btyz+x3pGcC+bbdq3r2xDLBye/JFfX8Eem6IY85+h1EVInQilYZ1pB9kduvTR1zYHz5O
 msmjvfGfAmvOKy3HhUokx9bmXrj5c8Sz/qiJmghcpTzND42EqS3mG7IDjahDr6aK3QWm
 WKBs1LLEi5tAy2iYDyU4e1BOW8jB5FvBBI9ThX5E+lxi15L+ndMssrpHm9jz9+RF+CuA
 l/hEVyH9EE3Cx2D6xod9AcDAgrHsisqeEp/QscLw4l7K+aDNY66nPWqilRQu0qVr+gAw
 KhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499625; x=1791104425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j5SErqkyagdaz++WIy5HouZyxpvggeh5TiOu8wTGHXI=;
 b=aX3Q+U765x+CVrk14OimE2RVzEqWIR75zlQR84ZLyqPKb3NZJDhyjME8x69yd5wWO6
 QTad89yh3uAVWUX2l4iuL4GSjRM/4QGHacX8jOWTyBUZdXCozkh0b6OoOxVL9r9N6BR9
 Sh9bPskIbI+82j1zdMPPHhKcz4CenpeRH6WSADGnWIlNJTzo8d3kzCL/6Qi9kQHgSClk
 bk0kitHmfOWchILd7Lit6e8ux46n8mCOpjQANbH+G3Q8H9rr9goGClQsELrJ7/87gAMe
 r1sDbB9RshE0UWsel9ggfcZElAt3IxXSfiVAX8RF3lICkyeHC9FB7ZwrzHYCJH09UuDO
 ZjaQ==
X-Gm-Message-State: AFq9FYIUsQmL+l0RAWzUbfCF7F9t7a4lOyEKYGHL8rIxFiKBQpe3zD+x
 9Lgg9Fsr/V2XBZ3o+DyawFWB7RR+eQRYpr+tZ0HhQ2NfDk9yNlPnAoQnRBhsmPCu+4f8ngu73ba
 CZp0N
X-Gm-Gg: AYBFou3qJT401J6S9zQsyXdCkdkSTcMvZjXlgkIV28vrUjn3YvMxOC2i1/Iej5K9MHF
 ZVr2ymRFUepCeIBZQhT6/6f1sumyY7AhXjlvvyAuZAYy2NCdDlK+NytY5yjLNHQKoejfzO5Jd0Y
 BAnATlrtxF2h82d4tcjzM0cq67cMWaUmHTbdl101ZV1Ox9PV9kqo8tIVgMmVc/i/l2ubwVuPCCs
 sOqW/nhBfJSN/sl/MgmpTBgEb50evFGypPBFwFObqjOanQln8EzEJ4ij+Hwc6e/swcM/H1gZ0BK
 6Yj0zM9LWMJ35kHsqfsflFbsZmPnP+Om53rPPvKE4nntR3AvdYe5VZxIx41FidPeqgWKGYt5kRA
 bcw2f0vdSpL1k5EIM5JVJ6tHTpvfhqD8JN/xXQ7GdoSfpaQNj/CkQ/GbSFXOzpAxJptsEY2jVhX
 wo0Myvh28uFezPULkt040uzVadEFGAR3y7EISKpfNB9J9uM/PmZePVpiaXJ1ue7OlTtDTHutAvg
 CoTPTR5o7Sv0Ka5/JxsOT9Fj9nEONE=
X-Received: by 2002:a17:90b:164a:b0:3a0:c8b5:ff0d with SMTP id
 98e67ed59e1d1-3a0c8b60c53mr4329107a91.12.1790499624563; 
 Sun, 27 Sep 2026 02:00:24 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 013/101] tcg: Generic expansion of tcg_gen_addi_*
Date: Sun, 27 Sep 2026 01:58:43 -0700
Message-ID: <20260927090011.10724-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 29 +++++++++--------------------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3d72d338277..db1405f9ebe 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -226,7 +225,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 73b1ec3d057..faa83a09b2a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -2,6 +2,7 @@
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
 DEF3(add, TCGV, TCGV, TCGV)
+DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a17a9db8203..17fcc889906 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -368,6 +368,15 @@ void tcg_gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
 }
 
+void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_add(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -387,16 +396,6 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_add_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
@@ -1534,16 +1533,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_add_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
 {
     if (arg1 == 0) {
-- 
2.53.0


