Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF313C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaBW-0004dZ-8X; Fri, 06 Jun 2025 12:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBU-0004d6-N2
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:44:48 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBT-00039w-2a
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:44:48 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so2065663f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228285; x=1749833085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUp6HMosko5+RmwM4ev7KubdCI/J9zGOgFIy4jTzBlM=;
 b=qD9yirwmj4TVcKhAn0p60hkJ/dX9w3BSjwR75fQ5aOiibX8QfTR9/9YkHvp8iFZ8O+
 MN6z0+jrVUzSA0OZ5eJRoSsDxr3IJj6RSozezFq+1n/64Pl8rALHfGNlD6b9SAfyS3/l
 BBAuMFpE4YNp7ty7ULcY7L5+0EM8OjEQ9oJamSMLjy1MYERgDp6BfH0L6kBIJH+JffeQ
 /JOIHtAfzdVKrr7DCAXM3oiTL2RBZiQ7FCErl20jR/eZvXcV/kzpmpDjUPyzgKQanHuU
 u6f8SDmY2PpdPmFT2EDZlRTqymZOHlaqpmmLAr3400NBC1VNJ/Lzj5We2KLgUd64z/RW
 3vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228285; x=1749833085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aUp6HMosko5+RmwM4ev7KubdCI/J9zGOgFIy4jTzBlM=;
 b=gu5xYOBhA/EwSaC2lY0SwkXvWP8XqixUv3/JwMXaOBC6Gg97EQf/lAdMwBuPVwIuHW
 6IyrQJfMknQWONVxzk8NldLs/YnUU5A2KyYt9FNh7Y+fYpk30QLk77xtv8g4nvqQxizf
 fXOApb+RDBGClVaWmcwud5AJfDFpYicQGngDa4qHAcT06YYSMKYo0M3zkRep9EhNPAc1
 41HVRT7T8PhjaNHkEISdXWBEn1p90DEghFjcGsk733XH7ayMuKLqN5c7POdX/o2D6j8M
 K4lNLe2DAR29DKHj+v6DX/LBPPVXcHbV6oVCgXxk6fpchoBprUBnSfVoDo6CY8p0vMlB
 wE6w==
X-Gm-Message-State: AOJu0YzXIJpbuH9OY20qiJ1X4H1YZP53l7STfKecUy8W0QMRBfWgOkGL
 EfCKzA8CWxmXRm+AES6+i7cYw0oFDpWh948NUN1K+AHR5PzXfmZhkw9J34rw2uZCRF37A0ivOPi
 eAwIDU8E7iQ==
X-Gm-Gg: ASbGnctZHEHI6rR5ZXtom6l9RPJUU9BwncOeNB9rcaVdvj0B+Z+uBsz94H2qr2D0OkS
 OEmeakFmoSTq0EhCoycrDPOheny5IHtiqaRCCqFTbPy656vJpsSMFpX79hL+ADyiG//4bobQt6z
 /JzJg64LCFf908IcGQGI/M8M+xiuNWzqyl173AGRhhQYDiGkb3vXzghY9taLap67vSr+ZLLA+0l
 fMJxqtcfv3YjOxGxzowqGG6EvMhCigPohEpGjDEXXZ6UU43Ebt+MHA/whqjVERpD26IpCa9EzuQ
 kyE/463rneKA6hn88Rj1hWhTpLX4c6XrF2aqmxM75MoXHRulRMcd7yqR7a43FTAn8CMORXv6pEh
 SFQgZHWtuRJDjBCLn5zaSMCLDH9qwyqLtnA9UohELJS3Sb2Dm
X-Google-Smtp-Source: AGHT+IEFoy0iUsm50S8C5X9dDeALmMI23Uup+Xi95anscjkLGUgqXs/1YmskcA2kRwB/hddPmbmz0w==
X-Received: by 2002:a05:6000:2c10:b0:3a4:e6e7:3acd with SMTP id
 ffacd0b85a97d-3a531ca7d4dmr3344706f8f.18.1749228285001; 
 Fri, 06 Jun 2025 09:44:45 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229de70sm2304909f8f.5.2025.06.06.09.44.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:44:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 03/19] accel: Keep reference to AccelOpsClass in AccelClass
Date: Fri,  6 Jun 2025 18:44:02 +0200
Message-ID: <20250606164418.98655-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Allow dereferencing AccelOpsClass outside of accel/accel-system.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h       | 2 ++
 include/system/accel-ops.h | 3 ++-
 accel/accel-system.c       | 3 ++-
 accel/tcg/tcg-accel-ops.c  | 4 +++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index fbd3d897fef..23c62cbeb07 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -37,6 +37,8 @@ typedef struct AccelClass {
     /*< public >*/
 
     const char *name;
+    AccelOpsClass *ops;
+
     int (*init_machine)(MachineState *ms);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 4c99d25aeff..44b37592d02 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -10,6 +10,7 @@
 #ifndef ACCEL_OPS_H
 #define ACCEL_OPS_H
 
+#include "qemu/accel.h"
 #include "exec/vaddr.h"
 #include "qom/object.h"
 
@@ -31,7 +32,7 @@ struct AccelOpsClass {
     /*< public >*/
 
     /* initialization function called when accel is chosen */
-    void (*ops_init)(AccelOpsClass *ops);
+    void (*ops_init)(AccelClass *ac);
 
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
diff --git a/accel/accel-system.c b/accel/accel-system.c
index a0f562ae9ff..64bc991b1ce 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -85,8 +85,9 @@ void accel_init_ops_interfaces(AccelClass *ac)
      * non-NULL create_vcpu_thread operation.
      */
     ops = ACCEL_OPS_CLASS(oc);
+    ac->ops = ops;
     if (ops->ops_init) {
-        ops->ops_init(ops);
+        ops->ops_init(ac);
     }
     cpus_register_accel(ops);
 }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index b24d6a75625..da2e22a7dff 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -198,8 +198,10 @@ static inline void tcg_remove_all_breakpoints(CPUState *cpu)
     cpu_watchpoint_remove_all(cpu, BP_GDB);
 }
 
-static void tcg_accel_ops_init(AccelOpsClass *ops)
+static void tcg_accel_ops_init(AccelClass *ac)
 {
+    AccelOpsClass *ops = ac->ops;
+
     if (qemu_tcg_mttcg_enabled()) {
         ops->create_vcpu_thread = mttcg_start_vcpu_thread;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
-- 
2.49.0


