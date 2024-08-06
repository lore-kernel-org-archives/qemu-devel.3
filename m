Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6C1C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJh5-0004Q5-HN; Tue, 06 Aug 2024 08:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJh3-0004AO-VT
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:37 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJh2-00007e-2r
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:37 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135dso940252a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948814; x=1723553614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBx0ReACLauBHHw6c0ZSc7DkdUMOkNRvc02ZcjHiRGU=;
 b=uuGn/DaCJgBRtNzbOAUHwN+KNLYRPbOjcfyGa4hCpdrwWyfrBIjRldzj7zrDCMS1Mh
 qjKJW0KnyiZRqOs2rTPmiYEi1tByWhs36tDW86LIF5q3ui6xcvxZC84Q6tb57BSAPoUg
 FKS8Ae+fTNqSnTSSe+eXwq3JZ07Rws3PheoNAdGqfF3Yy42WgoOn40pwUzv+jU57QMQi
 pPukO1Y+lVyY2ux2C7/wSR9c+ccY/MEBJXzBxGPhtLfFrPT3+cyKJlzQ9mVcBPAaSZse
 nlPwQ5kWj7n4Z3QVQAvDfyncaolExF5BKKBBXsRcJ4yF5nMxs5jkFk+3t18XXsxzPm3h
 GYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948814; x=1723553614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBx0ReACLauBHHw6c0ZSc7DkdUMOkNRvc02ZcjHiRGU=;
 b=UxBN2Xew4HmJw4VshbaO+fX5K2dEKNuJjnEKq0hy65EWY8NEZR12UoPlJp32PjFr0Q
 Y7BQHr/oHPABbJmwIFL/3hkKVUMUDNg9r2qcdjKjYC0nuEHr0KUFlgRWgeACg6XAwkR5
 Jfke3FG8yOHBP5071K4Doq6LkKt4BcdnVFzBjyMBmPD6ut/5w9eKLXhPcm8mXKA5vXbQ
 EE46uOR5v1Z1khngMLbgg5Q3c/LQhAPt6y8V2dQDK/0IpnALwOm8sjtTkrbGQlxbm0t9
 OWnEzxaP0SwQL9gyAikFIZtsQqmX6q+q6fSN7CqKj/OSvmDY6xcIJMEwwjWDMsLh+fSh
 7Yug==
X-Gm-Message-State: AOJu0Yz3rsHiJuTgVxvSvuQzO5f4OVvtqJL2MQBovFJ+U9QPXV9WFj7a
 IS1LLXrbREKZcir8uknlc/UNkVoRIJ8e11zYo0g3RB3V3/qBL6wgQVBZ1EMrBSTdn3xi4zhuH0v
 T
X-Google-Smtp-Source: AGHT+IFSW18A13ce5y8kMmwiWxT252fSEWj6zChLm1NGHFiOLmBxKqXWBI2Ou9wjNg/7YPWFS4LTTQ==
X-Received: by 2002:a17:907:3f9d:b0:a7a:97ca:3059 with SMTP id
 a640c23a62f3a-a7dc4fbeb22mr1168855566b.34.1722948814075; 
 Tue, 06 Aug 2024 05:53:34 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d43920sm542964866b.102.2024.08.06.05.53.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:53:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/28] hw/sd/sdcard: Explicit dummy byte value
Date: Tue,  6 Aug 2024 14:51:43 +0200
Message-ID: <20240806125157.91185-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On error the DAT lines are left unmodified to their
previous states. QEMU returns 0x00 for convenience.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240730092138.32443-2-philmd@linaro.org>
---
 hw/sd/sd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 07cb97d88c..de27e34fc8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2478,20 +2478,22 @@ void sd_write_byte(SDState *sd, uint8_t value)
 uint8_t sd_read_byte(SDState *sd)
 {
     /* TODO: Append CRCs */
+    const uint8_t dummy_byte = 0x00;
     uint8_t ret;
     uint32_t io_len;
 
     if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
-        return 0x00;
+        return dummy_byte;
 
     if (sd->state != sd_sendingdata_state) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: not in Sending-Data state\n", __func__);
-        return 0x00;
+        return dummy_byte;
     }
 
-    if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
-        return 0x00;
+    if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION)) {
+        return dummy_byte;
+    }
 
     io_len = sd_blk_len(sd);
 
@@ -2517,7 +2519,7 @@ uint8_t sd_read_byte(SDState *sd)
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
                                   sd->data_start, io_len)) {
-                return 0x00;
+                return dummy_byte;
             }
             sd_blk_read(sd, sd->data_start, io_len);
         }
-- 
2.45.2


