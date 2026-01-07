Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9980D0D15D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdY9F-0006L0-NS; Wed, 07 Jan 2026 13:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdY9C-0006KD-8Z
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:20:42 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdY98-0005kR-0j
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:20:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so8935715e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 10:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767810036; x=1768414836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5vUbPm6z1uOCPE8G5muzfEnqNfVl9U7aMx0sRH9rCw=;
 b=xHl2v+6rC8aF2FC2zRHJF4FNb8CdYKgljbA4GDGAcfWSt/XlUqOJuKpYrvo8inKxQ5
 szgWqtwzowdjq/QcrsTxk+dpecUbTNHSSIt0lOtigqCyL0csMzwcZNr4wsXUJ1UfOH6W
 mMu1UvZzDPnGps0Wi12REmOL3zP0RdbZdQUNVoUfO6wiq3U7jlPT5zkblgsBFfjWKnmX
 wR2sQ6+jaqb6x/VxPlhQn4SmGemmmO97F45WgqThqlo4CgI1XXhae1AbX8EzQHUVKe6z
 KiTazyFUPbCTafB6M0A0qAsDE/HQ0Fv/q7Y8tqUajjryqYMiIx7IEdj2Ps3KUsxTFa4D
 XrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767810036; x=1768414836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c5vUbPm6z1uOCPE8G5muzfEnqNfVl9U7aMx0sRH9rCw=;
 b=sE9G1humENaTQB++2TTLNP+7WZRuGlJ063FvMGvDsgL8Avs10Ae+iBoNb1uWh+YMbP
 aapkNZvfvK9C0sha48+cQcRLkvad2NErqkWjUynvbLyaxIgdsP9ESlVXcHs6H4x8GTjl
 GaAOc83RX9PG17aqCZt26EuI/GisS3QuWP7QDrp8Fj8F6IrrLyRi/6nuRAC3mZ4u2UHe
 MrqKkTrP4xzUWfrVRBKtVQ0JEVT11lGMsdA3VjuvPdFOZ40cWE1UjKxkgxYcUfYkAEPg
 /H7IK+GKR5KDXUP4u7uBcgID327x5pBT0GgMffgsks4gkmsa794IVxCO8Mf3ZKEv/+mF
 3FUg==
X-Gm-Message-State: AOJu0Yx5kYhKE7velVpsDvKx6SO1Yieer23JkfzKUhJwOhHCvaKbRwBr
 itToyEPC74xpanwtRsy12chAnPVpprilxcL6EwgIRtTW6fIwOwLZSOCOWJb1VAj92Wt9fFCgCRG
 /w9oM3vU=
X-Gm-Gg: AY/fxX48Xtq/iu16ODHn+7s6ARlU6rrKFdpTTjLdJvMM9zkAirimdftUaMmjceb/2O5
 NrOgv9IPbiqtSoJpBDAJ+O5GaHLVpVYEhCfBoXHOF+ix/wHRsi6ix/EATQ7NQo9KI6Z6AHDR/aq
 GJe+VPyCHLQAMVlIjy2DdceVKrt8Ly8t5ONVbX8Es8LfjZ3fN2lpp80HHUhnPnu/VHdXM+KHYUx
 RCucUdtbsik1tQx0jM3ZzERoqjFMu3DDD35fJBf8CPYDjeR8CDKFH9pHy0rf3HO/7dix8OYGAx+
 J9wJHlujmdzPueptxYJa/iXKmAjzaJuZ6baecniLdMyQOzdmhB+ODx+8VMhYCcKZrWsm80WExCb
 44tO7lkZmahCTX7NgnooDjAPYbCEsrqDXZLEKjcmLQJd13XMYdqGYjS7xuHhvfVnE6VfIHTB5S/
 ocpKyk9hvRisjjmgIgLqBkSgQQRprdbPweRPqkYKEMRNyjPlE7FOS67AtVeSP7
X-Google-Smtp-Source: AGHT+IH35LX58d6iyis4US3zlff2ddmvK+Kej9v1Ob5JXh2aZ9aKF+hD5J/dRbIVvn6vm/UBgCxgjA==
X-Received: by 2002:a05:600c:a30c:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-47d848787eemr36087415e9.15.1767810035952; 
 Wed, 07 Jan 2026 10:20:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f620ac8sm107925335e9.0.2026.01.07.10.20.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 10:20:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Max Filippov <jcmvbkbc@gmail.com>, kvm@vger.kernel.org
