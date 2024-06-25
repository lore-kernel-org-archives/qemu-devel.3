Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E53C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz8K-0001ek-C5; Tue, 25 Jun 2024 01:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8I-0001dx-UU
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8H-0001am-FD
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42172ed3597so29971895e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294859; x=1719899659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QasiI5Og3o+xZHl0uXbjz82y8xzUq9DKLys9TXhovwY=;
 b=B+fGnjib6o/XAH2VhPr4Lw38NqLOqdkWhpfNVqwvZLcyI/5jxfvmOyQ7mWxen7la36
 S2B/Qr09hyXOgXH5/JFY/omSaEjJNfxeju3DquYWqBwBLCHHJREtfCuW/Rkh5NQR75mK
 X4XkYA71u8PgKHg29r0f6NmFqg0W8r7iVjTUbB3ETpEFP1C0q/gHr/3IT8n5Xsyqqfa1
 iTtHHNFkX3UfNXblN7DrNRnb8BPGKDwYdOx+isiVz3k9tV18dcvyra1mgcye/oSMVxGF
 yUb52XPWwoyOx447vvcOwXjAp51TwEDRXeMgemUh3WAk0ulMYzcllnT/imJIeFoOQp16
 8TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294859; x=1719899659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QasiI5Og3o+xZHl0uXbjz82y8xzUq9DKLys9TXhovwY=;
 b=kna4C42r0RP1634s+pXovDzzRFZ0IiO2fUz6PmJItegpYppkKMsL6MluhrXYmxUOEG
 rIJh48PMDv2Y6yp6JyLUFmwZ4F2HAkUwSRdAgPUjyX2kbv8Sia0nKkz1b1PBCqRA+y4L
 0n4Lb81SqfS+B5qxASfGgArPuycfkHcwOM3kmsaqM/Njez/u5202sCWsrl/gUvxaowL2
 EEYkiA7oij2MI/b+PaaUVrt3TzdKfVlUKqvgJEb/NEf2qjPY+QlxbryW40vgBrnLVR54
 PN6lER7Qv1UZbUojKBAk2HXp8w2CGr2Q3gPNVCkr5BAGrWz0rUXNSXUlru14/6yg19A/
 G/oA==
X-Gm-Message-State: AOJu0Ywc9T2j2Rx9kb10lqn3YysaeDbSgvqgZKdXwPxg0o3YuGG9wvw9
 Kpyb3b3MNRoSybHKxPd7T1yOQtfJAiQk/pWqTgYE4VcZOI9V2gkjTyAUxLTiwKwozlEKHf5ddAg
 q
X-Google-Smtp-Source: AGHT+IGJ2iGh40wc+Wrh3XkSL/ES4e48IN3SlmKtpk24PfBEdRlEC2owMIdrI2JYmi90uGmsa0kb7g==
X-Received: by 2002:a05:600c:2e04:b0:424:86fe:ac99 with SMTP id
 5b1f17b1804b1-424895eaf2dmr72866125e9.14.1719294859638; 
 Mon, 24 Jun 2024 22:54:19 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c54c9sm199933385e9.27.2024.06.24.22.54.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:54:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 04/12] hw/sd/sdcard: Trace block offset in READ/WRITE data
 accesses
Date: Tue, 25 Jun 2024 07:53:45 +0200
Message-ID: <20240625055354.23273-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Useful to detect out of bound accesses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c         | 4 ++--
 hw/sd/trace-events | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 14bfcc5d6b..e4587a0a37 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1913,7 +1913,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
 
     trace_sdcard_write_data(sd_proto(sd)->name,
                             sd->last_cmd_name,
-                            sd->current_cmd, value);
+                            sd->current_cmd, sd->data_offset, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
         sd->data[sd->data_offset ++] = value;
@@ -2069,7 +2069,7 @@ uint8_t sd_read_byte(SDState *sd)
 
     trace_sdcard_read_data(sd_proto(sd)->name,
                            sd->last_cmd_name,
-                           sd->current_cmd, io_len);
+                           sd->current_cmd, sd->data_offset, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
         ret = sd->data[sd->data_offset ++];
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 724365efc3..0eee98a646 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -52,8 +52,8 @@ sdcard_lock(void) ""
 sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
-sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
-sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t length) "%s %20s/ CMD%02d len %" PRIu32
+sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
+sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint32_t length) "%s %20s/ CMD%02d ofs %"PRIu32" len %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # pxa2xx_mmci.c
-- 
2.41.0


