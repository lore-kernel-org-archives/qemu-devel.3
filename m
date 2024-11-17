Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF0DD10F3A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 23:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCoGO-0008Eu-St; Sun, 17 Nov 2024 18:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCt-0007hP-VV
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:27 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1tCoCs-0002sm-Am
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 17:57:27 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-431481433bdso21905635e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 14:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731884245; x=1732489045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BU5iYSnAuyrEV5xBAp7OTGDZ08INsgWhPSSF/a6akAU=;
 b=WQTne9XwSo7DZZwjnjucP43sDDM8T/nhyMmwY/xW9XV8C0WHEY9VVG8lcRakCysj4M
 RdvV8M9gJxVrJNn4VtTDnVZVD4l6KYZ7zPOPHIM1TXX1Yd44Ixwe5D1j+5PS1nZDr9Xj
 afjS+XBAbmrs74DSwnMFq/wzoUKBYF8fNFjWa7/vLYoTNe5yDj+nqKag2L8qmZ3HVLYR
 3YC+57gppHH/4WfJyGzGRXn1+07RxSxgP2H9DOcpIzJa9yGE98E4iS3HiY/hevCV+UNs
 afZF/BDSfj6HohIshemASgnjjdgfdkYOzG9gQn7ASN8n2n1LLDSD/IAGHxMQlmlus54d
 GS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731884245; x=1732489045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BU5iYSnAuyrEV5xBAp7OTGDZ08INsgWhPSSF/a6akAU=;
 b=aFJzYpRWDVZWSAIkrAK+RhlxDy7HSdQ2Yquc1kLkTxOHGMFfVXYuxuj2ergHM9x58m
 zo5dfZ/E0nRMDkodaG2mPqz1wTCG3IN0CEcQd3DJQbBlxYuUyo96yEO4Bn/EbtdaZ5nQ
 fQAPsbqI+G6AQZmTm5M89jcTnCPnG/EI/kwvcykoFj2J+JAv+BreRWzWiM8MkqwKUGP6
 sEL19JfmN9H1yUdkSINZy8SRFaRHx7TaTvwOiLY0rQSwycuwtNyXw6Se9PX0j/mT5QGB
 lojwZnhFU4+TwCa1iktpGi1VQ2/Yp/kxUKFuvAs/0i2AUJJBYIngUY4hYHc8PRYlrYhq
 lOPg==
X-Gm-Message-State: AOJu0YwUjcp8GZFu4AiCTd452xzdAUtNPBCVxp7dIKQ8YxCPsbrlfOkV
 tZH1tvG3fysR0L4thpnm8I3TwoFDtSJDrAw6JpAz1C3rNkpbbgkcLpmKClmwHdolUw==
X-Google-Smtp-Source: AGHT+IFyzJm/bt66HHsHbHfXenoObKKWxM0MX5r7suUHYUC0pfk57muyRcLSEXpPWH3LMZypCPL6Wg==
X-Received: by 2002:a05:600c:4e08:b0:431:1512:743b with SMTP id
 5b1f17b1804b1-432df78b038mr74724205e9.21.1731884244870; 
 Sun, 17 Nov 2024 14:57:24 -0800 (PST)
