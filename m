Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44489C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsfd-0008Nj-UV; Thu, 27 Jun 2024 13:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsfY-0008Ab-Bv
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:24 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsfW-0002Hv-PQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4255fa23f7bso15163645e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508339; x=1720113139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9Lv5oRHhagfJkOeTGJdPKagMg6fgJmQOzE+waR1EWA=;
 b=WFbFROm34UxZorvMkRKKGtpRHQMQaTtofOS/ynldgAz9fG3CNPWLhGdvUoP8O7m9oa
 b4LbLRFdp2SQwa4xuN2N2S5HmSA7vYq85Mc3CbcZTU3QgMUqRcMai0aiRLDMQr3DvK4y
 2AG30CUMUUxLCOqW2zOTNWl5PWBxB8dBe1l7mAgok84GWmIxXDKgGRqTpmM5VgmffKLB
 fjtloFRfpEa3Wa1seD/9Nedr0UwE75ecrUhycFM1IKbg3gqglprsLyilyEs62DV3QBw7
 /7GkyH9IIiZIe1XVpe9SlRzJbZWjnZMAsBf22WsbFKmU4uyLlKDOUmd4rfYoaqdgEmt7
 vxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508339; x=1720113139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z9Lv5oRHhagfJkOeTGJdPKagMg6fgJmQOzE+waR1EWA=;
 b=FUWQgs9dzG29vKHoirgEph2JnY/N258+iPfQ2l033W9pXEtubx+pO2zBy1l7OzA9e4
 QhV/vBaEmcyJtz1PFymuApGbuzgtDxd3uOq0z0QH5IX2ANlJIaHbXiJK5q85flpKwbeR
 35sMnNInEDb+xfIwFSBuKR4cy0tFfL+L/FNErVjPwePMxNIplkDHJU+S/cXTkEOLAh+3
 Ers8PZ85TLSQn7pARkpxFT2id+ovr3vc55UHdRsucCp0KhHfadtIyN4CHe0WeJO/ad7m
 7RZFNGK6UOJzsADIoN95ip45GUJlnMMaPcEllgOhwJbrdHUlzZopWMh8dj8QH0RaLudX
 1qXA==
X-Gm-Message-State: AOJu0YzP72t8NYI+C928Hta5uLug+4I97AyGBAYbnmZBkknkrbRhYHG1
 bNEY2YuOMWU5ZWcb5VG0RMijUuJuUJ7x5VvRlX1geFowsMW8m2ZF1GX2mqh9PNxreoiO5ssEP+v
 8o+c=
X-Google-Smtp-Source: AGHT+IE2AdN/IeEA0++g8AMnWzZmbanFjQ5pOfLNrP7Lqhaflitu5gVMnfSYB7RrJWT5yGR1qDGBFg==
X-Received: by 2002:a7b:cbd0:0:b0:424:ac14:ddc8 with SMTP id
 5b1f17b1804b1-424ac14deddmr42871175e9.17.1719508338799; 
 Thu, 27 Jun 2024 10:12:18 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674369ed92sm2490144f8f.105.2024.06.27.10.12.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:12:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Subject: [PATCH 07/19] hw/sd/sdcard: Add emmc_cmd_SEND_OP_COND handler (CMD1)
Date: Thu, 27 Jun 2024 19:10:47 +0200
Message-ID: <20240627171059.84349-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

Add support to Power up the card and send response r3 in case of MMC.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c6e5c93acb..2dc0209482 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1190,6 +1190,12 @@ static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+static sd_rsp_type_t emmc_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
+{
+    sd_ocr_powerup(sd);
+    return sd->state == sd_idle_state ? sd_r3 : sd_r0;
+}
+
 /* CMD2 */
 static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 {
@@ -2398,6 +2404,7 @@ static const SDProto sd_proto_emmc = {
     .name = "eMMC",
     .cmd = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [1]  = {0,  sd_bcr,  "SEND_OP_COND", emmc_cmd_SEND_OP_COND},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
-- 
2.41.0


