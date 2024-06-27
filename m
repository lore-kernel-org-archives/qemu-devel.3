Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2152CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMruh-0004EB-ME; Thu, 27 Jun 2024 12:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMruR-0003xh-PL
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:23:49 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMruL-0007F1-Iq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:23:42 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ed5ac077f5so27788021fa.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505415; x=1720110215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+gseryQhO5/sKrfElbobPrg2sCJZha7vmxA4CmxEms=;
 b=j0Bwvdo8BQYmU/idHE3k2dbgTq4Hy8FkFqmslQq2RD0QaHhePwf4u4qvgfLDPSCivg
 4cR49j3/Tq7m8BNhSX+xQ0/Ta2Q69aVOmt4vkLTgl5BLtXz07UaU6e+tyZ2/T19G9TRz
 pqi7NygErEvF/NE1GDdEpFJIycxyfxh5gMaK5SSgZieC+ZEzADx3FhJrSDuCbV/ujRX0
 N/KC1F2gNnzlUAnZhbuP7NRRnG5NVY+zTQVlXZQI1ebYpW6TItnxUCBwcvXzgXkZ59sT
 rvKO3ACApIKz/SbvDnMEEre6Xi41jMBlWRUquU0WnPps9D5KNHkQXNHPkkOmedmE7kjY
 85Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505415; x=1720110215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+gseryQhO5/sKrfElbobPrg2sCJZha7vmxA4CmxEms=;
 b=xNDRcoYbDMMW5I6KIJF9qe1GwA7Pu2yngYfj6oSHs0vBVdOlVwA9jXzeAQoMpcG8E7
 gTW+fx9maJMt2qJ8/pdmWmqKfeCQ3B7qMP9FrNdCFDQGryFsfsg6aUZiifOAdj7BJLcU
 OZt7IHdWPutxVNZmTYLuFJkDjzp7+LwwJunK8AoG7ZrAurjLbAQ66z1aoHrnBCUrcpWe
 1mHC/cQzSagArNX9BtyJRCiaRcgaxZl/G1XI8OytSWCnbmVvh/X1eRG8EjXKTlSbigU/
 fq1eM3ilm4jz5RbZp6iCZVB8fZosnJmU3oBrWzLan6lj052+Tb8VdeXG/9gs4Z1WuzXB
 0TUw==
X-Gm-Message-State: AOJu0Yy74rZjAuL1lKIBYgL33Vp7YNiYTEp5F7LQ/RYR60nr3HmFpOqO
 S3l3skn9w28hfNnYjip/W02M699DBNsYenh4JngZfApEpcIAwP5NYcIL7PrgYHZMkaR/scqagoe
 a8xA=
X-Google-Smtp-Source: AGHT+IFw/4+MfMkneAczF/krX1uL4DSonAuYfln+fKmas1h9XiX0qn2jevnLbsxKN1VGZHTZZbSRVA==
X-Received: by 2002:a2e:95d4:0:b0:2ec:40ab:694d with SMTP id
 38308e7fff4ca-2ec593be836mr88767081fa.1.1719505415060; 
 Thu, 27 Jun 2024 09:23:35 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bc4e2csm35641185e9.40.2024.06.27.09.23.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:23:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 04/17] hw/sd/sdcard: Trace block offset in READ/WRITE data
 accesses
Date: Thu, 27 Jun 2024 18:22:19 +0200
Message-ID: <20240627162232.80428-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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


