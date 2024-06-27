Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E032BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs57-0001cV-4x; Thu, 27 Jun 2024 12:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs55-0001bX-HB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs53-0004Xp-TF
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:43 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4256788e13bso4476365e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506080; x=1720110880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OC5ZZTN2g0zXo+PgkNXxQ15/x/Un0F32fTNODaUpCo=;
 b=rcf8ox58YZWChJUnHR7hZr1l7eWrvp2bxXw+qa2eBeZGkfQOGudn3z6+fv53un/lER
 o+gxM4IXreEbzLuFLMQlc+SM7fTPObaPgXAlEnJoc0wQ7zAd80+HVTMl64/+crlae/t/
 ID+uZi+dbxnn0BQ8y3oqOek6310yMZyiEz6lEUaVS4N+g3UeEhwyFlizPVjgujbG/KYs
 vEQKzrnlOijrixlsCdO1EOnjZDbwlukWbsU3OHW9MxfcMFxsMvZjwnDa44G8nau++y/B
 MZZONam8Z+QOln9UJL+5KpdrP5gx4Xf6JvcHdscCpzfPhYJ88bSLd+Xw2U0iFbsdqLay
 5p5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506080; x=1720110880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OC5ZZTN2g0zXo+PgkNXxQ15/x/Un0F32fTNODaUpCo=;
 b=lt/L5QcZ2xYXcyRTL7PM1ItPQytaUbVQExrf5z/QGkOOW2XTSo+r/EeAW04mjGPIgr
 yEFlhhgl2BnRkGd2dH+0fPHeZFDL63VSpVk3aWtbWd5HE7dOhY3xmLhn0EMblLyKosUy
 VeRbZ4GEAFgKqT/hl/w/zTT7flnNXkwSxbz5OK39Y1JxYUmP5osephX/ZnKci8KQFyHH
 5ijSCiCMjwQfl6z078nIpwqmKtdn/NBdHMtxOzK0/eyyRozLkCgDah2HJy4rnWD2b3oL
 HZe/ZmRfaKWe3BY8tFJ9w/rNd1SFMBHoUpPGROmO1G95EAz0OCmJ6VJ3XYGMFA/vzFHc
 TVFA==
X-Gm-Message-State: AOJu0YzrYXXtVWFWR3sAMkfXB8ZftOzbaWNwlKroejo5Z1oASP2zpFF9
 6Z+lNP627Rz5eU42b4VXv5iiMh9UX4ToGiComRkrropcBP1osXbkZlfi/bU2WRIgt9M6HC1g2cC
 9phA=
X-Google-Smtp-Source: AGHT+IHmWB9cBJ6kB0a4Z7vpIdBao1tKUnFDosAx5eK6F3ndMypCrF/ked2M8wQLRrLDQAtC7/LUlQ==
X-Received: by 2002:a05:600c:6b16:b0:424:a3d7:2a89 with SMTP id
 5b1f17b1804b1-424a3d72b27mr54802075e9.4.1719506080055; 
 Thu, 27 Jun 2024 09:34:40 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bb6cccsm34736665e9.35.2024.06.27.09.34.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:34:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 3/7] hw/sd/sdcard: Convert WRITE_SINGLE_BLOCK to
 generic_write_byte (CMD24)
Date: Thu, 27 Jun 2024 18:33:59 +0200
Message-ID: <20240627163403.81220-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163403.81220-1-philmd@linaro.org>
References: <20240627163403.81220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5dbfc8000b..4a03f41086 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1101,7 +1101,6 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 }
 
 /* Configure fields for following sd_generic_write_byte() calls */
-__attribute__((unused))
 static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
                                              uint64_t start, size_t size)
 {
@@ -1470,10 +1469,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
                 return sd_r1;
             }
 
-            sd->state = sd_receivingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
-
             if (sd->size <= SDSC_MAX_CAPACITY) {
                 if (sd_wp_addr(sd, sd->data_start)) {
                     sd->card_status |= WP_VIOLATION;
@@ -1483,7 +1478,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
                 sd->card_status |= WP_VIOLATION;
             }
             sd->blk_written = 0;
-            return sd_r1;
+            return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
 
         default:
             break;
@@ -1999,7 +1994,6 @@ send_response:
 }
 
 /* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
-__attribute__((unused))
 static bool sd_generic_write_byte(SDState *sd, uint8_t value)
 {
     sd->data[sd->data_offset] = value;
@@ -2045,8 +2039,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
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


