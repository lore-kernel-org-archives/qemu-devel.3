Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2158ECF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBLf-0006Y7-2D; Mon, 30 Sep 2024 04:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBLO-0006A2-U0
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:01:33 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBLN-0003i2-AH
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:01:22 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5398e53ca28so1296609e87.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727683279; x=1728288079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgFNx5loGg07bkVRCAPUaZ+t66SDahiEcwbYBeR9pKk=;
 b=OcrhSLLdI4UVTTegTKcFLkH0S9eazbZxrXRy5HY1H1dHikwJ6dyfEssgYEmmGLroA7
 fGzoUJwWP1L+QG/mkERMnA6l+O+FU+zq8Ux4/fCq56Y5m+aazUaSVVMy8+u6kE8PKBA9
 qn6qNrsRbaIXkd8at07+uGWqzFqeS+VapKWX3vIf75kRs1YbFIwHiEz/ORi/x4dqMvDp
 okNse1YW0LJKq3PG5V6kj+sb754EeKnZcH6zZXoOk0r1kjALfq1X4lb+CZyoG1gwFfRY
 5TPx3RdXIT4HQgl1X8gPtjxXpLFt19ES7lEo/KPFi48RP7wAl9AHanx9qwa0qF1ge3vQ
 vXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683279; x=1728288079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qgFNx5loGg07bkVRCAPUaZ+t66SDahiEcwbYBeR9pKk=;
 b=fTh9ExoiIZSSy4AhEfMbtc1vNVXBf2Ek6gp3Vft4DhJDaw60RBjfG4Qpp77iAGWcUp
 UU0sRfeg0d0dBE2HoqDWlbuMC52a5obvA/jg1MtpUGYhgRO7kO/wSiTL17RGcaF3ATy7
 OSWkeZawis8aypo8P4VNjZ512evFaLQszlbU5aBNVkYEiUOJnEJxB/B+AC6bF+80cBah
 E4ZVOYmHdw2Ppqp8oVwByaBcaD2kNO7i6RrBVs2VxpUVZNDJGpTmaRYHGmzAmS9FMG/8
 oGDDvSn9HpnkDs4gDi5Q/nGxhQSLEDLgu9aB9ANp/CdaMxbBRsVJIArC9T1Aq77Kq87b
 eZbQ==
X-Gm-Message-State: AOJu0Yx+MJ4eZC6YOhPoqNLobRpCZmWeiJNrMCY96WupR+tKwcgbr/KZ
 auAOzT6fejY7TSMWFtc155HngEMzHlqzzemP9QgndJ6CZLKyfozvuvNS1c7VVxa07LZIrcV56nN
 C8ys=
X-Google-Smtp-Source: AGHT+IFvV+g71WyrICzKtY9MUw0GkbE1ssnGCcVYI5UdtoKHuB2gzrZM3sxXfntbw5eYtIk8XvapDw==
X-Received: by 2002:adf:8bd3:0:b0:37c:cd0d:3433 with SMTP id
 ffacd0b85a97d-37cd5a9e0f3mr6507614f8f.29.1727681802055; 
 Mon, 30 Sep 2024 00:36:42 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57427c6sm8356329f8f.96.2024.09.30.00.36.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:36:41 -0700 (PDT)
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
Subject: [PATCH 13/13] hw/net/tulip: Use ld/st_endian_pci_dma() API
Date: Mon, 30 Sep 2024 09:34:50 +0200
Message-ID: <20240930073450.33195-14-philmd@linaro.org>
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

Refactor to use the recently introduced ld/st_endian_pci_dma()
API. No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/tulip.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 9df3e17162..6c67958da7 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -71,36 +71,24 @@ static void tulip_desc_read(TULIPState *s, hwaddr p,
         struct tulip_descriptor *desc)
 {
     const MemTxAttrs attrs = { .memory = true };
+    bool use_big_endian = s->csr[0] & CSR0_DBO;
 
-    if (s->csr[0] & CSR0_DBO) {
-        ldl_be_pci_dma(&s->dev, p, &desc->status, attrs);
-        ldl_be_pci_dma(&s->dev, p + 4, &desc->control, attrs);
-        ldl_be_pci_dma(&s->dev, p + 8, &desc->buf_addr1, attrs);
-        ldl_be_pci_dma(&s->dev, p + 12, &desc->buf_addr2, attrs);
-    } else {
-        ldl_le_pci_dma(&s->dev, p, &desc->status, attrs);
-        ldl_le_pci_dma(&s->dev, p + 4, &desc->control, attrs);
-        ldl_le_pci_dma(&s->dev, p + 8, &desc->buf_addr1, attrs);
-        ldl_le_pci_dma(&s->dev, p + 12, &desc->buf_addr2, attrs);
-    }
+    ldl_endian_pci_dma(use_big_endian, &s->dev, p, &desc->status, attrs);
+    ldl_endian_pci_dma(use_big_endian, &s->dev, p + 4, &desc->control, attrs);
+    ldl_endian_pci_dma(use_big_endian, &s->dev, p + 8, &desc->buf_addr1, attrs);
+    ldl_endian_pci_dma(use_big_endian, &s->dev, p + 12, &desc->buf_addr2, attrs);
 }
 
 static void tulip_desc_write(TULIPState *s, hwaddr p,
         struct tulip_descriptor *desc)
 {
     const MemTxAttrs attrs = { .memory = true };
+    bool use_big_endian = s->csr[0] & CSR0_DBO;
 
-    if (s->csr[0] & CSR0_DBO) {
-        stl_be_pci_dma(&s->dev, p, desc->status, attrs);
-        stl_be_pci_dma(&s->dev, p + 4, desc->control, attrs);
-        stl_be_pci_dma(&s->dev, p + 8, desc->buf_addr1, attrs);
-        stl_be_pci_dma(&s->dev, p + 12, desc->buf_addr2, attrs);
-    } else {
-        stl_le_pci_dma(&s->dev, p, desc->status, attrs);
-        stl_le_pci_dma(&s->dev, p + 4, desc->control, attrs);
-        stl_le_pci_dma(&s->dev, p + 8, desc->buf_addr1, attrs);
-        stl_le_pci_dma(&s->dev, p + 12, desc->buf_addr2, attrs);
-    }
+    stl_endian_pci_dma(use_big_endian, &s->dev, p, desc->status, attrs);
+    stl_endian_pci_dma(use_big_endian, &s->dev, p + 4, desc->control, attrs);
+    stl_endian_pci_dma(use_big_endian, &s->dev, p + 8, desc->buf_addr1, attrs);
+    stl_endian_pci_dma(use_big_endian, &s->dev, p + 12, desc->buf_addr2, attrs);
 }
 
 static void tulip_update_int(TULIPState *s)
-- 
2.45.2


