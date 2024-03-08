Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E1FC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9r-0006gj-FK; Fri, 08 Mar 2024 06:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9k-0006fP-Cv
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:53 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9i-0001c6-QE
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:52 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dd6412da28so7885825ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896369; x=1710501169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1+fe1bmiW3piQSxB1/TB32uVppCGtDxv3LzWwD/VvU=;
 b=l7q9Qh+A3plJ7E4K8nKG4WedceEatlWWJBFfToo+pt6tdxKNBGeSdjj2YOyg+KcquK
 NZUtPPiThM9xzWn9+vmM/bjRFgwcIIXUjDkVQGzrH0BifVnAOFqJgfq1XjYrpu7IW2Tp
 XfZm5MoOUQXqP4mh3Fc7fcHm25jp3H6xRxX4ZS8isaCJFTtw89FRrXGbF9cTUgaP6A3L
 3kqHHh607YTqDwkF/7fyf7f2x0Vzzh4OI589CsrQxUPb0WHMHaKMwHMABcCvvn9bPxVy
 9JA1EhiInOIO9uiGOrRY9rdAj/N82CuF8229gIH55Dw7FTq+s7BqMUPK3Sos7iysa4YS
 3Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896369; x=1710501169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H1+fe1bmiW3piQSxB1/TB32uVppCGtDxv3LzWwD/VvU=;
 b=MUIqiVJkhpuQiiqewZfYqV9oiIQNNtjURE6vyM3qkbnx10+7kkk6rmpYpWbYoECFko
 bz4vFASg6/xsQeRN79rsjfu7OXjRIfznO4zvcxRgMGZzuQA40AQKSXxBqNRw1YHIgkLW
 xm2Ap5v4Qhq3n+HKwtiKjG50SzqrIKd1SUV3K1fKjwZ1eODyytdbWZxJHo/qbgWbHnra
 Jl//DCwBZs8e/BM30Qtviuo+BglAVhpo67/wddUYUyrejveMcARfeCZAKr9paZSLDtpj
 Px6gB5fvwlHnk6T5zmAvrj0yi4cVGovKNVZruoCAbnrBLe0Zv7h71rFRPJBF05eJJXLf
 paDw==
X-Gm-Message-State: AOJu0Yz/36JjYKfyGVfSlXMS3RCdzXxzbcRygZ4LXUTR/JT3BCpml9xd
 8fYeQRXfHLguybe4t0XoB+cp6Eqca5ZQXnbAlOfeQdpxePSpur3NbnYSqCLlPKXcqg==
X-Google-Smtp-Source: AGHT+IEUOca+1Wo0shGtTPlUQBBH2SaSP+w1hnbxPTSxhot3hZFZob77r/pnoYgMQPy4VwROL3nDQg==
X-Received: by 2002:a17:902:e805:b0:1dc:f916:6b07 with SMTP id
 u5-20020a170902e80500b001dcf9166b07mr12100010plg.20.1709896369293; 
 Fri, 08 Mar 2024 03:12:49 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:48 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Irina Ryapolova <irina.ryapolova@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/34] target/riscv: UPDATE xATP write CSR
Date: Fri,  8 Mar 2024 21:11:32 +1000
Message-ID: <20240308111152.2856137-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Irina Ryapolova <irina.ryapolova@syntacore.com>

Added xATP_MODE validation for vsatp/hgatp CSRs.
The xATP register is an SXLEN-bit read/write WARL register, so
the legal value must be returned (See riscv-privileged-20211203, SATP/VSATP/HGATP CSRs).

Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240109145923.37893-2-irina.ryapolova@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 52 ++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 805b972f6d..726096444f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1299,6 +1299,32 @@ static bool validate_vm(CPURISCVState *env, target_ulong vm)
     return get_field(mode_supported, (1 << vm));
 }
 
+static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_xatp,
+                                  target_ulong val)
+{
+    target_ulong mask;
+    bool vm;
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        vm = validate_vm(env, get_field(val, SATP32_MODE));
+        mask = (val ^ old_xatp) & (SATP32_MODE | SATP32_ASID | SATP32_PPN);
+    } else {
+        vm = validate_vm(env, get_field(val, SATP64_MODE));
+        mask = (val ^ old_xatp) & (SATP64_MODE | SATP64_ASID | SATP64_PPN);
+    }
+
+    if (vm && mask) {
+        /*
+         * The ISA defines SATP.MODE=Bare as "no translation", but we still
+         * pass these through QEMU's TLB emulation as it improves
+         * performance.  Flushing the TLB on SATP writes with paging
+         * enabled avoids leaking those invalid cached mappings.
+         */
+        tlb_flush(env_cpu(env));
+        return val;
+    }
+    return old_xatp;
+}
+
 static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
                                  target_ulong val)
 {
@@ -3021,31 +3047,11 @@ static RISCVException read_satp(CPURISCVState *env, int csrno,
 static RISCVException write_satp(CPURISCVState *env, int csrno,
                                  target_ulong val)
 {
-    target_ulong mask;
-    bool vm;
-
     if (!riscv_cpu_cfg(env)->mmu) {
         return RISCV_EXCP_NONE;
     }
 
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        vm = validate_vm(env, get_field(val, SATP32_MODE));
-        mask = (val ^ env->satp) & (SATP32_MODE | SATP32_ASID | SATP32_PPN);
-    } else {
-        vm = validate_vm(env, get_field(val, SATP64_MODE));
-        mask = (val ^ env->satp) & (SATP64_MODE | SATP64_ASID | SATP64_PPN);
-    }
-
-    if (vm && mask) {
-        /*
-         * The ISA defines SATP.MODE=Bare as "no translation", but we still
-         * pass these through QEMU's TLB emulation as it improves
-         * performance.  Flushing the TLB on SATP writes with paging
-         * enabled avoids leaking those invalid cached mappings.
-         */
-        tlb_flush(env_cpu(env));
-        env->satp = val;
-    }
+    env->satp = legalize_xatp(env, env->satp, val);
     return RISCV_EXCP_NONE;
 }
 
@@ -3532,7 +3538,7 @@ static RISCVException read_hgatp(CPURISCVState *env, int csrno,
 static RISCVException write_hgatp(CPURISCVState *env, int csrno,
                                   target_ulong val)
 {
-    env->hgatp = val;
+    env->hgatp = legalize_xatp(env, env->hgatp, val);
     return RISCV_EXCP_NONE;
 }
 
@@ -3809,7 +3815,7 @@ static RISCVException read_vsatp(CPURISCVState *env, int csrno,
 static RISCVException write_vsatp(CPURISCVState *env, int csrno,
                                   target_ulong val)
 {
-    env->vsatp = val;
+    env->vsatp = legalize_xatp(env, env->vsatp, val);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.44.0


