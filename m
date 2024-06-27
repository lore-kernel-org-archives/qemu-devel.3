Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56351C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsev-0007LX-79; Thu, 27 Jun 2024 13:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsel-0007HQ-Gs
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:11:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsej-0001qR-9d
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:11:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-424ad289912so17956945e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508291; x=1720113091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5dk8XRtaZNYeklBLa17/11yculQIx4J+IHrxLfyvgU=;
 b=QrwAPP5d927dS7uwysiG4MPvGT4rp3ZsfRiYi0HZu1MTmnip1y8OxfGE98PTXCuyUy
 Z6JakFiV/AUbYKs0N7ycGGURdy2nZuHutrMote5GiS7J/XKvdZjBkkyzDhIvmR3oilts
 h0msTtkGPk90uL5nqxbvhzzyEDiZRnWaDWJylPQ1A8UYIMrgPGsjEbF09HccDT0medKX
 PD7WZJwy4q9qFUzchZLOk6BEdiSbD7eah3vCZPDZymF84VoiwNtuuBgY0bU+Lx9UQvue
 3r1XaeqJWpmqK0j6LnD0VeoEFSnSIHGUqvlsM+SxEcR8cds9dKBO4wrpaEw0XaTDwZnJ
 d+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508291; x=1720113091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5dk8XRtaZNYeklBLa17/11yculQIx4J+IHrxLfyvgU=;
 b=iw3EHIPwTtWsNAEe5UYL7eodL/Yfl2fdDdtw+bD6dK0QUu3Ky1eKjrz8rSUQX6qb6Q
 cncCvNE6wFCxgwX5spP3ZmsR2IQmJMFwnkSfzbGNVYrpCfiTOa1GltHpsD3KAe1F7kWl
 9zGVgGK1AlrnTc0KlhakkdocheGfp6cLiXzgpWREAta/RlQj+N3hJIt+fxspwZzEtsUH
 ioSxeeD47UHam/sJAFHQdd5/56qQFVB1e2qcl9hi45FRz/Z/vj+pBTrbxFRMEMCU4qAk
 7vbB7Jb2jRHi+B2Xo1pYKJ2YGIEAvql1qmWCvm5xJyKEKppFUsR/2rxZGVZ15lMXc4oy
 jpBg==
X-Gm-Message-State: AOJu0YxquggJuz1/5iLLX9l5GdXAE0WuCuisE6+KkR+n5TXLXeQXwyvQ
 /sUIYbAUeLF5P3KTF+zLr9M4oqeuQ/YCE5VCCVJtBT56M/4x/hX9F4hyryeDM+haWphJSivSK4H
 LPUo=
X-Google-Smtp-Source: AGHT+IHX9Yd05LKTMcVfh3Fq9AkCNaj5LApxDee9M1UmPU7Max3APVhYXUZAEISK4mrW36cMpvZCdg==
X-Received: by 2002:a05:600c:888:b0:424:a779:b5c1 with SMTP id
 5b1f17b1804b1-424a779b687mr48905595e9.20.1719508291578; 
 Thu, 27 Jun 2024 10:11:31 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0fbesm435835e9.43.2024.06.27.10.11.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:11:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 02/19] hw/sd/sdcard: Cover more SDCardStates
Date: Thu, 27 Jun 2024 19:10:42 +0200
Message-ID: <20240627171059.84349-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


