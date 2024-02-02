Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5FCC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWa-00071X-ID; Fri, 02 Feb 2024 00:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWZ-0006wR-5x
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:39 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWX-00035s-8R
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:38 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d74045c463so14548795ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853335; x=1707458135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MmXvL/mBUtjPLJgH7bWQwu4aOx0MlIr+YBmEmLuSVs=;
 b=c2yTC3GnDXdJA5yBMl/d3AUjJlTzJYCv3r8hUcaZa3AEmUm1iISEnrR3pRz42bDmhX
 DgxfV5xAHZTVt1RYBfBw0dZYPfm6cu0AHqVjNohGiePZrLJFhBrfaxrUbtRQB3GA3yyJ
 5iYbDO8gpiUcqgadTETJiR9SXLVecmHKKzeD8dDRjfhJ73/YtBeZ+moMyyTWokmlO+gz
 d9rPFOOFYcV1Q8CdcUJk48fAU+LX/CKYesrDOMrXp63xTqhDjO8f06NdSYgIG5foBQE1
 TeK2GhTdJtqf2QrZlbCmmPWiDBRQErJq5/84zrOSmS63+8h0wNdw3ujSCdvCNIwvawk5
 gwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853335; x=1707458135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MmXvL/mBUtjPLJgH7bWQwu4aOx0MlIr+YBmEmLuSVs=;
 b=gFUQV7dRZ1AoajCb7WG2wevD6G2rn7qqOPLHlpxGSUUON1dQlbyU91SGhVCdk3Upxs
 LTpGrJySCzxC0cbGiqrXdWA+7EE/pZFlH0PPfWdvhJP+oPFGJLQI5VPGvZfBfgCS6up6
 dm5CSodxjVwGIfQclQcKBbXdD6sBy+Xss1lrIIdd2xzrIq6cRvydjjngR0/wMBWSLtu2
 Pzr/gTY5tQr6I9DlCSSAkxIBb6rK9WdgIw00phlkvfMKQN1c5fAj65/sF1q/ewE0O4lH
 KOuoHFcVe2gocQHBOwqyz4MAxTX9nKK2OjkPCRd/ivP2qpoLGwOWD4lQ7kV4wZLGkBKX
 G/8Q==
X-Gm-Message-State: AOJu0YwRW78RcwD2CMxYNPrKH99d6NqIPkYEihkeapKm2l+OQWzAjuki
 x3CUeXuUopThOB0LGPfDeH4orSRTDXFSbg9aY6CqT3Mo7CeWuq5+bOIPaoiqp09huWFm6oD4i6u
 WAaE=
X-Google-Smtp-Source: AGHT+IGhMYTbjbuittSUoQFX5q/mWgzWbJ4tqyn/nOmteb9njrv5ATAO3S5/zzyFCIV2fQ6yqJDPqg==
X-Received: by 2002:a17:902:fc4b:b0:1d8:8f4d:4d15 with SMTP id
 me11-20020a170902fc4b00b001d88f4d4d15mr1389605plb.17.1706853335661; 
 Thu, 01 Feb 2024 21:55:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUT0uxolzHzecaY5zWYHyx7J7ZYB+pNmLORzM0T5Dwla+MYeY2iBmPzT9GnNZe7J+3MbLEMUb9f9K7MFtFF/WIbihBywFanhTwd4/m+kA==
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 51/57] target/sparc: Split ver from env->fsr
Date: Fri,  2 Feb 2024 15:50:30 +1000
Message-Id: <20240202055036.684176-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This field is read-only.  It is easier to store it separately
and merge it only upon read.

