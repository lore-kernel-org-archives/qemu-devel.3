Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D14F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHvv-0000iz-JN; Fri, 10 Apr 2026 15:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvp-0000eH-OB
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:22 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvm-0001Qt-LU
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:20 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43cf8fe9c2aso1606360f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850857; x=1776455657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5s/GIt0tTjsOfb6v9VaN6RJdqFFBKJGIkUaXvnC2hp0=;
 b=HsD9cOWagg8s0L96aQLSMgGu/flt1alHypu44f9dxNgzxWQCPFZBnoDPda05gqhMh1
 Yv3/pKuyBYrFRDFWI0FdkTUMrBcm+95ul8Gcke6OzEGk1DEZFOqFzKgmj6mBHeKuW8N8
 RqH2sOQbcKn86y8CexHoItP/AaDyeTCLEe6IBwx41deAHmXhV06JXfvO8FkiQ2mo5Rn2
 RjyEq4uP1NUeIJ6prToppFwTOlOZf2wnQQk1+4jExobPte8xclh2KDMKT1Z/uduvVK9K
 tJm3+uw+2XBzLZrW5mjYLtp8ZM/PSjSztiJSz58TuHQPpEMNVNEBfGvfHA40yUAu4XfS
 HJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850857; x=1776455657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5s/GIt0tTjsOfb6v9VaN6RJdqFFBKJGIkUaXvnC2hp0=;
 b=cfTgpV5HFt6tPA+beKN95T4GdMqDH7lyz6WIr0sjXuPd0E9SOzuIIt8416G3RCZNrS
 pbFGbZDi7OWoyyjbJw3cRfEPuq+V8NVaXeobZHBu+nI64vBas8lG0osWx52GkV+j+dVs
 fhPYUCSbLe8iM0HWiO7KusksR54C/Mbn8dFSLsJqZQlLBEGQc0jRpFPLd36i32Y3WLLE
 sn0kaNiDuF06la5gPz5c7776bTnqH1G5o4WdOTMXldZZvlHPfYjhk5xJPwiPsuWnTlNe
 9W8jmrk5wzR6hAa4MiLUYmR7hXb+F1VwDlE8HA7UjH7K2uA0IkKBPJhuyuqR7ZTkD2U+
 wsUw==
X-Gm-Message-State: AOJu0YyF109HeSywZQfLmk9TaJnjiTjiFiMLWFm+/L4Hg1PCQqguEHfr
 pdDOeSeqgU9DZLsfkNmoufQ7LZ4Qm7se/vOEh6YZ+1e2mECImjwD7LGVkSG/6rVLgnOk1c4enZ7
 qa6xQy/k=
X-Gm-Gg: AeBDiesVN5bLLXw9NlwKwNFD7jtoI+s56imQcKVPpu476554sEH8R03XwmaCf2tuOHt
 4BO1i3XUpCnRgYDsPsgst9Zpfd9+28X9Q9tGpx5Vcuzx/8E0xsRQL1dnpxX45x2DN+SVse3UTvC
 ju+Wx3tX95UxWQgOYdT6jNk2sB0NZ3QG24E3pg+ZkkPj4XmROyUIfvy5lrI0Rw8voUTJ0Wnpmkq
 MMpL+kfJ5BshtcWkf5ywWwetPVmtaXWKfgbkn3xax9/PIpjj6+u9ys+sJF6iM/ZVcY8qt188crJ
 2V2ewwb8HmfvXCGG4TaSJFfDAMwGiyqoRAZGCsGieneVCrH4XOz/xxrh256GKlqojTzhvM/lHpc
 nx2AkX0+dlSDAMHhK0l52ulsA1BNDIEfKXyWfN+0Qk/rR6BzhNhZrs9eMkGyFrb2ILf4d9hXHDW
 +FIkn4yiGkghOISC4c4SeZJsoQ3sKnET6ujn/5Jm/Guw3/5ni2JEtrASUGF6B76Zb84wycmUqY
X-Received: by 2002:a5d:5f92:0:b0:43b:60f7:2283 with SMTP id
 ffacd0b85a97d-43d64289753mr6876436f8f.22.1775850856829; 
 Fri, 10 Apr 2026 12:54:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e469ddsm9737710f8f.17.2026.04.10.12.54.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:54:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 07/27] target/i386: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Fri, 10 Apr 2026 21:53:01 +0200
Message-ID: <20260410195323.17937-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Restrict x86_monitor_defs[] to cpu.c, register it as
SysemuCPUOps::monitor_defs hook, allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c     | 24 ++++++++++++++++++++++++
 target/i386/monitor.c | 25 -------------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c6fd1dc00eb..968414e7215 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -39,6 +39,7 @@
 #include "exec/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
 #include "confidential-guest.h"
+#include "monitor/hmp.h"
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine.h"
 #include "system/address-spaces.h"
@@ -10685,6 +10686,28 @@ static const Property x86_cpu_properties[] = {
 };
 
 #ifndef CONFIG_USER_ONLY
+
+static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+                              int offset)
+{
+    CPUArchState *env = mon_get_cpu_env(mon);
+    return env->eip + env->segs[R_CS].base;
+}
+
+static const MonitorDef x86_monitor_defs[] = {
+#define SEG(name, seg) \
+    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
+    SEG("cs", R_CS)
+    SEG("ds", R_DS)
+    SEG("es", R_ES)
+    SEG("ss", R_SS)
+    SEG("fs", R_FS)
+    SEG("gs", R_GS)
+    { "pc", 0, monitor_get_pc, },
+    { NULL },
+#undef SEG
+};
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps i386_sysemu_ops = {
@@ -10698,6 +10721,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_note = x86_cpu_write_elf64_note,
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
+    .monitor_defs = x86_monitor_defs,
     .legacy_vmsd = &vmstate_x86_cpu,
 };
 #endif
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index ddc666d3451..a536712c755 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -591,28 +591,3 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
                            flags);
     }
 }
-
-static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-                              int offset)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-    return env->eip + env->segs[R_CS].base;
-}
-
-const MonitorDef monitor_defs[] = {
-#define SEG(name, seg) \
-    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
-    SEG("cs", R_CS)
-    SEG("ds", R_DS)
-    SEG("es", R_ES)
-    SEG("ss", R_SS)
-    SEG("fs", R_FS)
-    SEG("gs", R_GS)
-    { "pc", 0, monitor_get_pc, },
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-- 
2.53.0


