Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236D5C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWr-0006VQ-8M; Tue, 04 Mar 2025 20:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUN-0002Di-3D
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:00 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUL-0007AM-I2
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:58 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-390ddf037ffso3360399f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137835; x=1741742635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd7m5wMCz+XZxcgvBF3/5ywn7cJ5I9SW91UZjpHUbeA=;
 b=cYsEZF4DPwJbbCt2fcEC3RW4ULWbSjKrmFSsyxUxqf3vY1nCYW87qh0oHAI9zVhh5/
 6pl70pzVP1Opom2qJKsNV5QzuF++Mq1Inl+/nim0nBhV7q4+71MzBpr3iiw8m++giGO1
 qxnEzfCdR5vlq7KHnYVV+5LRd1DWh5BfIyKgJB53AA19mfvqAYwvBi4wpqEjn1NTwYOR
 v1Un3+6KvPG9YtVPcIW4C8QltQvzFk5MsQwUOXsQGQ8ScxJBhqZd43dHUiFHDDg2Q81C
 KS1gCmkBdfFbSMk2a4LhiUq7QLLx8sRGqOlCT38y3YynIvCPvONf5F8K0gXuzNoFu9rY
 rAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137835; x=1741742635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qd7m5wMCz+XZxcgvBF3/5ywn7cJ5I9SW91UZjpHUbeA=;
 b=Awo44fFGfeZqqPNZXzGOppZGOv9Ug5FF8NE5H24lK5kU1N9LyUbcjH7McRYrQSd+mB
 1h4lfHWLWcH8oHswepdAG1StsLSJyEIgqyhoqtS/r9MrBLEo44IPaDQnNUMvUzToHq2A
 KvlISm+hdIJc64D5CZX1jtv+fRCO8JjJtS3yxgmgwFpCVGdaQYiVc0ZdhlZmSAny7FHh
 1bYKhKtBN25gqCa6ighF30q7z0YcfwE7P74UePPJGljGQP8L+JegdclRrrPyd54aNc5b
 /U2/0Tk3xxoEpdA5LvAQqvfNCSTsd2irKRseopgiNVRxqhSP5F6lnNDe6Q9ccOAQiJuO
 KA9g==
X-Gm-Message-State: AOJu0Yx5HYI4NwhSiWy1IBNC+GMntEJ0ttMZSMURE0/WmShy8bVbQGA6
 UyBGJkQ4XlEaUrDBEEPXJ5k5lCj6V6NEUC4s39LonL6Xy0StLnK+OqB8TC79oL0NnEelAO6FFAu
 nzzc=
X-Gm-Gg: ASbGnctVnumn7uZWEozYHEe2A3uH+FH4Xub98GUrtX0WoCIpOHGPm+2YRWwL8Rk+a5R
 J+m7HyNvzAYQcKktbGJ0YfATt/UDI8GMIcSzEJ3tqG9xw/78xzVv6u0Hbc62vctoAdBPjpoQ3C8
 OHqzmH61P54k8kRHe0/EIR5T26FtQq6M1ZydnvdGESUBxHHnn0bVMK4dXmtcQQ3JW+w5wY1Yw7m
 TVBCW59YXivH1Oa2SyVjP+dam4PxfxSnsN++RscEBE6oW3Bh1eXQoCXoB783WycRrZbFEOkNN2r
 Y27trYw9wCdVN2dwE7gjL5Z00nnEVKz6ahSmLngeFvJjlco40NpoSg+LX/fPWQIu+DXvCr0M+wt
 7rTW/uYFSirzj/CJPWCg=
X-Google-Smtp-Source: AGHT+IFQriLDXu0bW0VYcFYpFnrQQOenK3H2DTY1wBvYAaLm4iAVNypHhoO05v4I74OKggKoXOtFHg==
X-Received: by 2002:a05:6000:381:b0:38f:2f0e:980c with SMTP id
 ffacd0b85a97d-3911f7d2fc9mr585329f8f.47.1741137835466; 
 Tue, 04 Mar 2025 17:23:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844c0dsm18880330f8f.80.2025.03.04.17.23.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 24/41] hw/char/imx_serial: Really use RX FIFO depth
Date: Wed,  5 Mar 2025 02:21:39 +0100
Message-ID: <20250305012157.96463-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While we model a 32-elements RX FIFO since the IMX serial
model was introduced in commit 988f2442971 ("hw/char/imx_serial:
Implement receive FIFO and ageing timer") we only read 1 char
at a time!

Have the IOCanReadHandler handler return how many elements are
available, and use that in the IOReadHandler handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20250220092903.3726-7-philmd@linaro.org>
---
 hw/char/imx_serial.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 38b4865157e..6f14f8403a9 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -386,7 +386,8 @@ static void imx_serial_write(void *opaque, hwaddr offset,
 static int imx_can_receive(void *opaque)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
-    return s->ucr2 & UCR2_RXEN && fifo32_num_used(&s->rx_fifo) < FIFO_SIZE;
+
+    return s->ucr2 & UCR2_RXEN ? fifo32_num_free(&s->rx_fifo) : 0;
 }
 
 static void imx_put_data(void *opaque, uint32_t value)
@@ -417,7 +418,10 @@ static void imx_receive(void *opaque, const uint8_t *buf, int size)
     IMXSerialState *s = (IMXSerialState *)opaque;
 
     s->usr2 |= USR2_WAKE;
-    imx_put_data(opaque, *buf);
+
+    for (int i = 0; i < size; i++) {
+        imx_put_data(opaque, buf[i]);
+    }
 }
 
 static void imx_event(void *opaque, QEMUChrEvent event)
-- 
2.47.1


