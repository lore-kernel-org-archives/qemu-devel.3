Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FD5CD3440
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcqg-0008UX-Vh; Wed, 06 May 2026 10:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcq7-0007kO-1x
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:09 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcq5-0000z5-7t
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:02 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bc56c52a0d1so120731766b.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076178; x=1778680978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M8r5iA01i1XHEti0t8TY7QQtNNhBKRygBi+/ersf6DI=;
 b=JydtjFOmhTv2ZYBqlbm80S6DO5VRT+DDVgbQTf4RiawtzhdFwCD5/1SEWxZFKtq0v0
 t9XFgo2lkF6/8xs1RmH0Wg+oXMhbiNF1VfkaK963ekGqjasKWliYBn7HZLn+dPCIMfAN
 cKEqKuupXnTBw9biVyyQZj2rW9prTOVlahNwLSdgF7U219iEQYsPoc7x4b7KWyRMIE1m
 a5n1fHcRfDumUPqURikJuhEIFHEfAJNM5JYITdwt+a8kopvtCgErEuPJnpRUW5/aHRaP
 QK+t6mVLyPcBb3VP+DZLc/NIkaRS06Phti9rdbqe4aXG1gk4Tj5iFxjq34dVsMGbIi68
 yKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076178; x=1778680978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M8r5iA01i1XHEti0t8TY7QQtNNhBKRygBi+/ersf6DI=;
 b=RonwALBDW59b4mD1JkC0ybxnRuFvKqJLofxcYO3tblm/+uVWjHXgkDMdmL7luJUixo
 umOLwTM0jt+tEJJL7LCgbOfslEwk5xTiGxI7+hjVg8SXyc4QIkhYhG5t2HJHDHzlP21d
 cbW55JX/WnsnE6WC6Pc6SzfuSO+8tx0Zrd7b83HJhXvsR1hlACdwE3SbYLE9dM1jw9LJ
 uulQyGVLP7NiN/h67V1aEXISZ1GveAQEH+jiX6wMwE9jJ1UoiM3rXtZclGrrDOihx6fG
 4hM1QF+uyKAvbBlzewS8TjZaQ6LEtLw2d+x7lP9KXSRLJFaBmrD3WcEe9rRCDYNUjIEf
 Jjow==
X-Gm-Message-State: AOJu0Yxct/cuCpPsQsHj8ZAEvvHdLhsPpDBiAUPhvhiaJJmYN+TtS5xf
 776iSzgqu+lWF6vV+QX2xVbYRGmA4bv8jcXGJirN+zwhNfkvqmSum0f4Xfjod+/MqwB3DblDUIp
 lktWhMM8=
X-Gm-Gg: AeBDietBJtOw32i1I83CWz+SpCT5wMXZ5QmhQUYRDWEkvlreZbm+09rBmLgwAYBGvyI
 POBnMwdRpsLGgqB5/dvskDojMwVdcfi8l6YBvSqX83qaJW0rpjxz94XPoMm/IVt3E/BHIQNV5Db
 WwR2ccErhDYNqGrbzp5ZwExDhDG6PpR9fQ0tJpzXqkr9+zh63vwK18LQwUtRG/SiftwtkZYzqx2
 Lh3UQLrAp8FGWW528IU4awANGGxqqx5+BvLuLHze+UJXSUmjZSQCDCtiHln7ZvCabENfsT4jRmG
 Hl0ZUUBS0bj3R8SvCj8jYsE9DT3kg63wjovrrgdDMeULROJ7aUcOZPf0UAtp5DrPPty7sZ6qH4T
 XkfD60dYamFhc6UZcP49MN7XJAgMbgQMDu/prYQd+Q4zCLp2XmYKYDmvwKWidIZvXoVhTE8FEwo
 z9erlyu4lzyk4JwdYWQJpxoiumSwIzJRi3YIwBTAfPzwXr7/nKWDtonQklPiYGnQy/RnU0wiRbE
 jdPdIKjwxYi3KcmlLZuSg==
X-Received: by 2002:a17:907:c817:b0:bae:456f:fbb2 with SMTP id
 a640c23a62f3a-bc56cd3b1ccmr205961466b.23.1778076178001; 
 Wed, 06 May 2026 07:02:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960973sm12666305f8f.30.2026.05.06.07.02.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:02:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 058/110] monitor: Have MonitorDef::get_value() always return
 int64_t type
Date: Wed,  6 May 2026 15:54:30 +0200
Message-ID: <20260506135524.20617-59-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Simplify MonitorDef::get_value() handler by having it always
return a int64_t type.

Let the single caller (x86 targets) sign-extend the returned
value, directly handling 64-bit CPUs in 32-bit or 16-bit mode.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260427080738.77138-23-philmd@linaro.org>
---
 include/monitor/hmp-target.h |  6 +-----
 target/i386/monitor.c        | 11 ++++++++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 008c1a6570c..ae34ca65ded 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -27,15 +27,11 @@
 
 typedef struct MonitorDef MonitorDef;
 
-#ifdef COMPILING_PER_TARGET
-#include "exec/target_long.h"
 struct MonitorDef {
     const char *name;
     int offset;
-    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
-                             int val);
+    int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
 };
-#endif
 
 const MonitorDef *target_monitor_defs(void);
 
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 977f65fe16c..98df5c7fd12 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -593,11 +593,16 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     }
 }
 
-static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-                                  int val)
+static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+                              int offset)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
-    return env->eip + env->segs[R_CS].base;
+    int64_t ret = env->eip + env->segs[R_CS].base;
+
+    if (!(env->hflags & HF_CS64_MASK)) {
+        ret = (int32_t)ret;
+    }
+    return ret;
 }
 
 const MonitorDef monitor_defs[] = {
-- 
2.53.0


