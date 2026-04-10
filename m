Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751EDF45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHwZ-0002HA-0c; Fri, 10 Apr 2026 15:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwX-0002F6-7C
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwU-0001is-47
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488971db0fdso23955315e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850900; x=1776455700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQoGjEROfb1fZGcAyFP7wGDHaXz8m4JpMOdQttRvXaU=;
 b=hDwdKDl7XKAPOkK7kPQc5XoqlmAAHXUIARDvA/fb5kI2SKFNyGZRW7XLz3mYNBmk3x
 NBTkIhYVrqRdIBETJfqAvJhskn4LIUQF5I0rErM0yN67lSoMy4+xOogUrGmIP5wbfJD+
 5O8W0CYd13ZyZ78rT5vL5PyPBQWWlvPEHNpkLnyCI2oN03hsbB7vK3eokDcL9maURGW6
 GXAq0d5vJXqgroNWz6GhdM/XMM83UM9y6UyHij8h8yUurd9u8u5fhnLCxkCIyJwHLeZ2
 3UEKcOn3b6H1KGpcrJIjBv+hUDRLLZSFSzYnVFX2SyNAzIoILW6r+bMy92L2IM9mPcg1
 lCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850900; x=1776455700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WQoGjEROfb1fZGcAyFP7wGDHaXz8m4JpMOdQttRvXaU=;
 b=LbpD3uzXFANOxVRl01R6OctMHL0nSjeW1JirvnI7S0TGATmYV0yQRognO+gIMj+FRz
 rK66jGMW2sADBMaxtofUalp5ZwKgi/Apz3mnP7a65Y6vvcddCwrqiqE4MyIsiLPaXfU/
 RLkkQuadq/PPDKXFDEXX0+mDqxn2Bf9Akx2UXadBE3rSJZug+TXyuNFO2BkNJTaaAOtV
 6NCAYD0QUAdExJqnWGq9gevKgzBrLnN0Z6mo3+dh9AibjgcfohpUmVL+iYpw5NJpKBPx
 Pm+p1wh6X0Dz4MXsh5OaF9CpCSrTFGYtnPfrH8M3Syo3SlpWIJr6RkPpluqo9FNTTzW0
 w/Gw==
X-Gm-Message-State: AOJu0Yx46aaHkBz2w8uF6rQuUju/6AdxMv0rzS6c4N4FSc4yDYnA5OuE
 gE9f8kQfdbRMVvYOLRb8kqYCc4dH1Z2goUOIFnFdDXwdregixWBSeSGbJbT50wD1I5obpg8L82C
 M3TCE1Cg=
X-Gm-Gg: AeBDiev24ThVSPFuBZTTklrz/OOb4cYphMI/zYaGh6uVMFcyJ8npB9dVTojp/QXWJqs
 9b5PYz6jOUbwgTjya0et2qnIU0/DiZhO+tMmjTFt9j3lMNSsWth7a5+xuuH4l195STaSV/LOjoO
 ZnhqWzq6k35UwiB6NYWnlMoU6ReF1YmmwCqcKKnn89JBbQWTgDuTjNicE60PSLzve/vys89P2jC
 0C+KtxqpM/GLRldFURSrjNbmw2YCWsgq+OaWWZ4DixKEJbZoEmwc2PkQnyM/60m+3TnFuqEJbV6
 cRsXKfQWZOJPd0qvWefNrGgAjtRXoqxEA6kvY+EWvZZOKpr+ZKzt4zNkFnF0zuEPLJ3nrfW0HeV
 l+u48ZR8Ah8Vsglj/Y+kMZWfsAhyqUU5KJINAce7t2jVhjR+ZBhn1xDgncKnollQJVd/Y5IvSFI
 ZXwbDHDGQF2nMHPqFUZXyj7ixqX0eA6tELf4VDeGGfBaPmlYvv8O8j4yA1ka4DK5w/JCk375dF
X-Received: by 2002:a05:600c:c0c8:b0:488:8bdd:cfb9 with SMTP id
 5b1f17b1804b1-488d67bbbf8mr42408135e9.1.1775850899858; 
 Fri, 10 Apr 2026 12:54:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d592d606sm88600455e9.9.2026.04.10.12.54.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:54:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 13/27] monitor: Remove target_get_monitor_def()
Date: Fri, 10 Apr 2026 21:53:07 +0200
Message-ID: <20260410195323.17937-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
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

target_get_monitor_def() is now only a dead stub. Remove as pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp.h          |  2 --
 monitor/hmp.c                  |  7 +++----
 stubs/target-get-monitor-def.c | 29 -----------------------------
 stubs/meson.build              |  1 -
 4 files changed, 3 insertions(+), 36 deletions(-)
 delete mode 100644 stubs/target-get-monitor-def.c

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index cabb2c55f8e..b444095f684 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -23,8 +23,6 @@ struct MonitorDef {
     int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
 };
 
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
-
 CPUArchState *mon_get_cpu_env(Monitor *mon);
 CPUState *mon_get_cpu(Monitor *mon);
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 799855f3f68..3b9e180c1ca 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1632,11 +1632,10 @@ static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
         }
     }
 
-    if (cs->cc->sysemu_ops->monitor_get_register) {
-        ret = cs->cc->sysemu_ops->monitor_get_register(cs, name, &tmp);
-    } else {
-        ret = target_get_monitor_def(cs, name, &tmp);
+    if (!cs->cc->sysemu_ops->monitor_get_register) {
+        return -1;
     }
+    ret = cs->cc->sysemu_ops->monitor_get_register(cs, name, &tmp);
     if (!ret) {
         *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
     }
diff --git a/stubs/target-get-monitor-def.c b/stubs/target-get-monitor-def.c
deleted file mode 100644
index 394e0f9a7d2..00000000000
--- a/stubs/target-get-monitor-def.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- *  Stub for target_get_monitor_def.
- *
- *  Copyright IBM Corp., 2015
- *
- *  Author: Alexey Kardashevskiy <aik@ozlabs.ru>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License,
- *  or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
-
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
-{
-    return -1;
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index 10eb68ab55e..85f9e3a4f23 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -74,7 +74,6 @@ if have_system
     stub_ss.add(files('igvm.c'))
   endif
   stub_ss.add(files('kvm.c'))
-  stub_ss.add(files('target-get-monitor-def.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
   stub_ss.add(files('monitor-arm-gic.c'))
-- 
2.53.0


