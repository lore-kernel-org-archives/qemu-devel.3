Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BD4C30659
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz8F-0001dO-0a; Tue, 25 Jun 2024 01:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8D-0001cR-2q
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8B-0001Zn-Hb
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:16 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-424720e73e1so42223355e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294854; x=1719899654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Dw7TbCqvf3FA5r7Q8Kk2fU8m/vY/FUcBZ3OzTc5F+s=;
 b=GMg2j5T+iuAn33zVveDz8E0MOwz3R5bgqXy3vVap0o62HLsN48KXttFPRLoVLZSUul
 ivGdt8fSmxfGyIp0udlgFDCEV3unvIPZMUDQdZP5zGKJpPTk31ZpSAaZJ1sicfemxJYc
 JkhrtvOulzloU2Onc9gb9/mjh3jOwn1zXMP5yxI7fTIrftiBS5bD0Wp5KlaUYXUgxigj
 yM7jC9Upmv+Hb6JAmR+ioRjYdeFbYpQcmKf0wC8muejCeqYHRmyccJMWYJBfZjyqlcxG
 36sKdp76QohsJyOyDxnGYO/erBzNHDmpzRFwaAYPjh/G024AkOsWvWCgS9tYQqZ/EPwH
 D1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294854; x=1719899654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Dw7TbCqvf3FA5r7Q8Kk2fU8m/vY/FUcBZ3OzTc5F+s=;
 b=uJdGIUCITS9JzulK8+HrReizvAL1oxfQIS2Nv+qlDyS+KAAWvHF6WdoRVeTi/88uA5
 /kqSf942C8Ec+vaKLRswqlgPmmDOFWgRvO0PIOAskODpqzv83Cbh3BAGVAxnI7r2511B
 Y9D9Rmt4o/Bx6niNt8ykMtCNzo0/b17BvVoBHsWAZblMhHkQpujmWlBDl8/+nxSXKsoA
 xPaAcpc9umQzh2WXqTTUkYlw5ZcplsAcbEA8Q+rbi6h+NuKOwklg1gUDeQdnsjI5RYdR
 H7W/twG12VTOFD8AvwWz+mqmZRNkMhh0xlWraZpbX4XeCkpYGeP/YE+MwwC1QprSqts5
 qGqA==
X-Gm-Message-State: AOJu0Yw0XW6ePdd8UkBBqmdIT6d6NWvbX27gyO451wi94VKDM3Qm+Sz0
 6LWfc9R7ZsH2Y+HeM3u+eCeJs9MVyhbPlkRHQ4bIYZ7v7kPH13PWAC6wOYrFOwFXwk0lK6/M99F
 c
X-Google-Smtp-Source: AGHT+IEI8xOUGeZGlT9TyChqUUcjFvnX3GyPQxcmgCZc27chblJKDReheB16/IsA16iqACR+edGizQ==
X-Received: by 2002:a05:600c:2d05:b0:421:82ed:28d1 with SMTP id
 5b1f17b1804b1-4248cc73e25mr42975115e9.41.1719294853895; 
 Mon, 24 Jun 2024 22:54:13 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3666dc46d50sm11549452f8f.67.2024.06.24.22.54.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:54:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 03/12] hw/sd/sdcard: Track last command used to help logging
Date: Tue, 25 Jun 2024 07:53:44 +0200
Message-ID: <20240625055354.23273-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The command is selected on the I/O lines, and further
processing might be done on the DAT lines via the
sd_read_byte() and sd_write_byte() handlers. Since
these methods can't distinct between normal and APP
commands, keep the name of the current command in
the SDState and use it in the DAT handlers. This
fixes a bug that all normal commands were displayed
as APP commands.

Fixes: 2ed61fb57b ("sdcard: Display command name when tracing CMD/ACMD")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ec58c5e2a6..14bfcc5d6b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -134,6 +134,7 @@ struct SDState {
     uint32_t pwd_len;
     uint8_t function_group[6];
     uint8_t current_cmd;
+    const char *last_cmd_name;
     /* True if we will handle the next command as an ACMD. Note that this does
      * *not* track the APP_CMD status bit!
      */
@@ -1150,12 +1151,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     uint16_t rca;
     uint64_t addr;
 
+    sd->last_cmd_name = sd_cmd_name(req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
      * However there is no ACMD55, so we want to trace this particular case.
      */
     if (req.cmd != 55 || sd->expecting_acmd) {
         trace_sdcard_normal_command(sd_proto(sd)->name,
-                                    sd_cmd_name(req.cmd), req.cmd,
+                                    sd->last_cmd_name, req.cmd,
                                     req.arg, sd_state_name(sd->state));
     }
 
@@ -1616,7 +1618,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    trace_sdcard_app_command(sd_proto(sd)->name, sd_acmd_name(req.cmd),
+    sd->last_cmd_name = sd_acmd_name(req.cmd);
+    trace_sdcard_app_command(sd_proto(sd)->name, sd->last_cmd_name,
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
 
@@ -1909,7 +1912,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         return;
 
     trace_sdcard_write_data(sd_proto(sd)->name,
-                            sd_acmd_name(sd->current_cmd),
+                            sd->last_cmd_name,
                             sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
@@ -2065,7 +2068,7 @@ uint8_t sd_read_byte(SDState *sd)
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
     trace_sdcard_read_data(sd_proto(sd)->name,
-                           sd_acmd_name(sd->current_cmd),
+                           sd->last_cmd_name,
                            sd->current_cmd, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
@@ -2210,6 +2213,7 @@ static void sd_instance_init(Object *obj)
 {
     SDState *sd = SD_CARD(obj);
 
+    sd->last_cmd_name = "UNSET";
     sd->enable = true;
     sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
 }
-- 
2.41.0


