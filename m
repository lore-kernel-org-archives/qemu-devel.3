Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F80C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrwM-0003KO-20; Thu, 27 Jun 2024 12:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrwD-0002pk-Ot
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:25:33 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrw9-0002XK-Qe
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:25:33 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ec0f3b9cfeso97501571fa.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505525; x=1720110325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zk4YjB9lQI2zLem86by0CBqxXy4bvU8ycOt1g+Y0WQQ=;
 b=h0QES/EN/cW4hVUVQ+eEtzCkcIu3eEXMWadNgcmK0lrKnArUNHvCE5Kz0E/lasdgoq
 +HdCtGCts3PDDQkXoEcnV3q7YoZMP8K2oCiu1GBKT8I1NG/eHEdscExni5yPeZbWWAKn
 mcvQUoo507u0LyBsOdIOvrSIB0EffLJLMpFqaFWZYDgIs7DvNihHAQaxBHaOJce8amej
 j2YXaknEJTSRfrOv2RI/9FChFvLDZd7Hu8lZW8iFh8uKQJe0inOlSdiDCg8E++AwNM+j
 xwAdeu1uD+tqbZ6ygMDFoSc3dad8CAtaN5BZSpcAsJPsgWzCyk3luTUU4Ane6hv0tMho
 aEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505525; x=1720110325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zk4YjB9lQI2zLem86by0CBqxXy4bvU8ycOt1g+Y0WQQ=;
 b=Yv4TiXZz9iEnvH7vfba0kebiz815A3IR8DoNB5r6a0hqELdRXSDM0NhtueuVqXz/4S
 TDs9S8y9SnOxQQRLvdqEP2VxB9faBJaI9F7eMc0HJDM/yJ1IrQQ2TBq6NmV5LjLZ6Jia
 wadMBFTiWgIlCok2ZD0TNDj7BMmW5blrqEdsPktsiMEBEwr8Bups0lRZwjnlP/HHR0kw
 /xvpiD4v+hgM+/yko23W5Gb+ARDkTzO2xge101SLWf97Ie/74QccSGkQ7lThHYqKpOlU
 +aiVbAIuoc1c00xbYH6E9dDWQ60JEiJEINhFi7zPZuCU5U3yv3WXccAiAeI9JjwHLdxG
 rtmg==
X-Gm-Message-State: AOJu0Yw6S/+ofPnF0GhBu8xAb7TBqhIq6gkIhRqORjOzGovAnuvCj9LW
 CcCBH4l0JCZCG/VWqw4erEFzQPgi2uyuHkVJr4kjuOvr2y/43EbonZBMoOm4/yAzJssgfEpMuHq
 yMj4=
X-Google-Smtp-Source: AGHT+IEdxMiurzV1C2T08Oc3P/QDF6vdmkFS0KlGAjnc7OKIe6mRlaeZpBQLQWGf6f6Q6vYeO7YyGQ==
X-Received: by 2002:a19:7612:0:b0:52c:d639:dd4b with SMTP id
 2adb3069b0e04-52ce06442eamr8285193e87.23.1719505523361; 
 Thu, 27 Jun 2024 09:25:23 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bc4f70sm36674055e9.39.2024.06.27.09.25.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:25:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 13/17] hw/sd/sdcard: Add direct reference to SDProto in
 SDState
Date: Thu, 27 Jun 2024 18:22:28 +0200
Message-ID: <20240627162232.80428-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

