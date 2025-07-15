Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EE0C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ3Y-0005al-3c; Tue, 15 Jul 2025 02:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1w-0003UX-OR
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:21:01 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1r-0007RW-CJ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so3551770f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560435; x=1753165235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAAEB3eVJKoeoejF7sQrJUuJBjbwnpIt5RH1cN5JYiQ=;
 b=aRo+vdHm6y4mNOdyIpRrV/b5qAJtOH4n/l8/LKrIUJzxBVcZJdwP+hBQzmxxZHvzt+
 pbGTwhvBRhscR07QfbSQSeTwcp7FuIlx701TkUNLa/jnFwiz1qm15bdl7Z6sAbwTy8gQ
 Jf0kRnZz1Mz05mUrAgzIKysGonDHhsCeQUKwYAtCdc6TdIys69YyjdTZe460IOXiW5+W
 6gMAs7ykCIYrF1VYjB1vUSoP8WlB821brqArKqO0Frx+ZVLO4TYC6GwE9J1GMxbAQCUw
 9PSsHLiEr5U6XBqurg17MKJOOOW5aynkvX0h99Mw1kCpBeoMxb6yDOSQmLIutRrObPf6
 pM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560435; x=1753165235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AAAEB3eVJKoeoejF7sQrJUuJBjbwnpIt5RH1cN5JYiQ=;
 b=Gso4BCTUut37I+YQQ8S3UdiIiKhdwq5Xts89iQFq23h8ibkef8Rt98KLsu9B03vrh9
 iTD+v4Ncfi+2uSxpvI+q6T8WK2LiUsdS0OSpUeeBxcoSa1stpZVAF+CuQicfQyPv61kV
 WbNIUJC7/ZdHYUORLzezdAQRig90WBxvQLzEALEXraKtoXffTuub/lu+iG4Hu8JS2zXj
 lvV+lLeDSk0GvwHLYs62BW0BbumuouQqvlqAs1JO+XBRIzg/Z/Mtlm7/w9h3ea+Jjllv
 0Nuz/zMgbZmjgJMzdsDn8w6m3YHpuSyiI2308kqWSuiy0IU6I61MVCAAg5c3d/zpRCxP
 Oj7A==
X-Gm-Message-State: AOJu0YxbW5/REr73YNgzbZQL3d0UCi0CZAAq63HM++KaEiBH43+yk/5n
 Z7oP31uppWT4hMmSgD6znz4oTk1cEyLUXU7YbcRQSGTxDiZQpip61Gnr2n4mXpTkJZ/IkqLAbv4
 wqwkn
X-Gm-Gg: ASbGncsZio1POsifwxZdQ0cLn0sHZNVf9Nbd9rs3D/DPQBjq4etkNYWYjy/H3a/CdSE
 Xf1dIVsVr2mPomapj6id8mP3qXTidDHbNMkUJTRDgeeZJLgFg5twOLyTgyCmdwnaq5A+dIrq4rW
 FH7gd/9vAGuU9YVHWxTDu7z1vdSa2jOsdHZ/Y84g9PImpeHj/B2Wx6bZdkca1P++B4xBhTVsP0F
 awhYpc3I5+fTLpy893a0uHADXJZ7618uz+D22E956VdrQW9ed7fi2n53k7kZoAtCxHFyRLeN8St
 2B8UATVSQSXpdUaW023kK4iQIG/0RWUlizOTACCKyj76qK0BqncAr0n+Zz1DxxlyXwKnf/lL1CU
 ruNNI1E/PoA12XSXR//OazIV3RG/0TLduyXDmVF7ZI1MX4f71X1QDlrL1IWy9FZ0w0Sl0gAc0FR
 nliXa7M8M=
X-Google-Smtp-Source: AGHT+IE4kM2zPLwHhA8KcuIIH8p3I9fuc0n6FZDfc1V21iDYd5ErMap3SVHNE2uZlFs7uRpHnPFVzQ==
X-Received: by 2002:a05:6000:2307:b0:3a5:8934:4959 with SMTP id
 ffacd0b85a97d-3b609544322mr1440705f8f.27.1752560435072; 
 Mon, 14 Jul 2025 23:20:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5032e9esm190623215e9.3.2025.07.14.23.20.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:20:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 15/17] esp.c: only call dma_memory_write function if transfer
 length is non-zero
Date: Tue, 15 Jul 2025 08:19:15 +0200
Message-ID: <20250715061918.44971-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

In the cases where mixed DMA/non-DMA transfers are used or no data is
available, it is possible for the calculated transfer length to be zero.
Only call the dma_memory_write function where the transfer length is
non-zero to avoid invoking the DMA engine for a zero length transfer
which can have side-effects (along with generating additional tracing
noise).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250711204636.542964-6-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ec9fcbeddf4..1c7bad8fc02 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -631,7 +631,9 @@ static void esp_do_dma(ESPState *s)
         switch (s->rregs[ESP_CMD]) {
         case CMD_TI | CMD_DMA:
             if (s->dma_memory_write) {
-                s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+                if (len) {
+                    s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+                }
             } else {
                 /* Copy device data to FIFO */
                 len = MIN(len, fifo8_num_free(&s->fifo));
@@ -681,6 +683,7 @@ static void esp_do_dma(ESPState *s)
                 buf[0] = s->status;
 
                 if (s->dma_memory_write) {
+                    /* Length already non-zero */
                     s->dma_memory_write(s->dma_opaque, buf, len);
                 } else {
                     esp_fifo_push_buf(s, buf, len);
@@ -715,6 +718,7 @@ static void esp_do_dma(ESPState *s)
                 buf[0] = 0;
 
                 if (s->dma_memory_write) {
+                    /* Length already non-zero */
                     s->dma_memory_write(s->dma_opaque, buf, len);
                 } else {
                     esp_fifo_push_buf(s, buf, len);
-- 
2.49.0


