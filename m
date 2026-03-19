Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E84C1091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Ml3-00014z-Jw; Thu, 19 Mar 2026 19:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Ml1-00012u-IF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mkz-0007iO-Ul
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b04e6a989eso9796685ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962784; x=1774567584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JEb8zTJzS/m1p8rg1ZAG9mFLhEcaPRnQLFl3tU6IqbU=;
 b=KYHKpiwYpK5Z6h/OO/dCIU7QV1WcZUohwRTo1aqG5MH8tzdXQMNuRrkEhIfKlE1yEi
 A5FuTvsM2K77yAUsGXSgW8XzzCydFktERuCgaJg5TynVkO1hEXUrQbJlCpJFX5mSg2u0
 m1mb3jyVVlJ3G97nhtz2eUdwtxqS1V/72YYiOYjdu/ILuC+FGURrZxPNOpUpP12/zxX5
 KMbfV6sDz9n89sE1jKdkTAMCTo8mF+FcvTc2cQ2K++2VGHWliQ7zyCGzwjXsIr7Z48AF
 0w5xOkUCWVIrL7kh+wDSCTJ14jZGPMJvKBN4DeDz83dh4etOUTQNPYtB3crygWF85snd
 WZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962784; x=1774567584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JEb8zTJzS/m1p8rg1ZAG9mFLhEcaPRnQLFl3tU6IqbU=;
 b=gvKjnqZitDZzL7tmsYDYfk1hpJiUJ4En8VLDdWmK8zWHPDMYb4mzA9g6EmvaSTRQbU
 FwAZ9qXAjwOwtYP6mW2wPen6s/RUYjtNMI+5no9nPUqRQL6iYNKyPFEmHEfvQqz6YEm/
 xTxxfigamUNga4v0ccalrmzevaZEVHKG1hd8Tbk9VqxlA91P9rNa7jArlrxV0tzudalh
 sU1sJPAEw8UnQN3LctQJ9R7Gmh4J0tRB+guucifn8XG4dPJ+4fUhlr8EVi+2HoVJ0BKa
 A8bK1VKvUrzY1Tlq9+ssRx+06cU9/fl0RfQA4k7hmiPVT9mwjGUfPGik41GL5l1o8Skw
 YVOw==
X-Gm-Message-State: AOJu0Yw+rGZOr36ZAXHrJ6ANqPUdmXjwblE3JyKJMvjBM/+b+Mav1XbF
 eRgY7Wl9CQIgEAjRs9ag4Yw67vOkq9wWxw/OppXZ6OqxNo01CDQPV+TBnR8tOg==
X-Gm-Gg: ATEYQzyXfOtDKVoSZV52yppnkmjeJQOQTWoWHDM3fnxe3jpoPj7SUZsjDluVZKX1hdK
 YQm+5Hhb+92Ddf7Pdp8/zX3AQf1BDsGPhZbBPAF7gSQbcGwB9SQPuHeD2AAPAdVnTwBIjesOCpF
 8konvPAc2abhO0QfUWrP5A8hRA6bCyvTNRxHL6YSKj0fcKkVOLIJ6FXJgqpEJ0Uywu7S3RRDPO9
 jJnnifhV4ULUBo0Cqu4LIucA4vyMfwd9imuDW9aAHyOk/Z1+rI9k4XLYSEWqjL8zlh8zfZAm7sZ
 +nvMD++X4CCtM3nQiDNg9W91Ok4jPU/eOsjJDlHo4Lh0WHyAh4FW5NnUURrCrOiPZLYZ9Q4zIeA
 9zhmRsfeoUgAypPJ1cA91jp5klHlaMS1MFHkaMyNW8PRFmLa1AvgcsahEJTgHbTyqK/8XSa4+Vg
 d3RtWPgO61U8nOm6zyySyujhYsaVGZefuvgQahFHQLEw==
X-Received: by 2002:a17:902:f60d:b0:2ae:829d:3c33 with SMTP id
 d9443c01a7336-2b0826c3d65mr8041215ad.8.1773962783900; 
 Thu, 19 Mar 2026 16:26:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:26:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/17] hw/char: sifive_uart: Remove ip variable
Date: Fri, 20 Mar 2026 09:25:19 +1000
Message-ID: <20260319232522.1867400-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

The ip variable is no longer used in the code. Remove it from the
codebase.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260312033201.1619554-5-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/char/sifive_uart.h | 1 -
 hw/char/sifive_uart.c         | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index c78d9bd1fc..5f3b1327de 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -73,7 +73,6 @@ struct SiFiveUARTState {
 
     uint32_t txfifo;
     uint32_t ie;
-    uint32_t ip;
     uint32_t txctrl;
     uint32_t rxctrl;
     uint32_t div;
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index f255cca960..4c30fbf568 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -285,7 +285,6 @@ static void sifive_uart_reset_enter(Object *obj, ResetType type)
 
     s->txfifo = 0;
     s->ie = 0;
-    s->ip = 0;
     s->txctrl = 0;
     s->rxctrl = 0;
     s->div = 0;
@@ -343,14 +342,13 @@ static void sifive_uart_reset_hold(Object *obj, ResetType type)
 
 static const VMStateDescription vmstate_sifive_uart = {
     .name = TYPE_SIFIVE_UART,
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(rx_fifo, SiFiveUARTState,
                             SIFIVE_UART_RX_FIFO_SIZE),
         VMSTATE_UINT8(rx_fifo_len, SiFiveUARTState),
         VMSTATE_UINT32(ie, SiFiveUARTState),
-        VMSTATE_UINT32(ip, SiFiveUARTState),
         VMSTATE_UINT32(txctrl, SiFiveUARTState),
         VMSTATE_UINT32(rxctrl, SiFiveUARTState),
         VMSTATE_UINT32(div, SiFiveUARTState),
-- 
2.53.0


