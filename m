Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3654C3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCUn-00070Z-Gh; Wed, 17 Jul 2024 17:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCUk-0006zG-NN
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:47:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCUh-0001rp-Ue
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:47:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266fcb311cso986325e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252840; x=1721857640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rg0Rdjc81kCpKex+A4T6UVMbXK9hzcQBh67E0bOsYps=;
 b=P/SS0xeA89+Q2inGxgOoMES6/6knG7hD3lD1NjyrqpVtcH6GhRUGSjIxnl0V7DVVge
 ssbMEVnV6JAj0WdnCoApsNSIYYNjuwKVgy75Sv7TnTGqmC/plWo7cEdFUW3FYKHqC6zv
 IQm9QpixIQRQyGlhkZd13hJDRgdF6ArCD3QvplJIX4lr8yFFyrIK4dJNln/ECbiSwNUy
 XehY4fwZfNSiCGogoeHkFcp2uq6zqh2zhli1sSMCj5ck8BKFBV3PGKl8luWy+XA7CtDD
 Z5GcRUsHBXYhtYiid7jkXg4l8NJP4WGzvbP/Li6WT1p3n21fZqa/JxRqMfTC/W9t8fYK
 tUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252840; x=1721857640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rg0Rdjc81kCpKex+A4T6UVMbXK9hzcQBh67E0bOsYps=;
 b=i7vdGkupP9iALc5GPp9BVwZwlp8SsnRowjtZG7vy30rHYIaSI9K30UZnagH2GR7JiH
 GnDoBR5qXnrkgRlhHcw7QRl0Pe73hMPYyI69BXnYODfSrjn407jwnLhnSDPkeI3ht/KV
 qyObqdeXFBmKKm8EBc3rEwZHNDKE3bwS9+CZnpmkYyYqzWGLq3ZVp4ui5Sbzc6GzfDde
 MlpHAOVDKVuTUImJUk5kQJLgai0WT8Vaw3wrYhmRGCU8v3K9gMqSDwcvzTrJ5wZyW8/Z
 1fGfbvqcDIPQOXnGpYSIG4qRV8kd6GaGQW8QJcl68BNkh4OMlhTNEQkhl8xBSjZ3pw06
 MeEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuWfR15EWm4iWw2I9w9scZyJ+rncl+0C7ZT1U3Y3q/mhTRbwtmahjzk/HOLI/w5LS2wzJBtup1aIL81vOV0dtdTdNubGE=
X-Gm-Message-State: AOJu0Yxu9slCnKtUcz3XR+z3TNfe+/WIgd9NjhJfmoLuFURPbwRHq5DE
 rNbcIU2T1a2Or1z7pLN+UhZ/taGO0xFoWPtNlDVB+VVAeyhHRloV8oWJKw7SQOs=
X-Google-Smtp-Source: AGHT+IFMD1BiDk1OW8zpnTp0nB9P1w/4sdlbMPBZeRHIHa+wWWSpJmrR752STe1jdkJAPMraBGIBNQ==
X-Received: by 2002:a05:600c:524e:b0:426:6822:855 with SMTP id
 5b1f17b1804b1-427c2d42cdemr23173375e9.36.1721252840513; 
 Wed, 17 Jul 2024 14:47:20 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c78194f0sm11476165e9.47.2024.07.17.14.47.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:47:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 01/17] hw/intc/loongson_ipi: Access memory in little endian
Date: Wed, 17 Jul 2024 23:46:52 +0200
Message-ID: <20240717214708.78403-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Loongson IPI is only available in little-endian,
so use that to access the guest memory (in case
we run on a big-endian host).

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Fixes: f6783e3438 ("hw/loongarch: Add LoongArch ipi interrupt support")
[PMD: Extracted from bigger commit, added commit description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index e6a7142480..e7979dbdd8 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
+#include "exec/memory.h"
 #include "migration/vmstate.h"
 #ifdef TARGET_LOONGARCH64
 #include "target/loongarch/cpu.h"
@@ -102,7 +103,7 @@ static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
      * if the mask is 0, we need not to do anything.
      */
     if ((val >> 27) & 0xf) {
-        data = address_space_ldl(iocsr_as, addr, attrs, NULL);
+        data = address_space_ldl_le(iocsr_as, addr, attrs, NULL);
         for (i = 0; i < 4; i++) {
             /* get mask for byte writing */
             if (val & (0x1 << (27 + i))) {
@@ -113,7 +114,7 @@ static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
 
     data &= mask;
     data |= (val >> 32) & ~mask;
-    address_space_stl(iocsr_as, addr, data, attrs, NULL);
+    address_space_stl_le(iocsr_as, addr, data, attrs, NULL);
 
     return MEMTX_OK;
 }
-- 
2.41.0


