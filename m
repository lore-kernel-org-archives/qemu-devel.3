Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAB7C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 13:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJZJq-0008HO-1Q; Tue, 18 Jun 2024 09:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJZJo-0008G8-Ja
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 09:56:16 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJZJm-000289-Ps
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 09:56:16 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57cb9efd8d1so3658669a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718718973; x=1719323773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4CuWDGrXsYTHvxPtTrt3axmPm5v2kOqes49F3P7NwlU=;
 b=MfyGsODAz1YPq63fuylOdQOQF6odxfEqEXFLyxDZ9JHx0qP3yO1eRP3X4355yRuZDY
 yhpvB07BAXwpVh0H/DOfJ0077wVACeuoOvlYZltog6q6oYrIGnHgiq0+YQtuOzeUINBj
 AeWH4M554DzN/Bpx+T2mdW1F236Jhe6+sfKjyLqrhz3ufdcDIC/lEDLPqS/Wyhq5XPql
 jX1RMke9+NuWMmbQ1SPoNNDL39WmIECmbgya0dxAV/hD3goEVzTghmYQ0F7z1689Tzoi
 0RlqIifjJk4tjC0+JW186xkFd8pi1Ow/Vd8lS1QVE7Q5nZ6YZ2T1UPSrxsoHJeZPecmP
 tGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718718973; x=1719323773;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4CuWDGrXsYTHvxPtTrt3axmPm5v2kOqes49F3P7NwlU=;
 b=uf13/OmrzGZMT3gBMttGO4pqTJcFtkNIX3liqKHTOHPhw45IvGB/J7TB68st3fY/af
 tb7h0vOy1xtZuPyKN8uD9RKDr9RFY1ccuAdybG8bfFtQZ7ikcu9MCy1t8eYMysL4xOpO
 pOxqqoWUWvpGO8520MbjK2AQK7ujy2jSYaLxuRgS6lPOM4KYUSJSnihZyAjSLIgqPfng
 YsblzJnSewj+uqbX1BrE57nlyPP26Ul27rW6mRKpCVZYTt78QF6JL1FUi+pRCg+qQYop
 DucPi3ld3j9NIWHu29cp7Ru4n4z9VFB0LJIYPdWXb/AQ2leuGXiW/Uw8nRMfZa2w5KJm
 EbzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw7kF/CQQoUotwNYHO4wqz+M2M+tdPIEZXZ0Pe+S4c0jxxrTQWjL2DmS1SCKHepTfJO1vbVUaCQnH2XAUx9NAm3+L20lk=
X-Gm-Message-State: AOJu0YzqdJGXTc4wFH8nwjyHEIxNgU9NHk9Hko5PaH/hd7hgiieYJp86
 bru5YsXKCnwUdXcwAy0adVrQ9/OWjHRmrB3eXuXkSr+uzDk1poSepzzuvwbGGw==
X-Google-Smtp-Source: AGHT+IG3pgC3Odl2w7lg8LrbUh0Wy9f0DOa8IZ+yh2dd8ZbxrefrcyxgUgW7nQJ5/lm6yp8/p79UyA==
X-Received: by 2002:a17:906:684b:b0:a6f:8f48:5d29 with SMTP id
 a640c23a62f3a-a6f9506efbcmr165097966b.28.1718718972844; 
 Tue, 18 Jun 2024 06:56:12 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f5f8f6eb3sm567549366b.143.2024.06.18.06.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 06:56:12 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: 
Cc: Zheyu Ma <zheyuma97@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/usb/hcd-dwc2: Handle invalid address access in read and
 write functions
Date: Tue, 18 Jun 2024 15:56:10 +0200
Message-Id: <20240618135610.3109175-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=zheyuma97@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit modifies the dwc2_hsotg_read() and dwc2_hsotg_write() functions
to handle invalid address access gracefully. Instead of using
g_assert_not_reached(), which causes the program to abort, the functions
now log an error message and return a default value for reads or do
nothing for writes.

This change prevents the program from aborting and provides clear log
messages indicating when an invalid memory address is accessed.

Reproducer:
cat << EOF | qemu-system-aarch64 -display none \
-machine accel=qtest, -m 512M -machine raspi2b -m 1G -nodefaults \
-usb -drive file=null-co://,if=none,format=raw,id=disk0 -device \
usb-storage,port=1,drive=disk0 -qtest stdio
readl 0x3f980dfb
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/usb/hcd-dwc2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 8cac9c0a06..b4f0652c7d 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -1128,7 +1128,10 @@ static uint64_t dwc2_hsotg_read(void *ptr, hwaddr addr, unsigned size)
         val = dwc2_pcgreg_read(ptr, addr, (addr - HSOTG_REG(0xe00)) >> 2, size);
         break;
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        val = 0;
+        break;
     }
 
     return val;
@@ -1160,7 +1163,9 @@ static void dwc2_hsotg_write(void *ptr, hwaddr addr, uint64_t val,
         dwc2_pcgreg_write(ptr, addr, (addr - HSOTG_REG(0xe00)) >> 2, val, size);
         break;
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        break;
     }
 }
 
-- 
2.34.1


