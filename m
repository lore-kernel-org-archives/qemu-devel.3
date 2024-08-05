Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79916C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb27L-0001JA-7a; Mon, 05 Aug 2024 14:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27K-0001F9-2A
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27H-0006QZ-W4
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-428085a3ad1so75676485e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881250; x=1723486050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYMjdBet7Yoml5axNQCgjfc0S4lBa+FajRuNH3b5IpI=;
 b=KQDvBtnPnZRFgE+feZpLHPBY17UPbzeabHuyKljZYfldxYWZByuJdWUa3Kwtk9pwZz
 to4aizFDZXbY0As6K1vM9w7larkYHHJEZeR2hwRfCMTNdtNDmBSzSYWvVkgNxpt39r6J
 N5w1fu/WRj4fXqcZPrySXGWaa+BHsT+0c+dHvxSWFKSxc9MyunvHKhYGdEBzovYWaQK7
 Y+HCHLbxp7AKukSNvBLCY4ImxtiZjQ+22DH+NBuzoPKdHCb24RpiTD8pO2J/tvAxLOVM
 Zs9tuFv3bSiFBGc3vuOR+XrZRvLRM/5cHCtuw+FkigglY13zCJr21WqvMvL/O7cyvayB
 UvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881250; x=1723486050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYMjdBet7Yoml5axNQCgjfc0S4lBa+FajRuNH3b5IpI=;
 b=TdMCC08MAErMBIS5Ie4MNMYZIaWom1hRdc75PltNTzPYK25pPVLV5+Jcu0Thqvc+nu
 ZDKGdY09G78WOyEoVizmVravxtOyenh0RKqb/l40kXV/KJX9O6DWFTYQV9Khte2aiTEc
 R3H5DwvAjBS5Z4LDprWeEpyOeg4Der7T1T3otEV94he0Iduuh0NU1JgsNeCiG13tTkSH
 z8V9MU7TwXgQw8r/mHBDH+BiJ0Vg0/JB+w/Z2+BCWfRfv9GqFiuzlIQDHoAi5myOcjjL
 OGFCrp/ElXZ/An4QiBJ8yWJjvSw4FrqZtlV8RVqHzGZfKm/ZIGwJQDGEQMEW3fdB7a3E
 QjyA==
X-Gm-Message-State: AOJu0YyeT1ceQPaWVQCnKpM/cCVrlx6JCQ6qOb9eR7sTkiFCMkdWj3Ti
 eCkAajqpgzU0vyJpm8x8faZhiaTzDax972zp+LBhRO6kBs6LMJykBfZpkNCDiDwfbDXFYkCN+2V
 O
X-Google-Smtp-Source: AGHT+IHFo2gzRQEW9I8JIFBtoYi7NW5fVonxqq9qGEVHJaQC1iT6jgEunTeAJUoWOYVQSbw94xS+Ew==
X-Received: by 2002:a05:600c:5393:b0:428:1090:cfd4 with SMTP id
 5b1f17b1804b1-428e6b83437mr81893475e9.33.1722881249959; 
 Mon, 05 Aug 2024 11:07:29 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb64b84sm208585055e9.32.2024.08.05.11.07.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:07:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 10/15] hw/intc/loongson_ipi: Expose
 loongson_ipi_core_read/write helpers
Date: Mon,  5 Aug 2024 20:06:17 +0200
Message-ID: <20240805180622.21001-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
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
Message-Id: <20240718133312.10324-14-philmd@linaro.org>
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


