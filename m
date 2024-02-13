Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FADC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnua-0000vE-N8; Tue, 13 Feb 2024 03:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnuZ-0000uC-Bv
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:13:03 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnuO-0000uS-8o
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:13:03 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33b2960ff60so2867270f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 00:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707811969; x=1708416769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tGBnm3xpKoZJLGDzyHurshmc29aTqyoeNI6UD7GZU8=;
 b=CsjDaSAp9E5pazR+KBsXLlYoc29uzU8c4HU3hkmoRh79x1Nebb1mzWD/BHrWGYfy3D
 Xd+uwTbsZLQdtQ9BUYs/ev3AEOy2ObRcgwj+XrdDux+kvTd7ff4hyoKeyjM+YZh4oxzH
 D0yIAEcgh/8UxQKJDlSv0SiOqm0M+nTdunKduXHR1wGBfgB5Lpyr1L5jUeZdeM8BuShw
 +m1ftiCPvnXmWSWFUDOtFmQH8Yy46vzTJGbuqTebx01t3C+z54gvI/BzcBDH5aG7CUXO
 AzSJISdR032F18nAIP+LGOhti6gll9TT4u763dCQe4IrsWVzUwKj1sDHseC45tnu0NcT
 R/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707811969; x=1708416769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tGBnm3xpKoZJLGDzyHurshmc29aTqyoeNI6UD7GZU8=;
 b=SYDoJ/G3z7YiNXGGXQu5mRPjI1tOhsCKdgyHJYm3q+N/wPtXwYc0xxgsnkGLYNIQl1
 CKWsBjYXKZNVfOQlBB5ixwTRqsz3fWLjX/sSn4DvfFc597/vdbJueVYQGHRbd3tjotrF
 vcUbM/1F6+JLae32UU/98AiyQGPYoLKPCJioYtxhUYEqkHZK1uc+QkB00pW1X43SJsNS
 xIdGXt6pHqlmB8umA1dSiOdbnZ+nAf1xLehyLgeG3oW2Ogba0y8o7Avh2MxP/ifAwnZR
 m6MyLZ06BX7nafiDjbxbqc95LhVnT2EXRVpbA7u1E7NVHHuyBFvsEhn0cl6NMyw6lIbL
 Wlsg==
X-Gm-Message-State: AOJu0YzpE7008L4TAmb3ioACrBfp972FwO/JyPMkbGzekp2Zex43jKc6
 klPpZHqH/B9buZTKyHPrbB/Gko6Xkwp3Z+OTbl1ExhHbriBUYvxYFBdbUdRq20em4hcdbQ/XOUK
 e
X-Google-Smtp-Source: AGHT+IHAbjPO3QHRPjiBBcWKK0nCDzc8pkdF8GY8qtKFJR6HBvbG6Vuk5M8pHYFlo4jxz6obYbnDAQ==
X-Received: by 2002:a5d:4e4a:0:b0:33b:68d2:c5c9 with SMTP id
 r10-20020a5d4e4a000000b0033b68d2c5c9mr1442385wrt.8.1707811969753; 
 Tue, 13 Feb 2024 00:12:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUhv7HcJZUaxKepPaqXlfGBs6Jto0eV0QW/c86+/oleUEDjymNxErcchK8KDSHA0b91m/xVsnaFINko6RqeG82c2ixyk9H9WDfvlw9MHB01+N2/h+AyFjRuTYba8pw8FP4vAY8V/r+RPmr0BasoDggJD7gR9yEIEEiGeJSJ/rOiui/dSh/goC7y/E/YvJRlzBzLPhEVfZQeKgj0HS9FaToXQy4rAu7TgSIJ8CONb1oi0yTIMgN/ZGYlk5Z+0Mllmhrt/bOPc9/NU95UDvn+mq+JeSdm5f0=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 t24-20020adfa2d8000000b0033b86b38611sm3549752wra.10.2024.02.13.00.12.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 00:12:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/9] hw/ide/ahci: Do not pass 'ports' argument to
 ahci_realize()
Date: Tue, 13 Feb 2024 09:11:58 +0100
Message-ID: <20240213081201.78951-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213081201.78951-1-philmd@linaro.org>
References: <20240213081201.78951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Explicitly set AHCIState::ports before calling ahci_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ahci_internal.h | 2 +-
 hw/ide/ahci.c          | 9 +++++----
 hw/ide/ich.c           | 3 ++-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 4dc2805d21..4e13329bb2 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -377,7 +377,7 @@ typedef struct SDBFIS {
     uint32_t payload;
 } QEMU_PACKED SDBFIS;
 
-void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int ports);
+void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as);
 void ahci_init(AHCIState *s, DeviceState *qdev);
 void ahci_uninit(AHCIState *s);
 
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 2c3306dae4..33f7e83687 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1614,14 +1614,14 @@ void ahci_init(AHCIState *s, DeviceState *qdev)
                           "ahci-idp", 32);
 }
 
-void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int ports)
+void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as)
 {
     qemu_irq *irqs;
     int i;
 
     s->as = as;
-    s->ports = ports;
-    s->dev = g_new0(AHCIDevice, ports);
+    assert(s->ports > 0);
+    s->dev = g_new0(AHCIDevice, s->ports);
     ahci_reg_init(s);
     irqs = qemu_allocate_irqs(ahci_irq_set, s, s->ports);
     for (i = 0; i < s->ports; i++) {
@@ -1862,7 +1862,8 @@ static void sysbus_ahci_realize(DeviceState *dev, Error **errp)
 {
     SysbusAHCIState *s = SYSBUS_AHCI(dev);
 
-    ahci_realize(&s->ahci, dev, &address_space_memory, s->num_ports);
+    s->ahci.ports = s->num_ports;
+    ahci_realize(&s->ahci, dev, &address_space_memory);
 }
 
 static Property sysbus_ahci_properties[] = {
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index d190012a95..122fc7e0ab 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -113,7 +113,8 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     d = ICH9_AHCI(dev);
     int ret;
 
-    ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev), 6);
+    d->ahci.ports = 6;
+    ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev));
 
     pci_config_set_prog_interface(dev->config, AHCI_PROGMODE_MAJOR_REV_1);
 
-- 
2.41.0


