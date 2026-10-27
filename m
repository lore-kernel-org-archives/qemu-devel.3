Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DC606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ya0Ynu0l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnDr-0002pA-Cw; Tue, 27 Oct 2026 15:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLnDk-0002n1-3c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:52:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLnDi-0004qD-6z
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:52:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so188046f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130749; x=1793735549; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1C8skHGOVNN9sTDeszVwrYti+Dl4AQvQOGFxu/nUl5I=;
 b=Ya0Ynu0lfnL/Xgry5YGV/qkL3dqpC6ARr8Czh90dew+dP23CKLr7xg4AFiY9k6xpLL
 nCXUspiBCo7mnvdO3CdTYDRHzx9D/3hiyuaL+dOduZfa9oiomQTtMcJxGNuGgkJOGeqk
 MtipgFmqW0WGsuVEs2w4e0LwU9rT/6SYke5ji8oIJyZo3nkkfF1kvNJm5wCGrfXHFKi3
 ZMx6e2oVKI6pkcToCeMe9nwepqL3Lc3Hmm2SgNFiEhfpYcOQXCBL+8Ssg74/jNVdCn5Z
 q3jq1/fW7fZaVX8NmOS76Nu3ey4fpYRWwV3TsNlkGpcP/92TasxJ/+nMAdjZvhhULmOv
 Wz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130749; x=1793735549;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1C8skHGOVNN9sTDeszVwrYti+Dl4AQvQOGFxu/nUl5I=;
 b=D7CbaPauQnzUTXBQpfr6ju1yrT8v8H3CFMJx7v/WdrDtZ/yqgGhTp4d8oEYgff6ndR
 YObK3IOg0pgH/OvSKd+RVosVE04FFozoGiP+EZ7pfTcoWWh5pTou4lqhugV5m7FJ/w/K
 pJO7yYFN3QnOFibfMGcE/QGy8WWJSPX1RumZYG3cuc7aCzq8ceEgzO95EMHaBrWYunk+
 w93WzuGGpslp6SkDzqxv4xc61oqRotMa8tkqCLy6mJUNEYwIB+F9009uD4SGmLchV+IF
 STrf7HhHeNe2i4CIdRGe017IwQFcP6qPVMHXODZ//WJuR8oi0nLUJmG0/2l58dW86OWa
 0oIA==
X-Gm-Message-State: AFq9FYK3wW2LLg8c3YD8jwb0DrkqDUBwwtySGWI07AgIzljCF4r8p6ED
 agpM4Zh1blXLz/IzopTkJz3w3IDBJivu63j+TNr0wuo3hfCFONyjJeidwLAxLtYp96g=
X-Gm-Gg: AYBFou1e6BYqeuvKiy8gJIByzOSCCGtFWFeBBgn/Yw1nsocNdHjSJtE4/Js9veGzXxG
 d8TirPXt0mTtTW080JGaY4dNpvfMMzM8KgRy8PxyGKIuiaILEBbfSae9O9pUhCuCbS+qkEHPLDv
 mrHME8MovW2Cl+3xfCZP6NqeyFyFvuS6fXozd9llq6LzD4DEOSDabpoCbSGDwqVCKKANAthZdUR
 S8yCqCMEN7ZL+zuHkxnRoRvzA6uXItf/TmIheMYDikpSLp8ZtnPJdBgwuzz2FdeAFTa05gTWqi0
 GLdW8re0TY+ntm4JXjxj0YxHUYorKPzrrB0qCIvr5XtHeGP03+/cLX0OohBnjrWpGoA+M2rKeKZ
 N8RPMX49YYJK8Yyqhdo9llW3TbzXE/wkLBPE+c2TFE5N+DvIKkD2A1EDsaZsKg9/+ftf7N3t+dt
 HbRko52KT6surx7JhV5bnsM84+j8IME7BUuSDA2T2xaR+T2cY8g6/yqXDneBOElYNzJ7qsHq7sW
 dRSaTgv1AFNObyu19rK4nUY7xDl8ceoAXFYJRDkZa4YYSgwQO3DkyPL2ZJG4i9MQzsPfPwh8dAD
 4nOtrnSAtOELb+Y=
X-Received: by 2002:a05:6000:606:b0:48d:f249:82c3 with SMTP id
 ffacd0b85a97d-48e5d5996f9mr939321f8f.30.1793130748343; 
 Tue, 27 Oct 2026 12:52:28 -0700 (PDT)
Received: from [127.0.1.1] (95-24-99-141.broadband.corbina.ru. [95.24.99.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm24746368f8f.25.2026.10.27.12.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:52:28 -0700 (PDT)
From: Timur Maksimov <gessingate@gmail.com>
Date: Tue, 27 Oct 2026 22:50:43 +0300
Subject: [PATCH v2 2/6] hw/i2c/aspeed: fix BUSY status reading in new
 register mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-aspeed-i2c-nonpkt-fix-v2-2-07deed1dff60@gmail.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Timur Maksimov <gessingate@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793130744; l=1242;
 i=gessingate@gmail.com; s=20261022; h=from:subject:message-id;
 bh=xRsjRiO1YrfXwNZLoC5rlFGhOgngxwDjpGeWazFhqOE=;
 b=Fuc8GYMMvs/xVHXJFroZPABUJPFJjpK9RNZqY8oiYgbgDXdw//+cxTCJGktlvdiOkbCg/GAES
 KdEacF7TKtzCvXdO+UmB4ZnT4oYlA1xv+pr3s50PBD8PYwv0tza8sO1
X-Developer-Key: i=gessingate@gmail.com; a=ed25519;
 pk=xF4NKIzSbKMdte17nQ66S/q9m/A2gu6GiEWc8ZnyJmo=
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=gessingate@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In new register mode, BUS_BUSY_STS is bit 16 of I2CC_MS_TXRX_BYTE_BUF;
bit 16 of I2CM_CMD is PKT_OP_EN. Report the bus busy state in the
correct register.

Signed-off-by: Timur Maksimov <gessingate@gmail.com>
---
 hw/i2c/aspeed_i2c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 0bc4bb6fbe..fb6d19c37b 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -146,7 +146,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CC_POOL_CTRL:
     case A_I2CM_INTR_CTRL:
     case A_I2CM_INTR_STS:
-    case A_I2CC_MS_TXRX_BYTE_BUF:
+    case A_I2CM_CMD:
     case A_I2CM_DMA_LEN:
     case A_I2CM_DMA_TX_ADDR:
     case A_I2CM_DMA_RX_ADDR:
@@ -166,7 +166,8 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
     case A_I2CC_DMA_ADDR:
         value = extract64(bus->dma_dram_offset, 0, 32);
         break;
-    case A_I2CM_CMD:
+    case A_I2CC_MS_TXRX_BYTE_BUF:
+        value = bus->regs[offset / sizeof(*bus->regs)];
         value = SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus->bus));
         break;
     case A_I2CM_DMA_TX_ADDR_HI:

-- 
2.53.0


