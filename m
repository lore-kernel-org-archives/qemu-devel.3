Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55B5C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPruE-0005pL-VV; Thu, 12 Jun 2025 20:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3A2tLaAcKClA26436v0y66y3w.u648w4C-vwDw3565y5C.69y@flex--komlodi.bounces.google.com>)
 id 1uPruB-0005nm-It
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:23 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3A2tLaAcKClA26436v0y66y3w.u648w4C-vwDw3565y5C.69y@flex--komlodi.bounces.google.com>)
 id 1uPru9-0000Xc-Pl
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:23 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-af59547f55bso928302a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773060; x=1750377860; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tPtGaQ6vCtmF19bKh+Rkwj9EooYkX69QK4ltOQGJ2bM=;
 b=jyKoxpcuV5ZlR+dJ0mSSFxDw1N5UUhDmcRsJWyQXiTBjqZDNHzrFkHCizdowVgOOME
 CQAvcOFXt3LpeVnSvBjCCJXjQstRvy2+JQhNW0GzUh4LIbU21IKJyy584ijwr57R+rPF
 58dxrgMf2kupiBKQST9GLA/muZRG6y9oLIjamW/bxqgoZ+jfIbfiqjQLrqP33/5mj2JY
 kfNU/UzL3d1LSH13XDTxz3tK7ZP4cMtI4RE22fFt4Dy4HGPXj/LFcK1KJo12aXXcQbac
 YWE+Th8aMs+Zthb5iOG8S1vqvM1lbSunTxOJE5sedcEWKvQ/ZHmLJLLYIERtDeAbHKKq
 PBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773060; x=1750377860;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tPtGaQ6vCtmF19bKh+Rkwj9EooYkX69QK4ltOQGJ2bM=;
 b=gYrSF+iK/Nii3YCXYXpMjr8EpoRyB8PpdGoZf+Rq7DMUkny8NTxX5esVFYJly3IiPd
 lP+GI0w7jTy40zipPCBwK/dcIBI/aIdXOYnUzrEzSY7ngkbkhijsra5pDivqQsHqVbkh
 A8aqSfxTJpfrjFETCC0/xhBKm1bOSgxSpRhgYZufEGasE8ui4hF3SOCyJPkGANbJeDRL
 PuNtEWrpiXaxXPnXsbUfPPzU0yA5X3el2oq9HsRdhJPtpcELjGDYR+xccgb8bGHEE++W
 /Bgpp+Zgr6zLSUon+R3ZAG+51vE99EJsFNeXln8zc5uuB8aQj5MFzWpdDgmtuuZL5J2J
 /l0Q==
X-Gm-Message-State: AOJu0YzdL74LummLXodtDygn/BxjiQIe+RuNRjoLpv61hLYi2GraVy5y
 WZWsSj3bJ7Hc8wzATP7KgyrhVD4n40n5RWpXDd9t/4gwbQ4qr+4mtsEYpDxPztYD8tKh5lhJrar
 IgX9ZGcB55ZM68nshjhEreFICm1bB0LuXYhzoQLN2JOfyqncrBjiKb1CR6w42QZDTzytzRAjTHk
 hXKE3HxX++8fJb1DU3CZPwMg8N3vzOt2aeMqWfXznm
X-Google-Smtp-Source: AGHT+IE+wKtidJQQHaeAv26xb51vHC11aupnISz/rbqHPp8ZlgD6ID3Yf9t5RGWbCHWE8prPxAbGShLFDUqn
X-Received: from pgbdi9.prod.google.com ([2002:a05:6a02:c09:b0:b2c:3afe:6ece])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:914f:b0:1f3:41d5:65f6
 with SMTP id adf61e73a8af0-21faced23acmr1337373637.32.1749773059627; Thu, 12
 Jun 2025 17:04:19 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:03:57 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-6-komlodi@google.com>
Subject: [PATCH 05/19] hw/i3c/aspeed_i3c: Add more register fields
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3A2tLaAcKClA26436v0y66y3w.u648w4C-vwDw3565y5C.69y@flex--komlodi.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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

Adds the rest of the Aspeed I3C controller register fields.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
---
 hw/i3c/aspeed_i3c.c | 54 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
index cb0332828c..7a16dfec53 100644
--- a/hw/i3c/aspeed_i3c.c
+++ b/hw/i3c/aspeed_i3c.c
@@ -21,28 +21,58 @@
 /* I3C Controller Registers */
 REG32(I3C1_REG0, 0x10)
 REG32(I3C1_REG1, 0x14)
