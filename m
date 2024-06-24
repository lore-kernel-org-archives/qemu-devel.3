Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6033EC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjXZ-0002JG-RQ; Mon, 24 Jun 2024 09:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXW-0002GK-0d
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:22 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXU-0005EN-BP
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:21 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so49021551fa.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234917; x=1719839717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGq9CknDLxCzVytX4zHmuSLklJOyE1bcs9yCSxS9ogk=;
 b=CmaqscENhnn2kYiljC6eAO0ISCj2LFcmNolkxTeqx0/qXdk3qTjpKbOdw3GlHvu/2p
 3vrCvOO4uVsx/lrsSqDWUWkw8P81BbvtDEy5b0GiZ0pK7BWd5R0N5mkCPgFkMTJMvXzo
 pi2OYWlkgvIJtf5GOwmtEfEhPSJeqHawfwvdgTY08Jvb2fYKvRi5tweV7eXnSJL3VvDG
 kZd+WXvj0r80o2Uc4PhALcv8YIZaG2fRFehPm58lni/2m/2KEQ4LuvsIMuRRwRnCLmU/
 js2RJ04vOKVT3hLCISRw11ERJbWo0/oQRDrJanjTXuYmAzWRiRUmOyHVqK5IxKeiSfGy
 BMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234917; x=1719839717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGq9CknDLxCzVytX4zHmuSLklJOyE1bcs9yCSxS9ogk=;
 b=uxEgZ/L3HO63I41dgdktPO5yp+O4JBjxTHEknLoAmGyDvy80Lpnvfk/l8mbjbPvNHh
 AI3NZtMxfnn5G12XPukmFK3kWFxyaxeNEzEjFnLyCqrGsmp98lYVOXiJQf0aEPhpNg4L
 JlOsp4RVxuNqfowtgKosWs1c7Ifi16OBJ+0B4gUeLlEYl1tmWJxrVrfwpnSbtEuhod+h
 S/x1gK6WaM6xJhMh8ma2oQODz/4HD6V793ahOeShF6JEloezRI72uyiDEHH5fc3wwfxq
 J36oBWRiudLUuQMbDYz+y3RagSAD0BOZ59kvBj47iVB3iqsGFVF9VhDOj/AiK5hiOC09
 hx3Q==
X-Gm-Message-State: AOJu0YykswFW4LDnF96ZDyHG3/D49V4BiEKupfNq2ETuPm7jz6fcpXng
 o1+3i+xhvCRQieOgcjgveU6nHHe0Cy6IyCbOJLU0o9umBK4FFloRUlasUdzBk4z2/eFHE0tOreS
 c
X-Google-Smtp-Source: AGHT+IFpO2Ceup9ETQ0B85S4/kGSfjjAfkuNe62Hz037/LUOxezgwyoCtlNfXvN7cVDkYKXzOjjr7A==
X-Received: by 2002:a2e:9e0d:0:b0:2ec:49c2:a79f with SMTP id
 38308e7fff4ca-2ec5b388519mr25367741fa.42.1719234916739; 
 Mon, 24 Jun 2024 06:15:16 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0bea05sm173281545e9.18.2024.06.24.06.15.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:15:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/19] hw/sd/sdcard: Use HWBLOCK_SHIFT definition instead of
 magic values
Date: Mon, 24 Jun 2024 15:14:27 +0200
Message-ID: <20240624131440.81111-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-5-philmd@linaro.org>
---
 hw/sd/sd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 72d71259d3..a14c5ff147 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -596,7 +596,7 @@ static void sd_reset(DeviceState *dev)
     } else {
         sect = 0;
     }
-    size = sect << 9;
+    size = sect << HWBLOCK_SHIFT;
 
     sect = sd_addr_to_wpnum(size) + 1;
 
@@ -822,8 +822,8 @@ static void sd_erase(SDState *sd)
 
     if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
         /* High capacity memory card: erase units are 512 byte blocks */
-        erase_start *= 512;
-        erase_end *= 512;
+        erase_start <<= HWBLOCK_SHIFT;
+        erase_end <<= HWBLOCK_SHIFT;
         sdsc = false;
     }
 
-- 
2.41.0


