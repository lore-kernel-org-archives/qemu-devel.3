Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1653D10F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 02:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCrLe-0003dx-4g; Sun, 17 Nov 2024 21:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1tCrLb-0003dA-SW; Sun, 17 Nov 2024 21:18:39 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1tCrLZ-0000Qo-HY; Sun, 17 Nov 2024 21:18:39 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7eae96e6624so2700957a12.2; 
 Sun, 17 Nov 2024 18:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731896314; x=1732501114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=kxbNrkKoocTwxCu5X2NC5670IQ/yPXrUivhIXTfwl7U=;
 b=fa65ZD3JvJtn0O39R2ZkPp+6izy7UuEZv7VEBIolTyifTVy3QypVLAgnB54CEKQot6
 0ygoxAa01cPysZKlGhOBMPysOpIvgASLk0zvQx9BWBifKwNM4Il2HZSRqdSQT5LYWAxG
 arIM7dsma1xTC3HCliVSTf3kxWGP1SAcT9drkc5reloqrCtY1n04Qw/ZrXIYgMuMteV5
 o0/cMPw5orjQbhsBS6tezZ+DzgtrUx44KmYiERR/C1tF0Babj6dsM99BfkeYGoiU+kw3
 NjxJEbMeAdTmePl1NVR3mRhrmpKraDw/7p3A2VPRTCJHfwIsTqPjmPRfmMN5EhvDl/SC
 wSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731896314; x=1732501114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kxbNrkKoocTwxCu5X2NC5670IQ/yPXrUivhIXTfwl7U=;
 b=T3QH5dsAnbJH+5YsMpR0Qz40YZtVH+Ftfd+LWPhbGl5uuLGGt0ESAvNZO01X9wxOA8
 FjPMmEYtupxSDjTnYFSHbhh8kjY2eeZxPKRTnCdsS8E63pEJnw9QXfMYrNnDorNdtBuM
 fEpP+HLEzgWh6ivg53GobvL4o8FIRcCdnP9d84vep1ignqGA+C+cAGQllRIAFsq4yWkq
 ipC54INI6scHuvEDxmGtSEZTa2NOHCAbx4JUXd6MJQahI/sbA8c6CcKvMGzNaNtqylvN
 GBGwqLBIfvv6JFEMs3001hxmIvz4xxEfPCQ/zpVdRNuifx0YwUpw0IrqoGw4CANHqOqj
 nFug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu3605B5IFXj/qlu+1UVwm4fNlCxGUdMhk3j2r7v5NdA4FahZGXHObDdqAepJhu3c1akcD2s4lIQ==@nongnu.org,
 AJvYcCXNDpYpTCzK0aBfwjFDYTzJmSz0BAm5kYbFxwZnoSeYvPmn4HLtDiBEuoovIem43OjnRSs6bG3dqGxp9g==@nongnu.org
X-Gm-Message-State: AOJu0YyrGzg7ffIzoOe1tGBZBwzAUdvKpY/fnTpraskXZDveAJMHAO/G
 fUTigJshbVMg3Yx0D4VaSRf0WQ93Z5D6oHKxSZXfs8PjiyCNPxWq
X-Google-Smtp-Source: AGHT+IEPYqF4+nXfMmueTlj3O9Bh7QTrhbciS0XhD5FuMvdB05HPENlvQ17laq6+bB02aHIddpOqyQ==
X-Received: by 2002:a17:902:e843:b0:211:6b31:2f30 with SMTP id
 d9443c01a7336-211d0ed2bc3mr144109775ad.50.1731896314008; 
 Sun, 17 Nov 2024 18:18:34 -0800 (PST)
