Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E60C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5kV-0001Fk-7Y; Fri, 28 Jun 2024 03:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kS-00014S-GG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kO-0004nK-N4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-424acf3226fso2720005e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558614; x=1720163414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l5dk8XRtaZNYeklBLa17/11yculQIx4J+IHrxLfyvgU=;
 b=ud+Yv6NEPylVbiw7RCSHgx0Kh8Nc0yFH0tz9A73yBOoj8ZjtRxqc5GAU2rvUBtu3iz
 8g0XLK6NKiHjEfbYHKsN4jmZATMzTN2A4nGIfcZtktHSkpZ3+YsHLPBFGBsHWx3WwIyw
 Ca5pGhAi5vpqHcR1ofCJQ1zum4HYs+E9CaR6w6+yxtjj3dtDDgBvsNgF9dZ7ePTaKSbd
 TVz11RAjytq6HxpgL+iJXOSRr8UU4Op2UgRFi+HTRhpsa6KWD1WucVuYuJKPtcm4Sg/l
 d5py76TtJcAdl/3Nbjb0KSQj3S7gIGnv+DgH3NZ2UQJqsIDrD32t8zF9vxruYlHDcD+L
 Oftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558614; x=1720163414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5dk8XRtaZNYeklBLa17/11yculQIx4J+IHrxLfyvgU=;
 b=vnAVZ8NwhLKC1xZTDsdiuaJs0I89+Is3RNT8ByZNFeTH9fiw0T86QSMa8OZoYQXL0S
 euzGah+x2NUJbOINT+qv5/3EVlua/CCaWu+/R7RrvEd3yciQ/QWZuUTPB0tVGksiPSW0
 j/FWh8DLGVpYq5P2Tz2gSOV8JlUwqeRfQP7mM87gQ5y4SkNEK7GpciPE+DVWQ3mDtjxp
 4ouWCpK3vmMkC8fVpZIIWw8X6JHdbDxPmVN7kuiJ0xYjRr6v3Rh3loZWFq9MbNA3tYE6
 fN+ZZOeCazCd4XLHsTOUYQlikFThifEONnn3EJKnMSoHSO0iC+9I2tWFMMwM7wRm4gVW
 oK1w==
X-Gm-Message-State: AOJu0Yzby0MRKa96Aa3KPPGipF68fNRH/doCnI2RWHWhNGHK9F/Hk8R7
 dXgSI7GOQXYUZ5pb2Uz+3eXivnjNa9dv6nJ6W4hUVORLNBeznls6Oi8XBK/M9W9Fd1hRhGWCgAP
 kTVs=
X-Google-Smtp-Source: AGHT+IEl51bAEI+XyHAWS4rUh/pgPcWWkB51cWIfh4bnXJZe7pxNqtOum/Aw7+y6wo3aVjNn8RoqLQ==
X-Received: by 2002:a5d:6c6c:0:b0:366:eb2f:4f81 with SMTP id
 ffacd0b85a97d-366eb2f4fd1mr12335290f8f.45.1719558614647; 
 Fri, 28 Jun 2024 00:10:14 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10307bsm1328372f8f.94.2024.06.28.00.10.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:10:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 81/98] hw/sd/sdcard: Cover more SDCardStates
Date: Fri, 28 Jun 2024 09:01:57 +0200
Message-ID: <20240628070216.92609-82-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

So far eMMC will only use sd_sleep_state, but
all all states specified for completeness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b0ef252001..92ac57a648 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -76,7 +76,9 @@ enum SDCardModes {
 };
 
 enum SDCardStates {
+    sd_waitirq_state        = -2, /* emmc */
     sd_inactive_state       = -1,
+
     sd_idle_state           = 0,
     sd_ready_state          = 1,
     sd_identification_state = 2,
@@ -86,6 +88,9 @@ enum SDCardStates {
     sd_receivingdata_state  = 6,
     sd_programming_state    = 7,
     sd_disconnect_state     = 8,
+    sd_bus_test_state       = 9,  /* emmc */
+    sd_sleep_state          = 10, /* emmc */
+    sd_io_state             = 15  /* sd */
 };
 
 #define SDMMC_CMD_MAX 64
@@ -205,13 +210,19 @@ static const char *sd_state_name(enum SDCardStates state)
         [sd_standby_state]          = "standby",
         [sd_transfer_state]         = "transfer",
         [sd_sendingdata_state]      = "sendingdata",
+        [sd_bus_test_state]         = "bus-test",
         [sd_receivingdata_state]    = "receivingdata",
         [sd_programming_state]      = "programming",
         [sd_disconnect_state]       = "disconnect",
+        [sd_sleep_state]            = "sleep",
+        [sd_io_state]               = "i/o"
     };
     if (state == sd_inactive_state) {
         return "inactive";
     }
+    if (state == sd_waitirq_state) {
+        return "wait-irq";
+    }
     assert(state < ARRAY_SIZE(state_name));
     return state_name[state];
 }
-- 
2.41.0


