Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B3AC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0i8-0004sT-OM; Tue, 25 Jun 2024 03:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0i7-0004r7-7i
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:35:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0i5-00042o-M9
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:35:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-424798859dfso43620855e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719300924; x=1719905724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkL+F609blkCP7YhkbDtjFQ52Ff3yQ68oguPONbJIG8=;
 b=XhjLj5bRAIS9pow3Ewos9Vqixrh/KdJ3/zW010ce7gV05yssSWIg15Wow+eYIQj73R
 soQKvnhLNK9Me9MawxbuHlVfxvDbdo8Is9RzbtXEZHvdE1Wvn7ej7c8KUHVgBAksIH5L
 MvfrrUszAAnAf/yrS/YWKyDUNcxD9KNugFT1z6ds1aEf/yzTS94etiLaLOxkqlm9T4qg
 ftGD7yYzurTfQvcqGcwCRLxeERngqQqSFdMcKAtp7zpmxHh0TO8T8XTtIF4aM8iEOXj9
 ATwxKmRuUUsDo9P34S5ulQHXwGMPBdSB9EjMyCBz2X4EbW8vsGHFiXBObgJs+8tG07Zz
 Aygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719300924; x=1719905724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkL+F609blkCP7YhkbDtjFQ52Ff3yQ68oguPONbJIG8=;
 b=RWDB/HbLe+odQMZiGMWDK6w73Llr3/mYEyq+/lQKXv+gjLN0LfCeeirdtJiBIUOkE/
 Ezl5cBNNG8VIHUyxINyn7bCIsDiqf5/J+6GAJlTRh/MgPcCsdgMymUBCyW2slWoQKc49
 aSavk4kVkNez4okKyHH1yOtqH03oiVGSo3HCg7XjuIyPwc5Ytn1Pqo7nCLFEpP4u6eSz
 oiv0GiqY2LVzdppXCpcgoNVLcelRLq4Hdz67HrhGb3TRrI+AGHm0Z7dae7bJXPVSknDi
 zctcBRrWQSJ5fH+r2omILOk5f9Im428Wo0y7NSbZQqyXqhBpe0BNBDxTfwERuSau/fBN
 1WUA==
X-Gm-Message-State: AOJu0YwgpPzl/e2vtAHGUQdX6kS6I5hSCiOm4TkgQ2cj/aTjbPT5MSbv
 f0RPjGkn8KbHiN6+2pI4qOF0Y0ViOGjoLDO73uCt1Kg1GMx1DHra7MSxiLr/gnU4X3i/1OcpVB5
 t
X-Google-Smtp-Source: AGHT+IGY2ql7Ry5epaD/h9fSFRPKqIjlbP6VVZa0yJxSpdUOj45HiIiVylLL5WrJPaz6Ko5hNxu0TQ==
X-Received: by 2002:a05:600c:470a:b0:421:7fb6:511e with SMTP id
 5b1f17b1804b1-4248cc5931bmr43876865e9.30.1719300923941; 
 Tue, 25 Jun 2024 00:35:23 -0700 (PDT)
Received: from m1x-phil.lan (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d208e13sm198393945e9.36.2024.06.25.00.35.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jun 2024 00:35:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 7/7] hw/sd/sdcard: Convert GEN_CMD to generic_write_byte
 (CMD56)
Date: Tue, 25 Jun 2024 09:34:41 +0200
Message-ID: <20240625073441.34203-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625073441.34203-1-philmd@linaro.org>
References: <20240625073441.34203-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
 hw/sd/sd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 82b44b65e0..fe2210d65a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1633,14 +1633,12 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 56:  /* CMD56:  GEN_CMD */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->data_offset = 0;
             if (req.arg & 1) {
                 return sd_cmd_to_sendingdata(sd, req, 0,
                                              sd->vendor_data,
                                              sizeof(sd->vendor_data));
             }
-            sd->state = sd_receivingdata_state;
-            return sd_r1;
+            return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->vendor_data));
 
         default:
             break;
@@ -2085,9 +2083,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd->vendor_data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sizeof(sd->vendor_data)) {
-            sd->state = sd_transfer_state;
+        if (sd_generic_write_byte(sd, value)) {
+            memcpy(sd->vendor_data, sd->data, sizeof(sd->vendor_data));
         }
         break;
 
-- 
2.41.0


