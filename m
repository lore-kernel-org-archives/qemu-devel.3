Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E70C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs4w-0001Y2-DM; Thu, 27 Jun 2024 12:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs4u-0001Xd-U2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs4t-0004Wn-CA
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:32 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-421f4d1c057so63812855e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506069; x=1720110869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vBMoM//nVZe9CjYveKRdhPX/dFzNyrTxzPZ8neKDDk=;
 b=JiCddBWrglWdXlEz/eMnm2CAMaEA1zViytrpsENmb+qahURIp8UY0JJv4UUTwSZsrU
 uHhRntqiSAonTAU9wTFgY3WS9TXAfPF47RfKehgGkkwUurbbYO5P4W9y/N8mDDXd5I2X
 y7JYu1Fn6TC7pQ7F7UkDLLwkwlRA/p7JWH1RGQYQbbzmOr2A1OemRJs/dvnQC2WaVmIC
 mcRuwVUUYsEjaZCE/JCIVyYgqF8Cc62Y1H/ryVm8fTGQUPDmj8Mr5GFbFskXU2cirOXo
 nssCZc2OhFxrVF7ckSqTa1FCkPf8O9KPH5wZiltJEEopHIHn6wmp8xKrQE2eoNKTWzlj
 dmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506069; x=1720110869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vBMoM//nVZe9CjYveKRdhPX/dFzNyrTxzPZ8neKDDk=;
 b=FbZSTMTSWpIPkKt7cqyhxcN1vog+UksAQf9xAIfUy4qBN7QnGIaJAX6Zam9xw5K151
 NIxSvFbDP/tB3fYFl1w/Ey7+NJmxWG7NYvmdJLXmVzZeLvIfKs2oNroU9ppVIJNs8YNu
 gMYMh/MWOFFgIbpI/JHqQyFhodFiD8yDg5l6h3N0XPXJke435+2eOSEDhov/+zgM8sR/
 YMvQdjpSa/LmoBa4ZuSMoHrJTpozEUsaBUOON80n5uvY6h5aa22b1PdbTG8Pu3dIcjpN
 MJlNARjPSoUDozNK0+Moi90kpq+VNNXEJiaqylxtvHiBc8kfDVYz1sNyw7j5uhd7tfkP
 9/Tg==
X-Gm-Message-State: AOJu0YyZ+mehjLeAQw0CBxru2w/Ixw5Yl2owL9Fnl3sz88YI9XQnmyVX
 sM2AkUxM4AVbarcGXVOdYs//Qb+VcsA7UTTz7thezLPJJjgi9a0HMiTh7YFFkM+BbUFFRLaAMK2
 3DT0=
X-Google-Smtp-Source: AGHT+IFL2lh8jczBTPXoaTUIchyMuIhJJHm6yjhzuitt97QvEz8C4+BRijZYX7Ecit2llpmVytu/IQ==
X-Received: by 2002:a05:600c:4851:b0:424:abdb:9c67 with SMTP id
 5b1f17b1804b1-424abdb9c84mr40851815e9.40.1719506069544; 
 Thu, 27 Jun 2024 09:34:29 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c837a958sm71106395e9.27.2024.06.27.09.34.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:34:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 2/7] hw/sd/sdcard: Duplicate WRITE_SINGLE_BLOCK /
 WRITE_MULTIPLE_BLOCK cases
Date: Thu, 27 Jun 2024 18:33:58 +0200
Message-ID: <20240627163403.81220-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163403.81220-1-philmd@linaro.org>
References: <20240627163403.81220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

In order to modify the WRITE_SINGLE_BLOCK case in the
next commit, duplicate it first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 690a3f275e..5dbfc8000b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1461,6 +1461,35 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Block write commands (Class 4) */
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
+        addr = sd_req_get_address(sd, req);
+        switch (sd->state) {
+        case sd_transfer_state:
+
+            if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr,
+                                  sd->blk_len)) {
+                return sd_r1;
+            }
+
+            sd->state = sd_receivingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
+
+            if (sd->size <= SDSC_MAX_CAPACITY) {
+                if (sd_wp_addr(sd, sd->data_start)) {
+                    sd->card_status |= WP_VIOLATION;
+                }
+            }
+            if (sd->csd[14] & 0x30) {
+                sd->card_status |= WP_VIOLATION;
+            }
+            sd->blk_written = 0;
+            return sd_r1;
+
+        default:
+            break;
+        }
+        break;
+
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
-- 
2.41.0


