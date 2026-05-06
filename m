Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C16CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcrh-00023b-0H; Wed, 06 May 2026 10:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcrH-0000nQ-CA
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcrF-0001Dp-6I
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so81619375e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076251; x=1778681051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DHM6buaaRLBiKh6jcSvc9MFpxLAKvh+sCx3ywa9Z/Xk=;
 b=yYSPZWI8winisI4+aFq6OH6GJ0EGIp34uT64BVLlRFoNldQS7ih4f2xGStXy+0ZoKB
 r+VsUyRwOO46YqtwOEIvOLCv5XXJzaT8T71buDXdZqGUfObBoTOI57lPuoxihJqt5Rps
 ZWh3yWjjZ8t1U4LXvK4Jd7+MfuSHQ/9mrcgDuBno/GW92rSEVAl68zXIDhJ3pMRwKs1d
 lLArLtmbNgkq/2kruGDUfAEHYSg9bm6CUEyQl6dkTJeVvQsiOEjnq1CVqAdLhDReNQbJ
 ktQ85NKVdu/LOmSFz8bfBtV9XZFJpF2JCBS1o6lvxGLOwmajg9q884mL195WSM+T6Rjn
 Mk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076251; x=1778681051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DHM6buaaRLBiKh6jcSvc9MFpxLAKvh+sCx3ywa9Z/Xk=;
 b=RX4imDXnB99iLHUmYt7UsHDWwXaN7RonF0wi0O0KjafinLShogKS3DpZ13om23uFNC
 fj6wTHG3AoTeDxEk/NnS9W1RX7t92WXXYzx7o9kWlyQNN2SruAAMPymeMtTivtrCOOGo
 G7DNKl+WMzqGfoKz6HBr2N3Yelpuiy+CSErXqfw9wuwScg2PhSpbSm5/5t5kM7x8caFw
 Vk0qn/kHIiq+Bzlfr+rcD+KWGDGkZSC0fuUCWc9TuvFWEcDVHGZDGf07vbbFkCZWrJ9m
 oo3MIo5s0XiWirUB9zPJt2ByXWAHH21CK5kpwYdtJmTs8BIW6mj0Js5hWflhZYBTBqaG
 OOIg==
X-Gm-Message-State: AOJu0YxVc/HhZP2Ykxk7/uebyKO+ddBSaC3y6gHy43DTQgIratT2aVnp
 keJKBca/pU2NaKj8C0nfxYoBuTTRb7LY/2StMI1VLyyV60Kf4r4wdxNzOtb2fvNkEzUKFbC9U5J
 1FDfc8NM=
X-Gm-Gg: AeBDieswC73FaWNJGZqNEac7WfAQx+10UR9gAflRotRcxD3X+nW1+EJu3zgW5EOw7tD
 0qFeuUD8wdgbq22zBELauduYhsHfTc6+8OGTeo7Bal5rRO+faXUMfbyJ+DNUK1d2HmUWHZjKj9l
 6perTtYBOVz6izM9cU5GaSymv6DZXmiXmHY/IB2lWNmyLM6vAlAf0HJaZ22EzPJmb+JZCudMELZ
 chzhskEYKbz+ojBoInS0l/uBgX+su1t5KbcNRebjygU0mlLKALx1v+o0GhsJ/OXEsQ/FsD5glIl
 84g3rLSNvzOG90Kl+M1CMR1WggN4s75MiA4YX9wu+UvNkuIVhdWkemmbMYt01CJrx34JZGsh4qG
 SC1CGcGlvkSvwBjYwj/3GPHoIJjuSjOm+NlAqHApB3cpjF4hHuvjUlXjG3cLb0fCusTIuNcKz06
 dNB/78sd4vd6TG6xO8wPOWZmMFBdVawVT3gUMJKkCFufMsVAwAAVjHZCVJ8zucDcgzIMkecrx8V
 btmk1iXTes=
X-Received: by 2002:a05:600c:c107:b0:48a:56d5:16f2 with SMTP id
 5b1f17b1804b1-48e51e15b69mr48842905e9.7.1778076250482; 
 Wed, 06 May 2026 07:04:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312dcbesm17323105e9.22.2026.05.06.07.04.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:04:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 067/110] monitor: Merge hmp-target.c code within hmp-cmds.c
Date: Wed,  6 May 2026 15:54:39 +0200
Message-ID: <20260506135524.20617-68-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