Keep direct reference to SDProto in SDState,
remove then unnecessary sd_proto().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8f441e418c..aaa50ab2c5 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -116,6 +116,8 @@ struct SDState {
     uint8_t spec_version;
     BlockBackend *blk;
 
+    const SDProto *proto;
+
     /* Runtime changeables */
 
     uint32_t mode;    /* current card mode, one of SDCardModes */
@@ -154,18 +156,11 @@ struct SDState {
 
 static void sd_realize(DeviceState *dev, Error **errp);
 
-static const struct SDProto *sd_proto(SDState *sd)
-{
-    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
-
-    return sc->proto;
-}
-
 static const SDProto sd_proto_spi;
 
 static bool sd_is_spi(SDState *sd)
 {
-    return sd_proto(sd) == &sd_proto_spi;
+    return sd->proto == &sd_proto_spi;
 }
 
 static const char *sd_version_str(enum SDPhySpecificationVersion version)
@@ -1044,7 +1039,7 @@ static bool address_in_range(SDState *sd, const char *desc,
 static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong state: %s (spec %s)\n",
-                  sd_proto(sd)->name, req.cmd, sd_state_name(sd->state),
+                  sd->proto->name, req.cmd, sd_state_name(sd->state),
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1053,7 +1048,7 @@ static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong mode: %s (spec %s)\n",
-                  sd_proto(sd)->name, req.cmd, sd_mode_name(sd->mode),
+                  sd->proto->name, req.cmd, sd_mode_name(sd->mode),
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1062,7 +1057,7 @@ static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown CMD%i for spec %s\n",
-                  sd_proto(sd)->name, req.cmd,
+                  sd->proto->name, req.cmd,
                   sd_version_str(sd->spec_version));
 
     return sd_illegal;
@@ -1073,7 +1068,7 @@ __attribute__((unused))
 static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_UNIMP, "%s: CMD%i not implemented\n",
-                  sd_proto(sd)->name, req.cmd);
+                  sd->proto->name, req.cmd);
 
     return sd_illegal;
 }
@@ -1166,7 +1161,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
      * However there is no ACMD55, so we want to trace this particular case.
      */
     if (req.cmd != 55 || sd->expecting_acmd) {
-        trace_sdcard_normal_command(sd_proto(sd)->name,
+        trace_sdcard_normal_command(sd->proto->name,
                                     sd->last_cmd_name, req.cmd,
                                     req.arg, sd_state_name(sd->state));
     }
@@ -1185,8 +1180,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_illegal;
     }
 
-    if (sd_proto(sd)->cmd[req.cmd]) {
-        return sd_proto(sd)->cmd[req.cmd](sd, req);
+    if (sd->proto->cmd[req.cmd]) {
+        return sd->proto->cmd[req.cmd](sd, req);
     }
 
     switch (req.cmd) {
@@ -1632,12 +1627,12 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
     sd->last_cmd_name = sd_acmd_name(req.cmd);
-    trace_sdcard_app_command(sd_proto(sd)->name, sd->last_cmd_name,
+    trace_sdcard_app_command(sd->proto->name, sd->last_cmd_name,
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
 
-    if (sd_proto(sd)->acmd[req.cmd]) {
-        return sd_proto(sd)->acmd[req.cmd](sd, req);
+    if (sd->proto->acmd[req.cmd]) {
+        return sd->proto->acmd[req.cmd](sd, req);
     }
 
     switch (req.cmd) {
@@ -1928,7 +1923,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return;
 
-    trace_sdcard_write_data(sd_proto(sd)->name,
+    trace_sdcard_write_data(sd->proto->name,
                             sd->last_cmd_name,
                             sd->current_cmd, sd->data_offset, value);
     switch (sd->current_cmd) {
@@ -2083,7 +2078,7 @@ uint8_t sd_read_byte(SDState *sd)
 
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
-    trace_sdcard_read_data(sd_proto(sd)->name,
+    trace_sdcard_read_data(sd->proto->name,
                            sd->last_cmd_name,
                            sd->current_cmd, sd->data_offset, io_len);
     switch (sd->current_cmd) {
@@ -2227,7 +2222,9 @@ static const SDProto sd_proto_sd = {
 static void sd_instance_init(Object *obj)
 {
     SDState *sd = SD_CARD(obj);
+    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
 
+    sd->proto = sc->proto;
     sd->last_cmd_name = "UNSET";
     sd->enable = true;
     sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
-- 
2.41.0


