Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE339E8383A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6Co-0001Zv-WD; Mon, 16 Feb 2026 16:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6Bz-0007tQ-WD
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:47 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6Bx-0003zH-9C
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:43 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso30672865e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771277499; x=1771882299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryaQ/AkO6jKX0PQ//vdGmEpeMhxdiou+ug6hLMUHQC8=;
 b=rg3pZiOk+YZKTiioXmikROsm1fdkwfEtkUYavO/Ygfq3gowsj/EJWcg5XoSyunk9+X
 +354Ix1IsP7phJ2ycpDxXfFJskP/+bX+z90i6RKDNF9AAV0kbRR0ZAYGlXwrqyRRsWHi
 bwyo3AKJYDyYAw/bxGPzFwOomqDWGfuPnOQxP+F/padpaxD4jKlLZU5eG36tWCjjp2XX
 f71gR8Z3oRyic2EPX7NnE2SptyPvGqx9wk2yKOtCukyszAAkdlVgMLY+tGhzzxRwUKMY
 vcV/eZyNla2L/hUufVJunmRLxJQhbY9m1H3+7FL9wCtmtcT1N0KGqSawPxsDLBo0p+F9
 AVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771277499; x=1771882299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ryaQ/AkO6jKX0PQ//vdGmEpeMhxdiou+ug6hLMUHQC8=;
 b=SmokBjxKvvI7wQ3ia3yPt5YcxU8GQYVhbk/ua90mOIATjUh3q2xYmEp+kQWIjAr5AE
 pwYduTcu73H47YFp28N/ZxVzSuqr6EH7Q3IYHMI1JkbSgefQGIORRvMVOHizYmK4dVg/
 mRu5Qac/edOii2tyY9dznYbtlJbFBGrPILRcIRvparDz8yRu19mtKUZE6xv5vdwt/c1r
 zeW/AnFNMp4V8j9zQrH0eQvakqOirL7lKz0iBglEUYkEGXPyWmPHZG576IYi4yc0y28+
 0knc3S/VCVWhuJ1dxZoYt27Z9hzB7a/vCJlEgfDlYZH2m9NCXRpdc0MmiLCFFCl9ttAW
 9Xog==
X-Gm-Message-State: AOJu0YyIRWwH1NM9FXUPMKNe9aiQJ8PTu48irYYHv4K3Wcs2OhDEsMze
 Odxxvp7fp71D5wa+EatPiYqLH6ROKaNQgGaGlad+bp32OvWUZFSJjOrj02l6IOxOPk+RKXJHpX6
 aMN+ekxE=
X-Gm-Gg: AZuq6aKxSkX/StN30e+ywqHbh/qv+TmOgD/gxdVgvhsYISVlTLrVR2TNhIE3ZVygDp2
 48+3uO/vxaVnsd9pMSTewpTCpc75/Xx3tr5bUW2uxyEI7gSZUM8Q8KD+S8B+rKasUPc+69vNODO
 OEKNmQfz/H+WTwGB7qfquBtgg959mym3XJEqyyP6VY7KC5pNTlt2PX6G/a9scLWbOHr6fB4ElBJ
 M2TBze+Ewdt9HiQPy4p3YDNpSxl1KqMTwufcsThrJsGaaNvtQ2gZKqbma0MlwBCN7SskD1ajFZB
 Mt+1wltXKQGghsyKeH7MeCBo1VXehVZYcIWTKU1yamV5i1gZkBRfzKQ3/18gHNWutw3FaLBEKvi
 g+ipfiGo0NQ+3CaoKxy/7IOXEaZmZioNXTskfaSElcrnrBbrpfQS30TX/PVRKZ0AhSZI+Id54Qk
 NqtiXQl5iMLMaZRaala5y5YfJvK/cGn5mtBDBgCfIg4BE2N56oUI3chdqz1MKnwnJqIwgiXg9c
X-Received: by 2002:a05:600c:8b84:b0:483:4bbc:89ea with SMTP id
 5b1f17b1804b1-48379c42db1mr156642235e9.37.1771277499064; 
 Mon, 16 Feb 2026 13:31:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a63afesm93274735e9.9.2026.02.16.13.31.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 13:31:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/8] hw/display/macfb: Constify macfb_mode_table[] array
Date: Mon, 16 Feb 2026 22:31:15 +0100
Message-ID: <20260216213121.47122-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216213121.47122-1-philmd@linaro.org>
References: <20260216213121.47122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


