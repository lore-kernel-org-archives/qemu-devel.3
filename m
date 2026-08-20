Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2568DC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtji-0001as-BR; Wed, 19 Aug 2026 23:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjf-0001YL-LR
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:36 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjd-00044d-QE
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:35 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c999f162c9aso1095686a12.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197592; x=1787802392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ZvrE0OJGfngMr7vtDZpzHvPZXdScoco3DbqKgkdkXM=;
 b=jVKgwCfeCfCs/OkIxKIoyiIAY/7arl4c/G+yQOiyMCEpuatVCyAvmoWmg4O4fBcBrw
 jlnnaaOTSl5IvUHFW11i8fAEd1jTCaHsVLB5HU4VSdIlCK1jLDnMCV7R6b6JR7vHzTMU
 BQ+inxqHD+qkZ0Giga52cpxf2jbq84SG9CpwN5VUiVqAHzJTC8JhUfSQk7QYjRPfWuxC
 oeoNilcqSn1yzyZOugz8OGJPrx0OeftPc3hPJBm9CSMPQtYOf12rW9WumqIveyiUVJWY
 Iwz1QW9M7rXptf+dCfVsLm6Ap4ff5A4UEn2CHLteyNKI2/1pzFhlZbdYLTsEr8AALx2A
 lZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197592; x=1787802392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ZvrE0OJGfngMr7vtDZpzHvPZXdScoco3DbqKgkdkXM=;
 b=S0prwInbqoiBBr3HXnbIPjtXyP6BUu79aQ/3AjHqZBsgJJySa2jgQpyLDdP6ToQXIM
 appV9JbYXs6peQAvKx0Y5kJbwIvTVVJMJlWVmZXMmNGvDtDqiTQMqCBZF3BCr3SV0a/T
 L6p7KV/2m9NvzILaPoMKC+jBpJ/FzI9HlswwqRHb/IGItEROv+wxl4FGxnCw3zq6v99q
 ADVbLjVlKjA81Ya5D98ouYiGvQ3ADNIikR34afjDwW/uJRcFOz7X4Avsls8CTSEzt041
 nOe23O4eJTuwJMOaGg4WT5Ccuj7nydblwOOvLprM94UTt+OJpEL50hKhThWqu4CQ5bNZ
 N/nw==
X-Gm-Message-State: AOJu0Yzeccul+QnAbb5rSzy5iCU0czZmwdMrfBVQhn0zlvYgHyqMSHLz
 mnUdxt5ZemUd7jyQFsgApbNuIrEVmfgiL62Bvup3MnGMMji1f4Z/Or/whoaDnQ==
X-Gm-Gg: AR+sD12hEHRPuRe5cID86nAtECTmv/FMDVM5aAzh0iTcT3sjjbDAsivmnby9IAsqq4U
 dNxCA1lMJl8WVDFkA3Q6W8hjYsAqIVdFwLpUeZ5d5mFXUn63uyNvIL6j8xcHED/0y4Rz6KFNTiO
 SXUyozERFG1WnJXd0hQX9TF/UWdhTSL8ek//L+2ev8KZvKYcrODOfc+4Ya9KsFnxU0YAOfcT0c6
 e7CcxgYsBwWMACTTH6Zn2bu4ghPSWadj/Pj4680aBMMfAZq7m7CLJ20Dxn1M5ZKQHS5yR5Vf7nw
 sJEtWqeXBjgnCHLo4jpqwN71WalpU+rhxFO0P6miYahr8BPvMavvQ9C78qjfsnEtQvCqUAhRYN+
 EXwqc2fbUZtjglFbx4qXk/EJO9r8VCF6jRVcHXZkwKW9psSzZGYaJtx1jcFBw6VnQ3EPK5h+mjv
 FROrWdGrc3gSRrFvRkh2MgKeH2EjgVuXSdl8F4p4PgYvJ9Ci80onkvwSddDd4G7B42gTezU3is5
 T+tqQ==
X-Received: by 2002:a05:6a21:9984:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3cd0132c618mr15438400637.18.1787197592488; 
 Wed, 19 Aug 2026 20:46:32 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: A-Shehab <ahshehab24@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/93] target/riscv: allow menvcfg/henvcfg LPE and SSE bits on
 RV32
