Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1F6C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwiS-00048W-Tl; Mon, 04 Aug 2025 11:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivL8-00016D-7v
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:35:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivL5-0000BX-Ly
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:34:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so31006395e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754314494; x=1754919294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZpl0YFbqRebR1Q333Nb/UlL0rGZ2P62yuzFRdhk9bs=;
 b=QCHLhQtEaOoAvhuajT6ZkKRv0tHORT7jF+0faFdyTEVnR2aF1dBiloPFTAVvEabosG
 sZ28s+eAM+kfbBz9lZs1HL/oepv/4LhAStR4hWgqOm2vD9xrKKd7CfUs7ezQ0hxbgH8Y
 o7dil+ZcDRMKJUFp5lCLk0fQR3HeddE4AikyubTisf7VCqmUDEsPt625Z2leJ6yRsTy+
 kvNDB1PAf9yO/erQ3CjeZNqSdShINHog8zd1i6KlkuwyjvJNoCks0/lq9ErcFBEnzc7O
 mmo+dxriTnbPDCX7kfmpjwj+oBMMqT08yozMmQmNBoChqRPGzwjFQnU/rG9qAQLKsy/I
 bTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314494; x=1754919294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZpl0YFbqRebR1Q333Nb/UlL0rGZ2P62yuzFRdhk9bs=;
 b=LiPhxCv6BKz2BaD02lqC9hxHW7mWQJOzFRwBPyjHv8EUv025HEmxbk6F/ypbFRvjsb
 OVJODz+uqPwUNmVL8ZqeGqU3i/jfKlpRwqgo4pZYNNV8NjQvVNiQkVXPux+SPKDq4rK0
 bjkDH2QUmGDvfSDzKy87VNmGW2i6x3kQuq6VP4CQhI0M5djDxprD8GzDt3HzWhWdCL8r
 5FPqEyh/lX/KkWsxsAipuWDqzst37OsXCs8paUS9D9T4Aro5Icx/EPT0MbVaNKCuW/3v
 Ife0RBmG72lfUmzSIrS+m/IvbydFzap2xPSs45nxSeW9WrMiapXUC8QkEnv6oR3ggk/P
 Tugw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkySxh6tP03YeP49dbR7I0h/6Z7FH+OgRsUgE68jFZmFw6XhF7OZVgMHphKwEOsI7X9lmi+InnRErH@nongnu.org
X-Gm-Message-State: AOJu0YzLuguSdX7YBeCoNyOTipwW08Z2LRvXqjyL3Fi4FvtktH63u81N
 LkOfGOFwIE6LxND98UZxK1dCp0KwQTKLG/TeOTIOVYCsjAZm9Pf3rMdG+9NAfOhbFf8=
X-Gm-Gg: ASbGnctdNNiDfWknkQYHZNt6Mi+BqBpq2DmhsXRDKhGwlL2Wjpd3CFoFUmDRVVJ2fC6
 f7Qss77bwtLMj8QsHV913hGxFVVbP4TYti5dwl3rfcGfhqvIQDDS59BeHfZMS0Fh41fnBet5eSz
 NJa2KrkFZmktkQ93zKbfaftfuZzuhwP7pjZbRM2zZF5kNYahun8n6Kmji00eDxeJOGizXfj18hP
 ExZ6FsIDPlvBslmmCAe9B6pXPcO4tMM/16c7Svk7D7xKcirEBaCX0NlXvtohvhKm50QrwWkLnBc
 OYL/dJZzEAvwzqBcKhL8mLsSZfZOBMplsh+qusawyYn6o1lmfK/9y7zuP9Oq7BiFW0eDXmUXgxj
 YHCCYw9SDhgzX/DY1C35MZsYUuOdHV0V2HRKaj8H/5oa8voiwYgYu0DU3wauyYxNpajgDR6OI
X-Google-Smtp-Source: AGHT+IFv7o0lQT6SIORbgD9ltcwVY0pnayL3M7/0hwkveU54IP/k7OHeWCpQOq/yGxHXhGn1M1socw==
X-Received: by 2002:a05:600c:4b2a:b0:458:bf0a:6061 with SMTP id
 5b1f17b1804b1-458bf0a6326mr35663155e9.24.1754314493543; 
 Mon, 04 Aug 2025 06:34:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf956sm15883300f8f.24.2025.08.04.06.34.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Aug 2025 06:34:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH-for-10.1 v2 09/11] hw/sd/sdcard: Disable checking STBY mode in
 SPI SEND_CSD/CID
Date: Mon,  4 Aug 2025 15:34:03 +0200
Message-ID: <20250804133406.17456-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804133406.17456-1-philmd@linaro.org>
References: <20250804133406.17456-1-philmd@linaro.org>
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

The card should be in STANDBY mode to process SEND_CSD or SEND_CID,
but is still in IDLE mode.

Unfortunately I don't have enough time to keep debugging this issue,
so disable the check for the time being and the next release, as it
blocks Linux. I'll keep looking.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ee81dc09991..22f30997713 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1591,9 +1591,20 @@ static sd_rsp_type_t emmc_cmd_SEND_EXT_CSD(SDState *sd, SDRequest req)
 static sd_rsp_type_t spi_cmd_SEND_CxD(SDState *sd, SDRequest req,
                                       const void *data, size_t size)
 {
+    /*
+     * XXX as of v10.1.0-rc1 command is reached in sd_idle_state,
+     * so disable this check.
     if (sd->state != sd_standby_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
+    */
+
+    /*
+     * Since SPI returns CSD and CID on the DAT lines,
+     * switch to sd_transfer_state.
+     */
+    sd->state = sd_transfer_state;
+
     return sd_cmd_to_sendingdata(sd, req, 0, data, size);
 }
 
-- 
2.49.0


