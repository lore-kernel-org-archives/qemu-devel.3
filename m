Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40CFC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmYfC-0005Lk-Gr; Wed, 22 Jul 2026 11:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wmYfB-0005LE-Ea
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 11:15:13 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wmYf8-0001so-FL
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 11:15:13 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-92e67555e24so673797485a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784733309; x=1785338109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jdkr+HyHH8zMt+/SQDk1rGwrLJfQWA9uGwAoT38+wWo=;
 b=PxrrypMc6dqVIOWQPfHHR7+pqNuqg0wtZSFF//ONDEpmNeebIu+zEvcv8Ze+RDJw00
 5zaDbqqM0qfJerIuwSW7Wz5cHjVLmol+3IlK/+g/vwLM4QSv3LVrOQGHvvZp30qWtRon
 dj+Fp+1X6PWp7YH3mhjxnfRtEWNP0t56+JfQBQR2wWsSL8TVNdGwqBfFvbTtwBvHiCpx
 dG7kHA6gPu2TJ1QY1WhsslPjNYAXE6JIZymARncbpMAdbPI/LV3XCh9AlQw8Q9uU1d58
 kVRSg0VsHN0+n84N7FqEDCTLGKSn89hMeCtQjsGeuxzlMm6yZ8FwvliBj+rRmP393vHY
 OiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784733309; x=1785338109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jdkr+HyHH8zMt+/SQDk1rGwrLJfQWA9uGwAoT38+wWo=;
 b=C37OLLTbNNBYuNO/ByZOklendyU8yB5f+mfHCy7fdABoc+ZR0HAH7oFpy2W8A6c9kR
 PoL01KB2vgcDlzfxwoDyWo86Xm8WyV0IRa/Z/K3Cd/vCsWfJytCmALkOwQpv1p3baqQk
 5BVIkK5uZNAbyqrj6GnIpgC2I7d/NxdMTMi9vRVZEPtvBVQ/DdzFq/e+0le0NIx3n57W
 IRRvo4BvYq1g+UV3Rrf6Qjm+srylmn8LyJaJOt7wXDW58dur2mncL7o6Q4QDhqs7Uc6E
 H/iWcSgv6dhI0EMd0ApyvqMXEKH+7BJ8bKkNGqaN+OI27rgjrCGHlKVLeKCVgs3QInjh
 b9vg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOVx3naQ3hesQ39QxlOmMSy3cxxWC2CvFBPJYfnqgQg40yMzZJscUdM5tuqtbYpOiMAindNtOL0WvT@nongnu.org
X-Gm-Message-State: AOJu0YzkDk0ssIYIiF9Cw5vraO1XNojWe3/g/bEzbxcAAVqDUsWN0dUs
 GRjhJ1CvW8LhatbzLjzCvJtTIo/KLVHEg8c99NzLui2MMBG7kWgiYdtY
X-Gm-Gg: AR+sD133VdgWJ+l+CWObmDgz08ens1WEgGNSTxSlxJ2JHKEyFvDa6ZmembVb7Jya22L
 ccEtem4bYFGcJgP8YL/hXUTveSoQXkR0890QHvIP/0IEdibjR0Z4LerNVw+VCMvYHZoymaNRdZG
 KoSQvcw9jZbEksHownDvXFB1zedSGirB9AWKF9fXba5l2y/cPWOt6M/XKgPDfLzWPSJyj2E6GgR
 rZICd8xVOSHUceaPBu1LgHq+sNou9EUif4FTGQ8NYBTQzVLAOdar/b/ZDzD0bMcvROmCC/nNYWC
 wsn/DHjyr+N81hOLxrd8Oghd9s1NwM8IH/mnlfsI1tUEl4rRXClpBm5oXUmc9HbTYhSyLBMd52x
 p064cx/Y4ZzZlyWTJshWyRuEmWSuknjj/eAL0nRXnqhXs1QlcMfdVYf8//NXnbUCUuHu+UXxoFE
 Q=
X-Received: by 2002:a05:620a:3948:b0:915:d10e:8c4f with SMTP id
 af79cd13be357-930b430c087mr2515973685a.53.1784733308686; 
 Wed, 22 Jul 2026 08:15:08 -0700 (PDT)
Received: from toolbx ([146.70.165.44]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930f687465csm189641185a.10.2026.07.22.08.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:15:08 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alistair@alistair23.me, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] hw/block/m25p80: Perform a size check before erase
Date: Wed, 22 Jul 2026 11:15:03 -0400
Message-ID: <20260722151503.491139-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x729.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It seems like the erase operation can write off the end of the storage,
so let's add a size guard to make sure we don't do that.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4049
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/block/m25p80.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 545e0b5728..54eb12ebbe 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -648,6 +648,13 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
         qemu_log_mask(LOG_GUEST_ERROR, "M25P80: erase with write protect!\n");
         return;
     }
+
+    if (offset + len >= s->size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "M25P80: erase operation overflowing storage size!\n");
+        return;
+    }
+
     memset(s->storage + offset, 0xff, len);
     flash_sync_area(s, offset, len);
 }
-- 
2.55.0


