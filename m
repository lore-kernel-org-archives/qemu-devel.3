Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464FEC5B542
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 18:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJcDd-0003H1-9F; Mon, 26 May 2025 14:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcDF-00036e-Eg
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:06:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcDD-0004pq-I6
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:06:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so33095665e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748282770; x=1748887570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PK/3BMMw+rPIcEuLbLBqAtKj1UfFQt8uO08FuIUDDYU=;
 b=WX5uySL2yP1hyPrlTDYUz2KpXgw21GQ4jBsaaxabLmSsZOvAFzqNZvL9AemyKnuiIg
 rLrR39zpaFma5+pq93atf6qZPOTc4G/5hSm2LqW9timAoZ2WBPafNz12w20/i4QGJeg1
 LWLNyPBnFfPtHoM6h+vo2GsMLDffqho3Qj5Tbe79tIeK9PWB/BIw0dK40YDirhs4WBOu
 DiicblP6t0h+1DxGyWOVBr7TTPU9gZFVohO2Huv5sqrgCn9KHDcYIxGd0rX8/9AVBPAV
 Ldc+ioinmZ4IMrA5XXHX7fLbWGebH3+wY6O9M9kPJEJ4VK5Z2i3uI8pvouPicEHOaO3V
 NJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748282770; x=1748887570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PK/3BMMw+rPIcEuLbLBqAtKj1UfFQt8uO08FuIUDDYU=;
 b=aBZWL1GkGr3VD/4IbrMCCIn1iVv57ev7RQ9HlmekAgk9cse7FW4fw4x3GXC7H2X+xt
 C/Ys7UxBgS1HmAqt3shZLYJMn8XphIphWSnYFEyeyoQdJxo2XRliyvcHfUaUYSUg27CW
 k9sAYQJnluRfaExSOlJVMBkwX1NC0LhpxZXQJTRgVNdAYSHNCbcLF0TDN6sNmee7ijEt
 +6c3B8YlP8WHIWHi1UCVxI6tcSqKhohnHuSTDnErqEujYOQ0IzaOlYJ7BCiAYfnXzHlB
 uaFPeWF0EcttzMy56e1ISfHbwN09cZ5N4hoFJcCGLB/OHZV6WBmGB92CP3q5g2uEUabA
 N2FA==
X-Gm-Message-State: AOJu0Yy17OSIbQq1UXB/7zqH0Y6W76c50DPho4HelDSeWgqMFSGHnx6x
 Eej2sr0m4MM8g8qfmpNXX6Y6CopjLLHOm1f7rnKKaUoxFqi1ncdEWje4shi5Vkl1XRXgqGpAVYM
 UzgHwdxQ=
X-Gm-Gg: ASbGnctdJhd0zv67JQ+2WPkWFnLRo8jwTVEEFF+Fy3EqhF0Rj9JL+O7iSbKoFOFISf5
 XyrnIxaX+/9zDGa51KIZjbXLXBCMcyjFhmqw5KsXkCa7sNNwWTYeylDhFdFn09EY4WOAUO90CiZ
 xnJwadgYiLGuOBOs+U2eRM6W7WulZ61h5R73IHGOF/6cy8obt+EfjBRYjC0aYJXSmdMhpGeFBMM
 z5xD1DCG5mAuQKMjyiSArxkoVcjBfuiOTsnuX89wCAG5irPyaDIey1fIPIvhhYxXp5QchMmkfFN
 23jY6MfHcbszcLDTUjbS/AQiWeD5KI4xYjlNy46Risms5Xz2Ygy0aM1YHXLcgI8jFgEQcHSKIeL
 XvBPWe93zHAA1QDeIWkjk5aJs1RGGZWc=
X-Google-Smtp-Source: AGHT+IEct3U0VqUxCmKQNa7qLZzBiVK1+v0jtdEL0TFxPrlTrutfbCQicw8/ql0Dt31GE8hxRz2aig==
X-Received: by 2002:a05:600c:4fd6:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-44c91bce747mr94158155e9.0.1748282769815; 
 Mon, 26 May 2025 11:06:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4dc1172ecsm2684499f8f.48.2025.05.26.11.06.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 11:06:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/2] hw/ide/ahci: Delay a bit before completing reset
Date: Mon, 26 May 2025 20:05:58 +0200
Message-ID: <20250526180558.65613-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250526180558.65613-1-philmd@linaro.org>
References: <20250526180558.65613-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Give few milliseconds to (emulated) hardware to complete
its reset sequence.

The intent is to have this model better match hardware,
reducing firmware bugs "works in QEMU but not in real
world" such https://github.com/FlyGoat/csmwrap/issues/14.

