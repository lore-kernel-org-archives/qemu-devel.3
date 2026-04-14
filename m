Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5B3F531CE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRh8-00051m-KO; Mon, 13 Apr 2026 20:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRh6-0004hr-Io
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRh4-0003M0-Ls
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so2752313f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126713; x=1776731513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+EDDgWhJI3ORltCGjgBjB3nc854c+rlyGvs0etBPgA=;
 b=ioRPO7nzNfpEFh2dn+h8ECnRhycx3trFIglluKEpAa5BNKXQZ09IxuQGVKI7Jc5RV3
 BixTxW4/gCJ7EIYHPC6v0lDwPrPwU13V9Pd/VkCqJ7clH54LfM+p9kCMRvAwT3BnRROE
 kERI4nxGnS2w012DSJIAeVszbAEw1QCHrkIRkz7ywl3GfqWNs0xj1WTD09r55jHcYkmd
 ZW4nO3ZPkCij/JNnQ0hWFlV+56V43CA4Jh5MUolJwT4Q78jkB7facb2ADgNZFcI8pyD6
 EQn/6VHfqDKfzevmHlyv4Yuxyrah9DouRqMfdKgrGvqP1wTE0m7UNv8CIS/56hF7yLOF
 FNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126713; x=1776731513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e+EDDgWhJI3ORltCGjgBjB3nc854c+rlyGvs0etBPgA=;
 b=QV35nZK6V/F3bu9Oj1HvccBwgZmnvMfJsgIyZM03+Zf0zToPKg885E9fijF7RAP9Ss
 IuBsudzkFAiKxGTthPMfm4CWQ1QtqgHWJjBwvgAgYegH2SbeEn0TUDOJrzZ/+r7KpRAH
 lXozQqdmxlfjINqPNeltHkNLk/bEwjFXg/9ZJFFp6VpnNj6BBNoBKSLKxLNMXxyeD+Hb
 8fZZ9jjuZNbEhzjeAAxfjVbhCy8Jgy9PPLWbf6KVNcq78/xy4fSiuK5e2T1t+fjQJuvR
 wuHWOW/1NJK8Oc8KRlh9Ywy3/ZsV6w13809DPf9LHznhs3Ho0h98IfObCIKTVOOsTV1I
 fwKg==
X-Gm-Message-State: AOJu0Yym7mwLIHD1ck27+jcp7mkUJZLqWBZ2FHoTS9eq+RFjbQenZs5+
 wYFOXbwJzbUJyp/CBHIfE3Osf8PQLIG2Ym9/FCBTyqH5gndOAg6QyhO6GpJfpNmcgG0wT4hRX9B
 WwSv91wQ=
X-Gm-Gg: AeBDieuU6fFe4xeeKfLVQwWByFkkTAzKRrGYCB5Xd5zeTMvXNWqxJGB+XG7rb1Xm7bc
 oayZ/Xea86/Wl+sawo325WI55l1eo5/39oG/Q8TWFseaj8YleJj1zUKE6AkIbDyEkoIslxAz9bM
 3ZhQmGNHtb+kAbQkrNO7KPTAh5imPupNH3jNEM8IEFwJWw8X2vwAeZXXaQXc182bZkGSAowIAre
 5W5eXVrSmzU7h4vWY2pNW91en98kh/USN98HN/geh9L0UKv2hb4tqGKPEhP8B14WCiFBVuEO3s6
 3EiggP90k4QZ8I3igNxOggo6Xzn47kecaMMJCp0tKKMV4iBp1lhrIiTshfFkCdWnB0IgVSNvqYl
 D6NtGOiM2fBcZE5JHl/M69jf+gUNH25AQ9ODR6LNMxvYmf1UNP5iCuy0zrGFlL2zQDoAGxkjvzV
 Yux/pLPLXMNbZzm2CPUqp+U9p+PqFoN3gANGP/HdCiLfOZMcmAIC8r2X3o7Nfs9T4n1+QehHUh
X-Received: by 2002:a05:6000:1a8b:b0:43d:7e6f:37fa with SMTP id
 ffacd0b85a97d-43d7e6f38cemr3183194f8f.19.1776126712801; 
 Mon, 13 Apr 2026 17:31:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7c135fd6sm14694414f8f.28.2026.04.13.17.31.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:31:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/27] cpus: Introduce SysemuCPUOps::monitor_get_register()
 hook
Date: Tue, 14 Apr 2026 02:29:47 +0200
Message-ID: <20260414003001.97571-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
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

Allow targets to register their legacy target_get_monitor_def()
in SysemuCPUOps; check it first in get_monitor_def() otherwise
fall back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


