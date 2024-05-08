Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EE0C25B74
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lO6-0004Eq-BQ; Wed, 08 May 2024 13:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNz-0003f8-9M
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:25 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNw-0000rb-Ll
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:22 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a59b49162aeso1043236966b.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190437; x=1715795237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfa4b/yP5j4YbPKarQui7QysCN8PurfTYNdnjK8DmcY=;
 b=bgc52l6se0MGAHFB/WaKt/fb0L+jYOQn5c7ZD4vJb130N5xAV/Xbhnlsbl/nVMu/wb
 HfBWlI2G3Mp55kAFFY80l1bDMslgNx9h41vWL8IqAghfJpQfeHuSS8BJ8PnwOlYU+mDR
 C+Zs8Sa/DFCZNKZGPO1mC346dmV4OvAUbT3KL03k6U/x6AebW3xMWROJT+SHeI6smB4U
 zIN3Xh0XJyezP1XxwhegbcChSvEgHEs/aXgRJKqcaNWocd2/3LyVAFS1Eyw5hjlf4yph
 i1eQb6FlPwLdY2xf2OavomCRfg43xLfAml64Hhstd0c60Jz+JnllYzUHR7d+n4hoWFvf
 QLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190437; x=1715795237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfa4b/yP5j4YbPKarQui7QysCN8PurfTYNdnjK8DmcY=;
 b=WsxwnxPiLFDVGqp31MAupwtIGpyiOzbqYO9Q430J6ZtZ/x6/DMOlw1JSLj3PARMqlS
 y65oFfGtpe8p6Xxbmqr/FQ+loUW3G39dl941L5yzJpYVn++FfIM826U2cvglHB7jh7Ug
 Ts84o0cN4OXe/uuEbXG4N07WQaDvYtgpTormD3m+lTEI3E2aII8qPLZSY+BBW94jCSrb
 Duw0/9qfwvHaLoIjMl586Cf8Lz9c3cujEDg57pjjqjN5lU0LkCrNr06SuFePfK67Y7W0
 3cpoSgepoS7YhlJPNSGWzUTjZpXuHAs82wS3gsvmcnR2coFVqYhfYIhAY1EfIfdMlE6y
 CsGA==
X-Gm-Message-State: AOJu0YwPbVxMEmVzMWZnud1GKjFuOKiZafPVEAcUBbFxaa2Bg1rCqJCo
 6lY5EPespNnhZJq+JCF7K3QYmwFxidOD55a7p7HxPpglo8WWEUwJ7JeTruRHtajDwXByRh28k8w
 7
X-Google-Smtp-Source: AGHT+IG/wbch7inn3YgxYi376mBfCwdGm+cxn0FK5VL+GS+Toy3wWLtJKjb8TrQWhmb6vUgB2IDEyg==
X-Received: by 2002:a50:bb05:0:b0:572:7c99:a280 with SMTP id
 4fb4d7f45d1cf-5731d9d4572mr2221467a12.15.1715190437587; 
 Wed, 08 May 2024 10:47:17 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 o5-20020aa7c7c5000000b00572c25023b1sm7792892eds.0.2024.05.08.10.47.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:47:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/26] hw/intc/loongarch_ipi: Remove pointless MAX_CPU check
Date: Wed,  8 May 2024 19:45:07 +0200
Message-ID: <20240508174510.60470-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Since cpuid will be checked by ipi_getcpu anyway, there is
no point to enforce MAX_CPU here.

This also saved us from including loongarch board header.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240508-loongson3-ipi-v1-1-1a7b67704664@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongarch_ipi.c | 19 ++-----------------
 hw/intc/trace-events    |  2 --
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index a184112b09..44b3b9c138 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/intc/loongarch_ipi.h"
 #include "hw/irq.h"
@@ -13,9 +14,8 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
-#include "hw/loongarch/virt.h"
 #include "migration/vmstate.h"
-#include "target/loongarch/internals.h"
+#include "target/loongarch/cpu.h"
 #include "trace.h"
 
 static MemTxResult loongarch_ipi_readl(void *opaque, hwaddr addr,
@@ -122,11 +122,6 @@ static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    if (cpuid >= LOONGARCH_MAX_CPUS) {
-        trace_loongarch_ipi_unsupported_cpuid("IOCSR_MAIL_SEND", cpuid);
-        return MEMTX_DECODE_ERROR;
-    }
-
     cs = ipi_getcpu(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
@@ -146,11 +141,6 @@ static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    if (cpuid >= LOONGARCH_MAX_CPUS) {
-        trace_loongarch_ipi_unsupported_cpuid("IOCSR_ANY_SEND", cpuid);
-        return MEMTX_DECODE_ERROR;
-    }
-
     cs = ipi_getcpu(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
@@ -201,11 +191,6 @@ static MemTxResult loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
         break;
     case IOCSR_IPI_SEND:
         cpuid = extract32(val, 16, 10);
-        if (cpuid >= LOONGARCH_MAX_CPUS) {
-            trace_loongarch_ipi_unsupported_cpuid("IOCSR_IPI_SEND", cpuid);
-            return MEMTX_DECODE_ERROR;
-        }
-
         /* IPI status vector */
         vector = extract8(val, 0, 5);
         cs = ipi_getcpu(cpuid);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 47340b5bc1..a979784f9b 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -294,8 +294,6 @@ sh_intc_set(int id, int enable) "setting interrupt group %d to %d"
 # loongarch_ipi.c
 loongarch_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
 loongarch_ipi_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
-loongarch_ipi_unsupported_cpuid(const char *s, uint32_t cpuid) "%s unsupported cpuid 0x%" PRIx32
-
 # loongarch_pch_pic.c
 loongarch_pch_pic_irq_handler(int irq, int level) "irq %d level %d"
 loongarch_pch_pic_low_readw(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
-- 
2.41.0


