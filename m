Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CB4CCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 02:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHCGV-0006HR-MR; Thu, 06 Nov 2025 21:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vHCGR-0006Ec-8Y
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 21:31:47 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vHCGO-0002wF-23
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 21:31:46 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29599f08202so3480515ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 18:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1762482702; x=1763087502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DY6gp++mEiAa25/v6nXiBTsLV9urICNYQrtoFh1K61s=;
 b=K4UFcDkfHvCdbh/EPfFMh/lVgNL0E/Mlk5jI2L/+IgVyAEy3kgIfHGXRuqBQCLChRS
 X/phWsdypObX6NXUCB/qJN6tvoAtbMGvorvyZwjZzhNZExFW9OsUJb/pMDjsPX7tizng
 9jbs4CHZ7hW210iCumJ4abMAGpCCcpjlmoLFmSPR5ouIoSpqeGhzdfZDFuznNAUIbxM6
 3gtVg5zNucOq+ebApPqAglxWEGC5sWAF2MkMQN9UKa9eHcq3mFHcQrOErFiK8RktFTga
 Lu3rGUUxiC/lQLKQp5YZ/o8pqxKWG5xDqABcM0SeS5+YY19zqk68TaVI5DsZLo0trd8v
 5VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762482702; x=1763087502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DY6gp++mEiAa25/v6nXiBTsLV9urICNYQrtoFh1K61s=;
 b=b8e324MzftNp8jqNWe0N2jpKlfwnFTImkhSH2Tf00GtCKu9bHn5IXeJQ+oZZvgMlcW
 0F7F9ky6nXJSbGmHStdf3eDxIe1zJ8Y2rCc8GkY0PvvpRtZXFMuUI+RvQeoCV1xwOfVj
 UBurlCSdARPzgHtPHXKqgkPMYofE9pQcUnptvEQUkw+jmL3UiHFwxzVobevWq4zrxPku
 chBq9+rwhyzTCfpZNFZcuAe30+9ZQnoYYmNYbxAsS9SVCeU1a5S1EWBOJ7018YSWbcG3
 2X8jdZX0Qzcop8FqUhrj+6uPhb9dxoeCSwJ0nQWLNT5iyJESjWdq9DcC6v7oD5tD5JPi
 WrJA==
X-Gm-Message-State: AOJu0YwFOWhMEILQEcbATQKNTC0c03GiMVi4WinqOTKAMiS65kUyDVG2
 RYk3sXh4gfeYrkcJVbcW8P1LbG1QzTF9WBeLpZDYfUVectnKRGOAEhhGmuU3KOCk9kmbAPD9g1v
 x6ClqYZe+Bc85rAw7C6osMe+Kvkj7YeQVjSz/mL8pEQH0b2K6K3vjBHMs05Pqxia4yWI8YT+KXx
 sH2UuwJw8uLmRUuqi/XqLcHw1nS+DzVKi85BAUaERq
X-Gm-Gg: ASbGnctUpywarri3yTuNdBTlaeD44v5ZPARxMAiDWU/9DIo70TaGgWcbPuMIzwPE+uH
 crDsFkCMqoz5Y1GJVY2PkSahXtzDmG1nDGIq5f77uC8puwav/Uk0148NkJynz962FawW56/IUrY
 5KjaeuCvqlTiP6orp1DATdio07U67Yduhj2b4662lsQFs++bvyzRblFoymXxSk9KXRLCSRTHoz8
 1X0oJ5pAKoFnOqHidCJrt0to37QFy5XqNtR8gRbf/VJE1WrmwUz10fJFhhwMAAlJtLT7I8vVrl3
 9febzOyx0cGEeK/nWjyWi0O0G0zdQ+8pLwQG8tSXwIn+nwy6QgnhYOYIwOs+NwClge4ZCqPPiJ+
 Utg85X40MJ7f0iIBhsReGsNNYBAk512CM9HtBrWcIG6PzPBrYcuRx3Pq66dPekCcbsm+ZcgnNV5
 LvxJvs0U9EEJZlUs31Bw+86n39vf/71BZy+yht24I=
X-Google-Smtp-Source: AGHT+IECF1HWgGebGi88d+FEvKlKfn+1in6jeeypiKZ0z5+1xcsFi/GL2HgtqzESO0AM74WSiNGZgg==
X-Received: by 2002:a17:902:ecc9:b0:262:9c4:5470 with SMTP id
 d9443c01a7336-297c044f7a3mr22379935ad.28.1762482701781; 
 Thu, 06 Nov 2025 18:31:41 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.208])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651ca1eb7sm43499775ad.89.2025.11.06.18.31.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Nov 2025 18:31:41 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2] target/riscv: Support Smpmpmt extension
Date: Fri,  7 Nov 2025 10:31:36 +0800
Message-ID: <20251107023136.89181-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/cpu.c                |  2 ++
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/pmp.c                | 12 ++++++++++++
 target/riscv/pmp.h                |  1 +
 4 files changed, 16 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ae8b721e55..0760ee7d9e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -203,6 +203,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
     ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
@@ -1262,6 +1263,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
+    MULTI_EXT_CFG_BOOL("smpmpmt", ext_smpmpmt, false),
     MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
     MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
 
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a154ecdc79..b1096da664 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -57,6 +57,7 @@ BOOL_FIELD(ext_svadu)
 BOOL_FIELD(ext_svinval)
 BOOL_FIELD(ext_svnapot)
 BOOL_FIELD(ext_svpbmt)
+BOOL_FIELD(ext_smpmpmt)
 BOOL_FIELD(ext_svrsw60t59b)
 BOOL_FIELD(ext_svvptc)
 BOOL_FIELD(ext_svukte)
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3ef62d26ad..52a7677683 100644
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


