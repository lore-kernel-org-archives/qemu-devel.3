Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59612C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjYt-0005ES-6V; Mon, 24 Jun 2024 09:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjYY-0004Wb-Jc
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:31 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjYW-0005cc-Uf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:26 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ec52fbb50cso21891711fa.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234981; x=1719839781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdaAnkUJwowtFskE1jnezvCSjmf7OfsaigbewXS0J/c=;
 b=dcxT2kCIg8m9Hm+Ga5mbs6X3mJ943gViHmm2gNoloOKAZtNngKXMetmVLFB3NO7Lpx
 S4bhDs7GDnMmrf1zgpSlm2Vc+AmGsR+FYhNofP2xe2e3xf+Mm0DHhj1evcVKzqA9l2Bo
 IRzcHAIXqG9H8K1kSDJvVLSw7CrCBHuLIjLsf03by7zQ3hMxIWG3wr5M54/WV2syG3Kq
 iykVAuVgRFBf4jDPUIEkhHHmw1M+MR2l6H8ewkW/kcXIBIsAtqCl3pIvt/xQrppTiuLT
 6XVxBt2GpzBL9reAWXyZl7dHDH19cZoGg60eP0xfn1mEwPwEZcRkEIgPQzs+UGI5gHJq
 k9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234981; x=1719839781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdaAnkUJwowtFskE1jnezvCSjmf7OfsaigbewXS0J/c=;
 b=lLoUwfYIRXhdmdpLIgH9XIx2XWPAm/L4Wu+jJ4CVFmcFWVJi4g2IjNtoZPwVeqYXzi
 bTWOehH0vNQmGibbXcVnFmqBi0Y+se5M8QUO0HrwBK9z6VeMIjx5KO4yW2DxrrnDY6hr
 j7E3kYwwK6uf6mLuIsQNy8jy2PRAy1YfafOoZdJ4LmtOtalqjhniqvMeFWXkiAAHwjAg
 V1wOT9DzUJi3tfeeLMLfuaa3M7gCCRa52dhHvPDyjYgLukUBRwqHg+6WCa7WukhTVQEh
 EuS0dRgSQOMCMC3bNSddtOtIb7EHqkyyl9GlI1YZoq9QgO2tCTJyJbqMyU98DcJf/AFd
 5ENA==
X-Gm-Message-State: AOJu0YwK1EYW81hqreT21eT+mWlHIVfR0AP5gura0pB5rS09eIaJGG6M
 +dLnIDCntTm55AROdUD75nUYbsWJkTIJWAyA1hE7pzz7viFgRbMOgqXJ0rfSIe4dUi8wumOcLvs
 1
X-Google-Smtp-Source: AGHT+IGDCutJFfSVzkWUgg0W44sDuHKsWlIUnWlRCPJImUKzZ3tvf297RsnPU4U220VXVY02+jN/2g==
X-Received: by 2002:a2e:890d:0:b0:2eb:e258:717f with SMTP id
 38308e7fff4ca-2ec5b2f0400mr27285961fa.42.1719234981135; 
 Mon, 24 Jun 2024 06:16:21 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d208e13sm171560425e9.36.2024.06.24.06.16.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:16:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/19] hw/sd/sdcard: Inline BLK_READ_BLOCK / BLK_WRITE_BLOCK
 macros
Date: Mon, 24 Jun 2024 15:14:39 +0200
Message-ID: <20240624131440.81111-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

These macros only save 3 chars and make the code harder
to maintain, simply remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-20-philmd@linaro.org>
---
 hw/sd/sd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 969340e5cb..d4e3d079a8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -819,8 +819,6 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
     }
 }
 
-#define BLK_READ_BLOCK(a, len)  sd_blk_read(sd, a, len)
-#define BLK_WRITE_BLOCK(a, len) sd_blk_write(sd, a, len)
 #define APP_READ_BLOCK(a, len)  memset(sd->data, 0xec, len)
 #define APP_WRITE_BLOCK(a, len)
 
@@ -872,7 +870,7 @@ static void sd_erase(SDState *sd)
                 continue;
             }
         }
-        BLK_WRITE_BLOCK(erase_addr, erase_len);
+        sd_blk_write(sd, erase_addr, erase_len);
     }
 }
 
@@ -1903,7 +1901,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
-            BLK_WRITE_BLOCK(sd->data_start, sd->data_offset);
+            sd_blk_write(sd, sd->data_start, sd->data_offset);
             sd->blk_written ++;
             sd->csd[14] |= 0x40;
             /* Bzzzzzzztt .... Operation complete.  */
@@ -1929,7 +1927,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
-            BLK_WRITE_BLOCK(sd->data_start, sd->data_offset);
+            sd_blk_write(sd, sd->data_start, sd->data_offset);
             sd->blk_written++;
             sd->data_start += sd->blk_len;
             sd->data_offset = 0;
@@ -2077,8 +2075,9 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     case 17:  /* CMD17:  READ_SINGLE_BLOCK */
-        if (sd->data_offset == 0)
-            BLK_READ_BLOCK(sd->data_start, io_len);
+        if (sd->data_offset == 0) {
+            sd_blk_read(sd, sd->data_start, io_len);
+        }
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= io_len)
@@ -2091,7 +2090,7 @@ uint8_t sd_read_byte(SDState *sd)
                                   sd->data_start, io_len)) {
                 return 0x00;
             }
-            BLK_READ_BLOCK(sd->data_start, io_len);
+            sd_blk_read(sd, sd->data_start, io_len);
         }
         ret = sd->data[sd->data_offset ++];
 
-- 
2.41.0


