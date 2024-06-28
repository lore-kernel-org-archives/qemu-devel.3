Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016A9C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jm-0006mZ-CL; Fri, 28 Jun 2024 03:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jF-0006Ce-Ae
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jB-0004UF-B8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4256788e13bso2228135e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558538; x=1720163338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K1hpuhYvD8c8zKzHH2qCf+bpB7ESZQppXpuiPvi8zTE=;
 b=XaPqiwVCc4p+ls1P3cIggpfhJe524M30oXzIjI4GJRO+f6qU3R8Aw/LxWkxzl0F85w
 Kvgb/IKO/1zaE6amCCct4ndyEBqqqpulXpmRJZP4Dcn/UMvFKivjRqOvxDuEpVVgs4dn
 6MtCJLd9s2U9xn8kxEWqbmLcSIwFrnGif/GT/1lWV8u/AhpvIrcHdMEdNoJ0z0WMyIP+
 0skaHqYnYyt0nOW9Q+JaB1SeLd+2fYmnGGDMlWDqy/LAgicGSika1O5CV0OJexj8t9JB
 uFrd7LycRBb2cTfHvF8Gf11II/duMF1nf+g9LMvwsyYURtf75Vwvfe6IdMUFo/M+W8rM
 awPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558538; x=1720163338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1hpuhYvD8c8zKzHH2qCf+bpB7ESZQppXpuiPvi8zTE=;
 b=lAAG+FJU7mtHxp8GmD3cdgu6ZD6DzuSn1JErqiM73DXC7J8rH5t1u0HiQRdZApzQae
 wWhlsvjfG9uVj1d6eIOvs37ufSJ7iHnSbIawOpPyBFjiHISkHNP4PKqlnMx/pvsmq+DL
 an9mkMXyMzVaMRt4YhdvJXZQxFmkogSdwjiEnwpnwcjTKUq2+bgr2yAVLmwPjuC2OKub
 QMMThEQqr3M9QrOIkZok9aU9ruEsPJZ8Lvr4WSc9KFDV2vCqgyvplrkxoRNaZZNF80sV
 ou2MbcNnZYoJkVU8r3WY5v1CvC7OlxBHpcH2n8qZ+ERl3+Wx0rO0nWb9UaRM/SfseQpW
 /OMA==
X-Gm-Message-State: AOJu0YzRvf6fD+vZsOz0sM9uwfwxdNP+6u1md2Yj64v1nwKOUWeQ53Pu
 i9p0uWrzlENs5Jhta0U5aRmsKyy8epO3VY/K9DhosBegHZrt5rC5s0z1SI0QhYSVPX4GX607Z0o
 +qOE=
X-Google-Smtp-Source: AGHT+IFPgiw0+qHt7mr0yeKi47Ss/1C0ce1JIkYTzJkiSSCE9rYRPGVJzr4FWejZBVIGMKOfAbrouA==
X-Received: by 2002:a05:6000:184f:b0:366:ee84:6a79 with SMTP id
 ffacd0b85a97d-366ee846c15mr14263981f8f.51.1719558538098; 
 Fri, 28 Jun 2024 00:08:58 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d18sm1325820f8f.106.2024.06.28.00.08.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 66/98] hw/sd/sdcard: Add spi_cmd_READ_OCR handler (CMD58)
Date: Fri, 28 Jun 2024 09:01:42 +0200
Message-ID: <20240628070216.92609-67-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 50cee5ac40..b3b4cd5a3a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1660,6 +1660,12 @@ static sd_rsp_type_t sd_cmd_GEN_CMD(SDState *sd, SDRequest req)
     }
 }
 
+/* CMD58 */
+static sd_rsp_type_t spi_cmd_READ_OCR(SDState *sd, SDRequest req)
+{
+    return sd_r3;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1748,9 +1754,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     /* Application specific commands (Class 8) */
-    case 58:    /* CMD58:   READ_OCR (SPI) */
-        return sd_r3;
-
     case 59:    /* CMD59:   CRC_ON_OFF (SPI) */
         return sd_r1;
 
@@ -2321,6 +2324,7 @@ static const SDProto sd_proto_spi = {
         [55] = {8,  sd_spi, "APP_CMD", sd_cmd_APP_CMD},
         [56] = {8,  sd_spi, "GEN_CMD", sd_cmd_GEN_CMD},
         [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
+        [58] = {0,  sd_spi, "READ_OCR", spi_cmd_READ_OCR},
     },
     .acmd = {
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
-- 
2.41.0


