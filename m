Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439D3F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHvm-0000ai-E4; Fri, 10 Apr 2026 15:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvj-0000VW-Bh
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:15 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvf-0001Ms-Dt
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:14 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43b983bb07eso1554144f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850850; x=1776455650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eA3XKlB2Issg1dkYmP2jSa4cjzBFSxxUi2nhDXWoMo=;
 b=dYfu5rghv18AVZXa0Jkeg1dTcpK2UYN0b4DWmJjfSrVytkKDS6S6uOyCZPebtcdv7f
 NKyquf/+f4+VGywiOG3DZXvSayKuZhY1YIniNqKOfiqTNfB6uX0RfJv/BmHEuYcAjM5b
 7tCW0ERDu43UGQuQFkpgH1Arqausiy/esmrn0DnK68JSafCvygfQwe5SxSt7XRK6tYUU
 EMvapI7lNLU4wcLxy5rNsiMV1N0LUEJZUobCU+gbaLfcotprXORGB8wf6k5qffcbvK30
 tmpRrLLrL49UE0EJBDfw6+Zobsc9ys+OeALlJrElm+iyW3mTmzcOphQFDD+NPdVJqErS
 EOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850850; x=1776455650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1eA3XKlB2Issg1dkYmP2jSa4cjzBFSxxUi2nhDXWoMo=;
 b=q1VSdXlE8597uQP9Y1lsg+4pSRDldVsg5dJXEkhWCleiJGM5eRa1f0Pk5sX+dCvsmK
 yXiAWWPTlG/qboXnJSxVi15wPEW9j31K7d8hg6odMVZODbrTMFLXOAQfYxo+FlA686/6
 cCI6+viMTiL0sHH6Aa32DmDw2dOe9dU/gKCRJSPMhLdXAb7ChO8dbu3JRZU9kO8C8nAL
 YYxqDeMapjwzCd4MZKR3fOLB8BCNfWqozmaXAIVYzqdpSy9/NbDrSxC4cajUeP8BRdOV
 4vtzptou/SFgugepW0OyB8beDXaOBvgbvz/r9H6UoVqNwiRglHExcbK8liZBW78X+n/3
 RJEg==
X-Gm-Message-State: AOJu0Ywgo04RVQuIK/PJVXLI1t/XFn52Zk/yQKSFbrmrxPdOyQNUw/y2
 2XR6vKs7wggfQ8CbmCIpFguOU4zrssQ5MTrray6MAASXbAaFL9y29v5ueiBNVDNAIAjT1Txavv6
 9ed5/XNA=
X-Gm-Gg: AeBDievIZlE6FiK2f98+j7nVsrcS8N1agNJKWYFyfFDJWSsO5IQBEcEBp/Cy0pSPAq5
 Or32tolePr69tKlSgx+ae/RHdqNhX/hHHokUgdGjm5QE82jDE/Z2RuneipD488R9Tu1ntPMulNv
 aFy2i4HdUEXYuD8E4cr74CcUvW7HzyMrUeZ/nebXwp14tXhd+lA9JTvFLgrdnUTTFI2ycYy52l0
 opSswyu9RlmbWYCoThsxYHnxlzUo3rW+vBNa7HFBfj/CZ0KMZiFZGyzJv7KkfH1j1LoGwNV3GMZ
 +IxpgohBODJBrkfP76ERt77YlzC9/Gaz6dRvKsoeDcJ5zFwUjJr0ZOQ5lK8Z9ugysagrf3ozvLq
 uQMbDCEWsEEFoSSCIvTP/R+8WmJfc3BOzhdok95LiJjU1JT3jF5y8L6oRNK0e6ZL8DxDhvk60fv
 M/roV7PMvc2L1JucDuE8kqnH8nhQJChA5rZmp3cxjVUnQOU4YVMAfoB+4lgPglFBA9heZgSsuf
X-Received: by 2002:a05:6000:220b:b0:43c:fdd:ea96 with SMTP id
 ffacd0b85a97d-43d642b6e75mr6383617f8f.26.1775850849621; 
 Fri, 10 Apr 2026 12:54:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec28asm10125307f8f.15.2026.04.10.12.54.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:54:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/27] cpus: Introduce SysemuCPUOps::monitor_defs hook
Date: Fri, 10 Apr 2026 21:53:00 +0200
Message-ID: <20260410195323.17937-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Allow targets to register their legacy target_monitor_defs()
in SysemuCPUOps; check it first in get_monitor_def() otherwise
fall back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 5 +++++
 monitor/hmp.c                    | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 7b2d2d2610f..a96f4907d05 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -85,6 +85,11 @@ typedef struct SysemuCPUOps {
      */
     bool (*internal_is_big_endian)(CPUState *cpu);
 
+    /**
+     * @monitor_defs: Array of MonitorDef entries. This field is legacy,
+     *                use @gdb_core_xml_file to dump registers instead.
+     */
+    const MonitorDef *monitor_defs;
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 983048db1b9..6cf2f3e65ff 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include <dirent.h>
 #include "hw/core/qdev.h"
+#include "hw/core/sysemu-cpu-ops.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
 #include "qobject/qdict.h"
@@ -1603,13 +1604,17 @@ void monitor_register_hmp_info_hrt(const char *name,
  */
 static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 {
-    const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
+    const MonitorDef *md;
     void *ptr;
     uint64_t tmp = 0;
     int ret;
 
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


