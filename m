Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46BDC282C5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhIf-0007ai-CF; Thu, 27 Feb 2025 12:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhGX-0005D2-2n
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:01:44 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhGQ-0002Lr-W8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:01:40 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43aac0390e8so8419695e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740675686; x=1741280486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3K/8zo+OPQ7fiQIh7CxNG3iVbX/8VRGnrPe58kHl2iU=;
 b=uyImSSoyNnxcxSJnKA2iwvKKvbEYpc4gM3bjIXFWP7laxmiU5he5YeLIxL70FuzS1k
 8w44UkOOqNYiD/R8GHWrQrSC3AqG2amU1NBndULtjFmJGzYX3cz412HCo6N/7C9BBV4/
 zJlUUDtuzqlr023XAzdxyBr0mfRU3ngbCasxa2muA0Zf0AIBd1jS74np+cmHnGb76miE
 ud2dMUae+wI9layQOSFro0L/dgu/JI7Hu9FsXqXG6eSj2tK+vkG+NzqzkpTAd2gynQfB
 3y9bKbttB3WLvmpdHOXT5I3RhSPngRzAI3KM++8n5eVwk9AB/L2r2KYgsysW9L6FBam+
 ClOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675686; x=1741280486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3K/8zo+OPQ7fiQIh7CxNG3iVbX/8VRGnrPe58kHl2iU=;
 b=vEAE8EKXo0E4uXbxAINqXEC3MEyaTAKeyW8Icq8qFa8BczajaPQ6Gf4ZabKI2gvcrD
 uGS0wqKG/+ayRwZEvrB5bNu1RS5GyYaZSFirn1vZcnEzcWSWMn9gsG54Y3FlKb1n6G9z
 27oc2pbbddFhzG1CoFLqsrWvU6RXB9AAkfWlJHnNhU2K4+Re59egZDd5keYEwVbKtAPZ
 f1mCEIZMy2k9Lr9lS39WBpoqgNzQ83podSLN8aeDdCGBcDLA6w6pTn1UgKTyDb95KDFS
 TtwPFX3OYIUP+6s9omwJZPGNRaQzcsHuemDi0Yr76oO3WnelMFTBKK9I/nVjV6UNPCRT
 iUHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAR8CdUB4/W23999FBhIZ63uyD/kU89dRDS4yzhmOY6IACRWkS2U9KS7Dc56LZL/PmjNU7Z6mHBLtA@nongnu.org
X-Gm-Message-State: AOJu0Yx6mxrQIAlQcokcKqx6dOZq2JbFoweyOaih8nRSdb6wLDidaTz5
 o5Mrp7KcUmgzKUft5TxaABh3JxFUbZmvMUm7qUiSwPrqO010Q4dJoYIRaKQNbJs=
X-Gm-Gg: ASbGncvjII5CQ7Rnm4YhUMsJercFLdtLmRWWMbt/Nan9Uj91ba3J4MXq5Z0w6IQjVoe
 YcyieHsryiAFK8OkJCyM3JkbjNkjkqI53r6t9RtWJFdMnw7zea35S4BdLtulqaCyH0195Lejvet
 7xPSAnPE1KJ1Uto1VmRC4yHqebV1g8Hx0xSfWFXwChEzemsxYj+TkxQSv7Nod2Mek6/Gj5NSkJG
 7JyxE9G6rs+kXmQ5sdNoN5dTGcDrkm0e8NPKhPHuI+0FjHvqIapXcLJD5r43bwQTGuv+tebjyZ+
 AcBgi1b30WOwzfvZrxY9vW5KYucshbBA
X-Google-Smtp-Source: AGHT+IHOduFRNFpZ6KPiIMSFIC3xcsi+VCmmKAYlQDRyY7NzVI7ocfRXrTnPlOwD+2U+r6MbKM/OLw==
X-Received: by 2002:a05:600c:4686:b0:439:a25b:e7d3 with SMTP id
 5b1f17b1804b1-439ae1f4153mr274745565e9.14.1740675685648; 
 Thu, 27 Feb 2025 09:01:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5871f4sm62747565e9.39.2025.02.27.09.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:01:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/arm/versatilepb: Convert printfs to LOG_GUEST_ERROR
Date: Thu, 27 Feb 2025 17:01:17 +0000
Message-ID: <20250227170117.1726895-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227170117.1726895-1-peter.maydell@linaro.org>
References: <20250227170117.1726895-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Convert some printf() calls for attempts to access nonexistent
registers into LOG_GUEST_ERROR logging.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/versatilepb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 941616cd25b..35766445fa4 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -27,6 +27,7 @@
 #include "qom/object.h"
 #include "audio/audio.h"
 #include "target/arm/cpu-qom.h"
+#include "qemu/log.h"
 
 #define VERSATILE_FLASH_ADDR 0x34000000
 #define VERSATILE_FLASH_SIZE (64 * 1024 * 1024)
@@ -110,7 +111,8 @@ static uint64_t vpb_sic_read(void *opaque, hwaddr offset,
     case 8: /* PICENABLE */
         return s->pic_enable;
     default:
-        printf ("vpb_sic_read: Bad register offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "vpb_sic_read: Bad register offset 0x%x\n", (int)offset);
         return 0;
     }
 }
@@ -144,7 +146,8 @@ static void vpb_sic_write(void *opaque, hwaddr offset,
         vpb_sic_update_pic(s);
         break;
     default:
-        printf ("vpb_sic_write: Bad register offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "vpb_sic_write: Bad register offset 0x%x\n", (int)offset);
         return;
     }
     vpb_sic_update(s);
-- 
2.43.0


