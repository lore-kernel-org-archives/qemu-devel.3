Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825B9C52D6D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 06:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDe0-0002za-PT; Tue, 06 Aug 2024 02:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDdz-0002uq-Fs
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:26:03 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDdx-0003wd-Lo
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:26:03 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc52394c92so4168905ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 23:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722925559; x=1723530359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqP4ivw7uQVKQSYmqJWEmyZWTEcacM5pMYJS2o///Ys=;
 b=WNcxVnR9M1VFqjtL+po2VPZw4PQPvZhxn3J61uuFnUyb1iDg6lPfNhDpnhsj6HZ8jt
 Hk7AMad5xEsgNNt3tDdrEwSfn1VIQYwuHdlIOfAHVspABCqr9xN759bKDFtfrp84gChu
 CHB77UlWxt7YPCZ4FMix/VC/SMGsDMEKPx+ShCEFG8coQD8Gzx3T6f1JwSseuQj/quxJ
 HKFsA2etHIwdmRrFH4i8emYAb+CYISU8r2BgLEiCxCkj3lFhKe9IrLzUlRrMkgQVwIHf
 EIMXZJyNqkctx4D98XUAjUcaF+NL0D77gBcxbGAbR9Y9VPIGJY9Mkw3LMeM0lHsJhTqS
 KYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722925559; x=1723530359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqP4ivw7uQVKQSYmqJWEmyZWTEcacM5pMYJS2o///Ys=;
 b=iBYpWnhSoCKsfuR6/YNeti9eQR8Lo0F0xcg8Zw5NvfMTIxAQk04g9Q1Fhw964dwIPR
 SfbPbbZ6unEbTdA54enBcL+70yRYYu7npCzSyOsFD0vUxLGit0qTP4f3euQ8pd25iu5O
 hxYe/Y+JPw91F3XcDllC8pRFo1opZv5JpCGp/s+xOyH49wV/JI6ei2vxb5oWOXxNLylI
 2VPl4fKaM7ginO0PvM3EKNiu7SLzNr98hM/BCW4BT4ze96rVB870aDkeGXShK5nVXCH1
 /F+00jty6JYJRoSJYLMG5MItNKhD/iTIaneQiMV9RFI3EidbgtZ+5gD/Xu7sq6i+G2qw
 a8IA==
X-Gm-Message-State: AOJu0YwS5wuuiRVnUcwmyOmw++QpaP+hH1T/+cXkHhRtZ/Mp3yRjDa4D
 0ZQ1jz2G2vi9c2a6fh7+avDrujIWq0bHAUYfp3/DuDJAmWZGLkQeMbOIm6gP
X-Google-Smtp-Source: AGHT+IE0HC2Vrz6UuBTBb25TQ3gWeAZLMY0BZXqlSDs6NgOPNuxNpwSnS0x4GprcH8LLvljO0Gq/3w==
X-Received: by 2002:a17:902:f68e:b0:1f9:f1e1:da72 with SMTP id
 d9443c01a7336-1ff574a6fecmr171649735ad.63.1722925558906; 
 Mon, 05 Aug 2024 23:25:58 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5927f161sm79464975ad.232.2024.08.05.23.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 23:25:58 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/5] target/riscv: Remove redundant insn length check for
 zama16b
Date: Tue,  6 Aug 2024 16:25:41 +1000
Message-ID: <20240806062545.1250910-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806062545.1250910-1-alistair.francis@wdc.com>
References: <20240806062545.1250910-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Compressed encodings also applies to zama16b.
https://github.com/riscv/riscv-isa-manual/pull/1557

Suggested-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240802072417.659-2-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvd.c.inc | 4 ++--
 target/riscv/insn_trans/trans_rvf.c.inc | 4 ++--
 target/riscv/insn_trans/trans_rvi.c.inc | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 1f5fac65a2..0ac42c3223 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -47,7 +47,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
 
@@ -67,7 +67,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
 
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
 
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index f771aa1939..0222a728df 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -48,7 +48,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
 
@@ -70,7 +70,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
 
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 98e3806d5e..fab5c06719 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -268,7 +268,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
     bool out;
 
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
     decode_save_opc(ctx);
@@ -369,7 +369,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
 
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
-    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
+    if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
     decode_save_opc(ctx);
-- 
2.45.2


