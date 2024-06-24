Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E21C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjXH-0001WC-2j; Mon, 24 Jun 2024 09:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXE-0001VD-NJ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:04 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXC-000506-5h
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:04 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ebeefb9a6eso47625211fa.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234900; x=1719839700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5C/rBGUajz/uZ65x4moAAqa+NPc5S7yF9iilS4WUHk=;
 b=bQ4G3gE+VPTTgE7xHzMNoeYf92xWNXMWYVj2KrdoMFRsILwwyQkhm+JHZHScPISZty
 GyJ1tRYcU2bvLPg6XiC9Ap884zbLMXL6E6Otsqj0tGPXUnTBmfh5KeCViEX/7pTO6gN1
 mYJA1Qh0qNkRMyQBcxiYLwlsI1AptKKb5EGRYpygtGM+ur6ISn4VtAZaKyu+slAPfcv9
 FxImM925Tk0jjGYr2FaIW5TBAwB1T0q04FbGpl4TReG2DU1QSqMOppasw6dHRkguHPOF
 7hUjV9T3hFFo19vcoxosQHSJa4eFoXaUJPQ+a7K2UbibrVb7kK7QQBAWPsjzKKNOGckI
 89zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234900; x=1719839700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5C/rBGUajz/uZ65x4moAAqa+NPc5S7yF9iilS4WUHk=;
 b=GVg7D5hLy5wxk++ilYlpLvZ1YZb74/fiKRC/Rj7nP/4VxN1bW+0jHPZjDg9XR83xnW
 BGxSaQ94jXl0AAANRFatLbR+AgtuuqjguWom8NqZue1B04yVj3FFbMC3S6bABo1uimGp
 E83zO+XACxQrOLC5D/JeIplX/VTPCkeKy22PKpCgMN7cmJZRQZaO8mF6hmjD57XHO1fK
 zH6BnNCisLkAEeNBUvaDZben24yJXSS8SDEKzocgHOjMw1G36qZUQBHAILWCKpuvtjMN
 vO7/tpc+P2+EB/w8AVwsrGYFSXZr5mH6lNgi8MiYOcb5HwTrpEZj4OT/XKnLv2SjjGN/
 OjJw==
X-Gm-Message-State: AOJu0Yyo0pfK2IE4AIzrdY8XTcJAtSv+Wg4OM7oScWp3ODy5rYKS5t8B
 HaWeez/IngWs6i5B78sWg80mRCR9nkkRBx8HUj2FFTdo4wweR7r3wimcEWo1rQeOOKdXHGTYoPr
 t
X-Google-Smtp-Source: AGHT+IELuqR4wMmlDqCMx98lY9cPeUbP8HZpgf6vJKFgGQ19UYoDv6DMwEaavXqWGwYmux4riJ1ICw==
X-Received: by 2002:a05:651c:104f:b0:2eb:fb9c:5a85 with SMTP id
 38308e7fff4ca-2ec5940087bmr28858911fa.23.1719234900175; 
 Mon, 24 Jun 2024 06:15:00 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817a9667sm132776375e9.15.2024.06.24.06.14.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:14:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/19] hw/sd/sdcard: Correct code indentation
Date: Mon, 24 Jun 2024 15:14:24 +0200
Message-ID: <20240624131440.81111-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
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

Fix mis-alignment from commits 793d04f495 and 6380cd2052
("Add sd_cmd_SEND_TUNING_BLOCK" and "Add sd_cmd_SET_BLOCK_COUNT").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-2-philmd@linaro.org>
---
 hw/sd/sd.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6a7a10501b..ba7f165cb5 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1069,33 +1069,33 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
 
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
-        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
-            return sd_cmd_illegal(sd, req);
-        }
+    if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
+        return sd_cmd_illegal(sd, req);
+    }
 
-        if (sd->state != sd_transfer_state) {
-            return sd_invalid_state_for_cmd(sd, req);
-        }
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
 
-        sd->state = sd_sendingdata_state;
-        sd->data_offset = 0;
+    sd->state = sd_sendingdata_state;
+    sd->data_offset = 0;
 
-        return sd_r1;
+    return sd_r1;
 }
 
 static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 {
-        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
-            return sd_cmd_illegal(sd, req);
-        }
+    if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
+        return sd_cmd_illegal(sd, req);
+    }
 
-        if (sd->state != sd_transfer_state) {
-            return sd_invalid_state_for_cmd(sd, req);
-        }
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
 
-        sd->multi_blk_cnt = req.arg;
+    sd->multi_blk_cnt = req.arg;
 
-        return sd_r1;
+    return sd_r1;
 }
 
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
-- 
2.41.0


