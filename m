Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9783AC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCWJ-0006Vg-1e; Wed, 17 Jul 2024 17:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCWH-0006Kr-9W
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:49:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCWF-0002Qy-Lq
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:49:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266b1f1b21so1052915e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252942; x=1721857742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kegsiamyyo4kuzUkiCo64gpe7mAsvqKWMspUikrykEI=;
 b=gk4yao0dVSYyiNOY1yEzLfUF20PWplsbId29iHAPjprsh4dLZjzt1M2CUbxOfliIhd
 /A5+DoAh9OVdftOMd11DOrOWPpiG1aqjy8yDk4kFlRPeWUIXtXVMU6+dgTdzn6Az0Qk5
 /PanrMFpd+OP/23eE++aj4Wh4uk9zOpUo5FmAin9xG8bTZKGb9wYHc+CnxK4QAq/PukR
 udszVmjZhYvJClBMiZ3dV9YBglsf3BGGjq+9yNIcV8zvGv2xLkvYa+3TI0KVQSRZvEoK
 MXz03o+rIqQtBp1wnha7wJKc0FRLzkJCo4UL/4MFJyxWDbiUBvpwHoBO2g6qB6GmT2wF
 OhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252942; x=1721857742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kegsiamyyo4kuzUkiCo64gpe7mAsvqKWMspUikrykEI=;
 b=N3aZwfcWnfDlJdym1AhkBvOqkjvlD94lQ2UBUTjz3INKfhN59V90CLKu5VCeXFHm54
 tj42xFNYARfyhrHA05GU7qgAfRi26I8lqWhyoGWR2IBAIfXfKwo8JUMBhjG/vSit+pLD
 34skNCYcISmrXBfFJZwFcmv33Hlqnne7XcXh89jJHpNpWF+0oP4kOo9Tj34k7ZuednXO
 rudhMx3rf1Lyk5UVL5X5A8SUvPS9EPY6u3oIo51VUMlnLchwSJ8UFZyyvtl5y0SFmL8X
 jvEECNq6ICscCvvQB8jfusOuNv7Ib9DjRjyj97tt9wKl2dvGtGIyQVeeSWs6bCOdIuml
 TuQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqnQFlWEKUrD8VMVAfMefB/4iI3ERs+AYpGLc2KBjko+8mfteKAT9YgjOVdfPcD/PHumqP0ULkaGil14NdQe2L1Y+D3ig=
X-Gm-Message-State: AOJu0YyTd184rid7Fxc2zL9BwS+ctUIRREV/J2zc1t92ey9+kZFolKHk
 ahpYYc0KCG0+i/0qlUS6cS1/ScolHN9SsrNq/VvNalJseKRHnpea2lq38P9HAPU=
X-Google-Smtp-Source: AGHT+IEC8fN4kjsKomue30aGkuMAr4G04MYY6d+sCM1npaQllU3HWvTND85Lk9JcDg0O83Fs3v4dLQ==
X-Received: by 2002:a05:600c:a44:b0:426:5e0b:5823 with SMTP id
 5b1f17b1804b1-427c2d33196mr21227425e9.34.1721252942408; 
 Wed, 17 Jul 2024 14:49:02 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c77a56f3sm11697835e9.11.2024.07.17.14.49.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:49:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 15/17] hw/loongarch/virt: Replace loongson IPI with
 loongarch IPI
Date: Wed, 17 Jul 2024 23:47:06 +0200
Message-ID: <20240717214708.78403-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Loongarch IPI inherits from class LoongsonIPICommonClass, and it
only contains Loongarch 3A5000 virt machine specific interfaces,
rather than mix different machine implementations together.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Rebased]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loongarch/virt.h | 1 -
 hw/loongarch/virt.c         | 4 ++--
 hw/loongarch/Kconfig        | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 8fdfacf268..91216418c8 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -11,7 +11,6 @@
 #include "target/loongarch/cpu.h"
 #include "hw/boards.h"
 #include "qemu/queue.h"
-#include "hw/intc/loongson_ipi.h"
 #include "hw/block/flash.h"
 #include "hw/loongarch/boot.h"
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e592b1b6b7..29040422aa 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -23,7 +23,7 @@
 #include "net/net.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "hw/intc/loongson_ipi.h"
+#include "hw/intc/loongarch_ipi.h"
 #include "hw/intc/loongarch_extioi.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_pch_msi.h"
@@ -788,7 +788,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
      */
 
     /* Create IPI device */
-    ipi = qdev_new(TYPE_LOONGSON_IPI);
+    ipi = qdev_new(TYPE_LOONGARCH_IPI);
     qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 89be737726..0de713a439 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -12,7 +12,7 @@ config LOONGARCH_VIRT
     select SERIAL
     select VIRTIO_PCI
     select PLATFORM_BUS
-    select LOONGSON_IPI
+    select LOONGARCH_IPI
     select LOONGARCH_PCH_PIC
     select LOONGARCH_PCH_MSI
     select LOONGARCH_EXTIOI
-- 
2.41.0