Reported-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/ahci.h   |  1 +
 hw/ide/ahci.c           | 39 +++++++++++++++++++++++++++++++++++++--
 tests/qtest/ahci-test.c |  4 ++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index cd07b87811b..82617835195 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -46,6 +46,7 @@ typedef struct AHCIState {
     uint32_t ports;
     qemu_irq irq;
     AddressSpace *as;
+    QEMUTimer *reset_timer;
 } AHCIState;
 
 
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 7e586c7a0a4..cf1c5d3f3db 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -28,6 +28,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "qemu/timer.h"
 #include "system/block-backend.h"
 #include "system/dma.h"
 #include "ahci-internal.h"
@@ -47,6 +48,7 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
 static void ahci_unmap_fis_address(AHCIDevice *ad);
 static void ahci_reset_delayed(AHCIState *s, bool immediate);
+static void ahci_reset_complete(void *opaque);
 
 static const char *AHCIHostReg_lookup[AHCI_HOST_REG__COUNT] = {
     [AHCI_HOST_REG_CAP]        = "CAP",
@@ -459,7 +461,7 @@ static void ahci_mem_write(void *opaque, hwaddr addr,
             break;
         case AHCI_HOST_REG_CTL: /* R/W */
             if (val & HOST_CTL_RESET) {
-                ahci_reset(s);
+                ahci_reset_delayed(s, true);
             } else {
                 s->control_regs.ghc = (val & 0x3) | HOST_CTL_AHCI_EN;
                 ahci_check_irq(s);
@@ -1591,6 +1593,7 @@ void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as)
     s->as = as;
     assert(s->ports > 0);
     s->dev = g_new0(AHCIDevice, s->ports);
+    s->reset_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, ahci_reset_complete, s);
     ahci_reg_init(s);
     irqs = qemu_allocate_irqs(ahci_irq_set, s, s->ports);
     for (i = 0; i < s->ports; i++) {
@@ -1622,8 +1625,12 @@ void ahci_uninit(AHCIState *s)
     }
 
     g_free(s->dev);
+
+    timer_free(s->reset_timer);
 }
 
+#define AHCI_RESET_DELAY_MS     69  /* Arbitrary value less than 500 ms */
+
 static void ahci_reset_complete(void *opaque)
 {
     AHCIState *s = opaque;
@@ -1667,7 +1674,11 @@ static void ahci_reset_delayed(AHCIState *s, bool immediate)
     }
 
     if (immediate) {
+        timer_del(s->reset_timer);
         ahci_reset_complete(s);
+    } else if (!timer_pending(s->reset_timer)) {
+        timer_mod(s->reset_timer,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + AHCI_RESET_DELAY_MS);
     }
 }
 
@@ -1676,6 +1687,24 @@ void ahci_reset(AHCIState *s)
     ahci_reset_delayed(s, false);
 }
 
+static bool ahci_timer_needed(void *opaque)
+{
+    AHCIState *s = opaque;
+
+    return timer_pending(s->reset_timer);
+}
+
+static const VMStateDescription vmstate_ahci_timer = {
+    .name = "ahci/reset_timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ahci_timer_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_TIMER_PTR(reset_timer, AHCIState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ncq_tfs = {
     .name = "ncq state",
     .version_id = 1,
@@ -1734,7 +1763,9 @@ static int ahci_state_post_load(void *opaque, int version_id)
         ad = &s->dev[i];
         pr = &ad->port_regs;
 
-        if (!(pr->cmd & PORT_CMD_START) && (pr->cmd & PORT_CMD_LIST_ON)) {
+        if (timer_pending(s->reset_timer)) {
+            /* Reset in progress */
+        } else if (!(pr->cmd & PORT_CMD_START) && (pr->cmd & PORT_CMD_LIST_ON)) {
             error_report("AHCI: DMA engine should be off, but status bit "
                          "indicates it is still running.");
             return -1;
@@ -1823,6 +1854,10 @@ const VMStateDescription vmstate_ahci = {
         VMSTATE_UINT32_EQUAL(ports, AHCIState, NULL),
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_ahci_timer,
+        NULL
+    }
 };
 
 void ahci_ide_create_devs(AHCIState *ahci, DriveInfo **hd)
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index e8aabfc13f5..4389aaa7f70 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -40,6 +40,8 @@
 #define TEST_IMAGE_SIZE_MB_LARGE (200 * 1024)
 #define TEST_IMAGE_SIZE_MB_SMALL 64
 
+#define AHCI_RESET_TIMEOUT_NS   (500 * 1000 * 1000)
+
 /*** Globals ***/
 static char *tmp_path;
 static char *debug_path;
@@ -483,6 +485,8 @@ static void ahci_test_hba_spec(AHCIQState *ahci)
 
     g_assert(ahci != NULL);
 
+    qtest_clock_step(ahci->parent->qts, AHCI_RESET_TIMEOUT_NS);
+
     /*
      * Note that the AHCI spec does expect the BIOS to set up a few things:
      * CAP.SSS    - Support for staggered spin-up            (t/f)
-- 
2.47.1


