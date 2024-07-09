Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C89C3DA47
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCjt-0004Fw-5x; Tue, 09 Jul 2024 11:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCjq-000466-9V
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCjn-0006Gt-W2
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266fd395eeso8155705e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538798; x=1721143598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=daY+t25+t6fUlvq8XgRmvXSG1rxW6z777bj+RrC4xDs=;
 b=FUdkAThuB/oVl2mEKN3PytIRlKxYmI7yeJLXAKUiqwpM3znJpM+m11sH6RTlT01KOE
 llhMCOfrGBAs9Ta8uOcec6/DCOZw5F7Y47o8rnMI/+5fawcL4U3lsgrZlRbcab4POkLf
 PpP8CZXjF2CeBDux3odTrQJ19wrmx80qqPjR40CJHG5sxVhZ9D5wJ/HDGPWWX6ST55eP
 CVH1cmVsVR8ptDKKAyBQLWSNeV4hS4nF80cpJQEIlN3cxg/o0QitMfkuysM9iiXZsme6
 dw5WJMuuppHRMLvgnpPX69nIlWBqfatXF1gojPsRG1UmkFiWTggDzuKnwuaH3ZuyThrE
 JrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538798; x=1721143598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=daY+t25+t6fUlvq8XgRmvXSG1rxW6z777bj+RrC4xDs=;
 b=ZyBs/GSMKRMeUHzaGVIluzG+/Iihuqg/hl20htnbKFeFL37ajrKb6qLubuVbtwmwLI
 ghyS1e+A1pvUqbRzWByhh5ykjwgB8gJEapPl37cV3K+vcwe2CVNvx2GgYvTUpGczbDQh
 fUQxXKtbnHs58oMD8PCLqhPs+DeFc0lBfaykCWMGRu4ySYgTbGmhvGbNY+m0D+RyzsZ5
 ZTSao4JxQQFSWxYit09lv+KNs204hX3u4ldPeox2XkXyvtGygS5kzFLBfP+jSuht2Amb
 ONHdUwOEJ9vE4bo8IrP0I0Luqc+qiMAVY7jTSz0357AUUCUoByYMyULhzz8pOuQOpDV3
 tPmg==
X-Gm-Message-State: AOJu0YwfrAm8ogTKtqFcBn35GGkZQjWnjqv1Sm79j1Ow4HFGwXS1ccE0
 2E9OWo6EKHA5nu/PxKgn44fQr5iBuwSP5y0u687t7ZmFenXdo/awBV9sgg5xw0ApXkv6gFc6H9Q
 F
X-Google-Smtp-Source: AGHT+IGpaP1PaUQFbl5nkPS7zpUzx+EbRXFb+HKC55gHe1HHT2eJFKuQL7IwD3NsVOSjKU/IfCy+NQ==
X-Received: by 2002:a05:600c:1c10:b0:426:5416:67de with SMTP id
 5b1f17b1804b1-426707f7e68mr19359555e9.30.1720538798331; 
 Tue, 09 Jul 2024 08:26:38 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f7362d9sm44351915e9.30.2024.07.09.08.26.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:26:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [PATCH v47 06/19] hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR
 handler (CMD3)
Date: Tue,  9 Jul 2024 17:25:43 +0200
Message-ID: <20240709152556.52896-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
Message-Id: <20240628070216.92609-86-philmd@linaro.org>
---
 hw/sd/sd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f580c6b2ae..83d45c897f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1280,6 +1280,20 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
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
@@ -2445,6 +2459,7 @@ static const SDProto sd_proto_emmc = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_bcr,  "SEND_OP_COND", sd_cmd_SEND_OP_COND},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
-- 
2.41.0


