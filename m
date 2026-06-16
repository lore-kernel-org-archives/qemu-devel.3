Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20818CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQht-00026Y-US; Tue, 16 Jun 2026 06:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhh-0001h1-0d
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:33 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhf-0003TP-BE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:32 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c8588ec1b44so3010684a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604450; x=1782209250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5q6ISXs9OA63MoSetz0QM2GNUXYBRusOLOcdCa31BY=;
 b=kjfBnL5WsOnq6KBxc4x+iM2ncchEk8Yc7PeR7ZX4AzjnYnYz9Vbt5lTHfMruLahYFO
 cCDbpL+g0G3gF562Zy1pzG9z4PR5r4Hbpwjyko/oT2vLOGb9OtARzqbapVTvTNBoKbFj
 //SiPXrA81ltUNLBVPfbuY6iNMo+ww26mF1SwDXmwkNmvHaHA6GLmsPinwvzxKVWiMAr
 DKOrua3Vk9VLsAVK3RK0QJvygOFx/H8A3O8Co0xX7Co858KIZUplDtsC/ZrNpo62r0IA
 3ON1CoWlAOcEGgYxuI8usjTmX54Q7PFPr4anIrs5yTsxbFOhwyiufkXelDJOwtTyrRjy
 /x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604450; x=1782209250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b5q6ISXs9OA63MoSetz0QM2GNUXYBRusOLOcdCa31BY=;
 b=XGkrNYXn3koTrNmuUH2P/5V7TU4n8GWmHAWVkk7kmHeHcW/tOSovSSytoJqY9p2gUx
 qJ022NF0l+gH2EIl2huUioLB2oxpZkg+B7Y4zqLx7DV/JWcjBM/XTtyqQf0jOsluXEr4
 x/Felh5dI+wGh8N7inIjcKAIQEWh+N1MAaN2epG/QWjQrqx2k1ccaz9MLMAufdEytGSU
 vF/Hl1vnSD1wLDULP2hpiFb//sC1FeZuvlTuuY3t5n/HkIaV91CSOizYAsVJsWaUcf6x
 Mfonb2HOCis73YanVi+/hnQuHtZBtm7nRAsUbdkhV/bzp2wrF+kUMMjuFaTr7NlQZJI8
 MsBA==
X-Gm-Message-State: AOJu0Yydf2s6Kd5LaCbzMro7rcT2w8JVc5iyNXG9VCqjBipsI0FJpq+S
 Rkar/wIBc6aTm1hZxbmAv6RT9p3319M4hLIPbLXzVcPOR/HdEUtGGnCCJGsMiBwU
X-Gm-Gg: Acq92OEEgEjqbIDzC1ngkL2NI1WBZNMgLG+P5TBKjmr5RlFn+7NHfouocc6XlFQcqR4
 tgfe/RkkBWFOIMi3pkKTWZV5BCNOKiGN+CR7uEwdKgl1/DFd3kpN9q0PQktSrHgJWbbP9P2yOQ4
 v1iT7CVKEY7AVDcr4TQE87WE9+almyRTEVs6C/81r/D1MasAocg6C/IPLHm2Q9NMW6EFDQYyaxM
 hCKhEQf906biQjRsVLf9EsjyAOSCvTBIGDBg1vnkxgeCMV8GLT197UJ7p2/AG3GusIUtSUzTG+0
 HUku+zlZNibVhtbjhFZxdzfrHjSXX1gPiS4JUqfjj+9VZWAOuwkeo5dxrexaQ9hIO6GIKvG6k5a
 2ZN357G87MXWJRjON8yARyp7vwB4q3Xll7zlFP2n0lTgiwmUxqUrET2Val4VsAaF18N5ClRDwLQ
 Av/f06NRNWb4VqYkmQ8J2exdGLOQ/pGt4rRTv8oaos
X-Received: by 2002:a05:6a20:1615:b0:3b4:736b:da61 with SMTP id
 adf61e73a8af0-3b784193115mr21608195637.35.1781604449989; 
 Tue, 16 Jun 2026 03:07:29 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/83] target/riscv: Move debug.h include away from cpu.h
Date: Tue, 16 Jun 2026 20:04:36 +1000
Message-ID: <20260616100527.1939565-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Anton Johansson <anjo@rev.ng>

All debug.h definitions except for RV_MAX_TRIGGERS are internal to
target/riscv.  Move RV_MAX_TRIGGERS to cpu.h and include debug.h from
all translation units which relied on the cpu.h include.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260520125406.28693-23-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         | 2 +-
 target/riscv/debug.h       | 2 --
 target/riscv/cpu.c         | 3 +++
 target/riscv/cpu_helper.c  | 2 +-
 target/riscv/csr.c         | 3 +++
 target/riscv/debug.c       | 1 +
 target/riscv/tcg/tcg-cpu.c | 1 +
 7 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8726929bd3..644a08ea5a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -187,12 +187,12 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
-#include "debug.h"
 #endif
 
 #define RV_VLEN_MAX 1024
 #define RV_MAX_MHPMEVENTS 32
 #define RV_MAX_MHPMCOUNTERS 32
+#define RV_MAX_TRIGGERS 2
 
 FIELD(VTYPE, VLMUL, 0, 3)
 FIELD(VTYPE, VSEW, 3, 3)
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 066e9c585f..55a3ac72e6 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -25,8 +25,6 @@
 #include "exec/breakpoint.h"
 #include "exec/target_long.h"
 
-#define RV_MAX_TRIGGERS         2
-
 /* register index of tdata CSRs */
 enum {
     TDATA1 = 0,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e792655cc2..7fb426b697 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,6 +38,9 @@
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
 #include "tcg/tcg.h"
+#if !defined(CONFIG_USER_ONLY)
+#include "target/riscv/debug.h"
+#endif
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 57e6f8217c..be36dca8f1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -34,7 +34,7 @@
 #include "semihosting/common-semi.h"
 #include "exec/icount.h"
 #include "cpu_bits.h"
-#include "debug.h"
+#include "target/riscv/debug.h"
 #include "pmp.h"
 #include "qemu/plugin.h"
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4dd6c93e51..8b1de77b7a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -31,6 +31,9 @@
 #include "qapi/error.h"
 #include "tcg/insn-start-words.h"
 #include "internals.h"
+#if !defined(CONFIG_USER_ONLY)
+#include "target/riscv/debug.h"
+#endif
 
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5664466749..30d39ee5cd 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -27,6 +27,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "target/riscv/debug.h"
 #include "trace.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f8b2f04a94..21886e5d39 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -37,6 +37,7 @@
 #include "hw/core/boards.h"
 #include "system/tcg.h"
 #include "exec/icount.h"
+#include "target/riscv/debug.h"
 #endif
 
 /* Hash that stores user set extensions */
-- 
2.54.0


