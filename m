Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E87D10987A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cQe-0001GR-Vp; Fri, 20 Mar 2026 12:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cPi-0000X6-ID
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:09:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cPg-0000ER-17
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:09:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-486fd5360d4so17709105e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774022966; x=1774627766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRYSLmqunllpzQ/lnCaZwfgg4b9UisGSGzPJEZG7tJw=;
 b=x1PW4tdtDx6Qqcw8cuG9uGpG00MKp09eSA9nyilUcU0kXyAQMjmaad//1+Zd4oSXOp
 OIkCinAT8Tm6/m+cT4bq3pfA4B7LyhBrUx0cIrHQDhJcmUwIkjLDe3e1xtZjt+gOU7NQ
 brFyulUwG49+45rslaruzYJQnwG9+Oz+kbmCD9LPwWQsEJd1+A/cChN9ZuRDFb2P3XnG
 c++0fpuMnw0EcFii6Sv+PMeHGnFtweVQ+tktogs1Pblmhy+Rwg2PeSNOJW86q1jtfj9s
 wQdut+4RQJ0TPcxO3rs3GDQ9BiFA6QkmxQlBqhk8op0CdNd+DQzAWsRfoATc8AzwvKCS
 bNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022966; x=1774627766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XRYSLmqunllpzQ/lnCaZwfgg4b9UisGSGzPJEZG7tJw=;
 b=Soj9rVNT9ll4A0T9p3B7WZd6POOajpvyFTm40AFl+W0IjuyzP7wCcZj1qyQZ5s8VPc
 v9b4jGqlV6oNHLVfeYXKM9Ks3i1h2cz6f7vDssa2LoxIwekCrPof36cd3sf5PX+m4Q+s
 e3yEwd37xhBGzaPVFuwv90TECAOGy6+M2H+sZau84ucyABm+W3sOBwZhVmjRR6PMgz7T
 p2PtPkS3HA/fpoeNB0jUIyoINHwA81r0WxRhPtsnUWnUDk7tm7xyv7v5823tOwWpGNTW
 Y/lUeV45u3p5YcFt1uOKr+ZOmbcdVfsBO3b104+YNQkSZo3Tcv1xbz0d72DtXRlzmCWW
 0sCw==
X-Gm-Message-State: AOJu0Yy8otoJdkaCwpqdVath1sejVkf70ioqkYVfUgMsPL7eTxhNmoU9
 +TOxMJnPbq7kwUqn+rWubyCnT6BMtMxgVp2MJPeZOtcHoRaQCkg3LjLKkLMayqXbEuNWoDcs5u6
 UVyW5yZg=
X-Gm-Gg: ATEYQzyNNHcG54jtXuW8hzPFecde+Vcr/efKfEFkw6jvd+BCvkLw2xqhwONilcji2kj
 vSZtj3eBcGKoV5d3Eab2p/Sopf0knQNUIPlJ1M0Wwa29jaZab2osxEYn4R2eo+I0Ll9s+2JdFh6
 6gibRycq+JkySPuseuqN8RoxAuQWDWCY5tLNWElh8F+eQGvMrwSScquglQl+pG3KephZHlG72mc
 agbqNpHoXlTtupyoTeX8DrUHZAUYT68Tyw1nf8a3rnbLayTDOpQu0+fbGNxQ6xHvHn0Nw1/2TzE
 HFiyi8BEg4H7qd4WvOpNz1/Jcl8ZuY/MBN067c5f5y4qXL65zPBlEiyRj2uWxMOBNpuVMBQx0YA
 ryfLBkO6eB5/6PNsABiZkFnVsE+TLn35bf1fGBBUTYLoT5ekEF09Du0bzB0bCwilBT/+Sz+HnLN
 tUPEo/Iu0SKDeRhkozvOmZPWWgvl/BE3cbvdyUsbOVkYGhPFIz22+5eFYNBfrN25O0fC6rt8eG
X-Received: by 2002:a05:600c:8b31:b0:485:9a50:3369 with SMTP id
 5b1f17b1804b1-486fee304c4mr55060035e9.29.1774022966042; 
 Fri, 20 Mar 2026 09:09:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1ce05fsm28094485e9.5.2026.03.20.09.09.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:09:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 10/10] monitor: Remove target_get_monitor_def()
Date: Fri, 20 Mar 2026 17:08:10 +0100
Message-ID: <20260320160811.28611-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320160811.28611-1-philmd@linaro.org>
References: <20260320160811.28611-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

target_get_monitor_def() is now only a stub. Remove as pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp.h          |  2 --
 monitor/hmp.c                  |  7 +++----
 stubs/target-get-monitor-def.c | 29 -----------------------------
 stubs/meson.build              |  1 -
 4 files changed, 3 insertions(+), 36 deletions(-)
 delete mode 100644 stubs/target-get-monitor-def.c

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index ea7e53060a0..a335e4ccd3e 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -23,8 +23,6 @@ struct MonitorDef {
     int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
 };
 
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
-
 CPUArchState *mon_get_cpu_env(Monitor *mon);
 CPUState *mon_get_cpu(Monitor *mon);
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index ad253347892..33197b35e41 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1628,11 +1628,10 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
         }
     }
 
-    if (cs->cc->legacy_monitor_get_register) {
-        ret = cs->cc->legacy_monitor_get_register(cs, name, &tmp);
-    } else {
-        ret = target_get_monitor_def(cs, name, &tmp);
+    if (!cs->cc->legacy_monitor_get_register) {
+        return -1;
     }
+    ret = cs->cc->legacy_monitor_get_register(cs, name, &tmp);
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