Date: Thu, 20 Aug 2026 13:43:33 +1000
Message-ID: <20260820034430.1186695-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

From: A-Shehab <ahshehab24@gmail.com>

The Zicfilp landing-pad enable (LPE, bit 2) and Zicfiss shadow-stack
enable (SSE, bit 3) controls live in the low 32 bits of menvcfg and
henvcfg, and the CFI specification defines them for both RV32 and RV64.

QEMU only adds MENVCFG_LPE/MENVCFG_SSE (and the henvcfg equivalents) to
the writable mask inside the "riscv_cpu_mxl(env) == MXL_RV64" block, so
on RV32 these bits are silently dropped and the features cannot be
enabled. This is inconsistent with write_senvcfg(), which already
handles SENVCFG_LPE/SENVCFG_SSE regardless of MXLEN.

Hoist the LPE/SSE mask handling out of the RV64-only block in
write_menvcfg() and write_henvcfg() so the bits become writable on RV32
as well. The upper-half writers (write_menvcfgh/write_henvcfgh) are
unaffected because these bits reside in the low 32 bits.

Reproducible on qemu-system-riscv32 -cpu rv32,zicfilp=true,zicfiss=true:
an M-mode write of menvcfg.{LPE,SSE} reads back as zero, while the same
program on rv64 keeps the bits set.

Fixes: 4923f672e3d7 ("target/riscv: Introduce elp state and enabling controls for zicfilp")
Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling controls for zicfiss")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4045
Signed-off-by: A-Shehab <ahshehab24@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260726080537.13913-1-ahshehab24@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 45 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index a90449b87f..ffd751caa5 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3221,6 +3221,19 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                     MENVCFG_CBZE;
     bool stce_changed = false;
 
+    /*
+     * menvcfg.LPE (Zicfilp) and menvcfg.SSE (Zicfiss) reside in the low
+     * 32 bits and are defined for both RV32 and RV64, so they must be
+     * writable regardless of MXLEN.
+     */
+    if (cfg->ext_zicfilp) {
+        mask |= MENVCFG_LPE;
+    }
+
+    if (cfg->ext_zicfiss) {
+        mask |= MENVCFG_SSE;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
@@ -3228,14 +3241,6 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
                 (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
 
-        if (env_archcpu(env)->cfg.ext_zicfilp) {
-            mask |= MENVCFG_LPE;
-        }
-
-        if (env_archcpu(env)->cfg.ext_zicfiss) {
-            mask |= MENVCFG_SSE;
-        }
-
         /* Update PMM field only if the value is valid according to Zjpm v1.0 */
         if (env_archcpu(env)->cfg.ext_smnpm &&
             get_field(val, MENVCFG_PMM) != PMM_FIELD_RESERVED) {
@@ -3383,20 +3388,24 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         return ret;
     }
 
+    /*
+     * henvcfg.LPE (Zicfilp) and henvcfg.SSE (Zicfiss) reside in the low
+     * 32 bits and are defined for both RV32 and RV64, so they must be
+     * writable regardless of MXLEN.
+     */
+    if (cfg->ext_zicfilp) {
+        mask |= HENVCFG_LPE;
+    }
+
+    /* H can light up SSE for VS only if HS had it from menvcfg */
+    if (cfg->ext_zicfiss && get_field(env->menvcfg, MENVCFG_SSE)) {
+        mask |= HENVCFG_SSE;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
                                 HENVCFG_DTE);
 
-        if (env_archcpu(env)->cfg.ext_zicfilp) {
-            mask |= HENVCFG_LPE;
-        }
-
-        /* H can light up SSE for VS only if HS had it from menvcfg */
-        if (env_archcpu(env)->cfg.ext_zicfiss &&
-            get_field(env->menvcfg, MENVCFG_SSE)) {
-            mask |= HENVCFG_SSE;
-        }
-
         /* Update PMM field only if the value is valid according to Zjpm v1.0 */
         if (env_archcpu(env)->cfg.ext_ssnpm &&
             get_field(val, HENVCFG_PMM) != PMM_FIELD_RESERVED) {
-- 
2.54.0


