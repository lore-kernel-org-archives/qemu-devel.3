Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE277EF99F1
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr59c-0003eq-46; Fri, 13 Feb 2026 21:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59Z-0003eB-Ul
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:01 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59Y-0004WH-H8
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:01 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso12335825e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771035178; x=1771639978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmUxv3UTE6ZdlIHSSW1HHJoRu03dAklDGcxZsp/sqZ4=;
 b=sCDmB2ZtC83l38Z/GIYPm6uldV+ni2oCbixbye9fC/oiGTDhsN2CEQ4UDl2YI82X36
 m7nI9kaFEzz7ZhhSoEyE9+CPBdqBzEvci7d/o+Y9NLf82mLOUaHNxQsArG9NUvQld5YO
 TpMWiQUomEqt7N4AkvdV+ZqEB87M2vM2G0DpvzjMb/Nu9jXPj1PNCg0Sf16ZBjCSbsnA
 lIW7GL1Lh6dUHShgAaLy/qd4rSsNo+tDmtrFjQVA0idBKP/1otKi0rnagkTr020kHGh3
 oKORZyG5r2ewEs/ZASCKnBr99qefyU+FjMYkQYrZmoiVIlo/QEhlzGWtTXd2FRkWo1RZ
 NM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771035178; x=1771639978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nmUxv3UTE6ZdlIHSSW1HHJoRu03dAklDGcxZsp/sqZ4=;
 b=Hce3cCYhws1yzZk1yO5vIkJccGQsEI/kZ+Nt0Al2EtAOqHcqXAZ9Lp5crjUBWOFDTr
 dD6tbbVc5rZv1m6HBgCrJIeXrFYJofgrGJ8DqsYG/L0l6qzBQJy2hifdDKj5s7nNguSk
 D8+CYUQ8tkCZQM2UXINnQdhNvHVn5epLzGsZnFASesSnEd4dT+APeQmzedXcM7GucHD/
 bx2X4kG7yncL/xr8z1FrWYoonTNhp6tDD725IenX2FUBscZxE0EwSKZvAg1Tp8GuoVlx
 yvdpuCkkkAQ3Fj1kFDttLUWyEQZhT8+O08Y+E9Oe+686pPN0LPXAJMJPHlOEzef5GIyF
 2Gng==
X-Gm-Message-State: AOJu0YwGdruQSXoIqc13Q47qTsdpinQXc7lA9gV1yfe5M4Uw7v+16Vbm
 SrChAeimM0yrYypHizi3WFVXLfOv5STllXydR8KlT/5v43uZ23tjUw+fPuDbLLcA01nAQXv0YvA
 aWMhGgtk=
X-Gm-Gg: AZuq6aJDZfEhmUEGJgxrSxLdZxvaLoChWi6CLd2J2EYyeWlTRSYyAuUT7eYWXnLacN+
 T0dcGTPCvdjPVN2pDLrvXZnfFMoymUQURu9pHaS7gdVepaFt9JujdcjQAo9U+k3FH4n8pI4hpQ4
 1X7Ya5zlwpxVw0I/Jmd+0btj1ouKXIQDN4nfxVnlPK/+xCCSrxO4S3fA5vF0AddgwzMdveudoku
 tnFx/IMHoVdTtv0cU96jIYCCIUotslHnHjj6bUNjJ6Wc40v34jqmTH/fQCQ021ot4EE0eu2nXkR
 ogJN7mGumPpm/IP99Sk5Ovo49ZDTvqoGho91BA0N9XNDe/QC1tHv1/OCIh0/VRRFhTXE4oQjKH7
 d27VfUmCB8Vs9BzggcCMdt/qEEED35xyPNrPwEs3eGo/TCuoYcb2YvBf7BEhcSAxaislNDM4n7p
 xgJR0Ea/thBKBSH0SwpBaG+2fWQmYGWTb523ubMmFUYd7+rfsGCmme1Wb5xV71SU5+5bxSlX9Xt
 Hmh+QP4dIM=
X-Received: by 2002:a05:600c:4443:b0:47e:e952:86c9 with SMTP id
 5b1f17b1804b1-48379b318bamr18979695e9.0.1771035178495; 
 Fri, 13 Feb 2026 18:12:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d482480sm328085395e9.0.2026.02.13.18.12.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 18:12:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] hw/display/macfb: Constify macfb_mode_table[] array
Date: Sat, 14 Feb 2026 03:12:33 +0100
Message-ID: <20260214021240.58657-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214021240.58657-1-philmd@linaro.org>
References: <20260214021240.58657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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


