Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B7DC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXxw-0006FE-La; Fri, 23 Feb 2024 11:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXj4-0005dg-5l; Fri, 23 Feb 2024 10:44:38 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXj2-0006N8-JL; Fri, 23 Feb 2024 10:44:37 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so7524335ad.3; 
 Fri, 23 Feb 2024 07:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703074; x=1709307874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDOAPyy/p7ldU2KSryWFNhizVqq3Tur5f2N+VyCj+Jk=;
 b=FoSN7PxMMm0JrSCJCjugDHdr6AJsZxrBxCJgA40zr6ZXPiACvkYNWhFgDF8htUBvDs
 fRpcbLHwdMl95bnG2PObSw/+6KkjDeOH+Xfu4xRx+qzcLJ8qwF634f6z/6PxNPklotms
 wSVwouwCNy3PJs8/yscw5xiZHXvrLaeHBzY2YDUHc06T4jjoEScLQd1RPlNqJiDgUIAU
 7vKCQ2RZUc5/+YSxIXkG1pu7JN5oXavIpdTNRrX1SPLEdnfPt2qZ9NLklCKKVDxpEGDO
 B4dgB95FED1BSaw2ZG1visSmlJjjzxeTfma06IWSbjNNgJ3veJKhwlWL8NPPkGgf2w+t
 NVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703074; x=1709307874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDOAPyy/p7ldU2KSryWFNhizVqq3Tur5f2N+VyCj+Jk=;
 b=kZCxVLzgAoL1PpVxWcxOkW3syUsdnG5zE23Hq2fcGjTIyWMdfVkBkb/4pHqkCl/Fm6
 1d3GiJ2pw9ygb8Yc1y4EcFTYHsCV7nNHW3Byd/Y8sxhGZx0DP/FW4J7vyNQW+NM7BdYh
 bgtqLql0ddf5mq89Vj5VRr3fghpW/hnV9As4hKpl92wPRKvGRMi79+FtoDTpAqyisYBq
 7z6jpuvteMohwuQ+q+noooIIi2b0X0mzHbr2p0w/aJPfSbtQ5P1KGPppDPclbE+K/Rdt
 Gg6kYVfJVRC24yPaL6bJDU/WEou5BXN1QRM5ZjbGgPSuECGQsdd0Nga7/E4Kzg+K+/VH
 yGag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkBvzRCYDZBdy24ge0Xni4yMkTc6NxUtxOp+uoxt9N4+cOE3QW5lAnydqQ/E4OhYIXZZ1E/vLe42bj9Z1oSxGL0Zsd
X-Gm-Message-State: AOJu0YyG19pq9KU47GMFb+OjcJltZDzTGjlFZJVu8C7E3tAdBdYRyUl6
 4/+l6HUQ3Qbp58ZW0hr0FxdDppk+DTsovwmASvkH9QY+uWeXah+Jys6iPyWV
X-Google-Smtp-Source: AGHT+IG81SzWllCPIziRfBtbHLRQnW2yDKp3+EZJHsluMj3Ho6gcYqIhXI0dgBBsAYeysY0NkMv0kg==
X-Received: by 2002:a17:903:1206:b0:1dc:4bc0:6996 with SMTP id
 l6-20020a170903120600b001dc4bc06996mr246576plh.2.1708703074505; 
 Fri, 23 Feb 2024 07:44:34 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 21/47] misc/pca9552: Fix inverted input status
Date: Sat, 24 Feb 2024 01:41:40 +1000
Message-ID: <20240223154211.1001692-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

The pca9552 INPUT0 and INPUT1 registers are supposed to
hold the logical values of the LED pins.  A logical 0
should be seen in the INPUT0/1 registers for a pin when
its corresponding LSn bits are set to 0, which is also
the state needed for turning on an LED in a typical
usage scenario.  Existing code was doing the opposite
and setting INPUT0/1 bit to a 1 when the LSn bit was
set to 0, so this commit fixes that.

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/misc/pca9552.c          | 18 +++++++++++++-----
 tests/qtest/pca9552-test.c |  6 +++---
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 72b653463f..f00a149d61 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -36,7 +36,10 @@ typedef struct PCA955xClass PCA955xClass;
 
 DECLARE_CLASS_CHECKERS(PCA955xClass, PCA955X,
                        TYPE_PCA955X)
-
+/*
+ * Note:  The LED_ON and LED_OFF configuration values for the PCA955X
+ *        chips are the reverse of the PCA953X family of chips.
+ */
 #define PCA9552_LED_ON   0x0
 #define PCA9552_LED_OFF  0x1
 #define PCA9552_LED_PWM0 0x2
@@ -112,13 +115,18 @@ static void pca955x_update_pin_input(PCA955xState *s)
 
         switch (config) {
         case PCA9552_LED_ON:
-            qemu_set_irq(s->gpio[i], 1);
-            s->regs[input_reg] |= 1 << input_shift;
-            break;
-        case PCA9552_LED_OFF:
+            /* Pin is set to 0V to turn on LED */
             qemu_set_irq(s->gpio[i], 0);
             s->regs[input_reg] &= ~(1 << input_shift);
             break;
+        case PCA9552_LED_OFF:
+            /*
+             * Pin is set to Hi-Z to turn off LED and
+             * pullup sets it to a logical 1.
+             */
+            qemu_set_irq(s->gpio[i], 1);
+            s->regs[input_reg] |= 1 << input_shift;
+            break;
         case PCA9552_LED_PWM0:
         case PCA9552_LED_PWM1:
             /* TODO */
diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
index d80ed93cd3..ccca2b3d91 100644
--- a/tests/qtest/pca9552-test.c
+++ b/tests/qtest/pca9552-test.c
@@ -60,7 +60,7 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(value, ==, 0x55);
 
     value = i2c_get8(i2cdev, PCA9552_INPUT0);
-    g_assert_cmphex(value, ==, 0x0);
+    g_assert_cmphex(value, ==, 0xFF);
 
     pca9552_init(i2cdev);
 
@@ -68,13 +68,13 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(value, ==, 0x54);
 
     value = i2c_get8(i2cdev, PCA9552_INPUT0);
-    g_assert_cmphex(value, ==, 0x01);
+    g_assert_cmphex(value, ==, 0xFE);
 
     value = i2c_get8(i2cdev, PCA9552_LS3);
     g_assert_cmphex(value, ==, 0x54);
 
     value = i2c_get8(i2cdev, PCA9552_INPUT1);
-    g_assert_cmphex(value, ==, 0x10);
+    g_assert_cmphex(value, ==, 0xEF);
 }
 
 static void pca9552_register_nodes(void)
-- 
2.42.0


