Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EB2C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPrwB-00074P-Og; Thu, 12 Jun 2025 20:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3C2tLaAcKClgAECBE386EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--komlodi.bounces.google.com>)
 id 1uPruL-0005rd-AE
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:33 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3C2tLaAcKClgAECBE386EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--komlodi.bounces.google.com>)
 id 1uPruI-0000aN-FN
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:32 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b26e73d375aso1444108a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773068; x=1750377868; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=IFNo7OhYkVhWHM6SQDIAUQfEPwpaNIWcaew9uihGsFg=;
 b=xYzK8/eRnulGq8Vq4ieSqByHu+l2ILJYN4o7sMHTU7o40s9CfRyutMvh4CvmwSHjbE
 twqWoIHbMNsvFFMPVaKYdTVqY6Fr3Yer8pn72dGogV48W80+lCzFwxZNxtZYDmXlJNzU
 /S0NltdyQi3+9tck/Yl3SRqaGhdeRpJ+hxkR75FlMZxBh1abziQ+v3QBqugtPCbS5J3e
 2pJ4Z7wNGBhNqt+dCdCfpcRNjD0jqQ1XbY8Zl8y9TmsB0B6FOhO8iKXT+eHesc6ZHRx7
 SxSroErzWQ20l/HkPot6fAqJ1nJDje0lhFZoe+ZXKG9gsfTP2QEQ1qaWNBkatdUi4InX
 xuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773068; x=1750377868;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IFNo7OhYkVhWHM6SQDIAUQfEPwpaNIWcaew9uihGsFg=;
 b=Nn6s/GHP8lB5Tq6Y/+Y7qTFvOCObq5pxk6Wmj22UYQO7FHajuYl18fDjonZcgPs3x6
 Yd9DBadieqsnWnaGnAhc/auU4djgxC9YHEB0b38L8LIfF1w5AGREV2Yw6JMdB/fF+xYp
 oIXAO80euQ/AW0cpiU6U73R3Z2Eyfr+Ist9u6m00uj0RUhuHckDSssae5H78Mfd42/TN
 h3UjIK9eXUV6bunwK7NlzeTYhGqhXkfl7PjRVm6NOTEngpaGxo41Lt99M1YHaB2YRb6k
 5qYl5/wxAhC8bQoUO7mmjPP/dja3b0IlGfL1vGGwmtkl4OE8OTuGLDNUkpkw/Lya9QGP
 J2/g==
X-Gm-Message-State: AOJu0Yx/PPXL8bxSKRtsrnWWgxR5lieQAM4AyJaXB+rUm7c6w57JG3ql
 zb/nHWCxwEzq/QkELHEO3SAyVxpUmv+2+/V352aSO3C+JM3RfIewT58cWO6TcG480KNLhzstbVK
 s6CWIwN4D/HftftiPrOcE0q4m4eC8Tv2rus98oAyQ5S51VGtJPovj/ISyTXxkOJmmFdIYJS7Qx6
 Kd6/AU2HHkx6XYbi61o5rTpMLWLq2YsgnaVwoTGunF
X-Google-Smtp-Source: AGHT+IEoz+VmcVEpV6XfckGFBq9gJ+0WJ/H0fJ8JLXUKl/XSuEpQmGHbDJxSCtjPcapQdpVit1pneTX/4VkX
X-Received: from pgbda8.prod.google.com ([2002:a05:6a02:2388:b0:b2c:4d7e:b626])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3994:b0:20b:a75e:fa32
 with SMTP id adf61e73a8af0-21facf126aamr1382432637.40.1749773067968; Thu, 12
 Jun 2025 17:04:27 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:04:03 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-12-komlodi@google.com>
Subject: [PATCH 11/19] hw/i3c/dw-i3c: Add IRQ MMIO behavior
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3C2tLaAcKClgAECBE386EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--komlodi.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
---
 hw/i3c/dw-i3c.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index ecd79aba8c..c58e12964c 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "hw/irq.h"
 
 REG32(DEVICE_CTRL,                  0x00)
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)
@@ -352,6 +353,46 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] = {
     [R_SLAVE_CONFIG]                = 0xffffffff,
 };
 
+static void dw_i3c_update_irq(DWI3C *s)
+{
+    bool level = !!(s->regs[R_INTR_SIGNAL_EN] & s->regs[R_INTR_STATUS]);
+    qemu_set_irq(s->irq, level);
+}
+
+static uint32_t dw_i3c_intr_status_r(DWI3C *s)
+{
+    /* Only return the status whose corresponding EN bits are set. */
+    return s->regs[R_INTR_STATUS] & s->regs[R_INTR_STATUS_EN];
+}
+
+static void dw_i3c_intr_status_w(DWI3C *s, uint32_t val)
+{
+    /* INTR_STATUS[13:5] is w1c, other bits are RO. */
+    val &= 0x3fe0;
+    s->regs[R_INTR_STATUS] &= ~val;
+
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_intr_status_en_w(DWI3C *s, uint32_t val)
+{
+    s->regs[R_INTR_STATUS_EN] = val;
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_intr_signal_en_w(DWI3C *s, uint32_t val)
+{
+    s->regs[R_INTR_SIGNAL_EN] = val;
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val)
+{
+    /* INTR_FORCE is WO, just set the corresponding INTR_STATUS bits. */
+    s->regs[R_INTR_STATUS] = val;
+    dw_i3c_update_irq(s);
+}
+
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
 {
     DWI3C *s = DW_I3C(opaque);
@@ -365,6 +406,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
     case R_INTR_FORCE:
         value = 0;
         break;
+    case R_INTR_STATUS:
+        value = dw_i3c_intr_status_r(s);
+        break;
     default:
         value = s->regs[addr];
         break;
@@ -409,6 +453,18 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
         break;
     case R_RESET_CTRL:
         break;
+    case R_INTR_STATUS:
+        dw_i3c_intr_status_w(s, val32);
+        break;
+    case R_INTR_STATUS_EN:
+        dw_i3c_intr_status_en_w(s, val32);
+        break;
+    case R_INTR_SIGNAL_EN:
+        dw_i3c_intr_signal_en_w(s, val32);
+        break;
+    case R_INTR_FORCE:
+        dw_i3c_intr_force_w(s, val32);
+        break;
     default:
         s->regs[addr] = val32;
         break;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


