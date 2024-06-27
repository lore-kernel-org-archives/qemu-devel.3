Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869F0C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs5N-0001t1-UK; Thu, 27 Jun 2024 12:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs5L-0001p2-No
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs5K-0004ZS-7I
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42563a9fa58so9513805e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506096; x=1720110896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6Piulxoj8zPwW1Yv8YFFcFYZqBjXPSZ0pu/dRDGp6Y=;
 b=S3l07bbL8wEOFBG6Egt5VJE6JmoOuuP+AO3jZ+FFb8mlWGC0MPhAbkEV5mpNsXXYU0
 ueli/iHLuYCRKuAmK8k12FKcN/DAUylcPTPyKLWFxOPUvNQnGB3xf4eJ1niXKGq7jamv
 qAMDWS8M4BdnrZQA4lR1WroEQxSRDKdZs80QIM3yZzS8HBUOobdJ9rj+Wz7kvis+clSt
 c9LaatXjIqZKG12+bHYKkS/UvUcx8/kMfixhXEGx+S+Dje/gjQYkmWX1oMHW9ApNkuj8
 lTSGf3RFvR1VgBkL0jyVSCx4FsCkXt/eJeMqdVD4vFzjKlZxNQsHKZlWxorJmyOePJn7
 /DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506096; x=1720110896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6Piulxoj8zPwW1Yv8YFFcFYZqBjXPSZ0pu/dRDGp6Y=;
 b=pVBSjXZvRtRUpZH/wNQaO0GGGwsKPCtFFfPNK5LRYFdY0jTaQzuZlzqMgS9TnJ9SvD
 vnX4cMD2D9yCGAzFConKZbLZe6gG33C+xWMimvwVI032od3fHlDXAWwqHDSfJHaqYx40
 cQjXvjbGToPq7PK17HMFwxopqVJ9QLH1mAuGU2hAsHZ6gxBNoeJFHjBuPTVyOMNdS4Z8
 pyg/BH4+BznacLznsmO7OD1X0UnVcbhFxIYauIoF+QXJszCVS2ks+pOsbJommLIO0v8R
 gbJEF2brhg2jcAxaJwlS+Xd6Nosxx8qK59PSctIfyxJOgjePBLme3l/1bMy2hjJ+czvy
 971g==
X-Gm-Message-State: AOJu0YyWE02NKZTlMxlDk9zowenWVt+bTBwtvGBqLD8CIFJ0kxhnyyn1
 isKamnrXTJJek9PoD+yy5lyHUY7MvLW9AcXxrU9myzswLx6oF5iyICHo52ZILfJcgH65lJd4ZvQ
 zsj8=
X-Google-Smtp-Source: AGHT+IHlrHip9w5BYhhMjlc9mdGK3epxwEAlEqYQqvm3FijUbRCvul2ztTlvHEhpN+oCeSsvw/43+A==
X-Received: by 2002:a05:6000:2a8:b0:367:4dce:1ff5 with SMTP id
 ffacd0b85a97d-3674dce21f9mr1772490f8f.32.1719506096486; 
 Thu, 27 Jun 2024 09:34:56 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674369eb17sm2371070f8f.93.2024.06.27.09.34.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:34:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 5/7] hw/sd/sdcard: Convert PROGRAM_CSD to
 generic_write_byte (CMD27)
Date: Thu, 27 Jun 2024 18:34:01 +0200
Message-ID: <20240627163403.81220-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163403.81220-1-philmd@linaro.org>
References: <20240627163403.81220-1-philmd@linaro.org>
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
 hw/sd/sd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b9c72a0128..bdd5f3486a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1518,17 +1518,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -2096,8 +2086,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
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


