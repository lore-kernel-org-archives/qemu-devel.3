Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17256CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwW-0004GC-Dm; Wed, 07 Oct 2026 05:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAQ-0004ZV-PA; Wed, 07 Oct 2026 04:38:26 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAP-0006Yf-7O; Wed, 07 Oct 2026 04:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=1QtxErAwu660kB/UzGkbIpVGSr2Gvl//r6cuPR/bU+g=; b=ZtXwXtHrb4XOmAD
 w3UpHhotrWkCUO099agInNvoByV34Vcbg5LDvflTMMmwQex+TMkS1yp5HOmU6Jn/yd84ADWZWRV8J
 iXNpwZLVvx4yySwC3Cdxn4dKbm/4KjG2MSRem7muwvyNGrFllCnNGLt/Tq1rsOwu2P3R2nCyKRECc
 D4=;
Date: Wed, 07 Oct 2026 10:43:21 +0200
Subject: [PATCH v2 15/18] target/riscv: Compile arch_dump.c once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-15-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=1591;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=cRkiucGLVhuUsQuyMT8GenEJyKRclZNbAtgMX9lvSDg=;
 b=Sr4s0NKfRnsi3kbtlZFcxR7hI4B6Yl8aEIndNm07d1jQC/lZjJmgZTdKjeYm4t8pz7EGUVtIJ
 nf+aTWJcqwCDM87SA5dBDALtdPSl58tM+FAyMld3QImWccxINLJbHVa
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/arch_dump.c | 13 +++++++------
 target/riscv/meson.build |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 12b6879907..3276c00128 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -17,7 +17,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "qemu/target-info.h"
+#include "target/riscv/cpu.h"
 #include "elf.h"
 #include "system/dump.h"
 
@@ -175,11 +176,11 @@ int cpu_get_dump_info(ArchDumpInfo *info,
 
     info->d_machine = EM_RISCV;
 
-#if defined(TARGET_RISCV64)
-    info->d_class = ELFCLASS64;
-#else
-    info->d_class = ELFCLASS32;
-#endif
+    if (target_riscv64()) {
+        info->d_class = ELFCLASS64;
+    } else {
+        info->d_class = ELFCLASS32;
+    }
 
     info->d_endian = (env->mstatus & MSTATUS_UBE) != 0 ?
                      ELFDATA2MSB : ELFDATA2LSB;
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 8d0b3ed4ce..28a6ff8553 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -22,7 +22,6 @@ riscv_stubs_ss = ss.source_set()
 
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
-  'arch_dump.c',
   'monitor.c',
   'machine.c',
   'time_helper.c',
@@ -36,6 +35,7 @@ riscv_user_ss.add(files(
 ))
 
 riscv_common_system_ss.add(files(
+  'arch_dump.c',
   'cpu.c',
   'riscv-qmp-cmds.c',
 ))

-- 
2.52.0


