Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8481EF45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHy2-0000oX-KR; Fri, 10 Apr 2026 15:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHy0-0000mH-PM
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:56:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxq-0004ag-Ht
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:56:36 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43b95e5b3afso1560801f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850984; x=1776455784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3N9tVXkZOmp74LI4AeaDzzl55NbG18DiRwK9K16fx5c=;
 b=Q6EwOKwtEdlJe78qgdf+K9reHh119V9ZNBDERPt7rGRFcT2GQrITYljBOIQD3zQEgs
 NUI88LoGbzVyLhEIxs3eoGzAZZtEadgYuld8mjSyWVPiKotie/W3UEAEw4iC7qZrs8+q
 o5U+3Kz8UXXxC+J2/I8bpRb9DVQ8z+2al/+yvHN3XWWKYRHa1pMolTo7raDNAIlNjKIk
 flEdBpEzivY1nFCgswyRvsmx39pzUKPBuEjCELKzyRS2HFAr5HBrM/q9WhLLOy6hD9a+
 a3yPoaGO40K1PDY/8JVqbfHegTJ4J5rc+sUEcPeq3zncjIWp+c/1M877wXuxI6gn3+Dx
 whsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850984; x=1776455784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3N9tVXkZOmp74LI4AeaDzzl55NbG18DiRwK9K16fx5c=;
 b=YRQkWwcgsz3dx5b+hU4L2b5k+m62kT7BWZH0iGsG5GwmBw3cMjnq2kKCmZ6tKdHNB1
 0/gLffh4rts8kEmLhcl/7xPGpA+a33VuxrGWyKXa1ghxhGDmd4hLysKKf5j8OBZl4erE
 rQFrClU2HXyS7Hw+aEeY2vmEg2fTYBMQeJs45flCR4XWGbB/REjtI/FSr96NHKhfp/ei
 7NgITtWNzG7DYbVFBDW6ozuB88gZEiCIXT5dp11BJOmUVFQqeOhgzMn6ZaI14Lqz5Vkv
 fxal0MAftsxuXCKENwkGaN+RB3TT8q/EBBQS3GYknmS4GhjXsXx8QuDLjpbGEU4H07Gm
 gt9Q==
X-Gm-Message-State: AOJu0YwZjO1IJDqDpLch/vfCB6axJMdTsza9EwsfEwWkl4gvbHuSLYWL
 4mK+mCkcDjyuCHSeACGdjujppOsqEuBbLD5rO69ciwoJ/+Ax0jJHk68Udj0a+LSgwdFaeaRf1o2
 Vf1ZEy5c=
X-Gm-Gg: AeBDietKp3QerXU3VoJeumcN43KseRns6Z5hjq6P5SRtNL6sv+oG9Vapy49Q/olRdpx
 OR0hA+xEdCYwmaVvwGAji3V0E3lhEdN1nUpH7ZRzFSwLjpbkxO3RO0aiDw3i8SGwclTu6p0JcKi
 eRjwczxXZZXH4K1YvGiMl4FBlXroLF07B9SS2jHiHNtKv4ksWxKBRCSjQklQHOP0/lKMBtd6x7P
 G3JtG/UFLUlCns7fojzZh0U6pnp5wjxRGz2AX2h2lsHNm2Z+E5Ez0akTHCygFHhMa2OpFA2RVeC
 bQrKfq1hnFuthjIih95JrPGawg3gHbE0YvuXUFXPiufGCDYm1AOYqotYjIK15vLEfTdUeLDHgaZ
 r5Y6usVnsCX9wUcCziezGlV/p/Gy4swuGEf65P6zaAMhJtcl4NzPcYmW8b6xvgU4eEBvT4Sytut
 cOVOUZamIXQzS2WdagXtoqjjII2Ciet/vPASRmr0y9XGh5JOvKitPZFRaBjlGO0GP6zwlZRZXW
X-Received: by 2002:a05:600c:35c7:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-488d68b27d6mr64123085e9.26.1775850984497; 
 Fri, 10 Apr 2026 12:56:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5b56d1asm96903885e9.15.2026.04.10.12.56.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:56:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 25/27] monitor: Do not check TARGET_I386/RISCV to build
 'info mem' command
Date: Fri, 10 Apr 2026 21:53:19 +0200
Message-ID: <20260410195323.17937-26-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
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

This command is filtered at build-time for i386/x86_64 and
riscv32/riscv64 binaries. By using the recently introduced
HMPCommand::arch_bitmask flag we can filter it at runtime,
making it possible to compile hmp-commands-info.hx once.

Since the method depends on a pair of distinct targets,
define it in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 stubs/hmp-cmd-info_mem.c | 12 ++++++++++++
 hmp-commands-info.hx     |  3 +--
 stubs/meson.build        |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_mem.c

diff --git a/stubs/hmp-cmd-info_mem.c b/stubs/hmp-cmd-info_mem.c
new file mode 100644
index 00000000000..8a53e367a9f
--- /dev/null
+++ b/stubs/hmp-cmd-info_mem.c
@@ -0,0 +1,12 @@
+/*
+ * Human Monitor 'info mem' stub
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(info_mem)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 336ab870a2c..2d0a8f7d48f 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -209,15 +209,14 @@ SRST
     Show virtual to physical memory mappings.
 ERST
 
-#if defined(TARGET_I386) || defined(TARGET_RISCV)
     {
         .name       = "mem",
         .args_type  = "",
         .params     = "",
         .help       = "show the active virtual memory mappings",
         .cmd        = hmp_info_mem,
+        .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_RISCV,
     },
-#endif
 
 SRST
   ``info mem``
diff --git a/stubs/meson.build b/stubs/meson.build
index 09e73ef8b73..ed7ca54ae06 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -84,6 +84,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmd-info_mem.c'))
   stub_ss.add(files('hmp-cmd-info_sev.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
-- 
2.53.0


