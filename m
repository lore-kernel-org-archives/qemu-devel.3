Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3C4C3600B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 16:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txTUT-0003uJ-OK; Wed, 26 Mar 2025 12:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1txTUR-0003ru-6o
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 12:20:27 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1txTUP-0003qJ-2d
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 12:20:26 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so12637601a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743006022; x=1743610822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I3JFUKCCRkTnpbwiMFKH97iS5KTKZQkgxVnBd4MkOAc=;
 b=UPWznZy0pXVGysvMD4b9ev843s4oVzAGwUGhNthxR+LwhwjwoyJqN77GDAcFnP7j9A
 1orXniaA8LgKPt56d9e+8Z3ynAiJHEPS2H6ffD4kOlpAmaHqjJEf7Je/XfgAB2t5T+sS
 lBV9AzuUcyOcBBE17wwqpuHUxlWsStC5TYAR1PK2mo2Vg/DFuu/s8H8aIqVVMvF4Z2lG
 3z8R/gx9jZEh5iDQ0+KAwYxKMkVxplu22T251lRpmcbI8jgor20UpgDI1Qxfy5o7f3bd
 chVR5W6AFjxVe+bGHuJtuZreqi30BNskzHuzQAxRPLB80o2FAzWNkMoGUMl6DZcRwBzi
 H4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743006022; x=1743610822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I3JFUKCCRkTnpbwiMFKH97iS5KTKZQkgxVnBd4MkOAc=;
 b=dYKsk6c3fCmrLcoi/5V7CVJXRLdvSjGPiE9o64nbfyXpGdBzLJulhe2R6nA7f5CY9K
 b+myj7E4yMUFbn+B21fdwL/s7we4YFfIBgqoWPLDCkvsMQqtuypouJqhoNLRdX4SB/Xa
 cFXjvWqA2LTECl1N7U8Py5IyLIoGfnqQllmd8ASIsKPsSofxgZq9EG14waT/ni68PHeN
 h5aygkLoKYBDvSKTsMwqbLUwGPi7H9OL5Y8m11B0tNcmz7NiIbYJ73f+m+WchelrHfg5
 /uNg3Q1bgYatQD+xo5Ki0FhOJigGKbOfhaEpWxVyLYAGt4jb/81qC2eZBCY9kApH+OEr
 VHqQ==
X-Gm-Message-State: AOJu0Yzy9un+azjoDvNbfGizmoom7YQrNrDYUpfQzCXEmVXlhcUcVKwc
 DpcWfZj4tqR8VsolzGt73oqZDf0GKH0wJREWN2MfXCL0DKcODMZ1yvpUrIWn
X-Gm-Gg: ASbGnctmfBvQz0pgbQDbySa3VUJnqyTwgEwFFPXXSrHIBEEDcUJueWVR268day0CdOn
 kxVeIc6EXLTCJGlyIYKpi3kkE99g2Rfh2bBws959ux/UWT8AXqr1S91ZV0Jjfv/uVUwS/47J+ja
 rGMTs/Y4VX9GIjGmcvpI0XMfvlrPs8evg0ahS8knEivf0v1MaXltiYGO5/zoNcmOos0hyK4a4aU
 BpCaStcfykiBoAjy5SQSZL1AdSLez/wx1h7sIE73RE85e4O6F3f0AJj4kgb7ClJx1rnI8CEiGau
 DJtjZ8wQ/9FRFOwjxU+dVouas8Tfh+sk7hgvXRKNUZ63AJMn44ZRIA==
X-Google-Smtp-Source: AGHT+IFHXq5f7XlA6VNKaCSpqMNRDnMXcGtZsq2tro0p7CcRAanHoB9vJj4sOuEEpcSnVTLNU115NQ==
X-Received: by 2002:a17:906:4fd5:b0:ac3:e4ea:de3b with SMTP id
 a640c23a62f3a-ac6faf3479emr875466b.27.1743006021599; 
 Wed, 26 Mar 2025 09:20:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:14f:49b:dfe6::4cbf:5fb6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efbde4bfsm1049411966b.143.2025.03.26.09.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 09:20:21 -0700 (PDT)
From: donno2048 <just4now666666@gmail.com>
To: 
Cc: qemu-devel@nongnu.org,
	donno2048 <just4now666666@gmail.com>
Subject: [PATCH 1/1] util/memfd: allow allocating 0 bytes
Date: Wed, 26 Mar 2025 16:19:27 +0000
Message-Id: <20250326161927.15572-1-just4now666666@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=just4now666666@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This silently fixes issues resulting from trying to allocate 0 bytes.

Fixes error, for example, for writing byte 0x20 to port 0x3c0, then word 0xf09 to port 0x3b4 when CPU is initiated, which shouldn't break.

Signed-off-by: donno2048 <just4now666666@gmail.com>
---
 util/memfd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/util/memfd.c b/util/memfd.c
index 07beab174d..4f2c4ea1dd 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -131,9 +131,13 @@ void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
         }
     }
 
-    ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
-    if (ptr == MAP_FAILED) {
-        goto err;
+    if (size != 0) {
+        ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
+        if (ptr == MAP_FAILED) {
+            goto err;
+        }
+    } else {
+        ptr = fdopen(mfd, "rw");
     }
 
     *fd = mfd;
-- 
2.30.2


