Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90149C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ2d-0003s3-Kd; Tue, 15 Jul 2025 02:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1r-0003LA-Sz
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:41 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1m-0007Qc-Vs
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:38 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so4184550f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560431; x=1753165231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJ/tkPkzgP2G4LmEdPSORw9xVUXvOZgvZ1yKFPXS8bk=;
 b=IehGzfAyyuXBfdNmnxZInT48pKxcpr9ObE0vhM60EuTZQW1ybcRGOaIExSeLyc4zcm
 k6xYG3NlsC9sQhwunoAERgbUSXnjFViFJtPTB3F8Zpl9SQn1OCdboyFtdndSfmC0Jidx
 AT4bsSLsEuRJBwMTuIs2PvVN7voPN80g19FrBB/ftIsCM+Ym7r9cg8UeZT4qBlyXw4dN
 DDoBicZUiPNfOkHTgOPT8e/KLTQVm+b71zdirJlKDDAJBHHjZ6GrQtGublEXz5xSHh4U
 sCjBR5np+p/Jx1NU+BJ67w1YvWVnomeVr29Ol8aUHc6E98p60KLwX6K4nYxsvioc85MZ
 /uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560431; x=1753165231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJ/tkPkzgP2G4LmEdPSORw9xVUXvOZgvZ1yKFPXS8bk=;
 b=gL/iWroAuNrq5WrI7m7c9gIFdKiGlwp5K8tf4Nb0r9hdhnDTuzTcuwz2kW6uAg/JWA
 qpPCMmwJiS/oRHa2r7qUbdjKi+riwrszU0BQPNLT6o48SviWeHtKFDYdXj3aielaJ7G6
 t7igrGa0RAAKpXlNVwhe5rQFkPFtY7wAb1Zp3xPCCFb8KynpdvkvfHfuw7DRI4ddnBwX
 nBEJ+BMv1Uvb0aMXD5/ZMXXfZ/tIOKbRQvD/w5tVgAopVlUgaEgsj2RRDjrnTUCtJ4rw
 rOEuGQvupFuXayvUsrUMUTfSv1jWPoqaoeWadYOlrvX00mOEL2IMYwevV0MtgZiDjVMc
 0Vgw==
X-Gm-Message-State: AOJu0YwEy/dEpk/KkVyMRoi2RHzd9RXI10uOHpGUsIsKm46/NA754iTj
 9QULlZY+pxvlQ10jxp5bYwhIj5g33t0cOXtEW7VXDrkK7KRD/lSQYkV48tnENgfpQLcOvLqudXz
 2dOyU
X-Gm-Gg: ASbGnctoOMG/G5x49zqbMRQqD/aQsl5PYNTMvMxFewCa2HRsfX/9+952vJuJCk9Nhoc
 7sSlpwlmkPs6SYID3oTZyx7q2z1cl0iEdCFmB3cVvMjXMgb2eOu8Cyv0zqSw7shtoO8ySL3jD0A
 nvnDECil2K6eLvowuGlUYiTjD2jsQmmzWbZc52ERnNARW4tlFUB9FUnGILDOAV8IleCsSjIyebI
 +tVOODzKoeiw7zR8mh3/6Qjm5Fn+zJNPCiH9ilvZATgdTMU/TeDAbE0TjKgvGyUiZ2hAUUx2Ug4
 cpkvclgbGYJc4bfAP+eubGWQsiH45Uf7lA7HOCAm+y2WxCc0Q3e274oxnFa33zbqZDCIeuwhJ+3
 MZL3AE6Vcbuz4kuEWSL4kwpCYAQyMhTJR5iDcTjL4HsaNpR/MVCSWhSGdOaCgAEWg+h3y64Sn
X-Google-Smtp-Source: AGHT+IGO8LYAGWiLViQFkqJbigWnR+O7BCPkSqZzEHAbmSD7r+xY53v76zJK8wetKhEblN2hFyjrEA==
X-Received: by 2002:a5d:64e8:0:b0:3a4:e480:b5df with SMTP id
 ffacd0b85a97d-3b5f2e33b06mr11896666f8f.44.1752560430348; 
 Mon, 14 Jul 2025 23:20:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14e82sm14307792f8f.71.2025.07.14.23.20.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:20:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 14/17] esp.c: only call dma_memory_read function if transfer
 length is non-zero
Date: Tue, 15 Jul 2025 08:19:14 +0200
Message-ID: <20250715061918.44971-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
Only call the dma_memory_read function where the transfer length is
non-zero to avoid invoking the DMA engine for a zero length transfer
which can have side-effects (along with generating additional tracing
noise).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250711204636.542964-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 62ba4061492..ec9fcbeddf4 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -487,8 +487,10 @@ static void esp_do_dma(ESPState *s)
     case STAT_MO:
         if (s->dma_memory_read) {
             len = MIN(len, fifo8_num_free(&s->cmdfifo));
-            s->dma_memory_read(s->dma_opaque, buf, len);
-            esp_set_tc(s, esp_get_tc(s) - len);
+            if (len) {
+                s->dma_memory_read(s->dma_opaque, buf, len);
+                esp_set_tc(s, esp_get_tc(s) - len);
+            }
         } else {
             len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
@@ -541,9 +543,11 @@ static void esp_do_dma(ESPState *s)
         trace_esp_do_dma(cmdlen, len);
         if (s->dma_memory_read) {
             len = MIN(len, fifo8_num_free(&s->cmdfifo));
-            s->dma_memory_read(s->dma_opaque, buf, len);
-            fifo8_push_all(&s->cmdfifo, buf, len);
-            esp_set_tc(s, esp_get_tc(s) - len);
+            if (len) {
+                s->dma_memory_read(s->dma_opaque, buf, len);
+                fifo8_push_all(&s->cmdfifo, buf, len);
+                esp_set_tc(s, esp_get_tc(s) - len);
+            }
         } else {
             len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
@@ -572,8 +576,10 @@ static void esp_do_dma(ESPState *s)
         switch (s->rregs[ESP_CMD]) {
         case CMD_TI | CMD_DMA:
             if (s->dma_memory_read) {
-                s->dma_memory_read(s->dma_opaque, s->async_buf, len);
-                esp_set_tc(s, esp_get_tc(s) - len);
+                if (len) {
+                    s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+                    esp_set_tc(s, esp_get_tc(s) - len);
+                }
             } else {
                 /* Copy FIFO data to device */
                 len = MIN(s->async_len, ESP_FIFO_SZ);
-- 
2.49.0


