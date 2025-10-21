Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6BCCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJIE-0001hl-3K; Tue, 21 Oct 2025 16:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIB-0001XF-8E
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJI4-0001DQ-8V
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so16166425e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079744; x=1761684544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qiAzXkxkjYHknkOXo7tQh5/nC6H28Sy+HM9ZBnkuo70=;
 b=wKuhvhLSD0wkKRF6vFrnKbIwy7/7T9Qll/BXCRMjragSaqDZrfXeFLWkJ1aPXGWT4E
 MGibiGj7qjFwnIlRhSCP5r/zI7ZnmEIFij3zAZ3WQxaQrPGcZa7NzhmBc+Y6J+YlhXjP
 sRPZVl65/ze5fOPn6u/xH2Hwa/BvtLjNlUroxBYpsjfohctHPPPP3F74ia4isdzjc6iG
 IStqJefkLAKpRUjK6L58XO5Nrlkvfh46Hwyho16/1Zm0/ron+ZJAgIy2u6Srm6rOp4rK
 9ywYsr6YBK/wLdLIoChUSG7F7i7sl2TJnt/geiDrfUnz4IwaL0/agPLPl2FdhnpRJLEO
 pj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079744; x=1761684544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qiAzXkxkjYHknkOXo7tQh5/nC6H28Sy+HM9ZBnkuo70=;
 b=UnUhw7UjLTvCAt2cb2ALcDQrFq+8l8G8YQZntqcMiHSaGAGO0cicqaar7BH7Oa3bS8
 fAO+eBGoTIGsihsTPAxjkw5Yc3JeBBrGdKEsDs6yn6taY88K0dXLLXMSSqdn/fNqnWJ0
 QDFSdwHriPTXmO/F8oK0NyRywJEjrVz3aZwp3wto774jf5Aj0ZcAtQ/a0B6pxBjHjyN5
 M2qeyJVr8Em5ArkwmmrcESwKw6xqymnR9t9jZKX4Yi6YThMXk9pM8lKe/HG4w3zjeh6c
 +9UezLBlEmYYwFDSFwj6RYJj1kzo/UJHj2srhGAx460zUlTxmZplRnhWtzLLuRh5voZ7
 M0Nw==
X-Gm-Message-State: AOJu0YwSn/J2S6/TV2m4fVsMx/2FHSO6zMIGFenc0pgtT9v6FJcRMEaL
 rKZDKeMSW1CB/o6eB/LTHI9zPMywfDJwVuizuJ2VTHmZgE3ViUFRwa41z93Hx7hDsKyz0CvTX+b
 keGmfL+0=
X-Gm-Gg: ASbGncudJ8YlzeC3n2Z/YpUE1kWZVF4QdjGCtKrQghLchinXE4Goeh6Uyc6A5jc1UwO
 r5YjjejcTLfGq7nGpFqHuU6NiKQjGfQtYr0gZSu9lsKxQlpHiVuWbB/gYHOXkXej0fRPxmE6Uyh
 AawZSPF79HE7xwHkVyf+fzUoXZhH9vCfmF61BhtCy97X6y07iD273pvHmZA2JtLZgM3glr5V1/T
 M8AyFNV6GS1bZcTJh1FraABLSiKS/WmGKQ3QuHItq8MjZ1JYYM+YsyZ9gKcVbJhl1+oPE1REiYV
 m7n7L2lvuywoqa/kaNkB2hk1HbC2wxsSVPxrk68fDBbomEUUwMWoqz+NKISN5KfNb/serZeOb/4
 S4gJa81lmbgw2wjdyKK/YTTl7ocyan5xR9AGQhj3Xe5Ct1ByS+u5yrqvM6hQPqvcumXiUn7RBWs
 rFxNdqyez/iPS75SCEwE4hLhcBynm+33ouBuy3kGH9PN1TNniLEqhLehlr/+hc
X-Google-Smtp-Source: AGHT+IHET51dflvL2EqO31hezpcfSdXVtgVgR8Ht/8cjxYQpLuuqAgbnIdkZcfXpW3UF9K+yof/6Uw==
X-Received: by 2002:a05:600c:5029:b0:45d:cfee:7058 with SMTP id
 5b1f17b1804b1-471179035dbmr137360965e9.22.1761079743920; 
 Tue, 21 Oct 2025 13:49:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427f685sm10282635e9.2.2025.10.21.13.49.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/45] hw/rtc/mc146818rtc: Convert CMOS_DPRINTF() into trace
 events
Date: Tue, 21 Oct 2025 22:46:40 +0200
Message-ID: <20251021204700.56072-27-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251019210303.104718-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rtc/mc146818rtc.c | 14 +++-----------
 hw/rtc/trace-events  |  4 ++++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index f9f5cf396f0..61e9c0bf99f 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -43,16 +43,10 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-misc.h"
 #include "qapi/visitor.h"
+#include "trace.h"
 
-//#define DEBUG_CMOS
 //#define DEBUG_COALESCED
 
-#ifdef DEBUG_CMOS
-# define CMOS_DPRINTF(format, ...)      printf(format, ## __VA_ARGS__)
-#else
-# define CMOS_DPRINTF(format, ...)      do { } while (0)
-#endif
-
 #ifdef DEBUG_COALESCED
 # define DPRINTF_C(format, ...)      printf(format, ## __VA_ARGS__)
 #else
@@ -439,8 +433,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
     if ((addr & 1) == 0) {
         s->cmos_index = data & 0x7f;
     } else {
-        CMOS_DPRINTF("cmos: write index=0x%02x val=0x%02" PRIx64 "\n",
-                     s->cmos_index, data);
+        trace_mc146818_rtc_ioport_write(s->cmos_index, data);
         switch(s->cmos_index) {
         case RTC_SECONDS_ALARM:
         case RTC_MINUTES_ALARM:
@@ -726,8 +719,7 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
             ret = s->cmos_data[s->cmos_index];
             break;
         }
-        CMOS_DPRINTF("cmos: read index=0x%02x val=0x%02x\n",
-                     s->cmos_index, ret);
+        trace_mc146818_rtc_ioport_read(s->cmos_index, ret);
         return ret;
     }
 }
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index b9f2852d35f..d2f36217cb8 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -32,6 +32,10 @@ m48txx_nvram_io_write(uint64_t addr, uint64_t value) "io write addr:0x%04" PRIx6
 m48txx_nvram_mem_read(uint32_t addr, uint32_t value) "mem read addr:0x%04x value:0x%02x"
 m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x%04x value:0x%02x"
 
+# mc146818rtc.c
+mc146818_rtc_ioport_read(uint8_t addr, uint8_t value) "[0x%02" PRIx8 "] -> 0x%02" PRIx8
+mc146818_rtc_ioport_write(uint8_t addr, uint8_t value) "[0x%02" PRIx8 "] <- 0x%02" PRIx8
+
 # goldfish_rtc.c
 goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
-- 
2.51.0


