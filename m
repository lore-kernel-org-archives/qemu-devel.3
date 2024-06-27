Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92866C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMryT-0000YW-NI; Thu, 27 Jun 2024 12:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMryR-0000Vy-58
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:27:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMryO-0003Le-JW
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:27:50 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-36743a79dceso553688f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505667; x=1720110467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dkdp8a0v1eDrwEVEV8e/ROv9nmNjtoGPC9rjoBe3Zg=;
 b=QEeCDpnnxzodhiI+YlDudza8dfO+H9e5eSCLHeZz59J+MHjRKF4sWK3se+ydq8Or2C
 WEUuYsatW0ekNd7OhYsx9d9Rc82dVtc7dLywp0nBVSCeO+hFm6YxxJmcVWaxENWToTr2
 3megdtH1bibyKptzl2IOTpeUhivUn3Tn3P3ydNS1b/19FUTyK3Ie1QabYEZkT4QynO8i
 KPESup6Uzhi0Hs06df7W2FRGIDt48Phu0DhnO9/4gHn0hdq2dpA/cErr5MF8heRFDkZl
 P4R7SkBUrgp5lYb3OlqhjWbZUowAaV3bf210uzkhL0YgNrIKcq+HpjNVhUeAJBA41XwE
 AWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505667; x=1720110467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/dkdp8a0v1eDrwEVEV8e/ROv9nmNjtoGPC9rjoBe3Zg=;
 b=sgrGIlhSPTT1iTP8GHtYyg1uGAJAoCe48lauuXAru4xGDJvs/C0wgQPJyqFPkliGEF
 ZNUECC/0BuexGCutMjA5ZBcNZ+oJNxRC0PbAJIVpyqaRuFdd38UrAcN/q5juEPVg/tas
 OMpVzeziD2yB7wIpe8VDsdBk0VNg4jKucV3Sgca/vg2I0r6Dw68hrJktOaVs1Hcapg06
 n5erdQNyMkPgzb1UeLereTJqUsZV990b4BWkUaSNgwQoYew6KW1UhuFVblFGwvwUDM5s
 k91o25UWf3+n0kPAtL4IjWblXgD2BCGnoIVaS/Fidm4Yk0Kz3hAXsmhTTwgESJCPFX07
 gHBg==
X-Gm-Message-State: AOJu0YyuoUPIH7PJ1uY6MwLK7C1zzPxv5wyiiwz/Sv0X3jsKgJdJEXgf
 joXIhld2k/IP4LVTnxKquDwNTSn/UcrbaOBZVDeb+oFZjzH/fgRg91a/kB1LM4bjUc7bXt805KD
 pAgM=
X-Google-Smtp-Source: AGHT+IHCB+/h2ET78YOzpZ+NRyipA37XIDAbT/u+5fHeiLNTenDopHbhsbXtYUCQI5xpnyyhKio5LA==
X-Received: by 2002:a05:6000:1748:b0:362:363a:9594 with SMTP id
 ffacd0b85a97d-3674178975cmr2208517f8f.11.1719505666928; 
 Thu, 27 Jun 2024 09:27:46 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357fcb2sm2379487f8f.30.2024.06.27.09.27.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:27:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 01/11] hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and
 sd_generic_read_byte
Date: Thu, 27 Jun 2024 18:27:19 +0200
Message-ID: <20240627162729.80909-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162729.80909-1-philmd@linaro.org>
References: <20240627162729.80909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

All commands switching from TRANSFER state to (sending)DATA
do the same: send stream of data on the DAT lines. Instead
of duplicating the same code many times, introduce 2 helpers:
- sd_cmd_to_sendingdata() on the I/O line setup the data to
  be transferred,
- sd_generic_read_byte() on the DAT lines to fetch the data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d85b2906f4..1a8d06804d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -142,8 +142,10 @@ struct SDState {
      */
     bool expecting_acmd;
     uint32_t blk_written;
+
     uint64_t data_start;
     uint32_t data_offset;
+    size_t data_size;
     uint8_t data[512];
     uint8_t vendor_data[512];
 
@@ -1083,6 +1085,29 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+/* Configure fields for following sd_generic_read_byte() calls */
+__attribute__((unused))
+static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
+                                           uint64_t start,
+                                           const void *data, size_t size)
+{
+    if (sd->state != sd_transfer_state) {
+        sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd->state = sd_sendingdata_state;
+    sd->data_start = start;
+    sd->data_offset = 0;
+    if (data) {
+        assert(size);
+        memcpy(sd->data, data, size);
+    }
+    if (size) {
+        sd->data_size = size;
+    }
+    return sd_r1;
+}
+
 /* CMD0 */
 static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
 {
@@ -1920,6 +1945,20 @@ send_response:
     return rsplen;
 }
 
+/* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
+__attribute__((unused))
+static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
+{
+    *value = sd->data[sd->data_offset];
+
+    if (++sd->data_offset >= sd->data_size) {
+        sd->state = sd_transfer_state;
+        return true;
+    }
+
+    return false;
+}
+
 void sd_write_byte(SDState *sd, uint8_t value)
 {
     int i;
-- 
2.41.0


