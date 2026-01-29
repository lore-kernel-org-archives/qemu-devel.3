Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155B2D3F09D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlV4n-0000Ez-JQ; Thu, 29 Jan 2026 11:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV4l-0000Bv-In
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:40:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV4i-0005Af-9E
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:40:59 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so14927545e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769704854; x=1770309654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jc84jdH37KzF728Sj6zsRk41/3OawHC9hDcgf32rp1k=;
 b=hBvJp3CwGusc/qvRBR8lx2s6Y8Co7syxSgMHMWXilVflyJYlapgzVnIPt9aCG4h7zh
 CoKDQUjMOJ4iTxMlrN1WgTQH4MVYk7Y+vWHNpp/+aCrFOJfQLKUCX5+oG11CxiaQf3vR
 F6xAnCjTgJquPdEzWKC9oFj3n68TRE7z+uLVRFjcDEVI1AdrfFbrfarof3a4b7z3fDya
 xMHcYYgpMgo5xmIOOP18ISDTQCbPIQukSIgl7bnTJIfxwQLOv/QnYkXqrptmlyTG3vnV
 eVQemWniKF+hL83cJymSlJJ9yeKh52gxfSSZpwcov14K6SY67yoS+6XPAY/prhL5H2Lz
 t/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704854; x=1770309654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jc84jdH37KzF728Sj6zsRk41/3OawHC9hDcgf32rp1k=;
 b=FnyI16eWnTze5q6dPCEr5DfXqtgWMMy/HnOZYmuWVuZTS1JLuOk7Qpbxj4BLZXn9jg
 xIbJ6KUMfLh6yq8eJqps0d8t7inu28hY1vpsMzMxRnLICSLJ5cqRXqqjk/Gfk6q2jOlW
 1QXziCRIQRYMvUp7+5XjIQmr9T3zNAc6TniQ6qlNhfkgGWEd/rBf5fe5qhNFWvY4lUM2
 +t3OXl4b8OTjNemjnxm4ZS6yPf60o6ZTJOGf/nD+olaWXqg+2AVQDALANczKJjZ2Uy+/
 wguFojmNLHGen/dVbJHxxYklfzlYeOopBGi9i/yCpJX956ceIfVmzxJ654rHv81Az33v
 N8aQ==
X-Gm-Message-State: AOJu0Yx8IZjHXAzWieBbr74Udao/P0xPTNd3MYdys7bhQQgrKjeNPE5a
 IN5k4Ge6wldGTe0TlejB9SbOA3IjCP+YZjzoMnF/G9xYu6wSr1z5BLeWuFpNV16GVQaqm5nFSgv
 w5XObyVI=
X-Gm-Gg: AZuq6aLArKST/Em1XZIYtO+dwTHlTNflDi1fh0OS2fjy296XTWNKpPUr9p+huWk2Y3Q
 8ylzA9arHL8XdeS6KN54BJR4tcLG0nKpmhJFMb7J+i97orRWAPeIyiGb4wk3YxAc8ICKXsLz6u1
 pZ/n5Eh4uUTdznoOAmVAs9YcGjoLuuNpITGISyIbJiHb+l0eGqsnUhik/l0aFL6rQofG2QRfPqK
 kXVlK3t1L36/kMzMB+jfYQp91xoKmgvIzHUsC5uhuyb48CiPnPxb1lOkSQQsqpKiMz/bA81s0aR
 YEOOvoD6K3/0H6G/Er5W98e0XBOwoA3ziAzX3IaNR+U8LpqP+baanO//4FL7YMrRhBQwIrBG03p
 ZQSehtc8p7FkrehcgH45LLEhWFL1uJCS3D1m/NfWnliKkqZwczQIHOQ4OcolJqJGT6rHswoteRY
 E38LwiWQkx7BmBth5+tq2LK0YRZhRne+YWldJKpGaYyMhuReYMg8pY6KT7310/
X-Received: by 2002:a05:600c:8714:b0:480:3a72:524a with SMTP id
 5b1f17b1804b1-48069c5bb10mr113359535e9.19.1769704854112; 
 Thu, 29 Jan 2026 08:40:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806d98c8desm118821435e9.3.2026.01.29.08.40.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 08:40:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH v5 2/9] monitor: Reduce target-specific declarations
Date: Thu, 29 Jan 2026 17:40:31 +0100
Message-ID: <20260129164039.58472-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129164039.58472-1-philmd@linaro.org>
References: <20260129164039.58472-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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


