Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A83C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0hx-0004er-Kv; Tue, 25 Jun 2024 03:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hw-0004eU-62
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:35:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hu-0003yS-Do
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:35:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-421eab59723so39061615e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719300912; x=1719905712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qb2qfxjBpxYILlILF5IkDh+mD4sc48rfhXmjHKKwuZ4=;
 b=a7VOfH2EFYw45itsza6Ow8skCBh7gBVitnTzDtjQsS3vddTLfgfvPeWr4LpnMam7rT
 SagxSnFUxTgSo9+ZvRSL3sSPKO8kSGxOP3mV12JNgVSxpm1le6dFb0YFB07lYrqaExUx
 ojA3SHJYHLF6jVXBjwV+giS2n7gz1TI0WNaxNQUm1WWZt3nN57H+d7m4uUK3FVsco7lH
 EuQ9jEO/7WgqJV04UuQGNXnFosiaAkJyQJ0wGHz4nlvwIcrD4Bs4+hGub5ue/2h+K4PV
 4GXc8Q3Ckl0Th6jnSsdiwQrW2lZ68BFf9DO+JtisZyn1NidTCf4r1Y9OprMvJ0LSo/m8
 eZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719300912; x=1719905712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qb2qfxjBpxYILlILF5IkDh+mD4sc48rfhXmjHKKwuZ4=;
 b=p+ke/026zrzAlMYVxY7hCMFbSnKfsmpcf6lho76U3OjkvyDfX+n6nP7FAaNK9U4wkA
 Ksp+rBxPXwFUgvqwHc3P98ZdCRKFqY1wPywsdhspupftTbhRbn4bzsBrNC5yEuQcFD+U
 Q0TtNVFczGMG9acu1SBUV8aFeynlsBn1ZYiAHYUgzFbJH/+UoF7j9WmKra8UtOsr4oNL
 PlUbt3aBhPViiY07N+HnejpTIgA3fXnFIBsaG96OMxTxnM1pF/JDT9A9mjgLK02f19rR
 m2rf7/MZnh/0kPWDfc40nzfjqxaiFqtLFsXoX8jTar5NIdRt1zV4uG0Vg/2EpX88uESI
 nqdA==
X-Gm-Message-State: AOJu0Yzl9Pcizn2btwApiVfOnEhkzEWPiX7qMnxjafeK3c2Xff/CR5t5
 5Lxejyb2gvKM6YjOekvnDgmznxZR7rezyydh6Sjox+0BufBT8xTshDPpMrvgWIkd7q8mNB3eJAE
 g
X-Google-Smtp-Source: AGHT+IHjRWkYjBp9nOHPeREXvDg6hjhWtRfLknO3y12fQE4OPz7NhFTF+03Vve11pSmGoeoLGtaLVA==
X-Received: by 2002:adf:e6c6:0:b0:35f:2725:f6cd with SMTP id
 ffacd0b85a97d-366e4f0bf67mr4989189f8f.59.1719300912648; 
 Tue, 25 Jun 2024 00:35:12 -0700 (PDT)
Received: from m1x-phil.lan (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638e911b8sm11991956f8f.62.2024.06.25.00.35.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jun 2024 00:35:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 5/7] hw/sd/sdcard: Convert PROGRAM_CSD to generic_write_byte
 (CMD27)
Date: Tue, 25 Jun 2024 09:34:39 +0200
Message-ID: <20240625073441.34203-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625073441.34203-1-philmd@linaro.org>
References: <20240625073441.34203-1-philmd@linaro.org>
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
 hw/sd/sd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9db3b32b0b..b0f29034c0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1494,17 +1494,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     case 27:  /* CMD27:  PROGRAM_CSD */
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
+        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
 
     /* Write protection (Class 6) */
     case 28:  /* CMD28:  SET_WRITE_PROT */
@@ -2072,8 +2062,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 27:  /* CMD27:  PROGRAM_CSD */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sizeof(sd->csd)) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->csd); i ++)
-- 
2.41.0


