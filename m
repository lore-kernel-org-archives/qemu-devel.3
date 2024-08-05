Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D17C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb27e-0003GQ-3B; Mon, 05 Aug 2024 14:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27c-00037r-OT
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb27a-0006Sp-TH
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4280bbdad3dso73350655e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881269; x=1723486069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9ejfrRNicFtIaOENDLOGRJ84CHVlCyZuuz175O5yxE=;
 b=FOOgRTiqtxXRGpRrNyYDJR3bj/Jeq3V3VAbZL/wfWdmpilIz3k2IDHfsgTjyttCzvg
 ltSLXNZEjn2rlUYRG4Xrg79HjeDEjKnIZ/c10aJ5SwGFiBQ8WSadjiXyG2kZYukSxFig
 SBNgjbzJoClXQ5O+OaJdhX8sCRP5YO2LW/u85u5/eEzToOGQll4Yj1s/2WqQVTXSAvve
 TIdCR0Kfak5pa1kEkLVUitrYOhRh+2blRj2dn3/ZLizxvXrq+d9ql08gDy+hZLQ8TiUY
 4b6Zoi/EdILsmWv+UFx6FwcdQCCUu+2hv9sfZrYlLBL/vfg87deWKW5RyV0JDHp3N9rX
 gPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881269; x=1723486069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9ejfrRNicFtIaOENDLOGRJ84CHVlCyZuuz175O5yxE=;
 b=rSl7Ok9cVSStM3iahOUgHPEi63frtXLZt11gYFWZ5mJ+5CIKWTcwFAIwnkrFnNluCb
 Wg5Hp4QOAUV5C2xYwUp64yjrYI6mkTJzB56O7igoLKDVqj7n05DMXIPE3yLepGkcNEZi
 KE7/bO83lrW4SNECC4M1dPPGxjJ6IY4wz7JIKASA5uCAvOYuanEFygn6/zH8tSU1NxOu
 5eivMQ4mF+WonrXKhARRmSOoHrB5LXyEdwOZi44WaiR9vfVgYMUX0Hw/v0RBEEFzJHi5
 51bZa900wIGiRoQOmsJAyPD9dnsaUZwT3wsa7PjcxkQ4qUqaxQr+4ZPttK7mWVBMxh89
 2xOA==
X-Gm-Message-State: AOJu0YyaeuJt/kObqbNa2V/yspjNYRgj1obPqeGsjtEgG5AG6yd3Yt8T
 LjvJzRWBaJoYR+yq0A5R/8qEf+fZW96hXPtl0qrcU9WD4xrn+WzjC8nYtReVS09tsrfptUv0rpY
 q
X-Google-Smtp-Source: AGHT+IF2Y5gLikM9y4pQHYkSVTLc8RFJQyTL/wuxeynS2s4VdoELvWHRv/zQVKwoXIzhIowaq8aN2g==
X-Received: by 2002:a05:600c:3544:b0:421:7aa1:435 with SMTP id
 5b1f17b1804b1-428e6b81cbamr73972275e9.25.1722881268980; 
 Mon, 05 Aug 2024 11:07:48 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb63f16sm208353415e9.33.2024.08.05.11.07.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:07:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 13/15] hw/loongarch/virt: Replace Loongson IPI with
 LoongArch IPI
Date: Mon,  5 Aug 2024 20:06:20 +0200
Message-ID: <20240805180622.21001-14-philmd@linaro.org>
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

Loongarch IPI inherits from class LoongsonIPICommonClass, and it
only contains Loongarch 3A5000 virt machine specific interfaces,
rather than mix different machine implementations together.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Rebased]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-17-philmd@linaro.org>
---
 include/hw/loongarch/virt.h | 1 -
 hw/loongarch/virt.c         | 4 ++--
 hw/loongarch/Kconfig        | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 603c1cebdb..c373e48f27 100644
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
2.45.2