-    FIELD(I3C1_REG1, I2C_MODE,  0,  1)
-    FIELD(I3C1_REG1, SA_EN,     15, 1)
+    FIELD(I3C1_REG1, I2C_MODE,      0,  1)
+    FIELD(I3C1_REG1, SLV_TEST_MODE, 1,  1)
+    FIELD(I3C1_REG1, ACT_MODE,      2,  2)
+    FIELD(I3C1_REG1, PENDING_INT,   4,  4)
+    FIELD(I3C1_REG1, SA,            8,  7)
+    FIELD(I3C1_REG1, SA_EN,         15, 1)
+    FIELD(I3C1_REG1, INST_ID,       16, 4)
 REG32(I3C2_REG0, 0x20)
 REG32(I3C2_REG1, 0x24)
-    FIELD(I3C2_REG1, I2C_MODE,  0,  1)
-    FIELD(I3C2_REG1, SA_EN,     15, 1)
+    FIELD(I3C2_REG1, I2C_MODE,      0,  1)
+    FIELD(I3C2_REG1, SLV_TEST_MODE, 1,  1)
+    FIELD(I3C2_REG1, ACT_MODE,      2,  2)
+    FIELD(I3C2_REG1, PENDING_INT,   4,  4)
+    FIELD(I3C2_REG1, SA,            8,  7)
+    FIELD(I3C2_REG1, SA_EN,         15, 1)
+    FIELD(I3C2_REG1, INST_ID,       16, 4)
 REG32(I3C3_REG0, 0x30)
 REG32(I3C3_REG1, 0x34)
-    FIELD(I3C3_REG1, I2C_MODE,  0,  1)
-    FIELD(I3C3_REG1, SA_EN,     15, 1)
+    FIELD(I3C3_REG1, I2C_MODE,      0,  1)
+    FIELD(I3C3_REG1, SLV_TEST_MODE, 1,  1)
+    FIELD(I3C3_REG1, ACT_MODE,      2,  2)
+    FIELD(I3C3_REG1, PENDING_INT,   4,  4)
+    FIELD(I3C3_REG1, SA,            8,  7)
+    FIELD(I3C3_REG1, SA_EN,         15, 1)
+    FIELD(I3C3_REG1, INST_ID,       16, 4)
 REG32(I3C4_REG0, 0x40)
 REG32(I3C4_REG1, 0x44)
-    FIELD(I3C4_REG1, I2C_MODE,  0,  1)
-    FIELD(I3C4_REG1, SA_EN,     15, 1)
+    FIELD(I3C4_REG1, I2C_MODE,      0,  1)
+    FIELD(I3C4_REG1, SLV_TEST_MODE, 1,  1)
+    FIELD(I3C4_REG1, ACT_MODE,      2,  2)
+    FIELD(I3C4_REG1, PENDING_INT,   4,  4)
+    FIELD(I3C4_REG1, SA,            8,  7)
+    FIELD(I3C4_REG1, SA_EN,         15, 1)
+    FIELD(I3C4_REG1, INST_ID,       16, 4)
 REG32(I3C5_REG0, 0x50)
 REG32(I3C5_REG1, 0x54)
-    FIELD(I3C5_REG1, I2C_MODE,  0,  1)
-    FIELD(I3C5_REG1, SA_EN,     15, 1)
+    FIELD(I3C5_REG1, I2C_MODE,      0,  1)
+    FIELD(I3C5_REG1, SLV_TEST_MODE, 1,  1)
+    FIELD(I3C5_REG1, ACT_MODE,      2,  2)
+    FIELD(I3C5_REG1, PENDING_INT,   4,  4)
+    FIELD(I3C5_REG1, SA,            8,  7)
+    FIELD(I3C5_REG1, SA_EN,         15, 1)
+    FIELD(I3C5_REG1, INST_ID,       16, 4)
 REG32(I3C6_REG0, 0x60)
 REG32(I3C6_REG1, 0x64)
-    FIELD(I3C6_REG1, I2C_MODE,  0,  1)
-    FIELD(I3C6_REG1, SA_EN,     15, 1)
+    FIELD(I3C6_REG1, I2C_MODE,      0,  1)
+    FIELD(I3C6_REG1, SLV_TEST_MODE, 1,  1)
+    FIELD(I3C6_REG1, ACT_MODE,      2,  2)
+    FIELD(I3C6_REG1, PENDING_INT,   4,  4)
+    FIELD(I3C6_REG1, SA,            8,  7)
+    FIELD(I3C6_REG1, SA_EN,         15, 1)
+    FIELD(I3C6_REG1, INST_ID,       16, 4)
 
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int size)
 {
-- 
2.50.0.rc1.591.g9c95f17f64-goog


