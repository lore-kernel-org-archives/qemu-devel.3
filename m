Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7466EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDTH-0007bI-Gg; Tue, 23 Jul 2024 07:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWDTF-0007Up-R2
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:14:17 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWDTE-0006Nh-2u
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:14:17 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so79661921fa.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721733254; x=1722338054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+6A8WFWFSiEF37fcqIfeInJAB6wU5Iop/0MxtMGn6w=;
 b=D1XZb3Z91huaE0scAKrZFRobOC7Ir41QKPLXd5JE6YS/WHA587Yvbxeii1xQGfwcgX
 0fi/UJesiW5uLvPU8FfMvDWKI3xFkLY9HZo01qBNaA4/OuJWL3p0KhA7LIoxVJMYKGPk
 h0/qOWcqBH/8+5FOmQFc8h+5dTQ4f3JHj74mT4FeKwYBvoCh9n9gninA64cTzuHYeb49
 8COqOt3XNe+TmtjorxxiWehqmEjCa8EUXhaOejg9lxmED9VJhVmnTkyJlnbdx/Vnics+
 5dU7KX1SyncOaA581zMyIvlKkt5s6OQ6nGEYbIp8UGVJEmzud0yN1dOA0ElcaFw8l5Ip
 /6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721733254; x=1722338054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+6A8WFWFSiEF37fcqIfeInJAB6wU5Iop/0MxtMGn6w=;
 b=duMj1vY7MggZVaB2KVT83BqrLdiMw6TBEAhaj7eXjd/k6yGnw/efKBqa0EZ6uHn/9O
 xi/JrJG4uFsME5c7qU6kYDpbFdYJl0u6M9facM07LBPv1fBFipAq6YNicUY0RzeqDrAJ
 Ly8zkelH6wJWSjSxbtXGPCmg9q853If6GjJ3y+AZeD8DEFlBCJjuZqFMLAB+qr3+LBiO
 fvX6tj4gKm1JFqC0/3GL9q1MIOAKOiMqKjNsUi5Co7jBeZ3YrgUHgwXs6qvQfLmxMNj6
 VSrVSs0yr0dZfaouDfeiIGsYIk8Np/hrAl61pUbkP6rSQHj+CVoqqIMbyVqOkI5ECzFe
 6qVg==
X-Gm-Message-State: AOJu0YzCTfUAqPM7C8NFffjyyVwZj3j2N/fXNVtlW/8zVO01GId/9+Nr
 hTTQV17Xmdov8U2Jep1eKrlN2p8Cn8njFMMbJtrgcUCazJiRtxvjaE/+cddFAT9fR1N33kOJnaQ
 xPBQ=
X-Google-Smtp-Source: AGHT+IE/m8ajB279XSh3YtSL3kA35ewAQvec5MtnCVuACbEvHM7HakPtmXdtcsydkwXJi4OXIzltMA==
X-Received: by 2002:a2e:91d3:0:b0:2ef:2c86:4d47 with SMTP id
 38308e7fff4ca-2ef2c864e49mr43201111fa.15.1721733253778; 
 Tue, 23 Jul 2024 04:14:13 -0700 (PDT)
Received: from localhost.localdomain (5.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.5]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69073d5sm169054185e9.25.2024.07.23.04.14.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 04:14:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Bibo Mao <maobibo@loongson.cn>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/2] hw/intc/loongson_ipi: Access memory in little endian
Date: Tue, 23 Jul 2024 13:14:04 +0200
Message-ID: <20240723111405.14208-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723111405.14208-1-philmd@linaro.org>
References: <20240723111405.14208-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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


