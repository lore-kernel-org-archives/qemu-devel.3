Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C071FC5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGPX-0002T7-Ht; Tue, 04 Aug 2026 10:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huang.botsz@gmail.com>)
 id 1wrGPQ-0002Rm-6y
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 10:46:25 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <huang.botsz@gmail.com>)
 id 1wrGPN-00013Z-EV
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 10:46:23 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so589617a91.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785854777; x=1786459577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CSa5gtZjReAy+ibyYVDzpszBYSW7M8VPvzqtePKDMK8=;
 b=M5eU3tydIEteeYCtiY/u8UDe39/Y6fZb92YdpZTCVMXCc7QJBqSiNl4a2uM9cb4lS8
 L9jvjSV62MOi5njKsx+ybSCoP9+CihBqg3LEPXlqg679ZB+06pAsbZK6pXkA5CqIP1u5
 ZkMaNic5JzF+TfDYJQlUzJWjxFJ5qDyuNTEzQRAKie5Yfkm7jpi8xp786l74kOdxJYfN
 hrLD0qD2vYOAyI6z+4Kjqg2GbkkQ59WPD7U3dTcqG7/nGks5Z9NUz2oVnq+MsB3MwAx/
 2sQHTf9WvryyabYIU1vdAYVjz+lNQNeFShXMHPvUErQ8sTPjGAbVdjX8xB+5LgeUTK+i
 0uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785854777; x=1786459577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CSa5gtZjReAy+ibyYVDzpszBYSW7M8VPvzqtePKDMK8=;
 b=OsjyP+iaxAFhtkygHbfVOQdFRC6Z86GuY2SzMqeq3XK1mu5+aV+RXYpPxB700Ka9gw
 a8RqY8LOMjPxnRe3qv06L3Soh9iwlsYMjRgdQzO4kQJi0pGgH4njfeASXiQq495GY04T
 DAJ7LKYQh9V2fpG8mgykRYIghTBus31NlNwiSqHlTDfBZJ7omJW8w6xsp6JL2wVL/j0G
 1swFXGSWycGnvxnLmhonq2jdkqptRRw608K+a1C11YmFzUmTmXTk5/dplFs5xMlUYF15
 Q7Q1SAXdTsWzvZWaK7m9EgmQ/1LUKz++YK0Rrh+2uvWKhxbrbAtoBnYp75rAE+jmNAst
 C1RQ==
X-Gm-Message-State: AOJu0YyeuSzwDNAKsPOLxmDDa1CTr1NGck9qfMz0iqmoKuaeI9vy35Ds
 GXImhaKVTKTebS40z2ziGaUcWHN3KJhT+Kw7yBJbQIi0dhxiQjBz6BTXmXMx9w==
X-Gm-Gg: AR+sD114r2floZTxwWyLzWpKv64Ps3m75/QDQ3HKsygsNnQsq8IScTCwtavJBYMHBRl
 LQ6YUqGAo0hk4xiEXCFNcnySfoB8Lt7h+qGyiT3aP9PAGnrlV8yVn9kBqLiu+TlnOlS1zq7W5WU
 QGwU1kuYaD24wQI/2Lm79n42Bi96/XQuj01S2U0pM6hstmg8338397pMZCfB9u5G/OJWwOfN7i3
 e2N88dWyDjSpd93x6wjLNux871vjgiPQ+BFk8LTjnTtKwsFImZq+bngi5bGDlTszY+f98rEM9mE
 pM/ci0fYVdfF15CBCVDBrkPsGF9voR+ThjENj5P+fBNubOK/CAlv4E12E8owv8Q5vZLnUr8/hJR
 rrnNIe5PM7v3yFEaS45cO5HZjnqCPPXeFewvFkgYNmf7lK+gOARQNiEm8upOrKI7HO2Db6a8+Uh
 7pC+FFoOWY2Xja9jOE73R2LXNb3VioFjm7XFpKTlp2ajscs3cfpuIHXQoZajAqjGev/60t+ymKe
 u9xAfAeOdQ+x2bjjGz/EcQWAKAevpp/4REWNzjjTCSMv0ldVWeg3FIwCGn9zqtFKDiIV1+29AlS
 8ej6Y+2VlE/Wo5uBmMM9KOfB5XtNYXkYiZ5N5bhlODPUKQ==
X-Received: by 2002:a17:90b:3852:b0:38e:5964:97a8 with SMTP id
 98e67ed59e1d1-38fbc46d032mr12071305a91.16.1785854776683; 
 Tue, 04 Aug 2026 07:46:16 -0700 (PDT)
Received: from botszhome.. (118-171-39-160.dynamic-ip.hinet.net.
 [118.171.39.160]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38febffb36dsm1553009a91.7.2026.08.04.07.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 07:46:16 -0700 (PDT)
From: botszhuang <huang.botsz@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@mailo.com, qemu-arm@nongnu.org,
 sef1548@gmail.com, botszhuang <huang.botsz@gmail.com>
Subject: [PATCH] hw/i2c/bcm2835_i2c: Correct iomem size
Date: Tue,  4 Aug 2026 22:46:11 +0800
Message-ID: <20260804144611.31735-1-huang.botsz@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=huang.botsz@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The last valid register is the Clock Stretch Timeout (CLKT) at
offset 0x1c. Since it is a 32-bit register, the total memory
region size should be 0x1c + 4 = 0x20.

Update the size parameter in memory_region_init_io() from 0x24
to 0x20 to accurately reflect the hardware specification.

Signed-off-by: botszhuang <huang.botsz@gmail.com>
---
 hw/i2c/bcm2835_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c
index 34de1f36e5..5f6093087d 100644
--- a/hw/i2c/bcm2835_i2c.c
+++ b/hw/i2c/bcm2835_i2c.c
@@ -222,7 +222,7 @@ static void bcm2835_i2c_realize(DeviceState *dev, Error **errp)
     s->bus = i2c_init_bus(dev, NULL);
 
     memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_i2c_ops, s,
-                          TYPE_BCM2835_I2C, 0x24);
+                          TYPE_BCM2835_I2C, 0x20);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 }
-- 
2.43.0


