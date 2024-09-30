Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8CFCF649E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 07:48:36 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svB5i-0006no-VS; Mon, 30 Sep 2024 03:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svB58-0006ha-DP
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:44:52 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svB4D-0000X2-Au
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:44:20 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c87c7d6ad4so3757393a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 00:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727682143; x=1728286943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J3QK0sGMtG8TI1HL5/V5FwLZQoUZnlZNYr8FgmUN/RY=;
 b=gmg7saSjmuJPt+O7T36M1yCxWkLpwIUlEGmprRhXN8JUGQa2oj1NQO5ZQYYktuMCLz
 /CAKbT/Qd+b/tUm3G6+gmTearftvZXk46Q6A4lPrOUoLZIyFue78acxJe524U1Rt4eCV
 6kP91RJUbYIiAOOuIIzbKgnzu5uTSSAMCG7Csev8T1/L2UGXE1yHOZLOLM1ba9LYuMC2
 SJoec0iUCzl3tLaHLm/u60JdNY+szQwQm5zMVjKoslYheK0vMRJs5SxurxjRFjvMScTG
 XqQVHVON6CDj2UIM/EBomP1eBlDB4QRJEnLkkM7fL5ocgbY7hh8cgyqvM6zUunvAnE8o
 VKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727682143; x=1728286943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J3QK0sGMtG8TI1HL5/V5FwLZQoUZnlZNYr8FgmUN/RY=;
 b=AmM8QIJW3cPAA200KWmB/rzwnPedoVmo0ziXWwlmKciZiTUp9CpFwsD8Uk27v+K4EQ
 JUUFKBzZhiPQNiEJb+8mXAExHCHGOMTcpgtVtTGxZlj0XJBKWlSTG6noaLrfgRyqutHz
 TvjaQ4WkBOCOL4Ll4J5ET3N/Zj2EQOqlSf58ldVG7VoUeOY67vNhvUMmbQF5nEakCbjI
 QpLEMIqGhJ13qVpQhyVPOnM4/YzvRneYoftfMCYKp8zA0osdycuOMC9Xq/evlrP5Zay/
 6QJdd3Z8TrknSdGOgKyxNlUc7bBE9pQupMt7fVBM8oDfk+1ZnwKlPwPriOqEgjKlVVzC
 K5bw==
X-Gm-Message-State: AOJu0YxjlyabFC6CrJv6mzmQ1ddGXrYjVTgFdBEY+ciSNIGgyN8quR4J
 Bispflsh6SmNoUpd1P7Ys1kPcXXuPoI/jlXhZdPTNDa5F25BhtsHMS/l3Z3PLorjqCXV7E/ZCYY
 1CAs=
X-Google-Smtp-Source: AGHT+IHfyb7T2OKPtc/aN3zF39s8yY/HEtBknVQ7wiGAPxn0Lopn0hpb6weLKhFtYxrMG/LxHKBT4A==
X-Received: by 2002:a5d:630c:0:b0:37c:d1fb:82fb with SMTP id
 ffacd0b85a97d-37cd5b3172dmr5782965f8f.36.1727681794106; 
 Mon, 30 Sep 2024 00:36:34 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a54dedsm142631145e9.44.2024.09.30.00.36.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:36:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 12/13] hw/pci/pci_device: Introduce ld/st_endian_pci_dma() API
Date: Mon, 30 Sep 2024 09:34:49 +0200
Message-ID: <20240930073450.33195-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930073450.33195-1-philmd@linaro.org>
References: <20240930073450.33195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Introduce the ld/st_endian_pci_dma() API, which takes an extra
boolean argument to dispatch to ld/st_{be,le}_pci_dma() methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
TODO: Update docstring regexp
---
 include/hw/pci/pci_device.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index ff619241a4..dc9b17dded 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -300,7 +300,29 @@ static inline MemTxResult pci_dma_write(PCIDevice *dev, dma_addr_t addr,
 
 #define PCI_DMA_DEFINE_LDST_END(_l, _s, _bits) \
     PCI_DMA_DEFINE_LDST(_l##_le, _s##_le, _bits) \
-    PCI_DMA_DEFINE_LDST(_l##_be, _s##_be, _bits)
+    PCI_DMA_DEFINE_LDST(_l##_be, _s##_be, _bits) \
+    static inline MemTxResult ld##_l##_endian_pci_dma(bool is_big_endian, \
+                                                      PCIDevice *dev, \
+                                                      dma_addr_t addr, \
+                                                      uint##_bits##_t *val, \
+                                                      MemTxAttrs attrs) \
+    { \
+        AddressSpace *pci_as = pci_get_address_space(dev); \
+        return is_big_endian \
+               ? ld##_l##_be_dma(pci_as, addr, val, attrs) \
+               : ld##_l##_le_dma(pci_as, addr, val, attrs); \
+    } \
+    static inline MemTxResult st##_s##_endian_pci_dma(bool is_big_endian, \
+                                                      PCIDevice *dev, \
+                                                      dma_addr_t addr, \
+                                                      uint##_bits##_t val, \
+                                                      MemTxAttrs attrs) \
+    { \
+        AddressSpace *pci_as = pci_get_address_space(dev); \
+        return is_big_endian \
+               ? st##_s##_be_dma(pci_as, addr, val, attrs) \
+               : st##_s##_le_dma(pci_as, addr, val, attrs); \
+    }
 
 PCI_DMA_DEFINE_LDST(ub, b, 8);
 PCI_DMA_DEFINE_LDST_END(uw, w, 16)
-- 
2.45.2


