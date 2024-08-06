Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CEAC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJfx-0005lj-Ig; Tue, 06 Aug 2024 08:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJfv-0005lF-Qg
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:27 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJfu-0008OD-1W
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:27 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-530ae4ef29dso1150916e87.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948744; x=1723553544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8RRMhLXR56plds6R4QKKiZtLeNwl7BDBlyuBOky7w8=;
 b=Yv3uU6tCf1T937m2RMfOuKTL/ax8ZZfX65jDM+IyWeCw13xe2f3Jj6cknPx5RY4FNl
 i6u5Nm0GDG7nCzwhTeX5WLZkaYhCo4Bri7bz8XIXQlm+zmzuq89eXg8/jjRjzKlRLC4u
 /MA+iG7GmpwYJN3cgGFZ96cOUIqHF0RDAwqa4l5G10FEcPsEQgEfKhXwui/ssJS3+EFK
 3i3+3aTi8geIzdnDMHsKCMWCHWtytafy/x4jI2wbArFpatAPdW+p/x86Ch2QG9hSEPiX
 0YOa/0XO1jPfjR1RWV9+7VxjxreXjkZp0w4aVyK/7j4tzyS6Apz2VTuoO+HEARRu3dXO
 vTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948744; x=1723553544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O8RRMhLXR56plds6R4QKKiZtLeNwl7BDBlyuBOky7w8=;
 b=qgWcg9o9IFvGDzooreP2VYkYC4bVUTvKlvaqFuogrDO/j4N3PtFlace3FuEme2Dkwd
 TG9yRlYptVk4nFgMB4Hdh7YqgBX182D2sb4jPP4vZzu6eFbcKs/urTYlDcN0UZNdRpEU
 20fFWpOQJb9WVtYVUFdo06ceGygs2o3T694nyVNuF1pW7naYXnqNL4A6pLZI5Zq0nkLF
 5hRP5pdJmLB6VOUbZe2VXpw108/xsQjlTYUdYyMXXGFX1DOoASgiIojddJeVzxMVAq0s
 1I6iBn7uqnGH7olr+UcJsIbdhkuuqH2xvXiNNtSN03Jgt2N7tU9FhiPtRvKbEMMTYtXv
 yXyg==
X-Gm-Message-State: AOJu0YzaTxCYalhMEeF5YzjBo/S256jzjrUFsByjZp1j6nGvpxLg1sPQ
 WnHr9nJuJeBJQcICK3UG4zXaPMnvbfoWmRpasSY/COGO2y8Fkp6DQXpfTeaUr0vTksF4zB7pXHm
 +
X-Google-Smtp-Source: AGHT+IHnGZ+3qMsZeWlpBhQLtvkBl9xykl5mxO0zIVBc7Wavo+lowRnYlVD2PKjy88XcSzWRDSVSHg==
X-Received: by 2002:a05:6512:3b89:b0:52c:cd77:fe03 with SMTP id
 2adb3069b0e04-530bb380dabmr12456478e87.14.1722948743824; 
 Tue, 06 Aug 2024 05:52:23 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e8383dsm551798066b.173.2024.08.06.05.52.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:52:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 04/28] hw/intc/loongson_ipi: Move common definitions to
 loongson_ipi_common.h
Date: Tue,  6 Aug 2024 14:51:32 +0200
Message-ID: <20240806125157.91185-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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
Message-Id: <20240805180622.21001-5-philmd@linaro.org>
---
 include/hw/intc/loongson_ipi.h        | 18 ------------------
 include/hw/intc/loongson_ipi_common.h | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 9c9030761e..70e00dc1a7 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -12,24 +12,6 @@
 #include "hw/intc/loongson_ipi_common.h"
 #include "hw/sysbus.h"
 
-/* Mainy used by iocsr read and write */
-#define SMP_IPI_MAILBOX      0x1000ULL
-#define CORE_STATUS_OFF       0x0
-#define CORE_EN_OFF           0x4
-#define CORE_SET_OFF          0x8
-#define CORE_CLEAR_OFF        0xc
-#define CORE_BUF_20           0x20
-#define CORE_BUF_28           0x28
-#define CORE_BUF_30           0x30
-#define CORE_BUF_38           0x38
-#define IOCSR_IPI_SEND        0x40
-#define IOCSR_MAIL_SEND       0x48
-#define IOCSR_ANY_SEND        0x158
-
-#define MAIL_SEND_ADDR        (SMP_IPI_MAILBOX + IOCSR_MAIL_SEND)
-#define MAIL_SEND_OFFSET      0
-#define ANY_SEND_OFFSET       (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
-
 #define IPI_MBX_NUM           4
 
 #define TYPE_LOONGSON_IPI "loongson_ipi"
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index 70ac69d0ba..b43b77bda6 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -23,4 +23,23 @@ struct LoongsonIPICommonClass {
     SysBusDeviceClass parent_class;
 };
 
+/* Mainy used by iocsr read and write */
+#define SMP_IPI_MAILBOX         0x1000ULL
+
+#define CORE_STATUS_OFF         0x0
+#define CORE_EN_OFF             0x4
+#define CORE_SET_OFF            0x8
+#define CORE_CLEAR_OFF          0xc
+#define CORE_BUF_20             0x20
+#define CORE_BUF_28             0x28
+#define CORE_BUF_30             0x30
+#define CORE_BUF_38             0x38
+#define IOCSR_IPI_SEND          0x40
+#define IOCSR_MAIL_SEND         0x48
+#define IOCSR_ANY_SEND          0x158
+
+#define MAIL_SEND_ADDR          (SMP_IPI_MAILBOX + IOCSR_MAIL_SEND)
+#define MAIL_SEND_OFFSET        0
+#define ANY_SEND_OFFSET         (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
+
 #endif
-- 
2.45.2


