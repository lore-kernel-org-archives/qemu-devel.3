Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C221093190
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Vsa-0006zv-7H; Fri, 20 Mar 2026 05:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3VsV-0006zd-Th
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:10:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3VsS-0003fK-VL
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:10:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso9328805e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773997843; x=1774602643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwEd3SP96owfBxqUTnmeX3xBEcgEs5+tbDNNCkTGnRE=;
 b=VDX6dJWYFpIg4ntdDYVNGRbCCP+Od3cNA1vCzOH/hkS3MLhZqKGbwL9AoOKqP01m9e
 gg6a5WyljONVHZwkItXFi6ngt5lA/eBn8/isacr63WpWlYZvYzpP5kv0nRFUCX5jLrb2
 9TeJI+owD1fjXLmcvx+tonj3LFuVh8Hc8Ehgg2g4/GmzxQ2O2H/IFwCMVlKf61t4dX2a
 z58Gob0nux0v5EKAnPiCNjJIPxZWqUfA7dtWOpi76nj7uRuiuml0UqRzDKhIAhlcIH++
 OIF9NPjMHAN6pPHcZUd1KrRwvjEQMvybN8SV3qoV4hq0Kpqs+PBEA4A1qiK2CsiNrTlD
 5kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773997843; x=1774602643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TwEd3SP96owfBxqUTnmeX3xBEcgEs5+tbDNNCkTGnRE=;
 b=hTQmTIl9bKznclxylObd3XoQBoYB4qNUrLBYJjExmg4U8WItUiIw8Us7ZSes1aTnIR
 l0YjZsHcfjIHKSx5TnJIOao2TLjMZKZIwRNy0C0DnoQrcGzuO6LlLk1G1aH+70ki+Bsp
 DVY1dLhGvDdEaqalw+z5jFriByUQ9rnJZ5rqGqrNOhkTH6TO4A3I4ewlJAsAYUaKgsKz
 tw/KPSnfkFa1437CzKiuTQZiZQ98hH/HJ64ZtI5mLjSpmmyOe6muyPV8qipeBSGT912v
 +C6XJHH6Ol9t+2YQKkNZUaBwf/rFLZ9U7TYZ/2XQh2bLGXBNP5CzDgv7Ptlypc5ZQz9r
 pAaw==
X-Gm-Message-State: AOJu0YzN8j3XCxpmPzQh9Xsq9wnEH5ruQnpG2HenxOvKIUVX/8kRYpiQ
 suNUENiQnjCmupdzt+knDZnLIu6IttQKvvIkZrUc2Ez7NLKM3LwnWtr7s2cmZ5mhN8hTARU5lzo
 aC/MIsW8=
X-Gm-Gg: ATEYQzz+J9lakp3x16sZ5ARyN6JVsezhCJ5JmsEFqOQ1Ge/5IMNaE38+WWMPb2udZjE
 24/gfm4OA5IGmicE/Ynswt5DkVTDHv/Ajk3ivgNt9X5vIBzKPfENFOE1jSz+UgFaIJYrpckBTdI
 /jEd3r4AIx9c/SozUgH1IxShX0u3Myb3oFOUJshjr24aX4QVY8G7xIGcMXW+a69EKxbZWG74Afv
 PwxspSShELGGNT0w23zzqSQUXb0HuTaAsi+7HgumPUOrvrHd5CvosKEDHCopndlHATgGmtxQ47u
 IlqUHLlSGvaQy0ofH2BF5ARWnPpbi2hBWpkakBsCP3qF3LRjuQEaMbm0d96bfC8PYjHn1ZdLN/x
 tRuFML5WOZuEiwF66QU3VH5WvnbBFxMSVxzncVF5dJepi4EzsmrBORDs5hl7Ms4Sgguztfhdgu+
 xjxcv/v1zWiV2VDDKCND3QXTt0l+UkLr7bBzsNeUvuAuTusKBO8x9CiVczszrUC06PVc7R9lRB
X-Received: by 2002:a05:600c:8b18:b0:485:3dfc:57d with SMTP id
 5b1f17b1804b1-486ff01ca8dmr29809895e9.30.1773997842770; 
 Fri, 20 Mar 2026 02:10:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe8359acsm48255075e9.12.2026.03.20.02.10.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 02:10:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-11.1 v6 3/6] monitor: Have MonitorDef::get_value() always
 return int64_t type
Date: Fri, 20 Mar 2026 10:10:15 +0100
Message-ID: <20260320091019.59902-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320091019.59902-1-philmd@linaro.org>
References: <20260320091019.59902-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
return a int64_t type. Truncate to 32-bit in the single caller.

Note, this handler is only implemented once for the x86 targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp-target.h | 6 +-----
 monitor/hmp-target.c         | 5 ++++-
 target/i386/monitor.c        | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 56322ceddd4..6364c94edf8 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -27,15 +27,11 @@
 
 typedef struct MonitorDef MonitorDef;
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu.h"
 struct MonitorDef {
     const char *name;
     int offset;
-    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
-                             int val);
+    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
 };
-#endif
 
 const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 3f019ae2a28..155caedd784 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
@@ -33,6 +34,7 @@
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-machine.h"
+#include "exec/target_long.h"
 
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
@@ -78,7 +80,8 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
     for(; md->name != NULL; md++) {
         if (hmp_compare_cmd(name, md->name)) {
             if (md->get_value) {
-                *pval = md->get_value(mon, md, md->offset);
+                int64_t val = md->get_value(mon, md, md->offset);
+                *pval = target_long_bits() == 32 ? (int32_t)val : val;
             } else {
                 CPUArchState *env = mon_get_cpu_env(mon);
                 ptr = (uint8_t *)env + md->offset;
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 977f65fe16c..b128334e571 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -593,8 +593,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     }
 }
 
-static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-                                  int val)
+static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+                              int offset)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     return env->eip + env->segs[R_CS].base;
-- 
2.53.0


