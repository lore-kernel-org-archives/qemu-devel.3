Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E401091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Mks-0000ri-0h; Thu, 19 Mar 2026 19:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mkq-0000rG-NK
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mko-0007ep-V8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso12358575ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962773; x=1774567573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7g1o79/xiI7Xs46q9zIQv9CFVhyUUYrJ+M0IIOYvaIM=;
 b=O1Duqzpv7RonYnY+NvPrewybF4YRgdwu8bYV8gAh10WQ350UUNHiWhk6sBo0ftp1Q2
 5mpPHjqzGtNBUCDVppQyjV6xMkyPo0axNAxNF0MmQANb0yIguEEkliRHS14JbGvc7bg3
 kJUJ0kmjefY7Bxi5Z1VpRjckv+0xfvkyqh9hJ8v26Ep1RHCIUlnTdMwEveGux/D0Y+AN
 saur7jua1v0xn52EFXj3K+2rH8BTOnSE41JvKiFNUxIbMh8GYFcRCQkEa53pSzM5hJNS
 POS6dhzmXi3l/zkEqwrLmZfI8rqYQJ+BphWSzMJSUr+jdhLZsx3dNWpywDuH0Q6fFQvg
 jTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962773; x=1774567573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7g1o79/xiI7Xs46q9zIQv9CFVhyUUYrJ+M0IIOYvaIM=;
 b=bPYG2npvMwgqVKSmDie9cuh0Ljt4azRecRD6x2uz6p3oTNOEtlmRaH14JFhMDUeKnS
 tPkg8GRdFdf6FjCZmYOaGNlAg4Nj/Vt14Sxk82uDD5s94Na/pCrlONP5tOqDXMFJroSl
 mSS9Pa9Ap35wCMm6eC0n3B8Pulr0pLGy032mT67bpSvYs8QGgLtbKCUuW7quld9LSsQH
 QBCPhspByJidbTq3Zt5//0rl96ZMF7H13iUqAZPUulAbSJ6RUmiNFQuKnaTqADlfN28b
 OkBDC2pRfNxbhPZQUPz/FcgGbWx6nDKzDPsxjIO1EN+6qryogNIEEeH6k8yRmfLxoMO8
 8vSQ==
X-Gm-Message-State: AOJu0Yx88U1DHIdPDMAE1KXFFAQTxp8a9cD/mxpZXnOrZfBFCAH18Rrk
 veJoZ698Np5ZCXfBsN38hFW45Ci8StNPg+3iK7kqos7SimDyFP4M1VRo43AFCw==
X-Gm-Gg: ATEYQzyuovGrz26MAppe2ZFjgDYVFBN+hytli6FonR/YkDsxZfUQLTzaQ7QsGTzGxpX
 DtusROxBwjTmWgIQzXMZ1bfIC3uWqn5nXYaQraBjIC//Zc3QCql12tvDDCsT5w2rxVyl0iPUGqb
 FtmCkCcxAcw3L+VN+k1EOpDbrBSeFvsXHFc3u5HSKijAO469dDF7mAvB8+Wb9uitaVkugHlhLot
 oq2rdfJjPUmzWioZYFNvfprtCBy6KHCtGbmryBG1UycjwzLXJ5877RlCJzoOIXKMU42NFW1Ix8E
 916Mz0/Mp0/LFQsrkBKPsSAXlyLvbrs6qBF4PPwtINa+Mrjdy+eNRjsgSs6TnRpkhbxqkHvZQwS
 RzWTO2z13akqXCawjudU4Kz2kOIRO02JzyQHZGFrl27OcNEBt9niojRpdM2KqmnmeEv3N8pK79D
 0IEUntOavhmflgkjHd1Oe2oc043KiQLEpq0dTY6V4DbrXwj6sYPMqH
X-Received: by 2002:a17:902:ccca:b0:2b0:53b6:d0a4 with SMTP id
 d9443c01a7336-2b07717eda0mr39169455ad.12.1773962771658; 
 Thu, 19 Mar 2026 16:26:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:26:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/17] target/riscv: Support Smpmpmt extension
Date: Fri, 20 Mar 2026 09:25:15 +1000
Message-ID: <20260319232522.1867400-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: Jay Chang <jay.chang@sifive.com>

The Smpmpmt extension provides a mechanism to control memory attributes
at the granularity of PMP (Physical Memory Protection) registers, similar
to how Svpbmt controls memory attributes at the page level.

Version 0.6
https://github.com/riscv/riscv-isa-manual/blob/smpmpmt/src/smpmpmt.adoc#svpbmt

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260305034429.74739-1-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.h                |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/cpu.c                |  2 ++
 target/riscv/pmp.c                | 16 ++++++++++++++++
 4 files changed, 20 insertions(+)

diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 271cf24169..467fb6b4b1 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -29,6 +29,7 @@ typedef enum {
     PMP_WRITE = 1 << 1,
     PMP_EXEC  = 1 << 2,
     PMP_AMATCH = (3 << 3),
+    PMP_MTMATCH = (3 << 5),
     PMP_LOCK  = 1 << 7
 } pmp_priv_t;
 
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 70ec650abf..cd1a5ec56b 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -59,6 +59,7 @@ BOOL_FIELD(ext_svadu)
 BOOL_FIELD(ext_svinval)
 BOOL_FIELD(ext_svnapot)
 BOOL_FIELD(ext_svpbmt)
+BOOL_FIELD(ext_smpmpmt)
 BOOL_FIELD(ext_svrsw60t59b)
 BOOL_FIELD(ext_svvptc)
 BOOL_FIELD(ext_svukte)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9be79622f4..8ac935ac06 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -223,6 +223,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
     ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
@@ -1276,6 +1277,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smpmpmt", ext_smpmpmt, false),
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
     MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3ef62d26ad..5391caa59c 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -165,6 +165,18 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
                           "ignoring pmpcfg write - invalid\n");
         } else {
             uint8_t a_field = pmp_get_a_field(val);
+
+            if (!riscv_cpu_cfg(env)->ext_smpmpmt) {
+                /* If smpmpmt not supported, clear the MTMATCH bit */
+                val &= ~PMP_MTMATCH;
+            } else if ((val & PMP_MTMATCH) == PMP_MTMATCH) {
+                /*
+                 * If trying to set reserved value (0x3) for MT field,
+                 * preserve the original MT field from current config.
+                 */
+                val = (val & ~PMP_MTMATCH) |
+                    (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_MTMATCH);
+            }
             /*
              * When granularity g >= 1 (i.e., granularity > 4 bytes),
              * the NA4 (Naturally Aligned 4-byte) mode is not selectable
@@ -355,6 +367,10 @@ static bool pmp_hart_has_privs_default(CPURISCVState *env, pmp_priv_t privs,
  * Check if the address has required RWX privs to complete desired operation
  * Return true if a pmp rule match or default match
  * Return false if no match
+ *
+ * Note: The MT (Memory Type) field from Smpmpmt extension is stored in
+ * pmpcfg but is not acted upon during access checks. Cache attributes
+ * have no functional impact in QEMU emulation.
  */
 bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
                         target_ulong size, pmp_priv_t privs,
-- 
2.53.0


