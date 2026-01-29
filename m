Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257F4D61017
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlS9o-0000h9-Qe; Thu, 29 Jan 2026 08:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS8t-000052-5y
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:08 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS8p-0002ad-Lr
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:02 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4327555464cso818267f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769693577; x=1770298377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jc84jdH37KzF728Sj6zsRk41/3OawHC9hDcgf32rp1k=;
 b=eNWpIg1nE37hv6rXTzjeG2PlkdORohpiyMc0Ar8DUSM0YAfZH3D9yRLEGwjI/rQQqT
 tD+896ISvTc0gc6iJzPiFLbyv817Q2fuWMLBfdUap7fYQqQhrpJoY/0WEfpi6bFOUlsz
 P/lK3RqZ6AkcCoi0IFQZwALzblH0c6BEqxCoh8XywOt1OeYyf8f/d2WyfVvtOjIIozoV
 CCcMtcf/9qo9mprBN+33mwL2xhBmNYnz9lOBeP3at7fO/ZVmgtS1CBpoV2V/qr72cbV8
 NRucf+yUYEOX6usrUsD2h+x5K4xv1YspAUUAbIxWUE92SYAX4VFRgSTAKe0vsLptT0mk
 bg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769693577; x=1770298377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jc84jdH37KzF728Sj6zsRk41/3OawHC9hDcgf32rp1k=;
 b=JdLoi4NgoiJmBjqu5J0I+hY+CNUayXbTABDSPz6iB4KFJvULqhL1RPnUsxYjSYNxHM
 +NXk4R+OWxyWuNBpUq2G6c5o7Y9T9oP+R/afmygIdrZ36GDKxxLzPu+/dY6TJ3+awYzX
 LhpJt+6Q20Z5sOWqpIbnxa45hg+jTB0hkqQM3DgrS+PLKBhncBx0ewFOZwP/vdR8Ipf4
 MbnZIdHPRYs0CSaJwTFext6Br3oTHd6tv0bGXFGLx8aSY5JkrGGYb1bxykB6zfghB0EW
 2SfS946COzaJaq07sWagW9qCcQbHnL4bbd6bJIatKm8Ld0X/BlEEBI0dcIIoUBrdtC2A
 LbBA==
X-Gm-Message-State: AOJu0YyUYJQdBo7/KYQwoypqRQ6n5pcfS3z/w6nrZw6Ilw0LPXy7a+8E
 xMPBYOIZ8GsJ+wj9zw2kRu/y7wFRsLXDwrwmFjRZH3r3g/dE+UxJEpf6/22etccTTZX3fIokOct
 gJfwIBdg=
X-Gm-Gg: AZuq6aKHLSjINB7N7NwALli58yzXhrEIA9InGQkBxIBJrxUSFsZfYdkLUoISGpjre1t
 Ojt8xyd67FGflsVPJS1CvbA6JDRw6mlj0ypc8ieu9O/GqpzX5Gp0cHBv8tj+17B4t3djMN2RXBn
 muRdH4BzZvMpKIqDiPmoxu2kOBU15HqsCxJYXoO43Ut9DMxJSQ8EeLCLpNHJR0ISkfumK5rw/JS
 iUKDslANWG1Tx8Szaj4SURiGzDv6rVXnLpdF3bNh7QYcZwmBpb61TT2K7ZzJaRKqAi2UuSzIiLz
 yWbdYG8mV78ZYDaq7rGgg7SUAZO9O6aCRM0IU3C4VidI9s/6UnFIwSxid8xVbTJ9KUw4K3bP1Ms
 fNnPD14MtHHSy5ufgWV7qw1IzCOYFQQBGwRjJ7FQBasSeNptefEPWKDPBNXWv8+atOlVvAzYqdy
 lzy8nMB/xX9IUTNu//awkA+/seArtuJbsNliDOaaLn5fQy/1wgVpW5qYzm04fh
X-Received: by 2002:a05:6000:40dc:b0:430:c76b:fadd with SMTP id
 ffacd0b85a97d-435dd073a76mr13761921f8f.28.1769693577318; 
 Thu, 29 Jan 2026 05:32:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cf16sm15539645f8f.22.2026.01.29.05.32.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 05:32:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v4 2/9] monitor: Reduce target-specific declarations
Date: Thu, 29 Jan 2026 14:32:34 +0100
Message-ID: <20260129133241.35990-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129133241.35990-1-philmd@linaro.org>
References: <20260129133241.35990-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Some declarations do not depend on target-specific types,
move them out of "monitor/hmp-target.h" to "monitor/hmp.h".

Commit 409e9f7131e ("mos6522: add "info via" HMP command
for debugging") declared hmp_info_via() is declared twice.
Remove the one in "hw/misc/mos6522.h" otherwise we get:

  In file included from ../hw/misc/mos6522.c:33:
  include/monitor/hmp.h:43:6: error: redundant redeclaration of 'hmp_info_via' [-Werror=redundant-decls]
     43 | void hmp_info_via(Monitor *mon, const QDict *qdict);
        |      ^~~~~~~~~~~~
  In file included from ../hw/misc/mos6522.c:29:
  include/hw/misc/mos6522.h:175:6: note: previous declaration of 'hmp_info_via' with type 'void(Monitor *, const QDict *)'
    175 | void hmp_info_via(Monitor *mon, const QDict *qdict);
        |      ^~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/mos6522.h     |  2 --
 include/monitor/hmp-target.h  | 14 --------------
 include/monitor/hmp.h         | 13 +++++++++++++
 hw/i386/sgx-stub.c            |  1 +
 hw/i386/sgx.c                 |  1 +
 monitor/hmp-cmds.c            |  1 +
 target/i386/cpu-apic.c        |  1 +
 target/i386/sev-system-stub.c |  1 +
 target/i386/sev.c             |  1 +
 target/m68k/monitor.c         |  1 +
 target/riscv/monitor.c        |  1 +
 11 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index 150e30a2c11..82838d09106 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -172,6 +172,4 @@ extern const VMStateDescription vmstate_mos6522;
 uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size);
 void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size);
 
-void hmp_info_via(Monitor *mon, const QDict *qdict);
-
 #endif /* MOS6522_H */
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index b679aaebbff..5167d17d41d 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -47,18 +47,4 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
 CPUArchState *mon_get_cpu_env(Monitor *mon);
 CPUState *mon_get_cpu(Monitor *mon);
 
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
index 83721b5ffc6..e222bea60cd 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -180,5 +180,18 @@ void hmp_info_mtree(Monitor *mon, const QDict *qdict);
 void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
 void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
 void hmp_info_firmware_log(Monitor *mon, const QDict *qdict);
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
 
 #endif
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index d295e54d239..1dd8d9afbfa 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/sgx-epc.h"
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index e2801546ad6..5e792e8e6e9 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -16,6 +16,7 @@
 #include "hw/mem/memory-device.h"
 #include "monitor/qdev.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 5a673cddb2a..bad034937a9 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -21,6 +21,7 @@
 #include "gdbstub/enums.h"
 #include "monitor/hmp.h"
 #include "qemu/help_option.h"
+#include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index eeee62b52a2..f7ad7b51394 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -10,6 +10,7 @@
 #include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
index 7c5c02a5657..fb84aee94d2 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "sev.h"
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1d70f96ec1f..fef9f441c61 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -36,6 +36,7 @@
 #include "migration/blocker.h"
 #include "qom/object.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
 #include "qapi/qapi-commands-misc-i386.h"
 #include "confidential-guest.h"
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 161f41853ec..6d101c75df0 100644
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
 
-- 
2.52.0


