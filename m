Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0247BC87FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 00:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujor8-0000WW-FF; Wed, 06 Aug 2025 20:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31eiTaAgKCkIflmppmivksskpi.gsquiqy-hiziprsrkry.svk@flex--bhillier.bounces.google.com>)
 id 1ujno4-0008AH-RU
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 19:44:28 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31eiTaAgKCkIflmppmivksskpi.gsquiqy-hiziprsrkry.svk@flex--bhillier.bounces.google.com>)
 id 1ujno2-0002P2-2i
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 19:44:27 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-76bef13c254so463642b3a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 16:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1754523861; x=1755128661; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ONbEKVN/AZlJkSiX9R+Cf20vBrI+oWoGS0g6VeJ0HZ4=;
 b=tJY8bFRHSc1d25o9BIwp4Eum9H6vNuJQTYlIFtZbf1kEPfZ+WT8YlJLX7ywzoLjhHY
 xDPdEApFiVq1R5bes70HYLXWqHiMQZ1WhhnSyGr3qbnCVE3P/ky1/lEy5oqCQ3y0Ez7f
 3N+K/YJkHJzUbiAR9CVGWHy7iHA+k9FBF/1LXRt2jhhr4G70kqhjlUSqUF5xpe8GFD13
 aJ4qtIqNluEoJNAOB+ZWX3SAdLKf7HOVQE8LZ3C6nkJRp4FIzA5j9eGAu/C0dhxeNG++
 P3+oK9GDWmrCC+k4hiCGjlklSpy26Fuy5E4kyBjsutDD28/EAfwmbh0Hy1ahpavNPfvz
 sLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754523861; x=1755128661;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ONbEKVN/AZlJkSiX9R+Cf20vBrI+oWoGS0g6VeJ0HZ4=;
 b=IhNYepxtuYmufP2arTmCVz/37fpdq2uKzRc5I8t6szAxJBWAFLrwu4Zh71+ye1cx/1
 gz734lBXHQJgLybhz3lob6iyMUPjpZHeXLkeRuKqc7K3BiTVRG8tsqCooxaeybB5b4Fb
 /VOoa5MUGrWLQ3wkf9py+6R5X0sm6UkfN60nN29x+no3lHCgnuJZUCpauHIckDYvXAEp
 Sfwt+FoDJcZMPNkQV/2hArX6Gbe1hrlOg/ZRM7f2tozV8+GVB55nz9KcsSS/kKp+C/kU
 SM6+9peW8bdbbIzde4UugONkVgbzHbCJ8VXTNaZUCkBkwurD32g9C8rpsjJ/LSrXcg8G
 PMhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFFOaJAxjSoNQjpb8KzgbP9KlI/JNckvBQMj6pE2GmPqiLrjqtO5GsKR/Jybb5DUqIPI5tEhNoddCe@nongnu.org
X-Gm-Message-State: AOJu0YzIBKFAdxEZnQ72M6zRnAeAJRFZaCtiKmcdnWgQyB6qitm21bJy
 M2LNbdTjz6+DGMcHG6wjPbqzl0R0rabuYhnpns+iPctV3meZE6M5uvESjAheGJD8MZFy2Idi/4y
 MQyYKzgxnVXYZfA==
X-Google-Smtp-Source: AGHT+IFkXoo7ViXbM9I2Z0jYSlQEa508nrqi89YBurCasSjIKm8bxwaFvam8jkmtBZu4uiC5tIlA2//gLl9Blw==
X-Received: from pfbfm16.prod.google.com
 ([2002:a05:6a00:2f90:b0:748:fa5b:4163])
 (user=bhillier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4c8d:b0:76b:ea1e:78b9 with SMTP id
 d2e1a72fcca58-76c3727388emr1573822b3a.1.1754523861003; 
 Wed, 06 Aug 2025 16:44:21 -0700 (PDT)
Date: Wed,  6 Aug 2025 23:43:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250806234342.811926-1-bhillier@google.com>
Subject: [PATCH 1/1] hw/sensor: add stub for ADM1266 blackbox
From: Ben Hillier <bhillier@google.com>
To: wuhaotsh@google.com, kfting@nuvoton.com
Cc: philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=31eiTaAgKCkIflmppmivksskpi.gsquiqy-hiziprsrkry.svk@flex--bhillier.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Aug 2025 20:51:41 -0400
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

From: Titus Rwantare <titusr@google.com>

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/sensor/adm1266.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 9017ce6116..cd11526c2b 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -75,6 +75,7 @@ typedef struct ADM1266State {
 static const uint8_t adm1266_ic_device_id[] = {0x03, 0x41, 0x12, 0x66};
 static const uint8_t adm1266_ic_device_rev[] = {0x08, 0x01, 0x08, 0x07, 0x0,
                                                 0x0, 0x07, 0x41, 0x30};
+static const uint8_t adm1266_blackbox_info[] = {0x04, 0x00, 0x00, 0x00, 0x00};
 
 static void adm1266_exit_reset(Object *obj, ResetType type)
 {
@@ -125,6 +126,17 @@ static uint8_t adm1266_read_byte(PMBusDevice *pmdev)
         pmbus_send(pmdev, adm1266_ic_device_rev, sizeof(adm1266_ic_device_rev));
         break;
 
+    case ADM1266_BLACKBOX_CONFIG:
+        return 0;
+
+    case ADM1266_READ_BLACKBOX:
+        return 0;
+
+    case ADM1266_BLACKBOX_INFORMATION:
+        pmbus_send(pmdev, adm1266_blackbox_info,
+                   sizeof(adm1266_blackbox_info));
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s: reading from unimplemented register: 0x%02x\n",
@@ -154,6 +166,9 @@ static int adm1266_write_data(PMBusDevice *pmdev, const uint8_t *buf,
         pmbus_receive_block(pmdev, (uint8_t *)s->mfr_rev, sizeof(s->mfr_rev));
         break;
 
+    case ADM1266_BLACKBOX_CONFIG:
+    case ADM1266_READ_BLACKBOX:
+    case ADM1266_BLACKBOX_INFORMATION:
     case ADM1266_SET_RTC:   /* do nothing */
         break;
 
-- 
2.50.1.703.g449372360f-goog


