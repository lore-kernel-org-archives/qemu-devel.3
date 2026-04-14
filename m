Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41032F531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRhx-0000Fc-EP; Mon, 13 Apr 2026 20:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRhv-000070-NM
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRhu-0003R8-6k
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4888375f735so48729125e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126764; x=1776731564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CX4HMtCLtaKxWP+CnhHEeurJGMT23nAqgS5xqErMf6U=;
 b=G7u7xKi0tZu3txuhUQEw4Dq7y8/C1MGPYCs7P6udmIu+w8eeerjH8S/AjyosUdrUd3
 38YOPlWX3YuFPJhl1yPoJ0UC7Y0F/+dxWs+x1orgFWe4i2UtZ+A2h1eRqk3Z9jnTX97C
 8Z1GqZgpqA0uSBpuqMuwUQWR0UDxz83JbZxHx+0BS4p45ta1qRkoApbi91jl3bLpJN/X
 /plioCzsOo/iA3iyDyKk7BzoSrcU0FPjmajxwPOhKYqokeiSUvTeWJ4uf5hciFrh5h0R
 sE0RvjiNS1VbtKwUwByuC7JxpVDmZwx0IDxFKt6PGw06sgRO6GpRhwBJhvseG8DhMVau
 FB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126764; x=1776731564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CX4HMtCLtaKxWP+CnhHEeurJGMT23nAqgS5xqErMf6U=;
 b=NRkq1TlMBCwaV92wfBPychL4nV7+0TbkCfVboNiTT9cGtuSowqM8TGA2Bk/YJwD3yY
 mXjGCZJJmELOnZY8hQiJSGDD3bLwmSAe6WJyDHdkk14Ep9LQd+Ir22ghzYLtAeWvNpI+
 vH2s3wMHTkCRSdO6VFLW+mFNgG0mBoLI9lEGTRTiKzgf04r1RQnCj2rz6HYhTv2dxxHf
 /v44T5U2urkiQ0dpYjCK3L1fZYc/UG5Xw9y2mFh5+Lh3Q6TROB1YOLtWFkZr6vyODx97
 9JnIGRKeUAlP2im+AomescneS6C4Bajb2DHgvqYyr0jKOPxSad0CNQIQimiu2ShxvEvg
 Kfqw==
X-Gm-Message-State: AOJu0YzRObQuNN5O+SaDJXQ7630Fz1/7t1xyTsbfadzdH/lL5Uhk5WbX
 vmosyvkd4/MBFm7Ewegf80s0r8Odk1YavF+Wlpndi2qhZiJ3XWQAqzCKNWTCm5KZ1QPOMjR4kb7
 KxvA892s=
X-Gm-Gg: AeBDies3M/QM3i7HkYHCi2GeTnnk4pZzV7FXBS9UPrcj17bSIc9ZKS0qtCzeQlmsfxV
 AuilmP6qHMw9LJAO3OS/3Gj76l60pwUOUyrr0xL++LmnYOh604YzKzmKb6yL7pV1zamL93eW7l2
 qC/OG6KNSx/ts8ZsAxunI/KFpD870jvkaxsPt1LpuMF68mrS9JmlZR511r58Q8Nr+MYsaa9e/o8
 EdHFu8T0gDjjaQSRzLvQc1Byw8CMZ8wcopKCbYf+20ZjuFSI8qvlkRNZ7fiRSrTRt0v8Q2ZIwLU
 KpYiHGKp60lwQpltKnvsGqgnF3dUbmqwPv0fHcVT6gc9Vuqe29NKO0FzdOxk6qCXgAZWQqLaPow
 nIICdaIJV9XLsltbKlI7AngXAkkiRBollfgpCSWD29IVlHkCrKa+P1ahtNUyWeYPj2Knev8ahpb
 SyXqN+pnhhNixMgQg/qy8ongl56lP8/h5E+Zs97zRx1G74zrXh64FFpDOaJYisxcbbMsNFE9NY
X-Received: by 2002:a05:600c:c08e:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-488d6864d41mr142234575e9.24.1776126764432; 
 Mon, 13 Apr 2026 17:32:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede15cfbsm6671665e9.1.2026.04.13.17.32.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:32:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 22/27] cpus: Introduce SysemuCPUOps::monitor_defs hook
Date: Tue, 14 Apr 2026 02:29:54 +0200
Message-ID: <20260414003001.97571-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
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

Allow targets to register their legacy target_monitor_defs()
in SysemuCPUOps; check it first in get_monitor_def() otherwise
fall back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 6 ++++++
 monitor/hmp.c                    | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 5b831393cf4..94e36ecdd18 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -93,6 +93,12 @@ typedef struct SysemuCPUOps {
      */
     int (*monitor_get_register)(CPUState *cs, const char *name, int64_t *pval);
 
+    /**
+     * @monitor_defs: Array of MonitorDef entries. This field is legacy,
+     *                use @gdb_core_xml_file to dump registers instead.
+     */
+    const MonitorDef *monitor_defs;
+
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/monitor/hmp.c b/monitor/hmp.c
index d7b2f731def..70e5e5c2367 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1608,11 +1608,15 @@ void monitor_register_hmp_info_hrt(const char *name,
  */
 static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 {
-    const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
+    const MonitorDef *md;
     void *ptr;
 
-    if (cs == NULL || md == NULL) {
+    if (cs == NULL) {
+        return -1;
+    }
+    md = cs->cc->sysemu_ops->monitor_defs ?: target_monitor_defs();
+    if (md == NULL) {
         return -1;
     }
 
-- 
2.53.0


