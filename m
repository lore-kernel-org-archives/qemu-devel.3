Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158CEC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Px-0008Pb-S4; Thu, 09 Jul 2026 22:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pl-00085v-RD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:37 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pj-0008P0-RC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:33 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so284990a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652190; x=1784256990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UlRcCZ0xQ13CfZH7EKA1IBOPfSdKOe0BjYRzNuSM86o=;
 b=B8oB1JDqkU7W9vgzhmmiCK6rQwb74BPrBrMGbj/v3VpIGT0IeOOHOifsilvFg/cnfW
 33gvtdcQoz9ZxKS8+UT1Ewp5AKDlv9SFPlmqnyHRz8tnQfKyeWTeUHUmeFGWZcfqfDKt
 63Ms9oseSZVppzMd0uFthorJWEo+i+H1t0TxPwm8LYYm06wzMsB01r2avNTUal/Hb1h9
 Kiv/D2p8HskVpdC6pIeEEOEKP1mMDxbczlJ3t5EkW6Y+JH0iFN4vUHsK3ImKf3LGg0xZ
 7+jjS8fVx6DQH8J8xrro4T5UWLoHBFl9rOewgcghpBe8tZjlj7PDsU6iXOIMi4CJEDqO
 BCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652190; x=1784256990;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UlRcCZ0xQ13CfZH7EKA1IBOPfSdKOe0BjYRzNuSM86o=;
 b=eryfzX7ecsa5HbPUBfWUkdcnDPo0XIPsiDEXyeXgzhtxgIyPIRhwMHR9Gjke7b8VXN
 7P16LDB75mXq78lUiEAy/hW80l3LQNq1/H9jPTbY0CzP6y2DlVrDQJhSNTvfntpvh+9V
 W7pt73b/ao04NJwpRMhC/3Q/6qBySp16Bo8M3SCiUtGf5OfuWyEsNANap96RqNFgCErH
 cgthaocoOeckfw9f0zUcI/1qoRSxDjIkr+yQTfXE4vxYn3sMhtfPX0ns1iWy5mrOHlLa
 +S8vgKCKq1XNg6JjzPhsBLDm4z+LYJCqb758Z0bcM30SfYnksiB4fEzSGOusBeYT+sTK
 nreA==
X-Gm-Message-State: AOJu0Yweojb0aztezJfKLgTAillGLo0LCRR2NWWf+DOhnqpe43+yQj6H
 PokapLEU5MuwunbGbWo67ktRx4hvI5/Em6Y5Lg4YP1ozWlT6l/4lquxBXZlA6A==
X-Gm-Gg: AfdE7ck1Sh1PQ41p4csWy/f+ndUWTqD224wN0p6KJp4/PaiRpLQUaLDgXF31Vkpf0AC
 iQsGkLYBHxkIUBACFTaqdJ7a5IiXVz1kM9g43k9SrEIxIX/vtcoSgI3ocsQgASQgqvHwtzhzMkm
 KeLaBp1nI45n7atAbA8sUyVh2XIAS23hHLyFR6Nakd2bijxQoKl+62zx6nINwp92+xI5gWVRFHo
 fRT3OcTe9i5Yj5kxxHfuiwBE59TuFQ2VCBbTUmrq+kx9dPlN3O7+eUIZzVFY4puDQtHaEA/I+NH
 GJfo39tib67jwMe3eDdwlx1PRqPCo6Ogl2HHIL/jqz/WTsi28RbLos6NRc03IMS5XVUvlLlekey
 CA1N4D3LD4Cnaz2cXM0GBNpTjoD+MpoH7T9KwT1ifG0cUCEmWH5BvmfpFC89UXtJmNchlp726fB
 jE1GXZpEtCb1qplUXmbqda/nh4A1KRTzA1hCoxDLlinA==
X-Received: by 2002:a05:6a21:6b02:b0:3bf:a1e5:ff53 with SMTP id
 adf61e73a8af0-3c0bcb7e330mr11756383637.48.1783652190535; 
 Thu, 09 Jul 2026 19:56:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/40] target/riscv: move csr.h to tcg subdir
Date: Fri, 10 Jul 2026 12:55:01 +1000
Message-ID: <20260710025525.1704417-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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

After KVM is no longer reliant on csr.h move it to the TGC only land.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-11-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/{ => tcg}/csr.h  | 0
 target/riscv/cpu.c            | 2 +-
 target/riscv/gdbstub.c        | 2 +-
 target/riscv/monitor.c        | 2 +-
 target/riscv/riscv-qmp-cmds.c | 2 +-
 target/riscv/tcg/csr.c        | 2 +-
 target/riscv/tcg/mips_csr.c   | 2 +-
 target/riscv/tcg/op_helper.c  | 2 +-
 target/riscv/tcg/pmp.c        | 2 +-
 target/riscv/tcg/th_csr.c     | 2 +-
 10 files changed, 9 insertions(+), 9 deletions(-)
 rename target/riscv/{ => tcg}/csr.h (100%)

diff --git a/target/riscv/csr.h b/target/riscv/tcg/csr.h
similarity index 100%
rename from target/riscv/csr.h
rename to target/riscv/tcg/csr.h
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ba75c0de39..c5b03847bf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -24,7 +24,7 @@
 #include "qemu/guest-random.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 #include "internals.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index a2bbaf7f07..f0a5e0d86f 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -21,7 +21,7 @@
 #include "gdbstub/helpers.h"
 #include "cpu.h"
 #include "internals.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 
 struct TypeSize {
     const char *gdb_type;
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 7aacd1d89c..f8042db9cd 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -22,7 +22,7 @@
 #include "qemu/ctype.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index b94e8391ed..2647deef91 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -35,7 +35,7 @@
 #include "system/tcg.h"
 #include "cpu-qom.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 
 static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
 {
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 9c7e9d0e4b..36f2004bc5 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -21,7 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 #include "tcg/tcg-cpu.h"
 #include "pmu.h"
 #include "time_helper.h"
diff --git a/target/riscv/tcg/mips_csr.c b/target/riscv/tcg/mips_csr.c
index 609718f288..884030e91d 100644
--- a/target/riscv/tcg/mips_csr.c
+++ b/target/riscv/tcg/mips_csr.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 
 /* Static MIPS CSR state storage */
 static struct {
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 6d4849b135..ba3c7da375 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 #include "internals.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index d93563c36b..41b55519a8 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -23,7 +23,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 #include "trace.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
diff --git a/target/riscv/tcg/th_csr.c b/target/riscv/tcg/th_csr.c
index 431f4cc286..e6f642991c 100644
--- a/target/riscv/tcg/th_csr.c
+++ b/target/riscv/tcg/th_csr.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 
 /* Extended M-mode control registers of T-Head */
 #define CSR_TH_MXSTATUS        0x7c0
-- 
2.54.0


