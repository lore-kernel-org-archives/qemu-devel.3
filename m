Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00326FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcrW-0001VN-2S; Wed, 06 May 2026 10:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpc-0007Iv-Tu
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpa-0000vB-8E
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:32 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso3603803f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076146; x=1778680946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yewvYs6cPTD2dj7nT/r4N5XxtqUaMU8rpJtQZi2DobU=;
 b=txdubUxzhGFf6nrPvz9WrunCTWPOUe3uLV/48icEbdm1cM9p8lqdNq5E+p9kbYTMA9
 mgeKLcxZcWETKPCyK9ZnsNPSEXpCe7nVfeTztEjPl0p/IRgX0rS0pd2sc7amHWte5UiW
 lenUABlpHN0DnSaRinCZT0jtqneIfupjGgA2cKRn1LjvRWbjo3TIjbr1ZI7kXD743ZIX
 Yp//PwfgWdLc7qXlNfOX/nxdtOlRQm2jtm1S27P+Ib1YthRNMxAEppRH4rp577RZOAOb
 cm0xEWVBvYZnNgqFFbwIFa6nagLmnqMqugamsZi+TeFfVlKVE6Yops0peUG0ibjXmRCs
 S1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076146; x=1778680946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yewvYs6cPTD2dj7nT/r4N5XxtqUaMU8rpJtQZi2DobU=;
 b=l9UNjO5urYORn/YhwNSsHg5IlzIp/2TofXXiIqtzbnxMiFJUDw3mZ0bCcl27n2txC4
 yvjFPwjin7jJ6fa0C+rGi02dAHYv1W/Xo0LaVFArDhO58ptyjflQMUo9ixfqNFVm24g1
 ITHzh+2vsUuKBsjTfP3pOQy/Gp1QyZTP+6BtOvNKZPwg/ebkfk6qel5KlwltEcEvvZFI
 HfSCfXJhJpvwQIZOGIoCULTLp62EHo9xMC4l4bxps6xKbMmUGyR3OyZXlVGFDCg5QsU0
 /hQgbchqgvZYjGUlLxP+Mxr2h1WXY75UdcLmI9fgzGkg3bvYdp3bJc277DuQ+U9lBIZ+
 rwZg==
X-Gm-Message-State: AOJu0YzUz0uIrDTdfAvLI4dZPYVnI+4/XaUvB1e7Q7bJL2tLEF6jDveS
 QWrmSFlGySAN1spv1eue2vN2ijj3ndP6SyBnPMcVtaU9TrbYacMTNYZF9Spt06VA/mnZVUy6TgD
 nZerkj1M=
X-Gm-Gg: AeBDiesLznX7RYdwAOkQMawSxRWZKRirEQB1IFVLeMBqR1q0Kt9au+hG2P2GldRPNL6
 qxCYvEktHENxkLNwhTLCWKaADlbidKgpW6gsJDR7fLU1b0K/JZr2JBp1jn3sM54iXlbq1VxvOte
 2F31DGSkCToMNJyiyPOVZrkpjOdvS9LMVYQRGuUCWZm47pXG0oFRNt29/az823jzptx8972/U6j
 b76N3c0bblpK9i+qGPpengY+ruYylPGSU83QWysP1g1rD3WwmChYFYikwUJTtUCqSwQwYkLUR+D
 ndbCB7gt+0tMhf6Wo1VO0raW2H1Z7qMFj79iETNGrvYjp8iYXf3L96VaaNOfQNWtSS00mqLa3dz
 t2yxq1tVbw+7Y6cCNQjJ2ynSU6VlKmon6Ix2Mqe+bBwlVD+oWTJhs64gCgzQgjdWglJIjzzOJA7
 ciaMktaXnlt1eJql42AIpDYw4DeFVR2ZBCt9I26OqpBJ9cR18GgbgLdbJKoRFHrEskHF97HgjFI
 sIaZT0Qm+M=
X-Received: by 2002:a05:6000:3110:b0:449:acdb:3009 with SMTP id
 ffacd0b85a97d-4515b057246mr6053359f8f.6.1778076146321; 
 Wed, 06 May 2026 07:02:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02c5asm12726418f8f.19.2026.05.06.07.02.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:02:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 054/110] monitor: Do not check multiple TARGET_* to build 'info
 tlb' command
Date: Wed,  6 May 2026 15:54:26 +0200
Message-ID: <20260506135524.20617-55-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

This command is filtered at build-time for a selection of binaries.
By using the recently introduced HMPCommand::arch_bitmask flag we
can filter them at runtime, making it possible to compile
hmp-commands-info.hx once.

Since the method depends on a pair of distinct targets,
define it in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-19-philmd@linaro.org>
---
 stubs/hmp-cmd-info_tlb.c | 12 ++++++++++++
 hmp-commands-info.hx     |  5 ++---
 stubs/meson.build        |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_tlb.c

diff --git a/stubs/hmp-cmd-info_tlb.c b/stubs/hmp-cmd-info_tlb.c
new file mode 100644
index 00000000000..a144e68c1c7
--- /dev/null
+++ b/stubs/hmp-cmd-info_tlb.c
@@ -0,0 +1,12 @@
+/*
+ * Human Monitor 'info tlb' stub
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(info_tlb)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index c93c049daea..82134eb6c21 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -186,16 +186,15 @@ SRST
     Show PCI information.
 ERST
 
-#if defined(TARGET_I386) || defined(TARGET_SH4) || defined(TARGET_SPARC) || \
-    defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
     {
         .name       = "tlb",
         .args_type  = "",
         .params     = "",
         .help       = "show virtual to physical memory mappings",
         .cmd        = hmp_info_tlb,
+        .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
+                        | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,
     },
-#endif
 
 SRST
   ``info tlb``
diff --git a/stubs/meson.build b/stubs/meson.build
index 33053d932c8..2f4e1ab4300 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -89,6 +89,7 @@ if have_system
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   stub_ss.add(files('hmp-cmd-info_mem.c'))
   stub_ss.add(files('hmp-cmd-info_sev.c'))
+  stub_ss.add(files('hmp-cmd-info_tlb.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
-- 
2.53.0


