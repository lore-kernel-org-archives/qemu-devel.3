Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62DBC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0ho-0004bX-7Z; Tue, 25 Jun 2024 03:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hl-0004ap-8h
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:35:05 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hj-0003lI-G8
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:35:04 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ebed33cb65so57158391fa.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719300901; x=1719905701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wK0X2J7xkzuOoEV+SXxI0L9Mdx2I1sNaqE4cl4V+Wxc=;
 b=M54iHxNN8SiAkNkVpD+eR/6SRzLjI7VrrwRmAlnkT8lvXMnJA3vEAJrOcXbOEDBSnZ
 xXo0fzjYLS8Dvcyp8HECvlUdIFhsVtw8Z9Ynf1ouwLrXkuQCN69Zxzls/dFBiNyJsXrI
 bF//SXHnZjSWBV16eYWmXD7b61PTlSXEAbmV/ZhnwfcG8yPeL6kjsKnIUwtWRlrC/PSu
 5/cF8DVqzKUremXGJsuXUZKdhyRc8SgKpTnqiu95SfYpgr4V981BiQqPemQuO/9bqrlN
 7vTz960Z9ge4jLneELiIKsZXLzMRHZRb2py3neIPOteD4A5Eu56k2Wifsq/TDQWV/kFr
 qgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719300901; x=1719905701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wK0X2J7xkzuOoEV+SXxI0L9Mdx2I1sNaqE4cl4V+Wxc=;
 b=D/veaiJVlIfdtUZRynHXt7y0XUAREuEp3uugzTCaNri5zkso+iNmUa2QR21pRwAYp7
 phArVbRYuuMthrzboJnzaHgxPeYuRG8+V6hWiJkjiMESf/OEaSXT53smWc/LIIthaD8x
 ysSvIpijoW2XobeldR8aoTuC5GonqfV46nvg/pyQraC6KQZkhiQ6d/vPe8uxHSynNeeZ
 S1AYXXBJpAqapMl0RVyqjh5rKc3efcBQ6Uh5KgXlmontEl8Gnm4MH0Nyaixz/i3e4E4y
 YVk5NrF9yYkxbDcN3ED/LqZa3K5JMU2c8/pNL0NHpJ++UezYJNA1RGgu+TW7cTLfyT97
 cHaA==
X-Gm-Message-State: AOJu0YxrC1MnOqL3FRbKzANBarIr5CNCQH1qpbf4N58xKuojPq0qiIzc
 acLmCR06McneRCrM/q+eVjUcehBssnw9RHEzkN7deEx6+4i+H+yOPFQQljlYaU4Dvgn5mjkxPH/
 E
X-Google-Smtp-Source: AGHT+IGuRSy70bJPO/kwhQjWcT141lShqWP5LKL6mWY1oHOl1qksvHIrcJojUI+iXTXNS8+NyDDyqg==
X-Received: by 2002:a2e:9859:0:b0:2eb:f0ed:a36d with SMTP id
 38308e7fff4ca-2ec5931d44cmr56284711fa.19.1719300901360; 
 Tue, 25 Jun 2024 00:35:01 -0700 (PDT)
Received: from m1x-phil.lan (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4249e48ad3dsm12591665e9.16.2024.06.25.00.35.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jun 2024 00:35:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 3/7] hw/sd/sdcard: Convert WRITE_SINGLE_BLOCK to
 generic_write_byte (CMD24)
Date: Tue, 25 Jun 2024 09:34:37 +0200
Message-ID: <20240625073441.34203-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625073441.34203-1-philmd@linaro.org>
References: <20240625073441.34203-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8c30826754..fff4be3ae2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1081,7 +1081,6 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
-__attribute__((unused))
 static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
                                              uint64_t start, size_t size)
 {
@@ -1446,10 +1445,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
                 return sd_r1;
             }
 
-            sd->state = sd_receivingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
-
             if (sd->size <= SDSC_MAX_CAPACITY) {
                 if (sd_wp_addr(sd, sd->data_start)) {
                     sd->card_status |= WP_VIOLATION;
@@ -1459,7 +1454,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
                 sd->card_status |= WP_VIOLATION;
             }
             sd->blk_written = 0;
-            return sd_r1;
+            return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
 
         default:
             break;
@@ -1975,7 +1970,6 @@ send_response:
 }
 
 /* Return true when buffer consumed */
-__attribute__((unused))
 static bool sd_generic_write_byte(SDState *sd, uint8_t value)
 {
     sd->data[sd->data_offset] = value;
@@ -2021,8 +2015,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
                             sd->current_cmd, sd->data_offset, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sd->blk_len) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_blk_write(sd, sd->data_start, sd->data_offset);
-- 
2.41.0


