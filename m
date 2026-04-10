Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176C5F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHvf-0000OM-Jq; Fri, 10 Apr 2026 15:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvc-0000Lh-4y
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHvY-0001KA-EQ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:06 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d01d6b50cso2410703f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850843; x=1776455643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpWqUPwhfS1fPWpJ/GJCnH26mtliLzp4q5CtM+NZCuc=;
 b=WwdiUehhqkEgYKiB6GX9PB40bOmomgckc5Ox79zUr83e3rK06b8MPRIer9Wq3CJFZs
 vPOTC4xQaTKaj0UZsueukJPb/ZJdfvUflvE0IixKcLSckN6fiwH1RESJVj7xggkCBi8a
 8mNUntJ5ZC/gFGiKHoswDN2STq0utP8c7RsFpM0DiU1esOBdNAfM53wYdVCkW8ktnPQq
 6UMo/LBTBouc4TklQjW5m4vEbcAK29f7ftqNSYHPi91chJ3+3LJ3WBs+2yHEHXhtik+V
 gmuFFSfh6o32LWO9BAfunxNtWuEdK7OkwQkaoygE3Y8eLNsu6zGw8cKKOm8U58m2DUEO
 cL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850843; x=1776455643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MpWqUPwhfS1fPWpJ/GJCnH26mtliLzp4q5CtM+NZCuc=;
 b=ncPp+pL05IYdD8K2o3ElSLEQWbg7VgrHAyNrLqoWZVsHFWVhfJy2HV47YoKSt+e08F
 aMJgUnZcTsnH5dzjfEAxNdDOQo7UGr//lWIzf9vBtEb69fCYvvON5MQ5LgYisZqvjsYC
 5gb2A8phdvj0BTKrsVXuD65t1/jWwlDzcBoO2X0Isdt48mNZJ+06Vi362abmBNnA2uld
 HoVliXI+EYzuanUM30L1wH6SAS5w27R38n5UCFzTi+qioYERk4y8fTkvCD/wj6UbT9AW
 2pPO79lR9wATI8TqI0XtWia6TitrY99vhKCsPwT8n/DnO5oE6x2KG9d2gDcQpa6ICKfr
 ZGNw==
X-Gm-Message-State: AOJu0YzYVjYICMy/8vEo/HlNTGuqwis8AxGSkQ1RK/3D6Ol9Hng5r9hM
 KFC5xhcBWC8KM/E5dhUO2srbTKpWYyXoPGFdRkgarqkv50K7OT4amFpuc0s+g8XVx8nLvswFbUl
 hmYqFEWo=
X-Gm-Gg: AeBDieuzXqJs9Uxwra+WqRYe49Lk5DfErSxeD3+odkWyDdT1CMOIooVuxN9mmyJi69U
 EJVHTuNtPmO6XLL7tnSpU0UTAuRkURq5Jde3dKVgJHyFsOTC9sEHXhEyD8vNQoz0L/nvcMvFYHW
 o2SFypNrbTfqqWAl6V25Vm8V3tjhqVkp4Dm/2OMLnHSVv4yT/mkumcBB7AoaRIyz2BpIvYAMuYc
 TeX0yPZMCawA8JnGtk518DJmh2bfBa7kXQq+EcJxIz4t5Cj4qnwTPAKz0M4NcFEdF6AlZOV6jvs
 25iuOYizwlc5FvbL8GK21S01roU5duAsylUthTAk753uO/uybfyMjdR0DadGaOKWxiHhqaRXrUT
 wm0qxom+ulekHJll9iFFv928W0SVZUuoARxg27r+BhHfUIbBJ6ifpAbxyFBox1G3e5sz+a8Sgi1
 pofTsvWiKHaATlI9rLHpU+QWe2BMyKIAHRyZ+PUgqnrtI1IHanTric+U/M0vh3CHUURrMfhmOf
X-Received: by 2002:a05:6000:2886:b0:43b:7ff5:fdf7 with SMTP id
 ffacd0b85a97d-43d642c8664mr6778189f8f.29.1775850842547; 
 Fri, 10 Apr 2026 12:54:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5d85fsm8599729f8f.36.2026.04.10.12.54.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:54:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/27] monitor: Forward-declare the MonitorDef type
Date: Fri, 10 Apr 2026 21:52:59 +0200
Message-ID: <20260410195323.17937-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Rather than having core header forced to include "monitor/hmp.h"
to get the MonitorDef type declaration, forward-declare it in
"qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp.h   | 6 +++---
 include/qemu/typedefs.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index f17a50a3fed..516089eb5c6 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -17,11 +17,11 @@
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
 
-typedef struct MonitorDef {
+struct MonitorDef {
     const char *name;
     int offset;
-    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
-} MonitorDef;
+    int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
+};
 
 const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 416a8c9acea..07f2ae7c9f1 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -72,6 +72,7 @@ typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
 typedef struct MigrationState MigrationState;
 typedef struct Monitor Monitor;
+typedef struct MonitorDef MonitorDef;
 typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
-- 
2.53.0


