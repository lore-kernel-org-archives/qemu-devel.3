Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB54C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURHe-0003z3-I9; Thu, 18 Jul 2024 09:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHc-0003my-M5
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHb-00008C-0P
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4277a5ed48bso2815655e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309693; x=1721914493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsKSM3KuaB4chvTu0dhkMoqoWuPlYClNtw5MCTNrLns=;
 b=IT22f//mn+jv422glk3PUvcelIBcOqxnZimujSA9fNiFgZgzJ2+78ogEcdw3TZKFXw
 lGCUY4yx6zRknLLSP0o4pCriEaYesO8UjbqGsL//faaJ7H3CeF/Db6UwxTN+BLsxGgvM
 MH52DVTUN788e3qhyR6NrNzqOTpcBoCxu02Clr721sjhsIRktLjMyshmipveHXxGp7s9
 3oVeOGfhh4OtPKYQpWuTabBaFvdG+z+MMKmNc75jnksvQtj3F6T6Ci+GCGcDtKPhgRAH
 T/lMsTECanVZzaEHjpUjKe1NJklpraFbzhTehQB06BETMxWEo3RfP8DQwzOOa50mbiB6
 h7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309693; x=1721914493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsKSM3KuaB4chvTu0dhkMoqoWuPlYClNtw5MCTNrLns=;
 b=fJQbn0jhfNZs4MzyhOdHYy8xogCg4+miB69Hqj1DhckVMuj2QdZUIAUjetz5VDAOmv
 XQ/Z8NPfjxwoxc/6/8IBQfbugBnhE3UR87KK170PWG8dx2dKRZxkGvM98kGZ50DD2SHL
 vx80BZPP9giATHTilPUD+rntb4SDDoQ3Fl0BXjGsr4Tw+ZMBiT1alQhkCGTx14NKiQ+7
 MwjjIvTdn5Ml4PNuW9zsf0dVVTKAUjeeuuU2lN67zS5cYboc6f8S5Gauq+JDTsDH//dK
 hGVJQlb+BOVZF7DuHH47dM0fPZ3yZ/Y3YM63Yf1+58r6P7uBRp4SsOOVEiSBYI+rz70m
 0nAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbNfQAIaOCBp6ueUXwpwIL0T785sSfIk+NKR7tvTY/13A6frP35WE/ur7KvvcDbwd0BjI59/Ff6gI325W6CpuB2bxgVkE=
X-Gm-Message-State: AOJu0YzGGn3BVhxRc3MOREbql4fnEGxWSPeP7z0ey+WvQNHF3i5cmpAB
 c64HQauGUXySCVBR0PRymxFgkA0eTq+sAHsDG+SMLDoQYaonsWO5BtBBFhj9eOA=
X-Google-Smtp-Source: AGHT+IH2VDi4d/oEoJxK4t7sz8wpEjKeqijZ66sDVY23BLtFYOF8E/xE8qDUEdZ971/zbWiltCLZPQ==
X-Received: by 2002:a5d:64e6:0:b0:35e:6472:4390 with SMTP id
 ffacd0b85a97d-3683160d165mr4356866f8f.27.1721309693635; 
 Thu, 18 Jul 2024 06:34:53 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368584ddd6asm1540113f8f.91.2024.07.18.06.34.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:34:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 17/19] hw/intc/loongson_ipi: Restrict to MIPS
Date: Thu, 18 Jul 2024 15:33:09 +0200
Message-ID: <20240718133312.10324-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Now than LoongArch target can use the TYPE_LOONGARCH_IPI
model, restrict TYPE_LOONGSON_IPI to MIPS.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
---
 MAINTAINERS            |  2 --
 hw/intc/loongson_ipi.c | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a670c8ee67..c2d51b0158 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1250,10 +1250,8 @@ F: hw/loongarch/
 F: include/hw/loongarch/virt.h
 F: include/hw/intc/loongarch_*.h
 F: include/hw/intc/loongson_ipi_common.h
-F: include/hw/intc/loongson_ipi.h
 F: hw/intc/loongarch_*.c
 F: hw/intc/loongson_ipi_common.c
-F: hw/intc/loongson_ipi.c
 F: include/hw/pci-host/ls7a.h
 F: hw/rtc/ls7a_rtc.c
 F: gdb-xml/loongarch*.xml
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 86badb2972..051e910586 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -16,22 +16,9 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "migration/vmstate.h"
-#ifdef TARGET_LOONGARCH64
-#include "target/loongarch/cpu.h"
-#endif
-#ifdef TARGET_MIPS
 #include "target/mips/cpu.h"
-#endif
 #include "trace.h"
 
-#ifdef TARGET_LOONGARCH64
-static AddressSpace *get_iocsr_as(CPUState *cpu)
-{
-    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
-}
-#endif
-
-#ifdef TARGET_MIPS
 static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
     if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
@@ -40,7 +27,6 @@ static AddressSpace *get_iocsr_as(CPUState *cpu)
 
     return NULL;
 }
-#endif
 
 static const MemoryRegionOps loongson_ipi_core_ops = {
     .read_with_attrs = loongson_ipi_core_readl,
-- 
2.41.0