Received: from prometheus.lan ([45.124.203.18])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0ec7b91sm46637845ad.62.2024.11.17.18.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 18:18:33 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Cc: BMC-SW@aspeedtech.com,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/aspeed: Correct minimum access size for all models
Date: Mon, 18 Nov 2024 12:48:19 +1030
Message-ID: <20241118021820.4928-1-joel@jms.id.au>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Guest code was performing a byte load to the SCU MMIO region, leading to
the guest code crashing (it should be using proper accessors, but
that is not Qemu's bug). Hardware and the documentation[1] both agree that
byte loads are okay, so change all of the aspeed devices to accept a
minimum access size of 1.

[1] See the 'ARM Address Space Mapping' table in the ASPEED docs. This
is section 6.1 in the ast2400 and ast2700, and 7.1 in the ast2500 and
ast2600 datasheets.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2636
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/fsi/aspeed_apb2opb.c  | 2 +-
 hw/gpio/aspeed_gpio.c    | 4 ++--
 hw/intc/aspeed_vic.c     | 2 +-
 hw/misc/aspeed_scu.c     | 4 ++--
 hw/misc/aspeed_sdmc.c    | 2 +-
 hw/misc/aspeed_xdma.c    | 2 +-
 hw/net/ftgmac100.c       | 4 ++--
 hw/sd/aspeed_sdhci.c     | 2 +-
 hw/timer/aspeed_timer.c  | 2 +-
 hw/watchdog/wdt_aspeed.c | 2 +-
 10 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
index 0e2cc143f105..855dccf6094c 100644
--- a/hw/fsi/aspeed_apb2opb.c
+++ b/hw/fsi/aspeed_apb2opb.c
@@ -259,7 +259,7 @@ static const struct MemoryRegionOps aspeed_apb2opb_ops = {
     .read = fsi_aspeed_apb2opb_read,
     .write = fsi_aspeed_apb2opb_write,
     .valid.max_access_size = 4,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .impl.max_access_size = 4,
     .impl.min_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index a5b3f454e800..c8bb7e590696 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -1372,7 +1372,7 @@ static const MemoryRegionOps aspeed_gpio_ops = {
     .read       = aspeed_gpio_read,
     .write      = aspeed_gpio_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
 };
 
@@ -1380,7 +1380,7 @@ static const MemoryRegionOps aspeed_gpio_2700_ops = {
     .read       = aspeed_gpio_2700_read,
     .write      = aspeed_gpio_2700_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
 };
 
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 55fe51a6675f..8ee662064469 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -286,7 +286,7 @@ static const MemoryRegionOps aspeed_vic_ops = {
     .read = aspeed_vic_read,
     .write = aspeed_vic_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
 };
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 2c919349cfc0..b7a62da45907 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -436,7 +436,7 @@ static const MemoryRegionOps aspeed_ast2500_scu_ops = {
     .read = aspeed_scu_read,
     .write = aspeed_ast2500_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
 };
@@ -777,7 +777,7 @@ static const MemoryRegionOps aspeed_ast2600_scu_ops = {
     .read = aspeed_ast2600_scu_read,
     .write = aspeed_ast2600_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
 };
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 4bc9faf691d6..ba700b008e5e 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -195,7 +195,7 @@ static const MemoryRegionOps aspeed_sdmc_ops = {
     .read = aspeed_sdmc_read,
     .write = aspeed_sdmc_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
 };
 
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index 1dd32f72f453..f222c632c099 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -114,7 +114,7 @@ static const MemoryRegionOps aspeed_xdma_ops = {
     .read = aspeed_xdma_read,
     .write = aspeed_xdma_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
 };
 
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 478356ee3e10..c8f6e1138ed0 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1150,7 +1150,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
 static const MemoryRegionOps ftgmac100_ops = {
     .read = ftgmac100_read,
     .write = ftgmac100_write,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
@@ -1158,7 +1158,7 @@ static const MemoryRegionOps ftgmac100_ops = {
 static const MemoryRegionOps ftgmac100_high_ops = {
     .read = ftgmac100_high_read,
     .write = ftgmac100_high_write,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 98d5460905df..85e3f05e438f 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -123,7 +123,7 @@ static const MemoryRegionOps aspeed_sdhci_ops = {
     .read = aspeed_sdhci_read,
     .write = aspeed_sdhci_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
 };
 
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 149f7cc5a6aa..a116488aa2dd 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -460,7 +460,7 @@ static const MemoryRegionOps aspeed_timer_ops = {
     .read = aspeed_timer_read,
     .write = aspeed_timer_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
 };
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 39c3f362a833..d9fd6fc9079f 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -229,7 +229,7 @@ static const MemoryRegionOps aspeed_wdt_ops = {
     .read = aspeed_wdt_read,
     .write = aspeed_wdt_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
 };
-- 
2.45.2


