Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42612C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPrwg-0007qo-RU; Thu, 12 Jun 2025 20:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3EGtLaAcKCl0FJHGJ8DBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--komlodi.bounces.google.com>)
 id 1uPruU-0005sy-FR
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:47 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3EGtLaAcKCl0FJHGJ8DBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--komlodi.bounces.google.com>)
 id 1uPruM-0000bH-Av
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:36 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-235e3f93687so18896045ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773072; x=1750377872; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=OIZH2xkbqf0VU2m6tXJnpYTNb7RaFWBkaYVW+cq3n6g=;
 b=dnxTVhVntuJWK4JAjyE85IQnDZEheEM52MWq6HCHqtT5oGTzV+YnAp3x1zn41P1crR
 idptzk+YaPi2j1kJwvLm4+45lkJCIHUhd9xlGjFVK4qjwSlhgMQyS5i/7svDKUhj3oJj
 jXUPgLk/3k/Fo9e6F4BqnUnrcNRdcz8TjJlz2eGPcEWDXgteR8sAoUErl/tHcCKOql07
 Lwj5e8JZxEbzw+TAUPRJCQDfUiyIcDJlcaWmhhbx+OcEb7V4UUqSxc8+B9ceIg8i1Jfo
 /xmOVAOFBMh+a27uc+wvoVugFjv8pTrfQ8qt/ljuA2bARIFHYdusVXR60lOvN92wucSb
 gkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773072; x=1750377872;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OIZH2xkbqf0VU2m6tXJnpYTNb7RaFWBkaYVW+cq3n6g=;
 b=TCBefP1QAWoKcAjyJjytlhQ7p1vicoAFqdHgwXXHqLNx0tdIKu/JDypfnrzr3QAqJT
 dJa+8t5V73UYlrcIVPt+3C1EUqad3C3aFqX5oCvxUq8fE9YKO3oiHTgEGbGOsOaLqVTH
 o6ZYypjn964R3EAKRV6U3ajYVpw48H0IKq8wlH278EjUWhk7FSBhUF43RAH3W4Paoksk
 tzEJPnER3jJCR+YUQsw6Q2GjfSA+oHo1I9kQRU7JggrD6BldtIG4nZH3owuc9reyLrD2
 q0CRhBRh7UcolFeo/Mo9UN0A3ns/K+0lz4qnIggpWbsR6PpX7dEFzrzinVntrLaMz5Kl
 YrrQ==
X-Gm-Message-State: AOJu0YyzbCzA+U6H4bhoV3Ns9qAEPeA0NsccQ+zn64drfTUV3n40YwB3
 /OCcQLAH4VSa06qUzaXrmD/THcFU6YxWSlCiBIzuFghQFNocPMQ8TucLGWHBOi08DgAklkxAwa3
 nx20fJnTLHCknakUI6my6O7JxNoEQtRyfeqye2SSh81LQ6fiZ0EY+WaV+BWvrjZhutp2q/kcr1R
 Do/P3Cw8hK1WY05VqAopTKkNjDPo8To0WLRkKasNMO
X-Google-Smtp-Source: AGHT+IEP1W9AelPzz3ZYsYe3gktWUdq580jYTbGroEtbfPQaUTVZGezYF+TuAf0CxnnchkAj23SD6RuUZ5ak
X-Received: from pge22.prod.google.com ([2002:a05:6a02:2d16:b0:b2f:795e:379a])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:be03:b0:235:27b6:a891
 with SMTP id d9443c01a7336-2365da079a2mr10352165ad.28.1749773072319; Thu, 12
 Jun 2025 17:04:32 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:04:06 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-15-komlodi@google.com>
Subject: [PATCH 14/19] hw/i3c/dw-i3c: Add ctrl MMIO handling
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3EGtLaAcKCl0FJHGJ8DBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--komlodi.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Adds functionality to the CTRL register.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Titus Rwantare <titusr@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
---
 hw/i3c/dw-i3c.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index c5af331ac4..61845c909f 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -361,6 +361,8 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] = {
     [R_SLAVE_CONFIG]                = 0xffffffff,
 };
 
+static void dw_i3c_cmd_queue_execute(DWI3C *s);
+
 static inline bool dw_i3c_has_hdr_ts(DWI3C *s)
 {
     return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_TS);
@@ -520,6 +522,36 @@ static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uint8_t *data,
     return ret;
 }
 
+static void dw_i3c_ctrl_w(DWI3C *s, uint32_t val)
+{
+    /*
+     * If the user is setting I3C_RESUME, the controller was halted.
+     * Try and resume execution and leave the bit cleared.
+     */
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_RESUME)) {
+        dw_i3c_cmd_queue_execute(s);
+        val = FIELD_DP32(val, DEVICE_CTRL, I3C_RESUME, 0);
+    }
+    /*
+     * I3C_ABORT being set sends an I3C STOP. It's cleared when the STOP is
+     * sent.
+     */
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_ABORT)) {
+        dw_i3c_end_transfer(s, /*is_i2c=*/true);
+        dw_i3c_end_transfer(s, /*is_i2c=*/false);
+        val = FIELD_DP32(val, DEVICE_CTRL, I3C_ABORT, 0);
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ABORT, 1);
+        dw_i3c_update_irq(s);
+    }
+    /* Update present state. */
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                     DW_I3C_TRANSFER_STATE_IDLE);
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
+                     DW_I3C_TRANSFER_STATUS_IDLE);
+
+    s->regs[R_DEVICE_CTRL] = val;
+}
+
 static inline bool dw_i3c_target_is_i2c(DWI3C *s, uint16_t offset)
 {
     /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array. */
@@ -1592,6 +1624,9 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
                       "] = 0x%08" PRIx64 "\n",
                       __func__, offset, value);
         break;
+    case R_DEVICE_CTRL:
+        dw_i3c_ctrl_w(s, val32);
+        break;
     case R_RX_TX_DATA_PORT:
         dw_i3c_push_tx(s, val32);
         break;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