hmp-target.c doesn't contain any target-specific code anymore.
Merge it within hmp-cmds.c (which is already built once).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-32-philmd@linaro.org>
---
 MAINTAINERS          |  1 -
 monitor/hmp-cmds.c   | 40 ++++++++++++++++++++++++
 monitor/hmp-target.c | 74 --------------------------------------------
 monitor/meson.build  |  3 --
 4 files changed, 40 insertions(+), 78 deletions(-)
 delete mode 100644 monitor/hmp-target.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c4f78ac07f7..10bf7b761b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3408,7 +3408,6 @@ Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dave@treblig.org>
 S: Maintained
 F: monitor/monitor-internal.h
-F: monitor/hmp-target.c
 F: monitor/monitor.c
 F: monitor/hmp*
 F: hmp.h
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 682bb62e91b..db92d6cb86b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/base-arch-defs.h"
 #include "system/address-spaces.h"
 #include "system/ioport.h"
 #include "exec/gdbstub.h"
@@ -22,19 +23,58 @@
 #include "monitor/hmp.h"
 #include "qemu/help_option.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor-internal.h"
+#include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
+#include "block/block-hmp-cmds.h"
 #include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
+#include "net/slirp.h"
+#include "system/device_tree.h"
 #include "system/hw_accel.h"
 #include "system/memory.h"
 #include "system/system.h"
 #include "disas/disas.h"
 
+/* Please update hmp-commands.hx when adding or changing commands */
+static HMPCommand hmp_info_cmds[] = {
+#include "hmp-commands-info.h"
+    { NULL, NULL, },
+};
+
+/* hmp_cmds and hmp_info_cmds would be sorted at runtime */
+static HMPCommand hmp_cmds[] = {
+#include "hmp-commands.h"
+    { NULL, NULL, },
+};
+
+HMPCommand *hmp_cmds_for_target(bool info_command)
+{
+    return info_command ? hmp_info_cmds : hmp_cmds;
+}
+
+static int
+compare_mon_cmd(const void *a, const void *b)
+{
+    return strcmp(((const HMPCommand *)a)->name,
+            ((const HMPCommand *)b)->name);
+}
+
+static void __attribute__((__constructor__)) sortcmdlist(void)
+{
+    qsort(hmp_cmds, ARRAY_SIZE(hmp_cmds) - 1,
+          sizeof(*hmp_cmds),
+          compare_mon_cmd);
+    qsort(hmp_info_cmds, ARRAY_SIZE(hmp_info_cmds) - 1,
+          sizeof(*hmp_info_cmds),
+          compare_mon_cmd);
+}
+
 bool hmp_handle_error(Monitor *mon, Error *err)
 {
     if (err) {
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
deleted file mode 100644
index 2739383607d..00000000000
--- a/monitor/hmp-target.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * QEMU monitor, target-dependent part
- *
- * Copyright (c) 2003-2004 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/base-arch-defs.h"
-#include "monitor-internal.h"
-#include "monitor/qdev.h"
-#include "net/slirp.h"
-#include "system/device_tree.h"
-#include "monitor/hmp.h"
-#include "monitor/hmp-completion.h"
-#include "block/block-hmp-cmds.h"
-#include "qapi/qapi-commands-control.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-commands-machine.h"
-#include "hw/core/sysemu-cpu-ops.h"
-
-/* Make devices configuration available for use in hmp-commands*.hx templates */
-#include CONFIG_DEVICES
-
-/* Please update hmp-commands.hx when adding or changing commands */
-static HMPCommand hmp_info_cmds[] = {
-#include "hmp-commands-info.h"
-    { NULL, NULL, },
-};
-
-/* hmp_cmds and hmp_info_cmds would be sorted at runtime */
-static HMPCommand hmp_cmds[] = {
-#include "hmp-commands.h"
-    { NULL, NULL, },
-};
-
-HMPCommand *hmp_cmds_for_target(bool info_command)
-{
-    return info_command ? hmp_info_cmds : hmp_cmds;
-}
-
-static int
-compare_mon_cmd(const void *a, const void *b)
-{
-    return strcmp(((const HMPCommand *)a)->name,
-            ((const HMPCommand *)b)->name);
-}
-
-static void __attribute__((__constructor__)) sortcmdlist(void)
-{
-    qsort(hmp_cmds, ARRAY_SIZE(hmp_cmds) - 1,
-          sizeof(*hmp_cmds),
-          compare_mon_cmd);
-    qsort(hmp_info_cmds, ARRAY_SIZE(hmp_info_cmds) - 1,
-          sizeof(*hmp_info_cmds),
-          compare_mon_cmd);
-}
diff --git a/monitor/meson.build b/monitor/meson.build
index 585251804e4..4c58dd148c0 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -7,6 +7,3 @@ system_ss.add(files(
   'qemu-config-qmp.c',
   'qmp-cmds.c',
 ))
-
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: [files('hmp-target.c')])
-- 
2.53.0


