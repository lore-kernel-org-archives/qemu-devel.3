Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8552C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz8n-0002XI-1N; Tue, 25 Jun 2024 01:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8l-0002UK-Mm
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8k-0001g6-3i
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:51 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-35f090093d8so3462651f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294888; x=1719899688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rePHr36mkrTbTL5WwJD6QrkkFRWrQAZ68gdScQGNuYc=;
 b=ebDp/fvXtDRbOhsy16ZxMhNSsUUS8POT6ouUdiyzY8vFn7y7WmY9M0zM5hoby4KTz5
 gZM2V+me5ERHr1W0wf98gRObk5bR5tjHLerN4HucD9fqzPoEh4O4hLjhu6FSrhX5A+I2
 Nd4wZShLIGXuphkxwkpiX/o21b5/pKdp5u1NRzPspuPCjwdnZSOof7AZZYmiQi/bhDfo
 4ZdNEC/2Mk49AjzPdUfylvlZbqceVKHMaSUkcQ+VKZu/fIhqSgO495jM3CV6n4EzNWQT
 feoCIIUO/d51MXBTJ6J00k+CkGbOgNXqcRIBgOwN/dct78ecguwYKPWzjPVxs4gRaSoa
 AtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294888; x=1719899688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rePHr36mkrTbTL5WwJD6QrkkFRWrQAZ68gdScQGNuYc=;
 b=BKZVuEqiB4UC94NrtbmIZ+7f8SdzZpbTVHkoiaJlp+7o2mx+p8rHgQyyCNKc3uBXA9
 1x+qMQlWfqiVCRCIlzdBeVe7j30y8xLEJHl0woqH61oFQ0gvT9iEgyj6ELhO4j9tSLfe
 tT+UEKphVNNGYVGfdW8/KNN94u8ZlG973bQmXb/hXL+00uHu0i3/NB8waXnitvOUiG/g
 m+rMjkUClfDiHgPi/Tl8s+rxhAreu+GmBK7dfd6B5hN925aHd7Qu8M+sY0gHgg42Vz5p
 KNEgUJWv6xlG8STqTVuuQb5Q2Dp830FOiSaazQGnvi3yEcveh9TMyVrWkl4A0CiOVON5
 9L6Q==
X-Gm-Message-State: AOJu0YzwHTcBuiGkl4QotPzqJxXWLfuiXGHoJkVKFq/0Pgd91PukM90E
 25I3kfcpXvICFjVvImpqT7m9pVd8GPBIX2wyOV4cSB14OYyOHwL3LFk1zZ6LuQSF6fbMzCyLmFw
 b
X-Google-Smtp-Source: AGHT+IGfjfo4xhAxXI7RAYjdwG8Khrx1F3ZlWhbeLi/Q1CIcgkLO3YA63Au0ugQgE7fu3UgCRBuMmg==
X-Received: by 2002:adf:f7cb:0:b0:35f:cd7:5ba1 with SMTP id
 ffacd0b85a97d-366e7a6367amr4875249f8f.60.1719294888263; 
 Mon, 24 Jun 2024 22:54:48 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638d9c1d1sm11898372f8f.51.2024.06.24.22.54.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:54:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 09/12] hw/sd/sdcard: Assign SDCardStates enum values
Date: Tue, 25 Jun 2024 07:53:50 +0200
Message-ID: <20240625055354.23273-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

SDCardStates enum values are specified, so assign them
correspondingly. It will be useful later when we add
states from later specs, which might not be continuous.

See CURRENT_STATE bits in section 4.10.1 "Card Status".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8816bd6671..36955189e8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -76,16 +76,16 @@ enum SDCardModes {
 };
 
 enum SDCardStates {
-    sd_inactive_state = -1,
-    sd_idle_state = 0,
-    sd_ready_state,
-    sd_identification_state,
-    sd_standby_state,
-    sd_transfer_state,
-    sd_sendingdata_state,
-    sd_receivingdata_state,
-    sd_programming_state,
-    sd_disconnect_state,
+    sd_inactive_state       = -1,
+    sd_idle_state           = 0,
+    sd_ready_state          = 1,
+    sd_identification_state = 2,
+    sd_standby_state        = 3,
+    sd_transfer_state       = 4,
+    sd_sendingdata_state    = 5,
+    sd_receivingdata_state  = 6,
+    sd_programming_state    = 7,
+    sd_disconnect_state     = 8,
 };
 
 typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
-- 
2.41.0


