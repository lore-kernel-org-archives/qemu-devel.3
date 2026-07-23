Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E57CC531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnRW-00024x-5c; Thu, 23 Jul 2026 03:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRJ-0001xX-ON
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRG-00043Q-RE
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so213356f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784790109; x=1785394909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WZjtpQtNSxI6AiGZFSXK11dMHv4Q6M+80pXz7HWALe0=;
 b=foXCs6cwsvFEae++j4ZYlOwpsOsdodec+pbAYn+DoSw3UgvCBHLu+ICAnnBJ1CNXDk
 Kre4YQMvr4nl2JqBhRGjvqsLZcsvnFdYDdx1wicSNEJsHN/GU7tPIo1pXZfI2X0kjXbg
 3+POApag7nOOkVa+xVUM2e+aolbnWM8sGPD5hvXY5dSrNgWhf6pypkz3Vgoy4F+WvwrC
 MgIOB2CI5z91Jl6y0AVV06aTdaSVinC9j1/cR4IHSsB7mUx3JmENrHocReQu/UsCo2VT
 2oZ1kQTxopJHr/L4GV0y9iHCBn/eMA9vVbtGT1o2cYepQFP1b0WQhD+iM/+GMFpp+hv2
 wNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790109; x=1785394909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WZjtpQtNSxI6AiGZFSXK11dMHv4Q6M+80pXz7HWALe0=;
 b=XW/0U1fBxvSI/boZPOJwx9BSjuAzyOGBURrNdyosmGY+G474E9cmiB2KAoahWFV5nA
 0Dv5lZqFX/StKc1V8ksb9re71eY/Wa5tmWoRXXxH9YD/fMXhxNi3GyunUqvUWQTkvG/n
 ZZ0zEN5X4Bpsq3GcYOcKawdDVHfCkUh/UgswpZtJVZqrYc5Ryj1mJvfr5MD6peqinJZO
 9hQeGFK+mlA9APiq4yeF9Cl3FNS0xm3r+0FyBZgmHwthA5ZgZbgdtLbKtpfabmKVX/MR
 e4zd7Ig2b+IhG2BdEzoT6MCykbgnHqxUJguMys1d6dSgOFISDebkZNVc3rgHg/xk4+hk
 MRdA==
X-Gm-Message-State: AOJu0YwSQ6l547JC7FZ4dle+pEaIwMACga1e1wQNZ3jIcIWEPc3N95C3
 zBMIhBWX6LymsjJPfz0v9dmLIh6ukRQaHTEi8B9YmpUyGNz2jn5gQht7M+Ip/q6s
X-Gm-Gg: AR+sD11uHXRZ5f3Q/0tTeS2SH/p/E+vgLmy3VTou08+qV4drUZFUs7RQO5T/m6n2Nxl
 aHkMpz/xcUxrk0e/E2PJvr6mFUnDITtqWF1DF7LkT083p7BkBEtmYpWRLKM85BUcOBsr2ob1TqI
 Pi37jiL0Xy5X4lqaYcdM+lHRdBiLSTcKIv+MHGn8jCA5EgZWrqapm3GRYHjFk//mP2OESsT38Cp
 Kds3eEYgoxQXW+aR13LkWRhj09szdXXrCix9+JuZ96HoPjG0VuRon9DmIc4KuJH+d9xUq4wIDkg
 pLAZ2Asi290KZhGKJWvTyFCicjXXjUC269jm0Gx2+vaM9EKtY5fHuLagQaci/oUjsnVR/4vqD4q
 e/ATyO2k+CUIegZSlOkdawUZ1Zny6RSsfPv6EcGIt6WFwKtiZQ8y3JvAjLdbs6DeF0SpCZpPatd
 x/rOJ+4pHG0f8Fa4lJ6Wq8I2bY1P5e/DL+dJrU7vLOQ9T6cj+vVE4hyq6Fx0npjTJ/D9FLRpvDt
 1LfwVI7d84MkHc/8gh0z95quJznso6jaPiU
X-Received: by 2002:a5d:5d0f:0:b0:47e:81aa:3822 with SMTP id
 ffacd0b85a97d-47f8d760694mr2025128f8f.42.1784790108950; 
 Thu, 23 Jul 2026 00:01:48 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-29ed-6000-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:29ed:6000:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm13293923f8f.33.2026.07.23.00.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:01:48 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 6/9] hw/net/can/flexcan: Fix mailbox reset mask initialization
Date: Thu, 23 Jul 2026 09:00:56 +0200
Message-ID: <20260723070059.6332-7-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723070059.6332-1-shentey@gmail.com>
References: <20260723070059.6332-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The mailbox reset mask initialized only the first word of the raw `mb[]`
array. Fix the initialization to cover the whole mailbox, as indicated
in the field description in the header. While at it, use the `mbs[]`
view instead in order to drop the redundant and oversized `mb[]` view in
the next commit.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/can/flexcan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 8d680f1832..f84f090a7f 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -134,7 +134,11 @@ static const FlexcanRegs flexcan_regs_reset_mask = {
     ._reserved2 = 0,
     .dbg1 = 0,
     .dbg2 = 0,
-    .mb = {0xFFFFFFFF},
+    .mbs = { [0 ... FLEXCAN_MAILBOX_COUNT - 1] = {
+        .can_ctrl = 0xFFFFFFFF,
+        .can_id = 0xFFFFFFFF,
+        .data = { 0xFFFFFFFF, 0xFFFFFFFF },
+    } },
     ._reserved4 = {0},
     .rximr = {0xFFFFFFFF},
     ._reserved5 = {0},
-- 
2.55.0


