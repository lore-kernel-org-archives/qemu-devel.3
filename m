Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62693FD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO8t-0003kE-5p; Wed, 25 Feb 2026 18:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8L-0003DF-1i
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:34 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8J-00032K-AE
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:32 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43945763558so141134f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061449; x=1772666249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f1OACo2rFMFGe6rKhG2a8bSn9SFj7vp7kMmyZM+yIks=;
 b=bQnZnSbFzIrEtj20vtXefEEKTFQpqedHSQkz8q0r6EEdTZKv/5nfbA5hZh+tDwOP3o
 p51on7eLadbvl5ItE3oiKnZMKKbpLPNKUrelvzfQF1BJ4/gpgVWJ5Hx6tBOofBOq/eYG
 p9mj9vH9zPR5j6Dr8ct2lDCs9qcwGT5lp6/H9zKiJrn2/7eywkhmLjPUaAwHQYboU+w8
 qU0R1TDBXCOS8pSBWkJR2TBRrbPh9x9EB7d+xJEbAdJcqnR8VyyZpprMJohtNblsZ5Y/
 OzD517psKRtqCmVo9Hv9KRp/T/+B4daNOKiSXkFwv7DLeCe2uZdTpGTCfVAp1A64mL9N
 U2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061449; x=1772666249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f1OACo2rFMFGe6rKhG2a8bSn9SFj7vp7kMmyZM+yIks=;
 b=fvnC7jUIwJt5aSodsHLyEmD0qwZ68D7GzCyjACuuAdNwPduZfcKwZdQ9VhRQYuCzud
 9Wvb17mFYF0lC1HO6JzOObMjWgEsgo9FnAWkHLzbkICSTf7uC7VdL7QaLbMoojULehK1
 1FgGI7vM8zTyCP9xrVB5E5jMA8iJ+bu2SWE0xwrJenhbxDT5tqW+w+SqE84wgbSyZ/oZ
 nMmgpK/N2nzWduNUPhTzDTLqUsHCfXmUbNuGCk7reQ7c3NRQBQDrAn6YmtR8EthfTjBl
 Q+b8OIwmDcEqt+1Iyfu+mN0H9xu12pAR6jR6g7TY5u8lqC/Y/wHG94UXONmdLkYWrAx3
 Zqwg==
X-Gm-Message-State: AOJu0YyzHJ5D6qbi5pUFXMbdaGGPZXRisgtDryKsDAsn3jUDe6fF0yBB
 MaecrEMx61mvwTXaddBGs5mskGCq/loW6ZKLgE2KguJKc9oLtHw3LcSsPnYEU2lRfUurSiE3lgG
 XRdlpSBg=
X-Gm-Gg: ATEYQzxGn67BpC6i79KEUuMeY+4InMsvjjaJ6ukxgMtOe5JCBFJrYJ++X09lUMOUcN0
 ICbYjAaFUdsRXGNBtCf4QtG93Zd8TGYQyntFSLF8cCwcxwFJJayyZBr8X4v4a+ZlfWz8XXQvU95
 Bypvl4iXhC9328yZM8h9Hv2SMrTU8KUqOppl1QB+iH7ajizXrQ634N6/6AhePWgE+SBqxfgYEkp
 AW6eFRdmMLHsjSD7knVW+2/2eXKS/Avxi+xTFEwr+D9KJbxwjSji24VkmyLUOuN5t+zPB6PNFig
 wki32kLjt6rZChQAb4Vr9aRr0uzkgsSwmuTcMxi3iVcMdeGriRy2XpUInPVTuC4T5IsU9nsq+Jt
 KUqH7p/FenttPvnsN8tjBoleGXcgKzVAhYwR0iTodjTWFlUKa49VB+PXzc4rAOgPldXc5CBeptO
 fjesLdKVd0yruF9xqUMDVPJaLiTQGZY+iMGh1X4ZyHnU2Eb6dzcUB9nSPHRtCg8Pyu+b/Udvul
X-Received: by 2002:a05:6000:4026:b0:439:9203:595a with SMTP id
 ffacd0b85a97d-43992035a43mr5976686f8f.43.1772061449244; 
 Wed, 25 Feb 2026 15:17:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3ff27sm38820078f8f.22.2026.02.25.15.17.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:17:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/70] target/ppc: Extract monitor-related code to monitor.c
Date: Thu, 26 Feb 2026 00:13:29 +0100
Message-ID: <20260225231411.96482-30-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Keep ppc-qmp-cmds.c for QMP, use monitor.c for HMP.

Since ppc-qmp-cmds.c was introduced using the MIT license
(see commit bf957284006 "monitor: remove target-specific
code from monitor.c") retain the same license for the new
monitor.c file.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-22-philmd@linaro.org>
---
 target/ppc/monitor.c      | 25 +++++++++++++++++++++++++
 target/ppc/ppc-qmp-cmds.c | 16 +---------------
 target/ppc/meson.build    |  1 +
 3 files changed, 27 insertions(+), 15 deletions(-)
 create mode 100644 target/ppc/monitor.c

diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
new file mode 100644
index 00000000000..776a76602ea
--- /dev/null
+++ b/target/ppc/monitor.c
@@ -0,0 +1,25 @@
+/*
+ * QEMU PPC (monitor definitions)
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
+#include "cpu.h"
+
+void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+{
+    CPUArchState *env1 = mon_get_cpu_env(mon);
+
+    if (!env1) {
+        monitor_printf(mon, "No CPU available\n");
+        return;
+    }
+    dump_mmu(env1);
+}
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 66c3bcb2c38..96228919966 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -1,5 +1,5 @@
 /*
- * QEMU PPC (monitor definitions)
+ * QEMU PPC (QMP definitions)
  *
  * Copyright (c) 2003-2004 Fabrice Bellard
  *
@@ -24,26 +24,12 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "monitor/monitor.h"
 #include "qemu/ctype.h"
-#include "monitor/hmp-target.h"
-#include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "cpu-models.h"
 #include "cpu-qom.h"
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
-{
-    CPUArchState *env1 = mon_get_cpu_env(mon);
-
-    if (!env1) {
-        monitor_printf(mon, "No CPU available\n");
-        return;
-    }
-    dump_mmu(env1);
-}
-
 CpuModelExpansionInfo *
 qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                               CpuModelInfo *model,
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index b0d708bb519..d4ebbaf0a19 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -43,6 +43,7 @@ ppc_system_ss.add(files(
   'mmu-hash32.c',
   'mmu-booke.c',
   'mmu_common.c',
+  'monitor.c',
   'ppc-qmp-cmds.c',
 ))
 ppc_system_ss.add(when: 'CONFIG_TCG', if_true: files(
-- 
2.52.0


