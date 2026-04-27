Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C03FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH1z-0001lr-91; Mon, 27 Apr 2026 04:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1t-0001QQ-NX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1s-0001zJ-1b
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so65805275e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277358; x=1777882158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O7UCdCKJ1c5qVGsxeGNM3DP4EYb+8E6FPBO3612XPg8=;
 b=k2fx1BVd0JdohBqCRPX/OnkgLDcJQ8HagO8csgISU4zGlGPp69MdSNs45LO9i1oLdg
 ebL9IbwrO9Qy1IJQ6aP38HnSCqaOyxfc5klpb+5kcXmWXnDPKZOYGw0Fxnt4E8vE6FkS
 NM3HJCXmYI1pDHbtsEhK9toBgvYE+o7d6lDU84Uq+IhUIOZg5N6KxmrC2XkNE+0SV/+z
 ygkfXP+EKmYXkvK7rVyg8GCs5CZo2PGLJIkkYoZLsHvZfOu+Wb8SL+a2E5gH/ahMt7hD
 BGgPJ69utj7Ohl3cQ5lY1T2CJL0i3l5kmWTWC5Yg92pJdOezsa4po+EtLnNy0pGBhyqj
 u9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277358; x=1777882158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O7UCdCKJ1c5qVGsxeGNM3DP4EYb+8E6FPBO3612XPg8=;
 b=UnDvN9VcluiVgeT2r/tdjdxfKpCVwPZoE3b3ZwoUJzdkobPPFE9zbp1bw2/kRPCZB4
 bZBsw0ohz7X8kq6fqzq/G6oCJxaWp4C0OmJLwEU8WggExAZBHW8r2JdG5e/Zhg216O4w
 o9DFLXsOBWvBeLf3QskhetiFxuI47CN0RhvUhRGv3n8RQgUQTNko4Ysb1co4S+3TQAj9
 M69mgCxWVb+nKoPk7M+a/2M+Lft+mEEcFVeXjHVC3IByKNy2a07gbDF2cF8bxAKAvr1V
 q5mhbp1WEHsPRQfGKG1rRwZd/9XT9zhzctKRqsiE2VBzgODqF+PScetKbWX3ryYcvty8
 46OA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jxQs9ame+Nqjgp9eK2JeqnnZOVHlfKjDRnunwcxZTJuL/wG/LoljXhHGNHmP3u+dpIf7wZzXlbeGD@nongnu.org
X-Gm-Message-State: AOJu0Yy3dD5JyO8KCGy2sUZ4siJtu8u6zuDcRoOeQOmtFbPgZrssnRV/
 ZgOcxfhcFa5NYMC8gdqJA70IR+nS52RwuPqod07i9LvFOVARFXffSN+939yXzQEmOJk=
X-Gm-Gg: AeBDiestYr3lEBZccVtYzHLRn3luEYEsjwEC8jFR5FlGeLN403vlJrWHm2tdiz9BMJE
 kQMIndJdQXru2NHXComv0sfC44wWhOpV/ae+2QuIUWh3m6k9tvociIpuytJETlYbTWTuvA8hyA9
 +RM6WovKZooVoMgVjiFll/FmP6ZfpG6nUlazi9kZi+npi0IHVQ7g4M0xlww3t/yi3d3sdehK+bH
 vFu8z47kRcEDCT9ihGQfCWyiSr/46l1AhXI/dzWFrIS9S+v+8Au/NSb+uZWHvY3Nl1CIhzGRH+t
 wVxdDKUBLeo0Lfh4apv5P5DmM7pTAe1aqrUlnTFdechb6XaWbA39KjhGFPbdcmXka4S6nsVBR02
 Uuc1H3g4Fb+F3v3X3u1+O393Lua8F57XTtJl6+SfSNf4iKGAEkBNL4ZdNUValyg2E3alx99Vn5D
 ZvDpN5E9/z2qGXM6ty6Aelp6qvk5xcyOkw72XdF/bYgRZkRRL/vms2CC9MGB044QYolKQD4EKHs
 cxokjvAAas=
X-Received: by 2002:a05:600c:a30a:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-48a581c113cmr262189365e9.10.1777277357847; 
 Mon, 27 Apr 2026 01:09:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10019bsm797040345e9.4.2026.04.27.01.09.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:09:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 14/32] monitor: Do not check TARGET_I386 to build
 target/i386/ commands
Date: Mon, 27 Apr 2026 10:07:20 +0200
Message-ID: <20260427080738.77138-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

These commands are filtered at build-time for i386/x86_64 binaries.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter them at runtime, making it possible to compile
hmp-commands[-info].hx files once.

Since these methods are used inconditionally within target/i386/,
define them in the same stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                  |  1 +
 stubs/hmp-cmds-target-i386.c | 13 +++++++++++++
 hmp-commands-info.hx         |  4 +---
 hmp-commands.hx              |  5 +----
 stubs/meson.build            |  1 +
 5 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 stubs/hmp-cmds-target-i386.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5583df5087f..8493b12a342 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -148,6 +148,7 @@ F: configs/targets/i386-softmmu.mak
 F: configs/targets/x86_64-softmmu.mak
 F: docs/system/i386/
 F: docs/system/target-i386*
+F: stubs/hmp-cmds-target-i386.c
 F: target/i386/*.[ch]
 F: target/i386/Kconfig
 F: target/i386/meson.build
diff --git a/stubs/hmp-cmds-target-i386.c b/stubs/hmp-cmds-target-i386.c
new file mode 100644
index 00000000000..43a167056d5
--- /dev/null
+++ b/stubs/hmp-cmds-target-i386.c
@@ -0,0 +1,13 @@
+/*
+ * Human Monitor x86 stubs
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(info_local_apic)
+HMP_STUB(mce)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 28dec25642d..b575e4ac993 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -113,16 +113,14 @@ SRST
     Show the cpu registers.
 ERST
 
-#if defined(TARGET_I386)
     {
         .name       = "lapic",
         .args_type  = "apic-id:i?",
         .params     = "[apic-id]",
         .help       = "show local apic state (apic-id: local apic to read, default is which of current CPU)",
-
         .cmd        = hmp_info_local_apic,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
-#endif
 
 SRST
   ``info lapic``
diff --git a/hmp-commands.hx b/hmp-commands.hx
index ff65b39b454..cfd53bdc744 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1488,18 +1488,15 @@ SRST
   Stop the QEMU embedded NBD server.
 ERST
 
-
-#if defined(TARGET_I386)
-
     {
         .name       = "mce",
         .args_type  = "broadcast:-b,cpu_index:i,bank:i,status:l,mcg_status:l,addr:l,misc:l",
         .params     = "[-b] cpu bank status mcgstatus addr misc",
         .help       = "inject a MCE on the given CPU [and broadcast to other CPUs with -b option]",
         .cmd        = hmp_mce,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
 
-#endif
 SRST
 ``mce`` *cpu* *bank* *status* *mcgstatus* *addr* *misc*
   Inject an MCE on the given CPU (x86 only).
diff --git a/stubs/meson.build b/stubs/meson.build
index 99a89c00066..6142e0f4d9d 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -88,6 +88,7 @@ if have_system
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
+  stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0


