Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3716C52D73
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJgr-0001o0-Gt; Tue, 06 Aug 2024 08:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgb-0000a2-4l
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:10 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgY-0008Tj-6E
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:08 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52efa9500e0so769487e87.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948782; x=1723553582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8NieMjgzSjcem4/AV1PLU7Mhw3Kp6Q+yVzJJ4ns9BM=;
 b=vVMVw1PF5DwGxB5+jtlJXwZyyqYZ45qkqK5SEA3nmWLp8ggU/A07PTsiKQqzq1PVC8
 mMbfpIUQU/7AQ1gBz4wD3jrGbNWdQkyLZq2Jm8V2kVwHco5QldxtWQnHfxvnIh7z/aCA
 yHq9l+hvnOHbl3zx0Y1UEQvo2ya0MwWSEXh3/4Ae7wKobf00opvOYVHj/HdF/uCUR8Ul
 f1E+jVFb5gD8a2sZBti80BRY7b1vsIIClFk5DDnVbsXxQooUut51s5NTjOJVAH02nCe4
 U2Wdy95ib01MmIBvVZb0MvD28ZtahdX8+ysqqvDKdTUCQkYYwRIyoZ/8a9lP9WVi5QuM
 9I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948782; x=1723553582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8NieMjgzSjcem4/AV1PLU7Mhw3Kp6Q+yVzJJ4ns9BM=;
 b=V3eKxIPdci2SmKO6ngCLRePBsPPh5vnpIqgh1iO4vPo54EwwOH9GHvrkkoIJi/xEY+
 QJ2s+w8Z0haKB/0smKPSCWXOg13RoTTKPcZnVXIq0zohafJUbZkl1OjcectpTdGrb0ML
 kv9mF49HeKvyFioTOxlQgzhGBnsXJjGaZQqtJ1TYWM0X+hEEJ3kFGN6GwSYQjXk4x8ZP
 YYhlo5wqBmrhTZLua4CE0Q3lCJqa1tzknJHn1vyJmsuKen1JJk+Itb/wv40tPzKJFc+Y
 wAJfWaqIS77L6DVwq7oNgm/y7ouXAov55YeD1yM9chga9p4KCJNTAbB9jGMlZXDStwVS
 fY1w==
X-Gm-Message-State: AOJu0YyuyB6/Hasz3CIt1Kby5paL0V/5EA8lG9Ux9A20suOBGSRkOhAB
 VkhAecFXT2FD7SgzTU8Tz+q3pBHgHBU8CsOXL5h/u5gajzy7ionSOg5tStSTNwuP8BnZrjtGb7O
 c
X-Google-Smtp-Source: AGHT+IHjVZ0HfLp/SeamJ2fPShSNNluoG1+wZXgKtb/hnPmfEgbWQG1sKPY+SGbl6Qbp7/na5bRXDw==
X-Received: by 2002:a05:6512:3ca5:b0:52c:de3a:839f with SMTP id
 2adb3069b0e04-530bb36f2afmr8602574e87.20.1722948782411; 
 Tue, 06 Aug 2024 05:53:02 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c61575sm546609166b.92.2024.08.06.05.53.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:53:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 10/28] hw/intc/loongson_ipi: Expose
 loongson_ipi_core_read/write helpers
Date: Tue,  6 Aug 2024 14:51:38 +0200
Message-ID: <20240806125157.91185-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

In order to access loongson_ipi_core_read/write helpers
from loongson_ipi_common.c in the next commit, make their
prototype declaration public.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240805180622.21001-11-philmd@linaro.org>
---
 include/hw/intc/loongson_ipi_common.h |  6 ++++++
 hw/intc/loongson_ipi.c                | 10 ++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index 8997676f0d..65f8ef7957 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -10,6 +10,7 @@
 
 #include "qom/object.h"
 #include "hw/sysbus.h"
+#include "exec/memattrs.h"
 
 #define IPI_MBX_NUM           4
 
@@ -44,6 +45,11 @@ struct LoongsonIPICommonClass {
     CPUState *(*cpu_by_arch_id)(int64_t id);
 };
 
+MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr, uint64_t *data,
+                                    unsigned size, MemTxAttrs attrs);
+MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr, uint64_t val,
+                                     unsigned size, MemTxAttrs attrs);
+
 /* Mainy used by iocsr read and write */
 #define SMP_IPI_MAILBOX         0x1000ULL
 
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 4a8e743528..c13cb5a1d2 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -24,9 +24,8 @@
 #endif
 #include "trace.h"
 
-static MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr,
-                                           uint64_t *data,
-                                           unsigned size, MemTxAttrs attrs)
+MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr, uint64_t *data,
+                                    unsigned size, MemTxAttrs attrs)
 {
     IPICore *s = opaque;
     uint64_t ret = 0;
@@ -165,9 +164,8 @@ static MemTxResult any_send(LoongsonIPICommonState *ipi,
     return send_ipi_data(ipi, cs, val, addr, attrs);
 }
 
-static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
-                                            uint64_t val, unsigned size,
-                                            MemTxAttrs attrs)
+MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr, uint64_t val,
+                                     unsigned size, MemTxAttrs attrs)
 {
     IPICore *s = opaque;
     LoongsonIPICommonState *ipi = s->ipi;
-- 
2.45.2


