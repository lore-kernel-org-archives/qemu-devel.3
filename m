Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4BED232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6Q1-0004T4-Nm; Fri, 09 Jan 2026 01:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PH-0003dt-DR
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:37 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PF-0002pX-PJ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a102494058so12255395ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941731; x=1768546531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqVtcZ7GhetiIs9h/UKNMMBlkDbc7PuwUw9npuWelOU=;
 b=anP8Oraxx3ZJzdgySJ0OtV+7TpfSTB5P402r9za6H/bW54D34hDSKjNJe0KBWTlVP+
 g3XX/2RXQL1hF8jU8ZdyF+J9rJPwkt/FUqhGrEJXlDnTT4lbSQrNHz61LVdg38sRmJsa
 YNXGxoyUiWc8poxQDvIk+EcDHL5iEatgxlba9mNmvxt8KG0Zy7KXx7+NcWu/MPEBvoTj
 63HTvilQ0/5/UxPRDHaxHsdd5IlKor5GbJJ2r7s4zt20dOTaO8T6JYbzsFrf/qJpK3Qf
 VBi84txmD0iWs8MC/L0SUryvMjcVUz3ZsfJNPps6lrPjSKKWXYpcAk9MJSUidp11p2m3
 ghKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941731; x=1768546531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xqVtcZ7GhetiIs9h/UKNMMBlkDbc7PuwUw9npuWelOU=;
 b=i1YWuwm7kJAm3smXZadtKZM4uI8lpj59shUpW59ou/ssg4RGHMj6jVfSYCeVLZ+ZmQ
 qHVB5RfQWpc84qq6lZPnQP+o4CBl6n36WMm3zLONEAx4DIfr24tXB6uThTh4rqHAGZZf
 pt621dpbmMwFw7tRUsbpWdvss64Zt4RlGdd2OstEGmJNmlNnTS4aDj6FG+Z+EYJXm1at
 ouwullSi0zAb/oojySPeyFcpG8LWJRuyPpTe0EOatD/1A6fL3QTeWTz7cf5NUtdeut4r
 3mRJJmdfzvUR28gQLWfHQVlbk2w3HYRU8PJG2h3+N0df846wNvNIvrWkG0pRPF/fUVnJ
 VFWg==
X-Gm-Message-State: AOJu0YxeP7wv+vp1nyVPxKXsw0YWbkPjvL4jwX9KSvOqh2EVoHocx3Xy
 ZvgI2Q4nhutc0EzLE9mtulNZbhCF6NWoy9kfPzJSUU2v0IuVUONRRJK8NMTgOg==
X-Gm-Gg: AY/fxX6zNZvdRprc6z3MwDkY24id+LAurPzXAqvWoCae1DNUvGeABfNcrZVy3jBBSay
 vORmU6fQFum+kTe6R1yTKP8P7CFtjnn/rwqriGKqMRh5r840ksHNdLgKzMGXkzFwhZecd2pYiFD
 GMIjuv7hYZRO7tyMn1vrL/IpAVc6qSfRZY9Nda8d+mBl7pQfVanrYdhFv+I+4w4hsqMr2AzzSeW
 kit94q3BeBUciIUIcPVGgDtxi9PNFR6ESlODB1Hkm870+fXke7ryakIRk5BCQDrO05Vn2nKWk25
 A6ulNZzguQbtT+zmRCYt/j4qXTk6USz7Gh4UjA1pz1/ndkl+mXhIy9WiJHAQfQw+8aGwzeVT3lh
 cMlv9mAqVULsRpyVs9zDJ5KwJp03jmMkLC5dObGEv2jsLx/nxiUNzyF/QwndGeuHKizay7sUYJd
 wGEiz/5gXSgdRa85u8G5464KOokSQnuUliFx8qw/QYeCefS4vjHOYqfNbAAgi7gC32+cOGbR1yd
 QoQEzC/il+nWcb0bcQ=
