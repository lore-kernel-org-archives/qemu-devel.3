Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670CEC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsfX-000842-50; Thu, 27 Jun 2024 13:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsfR-0007nV-Et
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:17 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsfP-0002GZ-9F
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-424a3ccd0c0so27490545e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508332; x=1720113132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hWIFWqzHiq8lN1HtcaO+N2xCOE2TizGkz4ySULbbEQ=;
 b=xqiLKgDNLMK6hOQE4KzupANglfgoYU9bUs+VSE3bA/SbFMaL2aXVrTkuXPfN2/3tvU
 KzemlYOleQVLqOXS+PuTNuwig12sUq4rTV0miUTYF8K160RQX3gXIaP1BX0+RZNCuuBS
 T3AbKpb2dmoi+DRoENalOKHRvHkgsl0xvfDaU0+8zaHs2FdZsOOS+VOXhYAQMDx1wUPl
 LCiT2Fhsa+Jba+U2egho+iiKrclkWUWCzBeCM7M8XAyWHJzXErzNKvLtM4vuA1xX0J9g
 kiw19bCkQ8FxCC6gnxAAoltThABEyaV/DXwlH8pxeC5Roq+JRjL5eO+/AUsDd10t39Rj
 GneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508332; x=1720113132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hWIFWqzHiq8lN1HtcaO+N2xCOE2TizGkz4ySULbbEQ=;
 b=DnRuqyG6OJRoADnrHpbK+zLCgGgv91yVwAbhe5LfG4RsGOPvDs6a/69+bieEqwpxMk
 MDQwktek9rsCXEpMKMp2C6HcjXwkKxlrKI9NImleSEDzF5qSbr6a7+zdAzuJ8bq/N8xi
 qnwqp0FqL8iwiTA/l+h5ZQpa01rYWfKNKBq+HeqnPYGPzJSd8GWBDt46wFN1u7QKgJtR
 jUYZs5i/ZqDQLkXZqB1D4NRgTv3dhhkA+UK/Z9i2R9PA9RfgpuBmQR+eojelbGoTTGzE
 HVqfFtJqoxxnqsFN34jv7X+5pztsJ6z8WjBzBbKsZUipjrppk8h0iIlN0BR47nPH+xzy
 R2Tw==
X-Gm-Message-State: AOJu0Yxy+87WAIzROiuvtDaG8irgjtaGYCRWC+Yf6UW/mtL5bO9heI+0
 CM0wDtOdCws6nOO+rDyfVUfWbzRIarf5dXioZJR3Ofi4G59AeKaVHGKqfvu6Vfi+mko+WQKftAh
 Hw1A=
X-Google-Smtp-Source: AGHT+IEHCBMDF//TAaUS4JBORPA1qu6e1k7Xy0aG54ZASQ5sAAKOia9qwCyYvW9OHb7jRclv64D2ZA==
X-Received: by 2002:a05:600c:3b1f:b0:425:672a:766e with SMTP id
 5b1f17b1804b1-425672a7804mr14277585e9.0.1719508332472; 
 Thu, 27 Jun 2024 10:12:12 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424a2abcfd0sm52986785e9.1.2024.06.27.10.12.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:12:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 06/19] hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR() handler
Date: Thu, 27 Jun 2024 19:10:46 +0200
Message-ID: <20240627171059.84349-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9a2bfeaab6..c6e5c93acb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1220,6 +1220,20 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+static sd_rsp_type_t emmc_cmd_SET_RELATIVE_ADDR(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_identification_state:
+    case sd_standby_state:
+        sd->state = sd_standby_state;
+        sd_set_rca(sd, req.arg >> 16);
+        return sd_r1;
+
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD6 */
 static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
 {
@@ -2385,6 +2399,7 @@ static const SDProto sd_proto_emmc = {
     .cmd = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
-- 
2.41.0


