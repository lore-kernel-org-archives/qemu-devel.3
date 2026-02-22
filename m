Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AECC636C5
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIXC-0001bU-Ko; Sun, 22 Feb 2026 18:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXB-0001b9-50
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:41 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIX9-0005w8-G0
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:40 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-483abed83b6so7662755e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801598; x=1772406398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OLEzbZM328E3NSLw7igBEUpMihYAhPnmUCU+6xw7L88=;
 b=oZkwAFb3H/i2D0pwYjK1OrFq6R7bdtnVIMO17rGAaTADbw1zgibSsGw1TVa6vXV2BR
 96hnP28taAltnVtflOsmde/8Ov6PiRghlEmj+5BpmBvkahjTGCzfMFyXQ8Aer31I+gH4
 ZwBd4UCHRtYPVxIQ4SrOR0KI0Gs4DoiRatR/88bqUZ88tgXAc2oRxGeU3UdaIJ7xt7Rr
 vCZB1I3W3fPm6Y6DCjFJQ/UxZgy6GyNAnA7DFL1LBPtavycH8dv0p858JF2S5HSKSNxs
 MsNm3nM4QlfFMobY+iEJ38+TjC9u7/Pouq2xO9jTA+bE7TKcPaJmtzJFPioiOvavZ/En
 iPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801598; x=1772406398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OLEzbZM328E3NSLw7igBEUpMihYAhPnmUCU+6xw7L88=;
 b=D/z/I/NVygZ89V1o3VejutyZm3BbKeFZTPSkYu2R6lnQYxSgAcK0hD+a2VQMUjv8i9
 i/kTRs2oU+JkpGre/yBcVsKJqxPQzfL9HjJlhJQCtn6CFwMZG1xt03jTYJTR7qafVF81
 WHmBhSXzYElky8rekaQvNasUujriOL51f5ZMPT7s7nm8XAyAtUNB8zkbTAQ4jJoj2tZD
 9tj92frgbcX3Y5f1x42KpYPH6sVXxoJRJGGRM+uHmZMPN2Mx99BGDN89kXatW5dT7KhC
 KLpxssjAGFQY5tUW2izHvSm3Uqg4vaw9BtwMnveBinrHjPC8l9XRqKkf4tdsy318qh7P
 RdJQ==
X-Gm-Message-State: AOJu0Ywy8oMsTC0ic5/UIhBMn9qsV4JMlmIlLCEXT4UZwnBGBgEL1ww3
 R8UdlmnQw8X2FOMquQ+Njx3NlW8d+QruMOROOOP35eJJ4vhISn6sdQZ4vJhxAk32hDPZOuFpDwp
 Q/q+FWc0=
X-Gm-Gg: AZuq6aLonjXyWkosdq1kXqShRoyedMtTstCVkhqeGlP7K28T+/bk+iyXILj3fIKsAEa
 ot9pVs5HKwCm+kOoLLg4wyCyMBT3/+YF2dpLw9rpo2mGTPxzQnAQtB+hUp73EgJH/WYjP6FfSMO
 dZsR+vNXTaGAy9dgnOQI4DIerzTEEqenbDr8hlO8cfH0brOjc0re2NJwHdqu6QaxqCl4kvMep9Q
 ak03Qt2IrnORLu86wpFwddifG0DGDXYqbPW28QSf6pCsfbMMv3kLWW57tNNb/CNkfk3SE5MBI2l
 QuFhEoXxR0R/8CvK2PEZxPTISpEAb18XfkoyZLIEHK9R/XwABsdzhx0JiwbCkMV3/k4/rGM0yW4
 /J/gwAq0IqFKZwwKw8FmUpTyKRhHZ/qzHNI70udv8eHGFoZ6w+HCrPgjVo3sxTETQF9IOFy3E2Q
 tj+JipKczQATcer1faDEC5ptFUWeR/k665bLlVEQA2MYib62U2C7oeMjVQPMV0uLU6zqBzJtuZ
X-Received: by 2002:a05:600c:8b44:b0:480:6852:8d94 with SMTP id
 5b1f17b1804b1-483a95eabccmr114440005e9.27.1771801597729; 
 Sun, 22 Feb 2026 15:06:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9caadd4sm139296035e9.11.2026.02.22.15.06.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:06:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/20] hw/display/macfb: Constify macfb_mode_table[] array
Date: Mon, 23 Feb 2026 00:05:46 +0100
Message-ID: <20260222230602.5756-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

macfb_mode_table[] is only read, never updated, so can be const.

Update the call sites accordingly.
Make the MacfbState::mode pointer to const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260216213121.47122-3-philmd@linaro.org>
---
 include/hw/display/macfb.h |  2 +-
 hw/display/macfb.c         | 10 +++++-----
 hw/m68k/q800.c             |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
index 495dead44b5..cb7aac7a4dd 100644
--- a/include/hw/display/macfb.h
+++ b/include/hw/display/macfb.h
@@ -66,7 +66,7 @@ typedef struct MacfbState {
     uint8_t type;
 
     uint32_t regs[MACFB_NUM_REGS];
-    MacFbMode *mode;
+    const MacFbMode *mode;
 
     QEMUTimer *vbl_timer;
     qemu_irq irq;
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 57ad8ad5587..8ef174dc6df 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -100,7 +100,7 @@ static const MacFbSense macfb_sense_table[] = {
     { MACFB_DISPLAY_SVGA, 0x7, 0x5 },
 };
 
-static MacFbMode macfb_mode_table[] = {
+static const MacFbMode macfb_mode_table[] = {
     { MACFB_DISPLAY_VGA, 1, 0x100, 0x71e, 640, 480, 0x400, 0x1000 },
     { MACFB_DISPLAY_VGA, 2, 0x100, 0x70e, 640, 480, 0x400, 0x1000 },
     { MACFB_DISPLAY_VGA, 4, 0x100, 0x706, 640, 480, 0x400, 0x1000 },
@@ -397,7 +397,7 @@ static void macfb_update_mode(MacfbState *s)
 
 static void macfb_mode_write(MacfbState *s)
 {
-    MacFbMode *macfb_mode;
+    const MacFbMode *macfb_mode;
     int i;
 
     for (i = 0; i < ARRAY_SIZE(macfb_mode_table); i++) {
@@ -418,11 +418,11 @@ static void macfb_mode_write(MacfbState *s)
     }
 }
 
-static MacFbMode *macfb_find_mode(MacfbDisplayType display_type,
+static const MacFbMode *macfb_find_mode(MacfbDisplayType display_type,
                                   uint16_t width, uint16_t height,
                                   uint8_t depth)
 {
-    MacFbMode *macfb_mode;
+    const MacFbMode *macfb_mode;
     int i;
 
     for (i = 0; i < ARRAY_SIZE(macfb_mode_table); i++) {
@@ -440,7 +440,7 @@ static MacFbMode *macfb_find_mode(MacfbDisplayType display_type,
 static gchar *macfb_mode_list(void)
 {
     GString *list = g_string_new("");
-    MacFbMode *macfb_mode;
+    const MacFbMode *macfb_mode;
     int i;
 
     for (i = 0; i < ARRAY_SIZE(macfb_mode_table); i++) {
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 25ddddb5d9f..4767eb4298f 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -255,7 +255,7 @@ static void q800_machine_init(MachineState *machine)
     int32_t initrd_size;
     uint8_t *prom;
     int i, checksum;
-    MacFbMode *macfb_mode;
+    const MacFbMode *macfb_mode;
     ram_addr_t ram_size = machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
-- 
2.52.0


