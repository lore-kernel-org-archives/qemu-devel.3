Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A767C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5dA-0008Tq-BM; Fri, 28 Jun 2024 03:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5d9-0008Th-MO
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:47 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5d6-0006eI-Ro
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:47 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ec50d4e47bso2313581fa.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558160; x=1720162960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C+gseryQhO5/sKrfElbobPrg2sCJZha7vmxA4CmxEms=;
 b=mprTAIf5AvZXiCUS4sCmLIp78IfjXn3/0OUo+Zq/CXgQVSTMF2Kez/CtkNojkdMyXi
 3Ff8+XpPWif2Lh7w1ygJUXgkbXhWrUgB/4ibR5DYb1QTvk/qeqK3HIv/UT+fdvnLYRIA
 56Vfw/7LHUJZ5FNT0ymxuL8gks9mfTH7bi+z2uCVcMpY4O7vjU5gXh2wrk8AT+qHJMPG
 LKu6Orf3wZpRHfpMUm+5jNl2Bxl2k/zbYfEnW47OAJ9QN+M7TSAPPJNB+aOqAt+GZOEI
 qcaq7uezGHHCxYh3Mz5HU6bR3fCnn0yOzXWTez5obvxpTGnGw9RCTvpwSsv2PT0K77Eq
 71IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558160; x=1720162960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+gseryQhO5/sKrfElbobPrg2sCJZha7vmxA4CmxEms=;
 b=nKY8j0zyju65iHKrK1TBGXyrkKIhFHWFceL6cfOAdl/iH5f8V7xQGubyEct2p3ZEFJ
 Fct3EZlDRU+2Yguqxbn+loTQ5ls1x/O3GK3R0DH1iAZnEIMZEmMaB+JQiMXlA9UMzr3K
 1OdId2b7W58BB2K4XCGiaGphhsgZovgT+jFbjgrR8tAgZgR/p+aFHO/xxNZ7cSsU8L25
 urasZoR5V13cFAyyIQX1TfkuDNVABlQtaKUe3tieUxxUikgR+TWxeQsaMLCE+UM0tAA6
 2Qi7Z458QIV3ctYqJgDzsPbgvMDuLc4cAEtVniSb7ygIzgb8vEU/YvA+gDrocYwXBy8K
 8dDA==
X-Gm-Message-State: AOJu0YzrA66anlXrW5XdLYRaVoKV5PZdA+tRS0OH8Zba+KliUW7Sxae6
 FWtRg+S0Xs1b9T1WER52GnV58ZDf+ZlKRqFvj+ov3ES8V+wbpc5dOb7e5ncAY76FBftjLKOa+zB
 RyOQ=
X-Google-Smtp-Source: AGHT+IHTh+JurOqT5w5B7XxzkWNxt53ukhqjoDa471RTZkrukFgbxbBzM6t2MNwqICATVArLsEVsOQ==
X-Received: by 2002:a2e:7c0a:0:b0:2ed:136b:755b with SMTP id
 38308e7fff4ca-2ed136b79d4mr44953791fa.53.1719558160027; 
 Fri, 28 Jun 2024 00:02:40 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0676a3sm21176865e9.28.2024.06.28.00.02.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:02:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 04/98] hw/sd/sdcard: Trace block offset in READ/WRITE data
 accesses
Date: Fri, 28 Jun 2024 09:00:40 +0200
Message-ID: <20240628070216.92609-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

Useful to detect out of bound accesses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c         | 4 ++--
 hw/sd/trace-events | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bc87807793..090a6fdcdb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1917,7 +1917,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
 
     trace_sdcard_write_data(sd_proto(sd)->name,
                             sd->last_cmd_name,
-                            sd->current_cmd, value);
+                            sd->current_cmd, sd->data_offset, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
         sd->data[sd->data_offset ++] = value;
@@ -2073,7 +2073,7 @@ uint8_t sd_read_byte(SDState *sd)
 
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


