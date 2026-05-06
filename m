Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF27CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcqR-0007uU-F7; Wed, 06 May 2026 10:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpi-0007MQ-AY
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpg-0000wD-PW
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b150559bso44918985e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076154; x=1778680954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MBVFo7jkXJxLoZf3PgcZx8GVnDIMsyILjmfxQ7o/Kys=;
 b=Ufpzko/lpir4WN1qEi3ji6HBISh6tLjefgjCCM0otYQgzLZSh6/P/gC+yENSsiWxc5
 AxKyWn72cx0cYHlVxnx7kvJxkSvfaWqVt/a3EPng2/fSWQnlVhv7t31NAS7QFoRpXsu7
 yz2UBVgHqZINH6Ox0lrqOIHgcUmYKpcWO3I930Ond/yTcBgHVQ04ZFPYs85OIzTx5ykf
 8I2CBGuQmfg3w9eg27gP1/mgPDD4fN9mQLxSXoTPEIR8U8X1fPL4iufwep8qZ3PYhJT6
 BIdCUqEglJ8IFdEUxbGONwykagY9pZK2zI8VBgKrSD8KgwBtVoPraeJmQlfxloCKvGgQ
 o3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076154; x=1778680954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MBVFo7jkXJxLoZf3PgcZx8GVnDIMsyILjmfxQ7o/Kys=;
 b=e67rcaQbP6RDAg7kNzAXUk9uXwEvaR73ZRQ9fFFiMk43YsGLu3Kn67qdOetXwuRKj1
 zw7BnJfjGez2zTAM40ULNQqu6uNkB+eVgIq7CKPEhB8VhS8qBMSrMGO3u8eI4AjxkxJn
 D6DrVW7QG7kNA1Wg/QPdncZx8iJQiJyp68WhAfeyBtbVZ/5BRs3PjtorZdZoHqhaq5v1
 s0kiNUGLQacvDVvoJlj9QGr2ScM3HTarf5kRmDBVy5GBMJyvpmUkPT8WpwqV/iK5LWzt
 oq2q33jNMquEAT/KZqDdFz9Pa8UtaiSLY5K5b2yJ+4NIUY+TpwmCNgr2RG1iG04JGggM
 ExaA==
X-Gm-Message-State: AOJu0YzzRnX8y6c4QkblyIO2FdELdcS4FwUI60NMXrO53orF8D81w+ZX
 rFwXgE0yVIAD/kGL4W4dEFVxAnZWLBLPlEP78aqaHv/auOqkVmPv2S19/rLdj8ZbOS8UK8HjhQT
 c1EgVKPE=
X-Gm-Gg: AeBDieucrMfhUdP+03vWBHn3//ehMOMOCp+CvExlbQig81g0ysMfxOme6GuC4Z0eCkT
 TUu/d9fqvVZcnWNWQ7wK8wp4s759qeUdvbvZldr2SzOJxxjnaYmQUcqaMiCftedtxvqc6eEvh6V
 2/otIBsHpB4kiKjqIhrcMoi35Ha6Cgz5/eZKUdTTgZz637Q3noKNhUr0ccn5Jfxw8ToS8RvyotV
 UV95iFmsaWO1HEX3mtJZXSs2E6rgfmNlxQGOKhxzPNXca6NARa6+Fhuv7ggmwAfSgk93LISs5XF
 hM3kajlMmTs3uYCS47LHB7IKBefKTs1fqafXPPMPIoetucgak20ThTvgWstkxOGsP1kKCSeHhoE
 c+TWoi/ayZnFRVOe6fMsFKaudLWKxIABqPpWThxaWS+5IYh+GURwV5G8WPXwoc9DSz7OghSe/c6
 oV6Dof/Cy4QWgV5QlHtrvNcl8yAm3mkFikeJOkAHfL5nV7SsTNheyFbzBG+LeCKT8GSf1hyo+hE
 j1JSnKhhzQ=
X-Received: by 2002:a05:600c:c494:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-48e51f41be6mr57650895e9.25.1778076154101; 
 Wed, 06 May 2026 07:02:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530b2947sm17331115e9.4.2026.05.06.07.02.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:02:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 055/110] cpus: Introduce SysemuCPUOps::monitor_get_register()
 hook
Date: Wed,  6 May 2026 15:54:27 +0200
Message-ID: <20260506135524.20617-56-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Allow targets to register their legacy target_get_monitor_def()
in SysemuCPUOps; check it first in get_monitor_def() otherwise
fall back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-20-philmd@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h |  8 ++++++++
 monitor/hmp-target.c             | 11 ++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 7b2d2d2610f..5b831393cf4 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -85,6 +85,14 @@ typedef struct SysemuCPUOps {
      */
     bool (*internal_is_big_endian)(CPUState *cpu);
 
+    /**
+     * @monitor_get_register: Callback to fill @pval with register @name value.
+     *                        This field is legacy, use @gdb_core_xml_file
+     *                        to dump registers instead.
+     * Returns: 0 on success or negative errno on failure.
+     */
+    int (*monitor_get_register)(CPUState *cs, const char *name, int64_t *pval);
+
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index a222fd4c96a..46ccbd14aec 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -35,6 +35,7 @@
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-machine.h"
+#include "hw/core/sysemu-cpu-ops.h"
 
 /* Make devices configuration available for use in hmp-commands*.hx templates */
 #include CONFIG_DEVICES
@@ -85,9 +86,13 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
         }
     }
 
-    ret = target_get_monitor_def(cs, name, &tmp);
-    if (!ret) {
-        *pval = (target_long) tmp;
+    if (cs->cc->sysemu_ops->monitor_get_register) {
+        ret = cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
+    } else {
+        ret = target_get_monitor_def(cs, name, &tmp);
+        if (!ret) {
+            *pval = (target_long) tmp;
+        }
     }
 
     return ret;
-- 
2.53.0