X-Google-Smtp-Source: AGHT+IHNHhXh+katevCRax6EoNLn6Xv8NZqfkckDwVv//OS8cMO97CMX5yGt2MbzFrbHy1cuvRVXYg==
X-Received: by 2002:a17:903:3508:b0:2a0:a33d:1385 with SMTP id
 d9443c01a7336-2a3e39d7c25mr124084555ad.17.1767941731371; 
 Thu, 08 Jan 2026 22:55:31 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:30 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/34] target/riscv: print all available CSRs in
 riscv_cpu_dump_state()
Date: Fri,  9 Jan 2026 16:54:32 +1000
Message-ID: <20260109065459.19987-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

At this moment we're printing a small selection of CSRs. There's no
particular reason to not print all of them.

We're ignoring the note about CSR_SSTATUS being ommited because it can
be read via CSR_MSTATUS. There's a huge list of CSRs that would fall in
this category and it would be an extra burden to manage them, not
mentioning having to document "we're not listing X because it's the same
value as Y" to users.

Remove 'dump_csrs' and use the existing 'csr_ops' array to print all
available CSRs. Create two helpers in csr.c to identify FPU and VPU CSRs
and skip them - they'll be printed in the FPU/VPU blocks later.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250623172119.997166-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  2 ++
 target/riscv/cpu.c | 55 ++++++++++++++++------------------------------
 target/riscv/csr.c | 18 +++++++++++++++
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 90b3e95105..b3c0be5779 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -969,6 +969,8 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
+bool riscv_csr_is_fpu(int csrno);
+bool riscv_csr_is_vpu(int csrno);
 
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 063374be62..60abdf3324 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -545,44 +545,27 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #endif
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
-    {
-        static const int dump_csrs[] = {
-            CSR_MHARTID,
-            CSR_MSTATUS,
-            CSR_MSTATUSH,
-            /*
-             * CSR_SSTATUS is intentionally omitted here as its value
-             * can be figured out by looking at CSR_MSTATUS
-             */
-            CSR_HSTATUS,
-            CSR_VSSTATUS,
-            CSR_MIP,
-            CSR_MIE,
-            CSR_MIDELEG,
-            CSR_HIDELEG,
-            CSR_MEDELEG,
-            CSR_HEDELEG,
-            CSR_MTVEC,
-            CSR_STVEC,
-            CSR_VSTVEC,
-            CSR_MEPC,
-            CSR_SEPC,
-            CSR_VSEPC,
-            CSR_MCAUSE,
-            CSR_SCAUSE,
-            CSR_VSCAUSE,
-            CSR_MTVAL,
-            CSR_STVAL,
-            CSR_HTVAL,
-            CSR_MTVAL2,
-            CSR_MSCRATCH,
-            CSR_SSCRATCH,
-            CSR_SATP,
-        };
+    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
+        int csrno = i;
 
-        for (i = 0; i < ARRAY_SIZE(dump_csrs); ++i) {
-            riscv_dump_csr(env, dump_csrs[i], f);
+        /*
+         * Early skip when possible since we're going
+         * through a lot of NULL entries.
+         */
+        if (csr_ops[csrno].predicate == NULL) {
+            continue;
         }
+
+        /*
+         * FPU and VPU CSRs will be printed in the
+         * CPU_DUMP_FPU/CPU_DUMP_VPU blocks later.
+         */
+        if (riscv_csr_is_fpu(csrno) ||
+            riscv_csr_is_vpu(csrno)) {
+            continue;
+        }
+
+        riscv_dump_csr(env, csrno, f);
     }
 #endif
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c91658c3d..a69b9a11ab 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5802,6 +5802,24 @@ static RISCVException write_jvt(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+bool riscv_csr_is_fpu(int csrno)
+{
+    if (!csr_ops[csrno].predicate) {
+        return false;
+    }
+
+    return csr_ops[csrno].predicate == fs;
+}
+
+bool riscv_csr_is_vpu(int csrno)
+{
+    if (!csr_ops[csrno].predicate) {
+        return false;
+    }
+
+    return csr_ops[csrno].predicate == vs;
+}
+
 /*
  * Control and Status Register function table
  * riscv_csr_operations::predicate() must be provided for an implemented CSR
-- 
2.52.0


