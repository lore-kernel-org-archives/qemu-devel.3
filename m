Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5977C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0i3-0004pC-MQ; Tue, 25 Jun 2024 03:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0i2-0004oi-5h
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:35:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0i0-0003zQ-Ad
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:35:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4218180a122so39272015e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719300918; x=1719905718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pU2MPUHXpvnSU498pOire3lRQStnRBiAG9dQFz8I0B4=;
 b=azfw5UmsPcTm5jDYxm4cB5pZsdyyIz0YaRLI9eAUrOkLyijjFJG7fYnhJFOhG9gAWu
 VlbMKTyUjXXtWLYeGFyDm6O0CuUuECt6BzQJ0bFKhErq8mCBk5YTvd/bmZJDnWdCWrk5
 j1j/A/wMHusYTGRPZlepDTUpQqSUOgBMSFBNXbfjsEzrOcRJZkg9e5OtqhPM5Rui8urh
 8qE9NZDrloMCW3GnjrCA8aoYTuUJFbf+PmbwwcupElAcHggDUwR8xAXWb1nl2KgT/Mxp
 lBZ53dvHSW5zVNUmsaO8rl4Arxs9CCpWdKYnlHrcgewf5AnxZLtFSjv6yEDMsHMTXYBG
 +IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719300918; x=1719905718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pU2MPUHXpvnSU498pOire3lRQStnRBiAG9dQFz8I0B4=;
 b=d/ApCp6LQwuxHkdnC3DFNSdYU4vnuRTOZSl3Rm0fpj+gvUw7E/LRhBWnM3UPrK+P4q
 LjjWhhgI9HrySFuXC2hHVGpxLo3wd52YlJLZmd5sBUvwPnOOaQ9Sg+CWI/dXgQI74v2E
 yOn8E26J50D7PeL6iSw4amkbPUw6U5hQh2JexasGEPAt256EQyyI133Q9m7GkQxCe5bd
 LnsB+PDaf9RhgY650ior02dkiWw/BuqwHTsQCqwP4Tf8xkacoXQ9ITUD4IJVZqSgmAbL
 tRo8hnfDlHH55HD8UFoMWmxHjuVowQZRSBhcJL64+fR/n8TPayERDpDkoQQUIf6lP3Ye
 P9sg==
X-Gm-Message-State: AOJu0YxLYYGs09sClvRfDBJC8bNAN0kQk0u+ZOdnZepRoVKBSoNh0tHX
 Q29W8FgkJ2ytOjeJR95YVkL60AIMYv92QDTxO+9j/6tYQu3DkU3YPcUQCSL9IsKKUDASMuPPhbT
 0
X-Google-Smtp-Source: AGHT+IEvOrjnqYHK4x9lighrOwd4xp9d50/saPkcR3jqnJCldYnuNiBh3hpEtASeG+ZnLJPNG1JG7w==
X-Received: by 2002:a05:600c:4fd0:b0:424:74ed:dbfc with SMTP id
 5b1f17b1804b1-4248cc66abbmr49931405e9.35.1719300918307; 
 Tue, 25 Jun 2024 00:35:18 -0700 (PDT)
Received: from m1x-phil.lan (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d208b4asm199313845e9.29.2024.06.25.00.35.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jun 2024 00:35:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 6/7] hw/sd/sdcard: Convert LOCK_UNLOCK to generic_write_byte
 (CMD42)
Date: Tue, 25 Jun 2024 09:34:40 +0200
Message-ID: <20240625073441.34203-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625073441.34203-1-philmd@linaro.org>
References: <20240625073441.34203-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
 hw/sd/sd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b0f29034c0..82b44b65e0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1604,17 +1604,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Lock card commands (Class 7) */
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
+        return sd_cmd_to_receivingdata(sd, req, 0, 0);
 
     /* Application specific commands (Class 8) */
     case 55:  /* CMD55:  APP_CMD */
@@ -2085,8 +2075,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sd->blk_len) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_lock_command(sd);
-- 
2.41.0


