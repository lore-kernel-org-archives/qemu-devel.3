Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04ACC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMI5-0003ke-6o; Tue, 23 Jul 2024 16:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMI3-0003hh-CT
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:19 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMI1-0003va-OF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so43216515e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767156; x=1722371956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrr8U9MJkVqXeBeQIRhzeP4hlOkJzQZ2EPAVbiwALWY=;
 b=uu+kCSWUxkbHbQCPsXA1lfKP0oaO/kWX5NBaK4t5h3qxK5XqYbV0KvXi2SoR5wAlG0
 tU6iTKRZeNC4HdTLCkds88CF9Aev6OxN6Qu5zRCMEJ33K9hliY8PkaJLfPMk1iSMwOz/
 5GotqIT3JcU2ENIs4HhlIPLgEZlUMol8LwwgUlRkkVQCoH+FNbf15Ri4vL1smJE7SDsM
 wWTy7wCc8XymaqGNHs5dqh2xRSLpnTF+jpF/P5zW4nWWWLvc5ZzPeej6vK0w/Pml+BfP
 lrBpYURkZV2QC6wvlkGsS7U4xW2KAFDEWTqU/zkhe6+OpCaRlf+g2FcDi/sce59Su/4B
 tRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767156; x=1722371956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rrr8U9MJkVqXeBeQIRhzeP4hlOkJzQZ2EPAVbiwALWY=;
 b=fElR0E9HbxKL9ViheK5aS/NCs+yvs6S9WkNGYLYKhWxDVYqqFJNWc9bsJiu5DwjEwr
 roiNMmMVTFR2hZ1Ls0h399NQmsJIwwbqRDOO/TPY8Rc4gRG4GFWFUmoXeBrC3BifrlL1
 WXYzzbEfkz6a+qC0QeTOJVeLd3tCtYGRaI823wB8ap40L3KNL3OqMQ5i1z5ix2Q+i042
 zvBNBuZogDsdW0jaoSbk5dBb0lY44r0qQIbKrlFfBd5K8hflOD3Y/9EhPJ9vCNTar12k
 b1eU0aOL8MkSAKbEvqAaNPDEMwLaI5rDONYVvw0U76tTNBbHqbtE9O7oU/zryX4w2+Fy
 PvRQ==
X-Gm-Message-State: AOJu0YxN8dGKSxVI/WRZOg+zi1sTynADwd3HRXqjCEnlCMAdqb6MMeIf
 SP2ntgCfBpOSZsCJBZv8VMC2K/2rEUUBLhswFNI5ukTTBw97cNYXTB9+jYiuJIYglAFNZOzdsAQ
 r7k0=
X-Google-Smtp-Source: AGHT+IF38NEHrloe4WJCVqJkOGfytDDebvQOmzI0hSvr9MRxWG5qQfuMtnfYADvRMUbtZ9RkSj2V9w==
X-Received: by 2002:a05:600c:a42:b0:426:54c9:dfe5 with SMTP id
 5b1f17b1804b1-427eab7c129mr43548945e9.10.1721767155936; 
 Tue, 23 Jul 2024 13:39:15 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f937e274sm512615e9.14.2024.07.23.13.39.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:39:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 03/28] hw/intc/loongson_ipi: Access memory in little endian
Date: Tue, 23 Jul 2024 22:38:30 +0200
Message-ID: <20240723203855.65033-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Fixes: f6783e3438 ("hw/loongarch: Add LoongArch ipi interrupt support")
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-3-philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index e6a7142480c..e7979dbdd8b 100644
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


