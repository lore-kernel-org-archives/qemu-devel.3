Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED6CCD3442
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcrh-00027a-PI; Wed, 06 May 2026 10:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcr6-0000WT-Mi
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcr5-0001Bz-2r
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso62719595e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076240; x=1778681040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XQjXLV+ZgTD2AtRw0z/SHqVbFTw/hIPpAz6udWTcRtA=;
 b=jA6TxgIASGzAqS6eNi6zYDn8U8oFFabvuB/tt8pptzzt5oS5NaIFqzdkHHP7fGFoeZ
 SqscEtMEFmGw6Awvex6PWu/DkTeDnrnSFrSbMRRn7lIHmTO3biyTWM84NZuXUXN2CU/m
 AijrHc8xc3WDMx5H+PfXzbrEn02Omn0z05kzaZOXT2sE4FNuZUIf1xSDMP+R6Q9zmv8x
 1mtx8Zt0rXBn+v5qMLs6xFRPoN6dXQ2gIriBTGPbM62goZtE9s2xC7dR74XF96ekUBB5
 26pEkD2aL/xXptJx1qf2aUR000xg4wKJzYlC8jnGQMOnEFU9p+rbb0rLXXjsqcLxMUJ2
 5SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076240; x=1778681040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XQjXLV+ZgTD2AtRw0z/SHqVbFTw/hIPpAz6udWTcRtA=;
 b=oqtCHKSrYHfRwvJB8HfsUtsai0NynqEVat9Go30/Q3CaaEzZFCjQF8UNyDswSrQmen
 piOdbiiKNmYrAhS9sRnJwQ+UwcNNNgKhzRB3KyzNTGG4QFkjVg1hn7ymEWvDn9aivGbm
 bSWLXG+CDTT90g2TR/fiTDzqFvK0Gido/kxWd7ICRvh0s2yiuMFMn9UWQSMowDQk83XU
 PhoFc7iJ/B21sWcOr5uiZSRcrRtHR4/OXX/aEj1z292tx42Suvw3kpfpoB83z7/+9AiQ
 2ZrjZFBuuZYy0Ena9MyDPibYoVF1vJc5QnAbPNcswed8YzcnPU4xSQFHPjS0Fbh25F8f
 PpdA==
X-Gm-Message-State: AOJu0Ywxgl9TGw6KeB9cAiecwrQx/wSF0NRHcolztMh9/1tfYkcakZhM
 Ojt6AZYk+hBl8bJs3UpnIOuR3/lYRo2o59lB0E+xFEzLBkXA9uFhBGdS3jWI7jrqICQu2Ttcl6J
 NZuMKAPU=
X-Gm-Gg: AeBDietJV3GjJSXlH+yhKCm7iCf/JDV9y2EGj2qazcawVGPyINc13Mx7vyJBNBqzyFh
 S7UJ0B0ve0Ijjq6fMvlcCFKK9n4DoRoZdiwai7lG3SIIyStOEwF6DECPZAFaLYOKqZF9okh5t14
 bmhFx+w6bsXKtjtWKK1iXd3hFKT/dUfsMbgVss5+vthroV4tq3tHFJmJLZ6gv9pXqyolxkW7Wgk
 6WHZZgAgC5WgpgD1+CRK5XA0kItu0VadQ78XtsE6c6NPuUIWIKfrGEYOh/sK2CD8Jf5NQQ6mhwt
 bubdpQi3exLW35seFnZxZzcMRbvwHMs16wzpXMdJDTUhzEJrNF5EZRDPjknlbdEnlONtDQYiAou
 Ypon+oSZb6Lk2VjLbbUpcJIbyGaPHLV2J7Cbu9r/JDEYE0Xv+0ShWYY/0OqdyMetPgs9CxWFY/C
 UyrvS+bdWlQppA54hpeyeBxzqbC0+dB9yvfFLHRPSM0fapFChwm2RlLoP16F4cSe9NG7mUXN35z
 jeKwJagY/w=
X-Received: by 2002:a05:600c:2d15:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-48e51e16d0bmr36356015e9.8.1778076239917; 
 Wed, 06 May 2026 07:03:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53891163sm54736895e9.2.2026.05.06.07.03.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:03:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 066/110] monitor: Remove target_monitor_defs()
Date: Wed,  6 May 2026 15:54:38 +0200
Message-ID: <20260506135524.20617-67-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

target_monitor_defs() is now only a dead stub. Remove as pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-31-philmd@linaro.org>
---
 include/monitor/hmp.h       | 2 --
 monitor/hmp.c               | 2 +-
 stubs/target-monitor-defs.c | 7 -------
 stubs/meson.build           | 1 -
 4 files changed, 1 insertion(+), 11 deletions(-)
 delete mode 100644 stubs/target-monitor-defs.c

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index d423f54f904..9bf46795bd4 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -30,8 +30,6 @@ struct MonitorDef {
     int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
 };
 
-const MonitorDef *target_monitor_defs(void);
-
 CPUArchState *mon_get_cpu_env(Monitor *mon);
 CPUState *mon_get_cpu(Monitor *mon);
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index ad8b0d1a72e..cc4390486e1 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1615,7 +1615,7 @@ static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
     if (cs == NULL) {
         return -1;
     }
-    md = cs->cc->sysemu_ops->monitor_defs ?: target_monitor_defs();
+    md = cs->cc->sysemu_ops->monitor_defs;
     if (md == NULL) {
         return -1;
     }
diff --git a/stubs/target-monitor-defs.c b/stubs/target-monitor-defs.c
deleted file mode 100644
index 0dd4cdb34f6..00000000000
--- a/stubs/target-monitor-defs.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include "qemu/osdep.h"
-#include "monitor/hmp.h"
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return NULL;
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index 3489b1f20dd..3b2f2680b19 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -75,7 +75,6 @@ if have_system
     stub_ss.add(files('igvm.c'))
   endif
   stub_ss.add(files('kvm.c'))
-  stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
   stub_ss.add(files('qmp-arm-gic.c'))
-- 
2.53.0