While we're at it, use FSR_VER_SHIFT to initialize fpu_version.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-17-richard.henderson@linaro.org>
---
 target/sparc/cpu.h        |  3 +++
 target/sparc/cpu.c        | 27 +++++++++++++--------------
 target/sparc/fop_helper.c |  9 +++++++--
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 3cf8cc2d0b..216155d231 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -191,6 +191,9 @@ enum {
 #define FSR_NXC   (1ULL << 0)
 #define FSR_CEXC_MASK (FSR_NVC | FSR_OFC | FSR_UFC | FSR_DZC | FSR_NXC)
 
+#define FSR_VER_SHIFT  17
+#define FSR_VER_MASK   (7 << FSR_VER_SHIFT)
+
 #define FSR_FTT2   (1ULL << 16)
 #define FSR_FTT1   (1ULL << 15)
 #define FSR_FTT0   (1ULL << 14)
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1897ab230d..313ebc4c11 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -368,7 +368,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "Fujitsu MB86904",
         .iu_version = 0x04 << 24, /* Impl 0, ver 4 */
-        .fpu_version = 4 << 17, /* FPU version 4 (Meiko) */
+        .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0x04 << 24, /* Impl 0, ver 4 */
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0x00ffffc0,
@@ -381,7 +381,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "Fujitsu MB86907",
         .iu_version = 0x05 << 24, /* Impl 0, ver 5 */
-        .fpu_version = 4 << 17, /* FPU version 4 (Meiko) */
+        .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0x05 << 24, /* Impl 0, ver 5 */
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -394,7 +394,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI MicroSparc I",
         .iu_version = 0x41000000,
-        .fpu_version = 4 << 17,
+        .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x41000000,
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0x007ffff0,
@@ -407,7 +407,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI MicroSparc II",
         .iu_version = 0x42000000,
-        .fpu_version = 4 << 17,
+        .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x02000000,
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0x00ffffc0,
@@ -420,7 +420,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI MicroSparc IIep",
         .iu_version = 0x42000000,
-        .fpu_version = 4 << 17,
+        .fpu_version = 4 << FSR_VER_SHIFT,
         .mmu_version = 0x04000000,
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0x00ffffc0,
@@ -433,7 +433,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc 40", /* STP1020NPGA */
         .iu_version = 0x41000000, /* SuperSPARC 2.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x00000800, /* SuperSPARC 2.x, no MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -446,7 +446,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc 50", /* STP1020PGA */
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000800, /* SuperSPARC 3.x, no MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -459,7 +459,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc 51",
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000000, /* SuperSPARC 3.x, MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -473,7 +473,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc 60", /* STP1020APGA */
         .iu_version = 0x40000000, /* SuperSPARC 3.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000800, /* SuperSPARC 3.x, no MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -486,7 +486,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc 61",
         .iu_version = 0x44000000, /* SuperSPARC 3.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000000, /* SuperSPARC 3.x, MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -500,7 +500,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "TI SuperSparc II",
         .iu_version = 0x40000000, /* SuperSPARC II 1.x */
-        .fpu_version = 0 << 17,
+        .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x08000000, /* SuperSPARC II 1.x, MXCC */
         .mmu_bm = 0x00002000,
         .mmu_ctpr_mask = 0xffffffc0,
@@ -514,7 +514,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "LEON2",
         .iu_version = 0xf2000000,
-        .fpu_version = 4 << 17, /* FPU version 4 (Meiko) */
+        .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0xf2000000,
         .mmu_bm = 0x00004000,
         .mmu_ctpr_mask = 0x007ffff0,
@@ -527,7 +527,7 @@ static const sparc_def_t sparc_defs[] = {
     {
         .name = "LEON3",
         .iu_version = 0xf3000000,
-        .fpu_version = 4 << 17, /* FPU version 4 (Meiko) */
+        .fpu_version = 4 << FSR_VER_SHIFT, /* FPU version 4 (Meiko) */
         .mmu_version = 0xf3000000,
         .mmu_bm = 0x00000000,
         .mmu_ctpr_mask = 0xfffffffc,
@@ -786,7 +786,6 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
 
     env->version = env->def.iu_version;
-    env->fsr = env->def.fpu_version;
     env->nwindows = env->def.nwindows;
 #if !defined(TARGET_SPARC64)
     env->mmuregs[0] |= env->def.mmu_version;
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 70b38011d2..22b412adb5 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -349,7 +349,12 @@ GEN_FCMP(fcmpeq_fcc3, float128, 26, 1);
 
 target_ulong cpu_get_fsr(CPUSPARCState *env)
 {
-    return env->fsr;
+    target_ulong fsr = env->fsr;
+
+    /* VER is kept completely separate until re-assembly. */
+    fsr |= env->def.fpu_version;
+
+    return fsr;
 }
 
 target_ulong helper_get_fsr(CPUSPARCState *env)
@@ -361,7 +366,7 @@ static void set_fsr_nonsplit(CPUSPARCState *env, target_ulong fsr)
 {
     int rnd_mode;
 
-    env->fsr = fsr;
+    env->fsr = fsr & ~FSR_VER_MASK;
 
     switch (fsr & FSR_RD_MASK) {
     case FSR_RD_NEAREST:
-- 
2.34.1


