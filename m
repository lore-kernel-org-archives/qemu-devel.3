Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65312C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SeX-0005sO-Lp; Mon, 13 May 2024 06:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1s6SeS-0005p6-ES; Mon, 13 May 2024 06:11:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1s6SeP-0006Nn-HT; Mon, 13 May 2024 06:11:24 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59a9d66a51so947604666b.2; 
 Mon, 13 May 2024 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715595077; x=1716199877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXM+rlyySsEepbdMWPSfQWIUt/cvfwCazjiSQXOTYgA=;
 b=abgTgV/2ZXL4b709ITYeFKE9gjLK41zQ34pOgMROprDEoVwsx3DAWxElJB8k5r62om
 MaZ5397dnvfUGhc7spyCB+9A5o49IyldbFGoRi5BqUL2VDTlhtlPk4IngW/29ecvchuq
 kuHA/hAWoqkHHP8b5s0d4OwV07EwVKPsrX6hlLHZELABZgtGSp5g2qSpDBb/az1cs/gn
 srJ6a50NngLmnLteX0OkYji99I3Fyl0bnJqWvpLRXyY6usLVDGjNU4zPsfYN63c2K9C0
 rdhdEX8GLlsUyuUkLg3+NSP/dSmeW/N1wsLHfANwXnJvSWJzV+iRVcS+F5AseUIXzcgQ
 wEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715595077; x=1716199877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXM+rlyySsEepbdMWPSfQWIUt/cvfwCazjiSQXOTYgA=;
 b=HYKOM+zafer5tz8GQIKKphXOA3M5vF1pnJ2If01t34kOAnUKA1W2mgX49jQeqEKHDs
 FQd0iiWLtimExIkKxLVsQYjr0op4MI4tOnQSQoWedUz1K3yaMaaPxXEU96FWQqVesjjX
 BtsMIqb5LBgmOmupxblQ/YJuamKINGvU0v+/PWXd2vh76/zFkaTCxjUo6IxfMFKKA64B
 +VFJacQb8ruvnyyE8rDKq3XV/OgxPG8pPRjaCteqrrgdY+vWHKN+HjwsVr2lPpllu4wK
 pdogh37oC7kufDlSsq+9cEkRyzp7J2SccRdpnu6AFRb1fN59Jjn/7Tq9JBob7jjmbK2T
 7zNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTI1BSArs9rqKkLjuWHTdBtupj4RArxi0Jae70rYfJH9cwHbS1+fZFtP7P9LEahY4HKyfk/BqTP2W0RJS4XIso1prrNd0pDSp2jWu/MViOJY7nvjQ+p0Ftwg8qWQ==
X-Gm-Message-State: AOJu0YxtbtEcuOT/WjDUrVxVmxjenuttgWJgHjMaDEvUWGQwGjbvvEd4
 mEYD6o6e/E6Os0Y7Pl30jOQXy71BzyuY3SnEnAtqN36hNkW2AqVaQy28MA==
X-Google-Smtp-Source: AGHT+IEt8WtVpk63r6wGHTE4JR4MhZ5JCRDj+lR3y5Ct7HVCy8DgfS48+bJsGX2ffNP5vf7xIrcw1A==
X-Received: by 2002:a17:907:6d12:b0:a59:a532:ed5b with SMTP id
 a640c23a62f3a-a5a2d665e29mr756501466b.50.1715595077452; 
 Mon, 13 May 2024 03:11:17 -0700 (PDT)
Received: from archlinux.. (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17894d2asm574906666b.87.2024.05.13.03.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 03:11:17 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/3] hw/rtc/ds1338: Trace send and receive operations
Date: Mon, 13 May 2024 12:11:06 +0200
Message-ID: <20240513101108.5237-2-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240513101108.5237-1-shentey@gmail.com>
References: <20240513101108.5237-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/rtc/ds1338.c     | 6 ++++++
 hw/rtc/trace-events | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index e479661c39..ec1b6c40b1 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -17,6 +17,7 @@
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "sysemu/rtc.h"
+#include "trace.h"
 
 /* Size of NVRAM including both the user-accessible area and the
  * secondary register area.
@@ -126,6 +127,9 @@ static uint8_t ds1338_recv(I2CSlave *i2c)
     uint8_t res;
 
     res  = s->nvram[s->ptr];
+
+    trace_ds1338_recv(s->ptr, res);
+
     inc_regptr(s);
     return res;
 }
@@ -134,6 +138,8 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
 {
     DS1338State *s = DS1338(i2c);
 
+    trace_ds1338_send(s->ptr, data);
+
     if (s->addr_byte) {
         s->ptr = data & (NVRAM_SIZE - 1);
         s->addr_byte = false;
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index ebb311a5b0..8012afe102 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -22,6 +22,10 @@ pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
 aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 
+# ds1338.c
+ds1338_recv(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] -> 0x%02" PRIx8
+ds1338_send(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] <- 0x%02" PRIx8
+
 # m48t59.c
 m48txx_nvram_io_read(uint64_t addr, uint64_t value) "io read addr:0x%04" PRIx64 " value:0x%02" PRIx64
 m48txx_nvram_io_write(uint64_t addr, uint64_t value) "io write addr:0x%04" PRIx64 " value:0x%02" PRIx64
-- 
2.45.0


