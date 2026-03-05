Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF96EFCE5E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 03:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxzdg-000637-L4; Wed, 04 Mar 2026 22:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vxzdf-00062j-4r
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:44:39 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vxzdd-0004qw-3a
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 22:44:38 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-354bc7c2c46so4210130a91.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 19:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772682274; x=1773287074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a3yBeeMGybkxwe9xCKni5iVnrSxuTxLUIv6stZXLhh8=;
 b=CGX/4GD159OiLrd2hXJNsKKUhsxZ43qMqcps6V4v/AqTg+IKw34NzzYbOG3tHoSyxt
 oQOakt0vdT9b0mqPgL4SeJcs7T0vLpDjujc+CB00KfvWW4+r0JUMvsRmHIRODAIFoTg1
 8aXCPqP6BaoRyvQ6DQvesseyB65kL8FDB0dBCvPVxz+W8usAARmvH6bkO0whPhCAMm4O
 Bet91ksk+1bokZFHANZr8jxeiSR58NE36boPtJt8khUkSWlLOMitk7msR95trk9xy7NT
 IcXt1fhZQcPB74v1h7pY2BeRiFnUqtqKywH4cOy6XGQ4sHV9MsZysHX93uMAfgI8YdkK
 Uu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772682274; x=1773287074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3yBeeMGybkxwe9xCKni5iVnrSxuTxLUIv6stZXLhh8=;
 b=iBQnvhZlBbi/XKc/h1XcOhPKMEhZj0L6v1GsIhHPzWyL9pKs4wQOkRau/XfmtxiyEA
 g8IjGKl92YBhf0tkZPfL9oQliEZqH8OzvF+WtUMJpqOTp7Fijhur2WmFtryw4uLpUGbR
 wmbri+AhuQBXJk7kg9GND9SVzMW844p1G7acWM2QpC2d2AicQfi1PikHMmRo1KA0Bu/z
 5T3xlbfqirdyj3K3q0Ahd7i+GwWs48emnSTunGJwSMwZqD2srOtTUNfx34i/9FLPoNaB
 VbTunca8gnW69TlzKk861fqzcFlguZhP1xne9zWa6tqionPf3sxPSQNke+CGWZtFkgSR
 3KPA==
X-Gm-Message-State: AOJu0YzJeCK1+jyY79Fsnz3G4VPBNfXqxfZt7rcc2UAXdpG81DJKp2bE
 NObLpG1hU2pWN3KcbHfc8ovAevFJw+AuJtqMSjppO5FrgvPWYc+hsHVYg1BJk3Yul1DJ8c9cmKy
 p3OpAX+WL9QaGnxsD9k44fuKCjarecAAu7/vAXLaX0XpZOniYMIQ51sjqEvF4WNk8/QlknELaYz
 eM1Gqmf6pel98ZvUWpZJCOmo8i8HbJJz02Ehl/9UnuCew=
X-Gm-Gg: ATEYQzzPX2YrDHISZhw/lFvZH85eIxRu37I7mkIF75fggR/Ryaa7n45+G2I9LUHGozO
 k21Aon2CzAC3W+NqM/CkFlXzcUblniauYtEtiABgO3XLcqw7HJiUtaOvrHLphSJFMni66MrqeYV
 6dfTitQtUaISUmUimdbZRt4yQouzmuo3d0G5B4dMbo3MsAzPNFswdsaMDOdUPEjh5+wiTU1isRp
 AOajAQ8YnUiJqgt7FXYmle+mr/oe9cklMmom3JFfu3gjiaZHRurVOBUJhVYqXPoZVA3yG+OphAk
 Fd+Dwr0EQD/P9hg48oA6D8fyHG9LIL7/aZH7CsnrjgRo0ze21UYgvURRxlnY8YtTor8VDiFR6Y7
 dkjtVvHRIG/0PpOUGEQR3SP13z+FSdsknf9+d1oqGhxOFi/ha4P2dePz7kS9ZdQB2Q/MtssItYv
 8DbUqhErSUEGoN6p1wW5bqztvUMn7JYEfIeQPYRQgzcxjJAUcU99peEU6vBATvqg==
X-Received: by 2002:a17:90b:2ec4:b0:359:8bcf:eded with SMTP id
 98e67ed59e1d1-359a6a97a7cmr3383752a91.35.1772682274351; 
 Wed, 04 Mar 2026 19:44:34 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359b2d81068sm390078a91.17.2026.03.04.19.44.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Mar 2026 19:44:34 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3] target/riscv: Support Smpmpmt extension
Date: Thu,  5 Mar 2026 11:44:29 +0800
Message-ID: <20260305034429.74739-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The Smpmpmt extension provides a mechanism to control memory attributes
at the granularity of PMP (Physical Memory Protection) registers, similar
to how Svpbmt controls memory attributes at the page level.

Version 0.6
https://github.com/riscv/riscv-isa-manual/blob/smpmpmt/src/smpmpmt.adoc#svpbmt

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>

---
v2:
    Place smpmpmt in the correct riscv,isa order.
v3:
    Add note comment in pmp_hart_has_privs() explaining that MT field
    is stored but not acted upon during access checks.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/cpu.c                |  2 ++
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/pmp.c                | 16 ++++++++++++++++
 target/riscv/pmp.h                |  1 +
 4 files changed, 20 insertions(+)

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
 
-- 
2.48.1