Received: from asus-xubuntu.. ([82.78.167.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da2800absm136351505e9.25.2024.11.17.14.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 14:57:24 -0800 (PST)
From: "=?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?="
 <jean.christian.cirstea@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Ioan-Cristian=20C=C3=8ERSTEA?=
 <ioan-cristian.cirstea@tutanota.com>
Subject: [PATCH 5/7] [BCM2835 AUX 5/7] Suffix constants
Date: Mon, 18 Nov 2024 00:56:41 +0200
Message-Id: <20241117225643.768322-5-ioan-cristian.cirstea@tutanota.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
References: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 17 Nov 2024 18:00:54 -0500
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

The constants defined through the preprocessor must be unsigned. Also,
unsigned integer constants are consistent across different bases (see
section 6.4.4.1 of the C99 standard draft).

Signed-off-by: Ioan-Cristian CÎRSTEA <ioan-cristian.cirstea@tutanota.com>
---
 hw/char/bcm2835_aux.c | 52 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 266d0dfdc7..e887076d9b 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -30,49 +30,49 @@
 #include "qemu/module.h"
 
 /* TODO: These constants need to be unsigned */
-#define AUX_IRQ         0x0
-#define AUX_ENABLES     0x4
-#define AUX_MU_IO_REG   0x40
-#define AUX_MU_IER_REG  0x44
-#define AUX_MU_IIR_REG  0x48
-#define AUX_MU_LCR_REG  0x4c
-#define AUX_MU_MCR_REG  0x50
-#define AUX_MU_LSR_REG  0x54
-#define AUX_MU_MSR_REG  0x58
-#define AUX_MU_SCRATCH  0x5c
-#define AUX_MU_CNTL_REG 0x60
-#define AUX_MU_STAT_REG 0x64
-#define AUX_MU_BAUD_REG 0x68
+#define AUX_IRQ         0x0U
+#define AUX_ENABLES     0x4U
+#define AUX_MU_IO_REG   0x40U
+#define AUX_MU_IER_REG  0x44U
+#define AUX_MU_IIR_REG  0x48U
+#define AUX_MU_LCR_REG  0x4cU
+#define AUX_MU_MCR_REG  0x50U
+#define AUX_MU_LSR_REG  0x54U
+#define AUX_MU_MSR_REG  0x58U
+#define AUX_MU_SCRATCH  0x5cU
+#define AUX_MU_CNTL_REG 0x60U
+#define AUX_MU_STAT_REG 0x64U
+#define AUX_MU_BAUD_REG 0x68U
 
 /* Register masks */
-#define MASK_AUX_MU_CNTL_REG 0x3
+#define MASK_AUX_MU_CNTL_REG 0x3U
 /* Mask for TX-related bits */
-#define MASK_AUX_MU_STAT_REG_TX 0xF00032A
+#define MASK_AUX_MU_STAT_REG_TX 0xF00032AU
 /*
  * Mask for RX-related bits.
  * XXX: It does not include receiver IDLE and receiver overrun for now.
  */
-#define MASK_AUX_MU_STAT_REG_RX 0xF0001
+#define MASK_AUX_MU_STAT_REG_RX 0xF0001U
 
 /* bits in IER register */
-#define IER_RX_IRQ_ENABLE  0x1
-#define IER_TX_IRQ_ENABLE  0x2
+#define IER_RX_IRQ_ENABLE  0x1U
+#define IER_TX_IRQ_ENABLE  0x2U
 
 /* bits in IIR register */
-#define IIR_IRQ_NOT_PEND 0x1
-#define IIR_TX_EMPTY 0x2
-#define IIR_RX_VALID 0x4
+#define IIR_IRQ_NOT_PEND 0x1U
+#define IIR_TX_EMPTY 0x2U
+#define IIR_RX_VALID 0x4U
 
 /* bits in CNTL register */
-#define CNTL_RX_ENABLE 0x1
-#define CNTL_TX_ENABLE 0x2
+#define CNTL_RX_ENABLE 0x1U
+#define CNTL_TX_ENABLE 0x2U
 
 /* bits in STAT register */
-#define STAT_TRANSMITTER_DONE 0x200
+#define STAT_TRANSMITTER_DONE 0x200U
 
 /* FIFOs length */
-#define BCM2835_AUX_RX_FIFO_LEN 8
-#define BCM2835_AUX_TX_FIFO_LEN 8
+#define BCM2835_AUX_RX_FIFO_LEN 8U
+#define BCM2835_AUX_TX_FIFO_LEN 8U
 
 #define log_guest_error(fmt, ...) \
     qemu_log_mask(LOG_GUEST_ERROR, \
-- 
2.34.1


