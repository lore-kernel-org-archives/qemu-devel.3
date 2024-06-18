Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F915C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbMM-0000Vc-0w; Tue, 18 Jun 2024 12:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLu-0008UP-8v
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLs-0007m9-5C
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:33 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-362f62ae4c5so121444f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726790; x=1719331590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmfqhTI871PevJRRppe1121NzLfqeW2EbWjz+frAkMg=;
 b=Yz858Glon500OPl1/YHcd2z7AzcnoykufjMlbK5APFYukpAx0xP/GDLWwCPvI7VBur
 nhDWbElh+yaLnPdwsWHiFS1gGlBusQwZOQnmrt35D8HkMXgLT6w5ZHvNbtJMcx/3E1Dw
 79UdfwuQ2gkDWrRMAN6I0H9Rs0Ka8oLrDcgYEwp3z9n44bWwNk5DL4lYWdfqgVdYiTMZ
 IBiJtb4hwG+M+RZOorgrK3T0/mj/rJSDTvYacNDcQGcotPDHFliyeUZe6bvDMwnj3qEP
 2zLBA9dg+I66j+JMse2jBf23S6yuih2lZQW+TlQN97k6JMQxo+tWKAQGPtowIDEoX8Mo
 Kr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726790; x=1719331590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmfqhTI871PevJRRppe1121NzLfqeW2EbWjz+frAkMg=;
 b=fbWlyGD3/AnLClhByhLiDtH0eX4XzILSTxJ9OZjK8PjLHLHhxLFxoh7oJ/vF2NH/Kr
 C4vuix8/tuJhW8H3GLxw59eTaC0CQi9I26oi4Yhqy4/ecwiigNDNtrFPoGwiz2/ADOgv
 SDa34LDUKYBv6Yw0l8KSV+d4ydcxyS9Qys7QbmAHKeNrZxsbAAH2sW3n2ak30cyL+t0C
 z5geJPO+UXeUAtD5VsM3CZCQuBfd9Vop5RFnhFPmdE1pyj4HcgqR+aq2cP8UWD26XSMO
 VJ1jSkCeD8OMaTk1sTYuNbrT+HTVpQ6GBUHkDZsycf0S1RFAjZOu5xnUper24t5WVaHd
 XmWQ==
X-Gm-Message-State: AOJu0Yx8VaADi5mNqxdvDhzpzIX+Rfo2+i/8/xFl71BGOuU1h2TrvkK/
 VABks3SaiIDT+TEkj2nuHkXoa0stPv/jYitGPqJqpPdXrhJvyydB3HWCRZXUyrmyAyfKhfXoYdJ
 x
X-Google-Smtp-Source: AGHT+IGUvUMFNhyudRaUhMkk0vkYqO8vPOQnFlVduqLzonDCk+MZDB8bhTIC4HRHb/NQrPWsNbITjg==
X-Received: by 2002:a05:6000:2:b0:362:363a:9594 with SMTP id
 ffacd0b85a97d-362363a95f1mr2093169f8f.11.1718726790083; 
 Tue, 18 Jun 2024 09:06:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874e71dcsm227153835e9.44.2024.06.18.09.06.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:06:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 60/76] hw/usb: Remove unused 'host.h' header
Date: Tue, 18 Jun 2024 18:00:22 +0200
Message-ID: <20240618160039.36108-61-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since commit 99761176ee ("usb: Remove legacy -usbdevice options
(host, serial, disk and net)") hw/usb/host.h is not used, remove
it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240611102305.60735-2-philmd@linaro.org>
---
 hw/usb/host.h | 44 --------------------------------------------
 1 file changed, 44 deletions(-)
 delete mode 100644 hw/usb/host.h

diff --git a/hw/usb/host.h b/hw/usb/host.h
deleted file mode 100644
index 048ff3b482..0000000000
--- a/hw/usb/host.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Linux host USB redirector
- *
- * Copyright (c) 2005 Fabrice Bellard
- *
- * Copyright (c) 2008 Max Krasnyansky
- *      Support for host device auto connect & disconnect
- *      Major rewrite to support fully async operation
- *
- * Copyright 2008 TJ <linux@tjworld.net>
- *      Added flexible support for /dev/bus/usb /sys/bus/usb/devices in addition
- *      to the legacy /proc/bus/usb USB device discovery and handling
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#ifndef QEMU_USB_HOST_H
-#define QEMU_USB_HOST_H
-
-struct USBAutoFilter {
-    uint32_t bus_num;
-    uint32_t addr;
-    char     *port;
-    uint32_t vendor_id;
-    uint32_t product_id;
-};
-
-#endif /* QEMU_USB_HOST_H */
-- 
2.41.0


