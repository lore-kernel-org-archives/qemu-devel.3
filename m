Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FF6CED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxysn-0007tC-Ru; Mon, 07 Oct 2024 21:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3f4gEZwUKCuAVCXKRIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--tavip.bounces.google.com>)
 id 1sxysQ-0007cD-FO
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:03 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3f4gEZwUKCuAVCXKRIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--tavip.bounces.google.com>)
 id 1sxysO-00006p-NB
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:02 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-71dfa361499so2100210b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350337; x=1728955137; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tX+6Z1PHnYxk320Y4l1d37qXLvaekBWmUkrZNyFnhQ0=;
 b=dbmY/ZCjpBKcnfie7FHk5Q4XREW4d0AptJVY+ZUQHuTYy8ax5kwtpdbdpBrfT/dPto
 gCfL4xLURjBI/XGpHdnv3uEX5IwoEzycP1/LqTI6U26Igs36HmvpOnDjpaf9JHN2jooj
 4aNs2TswgWE/VnRHisRqPUxe2hKhV7q/0SaE7DBPV3SuzwyvHjlN4u8awvcosoz3ANSx
 9uk9ARuHIvWSMKb0HBUZfmQQb03EqyY8o+0McglPlOk9LbWwwuhFSg8hswt12VdSXUGw
 TVt293mW22HU4nMSxC7jDDR11CGZ/5Qi0teN1rXk5Bx1PwmdODtYsUQhqP9UFxUFp98D
 QD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350337; x=1728955137;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tX+6Z1PHnYxk320Y4l1d37qXLvaekBWmUkrZNyFnhQ0=;
 b=iDnRWt0/rvv/2mJvpxDCDzkD4gRmX8jHeuHUWJsv0Oj75bAQV2fBAWkUjwCxddlA1d
 uvlvH37QjR5tbqlrKRLxPgMr8c7TU9x9W1O0tjhtNJNte+k8tvortSItOJGyTTOmIbmE
 nNDB2ok3laoFtzC1Mffjnr2JVEqxsd/hh54IM9sciwSwXyvI/BNAvXgGETo+CRsuN4cX
 o8QjYr4a8lmo/BWH1T2qiWOJ+JGyuso9myFgzIiCC4yeyHKuqBMMYyYtlnjbXH2mS8SF
 zqmKPQxTIC/hLoNBbQilbU4CdwLo/0aCfTxlBJ4vIRCw9o4SXYOLa9b4Gt+dU8v4d6+O
 vk5w==
X-Gm-Message-State: AOJu0Yzg3BkTAWy3Sejd495u5jVKR/GNeHLcfVNir9uCVtl/MeoG/VHX
 tdFqMjEU76U5BxGJFN64Hxz47KLvmbZGquEONES9BqtTAg1tBWT2GHS2pDDNO0sl6q5kM8xPJ6V
 86bkCB9QEBz4wlp43PNSK5zx6ISH6MLknVc5SS9A7zEQK0VhXKWzJV8eq1xwHgfQe0r7D3gsV7r
 zKJ83JcqbRoy24wBWgiYtjh2CyrQ==
X-Google-Smtp-Source: AGHT+IFcS0b2L6CwNcAuaaxIJ0yPVF1XIP3tgzQU+rGCAQO+Un5l5gv5AKJ7m2pQ1hJxX6pAHEEMx7pv1Q==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:8c0b:b0:71d:ef26:2c6f
 with SMTP id
 d2e1a72fcca58-71def262d76mr15806b3a.1.1728350335998; Mon, 07 Oct 2024
 18:18:55 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:27 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-2-tavip@google.com>
Subject: [PATCH v2 01/25] fifo32: add peek function
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3f4gEZwUKCuAVCXKRIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--tavip.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Add fifo32_peek() that returns the first element from the queue
without popping it.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/qemu/fifo32.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
index 4e9fd1b5ef..9de1807375 100644
--- a/include/qemu/fifo32.h
+++ b/include/qemu/fifo32.h
@@ -140,6 +140,34 @@ static inline uint32_t fifo32_pop(Fifo32 *fifo)
     return ret;
 }
 
+/**
+ * fifo32_peek:
+ * @fifo: fifo to peek at
+ *
+ * Returns the value from the FIFO's head without poping it. Behaviour
+ * is undefined if the FIFO is empty. Clients are responsible for
+ * checking for emptiness using fifo32_is_empty().
+ *
+ * Returns: the value from the FIFO's head
+ */
+
+static inline uint32_t fifo32_peek(Fifo32 *fifo)
+{
+    uint32_t ret = 0, num;
+    const uint8_t *buf;
+
+    buf = fifo8_peek_bufptr(&fifo->fifo, 4, &num);
+    if (num != 4) {
+        return ret;
+    }
+
+    for (int i = 0; i < sizeof(uint32_t); i++) {
+        ret |= buf[i] << (i * 8);
+    }
+
+    return ret;
+}
+
 /**
  * There is no fifo32_pop_buf() because the data is not stored in the buffer
  * as a set of native-order words.
-- 
2.47.0.rc0.187.ge670bccf7e-goog


