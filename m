Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236DDC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURHv-00056l-2q; Thu, 18 Jul 2024 09:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHi-0004Tz-Nn
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:35:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHg-00008Q-ML
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:35:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-426636ef8c9so2755485e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309699; x=1721914499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HR1xIddw3GQAkekNAdVkZHeDlA8TRFDNATHX/fKoI7M=;
 b=vMKLqrX7xK9RvfqBUj0b8tRftMVs19mq87WkEhJ76zH8//wWcq/kMaH5b7SDtifh7u
 JzHrYRmt5Fg9nT7jUz/Jk/Tbyu9ZRYOhboALSUQYQ7ybfVEdhVy1HWiPARsOvgonUTOK
 lOfQQnGc2bW8Z4E6/I2/LSondddzvBwVp8vNB+Qt61tdyJLQwed9sURlzVETlsJ2Et8P
 WucV5tA/ZlZjicbGhNWgCGLQKdyeEgtfHzOMjmKQwuzcyxkg4Jlb4UjedIK/fxyFpI3f
 LO7tfXOJo22z1P5HqeLo3iWb4zEWKMk0e4VCLpYS17jiVMWx2KDIOG+RqMQdKSi8QnZj
 L8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309699; x=1721914499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HR1xIddw3GQAkekNAdVkZHeDlA8TRFDNATHX/fKoI7M=;
 b=PvIdGPXwODuiNPKfjcfZxkZErYnZnsKjzCDmSp28uRqqAmkZJePLAL7xg4LZOetvA/
 WNwsiAJmZhQ4fNbhwxobqFby8GiaBubWg/yA/DoIe+fzMSiHk4s7ig/nDntM3HQEczxL
 3ewxlDXqKHBUxL3PrB01eUbujei2tua84ZLXI+CqO0xsc3vG/lpsl/LnJS6aASN0Td4h
 12Ga/fDzzG4PVJQO1z5DJwCw6m2uJXwVvjGvpHtO39rsn3LoPoWlUE2tSMyVRvadeDwr
 v1anQtGRzYi2ruOIHRV9tNf+Q/9G17bTYrU2TcKmg4tgw1iUtXXH17bGNixkwYHQ1u1N
 yPDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMUhbnas5arQS5msQke646blTcMJ+L/Ht0gix3Whab2yZCgbHknB0FTN2ZETSARgOlNt7M+sSUbg/37vFkjooZHthUdGw=
X-Gm-Message-State: AOJu0Ywyy2KucgtfCcGgxODka37VM/fWAyn5F2C0ypx8TABEUw2XkQc4
 NHFpiPaV30x5tAd6e7hOF9xlXNzSPFvsPPGYlQ//V8mkE8mDZnAXsUaUM8L1pn8=
X-Google-Smtp-Source: AGHT+IEBuK9Wgl7v3Mb2ywXiYq6VH85EO8mCHaNnE6ZUF/gNrHIqrmwmN8BNf8sqgAnMdT11v2ZydA==
X-Received: by 2002:a05:600c:4f89:b0:426:614b:1a72 with SMTP id
 5b1f17b1804b1-427c2cbd7c2mr37102965e9.17.1721309699336; 
 Thu, 18 Jul 2024 06:34:59 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a94f50sm14311575e9.44.2024.07.18.06.34.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:34:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 18/19] hw/intc/loongson_ipi: Remove unused headers
Date: Thu, 18 Jul 2024 15:33:10 +0200
Message-ID: <20240718133312.10324-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongson_ipi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 051e910586..aa1b0a474c 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -6,18 +6,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
-#include "hw/sysbus.h"
 #include "hw/intc/loongson_ipi.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
 #include "qapi/error.h"
-#include "qemu/log.h"
-#include "exec/address-spaces.h"
-#include "exec/memory.h"
-#include "migration/vmstate.h"
 #include "target/mips/cpu.h"
-#include "trace.h"
 
 static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
-- 
2.41.0


