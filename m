Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A645C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURGi-0005cv-Kn; Thu, 18 Jul 2024 09:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGh-0005W4-1B
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:59 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGe-0008Sv-Tw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:58 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2eecb63de15so10877271fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309635; x=1721914435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLONTvRjf34a+Vyw93TpcK5Od4YkptKH5NfsXVNFERI=;
 b=BMAQOIB/VbuWg0ktnT/anuPnQzGMz125WTUGSX0dtFrXd7uTWEtzG8QJhqgTcCR774
 OoS5kBwFbdoW4/Plf4EJU6kyJRtGi0/E/BsmAZ68N+DaYHMAs9WBDINBlKnSkSSqwqq4
 K/Fz1Um/lzWk/VY1quB6jAHgUuKLypSigNxfAzbyi/gFVdSoNYb0iycxWS+1FKU5rNgm
 /Y7cQeRBqM9oH292dnbYSTsqRdVTzxYr68hBb7FO2t4y97UJYFGpcymvhYtTacqtT6QK
 h7F/yw9SQbmn8/QXiOn4sA6PFK4pYzAJhNcpxk9jGWcgGCO1rL7PqJ16Y5dB87dYTBHI
 mRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309635; x=1721914435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLONTvRjf34a+Vyw93TpcK5Od4YkptKH5NfsXVNFERI=;
 b=Z4I3DACPXlUmObVm8crGTQqOI52Bs32L8HnWTveQlGq9gFEpWSBQSu+r2kCCA14XUf
 DKdEukit/fUPwafjgNC1/XoJbeSrA99Y7gtsfrfKXW/PPYMCpx9uX04MEbOSkTVCmxrs
 82Fhp0rtLOAld1pHBvS8yE5EMT5qCQDffz4BuSTz1MH/0McsbgdyMxFOVMzW1c2rII0O
 YEQMZ4oa9hmLs2qYTMWGizY1nPREqU6eR0GY49q0jNzOkCE0xKl7Du6FQRHA+IifaY/k
 E2QaKJ2lkpme5yZtiDu0pFjeyiiwPKF+NuyWE4enpLtcPWNvfBVdI49Fox81t/Lu7LbV
 kUOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW1Yze52EmHnCtImoEO5LVmD5xBzx7OuK0i7iNeP/7hgRw85ESpww5B+pY+tM02qrBO3caNIvkKy+2e4PjkYr893kl9mM=
X-Gm-Message-State: AOJu0YxKUINHD70HNq8MMGlq8mRLmaL1D2B97ngll3HhU7QABSuzShG4
 SVmmGDTO1VUMGonnTa4QpGzWNhnGeRADphN263br08mw/0Wfu57lXMtGPNmjIAQ=
X-Google-Smtp-Source: AGHT+IH38+zBuiOzBvvIueq0MxhBXTDAI80PiRkk+TGy1jaldcfMvUqfxoSvSPJcirfGlrRf8Ouqjw==
X-Received: by 2002:a2e:90d5:0:b0:2ec:1cf1:b74c with SMTP id
 38308e7fff4ca-2ef05d32f7bmr16817141fa.32.1721309635203; 
 Thu, 18 Jul 2024 06:33:55 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccacdsm14337586f8f.62.2024.07.18.06.33.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:33:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 07/19] hw/intc/loongson_ipi: Move common definitions to
 loongson_ipi_common.h
Date: Thu, 18 Jul 2024 15:32:59 +0200
Message-ID: <20240718133312.10324-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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
---
 include/hw/intc/loongson_ipi.h        | 18 ------------------
 include/hw/intc/loongson_ipi_common.h | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 82cb64ca40..d53bd5dcfe 100644
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
2.41.0


