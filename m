Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEF1C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsgf-0004iu-38; Thu, 27 Jun 2024 13:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsgb-0004Mg-9L
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:13:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsgY-0002PB-IK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:13:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-424f2b73629so23329475e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508405; x=1720113205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojivM3IaWwWzglQz4g05HwWNW+Y8YVh/DQQ1yO/B8Js=;
 b=hQD1cNMGVDmbof8gxhndOYSfho6R5rETVw6yhxuIvw5R0RscdR6KLKtZ6g4s5yrPf3
 LiSN5uMtCXKKxLxqNrjMdFEQNK4lYh74/ydVMUX8RjKFR3bKV7qbeRGFK6XHbzPgBAZa
 ruZCn9/JxQncpn3ppeASd2BR3SodzY3Tb4bpL4ikPnAbmscCBU5Z9yuVgFHeobVxKR2w
 hiJQ0i3nsDzgWAxa3UqXWB6bz+OhcipOeD1KZZAtC+mx2fOlTxOazpzHOP219ojJTq9K
 TmcQXAqFRQxvOyyvPFm+0K9YSJeOKEjMh2QWOIIpazcoGamzMgzDo2sqglTl97WaZZd+
 1IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508405; x=1720113205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ojivM3IaWwWzglQz4g05HwWNW+Y8YVh/DQQ1yO/B8Js=;
 b=B1ew8PCxw55fwZIkKZCZNpCG848iuN+lVUo9dbTEM2yNT1u4Blo2vDYhQqvkCeUwDE
 gsjE4jzMd9QIhowVeyIcKcBRBvHgG/zyNSm4g26vVzgW5vPw1+kbjg6nnqm0Muo2cBMw
 L5oWa+hrVdChM+S6h28wpxaBnmIeBoV5ib6I20UzSWs2cEsHnuAA2Cktgr9Xf15abh3f
 OvwxSXm0+WU1PcJ03OlKGl1car+9SqD9wIEZElIKE79NyBk4AIuZYXWZe5jsHpyRJ5Zu
 dFfdsIxfXVYXPBYBU+sreXiB5ZYaOr/GrKTMVNkKLxXtBFZwLM2sJeZx72yI+gqrKKTb
 ezrw==
X-Gm-Message-State: AOJu0YxF/+pNK85gL95a3eBsT3UGxAe9uU6V6zu9MCjFnHW4xyxoHhJ7
 TxJMMoLyTuGPV4BtYy1FMl0VYtGNolxLl2RaDk8Ssx8MyMl9AtrddXwcHSLUCs+Y/XDoZgbrixz
 mTyA=
X-Google-Smtp-Source: AGHT+IGMNvfO3BSLG+kEAfN3/+oY+svHa6CvwQH0RZxj9N8q0SIiXQBJIRyB0V8/+bRj9rWbuV+09g==
X-Received: by 2002:a05:600c:348c:b0:424:a5ee:a81e with SMTP id
 5b1f17b1804b1-4256456c30amr24527945e9.34.1719508404993; 
 Thu, 27 Jun 2024 10:13:24 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357fd08sm2510803f8f.27.2024.06.27.10.13.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:13:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 13/19] hw/sd/sdcard: Adapt sd_cmd_APP_CMD handler for eMMC
 (CMD55)
Date: Thu, 27 Jun 2024 19:10:53 +0200
Message-ID: <20240627171059.84349-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
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

From: Cédric Le Goater <clg@kaod.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
[PMD: Use aspeed_emmc_kludge]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f875fcd741..82e0b5838f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1693,6 +1693,9 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
     case sd_sleep_state:
         return sd_invalid_state_for_cmd(sd, req);
     case sd_idle_state:
+        if (sd_is_emmc(sd)) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
         if (!sd_is_spi(sd) && sd_req_get_rca(sd, req) != 0x0000) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "SD: illegal RCA 0x%04x for APP_CMD\n", req.cmd);
@@ -1707,7 +1710,7 @@ static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
     sd->expecting_acmd = true;
     sd->card_status |= APP_CMD;
 
-    return sd_r1;
+    return sd->aspeed_emmc_kludge ? sd_r0 : sd_r1;
 }
 
 /* CMD56 */
-- 
2.41.0


