Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EAEC3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzOl-0001r5-Ni; Tue, 25 Jun 2024 02:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOk-0001g2-A9
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOi-0005nO-Mo
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-424a2dabfefso2607065e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295879; x=1719900679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LWLsRRbYaLOv+/TgGcQ+HiQIJoOeLaCOvEip4a3OYs=;
 b=ZpYtu0XvWi/pN2eiul66Q/tdOhf+bZq+cs8aQLUJ6Gcy76odXV+ll5DjWmyVv7DV6z
 9xYvT0EBaadt9oZPVc9B8K3onz+0pHX/m/ZEVXNZj2Oz5svmuzt8OmVUEv9NPqeLxLTC
 Oo3eKqSj/3H86xjEOfsu9eQOPSjWUgULW89JUpKRLD6We2qW7lvDS+8EZXrzmBOg9gz4
 0oCk+lpzqMI71fuy9aZLBv2v3QnV2xsBoN1c4oQRNzHEMs6r6EqBS+Y5rwOEiU/9sCoy
 fZ9LIU04Ubjw6t7br3kEfNerA9eY2PIr4omKSwVTfA8wgI8Cb0k1aj5JLbuIh2oXW09x
 KnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295879; x=1719900679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/LWLsRRbYaLOv+/TgGcQ+HiQIJoOeLaCOvEip4a3OYs=;
 b=HcAO1R5GADk2VCQtel1J4fHu4VPb+fknVRJErLo6qC3/z2ocP+kZdPoZNg6VP2CEA9
 gqsOLVus6QRZzf2P2cIQDpGw/0zWPcm6zNcG2VpNDSpqpkLLgzWhBVBvhspiT5dgqGgK
 RE6fL6EoUDeFKeMeU/ClmdOOxfc/wFhgG6Yrx6BHKoki+exc/5VGF6qGElHJLrkF1TlW
 IuzTdmNZtzyBoamGdZ8vLoIVbZQdZGYI397IibgP3A5jpmZHU1X9YdMMNRifhqlyBWrC
 lSshfJqPNOwKG3uG5kJt3vPW164eeNfvbVp8gwLF0VqQ8z7UHyahvf8RGVlgKB7COLpU
 uMow==
X-Gm-Message-State: AOJu0YwONu73RCTusmLr/HQ4xBp5n57mQStTxipSLNcLYJiQYBKLyiju
 kP8AjVA2AbIqMnKIon5jfuvwClblbEdEgFVC9lD8F7u812+dfIgZ76p2i57i94Cht9DuqITg+cO
 N
X-Google-Smtp-Source: AGHT+IEXqJuSFY+L4pXWvD8yvS3/H/5rYmguUcDx1lc/44QcUyYq0rFIycLBJZ/jNm0A+RX3BEDNmA==
X-Received: by 2002:a05:6000:2c5:b0:366:e9dc:6dcf with SMTP id
 ffacd0b85a97d-366e9dc6ddcmr6726438f8f.42.1719295879001; 
 Mon, 24 Jun 2024 23:11:19 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366383f687dsm11948295f8f.15.2024.06.24.23.11.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:11:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/11] hw/sd/sdcard: Convert SEND_NUM_WR_BLOCKS to
 generic_read_byte (ACMD22)
Date: Tue, 25 Jun 2024 08:10:14 +0200
Message-ID: <20240625061015.24095-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625061015.24095-1-philmd@linaro.org>
References: <20240625061015.24095-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2f00184bb3..023fcc63ac 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1693,11 +1693,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
         switch (sd->state) {
         case sd_transfer_state:
-            stl_be_p(sd->data, sd->blk_written);
-            sd->state = sd_sendingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, 0,
+                                         &sd->blk_written,
+                                         sizeof(sd->blk_written));
 
         default:
             break;
@@ -2116,6 +2114,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 13: /* ACMD13: SD_STATUS */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
+    case 22: /* ACMD22: SEND_NUM_WR_BLOCKS */
     case 30: /* CMD30:  SEND_WRITE_PROT */
     case 56: /* CMD56:  GEN_CMD */
         sd_generic_read_byte(sd, &ret);
@@ -2145,13 +2144,6 @@ uint8_t sd_read_byte(SDState *sd)
         }
         break;
 
-    case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= 4)
-            sd->state = sd_transfer_state;
-        break;
-
     case 51:  /* ACMD51: SEND_SCR */
         ret = sd->scr[sd->data_offset ++];
 
-- 
2.41.0


