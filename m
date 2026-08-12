Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA366C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8j1-0000D0-FE; Wed, 12 Aug 2026 09:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8i7-0007t4-Ko; Wed, 12 Aug 2026 09:09:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8i5-0005em-51; Wed, 12 Aug 2026 09:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=oRC6/Quzig25Gy65AWgpj/Z1OJzeEhGrMhwUkwDSR14=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h2NMMmE/zeFGjbCenjoA4Wq0devkvh9xKvbEb5Z1CVuH3Oxh2DonTyMhQmoFaRiCq
 2OcV0xgFr/yACe1PMkp4w+0DNno0g5jBkprOBi1UOT+1h85a4ceqHEUiJfKae597O5
 5viSqm3G6TAyKjhRr1gwEs8iTanmaiDquTDGwFPgqpvCPYUCjWVgvKy7HZ+tSRtbtA
 k+SAXQRqU/z3An35e3ZAmyTQJUa2nB/Sj/rUmbDoRnPocjn//FX3fpo4Oj/e6YyIei
 DQz8Xt/xFT8y0S8yqJ9Ph7Hr3xPzOv332CAq/LRFuyFJCC0nJvcKQtM+J4g8KELcnQ
 hggXxjgwnupUg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4A8511CA4C2;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 80FDC409BA5;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7CAB42F91A; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, botszhuang <huang.botsz@gmail.com>,
 botszhuang <botszhuang@gmail.com>, Nick Huang <sef1548@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 067/102] hw/i2c/bcm2835_i2c: Correct CLKT register
 offset
Date: Wed, 12 Aug 2026 16:01:42 +0300
Message-ID: <20260812130233.621965-67-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: botszhuang <huang.botsz@gmail.com>

The Clock Stretch Timeout (CLKT) register for the BCM2835 I2C
controller is actually located at offset 0x1c, not 0x20.

Update the BCM2835_I2C_CLKT macro to match the hardware
specification.

Since QEMU's implementation ignores whatever value the guest
writes to this register, and Linux only writes to CLKT and
doesn't read it back, the main effect of this fix is to
avoid an incorrect GUEST_ERROR log.

Cc: qemu-stable@nongnu.org
Fixes: 9cf3bc65afdb63 ("hw/i2c: Implement Broadcom Serial Controller (BSC)")
Signed-off-by: botszhuang <botszhuang@gmail.com>
Tested-by: Nick Huang <sef1548@gmail.com>
Message-id: 20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com
[PMM: removed commit message paragraph about effects which I think
 is incorrect, substituted a different one]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit c4580a3a6d1cc542479602048d15556a18928a22)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/hw/i2c/bcm2835_i2c.h b/include/hw/i2c/bcm2835_i2c.h
index 0a56df4720b..7e8cbb43b1b 100644
--- a/include/hw/i2c/bcm2835_i2c.h
+++ b/include/hw/i2c/bcm2835_i2c.h
@@ -38,7 +38,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2835I2CState, BCM2835_I2C)
 #define BCM2835_I2C_FIFO    0x10                  /* FIFO */
 #define BCM2835_I2C_DIV     0x14                  /* Clock Divider */
 #define BCM2835_I2C_DEL     0x18                  /* Data Delay */
-#define BCM2835_I2C_CLKT    0x20                  /* Clock Stretch Timeout */
+#define BCM2835_I2C_CLKT    0x1c                  /* Clock Stretch Timeout */
 
 #define BCM2835_I2C_C_I2CEN     BIT(15)           /* I2C enable */
 #define BCM2835_I2C_C_INTR      BIT(10)           /* Interrupt on RXR */
-- 
2.47.3


