Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F83C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5dC-0008UM-4h; Fri, 28 Jun 2024 03:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dB-0008U6-D5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:49 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5d9-0006eo-Mo
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:49 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ebed33cb65so2526401fa.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558165; x=1720162965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2IVH6b/MHuau58htKVq2uNBSYst/d06FDWZAuadlm1c=;
 b=b+4D0E8YsZ35s5XIjBX0Ux4GDovRa/u7ocdwfiyqTB2NHFf/XTvcDD3efN7ink9WAl
 9hUxYzaHEZmQvUA+QAHVdJKBCBl8sCyqwr2NWucKV5IpBPsS+yoDRl+kXLl3Ul8o8fR/
 GGOu3uqutFsSYoi/5CSEPzeIveaY0VWVpqmtvpDmb4HZEhiacJlfHV6WYIDvHu8InmnY
 nLSKPVlcniqV8VmTsgUnTEqphArEwIKNJv8Vzq4UTWEDAFHCWQHP+vNFGvXK2CaMHK/1
 Cf6WYphGWKYtxnz90jdTAx86DgRq0ysuutpzqWNz1ThRonWOZbfCRX+2z/40TSHHNtgS
 f5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558165; x=1720162965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2IVH6b/MHuau58htKVq2uNBSYst/d06FDWZAuadlm1c=;
 b=q44iuEKf85uMG2EgNGjQMKHcC+uIbmwuRBMSaQeAKDmdx2SzhcbW1P1gDGb7aMwqXb
 07+t4Q2bcwoBTbwrLWcoQp6lICikZW8BT3JwjP0Vh1mekJZfEbp897CA8THpDunXGog9
 LREm+YE7oU8RFrLPEAxZDPq+sMoexBHv1ZYg7mfjCOGlneuD2k3GpIH+N8q+TjfTZuMY
 Z4bTjanCTPS5keNKhypFzZ4rJLeYB2XXD7bgx19Qu78Da0bPZwBBHNRpQ1wUdCx85CcT
 KNEBjCxCiggY4W/LcupOFQlzzw3YLUxL0CpjdIih4MHuliEdG5tKclCEFPlgFIcItxFX
 Jsig==
X-Gm-Message-State: AOJu0YxftjVD3xOboxibFASAYIR1y9w8kqNh50N36Mm94AoSTX8UoWBW
 HbQOdVIrU1a/Puj6RCIPQmwwfxyta1VrYMxY4qu7FoOGXCitorxOvsLyUBVKbsCnFVJJCNrHoAO
 1knQ=
X-Google-Smtp-Source: AGHT+IGqVLA+oLwVYMXLLBiZgT3g6pWxDTlgHpf5xpK0EInOybMDv6zdWVjwYEb+Gl3QCKN6tdtAqQ==
X-Received: by 2002:a2e:9e59:0:b0:2ec:5518:9550 with SMTP id
 38308e7fff4ca-2ec5930fdbcmr113733731fa.10.1719558165435; 
 Fri, 28 Jun 2024 00:02:45 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0642acsm21683805e9.25.2024.06.28.00.02.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:02:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 05/98] hw/sd/sdcard: Trace requested address computed by
 sd_req_get_address()
Date: Fri, 28 Jun 2024 09:00:41 +0200
Message-ID: <20240628070216.92609-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c         | 9 +++++++--
 hw/sd/trace-events | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 090a6fdcdb..464576751a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -608,10 +608,15 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
 
 static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
 {
+    uint64_t addr;
+
     if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
-        return (uint64_t) req.arg << HWBLOCK_SHIFT;
+        addr = (uint64_t) req.arg << HWBLOCK_SHIFT;
+    } else {
+        addr = req.arg;
     }
-    return req.arg;
+    trace_sdcard_req_addr(req.arg, addr);
+    return addr;
 }
 
 static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 0eee98a646..43eaeba149 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -50,6 +50,7 @@ sdcard_ejected(void) ""
 sdcard_erase(uint32_t first, uint32_t last) "addr first 0x%" PRIx32" last 0x%" PRIx32
 sdcard_lock(void) ""
 sdcard_unlock(void) ""
+sdcard_req_addr(uint32_t req_arg, uint64_t addr) "req 0x%" PRIx32 " addr 0x%" PRIx64
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
-- 
2.41.0


