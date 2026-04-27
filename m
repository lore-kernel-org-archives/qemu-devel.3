Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1126FF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH2h-0006cE-Uq; Mon, 27 Apr 2026 04:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2e-0006AB-I1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2c-0002QM-Ct
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43fde5b81a1so7438089f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277405; x=1777882205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5MbZLdHokWB3HHK4f6Bx4RdN98ey138uSNMtx96pK2A=;
 b=yHNrIgS3hOTrhHGBzpiWc17qMJk8gegizMA6bRFxeRnPeH02sHEV1dlyDSCudrJKJW
 BFRb0ESNdOamq9Gfd2T9mt8ydpcyeiFM7hUKTPWvkN5PJt7ecmuKuA2d7jTIyjFYVJmB
 koALeVha0ZuuzFxPNeNaUGF60MLIDkz7fmbH2Mwj06B5RD5xCqiB5d7eqQkzmNbe+lWY
 HMAFzDAdh/PXUUQMFt9jLb01MCDPH2svTaUOEb4tAO2jNvUe/7cPDCYY8CHoptZUB1iv
 GHYcC+YeMFGba+BeaPo9HHJjwFyAJwpZoN5+zmrROx6VZBfCReqOoftYY3Nofh74EMpj
 nKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277405; x=1777882205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5MbZLdHokWB3HHK4f6Bx4RdN98ey138uSNMtx96pK2A=;
 b=QrigV0Y5zC8AQpBP2CIbmH/5uwNsueX05MTbfo2wjYZVuU1/MF+Gkhk/sdQVUZOtvU
 0zcII0u2jdTYwGKXq96KCB5A6ouaOePFCHvNGh1wBNhrqn07KzkWXecl1jHj8aZo+AHA
 01wq+kY44dNd837JrZXnNj0vSFJXAr3sUjnCLtHMNd4fdmEdOxUOlGly1/WsVyaFBRWN
 NaMWJ4meqPT3+ucrnaeauRPHL09VNdaD+5un45OYEJLhXo2VywcX+tKxdJrGnYNO3y6j
 plEri+zmmZvDuE/0AA4VpLQbCudOFtlI0KUmFTevOK61iuobL+RBJ63uzLCokb3fjLsK
 OKgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+5CaQVP6gEfDoMdCp3S4R0rJ41UGNyoGGiDeyneuUt1oF7a9pE9jOM79sDinsW2p1m8nbsN3zrreO@nongnu.org
X-Gm-Message-State: AOJu0Yxgx8AiHwpZa7PiJr4qm4UMTMNF9Nv87tOWb+xCTTgzxHNB7XJR
 IK2eGPz1ag43vCaUwUiOEs4kJJFTRDNDElxFYUssfznnUG0r9ybA3b+d/yd2/yMbzOuFU165xlw
 zlp37W+g=
X-Gm-Gg: AeBDiesoKSlU4v15ySRq6i0L6gEG6C1q6hAzfVOOz7INSfP8C/d9tcGw+XY+1b9K+YX
 Ib2+XylS4quW4uWHZtCYS9zSZowmWpJOymIrIgKeiFLO+oI+huPAjomocJ9G/YkXDIGFstQHPGS
 hV4jpmqayykfSBKkJIINBBZXeMa/8AB7QCr2SJlceWLRVig/Hn37CnuEIBuVQUUvK/IqKWKS/BS
 2kssKlfXEai4CuzLM1ZNbj0W3HWZhLrp4AzajDGH4KTUDo/lGLNOBxtnme14hmSEYPOm+VhUK5U
 qyC40UYIJntga/hH/RuZI+18JEb65iZ3ODxpmCuRJscn9vXLw0K8VLc17yKxzMBBX0Tom15zsXb
 fQkqwGNZeQZWw7Cm/6O/liSSAiouUwRYmKD4Edg4VC99dOqYoxrAV4CXx8G2hSvsDHNmb1EDlns
 XE676Rq+P2zjyIQ4itHqAnkIgzYAtS0WfWTZ/Fa4K39jQCBq2fdt3udB4bLEqisf7Rk0BCHCT0Y
 eOPNA2JwPQ=
X-Received: by 2002:a05:6000:200c:b0:439:bd70:610f with SMTP id
 ffacd0b85a97d-43fe3e13c17mr64355324f8f.44.1777277404597; 
 Mon, 27 Apr 2026 01:10:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d112sm82866871f8f.29.2026.04.27.01.10.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:10:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 21/32] monitor: Remove target_get_monitor_def()
Date: Mon, 27 Apr 2026 10:07:27 +0200
Message-ID: <20260427080738.77138-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
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

target_get_monitor_def() is now only a dead stub. Remove as pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


