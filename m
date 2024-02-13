Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8729EC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsSG-0001gN-D7; Tue, 13 Feb 2024 08:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSD-0001d1-25
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsS9-000619-07
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:03 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33ce2121d5dso106300f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829432; x=1708434232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bjV7XbcteO5mP7y6ZVwmid/dNk1Cnsnez4w9DwRe9k=;
 b=Iuo2kq4j8ukTmdnLFLBwVBlv141VbxOiud44j19wChyXANllhtKUI+T//6Sl/QusqI
 bTjeApXT4e/hEI8XqZbtEQv+XPhmREz2tAgahk7xDqQ+gi/Dbvofat2jLmBZc542dq0T
 8r6pZG5UzrAVxqTxF4al2lqLFUyuFVgit/uOm3y/NXIw687Ah7OloGGbpYD5DmYWR1NE
 s0Ay1DGA1OXkF1AMKzBKIAkRxMILStV3jzDlthvA17tQ09IMKGIbKYYKdw283NaT8mIF
 hHZtvq0e7YLhuOYyHopoRh9gKami3innso6Xs13+dA2tr5kEZTma9CGo3imif4uhVfwq
 VDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829432; x=1708434232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bjV7XbcteO5mP7y6ZVwmid/dNk1Cnsnez4w9DwRe9k=;
 b=vvWVHX+mQWn40i8YK+iZ8TeGuzMtNGwqYzo72ucvMMZcUkxAtmHEPssXUnjAbmAna8
 Jx13V5pVYUkXFz3SoIf9iR+iwQdwG5otyRGEDPFIebn2fF3RL+ZupfWpyLvYj5Kk02RC
 RZwWFbjS74gCwWSqKz7o7ALafhyvfK8I98uqcQBjal15lfoLEwDWkSlXKyxmWEBvTQPi
 I8WoeeZDAnlp0O5H3lkBuVZWtYsJs+ci0VL8xe5BjN3uiQD3CdGpbXuNjPKkqn4T2fWb
 n1JUjzkW5NUh90MES8pERK9cOPDAoovNxpRToNVWxBWOwxBjkUdIQM4CsOnSWqXTkfcq
 xrVA==
X-Gm-Message-State: AOJu0YwgezkBjWTxs2d3XpinhZI8SWYrEOpUJFK9hn+K2DbJorq+ln77
 iCi7DjgUycW65mxeYKt2kw8h4phf9GYZ/2zXkG5AGgEKcQtJ+GrvmWD/hUD1seJfm9Bgj2zvN9K
 X
X-Google-Smtp-Source: AGHT+IENFjjwB0jUAykw+dAm6O9ozFxJpF+FAPLErPWePfluJ68hUwJdSQgP3Q3GYOZX+OsWwYUHCQ==
X-Received: by 2002:adf:f245:0:b0:33b:4908:9bbc with SMTP id
 b5-20020adff245000000b0033b49089bbcmr8723938wrp.40.1707829432085; 
 Tue, 13 Feb 2024 05:03:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXY47e5RknONtOTkkWbiFJ9EVpcCyRgrxnsd/fsLwV/Q5erRYBsZJCd8wguc4lqVNGTqynRqW+lXLbQOx+2QqIckvAqRynoDN0JhflIu7HfMUzfFBLrbHyLxrYOO65ALl0JrLdl43Zv+ivVop/tPheRTaWLT8r6yK5iKrK44N+7co4oOxoXQW5lj8Ru0eMFJfzcr1DOUi5ERdiW8AUYrJo7immmzfb8pKgSsXdZ+qKZ4sk+23oyyeo/abpNGolwangEhaZ5tdAmlgh8SSMNt9dtG2yd2DP0//8+UaUnK0sqb2HNCggRlawgc2as1xW6xbogcVZSM4vRrOzrlx3ROlqa6JZbeVJaxFXNzLroRgpKzWMMwRXSrV0mQfrJXH5ToLiwUA==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 ck13-20020a5d5e8d000000b0033b684d6d5csm9745907wrb.20.2024.02.13.05.03.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:03:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v4 01/12] hw/ide/ich9: Use AHCIPCIState typedef
Date: Tue, 13 Feb 2024 14:03:30 +0100
Message-ID: <20240213130341.1793-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

QEMU coding style recommend using structure typedefs:
https://www.qemu.org/docs/master/devel/style.html#typedefs

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ide/ich.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 49f8eb8a7d..048ea7e509 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -99,14 +99,14 @@ static void pci_ich9_reset(DeviceState *dev)
 
 static void pci_ich9_ahci_init(Object *obj)
 {
-    struct AHCIPCIState *d = ICH9_AHCI(obj);
+    AHCIPCIState *d = ICH9_AHCI(obj);
 
     ahci_init(&d->ahci, DEVICE(obj));
 }
 
 static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
 {
-    struct AHCIPCIState *d;
+    AHCIPCIState *d;
     int sata_cap_offset;
     uint8_t *sata_cap;
     d = ICH9_AHCI(dev);
@@ -154,7 +154,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
 
 static void pci_ich9_uninit(PCIDevice *dev)
 {
-    struct AHCIPCIState *d;
+    AHCIPCIState *d;
     d = ICH9_AHCI(dev);
 
     msi_uninit(dev);
-- 
2.41.0


