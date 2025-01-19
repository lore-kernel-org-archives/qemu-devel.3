Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6043CC02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJuM-0002g1-K4; Sat, 18 Jan 2025 20:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuI-0002MU-8z
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:18 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuF-0003gS-3w
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:17 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2efb17478adso5859576a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249313; x=1737854113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzfXtdeXTxj7aTbAzBirn5FPQKv+kTN3iTkNh9s4tgA=;
 b=KTjhITOaQeZrSsavEr7nE7CN4zx6i6SStmsnSrQWG5uOr87ONcYUMknPiGhxquhAvY
 cK350AbsHKfScnAprjPoNe9Mr8I4uDQKo0GmofWJ1GurbYx04/uog+te8ruOl69AbCje
 fxjiBRSCWjovGmLFsymGqqAFro833+GEGxDIJrcQBxQ9GYXVyPz4BPnCrix+uC7gdUPa
 N3kGiAbK58f8JQC1Miydg3Bjd55ROgJH/WIZqixxcuryD2D9CgNIZdeVX1mBiDj5PMG6
 4LMvp1cizcMBurLn7XzEaX4UvIDPaU5nsQ5BevVRKp988FsSEyT/lI2pNJ+TDTE+IuGK
 MGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249313; x=1737854113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzfXtdeXTxj7aTbAzBirn5FPQKv+kTN3iTkNh9s4tgA=;
 b=UjeNkxGQYzG+3z7J2QSN/WnOK6rj3bekWFQW1lJ9TvRbJQl+7Io+jqA0DozGR0FC1R
 +x3fWA7iq4myb69wgaLErRgYEdcr2JS8koNbFos5cHG8Hvqedc8g12vfuaR8W8c8S3MY
 D/9424SPFQqeiKnRtYi87jyJN0+BTGnXoaYXJM86fouy23TUoiI6WaVMgdH+P/uKtbiP
 VV44oR/f4SyhUB3+cFKJHZcr+nr9KLfUUSk/EkPdl+FojYB0VoRshkyT3LI21n+jzSrp
 NaLQWRBMWStu2OBxinSeTrLR8KXGABO/eP4ZzwwUGoQEDyDJC5ZhuRoKhZ0CZE0jjbiU
 hOQw==
X-Gm-Message-State: AOJu0YxCF6PKtvLJutfwtuIKMiSNLeYb6PR37Buv91x0qUdRyH1jkBG2
 nE3Fu8nVrZ65xJlwsn/msj34XzTr/1rhscEl+V7amgkzvOW5bxEBCHlzobjY
X-Gm-Gg: ASbGncsAT2G/CoqC3zQVCth11dllgD3kUa31e1+pc2N4BgUJob17y/bGSU3USexivsD
 0twAku5aFp7Kj9dUtoFiJRTu7367ikswVFu0urvHbVIoWb2sxdYtJnQG4ETJ/RMno5M+cwbxuEs
 31QupOZUn363zUQ990KOrEz3HBFbS6axShEhk+6IjnhiWN58Q16lQ4Z7x4ePxrJPrx3LbMrJAhB
 DhUldukd1nH7PXkEv7fp/ih2o1XqwUd3v3kspoMqqWl+4VgrGo+8vLx2fT7IwXQhib+FNdcv6Vc
 nUjsQXSQMNQB+ad9VTt6cEj3ixxTtT0B3mYTBqc4c5IBvbZKplah3UEnGQldJJ//rgf66PjbeQ=
 =
X-Google-Smtp-Source: AGHT+IGYZZnjhmL71CCFCjdBgYBw2Uev+rwgEBjj6Ph0MjMt0EOUVrqBOXLulB5LThTt++1g1CJbdQ==
X-Received: by 2002:a17:90b:2703:b0:2ee:d63f:d71 with SMTP id
 98e67ed59e1d1-2f782c7252dmr13256054a91.14.1737249313128; 
 Sat, 18 Jan 2025 17:15:13 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:15:12 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 44/50] target/riscv: Add Smdbltrp CSRs handling
Date: Sun, 19 Jan 2025 11:12:19 +1000
Message-ID: <20250119011225.11452-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Clément Léger <cleger@rivosinc.com>

Add `ext_smdbltrp`in RISCVCPUConfig and implement MSTATUS.MDT behavior.
Also set MDT to 1 at reset according to the specification.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-7-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  1 +
 target/riscv/cpu_cfg.h  |  1 +
 target/riscv/cpu.c      |  3 +++
 target/riscv/csr.c      | 13 +++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a3acda4bc8..f97c48a394 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -559,6 +559,7 @@
 #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 20e11a5bdd..aef896ba00 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -84,6 +84,7 @@ struct RISCVCPUConfig {
     bool ext_smcsrind;
     bool ext_sscsrind;
     bool ext_ssdbltrp;
+    bool ext_smdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9e1ce0e1f1..e3ed11b0fd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1064,6 +1064,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
             env->mstatus_hs = set_field(env->mstatus_hs,
                                         MSTATUS64_UXL, env->misa_mxl);
         }
+        if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
+        }
     }
     env->mcause = 0;
     env->miclaim = MIP_SGEIP;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4aded3f00c..afb7544f07 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1954,6 +1954,13 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         }
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((val & MSTATUS_MDT) != 0) {
+            val &= ~MSTATUS_MIE;
+        }
+    }
+
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
@@ -1996,6 +2003,12 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
     uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((valh & MSTATUS_MDT) != 0) {
+            mask |= MSTATUS_MIE;
+        }
+    }
     env->mstatus = (env->mstatus & ~mask) | (valh & mask);
 
     return RISCV_EXCP_NONE;
-- 
2.48.1


