Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B19EC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs5G-0001lL-Je; Thu, 27 Jun 2024 12:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs5F-0001iz-NB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs5E-0004Yq-7G
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4256742f67fso5169205e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506090; x=1720110890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBDncTLnw5e5+FewhpyrEtD081BWahb+ptMB4QhJVa0=;
 b=SN24iFVgfiw6f7qwlWKvnatbwKFQe2pfysgT03Bdn3W/bGZ1LQ5vIlBHqw6YQEJJuc
 +9y3umArY3lxpVjT+BZJUNmXapQVzh6vMIZXu8VjiuDDf+O3q2i78jQliEkaLA41DPjj
 EsKt5a8zgVS9U92BS0qLO1VEi4aFrikD65yp6PRKdQiNIrnXH4IjggNFahIoEzWve6UE
 QhumdqmmBTBQtXe8KgqzoVVzo6Yeqz8r1HyJrDcErhX8iboRKE4yIyysCf8f1Ttjsif3
 XmxOxRr4x+6ASjNOB9fCL8gjOTjUDCV9AkRM3GRbbU1ZETp+VlygStDxzUARU480hBTc
 M7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506090; x=1720110890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBDncTLnw5e5+FewhpyrEtD081BWahb+ptMB4QhJVa0=;
 b=ieMiWCItWAvQFF0n/v/C3ib7Wn9hY9YXzFuWKAFEbS8KhCprwoZLjTzW0lsyodPzU6
 c5I2uEIdSbuDzKVWpwzxTJg5tWjvlGCLyd/TA8JPbKzdZmz9OPnQe85sLSNbZMO+Xtqt
 q7XkH3yClXHS9yghU8ELz7cyb2Znv6N91zTVm12fLk/w+YHifAx1Z0hXpS016s8L9AKq
 kDPo16OL8KEw51VYMf9awixdvHlNbLhnWClrLH7vxUP7kKEr2mdqBfW/hkh1VRz+4awv
 Kdfd2JGaxrL41esp1wOPLSOrZLSjlS02t84FtndklIAdND/ZmH6DIL6011h4G9voGCS4
 sAuw==
X-Gm-Message-State: AOJu0YzsDCJJxU2MLtg/Fi2bzpiMVlFP64thRxHDxJa4r9k2YAVXdFLO
 x7dviyAphkmYWRCAbX0T5CKnRQ24O3yOrMiSb456skJsv/ap/s4IrMD4mysZwNL4Gt9UoMSMiyY
 Ytt8=
X-Google-Smtp-Source: AGHT+IFjycMFJtbYfQl9HQFXWBtd8TCgZNDgCxPjnUDWj9n+mk7A5OlGhpY1UmXkfHOje0QBJR4iUQ==
X-Received: by 2002:a05:600c:22c9:b0:425:6275:f7a with SMTP id
 5b1f17b1804b1-42562750fbemr28834225e9.15.1719506090468; 
 Thu, 27 Jun 2024 09:34:50 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8280a87sm75720715e9.24.2024.06.27.09.34.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:34:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 4/7] hw/sd/sdcard: Convert PROGRAM_CID to
 generic_write_byte (CMD26)
Date: Thu, 27 Jun 2024 18:34:00 +0200
Message-ID: <20240627163403.81220-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163403.81220-1-philmd@linaro.org>
References: <20240627163403.81220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
 hw/sd/sd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4a03f41086..b9c72a0128 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1515,17 +1515,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
+        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     case 27:  /* CMD27:  PROGRAM_CSD */
         switch (sd->state) {
@@ -2088,8 +2078,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sizeof(sd->cid)) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->cid); i ++)
-- 
2.41.0