Subject: [PATCH 2/2] monitor/hmp: Reduce target-specific definitions
Date: Wed,  7 Jan 2026 19:20:19 +0100
Message-ID: <20260107182019.51769-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107182019.51769-1-philmd@linaro.org>
References: <20260107182019.51769-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From "monitor/hmp-target.h", only the MonitorDef structure
is target specific (by using the 'target_long' type). All
the rest (even target_monitor_defs and target_get_monitor_def)
can be exposed to target-agnostic units, allowing to build
some of them in meson common source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp-target.h  | 28 +++++-----------------------
 include/monitor/hmp.h         | 23 +++++++++++++++++++++++
 hw/i386/sgx-stub.c            |  2 +-
 hw/i386/sgx.c                 |  1 -
 monitor/hmp-cmds.c            |  1 -
 stubs/target-monitor-defs.c   |  2 +-
 target/i386/cpu-apic.c        |  2 +-
 target/i386/sev-system-stub.c |  2 +-
 target/i386/sev.c             |  1 -
 target/m68k/monitor.c         |  1 +
 target/riscv/monitor.c        |  1 +
 target/sh4/monitor.c          |  1 -
 target/xtensa/monitor.c       |  1 -
 13 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index b679aaebbff..d39d8c8abe1 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -25,9 +25,12 @@
 #ifndef MONITOR_HMP_TARGET_H
 #define MONITOR_HMP_TARGET_H
 
-typedef struct MonitorDef MonitorDef;
+#include "monitor/hmp.h"
+
+#ifndef COMPILING_PER_TARGET
+#error hmp-target.h included from common code
+#endif
 
-#ifdef COMPILING_PER_TARGET
 #include "cpu.h"
 struct MonitorDef {
     const char *name;
@@ -36,29 +39,8 @@ struct MonitorDef {
                              int val);
     int type;
 };
-#endif
 
 #define MD_TLONG 0
 #define MD_I32   1
 
-const MonitorDef *target_monitor_defs(void);
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
-
-CPUArchState *mon_get_cpu_env(Monitor *mon);
-CPUState *mon_get_cpu(Monitor *mon);
-
-void hmp_info_mem(Monitor *mon, const QDict *qdict);
-void hmp_info_tlb(Monitor *mon, const QDict *qdict);
-void hmp_mce(Monitor *mon, const QDict *qdict);
-void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
-void hmp_info_sev(Monitor *mon, const QDict *qdict);
-void hmp_info_sgx(Monitor *mon, const QDict *qdict);
-void hmp_info_via(Monitor *mon, const QDict *qdict);
-void hmp_memory_dump(Monitor *mon, const QDict *qdict);
-void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
-void hmp_info_registers(Monitor *mon, const QDict *qdict);
-void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
-void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
-void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
-
 #endif /* MONITOR_HMP_TARGET_H */
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 83721b5ffc6..48cd8cefe98 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -17,6 +17,29 @@
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
 
+typedef struct MonitorDef MonitorDef;
+
+const MonitorDef *target_monitor_defs(void);
+
+int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
+
+CPUArchState *mon_get_cpu_env(Monitor *mon);
+CPUState *mon_get_cpu(Monitor *mon);
+
+void hmp_info_mem(Monitor *mon, const QDict *qdict);
+void hmp_info_tlb(Monitor *mon, const QDict *qdict);
+void hmp_mce(Monitor *mon, const QDict *qdict);
+void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
+void hmp_info_sev(Monitor *mon, const QDict *qdict);
+void hmp_info_sgx(Monitor *mon, const QDict *qdict);
+void hmp_info_via(Monitor *mon, const QDict *qdict);
+void hmp_memory_dump(Monitor *mon, const QDict *qdict);
+void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
+void hmp_info_registers(Monitor *mon, const QDict *qdict);
+void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
+void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
+void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
+
 bool hmp_handle_error(Monitor *mon, Error *err);
 void hmp_help_cmd(Monitor *mon, const char *name);
 strList *hmp_split_at_comma(const char *str);
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index d295e54d239..6e82773a86d 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/sgx-epc.h"
 #include "qapi/qapi-commands-misc-i386.h"
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index e2801546ad6..54d2cae36d8 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -16,7 +16,6 @@
 #include "hw/mem/memory-device.h"
 #include "monitor/qdev.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-misc-i386.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index f7ff6ec90ec..1ab789ff468 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -21,7 +21,6 @@
 #include "gdbstub/enums.h"
 #include "monitor/hmp.h"
 #include "qemu/help_option.h"
-#include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/stubs/target-monitor-defs.c b/stubs/target-monitor-defs.c
index 35a0a342772..0dd4cdb34f6 100644
--- a/stubs/target-monitor-defs.c
+++ b/stubs/target-monitor-defs.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 
 const MonitorDef *target_monitor_defs(void)
 {
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index eeee62b52a2..3b73a04597f 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -10,7 +10,7 @@
 #include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "system/xen.h"
diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
index 7c5c02a5657..f799a338d60 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "sev.h"
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index fb5a3b5d778..7e2a5df8867 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -36,7 +36,6 @@
 #include "migration/blocker.h"
 #include "qom/object.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "qapi/qapi-commands-misc-i386.h"
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 2bdf6acae0a..784f5730919 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
 #include "monitor/monitor.h"
 
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 8a77476db93..478fd392ac6 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
 #include "system/memory.h"
 
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 2da6a5426eb..50324d3600c 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
 static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index fbf60d55530..2af84934f83 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
-- 
2.52.0


