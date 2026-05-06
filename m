Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AA5CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcra-0001gU-Rx; Wed, 06 May 2026 10:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpy-0007bb-N0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpw-0000xw-OM
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so62758095e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076170; x=1778680970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=saeNhd6CtyK007geaZog+ztTZEhGq2PWC7iHo/mMXE0=;
 b=DKDNr26rXhrRUD+1bq2ivGAQfYbptPhi63p8hi/7Ra7syopIjsvhxYKS7aD/uqP+QA
 12+IL2dNYFL4c2kgX9vCV193nrtbUz4f9LaGYisMvTP4ORIYWzC2K0wbSZSdUL3U55Qj
 WtC/gKQf06LQNUfRaftSb7LadZX1nOJhtumGVwllntNnFzJ4cyUETxqsCdp3wwDaViiO
 uMpI/RKV07WAcfVkfiv9b3bjx0Egg1e35gags4PSTmzGDgob5MUgXGL72C0lJCUhvnOE
 Ymjsv3yJflcVENK06McfSNkswb8ALdDe0mIEiLXaAwm63xBzZ9QN5CNeOylvWCBuvZZB
 Hn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076170; x=1778680970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=saeNhd6CtyK007geaZog+ztTZEhGq2PWC7iHo/mMXE0=;
 b=Lah+MqMekC/qVslrQSy6XAH+hzkSD6uT7s2pcEqet8cc4tMVFcb/hZXp4WKAfza9Na
 6D0FoMmyPWktlUgBzbBvkjFu0AwW5MrdL4mhIIzkwEjE9IwzhtgN3gV0odHBFKcE6H2T
 92XAs0MuXD5dEgZO4FbdlY39UmTXKFkjV7acZuHwGwa2DztT1dQoa6VYbQkMPfQNBEl0
 RDC9XCxSbG2Pog2tQJi91JJeDKtMB3XmD32GOxkJi2UfVbXXVAok6GIouQUVE0HuYshP
 NYEAZy3+LCXaC6hUQbAcL3m7hEauVH957/pOFP9cluhBU6Ib2VAca2PDjqHFDYf43bk+
 zkDw==
X-Gm-Message-State: AOJu0YyA9WVY+RH3OSQtVieYSNWnkS2dqioVgvZF/0qyrpQhEtki++uQ
 UC8ytP3VW+JDV6urFMyUZejs0lqMZV7LLMHzUih/uCA03pJa9m2nHSqixSUgsKAjHbYbosrSw+6
 R9oh26q8=
X-Gm-Gg: AeBDieuXV+k3vhChsmn5u/2qxyhD3O9IKQtfLc1I5w77wDcslHSgKVH+uZJNHvToQ9p
 9G/ZUtaXiyDhqkszt5hBb2x+XB2C68F6nziDdGSKtRawGoiDVsN2Q/ddNXwSBC1APSNa/UPjEgl
 DXdyyUjNsNO79hzcwsAaxqfxpYd5aJaxwtuPzmfsh0nQ3gQ+Tuik/i1cx11KAqQtowgrEYa2sNJ
 BUGU2jqc8ptKDYEfV4hljdG8S3YrLaVkdEZyNyvXpm8fqa/stmRpFruusazpCbM81kSD9FTpKPs
 0lDQHF4X4jw3NrTgHabOcoFarQ+MrmHAEU4JC7oleiEd/DZT9g0adfneBawzTVZI8I8FoCb3048
 GKGLfD8semiGl4USe6had2jD7bWJAaCfwwEmzQb1OmrwsbqHzJhBjRkPxhe+037x8ucKz4MSUeX
 8giryeA78ipCGD1I+jdEizWaDWPIRgsJzB2uu+dWnRaMT6dNiBqZdsXWslSwRdCWSpZpeRVcFuF
 QxUpDLYtpm9ZOJAEWpyjQ==
X-Received: by 2002:a05:600c:a111:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-48e51f2f83dmr48314645e9.17.1778076169792; 
 Wed, 06 May 2026 07:02:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a517bsm52904675e9.4.2026.05.06.07.02.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:02:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 057/110] monitor: Remove target_get_monitor_def()
Date: Wed,  6 May 2026 15:54:29 +0200
Message-ID: <20260506135524.20617-58-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

target_get_monitor_def() is now only a dead stub. Remove as pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-22-philmd@linaro.org>
---
 include/monitor/hmp-target.h   |  1 -
 monitor/hmp-target.c           | 14 +++-----------
 stubs/target-get-monitor-def.c | 29 -----------------------------
 stubs/meson.build              |  1 -
 4 files changed, 3 insertions(+), 42 deletions(-)
 delete mode 100644 stubs/target-get-monitor-def.c

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index ce0bb1983cc..008c1a6570c 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -38,7 +38,6 @@ struct MonitorDef {
 #endif
 
 const MonitorDef *target_monitor_defs(void);
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
 
 CPUArchState *mon_get_cpu_env(Monitor *mon);
 CPUState *mon_get_cpu(Monitor *mon);
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 46ccbd14aec..c2ddcd67e51 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -66,8 +66,6 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
     const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
     void *ptr;
-    uint64_t tmp = 0;
-    int ret;
 
     if (cs == NULL || md == NULL) {
         return -1;
@@ -86,16 +84,10 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
         }
     }
 
-    if (cs->cc->sysemu_ops->monitor_get_register) {
-        ret = cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
-    } else {
-        ret = target_get_monitor_def(cs, name, &tmp);
-        if (!ret) {
-            *pval = (target_long) tmp;
-        }
+    if (!cs->cc->sysemu_ops->monitor_get_register) {
+        return -1;
     }
-
-    return ret;
+    return cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
 }
 
 static int
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
index 2f4e1ab4300..3489b1f20dd 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -75,7 +75,6 @@ if have_system
     stub_ss.add(files('igvm.c'))
   endif
   stub_ss.add(files('kvm.c'))
-  stub_ss.add(files('target-get-monitor-def.c'))
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
-- 
2.53.0


