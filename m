Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255E9CF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBSE-000852-Og; Mon, 30 Sep 2024 04:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBS7-0007jd-Qy
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:08:22 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBS6-0004gM-3p
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:08:19 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539983beb19so260803e87.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727683696; x=1728288496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olm5MEqTuo7Wlc02c6b6qRoX+TEZG1pRsM1M0qwZSUk=;
 b=zqYpeUnr5WZA45prmYu8Gq1tJDrjSlC5TvyqDbwUsFFYlrq4fDUwdTtmg+1DYtILMf
 9Ql0337t9wlEqMnUALEeIKRpg4UUySrFkTIW9DiXqAG0e7N1fDdh85PaGLBCVFm4oW1/
 64yhC179Lxti3xaxkj+tKf6s8pJ9F4tRShTPuH9NKzaLAXYatEy8qtJ1WBPLF9fiStEW
 bX9E0ccFGLmJZLAHyJpqh4DM7mfedJOCwFKHviBHESiGtkdX2cA+6sbh1ZkguugJuP7Q
 tQNcbunvwrzJ2mL3CJRoePe8XoYJ5qeG25ZSYR7x39139YzksZpDmLHYnYr/dtZ5OsAW
 9uTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683696; x=1728288496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olm5MEqTuo7Wlc02c6b6qRoX+TEZG1pRsM1M0qwZSUk=;
 b=s6e5oV/mHVEbXYdZBnrjg5mvv+VStNyuvQq2AsvdD+8jhLn+4SacmB6Kqm5wNXd8mc
 3887/QRzD+zDPy07pRaaK1SczqIwRs+o12PDf8+3mdifhuEi2aZz1r1f2/6zSTQR4ggG
 F8RaVJcl7Bs4Fgy+Y69nxCN47ALj5YTM4NiIcgt9v58cWFuUMkgDZd2h7BNSW0/burvg
 cO9Vi6NqHAfHa7sboPqfPXlhkEUmtlWoZgdOcOA2VC/HdiATNOFvR97uJsZWu69nBKmQ
 n/FDBVelehWuHzqP7rvf0H7L8ie94dtZ4+gAzOdAVePBzSqfXBw/uBcBg0bin1XKO3u+
 P51A==
X-Gm-Message-State: AOJu0Yxnzes+YMx1m+SzTqHjHzXADtHInBGYuEW/x5ofjyvWp34rw6qs
 o3fsX3Q+zz9h1YCELbKqfWmuHz802/4ZA+kdDBjSECSa6Vr5nGlfhyEfFOHAgr+/mUIBubMqIsF
 CRZw=
X-Google-Smtp-Source: AGHT+IFJ/LX8GVVEsOLDWrfB7Tgyojyz4e841ap2Xfa6UE1pQYhd3FzF3SxsSMfp08WAfw2JTro3Mg==
X-Received: by 2002:a5d:690f:0:b0:37c:d4ba:1127 with SMTP id
 ffacd0b85a97d-37cd5a8791dmr6298056f8f.16.1727681786225; 
 Mon, 30 Sep 2024 00:36:26 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6665sm8343859f8f.54.2024.09.30.00.36.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:36:25 -0700 (PDT)
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
Subject: [PATCH 11/13] hw/pci/pci_device: Add PCI_DMA_DEFINE_LDST_END() macro
Date: Mon, 30 Sep 2024 09:34:48 +0200
Message-ID: <20240930073450.33195-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930073450.33195-1-philmd@linaro.org>
References: <20240930073450.33195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Define both endianness variants with a single macro.
Useful to add yet other endian specific definitions
in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci_device.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 91df40f989..ff619241a4 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -298,13 +298,14 @@ static inline MemTxResult pci_dma_write(PCIDevice *dev, dma_addr_t addr,
         return st##_s##_dma(pci_get_address_space(dev), addr, val, attrs); \
     }
 
+#define PCI_DMA_DEFINE_LDST_END(_l, _s, _bits) \
+    PCI_DMA_DEFINE_LDST(_l##_le, _s##_le, _bits) \
+    PCI_DMA_DEFINE_LDST(_l##_be, _s##_be, _bits)
+
 PCI_DMA_DEFINE_LDST(ub, b, 8);
-PCI_DMA_DEFINE_LDST(uw_le, w_le, 16)
-PCI_DMA_DEFINE_LDST(l_le, l_le, 32);
-PCI_DMA_DEFINE_LDST(q_le, q_le, 64);
-PCI_DMA_DEFINE_LDST(uw_be, w_be, 16)
-PCI_DMA_DEFINE_LDST(l_be, l_be, 32);
-PCI_DMA_DEFINE_LDST(q_be, q_be, 64);
+PCI_DMA_DEFINE_LDST_END(uw, w, 16)
+PCI_DMA_DEFINE_LDST_END(l,  l, 32)
+PCI_DMA_DEFINE_LDST_END(q,  q, 64)
 
 #undef PCI_DMA_DEFINE_LDST
 
-- 
2.45.2


