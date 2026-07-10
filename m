Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309E1C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1PN-0007UQ-2m; Thu, 09 Jul 2026 22:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PL-0007Tt-Qw
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PK-0008Mh-6T
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so4027455ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652165; x=1784256965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hr+ttuZTMs4CfGWiw8ZM5PdRhuEWoSVW3Vb+w4EkIrE=;
 b=mICe3t1AVTMvb7IDzdqhX2ZjWUIRfzihVlANcPwQeyu4oQ52d1DQ/pkfqpQ31NYsFf
 u8jS7tUsY9jhIc4EpNv779p0caC86dR/1tMCbzTPOWlwTuVwnKBDGM/qEmQKpeqa3ud/
 vDg4HgPWEbs18t5wfmSZw2v0nn6JT4HKZh6yFLOkyXiWPDnmcnTxiX7VXkNS6ib80KSr
 mekMwgu1AfDlsty1ds+eRIZkd/LXj2qg8Mifkp68C4LiOWyuX3ArqLzb49RCnQEPviH9
 mirm11Y6NRHWWAFZsnNkTsyck5UlZh3K63HdIH/HdypuaQNUtXNDd+5HMuAmwkxtdRFg
 kGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652165; x=1784256965;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hr+ttuZTMs4CfGWiw8ZM5PdRhuEWoSVW3Vb+w4EkIrE=;
 b=PRaFdW0IEVfk6zyTYWtS+Xwcwt5A4qmMJGuz91mGjyz/ZmJzPqri6n7AR0uFNiU/aF
 pNHxdfcESEUGighxfk06ps0R6viaRcwecxKV6EqPGWWqobPLGC6RA8hPRYki+7EVZhoH
 dcDC1t7S4wEMfXznQI6pakLz6So6BLCsxJ5v0ViDvsGyB26WzI3KmMGzGHR6o53CuHi9
 hy28AqaPsduARbIbGlUsQPc7Hm3kHcBd7juSgpA2Fk7K5RlchO5XoOOmBk+ixdq93C/a
 VqZDPlp7RWBaTXh07l8+U1RN4BTaX0Jr1RmnQ+26IYwgYyeYFVQP6j+fsof2Wf6+ZuUq
 3+SA==
X-Gm-Message-State: AOJu0Yz5J6aRTumeQCWKcZNZJ2TOSI4blb8dImos4PfcfDvo99VcHq2W
 SLxvngOnZdZxy44NOboiPMv9eF7KyAOiNybwZFPpmxcEVcb84eKwjNULN2KqbA==
X-Gm-Gg: AfdE7ck8FAnIfTlOmnlEU+QRLPRBeAOufNixx/lfqGij9iKTODicqXuojkEabI9Nq7b
 luZUmrIAJdHicyxXdAMM4h0mapiWIWJcCYyNB72YuNJ7QEzknuJYUGFk2NYJdoBSNjnMJ/RqWGO
 INnQuiqErtRQyqur71PyoztF4Hx8AEkXVEV2Kf/Q5xZ/wgvqIGjaC1yf+3me2F9f4Qyu6bidYww
 49h3FHUG/+04lBDD5J/qH1YcK/Lg0GS0VaJvzEP20sxnoNmi3d3utmZmU6dSEU81O83YmonlWz7
 OiAqZBRKywaJ9LxiHidAzIVb/tMI/NCArlyNW9R5x5XNxYFwF8CC3GkWNaGBC87f99jY6LCnWIy
 omZ4HN5i1jD3jWgNOn/BAMF/NO8uhsYZjJ+GH+PIfD5ghEAOPr9aU9KY17e53Wrl0t/mm5mWWXZ
 6tZ4IgCoaKogFWcT6CC6l1kxY6EUtj6bA=
X-Received: by 2002:a05:6a20:a10e:b0:3b4:84c5:45c8 with SMTP id
 adf61e73a8af0-3c0bc9c0074mr11975394637.24.1783652164772; 
 Thu, 09 Jul 2026 19:56:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 08/40] target/riscv: move valid_vm_* satp arrays to cpu.c
Date: Fri, 10 Jul 2026 12:54:53 +1000
Message-ID: <20260710025525.1704417-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

These satp arrays are used internally in both csr.c and in cpu.c.  csr.c
is going to be moved to the TCG subdir in the next patch, and we want
the satp logic to be available for KVM with --disable-tcg builds.

Move these arrays to cpu.c to keep them available for KVM with
--disable-tcg.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260703180538.3346781-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  2 --
 target/riscv/csr.h |  3 +++
 target/riscv/cpu.c | 13 +++++++++++++
 target/riscv/csr.c | 12 ------------
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bdd28d329b..82362ef8d8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -968,8 +968,6 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
-extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
-
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index c791260f83..66ec9546ed 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -72,6 +72,9 @@ enum {
     CSR_TABLE_SIZE = 0x1000
 };
 
+/* valid_vm_* arrays are shared with KVM via cpu.c */
+extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
+
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7664e686fa..cae4e96232 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -65,6 +65,19 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
 #define BYTE(x)   (x)
 #endif
 
+/* SATP bits that are shared between TCG and KVM */
+const bool valid_vm_1_10_32[16] = {
+    [VM_1_10_MBARE] = true,
+    [VM_1_10_SV32] = true
+};
+
+const bool valid_vm_1_10_64[16] = {
+    [VM_1_10_MBARE] = true,
+    [VM_1_10_SV39] = true,
+    [VM_1_10_SV48] = true,
+    [VM_1_10_SV57] = true
+};
+
 bool riscv_cpu_is_32bit(RISCVCPU *cpu)
 {
     return riscv_cpu_mxl(&cpu->env) == MXL_RV32;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7168a4dc12..7818d81fb0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1875,18 +1875,6 @@ static const uint64_t hvien_writable_mask = LOCAL_INTERRUPTS;
 
 static const uint64_t vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
 
-const bool valid_vm_1_10_32[16] = {
-    [VM_1_10_MBARE] = true,
-    [VM_1_10_SV32] = true
-};
-
-const bool valid_vm_1_10_64[16] = {
-    [VM_1_10_MBARE] = true,
-    [VM_1_10_SV39] = true,
-    [VM_1_10_SV48] = true,
-    [VM_1_10_SV57] = true
-};
-
 /* Machine Information Registers */
 static RISCVException read_zero(CPURISCVState *env, int csrno,
                                 target_ulong *val)
-- 
2.54.0


