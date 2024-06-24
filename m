Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729FFC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjZ9-0005LR-JA; Mon, 24 Jun 2024 09:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjYU-0004Vq-Er
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:31 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjYS-0005c3-6z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:21 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ec4eefbaf1so32206141fa.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234976; x=1719839776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OyvAZYAFCHsIdySGDiXeFQ2F3N56N52JzU6FXve/Tk=;
 b=DzUU0xiczFjZbc9WgaPziF66c2woNd8KtcRbC03A9JHkQHZVSEH+VU0YH5omWSgRWr
 njhyl6h0yZVWdsPwP4ZxRuY9De3ltdIqWaMGPsGSZcYxse9V360AL03A2gLhCoJ/4A09
 lfU+K5bVJK9OjM5B2DL0baVC3FMDFS4yjGL9n0A/YSF2KCq9uX96AW4RKp3KJUenwziV
 Qm6bVyIx6pVL6uUkbfBb2h2y55nl3DoIWylVOiTXrxAClRZsECQK5Yju6Uk9X3EVtnPn
 oeT4BUtXnZr1C6MRJjnK2YVyM1RzNEMT50ZOjpgrY+ylOhxZ61Pc5bb6LCm4qe34Q3ox
 RqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234976; x=1719839776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OyvAZYAFCHsIdySGDiXeFQ2F3N56N52JzU6FXve/Tk=;
 b=WX3M8uRmzf010mGhec5x4D/oAIcu0P5VUMOPvJWUTqq+Cl9D+h9UzUhLpY2DDyIpKP
 w4S8won5JL+mo1qqUNLgq3NalbIgZ2HOSiqR6VAWn2jfc11Yq3P5UWeKCveEatY09CLj
 uGEeErGmdig23tg0014+x5v3MHQCnZGLTIwnsFWLdVWQcEhZ6OZJgC55B1Aj4gJj9xxa
 ochFoifHflbhcg4dN/jkiN+AdE6NQokj390CLzPD6CMdgSE54AP54JxtuCtJsuPLZwc7
 3bAw8ajo8lF1EPBdpGsTnA7I1jFyKR0bCN2uVxnNA+gEH+SPjgQBLcc/TSrF92edHhYY
 BDaQ==
X-Gm-Message-State: AOJu0Ywf3z7qKiBjq3YyjNw+iL0TUrFUC0K4QPEHBQXwl6XcNlmKzNJg
 aftoApYQJozIZWbybwkt5nVvkpTffAArEclCVfYlzuLKLS53zCp2+zrjULczPUwziEzfT7McTI3
 u
X-Google-Smtp-Source: AGHT+IFxIv8Hp01Og8kxt3lqIdEFZkOEKyHPfxi9T/bYxKs3Qjy8/GnA5UNvZIgZr6aKDO4zDCOcgw==
X-Received: by 2002:a2e:b788:0:b0:2ec:4487:6a8f with SMTP id
 38308e7fff4ca-2ec5b3d4ab1mr26520821fa.37.1719234975804; 
 Mon, 24 Jun 2024 06:16:15 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366388c41b0sm10007103f8f.44.2024.06.24.06.16.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:16:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/19] hw/sd/sdcard: Add sd_invalid_mode_for_cmd to report
 invalid mode switch
Date: Mon, 24 Jun 2024 15:14:38 +0200
Message-ID: <20240624131440.81111-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

Having the mode switch displayed help to track incomplete
command implementations.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-19-philmd@linaro.org>
---
 hw/sd/sd.c | 75 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3e4eb656e1..969340e5cb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -178,6 +178,17 @@ static const char *sd_version_str(enum SDPhySpecificationVersion version)
     return sdphy_version[version];
 }
 
+static const char *sd_mode_name(enum SDCardModes mode)
+{
+    static const char *mode_name[] = {
+        [sd_inactive]                   = "inactive",
+        [sd_card_identification_mode]   = "identification",
+        [sd_data_transfer_mode]         = "transfer",
+    };
+    assert(mode < ARRAY_SIZE(mode_name));
+    return mode_name[mode];
+}
+
 static const char *sd_state_name(enum SDCardStates state)
 {
     static const char *state_name[] = {
@@ -1018,6 +1029,15 @@ static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong mode: %s (spec %s)\n",
+                  sd_proto(sd)->name, req.cmd, sd_mode_name(sd->mode),
+                  sd_version_str(sd->spec_version));
+
+    return sd_illegal;
+}
+
 static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown CMD%i for spec %s\n",
@@ -1156,18 +1176,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 6:  /* CMD6:   SWITCH_FUNCTION */
-        switch (sd->mode) {
-        case sd_data_transfer_mode:
-            sd_function_switch(sd, req.arg);
-            sd->state = sd_sendingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
-
-        default:
-            break;
+        if (sd->mode != sd_data_transfer_mode) {
+            return sd_invalid_mode_for_cmd(sd, req);
         }
-        break;
+        sd_function_switch(sd, req.arg);
+        sd->state = sd_sendingdata_state;
+        sd->data_start = 0;
+        sd->data_offset = 0;
+        return sd_r1;
 
     case 7:  /* CMD7:   SELECT/DESELECT_CARD */
         rca = sd_req_get_rca(sd, req);
@@ -1291,33 +1307,24 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     case 13:  /* CMD13:  SEND_STATUS */
         rca = sd_req_get_rca(sd, req);
-        switch (sd->mode) {
-        case sd_data_transfer_mode:
-            if (!sd_is_spi(sd) && sd->rca != rca) {
-                return sd_r0;
-            }
-
-            return sd_r1;
-
-        default:
-            break;
+        if (sd->mode != sd_data_transfer_mode) {
+            return sd_invalid_mode_for_cmd(sd, req);
         }
-        break;
+        if (!sd_is_spi(sd) && sd->rca != rca) {
+            return sd_r0;
+        }
+
+        return sd_r1;
 
     case 15:  /* CMD15:  GO_INACTIVE_STATE */
-        rca = sd_req_get_rca(sd, req);
-        switch (sd->mode) {
-        case sd_data_transfer_mode:
-            if (sd->rca != rca)
-                return sd_r0;
-
-            sd->state = sd_inactive_state;
-            return sd_r0;
-
-        default:
-            break;
+        if (sd->mode != sd_data_transfer_mode) {
+            return sd_invalid_mode_for_cmd(sd, req);
         }
-        break;
+        rca = sd_req_get_rca(sd, req);
+        if (sd->rca == rca) {
+            sd->state = sd_inactive_state;
+        }
+        return sd_r0;
 
     /* Block read commands (Class 2) */
     case 16:  /* CMD16:  SET_BLOCKLEN */
-- 
2.41.0


