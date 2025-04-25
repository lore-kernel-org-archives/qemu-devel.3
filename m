Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2F2C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1L-0003IG-62; Fri, 25 Apr 2025 11:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1A-0002W6-CP
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L18-00041Q-EE
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so1925999f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595064; x=1746199864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5L0VRZfPFZCVjC2nBfKXHPmUNh0r0Sy/642Ifkd7GzA=;
 b=adbHjS71pIBqBJUZN00GGbMCiY9O0W25nmUaGR7AN/+/seb6scO2WeO+HYN+CxhBI1
 L/a+nGWU2/JYa9cRX7EJtXV4ptvwyrux9yAedbMQAKHehIi/Yh5Fsi++NhRJVQrDreJd
 G2qKbPlotTFCvww+JwqGgWuIYQthUyNoJJ25WN2EbL5xzX7QY2GMk5Oanup42k38XRR/
 BRRH6wiFf6cVkPvF4mJ6LJTOD68vlKnpTDX/DhexbbZjN7gzQ3YnZZallTwC77RigeTx
 F5/yvi0CMWE2xCrjh94Tycz3R52drIyjicLWSHhlySVz7tTEBbZLvkqLY+y75w5UF6fR
 nbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595064; x=1746199864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5L0VRZfPFZCVjC2nBfKXHPmUNh0r0Sy/642Ifkd7GzA=;
 b=LyjELxenHpA6+MtGFZExLkYuzsY0fWhV8Xl/ykoYrbxIeQYEmn6GJ0RQeBl4HuklqR
 SVKJh2PFn97CuqQQes81bHh0heCUdExaqESyvV3YzzZ9NZp80AkD86JTLM4abSA8o59r
 pjqvhoYoZF9x4+pN5dRngK9k4ghmWsCiIndcnJTnvFU4BFJ+YywUiqcet6xYk56Yltud
 Z/47mMZGIwNqI/WvLdildV8j9/lvgtXPsW7rGd7WHVL1LtC/PKR0KfYrfRV0UDTvr0FV
 OJ4oJgsCWrF5qUnfKl5bbGOxrx0FA1rHfreStbJ9ZIjvjtT3BL7eOd1rlBJ4MKseK53F
 +iDA==
X-Gm-Message-State: AOJu0Yw3lVpE3bV6xVfKf0pS74Pdjq3a+yPkm2bDdoJ4WjMJ5jcZPx2F
 H4aYWoR789ogyVu91dSJWbbIWZZAXIp1TySjuoS4wnCGppGltGQ8G90euZZ9PIhFHGgRNGVQlxX
 u
X-Gm-Gg: ASbGncsX6a3eLBHStOQ75V3fty6LW1NvJ7G9+2hi37l4ubAkcw5I5d9whxwsXcEAygm
 3nLuN2rfgzDb/Tg9e5GecdxGKcTQtLMIn+tsC+OzolJpY8aqXbG2kowfjzkOA7sAoXuQsN/u98S
 96k9BXw5pd0SltXJkcKEXnJk1N8BRfaAPImm1mkRyPqkliuUJ9cEDH9+dMEdmV/LcryqjqtOyx4
 xtwt/Resreplfa74exAba2pOp3uLgiKcukFNvNUUT/Oqu6s0Lzsx7lAFa14CEm3HiH0XbmhqxjK
 jv8uYTbSJdfbuXYE1gCHqOAaWF/Q3zP+qx1Dn5sxTa7/MgpiRsdF0ZQW5S1X9680lxA9umzExRM
 mLnIBTrT69bH2xKI=
X-Google-Smtp-Source: AGHT+IGVal3MRlvy3621e5+2nfOeCAg1kfnlrmLDJZh/UrGI00WRQ2n7cFhDgDEyPJnfTeLgnNCKfg==
X-Received: by 2002:a05:6000:2505:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-3a074e147a9mr2115676f8f.2.1745595064267; 
 Fri, 25 Apr 2025 08:31:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8cc81sm2699639f8f.19.2025.04.25.08.31.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/58] hw/usb/hcd-xhci: Unmap canceled packet
Date: Fri, 25 Apr 2025 17:28:12 +0200
Message-ID: <20250425152843.69638-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

When the Stop Endpoint Command is received, packets running
asynchronously are canceled and then all packets are cleaned up. Packets
running asynchronously hold the DMA mapping so cleaning the packets leak
the mapping. Remove the mapping after canceling packets to fix the leak.

Fixes: 62c6ae04cf43 ("xhci: Initial xHCI implementation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250418-xhc-v1-1-bb32dab6a67e@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-xhci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b3785b8ba6c..292c378bfc9 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1187,6 +1187,12 @@ static void xhci_ep_free_xfer(XHCITransfer *xfer)
     g_free(xfer);
 }
 
+static void xhci_xfer_unmap(XHCITransfer *xfer)
+{
+    usb_packet_unmap(&xfer->packet, &xfer->sgl);
+    qemu_sglist_destroy(&xfer->sgl);
+}
+
 static int xhci_ep_nuke_one_xfer(XHCITransfer *t, TRBCCode report)
 {
     int killed = 0;
@@ -1198,6 +1204,7 @@ static int xhci_ep_nuke_one_xfer(XHCITransfer *t, TRBCCode report)
 
     if (t->running_async) {
         usb_cancel_packet(&t->packet);
+        xhci_xfer_unmap(t);
         t->running_async = 0;
         killed = 1;
     }
@@ -1480,12 +1487,6 @@ err:
     return -1;
 }
 
-static void xhci_xfer_unmap(XHCITransfer *xfer)
-{
-    usb_packet_unmap(&xfer->packet, &xfer->sgl);
-    qemu_sglist_destroy(&xfer->sgl);
-}
-
 static void xhci_xfer_report(XHCITransfer *xfer)
 {
     uint32_t edtla = 0;
-- 
2.47.1


