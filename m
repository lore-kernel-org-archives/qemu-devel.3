Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CB6CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU1q-0005oX-82; Wed, 10 Apr 2024 05:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1n-0005o4-VY
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:00 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1m-0005Zy-4q
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:59 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so7339028a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740436; x=1713345236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6v/aT8rb7X2sUMc6qOL0nZTELiwkre+4QEi5O+6ex0=;
 b=kPLtL3JNKBGeG3HBDtBROCJIkoh20YPzNrRAV9BgDDV7RM9MDOIeFoQu2AbOI4QRGr
 BK/6gg5h4LMeGwJ3cPDaysQHn7afGdtpIQVAP7gCdZpHSYy1XtKZUIShj703XQDDXyj9
 Dr3FeJ0aJX+GB3zUoiqqvF46mbsRNjC/GuldKi7XKFdRSQ8512O4avbsFVTZ/aCoVaPK
 wckOry/44mHmA8VgIOGZrAaqckTaDR/BF51kVdlqdJPTUyaMFa4hVbOVtTRkC9xdYpCX
 dLwNYc//fwk09qWRW4auPVw0RdMPQSHyM5O2Jt5oPdW7KikT0a+/1YufqqT3RET/6jXq
 h45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740436; x=1713345236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6v/aT8rb7X2sUMc6qOL0nZTELiwkre+4QEi5O+6ex0=;
 b=gS7wQ4uphWXV2gZHfuA1Lp7nRqm8UOHFF5BtyEGKGVlXxyVMMQtZz2zfnJCw4qzwsf
 lsSkxDpRcj4f467zpKWPMfQ6OZf1a29IHiKctFZWxeEugGkdMv4lyznY6Ns7+X8fKmrs
 qYS9QETY8X8vyhr6T/zkyUPVd+56W8U7LCB2lfOqhCTA+1R3sPtp3gCpCy4wd6SRRKjF
 QxM2pFbwWHysvWFPiU9DX9CUukwssVRW6vpkdP4HyulA8+2ExPFaOVmT32NM9wAl6oO/
 dNYxRSKnDfNjmWQEbrxpck9WELGd7DcQH8NeZ7Pp/SYfTIi6SgJZZeYSRc3rFT1gcDYF
 PxOQ==
X-Gm-Message-State: AOJu0YzTnrVoTVhkfmsggew+GVZPJNAsAxiyzg5zTbXBLbjRs5H8cX3e
 EXxPLQKO8kQtl+ASb6//nE+VYqaFY/xOUoAyjjRajvx2FbEt8CddW+ePp3vy8ucPJslzE1WWJ0/
 Z
X-Google-Smtp-Source: AGHT+IFLpTKsx+0txJFPrMy80DGUa90Jq8awXkYvxCDNbJ4WVWnB0bo6kjQynHAeBbZnddLEC5xYEQ==
X-Received: by 2002:a50:8a84:0:b0:56d:c722:93a3 with SMTP id
 j4-20020a508a84000000b0056dc72293a3mr1579497edj.21.1712740436319; 
 Wed, 10 Apr 2024 02:13:56 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 c9-20020a0564021f8900b00568c613570dsm6282943edc.79.2024.04.10.02.13.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:13:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 06/16] hw/block/nand: Factor nand_load_iolen() method out
Date: Wed, 10 Apr 2024 11:13:05 +0200
Message-ID: <20240410091315.57241-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240409135944.24997-2-philmd@linaro.org>
---
 hw/block/nand.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index d1435f2207..f33eb2d552 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -243,9 +243,28 @@ static inline void nand_pushio_byte(NANDFlashState *s, uint8_t value)
     }
 }
 
+/*
+ * nand_load_block: Load block containing (s->addr + @offset).
+ * Returns length of data available at @offset in this block.
+ */
+static unsigned nand_load_block(NANDFlashState *s, unsigned offset)
+{
+    unsigned iolen;
+
+    s->blk_load(s, s->addr, offset);
+
+    iolen = (1 << s->page_shift);
+    if (s->gnd) {
+        iolen += 1 << s->oob_shift;
+    }
+    assert(offset <= iolen);
+    iolen -= offset;
+
+    return iolen;
+}
+
 static void nand_command(NANDFlashState *s)
 {
-    unsigned int offset;
     switch (s->cmd) {
     case NAND_CMD_READ0:
         s->iolen = 0;
@@ -271,12 +290,7 @@ static void nand_command(NANDFlashState *s)
     case NAND_CMD_NOSERIALREAD2:
         if (!(nand_flash_ids[s->chip_id].options & NAND_SAMSUNG_LP))
             break;
-        offset = s->addr & ((1 << s->addr_shift) - 1);
-        s->blk_load(s, s->addr, offset);
-        if (s->gnd)
-            s->iolen = (1 << s->page_shift) - offset;
-        else
-            s->iolen = (1 << s->page_shift) + (1 << s->oob_shift) - offset;
+        s->iolen = nand_load_block(s, s->addr & ((1 << s->addr_shift) - 1));
         break;
 
     case NAND_CMD_RESET:
@@ -597,12 +611,7 @@ uint32_t nand_getio(DeviceState *dev)
     if (!s->iolen && s->cmd == NAND_CMD_READ0) {
         offset = (int) (s->addr & ((1 << s->addr_shift) - 1)) + s->offset;
         s->offset = 0;
-
-        s->blk_load(s, s->addr, offset);
-        if (s->gnd)
-            s->iolen = (1 << s->page_shift) - offset;
-        else
-            s->iolen = (1 << s->page_shift) + (1 << s->oob_shift) - offset;
+        s->iolen = nand_load_block(s, offset);
     }
 
     if (s->ce || s->iolen <= 0) {
-- 
2.41.0


