Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A52C531BC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9ci-0005tw-8l; Thu, 19 Feb 2026 14:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bq-0003Yb-SW
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:49 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bo-0008JS-Dq
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:46 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4837907f535so12133525e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528962; x=1772133762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vg9Yq7RObwqMLng5EN2fLLbwzE+0UIOLuXSANKUubs0=;
 b=uH5ApPyiWuFWsqAIZsp88xmHtKK9ztvFKeO9L5dZUieyQVWbYdcR7FXh953d2q2qZd
 Az7HwUpGcGxMtSY5B+1Q4MLYRIsK79IrvUhp2rgQ5z8nRbwST/vJX6BlMxTSyqZCc9Ci
 trFoHEMslCID0FsxPb5/xNmG2/Ve6iKg5TJXHsffRE5tnb2b5xef+PtK5eQe6yGNhBG6
 8HS1hxYK2gLeUjZ5nLgZoKxgegZjoyJO17/WKxSPVit9grWqEn1FrjmJsCvGWA+tASXo
 qaUYVXIolK3vkRYCrtxp27h/TkhxEgcjawbgo1aACm6PeErNHzMqRlydiZ4yjyERyGoa
 iKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528962; x=1772133762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vg9Yq7RObwqMLng5EN2fLLbwzE+0UIOLuXSANKUubs0=;
 b=f2jbwurUEbXk/qfdPm88oK48l4UMvHf1fOgenR7bo6rooguIv4tbRLzYXB7bdLjUZo
 flaUYiiP5rk+j2gSOg/cCudNShczg2UC38ATSGO1nSXQc2AlH+Phlg9IZ9OkoxTxJOha
 S8Sux3zpaQ4GE3m5KeBXnoOIJp59CF5yrLlK0B7A/ULQ9TsFlV+AxyLUsOdtRv22Aqpa
 cPoRWUu6azXCTpgCzGJo9iwWUi46WXx8FPztEcjxpYfVI+z/8xdGQW/Vj+jQkOC/Hpv4
 DM8V966Kg1RNU3MV2lfnV3E6js7evE0/5jsZST8CG2BSTORZp7zHbOS7TAVC09M9OYD+
 SwHw==
X-Gm-Message-State: AOJu0Ywdgr7bSfP49EYPslRhsbmZZ967Np3P6lQjG5Ve25MMGGurXKJW
 K2V3vWVjGz9MG9m+U+LgHSyeWlBjVIP/4ILi6vXkkl9+/K90dnlGvq6F4/iNl9jnn69/eoUPXs+
 IkFamDVl4qg==
X-Gm-Gg: AZuq6aLqiU9o106aucL0C6SlDjCTlmhiznEOqLaTUtZUEvOpx4V+Q6VszF+UVRz5/8z
 GbXKstJITJQPt/RCYPb9QKuFESC2AcrHCfcMFgbCTbRBExiPZrbpSb69XZMeoYeYiSYXaZdVYlO
 jWPcy97o7fSM6U1ZTi8IzRvZxkhp/ppdM2Ah2Ef+N4C4NVqPgHA+EHQovJcupyufzCKLNa2iWA0
 faWiOUIENpzoUDx+dX6k7ZHtvXiCFqPS/Y8QqsLplWO+nR2BazJSmqXPR7FzGUFy0Q4uQq5Pou7
 x27FKJiiQ/YuYRSZwFgriB+3V7h7I7X/9lCIE2eJulwW37r1kMv+cpSHoEt6xF8bnyfT8MUazSn
 U6ORG9icvF3duu6Vvw7RLC6OWi+uId5ueKzKkX/tOsgrm5QTiXbTzMVQqfYs8PHv5WGbWUnw0dX
 n6lRe+aFd3DJHSURfHu3witVxDUEjVmfNPhdpLyJQxFj/O2Lak8pFBX8Kvlr4Tz9mi3iY7x19B
X-Received: by 2002:a05:600c:444f:b0:475:de14:db1e with SMTP id
 5b1f17b1804b1-48379bd742amr313079625e9.24.1771528962611; 
 Thu, 19 Feb 2026 11:22:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31bac27sm23862645e9.5.2026.02.19.11.22.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:22:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 23/50] target/riscv: Remove empty target_monitor_defs()
 symbol
Date: Thu, 19 Feb 2026 20:19:25 +0100
Message-ID: <20260219191955.83815-24-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Prefer the stub target_monitor_defs() symbol introduced in commit
bf957284006 ("monitor: remove target-specific code from monitor.c").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/monitor.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index ccb7eb44d02..a9d31114442 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -244,19 +244,6 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
     mem_info_svxx(mon, env);
 }
 
-/*
- * We have way too many potential CSRs and regs being added
- * regularly to register them in a static array.
- *
- * Declare an empty array instead, making get_monitor_def() use
- * the target_get_monitor_def() API directly.
- */
-const MonitorDef monitor_defs[] = { { } };
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-
 static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
                                  target_ulong *val, bool is_gprh)
 {
-- 
2.52.0


