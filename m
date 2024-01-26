Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6D3C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHJ-0002M8-2A; Fri, 26 Jan 2024 09:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHH-0002K9-BU
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHE-0007wt-Tn
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:55 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3392291b21bso634144f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279631; x=1706884431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8W6Dmg/Z15G38A2ANLX0PCG/NULptGOn1F3YALWfvag=;
 b=fkEx0EjjHRzF3rvznw7+RqB3EJFj9s6om0y4h137cxnTPcjhjbuATTUIOSsqWrcku8
 mtufP+rbCoJdlWs5RVX6n+fYKRnYYiOEmQfe6PZYD0g/Zo2B6naQJR1X2qbr+Uopt72w
 0tmlUG7Npzno68sfDbxP+zKRu2CvhgXpmvGH8yBp/wZYJvn4rAzipZhRgQwRuHYZUr3l
 9Yguqo8be9o2xbdzlyVl1o0KP8n7g5Hv3PCTN/PvmACp1U+ZqaOFt/ZlKwxen1SJ4EHP
 8smtBXJUIYUu4+okXQJqTj0DEQiU7QBDJuzxXHaASW9+Cr0GBUNMWCfGTP5AMElRPPL2
 E16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279631; x=1706884431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8W6Dmg/Z15G38A2ANLX0PCG/NULptGOn1F3YALWfvag=;
 b=IOBaDbz5SZDeSoASO0zLxrRExCKf4sFrayV3pFG3I6oTzX1quiesA6G3G8eZhtpZvT
 MWplpQI2VEamu93eR6Kl7Tg3FfD2a8CvR7NBMPSLIwi+Ba8nD7ro1NyylNYCYbiscj7s
 3Xr3IUNFZa7L07CHYx+KI7lgNzWVJazbLQukwVsBhfVhzQ1eMQzH0qTITrHpmnND3whx
 WyAG6oSNHtze2Vci71lQ/XS2/Hoh4RJowrfKq1RVoZo14M9kFFcjV/viGp+zdz4kIsWP
 0pcxNathGRhf9DJ8Xg6fBXgOJiT1+fzFQ6LA1X55kPtLgEq+8j0qduGfVbn1SMs/WKM1
 OTXA==
X-Gm-Message-State: AOJu0YxYEcTr23t2LLxyRvFhvmc8bbWleJiZ8hp+oQO/LDGOYgylT+H5
 r7qkOPNMHNA0gNX8zH59wN+tAIeHfqFV1303ZM5eXn3M9bq2X2jo/Ep5hu+Xt74XvbCsvnY00Zm
 V
X-Google-Smtp-Source: AGHT+IF9uk3c1ASXF2iTrylbz01F2lZILul21p0dTjJY97LbAxFj3xdLDYkfRD/yqN8e6kmrAfG4gQ==
X-Received: by 2002:a5d:6303:0:b0:337:9b58:6b8d with SMTP id
 i3-20020a5d6303000000b003379b586b8dmr926115wru.112.1706279631407; 
 Fri, 26 Jan 2024 06:33:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/36] hw/cpu/a9mpcore: Build it only once
Date: Fri, 26 Jan 2024 14:33:26 +0000
Message-Id: <20240126143341.2101237-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hw/cpu/a9mpcore.c doesn't require "cpu.h" anymore.
By removing it, the unit become target agnostic:
we can build it once. Update meson.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-13-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/a9mpcore.c  | 2 +-
 hw/cpu/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index d03f57e579b..c30ef72c669 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -15,7 +15,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
-#include "cpu.h"
+#include "target/arm/cpu-qom.h"
 
 #define A9_GIC_NUM_PRIORITY_BITS    5
 
diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
index 6d319947ca0..38cdcfbe572 100644
--- a/hw/cpu/meson.build
+++ b/hw/cpu/meson.build
@@ -2,5 +2,5 @@ system_ss.add(files('core.c', 'cluster.c'))
 
 system_ss.add(when: 'CONFIG_ARM11MPCORE', if_true: files('arm11mpcore.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_mpcore.c'))
-specific_ss.add(when: 'CONFIG_A9MPCORE', if_true: files('a9mpcore.c'))
+system_ss.add(when: 'CONFIG_A9MPCORE', if_true: files('a9mpcore.c'))
 specific_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))
-- 
2.34.1


