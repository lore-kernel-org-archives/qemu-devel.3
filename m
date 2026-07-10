Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B39EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIEm-0001DZ-Rw; Fri, 10 Jul 2026 16:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEk-00019X-AA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:18 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEd-0000dN-M9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:17 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so1546409b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716850; x=1784321650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gkaJCNX67B3j7ndloFDN5kylCYvx7pNXiMbKUrJ80tc=;
 b=tfh08xfnK67VgfddWUo+s1dlhHRgF/MPn50vxksRQoI+UbScFdrhL5YvYNNMIC3fxW
 Tt0wDJzLm7liaXUB2RhASjxVLsT5/D3K6UJY8956hO6EJ2e1lXBwy05Q9F9XbDxKq55s
 l9BXIO7q8pLgsXriXsprAauhEZvtJE3WHQ8Exq0qMiYSnjUiw/zoCgECZePsILhLNXOB
 NzHFXw8LMSRN2swNhizxjE1PO2gW8avUpKQUIAmoY2peZ0S1c6szy8rTqdmyJYBaEIAd
 N+zuzUq3arsWwU4pUpzDmqpu4P86FeiiBEUW1b0YLhKNlVgCPUjORH/7xYEKCXQZW983
 M/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716850; x=1784321650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gkaJCNX67B3j7ndloFDN5kylCYvx7pNXiMbKUrJ80tc=;
 b=TWlx/57BYRUisdcoPYvm/+02r3k6li/Sc8tE199bACLWPDxRdzCF+ukdx13KGyqxGk
 cJ+ER6qSmUlu05STeUuEWy+Bz7/maQjffVthQybojXn9dMbeeIN6RAPYWC2iNZzd1kEP
 wyhRg1akFUtNqNFnvVXbq9PfdHvBQTFURWm28gPp2Wero1M1Qsm5GFmxM4PtKDAQvpE5
 /f5ay673R184GjDZ6HvWnbrOGT8uKzVerdtOHKcFHHFMrQyIlZigQDeSqH6aoCia8ra5
 WMHhn22NAJrJAI3U7tDxaXJ61WfgYfitEJg8I+grPg1ehAwHrjtIPCsKJzAurWAN55AI
 Clqw==
X-Gm-Message-State: AOJu0YzJvwsUEwq6tpdk4OU53v2J3GGjfLFxML7o5V7nETaInkdTon6k
 O6sW2U3O+rL/GZK75pKg063hhc3VrWfsJpHS+20dfhPqwssvPBavvZlC0R7b+OQNAIIhf56mrrv
 yOmKa
X-Gm-Gg: AfdE7cnHhm0FFG2nE/Y2pMjnKD2C5moW7O2oKxgXk8fcXIa+NtzjQoSxeCs7RZ9rEoR
 ISMlRqvOjfjktY6YwURO2zSu8aQjhUg1UpE4+t9z5cLe+I7y0s0pY1FdNzjR2f7buaGvdnd+7Uu
 BFZlPXKpXO+PPbPXGRJ6VjiNVsJMgh3J7V6c7nXr2PMVLVDgdgbiuwR7F9PtnBV7ThkDK3eRCZh
 SKOEWc00JzSGjU+TRecz/iSk4Fsb08mviAKHwMW888a+h3Ypx8lu/vI7AWnuykF/P4itYBqSyFI
 77h/IZOWddXXKSMtscRRm4y0S4895x39nvfDLamsLZ5H9ZFliwGLm6Saq8Df8jAsCIQgBY8OMJ/
 k760U2i2k2et5R/uuGbJVQsY2FexeT3u91JBoFvrHxTbIWUe9Z8iNvCvuId9NQJ8IizIyTUXyu2
 a7zDx8ffqKQGva0GeUJADyP8OmLzBZ
X-Received: by 2002:a05:6a00:f08:b0:848:4859:a45 with SMTP id
 d2e1a72fcca58-848895dc4b9mr564447b3a.2.1783716850013; 
 Fri, 10 Jul 2026 13:54:10 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 05/51] hw/core/cpu: Remove exec/breakpoint.h include
Date: Fri, 10 Jul 2026 13:53:15 -0700
Message-ID: <20260710205401.836304-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

This is no longer required in the generic header.  Add includes
where required elsewhere in the code base.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h     | 1 -
 accel/tcg/tcg-accel-ops.c | 1 +
 cpu-common.c              | 1 +
 gdbstub/system.c          | 1 +
 gdbstub/user.c            | 1 +
 target/i386/kvm/kvm.c     | 1 +
 target/ppc/kvm.c          | 1 +
 target/s390x/kvm/kvm.c    | 1 +
 target/xtensa/helper.c    | 1 +
 9 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 481646f5b9..5c01908f83 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -22,7 +22,6 @@
 
 #include "hw/core/qdev.h"
 #include "disas/dis-asm.h"
-#include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index c59ab85606..76af8d67c0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -31,6 +31,7 @@
 #include "accel/tcg/cpu-loop.h"
 #include "system/tcg.h"
 #include "system/replay.h"
+#include "exec/breakpoint.h"
 #include "exec/icount.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
diff --git a/cpu-common.c b/cpu-common.c
index ba2676cbad..af64bb1126 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "exec/cpu-common.h"
+#include "exec/breakpoint.h"
 #include "hw/core/cpu.h"
 #include "qemu/lockable.h"
 #include "trace/trace-root.h"
diff --git a/gdbstub/system.c b/gdbstub/system.c
index c77d067ab4..724fd24c00 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -15,6 +15,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "exec/gdbstub.h"
+#include "exec/breakpoint.h"
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 9e6f9a6f37..0a61bd7d92 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -14,6 +14,7 @@
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
+#include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/commands.h"
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4272b6770c..8161831de2 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -68,6 +68,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "migration/blocker.h"
+#include "exec/breakpoint.h"
 #include "exec/memattrs.h"
 #include "exec/target_page.h"
 #include "trace.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index aa21cab50e..1a093e1f83 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -40,6 +40,7 @@
 #include "system/watchdog.h"
 #include "trace.h"
 #include "gdbstub/enums.h"
+#include "exec/breakpoint.h"
 #include "exec/memattrs.h"
 #include "system/ramblock.h"
 #include "system/hostmem.h"
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 72031a5714..6f7f75f601 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -48,6 +48,7 @@
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/ebcdic.h"
+#include "exec/breakpoint.h"
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-hypercall.h"
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 5a0e865514..0db5502287 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -30,6 +30,7 @@
 #include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
+#include "exec/breakpoint.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-loop.h"
-- 
2.43.0


